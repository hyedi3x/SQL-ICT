-- // 9. 테이블 생성 수정 삭제 //  
-- // 9-1 SQL 문법 //
-- DDL(Data Definition Language : 데이터 정의어) : CREATE, ALTER, DROP, TRUNCATE -> AUTO COMMIT
-- DML(Data Manipulation Language : 데이터 조작어) : INSERT, UPDATE, DELETE -> COMMIT, ROLLBACK
-- DQL(Data Query Language : 데이터 질의어) : SELECT
-- DCL(Data Control Language : 데이터 제어) : GRANT, REVOKE
-- TCL(Transaction Control Language : 트랜잭션 콘트롤 제어) : COMMIT, ROLLBACK

-----------------------------------------------------------------------------
-- DML(Data Manipulation Language : 데이터 조작어) 
-- : INSERT, UPDATE, DELETE -> COMMIT, ROLLBACK

-----------------------------------------------------------------------------
-- // 9-2. CREATE TABLE (테이블 구조 생성) //
-- : DDL(Data Definition Language : 데이터 정의어) 중 하나이며, 데이터를 저장할 테이블을 생성하는 명령어이다. 

-- SCOTT_04 계정에서 작업 (테이블을 생성해서 사용할 것이기 때문.)
-- [실습 9-1] 멤버 테이블 생성 (member_tb)
-- 1. 테이블 삭제를 먼저 진행한다. (테이블이 이미 존재할 수 있기 때문에) 
DROP TABLE member_tb;

-- 2. 회원 정보 테이블 생성 (auto commit) 
CREATE TABLE member_tb(
       mem_id       NUMBER(3)           PRIMARY KEY,    --- PK(UNIQUE, NOT NULL)
       mem_name     VARCHAR2(50)        NOT NULL, 
       mem_age      NUMBER(3), 
       mem_email    VARCHAR2(60)        NOT NULL UNIQUE, 
       mem_address  VARCHAR2(100)
);

-- 3. 테이블 구조 조회
DESC member_tb;

-----------------------------------------------------------------------------
-- // 9-3. INSERT (테이블의 내용을 추가) //
-- : DML(Data Manipulation Language : 데이터 조작어) 중 하나이며, 테이블에 새로운 데이터를 삽입하기 위한 명령어의 집합이다. 
--   테이블에 데이터 추가하기 - 컬럼갯수, 컬럼순서, 자료형이 일치해야 한다.
--   컬럼명 생략시 테이블생성시의 모든 컬럼순서대로 모든 값을 insert해야 한다. 
--   개수, 자료형 모두 일치해야 하며, 데이터 생략 불가.

-- [실습 9-2] INSERT를 통해 테이블에 데이터 5개를 삽입한다. 
INSERT INTO member_tb(mem_id, mem_name, mem_age, mem_email, mem_address)
       VALUES(101, '김태희', 30, 'km@mail.com', '서울시 서초구');

INSERT INTO member_tb(mem_id, mem_name, mem_age, mem_email, mem_address)
       VALUES(102, '비', 35, 'rain@mail.com', '서울시 마포구');

INSERT INTO member_tb(mem_id, mem_name, mem_age, mem_email, mem_address)
       VALUES(103, '홍길동', 40, 'hong@mail.com', '서울시 금천구');
        
INSERT INTO member_tb(mem_id, mem_name, mem_age, mem_email, mem_address)
       VALUES(104, '아이유', 45, 'IU@mail.com', '서울시 강남구');

INSERT INTO member_tb(mem_id, mem_name, mem_age, mem_email, mem_address)
       VALUES(105, '이순신', 50, 'lee@mail.com', '서울시 은평구');

COMMIT;  -- 영구 저장

-- 테이블 확인 
SELECT * FROM member_tb;

-----------------------------------------------------------------------------
-- // 9-4. UPDATE (테이블의 내용을 수정) //
-- : DML(Data Manipulation Language : 데이터 조작어) 중 하나이며, 테이블에 기존 데이터를 수정하기 위한 명령어의 집합
--   WHERE 조건절 : 조건이 없으면 모든 행의 데이터가 수정될 수 있다. 

-- [실습 9-3] UPDATE를 통해 mem_id 105번의 행 데이터들을 수정한다. 
-- 조건 : 이름, 메일, 주소를 수정한다. 
UPDATE member_tb 
   SET mem_name='소지섭', mem_email='sojisub@mail.com', mem_address='서울시 역삼동'
 WHERE mem_id = 105; 

-- 테이블 확인 
SELECT * FROM member_tb;

COMMIT;  -- 영구 저장

-----------------------------------------------------------------------------
-- // 9-5. DELETE(테이블의 내용을 삭제)   //
-- : DML(Data Manipulation Language : 데이터 조작어) 중 하나이며, 테이블에 기존 데이터를 제거(행 삭제)하기 위한 명령어이다. 
--   WHERE 조건절 : 조건이 없으면 모든 행의 데이터가 제거될 수 있다. 

-- [실습 9-4] DELETE를 통해 mem_id 105번의 행 데이터들을 제거한다.
DELETE member_tb 
WHERE mem_id = 105; -- 제거할 컬럼 = 어떤 데이터가 담긴 행을 제거할지 여부

-- 테이블 확인 
SELECT * FROM member_tb;

-- 전체 컬럼의 행 데이터들을 제거
DELETE member_tb; 

-- 테이블 확인 
SELECT * FROM member_tb;

ROLLBACK; -- commit전 취소 가능, commit 후 취소 불가  
  COMMIT;  -- 영구 저장
