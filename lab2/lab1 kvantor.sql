select *
from products
where price < all
(
	select price
	from products
	where id = '2202'
)