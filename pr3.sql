-- 1. 
select count(도시), count(distinct 도시) from 고객;

-- 2.
select year(주문일) as 주문년도, count(*) as 주문건수 
from 주문 
group by year(주문일);

-- 3.
select year(주문일), quarter(주문일), count(*) as 주문건수
from 주문
group by 1,2 with rollup;

-- 4. 
select month(주문일) as 주문월, count(*) as 주문건수
from 주문
where datediff(발송일, 요청일) > 0
group by 1
order by 1;

-- 5.
select 제품명, 재고 as 재고합
from 제품
where 제품명 like '%아이스크림%';

-- 6. 
select if(마일리지 > 50000, 'VIP고객', '일반고객') as 고객구분, 
		count(*) as 고객수, avg(마일리지) as 평균마일리지
from 고객
group by if(마일리지 > 50000, 'VIP고객', '일반고객');


-- 실전문제
-- 1.
select sum(주문수량) as 주문수량합,sum(단가*주문수량) as 주문금액합
from 주문세부;

-- 2. 
select 제품번호, sum(단가*주문수량) as 주문금액합
from 주문세부
group by 주문번호, 제품번호;

-- 3.
select 고객번호, count(*) as 주문번호
from 주문
where year(주문일) = 2021
group by 고객번호
order by count(*) desc
limit 3;

-- 4.
select 이름, count(*) over() as 사원수
from 사원;