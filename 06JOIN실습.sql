/* JOIN 간단 복습 */

-- INNER JOIN
-- 서로 다른 테이블의 데이터를 연결해서 조회합니다.

SELECT E.LAST_NAME,
       D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- OUTER JOIN
-- LEFT OUTER JOIN, RIGHT OUTER JOIN
-- 연결되는 데이터가 없어도 출력하고 싶을 때 사용합니다.
-- (+)는 없어도 되는 쪽에 붙입니다.

SELECT E.LAST_NAME,
       D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);


-- FULL OUTER JOIN
-- 양쪽 테이블의 데이터를 모두 출력합니다.
-- 오라클 디벨로퍼에서도 ANSI문법은 사용 가능하다!

SELECT E.LAST_NAME,
       D.DEPARTMENT_NAME
  FROM EMPLOYEES E
  FULL OUTER JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- SELF JOIN
-- 하나의 테이블을 자기 자신과 연결합니다.

SELECT E.LAST_NAME AS 직원,
       M.LAST_NAME AS 매니저
  FROM EMPLOYEES E, EMPLOYEES M
 WHERE E.MANAGER_ID = M.EMPLOYEE_ID;


/*
핵심 정리

JOIN        : 연결되는 데이터 조회
OUTER JOIN  : 연결되지 않아도 출력
(+)         : 없어도 되는 쪽에 붙임
FULL JOIN   : 양쪽 모두 출력
SELF JOIN   : 같은 테이블끼리 연결
*/

/* ============================================================================
   [문제 1] 기본 연결
   모든 직원의 사번(EMPLOYEE_ID), 이름(LAST_NAME), 부서 이름(DEPARTMENT_NAME)을 출력하세요.
============================================================================ */
SELECT E.EMPLOYEE_ID AS "사번", E.LAST_NAME AS "이름", D.DEPARTMENT_NAME AS "부서 이름"
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- FROM에 EMPLOYEES(E), DEPARTMENTS(D)를 콤마로 나열하고
-- WHERE에서 DEPARTMENT_ID가 같은 것끼리 연결
-- 부서가 배정된 직원만 나옵니다 (짝이 없는 직원은 자동으로 제외됨)


/* ============================================================================
   [문제 2] 조건 추가
   부서 이름이 'IT'인 직원들의 사번, 이름, 급여를 출력하세요.
   - 사번 컬럼 : EMPLOYEE_ID
   - 이름 컬럼 : LAST_NAME
   - 급여 컬럼 : SALARY
   - 부서 이름이 IT인 컬럼의 테이블 : DEPARTMENTS
============================================================================ */
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.SALARY
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND DEPARTMENT_NAME = 'IT';
 -- 위처럼 그냥 DEPARTMENT_NAME = 'IT' 이렇게 써도 한 테이블에만 있는 컬럼값이라 괜찮지만
 -- 현업에서는 D.DEPARTMENT_NAME = 'IT' 이렇게 써주는게 가독성이 좋다
 
 
 /* ============================================================================
   [문제 5] GROUP BY + HAVING

   평균 급여가 8000 이상인 부서만,
   부서 이름과 평균 급여를 출력하세요.

   [힌트]
   1. 직원 정보와 부서 이름은 서로 다른 테이블에 있습니다.
   2. 두 테이블의 DEPARTMENT_ID를 이용해서 연결하세요.
   3. 부서별로 평균 급여를 구해야 하므로 GROUP BY가 필요합니다.
   4. 평균 급여는 AVG() 함수를 사용합니다.
   5. 그룹화 한 다음에 조건을 걸 수 있는 게 뭐였죠?! -> HAVING
============================================================================ */
SELECT D.DEPARTMENT_NAME, ROUND(AVG(E.SALARY), 1) AS "평균급여"
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
 GROUP BY DEPARTMENT_NAME
HAVING AVG(E.SALARY) >= 8000;
-- 현업에서는 만약 이름은 같지만 서로 다른 부서가 있을때 그 두 부서가 합쳐져서 급여도 합쳐질수 있으므로
-- 그룹바이에 고유식별자인 디파트먼트 아이디도 같이 넣어주는게 좋다.
-- 그리고 그룹바이에도 앞에 별칭을 붙여줘야 한다. 왜냐하면 디파트먼트 아이디는 테이블 둘다 존재하기 때문에.(D.DEPARTMENT_ID, D.DEPARTMENT_NAME 이렇게)




/* ============================================================================
   7. JOIN - 실습 문제 (EMPLOYEES / DEPARTMENTS 만 사용)

   사용 테이블 : EMPLOYEES (EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID, SALARY, JOB_ID)
                DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME)
============================================================================ */


/* ============================================================================
   [문제 1] 기본 연결
   모든 직원의 사번(EMPLOYEE_ID), 이름(LAST_NAME), 부서 이름(DEPARTMENT_NAME)을 출력하세요.
============================================================================ */

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- FROM에 EMPLOYEES(E), DEPARTMENTS(D)를 콤마로 나열하고
-- WHERE에서 DEPARTMENT_ID가 같은 것끼리 연결
-- 부서가 배정된 직원만 나옵니다 (짝이 없는 직원은 자동으로 제외됨)


/* ============================================================================
   [문제 2] 조건 추가
   부서 이름이 'IT'인 직원들의 사번, 이름, 급여를 출력하세요.
============================================================================ */

SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.DEPARTMENT_NAME = 'IT';
-- 첫 번째 WHERE 조건(E.DEPARTMENT_ID = D.DEPARTMENT_ID)은 "연결 조건"
-- AND로 이어붙인 두 번째 조건(D.DEPARTMENT_NAME = 'IT')은 "진짜 필터링 조건"
-- 연결 조건 + 필터링 조건, 둘 다 WHERE 안에 AND로 같이 씁니다


/* ============================================================================
   [문제 3] 정렬 추가
   전체 직원의 이름, 부서 이름, 급여를 급여가 높은 순으로 출력하세요.
============================================================================ */

SELECT E.LAST_NAME, D.DEPARTMENT_NAME, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY E.SALARY DESC;
-- ORDER BY는 맨 마지막에 실행되는 절이라, 연결된 결과 전체를 정렬합니다
-- DESC : 내림차순(큰 값 -> 작은 값)


/* ============================================================================
   [문제 4] GROUP BY 추가
   부서별 직원 수를 부서 이름과 함께 출력하세요.
============================================================================ */

SELECT D.DEPARTMENT_NAME, COUNT(*) AS 직원수
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;
-- WHERE로 부서 이름을 먼저 붙이고 -> GROUP BY로 부서 이름 기준으로 묶은 뒤 -> COUNT(*)로 개수를 셈
-- 순서 : 연결(WHERE) -> 그룹화(GROUP BY) -> 집계(COUNT)


```sql
/* ============================================================================
   [문제 5] GROUP BY + HAVING

   평균 급여가 8000 이상인 부서만,
   부서 이름과 평균 급여를 출력하세요.

   [힌트]
   1. 직원 정보와 부서 이름은 서로 다른 테이블에 있습니다.
   2. 두 테이블의 DEPARTMENT_ID를 이용해서 연결하세요.
   3. 부서별로 평균 급여를 구해야 하므로 GROUP BY가 필요합니다.
   4. 평균 급여는 AVG() 함수를 사용합니다.
   5. 그룹화 한 다음에 조건을 걸 수 있는 게 뭐였죠?! -> 
============================================================================ */

SELECT D.DEPARTMENT_NAME, ROUND(AVG(E.SALARY), 1) AS 평균급여
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING AVG(E.SALARY) >= 8000;

-- GROUP BY로 부서별 평균을 구한 다음,
-- HAVING으로 평균 급여가 8000 이상인 부서만 남깁니다.
```



/* ============================================================================
   [문제 6] (+) 로 짝 없는 데이터까지 다 보기
   부서가 아직 배정되지 않은 직원도 포함해서, 모든 직원의 이름과 부서 이름을 출력하세요.
   (부서가 없으면 부서 이름 자리는 비어서(NULL) 나오면 됩니다)
============================================================================ */

SELECT E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);
-- 그냥 WHERE만 쓰면 부서 없는 직원은 결과에서 빠져버리므로, "부족해도 되는 쪽"인 D에 (+)를 붙임
-- E(EMPLOYEES)는 무조건 다 살고, 짝이 없는 D.DEPARTMENT_NAME 자리는 NULL로 채워짐


/* ============================================================================
   [문제 7] (+) 활용 - 짝 없는 데이터만 골라내기
   부서가 아직 배정되지 않은 직원의 사번과 이름만 출력하세요.
============================================================================ */

SELECT E.EMPLOYEE_ID, E.LAST_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND D.DEPARTMENT_ID IS NULL;
-- (+) 를 붙이면 부서 없는 직원도 결과에 남고, 대신 D쪽 컬럼들이 전부 NULL로 채워짐
-- AND D.DEPARTMENT_ID IS NULL : "짝을 못 찾아서 NULL로 채워진 행"만 걸러내는 방법
-- (부서 없는 직원만 쏙 뽑아낼 때 자주 쓰는 패턴입니다)


/* ============================================================================
   [문제 8] 종합 - 연결 + GROUP BY + HAVING + ORDER BY
   부서별 최고 급여를 구해서, 최고 급여가 5000을 초과하는 부서만
   부서 이름과 최고 급여를 최고 급여가 높은 순으로 출력하세요.
============================================================================ */

SELECT D.DEPARTMENT_NAME, MAX(E.SALARY) AS 최고급여
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING MAX(E.SALARY) > 5000
ORDER BY 최고급여 DESC;
-- 실행 순서로 이해하면 쉽습니다
-- 1) WHERE     : 부서 이름을 붙임
-- 2) GROUP BY  : 부서별로 묶음
-- 3) HAVING    : 묶인 그룹 중 최고 급여가 5000 초과인 부서만 남김
-- 4) ORDER BY  : 마지막으로 최고 급여 내림차순 정렬


/* ============================================================================
   [참고] ANSI JOIN으로 쓰면 이렇게 됩니다 (문제 1, 6번 예시)
============================================================================ */

-- 지금까지 푼 문제는 전부 콤마 + WHERE / (+) 방식이었는데,
-- 다른 회사 코드에서는 JOIN ... ON ... 이라는 표준 문법으로 똑같은 걸 씁니다. 하는 일은 동일합니다.

-- 문제 1 (기본 연결) -> ANSI로 쓰면
-- SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_NAME
-- FROM EMPLOYEES E
-- JOIN DEPARTMENTS D
--     ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 문제 6 ((+) 로 짝 없는 데이터까지) -> ANSI로 쓰면
-- SELECT E.LAST_NAME, D.DEPARTMENT_NAME
-- FROM EMPLOYEES E
-- LEFT JOIN DEPARTMENTS D
--     ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


/* ============================================================================
   오늘 정리
============================================================================ */

-- JOIN 문제를 풀 때 순서대로 생각하는 습관을 들이면 편합니다
-- 1) 어떤 테이블 두 개를 이어붙여야 하는지 (FROM 테이블1, 테이블2)
-- 2) 무엇을 기준으로 이어붙이는지 (WHERE의 연결 조건 = 두 테이블의 연결고리)
-- 3) 조건이 더 있는지 (WHERE에 AND로 추가)
-- 4) 그룹으로 묶어야 하는지 (GROUP BY, HAVING)
-- 5) 정렬이 필요한지 (ORDER BY)
-- 부서 없는 직원까지 포함해야 하면 -> "부족해도 되는 쪽" 컬럼에 (+)
-- 양쪽 다 짝이 있는 것만 필요하면 -> (+) 없이 기본 WHERE 연결