-- // 5. 문자열내에 특정문자 위치를 찾아주는 INSTR 함수 //
-- *문법 : SELECT INSTR(대상, 찾을 글자, 시작위치, n번째 글자 위치) AS 별칭 FROM 테이블명;
-- 시작 위치, n번째 글자 위치 생략 시 모두 1로 간주한다. 
-- 문자 발견 위치값 반환, 시작 위치부터 검색하여, n번째 문자에 해당하는 위치값 반환 
-- 문자열에서 원하는 문자열을 찾으면 문자열의 첫 번째 문자의 위치를 반환, 찾는 문자가 없으면 0을 반환 

-- 5-1. dual 테이블에서 문자열 내 특정 문자 위치 조회 
-- 1. 시작 위치 1번 인덱스부터 검색을 시작해 나온 첫 번째 O문자 위치 반환, 5 반환
-- 2. 시작 위치 6번 인덱스부터 검색을 시작해 나온 첫 번째 O문자 위치 반환, 8 반환 
-- 3. 시작 위치 2번 인덱스부터 검색을 시작해 나온 2 번째 O문자 위치 반환, 8 반환
SELECT INSTR('HELLO, ORACLE!', 'O') instr_1 
     , INSTR('HELLO, ORACLE!', 'O', 6) instr_2  
     , INSTR('HELLO, ORACLE!', 'O', 2, 2) instr_3 
  FROM dual;
  
-- 5-2. dual 테이블에서 문자열 내 특정 문자 위치 조회 
-- 1. HELLO의 첫 번째 문자 H의 위치 요소 반환, 1 반환 
-- 2. upper : 찾는 문자열을 대문자로 변환후 조회,
--    oracle의 첫 번째 문자 O의 위치 요소 반환, 8 반환
-- 3. data 값이 존재하지 않기 때문에 0을 반환 
SELECT INSTR('HELLO, ORACLE!', 'HELLO') instr_4  
     , INSTR('HELLO, ORACLE!', UPPER('oracle')) instr_5   
     , INSTR('HELLO, ORACLE!', 'data') instr_6 
  FROM dual;