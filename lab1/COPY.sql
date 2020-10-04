copy users(username, email, password, phone) 
from 'C:\Users\zhigalkin\OneDrive\desktop\Database\lab1\users.csv' delimiter ',' csv;

copy products(name, description, price, type, dimension) 
from 'C:\Users\zhigalkin\OneDrive\desktop\Database\lab1\products.csv' delimiter ',' csv;

copy products_photo(url, product_id) 
from 'C:\Users\zhigalkin\OneDrive\desktop\Database\lab1\products_photo.csv' delimiter ',' csv;

copy card_products(product_id, user_id, address, dimenstion, limit_of_age, fragility) 
from 'C:\Users\zhigalkin\OneDrive\desktop\Database\lab1\card_products.csv' delimiter '|' csv;


