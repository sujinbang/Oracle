--UNION Į���� ���� �ʾƵ� ������(��� Į���� ���¸� ���������
-- ����
SELECT b.idx, b.names
  FROM bookstbl b
 UNION 
SELECT m.idx, m.levels
  FROM membertbl m;

SELECT b.idx, TO_CHAR(b.price)
  FROM bookstbl b
 UNION 
SELECT m.idx, m.levels
  FROM membertbl m;
  
-----------------------------------------------------------------

SELECT idx, price FROM bookstbl
UNION
SELECT idx, names FROM membertbl;

--���̺� ����
CREATE TABLE userTBL
(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10) NOT NULL,
    addr NVARCHAR2(50)
);

--DROP TABLE userTBL; -- ���̺� ����
-- �θ� �ڽ� ���� �������� �ߺ��Ǵ� Į���� ������ ���´� ������ �����ؾ��� --> ���ڿ� ���ڸ� ���еǾ���ϴ���?
CREATE TABLE buy TBL
(
    idNum NUMBER(8) NOT NULL PRIMARY KEY,
    userID CHAR(8) NOT NULL,
    buyDate DATE,
    
    FOREIGN KEY(userID) REFERENCES userTBL(userID)
-- FOREIGN KEY�� ��Ī�� �ٸ��ٸ� �ش� ���̺��� ��Ī�� �����;���
-- ���� ��� FOREIGN KEY(memberidx) REFERENCES memberTBL(idx)
--> rentaltbl.memberidx = membertbl.idx


-- ���̺� ������ �ڽ����̺� ���� ��������(�θ����̺���� ���� x)

--key : pk, fk, unique, check, default, null

