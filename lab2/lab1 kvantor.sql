select *
from products
where price < all --значение предиката ALL будет истинным, если для всех значений 
				  -- V, получаемых из подзапроса, предикат "<значение выражения> <оператор сравнения> V" дает TRUE.
(
	select price
	from products
	where id = '2202'
)