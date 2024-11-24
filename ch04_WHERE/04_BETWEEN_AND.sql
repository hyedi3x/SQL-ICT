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
