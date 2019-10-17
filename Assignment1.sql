CREATE DATABASE BikeSStore
CREATE SCHEMA Sales;
CREATE SCHEMA Production
use BikeSStore

CREATE TABLE Sales.customers(
customer_id INT PRIMARY KEY,
first_name varchar(20),
last_name varchar(20),
phone numeric(10),
email varchar(30) unique ,
street varchar(20),
city varchar(20),
State_ varchar(20),
zip_code int
)

create table  Sales.stores
(
store_id int primary key,
store_name varchar(20),
phone numeric(10),
email varchar(30),
street varchar(20),
city varchar(20),
State_ varchar(20),
zip_code int
)

CREATE TABLE Sales.staffs(
staff_id INT primary key,
first_name varchar(20),
last_name varchar(20),
phone numeric(10) unique,
email varchar(30) unique ,
active varchar(20),
manager_id int,

)

drop table Sales.orders
Create table Sales.orders
(
order_id int primary key,
customer_id int not null,
order_status varchar(20),
order_date date,
required_date date, 
ship_day date,
store_id int,
staff_id int,
Constraint fk_cust foreign key(customer_id) references Sales.customers(customer_id),
Constraint fk_store foreign key(store_id) references Sales.stores(store_id),
Constraint  fk_staff foreign key(staff_id) references Sales.staffs(staff_id),
)



Create table Production.categories
(
category_id int primary key,
category_name varchar(20)
)

Create table Production.brands
(
brand_id int primary key, 
brand_name varchar(20)
)


Create table Production.products
(
product_id int primary key, 
product_name varchar(20),
brand_id int,
category_id int,
model_year date,
list_price int,
Constraint fk_categories foreign key(category_id) references Production.categories(category_id),
Constraint fk_brand foreign key(brand_id) references Production.brands(brand_id)

)


Create table Production.stock
(
store_id int,
product_id int,
quantity int,
Constraint fk_product foreign key(product_id) references Production.products(product_id),
Constraint fk_store foreign key(store_id) references Sales.stores(store_id),
Constraint pk_stock primary key(store_id,product_id)
)

Create table Sales.order_items
(
order_id int,
item_id int,
product_id int,
quantity int check(quantity >0),
list_price int check(list_price >0),
discount int,
Constraint fk_order foreign key(order_id) references Sales.orders (order_id),
Constraint pk_order_item primary key (order_id,item_id),
Constraint fk_productions foreign key(product_id) references Production.products(product_id)
)
alter table Sales.order_items
add item_amount as ((quantity*list_price)-discount)

alter table Sales.staffs
add Constraint fk_staff foreign key(manager_id) references Sales.staffs(staff_id)
