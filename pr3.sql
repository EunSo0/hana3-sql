-- 확인문제
SELECT  담당자직위
		,MAX(마일리지) AS '최대 마일리지'
FROM 고객
WHERE 도시 LIKE '%광역시'
GROUP BY 담당자직위
HAVING MAX(마일리지) >= 10000;

-- 연습문제
-- 1. 고객 테이블의 도시 컬럼에는 몇 개의 도시가 들어있을까?
--    도시 수와 중복 값을 제외한 도시 수를 보이시오.
--   COUNT()안에 DISTINCT를 넣으면 중복 값을 한 번씩만 셉니다.
SELECT 도시
	  ,COUNT(도시)
      ,COUNT(DISTINCT 도시)
FROM 고객
GROUP BY 도시;

-- 2. 주문 테이블에서 주문년도별로 주문건수를 조회하시오.
-- GROUP BY절에는 SELECT절에 있는 집계 함수를 제외한
--  나머지 컬럼이나 함수, 수식을 반드시 넣어주어야 합니다.
SELECT YEAR(주문일) AS 주문년도
       ,COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일);

-- 3. 결과 화면을 참조하여 주문 테이블에서 (주문년도, 분기)별 주문건수,
--  주문년도별 주문건수, 전체 주문건수를 한번에 조회하시오.
-- YEAR()를 사용하면 주문년도만 얻을 수 있고,
-- QUARTER()를 사용하면 분기만 얻을 수 있습니다.
-- WITH ROLLUP을 추가하면 GROUP BY의 결과와 함께
-- 주문년도별 주문건수와 전체 주문건수도 한번에 확인 할 수 있습니다.
-- WITH ROLLUP : 분류별 소계, 총계를 구하는 구문
SELECT YEAR(주문일) AS 주문년도
      ,QUARTER(주문일) AS 분기
      ,COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일)
        ,QUARTER(주문일)
WITH ROLLUP;

-- 4. 주문 테이블에서 요청일보다 발송이 늦어진 주문내역이
-- 월별로 몇 건씩인지 요약하여 조회하시오. 이때 주문월 순서대로 정렬하여 보이시오.
-- MONTH() 함수를 사용하면 주문일 컬럼에서 월을 얻을 수 있습니다.
SELECT MONTH(주문일) AS 주문월
      ,COUNT(*) AS 주문건수
FROM 주문
WHERE 요청일 < 발송일
GROUP BY MONTH(주문일)
ORDER BY MONTH(주문일) ASC;

-- 5.제품 테이블에서 ‘아이스크림’제품들에 대해서 제품명별로 재고합을 보이시오.
-- where절 분류(그루핑)하기 전에 먼저 행을 제거(가져오거나)
SELECT 제품명
      ,SUM(재고) AS 재고합
FROM 제품
WHERE 제품명 LIKE '%아이스크림%'
GROUP BY 제품명;
-- 전체 제품에 대해서 분류하고, 나중에 Having을 제거
SELECT 제품명
      ,SUM(재고) AS 재고합
FROM 제품
GROUP BY 제품명
HAVING 제품명 LIKE '%아이스크림%';

-- 6. 고객 테이블에서 마일리지가 50,000점 이상인 고객은 ‘VIP고객’,
--  나머지 고객은 ‘일반고객’으로 구분하고, 고객구분별로 고객수와
-- 평균마일리지를 보이시오.
SELECT IF(마일리지 >= 50000, 'VIP고객', '일반고객') AS 고객구분
	  ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY IF(마일리지 >= 50000, 'VIP고객', '일반고객');

-- 실전문제
-- 1. 주문세부 테이블에서 주문수량합과 주문금액합을 보이시오.
SELECT *
FROM 주문세부;
DESC 주문세부; -- 테이블의 구조 출력
-- 주문번호 + 제품번호 2개 기본키로 동작함. 복합키라고 한다.
SELECT SUM(주문수량) AS 주문수량합
	 ,SUM(단가 * 주문수량) AS 주문금액합
FROM 주문세부;

-- 2. 주문세부 테이블에서 주문번호별로 주문된 제품번호의 목록과 주문금액합을 보이시오.
--  주문번호는 주문 건당 하나씩 발급됨.
SELECT 주문번호,제품번호
FROM 주문세부
GROUP BY 주문번호,제품번호
ORDER BY 주문번호;
SELECT 주문번호,
		제품번호,
		COUNT(*),
		SUM(단가*주문수량) AS 주문금액합
FROM 주문세부
GROUP BY 주문번호, 제품번호
ORDER BY 주문번호;

-- 3. 주문 테이블에서 2021년 주문내역에 대해서 고객번호별로 주문건수를 보이된,
--     주문건수가 많은 상위 3건의 고객의 정보만 보이시오.
SELECT 고객번호,
	COUNT(*) AS 주문건수
FROM 주문
WHERE YEAR(주문일) = 2021
GROUP BY 고객번호
ORDER BY 주문건수 DESC

LIMIT 3;
-- 4. 사원 테이블에서 직위별로 사원수와 사원이름목록을 보이시오.
SELECT 직위, COUNT(직위), 이름
FROM 사원
GROUP BY 직위, 이름
ORDER BY 직위;
-- GROUP_CONCAT() : 여러행의 문자열을 결합해줌.
SELECT 직위, COUNT(직위), GROUP_CONCAT(이름 SEPARATOR ', ')
FROM 사원
GROUP BY 직위
ORDER BY 직위;
-- WITH ROLLUP : 소계와 총계를 구하는 구문
-- 고객테이블에서 지역이 null인 도시별 고개수와 평균마일리지를 구하시오.
SELECT 도시
	,COUNT(*) AS 고객수
	,AVG(마일리지) AS 평균마일리지
FROM 고객
WHERE 지역 IS NULL
GROUP BY 도시
WITH ROLLUP;
-- null 란에 '총계' 문구를 넣어주자
SELECT IFNULL(도시, '총계') AS 도시
	,COUNT(*) AS 고객수
	,AVG(마일리지) AS 평균마일리지
FROM 고객
WHERE 지역 IS NULL
GROUP BY 도시
WITH ROLLUP;
-- 그루핑하는 컬럼마다 소계를 출력, 마지막에 총계를 출력한다.
SELECT 담당자직위, 도시
       ,COUNT(*) AS 고객수
FROM 고객
WHERE 담당자직위 LIKE '%마케팅%'
GROUP BY 1, 2
WITH ROLLUP;
SELECT 지역
		,COUNT(*) AS 고객수
		,GROUPING(지역) AS 구분 -- 1이면 ROLLUP 행, 0이면 아님
FROM 고객
WHERE 담당자직위 = '대표 이사'
GROUP BY 지역
WITH ROLLUP;
-- GROUP_CONCAT() : 여러행의 문자열을 결합해서 단일값으로 반환
-- 사원테이블의 이름을 모두 결합하여 출력
SELECT GROUP_CONCAT(이름)
FROM 사원;
-- 고객테이블의 지역 이름을 모두 결합하여 출력
SELECT GROUP_CONCAT(DISTINCT 지역)
FROM 고객;
-- 도시별 고객회사명을 단일값으로 반환(연결할 때는 꼼마를 사용)
SELECT 도시
		,GROUP_CONCAT(고객회사명) AS 고객회사명목록
FROM 고객
GROUP BY 도시;