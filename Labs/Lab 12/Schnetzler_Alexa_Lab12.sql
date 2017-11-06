--Procedure
CREATE OR REPLACE FUNCTION CHALLENGE_61 
(p_grounds IN Number)
RETURN VARCHAR2 AS 
lv_type VARCHAR2(255);
BEGIN
 If p_grounds = 3 Then 
 lv_type := 'Whole Bean';
 Elsif p_grounds = 4 Then 
 lv_type := 'Ground';
 Elsif p_grounds = NULL Then 
 lv_type := 'N/A';
 Else lv_type := 'Description Not Found';
 END IF;
 RETURN lv_type;
END CHALLENGE_61;

--Anon Block
DECLARE
lv_grounds VARCHAR2(255);
Begin 
lv_grounds := CHALLENGE_61(3);
DBMS_OUTPUT.PUT_LINE(lv_grounds);
END;

--SQL
SELECT challenge_61(option2) "Ground Type"
FROM bb_Basketitem
Where option2 = 4;
