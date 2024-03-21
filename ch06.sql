-- 내문서 > sql 폴더
-- ch06.sql

-- 서브쿼리 : SQL문 내부에서 사용하는 SELECT문

-- 단일행 서브쿼리
-- 최고 마일리지를 보유한 고객의 정보를 구하시오.
-- 최고 마일리지를 구하기
SELECT MAX(마일리지)
FROM 고객;

SELECT *
FROM 고객
WHERE 마일리지 = 128790;

SELECT *
FROM 고객
WHERE 마일리지 = ( SELECT MAX(마일리지)
                    FROM 고객 );

SELECT 고객회사명, 담당자명
FROM 고객
WHERE 고객번호 = ( SELECT 고객번호 FROM 주문
                    WHERE 주문번호 = 'H0250' );

-- 복수행 서브쿼리 : 복수행 비교연산자 IN, ANY(SOME), ALL, EXISTS

-- '부산광역시' 고객이 주문한 주문건수를 출력하기
-- IN : ~중의 하나라도 
SELECT COUNT(*) AS 주문건수
FROM 주문
WHERE 고객번호 IN ( SELECT 고객번호 FROM 고객
                    WHERE 도시 = '부산광역시' );
-- ANY :  마일리지 > 부산마일리지 OR ... OR ... OR                    
SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지 > ANY( SELECT 마일리지 FROM 고객
                      WHERE 도시 = '부산광역시' ); 
-- ALL :  AND ... AND ... AND 
SELECT 담당자명, 고객회사명, 마일리지
FROM 고객
WHERE 마일리지 > ALL ( SELECT AVG(마일리지) FROM 고객 
                        GROUP BY 지역 );
-- EXISTS :  행의 존재여부로 비교
-- 주문이력이 있는 고객의 정보만 출력하기
SELECT 고객번호, 고객회사명
FROM 고객
WHERE EXISTS ( SELECT * FROM 주문 WHERE 고객번호 = 고객.고객번호 );

-- 인라인 뷰 : FROM절 안의 서브쿼리
SELECT 담당자명, 고객회사명, 마일리지, 고객.도시, 도시_평균마일리지,
       도시_평균마일리지 - 마일리지 AS 차이
FROM 고객,
     (
     	SELECT 도시, AVG(마일리지) AS 도시_평균마일리지
     	FROM 고객
     	GROUP BY 도시
     ) AS 도시별요약
WHERE 고객.도시 = 도시별요약.도시;

-- 스칼라 서브쿼리 : 메인 쿼리의 SELECT문안에 사용되는 서브쿼리
-- 행을 0개 반환하면 null이 되고, 2개이상 반환하면 오류 발생
SELECT 고객번호, 담당자명, (SELECT MAX(주문일) FROM 주문
                            WHERE 주문.고객번호 = 고객.고객번호) AS 최종주문일
FROM 고객;

-- CTE(Common Table Expression)
WITH 도시별요약 AS 
(
	SELECT 도시, AVG(마일리지) AS 도시_평균마일리지
	FROM 고객 
	GROUP BY 도시
)
SELECT 담당자명
      ,고객회사명
      ,마일리지
      ,고객.도시
      ,도시_평균마일리지
      ,도시_평균마일리지 - 마일리지 AS 차이
FROM 고객
	,도시별요약
WHERE 고객.도시 = 도시별요약.도시;