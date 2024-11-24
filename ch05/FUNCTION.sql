-- ///////////////////////////////////////////////
// 1. 대소문자를 바꿔주는 UPPER, LOWER, INITCAP 문자 함수 // 
-- UPPER : 대문자로 변환
-- LOWER : 소문자로 변환
-- INITCAP : 첫글자만 대문자로, 나머지 글자는 소문자로 변환
 
-- 1-1. 사원테이블의 email이 'TFOX'일 경우 email 조회, UPPER 사용 
SELECT employee_id "사원 ID"
       , email 이메일 
  FROM employees
 WHERE email = UPPER('tfox');  -- 대문자로 다 변환 후 값 조회 
 
-- 1-2. dual 테이블에 'hi' 컬럼 데이터가 'hi'일때, LOWER 사용
SELECT 'hi'
  FROM dual
WHERE 'hi' = LOWER('HI'); -- 소문자로 다 변환 후 값 조회 

-- 1-3. 사원 테이블의 last_name이 'King'일 경우 employee_id, last_name 조회
-- 조건 : INTICAP 안의 문자열을 소문자로 입력한다. 
SELECT employee_id "사원 ID"
       , last_name 이름 
  FROM employees
 WHERE last_name = INITCAP('king');  -- 첫글자를 대문자로 변환, 나머지는 소문자로 변환 후 값 조회 

-- 1-4. 사원 테이블의 last_name이 'King'일 경우 employee_id, last_name 조회
-- 조건 : INTICAP 안의 문자열을 대문자로 입력한다. 
SELECT employee_id "사원 ID"
       , last_name 이름 
  FROM employees
 WHERE last_name = INITCAP('KING');  -- 첫글자를 대문자로 변환, 나머지는 소문자로 변환 후 값 조회 

-- 1-5. dual 테이블에 'Oracle mania'를 조회 
-- 조건 : UPPER, LOWER, INITCAP을 사용하여 변환된 문자열을 확인한다. 
SELECT 'Oracle Developer'
     , UPPER('Oracle Developer') UPPER
     , LOWER('Oracle Developer') LOWER
     , INITCAP('Oracle Developer')INITCAP
  FROM dual;

-- ///////////////////////////////////////////////
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

-- ///////////////////////////////////////////////
-- // 3. 문자 결합 함수 (CONCAT[||]) //
-- 문자의 값을 연결한다.

-- 3-1. 사원 테이블에서 사원ID, 입사일, AS 이름(first_name-last_name) 조회
-- 조건 : ||로 first_name과 last_name 컬럼 결합 (컬럼이나 문자열 개수 상관없이 결합 가능) 
-- 정렬 : employee_ID 오름차순 정렬 
SELECT employee_id  사원ID
     , hire_date  입사일
     , first_name||'-'||last_name "성+이름"
 FROM employees
ORDER BY employee_id ASC;  -- employee_ID 오름차순 정렬 

-- 3-2. 사원 테이블에서 사원ID, 입사일, AS 이름(first_name-last_name)  조회
-- 조건 : CONCAT으로 first_name과 last_name 컬럼을 결합한다. (2개의 문자나 2개의 컬럼만 묶을 수 있다.)
-- 정렬 : employee_ID 오름차순 정렬 
SELECT employee_id  사원ID
     , hire_date  입사일
     , CONCAT(first_name, CONCAT('-', last_name)) "성+이름"
 FROM employees
ORDER BY employee_id ASC;  -- employee_ID 오름차순 정렬 

-- 3-3. 사원의 사원ID, 입사일(02년도, 04년도), 이름(first_name-last_name) 조회
-- 조건 : 입사년도가 02년도이거나 04년도인 입사일을 가진 사원 정보 조회 (OR / BETWEEN 사용), ||로 first_name, last_name 컬럼 연결 
-- 정렬 : hire_date 오름차순 정렬 
SELECT employee_id  사번
     , hire_date  입사일
     , first_name||'-'||last_name "성+이름"
 FROM employees
WHERE hire_date BETWEEN '02/01/01' AND '02/12/31' -- 02년도 1년간 범위
   OR hire_date BETWEEN '04/01/01' AND '04/12/31' -- 04년도 1년간 범위
ORDER BY hire_date ASC;  -- hire_date 오름차순 정렬

-- ///////////////////////////////////////////////
-- // 4. 문자열 일부를 추출하는 SUBSTR 함수 //
-- * 문법 : SELECT SUBSTR(컬럼명, 시작 위치, 추출길이)　AS 별칭 FROM 테이블명;
-- SQL 문자열 요소 인덱스는 1부터 시작한다. 
-- 시작　위치부터 추출 개수만큼 추출한다.
-- 시작　위치가 양수인 경우　: 시작 위치(문자열 순방향)부터 추출 길이만큼 추출 (추출 방향은 순방향)
-- 시작 위치가 음수인 경우 : 시작 위치(문자열 역방향)부터 추출 길이만큼 추출 (추출 방향은 순방향)

-- *문법 : SELECT SUBSTR(컬럼명, 시작 위치)　AS 별칭 FROM 테이블명;
-- 추출 개수 생략 시 : 시작 위치부터 데이터 끝까지 추출
-- 시작　위치가 양수인 경우　: 시작 위치(문자열 순방향)부터 데이터 끝까지 추출 (추출 방향은 순방향)
-- 시작 위치가 음수인 경우 : 시작 위치(문자열 역방향)부터 데이터 끝까지 추출 (추출 방향은 순방향)

-- 4.1 사원 테이블에서 job_id 조회 
-- 조건 : SUBSTR을 사용하여 job_id 컬럼의 `AC_ACCOUNT` 문자열의 일부분을 추출한다. 
--        SELECT SUBSTR(컬럼명, 1, 2) : 문자열 시작 위치 1번 인덱스부터 문자 2개 추출
--        SELECT SUBSTR(컬럼명, -2, 2) : 문자열 시작 위치 뒤에서 2번째 인덱스부터 문자 2개 추출
--        SELECT SUBSTR(컬럼명, -8) : 문자열 시작 위치 뒤에서 8번 인덱스부터 문자열 끝까지 추출
--        SELECT SUBSTR(컬럼명, 5) : 문자열 시작 위치 5번 인덱스부터 문자열 끝까지 추출
 SELECT job_id 직무ID
      , SUBSTR(job_id, 1, 2) "(job_id, 1, 2)"  
      , SUBSTR(job_id, -2, 2) "(job_id, -2, 2)"  
      , SUBSTR(job_id, -8) "(job_id, -8)" 
      , SUBSTR(job_id, 5) "(job_id, 5)"
   FROM employees
  WHERE job_id = 'AC_ACCOUNT';
  
-- 4.2 사원 테이블에서 first_name 조회 
-- 조건 : SUBSTR을 사용하여 first_name 컬럼의 `Elizabeth` 문자열의 일부분을 추출한다. 
--        SELECT SUBSTR(컬럼명, 6, 4) : 문자열 시작 위치 6번 인덱스부터 문자 4개 추출
--        SELECT SUBSTR(컬럼명, 4, 2) : 문자열 시작 위치 뒤에서 4번째 인덱스부터 문자 2개 추출
--        SELECT SUBSTR(컬럼명, -4, 4) : 문자열 시작 위치 뒤에서 4번 인덱스부터 문자 4개 추출
--        SELECT SUBSTR(컬럼명, -6) : 문자열 시작 위치 뒤에서 6번 인덱스부터 문자열 끝까지 추출
SELECT first_name 성
     , SUBSTR(first_name, 6, 4) "(first_name, 6, 4)"
     , SUBSTR(first_name, 4, 2) "(first_name, 4, 2)"
     , SUBSTR(first_name, -4, 4) "(first_name, -4, 4)"
     , SUBSTR(first_name, -6) "(first_name, -6)"
  FROM employees
 WHERE first_name = 'Elizabeth';

-- ///////////////////////////////////////////////
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

-- ///////////////////////////////////////////////
-- // 6. LPAD, RPAD 함수 //
-- 데이터의 길이가 지정한 자릿수보다 작을 경우 빈(나머지)공간을 특정 문자로 채우는 함수
-- LPAD(대상, 전체 문자열 길이, 채울 문자): 지정한 길이보다 데이터의 길이가 작은 경우, 왼쪽 빈 자리에 특정 기호를 채우는 함수 
-- RPAD(대상, 전체 문자열 길이, 채울 문자): 지정한 길이보다 데이터의 길이가 작은 경우, 오른쪽 빈 자리에 특정 기호를 채우는 함수
 
-- 6-1. dual 테이블에 주민번호 뒷자리와 폰 번호 뒷 자리를 * 기호로 채우기 
-- 1. 주민번호는 14자리로 구성되어 있다. (-포함)
-- 2. 핸드폰번호는 13자리로 구성되어 있다. (-포함)
SELECT RPAD('241123-', 14, '*') RPAD_JNUM
     , RPAD('010-1234-', 13, '*') RPAD_PNUM
  FROM dual;
  
-- 6-2. employees 테이블의 컬럼을 불러와 빈 공간(왼쪽 공간)을 특정 기호로 채우기
-- 1. 사원의 Full-name을 출력하는데, last_name만 표출. 빈 공간(왼쪽 공간)은 *로 채우기 (-포함)
-- 2. 부서 ID 데이터 길이를 맞추기 위해 빈공간(왼쪽 공간)을 0으로 채운다. 
SELECT LPAD('-'||last_name, 10, '*') LPAD_LName
     , LPAD(department_id, 5, '0') LPAD_DID
  FROM employees;
  
-- ///////////////////////////////////////////////
-- // 7. REPLACE 함수 // 
-- : 특정 문자를 다른 문자로 바꾸는(대체하는) 함수
-- * 문법 : REPLACE(문자열 데이터 또는 열이름(필수), [찾는 문자(필수)], [대체할 문자(선택)] 

-- 7-1. dual 테이블에서 핸드폰 번호의 '-'문자를 다른 기호로 바꿔보기
-- 1. 문자열 사이에 공백도 가능 
-- 2. / 기호로 변경 
-- 3. 대체할 문자열 생략시 지정한 -기호만 제거된다. (공백없음)
  SELECT '010-1111-2222' AS REPLACE_BEFORE
      , REPLACE('010-1111-2222', '-', ' ') AS REPLACE_1
      , REPLACE('010-1111-2222', '-', '/') AS REPLACE_2
      , REPLACE('010-1111-2222', '-') AS REPLACE_3
   FROM dual;   

-- 7-2. 사원의 사원ID, 입사일(02년도, 03년도), 이름(first_name-last_name) 조회
-- 조건 : 입사년도가 02년도이거나 03년도인 입사일을 가진 사원 정보 조회  
--        SUBSTRING을 사용하여 날짜를 추출하고, CONCAT으로 문자열을 결합한다.  
-- 정렬 : hire_date 오름차순 정렬 
SELECT employee_id  사번
     ,'20'
      ||SUBSTR(hire_date, 1, 2)||'년 ' -- hire_date의 1-2 요소 추출값과 문자열 결합
      ||SUBSTR(hire_date, 4, 2)||'월 ' -- hire_date의 4-5 요소 추출과 문자열 결합
      ||SUBSTR(hire_date, 7, 2)||'일' 입사일 -- hire_date의 7-8 요소 추출과 문자열 결합
     , first_name||'-'||last_name 이름
 FROM employees
 WHERE SUBSTR(hire_date, 1, 2) = 02  -- 년도가 02년도 일때
    OR SUBSTR(hire_date, 1, 2) = 03  -- 년도가 03년도 일때
 ORDER BY hire_date ASC;

-- 7-3. 사원의 사원ID, 입사일(01년도, 04년도), 이름(first_name-last_name) 조회
-- 조건 : 입사년도가 01년도이거나 04년도인 입사일을 가진 사원 정보 조회  
--        SUBSTRING을 사용하여 날짜를 추출하고, CONCAT으로 문자열을 결합한다. 
--        REPLACE를 사용하여, / 기호 대신 년, 월로 대체한다. 
-- 정렬 : hire_date 오름차순 정렬 
SELECT employee_id 사번
     -- hire_date의 1~3 요소를 추출하고, '/' 대신 '년' 문자열로 대체한다.
     -- hire_date의 4~6 요소를 추출하고, '/' 대신 '월' 문자열로 대체한다.
     -- hire_date의 7-8 요소 추출과 문자열 결합
     , 20||REPLACE(SUBSTR(hire_date, 1, 3), '/', '년 ') 
       || REPLACE(SUBSTR(hire_date, 4, 3), '/', '월 ') 
       || SUBSTR(hire_date, 7, 2)|| '일' 입사일
     , first_name||'-'||last_name 이름
  FROM employees
 -- substring으로 추출한 컬럼 위치의 데이터 01와 04을 뽑아낸다
 WHERE SUBSTR(hire_date, 1, 2) IN (01, 04) 
 ORDER BY hire_date ASC;

-- ///////////////////////////////////////////////
-- // 08. TRIM 함수 //
-- : 문자열의 공백을 제거하거나 반복적인 문자(좌/우만 가능)나 특정 문자를 제거할 때 자주 사용한다. 
-- TRIM : 문자열의 양쪽 공백을 제거하는 기본적인 함수이다. 
-- LTRIM 함수, RTRIM 함수는 왼쪽과 오른쪽의 공백을 제거할 때 사용
-- LTRIM 함수, RTRIM 함수 : 반복적인 문자나 특정 문자를 제거할 때 자주 사용한다.

-- 8-1. dual 테이블에서 '    Oracle SQL    ' 텍스트의 공백을 제거한다. 
-- 1. TRIM은 양쪽 공백을 제거한다. 
-- 2. LTRIM은 왼쪽 공백만 제거한다. 
-- 3. RTRIM은 오른쪽 공백만 제거한다. 
SELECT '    Oracle SQL    '
     , TRIM('    Oracle SQL    ') AS "TRIM"
     , LTRIM('    Oracle SQL    ') AS "LTRIM" 
     , RTRIM('    Oracle SQL    ')  AS "RTRIM" 
  FROM dual;  

-- 8-2. dual 테이블에서 'ACCOUNTING', '00100' 텍스트의 지정 문자를 제거한다. (지정문자 반복시, 한 번에 제거) 
-- 1. LTRIM은 왼쪽 지정문자를 제거한다. 
-- 2. LTRIM은 왼쪽 반복 문자를 제거한다. (0, 2개 제거)
-- 3. RTRIM은 오른쪽 반복 문자를 제거한다. (0, 2개 제거)
-- 4. RTRIM은 왼쪽 지정문자를 제거하지 못한다. 
-- 5. RTRIM은 오른쪽 지정문자를 제거한다. 
SELECT 'ACCOUNTING', '00100'
     , LTRIM('ACCOUNTING', 'ACC') AS "LTRIM_ACC" 
     , LTRIM('00100', '0')  AS "LTRIM_0"
     , RTRIM('00100', '0')  AS "RTRIM_0"      
     , RTRIM('ACCOUNTING', 'ACC')  AS "RTRIM_ACC"
     , RTRIM('ACCOUNTING', 'ING')  AS "RTRIM_ING"
  FROM dual;  

-- ///////////////////////////////////////////////
-- // 9. 숫자 데이터를 연산하고 수치를 조정하는 숫자 함수 // 
-- ROUND : 지정한 숫자의 특정 위치에서 반올림한 값을 반환
-- TRUNC : 지정한 숫자의 특정 위치에서 버림한 값을 반환
-- CEIL : 지정한 숫자와 가까운 큰 정수 반환
-- FLOOR : 지정한 숫자와 가까운 작은 정수 반환
-- MOD : 숫자를 나눈 나머지 값을 구하는 MOD 함수

-- ROUND : 지정한 숫자의 특정 위치에서 반올림한 값을 반환
-- *문법 : ROUND(숫자, 반올림위치)
-- 반올림 위치 생략시 소수점 첫째 자리 반올림 (자연수만 출력) 
-- 반올림 위치 0 : 소수점 첫째 자리 반올림 (자연수만 출력)
-- 반올림 위치 -1 : 자연수 첫째 자리 반올림 
-- 9-1. ROUND 함수 위치 별 반올림 조회 
SELECT ROUND(1234.5678) AS ROUND         -- 1235, 반올림 위치 생략, 소수점 첫째 자리 반올림
     , ROUND(1234.5678, 0) AS ROUND_0    -- 1235, 반올림 위치 0, 소수점 첫째 자리 반올림
     , ROUND(1234.5678, 1) AS ROUND_1    -- 1234.6, 반올림 위치 1, 소수점 둘째 자리 반올림
     , ROUND(1234.5678, 2) AS ROUND_2    -- 1234.57, 반올림 위치 2, 소수점 셋째 자리 반올림
     , ROUND(1234.5678, -1) AS "ROUND_-1"  -- 1230, 반올림 위치 -1, 자연수 첫째 자리 반올림
     , ROUND(1235.5678, -1) AS "ROUND_-1_2"  -- 1240, 반올림 위치 -1, 자연수 첫째 자리 반올림
     , ROUND(1234.5678, -2) AS "ROUND_-2"  -- 1200, 반올림 위치 -2, 자연수 둘째 자리 반올림
     , ROUND(1254.5678, -2) AS "ROUND_-2_2"  -- 1300, 반올림 위치 -2, 자연수 둘째 자리 반올림
  FROM dual; 
  
-- TRUNC : 지정한 숫자의 특정 위치에서 버림한 값을 반환
-- * 문법 : TRUNC(숫자, 버림위치)
-- 자릿수만 보고 나머지는 다 버림
-- 위치 생략시, 자연수만 남기고 소수점 전체 버림 
-- 버림 위치 0 : 자연수만 남기고 다 버림 
-- 버림 위치 -1 : 자연수 10의 자리 밑 버림 
-- 9-2. TRUNC 함수 위치 별 버림 조회 
SELECT TRUNC(1234.5678) AS TRUNC         -- 1234, 버림 위치 생략,자연수 밑으로 다 버림
     , TRUNC(1234.5678, 0) AS TRUNC_0    -- 1234, 버림 위치 0, 자연수 밑으로 다 버림
     , TRUNC(1234.5678, 1) AS TRUNC_1    -- 1234.5, 버림 위치 1, 소수 첫째 자리 밑으로 다 버림
     , TRUNC(1234.5678, 2) AS TRUNC_2    -- 1234.56, 버림 위치 2, 소수 둘째 자리 밑으로 다 버림
     , TRUNC(1234.5678, -1) AS "TRUNC_-1"  -- 1230, 버림 위치 -1, 자연수 10의 자리 밑으로 다 버림
     , TRUNC(1235.5678, -1) AS "TRUNC_-1_2"  -- 1230, 버림 위치 -1, 자연수 10의 자리 밑으로 다 버림
     , TRUNC(1234.5678, -2) AS "TRUNC_-2"  -- 1200, 버림 위치 -2, 자연수 100의 자리 밑으로 다 버림
     , TRUNC(1254.5678, -2) AS "TRUNC_-2_2"  -- 1200, 버림 위치 -2, 자연수 100의 자리 밑으로 다 버림
  FROM dual;  
  
-- CELL : 지정한 숫자와 가까운 큰 정수 반환 
-- FLOOR : 지정한 숫자와 가까운 작은 정수 반환 
-- 9-3. 원주율 (3.14)에 CELL/FLOOR 함수 적용해보기 
SELECT CEIL(3.14) "CEIL(3.14)"   -- 3와 4사이로 있다고 보고, 큰 양수인 4 반환 
     , FLOOR(3.14) "FLOOR(3.14)"  -- 3와 4사이로 있다고 보고, 작은 양수인 3 반환 
     , CEIL(-3.14) "CEIL(-3.14)"  -- -3와 -4사이로 있다고 보고, 큰 음수인 -3 반환 
     , FLOOR(-3.14) "FLOOR(-3.14)" -- -3와 -4사이로 있다고 보고, 큰 음수인 -4 반환 
  FROM dual; 
  
-- 9.4 MOD : 두 수를 나눈 나머지 값을 구하는 MOD 함수 
SELECT MOD(15, 6)  MOD_1  -- 15/6...3
     , MOD (10, 2) MOD_2  -- 10/2...0
     , MOD (11, 2) MOD_3  -- 11/2...1
  FROM dual; 

-- ///////////////////////////////////////////////
-- // 10. 날짜 함수 // 
-- 날짜 연산 
-- 날짜 형 데이터에 수를 더하면 (날짜 + 숫자), 해당 날짜로부터 기입한 수 만큼 지난 날짜를 계산한다. 날짜 형 데이터에 수를 빼면 (날짜 – 숫자), 해당 날짜로부터 기입한 수 만큼 이전 날짜를 계산한다. 
-- sysdate : 시스템에 저장된 `현재 날짜`를 반환하는 함수이다. 
-- 10-1. 날짜 연산 실습 
SELECT sysdate 오늘 
     , sysdate-1 어제
     , sysdate-2 그제
     , sysdate+1 내일
     , sysdate+2 모래
  FROM dual;  
  
-- // 날짜의 ROUND 반올림 함수, TRUNC 버림 함수 // 
-- 형식 : TRUNC(date, format), ROUND(date, format)
-- TRUNC => format이 'MONTH'인 경우, 현재 달을 기준으로 자른다, 현재 달의 1일 출력
-- ROUND => format이 'MONTH'인 경우, 현재 달의 일을 기준으로, 16일보다 작으면 현재 달의 1일/16일보다 크면 다음달 1일 출력

-- 10-2. 사원테이블에서 사원 ID, 입사일, T_입사일, R_입사일 조회 (월 기준)
-- '월'에 해당하는 '일'의 수만 버린다.(현재 달의 01일 조회)
-- '월'에 해당하는 '일'의 16일을 기준으로 달을 반올림한다. (현재 달 또는 다음 달의 01일 조회)
-- 정렬 : 입사일 오름차순 
SELECT employee_id "사원 ID"
     , hire_date 입사일
     , TRUNC(hire_date, 'MONTH') "T_입사일"   
     , ROUND(hire_date, 'MONTH') "R_입사일"  
  FROM employees
ORDER BY hire_date;
     
-- 10-3. 사원테이블에서 사원 ID, 입사일, T_입사일, R_입사일 조회 (년 기준)
-- '년'에 해당하는 '월'의 수만 버린다.(현재 년의 01월 01일 조회)
-- '년'에 해당하는 '월'의 07월을 기준으로 달을 반올림한다. (현재 년 또는 다음 년의 01월 01일 조회)
-- 정렬 : 입사일 오름차순 
SELECT employee_id "사원 ID"
     , hire_date 입사일
     , TRUNC(hire_date, 'YEAR') "T_입사일"   
     , ROUND(hire_date, 'YEAR') "R_입사일"  
  FROM employees
ORDER BY hire_date;

-- // MONTHS_BETWEEN 함수 //
-- : 두 날짜간의 개월수 차이를 구하는 함수

-- 10-4. MONTHS_BETWEEN 사용해 날짜 간의 개월 수 구하기 
-- * 문법 : MONTHS_BETWEEN(date1, date2)  // 소수점으로 반환
 SELECT sysdate 오늘 
       , MONTHS_BETWEEN(sysdate, '2025-05-12') 
             AS "(현재->수료) 개월-" -- 음수로 개월 수 조회
       , MONTHS_BETWEEN('2025-05-12', sysdate) 
             AS "(수료->현재) 개월+" -- 양수로 개월 수 조회            
   FROM dual; 
 
-- 10-5. MONTHS_BETWEEN 사용해 날짜 간의 개월 수 구하기 
-- * 문법 : ROUND(MONTHS_BETWEEN(date1, date2), 0) 
-- ROUND(MONTHS_BETWEEN, 0)을 통해 조회 값을 자연수로 반환
-- TO_DATE 사용하여, 문자형을 숫자형으로 변환 후 값을 연산한다. 
SELECT sysdate 오늘
     , ROUND(MONTHS_BETWEEN(sysdate, '2025-05-12'), 0) 
          AS "(현재->수료) 개월" -- 음수로 개월 수 조회
     , ROUND(MONTHS_BETWEEN('2025-05-12', sysdate), 0) 
          AS "(수료->현재) 개월" -- 양수로 개월 수 조회
     , ROUND(TO_DATE('2025-05-12') - sysdate) 
          AS "(수료->현재) 일수" -- 양수로 일수 조회
     , ROUND(TO_DATE('2025-05-12') - TO_DATE('2024-10-31'))
          AS "(수료->개강) 일수" -- 양수로 일수 조회
   FROM dual; 
   
-- 10.6 사원 테이블에서 사원 ID, 입사일, T_입사일, R_입사일, R_근무개월수, T_근무개월수를 구한다. 
-- MONTHS_BETWEEN : 현재 날짜와 입사일 간의 개월 수 구하기 
-- 입사일 오름차순 
SELECT employee_id "사원 ID"
     , hire_date 입사일 
     , ROUND(hire_date, 'MONTH') "R_입사일"  -- 16일을 기준으로 달을 반올림한다. 
     , TRUNC(hire_date, 'MONTH') "T_입사일"  -- 현재 달의 01일로 조회 (버림)
     , ROUND(MONTHS_BETWEEN(sysdate, hire_date), 0) AS "R_근무개월수" 
     , TRUNC(MONTHS_BETWEEN(sysdate, hire_date), 0) AS "T_근무개월수"
  FROM employees
 WHERE SUBSTR(hire_date, 1, 2) IN (01, 03)  -- hire_date 1~2번 요소 추출(01년도와 03년도) 
ORDER BY hire_date;

-- // ADD_MONTHS //
-- : N 개월 이후 날짜를 더하는 함수
-- * 문법 : ADD_MONTHS(날짜, 더할 개월 수) / ADD_MONTHS(date, number)
-- 10-7. 현재 날짜부터 3개월 이후의 날짜를 확인 
SELECT sysdate 오늘
     , ADD_MONTHS(sysdate, 3) "3개월 후"
  FROM dual; 
  
-- // 10-8. NEXT_DAY  //
-- : 돌아오는 요일의 날짜를 반환(해당 날짜를 기준으로 최초로 도래하는 요일에 해당되는 날짜 반환)
-- * 문법 : NEXT_DAY([날짜 데이터], [요일문자])
-- 요일 대신 숫자가 올 수 있다.  1:일요일, 2:월요일 3: 화요일 ....
SELECT sysdate 오늘_일요일
     , NEXT_DAY(sysdate, '일요일') "가장 가까운 일요일"  -- 오늘 일요일이라서 7일 뒤 반환
     , NEXT_DAY(sysdate, 2) "가장 가까운 월요일"  -- 오늘 일요일이라서 1일 뒤 반환
     , NEXT_DAY(sysdate, 3) "가장 가까운 화요일"  -- 오늘 일요일이라서 2일 뒤 반환
     , NEXT_DAY(sysdate, 6) "가장 가까운 금요일"  -- 오늘 금요일이라서 5일 뒤 반환
  FROM dual; 

-- // LAST_DAY //
-- : 달의 마지막 날 반환
-- * 문법 : LAST_DAY(날짜 데이터)
-- 10-9. 사원 테이블에서 사원ID, 입사일, 입사한 달의 마지막 날 조회 
SELECT employee_id 사원ID
     , hire_date 입사일
     , LAST_DAY(hire_date) "입사한 달_LAST"
  FROM employees
 WHERE SUBSTR(hire_date, 1, 2) IN (01, 03)
ORDER BY hire_date ASC;
 
-- ///////////////////////////////////////////////
  -- // 11. type casting(형변환 함수) //
-- TO_CHAR : (숫자형 또는 날짜형) -> 문자형 데이터로 변환
-- TO_DATE : 문자형 -> 날짜형 데이터로 변환
-- TO_NUMBER : 문자형 -> 숫자형 데이터로 변환

-- // TO_CHAR //
-- (숫자형 또는 날짜형)을 문자형으로 변환한다. 
-- *문법 : TO_CHAR(날짜데이터, '출력형식')
-- 11-1. 현재 '년', '월', '일'을 조회한다.
SELECT sysdate 오늘 
     , TO_CHAR(sysdate, 'YYYY/MM/DD DAY') "YYYY/MM/DD DAY"
     , TO_CHAR(sysdate, 'YY-MM-DD (DAY)') "YY-MM-DD (DAY)"
     , TO_CHAR(sysdate, 'YY/MM/DD DY') "YY-MM-DD DY"
     , TO_CHAR(sysdate, 'YY/MM/DD (DY)') "YY-MM-DD (DY)"
  FROM dual;

-- // 시간 표현 //
-- AM : 오라클의 설정에 따라 AM, PM으로 반환 
-- 12시간 -> HH:MI:SS    |    24시간 -> HH24:MI:SS
-- 11-2. 현재 날짜와 현재 시각을 조회한다.
SELECT sysdate 오늘 
     , TO_CHAR(sysdate, 'YYYY/MM/DD(DY) HH:MI:SS') AS "현재 날짜/시분초"
     , TO_CHAR(sysdate, 'YYYY/MM/DD(DY) HH:MI:SS AM') AS "현재 날짜/시분초 AM"
  FROM dual;

-- // 통화 기호로 숫자 데이터 -> 문자형으로 변환 //
-- L : 각 지역별 통화 기호를 자동으로 슷지 데이터 앞에 표시 예)한국: ￦   
-- 도구-환경설정 -> 검색(돋보기) -> NLS 창에 통화 : ￦으로 설정되어 있음
-- 특수문자 : ㄹ+한자키 
-- shift + 4 : $
-- , : 천단위 자리 구분을 표시(000,000,000)
-- . : 소수점을 표시
-- 9 : 자릿수를 나타내며, 자릿수가 맞지 않아도 0으로 채우지 않는다.
-- 0 : 자릿수를 나타내며, 자릿수가 맞지 않을 경우 나머지 공간을 0으로 채운다.

-- 11-3. salary (급여)를 지역별 통화 기호로 조회
SELECT employee_id 사원ID
     , salary 급여
     , TO_CHAR(salary, 'L9,999,999') "L9" 
     , TO_CHAR(salary, 'L0,009,999') "L0" 
     , TO_CHAR(salary, '$9,999,999.99') "$9" 
     , TO_CHAR(salary, '$0,009,999') "$0"
  FROM employees
 WHERE salary>10000;
  
-- //  TO_DATE //
-- 문자형을 날짜형 데이터로 변환한다. 
-- *문법 : TO_DATE('문자', '날짜 format')
-- 11-4. 입사일이 03/06/17인 사원의 사번, 입사일 조회 (오류 발생)
SELECT employee_id 사원ID
     , hire_date 입사일 
     , TO_CHAR(hire_date, 'MM-DD(DY)') "TO_CHAR 입사일"
  FROM employees
 WHERE hire_date = TO_DATE('03/06/17', 'MM/DD');  -- 에러 발생 : 문자와 format 형식이 다름

-- 11-5. 입사일이 03/06/17인 사원의 사번, 입사일 조회
SELECT employee_id 사원ID
     , hire_date 입사일 
     , TO_CHAR(hire_date, 'MM-DD(DY)') "TO_CHAR 입사일"
  FROM employees
 WHERE hire_date = TO_DATE('030617', 'YY/MM/DD'); -- 문자와 format 형식이 같음
    
-- 11-6. dual 테이블에서 2024-11-24일을 TO_DATE로 조회
SELECT TO_DATE('2024-11-24', 'YYYY-MM-DD') "YYYY-MM-DD"
     , TO_DATE('20241124', 'YYYY/MM/DD') "YYYY/MM/DD"
  FROM dual;
  
-- // TO_NUMBER // 
-- 문자형을 숫자형 데이터로 변환한다. 
-- 11-7. 문자열은 산술 (문자열끼리는 산술 불가, 오류 발생)
SELECT '100,000' - '50,000'
  FROM dual;  -- 오류 : 
  
-- 11-8. 문자형을 숫자형으로 바꾼 후, 연산
-- *문법 : TO_NUMBER('문자', '숫자형 format(999,999')
SELECT TO_NUMBER('100,000','999,999')
     - TO_NUMBER('50,000','99,999') "숫자형 변환 후 연산"
FROM dual; 

-- ///////////////////////////////////////////////
--  // 12. NULL 함수 //
-- NULL : 미확정, 값이 정해져있지 않아 알수없는 값을 의미하며, 연산, 대입, 비교가 불가능하다.
--        연산시 관계 컬럼값도 null로 바뀐다.

-- // NVL// 
-- : 값이 NULL일 경우 연산, 대입, 비교가 불가능하므로 NVL을 이용해 대체
--        NULL을 0 또는 다른 값으로 변환한다.
-- * 문법 : NVL(컬럼값, 초기값)

-- 12-1. 사원테이블의 last_name, salary,  salary*12-(salary*12)*commission_pct 연봉, 
-- commission_pct, salary >= 10000   
-- NULL 제거 전 
SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*commission_pct  연봉  -- 값이 null이면 비교, 연산, 할당 불가
     , commission_pct 수수료
  FROM employees
 WHERE salary>=10000;
 
-- NVL : NULL을 0으로 대체
SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*NVL(commission_pct, 0)  연봉  -- NULL을 0으로 대체 
     , NVL(commission_pct, 0) 수수료
  FROM employees
 WHERE salary>=10000;
 
-- 12-2. LOCATIONS 테이블에서 location_id, city, state_province 조회
-- (단 state_province가 null이 아닌 경우 조회, null 값을 제외한 데이터만 조회)
SELECT location_id  "위치 ID" 
     , city "도시명"
     , state_province "주/도"
FROM locations
WHERE state_province IS NOT NULL;

-- 12-3. LOCATIONS 테이블에서 location_id, city, state_province 조회
--       state_province가 null일 경우, '주(미정)'로 변환한다. 
SELECT location_id "위치 ID" 
     , city "도시명"
     , NVL(state_province, '주(미정)') "NVL(주/도)"
FROM locations; 

-- //  NVL2 함수  //
-- NULL이 아닐 때와 NULL일 때 반환값 각각 지정
-- NVL2(컬럼값, NULL이 아닌 데이터를 다른값으로 변환한 값, NULL 데이터를 다른값으로 변환한 값)

-- 12-4. 사원테이블의 last_name, salary,  salary*12-(salary*12)*commission_pct 연봉, 
-- commission_pct, salary >= 10000
-- NVL2를 사용해 NULL 값을 0으로 변환하고, NULL이 아닌 값은 0.1로 데이터를 변환한다. 
-- 모든 사원의 수수료를 동일한 값으로 줄 수 있다. 
 SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*NVL(commission_pct, 0)  연봉_NVL  -- NULL을 0으로 대체 
     , salary*12-(salary*12)*NVL2(commission_pct, 0.1, 0)  연봉_NVL2  -- NULL을 0으로 대체, NULL 아닌 값 0.1로 변경
     , NVL(commission_pct, 0) NVL_수수료
     , NVL2(commission_pct, 0.1, 0) NVL2_수수료
  FROM employees
 WHERE salary>=10000;

-- //  NULLIF 함수  //
-- * 문법 : NULLIF (표현식1, 표현식2)
-- : 두 표현식을 비교하여 동일하면 null을 반환하고, 동일하지 않으면 표현식1을 반환

-- 12-5. NULLIF 함수를 사용하여, 두 표현식의 값을 비교한다. 
SELECT NULLIF('SQL', 'SQL') SAME -- null
     , NULLIF('ORACLE', 'SQL') DIFFERENT -- ORACLE
  FROM dual;

-- ///////////////////////////////////////////////
-- // 13. COALESCE 함수 //
-- : COALESCE의 () 로 감싼 안의 인자들을 첫번째자리부터 비교를 하며, 
--   NULL을 만나면 다음 자릿수로 미룬다.
-- * 문법 : COALESCE(표현식1, 표현식2,..표현식n)

-- 13.1 COALESCE () 안에 값을 다양하게 두고, 값을 조회한다. 
-- 첫 번째 인자가 NULL이므로 두 번째 인자 값인 1이 반환된다. 
SELECT COALESCE(NULL, 1, 2) "NULL, 1, 2"
  FROM dual;

-- 첫 번째와 두 번째 인자가 NULL이므로, 세 번째 인자 값인 2가 반환된다. 
SELECT COALESCE(NULL, NULL, 2) "NULL, NULL, 2"
  FROM dual;

-- 첫 번째 인자가 NULL이 아니므로 1이 반환된다.   
SELECT COALESCE(1, 2, NULL) "1, 2, NULL"
  FROM dual;
  
-- ///////////////////////////////////////////////
-- // 14. DECODE & CASE 함수 //

-- // DECODE //
-- : 자바의 Switch Case문과 동일한 기능을 한다. 
--   조건에 따라 데이터를 다른 값이나 컬럼 값으로 추출할 수 있다. 
-- * 문법 : DECODE(VALUE, COND1, THEN1, COND2, THEN2, ...) 형태로 사용
--          VALUE == COND1 일 경우 THEN1 반환, VALUE == COND2 일 경우 THEN2 반환

-- 14-1. 사원 ID, 이름, job_id, salary, 급여 수당 출력(단 decode를 이용해 수당 출력)
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id  "직무 ID"
     , salary 급여
     , DECODE(job_id  -- 조건이 적용되는 컬럼 
            , 'AD_PRES', salary*1.1    -- 조건1, 결과 1
            , 'AD_VP', salary*1.2      -- 조건2, 결과 2
            , 'IT_PROG', salary*1.3    -- 조건3, 결과 3
            , 'FI_MGR', salary*1.4     -- 조건4, 결과 4
            , salary*1.5) AS 수당     -- 조건외 나머지(생략), 결과 5
  FROM employees;

-- // CASE문  //
-- : 자바의 if else문과 동일
--   조건에 따라 데이터를 다른 값이나 컬럼 값으로 추출할 수 있다. 
-- DECODE가 제공하지 못하는 비교 연산의 단점을 해결 할 수 있다.
-- CASE는 SQL과 PL/SQL에서 모두 사용 가능 하지만, DECODE는 SQL에서만 사용 가능
 
-- 14-2. 사원 ID, 이름, job_id, salary, 급여 수당 출력 (단 case를 이용해 수당 출력)
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id  "직무 ID"
     , salary 급여
     , CASE job_id  -- 조건이 적용되는 컬럼 
            WHEN 'AD_PRES' THEN salary*1.1    -- WHEN 조건1 THEN 결과 1
            WHEN 'AD_VP' THEN salary*1.2      -- WHEN 조건2 THEN 결과 2
            WHEN 'IT_PROG' THEN salary*1.3    -- WHEN 조건3 THEN 결과 3
            WHEN 'FI_MGR' THEN salary*1.4     -- WHEN 조건4 THEN 결과 4
            ELSE salary*1.5                   -- ELSE 결과 5
       END AS 수당
 FROM employees;
 
-- 14.3 사원 ID, 이름, job_id, salary, commission_pct, case문을 이용해 comm_text 출력 
-- comm_text : commission_pct가 null이면 '해당사항 없음'
--                                 0이면 '수수료 없음'
--                                 0보다 크면 연봉 출력 => '연봉 : ' 
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id  "직무 ID"
     , salary 급여
     , commission_pct 수수료
     , CASE 
            WHEN commission_pct IS NULL THEN '해당사항 없음'
            WHEN commission_pct=0 THEN '수수료 없음'
            WHEN commission_pct>0 THEN '연봉 : ' 
            || TO_CHAR(salary*12 - (salary*12)*commission_pct)
       END AS 연봉
 FROM employees;
 
-- 14-4. 사원테이블의 부서ID가 10~60인 경우 부서ID와 '부서명' 조회. 그 외는 '부서미정'으로 출력
-- 정렬 : 부서 ID(오름차순)
-- 조건 : 단 부서ID는 중복되지 않아야 하며, 부서ID가 null이면 출력안되게 
SELECT department_id "부서 ID"
     , department_name 부서명
     , CASE department_id
            WHEN 10 THEN 'Administration'
            WHEN 20 THEN 'Marketing'
            WHEN 30 THEN 'Purchasing'
            WHEN 40 THEN 'Human Resources'
            WHEN 50 THEN 'Shipping'
            WHEN 60 THEN 'IT'            
            ELSE '부서미정 '
       END AS "부서 정보"
  FROM departments
 WHERE department_id IS NOT NULL
ORDER BY department_id;
