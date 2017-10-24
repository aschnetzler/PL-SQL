--Hands on Practice 2-1
	DECLARE
		lv_test_date DATE := '10-DEC-12';
		lv_test_num CONSTANT NUMBER(3) := 10;
		lv_test_txt VARCHAR(10);
	BEGIN
		lv_test_txt := 'Schnetzler';
		DBMS_OUTPUT.PUT_LINE(lv_test_date);
		DBMS_OUTPUT.PUT_LINE(lv_test_num);
		DBMS_OUTPUT.PUT_LINE(lv_test_txt);
	END;
	
--Hands on Practice 2-3
	--Low rated customer
		DECLARE
			lv_cus_num NUMBER (3) := 100;
		BEGIN
			 IF lv_cus_num <= 100 THEN
				DBMS_OUTPUT.PUT_LINE('Low Rated Customer Info');
			 ELSIF lv_cus_num > 100 AND lv_cus_num < 200 THEN
				 DBMS_OUTPUT.PUT_LINE('Mid Rated Customer Info');
			 ELSE 
				 DBMS_OUTPUT.PUT_LINE('High Rated Customer Info');
			 End IF;
		END;
	--Mid Rated Customer
		DECLARE
			lv_cus_num NUMBER (3) := 150;
		BEGIN
			 IF lv_cus_num <= 150 THEN
				DBMS_OUTPUT.PUT_LINE('Low Rated Customer Info');
			 ELSIF lv_cus_num > 100 AND lv_cus_num < 200 THEN
				 DBMS_OUTPUT.PUT_LINE('Mid Rated Customer Info');
			 ELSE 
				 DBMS_OUTPUT.PUT_LINE('High Rated Customer Info');
			 End IF;
		END;
	--High Rated Customer
		DECLARE
			lv_cus_num NUMBER (3) := 250;
		BEGIN
			 IF lv_cus_num <= 150 THEN
				DBMS_OUTPUT.PUT_LINE('Low Rated Customer Info');
			 ELSIF lv_cus_num > 100 AND lv_cus_num < 200 THEN
				 DBMS_OUTPUT.PUT_LINE('Mid Rated Customer Info');
			 ELSE 
				 DBMS_OUTPUT.PUT_LINE('High Rated Customer Info');
			 End IF;
		END;
