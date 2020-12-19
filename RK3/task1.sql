Вариант 1. Жигалкин Дмитрий. ИУ7-55

create table if not exists employee (
	id serial not null primary key,
	name varchar(50) not null,
	birthdate date,
	department varchar(15)
);

insert into employee(name, birthdate, department)
values ('Иванов Иван Иванович', '25-09-1990', 'ИТ');

insert into employee(name, birthdate, department)
values ('Иванов Второй', '25-09-1970', 'ИТ');

insert into employee(name, birthdate, department)
values ('Петров Петр Петрович', '12-11-1987', 'Бухгалтерия');


create table if not exists record (
	id_employee int references employee(id) not null,
	rdate date,
	weekday varchar(15),
	rtime time,
	rtype int
);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(1, '21-12-2019', 'Суббота', '9:01', 1);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(1, '14-12-2018', 'Суббота', '9:20', 2);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(2, '21-12-2019', 'Суббота', '10:00', 1);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(2, '14-12-2018', 'Суббота', '9:05', 1);


=== Задание 1 ===
Написать скалярную функцию, возвращающую количество сотрудников в возрасте от 18 до
40, выходивших более 3х раз.

select count(*)
from (
        select emp.id, count(rtype) as crtype
        from (
                select *
                from employee
                where (extract(year from now()) - extract(year from birthdate)) <= 40 and (extract(year from now()) - extract(year from birthdate)) >= 18
            ) as emp join record tms ON emp.id = tms.id_employee
        where rtype = 2
        group by emp.id
) t1
where t1.crtype > 3;