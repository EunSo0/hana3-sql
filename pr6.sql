-- 연습문제
-- 1.
select 부서명 
from 부서 
where 부서번호 = (select 부서번호 from 사원 where 이름 = '배재용');

-- 2. 
