import time
from datetime import datetime
from faker import Faker
from random import randint
from random import uniform
from random import choice
import random

def generatePassword():
    chars = '+!abcdefghijklnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
    length = randint(8, 32)
    password = ''
    
    for i in range(length):
        password += random.choice(chars)
    return password

def generateUsers(filename):
    faker = Faker()
    f = open(filename, 'w')
    f.write("username,email,password,phone,friend_id\n")
    for i in range(2):
        line = "{0},{1},{2},{3},{4}\n".format(faker.name(), faker.email(), generatePassword(),
                                                  faker.phone_number(), randint(1, 400))
        f.write(line)
    f.close()

number = 1
wait_time = 20 # In seconds
filename_temp = "file_"
table_name = "BMSTU"
path = "C:/Users/zhigalkin/OneDrive/Desktop/get/"

current_entry = 0
while(True):
    my_time = str(datetime.now()).replace('.', '_').replace(':', '-').replace(' ', '_')
    filename = "{}{}_{}_{}.csv".format(path, filename_temp + str(number), table_name, my_time)
    generateUsers(filename)
    number += 1
    time.sleep(wait_time) 
