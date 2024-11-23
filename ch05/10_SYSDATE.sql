  
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
 