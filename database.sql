CREATE DATABASE spiritory;

CREATE TABLE users(
    u_id SERIAL PRIMARY KEY,
    email VARCHAR NOT NULL UNIQUE ,
    name VARCHAR NOT NULL,
    lastname VARCHAR NOT NULL,
    birthday DATE,
    password VARCHAR NOT NULL
);


CREATE TABLE items(
    i_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    price FLOAT NOT NULL
); 

CREATE TABLE purchase_item(
    pi_id SERIAL PRIMARY KEY,
    u_id INT REFERENCES users(u_id) NOT NULL,
    i_id INT REFERENCES items(i_id) NOT NULL,
    quantity FLOAT NOT NULL,
    price FLOAT NOT NULL,
    total_purchase_item_price FLOAT NOT NULL
);



CREATE TABLE purchase AS SELECT u_id, SUM(total_purchase_item_price) FROM purchase_item
GROUP BY u_id;


ALTER TABLE purchase
ADD p_id SERIAL PRIMARY KEY,
ADD date DATE;


SELECT purchase.p_id, purchase.u_id, purchase.date, items.name, purchase_item.quantity, purchase_item.price, purchase_item.total_purchase_item_price
FROM purchase
INNER JOIN purchase_item ON purchase.u_id = purchase_item.u_id
INNER JOIN items ON items.i_id = purchase_item.i_id;
  






/* select purchase.p_id, 
purchase.date, 
purchase.u_id, 
pi.i_id, 
pi.quantity, 
pi.price, 
pi.tpip
from purchase
inner join ( select i_id, quantity, price, total_purchase_item_price as tpip 
from purchase_item group by u_id) pi on purchase.u_id = pi.u_id; */

/* CREATE TABLE purchase AS p_id SERIAL PRIMARY KEY, 
date DATE, 
u_id INT REFERENCES users(u_id) NOT NULL, 
(SELECT, SUM(total_purchase_item_price) FROM purchase_item
GROUP BY u_id);

CREATE TABLE purchase (p_id SERIAL PRIMARY KEY, 
date DATE, 
u_id INT REFERENCES users(u_id) NOT NULL,  
SELECT SUM(total_purchase_item_price) FROM purchase_item
GROUP BY u_id); */

/* CREATE TABLE purchase(
    p_id SERIAL PRIMARY KEY,
    u_id INT REFERENCES users(u_id) NOT NULL,
    date DATE,
    total_purchase_price FLOAT NOT NULL
); */