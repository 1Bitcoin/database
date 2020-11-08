CREATE PROCEDURE insert_data(my_id integer, my_url varchar(45), my_products_id int)
LANGUAGE SQL
AS $$
INSERT INTO products_photo(id, url, product_id) VALUES (my_id, my_url, my_products_id);
$$;

CALL insert_data(10005, 'https://mysite/photo/23932', 2);