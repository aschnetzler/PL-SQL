-- Alexa Schnetzler Project 2
	--Part 1 Question 1
		--Add Notes Column to mm_rental
		alter table mm_rental add notes varchar(255);
		--Procedure
			--Procedure
			CREATE OR REPLACE PROCEDURE MOVIE_RENT_SP 
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
		--Anon Block
			Declare
				lv_memId NUMBER(5,3) := 13;
				lv_movieId NUMBER(5,3) := 12;
				lv_pay Number(2,0) := 4;
			BEGIN
				movie_rent_sp(lv_memId, lv_movieId, lv_pay);
			END;
	--Part 1 Question 2
	--PROCEDURE
		CREATE OR REPLACE PROCEDURE MOVIE_RETURN_SP 
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
	--Anon Block Successful
		Declare
			lv_memId NUMBER(5,3) := 13;
			lv_movieId NUMBER(5,3) := 12;
		BEGIN
			movie_return_sp(lv_memId, lv_movieId);
		END;
	--Anon Block Error
		Declare
			lv_memId NUMBER(5,3) := 69;
			lv_movieId NUMBER(5,3) := 12;
		BEGIN
			movie_return_sp(lv_memId, lv_movieId);
		END;
	--Part 2 Question 1
		--FUNCTION
		create or replace FUNCTION MOVIE_STOCK_SF 
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
		--Anon Block SUCCESSFUL
		Declare
			lv_stock VARCHAR2(255);
			lv_movieId NUMBER(5,3) := 12;
		BEGIN
			lv_stock := movie_stock_sf (lv_movieId);
			DBMS_OUTPUT.PUT_LINE(lv_stock);
		END;
		--Anon Block Error
		Declare
			lv_stock VARCHAR2(255);
			lv_movieId NUMBER(5,3) := 69;
		BEGIN
			lv_stock := movie_stock_sf (lv_movieId);
			DBMS_OUTPUT.PUT_LINE(lv_stock);
		END;
	--Part 2 Question 2
		--package create
		create or replace PACKAGE MOVIE_RENTALS_PKG AS 
		 FUNCTION MOVIE_STOCK_SF 
			(p_movieId IN NUMBER)
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
		--Anon Block id:6
		Declare
			lv_stock Varchar2(255);
		BEGIN
			lv_stock := MOVIE_RENTALS_PKG.movie_stock_sf(6);
			DBMS_OUTPUT.PUT_LINE(lv_stock);
		END;
		--Anon block id:7
		Declare
			lv_stock Varchar2(255);
		BEGIN
			lv_stock := MOVIE_RENTALS_PKG.movie_stock_sf(7);
			DBMS_OUTPUT.PUT_LINE(lv_stock);
		END;
	--Part 3 Question 1
		--PACKAGE create
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
				create or replace PACKAGE BODY MOVIE_RENTALS_PKG AS

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
		RETURN 'That title does not match a movie in our database. Please review the id and try again.';
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
		--anon block successful
		Declare
			lv_stock Varchar2(255);
		BEGIN
			lv_stock := MOVIE_RENTALS_PKG.movie_stock_sf('Jaws');
			DBMS_OUTPUT.PUT_LINE(lv_stock);
		END;
		--anon block error
		Declare
			lv_stock Varchar2(255);
		BEGIN
			lv_stock := MOVIE_RENTALS_PKG.movie_stock_sf('Saw');
			DBMS_OUTPUT.PUT_LINE(lv_stock);
		END;
	--Part 3 Question 2
		--Function
		CREATE OR REPLACE FUNCTION MOVIE_SUGGESTION_SF 
		(p_category IN VARCHAR2)
		RETURN VARCHAR2 
		AS 
		no_value exception;
		PRAGMA EXCEPTION_INIT(no_value, -06503);
		CURSOR category IS 
					   SELECT movie_category, movie_title
						 FROM MM_MOVIE NATURAL JOIN MM_MOVIE_TYPE
						 WHERE UPPER(p_category) = UPPER(movie_category);
				   lv_name category%ROWTYPE;
		BEGIN
		  open category;
					LOOP
						fetch category into lv_name;
						IF category%Rowcount >= 1 THEN
						 dbms_output.put_line(lv_name.movie_title);
						 ELSE 	DBMS_OUTPUT.PUT_LINE('Sorry, our system could not find a movie title within that category.');
						END IF;
						exit when category%NOTFOUND;    
						END LOOP;
				close category;
				exception
				when no_value then
								DBMS_OUTPUT.PUT_LINE('Sorry, our system could not find a movie title within that category.');
				when no_data_found then
								DBMS_OUTPUT.PUT_LINE('Sorry, our system could not find a movie title within that category.');
		END MOVIE_SUGGESTION_SF;
		--Anon Block
		DECLARE
				lv_category VARCHAR2(255) :='&Category';   
				lv_titles Varchar2(255);
			BEGIN
				DBMS_OUTPUT.Put_Line('Movies Titles from that cateogry:');
				DBMS_OUTPUT.Put_Line('******************************************');
				lv_titles := MOVIE_SUGGESTION_SF(lv_category);
			END;