--Function
create or replace FUNCTION STK_PF 
(p_product IN NUMBER)
RETURN VARCHAR2 AS 
lv_stock NUMBER(5,2);
BEGIN
    SELECT stock 
    INTO lv_stock
    From bb_product
    Where p_product = idproduct;    
  RETURN  lv_stock;
END STK_PF;
--Procedure
	CREATE OR REPLACE PROCEDURE STKUP_PP 
		(p_product IN Number,
		p_quantity IN NUMBER)
	AS 
		lv_id NUMBER (5,2);
	BEGIN
		If lv_stock <  p_quantity THEN
			DBMS_OUTPUT.PUT_LINE('Not enough stock');
		Else
			UPDATE bb_product
			set stock = stock - p_quantity
			WHERE p_product = idproduct;
			DBMS_OUTPUT.PUT_LINE('Stock was updated');
		END IF;
	END STKUP_PP;
--Body
	create or replace PACKAGE BODY PROD_PKG AS
	FUNCTION stk_pf(p_product IN NUMBER)
	RETURN NUMBER AS 
		lv_stock NUMBER(5,2);
	BEGIN
		SELECT stock 
		INTO lv_stock
		From bb_product
		Where p_product = idproduct;    
	RETURN  lv_stock;
	END STK_PF;
	  PROCEDURE STKUP_PP
	(p_product IN Number,
	p_quantity IN NUMBER)
	AS 
	lv_stock NUMBER (5,2) := stk_pf(p_product);
	BEGIN
		If lv_stock <  p_quantity THEN
			DBMS_OUTPUT.PUT_LINE('Not enough stock');
		Else
			UPDATE bb_product
			set stock = stock - p_quantity
			WHERE p_product = idproduct;
			DBMS_OUTPUT.PUT_LINE('Stock was updated');
		END IF;
	END STKUP_PP;
	END PROD_PKG;
--Anon Block 
	Declare
		lv_id NUMBER(5,2) := 1;
		lv_quantity NUMBER(5,2) := 2;
	BEGIN
		PROD_PKG.STKUP_PP(lv_id, lv_quantity);
	END;
--Part 3 Question 1
	--Package create
		create or replace PACKAGE MOVIE_RENTALS_PKG AS 
	 FUNCTION MOVIE_STOCK_SF 
	(p_movieId IN NUMBER)
	RETURN VARCHAR2;
	 FUNCTION MOVIE_STOCK_SF 
	(p_movieId IN VARCHAR2)
	RETURN VARCHAR2;
	PROCEDURE MOVIE_RENT_SP
	(p_memId in OUT NUMBER,
	p_movieId in OUT Number,
	p_pay in OUT Number);
	PROCEDURE MOVIE_RETURN_SP
	(p_memId IN  NUMBER,
	p_movieId IN NUMBER);


	END MOVIE_RENTALS_PKG;
	--Package BODY
		CREATE OR REPLACE
	PACKAGE BODY MOVIE_RENTALS_PKG AS

	  FUNCTION MOVIE_STOCK_SF 
	(p_movieId IN NUMBER)
	RETURN VARCHAR2
	AS 
	lv_stock NUMBER(5,2);
	lv_title VARCHAR(255);
	BEGIN
	select MOVIE_QTY, movie_title
	into lv_stock, lv_title
	from mm_movie
	WHERE p_movieId = movie_ID;
	 if lv_stock > 0 THEN 
	Return lv_title || ' is available. There are ' || lv_stock || ' left in stock.';
	elsif lv_stock = 0 THEN
	 Return lv_title || ' is  not in stock. Please check again later.';
	Else
	Return 'An error occurred finding the stcck. Please try again or contact customer service.';
	END IF;
	exception
	when no_data_found then
	RETURN 'That id does not match a movie in our database. Please review the id and try again.';
	END MOVIE_STOCK_SF;

	FUNCTION MOVIE_STOCK_SF 
	(p_movieId IN VARCHAR2)
	RETURN VARCHAR2
	AS 
	lv_stock NUMBER(5,2);
	lv_title VARCHAR(255);
	BEGIN
	select MOVIE_QTY, movie_title
	into lv_stock, lv_title
	from mm_movie
	WHERE p_movieId = movie_title;
	 if lv_stock > 0 THEN 
	Return lv_title || ' is available. There are ' || lv_stock || ' left in stock.';
	elsif lv_stock = 0 THEN
	 Return lv_title || ' is  not in stock. Please check again later.';
	Else
	Return 'An error occurred finding the stcck. Please try again or contact customer service.';
	END IF;
	exception
	when no_data_found then
	RETURN 'That id does not match a movie in our database. Please review the id and try again.';
	END MOVIE_STOCK_SF;

	 PROCEDURE MOVIE_RENT_SP 
				(p_memId in OUT NUMBER,
				p_movieId in OUT Number,
				p_pay in OUT Number)
				AS 
				lv_qty NUMBER(5,2) := 1;
				lv_stock NUMBER(5,2);
				no_info EXCEPTION;
				PRAGMA EXCEPTION_INIT(no_info, -02291);
				BEGIN

				--Create new order
				Insert into mm_rental(rental_id,member_id, movie_ID, PAYMENT_METHODS_ID)
					  VALUES (MM_RENTAL_SEQ.NEXTVAL,p_memid, p_movieId, p_pay);
					  
				--Update Stock
				Update mm_movie
				set  MOVIE_QTY = movie_QTY - lv_qty
				WHERE p_movieId = movie_ID
				AND movie_qty > 0;

				--Put stock into variable to output
				select MOVIE_QTY
				into lv_stock
				from mm_movie
				WHERE p_movieId = movie_ID
				AND movie_qty > 0;
				
				--Output everything
				DBMS_OUTPUT.PUT_LINE('New Order Report Created On: ' || sysdate);
				DBMS_OUTPUT.PUT_LINE('****************************************************');
				DBMS_OUTPUT.PUT_LINE('Rental Id: ' || MM_RENTAL_SEQ.NEXTVAL);
				DBMS_OUTPUT.PUT_LINE('Member Id: ' || p_memId);
				DBMS_OUTPUT.PUT_LINE('Movie Id: ' || p_movieId);
				DBMS_OUTPUT.PUT_LINE('Payment Type: ' || p_pay);
				DBMS_OUTPUT.PUT_LINE('Movie Stock: ' || lv_stock);
					  
				--Exceptions
				 exception
						  when no_info then
							DBMS_OUTPUT.PUT_LINE('One of your values does not exist in our database. Please review your values and try again.');
							when NO_DATA_FOUND then
							--Update Stock
										Insert into mm_rental(rental_id,member_id, movie_ID, CHECKOUT_DATE, PAYMENT_METHODS_ID, notes)
											 VALUES (MM_RENTAL_SEQ.NEXTVAL,p_memid, p_movieId, NULL, NULL, 'Order not completed. Movie not in stock. Contact customer.');
										DBMS_OUTPUT.PUT_LINE('Sorry, that movie is currently not in stock.');
								
						   
				END MOVIE_RENT_SP;
	PROCEDURE MOVIE_RETURN_SP 
	(p_memId IN  NUMBER,
	p_movieId IN NUMBER)
	AS
	lv_rental NUMBER(5,2);
	lv_qty NUMBER(5,2) := 1;
	no_info EXCEPTION;
	PRAGMA EXCEPTION_INIT(no_info, -02291);
	BEGIN
	--Get the rental id
		select rental_id 
		into lv_rental
		from mm_rental 
		where p_memid = member_id
		AND p_movieId = movie_id;

	--Check the movie back in
		  UPDATE mm_rental 
		  set checkin_date = sysdate
		   where p_memid = member_id
			AND p_movieId = movie_id
			AND checkin_date IS NULL;
			
	--Update movie stock
	Update mm_movie
				set  MOVIE_QTY = movie_QTY + lv_qty
				WHERE p_movieId = movie_ID;
				
	DBMS_OUTPUT.PUT_LINE('Movie rental id  ' || lv_rental || ' was checked in on  ' || sysdate); 
	--Exceptions
	exception
						  when no_info then
							DBMS_OUTPUT.PUT_LINE('One of your values does not exist in our database. Please review your values and try again.');
							when NO_DATA_FOUND then
							DBMS_OUTPUT.PUT_LINE('Sorry no data was found based on the given data.');
	END MOVIE_RETURN_SP;

	END MOVIE_RENTALS_PKG;