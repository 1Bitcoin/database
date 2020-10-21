select name, price,  
	min(price) over (partition by name), max(price) over (partition by name),
	avg(price) over (partition by name)
from products

