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


import import_ipynb
from make_table import CreateEveryday, CreateMonth, CreateYear

CreateEveryday()    #### 하루에 한번씩
CreateMonth()     #### 달에 한번씩
CreateYear()     #### 년에 한번씩


# In[23]:


from pyspark.sql.functions import *
from pyspark.sql.types import IntegerType
import datetime
from datetime import timedelta
import sys
from pyspark.sql.window import Window
import pyspark.sql.functions as func
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import pickle


crops_dict = {'오이':[['취청(50개)','가시계통(1kg)','다다기계통(100개)'],['중품','상품']],
              '양파':[['햇양파(1kg)','양파(1kg)','수입(1kg)'],['중품','상품']],
              '파':[['대파(1kg)','쪽파(1kg)'],['중품','상품']],
              '호박':[['애호박(20개)','쥬키니(1kg)'],['중품','상품']],
              '쌀':[['일반계(1kg)','햇일반계(1kg)'],['중품','상품']]}

area_dict = {'오이':'PyeongtaekWeather', '양파':'HampyeongWeather', '파':'AnseongWeather', '호박':'ChuncheonWeather', '쌀':'JeongeupWeather'}




element_for_predict = {'오이':{'취청(50개)':{'중품':{},'상품':{}}, '가시계통(1kg)':{'중품':{},'상품':{}}, '다다기계통(100개)':{'중품':{},'상품':{}}},
                           '양파':{'햇양파(1kg)':{'중품':{},'상품':{}},'양파(1kg)':{'중품':{},'상품':{}},'수입(1kg)':{'중품':{},'상품':{}}},
                           '파':{'대파(1kg)':{'중품':{},'상품':{}}, '쪽파(1kg)':{'중품':{},'상품':{}}},
                           '호박':{'애호박(20개)':{'중품':{},'상품':{}}, '쥬키니(1kg)':{'중품':{},'상품':{}}},
                           '쌀': {'일반계(1kg)':{'중품':{},'상품':{}}, '햇일반계(1kg)':{'중품':{},'상품':{}}}}


for item in crops_dict.keys():
    for kind in crops_dict[item][0]:
        for rank in crops_dict[item][1]:
            if item=='오이':
                element_for_predict[item][kind][rank]={'priceIndex':['채소및과실','기타운송장비','농업및건설용기계','식료품'],'weather':['dayAvgTa','dayAvgRhm']}
            elif item=='양파':
                element_for_predict[item][kind][rank]={'priceIndex':['채소및과실','전력가스및증기','식료품','비료및농약'],'weather':['dayAvgRhm','dayAvgTa','dayAvgWs']}
            elif item=='파':
                element_for_predict[item][kind][rank]={'priceIndex':['채소및과실','기타운송장비','음식점및숙박서비스','농업및건설용기계'],'weather':['dayAvgRhm']}
            elif item=='호박' and kind=='애호박(20개)':
                element_for_predict[item][kind][rank]={'priceIndex':['채소및과실','기타운송장비','음료품','식료품'],'weather':['dayAvgTa']}
            elif item=='호박' and kind=='쥬키니(1kg)':
                element_for_predict[item][kind][rank]={'priceIndex':['채소및과실','기타운송장비','음료품','식료품'],'weather':[]}
            elif item=='쌀':
                element_for_predict[item][kind][rank]={'priceIndex':['곡물및식량작물','수도폐기물처리및재활용서비스','음식점및숙박서비스','사업지원서비스','장비용품및지식재산권임대'],'weather':[]}




# In[28]:


for item in crops_dict.keys():
    for kind in crops_dict[item][0]:
        for rank in crops_dict[item][1]:
            try:
                if element_for_predict[item][kind][rank]['priceIndex'] != []:
                    priceIndex_select_str = []
                    for i in range(0, len(element_for_predict[item][kind][rank]['priceIndex'])):
                        if i==len(element_for_predict[item][kind][rank]['priceIndex'])-1:
                            priceIndex_select_str.append("priceIndex.`{}`".format(element_for_predict[item][kind][rank]['priceIndex'][i]))
                        else:
                            priceIndex_select_str.append("priceIndex.`{}`,".format(element_for_predict[item][kind][rank]['priceIndex'][i]))
                    priceIndex_select_str = ''.join(priceIndex_select_str)


                    query = "SELECT {3},priceTable.price,priceTable.timestamp                                FROM priceIndex RIGHT JOIN priceTable                                ON priceIndex.`날짜`==priceTable.timestamp                                WHERE priceTable.item_name='{0}' AND priceTable.rank='{2}' AND priceTable.kind_name='{1}' AND priceTable.timestamp NOT IN ('-')                                 ORDER BY priceTable.timestamp ASC"

                    priceIndex_df = spark.sql(query.format(item,kind,rank,priceIndex_select_str))

                    for i in element_for_predict[item][kind][rank]['priceIndex']:
                        priceIndex_df = priceIndex_df.withColumn(i, func.last(i, True).over(Window.partitionBy(func.month('timestamp')).orderBy('timestamp').rowsBetween(-sys.maxsize, 0))).orderBy(priceIndex_df.timestamp.asc())


                if element_for_predict[item][kind][rank]['weather'] != []:
                    weather_select_str = []
                    for i in range(0, len(element_for_predict[item][kind][rank]['weather'])):
                        if i==len(element_for_predict[item][kind][rank]['weather'])-1:
                            weather_select_str.append("{0}.`{1}`".format(area_dict[item],element_for_predict[item][kind][rank]['weather'][i]))
                        else:
                            weather_select_str.append("{0}.`{1}`,".format(area_dict[item],element_for_predict[item][kind][rank]['weather'][i]))
                    weather_select_str = ''.join(weather_select_str)    

                    query = "SELECT {0}, {1}.date AS `timestamp`                     FROM {1} WHERE wrnCount=0                     ORDER BY `timestamp`"

                    weather_df = spark.sql(query.format(weather_select_str, area_dict[item]))

                if element_for_predict[item][kind][rank]['priceIndex']!=[] and element_for_predict[item][kind][rank]['weather']!=[]:
                    regression_df = priceIndex_df.join(weather_df, "timestamp", "inner").orderBy("timestamp")

                elif element_for_predict[item][kind][rank]['weather']==[]:
                    regression_df = priceIndex_df.orderBy("timestamp")
                elif element_for_predict[item][kind][rank]['priceIndex']==[]:
                    regression_df = weather_df.orderBy("timestamp")     

                spark.conf.set("spark.sql.execution.arrow.enabled", "true")

                regression_pdf = regression_df.select("*").toPandas()
                regression_pdf.dropna(subset = ["price"], inplace=True)

                x_element = []
                x_element = list(element_for_predict[item][kind][rank]['priceIndex'])
                x_element.extend(element_for_predict[item][kind][rank]['weather'])

                x = regression_pdf[x_element]
                y = regression_pdf[['price']]
                x_train, x_test, y_train, y_test = train_test_split(x, y, train_size=0.8, test_size=0.2)

                #     predict_dict[item][kind][rank] = True
                model = LinearRegression()
                model.fit(x_train, y_train)

                filename = 'regression_model/{0}_{1}_{2}_model'.format(item,kind,rank)
                pickle.dump(model, open(filename, 'wb'))
                print("======================{} DONE======================".format(filename))
            
            except:
                print('error: {0}_{1}_{2}'.format(item,kind,rank))

        
        

