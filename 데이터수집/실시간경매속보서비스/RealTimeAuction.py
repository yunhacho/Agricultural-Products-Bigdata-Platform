#!/usr/bin/env python
# coding: utf-8

from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
import xml.etree.ElementTree as ET
from datetime import datetime
import json

today=datetime.today().strftime("%Y%m%d")

url = 'http://openapi.epis.or.kr/openapi/service/RltmAucBrknewsService/getPrdlstRltmAucBrknewsList'
servicekey='tTokC%2FSm3k4yWmMacSZ4ONS3jJj4wpSPGxEvj2bM7ywjmIuOsUpHRahXJmWgL%2BNpl1IFH311MA8ASyHP5ZDDhA%3D%3D'

queryParams = '?' + urlencode({ quote_plus('ServiceKey') : servicekey, quote_plus('dates ') : today })

request = Request(url + queryParams)
request.get_method = lambda: 'GET'

response_body = urlopen(request).read()

tree=ET.fromstring(response_body)

items=[]
for item in tree.findall("./body/items/"):
    response= { 
        'bidtime':item.find('bidtime').text,
        'coname':item.find('coname').text,
        'marketname':item.find('marketname').text,
        #'mclassnam':item.find('mclassnam').text,
        'price':item.find('price').text,
        'rnum':item.find('rnum').text,
        'sanji':item.find('sanji').text,
        'sclassname':item.find('sclassname').text,
        'tradeamt':item.find('tradeamt').text,
        'unitname':item.find('unitname').text
    }
    items.append(response)

for item in items:
    print(json.dumps(item, indent=2,ensure_ascii = False))

