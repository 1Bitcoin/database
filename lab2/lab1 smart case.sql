select products.price, 
	case
		when price < 1000 then 'Low'
		when price > 5000 then 'High'
		else 'Very high'
	end as check_price
from products