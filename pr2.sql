-- 1.
SELECT 고객회사명, CONCAT('**', SUBSTR(고객회사명, 3)) AS 고객회사명2, 
		전화번호, REPLACE(REPLACE(전화번호, ')', '-'), '(', "") AS 전화번호2 
FROM 고객;

-- 2.
SELECT 주문번호, 제품번호, 단가, 주문수량, 할인율, 주문수량*단가 AS 주문금액, 
		FLOOR(주문수량 * 단가 * 할인율) AS 할인금액, 
        FLOOR((주문수량 * 단가) - (주문수량 * 단가 * 할인율)) AS 실주문금액  
FROM 주문세부;
        
-- 3. 
SELECT 이름, 생일, TIMESTAMPDIFF(YEAR, 생일, NOW()) AS 만나이, 
		입사일, DATEDIFF(NOW(),입사일) AS 입사일수,
        ADDDATE(입사일, 500) AS 500일후
FROM 사원;
        
-- 4.
SELECT 담당자명, 고객회사명, 
		도시, IF(도시 LIKE '%특별시' OR 도시 LIKE '%광역시', '대도시', '도시') AS 도시구분, 
        마일리지, IF(마일리지 >= 100000, 'VVIP고객',IF(마일리지 >= 10000, 'VIP고객', '일반고객')) AS 마일리지구분
FROM 고객;
        
-- 5. 
SELECT 주문번호, 고객번호, 주문일, YEAR(주문일) AS 주문년도,
		QUARTER(주문일) AS 주문분기, MONTH(주문일) AS 주문월,
		DAY(주문일) AS 주문일, 
		CASE 
			WHEN WEEKDAY(주문일) = 0 THEN '월요일'
			WHEN WEEKDAY(주문일) = 1 THEN '화요일'
			WHEN WEEKDAY(주문일) = 2 THEN '수요일'
			WHEN WEEKDAY(주문일) = 3 THEN '목요일'
			WHEN WEEKDAY(주문일) = 4 THEN '금요일'
			WHEN WEEKDAY(주문일) = 5 THEN '토요일'
        ELSE '일요일'
		END AS 한글요일
FROM 주문;
        
-- 6. 
SELECT 주문번호, 고객번호, 사원번호, 주문일, 요청일, 발송일, DATEDIFF(발송일, 요청일) AS 지연일수
FROM 주문
WHERE DATEDIFF(발송일, 요청일) > 7;

-- 실전문제
-- 1.
SELECT *
FROM 고객
WHERE 담당자명 LIKE '%정%';

-- 2. 
SELECT *
FROM 주문
WHERE YEAR(주문일)=2020 AND QUARTER(주문일) = 2;

-- 3. 
SELECT 제품번호, 제품명, 재고
		,IF(재고 > 100, '과다재고', IF(재고 > 10, '적정', '재고부족')) AS 재고구분
FROM 제품;

-- 4.
SELECT 이름, 부서번호, 직위, 입사일, TIMESTAMPDIFF(MONTH, 입사일, now()) AS 입사개월수
FROM 사원
WHERE TIMESTAMPDIFF(MONTH, 입사일, now()) >= 40;