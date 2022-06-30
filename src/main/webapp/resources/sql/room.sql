DROP TABLE ROOM;
DROP TABLE ROOM_TYPE;
DROP TABLE IMAGE;

CREATE TABLE ROOM_TYPE (
	RT_NO	NUMBER	NOT NULL,
	RT_TYPE	VARCHAR2(30 BYTE)	NOT NULL,
	RT_MAX	NUMBER	NOT NULL
);


CREATE TABLE ROOM (
	ROOM_NO NUMBER	NOT NULL,
	RT_NO	NUMBER	NOT NULL,
	ROOM_NAME	VARCHAR2(300 BYTE)	NOT NULL,
	ROOM_STATUS	NUMBER	NOT NULL,
	ROOM_CHECKIN	DATE	NULL,
	ROOM_CHECKOUT	DATE	NULL,
    ROOM_PRICE NUMBER NOT NULL
);



CREATE TABLE IMAGE (
	IMAGE_NO	NUMBER	NOT NULL,
	ROOM_NO	NUMBER	NOT NULL,
	IMAGE_PATH	VARCHAR2(300 BYTE)	NULL,
	IMAGE_SAVED	VARCHAR2(40 BYTE)	NULL,
	IMAGE_ORIGIN	VARCHAR2(300 BYTE)	NULL
);



ALTER TABLE ROOM_TYPE ADD CONSTRAINT PK_ROOM_TYPE PRIMARY KEY (
	RT_NO
);



ALTER TABLE ROOM ADD CONSTRAINT PK_ROOM PRIMARY KEY (
    ROOM_NO
	
);



ALTER TABLE IMAGE ADD CONSTRAINT PK_IMAGE PRIMARY KEY (
	IMAGE_NO
	
);



ALTER TABLE ROOM ADD CONSTRAINT FK_ROOM_TYPE_TO_ROOM FOREIGN KEY (
	RT_NO
)
REFERENCES ROOM_TYPE (
	RT_NO
);

ALTER TABLE IMAGE ADD CONSTRAINT FK_ROOM_TO_IMAGE FOREIGN KEY (
	ROOM_NO
)
REFERENCES ROOM (
	ROOM_NO
);


INSERT INTO ROOM_TYPE(RT_NO, RT_TYPE, RT_MAX)
VALUES (1, 'SINGLE', 1);
INSERT INTO ROOM_TYPE(RT_NO, RT_TYPE, RT_MAX)
VALUES (2, 'DOUBLE', 2);
INSERT INTO ROOM_TYPE(RT_NO, RT_TYPE, RT_MAX)
VALUES (3, 'TWIN', 2);

--시퀀스 생성
DROP SEQUENCE ROOM_SEQ;
DROP SEQUENCE IMAGE_SEQ;
CREATE SEQUENCE ROOM_SEQ NOCACHE;
CREATE SEQUENCE IMAGE_SEQ NOCACHE;



COMMIT;
