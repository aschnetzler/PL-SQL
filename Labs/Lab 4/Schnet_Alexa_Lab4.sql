--3.1
	--Original Working Code
		DECLARE
		  lv_ship_date bb_basketstatus.dtstage%TYPE;
		  lv_shipper_txt bb_basketstatus.shipper%TYPE;
		  lv_ship_num bb_basketstatus.shippingnum%TYPE;
		  lv_bask_num bb_basketstatus.idbasket%TYPE := 5;
		BEGIN
		  SELECT dtstage, shipper, shippingnum
		   INTO lv_ship_date, lv_shipper_txt, lv_ship_num
		   FROM bb_basketstatus
		   WHERE idbasket = lv_bask_num
			AND idstage = 5;
		  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||lv_ship_date);
		  DBMS_OUTPUT.PUT_LINE('Shipper: '||lv_shipper_txt);
		  DBMS_OUTPUT.PUT_LINE('Shipping #: '||lv_ship_num);
		END;
	--Changed Code to show error
		DECLARE
		  lv_ship_date bb_basketstatus.dtstage%TYPE;
		  lv_shipper_txt bb_basketstatus.shipper%TYPE;
		  lv_ship_num bb_basketstatus.shippingnum%TYPE;
		  lv_bask_num bb_basketstatus.idbasket%TYPE := 7;
		BEGIN
		  SELECT dtstage, shipper, shippingnum
		   INTO lv_ship_date, lv_shipper_txt, lv_ship_num
		   FROM bb_basketstatus
		   WHERE idbasket = lv_bask_num
			AND idstage = 5;
		  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||lv_ship_date);
		  DBMS_OUTPUT.PUT_LINE('Shipper: '||lv_shipper_txt);
		  DBMS_OUTPUT.PUT_LINE('Shipping #: '||lv_ship_num);
		END;
--3.2
DECLARE
  rec_ship bb_basketstatus%ROWTYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
  SELECT *
   INTO rec_ship
   FROM bb_basketstatus
   WHERE idbasket =  lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||rec_ship.dtstage);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||rec_ship.shipper);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||rec_ship.shippingnum);
  DBMS_OUTPUT.PUT_LINE('Notes: '||rec_ship.notes);
END;
--3.3
DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
 lv_shop_num bb_basket.idshopper%TYPE := 22;
BEGIN
 SELECT SUM(total)
      INTO lv_total_num
  FROM bb_basket
  WHERE idShopper = 22
    AND orderplaced = 1
  GROUP BY idshopper;
  IF lv_total_num > 200 THEN
	lv_rating_txt := 'High';
	ELSIF lv_total_num < 200 AND lv_total_num > 100 THEN
	lv_rating_txt := 'Mid';
	ELSIF lv_total_num <= 100 THEN
	lv_rating_txt := 'Low';
  END IF; 
   DBMS_OUTPUT.PUT_LINE('Shopper: '||lv_shop_num||' is rated '||lv_rating_txt);
END;
--3.4
DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
 lv_shop_num bb_basket.idshopper%TYPE := 22;
BEGIN
 SELECT SUM(total)
      INTO lv_total_num
  FROM bb_basket
  WHERE idShopper = 22
    AND orderplaced = 1
  GROUP BY idshopper;
  CASE 
  WHEN lv_total_num > 200 THEN
	lv_rating_txt := 'High';
	WHEN lv_total_num < 200 AND lv_total_num > 100 THEN
	lv_rating_txt := 'Mid';
	WHEN lv_total_num <= 100 THEN
	lv_rating_txt := 'Low';
  END CASE; 
   DBMS_OUTPUT.PUT_LINE('Shopper: '||lv_shop_num||' is rated '||lv_rating_txt);
END;
--3.5
DECLARE 
    LV_QUANTITY_NUM NUMBER(3):=0; 
    LV_ITEMCOST_NUM BB_PRODUCT.PRICE%TYPE; 
    LV_AMOUNT_NUM NUMBER(3):=100; 
BEGIN 
    SELECT SUM (PRICE) 
    INTO LV_ITEMCOST_NUM 
    FROM BB_PRODUCT 
    WHERE idProduct=4; 
    WHILE LV_AMOUNT_NUM > 0 LOOP
        LV_AMOUNT_NUM:=LV_AMOUNT_NUM-LV_ITEMCOST_NUM; 
        LV_QUANTITY_NUM:=LV_QUANTITY_NUM+1; 
    EXIT WHEN LV_AMOUNT_NUM-LV_ITEMCOST_NUM<0; 
    END LOOP; 
DBMS_OUTPUT.PUT_LINE(LV_QUANTITY_NUM); 
END; 