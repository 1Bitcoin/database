--select * from products order by id
create or replace procedure update_price (new_price int, id_start int, id_stop int) as
$$
begin
	if (id_start <= id_stop)
then
	update products --UPDATE изменяет значения указанных столбцов во всех строках, удовлетворяющих условию. 
	set price = new_price
	where id = id_start;
	call update_price(new_price, id_start + 1, id_stop);
end if; 
end;
	
$$ language plpgsql;

call update_price(228, 1, 2);