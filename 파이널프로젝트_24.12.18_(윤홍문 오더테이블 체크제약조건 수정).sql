-- 테이블 및 시퀀스 초기화(삭제 순번 변경 시 오류 가능성▲)

-- 게시판관련
DROP TABLE LOST_ATTACHMENT;
DROP TABLE LOST;
DROP TABLE REVIEW_ATTACHMENT;
DROP TABLE REVIEW_LIKE;
DROP TABLE REVIEW_REPLY;
DROP TABLE REVIEW;
DROP TABLE NOTICE;
-- 예약관련
DROP TABLE RESERVE;
DROP TABLE CAMPSITE;
DROP TABLE SECTION;
-- 상품관련(대여)
DROP TABLE ORDER_DETAIL;
DROP TABLE GOODS_ORDER;
DROP TABLE CART;
DROP TABLE DIBS;
DROP TABLE GOODS_ATTACHMENT;
DROP TABLE GOODS;
-- 회원관련
DROP TABLE IDENTIFICATION;
DROP TABLE MEMBER;
--------------------------------------------------------------------------------
DROP SEQUENCE LOST_FILE_SEQ;
DROP SEQUENCE LOST_SEQ;
DROP SEQUENCE FILE_SEQ;
DROP SEQUENCE REPLY_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE NOTICE_SEQ;

DROP SEQUENCE RESERVE_SEQ;
DROP SEQUENCE CAMP_SEQ;

DROP SEQUENCE ORD_DETAIL_SEQ;
DROP SEQUENCE ORDER_SEQ;
DROP SEQUENCE CART_SEQ;
DROP SEQUENCE GOODS_SEQ;
DROP SEQUENCE GOODS_ATTACHMENT_SEQ;

DROP SEQUENCE MEMBER_SEQ;
--------------------------------------------------------------------------------


-- 회원테이블, 시퀀스 생성
CREATE TABLE MEMBER
(
    MEMBER_NO           NUMBER                  PRIMARY KEY,
    MEMBER_ID           VARCHAR2(30)            UNIQUE NOT NULL,
    MEMBER_PWD          VARCHAR2(100)            NOT NULL,
    MEMBER_NAME         VARCHAR2(15)            NOT NULL,
    BIRTH_DATE          DATE,
    PHONE               CHAR(13)                NOT NULL,
    EMAIL               VARCHAR2(300)           UNIQUE NOT NULL,
    SIGNUP_DATE         DATE DEFAULT SYSDATE    NOT NULL,
    ADDRESS             VARCHAR2(200)           NOT NULL,
    STATUS              VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N'))
);

CREATE SEQUENCE MEMBER_SEQ NOCACHE;

COMMENT ON COLUMN MEMBER.MEMBER_NO IS '시퀀스로 채번하여 등록';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '로그인 시 필요한 회원의 ID';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '로그인 시 필요한 회원의 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원의 이름';
COMMENT ON COLUMN MEMBER.BIRTH_DATE IS '회원의 생년월일';
COMMENT ON COLUMN MEMBER.PHONE IS '회원의 전화번호. -포함 13자리 숫자';
COMMENT ON COLUMN MEMBER.EMAIL IS '회원의 이메일 주소. 이메일 주소로 본인인증 처리';
COMMENT ON COLUMN MEMBER.SIGNUP_DATE IS '회원가입일. SYSDATE로 자동등록';
COMMENT ON COLUMN MEMBER.ADDRESS IS '회원의 집주소(도로명주소)';
COMMENT ON COLUMN MEMBER.STATUS IS '회원 탈퇴 여부. 존속 : Y, 탈퇴 : N';
--------------------------------------------------------------------------------


-- 인증 테이블 생성
CREATE TABLE IDENTIFICATION
(
    EMAIL               VARCHAR2(200)            NOT NULL,
    AUTH_CODE           VARCHAR2(200)            NOT NULL,
    AUTH_CODE_DATE      DATE                     DEFAULT SYSDATE NOT NULL
);

COMMENT ON COLUMN IDENTIFICATION.EMAIL IS '이메일 주소';
COMMENT ON COLUMN IDENTIFICATION.AUTH_CODE IS '인증번호';
COMMENT ON COLUMN IDENTIFICATION.AUTH_CODE_DATE IS '인증번호 발급일';
--------------------------------------------------------------------------------


-- 캠핑용품 테이블, 시퀀스 생성
CREATE TABLE GOODS
(
    GOODS_NO            NUMBER                  PRIMARY KEY,
    CATEGORY            VARCHAR2(60)            NOT NULL,
    GOODS_NAME          VARCHAR2(60)            NOT NULL,
    GOODS_THUMBNAIL     CLOB,
    GOODS_CONTENT       CLOB                    NOT NULL,
    GOODS_INFO          CLOB                    NOT NULL,
    MARK                VARCHAR2(60),
    PRICE               NUMBER DEFAULT 0,
    DISCOUNT            NUMBER DEFAULT 0.0,
    VIEWS               NUMBER DEFAULT 0,
    ENROLL_DATE         DATE DEFAULT SYSDATE    NOT NULL,
    TOTAL_STOCK         NUMBER                  NOT NULL,
    REMAIN_STOCK        NUMBER DEFAULT 0,
    STATUS              VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N'))
);
CREATE SEQUENCE GOODS_SEQ NOCACHE;
COMMENT ON COLUMN GOODS.GOODS_NO IS '시퀀스로 채번하여 등록';
COMMENT ON COLUMN GOODS.CATEGORY IS '카테고리 별로 분류하기 위한 제품의 종류';
COMMENT ON COLUMN GOODS.GOODS_NAME IS '제품의 이름';
COMMENT ON COLUMN GOODS.GOODS_THUMBNAIL IS '제품 썸네일 이미지. CLOB타입으로 이미지 등록';
COMMENT ON COLUMN GOODS.GOODS_CONTENT IS '제품 설명 내용. CLOB타입으로 이미지까지 한 번에 등록';
COMMENT ON COLUMN GOODS.GOODS_INFO IS '제품 요약 설명.';
COMMENT ON COLUMN GOODS.MARK IS '제품의 제조사';
COMMENT ON COLUMN GOODS.PRICE IS '제품의 가격';
COMMENT ON COLUMN GOODS.DISCOUNT IS '제품의 할인율';
COMMENT ON COLUMN GOODS.VIEWS IS '제품 페이지 조회 수';
COMMENT ON COLUMN GOODS.ENROLL_DATE IS '제품 등록일';
COMMENT ON COLUMN GOODS.TOTAL_STOCK IS '보유한 제품의 총 재고 개수';
COMMENT ON COLUMN GOODS.REMAIN_STOCK IS '제품의 남은 재고 개수.';
COMMENT ON COLUMN GOODS.STATUS IS '제품 존속 여부. 존속 : Y, 폐기(더 이상 대여X) : N';
--------------------------------------------------------------------------------


-- 캠핑용품 첨부파일 테이블, 시퀀스 생성
CREATE TABLE GOODS_ATTACHMENT
(
    FILE_NO         NUMBER                  PRIMARY KEY,
    ORIGIN_NAME     VARCHAR2(200),
    CHANGE_NAME     VARCHAR2(200),
    FILE_PATH       VARCHAR2(200),
    UPLOAD_DATE     DATE DEFAULT SYSDATE,
    FILE_LEVEL      NUMBER                  CHECK(FILE_LEVEL IN(1, 2)),
    STATUS          VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')),
    ATTACHMENT_GNO  NUMBER                  NOT NULL,
    FOREIGN KEY(ATTACHMENT_GNO) REFERENCES GOODS(GOODS_NO)
);

CREATE SEQUENCE GOODS_ATTACHMENT_SEQ NOCACHE;

COMMENT ON COLUMN GOODS_ATTACHMENT.FILE_NO IS '첨부파일번호. 시퀀스로 채번';
COMMENT ON COLUMN GOODS_ATTACHMENT.ORIGIN_NAME IS '첨부파일 원본명';
COMMENT ON COLUMN GOODS_ATTACHMENT.CHANGE_NAME IS '첨부파일 수정명';
COMMENT ON COLUMN GOODS_ATTACHMENT.FILE_PATH IS '첨부파일 저장경로';
COMMENT ON COLUMN GOODS_ATTACHMENT.UPLOAD_DATE IS '업로드 일';
COMMENT ON COLUMN GOODS_ATTACHMENT.FILE_LEVEL IS '이미지 구분. 1 : 섬네일, 2 : 상세이미지';
COMMENT ON COLUMN GOODS_ATTACHMENT.STATUS IS '첨부파일상태. 유효한 첨부파일 : Y, 삭제한 첨부파일 : N';
COMMENT ON COLUMN GOODS_ATTACHMENT.ATTACHMENT_GNO IS '참고 제품 번호';
--------------------------------------------------------------------------------


-- 찜 테이블 생성
CREATE TABLE DIBS
(
    DIBS_MEMBER    NUMBER   NOT NULL,
    DIBS_GOODS     NUMBER   NOT NULL,
    FOREIGN KEY(DIBS_MEMBER) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(DIBS_GOODS) REFERENCES GOODS(GOODS_NO)
);

COMMENT ON COLUMN DIBS.DIBS_MEMBER IS '찜한 회원 번호';
COMMENT ON COLUMN DIBS.DIBS_GOODS IS '이 회원이 찜한 제품 번호';
--------------------------------------------------------------------------------


-- 장바구니 테이블, 시퀀스 생성
CREATE TABLE CART
(
    CART_NO     NUMBER                  PRIMARY KEY,
    QUANTITY    NUMBER                  NOT NULL,
    PRICE       NUMBER                  NOT NULL,
    ADDED_AT    DATE DEFAULT SYSDATE    NOT NULL,
    MEMBER_NO   NUMBER                  NOT NULL,
    GOODS_NO    NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(GOODS_NO) REFERENCES GOODS(GOODS_NO)
);

CREATE SEQUENCE CART_SEQ NOCACHE;

COMMENT ON COLUMN CART.CART_NO IS '장바구니 번호. 시퀀스로 채번';
COMMENT ON COLUMN CART.QUANTITY IS '상품의 수량';
COMMENT ON COLUMN CART.PRICE IS '항목 총 금액. 제품가격*수량';
COMMENT ON COLUMN CART.ADDED_AT IS '장바구니에 담은 날짜. 30일이 넘으면 삭제';
COMMENT ON COLUMN CART.MEMBER_NO IS '장바구니에 담은 회원 번호';
COMMENT ON COLUMN CART.GOODS_NO IS '이 회원이 담은 제품의 번호';
--------------------------------------------------------------------------------


-- 주문 테이블, 시퀀스 생성
CREATE TABLE GOODS_ORDER
(
    ORDER_NO        NUMBER                  PRIMARY KEY,
    PAYMENT_ID      VARCHAR2(60),
    TOTAL_PRICE     NUMBER                  NOT NULL,
    CREATED_DATE    DATE DEFAULT SYSDATE    NOT NULL,
    PAYMENT_METHOD  VARCHAR2(60) CHECK(PAYMENT_METHOD IN('CARD', 'BANK', 'VBANK', 'CELLPHONE')),
    PAYMENT_STATUS  VARCHAR2(60) DEFAULT 'CREATED' CHECK(PAYMENT_STATUS IN('CREATED', 'PAID', 'CANCELED', 'REFUNDED')),
    UPDATED_DATE    DATE ,
    MEMBER_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

CREATE SEQUENCE ORDER_SEQ NOCACHE;

COMMENT ON COLUMN GOODS_ORDER.ORDER_NO IS '시퀀스로 채번. 나이스페이 Moid와 호환';
COMMENT ON COLUMN GOODS_ORDER.PAYMENT_ID IS '나이스페이의 TID와 호환';
COMMENT ON COLUMN GOODS_ORDER.TOTAL_PRICE IS '나이스페이의 Amt와 호환';
COMMENT ON COLUMN GOODS_ORDER.CREATED_DATE IS '주문 생성 일';
COMMENT ON COLUMN GOODS_ORDER.PAYMENT_METHOD IS '결제 방식. (CARD, BANK, VBANK, CELLPHONE - 나이스페이의 PayMethod와 호환)';
COMMENT ON COLUMN GOODS_ORDER.PAYMENT_STATUS IS 'CREATED: 사용자 결제 요청, PAID: 사용자 결제 완료, CANCELED: 사용자의 주문 취소 요청 시REFUNDED: 관리자 취소 승인';
COMMENT ON COLUMN GOODS_ORDER.UPDATED_DATE IS '결제완료. 주문취소 등 상태변경+부분 취소 등의 경우 로그 기록';
COMMENT ON COLUMN GOODS_ORDER.MEMBER_NO IS '주문한 회원의 번호';
--------------------------------------------------------------------------------


-- 주문 상세 테이블, 시퀀스 생성
CREATE TABLE ORDER_DETAIL
(
    ORDER_DETAIL_NO     NUMBER      PRIMARY KEY,
    QUANTITY            NUMBER      NOT NULL,
    PRICE               NUMBER      NOT NULL,
    TOTAL_PRICE         NUMBER      NOT NULL,
    GOODS_NO            NUMBER      NOT NULL,
    ORDER_NO            NUMBER      NOT NULL,
    FOREIGN KEY(GOODS_NO) REFERENCES GOODS(GOODS_NO),
    FOREIGN KEY(ORDER_NO) REFERENCES GOODS_ORDER(ORDER_NO)
);

CREATE SEQUENCE ORD_DETAIL_SEQ NOCACHE;

COMMENT ON COLUMN ORDER_DETAIL.ORDER_DETAIL_NO IS '주문 상세 번호. 시퀀스로 채번';
COMMENT ON COLUMN ORDER_DETAIL.QUANTITY IS '수량. 장바구니 상품일 경우 필수';
COMMENT ON COLUMN ORDER_DETAIL.PRICE IS '개별 금액';
COMMENT ON COLUMN ORDER_DETAIL.TOTAL_PRICE IS '항목 별 총 금액';
COMMENT ON COLUMN ORDER_DETAIL.GOODS_NO IS '주문하고자 하는 제품 번호';
COMMENT ON COLUMN ORDER_DETAIL.ORDER_NO IS '주문 번호';
--------------------------------------------------------------------------------


-- 캠핑장 섹션 테이블 생성
CREATE TABLE SECTION
(
    SECTION             CHAR(1)         CHECK(SECTION IN('A', 'B', 'C', 'D', 'E', 'F')) PRIMARY KEY,
    SECTION_DETAIL      VARCHAR2(60)    CHECK(SECTION_DETAIL IN('캠핑카존', '글램핑존', '일반석', '바베큐장')) NOT NULL
);

COMMENT ON COLUMN SECTION.SECTION IS '섹션명. A~F';
COMMENT ON COLUMN SECTION.SECTION_DETAIL IS '섹션 설명. 캠핑카존, 글램핑존, 일반석, 바베큐장';
--------------------------------------------------------------------------------


-- 캠핑장 부지 테이블, 시퀀스 생성
CREATE TABLE CAMPSITE
(
    CAMPSITE_ID     NUMBER  PRIMARY KEY,
    SPOT_NO         NUMBER  CHECK(SPOT_NO BETWEEN 1 AND 10) NOT NULL,
    PRICE           NUMBER  NOT NULL,
    SECTION         CHAR(1) NOT NULL,
    FOREIGN KEY(SECTION) REFERENCES SECTION(SECTION)
);

CREATE SEQUENCE CAMP_SEQ NOCACHE;

COMMENT ON COLUMN CAMPSITE.CAMPSITE_ID IS '부지 고유 ID. 시퀀스로 채번';
COMMENT ON COLUMN CAMPSITE.SPOT_NO IS '섹션 내 자리번호. 1~10';
COMMENT ON COLUMN CAMPSITE.PRICE IS '1박 기준 이용요금';
COMMENT ON COLUMN CAMPSITE.SECTION IS 'A~F';
--------------------------------------------------------------------------------


-- 예약 테이블, 시퀀스 생성
CREATE TABLE RESERVE
(
    RESERVE_NO      NUMBER                  PRIMARY KEY,
    START_DATE      DATE                    NOT NULL,
    END_DATE        DATE                    NOT NULL,
    NIGHTS          NUMBER CHECK(NIGHTS IN(1, 2)) NOT NULL,
    --------------------------------------------------------------------------------------------------------
    PAYMENT_ID      VARCHAR2(60)            NOT NULL,
    PRICE           NUMBER                  NOT NULL,
    PAYMENT_DATE    DATE DEFAULT SYSDATE    NOT NULL,
    PAYMENT_METHOD  VARCHAR2(60) CHECK(PAYMENT_METHOD IN('CARD', 'BANK', 'VBANK', 'CELLPHONE')) NOT NULL,
    PAYMENT_STATUS  VARCHAR2(60) DEFAULT 'CREATED' CHECK(PAYMENT_STATUS IN('CREATED', 'PAID', 'CANCELED', 'REFUNDED')),
    UPDATE_DATE     DATE,
    MEMBER_NO       NUMBER                  NOT NULL,
    CAMPSITE_ID     NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(CAMPSITE_ID) REFERENCES CAMPSITE(CAMPSITE_ID)
);

CREATE SEQUENCE RESERVE_SEQ NOCACHE;

COMMENT ON COLUMN RESERVE.RESERVE_NO IS '예약번호. 시퀀스로 채번';
COMMENT ON COLUMN RESERVE.START_DATE IS '체크인 날짜. 년월일시분초를 포함한 날짜 타입';
COMMENT ON COLUMN RESERVE.END_DATE IS '체크아웃 날짜. 년월일시분초를 포함한 날짜 타입';
COMMENT ON COLUMN RESERVE.NIGHTS IS '숙박일수';
COMMENT ON COLUMN RESERVE.PAYMENT_ID IS '결제 식별자';
COMMENT ON COLUMN RESERVE.PRICE IS '총 결제 금액';
COMMENT ON COLUMN RESERVE.PAYMENT_DATE IS '결제 날짜';
COMMENT ON COLUMN RESERVE.PAYMENT_METHOD IS '결제 방식. CARD, BANK, VBANK, CELLPHONE - 나이스페이의 PayMethod와 호환';
COMMENT ON COLUMN RESERVE.PAYMENT_STATUS IS 'CREATED: 사용자의 결제 요청 시, PAID: 사용자의 결제 완료 시, CANCELED: 사용자의 주문 취소 요청 시, REFUNDED: 관리자가 사용자의 취소 요청 확인 시';
COMMENT ON COLUMN RESERVE.UPDATE_DATE IS '결제완료, 주문취소 등 상태 변경 + 부분 취소등의 경우 로그기록';
COMMENT ON COLUMN RESERVE.MEMBER_NO IS '예약한 회원의 번호';
COMMENT ON COLUMN RESERVE.CAMPSITE_ID IS '예약한 부지 번호';
--------------------------------------------------------------------------------


-- 공지사항 테이블, 시퀀스 생성
CREATE TABLE NOTICE
(
    NOTICE_NO       NUMBER                  PRIMARY KEY,
    NOTICE_TITLE    VARCHAR2(200)           NOT NULL,
    NOTICE_CONTENT  VARCHAR2(4000)          NOT NULL,
    CREATE_DATE     DATE DEFAULT SYSDATE    NOT NULL,
    COUNT           NUMBER DEFAULT 0        NOT NULL,
    ORIGIN_NAME     VARCHAR2(200),
    CHARGE_NAME     VARCHAR2(200),
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N'))
);

CREATE SEQUENCE NOTICE_SEQ NOCACHE;

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '공지사항 번호. 시퀀스로 채번';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '공지사항 제목';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '공지사항 내용';
COMMENT ON COLUMN NOTICE.CREATE_DATE IS '공지사항 작성일';
COMMENT ON COLUMN NOTICE.COUNT IS '조회수';
COMMENT ON COLUMN NOTICE.ORIGIN_NAME IS '첨부파일 1개의 원본명';
COMMENT ON COLUMN NOTICE.CHARGE_NAME IS '첨부파일 1개의 수정명';
COMMENT ON COLUMN NOTICE.STATUS IS '글 상태. Y : 존속, N : 삭제';
--------------------------------------------------------------------------------


CREATE TABLE REVIEW
(
    REVIEW_NO       NUMBER                  PRIMARY KEY, -- 후기 게시판 번호
    REVIEW_TITLE    VARCHAR2(200)           NOT NULL,   -- 후기 제목
    REVIEW_CONTENT  VARCHAR2(4000)          NOT NULL,  -- 후기 내용
    REVIEW_COUNT    NUMBER DEFAULT 0        NOT NULL,   -- 조회수
    CREATE_DATE     DATE DEFAULT SYSDATE    NOT NULL,   -- 작성일
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N')), -- 글 상태
    MEMBER_NO       NUMBER                  NOT NULL,   -- 작성자 회원 번호
    REVIEW_WRITER   VARCHAR2(15)            NOT NULL,   -- 작성자 이름
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) -- 외래 키 설정
);

CREATE SEQUENCE REVIEW_SEQ NOCACHE;

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '후기 게시판 번호. 시퀀스로 채번';
COMMENT ON COLUMN REVIEW.REVIEW_TITLE IS '후기 제목';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '후기 내용';
COMMENT ON COLUMN REVIEW.REVIEW_COUNT IS '조회수';
COMMENT ON COLUMN REVIEW.CREATE_DATE IS '후기 작성일';
COMMENT ON COLUMN REVIEW.STATUS IS '글 상태. Y : 존속, N : 삭제';
COMMENT ON COLUMN REVIEW.MEMBER_NO IS '작성자 회원 아이디';
COMMENT ON COLUMN REVIEW.REVIEW_WRITER IS '작성자 이름 또는 별칭';
--------------------------------------------------------------------------------


-- 후기게시판 댓글 테이블, 시퀀스 생성
CREATE TABLE REVIEW_REPLY
(
    REPLY_NO        NUMBER                  PRIMARY KEY,
    REPLY_CONTENT   VARCHAR2(400)           NOT NULL,
    CREATE_DATE     DATE DEFAULT SYSDATE    NOT NULL,
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N')),
    MEMBER_NO       NUMBER                  NOT NULL,
    REVIEW_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

CREATE SEQUENCE REPLY_SEQ NOCACHE;

COMMENT ON COLUMN REVIEW_REPLY.REPLY_NO IS '댓글 번호';
COMMENT ON COLUMN REVIEW_REPLY.REPLY_CONTENT IS '댓글 내용';
COMMENT ON COLUMN REVIEW_REPLY.CREATE_DATE IS '댓글 작성일';
COMMENT ON COLUMN REVIEW_REPLY.STATUS IS '글 상태. Y : 존속, N : 삭제';
COMMENT ON COLUMN REVIEW_REPLY.MEMBER_NO IS '댓글을 작성한 회원의 번호';
COMMENT ON COLUMN REVIEW_REPLY.REVIEW_NO IS '댓글이 작성된 게시글 번호';
--------------------------------------------------------------------------------


-- 후기게시판 좋아요 테이블 생성
CREATE TABLE REVIEW_LIKE
(
    MEMBER_NO       NUMBER                  NOT NULL,
    REVIEW_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

COMMENT ON COLUMN REVIEW_REPLY.MEMBER_NO IS '좋아요 한 회원의 번호';
COMMENT ON COLUMN REVIEW_REPLY.REVIEW_NO IS '좋아요 한 게시글 번호';
--------------------------------------------------------------------------------


-- 후기게시판 첨부파일 테이블, 시퀀스 생성
CREATE TABLE REVIEW_ATTACHMENT
(
    FILE_NO         NUMBER                  PRIMARY KEY,
    ORIGIN_NAME     VARCHAR2(200),
    CHANGE_NAME     VARCHAR2(200),
    FILE_PATH       VARCHAR2(200),
    UPLOAD_DATE     DATE DEFAULT SYSDATE    NOT NULL,
    FILE_LEVEL      NUMBER                  CHECK(FILE_LEVEL IN(1, 2)),
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N')),
    REVIEW_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

CREATE SEQUENCE FILE_SEQ NOCACHE;

COMMENT ON COLUMN REVIEW_ATTACHMENT.FILE_NO IS '파일 번호';
COMMENT ON COLUMN REVIEW_ATTACHMENT.ORIGIN_NAME IS '원본 파일명';
COMMENT ON COLUMN REVIEW_ATTACHMENT.CHANGE_NAME IS '수정 파일명';
COMMENT ON COLUMN REVIEW_ATTACHMENT.FILE_PATH IS '파일 경로';
COMMENT ON COLUMN REVIEW_ATTACHMENT.UPLOAD_DATE IS '업로드 날짜';
COMMENT ON COLUMN REVIEW_ATTACHMENT.FILE_LEVEL IS '1 : 썸네일, 2 : 상세이미지';
COMMENT ON COLUMN REVIEW_ATTACHMENT.STATUS IS '파일 상태. Y : 존속, N : 삭제';
COMMENT ON COLUMN REVIEW_ATTACHMENT.REVIEW_NO IS '참조 게시글 번호';
--------------------------------------------------------------------------------


-- 분실물 게시판 테이블, 시퀀스 생성
CREATE TABLE LOST
(
    LOST_NO         NUMBER                  PRIMARY KEY,
    CATEGORY_NANE   VARCHAR2(30)            NOT NULL,
    LOST_TITLE      VARCHAR2(200)           NOT NULL,
    LOST_CONTENT    VARCHAR2(4000)          NOT NULL,
    FOUND_STATUS    CHAR(1) DEFAULT 'N'     CHECK(FOUND_STATUS IN('Y', 'N')),
    COUNT           NUMBER DEFAULT 0        NOT NULL,
    CREATE_DATE     DATE DEFAULT SYSDATE    NOT NULL,
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N'))
);

CREATE SEQUENCE LOST_SEQ NOCACHE;

COMMENT ON COLUMN LOST.LOST_NO IS '분실물 게시글 번호';
COMMENT ON COLUMN LOST.CATEGORY_NANE IS '카테고리 명. 귀중품, 캠핑용품, 위생용품, 의류...';
COMMENT ON COLUMN LOST.LOST_TITLE IS '분실물 게시글 제목';
COMMENT ON COLUMN LOST.LOST_CONTENT IS '분실물 게시글 내용';
COMMENT ON COLUMN LOST.FOUND_STATUS IS '분실물 처리상태. Y : 처리완료, N : 미처리';
COMMENT ON COLUMN LOST.COUNT IS '조회수';
COMMENT ON COLUMN LOST.CREATE_DATE IS '게시글 작성일';
COMMENT ON COLUMN LOST.STATUS IS '글 상태. Y : 존속, N : 삭제';
--------------------------------------------------------------------------------


-- 분실물 게시판 첨부파일 테이블, 시퀀스 생성
CREATE TABLE LOST_ATTACHMENT
(
    FILE_NO         NUMBER                  PRIMARY KEY,
    ORIGIN_NAME     VARCHAR2(200),
    CHANGE_NAME     VARCHAR2(200),
    FILE_PATH       VARCHAR2(200),
    UPLOAD_DATE     DATE DEFAULT SYSDATE    NOT NULL,
    FILE_LEVEL      NUMBER                  CHECK(FILE_LEVEL IN(1, 2)),
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N')),
    LOST_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(LOST_NO) REFERENCES LOST(LOST_NO)
);

CREATE SEQUENCE LOST_FILE_SEQ NOCACHE;

COMMENT ON COLUMN LOST_ATTACHMENT.FILE_NO IS '파일 번호';
COMMENT ON COLUMN LOST_ATTACHMENT.ORIGIN_NAME IS '원본 파일명';
COMMENT ON COLUMN LOST_ATTACHMENT.CHANGE_NAME IS '수정 파일명';
COMMENT ON COLUMN LOST_ATTACHMENT.FILE_PATH IS '파일 경로';
COMMENT ON COLUMN LOST_ATTACHMENT.UPLOAD_DATE IS '업로드 날짜';
COMMENT ON COLUMN LOST_ATTACHMENT.FILE_LEVEL IS '1 : 썸네일, 2 : 상세이미지';
COMMENT ON COLUMN LOST_ATTACHMENT.STATUS IS '파일 상태. Y : 존속, N : 삭제';
COMMENT ON COLUMN LOST_ATTACHMENT.LOST_NO IS '참조한 분실물 게시글 번호';



