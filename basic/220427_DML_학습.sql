--INSERT


--CREATE TABLE
CREATE TABLE testTBL
(
    id NUMBER(4) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10),
    age NUMBER(3)
);

--INSERT
INSERT INTO testTBL (id, userNAme, age) VALUES (1, 'ȫ�浿', 99);

INSERT INTO testTBL VALUES (2, N'ȫ���', 97);
--����, ���� ���� ��ġ���� ����
INSERT INTO testTBL VALUES (3, N'ȫ����');
--��ü���
INSERT INTO testTBL VALUES (3, N'ȫ����', NULL);

INSERT INTO testTBL (ID, userName) VALUES (4, '�����');

-- �ǵ�����
ROLLBACK;

-- ��������
COMMIT;

-- test table
-- CREATE TABLE
CREATE TABLE testTBL2
(
    id NUMBER(4) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10),
    age NUMBER(3)
);

--������ ����
CREATE SEQUENCE test2Seq
 START WITH 1 -- ����
 INCREMENT BY 1; -- ������
 
 --������ ��� �Է�
 --������ �ڷῡ�� �ѹ� ����� id�� �ٽ� ������� �ʴ´�
 
 INSERT INTO testTBL2(id, userName, age)
  VALUES (TEST2SEQ.nextval, '�����', 47);
  
COMMIT;

-- UPDATE(WHERE�� ���� ���� x -- �ſ� �߿�!)

UPDATE testTbl2
    SET username = 'ȫ���'
      , age = 97
WHERE id = 2;

-- DELETE (WHERE�� ���� ���� x -- �ſ� �߿�!)

DELETE FROM testTBL2 WHERE id = 6;

