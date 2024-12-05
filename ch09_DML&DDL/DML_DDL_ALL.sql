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

-----------------------------------------------------------------------------
-- DDL(Data Definition Language : 데이터 정의어)
-- : CREATE, ALTER, DROP, TRUNCATE -> AUTO COMMIT

-- /////////////////////////////////////////////////////////////////////////////// --
-- // 9-6. 테이블 복사 //
-- 1) 기존 생성된 테이블을 복사해와 새로운 테이블 생성 
-- 새로운 테이블 CREATE + 데이터 INSERT 작업 자동화 
-- -> 기존 테이블을 가져와서 카피하기에 INSERT 작업 생략
-- -> 키 값(제약조건)은 복제되지 않음, null 설정은 복제 됨(제약조건 아님)

-- [실습 9-5] 기존 테이블의 모든 데이터 및 컬럼을 복제한 새로운 테이블 생성.
-- 1. 테이블 삭제
DROP TABLE member_tb_copy;

-- 2. member_tb의 모든 데이터 및 컬럼을 복제 
CREATE TABLE member_tb_copy   
       AS SELECT * FROM member_tb;

-- 3. 생성된 테이블(member_tb_copy) 조회
SELECT * FROM member_tb_copy;
COMMIT; -- 영구 저장 

-- 4. 테이블 구조 확인 
DESC member_tb_copy;

-----------------------------------------------------------------------------
-- 2) 기존 생성된 테이블의 구조만 복사해, 새로운 테이블 생성 
-- INSERT 데이터는 복사되지 않는다.
-- -> 키 값(제약조건)은 복제되지 않음, null 설정은 복제 됨(제약조건 아님)
-- 조건절에 거짓 조건을 작성하면, 데이터가 복사(복제)되지 않는다. 

-- [실습 9-6] 기존 생성된 테이블의 구조만 복사해, 새로운 테이블 생성 (데이터 복제 x)
-- 1. 테이블 삭제
DROP TABLE member_tb_copy2;

-- 2. member_tb의 테이블 구조만 복제하여 새로운 테이블 생성  
CREATE TABLE member_tb_copy2   
    AS SELECT * FROM member_tb
        WHERE 0=1;   -- 조건절에 거짓 조건을 작성, 0과 1은 같지 않다. 

-- 3. 생성된 테이블(member_tb_copy) 조회
SELECT * FROM member_tb_copy2;
COMMIT; -- 영구 저장 

-- 4. 테이블 구조 확인 
DESC member_tb_copy2;

-----------------------------------------------------------------------------
-- 3) 테이블 데이터만 복사, 테이블 구조는 복제하지 않는다.  
-- [실습 9-7] 빈 테이블 구조만 있는 테이블 member_tb_copy2에 member_tb의 데이터를 복사하여 삽입한다. 
-- 1. 데이터 삽입 
INSERT INTO member_tb_copy2
       SELECT * FROM member_tb;

-- 2. 데이터 영구 저장
COMMIT;

-- 3. 삽입된 데이터 조회 
SELECT * FROM member_tb_copy2;

-- /////////////////////////////////////////////////////////////////////////////// --
-- // 9-7. ALTER TABLE (테이블 구조 변경) //
-- 1) 새로운 컬럼추가 : ADD 새로운 컬럼명 데이터타입 (제약 조건)
--    컬럼추가를 하면 테이블의 맨끝에 컬럼이 추가된다.

-- 2) 기존 컬럼명 변경(수정) : RENAME COLUMN old_컬럼 TO new_컬럼

-- 3) 기존 컬럼의 자료형 변경 : MODIFY 컬럼명 데이터타입 (제약 조건)
--    기존 데이터는 그대로 유지하면서 데이터타입, 크기, 기본값을 변경한다.
--    데이터가 존재하지 않을 경우 : 타입 변경이 자유롭지만, 
--    데이터가 존재하는 경우 : 타입 변경은 char, varchar2만 변경이 허용되며, 
--    변경한 컬럼의 크기는 저장된 데이터의 크기와 같거나 클 경우에만 변경 가능하다.
--    제약조건 변경은 필수는 아니다.

-- 4) 컬럼제거 : DROP COLUMN 컬럼명
-- -> 특정 컬럼과 컬럼 내의 데이터를 제거할 수 있다. 
-- -> 2개 이상의 컬럼이 존재하는 테이블만 가능하다. 
-- -> 삭제된 컬럼은 복구할 수 없고, 한번에 하나의 컬럼만 삭제할 수 있다. 

-----------------------------------------------------------------------------
-- 1) 컬럼추가 : ADD 컬럼명 데이터타입 (제약 조건)
-- [실습 9-8] 새로운 컬럼 mem_joindate을 추가하고, 컬럼의 자료형을 date로 지정한다.(현재날짜) 
-- 1. 새로운 컬럼 추가
ALTER TABLE member_tb_copy
      ADD mem_joindate DATE DEFAULT sysdate;  

-- 2. 테이블 조회 
SELECT * FROM member_tb_copy;

-- 3. 데이터 영구 저장
COMMIT;

-- 4. 테이블 구조 확인 
DESC member_tb_copy;

-----------------------------------------------------------------------------
-- 2) 컬럼명 변경 : rename column old_컬럼 to new_컬럼 
-- [실습 9-9] 기존 컬럼 mem_joindate 컬럼명을 mem_join_date로 변경한다.  
-- 1. 컬럼명 수정 
ALTER TABLE member_tb_copy 
      RENAME COLUMN mem_joindate TO mem_join_date;

-- 2. 테이블 조회 
SELECT * FROM member_tb_copy;

-- 3. 데이터 영구 저장
COMMIT;

-- 4. 테이블 구조 확인 
DESC member_tb_copy;

-----------------------------------------------------------------------------
-- 3) 컬럼의 자료형 변경 : MODIFY 컬럼명 데이터타입
-- [실습 9-10] member_tb_copy 테이블의 mem_email, mem_id 컬럼의 데이터타입과 제약조건을 수정한다. 
-- 1. mem_email 컬럼의 데이터 타입을 VARCHAR2(100)과 제약 조건을 UNIQUE로 수정한다. 
ALTER TABLE member_tb_copy
      MODIFY mem_email VARCHAR2(100) UNIQUE;  -- 원래 VARCHAR2(60)이었음

-- 2. mem_ID 컬럼의 데이터 타입을 NUMBER(5)과 제약 조건을 PRIMARY로 수정한다. 
ALTER TABLE member_tb_copy
      MODIFY mem_ID NUMBER(3) PRIMARY KEY;  -- 원래 NUMBER(5)이었음

-- 3. 데이터 영구 저장
COMMIT;

-- 4. 테이블 구조 확인 
DESC member_tb_copy;

-----------------------------------------------------------------------------
-- 4) 컬럼제거 : DROP COLUMN 컬럼명
-- [실습 9-11] member_tb_copy 테이블의 mem_join_date 컬럼을 제거한다. 
-- 1. 컬럼 제거
ALTER TABLE member_tb_copy
      DROP COLUMN mem_join_date;

-- 2. 테이블 조회
SELECT * FROM member_tb_copy;

-- 3. 데이터 영구 저장
COMMIT;

-- 4. 테이블 구조 확인 
DESC member_tb_copy;

-- /////////////////////////////////////////////////////////////////////////////// --
-- // 9-8. RENAME TO (테이블명 변경) //
-- [형식1]
-- ALTER TABLE [old 테이블명] 
--       RENAME TO [new 테이블명] 

-- [형식2] 
-- RENAME [old 테이블명] TO [new 테이블명];

-- [실습 9-12] member_tb_copy2의 테이블 명을 member_tb_rename으로 변경한다. 
-- 1. 기존 테이블 조회
SELECT * FROM member_tb_copy2;

-- 2. 기존 테이블 명 새로운 테이블명으로 수정 
RENAME member_tb_copy2 TO member_tb_rename;

-- 3. 이전 테이블 조회
SELECT * FROM member_tb_copy2;  -- 없는 테이블 

-- 4. 새로 변경한 테이블 조회
SELECT * FROM member_tb_rename; 

-- /////////////////////////////////////////////////////////////////////////////// --
-- // 9-9. TRUNCATE (테이블 속 모든 데이터 제거) //
-- 데이터(행)만 모두 제거(전체 삭제), 테이블 구조를 제거하는 것은 아니다.
-- 제약조건, 인덱스, 뷰, 동의어 등은 그대로 유지된다. 
-- delete는 커밋후 롤백 가능하지만, truncate는 커밋 후 롤백 불가하다. 
-- [형식] TRUNCATE TABLE 테이블명

-- [실습 9-13] member_tb_rename 테이블의 데이터를 모두 제거한다. 
-- 1. member_tb_rename 테이블 조회
SELECT * FROM member_tb_rename; -- 데이터 5건 존재

-- 2. 테이블 속 모든 데이터(행) 삭제
TRUNCATE TABLE member_tb_rename;  -- 데이터 전체 삭제 

-- 3. member_tb_rename 테이블 조회
SELECT * FROM member_tb_rename;  -- 데이터 0건 존재 

-- 4. 테이블 구조 확인 
DESC member_tb_rename;

-- /////////////////////////////////////////////////////////////////////////////// --
-- // 9-10. DROP TABLE (테이블 구조 제거)  //
-- 테이블 자체 삭제 (테이블 구조 및 모든 데이터를 제거한다.)
-- 삭제할 테이블의 기본 키나 고유 키를 다른 테이블에서 참조하고 있는 경우 삭제 불가능 
-- -> 삭제가 불가한 경우, 참조 중인 자식 테이블을 먼저 제거해야 한다.
-- [형식] DROP TABLE 테이블명

-- [실습 9-14] member_tb_rename 테이블을 삭제(제거)한다. 
-- 1. 테이블 목록 조회 
SELECT * FROM tab;

-- 2. member_tb_rename 테이블을 삭제
DROP TABLE member_tb_rename; 

-- 3. member_tb_rename 테이블 조회
SELECT * FROM member_tb_rename;  
 
-- 4. 테이블 구조 확인 
DESC member_tb_rename;
 
-- 5. 테이블 목록 조회 
SELECT * FROM tab;
