#!/usr/bin/env python
# coding: utf-8

from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
import xml.etree.ElementTree as ET
from datetime import datetime
import json
import time
import threading
from kafka import KafkaProducer


class RealTimeAuctionService:
    
    def __init__(self, topic, timeinterval=5, numofRows=100):
        self.__servicekey='tTokC%2FSm3k4yWmMacSZ4ONS3jJj4wpSPGxEvj2bM7ywjmIuOsUpHRahXJmWgL%2BNpl1IFH311MA8ASyHP5ZDDhA%3D%3D'
        self.numofRows=numofRows
        self.timeinterval=timeinterval
        self.today=datetime.today().strftime("%Y%m%d")
        self.existcount=0
        self.producer=KafkaProducer(acks=0, compression_type=None, bootstrap_servers=["127.0.0.1:9092"],
                      value_serializer=lambda x: json.dumps(x).encode('utf-8'))
        self.topic=topic
        
    def RltmAucBrknewsService(self):
        url='http://openapi.epis.or.kr/openapi/service/RltmAucBrknewsService/getWltRltmAucBrknewsList'
        queryParams = '?' + urlencode({ quote_plus('ServiceKey') : self.__servicekey,
                                        quote_plus('numOfRows') : self.numofRows,
                                        quote_plus('dates') : self.today })

        request = Request(url + queryParams)
        request.get_method = lambda: 'GET'
        
        return urlopen(request).read().decode('utf-8')  
    
        
    def RltmAucParsing(self, RltmAucTree, numOfRows=None):
        items=[]
        if numOfRows is None: numOfRows=self.numofRows
            
        for item in RltmAucTree.findall("./body/items/")[0:numOfRows]:
            response= { 
                'bidtime':item.find('bidtime').text,
                'coname':item.find('coname').text,
                'gradename':item.find('gradename').text,
                'marketname':item.find('marketname').text,
                'mclassname':item.find('mclassname').text,
                'price':item.find('price').text,
                'sanji':item.find('sanji').text.replace("-", " "),
                'sclassname':item.find('sclassname').text,
                'tradeamt':item.find('tradeamt').text,
                'unitname':item.find('unitname').text.strip()
            }
            items.append(response)
        return items

    
    def RltmAucNewNews(self):
        RltmAucTree=ET.fromstring(self.RltmAucBrknewsService())

        if RltmAucTree.find("./header/resultCode").text=='00':
            totalcount=int(RltmAucTree.find("./body/totalCount").text)
            items=self.RltmAucParsing(RltmAucTree, totalcount-self.existcount)
            
            if(totalcount-self.existcount!=0):
                for item in items:
                    self.producer.send(self.topic, value=item)
                    self.producer.flush()
                    print(json.dumps(item, indent=2, ensure_ascii=False))
                self.existcount=totalcount
        
        threading.Timer(self.timeinterval, self.RltmAucNewNews).start()


if __name__ == "__main__":
    topic='realtimeauction'
    event=RealTimeAuctionService(topic)
    event.RltmAucNewNews()

