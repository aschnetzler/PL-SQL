DECLARE 
    lv_first_txt bb_shopper.firstname%TYPE := 'Jeffrey';
    lv_last_txt bb_shopper.lastname%TYPE := 'Brand';
    lv_email_txt bb_shopper.email%TYPE := 'jbrand@site.com';
BEGIN
    INSERT INTO bb_shopper (idshopper, firstname, lastname, email)
        VALUES (bb_shopper_seq.NEXTVAL, lv_first_txt, lv_last_txt, lv_email_txt);
        COMMIT;
END;

