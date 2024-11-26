-- // 2. GROUP BY  //
-- : 특정 컬럼을 기준으로 그룹별로 나눌때 사용
-- SELCECT(일반 컬럼, 그룹함수)가 있다면, 
-- SELECT 리스트의 모든 일반 컬럼은 GROUP BY 절에 반드시 기술해야 한다.(중요)
-- 반대로, GROUP BY 절에 기술된 컬럼이 반드시 SELECT 리스트에 있어야 하는 것은 아니다. 
-- GROUP BY절 다음에 컬럼의 별칭은 사용할 수 없다.

-- 문법 : 
--      SELECT 컬럼1,..컬럼n, 그룹함수
--        FROM 테이블명
--       WHERE 조건
--      GROUP BY 컬럼1,..컬럼n
--      ORDER BY 컬럼명 ASC | DESC;
 
-- 2-1. 사원 테이블에서 부서 ID(일반 컬럼), 부서별 평균 급여(그룹함수)를 조회한다. 
-- 그룹 함수 조회 시, 싱글 함수를 사용할 수 없다. 
-- SQL Error : ORA-00937: not a single-group group function => 그룹화해주어야 한다.  
SELECT department_id "부서 ID"
     , AVG(salary) "평균 급여"
  FROM employees;

-- 2-2. 사원테이블에서 부서 ID(일반 컬럼), 부서별 평균급여(그룹함수)를 조회한다.
-- 조건 : 
--      1. GROUP BY에 일반 컬럼을 기술하고 그룹으로 묶어준다. (department_id)
--      2. 평균 급여를 소수 둘째 자리까지 표현한다. (소수 셋째 자리에서 반올림) 
--      3. 부서 ID로 오름차순 정렬한다. 
SELECT department_id 
     , ROUND(AVG(salary), 2) "평균 급여"
  FROM employees
GROUP BY department_id  -- 부서별로 그룹화, 별칭 사용 불가
ORDER BY department_id ASC;

-- 2-3. 사원테이블에서 부서 ID(일반 컬럼), 직무 ID(일반 컬럼), 부서별 최대 급여(그룹함수)를 조회.
-- 조건 : 
--      1. GROUP BY에 일반 컬럼을 기술하고 그룹으로 묶어준다. (department_id, job_id)
--      2. 최대 급여를 소수 둘째자리까지 표현한다. (소수 셋째자리에서 반올림) 
--      3. 부서 ID로 오름차순 정렬한다. 
-- 직무의 중복제거 된 수가 20개이므로, 부서의 수가 일부 중복된 행이 포함되서 조회된다. 
SELECT department_id "부서 ID"
     , job_id "직무 ID"
     , ROUND(AVG(salary), 2) "평균 급여"
  FROM employees
GROUP BY department_id, job_id  -- 부서별, 직무별로 그룹화
ORDER BY department_id ASC;

-- 2-4. 사원 테이블에서 부서 ID(일반 컬럼), 직무 ID(일반 컬럼), 부서별 최대 급여(그룹함수)를 조회.
-- 조건 : 
--      1. GROUP BY에 일반 컬럼을 기술하고 그룹으로 묶어준다. (department_id, job_id)
--      2. 최대 급여를 소수 둘째자리까지 표현한다. (소수 셋째자리에서 반올림) 
--      3. 부서 ID로 오름차순 정렬한다. 
--      4. department_id NULL 값을 제거한다.  
-- 직무의 중복제거 된 수가 20개이므로, 부서의 수가 일부 중복된 행이 포함되서 조회된다. 
SELECT DECODE (department_id
            ,  NULL, '부서 미발령'
            , department_id) "부서 ID"
     , job_id "직무 ID"
     , ROUND(AVG(salary), 2) "평균 급여"
  FROM employees
GROUP BY department_id, job_id  -- 부서별, 직무별로 그룹화
ORDER BY department_id ASC;

-- 2.5 직무별 총 급여, 최대 급여/최소 급여 구하기, 직무ID로 정렬 
SELECT job_id "직무 ID"
     , SUM(salary) "총 급여"
     , ROUND(MAX(salary), 2) "최대 급여"
     , ROUND(MIN(salary), 2) "최소 급여"
  FROM employees
GROUP BY job_id  -- 직무별로 그룹화 
ORDER BY job_id ASC;

-- 2.6 부서(department_id)별, 직무(job_id)별 인원수, 급여평균, 최대급여 구하기
-- 조건 : 부서, 직무 오름차순 정렬(단 부서는 NULL 값 허용안함)
SELECT department_id "부서 ID"
     , job_id "직무 ID"
     , COUNT(*) "인원수"
     , ROUND(AVG(salary), 2) "급여 평균"
     , MAX(salary) "최대 급여"
  FROM employees
 WHERE department_id IS NOT NULL
GROUP BY department_id, job_id  -- 부서별, 직무별로 그룹화
ORDER BY department_id ASC, job_id ASC;
