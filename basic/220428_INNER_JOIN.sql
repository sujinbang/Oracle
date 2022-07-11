-- ����
-- 1. INNER JOIN
SELECT b.idx, b.author, d.division, d.names AS "å�帣��"
     , b.names, to_char(b.releasedate, 'YYYY-MM-DD') AS "������"
     , b.isbn
     , to_char(b.price, '999,999') AS "����"
  FROM bookstbl b
 INNER JOIN divtbl d
    ON b.division = d.division
 WHERE d.division = 'B005';

--<�׽�Ʈ ���� ����>
--INNER JOIN, ���̺� 3��
-- *) ������ ����� - ���� ���� : shift + delete
-- �ݳ����� ���� ���� ����
SELECT r.idx, TO_CHAR(r.rentaldate, 'YYYY-DD-MM') as "�뿩��"
     , TO_CHAR(r.returndate, 'YYYY-DD-MM') as "�ݳ���"
     , m.names as "�뿩��"
     , b.names as "����å"
  FROM membertbl m
 INNER JOIN rentaltbl r
    ON m.idx = r.memberidx
 INNER JOIN bookstbl b
    ON b.idx = r.bookidx
 WHERE r.returndate IS null -- null���� =�� �ȵ�!!
 ORDER BY r.idx;
 

