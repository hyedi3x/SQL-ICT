-- // {10. 트랜잭션 & 데이터사전 & 제약조건} // 
---------------------------------------------------------------------------------------

-- // [10-1.트랜잭션] // 
-- : 트랜잭션은 데이터 처리에서 논리적인 하나의 작업 단위를 의미한다.
-- - ALL or Nothing : 여러 개의 명령어 집합이 정상적으로 처리되면 정상종료하고, 명령어들 중 하나라도 잘못된다면 전체를 취소한다.
-- - DML 작업이 성공적으로 처리되었다면 `COMMIT`을, 취소해야 한다면 `ROLLBACK` 명령을 실행한다.
   
-- DDL(테이블생성, 수정), DCL(권한)문이 실행되는 경우에는 자동으로 COMMIT 된다. COMMIT 할 필요 없다. (auto commit)
-- COMMIT - 트랜잭션의 처리과정을 반영하여 변경된 내용을 영구저장한다. 모든 작업들의 정상처리확정 명령어다.
-- ROLLBACK : COMMIT 후에 취소가 되지 않는다. commit 이전 상태로 돌아간다. 
-- SAVEPOINT - 현재의 트랜잭션을 작게 분할한다. 저장된 SAVEPOINT는 ROLLBACk TO SAVEPOINT 문을 사용하여 표시한 곳까지 롤백 가능.
-- LOCK : 특정 세션에서 조작중인 데이터는 트랜잭션이 완료(COMMIT, ROLLBACK)되기 전까지 다른 계정에서 
--        조작할 수 없도록 접근을 보류시키게 된다. 즉 데이터가 '잠금현상'이 일어난다.
--        트랜잭션이 완료(COMMIT, ROLLBACK)가 되면 LOCK이 풀리게 된다.
--        주의 : WHERE절을 지정하지 않은 UPDATE, DELETE문일 경우에는 테이블의 모든행이 LOCK 상태가 된다.

-- [실습 10-1] 트랜잭션 실습용 테이블을 생성하고, SAVEPOINT, ROLLBACK, COMMIT을 실습한다. 
-- 1. 테이블 삭제를 먼저 진행한다. (테이블이 이미 존재할 수 있기 때문에) 
DROP TABLE member_tb_tr;

-- 2. 트랙잭션 실습용 테이블 생성 (member_tb_tr)
-- 조건 : member_tb의 데이터와 구조를 복제해온다. 
CREATE TABLE member_tb_tr
    AS SELECT * FROM member_tb;

-- 3. member_tb_tr 테이블 조회
SELECT * FROM member_tb_tr;

-- 4. 103번 멤버의 이메일을 수정한다.
UPDATE member_tb_tr
   SET mem_email = 'gildong@naver.com'
 WHERE mem_id = 103;
SAVEPOINT s1;  -- 저장 위치 s1

-- 5. 101번 멤버 데이터를 삭제한다.
DELETE FROM member_tb_tr
 WHERE mem_id = 101;
SAVEPOINT s2;  -- 저장 위치 s2

-- 6. 102번 멤버 데이터를 삭제한다.
DELETE FROM member_tb_tr
 WHERE mem_id = 102;
SAVEPOINT s3;  -- 저장 위치 s3

-- 7. 104번 멤버 데이터를 삭제한다.
DELETE FROM member_tb_tr
 WHERE mem_id = 104;
SAVEPOINT s4;  -- 저장 위치 s4

-- 8. member_tb_tr 테이블 조회
SELECT * FROM member_tb_tr;    

-- 9. savepoint 부활
ROLLBACK TO s3;  -- 저장 위치 s3로 롤백, 104번 부활

ROLLBACK TO s2;  -- 저장 위치 s2로 롤백, 102번 부활

ROLLBACK TO s1;  -- 저장 위치 s1로 롤백, 101번 부활

ROLLBACK; -- save point가 없고 초기로 돌아갈때 (commit 이후 시점)

COMMIT; -- 영구 저장
