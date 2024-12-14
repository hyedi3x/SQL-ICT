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
SELECT  d.department_name "d.부서명"
     , e.employee_id     "e.사원 ID"
     , d.department_id   "d.부서 ID"
     , e.department_id   "e.부서 ID"
  FROM departments d
 FULL OUTER JOIN employees e
    ON d.department_id = e.department_id   -- 10~110 + NULL 1건
 ORDER BY d.department_id;
