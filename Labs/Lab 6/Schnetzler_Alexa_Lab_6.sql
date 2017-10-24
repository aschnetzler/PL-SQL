--4.1
	DECLARE
	   CURSOR cur_basket IS
		 SELECT bi.idBasket, bi.quantity, p.stock
		   FROM bb_basketitem bi INNER JOIN bb_product p
			 USING (idProduct)
		   WHERE bi.idBasket = 6;
	   TYPE type_basket IS RECORD (
		 basket bb_basketitem.idBasket%TYPE,
		 qty bb_basketitem.quantity%TYPE,
		 stock bb_product.stock%TYPE);
	   rec_basket type_basket;
	   lv_flag_txt CHAR(1) := 'Y';
	BEGIN
	   OPEN cur_basket;
		   LOOP 
			 FETCH cur_basket INTO rec_basket;
			  EXIT WHEN cur_basket%NOTFOUND;
			  IF rec_basket.stock < rec_basket.qty THEN lv_flag_txt := 'N'; END IF;
		   END LOOP;
		CLOSE cur_basket;
	   IF lv_flag_txt = 'Y' THEN DBMS_OUTPUT.PUT_LINE('All items in stock!'); END IF;
	   IF lv_flag_txt = 'N' THEN DBMS_OUTPUT.PUT_LINE('All items NOT in stock!'); END IF;   
	END;
--4.2
	--Code Given
		DECLARE
			CURSOR cur_shopper IS
				SELECT a.idShopper, a.promo,  b.total                          
				FROM bb_shopper a, (SELECT b.idShopper, SUM(bi.quantity*bi.price) total
									FROM bb_basketitem bi, bb_basket b
									WHERE bi.idBasket = b.idBasket
									GROUP BY idShopper) b
				WHERE a.idShopper = b.idShopper
				FOR UPDATE OF a.idShopper NOWAIT;
			lv_promo_txt CHAR(1);
		BEGIN
		  FOR rec_shopper IN cur_shopper LOOP
			lv_promo_txt := 'X';
			IF rec_shopper.total > 100 THEN 
				  lv_promo_txt := 'A';
			END IF;
			IF rec_shopper.total BETWEEN 50 AND 99 THEN 
				  lv_promo_txt := 'B';
			END IF;   
			IF lv_promo_txt <> 'X' THEN
				UPDATE bb_shopper
				SET promo = lv_promo_txt
				WHERE CURRENT OF cur_shopper;
			END IF;
		 END LOOP;
		 COMMIT;
		END;
	--Query
	SELECT 
		idShopper, s.promo, SUM(bi.quantity*bi.price) total
	FROM 
		bb_shopper s INNER JOIN bb_basket b USING (idShopper)
			INNER JOIN BB_BASKETITEM bi USING(idBasket)
       GROUP BY idShopper, s.promo
       ORDER BY idShopper;
--4.3
	--Given Code
		UPDATE bb_shopper
			SET promo = NULL;
		UPDATE bb_shopper
			SET promo = 'B'
			WHERE idShopper IN (21,23,25);
		UPDATE bb_shopper
			SET promo = 'A'
			WHERE idShopper = 22;
		COMMIT;
		BEGIN
			UPDATE bb_shopper
				SET promo = NULL
				WHERE promo IS NOT NULL; 
		END;
	--Modified Code
		UPDATE bb_shopper
			SET promo = NULL;
		UPDATE bb_shopper
			SET promo = 'B'
			WHERE idShopper IN (21,23,25);
		UPDATE bb_shopper
			SET promo = 'A'
			WHERE idShopper = 22;
		COMMIT;
        DECLARE
         promo VARCHAR(1);
         idshopper Number(2);
        
		BEGIN
            SELECT idShopper
            INTO idShopper
            FROM bb_Shopper
            WHERE idShopper = 21;
			UPDATE bb_shopper
				SET promo = NULL
				WHERE promo IS NOT NULL;
            IF idShopper = 21 THEN
                promo := 'B';
            ELSIF idShopper = 23 THEN
                 promo := 'B';
            ELSIF idShopper = 25 THEN
                promo := 'B';
            ELSIF idShopper = 22 THEN
                 promo := 'A';
            END IF; 
             IF promo = 'B' THEN DBMS_OUTPUT.PUT_LINE('1 Row Updated'); END IF;
            IF promo = 'A' THEN DBMS_OUTPUT.PUT_LINE('1 Row Updated'); END IF; 
		END;