--3day

--[조회 방법 정리]

-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름 조회하기
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원
--    그리고, 회원의 취미가 수영인 회원

SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '수영'
   AND mem_id in 
    (select cart_member
       from cart
      where cart_prod in (select prod_id
                            from prod
                           where prod_name LIKE '%삼성전자%'
                             and  prod_lgu in (select lprod_gu
                                                from lprod
                                               where lprod_nm LIKE '%전자%')));


-- 1. 테이블 찾기
--    - 제시된 컬럼들의 소속 찾기
-- 2. 테이블 간의 관계 찾기
--    - ERD에서 연결된 순서대로 PK와 FK 또는,
--    - 성격이 같은 값으로 연결할 수 있는 컬럼 찾기
-- 3. 작성 순서 정하기
--    - 조회하는 컬럼이 속한 테이블이 가장 밖...1순위...
--    - 1순위 테이블부터 ERD 순서대로 작성...
--    - 조건은 : 해당 컬럼이 속한 테이블에서 조건 처리...


-- [문제]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다.
-- 거래처 코드, 거래처명, 지역(서울 or 인천...), 거래처 전화번호 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만

SELECT buyer_id, buyer_name, substr(buyer_add1, 1, 2) 지역, buyer_comtel
  FROM buyer
 WHERE buyer_lgu in (select lprod_gu
                       from lprod
                      where lprod_nm LIKE '%캐주얼%')
                        
  AND buyer_id in (select prod_buyer
                     from prod
                    where prod_id in (select cart_prod
                                     from cart 
                                     where cart_member in (select mem_id
                                                             from member
                                                            where mem_name = '김형모')));


-- 여자인 회원이 구매한 상품 중에
-- 상품분류에 전자가 포함되어 있고,
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회하기


SELECT prod_id, prod_name
  FROM prod
 WHERE prod_lgu in (select lprod_gu
                      from lprod
                     where lprod_nm LIKE '%전자%')
   AND prod_id in (select cart_prod
                     from cart
                    where cart_member in (select mem_id
                                            from member
                                           where MOD(SUBSTR(mem_regno2,1,1),2) = 0))  -- 여자
   AND prod_buyer in (select buyer_id
                        from buyer
                       where SUBSTR(buyer_add1,1,2) = '서울');



--------------------------------------------------------------------------------------

-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회하기
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수

SELECT cart_prod, 
       MAX(cart_qty), MIN(cart_qty),
       ROUND(AVG(cart_qty),2), SUM(cart_qty),
       COUNT(cart_qty)
  FROM cart
 GROUP BY cart_prod;



-- 오늘이 2005년도 7월 11일이라 가정하고 장바구니테이블에 발생될 추가 주문번호를 검색하시오

-- cart_prod 앞의 4자리는 상품분류코드와 동일
-- cart_no의 앞의 8자리는 년, 월, 일 / 뒷자리는 하루에 주문당 1씩 증가

SELECT MAX(cart_no) as mno, MAX(cart_no)+1 as mpno
  FROM cart
 WHERE substr(cart_no, 1, 8) = '20050711';


-- 회원테이블의 회원전체의 마일리지 평균, 마일리지 합계, 최고 마일리지,
-- 최소 마일리지, 인원수를 검색하시오
SELECT ROUND(AVG(mem_mileage),2), SUM(mem_mileage), MAX(mem_mileage), MIN(mem_mileage),
       count(mem_id)
  FROM member;


-- [문제]
-- 상품테이블에 거래처코드별, 상품분류코드별로,
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회해 주세요
-- 정렬은 자료수를 기준으로 내림차순
-- 추가로, 거래처명, 상품분류명도 조회
-- 단, 합계가 100 이상인 것

SELECT prod_buyer, prod_lgu,
       MAX(prod_sale), MIN(prod_sale),
       ROUND(AVG(prod_sale),2),
       SUM(prod_sale), COUNT(prod_sale),
       (select Distinct buyer_name from buyer
        where buyer_id = prod_buyer) as 거래처명,
       (select Distinct lprod_nm from lprod
        where lprod_gu = prod_lgu) as 상품분류명
  FROM prod
 GROUP BY prod_buyer, prod_lgu
HAVING SUM(prod_sale) >= 100
 ORDER BY COUNT(prod_sale) desc; -- 마지막으로 실행되는 order by는 별칭으로 가능
 

----------------------------------------------------------------------------
-- NULL
-- IS NULL
-- IS NOT NULL
-- NVL

UPDATE buyer SET buyer_charger=NULL
 WHERE buyer_charger LIKE '김%';

UPDATE buyer SET buyer_charger=''
WHERE buyer_charger LIKE '성%';

SELECT buyer_name, buyer_charger
  FROM buyer
 WHERE buyer_charger IS Null;

SELECT buyer_name, buyer_charger
  FROM buyer
 WHERE buyer_charger IS NOT Null;

SELECT buyer_name, 
       NVL(buyer_charger,'없다')
  FROM buyer;

-----------------------------------------------------------------------------

-- SQL의 조건문
-- DECODE
-- CASE WHEN

SELECT prod_lgu,
        DECODE(SUBSTR(prod_lgu, 1, 2),
              'P1', '컴퓨터/전자 제품',
              'P2', '의류',
              'P3', '잡화', 
              '기타') as lgu_nm
  FROM prod;

-----------------------------------------------------------------------------

-- EXIST : 조회된 결과가 하나라도 있으면 True
SELECT prod_id, prod_name, prod_lgu
  FROM prod
 WHERE EXISTS ( select *
                from lprod 
                where lprod_gu = prod_lgu);

----------------------------------------------------------------------------

-- JOIN
-- Cross Join

SELECT * FROM lprod,prod; -- 일반방식
SELECT * FROM lprod CROSS JOIN prod;  -- 국제표준

-- Inner Join *** 조건
-- PK와 FK가 있어야합니다.
-- 관계조건 성립 : PK = FK
-- 관계조건의 갯수 : From절에 제시된 (테이블의 갯수 - 1개)

-- 상품테이블에서 상품코드, 상품명, 분류명을 조회

-- <일반방식>
SELECT prod.prod_id,
       prod.prod_name,
       lprod.lprod_nm,
       buyer_name,
       cart_qty,
       mem_name
  FROM prod, lprod, buyer, cart, member
-- 관계조건식
 WHERE prod.prod_lgu = lprod.lprod_gu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND mem_id = 'a001';


--<국제표준>
SELECT prod.prod_id,
       prod.prod_name,
       lprod.lprod_nm,
       buyer_name,
       cart_qty,
       mem_name
  FROM lprod Inner Join prod
                On( prod_lgu = lprod_gu )
             Inner Join buyer
                On( buyer_id = prod_buyer )
             Inner Join cart
                On ( prod_id = cart_prod )
             Inner Join member
                On ( cart_member = mem_id
                     And mem_id = 'a001');

-- 상품테이블에서 상품코드, 상품명, 분류명, 거래처명,
-- 거래처 주소를 조회
-- 1) 판매가격이 10만원 이하이고
-- 2) 거래처 주소가 부산인 경우만 조회
-- 일반방식, 표준방식.. 모두 해보기..


-- 1. 테이블 찾기 ( prod, lprod, buyer)
-- 2. 관계조건식 찾기
-- 3. 순서 정하기

--<일반방식>
SELECT prod_name, prod_id, lprod_nm, buyer_name, buyer_add1
  FROM prod, lprod, buyer
 WHERE prod_lgu = lprod_gu
   AND prod_buyer = buyer_id
   AND prod_sale <= 100000
   AND SUBSTR(buyer_add1,1,2) = '부산';
   
--<국제표준방식>
SELECT prod_name, prod_id, lprod_nm, buyer_name, buyer_add1
  FROM prod Inner Join lprod
                ON(prod_lgu = lprod_gu
                And prod_sale <= 100000)
            Inner Join buyer
                ON(prod_buyer = buyer_id
                AND SUBSTR(buyer_add1,1,2) = '부산');
                
-- [문제]
-- 상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명을 조회
-- 단, 상품분류 코드가 P101, P201, P301인 것
--      매입수량이 15개 이상인 것
--      서울에 살고 있는 회원 중에 생일이 1974년생인 회원
-- 정렬은 회원아이디 기준 내림차순, 매입수량 기준 오름차순
-- 일반방식, 표준방식..

--<일반방식>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM lprod, prod, buyprod, cart, buyer, member
 WHERE lprod_gu = prod_lgu
   AND prod_buyer = buyer_id
   AND prod_id = buy_prod
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_lgu IN ('P101', 'P201', 'P301')
   AND mem_bir LIKE '74%'
   AND buy_qty >= 15
   AND mem_add1 LIKE '서울%'
ORDER BY mem_id desc, buy_qty;


--<국제표준방식>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu)
             Inner Join buyprod
                On(prod_id = buy_prod
                And prod_lgu IN ('P101', 'P201', 'P301'))
             Inner Join cart
                On(prod_id = cart_prod)
             Inner Join buyer
                On(prod_buyer = buyer_id
                And buy_qty >= 15)
             Inner Join member
                On(cart_member = mem_id
                And mem_bir LIKE '74%'
                And mem_add1 LIKE '서울%')
ORDER BY mem_id desc, buy_qty;


select buyer_bankno, buyer_bank
 from buyer;



--1.상품분류명에서 판매가가 가장 높은 제품을 주문한 
--회원명, 회원 주민등록번호, 직업,
--  취미, 상품분류명 조회
--  단,주민등록번호 전체를 추출 (뒤의 첫번째 자리를 제외하고 나머지를 * 로 표시)
--  정렬은 주민등록번호 기준으로 오름차순


SELECT DISTINCT(mem_name), mem_regno1 || '-' || SUBSTR(mem_regno2,1,1) || '******'as resident_num,
       mem_job, mem_like 
  FROM (SELECT lprod_nm, MAX(prod_sale) as max
         FROM lprod, prod
         WHERE lprod_gu = prod_lgu
         GROUP BY lprod_nm) i,
        lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu
   AND prod_id = cart_prod
   AND cart_member = mem_id
 ORDER BY resident_num asc ;
 
 
 
 SELECT lprod_nm, MAX(prod_sale)
   FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu)
  GROUP BY lprod_nm;
  


--2. 매출에 가장 높은 영향을 준 VIP 고객 뽑기
-- 이메일 골뱅이가 없는 셀을 
-- 
--
--
--
--3. 거래처 주소가 빌딩이고 5층이상인

;
SELECT mem_regno1 || '-' || SUBSTR(mem_regno2,1,1) || '******'
  FROM member;


buyer_mail 골뱅이가 없는 셀을 
@ 뒤로만
------------------------------
SELECT cart_no
  FROM cart;

-- Outer Join ***

SELECT EXTRACT(mem_pass)
  FROM member;
