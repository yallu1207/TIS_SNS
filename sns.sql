-- SNS 프로젝트 DB 생성
CREATE USER SNS IDENTIFIED BY ABC123;
GRANT CONNECT, RESOURCE, CREATE VIEW TO SNS;
----------------------------------------------------
-- 회원 테이블 생성
CREATE TABLE MEMBER(
IDX NUMBER(8) CONSTRAINT MEMBER_IDX_PK PRIMARY KEY, -- 회원번호 PK
NAME VARCHAR2(30) NOT NULL, -- 이름
NICK_NAME VARCHAR2(30) CONSTRAINT MEMBER_NICK_UK UNIQUE NOT NULL, -- 닉네임 UK
USERID VARCHAR2(20) CONSTRAINT MEMBER_USERID_UK UNIQUE NOT NULL , -- 아이디 UK
PWD VARCHAR2(20) NOT NULL, -- 비밀번호
EMAIL VARCHAR2(100), -- 이메일
BIRTH VARCHAR2 (20), -- 생년월일
HP1 CHAR(3) NOT NULL, -- 010
HP2 CHAR(4) NOT NULL, -- 1234
HP3 CHAR(4) NOT NULL, -- 5678
POST CHAR(5) NOT NULL, -- 우편번호
ADDR1 VARCHAR2(100) NOT NULL, -- 주소1
ADDR2 VARCHAR2(100), -- 추가 주소
INDATE DATE DEFAULT SYSDATE, -- 가입일
MILEAGE NUMBER(10) DEFAULT 1000, -- 포인트 마일리지
M_STATE NUMBER(2) DEFAULT 0, -- 회원상태. 0:일반회원 -1:정지회원 -2:탈퇴회원
PROFILE VARCHAR2(100) -- 프로필 사진 위치
);

-- 게시판1 테이블 생성
CREATE TABLE BOARD1(
BOARDNUM NUMBER(10) CONSTRAINT BOARD1_NUM_PK PRIMARY KEY, -- 게시물번호 PK , SEQ_NEXTVAL
ADDR VARCHAR2(100), -- 저장위치
TITLE VARCHAR2(60), -- 게시물 제목
CONTENT VARCHAR2(1500), -- 게시물 내용
AUTHOR VARCHAR2(20) CONSTRAINT BOARD1_AUTHOR_FK REFERENCES MEMBER (NICK_NAME), -- (FK)

-- MEMBER(회원테이블)의 NICK_NAME(닉네임)값을 참조하는 FK로 생성
WDATE DATE DEFAULT SYSDATE -- 작성시간
);

-- 댓글 테이블 생성
CREATE TABLE REPLY(
REPLY_NUM NUMBER(10) CONSTRAINT REPLY_NUM_PK PRIMARY KEY, -- 댓글번호 PK , SEQ_NEXTVAL
BOARD_NUM NUMBER(10) CONSTRAINT REPLY_BOARDNUM_FK REFERENCES BOARD1 (BOARDNUM),
-- BOARD1(게시물텡디블)의 BOARDNUM(글번호)값을 참조하는 FK로 설정하여 댓글이 게시물에 맞게 보여질 수 있도록 FK 설정
CONTENT VARCHAR2(60), -- 댓글 내용
AUTHOR VARCHAR2(20) CONSTRAINT REPLY_AUTHOR_FK REFERENCES MEMBER (NICK_NAME), -- 작성자(FK)
-- MEMBER(회원테이블)의 NICK_NAME(닉네일)값을 참조하는 FK로 생성
WDATE DATE DEFAULT SYSDATE -- 댓글 작성시간 
);

-- 회원테이블 시퀀스
CREATE SEQUENCE MEMBER_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

-- 게시판1 시퀀스
CREATE SEQUENCE BOARD1_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

-- 댓글 시퀀스
CREATE SEQUENCE REPLY_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE;

/* 소모임 */----------------------------------------------------------------------------
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

/* 소모임 */
DROP TABLE meeting 
   CASCADE CONSTRAINTS;

/* 소모임 */
CREATE TABLE meeting (
   idx NUMBER(8,0) NOT NULL, /* 회원번호 */
   midx NUMBER(8,0) NOT NULL, /* 글번호 */
   category VARCHAR2(30 BYTE) NOT NULL, /* 관련분야 */
   meetName VARCHAR2(30 BYTE) NOT NULL, /* 모임명 */
   meetContent VARCHAR2(2000 BYTE), /* 모임소개글 */
   mDate DATE, /* 모임날짜 */
   personnel NUMBER(3,0), /* 모집인원 */
   leader VARCHAR2(30 BYTE) NOT NULL, /* 모임장 */
   hp1 CHAR(3 BYTE) NOT NULL, /* 연락처1 */
   hp2 CHAR(4 BYTE) NOT NULL, /* 연락처2 */
   hp3 CHAR(4 BYTE) NOT NULL, /* 연락처3 */
   place VARCHAR2(100 BYTE), /* 모임장소 */
   meetPwd VARCHAR2(20 BYTE) NOT NULL, /* 글비밀번호 */
   image VARCHAR2(100 BYTE), /* 이미지 파일 */
    mtime VARCHAR2(20 BYTE), /* 모임시간 */
    rstatus NUMBER(2,0) DEFAULT 1, /* 모집현황 */
    rpersonnel NUMBER(3,0) /* 현재 모집된 인원 */
    originimage VARCHAR2(100 BYTE) /* 이미지 파일 원본명 */
);

COMMENT ON TABLE meeting IS '소모임';

COMMENT ON COLUMN meeting.idx IS '회원번호';

COMMENT ON COLUMN meeting.midx IS '글번호';

COMMENT ON COLUMN meeting.category IS '관련분야';

COMMENT ON COLUMN meeting.meetName IS '모임명';

COMMENT ON COLUMN meeting.meetContent IS '모임소개글';

COMMENT ON COLUMN meeting.mDate IS '모임날짜';

COMMENT ON COLUMN meeting.personnel IS '모집인원';

COMMENT ON COLUMN meeting.leader IS '모임장';

COMMENT ON COLUMN meeting.hp1 IS '연락처1';

COMMENT ON COLUMN meeting.hp2 IS '연락처2';

COMMENT ON COLUMN meeting.hp3 IS '연락처3';

COMMENT ON COLUMN meeting.place IS '모임장소';

COMMENT ON COLUMN meeting.meetPwd IS '글비밀번호';

COMMENT ON COLUMN meeting.image IS '이미지 파일';

COMMENT ON COLUMN meeting.mtime IS '모임시간';

COMMENT ON COLUMN meeting.rstatus IS '모집현황';

COMMENT ON COLUMN meeting.rpersonnel IS '모집현황';

COMMENT ON COLUMN meeting.originimage IS '이미지 파일 원본명';

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

--시퀀스
CREATE SEQUENCE MEETING_MIDX_PK_SEQ
START WITH 1
INCREMENT BY 1;

-- 영화 테이블
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
--시퀀스
CREATE SEQUENCE MOVIELIST_SEQ
START WITH 1
INCREMENT BY 1;

/* 게시판 뷰 테이블 생성 */----------------------------------------------------------------------------
CREATE OR REPLACE VIEW boardView
AS
SELECT b.boardnum, m.idx, b.addr, b.title, b.content, b.author, b.wdate, m.profile
FROM board1 b JOIN member m
ON b.author=m.nick_name;