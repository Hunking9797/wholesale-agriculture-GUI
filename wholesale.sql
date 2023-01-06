use agriculture;
create table crop(
	crop_name varchar(100) PRIMARY KEY,
    crop_type varchar(100) not null,
    crop_desc varchar(100) not null,
    exp_date date not null
);

create table supplier(
	sup_name varchar(100) not null,
    s_id int primary key,
    commission varchar(25) not null,
    phone varchar(100) not null,
    email varchar(100) not null
);

create table farmer(
	farmer_name varchar(100) not null,
    f_id int primary key,
    age int not null,
    phone varchar(100) not null
);

create table warehouse(
	w_id int primary key,
    address varchar(100) not null,
    max_capacity varchar(100) not null,
    present_storage varchar(100) not null
);

create table payment(
	p_id int primary key,
    amount varchar(100) not null,
    discount varchar(100) not null,
    tax varchar(100) not null,
    mode_of_payment varchar(100) not null,
    cust_id int not null,
    FOREIGN KEY(cust_id) REFERENCES customer(c_id)
);


create table orders(
	o_id int primary key,
    order_date date not null,
    due_date date not null,
    delivery_loc varchar(100),
    cust_id int not null,
    FOREIGN KEY(cust_id) REFERENCES CUSTOMER(c_id)
);

create table customer(
	name varchar(100) not null,
    c_id int PRIMARY KEY,
    age int not null,
    address varchar(100) not null,
    phone varchar(100) not null,
    email varchar(100) not null
);


create table stocks_in(
	s_id int not null,
    w_id int not null,
    PRIMARY KEY(s_id, w_id),
    FOREIGN KEY(s_id) REFERENCES supplier(s_id),
    FOREIGN KEY(w_id) REFERENCES warehouse(w_id)
);

create table supplies_to(
	s_id int not null,
    f_id int not null,
    PRIMARY KEY(s_id, f_id),
    FOREIGN KEY(s_id) REFERENCES supplier(s_id),
    FOREIGN KEY(f_id) REFERENCES farmer(f_id)
);

create table gets(
	crop_name varchar(100) not null,
    o_id int not null,
    quantity int not null,
    PRIMARY KEY(crop_name, o_id),
    FOREIGN KEY(crop_name) REFERENCES crop(crop_name),
    FOREIGN KEY(o_id) REFERENCES orders(o_id)
);

create table supply(
	f_id int not null,
    crop_name varchar(100) not null,
    PRIMARY KEY(f_id, crop_name),
    FOREIGN KEY(f_id) REFERENCES farmer(f_id),
    FOREIGN KEY(crop_name) REFERENCES crop(crop_name)
);


-- 1. find the name of customer who have paid through CREDIT card
select name from customer c, payment p
where c.c_id = p.cust_id 
and mode_of_payment like '%CREDIT%';


-- 2. List all the name of customer whose order due date is between 2002-09-03 to 2002-11-10
select name from customer c, orders o
where c.c_id = o.cust_id 
and (due_date < '2002-11-10' and due_date > '2002-09-03');

-- 3. Select name of all farmer whose age is greater than 25;
select farmer_name from farmer
where age > 25;

-- 4. Find out available storage in warehouse
select address, (max_capacity - present_storage) AS available_storage from warehouse;

-- 5. Details of farmer whose supplier takes commission is 8% on crop
select farmer_name from farmer f, supplies_to st, supplier s
where f.f_id = st.f_id and st.s_id = s.s_id and s.commission = 8;
