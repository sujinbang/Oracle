--UNION 칼럼이 같지 않아도 합집합(대신 칼럼의 형태를 맞춰줘야함
-- 예시
SELECT b.idx, b.names
  FROM bookstbl b
 UNION 
SELECT m.idx, m.levels
  FROM membertbl m;

SELECT b.idx, TO_CHAR(b.price)
  FROM bookstbl b
 UNION 
SELECT m.idx, m.levels
  FROM membertbl m;
  
-----------------------------------------------------------------

SELECT idx, price FROM bookstbl
UNION
SELECT idx, names FROM membertbl;

--테이블 생성
CREATE TABLE userTBL
(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10) NOT NULL,
    addr NVARCHAR2(50)
);

--DROP TABLE userTBL; -- 테이블 삭제
-- 부모 자식 관계 데이터의 중복되는 칼럼의 데이터 형태는 무조건 동일해야함 --> 문자와 숫자만 구분되어야하는지?
CREATE TABLE buy TBL
(
    idNum NUMBER(8) NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    buyDate DATE,
    
    FOREIGN KEY(userID) REFERENCES userTBL(userID)
-- FOREIGN KEY의 명칭이 다르다면 해당 테이블의 명칭을 가져와야함
-- 예를 들어 FOREIGN KEY(memberidx) REFERENCES memberTBL(idx)
--> rentaltbl.memberidx = membertbl.idx


-- 테이블 삭제시 자식테이블 부터 삭제가능(부모테이블부터 삭제 x)

--key : pk, fk, unique, check, default, null

