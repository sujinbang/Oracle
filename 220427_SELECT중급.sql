--SELECT
--ROWNUM
-- �������� ����å ���Ǹ�
SELECT * FROM
(
    SELECT names, TO_CHAR(releasedate, 'YYYY-MM-DD') "������"
      FROM bookstbl
     ORDER BY ������
)
WHERE ROWNUM <=3;

--GRUOP BY

--GRUOP BY�� Į������ SELECT Į������ ��� ���������

--�Լ��� �̷���� column�� WHERE ��� ���� - HAVING ���

SELECT author, division, SUM(price) "�հ�" , SUM(1) "å��"
  FROM bookstbl
 --HAVING SUM(price) >= 200000
 GROUP BY author, division
 ORDER BY division;
 
 
 --GRUOP BY�� ���� ���� ����� �� �ִ� �Լ�
 COUNT : �׷��� �� ROW ��
 MAX : ���� ū �� (Null ����)
 MIN : ���� ���� �� (Null ����)
 SUM : �׷��ε� ��
 AVG : ���
 STDDEV : ǥ������
 
 
 SELECT * FROM bookstbl;
 
 --å ���� ���ġ
 SELECT CAST(AVG(price) AS NUMBER(8, 2)) "���å����" FROM bookstbl;

--å ���� ���Ϻ��å, ������ å
SELECT MAX(price), MIN(price) FROM bookstbl;

-- ��ü ����
SELECT COUNT(*) FROM bookstbl
  WHERE division = 'B003';
  
  --ROLLUP(), CUBE()
  
SELECT division, SUM(price) "�հ�" , SUM(1) "å��"
--SUM(1)�� �ǹ� : ������ Į���� 1�� ���Ƿ� �־ ���� �ͳ��� ��ħ
      , GROUPING_ID(division) "�߰��࿩��"
  FROM bookstbl
--HAVING SUM(price) >= 200000
 GROUP BY ROLLUP(division);
 
 