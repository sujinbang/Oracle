
--1. 지금까지 회원들이 구매했던 주문을 마일리지로 적립해주는 이벤트를 한다고 합니다.
--사람들이 구매한 상품 수량만큼 마일리지를 적립, 가지고 있는 마일리지와 더해서 회원번호 별로 현재 얼마인지 보여주세요
--조회하는 컬럼은 회원번호, 회원명, 가지고 있던 마일리지, 
--이벤트로 적립되는 마일리지(컬럼명은 eve_mile로 별칭), 최종 마일리지(컬럼명은 total로 별칭)
--상품 테이블의 상품 마일리지 컬럼을 업데이트하여 이용해주세요.(마일리지 적립율은 5%) 
--      멤버마일리지랑 상관없이 상품 판매가의 5%를 상품마일리지에 업데이트
--개인정보 보호를 위해서 회원명의 중간 글자는 *로 바꿔주세요
--회원번호 순으로 오름차순 정렬


SELECT mem_id, SUM(NVL(prod_mileage, (prod_sale * 0.05)) * cart_qty) eve_mile,
       SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1) name,
       SUM(mem_mileage),
       SUM(NVL(prod_mileage, (prod_sale * 0.05)) * cart_qty) + SUM(mem_mileage) total
  FROM member Inner Join cart
                On(mem_id = cart_member)
              Inner Join prod
                On(cart_prod = prod_id)
 GROUP BY mem_id, SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1)
 ORDER BY mem_id asc;
 
 
 
-------------------------------------------------------------------------------- 
 
SELECT cart_member, SUM(cart_qty) eve_mile,
       SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1) name,
       SUM(mem_mileage),
       SUM(cart_qty) + SUM(mem_mileage) total
       --NVL(prod_mileage, (prod_sale * 0.05))
  FROM member Inner Join cart
                On(mem_id = cart_member)
              Inner Join prod
                On(cart_prod = prod_id)
 GROUP BY cart_member,SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1)
 ORDER BY cart_member asc;


--
--2. 회원과 거래처간에 직접 거래를 한다고 할때, 
--지역이 같을 경우 배송기간이 0일, 지역이 다를 경우에는 배송기간이 1일입니다.
--이때, 당일배송이 가능한 상품들을 조회하세요.
--조회하는 컬럼은 회원번호, 회원명, 거래처명, 상품코드, 상품명
--회원번호 순으로 오름차순 정렬

SELECT mem_id, mem_name, buyer_name, prod_id, prod_name, 
       DECODE(SUBSTR(buyer_add1,1,2),
       SUBSTR(mem_add1,1,2),0) delivery
  FROM member, buyer, prod, cart
 WHERE prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_buyer = buyer_id
   AND DECODE(SUBSTR(buyer_add1,1,2),
       SUBSTR(mem_add1,1,2),0) = 0
ORDER BY mem_id;




--1.각 상품분류명에서 판매가가 가장 높은 제품을 주문한 
--회원명, 회원 주민등록번호, 직업,
--  취미, 상품분류명 조회
--  단,주민등록번호 전체를 추출 (뒤의 첫번째 자리를 제외하고 나머지를 * 로 표시)
--  정렬은 주민등록번호 기준으로 오름차순   
   
SELECT mem_name, 
       mem_regno1 || '-' || SUBSTR(mem_regno2,1,1) || '******'as mem_regno,
       mem_job, mem_like 
  FROM lprod, prod, cart, member,
        (SELECT lprod_nm, lprod_gu, i.prod_max
            FROM (SELECT lprod_gu, lprod_nm, MAX(prod_sale) as prod_max
                    FROM lprod, prod        
                    WHERE lprod_gu = prod_lgu
                    GROUP BY lprod_nm, lprod_gu
                    ORDER BY prod_max DESC) i
                    WHERE ROWNUM = 1) MAX_LPROD    
 WHERE MAX_LPROD.lprod_gu = prod_lgu
   AND prod_id = cart_prod
   AND cart_member = mem_id
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like
 ORDER BY mem_regno asc ;

----------------------------------------------------------------

SELECT lprod_nm, lprod_gu, i.prod_max
FROM (SELECT lprod_gu, lprod_nm, MAX(prod_sale) as prod_max
        FROM lprod, prod        
       WHERE lprod_gu = prod_lgu
       GROUP BY lprod_nm, lprod_gu
       ORDER BY prod_max DESC) i
WHERE ROWNUM = 1;

-----------------------------------------------------------------
-- 정빈씨 답
SELECT mem_name,
       mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******' mem_regno,
       mem_job, mem_like, MAX_LPROD.lprod_nm, MAX_LPROD.MS
  FROM member, cart, prod, lprod,
       (SELECT lprod_gu, lprod_nm, i.MAX_SALE as MS
          FROM(SELECT lprod_gu, lprod_nm, MAX(prod_sale) "MAX_SALE"
                 FROM lprod, prod
                WHERE lprod_gu = prod_lgu
                GROUP BY lprod_gu, lprod_nm
                ORDER BY MAX_SALE DESC) i
         WHERE ROWNUM = 1) "MAX_LPROD"
 WHERE prod_lgu = MAX_LPROD.lprod_gu      
   AND mem_id = cart_member
   AND prod_id = cart_prod
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like, MAX_LPROD.lprod_nm, MAX_LPROD.MS       
 ORDER BY mem_regno;



