#!/usr/bin/env python
# coding: utf-8

# In[1]:


import sys
import findspark
findspark.init() #jupyter notebook에서 -> 사용하면 pyspark를 일반 library처럼 사용 가능.
findspark.find()
import pyspark
findspark.find()


# In[2]:


from pyspark import SparkContext, SQLContext
from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()     #기존에 열려있는 session가져오기


# In[3]:


from flask import request, make_response
from flask_restful import Resource, Api
import json
from datetime import datetime
from datetime import timedelta
from bson import json_util     # datetime.date를 막기위함 -> 효과 없음
# import pandas as pd


item_dict = {"0":"오이", "1":"양파", "2":"파", "3":"호박", "4":"쌀"}
kind_dict = {"0":"취청(50개)", "1":"가시계통(1kg)", "2":"다다기계통(100개)", "3":"햇양파(1kg)", "4":"양파(1kg)", "5":"수입(1kg)", "6":"대파(1kg)", "7":"쪽파(1kg)", "8":"애호박(20개)", "9":"쥬키니(1kg)", "10":"일반계(1kg)", "11":"햇일반계(1kg)"}
rank_dict = {"0":"중품", "1":"상품"}

# @ShowPrice.route('/days_before', methods=['GET'])
class ShowPriceDaysBefore(Resource):
    def get(self):
        input_item_name = item_dict[request.args.get('item')] # ex. item=1
        input_date = request.args.get('date') # ex. date=20180320

        # date format 계산 가능한 format으로 바꾸기
        date_format = '%Y%m%d' 
        try:
            date_obj = datetime.strptime(input_date, date_format).date()
        except ValueError:
            print("Incorrect data format, should be YYYYMMDD")

        one_day_ago = date_obj - timedelta(days=1)
        one_week_ago = date_obj - timedelta(days=7)
        two_week_ago = date_obj - timedelta(days=14)
        _30day_ago = date_obj - timedelta(days=30)
        one_year_ago = date_obj.replace(year=date_obj.year-1)

        # price table에서 query 사용하여 찾기
        df = spark.sql("SELECT date_format(timestamp,'yyyy-MM-dd') as timestamp,item_name,kind_name,price,rank,unit FROM priceTable WHERE (timestamp=='{1}' OR timestamp=='{2}' OR timestamp=='{3}' OR timestamp=='{4}' OR timestamp=='{5}') AND item_name=='{0}' AND priceTable.price NOT IN ('-', '0') ORDER BY `timestamp` DESC".format(input_item_name, one_day_ago, one_week_ago, two_week_ago, _30day_ago, one_year_ago))

        map_datas = map(lambda row: row.asDict(), df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        list_datas = list(map_datas) # map을 list로 바꾸기
        dict_datas = {i: str(list_datas[i]) for i in range(len(list_datas))} # list를 dictionary로 바꾸기

        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200)  # dictionary를 json으로 바꾸기 (ensure_ascii=False를 사용하여 아스키에 없는 문자들도 모두 출력 -> 한글출력)
        return result

# @ShowPrice.route('/show_price/period', methods=['GET'])
class ShowPricePeriod(Resource):
    def get(self):
        input_item_name = item_dict[request.args.get('item')]
        input_start_date = request.args.get('date1')
        input_end_date = request.args.get('date2')
        date_list = []

        date_format = '%Y%m%d'
        try:
            date_start_obj = datetime.strptime(input_start_date, date_format).date()
            date_end_obj = datetime.strptime(input_end_date, date_format).date()
        except ValueError:
            print("Incorrect data format, should be YYYYMMDD")


        delta = date_end_obj - date_start_obj       # as timedelta

        for i in range(delta.days + 1):
            day = date_start_obj + timedelta(days=i)
            date_list.append(str(day))

        df = spark.sql("SELECT date_format(timestamp,'yyyy-MM-dd') as timestamp,item_name,kind_name,price,rank,unit FROM priceTable WHERE timestamp in ({1}) AND item_name=='{0}' AND priceTable.price NOT IN ('-', '0') ORDER BY `timestamp` DESC".format(input_item_name, ",".join(list(map(lambda x: "'"+x+"'", date_list)))))

        map_datas = map(lambda row: row.asDict(), df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        list_datas = list(map_datas) # map을 list로 바꾸기
        dict_datas = {i: str(list_datas[i]) for i in range(len(list_datas))} # list를 dictionary로 바꾸기
        
        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200) # dictionary를 json으로 바꾸기 (ensure_ascii=False를 사용하여 아스키에 없는 문자들도 모두 출력 -> 한글출력)
        return result


# @ShowPrice.route('/show_price/this_day', methods=['GET'])
class ShowPriceThisDay(Resource):
    def get(self):
        input_item_name = item_dict[request.args.get('item')]
        input_date = request.args.get('date')

        date_format = '%Y%m%d'
        try:
            date_obj = datetime.strptime(input_date, date_format).date()
        except ValueError:
            print("Incorrect data format, should be YYYYMMDD")

        df = spark.sql("SELECT date_format(timestamp,'yyyy-MM-dd') as timestamp,item_name,kind_name,price,rank,unit FROM priceTable WHERE timestamp=='{1}' AND item_name=='{0}' AND priceTable.price NOT IN ('-', '0')".format(input_item_name, date_obj))

        map_datas = map(lambda row: row.asDict(), df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        list_datas = list(map_datas) # map을 list로 바꾸기
        dict_datas = {i: str(list_datas[i]) for i in range(len(list_datas))} # list를 dictionary로 바꾸기

        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200)  # dictionary를 json으로 바꾸기 (ensure_ascii=False를 사용하여 아스키에 없는 문자들도 모두 출력 -> 한글출력)
        return result

