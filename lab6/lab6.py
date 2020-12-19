import psycopg2

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

def normalExit(cursor, connection):
    cursor.close()
    connection.close()
    print("Connection closed")

def scalarQuery(cursor):
    cursor.execute('select MAX(price) from products')

    records = cursor.fetchall()

    for item in records:
        print(item)


def multiJoinquery(cursor):
    cursor.execute('select username, name from card_products join users \
                    on card_products.user_id = users.id join products on \
                    products.id = card_products.product_id limit 5')
    
    records = cursor.fetchall()

    for item in records:
        print(item)

def windowFunction(cursor):
    
    cursor.execute('select name, price,  min(price) over (partition by name), \
                        max(price) over (partition by name), \
                        avg(price) over (partition by name) from products limit 5')
    
    records = cursor.fetchall()

    for item in records:
        print(item)
        
def metaData(cursor):
    cursor.execute("select * from pg_database_size('BMSTU')")
    
    records = cursor.fetchall()

    for item in records:
        print("Size: ", item)

def scalarFuncfromLab(cursor):
    cursor.execute("select scalar_func()")
    
    records = cursor.fetchall()

    for item in records:
        print(item)

def tableFuncfromLab(cursor):
    cursor.execute("select table_func(18)")
    
    records = cursor.fetchall()

    for item in records:
        print(item)

def storedFuncfromLab(cursor):
    cursor.execute("CALL insert_data(10007, 'https://mysite/photo/23932', 5)")

def systemFunc(cursor):
    cursor.execute("select * from current_database()")
    
    records = cursor.fetchall()

    for item in records:
        print("Name database: ", item)
    
def createTable(cursor):
    cursor.execute("create table if not exists scoresProducts ( \
                    id serial not null primary key, \
                    score INT not null, \
                    product_id INT REFERENCES products(id))")
    print("table create")

def insertInto(cursor):
    cursor.execute("INSERT INTO scoresProducts(id, score, product_id) VALUES (1, 4, 228)")
    cursor.execute("select * from scoresProducts")
                    
    records = cursor.fetchall()

    for item in records:
        print(item)
    
def manager(choice, cursor, connection):
    if choice == 0:
        normalExit(cursor, connection)
        
    elif choice == 1:
        scalarQuery(cursor)

    elif choice == 2:
        multiJoinquery(cursor)

    elif choice == 3:
        windowFunction(cursor)

    elif choice == 4:
        metaData(cursor)

    elif choice == 5:
        scalarFuncfromLab(cursor)
        
    elif choice == 6:
        tableFuncfromLab(cursor)

    elif choice == 7:
        storedFuncfromLab(cursor)
        
    elif choice == 8:
        systemFunc(cursor)

    elif choice == 9:
        createTable(cursor)

    elif choice == 10:
        insertInto(cursor)

def openConnection():
    try:
        connection = psycopg2.connect(dbname='BMSTU', user='postgres', 
                            password='monerocoinyota', host='localhost')
        
        print("Database connected\n")
        return connection

    except:
        return None
    
    return cursor, connection

def getCursor(connection):
    cursor = connection.cursor()

    return cursor

def main():
    try:
        connection = openConnection()
    except None:
        print("Failed to connect\n")

    if connection != None:        
        cursor = getCursor(connection)     
        choice = True

        while (choice):
            choice = menu()
            manager(choice, cursor, connection)

main()



