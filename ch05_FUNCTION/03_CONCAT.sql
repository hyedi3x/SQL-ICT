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