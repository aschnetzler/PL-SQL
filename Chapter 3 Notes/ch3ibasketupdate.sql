DECLARE
    lv_basket_num bb_basket.idbasket%TYPE :=14;
BEGIN
    UPDATE bb_basket
    SET orderplaced =1
    WHERE idbasket = lv_basket_num;
    COMMIT;
END; 

SELECT idbasket, orderplaced
FROM bb_basket
WHERE idbasket = 14;


