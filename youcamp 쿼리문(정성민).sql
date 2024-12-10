-- MEMBER 테이블 관련 쿼리문들
-- 1. 로그인용 쿼리문
SELECT *
  FROM MEMBER
 WHERE MEMBER_ID = ?
   AND STATUS = 'Y' 
   
-- 2. 회원가입용 쿼리문
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
                 
-- 3. 아이디 중복체크용 쿼리문
SELECT COUNT(*)
  FROM MEMBER
 WHERE MEMBER_ID = ?
                 
                 
-- RESERVE 테이블 관련 쿼리문들
-- 1. 
  