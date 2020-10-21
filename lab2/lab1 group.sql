select name, 
	case
		when price < 30 then 'Low'
		when price < 100 then 'Normal'
		when price > 200 then 'High'
		else 'Very high'
	end as price_check
from products
