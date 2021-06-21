#!/usr/bin/env python3
# coding: utf-8
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
from urllib.error import URLError, HTTPError
import xml.etree.ElementTree as ET
from datetime import datetime
from pytz import timezone
import json
import time
import threading
from kafka import KafkaProducer

class RealTimeAuctionService:
    
    def __init__(self, topic, timeinterval=5, numofRows=100):
        self.__servicekey='tTokC%2FSm3k4yWmMacSZ4ONS3jJj4wpSPGxEvj2bM7ywjmIuOsUpHRahXJmWgL%2BNpl1IFH311MA8ASyHP5ZDDhA%3D%3D'
        self.numofRows=numofRows
        self.timeinterval=timeinterval
        self.today=datetime.now(timezone('Asia/Seoul')).strftime("%Y%m%d")
        self.existcount=0
        self.producer=KafkaProducer(acks=0, compression_type=None, bootstrap_servers=["mykafka-0.mykafka-headless.kafka.svc.cluster.local:9092"], value_serializer=lambda x: json.dumps(x).encode('utf-8'))
        self.topic=topic
        self.timestamp=datetime.strptime(str(datetime.now(timezone('Asia/Seoul')).day)+"일"+" 00:00 00", '%d일 %H:%M %S')
    
    def todatetime(self,strtime):
        return datetime.strptime(strtime,'%d일 %H:%M %S')
    
    def RltmAucBrknewsService(self):
        url='http://openapi.epis.or.kr/openapi/service/RltmAucBrknewsService/getWltRltmAucBrknewsList'
        queryParams = '?' + urlencode({ quote_plus('ServiceKey') : self.__servicekey,
                                        quote_plus('numOfRows') : self.numofRows,
                                        quote_plus('dates') : self.today })
        try:
            print(queryParams)
            request = Request(url + queryParams)
            request.get_method = lambda: 'GET'
            result=urlopen(request)
            return result.read().decode('utf-8')  
        except HTTPError as e:
            print(e)
            print('Reload API')
            return '-1'
        
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
        httpresponse=self.RltmAucBrknewsService()

        if httpresponse!='-1':
            RltmAucTree=ET.fromstring(httpresponse)
            if RltmAucTree.find("./header/resultCode").text=='00':
                totalcount=int(RltmAucTree.find("./body/totalCount").text)
                items=self.RltmAucParsing(RltmAucTree, totalcount-self.existcount)
                if(totalcount-self.existcount!=0):
                    for item in items[::-1]:
                        if self.todatetime(item['bidtime']) > self.timestamp:
                            print(json.dumps(item, indent=2, ensure_ascii=False))
                            self.producer.send(self.topic, value=item)
                            self.producer.flush()
                    self.existcount=totalcount
                    self.timestamp=self.todatetime(item['bidtime'])
        threading.Timer(self.timeinterval, self.RltmAucNewNews).start()


if __name__ == "__main__":
    topic='realtimeauction'
    event=RealTimeAuctionService(topic)
    event.RltmAucNewNews()


