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
 