insert into products_photo(id, url, product_id) 
select card_products.id, 'url.ru/22758', card_products.product_id
from card_products
where products.price = 339

