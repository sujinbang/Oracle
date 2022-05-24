-- OUTER JOIN
-- ���ؿ� ���� LEFT, RIGHT��(��� ������ �θ����Ͱ� �����̾����)

SELECT m.idx "ȸ����ȣ", m.names "ȸ���̸�"
     , m.levels, m.mobile, m.email
     , r.idx
  FROM membertbl m
  LEFT OUTER JOIN rentaltbl r
    ON m.idx = r.memberidx
 WHERE r.idx IS null
   AND m.levels <> 'S';


--FROM �ڿ� ������ ���̺��� �������� �θ� ���̺��� ���ʿ� ������ left, �����ʿ� ������ right
SELECT m.idx "ȸ����ȣ", m.names "ȸ���̸�"
     , m.levels, m.mobile, m.email
     , r.idx
  FROM rentaltbl r
 RIGHT OUTER JOIN membertbl m
    ON m.idx = r.memberidx
 WHERE r.idx IS null;
 
 
 
 -- å�� �ѹ��� ������ ���� ȸ��
 SELECT b.idx "å��ȣ", b.names "å����"
      , b.author, b.price
      , r.idx, r.rentaldate, r.returndate
   FROM bookstbl b
   LEFT OUTER JOIN rentaltbl r
   ON b.idx = r.bookidx
  WHERE r.idx is null;

----------------------------------------------------------------------
-------------------------------TEST-----------------------------------
--�ǹ� ����
--SELECT *
--   FROM membertbl m
--   LEFT OUTER JOIN rentaltbl r
--     ON m.idx = r.memberidx
--   RIGHT OUTER JOIN bookstbl b
--   ON b.idx = r.bookidx
-- WHERE m.idx IS NULL;


-- �ѹ��� �뿩���� ���� å�� �帣
SELECT b.idx "å��ȣ", b.names "å����"
      , r.idx, r.rentaldate "�뿩��"
      , d.division, d.names
   FROM rentaltbl r
   RIGHT OUTER JOIN bookstbl b
     ON b.idx = r.bookidx
   RIGHT OUTER JOIN divtbl d
   ON b.division = d.division
 WHERE r.rentaldate IS null;




---------------------------------------------�����𸣴µ� �켱 ��(ȥ����)-------

SELECT b.idx "å��ȣ", b.names "å����", b.price "����"
      , r.idx, r.rentaldate, r.returndate
      , m.names, m.mobile
   FROM rentaltbl r
  RIGHT OUTER JOIN bookstbl b
     ON b.idx = r.bookidx
  RIGHT OUTER JOIN membertbl m
     ON m.idx = r.memberidx
  WHERE r.rentaldate IS null;
   