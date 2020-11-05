insert into products_photo(id, url, product_id) 
select 22222, 'url.ru/22758', products.id
from products
where products.price = 339

