Вариант 4.

create table if not exists worker (
   id serial primary key,
   FIO varchar(30),
   birthday varchar(30) not null,
   stag int not null,
   phone varchar(30) not null 
);

create table if not exists post (
   id serial primary key,
   name_post varchar(30),
   address varchar(30) not null 
);

create table if not exists duty (
   id serial primary key,
   data varchar(30),
   work_hours varchar(30) not null 
);

create table if not exists duty_worker (
   id_worker int references worker(id),
   id_duty int references duty(id)
);

/*insert into worker
values (0, 'FIO0', '2000', 2, '123');

insert into worker
values (1, 'FIO1', '2050', 22, '123');

insert into worker
values (2, 'FIO2', '2020', 22, '1232');

insert into worker
values (3, 'FIO3', '2003', 33, '12333');

insert into worker
values (4, 'FIO4', '2004', 42, '143');

insert into worker
values (5, 'FIO5', '2005', 5, '1253');

insert into worker
values (6, 'FIO6', '2006', 2, '126');

insert into worker
values (7, 'FIO7', '2007', 7, '123');

insert into worker
values (8, 'FIO8', '2000', 8, '12883');

insert into worker
values (9, 'FIO9', '2009', 29, '1293');*/

/*insert into duty
values (0, '20', '12-13');

insert into duty
values (1, '21', '10-13');

insert into duty
values (2, '22', '12-14');

insert into duty
values (3, '23', '12-16');

insert into duty
values (4, '4', '14-15');

insert into duty
values (5, '6', '12-15');

insert into duty
values (6, '1', '9-13');

insert into duty
values (7, '20', '12-13');

insert into duty
values (8, '20', '12-13');

insert into duty
values (9, '28', '12-17');*/

/*insert into post
values (0, 'first', 'street 1');

insert into post
values (1, 'second', 'street 2');

insert into post
values (2, 'new', 'street 3');

insert into post
values (3, 'old', 'street 4');

insert into post
values (4, 'green', 'street 11');

insert into post
values (5, 'gh', 'street 55');

insert into post
values (6, 'qwerty', 'street 145');

insert into post
values (7, '7', 'street 77');

insert into post
values (8, '88', 'street 78');

insert into post
values (9, 'night', 'street 228');*/
/*

insert into duty_worker
values (0, 1);

insert into duty_worker
values (5, 6);

insert into duty_worker
values (3, 2);*/

-- Работникам, стаж которых подходит под одно из условий делает соответствующий вывод.
-- Пример: stag  case
--         2   "new"
--         7   "older"

SELECT worker.stag,
       CASE WHEN stag <= 2 THEN 'new'
            WHEN stag > 5 AND stag < 10 THEN 'older'
            ELSE 'pension'
       END
    FROM worker;

-- Устанавливает работнику с FIO = 'FIO0' стаж, равный среднему стажу всех работников
update worker
set stag =
(
   select avg(stag)
   from worker
)
where FIO = 'FIO0';

-- Консолидирует данные и выводит года рождения, меньшие 2010, среди которых нет FIO1
select worker.birthday, worker.FIO
from worker
group by worker.birthday, worker.FIO
having worker.birthday < '2010' and worker.FIO != 'FIO1'

-- список ddl триггеров
--select * from pg_event_trigger;

-- Удаляем триггеры из всех таблиц.
CREATE OR REPLACE FUNCTION strip_all_triggers() RETURNS text AS $$ DECLARE
    triggNameRecord RECORD;
    triggTableRecord RECORD;
   my_count int;
BEGIN
    FOR triggNameRecord IN select distinct(trigger_name) from information_schema.triggers where trigger_schema = 'public' LOOP
        FOR triggTableRecord IN SELECT distinct(event_object_table) from information_schema.triggers where trigger_name = triggNameRecord.trigger_name LOOP
            RAISE NOTICE 'Dropping trigger: % on table: %', triggNameRecord.trigger_name, triggTableRecord.event_object_table;
            EXECUTE 'DROP TRIGGER ' || triggNameRecord.trigger_name || ' ON ' || triggTableRecord.event_object_table || ';';
        END LOOP;
    END LOOP;

    RETURN my_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

select strip_all_triggers();
