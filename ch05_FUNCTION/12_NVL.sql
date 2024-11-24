--  // 12. NULL 함수 //
-- NULL : 미확정, 값이 정해져있지 않아 알수없는 값을 의미하며, 연산, 대입, 비교가 불가능하다.
--        연산시 관계 컬럼값도 null로 바뀐다.

-- // NVL// 
-- : 값이 NULL일 경우 연산, 대입, 비교가 불가능하므로 NVL을 이용해 대체
--        NULL을 0 또는 다른 값으로 변환한다.
-- * 문법 : NVL(컬럼값, 초기값)

-- 12-1. 사원테이블의 last_name, salary,  salary*12-(salary*12)*commission_pct 연봉, 
-- commission_pct, salary >= 10000   
-- NULL 제거 전 
SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*commission_pct  연봉  -- 값이 null이면 비교, 연산, 할당 불가
     , commission_pct 수수료
  FROM employees
 WHERE salary>=10000;
 
-- NVL : NULL을 0으로 대체
SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*NVL(commission_pct, 0)  연봉  -- NULL을 0으로 대체 
     , NVL(commission_pct, 0) 수수료
  FROM employees
 WHERE salary>=10000;
 
-- 12-2. LOCATIONS 테이블에서 location_id, city, state_province 조회
-- (단 state_province가 null이 아닌 경우 조회, null 값을 제외한 데이터만 조회)
SELECT location_id  "위치 ID" 
     , city "도시명"
     , state_province "주/도"
FROM locations
WHERE state_province IS NOT NULL;

-- 12-3. LOCATIONS 테이블에서 location_id, city, state_province 조회
--       state_province가 null일 경우, '주(미정)'로 변환한다. 
SELECT location_id "위치 ID" 
     , city "도시명"
     , NVL(state_province, '주(미정)') "NVL(주/도)"
FROM locations; 

-- //  NVL2 함수  //
-- NULL이 아닐 때와 NULL일 때 반환값 각각 지정
-- NVL2(컬럼값, NULL이 아닌 데이터를 다른값으로 변환한 값, NULL 데이터를 다른값으로 변환한 값)

-- 12-4. 사원테이블의 last_name, salary,  salary*12-(salary*12)*commission_pct 연봉, 
-- commission_pct, salary >= 10000
-- NVL2를 사용해 NULL 값을 0으로 변환하고, NULL이 아닌 값은 0.1로 데이터를 변환한다. 
-- 모든 사원의 수수료를 동일한 값으로 줄 수 있다. 
 SELECT employee_id "사원 ID"
     , last_name 이름
     , salary 급여
     , salary*12-(salary*12)*NVL(commission_pct, 0)  연봉_NVL  -- NULL을 0으로 대체 
     , salary*12-(salary*12)*NVL2(commission_pct, 0.1, 0)  연봉_NVL2  -- NULL을 0으로 대체, NULL 아닌 값 0.1로 변경
     , NVL(commission_pct, 0) NVL_수수료
     , NVL2(commission_pct, 0.1, 0) NVL2_수수료
  FROM employees
 WHERE salary>=10000;

-- //  NULLIF 함수  //
-- * 문법 : NULLIF (표현식1, 표현식2)
-- : 두 표현식을 비교하여 동일하면 null을 반환하고, 동일하지 않으면 표현식1을 반환

-- 12-5. NULLIF 함수를 사용하여, 두 표현식의 값을 비교한다. 
SELECT NULLIF('SQL', 'SQL') SAME -- null
     , NULLIF('ORACLE', 'SQL') DIFFERENT -- ORACLE
  FROM dual;
