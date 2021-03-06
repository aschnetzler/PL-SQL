DECLARE
TYPE
    lv_card#_txt bb_basket.cardnumber%TYPE;
    lv_cardtype_txt bb_basket.cardtype%TYPE;
    lv_bask_num NUMBER(3) := 10;
BEGIN
    SELECT cardnumber, cardtype
    INTO lv_card#_txt, lv_cardtype_txt
    FROM bb_basket
    WHERE idbasket= lv_bask_num;
    DBMS_OUTPUT.PUT_LINE('Card #: ' || lv_card#_txt);
    DBMS_OUTPUT.PUT_LINE('Card Type: ' || lv_cardtype_txt);
END;
