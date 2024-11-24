-- /////////////////////////////////////////////

-- // 1. 비교 연산자 // 
-- 1-1. 사원테이블에서 사원ID, 입사일, 급여, 부서ID 조회
-- 조건 : 급여는 15000이상
-- 정렬 : 부서ID (오름차순), 급여 (내림차순)
SELECT employee_id AS "사원 ID"
     , hire_date AS 입사일
     , salary AS 급여
     , department_id AS "부서 ID"
  FROM employees
 WHERE salary>=15000
ORDER BY department_id ASC, salary DESC;

-- 1-2. 부서 테이블에서 부서ID, 부서명, 매니저ID 조회 
-- 조건 : 부서ID가 50번 미만일 때
SELECT department_id  "부서 ID"
     , department_name 부서명
     , manager_id  "관리자 ID"
  FROM departments
 WHERE department_id<50;

-- /////////////////////////////////////////////////////////
-- // 2. AND, OR 논리 연산자 // 
-- 2-1. 사원 테이블에서 사원ID, last_name, job_id, salary 조회 
-- 조건 : salary가 15000이상 이면서, 사원ID가 150이상이고, last_name이 Ozer인 사원 
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id "직무 ID"
     , salary 급여
  FROM employees
 WHERE salary>= 10000 AND employee_id >= 150 AND last_name = 'Ozer';
 
-- 2-2. 사원테이블에서 사원ID, salary 조회
-- 조건 : salary가 10000이상 11000이하인 
-- 정렬 : salary(오름차순) 
SELECT employee_id "사원 ID"
     , salary 급여
  FROM employees
 WHERE salary >= 10000 AND salary <= 11000 
ORDER BY salary ASC;
 
-- 2-3. 사원 테이블의 사원ID, 이메일, 급여, 부서 ID, 입사일 조회
-- 조건 : 부서 ID가 60이거나, 100일 때
SELECT employee_id "사원 ID"
     , email 이메일
     , salary 급여
     , department_id "부서 ID"
     , hire_date 입사일
  FROM employees
 WHERE department_id = 60 OR department_id = 100;
 
-- 2-4. 사원테이블에서 사원ID, last_name, 입사일 조회
-- 조건 : last_name이 King이거나 입사일이 05/07/16인 
SELECT employee_id "사원 ID"
     , last_name 이름
     , hire_date 입사일
  FROM employees
 WHERE last_name = 'King' OR hire_date = '05/07/16';
   
-- /////////////////////////////////////////////////////////
-- // 3. IN 연산자 //
-- : 특정 컬럼의 값이 A,B,C 중에 하나라도 일치하면 참이 되는 연산자이다. => 중요
-- * 문법 : 컬럼값 IN(A,B,C)  

-- 3-1. 사원테이블에서 사원ID, last_name, 부서ID로 조회
-- 조건 : 부서ID가 70,90,100인
-- 정렬 : 부서ID (오름차순)
SELECT employee_id  "사원 ID" 
     , last_name 이름
     , department_id "부서 ID"
  FROM employees
 WHERE department_id IN (70, 90, 100)
ORDER BY department_id ASC;   

-- // NOT IN 연산자 //
-- : 대상의 목록과 일치하는 데이터를 제외한 값들을 반환
-- * 문법 : 컬럼값 NOT IN(A,B,C)  

-- 3-2. 사원테이블에서 사원ID, last_name, 부서ID로 조회
-- 조건 : 부서ID가 50, 70, 80, 90, 100가 아닌 (NOT IN)
-- 정렬 : 부서ID (오름차순)
SELECT employee_id  "사원 ID" 
     , last_name 이름
     , department_id "부서 ID"
  FROM employees
 WHERE department_id NOT IN (50, 70, 80, 90, 100)
ORDER BY department_id ASC;   

-- ///////////////////////////////////////////////
-- // 4. BETWEEN A AND B 연산자 => 중요 //
-- * 문법 : WHERE 컬럼명 BETWEEN 최소값 AND 최대값; 

-- 4-1. 사원테이블에서 사원ID, salary 조회
-- 조건 : salary가 10000이상 11000이하
-- 정렬 : salary (오름차순)
SELECT employee_id "사원 ID"
     , salary 급여
  FROM employees
 WHERE salary BETWEEN 10000 AND 11000 
ORDER BY salary ASC;

-- 4-2. 사원테이블에서 사원ID, 입사일 조회
-- 조건 : 입사일 (04/12/31 ~ 05/01/30)
-- 정렬 : 입사일 (오름차순)
SELECT employee_id "사원 ID"
     , hire_date 입사일
  FROM employees
 WHERE hire_date BETWEEN '04/12/31' AND '05/01/30'
ORDER BY hire_date ASC;

-- /////////////////////////////////////
-- // 5. LIKE 연산자와 와일드 카드 => 중요
-- * 문법 : 컬럼명 LIKE Pattern
-- 와일드 카드 :
-- % => 길이와 상관없이 모든 문자데이터를 의미
-- _ => 어떤 값이든 상관없이 한개의 문자데이터를 의미

-- 5-1. 사원테이블에서 사원 ID, last_name 조회
-- 조건 : last_name의 3번째, 4번째 단어가 'tt'
-- 정렬 : 사원 ID (오름차순) 
SELECT employee_id "사원 ID"
     , last_name 이름
  FROM employees
 WHERE last_name LIKE '__tt%'
ORDER BY employee_id ASC;

-- 5-2. 사원 테이블에서 사원 ID, email 조회
-- 조건 : email에 'JONES'가 포함
-- 정렬 : 사원 ID (오름차순) 
SELECT employee_id "사원 ID"
     , email 이메일
  FROM employees
 WHERE email LIKE '%JONES%'
ORDER BY employee_id ASC;

-- 5-3. JOBS 테이블에서 job_id 조회
-- 조건 : job_id에 'REP' 포함
SELECT job_id "직무 ID"
  FROM jobs
 WHERE job_id LIKE '%REP%';

-- 5-4. JOBS 테이블에서 job_id 조회
-- 조건 : job_id에 'REP' 포함하지 않는다. 
SELECT job_id "직무 ID"
  FROM jobs
 WHERE job_id NOT LIKE '%REP%';
 
-- ///////////////////////////////////////////////////////
-- // 6. NULL : 미확정, 값이 정해져 있지 않아 알수 없는 값을 의미하며,
--       연산불가, 비교불가, 대입불가
--       연산 시 관계 컬럼값도 null로 바뀐다.
--       ex) 커미션이 null이면 연봉도 null
-- * 문법 : 컬럼명 IS NULL, 컬럼명 IS NOT NULL

-- Primary Key 
-- 1. Unique (데이터가 중복되지 않아야 한다.) 
-- 2. NOT NULL (필수) 

-- 6-1. 사원테이블에서 부서ID 조회 (IS NULL)
-- 조건 : 부서ID가 null인 모든 행
-- 정렬 : 부서ID(오름차순) 
SELECT *
  FROM employees
 WHERE department_id IS NULL
 ORDER BY department_id ASC;

-- 6-2. 사원테이블에서 부서ID 조회 (IS NOT NULL)
-- 조건 : 부서ID가 null이 아닌 모든 행
-- 정렬 : 부서ID(오름차순) 
SELECT *
  FROM employees
 WHERE department_id IS NOT NULL
 ORDER BY department_id ASC;

-- 6-3. 사원테이블의 employee_id, last_name, salary, salary*12+commission_pct AS 연봉, commission_pct 조회
-- 조건 : salary >= 10000, commission_pct이 null가 아닐 때
SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*commission_pct  연봉
     , commission_pct 수수료
  FROM employees
 WHERE salary>=10000 AND commission_pct IS NOT NULL;
 
-- ////////////////////////////////////////////
-- // 7. 집합 연산자  //
-- 합집합, 교집합, 차집합은 테이블간에 컬럼의 갯수와 자료형이 일치해야 한다. 
-- 테이블명은 달라도 무관

-- // UNION(합집합)
--: 중복제거 후 합집합 / UNION ALL 중복허용 후 합집합 
-- ORDER BY는 문장의 맨끝

-- UNION : 중복 제거후 합집합
-- 7-1. 30번부서의 사원 ID, 이름, 급여, 부서ID
SELECT employee_id 
     , last_name
     , salary 
     , department_id
  FROM employees
 WHERE department_id = 30
 UNION 
SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees
 WHERE department_id = 30
ORDER BY employee_id ASC;  -- 정렬은 문장의 맨 끝에 위치  

-- UNION ALL : 중복허용 합집합 
-- 7-2. 30번부서의 사원 ID, 이름, 급여, 부서ID
SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees
 WHERE department_id = 30
 UNION ALL 
SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees
 WHERE department_id = 30
ORDER BY employee_id ASC;  -- 문장의 맨 끝에 위치  

-- 차집합 : MINUS(EXCEPT) 
-- 7-3. 50번을 제외한 부서의 사원 ID, 이름, 급여, 부서 ID 
-- 전체 사원 정보 MINUS 50번 부서의 사원 정보 
SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees -- 조건이 없으므로 전체 사원의 정보 조회
MINUS 
SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees
 WHERE department_id = 50
ORDER bY department_id ASC;
 
-- 교집합(INTERSECT)
-- 7-4. department_id 30번과 겹치는 부서의 사원 ID, 이름, 급여, 부서 ID 
-- 전체 사원 정보 INTERSECT 30번 부서의 사원 정보 
 SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees -- 조건이 없으므로 전체 사원의 정보 조회
INTERSECT 
SELECT employee_id
     , last_name
     , salary 
     , department_id
  FROM employees
 WHERE department_id = 30
ORDER bY department_id ASC;
 