--1. cmd â ����

-- �������� ���� ����...
--2. sqlplus /nolog �Է� ����

--SQL>conn /as sysdba

--SQL>alter user system identified by ���ο��ȣ;
--SQL>alter user sys identified by ���ο��ȣ

--SQL>conn system/���ο��ȣ

-- ����Ȯ��
--SQL>show user


---- ����Ŭ 12���� �̻���ʹ� �Ʒ��� �����ؾ�
---- �Ϲ����� ���� �ۼ��� ������
--Alter session set "_ORACLE_SCRIPT"=true;
--
--
---- ���� ������ ���� �ѹ� ����
---- ���� ���� ���ϸ� �Ʒ�ó�� ������ �ۼ��ؾ���
--Create User c##busan_06 Identified by dbdb;
--
--
--
---- 1. ����� �����ϱ�
--Create User busan_06 
--    Identified By dbdb;
--
---- �н����� �����ϱ�
--Alter User busan_06
--    Identified By �����н�����;
--
---- ����� �����ϱ�
--Drop User busan_06;
--
---- 2. ���� �ο��ϱ�
--Grant Connect, Resource, DBA To busan_06;
--
--
---- ���� ȸ���ϱ�
--Revoke DBA From busan_06;


-- ȸ�����̺��� ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
SELECT mem_id, mem_name
FROM member;

-- ��ǰ�ڵ�� ��ǰ�� ��ȸ�ϱ�...
SELECT prod_id, prod_name
FROM prod;

-- ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ� ��ȸ�ϱ�
-- ��, �Ǹűݾ�=�ǸŴܰ� * 55 �� ����ؼ� ��ȸ�մϴ�.
-- �Ǹűݾ��� 4�鸸 �̻��� �����͸� ��ȸ�ϱ�
-- select > from ���̺� > where > �÷���ȸ > order by

SELECT prod_id, prod_name, 
       (prod_sale * 55) as sale
FROM prod
WHERE (prod_sale * 55) >= 4000000
ORDER BY sale desc;

-- ��ǰ�������� �ŷ�ó�ڵ带 ��ȸ�� �ּ���...
-- ��, �ߺ��� �����ϰ� ��ȸ���ּ���
SELECT DISTINCT prod_buyer
FROM prod;

-- ��ǰ�߿� �ǸŰ����� 17������ ��ǰ ��ȸ�ϱ�..
SELECT prod_name, prod_sale
  FROM prod
 WHERE prod_sale = 170000;

-- ��ǰ�߿� �ǸŰ����� 17������ �ƴ� ��ǰ ��ȸ�ϱ�
SELECT prod_name, prod_sale
  FROM prod
 WHERE prod_sale != 170000;

-- ��ǰ�߿� �ǸŰ����� 17���� �̻��̰� 20���� ������ ��ǰ ��ȸ�ϱ�
SELECT prod_name, prod_sale
  FROM prod
 WHERE (prod_sale >= 170000) 
   AND (prod_sale <= 200000);

-- ��ǰ�߿� �ǸŰ����� 17���� �̻� �Ǵ� 20���� ������ ��ǰ ��ȸ�ϱ�
SELECT prod_name, prod_sale
  FROM prod
 WHERE (prod_sale >= 170000) 
    OR (prod_sale <= 200000);

-- ��ǰ �ǸŰ����� 10���� �̻��̰�,
-- ��ǰ �ŷ�ó(���޾�ü) �ڵ尡 P30203 �Ǵ� P10201 ��
-- ��ǰ�ڵ�, �ǸŰ���, ���޾�ü �ڵ� ��ȸ�ϱ�
SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE (prod_sale >= 100000)
   AND (prod_buyer = 'P30203'
        OR prod_buyer = 'P10201'); -- or ��Ʈ�� ()�� ������Ѵ�

SELECT prod_id, prod_sale, prod_buyer
  FROM prod
 WHERE (prod_sale >= 100000)
   AND prod_buyer NOT IN('P30203','P10201');
    
    
SELECT DISTINCT prod_buyer
  FROM prod
 ORDER BY prod_buyer Asc;
 

SELECT *
  FROM buyer
 WHERE buyer_id NOT In (Select Distinct prod_buyer
                    From prod);


-- �ѹ��� �ֹ��� ���� ���� ȸ�� ���̵�, �̸��� ��ȸ�� �ּ���
SELECT mem_id, mem_name
FROM member
WHERE mem_id NOT In (Select Distinct cart_member
                    From Cart);


-- ��ǰ �з� �߿� ��ǰ������ ���� �з��ڵ常 ��ȸ�� �ּ���
SELECT lprod_gu
FROM lprod
WHERE lprod_gu NOT In (Select Distinct prod_lgu From prod);


-- ȸ���߿� ���� �߿� 75����� �ƴ� ȸ�����̵�, ���� ��ȸ�ϱ�
-- ������ ���� ���� ��������
SELECT mem_id, mem_bir,
       TO_CHAR(mem_bir, 'yyyy') as birth
FROM member
WHERE TO_CHAR(mem_bir, 'yyyy') != '1975'
ORDER BY birth desc;


SELECT * From member
Where mem_bir Not Between '1975-01-01' And '1975-12-31';


-- ȸ�� ���̵� a001�� ȸ���� �ֹ��� ��ǰ�ڵ带 ��ȸ�� �ּ���...
-- ��ȸ�÷��� ȸ�����̵�, ��ǰ�ڵ�
SELECT cart_prod, cart_member
FROM cart
WHERE cart_member = 'a001';
--WHERE cart_member in (select distinct mem_id from member where mem_id = 'a001');





