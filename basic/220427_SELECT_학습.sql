-- ��ȸ ������(where) (�ּ�)
SELECT names, levels, addr, mobile
FROM membertbl
WHERE names = '�����';

--idx�� 5~10���̸� ��ȸ, level�� A�� ����� ��ȸ
SELECT * FROM membertbl
WHERE (idx >= 5 AND idx <= 10) OR levels = 'A';

-- BETWEEN A and B
-- IDX�� 5~10������ ȸ�� ���ڵ� ��ȸ
SELECT * FROM membertbl
WHERE idx BETWEEN 5 AND 10;

-- OR��
SELECT * FROM membertbl
WHERE levels = 'B' OR levels = 'D' OR levels = 'S';

-- IN
SELECT * FROM membertbl
 WHERE levels NOT IN ('B', 'D', 'S');

-- LIKE ���� �˻�
SELECT * FROM bookstbl
 WHERE names LIKE '_����__'; -- '������%', '������__', '_����%'

-- LIKE ���� �˻�
SELECT * FROM bookstbl
 WHERE description LIKE '%��ǰ%'
   AND division = 'B005';


-- �������� ANY/ALL/SOME WHERE�� ��������
SELECT * FROM bookstbl
 WHERE division IN (SELECT division FROM divtbl
 WHERE names = '�߸�');

-- �������� 2 Culumn ��� ��������
SELECT b.idx as "��ȣ"
     , b.author "����"
     , b.division "�帣�ڵ�"
     , (SELECT d.names FROM divtbl D WHERE d.division = b.division) as "�帣"
     --d.division : divtbl, b.division : bookstbl
     , b.names "å����"
     , b.price "����"

  FROM bookstbl b
 WHERE b.division = 'B005';

-- �������� 3 FROM�� ��������
SELECT *
  FROM (SELECT b.author, b.division, b.names FROM bookstbl b);
  --������ ���̺� ���� ((SELECTĮ����)�� ����)
  
  
-- �������� ANY
SELECT * FROM bookstbl
 WHERE division IN (SELECT division FROM divtbl
 WHERE division LIKE 'B%');
 

--���� ORDER BY (ASC[ascending], DESC[descending](ASC�� �⺻��))
SELECT idx, author, names, releasedate, price
  FROM bookstbl
 ORDER BY price, idx DESC;
 
-- DISTINCT : �ߺ��� ����
SELECT DISTINCT price
  FROM bookstbl;

-- DISTINCT
SELECT * FROM divtbl
WHERE division NOT IN (
SELECT DISTINCT division
  FROM bookstbl);
 
 