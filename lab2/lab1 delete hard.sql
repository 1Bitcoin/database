delete from products
where id in
(
	select products.id
	from products
	where price = 228
)

