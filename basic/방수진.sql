-- 1��
SELECT LOWER(email), mobile, names, addr, levels
  FROM membertbl
ORDER BY names DESC;

--2��
SELECT names as "å����", author as "���ڸ�"
     , TO_CHAR(releasedate, 'YYYY-MM-DD') as "������", price as "����"
  FROM bookstbl
 ORDER BY price DESC;
 
 --3��
 SELECT d.names as "�帣", b.names as "å����"
      , b.author as "����", TO_CHAR(b.releasedate, 'YYYY-MM-DD') as "������"
      , b.isbn as "å�ڵ��ȣ", b.price as "����"
   FROM bookstbl b
  INNER JOIN divtbl d
    ON d.division = b.division
ORDER BY b.idx DESC;
    
    
--4��

CREATE SEQUENCE SEQ
 START WITH 27
 INCREMENT BY 1;
 
INSERT INTO membertbl
VALUES (
        SEQ.NEXTVAL
      , 'ȫ�浿'
      , 'A'
      , '�λ�� ���� �ʷ���'
      , '010-7989-0909'
      , 'HGD09@NAVER.COM'
      , 'HGD7989'
      , '12345', '', '');


--5��
SELECT NVL(d.names, '--�հ�--') as "�帣"
    , SUM(b.price) as "�帣���հ�ݾ�"
--     d.names as "�帣"
  FROM bookstbl b
 INNER JOIN divtbl d
    ON d.division = b.division
GROUP BY ROLLUP(d.names)
ORDER BY d.names;

