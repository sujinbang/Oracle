--4day

--[����]
-- ��ǰ���̺�� ��ǰ�з����̺��� ��ǰ�з��ڵ尡 'P101'�� �Ϳ� ����
-- ��ǰ�з��ڵ�(��ǰ���̺� �ִ� �÷�), ��ǰ��, ��ǰ�з����� ��ȸ�� �ּ���
-- ������ ��ǰ���̵�� ��������...

SELECT prod_lgu, prod_name, lprod_nm
  FROM prod Inner Join lprod
                On(prod_lgu = lprod_gu
                And lprod_gu = 'P101')
 ORDER BY prod_id desc;
 
--[����]
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ������ Ȯ���Ϸ��� �մϴ�.
-- �ŷ�ó�ڵ�, �ŷ�ó��, ȸ����������(���� or ��õ...) ��ȸ
-- ��, ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ�� ���ؼ���...

SELECT buyer_id, buyer_name, SUBSTR(mem_add1,1,2)
  FROM buyer Inner Join prod
                On(buyer_id = prod_buyer)
             Inner Join lprod
                On(prod_lgu = lprod_gu
                And lprod_nm LIKE '%ĳ�־�%')
             Inner Join cart
                On(prod_id = cart_prod)
             Inner Join member
                On(cart_member = mem_id
                And mem_name = '������');
                
                
-- [����]
-- ��ǰ�з��� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ����
--      ȸ���� ��̰� ������ ȸ��

SELECT mem_id, mem_name, lprod_nm
  FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu
                And lprod_nm LIKE '%����%'
                And prod_name LIKE '%�Ｚ����%')
             Inner Join cart
                On(prod_id = cart_prod)
             Inner Join member
                On(cart_member = mem_id
                And mem_like = '����');
                
                
-- [����]
-- ��ǰ�з� ���̺�� ��ǰ���̺�� �ŷ�ó���̺�� ��ٱ��� ���̺� ���
-- ��ǰ�з��ڵ尡 'P101' �� ���� ��ȸ
-- �׸��� ������ ��ǰ�з����� �������� ��������,
--                 ��ǰ���̵� �������� �������� �ϼ���
-- ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ������� ��ȸ

SELECT lprod_nm, prod_ID, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod Inner Join prod
                On(lprod_gu = prod_lgu
                And lprod_gu = 'P101')
             Inner Join buyer
                On(prod_buyer = buyer_id)
             Inner Join cart
                On(prod_id = cart_prod)
ORDER BY lprod_nm desc, prod_id asc;



-- [����]
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ������ ȸ���� ���ؼ���
-- ��ȸ�÷� ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

SELECT cart_prod, MAX(cart_qty), MIN(cart_qty),
       ROUND(AVG(cart_qty),2), SUM(cart_qty), COUNT(cart_qty)
  FROM cart, prod
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%�Ｚ%'
 GROUP BY cart_prod;
 
 
 -- [����]
 -- �ŷ�ó�ڵ� �� ��ǰ�з��ڵ庰��,
 -- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ踦 ��ȸ�� �ּ���
 -- ��ȸ�÷�, �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�, ��ǰ�з���,
 --             �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ�
 -- ������ ����� �������� ��������
 -- ��, �ǸŰ��� ����� 100 �̻��� ��
 
 SELECT buyer_id, buyer_name, lprod_gu, lprod_nm,
        MAX(prod_sale), MIN(prod_sale), COUNT(prod_sale),
        ROUND(AVG(prod_sale),2) avg, SUM(prod_sale)
   FROM prod, buyer, lprod
  WHERE prod_buyer = buyer_id
    AND prod_lgu = lprod_gu
  GROUP BY buyer_id, buyer_name, lprod_gu, lprod_nm
  Having ROUND(AVG(prod_sale),2) >= 100
  ORDER BY avg desc;
  
  
-- [����]
-- �ŷ�ó���� group ��� ���Աݾ��� ���� �˻��ϰ��� �մϴ�
-- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����)�ΰ���
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- (���Աݾ��� ���� null�� ��� 0���� ��ȸ)
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó���� �������� ��������

SELECT buyer_id, buyer_name, SUM(NVL(buy_qty*buy_cost, 0)) AS SUMCOST
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND TO_CHAR(buy_date, 'YYYY-MM') = '2005-01'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id desc, buyer_name desc;
 
 
 --[����]
 -- �ŷ�ó���� group ��� ���Աݾ������� ����Ͽ�
 -- ���Աݾ��� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ���� �˻��ϰ����մϴ�
 -- ������ ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����)�ΰ���
 -- ���Աݾ� = ���Լ��� * ���Աݾ�
 -- (���Աݾ������� null�� ��� 0���� ��ȸ)
 -- ��ȸĮ�� : ��ǰ�ڵ�, ��ǰ��
 -- ������ ��ǰ���� �������� ��������


SELECT prod_id, prod_name
  FROM (SELECT buyer_id, buyer_name, SUM(NVL(buy_qty*buy_cost, 0)) AS SUMCOST
        FROM buyer, prod, buyprod
        WHERE buyer_id = prod_buyer
        AND prod_id = buy_prod
        AND TO_CHAR(buy_date, 'YYYY-MM') = '2005-01'
        GROUP BY buyer_id, buyer_name
        ORDER BY buyer_id desc, buyer_name desc) A, prod P
 WHERE prod_buyer = A.buyer_id
   AND A.sumcost >= 10000000
 ORDER BY prod_name asc; 

---------------------------------------------------------------------------------

-- Outer Join
--  �� table �� join�� �� ������ row���� �˻��ǵ��� �ϴ� ���

-- ��ü �з��� ��ǰ�ڷ� ���� �˻� ��ȸ

-- �з����̺� ��ȸ
SELECT *
  FROM lprod;
  
-- �Ϲ� ��ȸ
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
 GROUP BY lprod_gu, lprod_nm;
 
-- ORACLE
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+) -- ��ü�� ������ �ݴ��ʿ� +�� ����
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;

-- ����ǥ��
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod LEFT OUTER JOIN  prod  -- ���� ���̺� ��ü�� ��ȸ�ϰڴ� (LEFT)
                On(lprod_gu = prod_lgu)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;


-- �Ϲ� JOIN
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-30'
 GROUP BY prod_id, prod_name;
 
-- ���� ǥ��
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod Inner Join buyprod
                On(prod_id = buy_prod
                AND buy_date BETWEEN '2005-01-01' AND '2005-01-30')  
 GROUP BY prod_id, prod_name;

-- OUTER JOIN ���Ȯ��
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod(+)
   AND buy_date BETWEEN '2005-01-01' AND '2005-01-30'
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;

-- ���� ǥ��
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod LEFT OUTER JOIN buyprod
                On(prod_id = buy_prod
                AND buy_date BETWEEN '2005-01-01' AND '2005-01-30')
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;


---------------------------------------------------------------------------
-- SELF JOIN
-- �ŷ�ó�ڵ尡 'P30203(����)'�� ���������� ���� �ŷ�ó�� �˻� ��ȸ

SELECT B.buyer_id, B.buyer_name, B.buyer_add1 || '' || B.buyer_add2
  FROM buyer A, buyer B
 WHERE A.buyer_id = 'P30203'
   AND SUBSTR(A.buyer_add1, 1, 2) = SUBSTR(B.buyer_add1,1,2);
   
   

