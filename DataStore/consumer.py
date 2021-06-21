from datetime import datetime
from pytz import timezone
from kafka import KafkaConsumer
import json
import time
import pymysql.cursors
import stomper
from websocket import create_connection

consumer=KafkaConsumer('realtimeauction',
                    bootstrap_servers=['mykafka.kafka.svc.cluster.local:9092'],
                    group_id='temp3',
                    value_deserializer=lambda x: json.loads(x.decode('utf-8')))

conn=pymysql.connect(host='10.106.106.193',
                    user='root',
                    password='password',
                    db="auction",
                    charset='utf8')

ws=create_connection("ws://34.64.186.184:31234/ws/websocket")

for message in consumer:
    with conn.cursor() as cursor:
        sql="insert into record (mclassname, sclassname, bidtime, price, gradename, marketname, coname, sanji, tradeamt, unitname) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        record=message.value
        date=datetime.now(timezone('Asia/Seoul'))
        record['bidtime']=str(date.year)+"-"+str(date.month)+"-"+str(date.day)+" "+":".join(record['bidtime'].split()[1:])

        cursor.execute(sql, (record['mclassname'], record['sclassname'],record['bidtime'], record['price'], record['gradename'], record['marketname'], record['coname'], record['sanji'], record['tradeamt'], record['unitname']))
        print(json.dumps(record, indent=2, ensure_ascii=False))
        conn.commit()
        sub=stomper.send('/pub/test', record)
        ws.send(sub)
conn.close()
