Модуль plpy содержит различные функции для выполнения команд в базе данных:
При вызове plpy.execute выполняется заданный запрос, а то, что он выдаёт, возвращается в виде объекта результата.

Функция plpy.prepare подготавливает план выполнения для запроса. 

TD содержит значения, связанные с работой триггера

 Получение названия товара по id

create or replace function get_product_by_id(my_id int) returns varchar
as $$
ppl = plpy.execute("select * from products")
for product in ppl:
	if product['id'] == my_id:
		return product['name']
return 'None'
$$ language plpython3u;

select * from get_product_by_id(228);

У скольких друзей есть друзья

create or replace function get_count_friends() returns int
as $$
information = plpy.execute("select * from users")
summ = 0
for person in information:
	if person['friend_id'] != None:
		summ += 1;
return summ
$$ language plpython3u;

select * from get_count_friends();

Возвращает информацию о всех продуктах указанной цены

create or replace function get_info_by_price (price int) 
returns table (	id int, name varchar, description varchar, price int, type varchar, dimension varchar)
as $$
informaton = plpy.execute("select * from products")
res = []
for product in informaton:
	if product['price'] == price:
		res.append(product)
return res
$$ language plpython3u;

select * from get_info_by_price(2000);

Добавляет нового пользователя в базу

create or replace procedure add_user(username varchar,  email varchar,  password varchar, phone varchar, friend_id int) as
$$
information = plpy.prepare("insert into users(username, email, password, phone, friend_id) values($1, $2, $3, $4, $5);", 
						   ["varchar", "varchar", "varchar", "varchar", "int"])
plpy.execute(information, [username,  email,  password, phone, friend_id])
$$ language plpython3u;

call add_user('Test person', 'maill', '12345', '777', 10);

select * from users
order by id desc;

При удалении пользователей, данные копируются в таблицу people_back

create or replace function backup_deleted_users()
returns trigger 
as $$
plan = plpy.prepare("insert into people_back(username,  email,  password, phone) values($1, $2, $3, $4);", 
					["varchar", "varchar", "varchar", "varchar"])
pi = TD['old']
rv = plpy.execute(plan, [pi["username"], pi["email"], pi["password"], pi["phone"]])
return TD['new']
$$ language  plpython3u;

--drop trigger backup_deleted_people on users; 

create trigger backup_deleted_users
before delete on users for each row
execute procedure backup_deleted_users();

delete from users
where username = 'Test person';

select * from people_back;

Тип параметров пользователя

create type stats as (
  username varchar,
  email varchar,
  password varchar
);

create or replace function get_stats_by_id(my_id integer) returns stats 
as $$
plan = plpy.prepare("select username, email, password from users where id = $1", ["int"])
cr = plpy.execute(plan, [my_id])
return (cr[0]['username'], cr[0]['email'], cr[0]['password'])
$$ language plpython3u;

select * from get_stats_by_id(1001);






