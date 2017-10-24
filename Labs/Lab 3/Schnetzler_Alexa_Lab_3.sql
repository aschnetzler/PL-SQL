--Hands on Practice 2-4
	--low rated customer
		DECLARE
			lv_cus_num NUMBER (3) := 100;
		BEGIN
		case
			WHEN lv_cus_num <= 100 THEN DBMS_OUTPUT.PUT_LINE('Low Rated Customer Info');
			WHEN lv_cus_num > 100 AND lv_cus_num < 200 THEN DBMS_OUTPUT.PUT_LINE('Mid Rated Customer Info');
			ELSE DBMS_OUTPUT.PUT_LINE('High Rated Customer Info');
			END CASE;
		END;
	--Mid rated customer
		DECLARE
			lv_cus_num NUMBER (3) := 150;
		BEGIN
		case
			WHEN lv_cus_num <= 100 THEN DBMS_OUTPUT.PUT_LINE('Low Rated Customer Info');
			WHEN lv_cus_num > 100 AND lv_cus_num < 200 THEN DBMS_OUTPUT.PUT_LINE('Mid Rated Customer Info');
			ELSE DBMS_OUTPUT.PUT_LINE('High Rated Customer Info');
			END CASE;
		END;
	--High rated customer
		DECLARE
			lv_cus_num NUMBER (3) := 250;
		BEGIN
		case
			WHEN lv_cus_num <= 100 THEN DBMS_OUTPUT.PUT_LINE('Low Rated Customer Info');
			WHEN lv_cus_num > 100 AND lv_cus_num < 200 THEN DBMS_OUTPUT.PUT_LINE('Mid Rated Customer Info');
			ELSE DBMS_OUTPUT.PUT_LINE('High Rated Customer Info');
			END CASE;
		END;
--Hands on Practice 2-5
	--No Balance
		DECLARE
			lv_act_bln BOOLEAN;
			lv_acct_num NUMBER(6,2) := '0';
			lv_msg_txt varchar(50) := 'Does the account have a balance left in it?';
			lv_outmsg_txt varchar(50);
		BEGIN
			if lv_acct_num > '0' then lv_act_bln := true;
			else lv_act_bln := false;
			end if;
		
			if lv_act_bln = true then lv_outmsg_txt := 'The account has a balance on it';
			else lv_outmsg_txt := 'The account does not have a balance on it';
			end if;
		
		dbms_output.put_line(lv_msg_txt);
		dbms_output.put_line(lv_outmsg_txt);
		END;
	--Has Balance
		DECLARE
			lv_act_bln BOOLEAN;
			lv_acct_num NUMBER(6,2) := '10';
			lv_msg_txt varchar(50) := 'Does the account have a balance left in it?';
			lv_outmsg_txt varchar(50);
		BEGIN
			if lv_acct_num > '0' then lv_act_bln := true;
			else lv_act_bln := false;
			end if;
		
			if lv_act_bln = true then lv_outmsg_txt := 'The account has a balance on it';
			else lv_outmsg_txt := 'The account does not have a balance on it';
			end if;
		
		dbms_output.put_line(lv_msg_txt);
		dbms_output.put_line(lv_outmsg_txt);
		END;
--Hands on Practice 2-6
	DECLARE
		lv_money_num NUMBER (5,2) := '69';
		lv_cartItem_num NUMBER (5,2) := '1';
		lv_price_num NUMBER (5) := '20';
		lv_total_num NUMBER (6, 2);
		lv_outmsg_txt varchar(50);
	BEGIN
		while lv_cartItem_num > 0 loop
			lv_total_num := lv_cartItem_num * lv_price_num;
			lv_cartItem_num := lv_cartItem_num - 1;			
		END LOOP;
		lv_outmsg_txt := 'You have:' || '$' || lv_money_num;
		dbms_output.put_line(lv_outmsg_txt);
	
		lv_outmsg_txt := 'Final Cost:' || '$' || lv_total_num;
		dbms_output.put_line(lv_outmsg_txt);
	END;

	