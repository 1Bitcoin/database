SELECT products.product_name, products.id, products_photo.product_id, products_photo.url 
FROM products JOIN products_photo ON products.id = products_photo.product_id 

where products.id in  --IN позволяет определить, совпадает ли значение объекта со значением в списке.
(	select products.price
 	from products
 	where price > 9990
)




