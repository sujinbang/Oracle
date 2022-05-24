--INSERT


--CREATE TABLE
CREATE TABLE testTBL
(
    id NUMBER(4) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10),
    age NUMBER(3)
);

--INSERT
INSERT INTO testTBL (id, userNAme, age) VALUES (1, '홍길동', 99);

INSERT INTO testTBL VALUES (2, N'홍길순', 97);
--오류, 값의 수가 일치하지 않음
INSERT INTO testTBL VALUES (3, N'홍길자');
--대체방법
INSERT INTO testTBL VALUES (3, N'홍길자', NULL);

INSERT INTO testTBL (ID, userName) VALUES (4, '성명건');

-- 되돌리기
ROLLBACK;

-- 완전저장
COMMIT;

-- test table
-- CREATE TABLE
CREATE TABLE testTBL2
(
    id NUMBER(4) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10),
    age NUMBER(3)
);

--시퀀스 생성
CREATE SEQUENCE test2Seq
 START WITH 1 -- 시작
 INCREMENT BY 1; -- 증가값
 
 --시퀀스 사용 입력
 --시퀀스 자료에서 한번 사용한 id는 다시 사용하지 않는다
 
 INSERT INTO testTBL2(id, userName, age)
  VALUES (TEST2SEQ.nextval, '성명건', 47);
  
COMMIT;

-- UPDATE(WHERE절 없이 진행 x -- 매우 중요!)

UPDATE testTbl2
    SET username = '홍길순'
      , age = 97
WHERE id = 2;

-- DELETE (WHERE절 없이 진행 x -- 매우 중요!)

DELETE FROM testTBL2 WHERE id = 6;

