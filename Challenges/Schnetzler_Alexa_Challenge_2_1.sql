DECLARE
lv_bill_date DATE := '21-OCT-12';
lv_last_txt VARCHAR2(20);
lv_credit_num NUMBER(6,2) := 1000;
BEGIN
lv_last_txt := 'Brown';
DBMS_OUTPUT.PUT_LINE(lv_bill_date);
DBMS_OUTPUT.PUT_LINE(lv_last_txt);
DBMS_OUTPUT.PUT_LINE(lv_credit_num);
END;