-- // 13. COALESCE 함수 //
-- : COALESCE의 () 로 감싼 안의 인자들을 첫번째자리부터 비교를 하며, 
--   NULL을 만나면 다음 자릿수로 미룬다.
-- * 문법 : COALESCE(표현식1, 표현식2,..표현식n)

-- 13.1 COALESCE () 안에 값을 다양하게 두고, 값을 조회한다. 
-- 첫 번째 인자가 NULL이므로 두 번째 인자 값인 1이 반환된다. 
SELECT COALESCE(NULL, 1, 2) "NULL, 1, 2"
  FROM dual;

-- 첫 번째와 두 번째 인자가 NULL이므로, 세 번째 인자 값인 2가 반환된다. 
SELECT COALESCE(NULL, NULL, 2) "NULL, NULL, 2"
  FROM dual;

-- 첫 번째 인자가 NULL이 아니므로 1이 반환된다.   
SELECT COALESCE(1, 2, NULL) "1, 2, NULL"
  FROM dual;
  