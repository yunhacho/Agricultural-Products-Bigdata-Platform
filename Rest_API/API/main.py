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
# from pyspark.sql.types import StructType,StructField, StringType, IntegerType,BooleanType,DoubleType

# spark = SparkSession.builder \
# .appName('Spark_test') \
# .master('local[*]') \
# .config('spark.sql.execution.arrow.pyspark.enabled', True) \
# .config('spark.sql.session.timeZone', 'UTC') \
# .config('spark.driver.memory','32G') \
# .config('spark.ui.showConsoleProgress', True) \
# .config('spark.sql.repl.eagerEval.enabled', True) \
# .getOrCreate()

# conf = pyspark.SparkConf().setAppName("").set("spark.ui.port", "25333")

#      .enableHiveSupport() \
#      .config("spark.some.config.option", "some-value") \

spark = SparkSession.builder      .master("local")      .appName("Spark_test")      .config("spark.some.config.option", "some-value")      .getOrCreate()


# In[3]:


from flask import Flask
from flask_restful import Resource, Api
import import_ipynb
from hello import HelloWorld
from make_table import CreateEveryday, CreateMonth, CreateYear


## 처음 서버 시작할 때 (main.py 돌릴 때) 모든 테이블 일괄 생성

CreateEveryday()    
CreateMonth()     
CreateYear()    


# In[4]:


from apscheduler.schedulers.background import BackgroundScheduler
from flask import Flask
import datetime

sched = BackgroundScheduler(daemon=True)

# 매일 00시 00분에 실행
@sched.scheduled_job('cron', hour='00', minute='00', id='job_1')
def job1():
    CreateEveryday()   #### 하루에 한번씩

# 매월 1일 00시 00분에 실행
@sched.scheduled_job('cron', hour='00', minute='00', id='job_2')
def job2():
    if datetime.datetime.now().day != 1:
        return
    CreateMonth()   #### 달에 한번씩
    
# 1월 1일 00시 00분에 실행
@sched.scheduled_job('cron', hour='00', minute='00', id='job_3')
def job3():
    if (datetime.datetime.now().month != 1) or (datetime.datetime.now().day != 1):
        return
    CreateYear()  #### 년에 한번씩

sched.start()


# In[5]:


from show_price import ShowPriceDaysBefore, ShowPricePeriod, ShowPriceThisDay
from show_graph import ShowOilPriceGraph, ShowYearStatisticGraph, ShowWeatherPriceGraph, ShowPriceInedxPriceGraph
from show_predict_price import ShowPricePredict

app = Flask(__name__)
api = Api(app)

api.add_resource(HelloWorld, '/')

api.add_resource(ShowPriceDaysBefore, '/show_price/days_before')
api.add_resource(ShowPricePeriod, '/show_price/period')
api.add_resource(ShowPriceThisDay, '/show_price/this_day')

api.add_resource(ShowOilPriceGraph, '/show_graph/oil')
api.add_resource(ShowYearStatisticGraph, '/show_graph/year')
api.add_resource(ShowWeatherPriceGraph, '/show_graph/weather')
api.add_resource(ShowPriceInedxPriceGraph, '/show_graph/price_index')

api.add_resource(ShowPricePredict, '/predict')

if __name__ == '__main__':
    app.run()


# In[ ]:




