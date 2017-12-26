--Manuel A. Bolanos-Tapia

--Question 1
CREATE OR REPLACE PROCEDURE COUNTRY_DEMOGRAPHICS 
(p_name IN OUT countries.country_name%type,
c_location OUT countries.location%type,
c_capitol OUT countries.capitol%type,
c_population OUT countries.population%type,
c_airports OUT countries.airports%type,
c_climate OUT countries.climate%type,
c_error OUT VARCHAR2)
AS
lv_name countries.country_name%type;
lv_loc countries.location%type;
lv_cap countries.capitol%type;
lv_pop countries.population%type;
lv_air countries.airports%type;
lv_cli countries.climate%type;
BEGIN
  select country_name, location, capitol, population, airports, climate
  into lv_name, lv_loc, lv_cap, lv_pop, lv_air, lv_cli
  from countries
  where UPPER(country_name) = UPPER(p_name);
  
  if lv_name = p_name then
  p_name := lv_name;
  c_location := lv_loc;
  c_capitol := lv_cap;
  c_population := lv_pop;
  c_airports := lv_air;
  c_climate := lv_cli;
  c_error := ' ';
  
  ELSE c_error := 'something went wrong';
  end if;
  
  exception 
  when no_data_found then
   c_error:='Country Does Not Exist';
END COUNTRY_DEMOGRAPHICS;

DECLARE
lv_name countries.country_name%type;
lv_location countries.location%type;
lv_capitol countries.capitol%type;
lv_population countries.population%type;
lv_airports countries.airports%type;
lv_climate countries.climate%type;
lv_error VARCHAR(30);

BEGIN
lv_name:='&country';
country_demographics(lv_name,lv_location,lv_capitol,lv_population,lv_airports,lv_climate,lv_error);
DBMS_OUTPUT.PUT_LINE(lv_error);
DBMS_OUTPUT.PUT_LINE('Country Name: '||lv_name);
DBMS_OUTPUT.PUT_LINE('Location: '||lv_location);
DBMS_OUTPUT.PUT_LINE('Capitol: '||lv_capitol);
DBMS_OUTPUT.PUT_LINE('Population: '||lv_population);
DBMS_OUTPUT.PUT_LINE('Airports: '||lv_airports);
DBMS_OUTPUT.PUT_LINE('Climate: '||lv_climate);

END;

--Question 2



--Question 3
CREATE OR REPLACE PROCEDURE CALC_AIRPORTS_PER_PERSON 
(a_name IN countries.country_name%type,
a_airport OUT NUMBER,
a_error OUT VARCHAR2)
AS 
lv_airports countries.airports%type;
lv_pop countries.population%type;
BEGIN
select airports, population
into lv_airports, lv_pop
from countries
where UPPER(country_name) = UPPER(a_name);

a_airport := (lv_airports/lv_pop);

exception
when NO_DATA_FOUND then
a_error := 'There was no data found';

END CALC_AIRPORTS_PER_PERSON;

DECLARE
lv_name countries.country_name%type;
lv_airport NUMBER(12,2);
lv_error VARCHAR2(30);
BEGIN
lv_name := '&Country';
calc_airports_per_person(lv_name, lv_airport, lv_error);
DBMS_OUTPUT.PUT_LINE('Country: '||lv_name);
DBMS_OUTPUT.PUT_LINE('Airports per Person: '||lv_airport);
END;

--Question 4
CREATE OR REPLACE PROCEDURE ADD_SPOKEN_LANGUAGE 
(s_cid IN spoken_languages.country_id%type,
s_lid IN spoken_languages.language_id%type,
s_off in SPOKEN_LANGUAGES.official%type,
s_com in spoken_languages.comments%type)
AS 
BEGIN
insert into SPOKEN_LANGUAGES (country_id, language_id, official, comments)
values (s_cid, s_lid, s_off, s_com);
END ADD_SPOKEN_LANGUAGE;

DECLARE
lv_cid SPOKEN_LANGUAGES.COUNTRY_ID%type;
lv_lid SPOKEN_LANGUAGES.LANGUAGE_ID%type;
lv_off SPOKEN_LANGUAGES.OFFICIAL%type;
lv_com SPOKEN_LANGUAGES.COMMENTS%type;
BEGIN
lv_cid := '&Country';
lv_lid := '&Language';
lv_off := '&Official';
lv_com := '&Comments';
add_spoken_language(lv_cid,lv_lid,lv_off,lv_com);
END;