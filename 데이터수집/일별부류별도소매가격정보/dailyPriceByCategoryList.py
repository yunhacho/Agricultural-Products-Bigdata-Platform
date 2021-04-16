#!/usr/bin/env python
# coding: utf-8

from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote_plus
from datetime import timedelta, date
import json

def to_json(fname, items):
    with open(fname+'.json', 'w', encoding='utf-8') as make_file:
        json.dump(items, make_file, ensure_ascii=False, indent='\t')

def daterange(start_date, end_date):
    for n in range(int ((end_date - start_date).days)):
        yield start_date + timedelta(n)

def dateVal(start_date, end_date):
    start_date = [int(i) for i in start_date.split("-")]
    end_date = [int(i) for i in end_date.split("-")]
    start_date = date(start_date[0], start_date[1], start_date[2])
    end_date = date(end_date[0], end_date[1], end_date[2])

    temp_list = []
    for single_date in daterange(start_date, end_date):
        temp_list.append(single_date)

    Day_list = []
    for tmp in temp_list:
        if(tmp.weekday()!=6):
            if tmp.month < 10 and tmp.day < 10:
                Day_list.append(format("%d-0%d-0%d" %(tmp.year,tmp.month, tmp.day )))
            elif tmp.month < 10:
                Day_list.append(format("%d-0%d-%d" %(tmp.year,tmp.month, tmp.day )))
            else :
                Day_list.append(format("%d-%d-%d" % (tmp.year, tmp.month, tmp.day)))
    return Day_list

def dailyPriceByCategoryList(category_code, regday, cls_code='02', kg_yn='Y'):
    url='http://www.kamis.or.kr/service/price/xml.do?action=dailyPriceByCategoryList'
    servicekey='ccd3cbd5-7d82-46b9-b178-c6a91aeb5e71'
    ID='1650'
    
    queryParams = '&' + urlencode(
                    {
                        quote_plus('p_cert_key') : servicekey,
                        quote_plus('p_cert_id') : ID,
                        quote_plus('p_returntype') : 'json',
                        quote_plus('p_product_cls_code') : cls_code,
                        quote_plus('p_item_category_code') : category_code,
                        quote_plus('p_regday') : regday,
                        quote_plus('p_convert_kg_yn') : kg_yn     
                    })
    request = Request(url + queryParams)
    request.get_method = lambda: 'GET'
    return json.loads(urlopen(request).read())

def get_dailyPriceByCategoryList(datelist, category_code, cls_code='02', kg_yn='Y'):
    dateitems=[]
    for regday in datelist:
        items={}; dics=[]
        for category in category_code:
            response=dailyPriceByCategoryList(category, regday, cls_code, kg_yn)
            if isinstance(response['data'], list)==False:
                if response['data']['error_code']=='000':
                    for item in response['data']['item']:
                        itemsample={
                            'item_name': item['item_name'],
                            'item_code': item['item_code'],
                            'kind_name': item['kind_name'],
                            'kind_code': item['kind_code'],
                            'rank': item['rank'],
                            'rank_code': item['rank_code'],
                            'unit': item['unit'],
                            'price': "".join(item['dpr1'].split(','))
                        }
                        dics.append(itemsample)
        items['timestamp']=regday
        items['item']=dics
        dateitems.append(items)
    return dateitems

if __name__=="__main__":
    datelist=dateVal('2000-01-01', '2021-04-12')
    category_code=['100','200', '300', '400', '600']
    
    item000101to210412=get_dailyPriceByCategoryList(datelist, category_code)
    
    content={'contents':item000101to210412}
    to_json('KamisDailyPrice', content)





