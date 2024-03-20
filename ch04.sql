-- 집계함수(다중행 함수) : count() ,sum(), avr(), min(), max()

select count(*)
from 고객;

select count(고객번호), count(도시), count(지역)
from 고객;

select sum(마일리지), avg(마일리지), min(마일리지), max(마일리지)
from 고객
where 도시 = '서울특별시';

-- group by절 - 특정 컬럼에 대한 집계를 할때
select 도시, count(*) as 고객수, avg(마일리지) as '도시별 평균마일리지'
from 고객
group by 도시;

-- group by 컬럼이름 대신 서수(1,2,...) 사용 가능
select 도시, count(*) as 고객수, avg(마일리지) as '도시별 평균마일리지'
from 고객
group by 1;

-- 두개 이상의 컬럼에 대한 집계
select 담당자직위, 도시, count(*) as 고객수
		, avg(마일리지) as 평균마일리지
from 고객
group by 1,2
order by 1,2;

-- having절 : select문에 들어가는 컬럼과 집계함수에만 직용 가능
select 도시, count(*) as 고객수,
		avg(마일리지) as 평균마일리지
from 고객
group by 도시
having count(*) >= 10;

-- where절과 having절을 함께 사용하는 예
select 도시, 고객번호, sum(마일리지)
from 고객
where 고객번호 like 'T%'
group by 1,2
having sum(마일리지) >= 1000;
-- group by절에는 집계함수를 제외한 select문의 컬럼명을 모두 넣어야함.