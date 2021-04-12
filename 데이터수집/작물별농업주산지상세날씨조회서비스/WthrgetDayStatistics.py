#!/usr/bin/env python
# coding: utf-8

from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
import xml.etree.ElementTree as ET
from datetime import datetime
import json
import pandas as pd
from collections import OrderedDict

def to_json(fname, items):
    jsondic={}
    for i, item in enumerate(items):
        jsondic[i]=item
        
    with open(fname+'.json', 'w', encoding='utf-8') as make_file:
        json.dump(jsondic, make_file, ensure_ascii=False, indent='\t')

def getDayStatistics(AREA_ID, PA_CROP_SPE_ID, ST_YMD='20160411', ED_YMD='20210411'):
    url = "http://apis.data.go.kr/1360000/FmlandWthrInfoService/getDayStatistics"
    key ='tTokC/Sm3k4yWmMacSZ4ONS3jJj4wpSPGxEvj2bM7ywjmIuOsUpHRahXJmWgL+Npl1IFH311MA8ASyHP5ZDDhA=='
    
    queryParams = '?' + urlencode({ quote_plus('ServiceKey') : key, 
                                   quote_plus('pageNo') : '1', 
                                   quote_plus('numOfRows') : '2000',
                                   quote_plus('dataType') : 'json', 
                                   quote_plus('ST_YMD') : ST_YMD, 
                                   quote_plus('ED_YMD') : ED_YMD, 
                                   quote_plus('AREA_ID') : str(AREA_ID), 
                                   quote_plus('PA_CROP_SPE_ID') : PA_CROP_SPE_ID})

    request = Request(url + queryParams)
    request.get_method = lambda: 'GET'

    response=json.loads(urlopen(request).read())
    
    if response['response']['header']['resultCode']=='00':
        to_json(str(AREA_ID), response['response']['body']['items']['item'])
        return 1, [AREA_ID, PA_CROP_SPE_ID]
    else:
        return 0, [AREA_ID, PA_CROP_SPE_ID]

def getDayStatistics_by_crops():
    areakey=pd.read_csv('whtrInfoService_areakey.csv')
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

if __name__=="__main__":
    NORMAL_SERVICE=getDayStatistics_by_crops()




