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
import import_ipynb
from draw_graph import oil_avgPrice, production_area_price, weather_avgPrice, priceIndex_avgPrice
import datetime
from datetime import timedelta


item_dict = {"0":"오이", "1":"양파", "2":"파", "3":"호박", "4":"쌀"}
kind_dict = {"0":"취청(50개)", "1":"가시계통(1kg)", "2":"다다기계통(100개)", "3":"햇양파(1kg)", "4":"양파(1kg)", "5":"수입(1kg)", "6":"대파(1kg)", "7":"쪽파(1kg)", "8":"애호박(20개)", "9":"쥬키니(1kg)", "10":"일반계(1kg)", "11":"햇일반계(1kg)"}
rank_dict = {"0":"중품", "1":"상품"}
weather_dict = {"0":"dayAvgTa", "1":"dayAvgRhm", "2":"daySumRn", "3":"dayAvgWs", "4":"daySumSs"}
priceIndex_dict = {"0":"곡물및식량작물", "1":"채소및과실", "2":"식료품", "3":"음료품", "4":"비료및농약", "5":"농업및건설용기계", "6":"기타운송장비", "7":"전력가스및증기", "8":"수도폐기물처리및재활용서비스", "9":"음식점및숙박서비스", "10":"장비용품및지식재산권임대"}


# spark.sql("SELECT `날짜` FROM oil ORDER BY `날짜` DESC LIMIT 1").show()   # 유가 마지막 데이터: 2021-04-11


####################### 유가별 price 변동 그래프 (x, y) 좌표 x:유가 , y:price #######################


class ShowOilPriceGraph(Resource):
    def get(self): 
        input_item = item_dict[request.args.get('item')] # ex. item= 오이
        input_kind = kind_dict[request.args.get('kind')] # ex. kind= 가시계통(1kg)
        input_rank = rank_dict[request.args.get('rank')] # ex. rank= 중품
        
        ################ 요근래 3일간의 평균 유가 ####################
        today_ = datetime.datetime.now()     # 오늘 날짜
        today = datetime.date(today_.year, today_.month, today_.day)
        three_days_ago = today - timedelta(days=3)      # 오늘 날짜에서 3일 뺌

        current_oil_price = spark.sql("SELECT AVG(oil.`평균`) FROM oil WHERE oil.`날짜` BETWEEN '{0}' AND '{1}'".format(three_days_ago, today)).select('avg(평균)').collect()[0]['avg(평균)']

        dict_datas = {'current_oil': current_oil_price, 'oil_avgPrice_df':oil_avgPrice(input_item,input_kind,input_rank)}

        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200)
        return result


# In[4]:



####################### 연도에따른 생산량, 면적, price평균 #######################
class ShowYearStatisticGraph(Resource):
    def get(self): 
        input_item = item_dict[request.args.get('item')] # ex. item= 오이
        input_kind = kind_dict[request.args.get('kind')] # ex. kind= 가시계통(1kg)
        input_rank = rank_dict[request.args.get('rank')] # ex. rank= 중품
        
        graph_datas = production_area_price(input_item,input_kind,input_rank)
        dict_datas = {'contents':graph_datas}

        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200)
        return result


# In[5]:



####################### 평균 기온 및 습도 등에 따른 price 변동 그래프 (x, y) #######################

area_dict = {'오이':'PyeongtaekWeather', '양파':'HampyeongWeather', '파':'AnseongWeather', '호박':'ChuncheonWeather', '쌀':'JeongeupWeather'}


class ShowWeatherPriceGraph(Resource):
    def get(self): 
        input_item = item_dict[request.args.get('item')] # ex. item= 오이
        input_kind = kind_dict[request.args.get('kind')] # ex. kind= 가시계통(1kg)
        input_rank = rank_dict[request.args.get('rank')] # ex. rank= 중품
        input_element = weather_dict[request.args.get('element')] # ex. element= dayAvgTa
        
        ############## 가장 최근의 날씨 데이터 ################
        current_weather = spark.sql("SELECT LAST({0}) AS current_value FROM {1}".format(input_element, area_dict[input_item]))

        dict_datas = {'current_weather': current_weather.collect()[0]['current_value'], 'weather_avgPrice_df':weather_avgPrice(input_item,input_kind,input_rank,input_element)}

        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200) # dictionary를 json으로 바꾸기 (ensure_ascii=False를 사용하여 아스키에 없는 문자들도 모두 출력 -> 한글출력)
        return result


# In[6]:



####################### 물가에 따른 price 변동 그래프 (x, y) 좌표 x:물가 , y:price #######################

class ShowPriceInedxPriceGraph(Resource):
    def get(self):
        input_item = item_dict[request.args.get('item')] # ex. item= 오이
        input_kind = kind_dict[request.args.get('kind')] # ex. kind= 가시계통(1kg)
        input_rank = rank_dict[request.args.get('rank')] # ex. rank= 중품
        input_element = priceIndex_dict[request.args.get('element')] #
        
        ############## 가장 최근의 곡물및식량물가 ################

        current_grainFood_price = spark.sql("SELECT LAST(`{0}`) AS current_value FROM priceIndex".format(input_element))  ## element받아야함

        dict_datas = {'current_priceIndex': current_grainFood_price.collect()[0]['current_value'], 'priceIndex_avgPrice_df':priceIndex_avgPrice(input_item,input_kind,input_rank,input_element)} ##element 받아야함

        result = make_response(json.dumps(dict_datas, ensure_ascii=False),200)
        return result

