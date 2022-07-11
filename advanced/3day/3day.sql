--3day

--[��ȸ ��� ����]

-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
--    �׸���, ȸ���� ��̰� ������ ȸ��

SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '����'
   AND mem_id in 
    (select cart_member
       from cart
      where cart_prod in (select prod_id
                            from prod
                           where prod_name LIKE '%�Ｚ����%'
                             and  prod_lgu in (select lprod_gu
                                                from lprod
                                               where lprod_nm LIKE '%����%')));


-- 1. ���̺� ã��
--    - ���õ� �÷����� �Ҽ� ã��
-- 2. ���̺� ���� ���� ã��
--    - ERD���� ����� ������� PK�� FK �Ǵ�,
--    - ������ ���� ������ ������ �� �ִ� �÷� ã��
-- 3. �ۼ� ���� ���ϱ�
--    - ��ȸ�ϴ� �÷��� ���� ���̺��� ���� ��...1����...
--    - 1���� ���̺���� ERD ������� �ۼ�...
--    - ������ : �ش� �÷��� ���� ���̺��� ���� ó��...


-- [����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó �ڵ�, �ŷ�ó��, ����(���� or ��õ...), �ŷ�ó ��ȭ��ȣ ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���

SELECT buyer_id, buyer_name, substr(buyer_add1, 1, 2) ����, buyer_comtel
  FROM buyer
 WHERE buyer_lgu in (select lprod_gu
                       from lprod
                      where lprod_nm LIKE '%ĳ�־�%')
                        
  AND buyer_id in (select prod_buyer
                     from prod
                    where prod_id in (select cart_prod
                                     from cart 
                                     where cart_member in (select mem_id
                                                             from member
                                                            where mem_name = '������')));


-- ������ ȸ���� ������ ��ǰ �߿�
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�,
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�


SELECT prod_id, prod_name
  FROM prod
 WHERE prod_lgu in (select lprod_gu
                      from lprod
                     where lprod_nm LIKE '%����%')
   AND prod_id in (select cart_prod
                     from cart
                    where cart_member in (select mem_id
                                            from member
                                           where MOD(SUBSTR(mem_regno2,1,1),2) = 0))  -- ����
   AND prod_buyer in (select buyer_id
                        from buyer
                       where SUBSTR(buyer_add1,1,2) = '����');



--------------------------------------------------------------------------------------

-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

SELECT cart_prod, 
       MAX(cart_qty), MIN(cart_qty),
       ROUND(AVG(cart_qty),2), SUM(cart_qty),
       COUNT(cart_qty)
  FROM cart
 GROUP BY cart_prod;



-- ������ 2005�⵵ 7�� 11���̶� �����ϰ� ��ٱ������̺� �߻��� �߰� �ֹ���ȣ�� �˻��Ͻÿ�

-- cart_prod ���� 4�ڸ��� ��ǰ�з��ڵ�� ����
-- cart_no�� ���� 8�ڸ��� ��, ��, �� / ���ڸ��� �Ϸ翡 �ֹ��� 1�� ����

SELECT MAX(cart_no) as mno, MAX(cart_no)+1 as mpno
  FROM cart
 WHERE substr(cart_no, 1, 8) = '20050711';


-- ȸ�����̺��� ȸ����ü�� ���ϸ��� ���, ���ϸ��� �հ�, �ְ� ���ϸ���,
-- �ּ� ���ϸ���, �ο����� �˻��Ͻÿ�
SELECT ROUND(AVG(mem_mileage),2), SUM(mem_mileage), MAX(mem_mileage), MIN(mem_mileage),
       count(mem_id)
  FROM member;


-- [����]
-- ��ǰ���̺� �ŷ�ó�ڵ庰, ��ǰ�з��ڵ庰��,
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ�� �ּ���
-- ������ �ڷ���� �������� ��������
-- �߰���, �ŷ�ó��, ��ǰ�з��� ��ȸ
-- ��, �հ谡 100 �̻��� ��

SELECT prod_buyer, prod_lgu,
       MAX(prod_sale), MIN(prod_sale),
       ROUND(AVG(prod_sale),2),
       SUM(prod_sale), COUNT(prod_sale),
       (select Distinct buyer_name from buyer
        where buyer_id = prod_buyer) as �ŷ�ó��,
       (select Distinct lprod_nm from lprod
        where lprod_gu = prod_lgu) as ��ǰ�з���
  FROM prod
 GROUP BY prod_buyer, prod_lgu
HAVING SUM(prod_sale) >= 100
 ORDER BY COUNT(prod_sale) desc; -- ���������� ����Ǵ� order by�� ��Ī���� ����
 

----------------------------------------------------------------------------
-- NULL
-- IS NULL
-- IS NOT NULL
-- NVL

UPDATE buyer SET buyer_charger=NULL
 WHERE buyer_charger LIKE '��%';

UPDATE buyer SET buyer_charger=''
WHERE buyer_charger LIKE '��%';

SELECT buyer_name, buyer_charger
  FROM buyer
 WHERE buyer_charger IS Null;

SELECT buyer_name, buyer_charger
  FROM buyer
 WHERE buyer_charger IS NOT Null;

SELECT buyer_name, 
       NVL(buyer_charger,'����')
  FROM buyer;

-----------------------------------------------------------------------------

-- SQL�� ���ǹ�
-- DECODE
-- CASE WHEN

SELECT prod_lgu,
        DECODE(SUBSTR(prod_lgu, 1, 2),
              'P1', '��ǻ��/���� ��ǰ',
              'P2', '�Ƿ�',
              'P3', '��ȭ', 
              '��Ÿ') as lgu_nm
  FROM prod;

-----------------------------------------------------------------------------

-- EXIST : ��ȸ�� ����� �ϳ��� ������ True
SELECT prod_id, prod_name, prod_lgu
  FROM prod
 WHERE EXISTS ( select *
                from lprod 
                where lprod_gu = prod_lgu);

----------------------------------------------------------------------------

-- JOIN
-- Cross Join

SELECT * FROM lprod,prod; -- �Ϲݹ��
SELECT * FROM lprod CROSS JOIN prod;  -- ����ǥ��

-- Inner Join *** ����
-- PK�� FK�� �־���մϴ�.
-- �������� ���� : PK = FK
-- ���������� ���� : From���� ���õ� (���̺��� ���� - 1��)

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з����� ��ȸ

-- <�Ϲݹ��>
SELECT prod.prod_id,
       prod.prod_name,
       lprod.lprod_nm,
       buyer_name,
       cart_qty,
       mem_name
  FROM prod, lprod, buyer, cart, member
-- �������ǽ�
 WHERE prod.prod_lgu = lprod.lprod_gu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND mem_id = 'a001';


--<����ǥ��>
SELECT prod.prod_id,
       prod.prod_name,
       lprod.lprod_nm,
       buyer_name,
       cart_qty,
       mem_name
  FROM lprod Inner Join prod
                On( prod_lgu = lprod_gu )
             Inner Join buyer
                On( buyer_id = prod_buyer )
             Inner Join cart
                On ( prod_id = cart_prod )
             Inner Join member
                On ( cart_member = mem_id
                     And mem_id = 'a001');

-- ��ǰ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��,
-- �ŷ�ó �ּҸ� ��ȸ
-- 1) �ǸŰ����� 10���� �����̰�
-- 2) �ŷ�ó �ּҰ� �λ��� ��츸 ��ȸ
-- �Ϲݹ��, ǥ�ع��.. ��� �غ���..


-- 1. ���̺� ã�� ( prod, lprod, buyer)
-- 2. �������ǽ� ã��
-- 3. ���� ���ϱ�

--<�Ϲݹ��>
SELECT prod_name, prod_id, lprod_nm, buyer_name, buyer_add1
  FROM prod, lprod, buyer
 WHERE prod_lgu = lprod_gu
   AND prod_buyer = buyer_id
   AND prod_sale <= 100000
   AND SUBSTR(buyer_add1,1,2) = '�λ�';
   
--<����ǥ�ع��>
SELECT prod_name, prod_id, lprod_nm, buyer_name, buyer_add1
  FROM prod Inner Join lprod
                ON(prod_lgu = lprod_gu
                And prod_sale <= 100000)
            Inner Join buyer
                ON(prod_buyer = buyer_id
                AND SUBSTR(buyer_add1,1,2) = '�λ�');
                
-- [����]
-- ��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó���� ��ȸ
-- ��, ��ǰ�з� �ڵ尡 P101, P201, P301�� ��
--      ���Լ����� 15�� �̻��� ��
--      ���￡ ��� �ִ� ȸ�� �߿� ������ 1974����� ȸ��
-- ������ ȸ�����̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲݹ��, ǥ�ع��..

--<�Ϲݹ��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM lprod, prod, buyprod, cart, buyer, member
 WHERE lprod_gu = prod_lgu
   AND prod_buyer = buyer_id
   AND prod_id = buy_prod
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_lgu IN ('P101', 'P201', 'P301')
   AND mem_bir LIKE '74%'
   AND buy_qty >= 15
   AND mem_add1 LIKE '����%'
ORDER BY mem_id desc, buy_qty;


--<����ǥ�ع��>
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty, buyer_name
  FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu)
             Inner Join buyprod
                On(prod_id = buy_prod
                And prod_lgu IN ('P101', 'P201', 'P301'))
             Inner Join cart
                On(prod_id = cart_prod)
             Inner Join buyer
                On(prod_buyer = buyer_id
                And buy_qty >= 15)
             Inner Join member
                On(cart_member = mem_id
                And mem_bir LIKE '74%'
                And mem_add1 LIKE '����%')
ORDER BY mem_id desc, buy_qty;


select buyer_bankno, buyer_bank
 from buyer;



--1.��ǰ�з����� �ǸŰ��� ���� ���� ��ǰ�� �ֹ��� 
--ȸ����, ȸ�� �ֹε�Ϲ�ȣ, ����,
--  ���, ��ǰ�з��� ��ȸ
--  ��,�ֹε�Ϲ�ȣ ��ü�� ���� (���� ù��° �ڸ��� �����ϰ� �������� * �� ǥ��)
--  ������ �ֹε�Ϲ�ȣ �������� ��������


SELECT DISTINCT(mem_name), mem_regno1 || '-' || SUBSTR(mem_regno2,1,1) || '******'as resident_num,
       mem_job, mem_like 
  FROM (SELECT lprod_nm, MAX(prod_sale) as max
         FROM lprod, prod
         WHERE lprod_gu = prod_lgu
         GROUP BY lprod_nm) i,
        lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu
   AND prod_id = cart_prod
   AND cart_member = mem_id
 ORDER BY resident_num asc ;
 
 
 
 SELECT lprod_nm, MAX(prod_sale)
   FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu)
  GROUP BY lprod_nm;
  


--2. ���⿡ ���� ���� ������ �� VIP �� �̱�
-- �̸��� ����̰� ���� ���� 
-- 
--
--
--
--3. �ŷ�ó �ּҰ� �����̰� 5���̻���

;
SELECT mem_regno1 || '-' || SUBSTR(mem_regno2,1,1) || '******'
  FROM member;


buyer_mail ����̰� ���� ���� 
@ �ڷθ�
------------------------------
SELECT cart_no
  FROM cart;

-- Outer Join ***

SELECT EXTRACT(mem_pass)
  FROM member;
