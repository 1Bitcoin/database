/*CREATE TRIGGER check_insert
    BEFORE INSERT ON products
    FOR EACH ROW
    EXECUTE PROCEDURE check_price();*/

create or replace function check_price()
returns trigger as
$$
begin
	IF NEW.price <= 0 THEN 
		raise notice 'exception, wrong price';
		return OLD;
	ELSE
		raise notice 'products was inserted';
		return NEW;
	END IF;

end;
$$ language plpgsql;

INSERT INTO products(id, name, description, price, type, dimension) 
VALUES (12122, 'new_CPU', 'very good', -2, 'new', '10x55x45');

--Через триггер реализовать проверку
--если добавляется что-то с неправильной ценой, то не добавлять, если цена правильная, то добавить

