select products.id, basket_id, product_id, val
from products join 
(
	card_products join baskets 
	on card_products.basket_id = baskets.id
) as temp_table on temp_table.product_id = products.id