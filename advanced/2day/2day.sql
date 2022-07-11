--2day

-- 회원정보 전체 조회
Select *
From member;

---------------------------------------------------------

-- 취미가 "수영"인 회원들 중에 
-- 마일리지의 값이 1000 이상인 
-- 회원아이디, 회원이름, 회원취미, 회원마일리지 조회
-- 정렬은 회원이름 기준 오름차순
Select mem_id, mem_name, mem_like, mem_mileage
From member
Where mem_like = '수영'
  And mem_mileage >= 1000
Order By mem_name Asc;

---------------------------------------------------------

-- 김은대 회원과 동일한 취미를 가지는
-- 회원 아이디, 회원이름, 회원취미 조회하기...
Select mem_like
From member
Where mem_name = '김은대';

Select mem_id, mem_name, mem_like
From member
Where mem_like = (Select mem_like
                    From member
                    Where mem_name = '김은대');
                    
----------------------------------------------------------------                    
                    
-- 주문내역이 있는 회원에 대한 정보를 조회하려고 합니다.
-- 회원아이디, 회원이름, 주문번호, 주문수량 조회하기
Select cart_member, cart_no, cart_qty,
        (Select mem_name 
         From member
         Where mem_id = cart_member) as name
From cart;

-- 주문내역이 있는 회원에 대한 정보를 조회하려고 합니다.
-- 회원아이디, 회원이름, 주문번호, 주문수량, 상품명 조회하기
Select cart_member, cart_no, cart_qty,
        (Select mem_name 
         From member
         Where mem_id = cart_member) as name,
         (Select prod_name
          From prod
          Where prod_id = cart_prod) as p_name
From cart;


-------------------------------------------------------------------

-- a001 회원이 주문한 상품에 대한
-- 상품분류코드, 상품분류명 조회하기..
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu In (Select prod_lgu
                    From prod
                    Where prod_id In (Select cart_prod
                                        From cart
                                        Where cart_member = 'a001'));


------------------------------------------------------------------------

-- 이쁜이 라는 회원이 주문한 상품 중에
-- 상품분류코드가 P201이고,
-- 거래처코드가 P20101인
-- 상품코드, 상품명을 조회해 주세요

select prod_id, prod_name
from prod
where prod_lgu = 'P201'
  And prod_buyer = 'P20101'
  And prod_id in (select cart_prod
                  from cart 
                  where cart_member in (select mem_id
                                              from member
                                              where mem_name='이쁜이'));

--------------------------------------------------------------------------

-- 서브쿼리(SubQuery) 정리
-- (방법1) Select 조회 칼럼 대신에 사용하는 경우
-- : 단일컬럼의 단일행만 조회

-- (방법2) Where 절에 사용하는 경우
--  In () : 단일컬럼의 단일행 또는 다중행 조회 가능
--  =     : 단일컬럼의 단일행만 조회 가능

--------------------------------------------------------------------------

--LIKE

SELECT prod_id 상품코드, prod_name 상품명 
  FROM prod
 WHERE prod_name LIKE '삼%'; -- 삼으로 시작하는 모든걸 찾아라
 
SELECT prod_id 상품코드, prod_name 상품명
  FROM prod
 WHERE prod_name LIKE '_성%'; -- 두번째가 성으로 시작하는 모든걸 찾아라
 
SELECT prod_id 상품코드, prod_name 상품명
  FROM prod
 WHERE prod_name LIKE '%치'; -- 마지막이 치로 끝나는 모든걸 찾아라

------------------------------------------------------------------------

-- ESCAPE

SELECT lprod_gu 분류코드, lprod_nm 분류명
  FROM lprod
 WHERE lprod_nm LIKE '%홍\%' ESCAPE '\'; -- 홍%로 끝나는 값을 찾아라
 
 -----------------------------------------------------------------------
 
 -- CONCAT / ||
 
 SELECT 'a' || 'bcde'
   FROM dual;
 
 SELECT mem_id || 'name is' || mem_name
   FROM member;
 
 ----------------------------------------------------------------------
 
 -- LTRIM, RTRIM, TRIM
 
 SELECT '<' || TRIM('  AAA  ')||'>' TRIM1,
        '<'|| TRIM(LEADING 'a' FROM 'aaAaBaAaa') || '>' TRIM2,
        '<'|| TRIM('a'FROM 'aaAaBaAaa') || '>' TRIM3
   FROM dual;
 
-----------------------------------------------------------------------

-- SUBSTR (c,m,[n])
---- 문자열의 일부분을 선택
---- c문자열의 m위치부터 길이 n만큼의 문자 리턴
---- m이 0 또는 1이면 첫 글자를 의미
---- m이 음수이면 뒤쪽에서부터 처리

SELECT mem_id, SUBSTR(mem_name, 1, 1)성씨
  FROM member;


-- 상품테이블의 상품명의 4째자리부터 2글자가 '칼라'인 상품의 상품코드, 상품명을 검색하시오
-- (Alias 명은 상품코드, 상품명)
SELECT prod_id 상품코드, prod_name 상품명
  FROM prod
 WHERE SUBSTR(prod_name,4,2) = '칼라';
------------------------------------------------------------------------

-- REPLACE

-- 거래처 테이블의 거래처명 중 '삼'->'육'으로 치환
SELECT buyer_name, REPLACE(buyer_name, '삼', '육') "삼->육"
  FROM buyer;

-- 회원테이블의 회원성명 중 '이'씨 성을 -> '리'씨 성으로 치환 검색

SELECT REPLACE(SUBSTR(mem_name,1,1), '이','리') ||
               SUBSTR(mem_name, 2, 2)
  FROM member;
  
  
-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원 이름 조회하기
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원
--     그리고, 회원의 취미가 수영인 회원


SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '수영' 
   AND mem_id in (select cart_member
                   from cart
                   where cart_prod in (select prod_id
                                         from prod
                                        where prod_name LIKE '%삼성전자%'
                                          and prod_lgu in (select lprod_gu
                                                            from lprod
                                                            where lprod_nm Like '%전자%')));


----------------------------------------------------------------------------------------------

-- ROUND

-- 회원 테이블의 마일리지를 12로 나눈 값을 검색
--  (소수 3째자리 반올림, 절삭)

SELECT mem_mileage,
       ROUND(mem_mileage / 12, 2),
       TRUNC(mem_mileage / 12, 2)
  FROM member;


-- MOD(c, n) : n 으로 나눈 나머지

SELECT MOD(10,3)
  FROM dual;

SELECT mem_id, mem_name, mem_regno1, mem_regno2,
       mod(SUBSTR(mem_regno2,1,1) , 2) 성별
  FROM member;
  
--------------------------------------------------------------
-- SYSDATE
---- date + NUMBER
---- date - NUMBER
---- date - date
---- date + 1/24

SELECT SYSDATE"현재시간",
       SYSDATE - 1 "어제 이시간",
       SYSDATE + 1 "내일 이시간"
  FROM dual;
  
-- 회원테이블의 생일과 12000일 째 되는 날을 검색
SELECT mem_bir, mem_bir + 12000
  FROM member;

------------------------------------------------------------
  
-- ADD_MONTH
SELECT ADD_MONTHS(SYSDATE, 5)
  FROM dual;

-- NEXT_DAY
-- LAST_DAY

SELECT NEXT_DAY(SYSDATE, '월요일'),
       LAST_DAY(SYSDATE)
  FROM dual;
  
-- 이번달이 몇일남았는지 검색
SELECT LAST_DAY(SYSDATE) - SYSDATE
  FROM dual;
  
SELECT round(sysdate, 'yyyy'),
       round(sysdate, 'q')
FROM dual;

------------------------------------------------------------

--EXTRACT
SELECT EXTRACT(YEAR FROM SYSDATE) "년도",
       EXTRACT(MONTH FROM SYSDATE) "월",
       EXTRACT(DAY FROM SYSDATE) "일"
  FROM dual;
  
-- 생일이 3월인 회원을 검색
SELECT mem_id, mem_name, mem_bir, EXTRACT(MONTH FROM mem_bir)
  FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;

-------------------------------------------------------------

-- CAST(expr AS type)
SELECT '[' || CAST('Hello'AS CHAR(30)) || ']' "형변환"
  FROM dual;

SELECT '[' || CAST('Hello'AS VARCHAR(30)) || ']' "형변환"
  FROM dual;
  
-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000, 
-- 00-00-00,   00/00/00,   00.00.00
 
SELECT CAST('1997/12/25' AS DATE)
  FROM dual;

-----------------------------------------------------------

-- TO_CHAR
-- TO_NUMBER
-- TO_DATE
SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC"세기"')
  FROM dual;
  
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
               'YYYY.MM.DD HH24:MI')
  FROM dual;
  


-- 상품테이블에서 상품입고일을 '2008-09-28' 형식으로 나오게 검색하시오
SELECT TO_CHAR(buy_date, 'YYYY-MM-DD')
  FROM buyprod;


-- 회원이름과 생일로 다음처럼 출력되게 작성하시오
SELECT mem_name || '님은' || TO_CHAR(mem_bir, 'YYYY') || '년'
       || TO_CHAR(mem_bir, 'MM') || '월 출생이고 태어난 요일은'
       || TO_CHAR(mem_bir, 'Day')
  FROM member;



SELECT TO_CHAR( 1234.6, '99,999.00'),
       TO_CHAR( 1234.6, '9999.99'),
       TO_CHAR( 1234.6, '99999999999.99') -- 9가 메모리 개수(자릿수가 맞지 않아 깨짐)
  FROM dual;
  
  
SELECT TO_CHAR( -1234.6, 'L9999.00PR'),
       TO_CHAR( -1234.6, 'L9999.99PR')
  FROM dual;
  

-- 여자인 회원이 구매한 상품 중에
-- 상품분류에 전자가 포함되어 있고,
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회하기

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer in (select lprod_gu
                      from lprod
                      where lprod_nm LIKE '%전자%')
   AND prod_lgu in (select buyer_id
                    from buyer
                    where buyer_add1 LIKE '서울%') 
                    -- where substr(buyer_add1, 1, 2) = '서울') 과 동일
   AND prod_id in (select cart_prod
                     from cart
                    where cart_member in (select mem_name
                                           from member
                                           where mod(SUBSTR(mem_regno2,1,1), 2) = 0));

----------------------------------------------------------------------------------

-- GROUP

-- AVG
---- DISTOMCT
---- ALL

SELECT ROUND(AVG(DISTINCT prod_cost), 2) as rnd_1, 
       ROUND(AVG(All prod_cost), 2) as rnd_2,
       ROUND(AVG(prod_cost), 2) as rnd_3
  FROM prod;
  

-- COUNT

SELECT COUNT(DISTINCT prod_cost), COUNT(All prod_cost),
       COUNT(prod_cost), COUNT(*)
  FROM prod;
  

-- GROUP
SELECT mem_job,
       COUNT(mem_job) 자료수, COUNT(*) "자료수(*)"
  FROM member
 GROUP BY mem_job;

-- 그룹(집계)함수만 사용하는 경우에는
-- Group By 절을 사용하지 않아도 됨
-- 조회할 일반컬럼이 사용되는 경우에는 Group By절을 사용해야 합니다.
-- - Group By 절에는 조회에 사용된 일반컬럼은 무조건 넣어 줍니다.
-- - 함수를 사용한 경우에는 함수를 사용한 원형 그대로를 넣어줍니다.
-- Order By절에 사용하는 일반컬럼 또는 함수를 이용한 컬럼은
-- - 무조건 Group By절에 넣어 줍니다.
-- sum(), avg(), min(), max(), count()

SELECT mem_job, mem_like,
       count(mem_job) as cnt1, count(*) as cnt2
  FROM member
 WHERE mem_mileage > 10
   AND mem_mileage > 10
 GROUP BY mem_job, mem_like, mem_id
 ORDER BY cnt1, mem_id Desc;


-- 수영을 취미로하는 회원들이
-- 주로 구매하는 상품에 대한 정보를 조회하려고 합니다.
-- 상품명별로 count 집계합니다.
-- 조회컬럼, 상품명, 상품 count
-- 정렬은 상품코드를 기준으로 내림차순

SELECT prod_name, count(prod_name)
  FROM prod
 WHERE prod_id in (select cart_prod
                   from cart
                   where cart_member in (select mem_id
                                         from member
                                         where mem_like = '수영'))
GROUP BY prod_name, prod_id
ORDER BY prod_id Desc;




