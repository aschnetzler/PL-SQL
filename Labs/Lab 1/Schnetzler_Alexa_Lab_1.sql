-- QUESTION 2
	SELECT IDPRODUCT, PRODUCTNAME,PRICE,ACTIVE,TYPE,IDDEPARTMENT,STOCK
	FROM BB_PRODUCT;

-- QUESTION 3
	SELECT idShopper, b.idBasket, b.orderplaced, b.dtordered, b.dtcreated
	FROM BB_Shopper s INNER JOIN BB_Basket b
	USING (idShopper);

-- QUESTION 4
	SELECT idProduct, p.productname, pc.categoryname, pd.optionname
	FROM BB_Product p INNER JOIN BB_productoption
	USING (idProduct)
	INNER JOIN BB_productoptiondetail pd
	USING(idOption)
	INNER JOIN BB_productoptioncategory pc
	USING(idOptioncategory);

-- QUESTION 1
	SELECT DISTINCT IDPRODUCT 
	FROM BB_BASKETITEM 
	ORDER BY IDPRODUCT;

-- QUESTION 2
	--ANSI Join
		SELECT pr.IDPRODUCT, bas.IDBASKET, pr.PRODUCTNAME, pr.DESCRIPTION
		FROM BB_PRODUCT pr, BB_BASKET bas
		WHERE pr.ordered IS NOT NULL;
	
	--Traditional Join
		SELECT IDPRODUCT, bas.IDBASKET, pr.PRODUCTNAME,pr.DESCRIPTION
		FROM BB_PRODUCT pr JOIN BB_BASKETITEM bas USING (IDPRODUCT)
		WHERE pr.ordered IS NOT NULL;
	

-- QUESTION 3
	--ANSI Join
		SELECT pr.IDPRODUCT, bas.IDBASKET, pr.PRODUCTNAME, pr.DESCRIPTION, sh.LASTNAME
		FROM BB_PRODUCT pr, BB_BASKET bas, BB_SHOPPER sh
		WHERE pr.ordered IS NOT NULL;

	--Traditional Join
		SELECT IDPRODUCT, IDBASKET, PRODUCTNAME,pr.DESCRIPTION, sh.LASTNAME
		FROM BB_PRODUCT pr 
		JOIN BB_BASKETITEM bas USING (IDPRODUCT) 
		JOIN BB_BASKET bask USING (IDBASKET)
		JOIN BB_SHOPPER sh USING (IDSHOPPER)
		WHERE pr.ordered IS NOT NULL;
-- QUESTION 4
	SELECT bas.IDBASKET, sh.IDSHOPPER, to_char(bas.dtordered, 'Month DD, yyyy')
	FROM BB_BASKET bas, BB_SHOPPER sh
	WHERE bas.dtordered LIKE '%-FEB-12';


-- QUESTION 5
	Select idproduct
	from bb_basketitem
	GROUP BY idproduct;


-- QUESTION 6
	Select idproduct
	from bb_basketitem
	WHERE idproduct < 3
	GROUP BY idproduct;

-- QUESTION 7
	SELECT IDPRODUCT, productname, price 
	FROM BB_Product
	WHERE price > (select avg(price) from bb_product);


-- QUESTION 8
	CREATE table CONTACTS
		(
			con_id NUMBER(4) PRIMARY KEY,
			company_name VARCHAR2(30) NOT NULL,
			email VARCHAR2(30),
			last_date DATE DEFAULT SYSDATE,
			con_cnt NUMBER(3)
			CHECK (con_cnt > 0)
		);


-- QUESTION 9
	INSERT INTO CONTACTS
	values(1234, 'Company Name', 'company@name.com','07-JUL-16', 1 );
	INSERT INTO CONTACTS
	values(4656, 'Company Name 2', 'company2@name.com',DEFAULT, 2 );
	COMMIT;
-- QUESTION 10
	UPDATE CONTACTS set email='company@gmail.com'
	WHERE con_id='1234';
	select * from CONTACTS;
	ROLLBACK;