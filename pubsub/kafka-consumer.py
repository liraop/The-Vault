from kafka import KafkaConsumer

consumer = KafkaConsumer('Test',bootstrap_servers='192.168.13.229:2181')

while True:
    for msg in consumer:
        print (msg)
