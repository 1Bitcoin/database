select name, price,  
	min(price) over (partition by name), max(price) over (partition by name), --подсчет будет идти в каждой группе отдельно (partition by)
	avg(price) over (partition by name)
from products

