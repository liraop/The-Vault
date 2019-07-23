from kafka import KafkaProducer
from random_word import RandomWords

producer = KafkaProducer(bootstrap_servers='192.168.13.229:2181')
r = RandomWords()

while True:
    word = r.get_random_word()
    producer.send('Test', b'word')
