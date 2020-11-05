drop function if exists multi_table_func;
create function multi_table_func(int, int) returns table
(
	id int,
	username varchar(30),
	email varchar(30)
)
as
$$
	select id, username, email
	from users
	where id >= $1 and id <= $2
$$ language sql;

select *
from multi_table_func(18, 22); 