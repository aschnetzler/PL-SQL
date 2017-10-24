--3.6
	--Basket id 5
		DECLARE 
			lv_shipping_num NUMBER(6,2); 
			lv_quantity_num bb_basket.quantity%type;
		BEGIN 
			SELECT quantity
			INTO lv_quantity_num 
			FROM BB_BASKET 
			WHERE idbasket=5;
			IF lv_quantity_num <= 3 THEN
				lv_shipping_num:=5.00; 
			ELSIF lv_quantity_num >= 4 AND lv_quantity_num <=6 THEN
				lv_shipping_num:=7.50; 
			ELSIF lv_quantity_num >= 7 AND lv_quantity_num <= 10 THEN
				lv_shipping_num:=10.00;
			ELSIF lv_quantity_num > 10 THEN
				lv_shipping_num:=12.00;
			ELSE DBMS_OUTPUT.PUT_LINE('I am sorry an error occured.'); 
			END IF;
			DBMS_OUTPUT.PUT_LINE('Customer has ' || lv_quantity_num || ' items in their basket');
			DBMS_OUTPUT.PUT_LINE('The shipping cost of this order is $' || lv_shipping_num); 
		END; 
	--Basket id 12
		DECLARE 
			lv_shipping_num NUMBER(6,2); 
			lv_quantity_num NUMBER(6); 
		BEGIN 
			SELECT quantity
			INTO lv_quantity_num 
			FROM BB_BASKET 
			WHERE idbasket=12;
			IF lv_quantity_num <= 3 THEN
				lv_shipping_num:=5.00; 
			ELSIF lv_quantity_num >= 4 AND lv_quantity_num <= 6 THEN
				lv_shipping_num:=7.50; 
			ELSIF lv_quantity_num >= 7 AND lv_quantity_num <= 10 THEN
				lv_shipping_num:=10.00;
			ELSIF lv_quantity_num > 10 THEN
				lv_shipping_num:=12.00;
			ELSE DBMS_OUTPUT.PUT_LINE('I am sorry an error occured.'); 
			END IF; 
			DBMS_OUTPUT.PUT_LINE('Customer has ' || lv_quantity_num || ' items in their basket');
			DBMS_OUTPUT.PUT_LINE('The shipping cost of this order is $' || lv_shipping_num); 
		END; 

--3.7
DECLARE 
	lv_id_num NUMBER:=12; 
	lv_subtotal_num NUMBER:=100; 
	lv_shipping_num NUMBER:=2; 
	lv_tax_num NUMBER:=5; 
	lv_total_num NUMBER(3); 
BEGIN 
	lv_total_num:=(lv_subtotal_num+lv_shipping_num+lv_tax_num); 
	DBMS_OUTPUT.PUT_LINE('Order Summary information');
	DBMS_OUTPUT.PUT_LINE('*************************');
	DBMS_OUTPUT.PUT_LINE('The basket id is '||lv_id_num);
	DBMS_OUTPUT.PUT_LINE('The subtotal is $'||lv_subtotal_num);
	DBMS_OUTPUT.PUT_LINE('The shipping cost is $'||lv_shipping_num);
	DBMS_OUTPUT.PUT_LINE('The tax is $'||lv_tax_num);
	DBMS_OUTPUT.PUT_LINE('The total for the order is $'||lv_total_num); 
END;
--3.8
DECLARE 
	lv_id_num NUMBER:=12; 
	lv_subtotal_num NUMBER; 
	lv_shipping_num NUMBER; 
	lv_tax_num NUMBER; 
	lv_total_num NUMBER; 
	 TYPE cus_info IS RECORD(
        id# bb_basket.idbasket%TYPE,
        subtotal bb_basket.subtotal%TYPE,
		shipping bb_basket.shipping%TYPE,
		tax bb_basket.tax%TYPE,
		total bb_basket.total%type);
	cus_data cus_info;
BEGIN 
	SELECT IDBASKET, SUBTOTAL, SHIPPING, TAX, TOTAL 
	INTO cus_data
	FROM bb_basket 
	WHERE idbasket=12; 
	DBMS_OUTPUT.PUT_LINE('Order Summary information');
	DBMS_OUTPUT.PUT_LINE('*************************');
	DBMS_OUTPUT.PUT_LINE('The basket id is '||cus_data.id#);
	DBMS_OUTPUT.PUT_LINE('The subtotal is $'||cus_data.subtotal);
	DBMS_OUTPUT.PUT_LINE('The shipping cost is $'||cus_data.shipping);
	DBMS_OUTPUT.PUT_LINE('The tax is $'||cus_data.tax);
	DBMS_OUTPUT.PUT_LINE('The total for the order is $'||cus_data.total); 
END;