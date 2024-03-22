select *
from 부서;

insert into 부서
values ('A5', '마케팅부');

INSERT INTO 제품
VALUES(91, '연어피클소스',NULL, 5000, 40);

INSERT INTO 사원(사원번호, 이름, 직위, 성별, 입사일)
VALUES('E20', '김사과','수습사원', '남', CURDATE())
	 ,('E21', '박바나나','수습사원', '여', CURDATE())
     ,('E22', '정오렌지','수습사원', '여', CURDATE());
     
SELECT * FROM 제품;

UPDATE 사원
SET 이름 = '김레몬'
WHERE 사원번호 = 'E20';

UPDATE 제품
SET 포장단위 = '200 ml bottles'
WHERE 제품번호 = 91;

DELETE FROM 사원
ORDER BY 입사일 DESC
LIMIT 3;

DELETE FROM 제품
WHERE 제품번호 = 91;

INSERT INTO 제품(제품번호, 제품명, 단가, 재고)
VALUES(91, '연어피클핫소스', 6000, 50)
ON DUPLICATE KEY UPDATE 제품명 = '연어피클핫소스', 단가 = 6000, 재고 = 50;

-- 연습문제 
SELECT * FROM 제품;
-- 1.
INSERT INTO 제품
VALUES(95,'망고베리 아이스크림', '400g', 800, 30);

-- 2.
INSERT INTO 제품(제품번호, 제품명, 단가)
VALUES(96,'눈꽃빙수맛 아이스크림', 2000);

-- 3.
UPDATE 제품
SET 재고 = 30
WHERE 제품번호 = 96;

-- 4.
SELECT * FROM 사원;
SELECT * FROM 부서;

DELETE FROM 부서
WHERE 부서.부서번호 <> ALL (SELECT DISTINCT 부서번호 FROM 사원);

DELETE FROM 부서
WHERE NOT EXISTS (SELECT * FROM 사원 WHERE 부서.부서번호 = 사원.부서번호);

DELETE 부서
FROM 부서
LEFT JOIN 사원
ON 부서.부서번호 = 사원.부서번호
WHERE 사원.부서번호 IS NULL;

-- 실습문제
-- 1. 
SELECT * FROM 고객;

INSERT INTO 고객(고객번호, 담당자명, 고객회사명, 도시)
VALUES('ZZZAA', '한동욱', '자유트레이딩', '서울특별시');

-- 2.
UPDATE 고객
SET 도시 = '부산광역시', 마일리지 = 100, 담당자직위 = '대표 이사'
WHERE 고객번호='ZZZAA';

-- 4.
SELECT * FROM 사원;

INSERT INTO 사원(사원번호, 이름, 직위)
VALUES ('E15', '이석진', '수습사원')
ON DUPLICATE KEY UPDATE 사원번호='E15', 이름='이석진', 직위='수습사원';

-- 5.
DELETE FROM 고객 
WHERE 고객번호 = 'ZZZAA';

-- 6.
DELETE FROM 사원
WHERE 사원번호 = 'E15';
