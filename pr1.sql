update 고객 set 지역 = null where 지역 = '';

-- 연습문제
-- 1.
select * from 고객 where 도시 like "%서울%" and 마일리지 between 15000 and 20000;
-- 2.
select distinct 지역, 도시 from 고객 order by 1,2;
select distinct 지역, 도시 from 고객 order by 1,2;
-- 3.
select * from 고객 where 도시 in ('춘천시','광명시','과천시') and (담당자직위 like '%이사' or 담당자직위 like '%사원');
-- 4.
select * from 고객 where 도시 not like '%특별시' and 도시 not like '%광역시' limit 3;
-- 5.
select * from 고객 where 지역 is not null and 담당자직위 <> '대표 이사';

-- 실습문제
-- 1.
select * from 제품 where 제품명 like '%주스%';
-- 2.
select * from 제품 where 제품명 like '%주스%' and 단가 between 5000 and 10000;
-- 3.
select * from 제품 where 제품번호 in(1,2,4,7,11,20);
-- 4.
select 제품번호, 제품명, 단가, 재고, 단가*재고 as 재고금액 from 제품 order by 재고금액 desc limit 10;