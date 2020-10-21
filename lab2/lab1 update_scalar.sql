update products
set price = 
(
	select avg(price)
	from products
	where type = 'new'
)
where type = 'new'

