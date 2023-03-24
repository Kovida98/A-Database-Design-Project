-- create Technical_Staff table

DROP table if exists Produced_accident;
DROP table if exists Repair_accident;
DROP table if exists Accident;
drop table if exists Complaint_repair;
DROP table if exists Cust_complaint;
DROP table if exists Requested_repair;
DROP table if exists Repair;
DROP table if exists Complaint;
DROP table if exists Purchase;
DROP table if exists Customer;
DROP table if exists Product3_account;
drop table if exists Product2_account;
DROP table if exists Product1_account;
DROP table if exists Account;
DROP table if exists Product3;
DROP table if exists Product2;
DROP table if exists Product1;
DROP table if exists Product;
DROP table if exists Worker;
DROP table if exists Quality_Controller;
DROP table if exists Degree;
Drop table if exists Tech_Staff;



CREATE TABLE Tech_Staff (
    tech_name VARCHAR(40) NOT NULL ,
    tech_address VARCHAR(150),
    tech_salary real,
    tech_position VARCHAR(40),
    PRIMARY KEY(tech_name)
);

CREATE TABLE Degree(
    tech_name VARCHAR(40) NOT NULL,
    degree VARCHAR(10) ,
    PRIMARY KEY (tech_name,degree),
    FOREIGN KEY (tech_name) REFERENCES Tech_Staff(tech_name),
    CONSTRAINT CHK_degree CHECK(degree IN ('BS',  'MS',  'PhD')) 
);


CREATE TABLE Quality_Controller(
    qc_name VARCHAR(40) NOT NULL,
    qc_address VARCHAR(150),
    qc_salary real,
    type_of_Product VARCHAR(40) ,
    PRIMARY KEY(qc_name)
    
);


CREATE TABLE Worker(
    w_name VARCHAR(40) NOT NULL,
    w_address VARCHAR(150),
    w_salary real,
    count_of_Products INT,
    PRIMARY KEY(w_name)
);



CREATE TABLE Product(
    product_ID INT NOT NULL,
    produced_date DATE,
    making_time float,
    produced_person VARCHAR(40),
    tested_person VARCHAR(40),
    PRIMARY KEY(product_ID),
    FOREIGN KEY (produced_person) REFERENCES Worker(w_name),
    FOREIGN KEY (tested_person) REFERENCES Quality_Controller(qc_name)
   
);


CREATE TABLE Product1(
    product_ID INT NOT NULL,
    size VARCHAR(40) ,
    software_name VARCHAR(40),
    PRIMARY KEY(product_ID),
    FOREIGN KEY (product_ID) REFERENCES Product(product_ID)
);

CREATE TABLE Product2(
    product_ID INT NOT NULL,
    size VARCHAR(40),
    color VARCHAR(20),
    PRIMARY KEY(product_ID),
    FOREIGN KEY (product_ID) REFERENCES Product(product_ID)
);

CREATE TABLE product3(
    product_ID INT NOT NULL,
    size VARCHAR(40),
    p_weight FLOAT,
    PRIMARY KEY(product_ID),
    FOREIGN KEY (product_ID) REFERENCES Product(product_ID)
);

CREATE TABLE Account(
    account_number VARCHAR(40) NOT NULL,
    created_date DATE,
    cost REAL,
    PRIMARY KEY(account_number)
);

CREATE TABLE Product1_account(
    product_ID INT,
    account_number VARCHAR(40),
    PRIMARY KEY(product_ID),
    FOREIGN KEY(product_ID) REFERENCES Product1(product_ID),
    FOREIGN KEY(account_number) REFERENCES Account(account_number)
);

CREATE TABLE Product2_account(
    product_ID INT,
    account_number VARCHAR(40),
    PRIMARY KEY(product_ID),
    FOREIGN KEY(product_ID) REFERENCES Product2(product_ID),
    FOREIGN KEY(account_number) REFERENCES Account(account_number)
);
CREATE TABLE Product3_account(
    product_ID INT,
    account_number VARCHAR(40),
    PRIMARY KEY(product_ID),
    FOREIGN KEY(product_ID) REFERENCES Product3(product_ID),
    FOREIGN KEY(account_number) REFERENCES Account(account_number)
);

CREATE TABLE Customer(
    customer_name VARCHAR(40) NOT NULL,
    customer_address VARCHAR(150) ,
    PRIMARY KEY(customer_name)
);


CREATE TABLE Purchase(
    Product_ID INT NOT NULL,
    customer_name VARCHAR(40),
    PRIMARY KEY(Product_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(product_ID),
    FOREIGN KEY(customer_name) REFERENCES Customer(customer_name)
);


CREATE TABLE Complaint(
    complaint_id VARCHAR(40) NOT NULL,
    complaint_date DATE,
    comp_desc VARCHAR(150),
    treatment VARCHAR(20),
    PRIMARY KEY (complaint_id)
);

CREATE TABLE Accident(
    accident_number VARCHAR(10) NOT NULL,
    accident_date DATE,
    days_lost INT ,
    PRIMARY KEY(accident_number)
);


CREATE TABLE Repair(
    product_ID INT,
    tech_name VARCHAR(40),
    date_repaired Date,
    PRIMARY KEY (product_ID),
    FOREIGN KEY (product_ID) REFERENCES Product(product_ID),
    FOREIGN KEY (tech_name) REFERENCES Tech_Staff(tech_name)
);

CREATE TABLE  Requested_repair(
    product_ID INT,
    qc_name VARCHAR(40),
    PRIMARY KEY (product_ID,qc_name),
    FOREIGN KEY (product_ID) REFERENCES Repair(product_ID),
    FOREIGN KEY (qc_name) REFERENCES Quality_controller(qc_name)
);

CREATE TABLE Cust_complaint(
    Complaint_ID VARCHAR(40) ,
    Product_ID INT NOT NULL,
    PRIMARY KEY (Complaint_ID,product_ID),
    FOREIGN KEY (Complaint_ID) REFERENCES Complaint(Complaint_ID),
    FOREIGN KEY (Product_ID) REFERENCES Purchase(Product_ID)
    
);

CREATE TABLE Complaint_repair(
    complaint_ID VARCHAR(40),
    product_ID INT,
    PRIMARY KEY(complaint_ID,product_ID),
    FOREIGN KEY (complaint_ID) REFERENCES Complaint(complaint_ID),
    FOREIGN KEY (product_ID) REFERENCES Repair(product_ID)
);

CREATE TABLE Repair_accident(
    Product_ID INT,
    Accident_number VARCHAR(10),
    PRIMARY KEY(Product_ID),
    FOREIGN KEY (Product_ID) REFERENCES Repair(Product_ID),
    FOREIGN KEY (Accident_number) REFERENCES Accident(Accident_number)
    
);

CREATE TABLE Produced_accident(
    Product_ID INT,
    Accident_number VARCHAR(10) ,
    PRIMARY KEY (Product_ID),
    FOREIGN KEY (Accident_number) REFERENCES Accident(Accident_number),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
    
);
Drop INDEX sal1 ON Tech_Staff;
Drop Index sal2 On Quality_controller;
Drop Index sal3 On worker;

CREATE INDEX sal1 ON Tech_Staff(tech_salary);
CREATE INDEX sal2 ON Quality_Controller(qc_salary);
CREATE INDEX sal3 ON Worker(w_salary);
CREATE INDEX pp1 on product(produced_person);
CREATE Index pp2 on product2(color);
CREATE Index A1 on Accident(accident_date);
Create INDEX a1 on Repair_accident(accident_number);
Create INDEX a2 on produced_accident(accident_number);
