select products.name
from products
group by products.name
having products.name != 'SSD' --предложение having фильтрует группы, а не строки, как where

