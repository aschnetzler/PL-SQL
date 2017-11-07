--6-2
	--Procedure
		CREATE OR REPLACE FUNCTION TOT_PURCH_SP 
			(p_shopper in NUMBER)
		RETURN NUMBER 
		AS
			lv_total NUMBER(5,2);
		BEGIN
			select  sum(total)
			into lv_total
			FROM bb_basket
			Where p_shopper = idshopper;
			RETURN lv_total;
		END TOT_PURCH_SP;
	--Anon Block
		DECLARE 
			lv_total NUMBER(5,2);
		BEGIN 
			lv_total := tot_purch_sp(22);
			DBMS_OUTPUT.PUT_LINE(lv_total);
		END;
	--SQL SELECT
		SELECT DISTINCT tot_purch_sp(idshopper)  "Shopper Total"
		FROM bb_Basket;
--6-3
	--PROCEDURE
		CREATE OR REPLACE FUNCTION NUM_PURCH_SF 
			(p_shopper IN NUMBER)
		RETURN NUMBER
		AS 
			lv_orders NUMBER(5,2);
		BEGIN
			select count(orderplaced)
			into lv_orders
			From bb_basket
			Where p_shopper = idshopper
			AND orderplaced = 1;
			RETURN lv_orders;
		END NUM_PURCH_SF;
	--Anon Block
		DECLARE 
			lv_orders NUMBER(5,2);
		BEGIN 
			lv_orders := num_purch_sf(23);
			DBMS_OUTPUT.PUT_LINE(lv_orders);
		END;
	--SQL SELECT
		SELECT DISTINCT num_purch_sf(23)  "Number of Orders"
		FROM bb_Basket;
--6.4
	--PROCEDURE
		CREATE OR REPLACE FUNCTION DAY_ORD_SF 
			(p_date IN String)
		RETURN STRING AS 
			lv_weekday STRING(255);
		BEGIN
			select to_char(dtcreated, 'DAY')
			into lv_weekday 
			From bb_basket
			where  p_date = dtcreated;
			RETURN lv_weekday;
			Exception when no_data_found then 
			RETURN 'No date found';
		END DAY_ORD_SF;
	--Anon Block
		DECLARE 
			lv_weekday STRING(255);
		BEGIN 
			lv_weekday := day_ord_SF('23-JAN-16');
			DBMS_OUTPUT.PUT_LINE(lv_weekday);
		END;
	--SQL SELECT
	SELECT DISTINCT idbasket,  day_ord_sf(dtcreated) AS "Day Created"
	FROM bb_Basket;
	--SQl GROUP BY
	SELECT day_ord_sf(dtcreated) AS "Day Created", count(*)
	FROM bb_Basket
	GROUP BY day_ord_sf(dtcreated);
--6.6
	