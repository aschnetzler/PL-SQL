select stock, reorder
from bb_product
where idproduct = 4;

update bb_product
set stock = 25
where idproduct = 4;

select *
from bb_product_request;