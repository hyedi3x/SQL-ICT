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