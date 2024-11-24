-- // 7. REPLACE 함수 // 
-- : 특정 문자를 다른 문자로 바꾸는(대체하는) 함수
-- * 문법 : REPLACE(문자열 데이터 또는 열이름(필수), [찾는 문자(필수)], [대체할 문자(선택)] 

-- 7-1. dual 테이블에서 핸드폰 번호의 '-'문자를 다른 기호로 바꿔보기
-- 1. 문자열 사이에 공백도 가능 
-- 2. / 기호로 변경 
-- 3. 대체할 문자열 생략시 지정한 -기호만 제거된다. (공백없음)
  SELECT '010-1111-2222' AS REPLACE_BEFORE
      , REPLACE('010-1111-2222', '-', ' ') AS REPLACE_1
      , REPLACE('010-1111-2222', '-', '/') AS REPLACE_2
      , REPLACE('010-1111-2222', '-') AS REPLACE_3
   FROM dual;   

-- 7-2. 사원의 사원ID, 입사일(02년도, 03년도), 이름(first_name-last_name) 조회
-- 조건 : 입사년도가 02년도이거나 03년도인 입사일을 가진 사원 정보 조회  
--        SUBSTRING을 사용하여 날짜를 추출하고, CONCAT으로 문자열을 결합한다.  
-- 정렬 : hire_date 오름차순 정렬 
SELECT employee_id  사번
     ,'20'
      ||SUBSTR(hire_date, 1, 2)||'년 ' -- hire_date의 1-2 요소 추출값과 문자열 결합
      ||SUBSTR(hire_date, 4, 2)||'월 ' -- hire_date의 4-5 요소 추출과 문자열 결합
      ||SUBSTR(hire_date, 7, 2)||'일' 입사일 -- hire_date의 7-8 요소 추출과 문자열 결합
     , first_name||'-'||last_name 이름
 FROM employees
 WHERE SUBSTR(hire_date, 1, 2) = 02  -- 년도가 02년도 일때
    OR SUBSTR(hire_date, 1, 2) = 03  -- 년도가 03년도 일때
 ORDER BY hire_date ASC;

-- 7-3. 사원의 사원ID, 입사일(01년도, 04년도), 이름(first_name-last_name) 조회
-- 조건 : 입사년도가 01년도이거나 04년도인 입사일을 가진 사원 정보 조회  
--        SUBSTRING을 사용하여 날짜를 추출하고, CONCAT으로 문자열을 결합한다. 
--        REPLACE를 사용하여, / 기호 대신 년, 월로 대체한다. 
-- 정렬 : hire_date 오름차순 정렬 
SELECT employee_id 사번
     -- hire_date의 1~3 요소를 추출하고, '/' 대신 '년' 문자열로 대체한다.
     -- hire_date의 4~6 요소를 추출하고, '/' 대신 '월' 문자열로 대체한다.
     -- hire_date의 7-8 요소 추출과 문자열 결합
     , 20||REPLACE(SUBSTR(hire_date, 1, 3), '/', '년 ') 
       || REPLACE(SUBSTR(hire_date, 4, 3), '/', '월 ') 
       || SUBSTR(hire_date, 7, 2)|| '일' 입사일
     , first_name||'-'||last_name 이름
  FROM employees
 -- substring으로 추출한 컬럼 위치의 데이터 01와 04을 뽑아낸다
 WHERE SUBSTR(hire_date, 1, 2) IN (01, 04) 
 ORDER BY hire_date ASC;
