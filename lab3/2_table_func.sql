drop function if exists table_func;
create function table_func(int) returns users as
$$
	select *
	from users
	where id = $1;
$$ language sql;

select *, upper(username)
from table_func(18);