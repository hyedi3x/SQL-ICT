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
   