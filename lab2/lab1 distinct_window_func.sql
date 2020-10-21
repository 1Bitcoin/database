drop table tempr;

create table tempr as
SELECT products.price,
  ROW_NUMBER() OVER(PARTITION BY products.price
                    ORDER BY (SELECT NULL)) AS n

FROM products;

DELETE FROM tempr
WHERE n > 1;

select *
from tempr

	