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
