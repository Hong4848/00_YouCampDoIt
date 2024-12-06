-- 1. ��ٱ��� ��� ��ȸ�� ������
SELECT M.MEMBER_NO
     , C.*
     , G.GOODS_NAME
     , G.GOODS_CONTENT
  FROM CART C
  JOIN MEMBER M ON C.MEMBER_NO = M.MEMBER_NO
  JOIN GOODS G ON C.GOODS_NO = G.GOODS_NO
 WHERE MEMBER_NO = ?
  
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
            
















