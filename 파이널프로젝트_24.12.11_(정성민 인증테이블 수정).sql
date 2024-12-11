-- ���̺� �� ������ �ʱ�ȭ(���� ���� ���� �� ���� ���ɼ���)

-- �Խ��ǰ���
DROP TABLE LOST_ATTACHMENT;
DROP TABLE LOST;
DROP TABLE REVIEW_ATTACHMENT;
DROP TABLE REVIEW_LIKE;
DROP TABLE REVIEW_REPLY;
DROP TABLE REVIEW;
DROP TABLE NOTICE;
-- �������
DROP TABLE RESERVE;
DROP TABLE CAMPSITE;
DROP TABLE SECTION;
-- ��ǰ����(�뿩)
DROP TABLE ORDER_DETAIL;
DROP TABLE GOODS_ORDER;
DROP TABLE CART;
DROP TABLE DIBS;
DROP TABLE GOODS_ATTACHMENT;
DROP TABLE GOODS;
-- ȸ������
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


-- ȸ�����̺�, ������ ����
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

COMMENT ON COLUMN MEMBER.MEMBER_NO IS '�������� ä���Ͽ� ���';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '�α��� �� �ʿ��� ȸ���� ID';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '�α��� �� �ʿ��� ȸ���� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���� �̸�';
COMMENT ON COLUMN MEMBER.BIRTH_DATE IS 'ȸ���� �������';
COMMENT ON COLUMN MEMBER.PHONE IS 'ȸ���� ��ȭ��ȣ. -���� 13�ڸ� ����';
COMMENT ON COLUMN MEMBER.EMAIL IS 'ȸ���� �̸��� �ּ�. �̸��� �ּҷ� �������� ó��';
COMMENT ON COLUMN MEMBER.SIGNUP_DATE IS 'ȸ��������. SYSDATE�� �ڵ����';
COMMENT ON COLUMN MEMBER.ADDRESS IS 'ȸ���� ���ּ�(���θ��ּ�)';
COMMENT ON COLUMN MEMBER.STATUS IS 'ȸ�� Ż�� ����. ���� : Y, Ż�� : N';
--------------------------------------------------------------------------------


-- ���� ���̺� ����
CREATE TABLE IDENTIFICATION
(
    EMAIL               VARCHAR2(200)            NOT NULL,
    AUTH_CODE           VARCHAR2(200)            NOT NULL,
    AUTH_CODE_DATE      DATE                     DEFAULT SYSDATE NOT NULL
);

COMMENT ON COLUMN IDENTIFICATION.EMAIL IS '�̸��� �ּ�';
COMMENT ON COLUMN IDENTIFICATION.AUTH_CODE IS '������ȣ';
COMMENT ON COLUMN IDENTIFICATION.AUTH_CODE_DATE IS '������ȣ �߱���';
--------------------------------------------------------------------------------


-- ķ�ο�ǰ ���̺�, ������ ����
CREATE TABLE GOODS
(
    GOODS_NO            NUMBER                  PRIMARY KEY,
    CATEGORY            VARCHAR2(60)            NOT NULL,
    GOODS_NAME          VARCHAR2(60)            NOT NULL,
    GOODS_CONTENT       CLOB                    NOT NULL,
    MARK                VARCHAR2(60),
    PRICE               NUMBER DEFAULT 0,
    VIEWS               NUMBER DEFAULT 0,
    ENROLL_DATE         DATE DEFAULT SYSDATE    NOT NULL,
    TOTAL_STOCK         NUMBER                  NOT NULL,
    REMAIN_STOCK        NUMBER DEFAULT 0,
    STATUS              VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN('Y', 'N')) 
);
CREATE SEQUENCE GOODS_SEQ NOCACHE;

COMMENT ON COLUMN GOODS.GOODS_NO IS '�������� ä���Ͽ� ���';
COMMENT ON COLUMN GOODS.CATEGORY IS 'ī�װ� ���� �з��ϱ� ���� ��ǰ�� ����';
COMMENT ON COLUMN GOODS.GOODS_NAME IS '��ǰ�� �̸�';
COMMENT ON COLUMN GOODS.GOODS_CONTENT IS '��ǰ ���� ����. CLOBŸ������ �̹������� �� ���� ���';
COMMENT ON COLUMN GOODS.MARK IS '��ǰ�� ������';
COMMENT ON COLUMN GOODS.PRICE IS '��ǰ�� ����';
COMMENT ON COLUMN GOODS.VIEWS IS '��ǰ ������ ��ȸ ��';
COMMENT ON COLUMN GOODS.ENROLL_DATE IS '��ǰ �����';
COMMENT ON COLUMN GOODS.TOTAL_STOCK IS '������ ��ǰ�� �� ��� ����';
COMMENT ON COLUMN GOODS.REMAIN_STOCK IS '��ǰ�� ���� ��� ����.';
COMMENT ON COLUMN GOODS.STATUS IS '��ǰ ���� ����. ���� : Y, ���(�� �̻� �뿩X) : N';
--------------------------------------------------------------------------------


-- ķ�ο�ǰ ÷������ ���̺�, ������ ����
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

COMMENT ON COLUMN GOODS_ATTACHMENT.FILE_NO IS '÷�����Ϲ�ȣ. �������� ä��';
COMMENT ON COLUMN GOODS_ATTACHMENT.ORIGIN_NAME IS '÷������ ������';
COMMENT ON COLUMN GOODS_ATTACHMENT.CHANGE_NAME IS '÷������ ������';
COMMENT ON COLUMN GOODS_ATTACHMENT.FILE_PATH IS '÷������ ������';
COMMENT ON COLUMN GOODS_ATTACHMENT.UPLOAD_DATE IS '���ε� ��';
COMMENT ON COLUMN GOODS_ATTACHMENT.FILE_LEVEL IS '�̹��� ����. 1 : ������, 2 : ���̹���';
COMMENT ON COLUMN GOODS_ATTACHMENT.STATUS IS '÷�����ϻ���. ��ȿ�� ÷������ : Y, ������ ÷������ : N';
COMMENT ON COLUMN GOODS_ATTACHMENT.ATTACHMENT_GNO IS '���� ��ǰ ��ȣ';
--------------------------------------------------------------------------------


-- �� ���̺� ����
CREATE TABLE DIBS
(
    DIBS_MEMBER    NUMBER   NOT NULL,
    DIBS_GOODS     NUMBER   NOT NULL,
    FOREIGN KEY(DIBS_MEMBER) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(DIBS_GOODS) REFERENCES GOODS(GOODS_NO)
);

COMMENT ON COLUMN DIBS.DIBS_MEMBER IS '���� ȸ�� ��ȣ';
COMMENT ON COLUMN DIBS.DIBS_GOODS IS '�� ȸ���� ���� ��ǰ ��ȣ';
--------------------------------------------------------------------------------


-- ��ٱ��� ���̺�, ������ ����
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

COMMENT ON COLUMN CART.CART_NO IS '��ٱ��� ��ȣ. �������� ä��';
COMMENT ON COLUMN CART.QUANTITY IS '��ǰ�� ����';
COMMENT ON COLUMN CART.PRICE IS '�׸� �� �ݾ�. ��ǰ����*����';
COMMENT ON COLUMN CART.ADDED_AT IS '��ٱ��Ͽ� ���� ��¥. 30���� ������ ����';
COMMENT ON COLUMN CART.MEMBER_NO IS '��ٱ��Ͽ� ���� ȸ�� ��ȣ';
COMMENT ON COLUMN CART.GOODS_NO IS '�� ȸ���� ���� ��ǰ�� ��ȣ';
--------------------------------------------------------------------------------


-- �ֹ� ���̺�, ������ ����
CREATE TABLE GOODS_ORDER
(
    ORDER_NO        NUMBER                  PRIMARY KEY,
    PAYMENT_ID      VARCHAR2(60)            NOT NULL,
    TOTAL_PRICE     NUMBER                  NOT NULL,
    CREATED_DATE    DATE DEFAULT SYSDATE    NOT NULL,
    PAYMENT_METHOD  VARCHAR2(60) CHECK(PAYMENT_METHOD IN('CARD', 'BANK', 'VBANK', 'CELLPHONE')),
    PAYMENT_STATUS  VARCHAR2(60) DEFAULT 'CREATED' CHECK(PAYMENT_STATUS IN('CREATED,  PAID,  CANCELED,  REFUNDED')),
    UPDATED_DATE    DATE ,
    MEMBER_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

CREATE SEQUENCE ORDER_SEQ NOCACHE;

COMMENT ON COLUMN GOODS_ORDER.ORDER_NO IS '�������� ä��. ���̽����� Moid�� ȣȯ';
COMMENT ON COLUMN GOODS_ORDER.PAYMENT_ID IS '���̽������� TID�� ȣȯ';
COMMENT ON COLUMN GOODS_ORDER.TOTAL_PRICE IS '���̽������� Amt�� ȣȯ';
COMMENT ON COLUMN GOODS_ORDER.CREATED_DATE IS '�ֹ� ���� ��';
COMMENT ON COLUMN GOODS_ORDER.PAYMENT_METHOD IS '���� ���. (CARD, BANK, VBANK, CELLPHONE - ���̽������� PayMethod�� ȣȯ)';
COMMENT ON COLUMN GOODS_ORDER.PAYMENT_STATUS IS 'CREATED: ����� ���� ��û, PAID: ����� ���� �Ϸ�, CANCELED: ������� �ֹ� ��� ��û ��REFUNDED: ������ ��� ����';
COMMENT ON COLUMN GOODS_ORDER.UPDATED_DATE IS '�����Ϸ�. �ֹ���� �� ���º���+�κ� ��� ���� ��� �α� ���';
COMMENT ON COLUMN GOODS_ORDER.MEMBER_NO IS '�ֹ��� ȸ���� ��ȣ';
--------------------------------------------------------------------------------


-- �ֹ� �� ���̺�, ������ ����
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

COMMENT ON COLUMN ORDER_DETAIL.ORDER_DETAIL_NO IS '�ֹ� �� ��ȣ. �������� ä��';
COMMENT ON COLUMN ORDER_DETAIL.QUANTITY IS '����. ��ٱ��� ��ǰ�� ��� �ʼ�';
COMMENT ON COLUMN ORDER_DETAIL.PRICE IS '���� �ݾ�';
COMMENT ON COLUMN ORDER_DETAIL.TOTAL_PRICE IS '�׸� �� �� �ݾ�';
COMMENT ON COLUMN ORDER_DETAIL.GOODS_NO IS '�ֹ��ϰ��� �ϴ� ��ǰ ��ȣ';
COMMENT ON COLUMN ORDER_DETAIL.ORDER_NO IS '�ֹ� ��ȣ';
--------------------------------------------------------------------------------


-- ķ���� ���� ���̺� ����
CREATE TABLE SECTION
(
    SECTION             CHAR(1)         CHECK(SECTION IN('A', 'B', 'C', 'D', 'E', 'F')) PRIMARY KEY,
    SECTION_DETAIL      VARCHAR2(60)    CHECK(SECTION_DETAIL IN('ķ��ī��', '�۷�����', '�Ϲݼ�', '�ٺ�ť��')) NOT NULL
);

COMMENT ON COLUMN SECTION.SECTION IS '���Ǹ�. A~F';
COMMENT ON COLUMN SECTION.SECTION_DETAIL IS '���� ����. ķ��ī��, �۷�����, �Ϲݼ�, �ٺ�ť��';
--------------------------------------------------------------------------------


-- ķ���� ���� ���̺�, ������ ����
CREATE TABLE CAMPSITE
(
    CAMPSITE_ID     NUMBER  PRIMARY KEY,
    SPOT_NO         NUMBER  CHECK(SPOT_NO BETWEEN 1 AND 10) NOT NULL,
    PRICE           NUMBER  NOT NULL,
    SECTION         CHAR(1) NOT NULL,
    FOREIGN KEY(SECTION) REFERENCES SECTION(SECTION)
);

CREATE SEQUENCE CAMP_SEQ NOCACHE;

COMMENT ON COLUMN CAMPSITE.CAMPSITE_ID IS '���� ���� ID. �������� ä��';
COMMENT ON COLUMN CAMPSITE.SPOT_NO IS '���� �� �ڸ���ȣ. 1~10';
COMMENT ON COLUMN CAMPSITE.PRICE IS '1�� ���� �̿���';
COMMENT ON COLUMN CAMPSITE.SECTION IS 'A~F';
--------------------------------------------------------------------------------


-- ���� ���̺�, ������ ����
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

COMMENT ON COLUMN RESERVE.RESERVE_NO IS '�����ȣ. �������� ä��';
COMMENT ON COLUMN RESERVE.START_DATE IS 'üũ�� ��¥. ����Ͻú��ʸ� ������ ��¥ Ÿ��';
COMMENT ON COLUMN RESERVE.END_DATE IS 'üũ�ƿ� ��¥. ����Ͻú��ʸ� ������ ��¥ Ÿ��';
COMMENT ON COLUMN RESERVE.NIGHTS IS '�����ϼ�';
COMMENT ON COLUMN RESERVE.PAYMENT_ID IS '���� �ĺ���';
COMMENT ON COLUMN RESERVE.PRICE IS '�� ���� �ݾ�';
COMMENT ON COLUMN RESERVE.PAYMENT_DATE IS '���� ��¥';
COMMENT ON COLUMN RESERVE.PAYMENT_METHOD IS '���� ���. CARD, BANK, VBANK, CELLPHONE - ���̽������� PayMethod�� ȣȯ';
COMMENT ON COLUMN RESERVE.PAYMENT_STATUS IS 'CREATED: ������� ���� ��û ��, PAID: ������� ���� �Ϸ� ��, CANCELED: ������� �ֹ� ��� ��û ��, REFUNDED: �����ڰ� ������� ��� ��û Ȯ�� ��';
COMMENT ON COLUMN RESERVE.UPDATE_DATE IS '�����Ϸ�, �ֹ���� �� ���� ���� + �κ� ��ҵ��� ��� �αױ��';
COMMENT ON COLUMN RESERVE.MEMBER_NO IS '������ ȸ���� ��ȣ';
COMMENT ON COLUMN RESERVE.CAMPSITE_ID IS '������ ���� ��ȣ';
--------------------------------------------------------------------------------


-- �������� ���̺�, ������ ����
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

COMMENT ON COLUMN NOTICE.NOTICE_NO IS '�������� ��ȣ. �������� ä��';
COMMENT ON COLUMN NOTICE.NOTICE_TITLE IS '�������� ����';
COMMENT ON COLUMN NOTICE.NOTICE_CONTENT IS '�������� ����';
COMMENT ON COLUMN NOTICE.CREATE_DATE IS '�������� �ۼ���';
COMMENT ON COLUMN NOTICE.COUNT IS '��ȸ��';
COMMENT ON COLUMN NOTICE.ORIGIN_NAME IS '÷������ 1���� ������';
COMMENT ON COLUMN NOTICE.CHARGE_NAME IS '÷������ 1���� ������';
COMMENT ON COLUMN NOTICE.STATUS IS '�� ����. Y : ����, N : ����';
--------------------------------------------------------------------------------


-- �ı�Խ��� ���̺�, ������ ����
CREATE TABLE REVIEW
(
    REVIEW_NO       NUMBER                  PRIMARY KEY,
    REVIEW_TITLE    VARCHAR2(200)           NOT NULL,
    REVIEW_CONTENT  VARCHAR2(4000)           NOT NULL,
    REVIEW_COUNT    NUMBER DEFAULT 0        NOT NULL,
    CREATE_DATE     DATE DEFAULT SYSDATE    NOT NULL,
    STATUS          CHAR(1) DEFAULT 'Y'     CHECK(STATUS IN('Y', 'N')),
    MEMBER_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

CREATE SEQUENCE REVIEW_SEQ NOCACHE;

COMMENT ON COLUMN REVIEW.REVIEW_NO IS '�ı� �Խ��� ��ȣ. �������� ä��';
COMMENT ON COLUMN REVIEW.REVIEW_TITLE IS '�ı� ����';
COMMENT ON COLUMN REVIEW.REVIEW_CONTENT IS '�ı� ����';
COMMENT ON COLUMN REVIEW.REVIEW_COUNT IS '��ȸ��';
COMMENT ON COLUMN REVIEW.CREATE_DATE IS '�ı� �ۼ���';
COMMENT ON COLUMN REVIEW.STATUS IS '�� ����. Y : ����, N : ����';
COMMENT ON COLUMN REVIEW.MEMBER_NO IS '�ۼ��� ȸ�� ���̵�';
--------------------------------------------------------------------------------


-- �ı�Խ��� ��� ���̺�, ������ ����
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

COMMENT ON COLUMN REVIEW_REPLY.REPLY_NO IS '��� ��ȣ';
COMMENT ON COLUMN REVIEW_REPLY.REPLY_CONTENT IS '��� ����';
COMMENT ON COLUMN REVIEW_REPLY.CREATE_DATE IS '��� �ۼ���';
COMMENT ON COLUMN REVIEW_REPLY.STATUS IS '�� ����. Y : ����, N : ����';
COMMENT ON COLUMN REVIEW_REPLY.MEMBER_NO IS '����� �ۼ��� ȸ���� ��ȣ';
COMMENT ON COLUMN REVIEW_REPLY.REVIEW_NO IS '����� �ۼ��� �Խñ� ��ȣ';
--------------------------------------------------------------------------------


-- �ı�Խ��� ���ƿ� ���̺� ����
CREATE TABLE REVIEW_LIKE
(
    MEMBER_NO       NUMBER                  NOT NULL,
    REVIEW_NO       NUMBER                  NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

COMMENT ON COLUMN REVIEW_REPLY.MEMBER_NO IS '���ƿ� �� ȸ���� ��ȣ';
COMMENT ON COLUMN REVIEW_REPLY.REVIEW_NO IS '���ƿ� �� �Խñ� ��ȣ';
--------------------------------------------------------------------------------


-- �ı�Խ��� ÷������ ���̺�, ������ ����
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

COMMENT ON COLUMN REVIEW_ATTACHMENT.FILE_NO IS '���� ��ȣ';
COMMENT ON COLUMN REVIEW_ATTACHMENT.ORIGIN_NAME IS '���� ���ϸ�';
COMMENT ON COLUMN REVIEW_ATTACHMENT.CHANGE_NAME IS '���� ���ϸ�';
COMMENT ON COLUMN REVIEW_ATTACHMENT.FILE_PATH IS '���� ���';
COMMENT ON COLUMN REVIEW_ATTACHMENT.UPLOAD_DATE IS '���ε� ��¥';
COMMENT ON COLUMN REVIEW_ATTACHMENT.FILE_LEVEL IS '1 : �����, 2 : ���̹���';
COMMENT ON COLUMN REVIEW_ATTACHMENT.STATUS IS '���� ����. Y : ����, N : ����';
COMMENT ON COLUMN REVIEW_ATTACHMENT.REVIEW_NO IS '���� �Խñ� ��ȣ';
--------------------------------------------------------------------------------


-- �нǹ� �Խ��� ���̺�, ������ ����
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

COMMENT ON COLUMN LOST.LOST_NO IS '�нǹ� �Խñ� ��ȣ';
COMMENT ON COLUMN LOST.CATEGORY_NANE IS 'ī�װ� ��. ����ǰ, ķ�ο�ǰ, ������ǰ, �Ƿ�...';
COMMENT ON COLUMN LOST.LOST_TITLE IS '�нǹ� �Խñ� ����';
COMMENT ON COLUMN LOST.LOST_CONTENT IS '�нǹ� �Խñ� ����';
COMMENT ON COLUMN LOST.FOUND_STATUS IS '�нǹ� ó������. Y : ó���Ϸ�, N : ��ó��';
COMMENT ON COLUMN LOST.COUNT IS '��ȸ��';
COMMENT ON COLUMN LOST.CREATE_DATE IS '�Խñ� �ۼ���';
COMMENT ON COLUMN LOST.STATUS IS '�� ����. Y : ����, N : ����';
--------------------------------------------------------------------------------


-- �нǹ� �Խ��� ÷������ ���̺�, ������ ����
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

COMMENT ON COLUMN LOST_ATTACHMENT.FILE_NO IS '���� ��ȣ';
COMMENT ON COLUMN LOST_ATTACHMENT.ORIGIN_NAME IS '���� ���ϸ�';
COMMENT ON COLUMN LOST_ATTACHMENT.CHANGE_NAME IS '���� ���ϸ�';
COMMENT ON COLUMN LOST_ATTACHMENT.FILE_PATH IS '���� ���';
COMMENT ON COLUMN LOST_ATTACHMENT.UPLOAD_DATE IS '���ε� ��¥';
COMMENT ON COLUMN LOST_ATTACHMENT.FILE_LEVEL IS '1 : �����, 2 : ���̹���';
COMMENT ON COLUMN LOST_ATTACHMENT.STATUS IS '���� ����. Y : ����, N : ����';
COMMENT ON COLUMN LOST_ATTACHMENT.LOST_NO IS '������ �нǹ� �Խñ� ��ȣ';



