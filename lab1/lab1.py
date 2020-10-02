from faker import Faker
from random import randint
from random import uniform
from random import choice
import random

MAX_N = 10000
COUNT_BASKETS = 6294

def generatePassword():
    chars = '+!abcdefghijklnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
    length = randint(8, 32)
    password = ''
    
    for i in range(length):
        password += random.choice(chars)
    return password

def generateUsers():
    faker = Faker()
    f = open('users.csv', 'w')
    for i in range(MAX_N):
        line = "{0},{1},{2},{3}\n".format(faker.name(), faker.email(), generatePassword(),
                                                  faker.phone_number())
        f.write(line)
    f.close()


def generateBaskets():
    f = open('baskets.csv', 'w')
    usedId = []
    count = 0
    
    for i in range(MAX_N):
        newId = random.randrange(1, MAX_N)
        
        if newId not in usedId:
            usedId.append(newId)
            line = "{0},{1}\n".format(newId, random.randrange(20, 100000))
            f.write(line)
            
            
    f.close()

def generateProducts():
    f = open('products.csv', 'w')

    descriptions = ['good', 'so-so', 'bad', 'very bad', 'very good', 'normal', 'premium', 'premiun lux']
    name = ['computer', 'car', 'milk', 'game', 'cat', 'dog', 'paper', 'table', 'negr', 'bed', 'air pods', 'book']
    
    for i in range(MAX_N):
        line = "{0},{1},{2}\n".format(random.choice(name), random.choice(descriptions), random.randrange(2, 10000))
        f.write(line)
    f.close()

def generateProductsphoto():
    f = open('productsPhoto.csv', 'w')
    usedId = []
    faker = Faker()
    
    for i in range(MAX_N):
            line = "{0},{1}\n".format(faker.image_url(), i + 1)
            f.write(line)
    f.close()

def generateCardproducts():
    f = open('cardProducts.csv', 'w')
    
    for i in range(COUNT_BASKETS):
        line = "{0},{1}\n".format(i + 1, random.randrange(1, 10000))
        f.write(line)
        
    f.close()
        
    
if __name__ == "__main__":
    #generateUsers()
    #generatePassword()
    #generateBaskets()
    #generateProducts()
    #generateProductsphoto()
    generateCardproducts()
