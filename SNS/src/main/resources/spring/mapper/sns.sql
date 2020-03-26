-- SNS ������Ʈ DB ����
CREATE USER SNS IDENTIFIED BY ABC123;
GRANT CONNECT, RESOURCE, CREATE VIEW TO SNS;
----------------------------------------------------
-- ȸ�� ���̺� ����
CREATE TABLE MEMBER(
IDX NUMBER(8) CONSTRAINT MEMBER_IDX_PK PRIMARY KEY, -- ȸ����ȣ PK
NAME VARCHAR2(30) NOT NULL, -- �̸�
NICK_NAME VARCHAR2(30) CONSTRAINT MEMBER_NICK_UK UNIQUE NOT NULL, -- �г��� UK
USERID VARCHAR2(20) CONSTRAINT MEMBER_USERID_UK UNIQUE NOT NULL , -- ���̵� UK
PWD VARCHAR2(20) NOT NULL, -- ��й�ȣ
EMAIL VARCHAR2(100), -- �̸���
BIRTH VARCHAR2 (20), -- �������
HP1 CHAR(3) NOT NULL, -- 010
HP2 CHAR(4) NOT NULL, -- 1234
HP3 CHAR(4) NOT NULL, -- 5678
POST CHAR(5) NOT NULL, -- �����ȣ
ADDR1 VARCHAR2(100) NOT NULL, -- �ּ�1
ADDR2 VARCHAR2(100), -- �߰� �ּ�
INDATE DATE DEFAULT SYSDATE, -- ������
MILEAGE NUMBER(10) DEFAULT 1000, -- ����Ʈ ���ϸ���
M_STATE NUMBER(2) DEFAULT 0, -- ȸ������. 0:�Ϲ�ȸ�� -1:����ȸ�� -2:Ż��ȸ��
PROFILE VARCHAR2(100) -- ������ ���� ��ġ
);

-- �Խ���1 ���̺� ����
CREATE TABLE BOARD1(
BOARDNUM NUMBER(10) CONSTRAINT BOARD1_NUM_PK PRIMARY KEY, -- �Խù���ȣ PK , SEQ_NEXTVAL
ADDR VARCHAR2(100), -- ������ġ
TITLE VARCHAR2(60), -- �Խù� ����
CONTENT VARCHAR2(1500), -- �Խù� ����
AUTHOR VARCHAR2(20) CONSTRAINT BOARD1_AUTHOR_FK REFERENCES MEMBER (NICK_NAME), -- (FK)

-- MEMBER(ȸ�����̺�)�� NICK_NAME(�г���)���� �����ϴ� FK�� ����
WDATE DATE DEFAULT SYSDATE -- �ۼ��ð�
);

-- ��� ���̺� ����
CREATE TABLE REPLY(
REPLY_NUM NUMBER(10) CONSTRAINT REPLY_NUM_PK PRIMARY KEY, -- ��۹�ȣ PK , SEQ_NEXTVAL
BOARD_NUM NUMBER(10) CONSTRAINT REPLY_BOARDNUM_FK REFERENCES BOARD1 (BOARDNUM),
-- BOARD1(�Խù��޵��)�� BOARDNUM(�۹�ȣ)���� �����ϴ� FK�� �����Ͽ� ����� �Խù��� �°� ������ �� �ֵ��� FK ����
CONTENT VARCHAR2(60), -- ��� ����
AUTHOR VARCHAR2(20) CONSTRAINT REPLY_AUTHOR_FK REFERENCES MEMBER (NICK_NAME), -- �ۼ���(FK)
-- MEMBER(ȸ�����̺�)�� NICK_NAME(�г���)���� �����ϴ� FK�� ����
WDATE DATE DEFAULT SYSDATE -- ��� �ۼ��ð� 
);

-- ȸ�����̺� ������
CREATE SEQUENCE MEMBER_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

-- �Խ���1 ������
CREATE SEQUENCE BOARD1_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

-- ��� ������
CREATE SEQUENCE REPLY_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

/* �Ҹ��� */----------------------------------------------------------------------------
ALTER TABLE meeting
   DROP
      CONSTRAINT FK_member_TO_meeting
      CASCADE;

ALTER TABLE meeting
   DROP
      PRIMARY KEY
      CASCADE
      KEEP INDEX;

DROP INDEX PK_meeting;

/* �Ҹ��� */
DROP TABLE meeting 
   CASCADE CONSTRAINTS;

/* �Ҹ��� */
CREATE TABLE meeting (
   idx NUMBER(8,0) NOT NULL, /* ȸ����ȣ */
   midx NUMBER(8,0) NOT NULL, /* �۹�ȣ */
   category VARCHAR2(30 BYTE) NOT NULL, /* ���úо� */
   meetName VARCHAR2(30 BYTE) NOT NULL, /* ���Ӹ� */
   meetContent VARCHAR2(2000 BYTE), /* ���ӼҰ��� */
   mDate DATE, /* ���ӳ�¥ */
   personnel NUMBER(3,0), /* �����ο� */
   leader VARCHAR2(30 BYTE) NOT NULL, /* ������ */
   hp1 CHAR(3 BYTE) NOT NULL, /* ����ó1 */
   hp2 CHAR(4 BYTE) NOT NULL, /* ����ó2 */
   hp3 CHAR(4 BYTE) NOT NULL, /* ����ó3 */
   place VARCHAR2(100 BYTE), /* ������� */
   meetPwd VARCHAR2(20 BYTE) NOT NULL, /* �ۺ�й�ȣ */
   image VARCHAR2(100 BYTE), /* �̹��� ���� */
    mtime VARCHAR2(20 BYTE), /* ���ӽð� */
    rstatus NUMBER(2,0) DEFAULT 1, /* ������Ȳ */
    rpersonnel NUMBER(3,0) /* ���� ������ �ο� */
    originimage VARCHAR2(100 BYTE) /* �̹��� ���� ������ */
);

COMMENT ON TABLE meeting IS '�Ҹ���';

COMMENT ON COLUMN meeting.idx IS 'ȸ����ȣ';

COMMENT ON COLUMN meeting.midx IS '�۹�ȣ';

COMMENT ON COLUMN meeting.category IS '���úо�';

COMMENT ON COLUMN meeting.meetName IS '���Ӹ�';

COMMENT ON COLUMN meeting.meetContent IS '���ӼҰ���';

COMMENT ON COLUMN meeting.mDate IS '���ӳ�¥';

COMMENT ON COLUMN meeting.personnel IS '�����ο�';

COMMENT ON COLUMN meeting.leader IS '������';

COMMENT ON COLUMN meeting.hp1 IS '����ó1';

COMMENT ON COLUMN meeting.hp2 IS '����ó2';

COMMENT ON COLUMN meeting.hp3 IS '����ó3';

COMMENT ON COLUMN meeting.place IS '�������';

COMMENT ON COLUMN meeting.meetPwd IS '�ۺ�й�ȣ';

COMMENT ON COLUMN meeting.image IS '�̹��� ����';

COMMENT ON COLUMN meeting.mtime IS '���ӽð�';

COMMENT ON COLUMN meeting.rstatus IS '������Ȳ';

COMMENT ON COLUMN meeting.rpersonnel IS '������Ȳ';

COMMENT ON COLUMN meeting.originimage IS '�̹��� ���� ������';

--CREATE UNIQUE INDEX PK_meeting
--   ON meeting (
--      idx ASC,
--      midx ASC
--   );

ALTER TABLE meeting
   ADD
      CONSTRAINT PK_meeting
      PRIMARY KEY (
         idx,
         midx
      );

ALTER TABLE meeting
   ADD
      CONSTRAINT FK_member_TO_meeting
      FOREIGN KEY (
         idx
      )
      REFERENCES member (
         idx
      );

--������
CREATE SEQUENCE MEETING_MIDX_PK_SEQ
START WITH 1
INCREMENT BY 1;

-- ��ȭ ���̺�
CREATE TABLE MOVIELIST(
    GENRE VARCHAR2(50 BYTE), 
	CODE NUMBER(30), 
	IMAGES VARCHAR2(50 BYTE), 
	TITLE VARCHAR2(50 BYTE), 
	URL VARCHAR2(300 BYTE), 
	DIRECTOR VARCHAR2(50 BYTE), 
	SYNOPSIS VARCHAR2(3999 BYTE), 
	RD VARCHAR2(50 BYTE), 
	GRADE VARCHAR2(50 BYTE), 
	MSPEC VARCHAR2(50 BYTE), 
	ACTOR VARCHAR2(50 BYTE), 
	PRICE NUMBER(30,0)
   );
ALTER TABLE MOVIELIST
   ADD
      CONSTRAINT PK_CODE
      PRIMARY KEY (
         CODE
      );
--������
CREATE SEQUENCE MOVIELIST_SEQ
START WITH 1
INCREMENT BY 1;

/* �Խ��� �� ���̺� ���� */----------------------------------------------------------------------------
CREATE OR REPLACE VIEW boardView
AS
SELECT b.boardnum, m.idx, b.addr, b.title, b.content, b.author, b.wdate, m.profile
FROM board1 b JOIN member m
ON b.author=m.nick_name;