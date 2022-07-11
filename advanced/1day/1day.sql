--1. cmd 창 열기

-- 계정없이 서버 접속...
--2. sqlplus /nolog 입력 엔터

--SQL>conn /as sysdba

--SQL>alter user system identified by 새로운암호;
--SQL>alter user sys identified by 새로운암호

--SQL>conn system/새로운암호

-- 접속확인
--SQL>show user


---- 오라클 12버전 이상부터는 아래를 실행해야
---- 일반적인 구분 작성이 가능함
--Alter session set "_ORACLE_SCRIPT"=true;
--
--
---- 위에 실행은 최초 한번 실행
---- 위에 실행 안하면 아래처럼 구문을 작성해야함
--Create User c##busan_06 Identified by dbdb;
--
--
--
---- 1. 사용자 생성하기
--Create User busan_06 
--    Identified By dbdb;
--
---- 패스워드 수정하기
--Alter User busan_06
--    Identified By 수정패스워드;
--
---- 사용자 삭제하기
--Drop User busan_06;
--
---- 2. 권한 부여하기
--Grant Connect, Resource, DBA To busan_06;
--
--
---- 권한 회수하기
--Revoke DBA From busan_06;


-- 회원테이블에서 회원아이디, 회원이름 조회하기
SELECT mem_id, mem_name
FROM member;

-- 상품코드와 상품명 조회하기...
SELECT prod_id, prod_name
FROM prod;

-- 상품코드, 상품명, 판매금액 조회하기
-- 단, 판매금액=판매단가 * 55 로 계산해서 조회합니다.
-- 판매금액이 4백만 이상인 데이터만 조회하기
-- select > from 테이블 > where > 컬럼조회 > order by

SELECT prod_id, prod_name, 
       (prod_sale * 55) as sale
FROM prod
WHERE (prod_sale * 55) >= 4000000
ORDER BY sale desc;

-- 상품정보에서 거래처코드를 조회해 주세요...
-- 단, 중복을 제거하고 조회해주세요
SELECT DISTINCT prod_buyer
FROM prod;

-- 상품중에 판매가격이 17만원인 상품 조회하기..
SELECT prod_name, prod_sale
  FROM prod
 WHERE prod_sale = 170000;

-- 상품중에 판매가격이 17만원이 아닌 상품 조회하기
SELECT prod_name, prod_sale
  FROM prod
 WHERE prod_sale != 170000;

-- 상품중에 판매가격이 17만원 이상이고 20만원 이하인 상품 조회하기
SELECT prod_name, prod_sale
  FROM prod
 WHERE (prod_sale >= 170000) 
   AND (prod_sale <= 200000);

-- 상품중에 판매가격이 17만원 이상 또는 20만원 이하인 상품 조회하기
SELECT prod_name, prod_sale
  FROM prod
 WHERE (prod_sale >= 170000) 
    OR (prod_sale <= 200000);

-- 상품 판매가격이 10만원 이상이고,
-- 상품 거래처(공급업체) 코드가 P30203 또는 P10201 인
-- 상품코드, 판매가격, 공급업체 코드 조회하기
SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE (prod_sale >= 100000)
   AND (prod_buyer = 'P30203'
        OR prod_buyer = 'P10201'); -- or 세트는 ()로 묶어야한다

SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE (prod_sale >= 100000)
   AND prod_buyer NOT IN('P30203','P10201');
    
    
SELECT DISTINCT prod_buyer
  FROM prod
 ORDER BY prod_buyer Asc;
 

SELECT *
  FROM buyer
 WHERE buyer_id NOT In (Select Distinct prod_buyer
                    From prod);


-- 한번도 주문한 적이 없는 회원 아이디, 이름을 조회해 주세요
SELECT mem_id, mem_name
FROM member
WHERE mem_id NOT In (Select Distinct cart_member
                    From Cart);


-- 상품 분류 중에 상품정보에 없는 분류코드만 조회해 주세요
SELECT lprod_gu
FROM lprod
WHERE lprod_gu NOT In (Select Distinct prod_lgu From prod);


-- 회원중에 생일 중에 75년생이 아닌 회원아이디, 생일 조회하기
-- 정렬은 생일 기준 내림차순
SELECT mem_id, mem_bir,
       TO_CHAR(mem_bir, 'yyyy') as birth
FROM member
WHERE TO_CHAR(mem_bir, 'yyyy') != '1975'
ORDER BY birth desc;


SELECT * From member
Where mem_bir Not Between '1975-01-01' And '1975-12-31';


-- 회원 아이디가 a001인 회원이 주문한 상품코드를 조회해 주세요...
-- 조회컬럼은 회원아이디, 상품코드
SELECT cart_prod, cart_member
FROM cart
WHERE cart_member = 'a001';
--WHERE cart_member in (select distinct mem_id from member where mem_id = 'a001');





