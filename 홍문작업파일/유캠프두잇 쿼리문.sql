-- 1. ��ٱ��� ��� ��ȸ�� ������
SELECT M.MEMBER_NO
     , C.*
     , G.*
     , GA.*
  FROM CART C
  JOIN MEMBER M ON C.MEMBER_NO = M.MEMBER_NO
  JOIN GOODS G ON C.GOODS_NO = G.GOODS_NO
  JOIN GOODS_ATTACHMENT GA ON 
 WHERE MEMBER_NO = ?
 
SELECT M.MEMBER_NO
     , C.CART_NO
     , C.QUANTITY
     , C.PRICE AS CART_PRICE
     , G.GOODS_NO
     , G.CATEGORY
     , G.GOODS_NAME
     , G.PRICE AS GOODS_PRICE
     , GA.FILE_NO
     , GA.ORIGIN_NAME
     , GA.CHANGE_NAME
FROM CART C
JOIN MEMBER M ON C.MEMBER_NO = M.MEMBER_NO
JOIN GOODS G ON C.GOODS_NO = G.GOODS_NO
JOIN GOODS_ATTACHMENT GA ON G.GOODS_NO = GA.ATTACHMENT_GNO
WHERE M.MEMBER_NO = ?
  
-- 2. ��ٱ��� �߰��� ������
INSERT INTO CART(CART_NO
               , QUANTITY
               , PRICE
               , ADDED_AT
               , MEMBER_NO
               , GOODS_NO)
          VALUES(CART_SEQ.NEXTVAL
               , ?
               , ? * (SELECT PRICE FROM GOODS WHERE GOODS_NO = ?)
               , SYSDATE
               , ?
               , ?)
            


------------------------------------------
-- ȸ������ ������ ������
UPDATE MEMBER
   SET BIRTH_DATE = #{birthDate}
     , PHONE = #{phone}
     , ADDRESS = #{address}
 WHERE MEMBER_NO = #{memberNo}
   AND STATUS = 'Y'

-- ������ ���౸��
ALTER TABLE GOODS_ORDER MODIFY PAYMENT_ID NULL;
ALTER TABLE GOODS_ORDER MODIFY PAYMENT_METHOD NULL;

-- ���� ��ũ��Ʈ�����ؾ��ϴ� �κ�
CREATE TABLE GOODS_ORDER
(
    ORDER_NO        NUMBER                  PRIMARY KEY,
    PAYMENT_ID      VARCHAR2(60), -- NULL ���
    TOTAL_PRICE     NUMBER                  NOT NULL,
    CREATED_DATE    DATE DEFAULT SYSDATE    NOT NULL,
    PAYMENT_METHOD  VARCHAR2(60) CHECK(PAYMENT_METHOD IN ('CARD', 'BANK', 'VBANK', 'CELLPHONE')), -- NULL ���
    PAYMENT_STATUS  VARCHAR2(60) DEFAULT 'CREATED' CHECK(PAYMENT_STATUS IN ('CREATED', 'PAID', 'CANCELED', 'REFUNDED')),
    UPDATED_DATE    DATE,
    MEMBER_NO       NUMBER                  NOT NULL,
    FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);






