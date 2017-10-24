--5.1
	--Prodcedure
	CREATE OR REPLACE PROCEDURE PROD_NAME_SP 
		(p_prodid IN bb_product.idproduct%TYPE,
		p_descrip IN bb_product.description%TYPE)
	AS 
	BEGIN
	  UPDATE bb_product
	  SET description = p_descrip
	  WHERE idproduct = p_prodid;
	  COMMIT;
	END PROD_NAME_SP;
	--Anon Block
	declare
	begin
		PROD_NAME_SP(1, 'CapressoBar Model #388');
	End;
--5.2
	--Procedure
	CREATE OR REPLACE PROCEDURE PROD_ADD_SP 
	   (p_name IN bb_product.productname%TYPE,
		p_descrip IN bb_product.description%TYPE,
		p_image IN bb_product.productimage%TYPE,
		p_price IN bb_product.price%TYPE,
       p_active IN bb_product.active%TYPE)
		AS 
	BEGIN
	  Insert into BB_PRODUCT( productname, description, productimage, price, active)
      VALUES (p_name, p_descrip, p_image, p_price, p_active );
	END PROD_ADD_SP;
	--Anon Block
	Declare
	Begin
		PROD_ADD_SP('Roasted Blend', 'Well-balanced mix of roasted beans, a medium body', 'roasted.jpg',9.50,1);
	END;
--5.3
	--PROCEDURE
	CREATE OR REPLACE PROCEDURE TAX_COST_SP 
		(p_state IN bb_tax.state%TYPE,
		p_total IN  NUMBER,
		p_taxtotal OUT Number)    
		AS 
	BEGIN
	  IF p_state = 'VA' THEN
		p_taxtotal := p_total *0.045 ;
		ELSIF p_taxtotal = 'NC' THEN
		p_taxtotal :=p_total * 0.03;
		ELSIF p_state = 'SC' THEN
		p_taxtotal := p_total*0.06;
		END IF; 
	END TAX_COST_SP;
	--Anon Block
	declare
		lv_taxtotal NUMBER(5,2);
	begin
		TAX_COST_SP('VA', 100, lv_taxtotal);
		DBMS_OUTPUT.PUT_LINE('The total for your order is' || ' ' || lv_taxtotal);
	END;
--5.4
	--PROCEDURE
	CREATE OR REPLACE PROCEDURE BASKET_CONFIRM_SP 
		(p_id IN bb_basket.idbasket%TYPE,
        p_subtotal IN bb_basket.subtotal%TYPE,
        p_ship IN bb_basket.shipping%TYPE,
        p_tax IN bb_basket.tax%TYPE,
        p_total IN bb_basket.total%TYPE)
        AS 
	BEGIN
	UPDATE bb_basket
	SET subtotal = p_subtotal,
			shipping = p_ship,
			tax = p_tax,
			total = p_total,
			orderplaced = 1
	WHERE idbasket = p_id;
	END BASKET_CONFIRM_SP;
	--Anon Block
	DECLARE
	BEGIN
		BASKET_CONFIRM_SP(17,64.80, 8.00, 1.94, 74.74);
	END;
--5.5
	--PROCEDURE
	create or replace PROCEDURE STATUS_SHIP_SP 
    (p_id IN bb_basketstatus.idbasket%TYPE,
    p_dtship IN bb_basketstatus.dtstage%TYPE,
    p_shipper IN bb_basketstatus.shipper%TYPE,
    p_shipnum IN bb_basketstatus.shippingnum%TYPE)
    AS 
	BEGIN
	insert into bb_basketstatus
		(idstatus, idbasket, idstage, dtstage, shipper, shippingnum)
		values (bb_status_seq.nextval, p_id, 3, p_dtship, p_shipper, p_shipnum);
	  commit;
	END STATUS_SHIP_SP;
	--Anon Block
	DECLARE
	BEGIN
		STATUS_SHIP_SP(3, '20-FEB-12', 'UPS', 'ZW2384YXK4957');
	END;
--5.6
	--PROCEDURE
	CREATE OR REPLACE PROCEDURE STATUS_SP 
     (p_id     in  bb_basketstatus.idbasket%type,
		p_date   out bb_basketstatus.dtstage%type,
		p_status out bb_basketstatus.notes%type)
	AS 
	 lv_stage bb_basketstatus.idstage%type;
	BEGIN
	  select idstage, dtstage
		into lv_stage, p_date 
	  from bb_basketstatus
	  where idbasket = p_id
	  and dtstage = (select max(dtstage) from bb_basketstatus);
		IF lv_stage = 1 then 
			p_status := 'Submitted and received';
		ELSIF lv_stage =2 then 
			p_status := 'Confirmed, processed, sent to shipping';
		ELSIF lv_stage= 3 then 
			p_status := 'Shipped';
		ELSIF lv_stage= 4 then 
			p_status := 'Cancelled';
		ELSIF lv_stage= 5 then 
			p_status := 'Backordered';
	   ELSE p_status := 'No status available';
	  end if;
	  exception
		  when no_data_found then
			p_status := 'No status available';
	END STATUS_SP;
	--Anon Block
	DECLARE
	lv_date bb_basketstatus.dtstage%TYPE;
	lv_status bb_basketstatus.notes%TYPE;
	BEGIN
		STATUS_SP(4, lv_date, lv_status);
        DBMS_OUTPUT.PUT_LINE(lv_date || lv_status);
	END;
	DECLARE
	lv_date bb_basketstatus.dtstage%TYPE;
	lv_status bb_basketstatus.notes%TYPE;
	BEGIN
		STATUS_SP(6, lv_date, lv_status);
        DBMS_OUTPUT.PUT_LINE(lv_date || lv_status);
	END;
	
--5.7
	--PROCEDURE
	CREATE OR REPLACE PROCEDURE PROMO_SHIP_SP 
	  (p_date  in bb_basket.dtcreated%type,
	   p_month in bb_promolist.month%type,
	   p_year  in bb_promolist.year%type)
	AS
	   lv_min bb_basket.idshopper%type;
	   lv_max bb_basket.idshopper%type;
	   lv_date bb_basket.dtcreated%type;
	   lv_shopper bb_basket.idshopper%type;
	   lv_dummy_id number; 
	begin
	  select min(idshopper), max(idshopper)
		into lv_min, lv_max
	  from bb_basket;

	  for i in lv_min..lv_max loop
		select max(dtcreated)
		  into lv_date
		from bb_basket
		where idshopper = i;
		if p_date >= lv_date then
		  select count(idshopper)
			into lv_dummy_id
		  from bb_promolist
		  where i = idshopper;		
			if lv_dummy_id = 1 then 
				continue;
			else    
				insert into bb_promolist
				  (idshopper, month, year, promo_flag, used)
				  values (i, p_month, p_year, 1, 'N');
			end if;
		end if;
	  end loop;
	END PROMO_SHIP_SP;
	--Anon Block 
	DECLARE
	BEGIN
		promo_ship_sp('15-FEB-12', 'APR', 2012);
	END;
--5.8
	--PROCEDURE
	CREATE OR REPLACE PROCEDURE BASKET_ADD_SP 
     (p_id    in bb_basketitem.idbasket%type,
	   p_prod  in bb_basketitem.idproduct%type,
	   p_price in bb_basketitem.price%type,
	   p_qnty  in bb_basketitem.quantity%type,
	   p_size  in bb_basketitem.option1%type,
	   p_form  in bb_basketitem.option2%type)
	AS 
	BEGIN
	   insert into bb_basketitem (idbasketitem, idbasket,
		idproduct, price, quantity, option1, option2)
		values (bb_idbasketitem_seq.nextval, p_id, p_prod,
		  p_price, p_qnty, p_size, p_form);
	END BASKET_ADD_SP;
	--Anon Block
	DECLARE
	BEGIN
		basket_add_sp(14, 8, 10.80, 1, 2, 4);
	END;
	
