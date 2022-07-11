--SELECT
--ROWNUM
-- 출판일이 빠른책 세권만
SELECT * FROM
(
    SELECT names, TO_CHAR(releasedate, 'YYYY-MM-DD') "출판일"
      FROM bookstbl
     ORDER BY 출판일
)
WHERE ROWNUM <=3;

--GRUOP BY

--GRUOP BY의 칼럼값은 SELECT 칼럼값에 모두 적어줘야함

--함수로 이루어진 column은 WHERE 사용 못함 - HAVING 사용

SELECT author, division, SUM(price) "합계" , SUM(1) "책수"
  FROM bookstbl
 --HAVING SUM(price) >= 200000
 GROUP BY author, division
 ORDER BY division;
 
 
 --GRUOP BY를 했을 때만 사용할 수 있는 함수
 COUNT : 그룹핑 된 ROW 수
 MAX : 가장 큰 값 (Null 제외)
 MIN : 가장 낮은 값 (Null 제외)
 SUM : 그룹핑된 값
 AVG : 평균
 STDDEV : 표준편차
 
 
 SELECT * FROM bookstbl;
 
 --책 정가 평균치
 SELECT CAST(AVG(price) AS NUMBER(8, 2)) "평균책정가" FROM bookstbl;

--책 가격 제일비싼책, 저렴한 책
SELECT MAX(price), MIN(price) FROM bookstbl;

-- 전체 갯수
SELECT COUNT(*) FROM bookstbl
  WHERE division = 'B003';
  
  --ROLLUP(), CUBE()
  
SELECT division, SUM(price) "합계" , SUM(1) "책수"
--SUM(1)의 의미 : 임의의 칼럼에 1을 임의로 넣어서 같은 것끼리 합침
      , GROUPING_ID(division) "추가행여부"
  FROM bookstbl
--HAVING SUM(price) >= 200000
 GROUP BY ROLLUP(division);
 
 