-- 조인
-- 1. INNER JOIN
SELECT b.idx, b.author, d.division, d.names AS "책장르명"
     , b.names, to_char(b.releasedate, 'YYYY-MM-DD') AS "출판일"
     , b.isbn
     , to_char(b.price, '999,999') AS "가격"
  FROM bookstbl b
 INNER JOIN divtbl d
    ON b.division = d.division
 WHERE d.division = 'B005';

--<테스트 문제 예시>
--INNER JOIN, 테이블 3개
-- *) 윈도우 단축기 - 한줄 삭제 : shift + delete
-- 반납하지 않은 고객의 정보
SELECT r.idx, TO_CHAR(r.rentaldate, 'YYYY-DD-MM') as "대여일"
     , TO_CHAR(r.returndate, 'YYYY-DD-MM') as "반납일"
     , m.names as "대여자"
     , b.names as "빌린책"
  FROM membertbl m
 INNER JOIN rentaltbl r
    ON m.idx = r.memberidx
 INNER JOIN bookstbl b
    ON b.idx = r.bookidx
 WHERE r.returndate IS null -- null값은 =로 안됨!!
 ORDER BY r.idx;
 

