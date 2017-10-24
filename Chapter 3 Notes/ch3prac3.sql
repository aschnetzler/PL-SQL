DECLARE
    lv_card#_txt VARCHAR2(20); --Pull from DB
    lv_cardtype_txt CHAR(1); --Pull from DB
    TYPE type_card IS RECORD( --Declare record
        card# bb_basket.cardnumber%TYPE, --Put cardnum into a new variable
        type bb_basket.cardtype%TYPE); -- put Cardtype into a new variable
    rec_card type_card; --Rename the record
    lv_bask_num NUMBER(3) := 10;
BEGIN
    SELECT cardnumber, cardtype -- Pull from DB
    INTO rec_card -- Placing the info into the record
    FROM bb_basket -- Table the info is coming from
    WHERE idbasket = lv_bask_num; --Make idbasket 10
    DBMS_OUTPUT.PUT_LINE('Card #: '||rec_card.card#); --Output card num
    DBMS_OUTPUT.PUT_LINE('Card Type: '||rec_card.type); --Output card type
END;