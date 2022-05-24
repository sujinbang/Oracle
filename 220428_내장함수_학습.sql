-- 평균
-- 형변환함수 CAST로 되어있음
SELECT CAST(AVG(price) AS number(10,2)) as "책가격 평균"
  FROM bookstbl;

SELECT CAST(AVG(hisal) as number(10,2)) "최고월급평균" 
  FROM salgrade;

-- DUAL (실제 db테이블 사용하지 않을 때)
SELECT CAST('1000' AS NUMBER(10)) FROM dual;
SELECT CAST(1000.08 AS CHAR(10)) FROM dual;

SELECT CAST('202/04/28' AS DATE) FROM dual;

SELECT TO_CHAR(12345, '$999,999') FROM dual;
SELECT TO_CHAR(12345, '999,999') FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS') "현재일시" FROM dual;
--> SYSDATE 매우중요!!!!

--문자열 함수
SELECT CHR(65), UNISTR('\D55C') FROM dual;

--문자열 결합
-- || 또는 CONCAT - CONCAT의 경우는 2개 까지만 허용
SELECT 'Hello, ' || 'World ' || '!' FROM dual;
SELECT CONCAT('Hello,', 'World') FROM dual;

--원하는 문자 찾기
SELECT INSTR('이것이 Oracle이다, 반갑습니다.', 'Oracle') FROM dual;

--대소문자 변환
SELECT UPPER('abcde'), LOWER('ABCDE') FROM dual;

-- 글자 자르기
SELECT SUBSTR('대한민국 만세', 5, 2) FROM dual;

-- 트림
SELECT LTRIM('     안녕하세요'), RTRIM('안녕하세요      '), TRIM('       안녕하세요       ')
FROM dual;

SELECT SYSDATE FROM dual;




