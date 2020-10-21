select products.id, products.name
from products
group by products.id
HAVING AVG(products.price) > 228

