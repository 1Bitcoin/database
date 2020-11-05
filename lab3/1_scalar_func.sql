drop function if exists scalar_func;
create function scalar_func() returns int as
'
	select price
	from products
	order by id DESC
' language sql;

select scalar_func();