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
 