--FUNCTION
create or replace FUNCTION memfmt1_sf
(p_id IN NUMBER,
p_first IN VARCHAR2, 
p_last IN VARCHAR2) 
RETURN VARCHAR2
IS 
lv_mem_txt VARCHAR2(35); 
BEGIN 
lv_mem_txt := 'Member '||p_id||' - '||p_first||' '||p_last; 
RETURN lv_mem_txt; END;

--Anon Block
DECLARE
lv_name_txt VARCHAR2(50);
lv_id_num NUMBER(4) := 25;
lv_first_txt VARCHAR2(15) := 'Scott';
lv_last_txt VARCHAR2(20) := 'Savid';
BEGIN lv_name_txt := memfmt1_sf(lv_id_num, lv_first_txt, lv_last_txt);
DBMS_OUTPUT.PUT_LINE(lv_name_txt); END;