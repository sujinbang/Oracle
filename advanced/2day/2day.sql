--2day

-- ȸ������ ��ü ��ȸ
Select *
From member;

---------------------------------------------------------

-- ��̰� "����"�� ȸ���� �߿� 
-- ���ϸ����� ���� 1000 �̻��� 
-- ȸ�����̵�, ȸ���̸�, ȸ�����, ȸ�����ϸ��� ��ȸ
-- ������ ȸ���̸� ���� ��������
Select mem_id, mem_name, mem_like, mem_mileage
From member
Where mem_like = '����'
  And mem_mileage >= 1000
Order By mem_name Asc;

---------------------------------------------------------

-- ������ ȸ���� ������ ��̸� ������
-- ȸ�� ���̵�, ȸ���̸�, ȸ����� ��ȸ�ϱ�...
Select mem_like
From member
Where mem_name = '������';

Select mem_id, mem_name, mem_like
From member
Where mem_like = (Select mem_like
                    From member
                    Where mem_name = '������');
                    
----------------------------------------------------------------                    
                    
-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ����� ��ȸ�ϱ�
Select cart_member, cart_no, cart_qty,
        (Select mem_name 
         From member
         Where mem_id = cart_member) as name
From cart;

-- �ֹ������� �ִ� ȸ���� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ�����, ��ǰ�� ��ȸ�ϱ�
Select cart_member, cart_no, cart_qty,
        (Select mem_name 
         From member
         Where mem_id = cart_member) as name,
         (Select prod_name
          From prod
          Where prod_id = cart_prod) as p_name
From cart;


-------------------------------------------------------------------

-- a001 ȸ���� �ֹ��� ��ǰ�� ����
-- ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ�ϱ�..
Select lprod_gu, lprod_nm
From lprod
Where lprod_gu In (Select prod_lgu
                    From prod
                    Where prod_id In (Select cart_prod
                                        From cart
                                        Where cart_member = 'a001'));


------------------------------------------------------------------------

-- �̻��� ��� ȸ���� �ֹ��� ��ǰ �߿�
-- ��ǰ�з��ڵ尡 P201�̰�,
-- �ŷ�ó�ڵ尡 P20101��
-- ��ǰ�ڵ�, ��ǰ���� ��ȸ�� �ּ���

select prod_id, prod_name
from prod
where prod_lgu = 'P201'
  And prod_buyer = 'P20101'
  And prod_id in (select cart_prod
                  from cart 
                  where cart_member in (select mem_id
                                              from member
                                              where mem_name='�̻���'));

--------------------------------------------------------------------------

-- ��������(SubQuery) ����
-- (���1) Select ��ȸ Į�� ��ſ� ����ϴ� ���
-- : �����÷��� �����ุ ��ȸ

-- (���2) Where ���� ����ϴ� ���
--  In () : �����÷��� ������ �Ǵ� ������ ��ȸ ����
--  =     : �����÷��� �����ุ ��ȸ ����

--------------------------------------------------------------------------

--LIKE

SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ�� 
  FROM prod
 WHERE prod_name LIKE '��%'; -- ������ �����ϴ� ���� ã�ƶ�
 
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE prod_name LIKE '_��%'; -- �ι�°�� ������ �����ϴ� ���� ã�ƶ�
 
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE prod_name LIKE '%ġ'; -- �������� ġ�� ������ ���� ã�ƶ�

------------------------------------------------------------------------

-- ESCAPE

SELECT lprod_gu �з��ڵ�, lprod_nm �з���
  FROM lprod
 WHERE lprod_nm LIKE '%ȫ\%' ESCAPE '\'; -- ȫ%�� ������ ���� ã�ƶ�
 
 -----------------------------------------------------------------------
 
 -- CONCAT / ||
 
 SELECT 'a' || 'bcde'
   FROM dual;
 
 SELECT mem_id || 'name is' || mem_name
   FROM member;
 
 ----------------------------------------------------------------------
 
 -- LTRIM, RTRIM, TRIM
 
 SELECT '<' || TRIM('  AAA  ')||'>' TRIM1,
        '<'|| TRIM(LEADING 'a' FROM 'aaAaBaAaa') || '>' TRIM2,
        '<'|| TRIM('a'FROM 'aaAaBaAaa') || '>' TRIM3
   FROM dual;
 
-----------------------------------------------------------------------

-- SUBSTR (c,m,[n])
---- ���ڿ��� �Ϻκ��� ����
---- c���ڿ��� m��ġ���� ���� n��ŭ�� ���� ����
---- m�� 0 �Ǵ� 1�̸� ù ���ڸ� �ǹ�
---- m�� �����̸� ���ʿ������� ó��

SELECT mem_id, SUBSTR(mem_name, 1, 1)����
  FROM member;


-- ��ǰ���̺��� ��ǰ���� 4°�ڸ����� 2���ڰ� 'Į��'�� ��ǰ�� ��ǰ�ڵ�, ��ǰ���� �˻��Ͻÿ�
-- (Alias ���� ��ǰ�ڵ�, ��ǰ��)
SELECT prod_id ��ǰ�ڵ�, prod_name ��ǰ��
  FROM prod
 WHERE SUBSTR(prod_name,4,2) = 'Į��';
------------------------------------------------------------------------

-- REPLACE

-- �ŷ�ó ���̺��� �ŷ�ó�� �� '��'->'��'���� ġȯ
SELECT buyer_name, REPLACE(buyer_name, '��', '��') "��->��"
  FROM buyer;

-- ȸ�����̺��� ȸ������ �� '��'�� ���� -> '��'�� ������ ġȯ �˻�

SELECT REPLACE(SUBSTR(mem_name,1,1), '��','��') ||
               SUBSTR(mem_name, 2, 2)
  FROM member;
  
  
-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ�� �̸� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
--     �׸���, ȸ���� ��̰� ������ ȸ��


SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '����' 
   AND mem_id in (select cart_member
                   from cart
                   where cart_prod in (select prod_id
                                         from prod
                                        where prod_name LIKE '%�Ｚ����%'
                                          and prod_lgu in (select lprod_gu
                                                            from lprod
                                                            where lprod_nm Like '%����%')));


----------------------------------------------------------------------------------------------

-- ROUND

-- ȸ�� ���̺��� ���ϸ����� 12�� ���� ���� �˻�
--  (�Ҽ� 3°�ڸ� �ݿø�, ����)

SELECT mem_mileage,
       ROUND(mem_mileage / 12, 2),
       TRUNC(mem_mileage / 12, 2)
  FROM member;


-- MOD(c, n) : n ���� ���� ������

SELECT MOD(10,3)
  FROM dual;

SELECT mem_id, mem_name, mem_regno1, mem_regno2,
       mod(SUBSTR(mem_regno2,1,1) , 2) ����
  FROM member;
  
--------------------------------------------------------------
-- SYSDATE
---- date + NUMBER
---- date - NUMBER
---- date - date
---- date + 1/24

SELECT SYSDATE"����ð�",
       SYSDATE - 1 "���� �̽ð�",
       SYSDATE + 1 "���� �̽ð�"
  FROM dual;
  
-- ȸ�����̺��� ���ϰ� 12000�� ° �Ǵ� ���� �˻�
SELECT mem_bir, mem_bir + 12000
  FROM member;

------------------------------------------------------------
  
-- ADD_MONTH
SELECT ADD_MONTHS(SYSDATE, 5)
  FROM dual;

-- NEXT_DAY
-- LAST_DAY

SELECT NEXT_DAY(SYSDATE, '������'),
       LAST_DAY(SYSDATE)
  FROM dual;
  
-- �̹����� ���ϳ��Ҵ��� �˻�
SELECT LAST_DAY(SYSDATE) - SYSDATE
  FROM dual;
  
SELECT round(sysdate, 'yyyy'),
       round(sysdate, 'q')
FROM dual;

------------------------------------------------------------

--EXTRACT
SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
       EXTRACT(MONTH FROM SYSDATE) "��",
       EXTRACT(DAY FROM SYSDATE) "��"
  FROM dual;
  
-- ������ 3���� ȸ���� �˻�
SELECT mem_id, mem_name, mem_bir, EXTRACT(MONTH FROM mem_bir)
  FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;

-------------------------------------------------------------

-- CAST(expr AS type)
SELECT '[' || CAST('Hello'AS CHAR(30)) || ']' "����ȯ"
  FROM dual;

SELECT '[' || CAST('Hello'AS VARCHAR(30)) || ']' "����ȯ"
  FROM dual;
  
-- 0000-00-00, 0000/00/00, 0000.00.00, 00000000, 
-- 00-00-00,   00/00/00,   00.00.00
 
SELECT CAST('1997/12/25' AS DATE)
  FROM dual;

-----------------------------------------------------------

-- TO_CHAR
-- TO_NUMBER
-- TO_DATE
SELECT TO_CHAR(SYSDATE, 'AD YYYY, CC"����"')
  FROM dual;
  
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
               'YYYY.MM.DD HH24:MI')
  FROM dual;
  


-- ��ǰ���̺��� ��ǰ�԰����� '2008-09-28' �������� ������ �˻��Ͻÿ�
SELECT TO_CHAR(buy_date, 'YYYY-MM-DD')
  FROM buyprod;


-- ȸ���̸��� ���Ϸ� ����ó�� ��µǰ� �ۼ��Ͻÿ�
SELECT mem_name || '����' || TO_CHAR(mem_bir, 'YYYY') || '��'
       || TO_CHAR(mem_bir, 'MM') || '�� ����̰� �¾ ������'
       || TO_CHAR(mem_bir, 'Day')
  FROM member;



SELECT TO_CHAR( 1234.6, '99,999.00'),
       TO_CHAR( 1234.6, '9999.99'),
       TO_CHAR( 1234.6, '99999999999.99') -- 9�� �޸� ����(�ڸ����� ���� �ʾ� ����)
  FROM dual;
  
  
SELECT TO_CHAR( -1234.6, 'L9999.00PR'),
       TO_CHAR( -1234.6, 'L9999.99PR')
  FROM dual;
  

-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�

SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer in (select lprod_gu
                      from lprod
                      where lprod_nm LIKE '%����%')
   AND prod_lgu in (select buyer_id
                    from buyer
                    where buyer_add1 LIKE '����%') 
                    -- where substr(buyer_add1, 1, 2) = '����') �� ����
   AND prod_id in (select cart_prod
                     from cart
                    where cart_member in (select mem_name
                                           from member
                                           where mod(SUBSTR(mem_regno2,1,1), 2) = 0));

----------------------------------------------------------------------------------

-- GROUP

-- AVG
---- DISTOMCT
---- ALL

SELECT ROUND(AVG(DISTINCT prod_cost), 2) as rnd_1, 
       ROUND(AVG(All prod_cost), 2) as rnd_2,
       ROUND(AVG(prod_cost), 2) as rnd_3
  FROM prod;
  

-- COUNT

SELECT COUNT(DISTINCT prod_cost), COUNT(All prod_cost),
       COUNT(prod_cost), COUNT(*)
  FROM prod;
  

-- GROUP
SELECT mem_job,
       COUNT(mem_job) �ڷ��, COUNT(*) "�ڷ��(*)"
  FROM member
 GROUP BY mem_job;

-- �׷�(����)�Լ��� ����ϴ� ��쿡��
-- Group By ���� ������� �ʾƵ� ��
-- ��ȸ�� �Ϲ��÷��� ���Ǵ� ��쿡�� Group By���� ����ؾ� �մϴ�.
-- - Group By ������ ��ȸ�� ���� �Ϲ��÷��� ������ �־� �ݴϴ�.
-- - �Լ��� ����� ��쿡�� �Լ��� ����� ���� �״�θ� �־��ݴϴ�.
-- Order By���� ����ϴ� �Ϲ��÷� �Ǵ� �Լ��� �̿��� �÷���
-- - ������ Group By���� �־� �ݴϴ�.
-- sum(), avg(), min(), max(), count()

SELECT mem_job, mem_like,
       count(mem_job) as cnt1, count(*) as cnt2
  FROM member
 WHERE mem_mileage > 10
   AND mem_mileage > 10
 GROUP BY mem_job, mem_like, mem_id
 ORDER BY cnt1, mem_id Desc;


-- ������ ��̷��ϴ� ȸ������
-- �ַ� �����ϴ� ��ǰ�� ���� ������ ��ȸ�Ϸ��� �մϴ�.
-- ��ǰ���� count �����մϴ�.
-- ��ȸ�÷�, ��ǰ��, ��ǰ count
-- ������ ��ǰ�ڵ带 �������� ��������

SELECT prod_name, count(prod_name)
  FROM prod
 WHERE prod_id in (select cart_prod
                   from cart
                   where cart_member in (select mem_id
                                         from member
                                         where mem_like = '����'))
GROUP BY prod_name, prod_id
ORDER BY prod_id Desc;




