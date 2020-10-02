SELECT SUM(price) FROM products;
SELECT count(*) AS Count_Product FROM (card_products JOIN products ON card_products.product_id = products.id) as tmp
