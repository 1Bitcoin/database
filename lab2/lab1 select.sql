select *
from users
where id in
(
	select distinct users.id
	from users join card_products on users.id = card_products.user_id
	where product_id in
	(
		select distinct products.id
		from card_products join products on card_products.product_id = products.id
		where price = 
		(
				select price
				from products
				where name = 'SSD' and id = 1
		)
	)
)