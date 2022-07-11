
--1. ���ݱ��� ȸ������ �����ߴ� �ֹ��� ���ϸ����� �������ִ� �̺�Ʈ�� �Ѵٰ� �մϴ�.
--������� ������ ��ǰ ������ŭ ���ϸ����� ����, ������ �ִ� ���ϸ����� ���ؼ� ȸ����ȣ ���� ���� ������ �����ּ���
--��ȸ�ϴ� �÷��� ȸ����ȣ, ȸ����, ������ �ִ� ���ϸ���, 
--�̺�Ʈ�� �����Ǵ� ���ϸ���(�÷����� eve_mile�� ��Ī), ���� ���ϸ���(�÷����� total�� ��Ī)
--��ǰ ���̺��� ��ǰ ���ϸ��� �÷��� ������Ʈ�Ͽ� �̿����ּ���.(���ϸ��� �������� 5%) 
--      ������ϸ����� ������� ��ǰ �ǸŰ��� 5%�� ��ǰ���ϸ����� ������Ʈ
--�������� ��ȣ�� ���ؼ� ȸ������ �߰� ���ڴ� *�� �ٲ��ּ���
--ȸ����ȣ ������ �������� ����


SELECT mem_id, SUM(NVL(prod_mileage, (prod_sale * 0.05)) * cart_qty) eve_mile,
       SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1) name,
       SUM(mem_mileage),
       SUM(NVL(prod_mileage, (prod_sale * 0.05)) * cart_qty) + SUM(mem_mileage) total
  FROM member Inner Join cart
                On(mem_id = cart_member)
              Inner Join prod
                On(cart_prod = prod_id)
 GROUP BY mem_id, SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1)
 ORDER BY mem_id asc;
 
 
 
-------------------------------------------------------------------------------- 
 
SELECT cart_member, SUM(cart_qty) eve_mile,
       SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1) name,
       SUM(mem_mileage),
       SUM(cart_qty) + SUM(mem_mileage) total
       --NVL(prod_mileage, (prod_sale * 0.05))
  FROM member Inner Join cart
                On(mem_id = cart_member)
              Inner Join prod
                On(cart_prod = prod_id)
 GROUP BY cart_member,SUBSTR(mem_name,1,1) || '*' || SUBSTR(mem_name,3,1)
 ORDER BY cart_member asc;


--
--2. ȸ���� �ŷ�ó���� ���� �ŷ��� �Ѵٰ� �Ҷ�, 
--������ ���� ��� ��۱Ⱓ�� 0��, ������ �ٸ� ��쿡�� ��۱Ⱓ�� 1���Դϴ�.
--�̶�, ���Ϲ���� ������ ��ǰ���� ��ȸ�ϼ���.
--��ȸ�ϴ� �÷��� ȸ����ȣ, ȸ����, �ŷ�ó��, ��ǰ�ڵ�, ��ǰ��
--ȸ����ȣ ������ �������� ����

SELECT mem_id, mem_name, buyer_name, prod_id, prod_name, 
       DECODE(SUBSTR(buyer_add1,1,2),
       SUBSTR(mem_add1,1,2),0) delivery
  FROM member, buyer, prod, cart
 WHERE prod_id = cart_prod
   AND cart_member = mem_id
   AND prod_buyer = buyer_id
   AND DECODE(SUBSTR(buyer_add1,1,2),
       SUBSTR(mem_add1,1,2),0) = 0
ORDER BY mem_id;




--1.�� ��ǰ�з����� �ǸŰ��� ���� ���� ��ǰ�� �ֹ��� 
--ȸ����, ȸ�� �ֹε�Ϲ�ȣ, ����,
--  ���, ��ǰ�з��� ��ȸ
--  ��,�ֹε�Ϲ�ȣ ��ü�� ���� (���� ù��° �ڸ��� �����ϰ� �������� * �� ǥ��)
--  ������ �ֹε�Ϲ�ȣ �������� ��������   
   
SELECT mem_name, 
       mem_regno1 || '-' || SUBSTR(mem_regno2,1,1) || '******'as mem_regno,
       mem_job, mem_like 
  FROM lprod, prod, cart, member,
        (SELECT lprod_nm, lprod_gu, i.prod_max
            FROM (SELECT lprod_gu, lprod_nm, MAX(prod_sale) as prod_max
                    FROM lprod, prod        
                    WHERE lprod_gu = prod_lgu
                    GROUP BY lprod_nm, lprod_gu
                    ORDER BY prod_max DESC) i
                    WHERE ROWNUM = 1) MAX_LPROD    
 WHERE MAX_LPROD.lprod_gu = prod_lgu
   AND prod_id = cart_prod
   AND cart_member = mem_id
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like
 ORDER BY mem_regno asc ;

----------------------------------------------------------------

SELECT lprod_nm, lprod_gu, i.prod_max
FROM (SELECT lprod_gu, lprod_nm, MAX(prod_sale) as prod_max
        FROM lprod, prod        
       WHERE lprod_gu = prod_lgu
       GROUP BY lprod_nm, lprod_gu
       ORDER BY prod_max DESC) i
WHERE ROWNUM = 1;

-----------------------------------------------------------------
-- ���� ��
SELECT mem_name,
       mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******' mem_regno,
       mem_job, mem_like, MAX_LPROD.lprod_nm, MAX_LPROD.MS
  FROM member, cart, prod, lprod,
       (SELECT lprod_gu, lprod_nm, i.MAX_SALE as MS
          FROM(SELECT lprod_gu, lprod_nm, MAX(prod_sale) "MAX_SALE"
                 FROM lprod, prod
                WHERE lprod_gu = prod_lgu
                GROUP BY lprod_gu, lprod_nm
                ORDER BY MAX_SALE DESC) i
         WHERE ROWNUM = 1) "MAX_LPROD"
 WHERE prod_lgu = MAX_LPROD.lprod_gu      
   AND mem_id = cart_member
   AND prod_id = cart_prod
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like, MAX_LPROD.lprod_nm, MAX_LPROD.MS       
 ORDER BY mem_regno;



