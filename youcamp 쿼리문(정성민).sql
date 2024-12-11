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
   AND SYSDATE < AUTH_CODE-DATE + 3
                        
  

                 
                 
-- RESERVE 테이블 관련 쿼리문들
-- 1. 
  