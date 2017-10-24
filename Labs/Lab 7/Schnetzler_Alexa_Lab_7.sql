--4.4
	DECLARE
	  lv_tax_num NUMBER(2,2);
	BEGIN
	 CASE  'NJ' 
	  WHEN 'VA' THEN lv_tax_num := .04;
	  WHEN 'NC' THEN lv_tax_num := .02;  
	  WHEN 'NY' THEN lv_tax_num := .06;  
	 END CASE;
	 DBMS_OUTPUT.PUT_LINE('tax rate = '||lv_tax_num);
	 EXCEPTION
		WHEN CASE_NOT_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('No tax'); 
	END;
--4.5
	DECLARE
	 rec_shopper bb_shopper%ROWTYPE;
	BEGIN
	 SELECT *
	  INTO rec_shopper
	  FROM bb_shopper
	  WHERE idShopper = 99;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Invalid Shopper Id');
	END;
--4.6
	ALTER TABLE bb_basketitem
	ADD CONSTRAINT bitems_qty_ck CHECK (quantity < 20);
	DECLARE
		ex_quantitiy EXCEPTION;
		PRAGMA EXCEPTION_INIT(ex_quantitiy, -02290);
	BEGIN
	  INSERT INTO bb_basketitem 
	   VALUES (88,8,10.8,21,16,2,3);
	EXCEPTION
		WHEN ex_quantitiy THEN
			DBMS_OUTPUT.PUT_LINE('Check quantitiy');
	END;
--4.7
	DECLARE
		ex_basket_update EXCEPTION;
	BEGIN
		UPDATE bb_basketitem
		SET idBasket = 4
		WHERE idBasket = 30;
		IF SQL%NOTFOUND THEN
			RAISE ex_basket_update;
		END IF;
		EXCEPTION
			WHEN ex_basket_update THEN
				DBMS_OUTPUT.PUT_LINE('Invalid basket ID entered');
	END;