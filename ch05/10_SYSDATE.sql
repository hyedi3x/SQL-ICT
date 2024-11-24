  
-- // 10. 날짜 함수 // 
-- 날짜 연산 
-- 날짜 형 데이터에 수를 더하면 (날짜 + 숫자), 해당 날짜로부터 기입한 수 만큼 지난 날짜를 계산한다. 날짜 형 데이터에 수를 빼면 (날짜 – 숫자), 해당 날짜로부터 기입한 수 만큼 이전 날짜를 계산한다. 
-- sysdate : 시스템에 저장된 `현재 날짜`를 반환하는 함수이다. 
-- 10-1. 날짜 연산 실습 
SELECT sysdate 오늘 
     , sysdate-1 어제
     , sysdate-2 그제
     , sysdate+1 내일
     , sysdate+2 모래
  FROM dual;  
  
-- // 날짜의 ROUND 반올림 함수, TRUNC 버림 함수 // 
-- 형식 : TRUNC(date, format), ROUND(date, format)
-- TRUNC => format이 'MONTH'인 경우, 현재 달을 기준으로 자른다, 현재 달의 1일 출력
-- ROUND => format이 'MONTH'인 경우, 현재 달의 일을 기준으로, 16일보다 작으면 현재 달의 1일/16일보다 크면 다음달 1일 출력

-- 10-2. 사원테이블에서 사원 ID, 입사일, T_입사일, R_입사일 조회 (월 기준)
-- '월'에 해당하는 '일'의 수만 버린다.(현재 달의 01일 조회)
-- '월'에 해당하는 '일'의 16일을 기준으로 달을 반올림한다. (현재 달 또는 다음 달의 01일 조회)
-- 정렬 : 입사일 오름차순 
SELECT employee_id "사원 ID"
     , hire_date 입사일
     , TRUNC(hire_date, 'MONTH') "T_입사일"   
     , ROUND(hire_date, 'MONTH') "R_입사일"  
  FROM employees
ORDER BY hire_date;
     
-- 10-3. 사원테이블에서 사원 ID, 입사일, T_입사일, R_입사일 조회 (년 기준)
-- '년'에 해당하는 '월'의 수만 버린다.(현재 년의 01월 01일 조회)
-- '년'에 해당하는 '월'의 07월을 기준으로 달을 반올림한다. (현재 년 또는 다음 년의 01월 01일 조회)
-- 정렬 : 입사일 오름차순 
SELECT employee_id "사원 ID"
     , hire_date 입사일
     , TRUNC(hire_date, 'YEAR') "T_입사일"   
     , ROUND(hire_date, 'YEAR') "R_입사일"  
  FROM employees
ORDER BY hire_date;

-- // MONTHS_BETWEEN 함수 //
-- : 두 날짜간의 개월수 차이를 구하는 함수

-- 10-4. MONTHS_BETWEEN 사용해 날짜 간의 개월 수 구하기 
-- * 문법 : MONTHS_BETWEEN(date1, date2)  // 소수점으로 반환
 SELECT sysdate 오늘 
       , MONTHS_BETWEEN(sysdate, '2025-05-12') 
             AS "(현재->수료) 개월-" -- 음수로 개월 수 조회
       , MONTHS_BETWEEN('2025-05-12', sysdate) 
             AS "(수료->현재) 개월+" -- 양수로 개월 수 조회            
   FROM dual; 
 
-- 10-5. MONTHS_BETWEEN 사용해 날짜 간의 개월 수 구하기 
-- * 문법 : ROUND(MONTHS_BETWEEN(date1, date2), 0) 
-- ROUND(MONTHS_BETWEEN, 0)을 통해 조회 값을 자연수로 반환
-- TO_DATE 사용하여, 문자형을 숫자형으로 변환 후 값을 연산한다. 
SELECT sysdate 오늘
     , ROUND(MONTHS_BETWEEN(sysdate, '2025-05-12'), 0) 
          AS "(현재->수료) 개월" -- 음수로 개월 수 조회
     , ROUND(MONTHS_BETWEEN('2025-05-12', sysdate), 0) 
          AS "(수료->현재) 개월" -- 양수로 개월 수 조회
     , ROUND(TO_DATE('2025-05-12') - sysdate) 
          AS "(수료->현재) 일수" -- 양수로 일수 조회
     , ROUND(TO_DATE('2025-05-12') - TO_DATE('2024-10-31'))
          AS "(수료->개강) 일수" -- 양수로 일수 조회
   FROM dual; 
   
-- 10.6 사원 테이블에서 사원 ID, 입사일, T_입사일, R_입사일, R_근무개월수, T_근무개월수를 구한다. 
-- MONTHS_BETWEEN : 현재 날짜와 입사일 간의 개월 수 구하기 
-- 입사일 오름차순 
SELECT employee_id "사원 ID"
     , hire_date 입사일 
     , ROUND(hire_date, 'MONTH') "R_입사일"  -- 16일을 기준으로 달을 반올림한다. 
     , TRUNC(hire_date, 'MONTH') "T_입사일"  -- 현재 달의 01일로 조회 (버림)
     , ROUND(MONTHS_BETWEEN(sysdate, hire_date), 0) AS "R_근무개월수" 
     , TRUNC(MONTHS_BETWEEN(sysdate, hire_date), 0) AS "T_근무개월수"
  FROM employees
 WHERE SUBSTR(hire_date, 1, 2) IN (01, 03)  -- hire_date 1~2번 요소 추출(01년도와 03년도) 
ORDER BY hire_date;

-- // ADD_MONTHS //
-- : N 개월 이후 날짜를 더하는 함수
-- * 문법 : ADD_MONTHS(날짜, 더할 개월 수) / ADD_MONTHS(date, number)
-- 10-7. 현재 날짜부터 3개월 이후의 날짜를 확인 
SELECT sysdate 오늘
     , ADD_MONTHS(sysdate, 3) "3개월 후"
  FROM dual; 
  
-- // 10-8. NEXT_DAY  //
-- : 돌아오는 요일의 날짜를 반환(해당 날짜를 기준으로 최초로 도래하는 요일에 해당되는 날짜 반환)
-- * 문법 : NEXT_DAY([날짜 데이터], [요일문자])
-- 요일 대신 숫자가 올 수 있다.  1:일요일, 2:월요일 3: 화요일 ....
SELECT sysdate 오늘_일요일
     , NEXT_DAY(sysdate, '일요일') "가장 가까운 일요일"  -- 오늘 일요일이라서 7일 뒤 반환
     , NEXT_DAY(sysdate, 2) "가장 가까운 월요일"  -- 오늘 일요일이라서 1일 뒤 반환
     , NEXT_DAY(sysdate, 3) "가장 가까운 화요일"  -- 오늘 일요일이라서 2일 뒤 반환
     , NEXT_DAY(sysdate, 6) "가장 가까운 금요일"  -- 오늘 금요일이라서 5일 뒤 반환
  FROM dual; 

-- // LAST_DAY //
-- : 달의 마지막 날 반환
-- * 문법 : LAST_DAY(날짜 데이터)
-- 10-9. 사원 테이블에서 사원ID, 입사일, 입사한 달의 마지막 날 조회 
SELECT employee_id 사원ID
     , hire_date 입사일
     , LAST_DAY(hire_date) "입사한 달_LAST"
  FROM employees
 WHERE SUBSTR(hire_date, 1, 2) IN (01, 03)
ORDER BY hire_date ASC;
 
  
 