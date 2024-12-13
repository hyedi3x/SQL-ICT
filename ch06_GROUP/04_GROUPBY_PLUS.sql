-- // 4. 그룹함수 심화 //
-- ROLLUP, CUBE, GROUPING SETS 함수 => GROUP BY 절에 지정할 수 있는 특수함수이다.
    
-- [ROLLUP 형식]
-- ROLLUP 함수는 명시한 열에 대해 소그룹별 결과를 출력하고, 마지막에 최종결과를 출력한다.
-- ROLLUP 함수에 명시한 열에 한하여 결과가 출력되며, ROLLUP 함수에는 그룹함수를 지정할 수 없다.
-- SELECT 컬럼1, 컬럼2, 그룹함수...
--   FROM 테이블명
--  WHERE절
--  GROUP BY ROLLUP(그룹화할 컬럼1, 컬럼2 ..);

-- [CUBE 형식] 
-- ROLLUP 결과와 동일하게 출력되며, 그 아래에 부서와 상관없이 직책별 결과가 함께 출력된다.
-- CUBE 함수는 지정한 모든 열에서 가능한 조합의 결과를 모두 출력한다.
-- SELECT 컬럼1, 컬럼2, 그룹함수...
--   FROM 테이블명
--  WHERE절
--  GROUP BY CUBE(그룹화할 컬럼1, 컬럼2 ..);

-- [GROUPING SETS 형식] 
-- GROUPING SETS 함수를 사용하여 컬럼별로 그룹으로 묶어 출력하기
-- 지정한 모든 열을 각각 대그룹으로 처리하여 출력
-- CUBE와 같으나 소계가 없음
-- SELECT 컬럼1, 컬럼2, 그룹함수...
--   FROM 테이블명
--  WHERE절
--  GROUP BY GROUPING SETS(그룹화할 컬럼1, 컬럼2 ..);

-- [GROUPING 형식] 
-- GROUPING(표현식) = 1 : 집계가 계산된 결과
-- GROUPING(표현식) = 0 : 집계가 계산되지 않은 결과
-- 한 컬럼씩만 GROUPING 할 수 있다.
-- SELECT 일반 컬럼명, 그룹 함수(컬럼명), GROUPING(컬럼명), 
--   FROM 테이블명
--  GROUP BY CUBE(select 절에 사용한 일반 컬럼, 컬럼,,,,);

---------------------------------------------------------------------------------------
-- HR 계정에서 실습
-- [실습 4-1] GROUP BY절만 사용하여 부서별, 직무별로 그룹화한다. 
-- 조건 : 부서 번호, 직무 번호, 부서별-직무별 COUNT, 부서별-직무별 최대 급여
-- , 부서별-직무별 급여 총합, 부서별-직무별 급여 평균을 구하시오. 
SELECT department_id
     , job_id
     , COUNT(*)
     , MAX(salary)
     , SUM(salary)
     , ROUND(AVG(salary), 2)
  FROM employees
 GROUP BY department_id, job_id  -- 부서별, 직무별 그룹화
 ORDER BY department_id, job_id;

-- [실습 4-2] ROLLUP 함수를 사용하여 부서별, 직무별로 그룹화한다. 
-- 조건 : 부서 번호, 직무 번호, 부서별-직무별 COUNT, 부서별-직무별 최대 급여
-- , 부서별-직무별 급여 총합, 부서별-직무별 급여 평균을 구하시오. 
SELECT department_id
     , job_id
     , COUNT(*)
     , MAX(salary)
     , SUM(salary)
     , ROUND(AVG(salary), 2)
  FROM employees
 GROUP BY ROLLUP(department_id, job_id)  -- NULL 출력 : 각 부서별 소계 (각 그룹함수별로 묶은 데이터 결과를 토탈 하나로 출력)
 ORDER BY department_id, job_id;

-- [실습 4-3] CUBE 함수를 사용하여 부서별, 직무별로 그룹화한다. 
-- 조건 : 부서 번호, 직무 번호, 부서별-직무별 COUNT, 부서별-직무별 최대 급여
-- , 부서별-직무별 급여 총합, 부서별-직무별 급여 평균을 구하시오. 
SELECT department_id
     , job_id
     , COUNT(*)
     , MAX(salary)
     , SUM(salary)
     , ROUND(AVG(salary), 2)
  FROM employees
 GROUP BY CUBE(department_id, job_id) 
 ORDER BY department_id, job_id;  -- (부서별 데이터 + 부서별 오름차순 소계) +  직무별 오름차순 소계  + 컬럼의 전체 total

-- [실습 4-4] GROUPING SETS 함수를 사용하여 부서별, 직무별로 그룹화한다. 
-- 조건 : 부서 번호, 직무 번호, 부서별-직무별 COUNT, 부서별-직무별 최대 급여
-- , 부서별-직무별 급여 총합, 부서별-직무별 급여 평균을 구하시오. 
SELECT department_id
     , job_id
     , COUNT(*)
     , MAX(salary)
     , SUM(salary)
     , ROUND(AVG(salary), 2)
  FROM employees
 GROUP BY GROUPING SETS(department_id, job_id)  -- 부서별로 집계, 직무별 집계(소계없이 총계만 출력)
 ORDER BY department_id, job_id;

-- [실습 4-5] GROUPING 함수를 사용하여 부서별, 직무별로 그룹화한다. 부서와 직무의 그룹화 결과 여부를 GROUPING 함수로 확인한다.
-- 조건 : 부서 번호, 직무 번호, 부서별-직무별 COUNT, 부서별-직무별 최대 급여
-- , 부서별-직무별 급여 총합, 부서별-직무별 급여 평균을 구하시오. 
SELECT department_id
     , job_id
     , COUNT(*)
     , MAX(salary) AS MAX_s
     , SUM(salary) AS SUM_s
     , ROUND(AVG(salary), 2) AS AVG_s
     , GROUPING(department_id) AS GROUP_d   -- department&소계 그룹화(0), job_id 비그룹화(1)
     , GROUPING(job_id) AS GROUP_j -- department&소계 비그룹화(1), job_id 그룹화(0)
  FROM employees
 GROUP BY CUBE(department_id, job_id)  -- (부서별 데이터 + 부서별 오름차순 소계) +  직무별 오름차순 소계  + 컬럼의 전체 total
 ORDER BY department_id, job_id;

---------------------------------------------------------------------------------------

-- // LISTAGG 함수 //
-- :  LISTAGG  ~ WITHIN GROUP  => 그룹에 속해 있는 데이터를 가로로 나열할 때 사용
-- [형식]
-- SELECT LISTEGG(컬럼이름B, '구분문자') WHITHIN GROUP(ODERBY 정렬기준 컬럼이름)
-- FROM 테이블이름;

-- [실습 4-6] 부서별 사원 이름을 한 컬럼에 가로로 나열해서 출력하기 
SELECT department_id
	 , LISTAGG(last_name, ', ') 
			   WITHIN GROUP(ORDER BY salary DESC) AS last_name
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;
 
---------------------------------------------------------------------------------------

-- // PIVOT 함수 //
-- :  표의 행과 열을 전환하는 등의 과정을 통하여 통계를 재정렬하는 함수 
--    즉, 2가지 컬럼(x,y)를 그룹화하여 1개의 컬럼으로 표현하되 x, y 중 하나를 행렬 전환하여 
--    2차원적 정보로 조회가 가능하다. 

-- [실습 4-7] PIVOT 함수를 사용하여 직책별 부서별 최고급여를 2차원 표 형태로 출력하기
SELECT * 
  FROM(SELECT department_id, job_id, salary   -- 행 기준 (job_id)
	     FROM employees)
  PIVOT(MAX(salary)
        FOR department_id IN(10, 20, 30) -- 컬럼 기준 (department_id 컬럼)
	   )
 ORDER BY job_id;
