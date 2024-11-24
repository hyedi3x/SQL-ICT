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
