-- // 5. LIKE 연산자와 와일드 카드 => 중요
-- * 문법 : 컬럼명 LIKE Pattern
-- 와일드 카드 :
-- % => 길이와 상관없이 모든 문자데이터를 의미
-- _ => 어떤 값이든 상관없이 한개의 문자데이터를 의미

-- 5-1. 사원테이블에서 사원 ID, last_name 조회
-- 조건 : last_name의 3번째, 4번째 단어가 'tt'
-- 정렬 : 사원 ID (오름차순) 
SELECT employee_id "사원 ID"
     , last_name 이름
  FROM employees
 WHERE last_name LIKE '__tt%'
ORDER BY employee_id ASC;

-- 5-2. 사원 테이블에서 사원 ID, email 조회
-- 조건 : email에 'JONES'가 포함
-- 정렬 : 사원 ID (오름차순) 
SELECT employee_id "사원 ID"
     , email 이메일
  FROM employees
 WHERE email LIKE '%JONES%'
ORDER BY employee_id ASC;

-- 5-3. JOBS 테이블에서 job_id 조회
-- 조건 : job_id에 'REP' 포함
SELECT job_id "직무 ID"
  FROM jobs
 WHERE job_id LIKE '%REP%';

-- 5-4. JOBS 테이블에서 job_id 조회
-- 조건 : job_id에 'REP' 포함하지 않는다. 
SELECT job_id "직무 ID"
  FROM jobs
 WHERE job_id NOT LIKE '%REP%';
 