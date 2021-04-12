#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import urllib.request
import xmltodict
import urllib
import json
import ssl

context = ssl._create_unverified_context()

#p_fymd : 조회기간 시작일 8자리
#p_tymd : 조회기간 종료일 8자리
#p_pum_cd : 품목코드
#p_unit_qty : 품목별 중랑크기
#p_unit_cd : 품목별 중량단위
#p_grade : 품목별 등급
#p_pos_gubun : 시장구분 ( 가락 1 양곡 2 강서시장경매 3 강서시장 9 )
main_url =  "http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=data5&pagesize=10&pageidx=1&portal.templet=false&p_fymd=20140429&p_tymd=20140506&d_cd=2&p_pum_cd=21100&p_unit_qty=5&p_unit_cd=04&p_grade=0&p_pos_gubun=1"
#가락시장 코드는 63페이지까지 존재 
garak_code_url = "http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=gk_pumcd&pagesize={i}&pageidx=64&portal.templet=false"


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[100]:


garak_product = dict() #가락시장품목 코드 및 품목명
for i in range(1,64):
    request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=gk_pumcd&pagesize=10&pageidx={}&portal.templet=false".format(i))
    response = urllib.request.urlopen(request,context=context).read()
    rescode = response.decode('utf-8')
    xml_parse = xmltodict.parse(rescode)
    xml_dict = json.loads(json.dumps(xml_parse))
    for temp in xml_dict['lists']['list']:
        garak_product[temp['S_NM']] = temp['S_GOSA'] #가락시장품목 상품명과 코드로 조회 
print(garak_product)


# In[ ]:





# In[ ]:





# In[ ]:





# In[102]:


gangseo_code_url ="http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=gs_pumcd&pagesize=10&pageidx=1&portal.templet=false"
gangseo_product = dict() #가락시장품목 코드 및 품목명
for i in range(1,38):
    request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=gs_pumcd&pagesize=10&pageidx={}&portal.templet=false".format(i))
    response = urllib.request.urlopen(request,context=context).read()
    rescode = response.decode('utf-8')
    xml_parse = xmltodict.parse(rescode)
    xml_dict = json.loads(json.dumps(xml_parse))
    for temp in xml_dict['lists']['list']:
        gangseo_product[temp['S_NM']] = temp['S_GOSA'] #가락시장품목 상품명과 코드로 조회 
print(gangseo_product)


# In[ ]:





# In[ ]:





# In[104]:


yanggok_product = dict() #양곡시장 품목 
for i in range(1,4):
    request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=yj_pumcd&pagesize=10&pageidx={}&portal.templet=false".format(i))
    response = urllib.request.urlopen(request,context=context).read()
    rescode = response.decode('utf-8')
    xml_parse = xmltodict.parse(rescode)
    xml_dict = json.loads(json.dumps(xml_parse))
    for temp in xml_dict['lists']['list']:
        yanggok_product[temp['S_NM']] = temp['S_GOSA'] #가락시장품목 상품명과 코드로 조회 
print(yanggok_product)


# In[ ]:





# In[ ]:





# In[106]:





# In[ ]:





# In[ ]:





# In[108]:


print(len(garak_product))
print(len(gangseo_product))
garak_product.update(gangseo_product) #가락시장과 강서시장 품목 합쳐줌
print(garak_product)
print(len(garak_product))


# In[ ]:





# In[ ]:





# In[ ]:





# In[190]:


garak_size = dict()
#가락시장 각 품목별 중량크기 종류 데이터 호출 
for key,value in garak_product.items():
    request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=unit_qty&pagesize=10&p_pum_cd={}&pageidx=1&portal.templet=false".format(value))
    response = urllib.request.urlopen(request,context=context).read()
    rescode = response.decode('utf-8')
    xml_parse = xmltodict.parse(rescode)
    xml_dict = json.loads(json.dumps(xml_parse))
    garak_size[key] = xml_dict['lists']['list']


# In[ ]:





# In[197]:



garak_unit = dict()
garak_grade = dict()
garak_unit_size =dict()
garak_grade_size = dict()
#가락시장 각 품목별 중량단위 호출
for key,value in garak_product.items(): 
    request2 = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=unit_cd&pagesize=10&p_pum_cd={}&pageidx=1&portal.templet=false".format(value))
    response2 = urllib.request.urlopen(request2,context=context).read()
    rescode2 = response2.decode('utf-8')
    xml_parse2 = xmltodict.parse(rescode2)
    xml_dict2 = json.loads(json.dumps(xml_parse2))
    garak_unit[key] = xml_dict2['lists']['list']
    garak_unit_size[key] = int(xml_dict2['lists']['list_total_count'])

    
#     print(xml_dict2['lists']['list'])
#     for i in range(0, len(garak_size[key])):
#         if(len(garak_size[key])==1):
#             print(garak_size[key])
#         else:
#             print(garak_size[key][i])

#가락시장 각 품목별 중량단위 데이터 호출 
for key,value in garak_product.items():    
    request3 = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=grade&pagesize=10&p_pum_cd={}&pageidx=1&portal.templet=false".format(value))
    response3 = urllib.request.urlopen(request3,context=context).read()
    rescode3 = response3.decode('utf-8')
    xml_parse3 = xmltodict.parse(rescode3)
    xml_dict3 = json.loads(json.dumps(xml_parse3))
    garak_grade[key]=xml_dict3['lists']['list']
    garak_grade_size[key] = int(xml_dict3['lists']['list_total_count'])


#각 품목별 중량 크기 호출 (양곡시장제외 )


# In[191]:





# In[194]:





# In[193]:





# In[199]:



for key, value in garak_product.items():
     print(garak_size[key])
     print(garak_unit[key],garak_unit_size[key])
     print(garak_grade[key],garak_grade_size[key])
    


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[268]:


#최종 가락시장 상품 상품코드 크기 단위 등급 계산 표
for key, value in garak_product.items():
    for i in range(len(garak_size[key])):
        if(len(garak_size[key])==1):
            size = garak_size[key]['UNIT_QTY']
        else:
            size = garak_size[key][i]['UNIT_QTY']
        for j in range(garak_unit_size[key]):
            if(garak_unit_size[key]==1):
                unit = garak_unit[key]['UNIT_CD']
            else:
                unit = garak_unit[key][j]['UNIT_CD']
            for k in range(garak_grade_size[key]):
                if(garak_grade_size[key])==1:
                    grade = garak_grade[key]['GRADE_CD']
                else:
                    grade = garak_grade[key][k]['GRADE_CD']
                #print(key,value,size,unit,grade)
                if(key=='대파(일반)'):
                    print(key,value,size,unit,grade)
                    request = urllib.request.Request("https://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=data5&pagesize=10&pageidx=1&portal.templet=false&p_fymd=20210412&p_tymd=20210412&d_cd=2&p_pum_cd={}&&p_unit_qty={}&p_unit_cd={}&p_grade={}&p_pos_gubun=1".format(value,size,unit,grade))
                    response = urllib.request.urlopen(request,context=context).read()
                    rescode = response.decode('utf-8')
                    xml_parse = xmltodict.parse(rescode)
                    xml_dict = json.loads(json.dumps(xml_parse))
                    print(xml_dict['lists']['list'])
#                     for i in range(len(xml_dict['lists']['list'])):
#                         print('검색 년월일 : ', xml_dict['lists']['list'][i]['YMD'])
#                         print('1년전 평균가 : ',xml_dict['lists']['list'][i]['AVG_P1'])
#                         print('2년전 평균가 : ',xml_dict['lists']['list'][i]['AVG_P2'])
#                         print('3년전 평균가 : ',xml_dict['lists']['list'][i]['AVG_P3'])
#                         print('4년전 평균가 : ', xml_dict['lists']['list'][i]['AVG_P4'])
#                         print('5년전 평균가 : ',xml_dict['lists']['list'][i]['AVG_P5'])
#                         print('현재평균 거래가격 : ',xml_dict['lists']['list'][i]['STD_PRICE'])
                
#  request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=data5&pagesize=10&pageidx=1&portal.templet=false&p_fymd=20140429&p_tymd=20140506&d_cd=2&p_pum_cd=21100&p_unit_qty=5&p_unit_cd=04&p_grade=0&p_pos_gubun=1")


# In[225]:


request = urllib.request.Request("https://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=data5&pagesize=10&pageidx=1&portal.templet=false&p_fymd=20210312&p_tymd=20210412&d_cd=2&p_pum_cd=43700&&p_unit_qty=1&p_unit_cd=00&p_grade=1&p_pos_gubun=1")
response = urllib.request.urlopen(request,context=context).read()
rescode = response.decode('utf-8')
xml_parse = xmltodict.parse(rescode)
xml_dict = json.loads(json.dumps(xml_parse))


# In[226]:


count = int(xml_dict['lists']['list_total_count'])
print(count)
print(xml_dict)
print(xml_dict['lists']['list'])
#     for i in range(count):
#         print(xml_dict['lists']['list'][i]['YMD'])
#         print(xml_dict['lists']['list'][i]['MD'])
#         print(xml_dict['lists']['list'][i]['UNIT'])
#         print(xml_dict['lists']['list'][i]['PUM_NM'])


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[90]:


#품목별 중량 단위 데이터 호출 (양곡시장제외)
for key,value in garak_product.items():
    request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=unit_cd&pagesize=10&p_pum_cd={}&pageidx=1&portal.templet=false".format(value))
    response = urllib.request.urlopen(request,context=context).read()
    rescode = response.decode('utf-8')
    xml_parse = xmltodict.parse(rescode)
    xml_dict = json.loads(json.dumps(xml_parse))
    print(xml_dict)


# In[91]:


for key,value in garak_product.items():
    request = urllib.request.Request("http://www.garak.co.kr/publicdata/dataOpen.do?id=2907&passwd=whdvm123!&dataid=grade&pagesize=10&p_pum_cd={}&pageidx=1&portal.templet=false".format(value))
    response = urllib.request.urlopen(request,context=context).read()
    rescode = response.decode('utf-8')
    xml_parse = xmltodict.parse(rescode)
    xml_dict = json.loads(json.dumps(xml_parse))
    print(xml_dict)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:


for i in range(1,64):
    
    


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[44]:


request = urllib.request.Request(garak_code_url)
response = urllib.request.urlopen(request,context=context).read()
rescode = response.decode('utf-8')
xml_parse = xmltodict.parse(rescode)
print(xml_parse)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[26]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




