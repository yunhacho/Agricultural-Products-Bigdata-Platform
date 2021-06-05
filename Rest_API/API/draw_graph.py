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


# In[4]:


import sys
from pyspark.sql.window import Window
import pyspark.sql.functions as func
import datetime


# In[5]:


crops_dict = {'오이':[['취청(50개)','가시계통(1kg)','다다기계통(100개)'],['중품','상품']],
              '양파':[['햇양파(1kg)','양파(1kg)','수입(1kg)'],['중품','상품']],
              '파':[['대파(1kg)','쪽파(1kg)'],['중품','상품']],
              '호박':[['애호박(20개)','쥬키니(1kg)'],['중품','상품']],
              '쌀':[['일반계(1kg)','햇일반계(1kg)'],['중품','상품']]}


# In[6]:


oil_avgPrice_graph_dict = {'오이':{'취청(50개)':{'중품':[],'상품':[]}, '가시계통(1kg)':{'중품':[],'상품':[]}, '다다기계통(100개)':{'중품':[],'상품':[]}},
                           '양파':{'햇양파(1kg)':{'중품':[],'상품':[]},'양파(1kg)':{'중품':[],'상품':[]},'수입(1kg)':{'중품':[],'상품':[]}},
                           '파':{'대파(1kg)':{'중품':[],'상품':[]}, '쪽파(1kg)':{'중품':[],'상품':[]}},
                           '호박':{'애호박(20개)':{'중품':[],'상품':[]}, '쥬키니(1kg)':{'중품':[],'상품':[]}},
                           '쌀': {'일반계(1kg)':{'중품':[],'상품':[]}, '햇일반계(1kg)':{'중품':[],'상품':[]}}}

### 그래프 미리 만들어 놓기
####################### 유가별 price 변동 그래프 (x, y) 좌표 x:유가 , y:price #######################

def oil_avgPrice(item, kind, rank):
    if oil_avgPrice_graph_dict[item][kind][rank]==[]:
        query = "SELECT A.`평균` AS oil_price,AVG(A.`price`) AS avg_price             FROM (            SELECT oil.`평균`,oil.`날짜`,priceTable.price             FROM oil JOIN priceTable ON oil.`날짜`=priceTable.timestamp             WHERE priceTable.item_name='{0}' AND priceTable.rank='{2}' AND priceTable.kind_name='{1}' AND priceTable.price NOT IN ('-', '0')             ORDER BY oil.`날짜` ASC            ) A             GROUP BY A.`평균`             ORDER BY A.`평균` ASC"
            
        oil_avgPrice_df = spark.sql(query.format(item, kind, rank))

        map_datas = map(lambda row: row.asDict(), oil_avgPrice_df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        graph_datas = list(map_datas) # map을 list로 바꾸기

        oil_avgPrice_graph_dict[item][kind][rank] = graph_datas
        
    return oil_avgPrice_graph_dict[item][kind][rank]
                                


# In[7]:


year_production_area_price_graph_dict = {'오이':{'취청(50개)':{'중품':[],'상품':[]}, '가시계통(1kg)':{'중품':[],'상품':[]}, '다다기계통(100개)':{'중품':[],'상품':[]}},
                           '양파':{'햇양파(1kg)':{'중품':[],'상품':[]},'양파(1kg)':{'중품':[],'상품':[]},'수입(1kg)':{'중품':[],'상품':[]}},
                           '파':{'대파(1kg)':{'중품':[],'상품':[]}, '쪽파(1kg)':{'중품':[],'상품':[]}},
                           '호박':{'애호박(20개)':{'중품':[],'상품':[]}, '쥬키니(1kg)':{'중품':[],'상품':[]}},
                           '쌀': {'일반계(1kg)':{'중품':[],'상품':[]}, '햇일반계(1kg)':{'중품':[],'상품':[]}}}

production_dict = {'오이':'cucumberProduction', '양파':'onionProduction', '파':'greenOnionProduction', '호박':'pumpkinProduction', '쌀':'riceProduction'}

### 그래프 미리 만들어 놓기
####################### 연도에따른 생산량, 면적, price평균 #######################

def production_area_price(item, kind, rank):
    if year_production_area_price_graph_dict[item][kind][rank]==[]:
        query = "SELECT {3}.`면적` AS area,{3}.`생산량` AS output,A.`avg(price)` AS avg_price,A.`연도` AS year             FROM (            SELECT AVG(price), YEAR(timestamp) AS `연도`             FROM priceTable WHERE item_name='{0}' AND rank='{2}' AND kind_name='{1}' AND price NOT IN ('-') AND timestamp NOT IN ('-')             GROUP BY YEAR(timestamp)             ) A JOIN {3} ON A.`연도`={3}.`연도`             ORDER BY A.`연도` ASC"

        production_area_df = spark.sql(query.format(item, kind, rank, production_dict[item]))

        map_datas = map(lambda row: row.asDict(), production_area_df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        graph_datas = list(map_datas) # map을 list로 바꾸기

        year_production_area_price_graph_dict[item][kind][rank] = graph_datas
        
    return year_production_area_price_graph_dict[item][kind][rank]


# In[8]:


weather_element_list = ['dayAvgTa', 'dayAvgRhm', 'daySumRn', 'dayAvgWs', 'daySumSs']
## 기온, 습도, 강수량, 풍량, 일조량

weather_avgPrice_graph_dict = {'오이':{'취청(50개)':{'중품':{},'상품':{}}, '가시계통(1kg)':{'중품':{},'상품':{}}, '다다기계통(100개)':{'중품':{},'상품':{}}},
                           '양파':{'햇양파(1kg)':{'중품':{},'상품':{}},'양파(1kg)':{'중품':{},'상품':{}},'수입(1kg)':{'중품':{},'상품':{}}},
                           '파':{'대파(1kg)':{'중품':{},'상품':{}}, '쪽파(1kg)':{'중품':{},'상품':{}}},
                           '호박':{'애호박(20개)':{'중품':{},'상품':{}}, '쥬키니(1kg)':{'중품':{},'상품':{}}},
                           '쌀': {'일반계(1kg)':{'중품':{},'상품':{}}, '햇일반계(1kg)':{'중품':{},'상품':{}}}}

for item in crops_dict.keys():
    for kind in crops_dict[item][0]:
        for rank in crops_dict[item][1]:
            weather_avgPrice_graph_dict[item][kind][rank]={i:[] for i in weather_element_list}

area_dict = {'오이':'PyeongtaekWeather', '양파':'HampyeongWeather', '파':'AnseongWeather', '호박':'ChuncheonWeather', '쌀':'JeongeupWeather'}


####################### 평균 기온 및 습도 등에 따른 price 변동 그래프 (x, y) #######################
def weather_avgPrice(item, kind, rank, element):
    if weather_avgPrice_graph_dict[item][kind][rank][element]==[]:
        query = "SELECT A.`{3}` AS element,AVG(A.`price`) AS avg_price         FROM (        SELECT {4}.{3},priceTable.price,priceTable.timestamp         FROM {4} JOIN priceTable         ON {4}.date==priceTable.timestamp         WHERE priceTable.item_name='{0}' AND priceTable.rank='{2}' AND priceTable.kind_name='{1}' AND priceTable.price NOT IN ('-')         ) A         GROUP BY A.`{3}`         ORDER BY A.`{3}` ASC"

        weather_df = spark.sql(query.format(item, kind, rank, element, area_dict[item]))

        map_datas = map(lambda row: row.asDict(), weather_df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        graph_datas = list(map_datas) # map을 list로 바꾸기
        
        weather_avgPrice_graph_dict[item][kind][rank][element] = graph_datas
        
    return weather_avgPrice_graph_dict[item][kind][rank][element]


# In[9]:


priceIndex_element_list = ['곡물및식량작물', '채소및과실', '식료품', '음료품', '비료및농약', '농업및건설용기계', '기타운송장비', '전력가스및증기', '수도폐기물처리및재활용서비스', '음식점및숙박서비스', '장비용품및지식재산권임대']


priceIndex_avgPrice_graph_dict = {'오이':{'취청(50개)':{'중품':{},'상품':{}}, '가시계통(1kg)':{'중품':{},'상품':{}}, '다다기계통(100개)':{'중품':{},'상품':{}}},
                           '양파':{'햇양파(1kg)':{'중품':{},'상품':{}},'양파(1kg)':{'중품':{},'상품':{}},'수입(1kg)':{'중품':{},'상품':{}}},
                           '파':{'대파(1kg)':{'중품':{},'상품':{}}, '쪽파(1kg)':{'중품':{},'상품':{}}},
                           '호박':{'애호박(20개)':{'중품':{},'상품':{}}, '쥬키니(1kg)':{'중품':{},'상품':{}}},
                           '쌀': {'일반계(1kg)':{'중품':{},'상품':{}}, '햇일반계(1kg)':{'중품':{},'상품':{}}}}


for item in crops_dict.keys():
    for kind in crops_dict[item][0]:
        for rank in crops_dict[item][1]:
            priceIndex_avgPrice_graph_dict[item][kind][rank]={i:[] for i in priceIndex_element_list}
            

### 그래프 미리 만들어 놓기
####################### 곡물및식량물가에 따른 price 변동 그래프 (x, y) 좌표 x:물가 , y:price #######################
def priceIndex_avgPrice(item, kind, rank, element):
    if priceIndex_avgPrice_graph_dict[item][kind][rank][element]==[]:
        query = "SELECT priceIndex.`{3}`,priceTable.price,priceTable.timestamp                    FROM priceIndex RIGHT JOIN priceTable                    ON priceIndex.`날짜`==priceTable.timestamp                    WHERE priceTable.item_name='{0}' AND priceTable.rank='{2}' AND priceTable.kind_name='{1}' AND priceTable.timestamp NOT IN ('-')"

        priceIndex_df = spark.sql(query.format(item,kind,rank,element))
        priceIndex_df = priceIndex_df.withColumn(element, func.last(element, True).over(Window.partitionBy(func.month('timestamp')).orderBy('timestamp').rowsBetween(-sys.maxsize, 0))).orderBy(priceIndex_df.timestamp.asc()).na.drop(subset=["price"])


        priceIndex_df = priceIndex_df.groupBy(element).agg(func.avg('price')).sort(func.asc(element)).na.drop(subset=[element])
        priceIndex_df = priceIndex_df.withColumnRenamed(element,"price_index")
        priceIndex_df = priceIndex_df.withColumnRenamed('avg(price)',"avg_price")

        map_datas = map(lambda row: row.asDict(), priceIndex_df.collect()) # dataframe을 map으로 바꾸기 (df.colloect()로 dataframe을 list화 한다)
        graph_datas = list(map_datas) # map을 list로 바꾸기
        
        priceIndex_avgPrice_graph_dict[item][kind][rank][element] = graph_datas

    return priceIndex_avgPrice_graph_dict[item][kind][rank][element]


# ## test ##
# def clean_avgPrice(item, kind, rank, element):
#     if priceIndex_avgPrice_graph_dict[item][kind][rank][element]!=[]:
#         priceIndex_avgPrice_graph_dict[item][kind][rank][element] = []
#     if weather_avgPrice_graph_dict[item][kind][rank][element]!=[]:
#         weather_avgPrice_graph_dict[item][kind][rank][element] = []
#     else:
#         print("empty!")


# In[10]:


import datetime
import time
from apscheduler.schedulers.background import BackgroundScheduler
from flask import Flask

sched = BackgroundScheduler(daemon=True)

# 1월 1일 00시 00분에 실행
@sched.scheduled_job('cron', hour='00', minute='00', id='job_4')
def job4():
    if (datetime.datetime.now().month != 1) or (datetime.datetime.now().day != 1):
        return
    
    ##### 유가와 평균가격 그래프 초기화
    oil_avgPrice_graph_dict = {'오이':{'취청(50개)':{'중품':[],'상품':[]}, '가시계통(1kg)':{'중품':[],'상품':[]}, '다다기계통(100개)':{'중품':[],'상품':[]}},
                           '양파':{'햇양파(1kg)':{'중품':[],'상품':[]},'양파(1kg)':{'중품':[],'상품':[]},'수입(1kg)':{'중품':[],'상품':[]}},
                           '파':{'대파(1kg)':{'중품':[],'상품':[]}, '쪽파(1kg)':{'중품':[],'상품':[]}},
                           '호박':{'애호박(20개)':{'중품':[],'상품':[]}, '쥬키니(1kg)':{'중품':[],'상품':[]}},
                           '쌀': {'일반계(1kg)':{'중품':[],'상품':[]}, '햇일반계(1kg)':{'중품':[],'상품':[]}}}
    
    
    
    ##### 연간 생산량, 면적 그래프 초기화 
    year_production_area_price_graph_dict = {'오이':{'취청(50개)':{'중품':[],'상품':[]}, '가시계통(1kg)':{'중품':[],'상품':[]}, '다다기계통(100개)':{'중품':[],'상품':[]}},
                           '양파':{'햇양파(1kg)':{'중품':[],'상품':[]},'양파(1kg)':{'중품':[],'상품':[]},'수입(1kg)':{'중품':[],'상품':[]}},
                           '파':{'대파(1kg)':{'중품':[],'상품':[]}, '쪽파(1kg)':{'중품':[],'상품':[]}},
                           '호박':{'애호박(20개)':{'중품':[],'상품':[]}, '쥬키니(1kg)':{'중품':[],'상품':[]}},
                           '쌀': {'일반계(1kg)':{'중품':[],'상품':[]}, '햇일반계(1kg)':{'중품':[],'상품':[]}}}
    
    
    ##### 날씨와 평균가격 그래프 초기화
    weather_avgPrice_graph_dict = {'오이':{'취청(50개)':{'중품':{},'상품':{}}, '가시계통(1kg)':{'중품':{},'상품':{}}, '다다기계통(100개)':{'중품':{},'상품':{}}},
                           '양파':{'햇양파(1kg)':{'중품':{},'상품':{}},'양파(1kg)':{'중품':{},'상품':{}},'수입(1kg)':{'중품':{},'상품':{}}},
                           '파':{'대파(1kg)':{'중품':{},'상품':{}}, '쪽파(1kg)':{'중품':{},'상품':{}}},
                           '호박':{'애호박(20개)':{'중품':{},'상품':{}}, '쥬키니(1kg)':{'중품':{},'상품':{}}},
                           '쌀': {'일반계(1kg)':{'중품':{},'상품':{}}, '햇일반계(1kg)':{'중품':{},'상품':{}}}}

    
    for item in crops_dict.keys():
        for kind in crops_dict[item][0]:
            for rank in crops_dict[item][1]:
                weather_avgPrice_graph_dict[item][kind][rank]={i:[] for i in weather_element_list}
                
                
    ##### 물가와 평균가격 그래프 초기화     
    priceIndex_avgPrice_graph_dict = {'오이':{'취청(50개)':{'중품':{},'상품':{}}, '가시계통(1kg)':{'중품':{},'상품':{}}, '다다기계통(100개)':{'중품':{},'상품':{}}},
                           '양파':{'햇양파(1kg)':{'중품':{},'상품':{}},'양파(1kg)':{'중품':{},'상품':{}},'수입(1kg)':{'중품':{},'상품':{}}},
                           '파':{'대파(1kg)':{'중품':{},'상품':{}}, '쪽파(1kg)':{'중품':{},'상품':{}}},
                           '호박':{'애호박(20개)':{'중품':{},'상품':{}}, '쥬키니(1kg)':{'중품':{},'상품':{}}},
                           '쌀': {'일반계(1kg)':{'중품':{},'상품':{}}, '햇일반계(1kg)':{'중품':{},'상품':{}}}}


    for item in crops_dict.keys():
        for kind in crops_dict[item][0]:
            for rank in crops_dict[item][1]:
                priceIndex_avgPrice_graph_dict[item][kind][rank]={i:[] for i in priceIndex_element_list}


sched.start()


# In[11]:







########################### 1년에 한번씩 갱신 ###################################




