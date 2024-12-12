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
 
-- 4. �̸��� ������ȣ �߱޿� ������
INSERT INTO IDENTIFICATION(EMAIL,
                         , AUTH_CODE
                         , AUTH_CODE_DATE)
                    VALUES(?
                         , ?
                         , SYSDATE)
                         
-- 5. �̸��� ������ȣ ������ ������
SELECT AUTH_CODE
  FROM IDENTIFICATION
 WHERE EMAIL = ?
   AND AUTH_CODE = ?
   AND SYSDATE < TO_DATE(AUTH_CODE_DATE, 'YYYY-MM-DD HH24:MI:SS') + NUMTODSINTERVAL(3, 'MINUTE');

-- 6. �̸��� ������ȣ ������ ������
DELETE
  FROM IDENTIFICATION
 WHERE EMAIL = ?
 
-- 7. ���̵� ã��� ������
SELECT MEMBER_ID
  FROM MEMBER
 WHERE MEMBER_NAME = ?
   AND EMAIL = ?
   AND STATUS = 'Y'
  
-- 8. ��й�ȣ ã��� ������
SELECT *
  FROM MEMBER
 WHERE MEMBER_NAME = ?
   AND MEMBER_ID = ?
   AND EMAIL = ?
   AND STATUS = 'Y'

                 
                 
-- RESERVE ���̺� ���� ��������
-- 1. 
  