/*7. Write a query to display carton id, (len*width*height) as carton_vol and identify the optimum carton (carton with the least volume whose volume is greater than the total volume of all items (len * width * height * product_quantity)) for a given order whose order id is 10006, Assume all items of an order are packed into one single carton (box). (1 ROW) [NOTE: CARTON TABLE]*/
select carton_id, LEN*WIDTH*HEIGHT carton_vol
from carton
where LEN*WIDTH*HEIGHT  > 
(select sum(LEN*WIDTH*HEIGHT*product_quantity) 
from product 
inner join order_items using (product_id)
where ORDER_ID = 10006)
order by LEN*WIDTH*HEIGHT limit 1;

/*8. Write a query to display details (customer id,customer fullname,order id,product quantity) of customers who bought more than ten (i.e. total order qty) products per shipped order. (11 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items,]*/
select oc.customer_id,concat(oc.customer_fname,' ',oc.customer_lname)full_name,oh.order_id,sum(oi.PRODUCT_QUANTITY) Total_quantity
from online_customer oc
inner join order_header oh
on oc.CUSTOMER_ID=oh.CUSTOMER_ID
inner join order_items oi
on oh.ORDER_ID=oi.ORDER_ID
where oh.ORDER_STATUS = 'shipped'
group by oh.ORDER_ID having total_quantity >10
order by total_quantity desc;

/*9. Write a query to display the order_id, customer id and cutomer full name of customers along with (product_quantity) as total quantity of products shipped for order ids > 10060. (6 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items]*/

select oh.ORDER_ID,concat(oc.customer_fname,' ',oc.customer_lname)full_name, sum(oi.product_quantity)total_qty
from online_customer oc
left join order_header oh
on oc.CUSTOMER_ID=oh.CUSTOMER_ID
left join order_items oi
on oh.ORDER_ID=oi.ORDER_ID
where oh.ORDER_STATUS = 'shipped'
group by oh.ORDER_ID having ORDER_ID > 10060
order by oh.ORDER_ID;

/*10. Write a query to display product class description ,total quantity (sum(product_quantity),Total value (product_quantity * product price) and show which class of products have been shipped highest(Quantity) to countries outside India other than USA? Also show the total value of those items. (1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]*/

select pc.PRODUCT_CLASS_DESC,sum(oi.PRODUCT_QUANTITY)total_qty,sum(oi.PRODUCT_QUANTITY*p.PRODUCT_PRICE) total_value,oh.order_status
from product_class pc
inner join product p
on pc.PRODUCT_CLASS_CODE=p.PRODUCT_CLASS_CODE
inner join order_items oi
on p.PRODUCT_ID=oi.PRODUCT_ID
inner join order_header oh
on oi.ORDER_ID=oh.ORDER_ID
inner join online_customer oc
on oh.CUSTOMER_ID=oc.CUSTOMER_ID
inner join address a
on oc.ADDRESS_ID=a.ADDRESS_ID
where (oh.ORDER_STATUS='shipped') and not (COUNTRY = 'india'or country ='usa')
group by pc.PRODUCT_CLASS_DESC
order by total_qty desc limit 1;


use orders



