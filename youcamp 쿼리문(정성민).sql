-- MEMBER ���̺� ���� ��������
-- 1. �α��ο� ������
SELECT *
  FROM MEMBER
 WHERE MEMBER_ID = ?
   AND STATUS = 'Y' 
   
-- 2. ȸ�����Կ� ������
INSERT INTO MEMBER(MEMBER_NO
                 , MEMBER_ID
                 , MEMBER_PWD
                 , MEMBER_NAME
                 , BIRTH_DATE
                 , PHONE
                 , EMAIL
                 , SIGNUP_DATE
                 , ADDRESS)
            VALUES(MEMBER_SEQ.NEXTVAL
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?
                 , ?)
                 
-- 3. ���̵� �ߺ�üũ�� ������
SELECT COUNT(*)
  FROM MEMBER
 WHERE MEMBER_ID = ?
                 
                 
-- RESERVE ���̺� ���� ��������
-- 1. 
  