create table if not exists users (
    id serial not null primary key,
	username varchar(45) not null,
	email varchar(255) not null,
	password varchar(32) not null,
	phone varchar(45) not null
);

create table if not exists baskets (
    id serial not null primary key,
	user_id INT REFERENCES users(id),
	val INT not null check (val > 0)
);

create table if not exists products (
    id serial not null primary key,
	name varchar(45) not null,
	description varchar(255) not null,
	price INT not null check (price > 0)
);

create table if not exists products_photo (
    id serial not null primary key,
	url varchar(45) not null,
	product_id INT REFERENCES products(id)	
);

create table if not exists card_products (
	product_id INT REFERENCES products(id),
	basket_id INT REFERENCES baskets(id)
);
