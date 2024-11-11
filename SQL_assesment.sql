create database assesment;
use assesment;

create table customer(customer_id int, cust_name varchar(100), city varchar(50), grade int,salesman_id int);
create table salesman(salesman_id int,name varchar(100),city varchar(50),commission decimal(3,2));

insert into customer values(3002,"Nick Rimando","New York",100,5001),(3007,"Brad Davis","New York",200,5001),(3005,"Graham Zusi","California",200,5002),(3008,"Julian Green","London",300,5002),(3004,"Fabian Johnson","Paris",300,5006),(3009,"Geoff Cameron","Berlin",100,5003),(3003,"Jozy Altidor","Moscow",200,5007),(3001,"Brad Guzan","London",null,5005);
insert into salesman values(5001,"James Hoog","New York",0.15),(5002,"Nail Knite","Paris",0.13),(5005,"Pit Alex","London",0.11),(5006,"Mc Lyon","Paris",0.14),(5007,"Paul Adam","Rome",0.13),(5003,"Lousen Hen","San Jose",0.12);

select * from customer;
select * from salesman;

SELECT customer.cust_name, salesman.city,commission
FROM customer
INNER JOIN salesman
ON customer.salesman_id = salesman.salesman_id