DECLARE
  CURSOR cur_prod IS
    SELECT type, price
    FROM bb_product
    WHERE active = 1
    FOR UPDATE NOWAIT;
  lv_sale bb_product.saleprice%TYPE;
BEGIN
  FOR rec_prod IN cur_prod LOOP
   IF rec_prod.type = 'C' THEN
        lv_sale := rec_prod.price * .9; 
   ELSIF rec_prod.type = 'E' THEN 
        lv_sale := rec_prod.price * .95; 
   END IF;
   UPDATE bb_product
    SET saleprice = lv_sale
    WHERE CURRENT OF cur_prod;
  END LOOP;
  COMMIT;
END;