--SQL-отчёт
--1. Выручка по клиентам:
select o.customer, sum(o.amount * o.price) as revenue
from orders o
group by o.customer
order by revenue desc 

--2. Топ-3 товара по выручке:
select o.product, sum(o.amount * o.price) as revenue
from orders o
group by o.product
order by revenue desc 
limit 1

--3. Выручка по месяцам:
select
    strftime('%Y-%m', date) as month,
    sum(o.amount * o.price) as revenue
from orders o
group by month
order by revenue desc

--4. Средний чек по клиентам:
select
    o.customer,
    avg(o.amount * o.price) as average_check
from orders o
group by o.customer

--5. Клиенты с выручкой > 1000:
select o.customer, sum(o.amount * o.price) as revenue
from orders o
group by o.customer
having sum(o.amount * o.price) > 1000

--Выводы: Основную выручку принёс клиент Maria, также высокий вклад у Alex;
--Самый прибыльный товар в исследуемой группе - Laptop, далее Phone и Mouse
--В январе была выручка выше, чем в феврале
--Клиенты с высоким оборотом: Maria (> 1000)

--6. Повторные клиенты:
select o.customer, sum(o.amount)
from orders o
group by o.customer
having sum(o.amount) > 1
order by sum(o.amount) desc

--7. Средний чек по месяцам:
select
    strftime('%Y-%m', date) as month
    avg(o.amount * o.price) as average_check
from orders o
group by month
order by average_check desc

--8. Самый популярный товар (по количеству покупок):
select o.product, sum(o.amount)
from orders o
group by sum(o.amount) desc
limit 1

--9. Доля каждого товара в общей выручке:
select 
    o.product,
    sum(o.amount * o.price) as revenue,
    sum(o.amount * o.price) * 1.0 / (
        select sum(o.amount * o.price) from orders o
    ) as share
from orders o
group by o.product
order by share desc

--10. Клиент с самым большим чеком:
select o.customer, avg(o.amount * o.price) as average_check
from orders o
group by o.customer
order by average_check desc 
limit 1
--Выводы: Наибольшую выручку приносит товар Laptop, однако по количеству продаж лидирует Mouse;
--Постоянными клиентами являются Maria и Alex - они совершают повторные покупки и формируют основную чать выручки;
--Наблюдается разница между дорогими и дешёвыми товарами: дешёвые покупаются чаще, но дорогие формируют основной доход;
--Средний чек в январе выше, чем в феврале, что может указывать на снижение активности, или изменение структуры продаж;
--Продажи распределены неравномерно: значительная часть выручки сосредоточена в отдельных товарах и клиентах.
