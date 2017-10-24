CREATE OR REPLACE PROCEDURE COFFEE_EQUIP 
    (product in CHAR)
AS 
BEGIN
if product = 'C' THEN
    DBMS_OUTPUT.PUT_LINE('Coffee');
ELSIF  product = 'E' THEN 
    DBMS_OUTPUT.PUT_LINE('Equipment');
END IF;
END COFFEE_EQUIP;

Declare 
Begin
    COFFEE_EQUIP('C');
END;