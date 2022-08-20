CREATE TABLE customer (
    customer_id INT UNIQUE PRIMARY KEY,
    name text,
    email text);

INSERT INTO customer values
  (1, 'A', 'A@gmail.com'),
  (2, 'B', 'B@gmail.com'),
  (3, 'C', 'C@gmail.com'),
  (4, 'D', 'D@gmail.com'),
  (5, 'E', 'E@gmail.com'),
  (6, 'F', 'F@gmail.com'),
  (7, 'G', 'G@gmail.com'),
  (8, 'H', 'H@gmail.com'),
  (9, 'I', 'I@gmail.com'),
  (10,'J', 'J@gmail.com');
    
select * from customer;

CREATE TABLE invoice (
    invoice_id INT UNIQUE,
    customer_id INT,
    invoice_date date,
    restaurant_id INT,
    PRIMARY KEY (invoice_id),
    FOREIGN KEY (customer_id)
    REFERENCES customer(customer_id),
    FOREIGN KEY (restaurant_id)
    REFERENCES restaurant(restaurant_id)
);

INSERT INTO invoice values
  (1, 1, '2022-01-01', 1),
  (2, 3, '2022-01-01', 2),
  (3, 2, '2022-01-02', 3),
  (4, 4, '2022-01-02', 4),
  (5, 5, '2022-01-03', 5),
  (6, 6, '2022-01-01', 6),
  (7, 7, '2022-01-01', 7),
  (8, 8, '2022-01-02', 8),
  (9, 9, '2022-01-02', 9),
  (10, 10, '2022-01-03', 10);
select * from invoice;

CREATE TABLE restaurant (
    restaurant_id INT UNIQUE,
    restaurant_branch text,
    PRIMARY KEY (restaurant_id)
);

INSERT INTO restaurant values
  (1, 'Bangkok'),
  (2,'Bangkok'),
  (3, 'Rayong'),
  (4, 'Phuket'),
  (5, 'Nan'),
  (6, 'Bangkok'),
  (7,'Bangkok'),
  (8, 'Rayong'),
  (9, 'Phuket'),
  (10, 'Nan');
select * from restaurant;

CREATE TABLE invoice_item (
    menu_id INT UNIQUE,
    invoice_id INT,
    price int,
    PRIMARY KEY (menu_id),
    FOREIGN KEY (invoice_id)
    REFERENCES invoice(invoice_id)
);

INSERT INTO invoice_item values
  (1, 2, 10),
  (2, 4, 20),
  (3, 5, 30),
  (4, 1, 40),
  (5, 3, 50),
  (6, 6, 10),
  (7, 7, 20),
  (8, 8, 30),
  (9, 10, 40),
  (10, 9, 50);

select * from invoice_item;

CREATE TABLE menu (
    menu_id INT,
    menu_name text,
    menu_type text,
    FOREIGN KEY (menu_id)
    REFERENCES invoice_item(menu_id)
);

INSERT INTO menu values
  (1, 'Salad', 'Appetizer'),
  (2, 'Salad', 'Appetizer'),
  (3, 'Pork Steak', 'Main Course'),
  (4, 'Soup', 'Soup'),
  (5, 'Fish Steak', 'Main Course'),
  (6, 'Salad', 'Appetizer'),
  (7, 'Salad', 'Appetizer'),
  (8, 'Pork Steak', 'Main Course'),
  (9, 'Soup', 'Soup'),
  (10, 'Fish Steak', 'Main Course');
select * from menu;