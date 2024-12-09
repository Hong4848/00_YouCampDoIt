-- 1. 장바구니 목록 조회용 쿼리문
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
  
-- 2. 장바구니 추가용 쿼리문
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
            
















