--Question 1
	--PROCEDURE
		create or replace PROCEDURE COUNTRY_DEMOGRAPHICS 
			(p_name IN  countries.country_name%TYPE,
			location OUT countries.location%TYPE,
			capitol OUT countries.capitol%TYPE,
			population OUT countries.population%TYPE,
			airports OUT countries.airports%TYPE,
			climate OUT countries.climate%TYPE)
		AS 
		BEGIN
			SELECT  location, capitol, population, airports, climate
			INTO  location, capitol, population, airports, climate
			FROM countries
			WHERE UPPER(p_name) = UPPER(country_name);
		  EXCEPTION WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Country not found');
		END COUNTRY_DEMOGRAPHICS;
	--ANON BLOCK
		DECLARE
			lv_name countries.country_name%TYPE := '&Country';
			 lv_location countries.location%TYPE;
			lv_capitol countries.capitol%TYPE;
			lv_population countries.population%TYPE;
			lv_airports  countries.airports%TYPE;
			lv_climate  countries.climate%TYPE;
		BEGIN
			country_demographics(lv_name,  lv_location , lv_capitol, lv_population, lv_airports, lv_climate);
			DBMS_OUTPUT.PUT_LINE(lv_name);
			DBMS_OUTPUT.PUT_LINE('**************************************');
			  DBMS_OUTPUT.PUT_LINE('Location: ' ||lv_location);
			  DBMS_OUTPUT.PUT_LINE('Capitol: ' ||lv_capitol);
			  DBMS_OUTPUT.PUT_LINE('Population: '||lv_population);
			  DBMS_OUTPUT.PUT_LINE('Airports: '||lv_airports);
			  DBMS_OUTPUT.PUT_LINE('Climate: '||lv_climate);
		END;
--Question 2
	--PROCEDURE
		CREATE OR REPLACE PROCEDURE FIND_REGION_AND_CURRENCY
			(p_country_name IN OUT countries.country_name%TYPE,
            p_currency OUT currencies.currency_name%TYPE,
            p_region OUT regions.region_name%TYPE)
		AS 
		BEGIN
		  SELECT country_name, currency_name, region_name
			INTO  p_country_name,p_currency, p_region
			FROM countries NATURAL JOIN currencies NATURAL JOIN regions
			WHERE UPPER(p_country_name) = UPPER(country_name);
		  EXCEPTION WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('Country not found');
		END FIND_REGION_AND_CURRENCY;
	--ANON BLOCK
		DECLARE
			lv_name countries.country_name%TYPE := '&Country';
			lv_currency  currencies.currency_name%TYPE;
            lv_region  regions.region_name%TYPE;
		BEGIN
			find_region_and_currency(lv_name, lv_currency, lv_region);
			DBMS_OUTPUT.PUT_LINE(lv_name);
			DBMS_OUTPUT.PUT_LINE('**************************************');
			  DBMS_OUTPUT.PUT_LINE('Currency:  '|| lv_currency);
			  DBMS_OUTPUT.PUT_LINE('Region: '|| lv_region);
		END;


--Question 3
	--PROCEDURE
		CREATE OR REPLACE PROCEDURE CALC_AIRPORTS_PER_PERSON 
			(a_name IN countries.country_name%TYPE,
				a_airport OUT NUMBER)
		AS 
			lv_airports countries.airports%TYPE;
			lv_pop countries.population%TYPE;
		BEGIN
			SELECT airports, population
			INTO lv_airports, lv_pop
			FROM countries
			WHERE UPPER(country_name) = UPPER(a_name);

			a_airport := (lv_pop/lv_airports);

		EXCEPTION
			when NO_DATA_FOUND then
				DBMS_OUTPUT.PUT_LINE('There was no data found');

		END CALC_AIRPORTS_PER_PERSON;
	--Anon Block
		DECLARE
			lv_name countries.country_name%type;
			lv_airport NUMBER(12,2);
		BEGIN
			lv_name := '&Country';
			calc_airports_per_person(lv_name, lv_airport);
			DBMS_OUTPUT.PUT_LINE(lv_name);
			DBMS_OUTPUT.PUT_LINE('**************************************');
			DBMS_OUTPUT.PUT_LINE('Airports per person: '||lv_airport);
		END;
--Question 4
	--PROCEDURE
		CREATE OR REPLACE PROCEDURE ADD_SPOKEN_LANGUAGE 
			(s_cid IN spoken_languages.country_id%TYPE,
				s_lid IN spoken_languages.language_id%TYPE,
				s_off IN SPOKEN_LANGUAGES.official%TYPE,
				s_com IN spoken_languages.comments%TYPE)
		AS 
		BEGIN
			INSERT INTO SPOKEN_LANGUAGES (country_id, language_id, official, comments)
			VALUES (s_cid, s_lid, s_off, s_com);
		END ADD_SPOKEN_LANGUAGE;
	--Anon Block
		DECLARE
			lv_cid SPOKEN_LANGUAGES.COUNTRY_ID%TYPE;
			lv_lid SPOKEN_LANGUAGES.LANGUAGE_ID%TYPE;
			lv_off SPOKEN_LANGUAGES.OFFICIAL%TYPE;
			lv_com SPOKEN_LANGUAGES.COMMENTS%TYPE;
		BEGIN
			lv_cid := '&Country';
			lv_lid := '&Language';
			lv_off := '&Official';
			lv_com := '&Comments';
			add_spoken_language(lv_cid,lv_lid,lv_off,lv_com);
		END;
--Question 5
	--PROCEDURE
	--ANON BLOCK
