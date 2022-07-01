SELECT USER
FROM DUAL;
--==>> SCOTT


--�� ���� ���̺� ����
DROP TABLE TBL_BOARD PURGE;
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� TBL_BOARD ���̺� ����(�Խ��� ���� ���̺� ����)
CREATE TABLE TBL_BOARD
( NUM       NUMBER(9)                           NOT NULL    -- �Խù� ��ȣ
, NAME      VARCHAR2(30)                        NOT NULL    -- �Խù� �ۼ���
, PWD       VARCHAR2(20)                        NOT NULL    -- �Խù� ��ȣ
, EMAIL     VARCHAR2(50)                                    -- �ۼ��� �̸��� (�̸��� ���� ����鵵 ������ NOT NULL �������� ���� ����)
, SUBJECT   VARCHAR2(100)                       NOT NULL    -- �Խù� ����
, CONTENT   VARCHAR2(4000)                      NOT NULL    -- �Խù� ����
, IPADDR    VARCHAR2(20)                                    -- ������ Ŭ���̾�Ʈ IP �ּ�
, HITCOUNT  NUMBER          DEFAULT 0           NOT NULL    -- �Խù� ��ȸ��
, CREATED   DATE            DEFAULT SYSDATE     NOT NULL    -- �Խù� �ۼ���
, CONSTRAINT BOARD_NUM_PK PRIMARY KEY(NUM)                  -- �Խù� ��ȣ�� PK �������� ����
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� �Խù� ��ȣ�� �ִ밪�� ���� ������ ����
SELECT NVL(MAX(NUM), 0) AS MAXNUM
FROM TBL_BOARD;
--> �� �� ����
SELECT NVL(MAX(NUM), 0) AS MAXNUM FROM TBL_BOARD
;


--�� �Խù� �ۼ� ������ ����
INSERT INTO TBL_BOARD(NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, CREATED)
VALUES(1, '������', '1234', 'ljy@test.com', '�ۼ��׽�Ʈ', '�Խù������ۼ�', '211.238.142.160', 0, SYSDATE);
--> �� �� ����
INSERT INTO TBL_BOARD(NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, CREATED) VALUES(1, '������', '1234', 'ljy@test.com', '�ۼ��׽�Ʈ', '�Խù������ۼ�', '211.238.142.160', 0, SYSDATE)
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.


--�� DB ���ڵ��� ������ �������� ������ ����
--   �� �� ���ڵ� ��ü ���� �����ñ�?
--      �� �������� �Խù� 10���� �����ϱ�� ������,
--      ��ü �Խù� �� ������ �˾ƾ�! ������ �ϴ� ������ �� �˾Ƽ� 
--      ������ ���̾ƿ� �������� 
--      ȭ�� �ϴܿ� 1|2|3|4|5 ������ �̷��� ����°�
--      ���� ��ü�Խù� 8��~10����� �ؿ� ������ 1|2| �̷��� �ʿ����
--      �̵��� �ʿ䰡 ���� ��Ȳ�̴ϱ�
--      �׷��� 10�� �Ѿ�� 12�� �Ǹ�, 1|2 ������ ������� �Ѵ�.
--      &&
--      ���� ������ Ŭ������ ��, ���۹�ȣ~����ȣ ����Ʈ ���� ������ �ʿ��ϴ�.
SELECT COUNT(*) AS COUNT
FROM TBL_BOARD;
--> �� �� ����
SELECT COUNT(*) AS COUNT FROM TBL_BOARD
;
--==>> 0


--                 1       10
--�� Ư�� ������(���۹�ȣ~����ȣ) �Խù� ����� �о���� ������ ����
--   ��ȣ, �ۼ���, ����, ��ȸ��, �ۼ���
--  
--   WHERE NUM BETWEEN 1 AND 10;
--   �� �̷��� �ϸ� �߰��� �����Ѱ� ������, 
--      � �������� �� �ϳ��� ���� ���� �ְ�, ���̻��� �������� ���̴�....
-- ���� �ٸ� ��ȣ �ο��ؾ���, NUM ������ �ڸ��� �ȵȴ�.
-- �� ORDER BY NUM DESC?? �� �ֽ� �ۼ��� ���� �տ� ������ �ϴϱ�~!!
-- ��ROWNUM�� ���ȣ �ٿ��ִ°�! ������ �����س��� ������ �̷��Ը� ���� ���ȣ �ٴ´�.
--�ڡ� CREATED(DATE TYPE) ���� �� �� TO_CHAR() �ε�, TO_DATE() ��� �س��� �ð����� ������ �Ǽ�����
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
--> �� �� ����
SELECT  NUM, NAME, SUBJECT, HITCOUNT, CREATED FROM ( SELECT ROWNUM RNUM, DATA.* FROM ( SELECT NUM, NAME, SUBJECT, HITCOUNT, TO_DATE(CREATED, 'YYYY-MM-DD') AS CREATED FROM TBL_BOARD ORDER BY NUM DESC) DATA ) WHERE RNUM>=1 AND RNUM<=10
;


--�� Ư�� �Խù� ��ȸ�� ���� ��ȸ Ƚ�� ���� ������ ���� (�������) �� �α�ȭ(������)
--   �� �Խù����� ��ũ �ɷ��ְ�, �װ� Ŭ���ϸ� �Խù� ��������.
-- GET������� �����غ��� �� �Խù��� 
-- ��List.jsp?pageNum=1�� �̷������� ��ũ �����Ǿ� ���� ���̴�.
-- �׸��� �� �Խù� �� Ŭ���ϸ� ��Article.jsp?num=1�� �� ���� �� ���� ������
-- �׷��鼭! �� Ŭ���Ǹ� hitcount �ϳ��� �÷���� �Ѵ�!
-- �Խù� �ȿ��� ���ΰ�ħ�ϰų� �����ٰ� ��� �ٽ� Ŭ���ϸ� ��ȸ�� �ö�...
-- �׷��� ��ȸ���� �����ϰ� ���̷��������ϰ� �ϱ� ������ ����� ��ȸ�� �׷��� ���� ����
-- ���߿� �� ������ �ؾ� �ϱ� ������, ��ȸ���� LOGȭ ó���ϴ°� ��κ��̴�.
-- �Ź� �������� �װ� ������ ������, ��������Ʈ(������)�� �����.
-- ��� ���ƿ��ư �̷���! �� ����� ������ �� �����Բ� 
-- �׷������� �ϴ°� �α�ȭ �� �α� ������� �� ����°�
-- ���ΰ�ħ�ؼ� ��ȸ�� �ø��°� ���� ���
-- ���򿡴� 
-- ��ȸ�� ��� ���̺� ���� ����
-- ���� ���� ������ ���� ���ܳ���, 10�� �ȿ� �ٽ� ������ ��ȸ�� �ȿø��ٰų�
-- �̷�������!!
-- ���̺� ���� ���� ���ͼ� �����߰�, ���ƿ��ߴ��� �� ����������
-- �� ���ǹ� �� �� ����(���� ����� ���ƿ� ��������, 
--    ���� ����� ��ȸ�� ��¥�ͽð� ������ 
--    10�оȿ� �� ���� �� �ϸ� ī��Ʈ UPDATE ��Ű�� �ʰڴ�)
UPDATE TBL_BOARD
SET HITCOUNT = HITCOUNT + 1        -- ����Ŭ�� +=, ++ ����
WHERE NUM=1;
--> �� �� ����
UPDATE TBL_BOARD SET HITCOUNT = HITCOUNT + 1 WHERE NUM=1
;


--�� Ư�� �Խù��� ������ �о���� ������ ���� 
--   (�Խù� ��ȸ�ؼ� ������ �����ϴ� ����)  �� �� ������� �Ѵ�.
SELECT NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT
     , TO_CHAR(CREATED, 'YYYY-MM-DD') AS CREATED
FROM TBL_BOARD
WHERE NUM=3;
--> �� �� ����
SELECT NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, TO_CHAR(CREATED, 'YYYY-MM-DD') AS CREATED FROM TBL_BOARD WHERE NUM=3
;


--�� Ư�� �Խù��� �����ϴ� ������ ����
DELETE
FROM TBL_BOARD
WHERE NUM=12;
--> �� �� ����
DELETE FROM TBL_BOARD WHERE NUM=12
;


--�� Ư�� �Խù��� �����ϴ� ������ ����
--   (�Խù� �󼼺��� ������ �� Article.jsp �������� ó��)
--   �ۼ���, �н�����, �̸���, ����, ����
UPDATE TBL_BOARD
SET NAME='��μ�', PWD='1234', EMAIL='kms@test.com', SUBJECT='��������', CONTENT='��������'
WHERE NUM=5;
--> �� �� ����
UPDATE TBL_BOARD SET NAME='��μ�', PWD='1234', EMAIL='kms@test.com', SUBJECT='��������', CONTENT='��������' WHERE NUM=5
;


-- ���� �д� �Խù��� 50�� �Խù��̶�� �� ��, �Ʒ� ������ȣ/������ȣ ������ �����غ���
-- �Խù� ��ȣ�� �˾ƾ��Ѵ�.
--�� Ư�� �Խù�(50)�� ���� ��ȣ �о���� ������ ����
SELECT NVL(MIN(NUM), -1) NEXTNUM
FROM TBL_BOARD
WHERE NUM > 50;
--> �� �� ����
SELECT NVL(MIN(NUM), -1) NEXTNUM FROM TBL_BOARD WHERE NUM > 50
;


--�� Ư�� �Խù�(50)�� ���� ��ȣ �о���� ������ ����
SELECT NVL(MAX(NUM), -1) BEFORENUM
FROM TBL_BOARD
WHERE NUM < 50;
--> �� �� ����
SELECT NVL(MAX(NUM), -1) BEFORENUM FROM TBL_BOARD WHERE NUM < 50
;


