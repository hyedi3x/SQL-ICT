-- // 11. type casting(형변환 함수) //
-- TO_CHAR : (숫자형 또는 날짜형) -> 문자형 데이터로 변환
-- TO_DATE : 문자형 -> 날짜형 데이터로 변환
-- TO_NUMBER : 문자형 -> 숫자형 데이터로 변환

-- // TO_CHAR //
-- (숫자형 또는 날짜형)을 문자형으로 변환한다. 
-- *문법 : TO_CHAR(날짜데이터, '출력형식')
-- 11-1. 현재 '년', '월', '일'을 조회한다.
SELECT sysdate 오늘 
     , TO_CHAR(sysdate, 'YYYY/MM/DD DAY') "YYYY/MM/DD DAY"
     , TO_CHAR(sysdate, 'YY-MM-DD (DAY)') "YY-MM-DD (DAY)"
     , TO_CHAR(sysdate, 'YY/MM/DD DY') "YY-MM-DD DY"
     , TO_CHAR(sysdate, 'YY/MM/DD (DY)') "YY-MM-DD (DY)"
  FROM dual;

-- // 시간 표현 //
-- AM : 오라클의 설정에 따라 AM, PM으로 반환 
-- 12시간 -> HH:MI:SS    |    24시간 -> HH24:MI:SS
-- 11-2. 현재 날짜와 현재 시각을 조회한다.
SELECT sysdate 오늘 
     , TO_CHAR(sysdate, 'YYYY/MM/DD(DY) HH:MI:SS') AS "현재 날짜/시분초"
     , TO_CHAR(sysdate, 'YYYY/MM/DD(DY) HH:MI:SS AM') AS "현재 날짜/시분초 AM"
  FROM dual;

-- // 통화 기호로 숫자 데이터 -> 문자형으로 변환 //
-- L : 각 지역별 통화 기호를 자동으로 슷지 데이터 앞에 표시 예)한국: ￦   
-- 도구-환경설정 -> 검색(돋보기) -> NLS 창에 통화 : ￦으로 설정되어 있음
-- 특수문자 : ㄹ+한자키 
-- shift + 4 : $
-- , : 천단위 자리 구분을 표시(000,000,000)
-- . : 소수점을 표시
-- 9 : 자릿수를 나타내며, 자릿수가 맞지 않아도 0으로 채우지 않는다.
-- 0 : 자릿수를 나타내며, 자릿수가 맞지 않을 경우 나머지 공간을 0으로 채운다.

-- 11-3. salary (급여)를 지역별 통화 기호로 조회
SELECT employee_id 사원ID
     , salary 급여
     , TO_CHAR(salary, 'L9,999,999') "L9" 
     , TO_CHAR(salary, 'L0,009,999') "L0" 
     , TO_CHAR(salary, '$9,999,999.99') "$9" 
     , TO_CHAR(salary, '$0,009,999') "$0"
  FROM employees
 WHERE salary>10000;
  
-- //  TO_DATE //
-- 문자형을 날짜형 데이터로 변환한다. 
-- *문법 : TO_DATE('문자', '날짜 format')
-- 11-4. 입사일이 03/06/17인 사원의 사번, 입사일 조회 (오류 발생)
SELECT employee_id 사원ID
     , hire_date 입사일 
     , TO_CHAR(hire_date, 'MM-DD(DY)') "TO_CHAR 입사일"
  FROM employees
 WHERE hire_date = TO_DATE('03/06/17', 'MM/DD');  -- 에러 발생 : 문자와 format 형식이 다름

-- 11-5. 입사일이 03/06/17인 사원의 사번, 입사일 조회
SELECT employee_id 사원ID
     , hire_date 입사일 
     , TO_CHAR(hire_date, 'MM-DD(DY)') "TO_CHAR 입사일"
  FROM employees
 WHERE hire_date = TO_DATE('030617', 'YY/MM/DD'); -- 문자와 format 형식이 같음
    
-- 11-6. dual 테이블에서 2024-11-24일을 TO_DATE로 조회
SELECT TO_DATE('2024-11-24', 'YYYY-MM-DD') "YYYY-MM-DD"
     , TO_DATE('20241124', 'YYYY/MM/DD') "YYYY/MM/DD"
  FROM dual;
  
-- // TO_NUMBER // 
-- 문자형을 숫자형 데이터로 변환한다. 
-- 11-7. 문자열은 산술 (문자열끼리는 산술 불가, 오류 발생)
SELECT '100,000' - '50,000'
  FROM dual;  -- 오류 : 
  
-- 11-8. 문자형을 숫자형으로 바꾼 후, 연산
-- *문법 : TO_NUMBER('문자', '숫자형 format(999,999')
SELECT TO_NUMBER('100,000','999,999')
     - TO_NUMBER('50,000','99,999') "숫자형 변환 후 연산"
FROM dual; 
