///////////////////////////////////////////////
-- 1. SELECT * FROM 테이블명;  -- 테이블의 모든 항목을 조회 
SELECT * 
  FROM employees;  -- 사원 테이블
  
-- 2-1. SELECT column FROM 테이블명;
-- 테이블의 해당 column 항목을 조회, 사원 ID 조회 
SELECT employee_id -- 사원 ID
  FROM employees;  -- 사원 테이블
  
-- 2-2. 사번, 이메일, 급여, 부서 코드 
SELECT employee_id
     , email
     , salary 
     , department_id  -- 부서 코드 
  FROM employees;  -- 사원 테이블
  
-- 2-3. 부서 테이블 조회 
SELECT * 
  FROM departments; 
  
-- 2-4. 부서 테이블에서 부서 코드, 부서명, 지역 코드 조회 
SELECT department_id    -- 부서코드
     , department_name  -- 부서명
     , location_id      -- 지역 코드 조회
FROM departments;       -- 부서 테이블 조회  

///////////////////////////////////////////////
-- 3. where (조건)
-- 3-1. 사원 테이블의 사번, First_name, 이메일, 입사일, 급여, 부서코드 조회(사번이 206번일때)
SELECT employee_id -- 사원 ID
     , first_name  -- 이름
     , email       -- 이메일
     , hire_date   -- 입사일
     , salary      -- 급여
     , department_id  -- 부서 ID
     , job_id         -- 직업 ID
  FROM employees      -- 사원 테이블
 WHERE employee_id = 206;  -- 사원 ID 206번 (조건)

-- 3-2. 부서 테이블에서 부서 코드(110번일 때), 부서명, 지역 코드 조회 
SELECT department_id    -- 부서 ID
     , department_name  -- 부서명
     , location_id      -- 위치 ID 조회
  FROM departments      -- 부서 테이블
 WHERE department_id = 110;  -- 부서 ID 110번 (조건)

-- 3-3. 지역 테이블 조회 
SELECT *
  FROM locations;  
 
-- 3-4. 지역코드가 1700일 때, 위치코드, 주소, 도시, 국가코드  
SELECT location_id     -- 위치 ID
     , street_address  -- 도로명 주소
     , city            -- 도시
     , country_id      -- 국가 ID
  FROM locations       -- 위치 테이블 조회
 WHERE location_id = 1700;  -- 위치 ID 1700번 (조건)
 
-- 3-5. 국가 테이블 조회
SELECT *
  FROM countries;
  
-- 3-6. 국가코드 ID가 US일 때, 국가 ID, 국가명, 지역코드 
SELECT country_id   -- 국가 ID
     , country_name -- 국가명
     , region_id    -- 지역ID
  FROM countries    -- 국가 테이블 
 WHERE country_id = 'US';  -- 국가 코드 US (조건), 문자열은 대소문자를 구분해야하며, ''로 구분한다.
 
 -- 3-7. 직무 테이블 조회 
 SELECT *
   FROM jobs;
  
 -- 3-8. william의 직무코드, 직무 타이틀, 최소 급여 조회 
 SELECT job_id      -- 직무 ID
      , job_title   -- 직무 명
      , min_salary  -- 최소 급여 
   FROM jobs        -- 직무 테이블 조회
  WHERE job_id = 'AC_ACCOUNT';  -- 직무 ID가 'AC_ACCOUNT'일 때(조건)
 
-- 3-9. job history 테이블 조회 
 SELECT *
   FROM job_history;
   
-- 3-10. ac_account 직무 ID를 가진 사원의 사번, 시작일, 종료일, 부서코드 
SELECT employee_id   -- 사원 ID
     , start_date    -- 시작일
     , end_date      -- 종료일
     , department_id -- 부서 ID
  FROM job_history   -- job history 테이블 조회 
 WHERE job_id = 'AC_ACCOUNT'; -- 직무 ID가 'AC_ACCOUNT'일 때(조건)

///////////////////////////////////////////////
-- 4. OREDER BY (여러 열 지정 가능), select 문 맨 끝에 온다. 정렬할 데이터가 동일하면, 그 다음 정렬 방식을 따른다.
-- 4-1. 이메일 (오름차순), First_Name (오름차순), 입사일 순(내림차순) 
SELECT email       -- 이메일
     , first_name  -- 이름
     , hire_date   -- 입사일
  FROM employees
ORDER BY email          -- default ASC, desc는 생략 불가 
       , first_name ASC   -- 오름차순
       , hire_date DESC;  -- 내림차순 

-- 4-2. First_Name (오름차순), 이메일 (오름차순), 입사일 순(내림차순) 
SELECT first_name  -- 이름
       , email      -- 이메일
       , hire_date    -- 입사일 
  FROM employees    -- 사원 테이블 조회  
ORDER BY first_name ASC  -- 오름차순
       , email ASC     -- 오름차순
       , hire_date DESC; -- 내림차순

-- 4-3. First_Name (오름차순), 이메일 (내림차순), 입사일 순(내림차순) 
SELECT first_name  -- 이름
       , email      -- 이메일
       , hire_date    -- 입사일 
  FROM employees    -- 사원 테이블 조회  
ORDER BY first_name ASC  -- 오름차순
       , email DESC     -- 내림차순
       , hire_date DESC; -- 내림차순

-- 4-4. 부서코드(오름차순), 입사일(내림차순) 
SELECT department_id   -- 부서 ID
     , hire_date       -- 입사일 
  FROM employees       -- 사원 테이블 출력 
ORDER BY department_id ASC  -- 부서 ID 오름차순
       , hire_date DESC;    -- 입사일 내림차순

///////////////////////////////////////////////
-- 5. [DESC 테이블의 구조 : DESC(DESCRIBE) 테이블명 ]
-- 테이블을 생성한 후, 테이블의 구조가 잘 만들어졌는지 확인하는 구문이다. 
-- NOT Null  : Null이 존재하면 안된다. 
DESC employees;  
  
///////////////////////////////////////////////
-- 6. [DISTINCT] : 열 중복데이터를 삭제
-- 문법 : DISTINCT (중복을 제거할 컬럼명)
-- 열이 여러개인 경우, 여러개의 열까지 모두 동일해야 중복데이터로 간주
-- 6-1. 사원 테이블에서 department_id를 중복없이 출력(내림차순)
SELECT DISTINCT department_id
  FROM employees
ORDER BY department_id DESC;

-- 6-2. 사원 테이블에서 department_id와 manager_id를 중복없이 출력
-- department_id(오름차순), manager_id (내림차순) 
-- manager_id에 중복값이 없기 때문에, department_id 값의 중복을 제거할 수 없다.
-- manager_id와 department_id 두 개가 한묶음으로 출력되어, 중복이 아닌 데이터로 인지됨. 
SELECT DISTINCT department_id
              , manager_id
  FROM employees
ORDER BY department_id ASC
       , manager_id DESC;
       
///////////////////////////////////////////////
-- 7. [별칭] 
-- 컬럼명 : 한칸 띄우고 별칭, 한칸 띄우고 "별칭", 한칸 띄우고 AS 별칭, 한칸 띄우고 AS "별칭"

-- 7-1. first_name과 last_name 사이에 공백을 주고 이메일, 입사일에 별칭 넣기 
-- || : 문서 연결 concat 문자열 연결 
SELECT first_name || ' ' || last_name AS 이름  
     , email AS 이메일
     , hire_date AS  입사일
  FROM employees; 

-- 7-2. first_name과 last_name 사이에 -을 주고 이메일, 입사일에 별칭 넣기 
SELECT first_name || '-' || last_name AS "이름"  
     , email 이메일          -- AS 생략 가능 
     , hire_date "입사 일"   -- 별칭 중간에 띄어씌기가 있으면 ""로 묶어줘야한다. 
  FROM employees;

-- 7.3 테이블명 : 한 칸 띄우고 영문 별칭(테이블에 사용하는 별칭은 소속을 의미한다.)
-- 다른테이블과 조인할때, 각 테이블에 중복되는 컬럼명이 있을 수 있어서 
-- 각 컬러명에 테이블별칭.컬럼명으로 표시한다. 
SELECT emp.first_name || ' ' || emp.last_name AS 이름  
     , emp.email AS 이메일
     , emp.hire_date AS  입사일
  FROM employees emp; 
  
-- 7-4. salary 값 *12하여 연봉으로 출력, commission은 수수료를 의미한다. 
-- commission_pct(Null)이 있어서 비교, 연산, 할당이 불가한다. 후에 null을 0으로 변환후 연산하는 법을 배운다.
-- Null은 연산시 모든 값을 Null로 받아온다.[비교, 연산, 할당 불가] 
SELECT first_name || ' ' || last_name AS 이름  
     , email AS 이메일
     , hire_date AS  입사일
     , salary*12 "연봉"
     , salary*12 + commission_pct   
     , salary*12 + commission_pct AS "연봉2"
  FROM employees; 