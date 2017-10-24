DECLARE
 TYPE type_roast IS TABLE OF NUMBER
  INDEX BY BINARY_INTEGER;
 tbl_roast type_roast;
 lv_tot_num NUMBER := 0;
 lv_cnt_num NUMBER := 0;
 lv_avg_num NUMBER;
 lv_samp1_num NUMBER(5,2) := 6.22;
 lv_samp2_num NUMBER(5,2) := 6.13;
 lv_samp3_num NUMBER(5,2) := 6.27;
 lv_samp4_num NUMBER(5,2) := 6.16;
 lv_samp5_num NUMBER(5,2);
BEGIN
  tbl_roast(1) := lv_samp1_num; 
  tbl_roast(2) := lv_samp2_num; 
  tbl_roast(3) := lv_samp3_num; 
  tbl_roast(4) := lv_samp4_num; 
  tbl_roast(5) := lv_samp5_num; 
  FOR i IN 1..tbl_roast.COUNT LOOP
     IF tbl_roast(i) IS NOT NULL THEN
         lv_tot_num := lv_tot_num + tbl_roast(i);
         lv_cnt_num := lv_cnt_num + 1;
     END IF;
  END LOOP;
  lv_avg_num := lv_tot_num / lv_cnt_num;
  DBMS_OUTPUT.PUT_LINE(lv_tot_num);
  DBMS_OUTPUT.PUT_LINE(lv_cnt_num);
  DBMS_OUTPUT.PUT_LINE(tbl_roast.COUNT);
  DBMS_OUTPUT.PUT_LINE(lv_avg_num);
END;