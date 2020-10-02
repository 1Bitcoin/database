select product_id, basket_id, product_name
FROM (products JOIN card_products ON products.id = card_products.product_id) as tmp
where product_name = 'negr' and exists
(	select card_products.basket_id
 	from card_products JOIN products ON products.id = card_products.product_id
 	where products.price > 9990 and card_products.basket_id = tmp.basket_id
)

