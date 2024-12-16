-- ////////////////////  CH06  //////////////////// 
-- // 1. 그룹함수 //
-- 테이블의 전체 데이터에서 `통계적인 결과`를 구하기 위해서 행 집합에 적용하여 [하나의 결과를 생산]한다. 
-- 하나 이상의 행을 그룹으로 묶어 연산하여 하나의 결과를 구한다.
-- 여러 로우 데이터를 가지고 한 번에 처리하여 결과값 1건을 반환하는 함수이다.
-- 결과값을 1건으로 만들기 때문에 복수행 함수 또는 집계 함수라고도 표현한다. 
-- 그룹 함수는 일반적으로 NULL값을 제외하여 처리한다. 
-- 그룹 함수는 WHERE 절에 사용할 수 없다. 

-- //  SUM : 그룹의 누적 합계를 반환 하는 함수 //
-- 1-1. 사원 테이블에서 salary 컬럼의 데이터 전체를 합하여 조회한다. 
SELECT SUM(salary) AS "급여 총액"
  FROM employees;
  
-- // AVG : 그룹의 평균을 반환하는 함수 //
-- 1-2. 사원 테이블의 salary 컬럼의 데이터의 전체를 평균하여 조회한다. 
SELECT AVG(salary) "급여 평균"
  FROM employees;
    
-- 1-3. 사원 테이블에서 salary 컬럼의 평균을 조회한다. 
-- 조건 
-- 1. 소수점 셋째 자리에서 반올림하여 조회한다. (소수점 둘째 자리까지 조회)
-- 2. 소수점 첫째 자리에서 반올림하여 조회한다. (자연수로 조회) 
SELECT ROUND(AVG(salary), 2) AS "급여 평균_소수점2"
     , ROUND(AVG(salary), 0) AS "급여 평균_자연수"
  FROM employees;

-- // MAX, MIN //
-- : 그룹의 최대값과 최소값을 반환하는 함수
-- 1-4. 사원 테이블에서 salary 컬럼의 데이터 중 최대급여와 최소급여를 조회한다. 
SELECT MAX(salary) "최대급여"
     , MIN(salary) "최소급여"
  FROM employees;

-- 1-5. 사원 테이블에서 hire_date 컬럼의 데이터 중 최근 입사일과 가장 오래된 입사일을 조회한다. 
SELECT MAX(hire_date) "최근 입사일"
     , MIN(hire_date) "가장 오래된 입사일"
  FROM employees;
  
-- //  COUNT(*)// 
-- : 전체행(=row) 갯수를 반환하는 함수
-- COUNT(*) : NULL값, 중복된 데이터를 포함하여 선택된 컬럼의 모든 행을 카운트한 갯수 반환
-- COUNT(컬럼명) : 컬럼의 값이 NULL이 아닐때의 행의 갯수, 중복된 행 포함

-- 1-6. 사원테이블에서 사원 수 전체를 조회한다.  (COUNT(*))
SELECT COUNT(*) "사원 수"
  FROM employees;

-- 1-7. commission 컬럼의 데이터 값이 NULL이 아닌 행의 갯수를 조회. COUNT(commission_pct)
-- 조건 : commission_pct IS NOT NULL
SELECT COUNT(commission_pct)||'명' "수수료 받은 인원 수"
  FROM employees
 WHERE commission_pct IS NOT NULL;
 
-- 1-8. commission 컬럼의 데이터 값이 NULL이 아닌 행의 갯수를 조회. COUNT(commission_pct)
-- 조건 : commission_pct NOT NULL 처리 안해보기 
SELECT COUNT(commission_pct)||'명' "수수료 받은 인원 수 "
  FROM employees;
 
-- 1-9. 부서 테이블에서 부서 ID 값이 NULL이 아닌 행의 개수를 조회한다. 
SELECT COUNT(department_id)||'개'  "부서 수"
FROM departments;

-- 1-10. 사원 테이블의 부서 ID 값이 NULL이 아닌 행의 개수를 조회한다. 
-- 사원 테이블에서 조회하기 때문에 총 사원 컬럼의 데이터가 PK이므로, 
-- 사원 컬럼 속 부서 ID 값이 중복되어 조회된다. NULL이 제외된 총 사원 수와 동일하게 나온다. 
-- 106개의 부서가 존재한다고 보인다. 
SELECT COUNT(department_id)||'개'  "사원 테이블의 부서 수"
  FROM employees;

-- 1-11. 사원 테이블에서 부서 ID 값이 중복되지 않게 조회한다. 
-- DISTINCT 사용 (중복 제거)
SELECT COUNT(DISTINCT department_id) ||'개' "사원테이블 부서 수"
  FROM employees;
 
-- 1-12. 사원 테이블에서 최대 급여, 최소 급여, 급여 총액, 급여 평균(둘째자리), 사원 수를 조회.
SELECT MAX(salary) "최대 급여"
     , MIN(salary) "최소 급여"
     , SUM(salary) "급여 총액"
     , ROUND(AVG(salary), 2) "급여평균_소수2"
     , COUNT(*) "사원 수"
  FROM employees;

-- /////////////////////////////////////////////////// 
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

-- /////////////////////////////////////////////////// 
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