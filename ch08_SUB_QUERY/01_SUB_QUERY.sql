-- // [8.서브 쿼리] //
-- 메인쿼리 내부에 포함된 SELECT 문장이다. 
-- 즉 서브쿼리에서 실행된 결과가 메인쿼리에 전달되어 최종적인 결과를 출력한다. 
-- - 메인쿼리 : 서브쿼리를 포함하고 있는 쿼리문
-- - 서브쿼리 : 메인쿼리에 포함된 쿼리문으로, 비교연산자의 오른쪽에 기술하고, 반드시 괄호안에 넣어야 한다.
--              메인쿼리가 실행되기 전에 한번만 실행된다.
--              서브쿼리의 SELECT 절에 명시한 열은 메인쿼리의 비교대상과 같은 자료형과 같은 갯수로 지정해야 한다.

-- 1. WHERE 절에서 사용하는 서브쿼리(중첩 서브 쿼리) .. 조건비교
-- 2. FROM 절에서 사용하는 서브쿼리(=인라인뷰) .. 테이블 대용
-- 3. SELECT 절에서 사용하는 서브쿼리(=스칼라 서브쿼리) .. 컬럼 대용

--   - 단일행 서브쿼리 : 수행결과가 오직 하나의 행만을 반환하는 서브쿼리
--              연산자 : >, >=, =, <=, <, <>, !=, ^=
--   - 다중행 서브쿼리 : 수행결과가 하나이상의 행만을 반환하는 서브쿼리 
--              연산자 : IN, ANY, SOME, ALL, EXISTS

--  //////////////////////////////////////////////////////////////////
-- // [1. Scalar Subquery] //
-- : SELECT 절에서 사용하는 서브쿼리
--   반드시 한 컬럼만 반환하는 서브쿼리이다. 만약 한컬럼이 여러개의 값을 가지면 오류가 발생한다.

-- [Scalar Subquery 실습] 
-- 8-1. 사원 ID, 이름, 직무명, 사원 테이블 평균 급여, 부서 ID, 부서 ID 10번 부서명 조회
SELECT employee_id
     , last_name
     , job_id
     , (SELECT TRUNC(AVG(salary),0) FROM employees) AS "평균급여_서브쿼리" -- 6461
     , department_id
     , (SELECT d.department_name
          FROM departments d, employees e  
         WHERE d.department_id = e.department_id  -- EQUI JOIN
           AND d.department_id = 10) AS "부서명_서브쿼리"  -- Administration
  FROM employees;

--  //////////////////////////////////////////////////////////////////
-- // [2. Inline View] //
-- : FROM 절에서 사용하는 서브 쿼리
--   특정 테이블 전체가 아닌, SELECT문을 통해 일부 데이터를 추출한 후 별칭을 주어 사용
--   결과는 반드시 하나의 테이블로 리턴 되어야 한다.

-- with절 : 인라인뷰를 가독성있게 사용할 경우
-- 테이블 내 데이터 규모가 크거나, 현재 작업에 불필요한 열이 너무 많아, 행과 열만 사용하고자 할 때 사용
-- - 문법 
--   WITH
--   별칭1 AS (SELECT문),
--   별칭2 AS (SELECT문)
--   메인쿼리..
--     FROM 별칭1,별칭2 

-- [Inline View 실습]
-- 8-2. 10번 부서의 사원 ID, 이름, 직무 ID, 급여, 부서 ID, 부서명 조회
SELECT e.employee_id                   
     , e.last_name              
     , e.job_id              
     , e.salary              
     , d.department_id  
     , d.department_name
  FROM (SELECT * FROM employees
         WHERE department_id = 10) e  -- Administration
  JOIN (SELECT * FROM departments) d
    ON e.department_id = d.department_id;  -- INNER JOIN
 
 -- 8-3. 10번 부서의 사원 ID, 이름, 직무 ID, 급여, 부서 ID, 부서명 조회 (WITH 절 사용)
WITH 
e AS (SELECT * FROM employees
         WHERE department_id = 10), -- Administration
d AS (SELECT * FROM departments) 
SELECT e.employee_id                   
     , e.last_name              
     , e.job_id              
     , e.salary              
     , d.department_id  
     , d.department_name
  FROM e, d
 WHERE e.department_id = d.department_id;

--  //////////////////////////////////////////////////////////////////
-- // [3. 중첩 서브 쿼리] //
-- : 결과 집합을 한정하기 위한 서브 쿼리로, WHERE 절에서 사용하는 서브 쿼리이다. 
-- -  서브 쿼리가 메인쿼리 컬럼을 참조할 때 상관관계 있는 서브쿼리 라고 한다. 

-- [3-1. 단일행 서브쿼리]
-- : 수행결과가 오직 하나의 행만을 반환하는 서브쿼리
--   비교 연산자 : >, >=, =, <=, <, <>, !=, ^=

-- [3-1. 단일행 서브쿼리 실습]
-- 8-4. 'Chen'의 급여(=8200)보다 많은 급여를 받는 사원의 사번, 이름, 급여를 구하시오.
-- 정렬 : 급여(오름차순) 
SELECT employee_id  
     , last_name
     , salary
  FROM employees
 WHERE salary > (SELECT salary     -- '>' 기호 사용으로 CHEN사원의 급여보다 높은 급여 조회
                   FROM employees 
                  WHERE last_name ='Chen')  -- Chen 사원의 급여 조회 서브 쿼리
 ORDER BY salary ASC; 
  
-- 8-5. 'Chen'과 같은 부서(=100)에서 일하는 사원의 사원 ID, 이름, 부서 ID, 부서명을 구하시오
-- 정렬 : 사원 ID(오름차순)
SELECT e.employee_id  
     , e.last_name
     , d.department_id
     , d.department_name
  FROM employees e
 INNER JOIN departments d
    ON e.department_id = d.department_id
 -- '=' 기호 사용으로 Chen 사원의 부서 ID와 같은 부서 ID 대입
 WHERE e.department_id   
         = (SELECT department_id 
              FROM employees
             WHERE last_name ='Chen')  -- Chen 사원의 부서 ID 조회
ORDER BY employee_id ASC; 

-- 8-6. job_title이 'Programmer'이면서, job_id(IT_PROG)에서 일하는 사원의 사원 ID, 사원명, job_id, 급여 출력
-- 정렬 : 사원 ID(오름차순)
SELECT e.employee_id  
     , e.last_name
     , e.salary
     , j.job_id
     , j.job_title
  FROM employees e
  INNER JOIN jobs j
    ON e.job_id = j.job_id
-- '=' 기호 사용으로 job_title이 'Programmer'인 직무(IT_PROG)와 같은 직무로 데이터 조회
 WHERE e.job_id 
         = (SELECT job_id      -- job_id : IT_PROG
              FROM jobs
             WHERE job_title LIKE '%Programmer%') -- job_title이 'Programmer'인 직무 조회
ORDER BY employee_id ASC; 

------------------------------------------------------------------------
-- // [3-2. 다중행 서브쿼리] //
-- : 수행결과가 하나 이상의 행만을 반환하는 서브쿼리 
--   * 연산자 : IN, ANY, SOME, ALL, EXISTS 
 
-- [3-2. 단일행 서브쿼리 실습]
-- [3-2-1. IN]
-- : 메인 쿼리의 조건식이 서브 쿼리의 결과 중에서 하나라도 일치하면 참이다.

-- 8-7. 각 부서별 최대 급여와 동일한 급여를 받는 사원정보 조회. (IN 연산자)
-- 정렬 : 부서 ID(오름차순), salary(오름차순) 
SELECT employee_id
     , last_name 
     , job_id 
     , salary
     , department_id
FROM employees
WHERE (department_id, salary)  -- 다중행 서브 쿼리와 하나라도 일치하면
      IN(SELECT department_id  -- 최대 급여와 부서 ID 조회
              , MAX(salary)
           FROM employees
          GROUP BY department_id)
ORDER BY department_id ASC, salary ASC;

-- [3-2-2. ANY, SOME]
-- : 메인쿼리의 비교조건이 서브쿼리의 결과와 하나 이상이 일치하면 참이다.
--  > ANY : 메인쿼리 결과값 > 서브쿼리의 최소값
--  < ANY : 메인쿼리 결과값 < 서브쿼리는 최대값
 
-- 8-8. 30번 부서의 최소 salary(2500)보다 큰 정보 (> ANY)
-- 조건 : salary(오름차순), 부서 ID(오름차순) 
SELECT employee_id
     , last_name 
     , job_id 
     , salary
     , department_id
FROM employees
WHERE salary > -- 메인쿼리 결과값 > 서브쿼리의 최소값 일치하면
      ANY (SELECT salary  
             FROM employees
            WHERE department_id = 30)  -- 30번 부서 급여 최소 2500
ORDER BY salary ASC, department_id ASC;

-- 8-9. 30번 부서의 최대 salary(11000)보다 작은 정보 (< ANY)
-- 조건 : salary(내림차순), 부서 ID(내림차순) 
SELECT employee_id
     , last_name 
     , job_id 
     , salary
     , department_id
FROM employees
WHERE salary < -- 메인쿼리 결과값 < 서브쿼리의 최대값 일치하면
      ANY (SELECT salary  
             FROM employees
            WHERE department_id = 30)  -- 30번 부서 급여 최대 11000
ORDER BY salary DESC, department_id DESC;

-- [3-2-3. ALL]
-- : 메인쿼리의 비교조건이 서브쿼리의 결과와 모두 일치하면 참이다.
--  > ALL : 메인쿼리 결과값 > 서브쿼리의 최대값
--  < ALL : 메인쿼리 결과값 < 서브쿼리는 최소값

-- 8-10. 30번 부서의 최대 salary(11000)보다 큰 정보 (> ALL)
-- 조건 : salary(오름차순)
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE salary > --  메인쿼리 결과값 > 서브쿼리의 최대값 일치하면
       ALL(SELECT salary  
             FROM employees
            WHERE department_id = 30)  -- 30번 부서 급여 최대 11000
ORDER BY salary ASC; 

-- 8-11. 30번 부서의 최소 salary(2500)보다 작은 정보 (< ALL)
-- 조건 : salary(오름차순)
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE salary < --  메인쿼리 결과값 < 서브쿼리의 최소값 일치하면
       ALL(SELECT salary 
             FROM employees
            WHERE department_id = 30) -- 30번 부서 급여 최소 2500
ORDER BY salary ASC; 

-- [3-2-4. EXISTS]
-- 서브쿼리에 결과값이 하나이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 모두 false
-- EXISTS가 false이면 검색결과가 없다.

-- 8-12. 존재하지 않은 300번 부서의 부서명과 동일한 사원 정보 조회 
-- 조건 : salary(오름차순)
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE EXISTS(SELECT department_name  -- 300번 부서가 존재하지 않으므로 빈 테이블 반환
                FROM departments 
               WHERE department_id = 300)
ORDER BY salary ASC; 

-- 8-13. EXISTS가 true이면 검색결과가 조회(사원테이블의 정보 조회)
-- 조건 : salary(오름차순)
SELECT e.employee_id
     , e.last_name
     , e.job_id
     , e.salary
     , d.department_id
     , d.department_name
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND EXISTS(SELECT department_name  -- 20번 부서가 존재므로 테이블의 결과값을 반환
                FROM departments 
               WHERE department_id = 20)
ORDER BY salary ASC, department_id ASC; 


 