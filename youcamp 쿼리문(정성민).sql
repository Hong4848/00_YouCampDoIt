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
 
-- 4. 이메일 인증번호 발급용 쿼리문
INSERT INTO IDENTIFICATION(EMAIL,
                         , AUTH_CODE
                         , AUTH_CODE_DATE)
                    VALUES(?
                         , ?
                         , SYSDATE)
                         
-- 5. 이메일 인증번호 대조용 쿼리문
SELECT AUTH_CODE
  FROM IDENTIFICATION
 WHERE EMAIL = ?
   AND AUTH_CODE = ?
   AND SYSDATE < TO_DATE(AUTH_CODE_DATE, 'YYYY-MM-DD HH24:MI:SS') + NUMTODSINTERVAL(3, 'MINUTE');

-- 6. 이메일 인증번호 삭제용 쿼리문
DELETE
  FROM IDENTIFICATION
 WHERE EMAIL = ?
 
-- 7. 아이디 찾기용 쿼리문
SELECT MEMBER_ID
  FROM MEMBER
 WHERE MEMBER_NAME = ?
   AND EMAIL = ?
   AND STATUS = 'Y'
  
-- 8. 비밀번호 찾기용 쿼리문
SELECT *
  FROM MEMBER
 WHERE MEMBER_NAME = ?
   AND MEMBER_ID = ?
   AND EMAIL = ?
   AND STATUS = 'Y'

                 
                 
-- RESERVE 테이블 관련 쿼리문들
-- 1. 
  