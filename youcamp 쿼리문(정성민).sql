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
   
-- 9. 비밀번호 변경용 쿼리문
UPDATE MEMBER
   SET MEMBER_PWD = ?
 WHERE MEMBER_NAME = ?
   AND MEMBER_ID = ?
   AND EMAIL = ?
   AND STATUS = 'Y'
  
-- 10. 회원탈퇴용 쿼리문
UPDATE MEMBER
   SET STATUS = 'N'
 WHERE MEMBER_ID = ?
   AND STATUS = 'Y';
   
   
-- 예약 관련 쿼리문들
-- 1. 캠핑장 섹션별 남은자리 갯수 조회용 쿼리문
SELECT C.SECTION AS SECTION, COUNT(C.CAMPSITE_ID) AS "REST_COUNT"
  FROM CAMPSITE C
 WHERE C.CAMPSITE_ID NOT IN (
          SELECT R.CAMPSITE_ID
          FROM RESERVE R
          WHERE 
              TRUNC(R.START_DATE) < TO_DATE('2024-12-25', 'YYYY-MM-DD') 
              AND TRUNC(R.END_DATE) > TO_DATE('2024-12-23', 'YYYY-MM-DD') 
            AND PAYMENT_STATUS = 'PAID'
       )
    
 GROUP BY C.SECTION
 ORDER BY C.SECTION
 



-- 2. 캠핑장 예약가능한 남은자리 조회용 쿼리문
SELECT SPOT_NO
  FROM CAMPSITE C
 WHERE C. CAMPSITE_ID NOT IN (
          SELECT R.CAMPSITE_ID
            FROM RESERVE R
           WHERE TRUNC(R.START_DATE) < TO_DATE('2025-01-08', 'YYYY-MM-DD')
             AND TRUNC(R.END_DATE) > TO_DATE('2025-01-06', 'YYYY-MM-DD')
             AND PAYMENT_STATUS = 'PAID'
       )   
   AND C.SECTION = 'B'
 ORDER BY C.SPOT_NO ASC

-- 3. 캠핑장 예약 INSERT 용 쿼리문
INSERT INTO RESERVE(RESERVE_NO, 
                    START_DATE, 
                    END_DATE, 
                    NIGHTS, 
                    MEMBER_COUNT,
                    PAYMENT_ID, 
                    PRICE, 
                    PAYMENT_DATE,
                    PAYMENT_METHOD, 
                    PAYMENT_STATUS, 
                    MEMBER_NO, 
                    CAMPSITE_ID)
             VALUES(RESERVE_SEQ.NEXTVAL,
                    TO_DATE('2025-01-06', 'YYYY-MM-DD'),
                    TO_DATE('2025-01-08', 'YYYY-MM-DD'),
                    2,
                    4,
                    '12345',
                    80000,
                    SYSDATE,
                    'CARD',
                    'PAID',
                    3,
                    17);

-- 4. 캠핑장 예약 목록조회용 쿼리문 (추후에 페이징 처리 필요)
SELECT *
  FROM RESERVE
 WHERE MEMBER_NO = ?
   AND PAYMENT_STATUS = 'PAID'

-- 5. 캠핑장 결제후 예약 번호 조회용 쿼리문
SELECT RESERVE_SEQ.CURRVAL FROM DUAL
   
-- 6. 캠핑장 예약 상세조회용 쿼리문
SELECT *
  FROM RESERVE
 WHERE RESERVE_NO = (SELECT RESERVE_SEQ.CURRVAL FROM DUAL)
   AND MEMBER_NO = 3
   AND PAYMENT_STATUS = 'PAID'
   
-- 7. 캠핑장 예약내역 총 갯수 조회용 쿼리문
SELECT COUNT(*)
  FROM RESERVE
 WHERE MEMBER_NO = ?
   AND PAYMENT_STATUS IN ('PAID', 'CANCELED', 'REFUNDED')
   
-- 8. 캠핑장 예약내역 목록조회용 쿼리문
SELECT RESERVE_NO, PAYMENT_DATE, PRICE, PAYMENT_STATUS
  FROM RESERVE
 WHERE MEMBER_NO = ?
  AND PAYMENT_STATUS IN ('PAID', 'CANCELED', 'REFUNDED')
 ORDER BY RESERVE_NO DESC

-- 9. 캠핑장 예약내역 상세조회용 쿼리문
SELECT RESERVE_NO, PAYMENT_DATE, START_DATE, PAYMENT_METHOD, PRICE, MEMBER_COUNT
  FROM RESERVE
 WHERE RESERVE_NO = ?






-- 예약 테이블 더미데이터 생성구문
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202401', 60000, SYSDATE, 'CARD', 'PAID', SYSDATE, 5, 1);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-23 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202402', 120000, SYSDATE, 'BANK', 'PAID', SYSDATE, 3, 2);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-23 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202403', 60000, SYSDATE, 'VBANK', 'CREATED', SYSDATE, 4, 3);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-23 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202404', 120000, SYSDATE, 'CELLPHONE', 'PAID', SYSDATE, 5, 4);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-24 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-25 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202405', 60000, SYSDATE, 'CARD', 'PAID', SYSDATE, 3, 5);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-25 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202406', 120000, SYSDATE, 'BANK', 'CANCELED', SYSDATE, 4, 6);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-26 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-27 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202407', 60000, SYSDATE, 'VBANK', 'PAID', SYSDATE, 5, 7);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-27 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-29 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202408', 120000, SYSDATE, 'CELLPHONE', 'PAID', SYSDATE, 3, 8);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-28 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-29 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202409', 60000, SYSDATE, 'CARD', 'CREATED', SYSDATE, 4, 9);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-29 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-31 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202410', 120000, SYSDATE, 'BANK', 'PAID', SYSDATE, 5, 10);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-30 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-31 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202411', 60000, SYSDATE, 'VBANK', 'PAID', SYSDATE, 3, 11);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2024-12-31 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-02 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202412', 120000, SYSDATE, 'CELLPHONE', 'REFUNDED', SYSDATE, 4, 12);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-01 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202413', 60000, SYSDATE, 'CARD', 'PAID', SYSDATE, 5, 13);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202414', 120000, SYSDATE, 'BANK', 'PAID', SYSDATE, 3, 14);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-03 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202415', 60000, SYSDATE, 'VBANK', 'PAID', SYSDATE, 4, 15);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202416', 120000, SYSDATE, 'CELLPHONE', 'PAID', SYSDATE, 5, 16);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-06 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202417', 60000, SYSDATE, 'CARD', 'CREATED', SYSDATE, 3, 17);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-06 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-08 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202418', 120000, SYSDATE, 'BANK', 'PAID', SYSDATE, 4, 18);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-07 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-08 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4, 'PAY202419', 60000, SYSDATE, 'VBANK', 'PAID', SYSDATE, 5, 19);
INSERT INTO RESERVE (
    RESERVE_NO, START_DATE, END_DATE, NIGHTS, MEMBER_COUNT, PAYMENT_ID, PRICE,
    PAYMENT_DATE, PAYMENT_METHOD, PAYMENT_STATUS, UPDATE_DATE,
    MEMBER_NO, CAMPSITE_ID
) VALUES
(RESERVE_SEQ.NEXTVAL, TO_DATE('2025-01-08 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 4, 'PAY202420', 120000, SYSDATE, 'CELLPHONE', 'PAID', SYSDATE, 3, 20);
COMMIT;
                 
                 
-- 캠핑장 더미데이터 생성 구문
-- 1. SECTION 테이블
INSERT INTO SECTION
             VALUES('A', '캠핑카존');
INSERT INTO SECTION
             VALUES('B', '글램핑존');
INSERT INTO SECTION
             VALUES('C', '일반석');
INSERT INTO SECTION
             VALUES('D', '바베큐장');
             
-- 2. CAMPSITE 테이블
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 1, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 2, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 3, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 4, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 5, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 6, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 7, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 8, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 9, 30000, 'A');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 10, 30000, 'A');

INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 1, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 2, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 3, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 4, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 5, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 6, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 7, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 8, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 9, 40000, 'B');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 10, 40000, 'B');

INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 1, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 2, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 3, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 4, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 5, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 6, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 7, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 8, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 9, 50000, 'C');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 10, 50000, 'C');

INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 1, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 2, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 3, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 4, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 5, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 6, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 7, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 8, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 9, 60000, 'D');
INSERT INTO CAMPSITE
            VALUES(CAMP_SEQ.NEXTVAL, 10, 60000, 'D');
  
COMMIT;
  
  
  
  
  
  
  