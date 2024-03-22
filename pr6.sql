-- 연습문제
-- 1.
select 부서명 
from 부서 
where 부서번호 = (select 부서번호 from 사원 where 이름 = '배재용');

-- 2. 
select * 
from 제품
where not exists (select * from 주문세부 where 제품.제품번호 = 주문세부.제품번호);

-- 3.
with 담당별주문 as
(
	select 고객번호, count(*) as 주문건수, min(주문일) as 최초주문일, max(주문일) as 최종주문일
	from 주문
	group by 1
)
select 담당자명, 고객회사명, 주문건수, 최초주문일, 최종주문일
from 고객, 담당별주문
where 고객.고객번호 = 담당별주문.고객번호;

-- 실전문제 
-- 1.
select *
from 제품 
where 단가 = (select max(단가) from 제품);

-- 2.
select 제품명, sum(주문세부.주문수량) as 주문수량합
from 제품
inner join 주문세부
on 제품.제품번호 = 주문세부.제품번호
where 제품.단가 = (select MAX(단가) from 제품)
group by 제품명;

-- 3.
select sum(주문수량) as 아이스크림_주문수량합
from 주문세부
where 주문세부.제품번호 in (select 제품번호
						from 제품
						where 제품명 like '%아이스크림%');
                        
-- 4.
SELECT * FROM 세계무역.주문;
SELECT * FROM 세계무역.주문세부;

select year(주문.주문일) as 주문년도, sum(1) as 주문건수
from 주문
join 주문세부
on 주문.주문번호 = 주문세부.주문번호
where 주문.고객번호 in (select 고객번호
					from 고객
					where 도시 = '서울특별시')
group by 1;