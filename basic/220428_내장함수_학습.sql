-- ���
-- ����ȯ�Լ� CAST�� �Ǿ�����
SELECT CAST(AVG(price) AS number(10,2)) as "å���� ���"
  FROM bookstbl;

SELECT CAST(AVG(hisal) as number(10,2)) "�ְ�������" 
  FROM salgrade;

-- DUAL (���� db���̺� ������� ���� ��)
SELECT CAST('1000' AS NUMBER(10)) FROM dual;
SELECT CAST(1000.08 AS CHAR(10)) FROM dual;

SELECT CAST('202/04/28' AS DATE) FROM dual;

SELECT TO_CHAR(12345, '$999,999') FROM dual;
SELECT TO_CHAR(12345, '999,999') FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS') "�����Ͻ�" FROM dual;
--> SYSDATE �ſ��߿�!!!!

--���ڿ� �Լ�
SELECT CHR(65), UNISTR('\D55C') FROM dual;

--���ڿ� ����
-- || �Ǵ� CONCAT - CONCAT�� ���� 2�� ������ ���
SELECT 'Hello, ' || 'World ' || '!' FROM dual;
SELECT CONCAT('Hello,', 'World') FROM dual;

--���ϴ� ���� ã��
SELECT INSTR('�̰��� Oracle�̴�, �ݰ����ϴ�.', 'Oracle') FROM dual;

--��ҹ��� ��ȯ
SELECT UPPER('abcde'), LOWER('ABCDE') FROM dual;

-- ���� �ڸ���
SELECT SUBSTR('���ѹα� ����', 5, 2) FROM dual;

-- Ʈ��
SELECT LTRIM('     �ȳ��ϼ���'), RTRIM('�ȳ��ϼ���      '), TRIM('       �ȳ��ϼ���       ')
FROM dual;

SELECT SYSDATE FROM dual;




