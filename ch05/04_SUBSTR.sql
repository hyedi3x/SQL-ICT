-- // 4. 문자열 일부를 추출하는 SUBSTR 함수 //
-- * 문법 : SELECT SUBSTR(컬럼명, 시작 위치, 추출길이)　AS 별칭 FROM 테이블명;
-- SQL 문자열 요소 인덱스는 1부터 시작한다. 
-- 시작　위치부터 추출 개수만큼 추출한다.
-- 시작　위치가 양수인 경우　: 시작 위치(문자열 순방향)부터 추출 길이만큼 추출 (추출 방향은 순방향)
-- 시작 위치가 음수인 경우 : 시작 위치(문자열 역방향)부터 추출 길이만큼 추출 (추출 방향은 순방향)

-- *문법 : SELECT SUBSTR(컬럼명, 시작 위치)　AS 별칭 FROM 테이블명;
-- 추출 개수 생략 시 : 시작 위치부터 데이터 끝까지 추출
-- 시작　위치가 양수인 경우　: 시작 위치(문자열 순방향)부터 데이터 끝까지 추출 (추출 방향은 순방향)
-- 시작 위치가 음수인 경우 : 시작 위치(문자열 역방향)부터 데이터 끝까지 추출 (추출 방향은 순방향)

-- 4.1 사원 테이블에서 job_id 조회 
-- 조건 : SUBSTR을 사용하여 job_id 컬럼의 `AC_ACCOUNT` 문자열의 일부분을 추출한다. 
--        SELECT SUBSTR(컬럼명, 1, 2) : 문자열 시작 위치 1번 인덱스부터 문자 2개 추출
--        SELECT SUBSTR(컬럼명, -2, 2) : 문자열 시작 위치 뒤에서 2번째 인덱스부터 문자 2개 추출
--        SELECT SUBSTR(컬럼명, -8) : 문자열 시작 위치 뒤에서 8번 인덱스부터 문자열 끝까지 추출
--        SELECT SUBSTR(컬럼명, 5) : 문자열 시작 위치 5번 인덱스부터 문자열 끝까지 추출
 SELECT job_id 직무ID
      , SUBSTR(job_id, 1, 2) "(job_id, 1, 2)"  
      , SUBSTR(job_id, -2, 2) "(job_id, -2, 2)"  
      , SUBSTR(job_id, -8) "(job_id, -8)" 
      , SUBSTR(job_id, 5) "(job_id, 5)"
   FROM employees
  WHERE job_id = 'AC_ACCOUNT';
  
-- 4.2 사원 테이블에서 first_name 조회 
-- 조건 : SUBSTR을 사용하여 first_name 컬럼의 `Elizabeth` 문자열의 일부분을 추출한다. 
--        SELECT SUBSTR(컬럼명, 6, 4) : 문자열 시작 위치 6번 인덱스부터 문자 4개 추출
--        SELECT SUBSTR(컬럼명, 4, 2) : 문자열 시작 위치 뒤에서 4번째 인덱스부터 문자 2개 추출
--        SELECT SUBSTR(컬럼명, -4, 4) : 문자열 시작 위치 뒤에서 4번 인덱스부터 문자 4개 추출
--        SELECT SUBSTR(컬럼명, -6) : 문자열 시작 위치 뒤에서 6번 인덱스부터 문자열 끝까지 추출
SELECT first_name 성
     , SUBSTR(first_name, 6, 4) "(first_name, 6, 4)"
     , SUBSTR(first_name, 4, 2) "(first_name, 4, 2)"
     , SUBSTR(first_name, -4, 4) "(first_name, -4, 4)"
     , SUBSTR(first_name, -6) "(first_name, -6)"
  FROM employees
 WHERE first_name = 'Elizabeth';
