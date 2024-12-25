-- ȸ������ ������ ������
UPDATE MEMBER
   SET BIRTH_DATE = #{birthDate}
     , PHONE = #{phone}
     , ADDRESS = #{address}
 WHERE MEMBER_NO = #{memberNo}
   AND STATUS = 'Y'

---------------------------------------------------------------
-- 1. ��ٱ��� ��� ��ȸ�� ������
SELECT M.MEMBER_NO
     , C.CART_NO
     , C.QUANTITY
     , C.PRICE AS CART_PRICE
     , C.ADDED_AT
     , G.GOODS_NO
     , G.CATEGORY
     , G.GOODS_NAME
     , G.GOODS_THUMBNAIL
     , G.PRICE AS GOODS_PRICE
  FROM CART C
  JOIN MEMBER M ON C.MEMBER_NO = M.MEMBER_NO
  JOIN GOODS G ON C.GOODS_NO = G.GOODS_NO
 WHERE M.MEMBER_NO = 1
 
 SELECT GOODS_NO
      , GOODS_THUMBNAIL
		  FROM GOODS
		 WHERE GOODS_NO IN (
		 		SELECT GOODS_NO
		 		  FROM CART
		 		 WHERE MEMBER_NO = ?
		 )
SELECT GOODS_NO
     , GOODS_THUMBNAIL
  FROM GOODS
 WHERE GOODS_NO IN (
            SELECT GOODS_NO
              FROM ORDER_DETAIL
             WHERE ORDER_NO = ?
         )

  
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

-- ��ٱ��� �ߺ�Ȯ��
SELECT COUNT(*) AS COUNT
  FROM CART
 WHERE GOODS_NO = ?
            
-- ��ٱ��� ������ ������
DELETE
  FROM CART
 WHERE CART_NO = ?
 
-- ��ٱ��� ��������+-��ư���� �������� ������
UPDATE CART
   SET QUANTITY = ?
      , PRICE = (
                SELECT PRICE 
                  FROM GOODS 
                 WHERE GOODS_NO = (
                            SELECT GOODS_NO 
                              FROM CART 
                             WHERE CART_NO = ?
                             )
                  ) * ?
      , ADDED_AT = SYSDATE
WHERE MEMBER_NO = ?
  AND CART_NO = ?
  
-- ���� �Ϸ� �� orderNo �������� ��ٱ��� ����
-- orderNo > orderDetail���̺� > goodsNo > īƮ ����
DELETE FROM CART
 WHERE GOODS_NO 
    IN (SELECT GOODS_NO
          FROM ORDER_DETAIL
         WHERE ORDER_NO = ?)
 
 

 
------------------------------------------
-- �ֹ� insert
INSERT INTO GOODS_ORDER(ORDER_NO
                      , PAYMENT_ID
                      , TOTAL_PRICE
                      , CREATED_DATE
                      , PAYMENT_METHOD
                      , PAYMENT_STATUS
                      , UPDATED_DATE
                      , MEMBER_NO) 
                VALUES (ORDER_SEQ.NEXTVAL
                      , NULL
                      , ?
                      , SYSDATE
                      , NULL
                      , 'CREATED'
                      , NULL
                      , ?)
-- �ֹ��� insert
INSERT INTO ORDER_DETAIL(ORDER_DETAIL_NO
                       , QUANTITY
                       , PRICE
                       , TOTAL_PRICE
                       , GOODS_NO
                       , ORDER_NO)
                  VALUES(ORD_DETAIL_SEQ.NEXTVAL
                       , ?
                       , (SELECT PRICE FROM GOODS WHERE GOODS_NO = ?)
                       , ?
                       , ?
                       , ?)
                       


-- �ֹ�ȭ�� �� �����ϱ� ���� order ��ȸ
SELECT *
  FROM GOODS_ORDER
 WHERE ORDER_NO = ?
-- �ֹ�ȭ�� �� �����ϱ� ���� orderDetail 
-- goodsName goodsInfo ��ȸ�ذ�����
SELECT OD.*
     , G.GOODS_NAME
     , G.GOODS_INFO
     , G.GOODS_THUMBNAIL
  FROM ORDER_DETAIL OD
  JOIN GOODS G ON (OD.GOODS_NO = G.GOODS_NO)
 WHERE ORDER_NO = ?

UPDATE GOODS_ORDER
   SET PAYMENT_ID = ?
     , PAYMENT_METHOD = ?
     , PAYMENT_STATUS = 'PAID'
     , UPDATED_DATE = SYSDATE
 WHERE ORDER_NO = ?

-- �� �ֹ��������� ��ȸ

SELECT O.*
     , OD.*
     , G.GOODS_THUMBNAIL
     , G.GOODS_NO
     , G.GOODS_NAME
  FROM GOODS_ORDER O
  JOIN ORDER_DETAIL OD ON O.ORDER_NO = OD.ORDER_NO 
  JOIN GOODS G ON OD.GOODS_NO = G.GOODS_NO
 WHERE O.MEMBER_NO = 1
   AND NOT PAYMENT_STATUS = 'CREATED'
 ORDER BY O.ORDER_NO


SELECT G.*
     , OD.*
  FROM GOODS_ORDER G
  JOIN ORDER_DETAIL OD ON (G.ORDER_NO = OD.ORDER_NO)
 WHERE G.MEMBER_NO = 1
   AND NOT PAYMENT_STATUS = 'CREATED'

-- �� �ֹ��������� ����ϰ�������
SELECT GOODS_NO
     , GOODS_THUMBNAIL
     , ORDER_DETAIL_NO
     , ORDER_NO
  FROM GOODS JOIN ORDER_DETAIL USING (GOODS_NO)
 WHERE GOODS_NO IN (
        SELECT GOODS_NO
          FROM ORDER_DETAIL
         WHERE ORDER_NO IN (SELECT ORDER_NO
                             FROM GOODS_ORDER
                            WHERE MEMBER_NO = 1
                              AND NOT PAYMENT_STATUS = 'CREATED')
 )
 ORDER BY ORDER_DETAIL_NO
 �����ȣ > �ֹ���ȣ > �ֹ����������̺� > ��ǰ��ȣ
 
UPDATE ORDERS
   SET PAYMENT_STATUS = 'CANCELED'
     , UPDATED_DATE = SYSDATE
 WHERE ORDER_NO = ?
---------------------------------------------




























----------------------------------------------

-- �뿩��ǰ ���̵�����

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 1, '��Ʈ', 'ķ�ο� 4�ο� ��Ʈ', NULL, '4�� ������ ����� �� �ִ� �˳��� ķ�� ��Ʈ.', '4�ο� ��Ʈ', NULL, 80000, 0, 0, SYSDATE, 10, 10, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 2, '��Ʈ', '2�ο� �ʰ淮 ��Ʈ', NULL, '2�ο� �ʰ淮 ��Ʈ�� ������ ��ġ�� ����.', '�ʰ淮 2�ο� ��Ʈ', NULL, 50000, 0, 0, SYSDATE, 15, 15, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 3, 'Ÿ��', '���� Ÿ��', NULL, '�޺��� ������ �� �ִ� ���� Ÿ��.', 'ķ�ο� ���� Ÿ��', NULL, 40000, 0, 0, SYSDATE, 8, 8, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 11, 'ü��', '���� ķ�� ü��', NULL, '����� ķ�ο� ���̽� ����.', '���̽� ķ�� ü��', NULL, 15000, 0, 0, SYSDATE, 30, 30, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 5, '���̺�', '���̽� ķ�� ���̺�', NULL, '�ٸ��� ���̽� ���̺�, 4�ο�.', '4�ο� ķ�� ���̺�', NULL, 30000, 0, 0, SYSDATE, 20, 20, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 6, '��Ʈ', '6�ο� ���� ��Ʈ', NULL, '���� ���� ķ�ο� ������ 6�ο� ��Ʈ.', '���� ���� ��Ʈ', NULL, 120000, 0, 0, SYSDATE, 5, 5, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 7, 'ü��', 'ķ�� ��Ŭ���̳� ü��', NULL, '����� ķ�� ��Ŭ���̳� ü��.', '��Ŭ���̳� ķ�� ü��', NULL, 35000, 0, 0, SYSDATE, 25, 25, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 8, '���̺�', '�Ѿ� ķ�� ���̺�', NULL, '������ ���� �� �ִ� �Ѿ� ���̺�.', '�Ѿ� ���̺�', NULL, 45000, 0, 0, SYSDATE, 15, 15, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 9, '����', 'LED ����', NULL, '��� ���� ���ӵǴ� ķ�ο� LED ����.', 'ķ�ο� LED ����', NULL, 20000, 0, 0, SYSDATE, 30, 30, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 10, '��', '�޴�� ķ�� ��', NULL, '������ �ż��ϰ� ������ �� �ִ� ķ�� ��.', '�޴�� ��', NULL, 55000, 0, 0, SYSDATE, 10, 10, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 11, '�Ҹ�ǰ', 'ķ�ο� ����', NULL, '������ �������� ȭ���� ���ϰ� ���� Ÿ�� ����.', 'ķ�ο� ����', NULL, 10000, 0, 0, SYSDATE, 50, 50, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 12, '�Ҹ�ǰ', '�̼Ұ���', NULL, '�޴�� �������ʿ� �Բ����ϴ� �̼Ұ���.', 'ķ�ο� �̼Ұ���', NULL, 5000, 0, 0, SYSDATE, 100, 100, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 13, '�Ҹ�ǰ', 'ķ�ο� ��ȸ�� ����', NULL, 'ķ�ο��� ����� �� �ִ� ������ ��ȸ�� ����.', '��ȸ�� ����', NULL, 3000, 0, 0, SYSDATE, 200, 200, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 14, '�Ҹ�ǰ', 'ķ�ο� �޴�� ����', NULL, '���� ������ �� �ִ� ķ�ο� �޴�� ����.', '�޴�� ����', NULL, 8000, 0, 0, SYSDATE, 50, 50, 'Y');

INSERT INTO GOODS (GOODS_NO, CATEGORY, GOODS_NAME, GOODS_THUMBNAIL, GOODS_CONTENT, GOODS_INFO, MARK, PRICE, DISCOUNT, VIEWS, ENROLL_DATE, TOTAL_STOCK, REMAIN_STOCK, STATUS) VALUES
( 15, '�Ҹ�ǰ', 'ķ�ο� �ճ���', NULL, '�߿� ������ ������ �޴�� �ճ���.', '�޴�� �ճ���', NULL, 4000, 0, 0, SYSDATE, 100, 100, 'Y');
commit
--------------------------------------------------------------
--
-- CART ���̵�����

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(1, 2, 160000, SYSDATE, 1, 1);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(2, 1, 50000, SYSDATE, 1, 2);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(3, 3, 120000, SYSDATE, 1, 3);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(4, 1, 15000, SYSDATE, 1, 4);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(5, 2, 60000, SYSDATE, 1, 5);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(6, 1, 120000, SYSDATE, 1, 6);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(7, 98, 105000, SYSDATE, 1, 7);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(8, 2, 90000, SYSDATE, 1, 8);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(9, 99, 60000, SYSDATE, 1, 9);

INSERT INTO CART (CART_NO, QUANTITY, PRICE, ADDED_AT, MEMBER_NO, GOODS_NO) VALUES
(10, 1, 55000, SYSDATE, 1, 10);
commit;


INSERT INTO MEMBER(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, BIRTH_DATE, PHONE, EMAIL, SIGNUP_DATE, ADDRESS)
VALUES(MEMBER_SEQ.NEXTVAL, 'user01', '$2a$10$eOGLex8k5BG.HHFkJYX.6eaOLJ6NCTEjJQK1z.L5Gb1Nu5cMMvL/u', 'ȫ�浿', '1990-01-01', '010-1234-5678', 'user@example.com', '2024-12-22', '����Ư���� �߱� ������');
INSERT INTO MEMBER(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, BIRTH_DATE, PHONE, EMAIL, SIGNUP_DATE, ADDRESS)
VALUES(MEMBER_SEQ.NEXTVAL, 'user02', '$2a$10$eOGLex8k5BG.HHFkJYX.6eaOLJ6NCTEjJQK1z.L5Gb1Nu5cMMvL/u', 'ȫ�浿', '1990-01-01', '010-1234-5678', 'user2@example.com', '2024-12-22', '����Ư���� �߱� ������');
INSERT INTO MEMBER(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, BIRTH_DATE, PHONE, EMAIL, SIGNUP_DATE, ADDRESS)
VALUES(MEMBER_SEQ.NEXTVAL, 'user03', '$2a$10$eOGLex8k5BG.HHFkJYX.6eaOLJ6NCTEjJQK1z.L5Gb1Nu5cMMvL/u', 'ȫ�浿', '1990-01-01', '010-1234-5678', 'user3@example.com', '2024-12-22', '����Ư���� �߱� ������');
