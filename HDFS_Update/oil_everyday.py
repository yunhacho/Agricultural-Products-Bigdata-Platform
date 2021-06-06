#!/usr/bin/env python
# coding: utf-8

# In[53]:


# 현재 오피넷에 게시되고 있는 시도별 주유소 평균 가격
# B034:고급휘발유, B027:보통휘발유, D047:자동차경유, C004:실내등유, K015:자동차부탄
# https://www.opinet.co.kr/user/custapi/custApiInfo.do
# 보통휘발유로 간다


# 구분,서울,부산,대구,인천,광주,대전,울산,경기,강원,충북,충남,전북,전남,경북,경남,제주,세종,평균

import requests, bs4
from lxml import html
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus, unquote
from bs4 import BeautifulSoup
import json



def UpdateOilPrice():
    oil_dict = {}
    sido_list = ['서울','부산','대구','인천','광주','대전','울산','경기','강원','충북','충남','전북','전남','경북','경남','제주','세종']

    sidoUrl = "http://www.opinet.co.kr/api/avgSidoPrice.do"
    avgUrl = "http://www.opinet.co.kr/api/avgAllPrice.do"
    My_API_Key = unquote('F961210322')


    sido_queryParams = '?' + urlencode(
        {
            quote_plus('code'):My_API_Key,
            quote_plus('out'):'xml',
            quote_plus('prodcd'):'B027'
        }
    )

    sido_response = requests.get(sidoUrl + sido_queryParams).text.encode('utf-8')
    sido_obj = bs4.BeautifulSoup(sido_response, 'lxml-xml')
    sido_data = sido_obj.find_all('OIL')

    # http://www.opinet.co.kr/api/avgAllPrice.do?out=xml&code=F961210322

    queryParams = '?' + urlencode(
        {
            quote_plus('code'):My_API_Key,
            quote_plus('out'):'xml'
        }
    )
    # print(avgUrl+queryParams)
    avg_response = requests.get(avgUrl + queryParams).text.encode('utf-8')
    avg_obj = bs4.BeautifulSoup(avg_response, 'lxml-xml')
    avg_data = avg_obj.find_all('OIL')


    for oil in avg_data:
        if(oil.find('PRODCD').get_text() == 'B027'):
            date = oil.find('TRADE_DT').get_text()
            avg_price = oil.find('PRICE').get_text()


    for i in range(17):
        for oil in sido_data:
            if(sido_list[i] == oil.find('SIDONM').get_text()):
                city = oil.find('SIDONM').get_text()
                price = oil.find('PRICE').get_text()
                oil_dict[city] = price
                break

    oil_dict['평균'] = avg_price # dictionary 만듦
    oil_dict['날짜'] = date[:4]+'-'+date[4:6]+'-'+date[6:]

    return oil_dict


# In[ ]:




