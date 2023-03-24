drop PROCEDURE if exists q1;
GO 
CREATE PROCEDURE q1
    @emptype VARCHAR(40),
    @ename VARCHAR(40),
    @address VARCHAR(150),
    @salary real,
    @tech_position VARCHAR(40) ,
    @degree VARCHAR(10),
    @type_of_Product VARCHAR(40),
    @count_of_Products INT

AS 
BEGIN
    DECLARE @dupname int = 0
    set @dupname = (select count(name1) from (select tech_name as name1 from Tech_Staff UNION 
    select qc_name from Quality_Controller UNION select w_name from Worker) as temp where name1 = @ename )

    IF @dupname < 1
     BEGIN
    IF @emptype = 'Tech_staff'
    BEGIN
        INSERT into Tech_Staff VALUES (@ename,@address,@salary,@tech_position)
        INSERT into Degree VALUES (@ename,@degree)
    END

    IF @emptype = 'QC'
    BEGIN
        INSERT into Quality_Controller VALUES (@ename,@address,@salary,@type_of_Product)
    END

    IF @emptype = 'Worker'
    BEGIN
        INSERT into Worker VALUES (@ename,@address,@salary,@count_of_Products)
    END
    END

END



DROP PROCEDURE if EXISTS q2;
GO
CREATE PROCEDURE q2
    @protype int,
    @product_ID INT,
    @produced_date VARCHAR(40),
    @making_time float,
    @produced_person VARCHAR(40),
    @tested_person VARCHAR(40),
    @repaired_person VARCHAR(40),
    @date_repaired VARCHAR(40),
    @size VARCHAR(40) ,
    @software_name VARCHAR(40),
    @color VARCHAR(20),
    @p_weight FLOAT,
    @Req int

AS
BEGIN

INSERT INTO Product VALUES (@product_ID,cast(@produced_date as date),@making_time,@produced_person,@tested_person)

    IF @protype = 1
    BEGIN
        insert into Product1 values (@product_ID,@size,@software_name)
    END
    IF @protype = 2
    BEGIN
        insert into Product2 values (@product_ID,@size,@color)
    END
    IF @protype = 3
    BEGIN
     insert into Product3 values (@product_ID,@size,@p_weight)
    END

    IF @Req = 1
    BEGIN
        insert into Repair values (@product_ID,@repaired_person,@date_repaired)
        insert into Requested_repair values (@product_ID,@tested_person)
    END
END


DROP PROCEDURE if EXISTS q3;
GO
CREATE PROCEDURE q3
    @customer_name VARCHAR(40),
    @customer_address VARCHAR(150) ,
    @Product_ID INT 

AS 
BEGIN
    DECLARE @dupcustname int = 0
    set @dupcustname = (select count(customer_name)  from Customer where customer_name=@customer_name) 
    
    if @dupcustname <1
    BEGIN
        INSERT INTO customer VALUES(@customer_name,@customer_address);
        INSERT INTO Purchase VALUES(@Product_ID,@customer_name);
    END
    IF @dupcustname >=1
    BEGIN
        INSERT INTO Purchase VALUES(@Product_ID,@customer_name);
    END
END
    

DROP PROCEDURE if EXISTS q4;
GO
CREATE PROCEDURE q4
    @account_number VARCHAR(40),
    @created_date VARCHAR(40),
    @cost REAL,
    @product_ID INT,
    @ptype INT

AS
BEGIN

IF @ptype=1
    BEGIN
        INSERT INTO Account VALUES(@account_number,cast(@created_date as date),@cost);
        INSERT INTO Product1_account VALUES(@product_ID, @account_number);
    END

IF @ptype=2
    BEGIN
        INSERT INTO Account VALUES(@account_number,cast(@created_date as date),@cost);
        INSERT INTO Product2_account VALUES(@product_ID, @account_number);
    END
IF @ptype=3
    BEGIN
        INSERT INTO Account VALUES(@account_number,cast(@created_date as date),@cost);
        INSERT INTO Product3_account VALUES(@product_ID, @account_number);
    END
END


DROP PROCEDURE if EXISTS q5;
GO
CREATE PROCEDURE q5
    @complaint_id VARCHAR(40),
    @complaint_date VARCHAR(40),
    @comp_desc VARCHAR(150),
    @treatment VARCHAR(20),
    @Product_ID INT ,
    @repreq INT,
    @techname VARCHAR(40),
    @date_repaired VARCHAR(40)
AS
BEGIN

INSERT INTO Complaint VALUES(@complaint_id,cast(@complaint_date as date),@comp_desc,@treatment);
INSERT INTO Cust_complaint VALUES(@complaint_id,@Product_ID);
IF @repreq =1
    BEGIN
        INSERT INTO Repair VALUES(@Product_ID,@techname,cast(@date_repaired as date));
        INSERT INTO Complaint_repair VALUES (@complaint_id,@Product_ID);
    END
END

DROP PROCEDURE if EXISTS q6;
GO
CREATE PROCEDURE q6
    @accident_number VARCHAR(10) ,
    @accident_date VARCHAR(40),
    @days_lost INT ,
    @Product_ID INT,
    @accitype VARCHAR(10)
AS
BEGIN

IF @accitype = 'type1'
    BEGIN
        INSERT INTO Accident VALUES (@accident_number,cast(@accident_date as date),@days_lost);
        INSERT INTO Produced_accident VALUES(@Product_ID,@accident_number);
    END
IF @accitype = 'type2'
    BEGIN
        INSERT INTO Accident VALUES (@accident_number,cast(@accident_date as date),@days_lost);
        INSERT INTO Repair_accident VALUES(@Product_ID,@accident_number);
    END
END

DROP PROCEDURE if EXISTS q7;

GO
CREATE PROCEDURE q7
    @product_id INT
AS
BEGIN

select produced_date,making_time from Product
where product_ID = @product_id;

END


DROP PROCEDURE if EXISTS q8;
GO
CREATE PROCEDURE q8
    @produced_person VARCHAR(40)   
AS
BEGIN
    SELECT product_ID from Product where produced_person=@produced_person;
END



DROP PROCEDURE if EXISTS q9;
GO
CREATE PROCEDURE q9
    @tested_person VARCHAR(40)

AS
BEGIN
    select count(tested_person) as errors from (SELECT tested_person from Product p 
    INNER JOIN Complaint_repair cr on p.product_ID=cr.product_ID) as temp where tested_person = @tested_person;

END


DROP PROCEDURE if EXISTS q10;
GO
CREATE PROCEDURE q10
    @qc_name VARCHAR(40)

AS
BEGIN
    
    select sum(a.cost) as total_cost from Requested_repair rr 
    INNER JOIN Product3_account p3 on rr.product_ID=p3.product_ID 
    INNER JOIN Account a on p3.account_number=a.account_number 
    WHERE rr.qc_name = @qc_name;


END

DROP PROCEDURE if EXISTS q11;
GO
CREATE PROCEDURE q11
    @color VARCHAR(20)
AS
BEGIN
    SELECT p.customer_name from Purchase p , Product2 p2 
    WHERE  p.product_ID = p2.product_ID AND p2.color=@color 
    ORDER BY p.customer_name;
END

DROP PROCEDURE if EXISTS q12;
GO
CREATE PROCEDURE q12
    @salary real

AS
BEGIN
    SELECT tech_name as employee_name,tech_salary as salary,tech_address as address from Tech_Staff where tech_salary>@salary  UNION 
    SELECT qc_name as employee_name,qc_salary as salary ,qc_address as address from Quality_Controller where qc_salary>@salary  UNION 
    SELECT w_name as employee_name, w_salary as salary,w_address as address from Worker WHERE w_salary > @salary;
    
END

DROP PROCEDURE if EXISTS q13;
GO
CREATE PROCEDURE q13
    
AS
BEGIN

    SELECT sum(a.days_lost) as total_days_lost from Accident a , Repair_accident ra , Complaint_repair cr 
    WHERE a. accident_number=ra.Accident_number AND ra.Product_ID=cr.product_ID;
END

DROP PROCEDURE if EXISTS q14;
GO
CREATE PROCEDURE q14
    @year INT
AS
BEGIN

    SELECT avg(temp.cost) as avg_cost from 
    (SELECT  a.cost,p.produced_date from Product1_account p1 
    INNER JOIN Account a on p1.account_number=a.account_number 
    INNER JOIN Product as p on p1.product_ID=p.product_ID 
    WHERE YEAR(p.produced_date)=@year UNION 
    SELECT a.cost,p.produced_date from Product2_account as p2 
    INNER JOIN Account a on p2.account_number= a.account_number 
    INNER JOIN Product as p on p2.product_ID=p.product_ID 
    WHERE YEAR(p.produced_date)=@year UNION
    SELECT a.cost,p.produced_date from Product3_account as p3 
    INNER JOIN Account a on p3.account_number= a.account_number 
    INNER JOIN Product as p on p3.product_ID=p.product_ID 
    WHERE YEAR(p.produced_date)=@year) as temp
END

DROP PROCEDURE if EXISTS q15;
GO
CREATE PROCEDURE q15
    @date1 DATE,
    @date2 DATE
AS
BEGIN

    DELETE produced_accident FROM (SELECT accident_number from Accident WHERE accident_date BETWEEN @date1 AND @date2) as temp 
    WHERE Produced_accident.Accident_number=temp.accident_number;
    DELETE Repair_accident FROM (SELECT accident_number from Accident WHERE accident_date BETWEEN @date1 AND @date2) as temp 
    WHERE Repair_accident.Accident_number=temp.accident_number;
    DELETE from Accident  WHERE accident_date BETWEEN @date1 AND @date2;

END

GO
EXEC q1  @emptype  = 'Tech_staff', @ename = 'Ela', @address = 'ajo',@salary = 1000,@tech_position = 'lead', @degree = 'BS', @type_of_product = NULL, @count_of_Products =  NULL;							
EXEC q1  @emptype  = 'Tech_staff', @ename = 'anna', @address = 'avondale',@salary = 2000,@tech_position = 'manager',@degree = 'MS', @type_of_product = null, @count_of_products =  NULL;
EXEC q1  @emptype  = 'Tech_staff', @ename = 'olaf', @address = 'bisbee',@salary = 3000,@tech_position = 'engineer',@degree = 'PhD', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'kristoff', @address = 'casa grande',@salary = 40000,@tech_position = 'lead',@degree = 'BS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'hans', @address = 'chandler',@salary = 50000,@tech_position = 'engineer',@degree = 'MS', @type_of_product = null, @count_of_products =  NULL;
EXEC q1  @emptype  = 'Tech_staff', @ename = 'oaken', @address = 'clifton',@salary = 10000,@tech_position = 'siftware  developer',@degree = 'PhD', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'iduna', @address = 'florence',@salary = 500000,@tech_position = 'sales engineer',@degree = 'BS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'duke ', @address = 'gila bend',@salary = 900,@tech_position = 'IT manager',@degree = 'MS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'pabble', @address = 'glendale',@salary = 300000,@tech_position = 'data scientist',@degree = 'PhD', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'Bulda', @address = 'globe',@salary = 500000,@tech_position = 'web developer',@degree = 'BS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'agnarr', @address = 'kingman',@salary = 5876000,@tech_position = 'sales engineer',@degree = 'MS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'dignitary', @address = 'lake havasu city',@salary = 234900,@tech_position = 'lead',@degree = 'PhD', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'gerda', @address = 'mesa',@salary = 123600,@tech_position = 'engineer',@degree = 'BS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'sven', @address = 'nogales',@salary = 1234,@tech_position = 'manager',@degree = 'MS', @type_of_product = null, @count_of_products =  NULL;	
EXEC q1  @emptype  = 'Tech_staff', @ename = 'marshmallow', @address = 'oraibi',@salary = 5678,@tech_position = 'web developer',@degree = 'PhD', @type_of_product = null, @count_of_products =  NULL;	

SELECT * from Tech_staff;
SELECT * from degree;


EXEC q1  @emptype  = 'QC', @ename = 'rapunzel', @address = 'phoenix',@salary = 9876,@tech_position = null,@degree = null, @type_of_product = 'AC', @count_of_products =  NULL;					
EXEC q1  @emptype  = 'QC', @ename = 'flynn', @address = 'prescott',@salary = 5432,@tech_position = null,@degree = null, @type_of_product = 'TV', @count_of_products =  NULL;						
EXEC q1  @emptype  = 'QC', @ename = 'rider', @address = 'temple',@salary = 1982,@tech_position = null,@degree = null, @type_of_product = 'fridge', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'gothel', @address = 'tucson',@salary = 198300,@tech_position = null,@degree = null, @type_of_product = 'AC', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'thug', @address = 'winslow',@salary = 18945,@tech_position = null,@degree = null, @type_of_product = 'TV', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'rufian', @address = 'yuma',@salary = 356782,@tech_position = null,@degree = null, @type_of_product = 'fridge', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'timothy', @address = 'california',@salary = 2000,@tech_position = null,@degree = null, @type_of_product = 'AC', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'rajtur', @address = 'huntington beach',@salary = 4000,@tech_position = null,@degree = null, @type_of_product = 'TV', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'vlad', @address = 'los angeles',@salary = 6000,@tech_position = null,@degree = null, @type_of_product = 'fridge', @count_of_products =  NULL;						
EXEC q1  @emptype  = 'QC', @ename = 'bill', @address = 'mountain view',@salary = 9000,@tech_position = null,@degree = null, @type_of_product = 'AC', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'mcknight', @address = 'oroville',@salary = 8000,@tech_position = null,@degree = null, @type_of_product = 'TV', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'simba', @address = 'roseville',@salary = 5000,@tech_position = null,@degree = null, @type_of_product = 'fridge', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'mufasa', @address = 'san francisco',@salary = 3000,@tech_position = null,@degree = null, @type_of_product = 'AC', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'scar', @address = 'colorado',@salary = 73620,@tech_position = null,@degree = null, @type_of_product = 'TV', @count_of_products =  NULL;						
EXEC q1  @emptype  = 'QC', @ename = 'nala', @address = 'canon city',@salary = 22400,@tech_position = null,@degree = null, @type_of_product = 'fridge', @count_of_products =  NULL;							
EXEC q1  @emptype  = 'QC', @ename = 'timon', @address = 'brighton',@salary = 57900,@tech_position = null,@degree = null, @type_of_product = 'AC', @count_of_products =  NULL;						

SELECT * from Quality_Controller;

EXEC q1  @emptype  = 'Worker', @ename = 'zazu', @address = 'claremore',@salary = 1100,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  8;
EXEC q1  @emptype  = 'Worker', @ename = 'rafiki', @address = 'edmond',@salary = 1200,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  6;
EXEC q1  @emptype  = 'Worker', @ename = 'pumba', @address = 'el reno',@salary = 1300,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  15;
EXEC q1  @emptype  = 'Worker', @ename = 'sarabi', @address = 'chickasha',@salary = 1400,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  13;
EXEC q1  @emptype  = 'Worker', @ename = 'shenzi', @address = 'alva',@salary = 1500,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  10;
EXEC q1  @emptype  = 'Worker', @ename = 'ed', @address = 'enid',@salary = 1600,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  5;
EXEC q1  @emptype  = 'Worker', @ename = 'banzai', @address = 'elk city',@salary = 1700,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  3;
EXEC q1  @emptype  = 'Worker', @ename = 'sarafina', @address = 'hobart',@salary = 1800,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  9;
EXEC q1  @emptype  = 'Worker', @ename = 'hyena', @address = 'midwest city',@salary = 1900,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  0;
EXEC q1  @emptype  = 'Worker', @ename = 'belle', @address = 'Moore',@salary = 2000,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  2;
EXEC q1  @emptype  = 'Worker', @ename = 'adam', @address = 'norman',@salary = 2100,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  4;
EXEC q1  @emptype  = 'Worker', @ename = 'gaston', @address = 'oklahoma city',@salary = 2200,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  7;
EXEC q1  @emptype  = 'Worker', @ename = 'lefou', @address = 'pauls valley',@salary = 2300,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  11;
EXEC q1  @emptype  = 'Worker', @ename = 'cadenza', @address = 'miami',@salary = 2400,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  10;
EXEC q1  @emptype  = 'Worker', @ename = 'maurice', @address = 'lawton',@salary = 2500,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  19;
EXEC q1  @emptype  = 'Worker', @ename = 'jam', @address = 'ponca city',@salary = 2600,@tech_position = null,@degree = null, @type_of_product = null, @count_of_products =  2;


select * from worker;

GO
EXEC q2  @protype  = 1, @product_ID = 9, @produced_date = '2021-05-01',@making_time = 2,@produced_person = 'gaston',@tested_person= 'simba', @repaired_person = 'agnarr', @date_repaired =  '2021-05-30', @size = 'small', @software_name = 'adobe', @color = NULL, @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 1, @product_ID = 8, @produced_date = '2021-06-02',@making_time = 3,@produced_person = 'lefou',@tested_person= 'mufasa', @repaired_person = NULL, @date_repaired =  NULL, @size = 'large', @software_name = 'cubase', @color = NULL, @p_weight= NULL, @req = NULL;
EXEC q2  @protype  = 1, @product_ID = 7, @produced_date = '2021-07-03',@making_time = 4,@produced_person = 'cadenza',@tested_person= 'scar', @repaired_person = 'gerda', @date_repaired =  '2021-07-30', @size = 'medium', @software_name = 'diablo', @color = NULL, @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 1, @product_ID = 6, @produced_date = '2021-08-04',@making_time = 5,@produced_person = 'maurice',@tested_person= 'nala', @repaired_person = NULL, @date_repaired =  NULL, @size = 'small', @software_name = 'excel', @color = NULL, @p_weight= NULL, @req = NULL;
EXEC q2  @protype  = 2, @product_ID = 5, @produced_date = '2021-09-05',@making_time = 6,@produced_person = 'jam',@tested_person= 'timon', @repaired_person = 'marshmallow', @date_repaired =  '2021-09-30', @size = 'medium', @software_name = NULL, @color = 'red', @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 2, @product_ID = 4, @produced_date = '2021-10-06',@making_time = 7,@produced_person = 'ed',@tested_person= 'rufian', @repaired_person = 'Ela', @date_repaired =  '2021-10-30', @size = 'large', @software_name = NULL, @color = 'red', @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 2, @product_ID = 3, @produced_date = '2021-11-07',@making_time = 8,@produced_person = 'banzai',@tested_person= 'timothy', @repaired_person = NULL, @date_repaired =  NULL, @size = 'meduim', @software_name = NULL, @color = 'black', @p_weight= NULL, @req = NULL;
EXEC q2  @protype  = 2, @product_ID = 2, @produced_date = '2021-12-08',@making_time = 9,@produced_person = 'sarafina',@tested_person= 'rajtur', @repaired_person = 'olaf', @date_repaired =  '2021-12-30', @size = 'small', @software_name = NULL, @color = 'white', @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 2, @product_ID = 1, @produced_date = '2021-01-09',@making_time = 1,@produced_person = 'hyena',@tested_person= 'vlad', @repaired_person = NULL, @date_repaired =  NULL, @size = 'medium', @software_name = NULL, @color = 'red', @p_weight= NULL, @req = NULL;
EXEC q2  @protype  = 2, @product_ID = 10, @produced_date = '2021-02-10',@making_time = 4,@produced_person = 'belle',@tested_person= 'bill', @repaired_person = 'anna', @date_repaired =  '2021-02-28', @size = 'small', @software_name = NULL, @color = 'white', @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 2, @product_ID = 11, @produced_date = '2021-03-11',@making_time = 6,@produced_person = 'adam',@tested_person= 'mcknight', @repaired_person = 'kristoff', @date_repaired =  '2021-03-30', @size = 'large', @software_name = NULL, @color = 'black', @p_weight= NULL, @req = 1;
EXEC q2  @protype  = 3, @product_ID = 12, @produced_date = '2022-01-01',@making_time = 7,@produced_person = 'rafiki',@tested_person= 'flynn', @repaired_person = NULL, @date_repaired =  NULL, @size = 'small', @software_name = NULL, @color = NULL, @p_weight= 10, @req = NULL;
EXEC q2  @protype  = 3, @product_ID = 13, @produced_date = '2021-09-02',@making_time = 2,@produced_person = 'pumba',@tested_person= 'rider', @repaired_person = 'dignitary', @date_repaired =  '2021-09-30', @size = 'medium', @software_name = NULL, @color = NULL, @p_weight= 34, @req = 1;
EXEC q2  @protype  = 3, @product_ID = 14, @produced_date = '2022-02-01',@making_time = 4,@produced_person = 'sarabi',@tested_person= 'gothel', @repaired_person = 'sven', @date_repaired =  '2022-02-28', @size = 'large', @software_name = NULL, @color = NULL, @p_weight= 56, @req = 1;
EXEC q2  @protype  = 3, @product_ID = 15, @produced_date = '2022-03-04',@making_time = 9,@produced_person = 'shenzi',@tested_person= 'thug', @repaired_person = 'agnarr', @date_repaired =  '2022-03-30', @size = 'medium', @software_name = NULL, @color = NULL, @p_weight= 12, @req = 1;



delete requested_repair
delete repair
delete product1;
delete product2;
delete product3;
delete product;

SELECT * from requested_repair;
SELECT * from repair;
SELECT * from product1;
SELECT * from product2;
SELECT * FROM product3;
SELECT * from product;

GO
EXEC q3  @customer_name  = 'king', @customer_address = 'lindsey street', @product_ID = 9;
EXEC q3  @customer_name  = 'kai', @customer_address = '12th ave', @product_ID = 8;
EXEC q3  @customer_name  = 'raj', @customer_address = 'beaumont drive', @product_ID = 7;
EXEC q3  @customer_name  = 'avi', @customer_address = 'south jenkins', @product_ID = 6;
EXEC q3  @customer_name  = 'lyle', @customer_address = 'california', @product_ID = 5;
EXEC q3  @customer_name  = 'emmett', @customer_address = 'texas', @product_ID = 4;
EXEC q3  @customer_name  = 'tristian', @customer_address = 'arizona', @product_ID = 3;
EXEC q3  @customer_name  = 'zayd', @customer_address = 'georgia', @product_ID = 2;
EXEC q3  @customer_name  = 'wells', @customer_address = 'virginia', @product_ID = 1;
EXEC q3  @customer_name  = 'lakshmi', @customer_address = 'newyork', @product_ID = 10;
EXEC q3  @customer_name  = 'rupa', @customer_address = 'los angeles', @product_ID = 11;
EXEC q3  @customer_name  = 'devi', @customer_address = 'singapore', @product_ID = 12;
EXEC q3  @customer_name  = 'janu', @customer_address = 'nepal', @product_ID = 13;
EXEC q3  @customer_name  = 'harsha', @customer_address = 'china', @product_ID = 14;
EXEC q3  @customer_name  = 'goutham', @customer_address = 'india', @product_ID = 15;


SELECT * from customer;
SELECT * from purchase;

delete purchase;
delete customer


GO
EXEC q4  @account_number  = 'A2001', @created_date = '2021-05-01', @cost = 2000,@product_ID = 9,@ptype = 1;				
EXEC q4  @account_number  = 'A2002', @created_date = '2021-06-02', @cost = 2100,@product_ID = 8,@ptype = 1;				
EXEC q4  @account_number  = 'A2003', @created_date = '2021-07-03', @cost = 2200,@product_ID = 7,@ptype = 1;				
EXEC q4  @account_number  = 'A2004', @created_date = '2021-08-04', @cost = 4000,@product_ID = 6,@ptype = 1;				
EXEC q4  @account_number  = 'A2005', @created_date = '2021-09-05', @cost = 4500,@product_ID = 5,@ptype = 2;				
EXEC q4  @account_number  = 'A2006', @created_date = '2021-10-06', @cost = 2000,@product_ID = 4,@ptype = 2;				
EXEC q4  @account_number  = 'A2007', @created_date = '2021-11-07', @cost = 1500,@product_ID = 3,@ptype = 2;				
EXEC q4  @account_number  = 'A2008', @created_date = '2021-12-08', @cost = 700,@product_ID = 2,@ptype = 2;				
EXEC q4  @account_number  = 'A2009', @created_date = '2021-01-09', @cost = 4400,@product_ID = 1,@ptype = 2;				
EXEC q4  @account_number  = 'A2010', @created_date = '2021-02-10', @cost = 9888,@product_ID = 10,@ptype = 2;				
EXEC q4  @account_number  = 'A2011', @created_date = '2021-03-11', @cost = 2300,@product_ID = 11,@ptype = 2;				
EXEC q4  @account_number  = 'A2012', @created_date = '2022-01-01', @cost = 3500,@product_ID = 12,@ptype = 3;				
EXEC q4  @account_number  = 'A2013', @created_date = '2021-09-02', @cost = 4550,@product_ID = 13,@ptype = 3;				
EXEC q4  @account_number  = 'A2014', @created_date = '2022-02-01', @cost = 7689,@product_ID = 14,@ptype = 3;				
EXEC q4  @account_number  = 'A2015', @created_date = '2022-03-04', @cost = 1098,@product_ID = 15,@ptype = 3;				

SELECT * FROM account;
SELECT * FROM Product1_account;
SELECT * FROM Product2_account;
SELECT * FROM Product3_account;



EXEC q5  @complaint_ID = 'C1000', @complaint_date = '2021-05-28', @comp_desc = 'not working',@treatment = 'need repair',@product_ID = 8, @repreq = 1, @techname =  'hans', @date_repaired = '2021-05-30';
EXEC q5  @complaint_ID = 'C3000', @complaint_date = '2022-10-03', @comp_desc = 'display not working',@treatment = 'exchange',@product_ID = 3,@repreq = 1, @techname =  'oaken', @date_repaired = '2022-11-01';
EXEC q5  @complaint_ID = 'C4000', @complaint_date = '2021-02-14', @comp_desc = 'servicing',@treatment = 'cleaning',@product_ID = 6, @repreq = 1, @techname =  'iduna', @date_repaired = '2021-02-28';

select * from complaint;
select * from cust_complaint;
select * from repair;
select * from complaint_repair;

EXEC q6  @accident_number  = 'ACC100', @accident_date = '2021-05-30', @days_lost = 2,@product_ID = 9,@accitype = 'type2';
EXEC q6  @accident_number  = 'ACC110', @accident_date = '2022-02-01', @days_lost = 3,@product_ID = 14,@accitype = 'type1';
EXEC q6  @accident_number  = 'ACC120', @accident_date = '2021-01-09', @days_lost = 5,@product_ID = 1,@accitype = 'type1';
EXEC q6  @accident_number  = 'ACC130', @accident_date = '2021-03-30', @days_lost = 9,@product_ID = 11,@accitype = 'type2';
EXEC q6  @accident_number  = 'ACC140', @accident_date = '2021-10-30', @days_lost = 4,@product_ID = 4,@accitype = 'type2';

SELECT * from accident;
select * from produced_accident;
select * from repair_accident;



EXEC q7 @product_id = 14;
EXEC q7 @product_id = 9;
EXEC q7 @product_id = 12;

EXEC q8 @produced_person = 'belle';
EXEC q8 @produced_person = 'jam';
EXEC q8 @produced_person = 'adam';

EXEC q9 @tested_person = 'mufasa';
EXEC q9 @tested_person = 'timothy';
EXEC q9 @tested_person = 'timon';
EXEC q9 @tested_person = 'nala';

EXEC q10 @qc_name = 'rider';
EXEC q10 @qc_name = 'gothel';
EXEC q10 @qc_name = 'thug';

EXEC q11 @color='red';
EXEC q11 @color='black';
EXEC q11 @color='white';

EXEC q12 @salary = 20000;

EXEC q13;

EXEC q14 @year = 2022;

EXEC q15 @date1='2021-05-30',@date2='2022-02-01';

select * from accident
SELECT * from produced_accident
SELECT * from repair_accident