-- OUTER JOIN
-- 기준에 따라 LEFT, RIGHT로(대신 기준은 부모데이터가 기준이어야함)

SELECT m.idx "회원번호", m.names "회원이름"
     , m.levels, m.mobile, m.email
     , r.idx
  FROM membertbl m
  LEFT OUTER JOIN rentaltbl r
    ON m.idx = r.memberidx
 WHERE r.idx IS null
   AND m.levels <> 'S';


--FROM 뒤에 나오는 테이블을 기준으로 부모 테이블이 왼쪽에 있으면 left, 오른쪽에 있으면 right
SELECT m.idx "회원번호", m.names "회원이름"
     , m.levels, m.mobile, m.email
     , r.idx
  FROM rentaltbl r
 RIGHT OUTER JOIN membertbl m
    ON m.idx = r.memberidx
 WHERE r.idx IS null;
 
 
 
 -- 책을 한번도 빌리지 않은 회원
 SELECT b.idx "책번호", b.names "책제목"
      , b.author, b.price
      , r.idx, r.rentaldate, r.returndate
   FROM bookstbl b
   LEFT OUTER JOIN rentaltbl r
   ON b.idx = r.bookidx
  WHERE r.idx is null;

----------------------------------------------------------------------
-------------------------------TEST-----------------------------------
--의미 없음
--SELECT *
--   FROM membertbl m
--   LEFT OUTER JOIN rentaltbl r
--     ON m.idx = r.memberidx
--   RIGHT OUTER JOIN bookstbl b
--   ON b.idx = r.bookidx
-- WHERE m.idx IS NULL;


-- 한번도 대여하지 않은 책의 장르
SELECT b.idx "책번호", b.names "책제목"
      , r.idx, r.rentaldate "대여일"
      , d.division, d.names
   FROM rentaltbl r
   RIGHT OUTER JOIN bookstbl b
     ON b.idx = r.bookidx
   RIGHT OUTER JOIN divtbl d
   ON b.division = d.division
 WHERE r.rentaldate IS null;




---------------------------------------------뭔지모르는데 우선 됨(혼자함)-------

SELECT b.idx "책번호", b.names "책제목", b.price "가격"
      , r.idx, r.rentaldate, r.returndate
      , m.names, m.mobile
   FROM rentaltbl r
  RIGHT OUTER JOIN bookstbl b
     ON b.idx = r.bookidx
  RIGHT OUTER JOIN membertbl m
     ON m.idx = r.memberidx
  WHERE r.rentaldate IS null;
   