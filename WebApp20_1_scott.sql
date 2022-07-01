
--■■■ 실습 진행간 테스트 ■■■--

SELECT COUNT(*) AS COUNT
FROM TBL_BOARD;
--==>> 0


--○ 게시물 작성
INSERT INTO TBL_BOARD(NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, CREATED)
VALUES(1, '김태형', '1234', 'kth@test.com', '작성테스트', '내용물작성', '211.238.142.154', 0, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--*** 꼭 반드시 커밋해야된다.
--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시물 삭제
DELETE TBL_BOARD
WHERE NUM=1;
--==>> 1 행 이(가) 삭제되었습니다.


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 프로시저 실행 이후 테이블 조회
SELECT *
FROM TBL_BOARD
ORDER BY NUM;


--○ 검색 데이터 개수 조회 쿼리문 구성
SELECT COUNT(*) AS COUNT
FROM TBL_BOARD
WHERE SUBJECT LIKE '%음식%';
--> 한 줄 구성
SELECT COUNT(*) AS COUNT FROM TBL_BOARD WHERE SUBJECT LIKE '%음식%'
;
--==>> 180


SELECT *
FROM TBL_BOARD
ORDER BY NUM desc;

--○ 


--○ 