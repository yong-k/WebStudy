SELECT USER
FROM DUAL;
--==>> SCOTT


--○ 기존 테이블 제거
DROP TABLE TBL_BOARD PURGE;
--==>> Table TBL_BOARD이(가) 삭제되었습니다.


--○ TBL_BOARD 테이블 생성(게시판 전용 테이블 생성)
CREATE TABLE TBL_BOARD
( NUM       NUMBER(9)                           NOT NULL    -- 게시물 번호
, NAME      VARCHAR2(30)                        NOT NULL    -- 게시물 작성자
, PWD       VARCHAR2(20)                        NOT NULL    -- 게시물 암호
, EMAIL     VARCHAR2(50)                                    -- 작성자 이메일 (이메일 없는 사람들도 있으니 NOT NULL 제약조건 걸지 않음)
, SUBJECT   VARCHAR2(100)                       NOT NULL    -- 게시물 제목
, CONTENT   VARCHAR2(4000)                      NOT NULL    -- 게시물 내용
, IPADDR    VARCHAR2(20)                                    -- 접속한 클라이언트 IP 주소
, HITCOUNT  NUMBER          DEFAULT 0           NOT NULL    -- 게시물 조회수
, CREATED   DATE            DEFAULT SYSDATE     NOT NULL    -- 게시물 작성일
, CONSTRAINT BOARD_NUM_PK PRIMARY KEY(NUM)                  -- 게시물 번호에 PK 제약조건 설정
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 게시물 번호의 최대값을 얻어내는 쿼리문 구성
SELECT NVL(MAX(NUM), 0) AS MAXNUM
FROM TBL_BOARD;
--> 한 줄 구성
SELECT NVL(MAX(NUM), 0) AS MAXNUM FROM TBL_BOARD
;


--○ 게시물 작성 쿼리문 구성
INSERT INTO TBL_BOARD(NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, CREATED)
VALUES(1, '이지연', '1234', 'ljy@test.com', '작성테스트', '게시물내용작성', '211.238.142.160', 0, SYSDATE);
--> 한 줄 구성
INSERT INTO TBL_BOARD(NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, CREATED) VALUES(1, '이지연', '1234', 'ljy@test.com', '작성테스트', '게시물내용작성', '211.238.142.160', 0, SYSDATE)
;
--==>> 1 행 이(가) 삽입되었습니다.


--○ 롤백
ROLLBACK;
--==>> 롤백 완료.


--○ DB 레코드의 개수를 가져오는 쿼리문 구성
--   → 왜 레코드 전체 개수 가져올까?
--      한 페이지당 게시물 10개씩 구성하기로 했으면,
--      전체 게시물 몇 개인지 알아야! 만들어야 하는 페이지 수 알아서 
--      페이지 레이아웃 설정해줌 
--      화면 하단에 1|2|3|4|5 페이지 이런거 만드는거
--      만약 전체게시물 8개~10개라면 밑에 페이지 1|2| 이런거 필요없음
--      이동할 필요가 없는 상황이니까
--      그런데 10개 넘어가고 12개 되면, 1|2 페이지 나뉘어야 한다.
--      &&
--      각각 페이지 클릭했을 때, 시작번호~끝번호 리스트 얻어내는 쿼리도 필요하다.
SELECT COUNT(*) AS COUNT
FROM TBL_BOARD;
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_BOARD
;
--==>> 0


--                 1       10
--○ 특정 영역의(시작번호~끝번호) 게시물 목록을 읽어오는 쿼리문 구성
--   번호, 작성자, 제목, 조회수, 작성일
--  
--   WHERE NUM BETWEEN 1 AND 10;
--   → 이렇게 하면 중간에 삭제한거 있으면, 
--      어떤 페이지는 글 하나도 없을 수도 있고, 사이사이 빠져있을 것이다....
-- 각각 다른 번호 부여해야지, NUM 값으로 자르면 안된다.
-- 왜 ORDER BY NUM DESC?? → 최신 작성글 먼저 앞에 띄워줘야 하니까~!!
-- 『ROWNUM』 행번호 붙여주는거! 지금은 정렬해놨기 때문에 이렇게만 쓰면 행번호 붙는다.
--★★ CREATED(DATE TYPE) 쿼리 쓸 때 TO_CHAR() 인데, TO_DATE() 라고 해놔서 시간까지 나오는 실수했음
SELECT NUM, NAME, SUBJECT, HITCOUNT, CREATED
FROM 
(
    SELECT ROWNUM RNUM, DATA.*
    FROM 
    (
        SELECT NUM, NAME, SUBJECT, HITCOUNT, TO_CHAR(CREATED, 'YYYY-MM-DD') AS CREATED
        FROM TBL_BOARD
        ORDER BY NUM DESC
    ) DATA
)    
WHERE RNUM>=1 AND RNUM<=10;
--> 한 줄 구성
SELECT  NUM, NAME, SUBJECT, HITCOUNT, CREATED FROM ( SELECT ROWNUM RNUM, DATA.* FROM ( SELECT NUM, NAME, SUBJECT, HITCOUNT, TO_DATE(CREATED, 'YYYY-MM-DD') AS CREATED FROM TBL_BOARD ORDER BY NUM DESC) DATA ) WHERE RNUM>=1 AND RNUM<=10
;


--○ 특정 게시물 조회에 따른 조회 횟수 증가 쿼리문 구성 (옛날방식) ↔ 로그화(요즘방식)
--   각 게시물에는 링크 걸려있고, 그거 클릭하면 게시물 보여진다.
-- GET방식으로 생각해보면 각 게시물에 
-- 『List.jsp?pageNum=1』 이런식으로 링크 구성되어 있을 것이다.
-- 그리고 그 게시물 딱 클릭하면 『Article.jsp?num=1』 로 가서 그 내용 보여짐
-- 그러면서! 딱 클릭되면 hitcount 하나씩 올려줘야 한다!
-- 게시물 안에서 새로고침하거나 나갔다가 계속 다시 클릭하면 조회수 올라감...
-- 그런데 조회수로 광고하고 바이럴마케팅하고 하기 때문에 요새는 조회수 그렇게 구성 안함
-- 나중에 다 증명을 해야 하기 때문에, 조회수를 LOG화 처리하는게 대부분이다.
-- 매번 누군가가 그거 열람할 때마다, 열람리스트(열람자)를 만든다.
-- 페북 좋아요버튼 이런거! 한 사람이 여러번 못 누르게끔 
-- 그런식으로 하는게 로그화 → 로그 기록으로 다 남기는거
-- 새로고침해서 조회수 올리는건 옛날 방식
-- 요즘에는 
-- 조회수 담는 테이블 따로 있음
-- 누가 언제 들어갔는지 정보 남겨놓고, 10분 안에 다시 들어오면 조회수 안올린다거나
-- 이런식으로!!
-- 테이블에 내가 언제 들어와서 열람했고, 좋아요했는지 다 남겨져있음
-- → 조건문 걸 수 있음(같은 사람이 좋아요 못누르게, 
--    같은 사람이 조회한 날짜와시간 찍어놓고 
--    10분안에 그 행위 또 하면 카운트 UPDATE 시키지 않겠다)
UPDATE TBL_BOARD
SET HITCOUNT = HITCOUNT + 1        -- 오라클은 +=, ++ 없음
WHERE NUM=1;
--> 한 줄 구성
UPDATE TBL_BOARD SET HITCOUNT = HITCOUNT + 1 WHERE NUM=1
;


--○ 특정 게시물의 내용을 읽어오는 쿼리문 구성 
--   (게시물 조회해서 실제로 열람하는 행위)  → 다 보여줘야 한다.
SELECT NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT
     , TO_CHAR(CREATED, 'YYYY-MM-DD') AS CREATED
FROM TBL_BOARD
WHERE NUM=3;
--> 한 줄 구성
SELECT NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, TO_CHAR(CREATED, 'YYYY-MM-DD') AS CREATED FROM TBL_BOARD WHERE NUM=3
;


--○ 특정 게시물을 삭제하는 쿼리문 구성
DELETE
FROM TBL_BOARD
WHERE NUM=12;
--> 한 줄 구성
DELETE FROM TBL_BOARD WHERE NUM=12
;


--○ 특정 게시물을 수정하는 쿼리문 구성
--   (게시물 상세보기 페이지 → Article.jsp 내에서의 처리)
--   작성자, 패스워드, 이메일, 제목, 내용
UPDATE TBL_BOARD
SET NAME='김민성', PWD='1234', EMAIL='kms@test.com', SUBJECT='수정제목', CONTENT='수정내용'
WHERE NUM=5;
--> 한 줄 구성
UPDATE TBL_BOARD SET NAME='김민성', PWD='1234', EMAIL='kms@test.com', SUBJECT='수정제목', CONTENT='수정내용' WHERE NUM=5
;


-- 지금 읽는 게시물이 50번 게시물이라고 할 때, 아래 다음번호/이전번호 쿼리문 구성해보자
-- 게시물 번호를 알아야한다.
--○ 특정 게시물(50)의 다음 번호 읽어오는 쿼리문 구성
SELECT NVL(MIN(NUM), -1) NEXTNUM
FROM TBL_BOARD
WHERE NUM > 50;
--> 한 줄 구성
SELECT NVL(MIN(NUM), -1) NEXTNUM FROM TBL_BOARD WHERE NUM > 50
;


--○ 특정 게시물(50)의 이전 번호 읽어오는 쿼리문 구성
SELECT NVL(MAX(NUM), -1) BEFORENUM
FROM TBL_BOARD
WHERE NUM < 50;
--> 한 줄 구성
SELECT NVL(MAX(NUM), -1) BEFORENUM FROM TBL_BOARD WHERE NUM < 50
;


