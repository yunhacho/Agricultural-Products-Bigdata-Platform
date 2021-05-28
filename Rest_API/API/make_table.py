#!/usr/bin/env python
# coding: utf-8

# In[1]:


import findspark
findspark.init()
findspark.find()
import pyspark
findspark.find()


# In[2]:


from pyspark import SparkContext, SQLContext
from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()     #기존에 열려있는 session가져오기


# In[1]:


from pyspark.sql.functions import *
from pyspark.sql.types import IntegerType
import datetime
from datetime import timedelta

# table 생성 30초~40초



def CreateEveryday():
    oil_df = spark.read.orc("../orc/oil") # 매일 업데이트 ******

    Pyeongtaek_df = spark.read.orc("../orc/main_area_weather/4122000000") #평택, 오이 (일조량 0)     # 매일 업데이트 *******
    Anseong_df = spark.read.orc("../orc/main_area_weather/4155000000") #안성, 대파     # 매일 업데이트 *******
    Chuncheon_df = spark.read.orc("../orc/main_area_weather/4211000000") #춘천, 호박     # 매일 업데이트 *******
    Jeongeup_df = spark.read.orc("../orc/main_area_weather/4518000000") #정읍, 쌀     # 매일 업데이트 *******
    Hampyeong_df = spark.read.orc("../orc/main_area_weather/4686000000") #함평, 양파     # 매일 업데이트 *******
    Sangju_df = spark.read.orc("../orc/main_area_weather/4725000000") #상주, 오이     # 매일 업데이트 *******
    Gimhae_df = spark.read.orc("../orc/main_area_weather/4825000000") #김해, 대파     # 매일 업데이트 *******
    Hamyang_df = spark.read.orc("../orc/main_area_weather/4887000000") #함양, 양파     # 매일 업데이트 *******

    price_df = spark.read.orc(["../orc/price/KamisDailyPrice_1", "../orc/price/KamisDailyPrice_2", "../orc/price/KamisDailyPrice_3"]) # 매일 업데이트 ********


    # 유가 table
    oil_df.createOrReplaceTempView("oil")
    spark.sql("CACHE TABLE oil") 
    print("table oil done")

    # 날씨 table
    Pyeongtaek_df.createOrReplaceTempView("PyeongtaekWeather")
    spark.sql("CACHE TABLE PyeongtaekWeather")
    print("table PyeongtaekWeather done")
    Anseong_df.createOrReplaceTempView("AnseongWeather")
    spark.sql("CACHE TABLE AnseongWeather") 
    print("table AnseongWeather done")
    Chuncheon_df.createOrReplaceTempView("ChuncheonWeather")
    spark.sql("CACHE TABLE ChuncheonWeather") 
    print("table ChuncheonWeather done")
    Jeongeup_df.createOrReplaceTempView("JeongeupWeather")
    spark.sql("CACHE TABLE JeongeupWeather") 
    print("table JeongeupWeather done")
    Hampyeong_df.createOrReplaceTempView("HampyeongWeather")
    spark.sql("CACHE TABLE HampyeongWeather") 
    print("table HampyeongWeather done")
    Sangju_df.createOrReplaceTempView("SangjuWeather")
    spark.sql("CACHE TABLE SangjuWeather") 
    print("table SangjuWeather done")
    Gimhae_df.createOrReplaceTempView("GimhaeWeather")
    spark.sql("CACHE TABLE GimhaeWeather") 
    print("table GimhaeWeather done")
    Hamyang_df.createOrReplaceTempView("HamyangWeather")
    spark.sql("CACHE TABLE HamyangWeather")
    print("table HamyangWeather done")

    # 가격 table         ## 시간 가장 많이 잡아먹음
    price_df = price_df.withColumn("price", price_df["price"].cast(IntegerType())) # string으로 되어있는 price를 long으로 고침
    price_df.createOrReplaceTempView("priceTable")
    spark.sql("CACHE TABLE priceTable")
    print("table priceTable done")
    print("=============================Create Table Everyday DONE=============================")
    
    
def CreateMonth():
    priceIndex_df = spark.read.orc("../orc/priceIndex")

    # 물가 table
    # priceIndex_df.
    priceIndex_df.createOrReplaceTempView("priceIndex")
    spark.sql("CACHE TABLE priceIndex") # 시작하기 전에 table cache하는 script 따로 만들기 -> 훨씬 빨라짐
    print("table priceIndex done")
    print("=============================Create Table Month DONE=============================")
    
    
def CreateYear():
    riceProduction_df = spark.read.orc("../orc/vege_production/rice")
    onionProduction_df = spark.read.orc("../orc/vege_production/onion")
    cucumberProduction_df = spark.read.orc("../orc/vege_production/cucumber")
    greenOnionProduction_df = spark.read.orc("../orc/vege_production/green_onion")
    pumpkinProduction_df = spark.read.orc("../orc/vege_production/pumpkin")


    # 생산량 table
    riceProduction_df.createOrReplaceTempView("riceProduction")
    spark.sql("CACHE TABLE riceProduction")
    print("table riceProduction done")
    onionProduction_df.createOrReplaceTempView("onionProduction")
    spark.sql("CACHE TABLE onionProduction")
    print("table onionProduction done")
    cucumberProduction_df.createOrReplaceTempView("cucumberProduction")
    spark.sql("CACHE TABLE cucumberProduction") 
    print("table cucumberProduction done")
    greenOnionProduction_df.createOrReplaceTempView("greenOnionProduction")
    spark.sql("CACHE TABLE greenOnionProduction") 
    print("table greenOnionProduction done")
    pumpkinProduction_df.createOrReplaceTempView("pumpkinProduction")
    spark.sql("CACHE TABLE pumpkinProduction") 
    print("table pumpkinProduction done")
    print("=============================Create Table Year DONE=============================")

