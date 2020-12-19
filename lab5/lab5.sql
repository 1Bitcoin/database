1) Извлечение данных с помощью функций создания JSON.
select to_json(users) from users;



2) Сохранение и загрузка JSON-документа
copy (select row_to_json(users) from users) 		-- Сохраняем данные из таблицы users в save.json
to 'C:\Users\zhigalkin\OneDrive\Desktop\save.json';

drop table ppl_import;
create temp table ppl_import(doc json);
copy ppl_import from 'C:\Users\zhigalkin\OneDrive\Desktop\save.json'; -- Загружаем данные из save.json

select *
from ppl_import, json_populate_record(null::users, doc) as p; -- Разворачивает объект из from_json в табличную строку, в которой 
														      --столбцы соответствуют типу строки, заданному параметром base

-- ***************************************
   Извлечь json фрагмент из json документа
-- ***************************************
create temp table import(doc json);
copy import from 
'C:\Users\zhigalkin\OneDrive\Desktop\tempJson.json';

select *
into temp tbl
from
(
    -- Получить все, что внутри массива
    select p.*
    from import, json_array_elements(doc) p
    limit 1
) imp;

select * from tbl;

-- *****************************************************
   Извлечь значения конкретных аттрибутов json документа
-- *****************************************************
drop table import;
drop table tbl;

create temp table import(doc json);
copy import from 
'C:\Users\zhigalkin\OneDrive\Desktop\tempJson.json';

select *
into temp tbl
from
(
    -- Получить все, что внутри массива
    select p.*
    from import, json_array_elements(doc) p
) imp;

select json_extract_path(tbl.value, 'username') 
from tbl;

-- **************************************************
  Выполнить проверку существования узла или атрибута
-- **************************************************
drop table import;
drop table tbl;

create temp table import(doc json);
copy import from 
'C:\Users\zhigalkin\OneDrive\Desktop\tempJson.json';

select *
into temp tbl
from
(
    -- Получить все, что внутри массива
    select p.*
    from import, json_array_elements(doc) p
) imp;

SELECT tbl.value::jsonb ? 'username' from tbl /* jsonb сохраняются в разобранном двоичном 
                                                формате, что значительно ускоряет обработку*/

-- **********************
  Изменить json документ
-- **********************
drop table import;
drop table tbl;

create temp table import(doc json);
copy import from 
'C:\Users\zhigalkin\OneDrive\Desktop\tempJson.json';

select *
into temp tbl
from
(
    -- Получить все, что внутри массива
    select *
    from import, json_populate_recordset(null::users, doc) as p
) imp;

--select * from tbl

update tbl
set doc = '{"status":10}'::jsonb;

select * from tbl

-- ***************************************************
 Разделить json документ на несколько строк по узлам
-- ***************************************************

drop table import;
drop table tbl;

create temp table import(doc json);
copy import from 
'C:\Users\zhigalkin\OneDrive\Desktop\newJson.json';

select *
into temp tbl
from
(
    -- Получить все, что внутри массива
    select p.*
    from import, json_array_elements(doc) p
) imp;

select json_each_text(tbl.value -> 'info')
from tbl





