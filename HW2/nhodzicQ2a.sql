drop database if exists nhodzichw2q2;
create database nhodzichw2q2;
use nhodzichw2q2;

drop table if exists customers;
create table customers
(custid int, fname varchar(45), lname varchar(45), address varchar(45), 
phone_num varchar(45), primary key(custid));

drop table if exists product_types;
create table product_types
(type_name varchar(45), primary key(type_name));

drop table if exists products;
create table products
(itemid int, remaining_qty int, item_name varchar(45), price float, 
type_name varchar(45) not null, primary key(itemid),
foreign key(type_name) references product_types(type_name));

drop table if exists employees;
create table employees
(eid int, address varchar(45), fname varchar(45), lname varchar(45), phone_num varchar(45), 
meid int, primary key(eid));

drop table if exists hourly_workers;
create table hourly_workers
(heid int, hourly_wage float, hours_per_week int, specialty varchar(45),
primary key(heid), foreign key(heid) references employees(eid) on delete cascade);

drop table if exists fulltime_workers;
create table fulltime_workers
(feid int, salary varchar(45), title varchar(45), primary key(feid), 
foreign key(feid) references employees(eid) on delete cascade);

drop table if exists managers;
create table managers
(meid int, salary varchar(45), max_supervise_cap int, primary key(meid), 
foreign key(meid) references employees(eid) on delete cascade);

alter table employees
add foreign key(meid) references managers(meid);

drop table if exists suppliers;
create table suppliers
(supplier_name varchar(45), address varchar(45), primary key(supplier_name));

drop table if exists ingredients;
create table ingredients
(ingredientid int, description varchar(45), primary key(ingredientid));

drop table if exists purchase;
create table purchase
(custid int, itemid int, quantity int, primary key(custid, itemid),
foreign key(custid) references customers(custid),
foreign key(itemid) references products(itemid));

drop table if exists make;
create table make
(heid int, itemid int, primary key(heid, itemid),
foreign key(heid) references hourly_workers(heid),
foreign key(itemid) references products(itemid));

drop table if exists bought_from;
create table bought_from
(itemid int, ingredientid int, supplier_name varchar(45), qty int, price float,
purchase_date date, primary key(itemid, ingredientid, supplier_name),
foreign key(itemid) references products(itemid),
foreign key(ingredientid) references ingredients(ingredientid),
foreign key(supplier_name) references suppliers(supplier_name));