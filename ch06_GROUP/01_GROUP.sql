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
