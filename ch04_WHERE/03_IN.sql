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