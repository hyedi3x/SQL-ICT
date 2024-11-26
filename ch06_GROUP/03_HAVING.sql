-- // 3. 그룹 함수 제한 함수 : HAVING절 // 
-- : 표시할 그룹을 지정하여 집계정보를 기준으로 Filtering
-- 그룹함수는 WHERE 절에 작성이 불가하다. WHERE 절은 일반 컬럼에 대한 조건식만 가능하다. 
-- HAVING 함수를 통해, 그룹 함수에 대한 조건식을 사용할 수 있다. 

-- 문법 : 
--      SELECT 컬럼1,..컬럼n, 그룹함수
--        FROM 테이블명
--       WHERE 조건
--      GROUP BY 컬럼1,..컬럼n
--        HAVING 그룹함수 조건절
--      ORDER BY 컬럼명 ASC | DESC;

-- 3.1 부서 테이블에서 부서별 최대급여, 총급여 조회
-- 조건 : 
-- 1. 총급여(그룹함수)가 15000 이상 - (WHERE 절에 그룹함수 조건절 작성해보기)
-- 2. 부서코드 오름차순 정렬
-- 3. 부서코드가 없으면 제외
-- WHERE에 그룹 함수 조건절을 수행하려고 할 때
-- ORA-00934: group function is not allowed here
-- https://docs.oracle.com/error-help/db/ora-00934/00934. 00000
-- "group function is not allowed here"
SELECT department_id "부서 ID"
     , job_id "직무 ID"
     , COUNT(*) "총 인원수"
     , ROUND(AVG(salary), 2) "급여 평균"
     , MAX(salary) "최대 급여"
  FROM employees
 WHERE department_id IS NOT NULL 
   AND MAX(salary)>=10000  -- 오류 발생 (그룹함수는 WHERE 절에서 조건식 불가)
GROUP BY department_id, job_id  -- 부서별, 직무별로 그룹화
ORDER BY department_id, job_id;

-- 3.2 부서테이블에서 부서별 최대급여, 총급여 조회
-- 조건 : 
-- 1. 총급여(그룹함수)가 15000 이상 (HAVING 위치에 조건 넣기)
-- 2. 부서코드 오름차순 정렬
-- 3. 부서코드가 없으면 제외
SELECT department_id "부서 ID"
     , job_id "직무 ID"
     , COUNT(*) "총 인원수"
     , ROUND(AVG(salary), 2) "급여 평균"
     , MAX(salary) "최대 급여"
  FROM employees
 WHERE department_id IS NOT NULL 
GROUP BY department_id, job_id  -- 부서별, 직무별로 그룹화
  HAVING MAX(salary) >=10000 
ORDER BY department_id ASC, job_id ASC;

-- 3.3 사원 테이블에서 직무별 총급여와 평균급여 조회
-- 조건 
-- 1. 평균급여가 5000 이상
-- 2. 소수점 이하는 무조건 절삭(TRUNC)한다.
-- 3. 직무(job_id) 오름차순 정렬
-- 4. job_id가 'IT' 문자열을 포함할 때 조회가 안되도록 한다. 
SELECT job_id
     , TRUNC(SUM(salary)) "총 평균"
     , TRUNC(AVG(salary)) "평균 급여"
     , MAX(salary) "최대 급여"
  FROM employees
  WHERE job_id NOT LIKE '%IT%' 
GROUP BY job_id  -- 직무별로 그룹화
  HAVING AVG(salary)>=5000 
ORDER BY job_id ASC;
