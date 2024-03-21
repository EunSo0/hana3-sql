-- 1.
select 제품명, SUM(주문수량) as 주문수량합, SUM(주문수량*주문세부.단가) as 주문급액합
from 제품
inner join 주문세부
on 제품.제품번호 = 주문세부.제품번호
group by 1;

-- 2. 
select year(주문.주문일), 제품.제품명, sum(주문세부.주문수량) as 주문수량합
from 주문세부
inner join 주문
on 주문세부.주문번호 = 주문.주문번호 
inner join 제품 
on 주문세부.제품번호 = 제품.제품번호
where 제품.제품명 like '%아이스크림%'
group by 1,2
order by 1,2;

-- 3.
select 제품.제품명, sum(주문세부.주문수량) as 주문수량합
from 제품
left outer join 주문세부 
on 제품.제품번호 = 주문세부.제품번호
group by 1;

-- 4.
select 고객번호, 고객회사명, 담당자명, 마일리지등급.등급명,마일리지
from 고객
join 마일리지등급 
on 마일리지 between 하한마일리지 and 상한마일리지
where 마일리지등급.등급명 = 'A';

-- 실전문제 
-- 1. 
select 마일리지등급.등급명, count(*)
from 고객
join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
group by 1;

-- 2.
select 고객.*
from 고객
join 주문
on 고객.고객번호 = 주문.고객번호
where 주문.주문번호 = 'H0249';

-- 3.
select 고객.*
from 고객
join 주문
on 고객.고객번호 = 주문.고객번호
where 주문.주문일 = '2020-04-09';

-- 4.
select 고객.도시, sum(주문세부.주문수량*주문세부.단가) as 주문금액합
from 고객 
join 주문
on 고객.고객번호 = 주문.고객번호
join 주문세부
on 주문.주문번호 = 주문세부.주문번호
group by 1
order by 2 desc
limit 5;
