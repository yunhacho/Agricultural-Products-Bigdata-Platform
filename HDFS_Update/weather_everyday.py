#!/usr/bin/env python
# coding: utf-8

# In[2]:


# from urllib.request import Request, urlopen
# from urllib.parse import urlencode, quote_plus
# from datetime import datetime
# import json
# import pandas as pd
# import datetime
# import time
# from datetime import timedelta, date

# today_ = datetime.datetime.now() - datetime.timedelta(days=2)     # 오늘 날짜는 업데이트 안됨 -> 전날 날씨
# today = datetime.date(today_.year, today_.month, today_.day)
# today = str(today).replace("-","")

# weather_dict = {}

# def to_json(fname, items):
#     with open(fname+'.json', 'w', encoding='utf-8') as make_file:
#         json.dump(items, make_file, ensure_ascii=False, indent='\t')
# #     weather_dict[fname] = items

# def getDayStatistics(AREA_ID, PA_CROP_SPE_ID, ST_YMD=today, ED_YMD=today):
#     url = "http://apis.data.go.kr/1360000/FmlandWthrInfoService/getDayStatistics"
#     key ='tTokC/Sm3k4yWmMacSZ4ONS3jJj4wpSPGxEvj2bM7ywjmIuOsUpHRahXJmWgL+Npl1IFH311MA8ASyHP5ZDDhA=='
    
#     queryParams = '?' + urlencode({ quote_plus('ServiceKey') : key, 
#                                    quote_plus('pageNo') : '1', 
#                                    quote_plus('numOfRows') : '30000',
#                                    quote_plus('dataType') : 'json', 
#                                    quote_plus('ST_YMD') : ST_YMD, 
#                                    quote_plus('ED_YMD') : ED_YMD, 
#                                    quote_plus('AREA_ID') : str(AREA_ID), 
#                                    quote_plus('PA_CROP_SPE_ID') : PA_CROP_SPE_ID})

#     request = Request(url + queryParams)
#     request.get_method = lambda: 'GET'

#     response=json.loads(urlopen(request).read())
    
#     if response['response']['header']['resultCode']=='00':
#         to_json(str(AREA_ID), response['response']['body']['items'])
#         return 1, [AREA_ID, PA_CROP_SPE_ID]
#     else:
#         return 0, [AREA_ID, PA_CROP_SPE_ID]

# def getDayStatistics_by_crops():
#     areakey=pd.read_csv('wthrInfoService_areakey.csv')
#     # 유니크한 지역-작물 데이터 프레임
#     uniqueld=areakey.drop_duplicates(['areald','paCropName'], keep='first').drop_duplicates(['areald'])
    
#     normals=[]
#     for row in uniqueld[['areald','paCropSpeld']].iterrows():
#         areald=row[1][0]; paCropSpeld= row[1][1]
#         normal, data= getDayStatistics(areald, paCropSpeld)
#         if normal:
#             normals.append(data)
#     '''
#     지역 하나가 여러 작물 재배하는 리스트 보기 
#     pNamebyAreald=areakey.groupby('areald')['paCropName'].unique()
#     for areald, paCropSpeld in normals:
#         print(pNamebyAreald[pNamebyAreald.index==areald])
#     '''
#     return normals
#     '''
#     # 작물 별 지역 개수
#     areakey.paCropName.value_counts()
#     # 작물과 상관없이 동일 지역은 API 호출 한 번만 한다.
#     len(areakey.areald.unique())
#     # 지역 별 작물 리스트 
#     areakey.groupby('areald')['paCropName'].unique()
#     '''
# # def UpdateWeather():
# if __name__=="__main__":
#     NORMAL_SERVICE=getDayStatistics_by_crops()
# #     print(weather_dict)


# In[7]:


from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
from datetime import datetime
import json
import pandas as pd
import datetime
import time
from datetime import timedelta, date

today_ = datetime.datetime.now() - datetime.timedelta(days=1)     # 오늘 날짜는 업데이트 안됨 -> 전날 날씨
today = datetime.date(today_.year, today_.month, today_.day)
today = str(today).replace("-","")

weather_dict = {}

def to_json(fname, items):
    weather_dict[fname] = items
#     with open(fname+'.json', 'w', encoding='utf-8') as make_file:
#         json.dump(items, make_file, ensure_ascii=False, indent='\t')


def getDayStatistics(AREA_ID, PA_CROP_SPE_ID, ST_YMD=today, ED_YMD=today):
    url = "http://apis.data.go.kr/1360000/FmlandWthrInfoService/getDayStatistics"
    key ='tTokC/Sm3k4yWmMacSZ4ONS3jJj4wpSPGxEvj2bM7ywjmIuOsUpHRahXJmWgL+Npl1IFH311MA8ASyHP5ZDDhA=='
    
    queryParams = '?' + urlencode({ quote_plus('ServiceKey') : key, 
                                   quote_plus('pageNo') : '1', 
                                   quote_plus('numOfRows') : '30000',
                                   quote_plus('dataType') : 'json', 
                                   quote_plus('ST_YMD') : ST_YMD, 
                                   quote_plus('ED_YMD') : ED_YMD, 
                                   quote_plus('AREA_ID') : str(AREA_ID), 
                                   quote_plus('PA_CROP_SPE_ID') : PA_CROP_SPE_ID})

    request = Request(url + queryParams)
    request.get_method = lambda: 'GET'

    response=json.loads(urlopen(request).read())
    
    if response['response']['header']['resultCode']=='00':
        to_json(str(AREA_ID), response['response']['body']['items'])
        return 1, [AREA_ID, PA_CROP_SPE_ID]
    else:
        return 0, [AREA_ID, PA_CROP_SPE_ID]

def getDayStatistics_by_crops():
    areakey=pd.read_csv('wthrInfoService_areakey.csv')
    # 유니크한 지역-작물 데이터 프레임
    uniqueld=areakey.drop_duplicates(['areald','paCropName'], keep='first').drop_duplicates(['areald'])
    
    normals=[]
    for row in uniqueld[['areald','paCropSpeld']].iterrows():
        areald=row[1][0]; paCropSpeld= row[1][1]
        normal, data= getDayStatistics(areald, paCropSpeld)
        if normal:
            normals.append(data)
    '''
    지역 하나가 여러 작물 재배하는 리스트 보기 
    pNamebyAreald=areakey.groupby('areald')['paCropName'].unique()
    for areald, paCropSpeld in normals:
        print(pNamebyAreald[pNamebyAreald.index==areald])
    '''
    return normals
    '''
    # 작물 별 지역 개수
    areakey.paCropName.value_counts()
    # 작물과 상관없이 동일 지역은 API 호출 한 번만 한다.
    len(areakey.areald.unique())
    # 지역 별 작물 리스트 
    areakey.groupby('areald')['paCropName'].unique()
    '''

def UpdateWeather():
    NORMAL_SERVICE=getDayStatistics_by_crops()
    return weather_dict

