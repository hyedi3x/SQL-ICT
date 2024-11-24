-- // 08. TRIM 함수 //
-- : 문자열의 공백을 제거하거나 반복적인 문자(좌/우만 가능)나 특정 문자를 제거할 때 자주 사용한다. 
-- TRIM : 문자열의 양쪽 공백을 제거하는 기본적인 함수이다. 
-- LTRIM 함수, RTRIM 함수는 왼쪽과 오른쪽의 공백을 제거할 때 사용
-- LTRIM 함수, RTRIM 함수 : 반복적인 문자나 특정 문자를 제거할 때 자주 사용한다.

-- 8-1. dual 테이블에서 '    Oracle SQL    ' 텍스트의 공백을 제거한다. 
-- 1. TRIM은 양쪽 공백을 제거한다. 
-- 2. LTRIM은 왼쪽 공백만 제거한다. 
-- 3. RTRIM은 오른쪽 공백만 제거한다. 
SELECT '    Oracle SQL    '
     , TRIM('    Oracle SQL    ') AS "TRIM"
     , LTRIM('    Oracle SQL    ') AS "LTRIM" 
     , RTRIM('    Oracle SQL    ')  AS "RTRIM" 
  FROM dual;  

-- 8-2. dual 테이블에서 'ACCOUNTING', '00100' 텍스트의 지정 문자를 제거한다. (지정문자 반복시, 한 번에 제거) 
-- 1. LTRIM은 왼쪽 지정문자를 제거한다. 
-- 2. LTRIM은 왼쪽 반복 문자를 제거한다. (0, 2개 제거)
-- 3. RTRIM은 오른쪽 반복 문자를 제거한다. (0, 2개 제거)
-- 4. RTRIM은 왼쪽 지정문자를 제거하지 못한다. 
-- 5. RTRIM은 오른쪽 지정문자를 제거한다. 
SELECT 'ACCOUNTING', '00100'
     , LTRIM('ACCOUNTING', 'ACC') AS "LTRIM_ACC" 
     , LTRIM('00100', '0')  AS "LTRIM_0"
     , RTRIM('00100', '0')  AS "RTRIM_0"      
     , RTRIM('ACCOUNTING', 'ACC')  AS "RTRIM_ACC"
     , RTRIM('ACCOUNTING', 'ING')  AS "RTRIM_ING"
  FROM dual;  
