
--���� �ǽ� ���ణ �׽�Ʈ ����--

SELECT COUNT(*) AS COUNT
FROM TBL_BOARD;
--==>> 0


--�� �Խù� �ۼ�
INSERT INTO TBL_BOARD(NUM, NAME, PWD, EMAIL, SUBJECT, CONTENT, IPADDR, HITCOUNT, CREATED)
VALUES(1, '������', '1234', 'kth@test.com', '�ۼ��׽�Ʈ', '���빰�ۼ�', '211.238.142.154', 0, SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--*** �� �ݵ�� Ŀ���ؾߵȴ�.
--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խù� ����
DELETE TBL_BOARD
WHERE NUM=1;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ���ν��� ���� ���� ���̺� ��ȸ
SELECT *
FROM TBL_BOARD
ORDER BY NUM;


--�� �˻� ������ ���� ��ȸ ������ ����
SELECT COUNT(*) AS COUNT
FROM TBL_BOARD
WHERE SUBJECT LIKE '%����%';
--> �� �� ����
SELECT COUNT(*) AS COUNT FROM TBL_BOARD WHERE SUBJECT LIKE '%����%'
;
--==>> 180


SELECT *
FROM TBL_BOARD
ORDER BY NUM desc;

--�� 


--�� 