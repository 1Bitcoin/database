import psycopg2

connection = psycopg2.connect(dbname='BMSTU', user='postgres', 
                        password='monerocoinyota', host='localhost')
cursor = connection.cursor()

def menu():
    print('+' + '-' * 78 + '+')
    print("|     {:<73}".format("Menu") + '|')
    print('+' + '-' * 78 + '+')
    print("| 0.  {:<73}".format("Exit") + '|')
    print("| 1.  {:<73}".format("Scalar query") + '|')
    print("| 2.  {:<73}".format("Multijoin query") + '|')
    print("| 3.  {:<73}".format("Window functions query") + '|')
    print("| 4.  {:<73}".format("Metadata query") + '|')
    print("| 5.  {:<73}".format("Scalar function call") + '|')
    print("| 6.  {:<73}".format("Multioperator function call") + '|')
    print("| 7.  {:<73}".format("Stored procedure call") + '|')
    print("| 8.  {:<73}".format("System function call") + '|')
    print("| 9.  {:<73}".format("Creete table on DB") + '|')
    print("| 10. {:<73}".format("Insert into table") + '|')
    print('+' + '-' * 78 + '+')
    print("Choose an option: ")
    option = int(input())
    return option

def normalExit():
    cursor.close()
    connection.close()
    print("Connection closed")

def scalarQuery():
    cursor.execute('select MAX(price) from products')


def multiJoinquery():
    cursor.execute('select username, name from card_products join users \
                    on card_products.user_id = users.id join products on \
                    products.id = card_products.product_id limit 5')
    
    records = cursor.fetchall()

    for item in records:
        print(item)

def windowFunction():
    
    cursor.execute('select name, price,  min(price) over (partition by name), \
                        max(price) over (partition by name), \
                        avg(price) over (partition by name) from products limit 5')
    
    records = cursor.fetchall()

    for item in records:
        print(item)
        
def metaData():
    cursor.execute("select * from pg_database_size('BMSTU')")
    
    records = cursor.fetchall()

    for item in records:
        print("Size: ", item)

def scalarFuncfromLab():
    cursor.execute("select scalar_func()")
    
    records = cursor.fetchall()

    for item in records:
        print(item)

def tableFuncfromLab():
    cursor.execute("select table_func(18)")
    
    records = cursor.fetchall()

    for item in records:
        print(item)

def storedFuncfromLab():
    cursor.execute("CALL insert_data(10007, 'https://mysite/photo/23932', 5)")

def systemFunc():
    cursor.execute("select * from current_database()")
    
    records = cursor.fetchall()

    for item in records:
        print("Name database: ", item)
    
def createTable():
    cursor.execute("create table if not exists scoresProducts ( \
                    id serial not null primary key, \
                    score INT not null, \
                    product_id INT REFERENCES products(id))")

def insertInto():
    cursor.execute("INSERT INTO scoresProducts(id, score, product_id) VALUES (1, 4, 228)")

    cursor.execute("select * from scoresProducts")
    
    records = cursor.fetchall()

    for item in records:
        print(item)
    

def manager(choice):
    if choice == 0:
        normalExit()
        
    elif choice == 1:
        scalarQuery()

    elif choice == 2:
        multiJoinquery()

    elif choice == 3:
        windowFunction()

    elif choice == 4:
        metaData()

    elif choice == 5:
        scalarFuncfromLab()
        
    elif choice == 6:
        tableFuncfromLab()

    elif choice == 7:
        storedFuncfromLab()
        
    elif choice == 8:
        systemFunc()

    elif choice == 9:
        createTable()

    elif choice == 10:
        insertInto()
        
choice = True

while (choice):
    choice = menu()
    manager(choice)



