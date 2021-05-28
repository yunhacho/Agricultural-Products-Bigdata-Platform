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
from predicts import Predict
from bson import json_util

item_dict = {"0":"오이", "1":"양파", "2":"파", "3":"호박", "4":"쌀"}
kind_dict = {"0":"취청(50개)", "1":"가시계통(1kg)", "2":"다다기계통(100개)", "3":"햇양파(1kg)", "4":"양파(1kg)", "5":"수입(1kg)", "6":"대파(1kg)", "7":"쪽파(1kg)", "8":"애호박(20개)", "9":"쥬키니(1kg)", "10":"일반계(1kg)", "11":"햇일반계(1kg)"}
rank_dict = {"0":"중품", "1":"상품"}


class ShowPricePredict(Resource):
    def get(self):
        input_item = item_dict[request.args.get('item')] # ex. item= 오이
        input_kind = kind_dict[request.args.get('kind')] # ex. kind= 가시계통(1kg)
        input_rank = rank_dict[request.args.get('rank')] # ex. rank= 중품


        predict_price = Predict(input_item, input_kind, input_rank)

        result = make_response(str(predict_price),200)
        return result

