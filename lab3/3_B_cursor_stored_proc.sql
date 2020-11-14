create or replace procedure update_price_by_age(new_price int, start_age int, stop_age int) as
$$
declare my_cursor cursor
	for select *
	from card_products
	where limit_of_age between start_age and stop_age;
	my_row record;
begin
	open my_cursor; --what
	loop
		fetch my_cursor into my_row;
		exit when not found;
		update products
		set price = new_price
		where products.id = my_row.product_id;
	end loop;
	close my_cursor;		
end
$$ language plpgsql;

call update_price_by_age(1137, 12, 13);