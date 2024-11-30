-- // [7. 조인] //
-- // 1. INNER JOIN / EQUI JOIN // 
-- [equal join 형식]
-- SELECT t1.column, t2.column   -- 별칭.컬럼명
--   FROM table t1, table t2     -- 테이블명 테이블별칭, 테이블명 테이블별칭, 
--  WHERE t1.column = t2.column  -- = 기호를 사용해 각 테이블의 동일한 컬럼을 대입(비교)한다. 
--    AND 조건식;                -- PK 테이블을 기준으로 PK 컬럼을 조회하는게 좋음 

-- [부서정보를 기준으로] 
-- 정보를 제공하는 테이블 => 부모테이블 : 부서T => Primary Key(식별키, PK) => NOT NULL, Unique
-- 정보를 제공받는 테이블 => 자식테이블 : 사원T => Foreign Key(외래키, FK)

-- 중복컬럼은 테이블명을 붙여야 한다. (어떤 테이블의 컬럼을 조회할지 참조해야 하기 때문)
-- 외래키끼리 데이터 연결은 의미가 없다. 
-- (외래키에는 null 값이 존재할수 있기 때문에 위험하다.)
-- PK와 FK간의 내부 조인을 해야 값이 조회된다. 
-- PK는 null이 없고, null 존재 시 데이터가 조회되지 않는다. 

-- // [EQUI JOIN 실습] //  
-- 7-1. 사원 테이블에서 20번 부서의 부서ID, 부서명 조회
-- 조건 : 
--      1. PK (department 테이블의 department_id) : 부모 테이블
--      2. FK (employees 테이블의 department_id) : 자식 테이블 
SELECT e.employee_id    "e.사원 ID"
     , e.first_name     "e.사원명"
     , e.department_id  "e.부서 ID"
     , d.department_id  "d.부서 ID"
     , d.department_name "d.부서명"
  FROM employees e
     , departments d  -- 테이블 참조 별칭 생성
 WHERE e.department_id = d.department_id  -- 컬럼 간의 비교 필수!! PK와 FK 동일 컬럼으로 비교
   AND d.department_id = 20;  -- PK 테이블을 기준으로 조회하는게 좋음 
-- [결과]
-- 201	Michael	20	20	Marketing
-- 202	Pat	20	20	Marketing
   
-- 7-2. 사원 테이블과 부서테이블을 JOIN하여 사원 ID, 부서 ID, 부서명을 조회한다.
-- 조건 : 사원 ID가 101번인 사원
SELECT e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
  FROM employees e
     , departments d  
 WHERE e.department_id = d.department_id
   AND e.employee_id = 101; 
-- [결과]
-- 101	90	Executive

----------------------------------------------------------------
-- // INNER JOIN ~ ON | JOIN ~ ON //  
-- [inner join 형식]
-- SELECT t1.column, t2.column   -- 테이블 별칭.컬럼명
--   FROM table t1    -- 첫 번째 테이블
--   JOIN table t2    -- 두 번째 테이블 , JOIN / INNER JOIN
--     ON t1.column = t2.column  -- = 기호를 사용해 각 테이블의 공통으로 존재하는 키를 대입(비교). 
--    WHERE 조건식;              -- 검색, 필터 조건, PK 테이블을 기준으로 PK 컬럼을 조회하는게 좋음 

-- 7-3. 사원 테이블과 부서테이블을 JOIN하여 사원 ID, 부서 ID, 부서명을 조회한다.
-- 조건 : 사원 ID가 101번인 사원 (JOIN ON 사용) 
SELECT e.employee_id "e.사원 ID"
     , d.department_id "d.부서 ID"
     , d.department_name "d.부서명"
  FROM employees e
  JOIN departments d  
    ON e.department_id = d.department_id
 WHERE e.employee_id = 101;  -- PK 테이블을 기준으로 조회하는게 좋음 
-- [결과]
-- 101	90	Executive

------------------------------------------------
-- // [EQUI/INNER JOIN 실습] // 
-- 7-4. 사원 ID, last_name, 부서 ID, 부서명 조회. 
-- 조건 : 60번부서(IT부서)
-- 방법 1. EQUI JOIN
SELECT e.employee_id "e.사원 ID"
     , e.last_name "e.이름"
     , d.department_id "d.부서 ID"
     , d.department_name "d.부서명"
  FROM employees e
     , departments d  
 WHERE e.department_id = d.department_id
   AND d.department_id = 60; 
-- [결과]
--103	Hunold	60	IT
--104	Ernst	60	IT
--105	Austin	60	IT
--106	Pataballa	60	IT
--107	Lorentz	60	IT

-- 방법 2. INNER JOIN
SELECT e.employee_id "e.사원 ID"
     , e.last_name "e.이름"
     , d.department_id "d.부서 ID"
     , d.department_name "d.부서명"
  FROM employees e
  INNER JOIN departments d  
    ON e.department_id = d.department_id
 WHERE d.department_id = 60;
-- [결과]
--103	Hunold	60	IT
--104	Ernst	60	IT
--105	Austin	60	IT
--106	Pataballa	60	IT
--107	Lorentz	60	IT
 
-- 7-5. 사원 ID, last_name, 직무ID, 직무타이틀, 최소급여, 최대급여
-- 조건 : 사원 ID가 110번인 사원(사원정보, 직무정보)
-- 방법 1. EQUI JOIN
SELECT e.employee_id    "e.사원 ID"
     , e.last_name      "e.이름"
     , e.job_id         "e.직무 ID"
     , j.job_id         "j.직무 ID"
     , j.job_title      "j.직무명"
     , j.min_salary     "j.최소 급여"
     , j.max_salary     "j.최대 급여"
  FROM employees e
     , jobs j  
 WHERE e.job_id = j.job_id
   AND e.employee_id = 110; 
-- [결과]
--110	Chen	FI_ACCOUNT	FI_ACCOUNT	Accountant	4200	9000

-- 방법 2. INNER JOIN
SELECT e.employee_id    "e.사원 ID"
     , e.last_name      "e.이름"
     , e.job_id         "e.직무 ID"
     , j.job_id         "j.직무 ID"
     , j.job_title      "j.직무명"
     , j.min_salary     "j.최소 급여"
     , j.max_salary     "j.최대 급여"
  FROM employees e
  JOIN jobs j  
    ON e.job_id = j.job_id
 WHERE e.employee_id = 110; 
-- [결과]
--110	Chen	FI_ACCOUNT	FI_ACCOUNT	Accountant	4200	9000
 
-- 7-6. 사원 ID, last_name, 부서 ID, 부서명, location_id, street_address
-- 조건 : 사원 ID가 100번 사원 (사원정보, 부서정보, 위치정보)
-- 방법 1. EQUI JOIN
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "l.위치 ID"
     , l.street_address  "l.도로명 주소"
  FROM employees e
     , departments d
     , locations l
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND e.employee_id = 100; 
-- [결과]
-- 100	King	90	Executive	1700	2004 Charade Rd

-- 방법 2. INNER JOIN
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "l.위치 ID"
     , l.street_address  "l.도로명 주소"
  FROM employees e
  JOIN departments d 
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
 WHERE e.employee_id = 100; 
-- [결과]
-- 100	King	90	Executive	1700	2004 Charade Rd

-- 7-7. 사원 ID, last_name, 부서코드, 부서명, location_id, street_address, country_id, country_name 
-- 조건 : 사원 ID가 101번인 사원(사원정보, 부서정보, 위치정보, 국가정보)
-- 방법1. EQUI JOIN
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "l.위치 ID"
     , l.street_address  "l.도로명 주소"
     , c.country_id      "c.국가 ID"
     , c.country_name    "c.국가명"
  FROM employees e
     , departments d
     , locations l
     , countries c
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND e.employee_id = 101; 
-- [결과]
-- 101	Kochhar	90	Executive	1700	2004 Charade Rd	US	United States of America

-- 방법 2. INNER JOIN
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "l.위치 ID"
     , l.street_address  "l.도로명 주소"
     , c.country_id      "c.국가 ID"
     , c.country_name    "c.국가명"
  FROM employees e
  JOIN departments d 
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id  
 WHERE e.employee_id = 101; 
-- [결과]
-- 101	Kochhar	90	Executive	1700	2004 Charade Rd	US	United States of America

-- 7-8. 사원 ID, last_name, 부서 ID, 부서명, location_id, street_address, country_id, 
-- country_name, region_id, region_name 
-- 조건 : 사원 ID가 100번인 사원(사원정보, 부서정보, 위치정보, 국가정보, 지역정보)
-- 방법1. EQUI JOIN 
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "l.위치 ID"
     , l.street_address  "l.도로명 주소"
     , c.country_id      "c.국가 ID"
     , c.country_name    "c.국가명"
     , r.region_id       "r.지역 ID"
     , r.region_name     "r.지역명"
  FROM employees e
     , departments d
     , locations l
     , countries c
     , regions r
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND e.employee_id = 100; 

-- 방법 2. INNER JOIN
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "l.위치 ID"
     , l.street_address  "l.도로명 주소"
     , c.country_id      "c.국가 ID"
     , c.country_name    "c.국가명"
     , r.region_id       "r.지역 ID"
     , r.region_name     "r.지역명"
  FROM employees e
  JOIN departments d 
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id  
  JOIN regions r
    ON c.region_id = r.region_id
 WHERE e.employee_id = 100; 

-- 7-9. 사원 ID, last_name, 부서 ID, 부서명, location_id, street_address, country_id, 
-- country_name, region_id, region_name, job_id, job_title, start_date  
-- 조건 : 사원 ID가 101번인 사원
-- (사원정보, 부서정보, 위치정보, 국가정보, 지역정보, 직무정보(현재), 직무history(이전))
-- 직무 history 테이블의 start_date : '97/09/21'의 모든 정보 
-- 방법1. EQUI JOIN 
SELECT  e.employee_id    "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "위치 ID"
     , l.street_address  "도로명 주소"
     , c.country_id      "국가 ID"
     , c.country_name    "국가명"
     , r.region_id       "지역 ID"
     , r.region_name     "지역명"
     , j.job_id          "직무 ID"
     , j.job_title       "직무명"
     , jh.start_date     "직무 시작일"
  FROM employees e
     , departments d
     , locations l
     , countries c
     , regions r
     , jobs j
     , job_history jh
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND e.job_id = j.job_id
   AND j.job_id = jh.job_id
   AND jh.start_date = '97/09/21'; 

-- 방법 2. INNER JOIN
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
     , l.location_id     "위치 ID"
     , l.street_address  "도로명 주소"
     , c.country_id      "국가 ID"
     , c.country_name    "국가명"
     , r.region_id       "지역 ID"
     , r.region_name     "지역명"
     , j.job_id          "직무 ID"
     , j.job_title       "직무명"
     , jh.start_date     "직무 시작일"
  FROM employees e
  JOIN departments d 
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id  
  JOIN regions r
    ON c.region_id = r.region_id
  JOIN jobs j
    ON e.job_id = j.job_id
  JOIN job_history jh
    ON j.job_id = jh.job_id  
 WHERE jh.start_date = '97/09/21'; 

-- ///////////////////////////////////////////////////////////////////////////////////////////
-- // 2. Outer join  //
-- 두 테이블간 조인 수행에서 조인 기준열의 어느 한쪽이 null이어도 강제로 출력하는 방식을
-- 외부조인(outer join)이라고 한다.

-------------------------------------------------------------
-- [LEFT OUTER JOIN ]
-- : 왼쪽 테이블의 모든 값이 출력되는 조인 (null 포함)
-- 문법 : WHERE table1.col1 = table2.col1(+)
--        또는 FROM table1 LEFT OUTER JOIN table2 ON 조인조건식

-- [LEFT OUTER JOIN 실습]
-- 7-10. 부서 테이블의 부서 ID와 사원 테이블의 부서 ID를 join한다. 
-- 조건 | 부서 테이블 부서 ID : 10~270 조회, 사원 테이블 부서 ID : 1~110 조회(null 포함) 
-- 방법 1. WHERE table1.col1 = table2.col1(+)
SELECT d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
     , employees e
 WHERE d.department_id = e.department_id(+)  -- + 기호를 통해 한쪽이 null이어도 데이터를 불러올 수 있다. 
 ORDER BY d.department_id;

-- 방법 2. FROM table1 LEFT OUTER JOIN table2 ON 조인조건식
SELECT d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
  LEFT OUTER JOIN employees e
    ON d.department_id = e.department_id  -- LEFT OUTER JOIN를 통해 한쪽이 null이어도 데이터를 불러올 수 있다. 
ORDER BY d.department_id;

------------------------------------------------------------
-- [RIGHT OUTER JOIN]
-- : 오른쪽 테이블의 모든 값이 출력되는 조인 (null 포함)
-- 문법 : WHERE table1.col1(+)  = table2.col1
--        또는 FROM table1 RIGHT OUTER JOIN table2 ON 조인조건식

-- [RIGHT OUTER JOIN 실습]
-- 7-11. 부서 테이블의 부서 ID와 사원 테이블의 부서 ID를 join한다. 
-- 조건 | 부서 테이블 부서 ID : 1~110 조회(null 포함), 사원 테이블 부서 ID : 1~110 조회(null 포함) 
-- 방법 1.WHERE table1.col1(+)  = table2.col1
SELECT d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
     , employees e
 WHERE d.department_id(+) = e.department_id  -- + 기호를 통해 한쪽이 null이어도 데이터를 불러올 수 있다. 
ORDER BY d.department_id;

-- 방법 2. FROM table1 RIGHT OUTER JOIN table2 ON 조인조건식
SELECT d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
  RIGHT OUTER JOIN employees e
     ON d.department_id = e.department_id  --  RIGHT OUTER JOIN를 통해 한쪽이 null이어도 데이터를 불러올 수 있다. 
ORDER BY d.department_id;

-------------------------------------------------------------
-- [FULL OUTER JOIN] 
-- : 왼쪽 외부 조인과 오른쪽 외부 조인이 합쳐진 것 (null 포함)
-- 형식 : FROM table1 FULL OUTER JOIN table2 ON 조인조건식

-- [FULL OUTER JOIN 실습] 
-- 7-12. 부서 테이블의 부서 ID와 사원 테이블의 부서 ID를 join한다. 
-- 방법1. d.department_id(+) = e.department_id(+) error
SELECT d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
     , employees e
 WHERE d.department_id(+) = e.department_id(+) -- NG에러
 ORDER BY d.department_id; 
-- [에러 발생]
-- https://docs.oracle.com/error-help/db/ora-01468/01468. 00000 -  "a predicate may reference only one outer-joined table"
-- *Cause:    A predicate in the WHERE clause had two columns from
--           different tables with "(+)".
 
-- 방법2. FROM table1 FULL OUTER JOIN table2 ON 조인조건식
SELECT d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
 FULL OUTER JOIN employees e
    ON d.department_id = e.department_id   -- 10~110 + NULL 1건
 ORDER BY d.department_id;

-- ///////////////////////////////////////////////////////////////////////////////////////////
-- // [3. SELF JOIN (자체 조인)]  //
-- 자기 자신과 조인하므로 1개의 테이블을 사용한다. 
-- 별도의 문법이 있는 것은 아니고 1개로 조인하면 자체 조인이 된다.

-- [3. SELF JOIN 실습] 
-- 7-13. 사원 ID, 사원명, 매니저 ID, 매니저명, 매니저 사원 ID 조회.
-- 방법1. EQUI JOIN
SELECT e.employee_id "e.사원 ID"  
     , e.last_name || '-' || e.first_name "e.사원명" 
     , e.manager_id "e.매니저 ID" 
     , m.last_name || '-' || m.first_name "m.매니저명" 
     , m.employee_id "m.매니저 사원 ID" 
  FROM employees e   -- 사원 테이블
     , employees m   -- 사원 테이블(매니저 테이블로 사용)
 WHERE e.manager_id = m.employee_id    -- 매니저 ID와 사원 ID 대입
   AND e.employee_id IN (143, 124); 
  
-- 방법2. INNER JOIN
SELECT e.employee_id "e.사원 ID"  
     , e.last_name || '-' || e.first_name "e.사원명" 
     , e.manager_id "e.매니저 ID" 
     , m.last_name || '-' || m.first_name "m.매니저명" 
     , m.employee_id "m.매니저 사원 ID" 
  FROM employees e        -- 사원 테이블
 INNER JOIN employees m   -- 사원 테이블(매니저 테이블로 사용)
    ON e.manager_id = m.employee_id   -- 매니저 ID와 사원 ID 대입  
 WHERE e.employee_id IN (143, 124);

-- ///////////////////////////////////////////////////////////////////////////////////////////
-- // [4. CROSS JOIN (상호 조인, 교차 조인)] //
-- 한쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인시키는 기능이다.

-- 상호 조인 결과의 전체 행 개수는 두 테이블의 각 행의 개수를 곱한 수만큼 된다.
-- 두 테이블의 모든 행이 각각 한 번씩 조인되어 모든 경우의 수를 조합한 조인 데이터가 출력된다.  
-- 카티션 곱(CARTESIAN PRODUCT)라고도 한다.

-- [CROSS JOIN 실습]
-- 7-14. 사원 ID, last_name, 부서 ID, 부서명 조회 
SELECT e.employee_id     "e.사원 ID"
     , e.last_name       "e.이름"
     , d.department_id   "d.부서 ID"
     , d.department_name "d.부서명"
  FROM employees e
 CROSS JOIN departments d;
-- 총 2889개의 데이터가 조회됨
