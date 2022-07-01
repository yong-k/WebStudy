SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_MEMBER
ORDER BY SID;
--==>>
/*
1	오이삭	010-1111-1111
2	김정용	010-2222-2222
3	이시우	010-3333-3333
4	이지연	010-4444-4444
5	이아린	010-5555-5555
6	김민성	010-6666-6666
7	이호석	010-7777-7777
*/

DESC TBL_MEMBER;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
SID  NOT NULL NUMBER       
NAME          VARCHAR2(30) 
TEL           VARCHAR2(40) 
*/

TRUNCATE TABLE TBL_MEMBER;
--==>> Table TBL_MEMBER이(가) 잘렸습니다.

DROP SEQUENCE MEMBERSEQ;
--==>> Sequence MEMBERSEQ이(가) 삭제되었습니다.

CREATE SEQUENCE MEMBERSEQ;
--==>> Sequence MEMBERSEQ이(가) 생성되었습니다.

INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '김태형', '010-1111-1111');
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '박현지', '010-2222-2222');
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '임소면', '010-3333-3333');
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '김정용', '010-4444-4444');
INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, '서민지', '010-5555-5555');
--==>> 1 행 이(가) 삽입되었습니다. * 5

SELECT SID, NAME, TEL
FROM TBL_MEMBER;
--==>>
/*
1	김태형	010-1111-1111
2	박현지	010-2222-2222
3	임소면	010-3333-3333
4	김정용	010-4444-4444
5	서민지	010-5555-5555
*/

COMMIT;
--==>> 커밋 완료.


--○ 인원 수 확인 쿼리문 구성
SELECT COUNT(*) AS COUNT
FROM TBL_MEMBER;
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_MEMBER
;


--○ WebApp11 쿼리문 구성
DESC TBL_SCORE;

--○ 전체 인원수 체크
SELECT COUNT(*) AS COUNT FROM TBL_SCORE
;
--○ 전체 조회
SELECT SID, NAME, KOR, ENG, MAT, NVL(KOR,0)+NVL(ENG,0)+NVL(MAT,0) AS TOT, ROUND((NVL(KOR,0)+NVL(ENG,0)+NVL(MAT,0))/3, 1) AS AVG FROM TBL_SCORE ORDER BY SID
;
--○ insert → NULLIF() 사용
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '깁접욥', NULLIF(99, -99), NULLIF(-99,-99), NULLIF(10, -99))
;


