#!/usr/bin/env python
# coding: utf-8

# In[1]:


import json
import import_ipynb
from price_everydays import UpdatePrice
from oil_everyday import UpdateOilPrice
from weather_everyday import UpdateWeather

import sys
import findspark
findspark.init() #jupyter notebook에서 -> 사용하면 pyspark를 일반 library처럼 사용 가능.
findspark.find()
import pyspark
findspark.find()

from pyspark import SparkContext, SQLContext
from pyspark.sql import SparkSession

spark = SparkSession.builder \
     .master("local") \
     .appName("Spark_test") \
     .config("spark.some.config.option", "some-value") \
     .getOrCreate()

# In[ ]:


from apscheduler.schedulers.background import BackgroundScheduler
import datetime
from pyspark.sql.functions import *

sched = BackgroundScheduler(daemon=True)

# 매일 15시 00분에 실행 -> 당일 가격이 아닌 전날 가격
@sched.scheduled_job('cron', hour='15', minute='00', id='job_1')
def job1():
    content = UpdatePrice()  #### 하루에 한번씩 return json file
    print(content)
    df_list_of_dict = content['contents'][0]['item']
    df_json = spark.createDataFrame(df_list_of_dict)
    df_json = df_json.withColumn("timestamp", lit(content['contents'][0]['timestamp']))
    df_json.write.orc("orc/price/KamisDailyPrice_3", mode='append')
    print("price orc update!!")
    
# 매일 02시 00분에 실행 -> 유가는 매일 당일 날짜로 업데이트 됨
@sched.scheduled_job('cron', hour='02', minute='00', id='job_2')
def job2():
    oil_content = UpdateOilPrice()
    print(oil_content)
    new_list = []
    new_list.append(oil_content)
    df_json = spark.createDataFrame(new_list)
    df_json.write.orc("orc/oil", mode='append')
    print("oil orc update!!")

# 매일 15시 00분에 실행 -> 당일 날씨가 아닌 전날 날씨
@sched.scheduled_job('cron', hour='15', minute='00', id='job_3')
def job3():
    weather_content = UpdateWeather()
    print(weather_content)
    area_list = ['4122000000','4155000000','4211000000','4518000000','4686000000','4725000000','4825000000','4887000000']
    
    for areaId in area_list:
        weather_content_areaId = weather_content[areaId]['item']
        df_weather_json = spark.createDataFrame(weather_content_areaId)
        df_weather_json_new = df_weather_json.withColumn("date", to_date(unix_timestamp(df_weather_json.ymd, 'yyyy-MM-dd HH:mm:ss').cast('timestamp')))
        df_weather_json_new = df_weather_json_new.drop('ymd')
        df_weather_json_new.write.orc("orc/main_area_weather/{}".format(areaId), mode='append')
    
    print("weather orc update!!")
    

sched.start()

