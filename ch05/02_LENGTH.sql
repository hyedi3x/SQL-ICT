-- // 2. 문자열 길이 함수 //
-- - LENGTH(문자열) : `문자열의 길이`를 반환(한글은 1byte 반환, 영문은 1byte 반환) 
-- - LEGNTHB(문자열) : `문자열의 바이트 수`를 반환(한글은 3byte 반환, 영문은 1byte 반환) 

-- [참고] 
-- Dual 테이블 : SYS 소유의 테이블로, 오라클에서 제공하는 dummy 테이블, 
-- 한 행으로 결과를 출력함, 임시연산, 함수결과 확인용도로 종종 사용한다
-- DUMMY  VARCHAR2(1)라는 하나의 컬럼으로 구성되어 있고, 데이터는 'X'값 

-- 2-1. LENGTH : 한글 한 문자당 1byte
-- 조건 : LENGTH 함수를 사용하여, 안녕을 출력해본다. 
SELECT LENGTH('안녕') FROM dual;

-- 2-2. LENGTHB : 한글 한 문자당 3byte
-- 조건 : LENGTHB 함수를 사용하여, 안녕을 출력해본다. 
SELECT LENGTHB('안녕') FROM dual;

-- 2-3. LENGTH : 영문 한 글자는 무조건 문자당 1byte
-- - LENGTH 함수를 사용하여, HI를 출력해본다.
SELECT LENGTH('HI') FROM dual;

-- 2-4. LENGTHB : 영문 한 글자는 무조건 문자당 1byte
-- - LENGTHB 함수를 사용하여, HI를 출력해본다.
SELECT LENGTHB('HI') FROM dual;

-- 2-5. dual 테이블에서 LENGTH와 LENGTHB 한눈에 조회하기 
SELECT LENGTH('tree')
     , LENGTHB('tree')
     , LENGTH('나무')
     , LENGTHB('나무')
  FROM dual;
