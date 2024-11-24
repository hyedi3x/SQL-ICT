-- // 14. DECODE & CASE 함수 //

-- // DECODE //
-- : 자바의 Switch Case문과 동일한 기능을 한다. 
--   조건에 따라 데이터를 다른 값이나 컬럼 값으로 추출할 수 있다. 
-- * 문법 : DECODE(VALUE, COND1, THEN1, COND2, THEN2, ...) 형태로 사용
--          VALUE == COND1 일 경우 THEN1 반환, VALUE == COND2 일 경우 THEN2 반환

-- 14-1. 사원 ID, 이름, job_id, salary, 급여 수당 출력(단 decode를 이용해 수당 출력)
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id  "직무 ID"
     , salary 급여
     , DECODE(job_id  -- 조건이 적용되는 컬럼 
            , 'AD_PRES', salary*1.1    -- 조건1, 결과 1
            , 'AD_VP', salary*1.2      -- 조건2, 결과 2
            , 'IT_PROG', salary*1.3    -- 조건3, 결과 3
            , 'FI_MGR', salary*1.4     -- 조건4, 결과 4
            , salary*1.5) AS 수당     -- 조건외 나머지(생략), 결과 5
  FROM employees;

-- // CASE문  //
-- : 자바의 if else문과 동일
--   조건에 따라 데이터를 다른 값이나 컬럼 값으로 추출할 수 있다. 
-- DECODE가 제공하지 못하는 비교 연산의 단점을 해결 할 수 있다.
-- CASE는 SQL과 PL/SQL에서 모두 사용 가능 하지만, DECODE는 SQL에서만 사용 가능
 
-- 14-2. 사원 ID, 이름, job_id, salary, 급여 수당 출력 (단 case를 이용해 수당 출력)
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id  "직무 ID"
     , salary 급여
     , CASE job_id  -- 조건이 적용되는 컬럼 
            WHEN 'AD_PRES' THEN salary*1.1    -- WHEN 조건1 THEN 결과 1
            WHEN 'AD_VP' THEN salary*1.2      -- WHEN 조건2 THEN 결과 2
            WHEN 'IT_PROG' THEN salary*1.3    -- WHEN 조건3 THEN 결과 3
            WHEN 'FI_MGR' THEN salary*1.4     -- WHEN 조건4 THEN 결과 4
            ELSE salary*1.5                   -- ELSE 결과 5
       END AS 수당
 FROM employees;
 
-- 14.3 사원 ID, 이름, job_id, salary, commission_pct, case문을 이용해 comm_text 출력 
-- comm_text : commission_pct가 null이면 '해당사항 없음'
--                                 0이면 '수수료 없음'
--                                 0보다 크면 연봉 출력 => '연봉 : ' 
SELECT employee_id "사원 ID"
     , last_name 이름
     , job_id  "직무 ID"
     , salary 급여
     , commission_pct 수수료
     , CASE 
            WHEN commission_pct IS NULL THEN '해당사항 없음'
            WHEN commission_pct=0 THEN '수수료 없음'
            WHEN commission_pct>0 THEN '연봉 : ' 
            || TO_CHAR(salary*12 - (salary*12)*commission_pct)
       END AS 연봉
 FROM employees;
 
-- 14-4. 사원테이블의 부서ID가 10~60인 경우 부서ID와 '부서명' 조회. 그 외는 '부서미정'으로 출력
-- 정렬 : 부서 ID(오름차순)
-- 조건 : 단 부서ID는 중복되지 않아야 하며, 부서ID가 null이면 출력안되게 
SELECT department_id "부서 ID"
     , department_name 부서명
     , CASE department_id
            WHEN 10 THEN 'Administration'
            WHEN 20 THEN 'Marketing'
            WHEN 30 THEN 'Purchasing'
            WHEN 40 THEN 'Human Resources'
            WHEN 50 THEN 'Shipping'
            WHEN 60 THEN 'IT'            
            ELSE '부서미정 '
       END AS "부서 정보"
  FROM departments
 WHERE department_id IS NOT NULL
ORDER BY department_id;
