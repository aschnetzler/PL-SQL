--7.1
	--Package CREATE
	create or replace PACKAGE order_info_pkg IS
	 FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2;
	 PROCEDURE basket_info_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE);
	END;
	--Body with error
	CREATE OR REPLACE PACKAGE BODY order_info_pkg IS
	 FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2
	  IS
	   lv_name_txt VARCHAR2(25);
	 BEGIN
	  SELECT shipfirstname||' '||shiplastname
	   INTO lv_name_txt
	   FROM bb_basket
	   WHERE idBasket = p_basket;
	  RETURN lv_name_txt;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END ship_name_pf;
	 PROCEDURE basket_inf_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE)
	  IS
	 BEGIN
	   SELECT idshopper, dtordered
		INTO p_shop, p_date
		FROM bb_basket
		WHERE idbasket = p_basket;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END basket_inf_pp;
	END;
	--Body no errors
	CREATE OR REPLACE PACKAGE BODY order_info_pkg IS
	 FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2
	  IS
	   lv_name_txt VARCHAR2(25);
	 BEGIN
	  SELECT shipfirstname||' '||shiplastname
	   INTO lv_name_txt
	   FROM bb_basket
	   WHERE idBasket = p_basket;
	  RETURN lv_name_txt;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END ship_name_pf;
	 PROCEDURE basket_info_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE)
	  IS
	 BEGIN
	   SELECT idshopper, dtordered
		INTO p_shop, p_date
		FROM bb_basket
		WHERE idbasket = p_basket;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END basket_info_pp;
	END;
--7.2
	--Package create
	CREATE OR REPLACE PACKAGE order_info_pkg IS
	 FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2;
	 PROCEDURE basket_info_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE);
	END;
	--Package Body
	CREATE OR REPLACE PACKAGE BODY order_info_pkg IS
	 FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2
	  IS
	   lv_name_txt VARCHAR2(25);
	 BEGIN
	  SELECT shipfirstname||' '||shiplastname
	   INTO lv_name_txt
	   FROM bb_basket
	   WHERE idBasket = p_basket;
	  RETURN lv_name_txt;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END ship_name_pf;
	 PROCEDURE basket_info_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE)
	  IS
	 BEGIN
	   SELECT idshopper, dtordered
		INTO p_shop, p_date
		FROM bb_basket
		WHERE idbasket = p_basket;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END basket_info_pp;
	END;
	--Anon block
	Declare
    lv_id NUMBER(5,3):= 12;
    lv_shop NUMBER(5,3);
    lv_date DATE;
    lv_name VARCHAR2(25);
	BEGIN
        lv_name := Order_info_PKG.ship_name_pf (lv_id);
        order_info_pkg.basket_info_pp(lv_id, lv_shop, lv_date);
        
        DBMS_OUTPUT.PUT_LINE('Name: ' || lv_name);
        DBMS_OUTPUT.PUT_LINE('Shop Number: ' ||lv_shop);
        DBMS_OUTPUT.PUT_LINE('Date: ' ||lv_date);
	END;
	--Select sql
	SELECT DISTINCT order_info_pkg.ship_name_pf(idbasket)
		FROM bb_Basket
        WHERE idbasket = 12;
--7.3
	--Package Create
	CREATE OR REPLACE PACKAGE order_info_pkg IS
	 PROCEDURE basket_info_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE,
	   p_name OUT VARCHAR2);
	END;
	--Package BODY
	CREATE OR REPLACE PACKAGE BODY order_info_pkg IS
	FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2;

	 PROCEDURE basket_info_pp
	  (p_basket IN NUMBER,
	   p_shop OUT NUMBER,
	   p_date OUT DATE,
	   p_name OUT VARCHAR2)
	  IS
	 BEGIN
	   SELECT idshopper, dtordered
		INTO p_shop, p_date
		FROM bb_basket
		WHERE idbasket = p_basket;
		p_name :=ship_name_pf(p_basket);
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END basket_info_pp;
	 
	 
	 FUNCTION ship_name_pf  
	   (p_basket IN NUMBER)
	   RETURN VARCHAR2
	  IS
	   lv_name_txt VARCHAR2(25);
	 BEGIN
	  SELECT shipfirstname||' '||shiplastname
	   INTO lv_name_txt
	   FROM bb_basket
	   WHERE idBasket = p_basket;
	  RETURN lv_name_txt;
	 EXCEPTION
	   WHEN NO_DATA_FOUND THEN
		 DBMS_OUTPUT.PUT_LINE('Invalid basket id');
	 END ship_name_pf;
	 
	END;
	--Anon Block
	Declare
    lv_id NUMBER(5,3):= 12;
    lv_shop NUMBER(5,3);
    lv_date DATE;
    lv_name Varchar(50);
	BEGIN
        ORDER_INFO_PKG.BASKET_INFO_PP(lv_id, lv_shop, lv_date, lv_name);
        
         DBMS_OUTPUT.PUT_LINE('Shopper ID: ' ||  lv_shop);
          DBMS_OUTPUT.PUT_LINE('Date: ' ||  lv_date);
        DBMS_OUTPUT.PUT_LINE('Name: ' ||  lv_name);
	END;
--7.5
	--Package Create
	CREATE OR REPLACE 
	PACKAGE SHOP_QUERY_PKG AS 
	PROCEDURE customer_search
	(p_id IN NUMBER,
	p_city OUT VARCHAR2,
	p_state OUT VARCHAR2,
	p_phone OUT VARCHAR2,
	p_email OUT VARCHAR2);
	PROCEDURE customer_search
	  (p_id IN VARCHAR2,
		p_city OUT VARCHAR2,
		p_state OUT VARCHAR2,
		p_phone OUT VARCHAR2,
		p_email OUT VARCHAR2);
	END SHOP_QUERY_PKG;
	--PACKAGE body
	CREATE OR REPLACE
	PACKAGE BODY SHOP_QUERY_PKG AS

	  PROCEDURE customer_search
	(p_id IN NUMBER,
	p_city OUT VARCHAR2,
	p_state OUT VARCHAR2,
	p_phone OUT VARCHAR2,
	p_email OUT VARCHAR2) AS
	  BEGIN
		SELECT city, state, phone, email
		INTO p_city, p_state, p_phone, p_email
		FROM bb_shopper
		WHERE p_id = idshopper;
	  END customer_search;

	  PROCEDURE customer_search
	  (p_id IN VARCHAR2,
		p_city OUT VARCHAR2,
		p_state OUT VARCHAR2,
		p_phone OUT VARCHAR2,
		p_email OUT VARCHAR2) AS
	  BEGIN
	  SELECT city, state, phone, email
		INTO p_city, p_state, p_phone, p_email
		FROM bb_shopper
		WHERE p_id = lastname;
	  END customer_search;

	END SHOP_QUERY_PKG;
	--Anon Block with id
	Declare
    lv_id NUMBER(5,3) := 23;
    lv_fname VARCHAR(50);
    lv_lname VARCHAR(50);
    lv_city Varchar(50);
    lv_state Varchar(50);
    lv_phone Varchar(50);
    lv_email Varchar(50);
	BEGIN
       SHOP_QUERY_PKG.customer_search(lv_id,lv_fname, lv_lname, lv_city, lv_state, lv_phone, lv_email);
        
        DBMS_OUTPUT.PUT_LINE('Name: ' ||  lv_fname || ' ' || lv_lname );
         DBMS_OUTPUT.PUT_LINE('City: ' ||  lv_city);
          DBMS_OUTPUT.PUT_LINE('State: ' ||  lv_state);
        DBMS_OUTPUT.PUT_LINE('Phone: ' ||  lv_phone);
         DBMS_OUTPUT.PUT_LINE('Email: ' ||  lv_email);
	END;
	--Anon block with lastname
	Declare
    lv_id VARCHAR2(50) := 'Ratman';
    lv_fname VARCHAR(50);
    lv_lname VARCHAR(50);
    lv_city Varchar(50);
    lv_state Varchar(50);
    lv_phone Varchar(50);
    lv_email Varchar(50);
	BEGIN
       SHOP_QUERY_PKG.customer_search(lv_id,lv_fname, lv_lname, lv_city, lv_state, lv_phone, lv_email);
        
        DBMS_OUTPUT.PUT_LINE('Name: ' ||  lv_fname || ' ' || lv_lname );
         DBMS_OUTPUT.PUT_LINE('City: ' ||  lv_city);
          DBMS_OUTPUT.PUT_LINE('State: ' ||  lv_state);
        DBMS_OUTPUT.PUT_LINE('Phone: ' ||  lv_phone);
         DBMS_OUTPUT.PUT_LINE('Email: ' ||  lv_email);
	END;
--7.7
	--Package CREATE
	create or replace PACKAGE TAX_RATE_PKG AS 
	PROCEDURE tax_calc_pf
	(p_state IN VARCHAR2, 
	p_amt OUT NUMBER);
	PRAGMA RESTRICT_REFERENCES(tax_calc_pf,WNPS);
	END TAX_RATE_PKG;
	--Package body
	CREATE OR REPLACE
	PACKAGE BODY TAX_RATE_PKG AS
	  PROCEDURE tax_calc_pf
	(p_state IN VARCHAR2,
	p_amt OUT NUMBER) 
	AS
	  BEGIN
		if p_state = 'NC' Then
		p_amt := .0365;
		elsif p_state = 'TX' Then 
		p_amt := .05;
		elsif p_state = 'TN' Then
		p_amt := .02;
		else
		p_amt :=0;
		End if;
	  END tax_calc_pf;

	END TAX_RATE_PKG;
	--Anon Block
	Declare
	lv_state Varchar2(25):= 'NC';
	lv_tax Number(5,3);
	BEGIN
	tax_rate_pkg.tax_calc_pf(lv_state, lv_tax);
	 DBMS_OUTPUT.PUT_LINE('The tax for ' || lv_state || ' is $' ||lv_tax);
	END;