/*==============================================================================

    5. JOIN
    -- 서로 다른 테이블 2개 이상을 공통된 값(컬럼)을 기준으로 옆으로 이어 붙이는 거
    -- GROUP BY는 "세로로 여러 행을 하나로 뭉치는 거" 였다면
    -- JOIN은 "가로로 여러 테이블을 하나로 이어붙이는 거"라고 생각하면 된다.
    
==============================================================================*/

-- 왜 JOIN이 필요할까? 
-- 1단계. 직원ID와 부서ID를 조회해보자.
SELECT EMPLOYEE_ID, DEPARTMENT_ID
  FROM EMPLOYEES;
  
-- 2단계. 부서명은 다른 테이블에 존재한다.
SELECT *
  FROM DEPARTMENTS;
  
-- 문제점 : 직원 정보랑 부서명 테이블이 서로 다른 테이블에 존재하고 있다.
-- 3단계. EMPLOYEES라는 테이블과 DEPARTMENTS라는 테이블에 공통된 컬럼이있다.(DEPARTMENT_ID)
-- DEPARTMENT_ID 를 가지고 조인 시켜보자
SELECT EMPLOYEES.EMPLOYEE_ID, EMPLOYEES.DEPARTMENT_ID, DEPARTMENTS.DEPARTMENT_ID  --조인시켜줄땐 어디테이블에서 어떤컬럼을 가져왔는지 표시 해줘야함
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
  
SELECT E.EMPLOYEE_ID, E.DEPARTMENT_ID, D.DEPARTMENT_NAME -- 근데 테이블명, 컬럼명 같이 적으면 너무 기니까 옆처럼 별칭을 지정해서 사용한다
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
-- EMPLOYEES에 있는 DEPARTMENT_ID라는 컬럼과
-- DEPARTMENTS에 있는 DEPARTMENT_ID라는 컬럼을 이어붙히겠다!
-- 어떤 컬럼을 기준으로 이어붙일지! (두 테이블의 연결 고리)가 무엇인지 생각하면 좋다

-- 오라클 문법/ ANSI 문법
-- 오라클 문법 : 오라클에서 사용하는 전통 SQL 문법
-- => 테이블을 FROM에 나열하고, JOIN 조건을 WHERE에다가 작성한다.

-- ANSI 문법 : 여러 DB에서 공통으로 사용할 수 있도록 만든 표준 SQL 문법
-- JOIN ~ ON 이런 키워드를 가지고 테이블 연결 조건을 작성할 수 있다.

-- E, D는 무엇일까?
-- 별칭 -> ALIAS(AS)
-- 두 테이블 모두 DEPARTMENT_ID라는 "같은 이름의 컬럼"이 존재한다는 걸 확인!
-- 그래서 그냥 DEPARTMENT_ID라고만 쓴다면 오라클에서 "어느 테이블 거를 말하는 거야?"하면서 헷갈릴 수 있다.
-- 그래서 테이블 이름 뒤에 별칭을 붙여서 구분을 한다.

-- JOIN을 사용하게 된다면 FROM에다가 테이블 별칭을 정해주는 걸 습관화하자!

-- JOIN 문법
-- SELECT ...
-- FROM 테이블1 별칭1, 테이블2 별칭2
-- WHERE 별칭1.컬럼 = 별칭2.컬럼 => 같은 컬럼끼리 연결 조건 걸어주기.

-- [실습] 직원 이름, 부서 이름, 부서별 급여를 같이 출력해 보자.
SELECT E.FIRST_NAME,D.DEPARTMENT_NAME, E.SALARY 
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY SALARY DESC;

/*==============================================================================

    JOIN의 종류!
    1. INNER JOIN : 양쪽 테이블에 모두 연결되는 데이터만 출력할 때(위에서 한거)
    2. LEFT JOIN  : 왼쪽 테이블은 모두 출력, 오른쪽은 연결되는 데이터만 출력
    3. RIGHT JOIN : 오른쪽 테이블은 모두 출력, 왼쪽은 연결되는 데이터만 출력
    4. FULL JOIN  : 양쪽 테이블의 데이터를 모두 출력할 때
    5. SELF JOIN  : 하나의 테이블을 자기 자신과 연결할 때

==============================================================================*/  
  
-- LEFT JOIN : 왼쪽 테이블은 모두 출력, 오른쪽은 연결되는 데이터만 출력할 때

-- 실습. EMPLOYEES의 직원은 모두 출력하고, 연결되는 부서가 없으면 NULL로 출력해보자.
-- EMPLOYEES의 직원은 모두 출력을 해야된다.
-- DEPARTMENT 테이블은 NULL로 출력을 해야된다.
-- (+)
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);
-- EMPLOYEES -> 모두 출력
-- DEPARTMENTS -> NULL로 출력을 해야된다 -> (+)
-- 왼쪽 테이블을 모두 살리고 싶고, 없어도 되는 오른쪽 테이블에 (+)만 붙이면 된다.

-- RIGHT JOIN - 오른쪽 테이블은 모두 출력, 왼쪽은 연결되는 데이터만 출력할 때
-- 실습. DEPARTMENTS의 부서는 모두 출력을 하고, 연결되는 직원이 없다면 NULL로 출력해보자.
SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID;
-- DEPARTMENTS 라는 테이블은 반드시 모두 출력을 해야한다.
-- EMPLOYEES 라는 테이블은 모자란 만큼 짝을 맞춰주기 위해 NULL로 출력을 해야된다. -> (+)

-- FULL OUTER JOIN(위에 FULL JOIN이랑 같은말)
-- 오라클 문법에서는 사용을 못합니다.
-- ANSI 문법을 통해서 사용을 해야된다.
-- 왼쪽 테이블과 오른쪽 테이블의 데이터를 모두 출력하는 방식입니다.
-- 기본 문법
SELECT 조회할 컬럼
  FROM 테이블1
  FULL OUTER JOIN 테이블2
    ON 테이블1. 공통컬럼 = 테이블2.공통컬럼; 
-- 오라클 문법에서는 FULL OUTER JOIN을 왜 못쓸까?
-- 참고 : (+)는 한 쪽만 살릴 때 사용하는 방식이었다.
-- 양쪽을 동시에 살리는 FULL OUTER JOIN 같은 경우는 ANSI문법을 사용해야 된다.

-- SELF JOIN : 하나의 테이블을 자기 자신과 연결하는 방식이다.
-- 기본 문법
SELECT A.컬럼,
       B.컬럼
FROM A테이블 A, A테이블 B
WHERE A.연결컬럼 = B.연결컬럼;

-- 예시 : 직원과 그 직원의 매니저 조회

SELECT E.LAST_NAME AS 직원,
       M.LAST_NAME AS 매니저
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID;
--> MANAGER_ID에 들어있는 값이 EMPLOYEE_ID와 같기 때문에

------------------------------------
SELECT LAST_NAME, MANAGER_ID
FROM EMPLOYEES;
--> 문제점 : 매니저가 누구인지 이름으로 알 수 없고 번호만 보임!


/* ============================================================================
    JOIN 한 번에 정리
============================================================================ */

-- INNER JOIN
-- -> 양쪽에 짝이 있는 데이터만 출력

-- LEFT JOIN 역할
-- -> 왼쪽 테이블은 모두 출력
-- -> 없어도 되는 오른쪽 테이블에 (+)

-- RIGHT JOIN 역할
-- -> 오른쪽 테이블은 모두 출력
-- -> 없어도 되는 왼쪽 테이블에 (+)

-- FULL OUTER JOIN 역할
-- -> 양쪽 데이터를 모두 출력
-- -> Oracle (+) 문법만으로는 한 번에 표현 불가

-- SELF JOIN
-- -> 하나의 테이블을 자기 자신과 연결