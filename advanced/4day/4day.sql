--4day

--[문제]
-- 상품테이블과 상품분류테이블에서 상품분류코드가 'P101'인 것에 대한
-- 상품분류코드(상품테이블에 있는 컬럼), 상품명, 상품분류명을 조회해 주세요
-- 정렬은 상품아이디로 내림차순...

SELECT prod_lgu, prod_name, lprod_nm
  FROM prod Inner Join lprod
                On(prod_lgu = lprod_gu
                And lprod_gu = 'P101')
 ORDER BY prod_id desc;
 
--[문제]
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보를 확인하려고 합니다.
-- 거래처코드, 거래처명, 회원거주지역(서울 or 인천...) 조회
-- 단, 상품분류명 중에 캐주얼 단어가 포함된 제품에 대해서만...

SELECT buyer_id, buyer_name, SUBSTR(mem_add1,1,2)
  FROM buyer Inner Join prod
                On(buyer_id = prod_buyer)
             Inner Join lprod
                On(prod_lgu = lprod_gu
                And lprod_nm LIKE '%캐주얼%')
             Inner Join cart
                On(prod_id = cart_prod)
             Inner Join member
                On(cart_member = mem_id
                And mem_name = '김형모');
                
                
-- [문제]
-- 상품분류명에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름, 상품분류명 조회하기
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원과
--      회원의 취미가 수영인 회원

SELECT mem_id, mem_name, lprod_nm
  FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu
                And lprod_nm LIKE '%전자%'
                And prod_name LIKE '%삼성전자%')
             Inner Join cart
                On(prod_id = cart_prod)
             Inner Join member
                On(cart_member = mem_id
                And mem_like = '수영');
                
                
-- [문제]
-- 상품분류 테이블과 상품테이블과 거래처테이블과 장바구니 테이블 사용
-- 상품분류코드가 'P101' 인 것을 조회
-- 그리고 정렬은 상품분류명을 기준으로 내림차순,
--                 상품아이디를 기준으로 오름차순 하세요
-- 상품분류명, 상품아이디, 상품판매가, 거래처담당자, 회원아이디, 주문수량을 조회

SELECT lprod_nm, prod_ID, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu
                And lprod_gu = 'P101')
             Inner Join buyer
                On(prod_buyer = buyer_id)
             Inner Join cart
                On(prod_id = cart_prod)
ORDER BY lprod_nm desc, prod_id asc;



-- [문제]
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회하기
-- 단, 상품명에 삼성이 포함된 상품을 구매한 회원에 대해서만
-- 조회컬럼 상품코드, 최대값, 최소값, 평균값, 합계, 갯수

SELECT cart_prod, MAX(cart_qty), MIN(cart_qty),
       ROUND(AVG(cart_qty),2), SUM(cart_qty), COUNT(cart_qty)
  FROM cart, prod
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%삼성%'
 GROUP BY cart_prod;
 
 
 -- [문제]
 -- 거래처코드 및 상품분류코드별로,
 -- 판매가에 대한 최고, 최소, 자료수, 평균, 합계를 조회해 주세요
 -- 조회컬럼, 거래처코드, 거래처명, 상품분류코드, 상품분류명,
 --             판매가에 대한 최고, 최소, 자료수, 평균, 합계
 -- 정렬은 평균을 기준으로 내림차순
 -- 단, 판매가의 평균이 100 이상인 것
 
 SELECT buyer_id, buyer_name, lprod_gu, lprod_nm,
        MAX(prod_sale), MIN(prod_sale), COUNT(prod_sale),
        ROUND(AVG(prod_sale),2) avg, SUM(prod_sale)
   FROM prod, buyer, lprod
  WHERE prod_buyer = buyer_id
    AND prod_lgu = lprod_gu
  GROUP BY buyer_id, buyer_name, lprod_gu, lprod_nm
  Having ROUND(AVG(prod_sale),2) >= 100
  ORDER BY avg desc;
  
  
-- [문제]
-- 거래처별로 group 지어서 매입금액의 합을 검색하고자 합니다
-- 조건은 상품입고테이블의 2005년도 1월의 매입일자(입고일자)인것을
-- 매입금액 = 매입수량 * 매입금액
-- 조회컬럼 : 거래처코드, 거래처명, 매입금액의 합
-- (매입금액의 합이 null인 경우 0으로 조회)
-- 정렬은 거래처 코드 및 거래처명을 기준으로 내림차순

SELECT buyer_id, buyer_name, SUM(NVL(buy_qty*buy_cost, 0)) AS SUMCOST
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND TO_CHAR(buy_date, 'YYYY-MM') = '2005-01'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id desc, buyer_name desc;
 
 
 --[문제]
 -- 거래처별로 group 지어서 매입금액의합을 계산하여
 -- 매입금액의 합이 1천만원 이상인 상품코드, 상품명을 검색하고자합니다
 -- 조건은 상품입고테이블의 2005년도 1월의 매입일자(입고일자)인것을
 -- 매입금액 = 매입수량 * 매입금액
 -- (매입금액의합이 null인 경우 0으로 조회)
 -- 조회칼럼 : 상품코드, 상품명
 -- 정렬은 상품명을 기준으로 오름차순


SELECT prod_id, prod_name
  FROM (SELECT buyer_id, buyer_name, SUM(NVL(buy_qty*buy_cost, 0)) AS SUMCOST
        FROM buyer, prod, buyprod
        WHERE buyer_id = prod_buyer
        AND prod_id = buy_prod
        AND TO_CHAR(buy_date, 'YYYY-MM') = '2005-01'
        GROUP BY buyer_id, buyer_name
        ORDER BY buyer_id desc, buyer_name desc) A, prod P
 WHERE prod_buyer = A.buyer_id
   AND A.sumcost >= 10000000
 ORDER BY prod_name asc; 

---------------------------------------------------------------------------------

-- Outer Join
--  두 table 을 join할 때 누락된 row들이 검색되도록 하는 방법

-- 전체 분류의 상품자료 수를 검색 조회

-- 분류테이블 조회
SELECT *
  FROM lprod;
  
-- 일반 조회
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
 GROUP BY lprod_gu, lprod_nm;
 
-- ORACLE
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+) -- 전체가 나오는 반대쪽에 +를 붙임
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;

-- 국제표준
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod LEFT OUTER JOIN  prod  -- 왼쪽 테이블 전체를 조회하겠다 (LEFT)
                On(lprod_gu = prod_lgu)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;


-- 일반 JOIN
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-30'
 GROUP BY prod_id, prod_name;
 
-- 국제 표준
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod Inner Join buyprod
                On(prod_id = buy_prod
                AND buy_date BETWEEN '2005-01-01' AND '2005-01-30')  
 GROUP BY prod_id, prod_name;

-- OUTER JOIN 사용확인
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod(+)
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-30'
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;

-- 국제 표준
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod LEFT OUTER JOIN buyprod
                On(prod_id = buy_prod
                AND buy_date BETWEEN '2005-01-01' AND '2005-01-30')
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;


---------------------------------------------------------------------------
-- SELF JOIN
-- 거래처코드가 'P30203(참존)'과 동일지역에 속한 거래처만 검색 조회

SELECT B.buyer_id, B.buyer_name, B.buyer_add1 || '' || B.buyer_add2
  FROM buyer A, buyer B
 WHERE A.buyer_id = 'P30203'
   AND SUBSTR(A.buyer_add1, 1, 2) = SUBSTR(B.buyer_add1,1,2);
   
   

