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
