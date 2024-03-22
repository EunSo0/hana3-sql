-- 연습문제 
-- 1. 
SELECT *
FROM 제품;

ALTER TABLE 제품 ADD CONSTRAINT CHECK(재고 >= 0);

-- 2.
ALTER TABLE 제품 ADD 재고금액 INT AS (단가*재고) STORED;

-- 3.

-- 실전문제
-- 1.
CREATE TABLE 영화
(
	영화번호 CHAR(5) PRIMARY KEY,
	타이틀 VARCHAR(100) NOT NULL,
    장르 VARCHAR(20) CHECK(장르 IN ('코미디', '드라마', '다큐', 'SF', '액션', '역사', '기타')),
    배우 VARCHAR(100) NOT NULL,
    감독 VARCHAR(50) NOT NULL,
    제작사 VARCHAR(150) NOT NULL,
    개봉일 DATE,
    등록일 DATE DEFAULT(CURDATE())
);

-- 2.
CREATE TABLE 평점관리
(
	번호 INT PRIMARY KEY AUTO_INCREMENT,
    평가자닉네임 VARCHAR(50) NOT NULL,
    영화번호 CHAR(20) NOT NULL REFERENCES 영화(영화번호),
    평점 INT NOT NULL CHECK(평점 BETWEEN 1 AND 5),
    평가 VARCHAR(2000) NOT NULL,
    등록일 DATE DEFAULT(CURDATE())
);

-- 3. 영화 테이블 데이터 추가
INSERT INTO 영화(영화번호, 타이틀, 장르, 배우, 감독, 제작사, 개봉일)
VALUES 
("00001", "파묘", "드라마", "최민식, 김고은", "장재현", "쇼박스", "2024-02-22"),
("00002", "둔:파트2", "액션", "티미시 샬라메, 젠데이아", "드니 뵐뇌브", "레전더리 픽처스", "2024-02-28");

-- 4. 평점관리 테이블 데이터 추가
INSERT INTO 평점관리(평가자닉네임, 영화번호, 평점, 평가) 
VALUES 
("영화광", "00001", 5, "미치도록 스릴이 넘쳐요"),
("무비러브", "00002", 4, "장엄한 스케일이 좋다");

-- 5번 (오류 발생, 영화번호가 영화 테이블에 없기 때문)
INSERT INTO 평점관리(평가자닉네임, 영화번호, 평점, 평가) 
VALUES ("영화광", "00003", 5, "미치도록 스릴이 넘쳐요");

-- 6번 : 영화 레코드를 삭제하려고 하면 오류발생
DELETE FROM 영화
WHERE 영화번호 = '00001';

-- 7번 : 평점관리 테이블 - 영화번호 제약 조건에 ON DELETE CASCADE 추가 후
DELETE FROM 영화
WHERE 영화번호 = '00001';