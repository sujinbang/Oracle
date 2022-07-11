-- 1번
SELECT LOWER(email), mobile, names, addr, levels
  FROM membertbl
ORDER BY names DESC;

--2번
SELECT names as "책제목", author as "저자명"
     , TO_CHAR(releasedate, 'YYYY-MM-DD') as "출판일", price as "가격"
  FROM bookstbl
 ORDER BY price DESC;
 
 --3번
 SELECT d.names as "장르", b.names as "책제목"
      , b.author as "저자", TO_CHAR(b.releasedate, 'YYYY-MM-DD') as "출판일"
      , b.isbn as "책코드번호", b.price as "가격"
   FROM bookstbl b
  INNER JOIN divtbl d
    ON d.division = b.division
ORDER BY b.idx DESC;
    
    
--4번

CREATE SEQUENCE SEQ
 START WITH 27
 INCREMENT BY 1;
 
INSERT INTO membertbl
VALUES (
        SEQ.NEXTVAL
      , '홍길동'
      , 'A'
      , '부산시 동구 초량동'
      , '010-7989-0909'
      , 'HGD09@NAVER.COM'
      , 'HGD7989'
      , '12345', '', '');


--5번
SELECT NVL(d.names, '--합계--') as "장르"
    , SUM(b.price) as "장르별합계금액"
--     d.names as "장르"
  FROM bookstbl b
 INNER JOIN divtbl d
    ON d.division = b.division
GROUP BY ROLLUP(d.names)
ORDER BY d.names;

