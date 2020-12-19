Вариант 1. Жигалкин Дмитрий. ИУ7-55

===Задание 2.1.1===
Найти все отделы, в которых работает более 10 сотрудников

def task(cursor):
    cursor.execute('select department from employee group by department having count(id) > 10')

    records = cursor.fetchall()

    for item in records:
        print(item)

def normalExit(cursor, connection):
    cursor.close()
    connection.close()
    print("Connection closed")
    

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

    task(cursor)

    normalExit(cursor, connection)

main()

===Задание 2.1.2===
Найти все отделы, в которых работает более 10 сотрудников

from peewee import *

database = PostgresqlDatabase('BMSTU', **{'user': 'postgres', 'password': 'monerocoinyota'})

class UnknownField(object):
    def __init__(self, *_, **__): pass

class BaseModel(Model):
    class Meta:
        database = database

class Employee(BaseModel):
    birthdate = DateField(null=True)
    department = CharField(null=True)
    name = CharField()

    class Meta:
        table_name = 'employee'

class Record(BaseModel):
    id_employee = ForeignKeyField(column_name='id_employee', field='id', model=Employee)
    rdate = DateField(null=True)
    rtime = TimeField(null=True)
    rtype = IntegerField(null=True)
    weekday = CharField(null=True)

    class Meta:
        table_name = 'record'
        primary_key = False

que = Employee.select(Employee.department).from_(Employee).group_by(Employee.department).having(fn.count(Employee.id) > 10)

records = que.dicts().execute()

for record in records:
    print('record: ', record)

===Задание 2.2.1===
Найти сотрудников, которые не выходят с рабочего места в течение всего рабочего дня

def task(cursor, check_date):
            cursor.execute("""
            SELECT tms.id_employee
            FROM timestamps tms
            WHERE stype = 2 AND sdate = %s
            GROUP BY tms.id_employee
            HAVING COUNT(stype) = 1;
            """, (check_date, ))

    records = cursor.fetchall()

    for item in records:
        print(item)

def normalExit(cursor, connection):
    cursor.close()
    connection.close()
    print("Connection closed")
    

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

    task(cursor, "18-12-2018")

    normalExit(cursor, connection)

main()


===Задание 2.2.2===
Найти сотрудников, которые не выходят с рабочего места в течение всего рабочего дня

database = PostgresqlDatabase('BMSTU', **{'user': 'postgres', 'password': 'monerocoinyota'})

class UnknownField(object):
    def __init__(self, *_, **__): pass

class BaseModel(Model):
    class Meta:
        database = database

class Employee(BaseModel):
    birthdate = DateField(null=True)
    department = CharField(null=True)
    name = CharField()

    class Meta:
        table_name = 'employee'

class Record(BaseModel):
    id_employee = ForeignKeyField(column_name='id_employee', field='id', model=Employee)
    rdate = DateField(null=True)
    rtime = TimeField(null=True)
    rtype = IntegerField(null=True)
    weekday = CharField(null=True)

    class Meta:
        table_name = 'record'
        primary_key = False

que = Employee.select(Record.id_employee).from_(Record).where((Record.rtype == 2) & (Record.rdate == '14-12-2018')).group_by(Record.id_employee).having(fn.count(Record.rtype) == 1)

records = que.dicts().execute()

for record in records:
    print('record: ', record)

===Задание 2.3.1===
Найти все отделы, в которых есть сотрудники, опоздавшие в определенную дату. Дату передавать с клавиатуры

def task(cursor, check_date):
    cursor.execute("""
    SELECT department
    FROM (
        select id_employee
        from (
            select id_employee, rtype, rtime, min(rtime) over(partition by id_employee) as mtime
            from (
                select id_employee, rtype, min(rtime) as rtime
                from record
                where rdate = %s
                group by id_employee, rtype
                having min(rtime) > '9:00'
                ) as que1
            ) as que2
        where rtype = 1 and rtime = mtime) qwe JOIN employee emp ON qwe.id_employee = emp.id;
                """, (check_date, ))

    records = cursor.fetchall()

    for item in records:
        print(item)

def normalExit(cursor, connection):
    cursor.close()
    connection.close()
    print("Connection closed")
    

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

    task(cursor, "18-12-2018")

    normalExit(cursor, connection)

main()



===Задание 2.3.2===
Найти все отделы, в которых есть сотрудники, опоздавшие в определенную дату. Дату передавать с клавиатуры

class BaseModel(Model):
    class Meta:
        database = database

class Employee(BaseModel):
    birthdate = DateField(null=True)
    department = CharField(null=True)
    name = CharField()

    class Meta:
        table_name = 'employee'

class Record(BaseModel):
    id_employee = ForeignKeyField(column_name='id_employee', field='id', model=Employee)
    rdate = DateField(null=True)
    rtime = TimeField(null=True)
    rtype = IntegerField(null=True)
    weekday = CharField(null=True)

    class Meta:
        table_name = 'record'
        primary_key = False


request = Record.select(Record.id_employee, Record.rtype, fn.min(Record.rtime)).from_(Record).where(Record.rdate == '18-12-2018').group_by(Record.id_employee, Record.rtype).having(fn.min(Record.rtime) > '9:00').alias("t1")










    
