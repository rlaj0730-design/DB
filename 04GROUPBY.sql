/* =============================================================================
 
    4. Groupby / Having / Orderby
    - GROUP BY : 특정 컬럼 기준으로 여러 행을 하나로 묶을 때 (그룹별 집계)
    - HAVING : 그룹화된 결과 중에서 원하는 그룹만 필터링할 때
    - ORDER BY : 결과를 특정 컬럼 기준으로 정렬할 때 (오름차순/내림차순)
    
    -- SQL 문장은 우리가 적은 순서대로 실행되지 않는다.
    
    [실행 순서]
    1) FROM         : 어느 테이블에서 데이터를 가져올지
    2) WHERE        : 그 중 원하는 행만 걸러낸다. (그룹화 전)
    3) GROUP BY     : 남은 행들을 특정 컬럼 기준으로 그룹화시킨다.
    4) HAVING       : 그룹화된 결과 중 원하는 그룹만 필터링시킨다.
    5) SELECT       : 화면에 출력할 컬럼을 고른다.
    6) OREDER BY    : 마지막으로 정렬을 시켜준다(오름차순/내림차순)
    
    [우리가 꼭 기억해야할 것!]
    WHERE : 그룹화하기 전 조건
    HAVING : 그룹화 후 조건
 
==============================================================================*/

-- GROUP BY : 특정 컬럼을 기준으로 집계를 내는데 사용한다.
-- 여러 개의 행을 그룹으로 묶어서 그룹당 딱 1줄로만 표시를 해준다.

-- [1단계 실습] 부서 ID만 조회해보자.
SELECT DEPARTMENT_ID
  FROM EMPLOYEES;
  
-- [2단계 실습] GROUP BY를 사용해보자.
-- 중복된 값 하나로 묶어주기
SELECT DEPARTMENT_ID
  FROM EMPLOYEES
  GROUP BY DEPARTMENT_ID;
--> 중복된 DEPARTMENT_ID가 하나로 합쳐짐(널값 제외 부서가 11개라는걸 알수있음)
-- GROUP BY의 핵심 : 중복되는 값을 기준으로 여러 행을 1줄로 뭉쳐주는 것

-- GROUP BY 문법
-- 1. SELECT 가져올 컬럼
-- 2. FROM 가져올 테이블
-- 3. GROUP BY 그룹화할 컬럼;

-- [집계함수 종류] SUM, COUNT, MIN, MAX, AVG 등
-- 단일행 함수 : 행 1개 넣으면 결과 1개 (예: UPPER, ROUND ...)
-- 다중행 함수(=집계함수) : 행 여러 개를 넣어서 결과 1개로 뭉쳐줌 (예: AVG, SUM ...)

-- [실습1] 부서별로 평균 급여 출력, 소수점 1자리까지 조회를 해볼 겁니다.
-- 평균 : AVG, 소수점 1자리 : ROUND 사용 
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY), 1)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
 
-- [실습2] 부서별로 급여가 제일 높은 사람과 제일 낮은 사람을 조회해보자.
-- 최고 급여 : MAX, 최저 급여 : MIN
SELECT DEPARTMENT_ID, MAX(SALARY) AS "최고 급여",
                      MIN(SALARY) AS "최저 급여"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
-- GROUP BY DEPARTMENT_ID : 부서별로 행을 묶음
-- MAX, MIN : 묶인 그룹 안에서 제일 큰 값 / 제일 작은 값 조회

-- HAVING : GROUP BY로 그룹화된 결과 중에서, 원하는 그룹만 골라내는 문법
-- WHERE -> 그룹화 하기 전 조건
-- HAVING -> 그룹화 한 다음에 조건

-- 기본 문법
-- 1. SELECT GROUP BY 컬럼, 집계함수
-- 2. FROM 가져올 테이블
-- 3. GROUP BY 그룹화할 컬럼
-- 4. HAVING 그룹에 대한 조건;

-- [1단계] HAVING 사용하지 않고 부서별 최고 연봉부터 눈으로 확인
SELECT DEPARTMENT_ID, MAX(SALARY*12) AS "연봉"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
-- 부서별로 연봉이 10만이 넘는 부서만 조회하고 싶다면?

-- [2단계] 10만이 넘는 부서만 조회를 하고 싶을 땐 HAVING만 추가해주면 된다.
SELECT DEPARTMENT_ID, MAX(SALARY*12) AS "연봉"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY*12) >= 100000;
-- GROUP BY DEPARTMENT_ID : 먼저 부서별로 그룹화를 시켜준다.
-- HAVING MAX(SALARY*12) >= 100000; : 그룹화를 한 다음에 급여가 100,000이상인 부서만 조회!

-- [왜 WHERE절에서는 집계함수를 못 쓸까?]
-- WHERE는 GROUP BY보다 먼저 실행됩니다. (실행순서 1번 참고)
-- 근데 그 시점엔 아직 그룹화가 안 됐으니까, "평균/최고"라는 개념 자체가 존재하지 않음!
-- 그래서 그룹화가 끝난 다음 단계인 HAVING에서 집계함수로 조건을 걸 수 있습니다.

-- 정리 : WHERE  - 그룹화 전, 개별 행에 조건을 걸 때 사용 (집계함수 X)
--        HAVING - 그룹화 후, 집계 결과에 조건을 걸 때 사용 (집계함수 O)

-- [실습] 부서별로 평균 급여를 출력을 하되, DEPARTMENT_ID 중에 NULL을 제외하고 조회해보자.
-- NULL을 제외할 수 있는 것 : IS NOT NULL;
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),1) AS "평균급여"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL;
-- 부서 배정이 안 된(DEPARTMENT_ID가 NULL) 직원은 그룹에서 제외!


-- ORDER BY - 결과 정렬
-- 특정 컬럼을 기준으로 결과를 정렬할 때 사용한다. (오름차순/내림차순)
-- 오름차순 : ASC (작은 값 -> 큰 값, 처음 기본값으로 적용되어있음)
-- 내림차순 : DESC (큰 값 -> 작은 값)

-- [실습] 사원번호를 출력을 하되, 급여가 낮은 순으로 정렬
SELECT EMPLOYEE_ID, SALARY -- 사원 (직원)번호 컬럼
  FROM EMPLOYEES 
 ORDER BY SALARY; -- 급여를 낮은 순으로 정렬 -> 오름차순 -> ASC -> 기본값!

-- [실습] SALARY AS 사용!
SELECT EMPLOYEE_ID, SALARY AS "급여"
  FROM EMPLOYEES
 ORDER BY "급여"; -- WHERE이랑 다르게 오더 바이는 젤 마지막에 실행이 되어서 별칭을 가져와도 됨

-- [실습] 부서별 연봉 합계를 구한 다음에 연봉이 높은 순으로 정렬을 해보자!
-- 내림차순 : DESC, 연봉 합계 : SUM
SELECT DEPARTMENT_ID, SUM(SALARY*12) AS "연봉"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY "연봉" DESC;
 
 
-- 방법 1. 부서별로 몇 명이 있는지 세는 방법!
-- 잘못된 방법
SELECT DEPARTMENT_ID, COUNT(DEPARTMENT_ID) AS "사원수"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
-- 이렇게 하면 부서가 정해지지 않은(NULL) 사원수가 나오지 않음

-- 방법 2. 부서별로 몇 명이 있는지 세는 방법!
-- 옳은 방법
SELECT DEPARTMENT_ID, COUNT(*) AS "사원수"
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID;
-- COUNT(DEPARTMENT_ID) : NULL을 제외하고 행을 셈
-- COUNT(*) : NULL 여부와 상관없이 모든 행을 센다.

/* =============================================================================

    이번 시간 배운 내용 정리
    실행 순서 복습
    1. FROM
    2. WHERE
    3. GROUP BY
    4. HAVING
    5. SELECT
    6. ORDER BY
    
    GROUP BY : 특정 컬럼을 기준으로 여러 행을 그룹당 1줄씩 묶을 때(중복값이 하나로 합쳐진다)
    HAVING   : 그룹화 한 다음에 조건 필터링, WHERE : 그룹화 하기 전 조건 필터링
    ORDER BY : 결과를 정렬할 때 사용한다! ASC(오름차순, 기본값) DESC(내림차순)
               --> SELECT 컬럼 별칭을 지정해줬을 때 ORDER BY 에서는 SELECT에서 사용한
                   컬럼 별칭을 사용할 수 있다!
                   왜냐하면 실행순서가 ORDER BY가 SELECT보다 뒤에 있기 때문에!
                   
==============================================================================*/

