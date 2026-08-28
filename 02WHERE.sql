-- [WHERE]

-- 1. 조건 지정

SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG';

-- 예제1) 직원ID가 105인 직원의 FIRST_NAME, LAST_NAME 출력
SELECT FIRST_NAME, LAST_NAME
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 105;

-- 예제2) 부서ID가 50인 직원의 직원 ID와 부서 ID를 출력
SELECT EMPLOYEE_ID, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50;
-- ** 주의사항 ) SQL에서 비교는 등호 1개(파이썬은 ==, 여기선 =)
--              직원ID와 부서ID는 자료형이 NUMBER형
-- 예제2 캡쳐해서 단톡방 업로드하기!


-- 2. 비교 연산자 (>, >=, <, <=)
-- 직원 테이블에서 급여가 5000 이하인 사람들의 이름과 급여 출력
SELECT FIRST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY <= 5000;
 
 -- 직원 테이블에서 연봉이 50000 이하인 사람들의 이름과 연봉을 출력
 -- 단, 연봉은 'Annsal' 이라는 별칭으로 출력
SELECT FIRST_NAME
        , SALARY * 12 AS "Annsal"
  FROM EMPLOYEES
 WHERE SALARY * 12 <= 50000; -- 실행순서가 FROM이 1, WHERE가 2, SELECT가 3이기 때문에
                             -- WHERE 절에 별칭을 쓸수가 없다(Annsal <= 50000)이렇게 못함


-- 3. 등가비교연산자 (~가 아니다.)
-- !=, ^=, <>, NOT =      성능차이는 없고 네개중 골라 쓰면 됨

SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID != 50;
 
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID ^= 50;
 
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID <> 50; --이게 제일 많이 쓰임
 
SELECT *
  FROM EMPLOYEES
 WHERE NOT DEPARTMENT_ID = 50; --앞에 NOT붙어있음 주의
 
 -- 기본적으로 성능차이는 없으나, <> 를 가장 많이 사용한다. 자격증 시험에서 많이 나옴
 
 -- 예제) JOB_ID가 FI-ACCOUNT가 아닌 직원의 이름과 JOB_ID를 출력
SELECT FIRST_NAME, JOB_ID
  FROM EMPLOYEES
 WHERE JOB_ID <> 'FI_ACCOUNT'; -- 비교하는 문자열은 반드시 ''로 감싸줘야함. 안그러면 컬럼으로 인식함
 -- 예제) 급여가 10000 미만이 아닌 직원의 이름과 급여를 출력
SELECT FIRST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 10000;
 
-- 4. 논리연산자 -> 조건식이 여러개일때 사용
-- AND  => 둘 다 만족
-- OR   => 둘 중 하나 만족

--JOB_ID가 IT_PROG 와 FI-ACCOUNT가 아닌 직원의 이름과 JOB_ID를 출력
SELECT FIRST_NAME, JOB_ID
  FROM EMPLOYEES
 WHERE JOB_ID <> 'FI_ACCOUNT'
   AND JOB_ID <> 'IT_PROG';
   

-- 예제 1) 직원 테이블에서 부서 ID가 90이고, 급여가 5000 이상인 직원의 ID 와 이름을 출력
SELECT EMPLOYEE_ID, FIRST_NAME
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 90
   AND SALARY >= 5000;
   
--      2) 부서 ID가 100이거나, 입사일이 16년 02월 02일 이후에 입사한 직원의 이름과
--         입사일, 부서 ID를 출력 (** 날짜의 형식 : '16/02/02')
SELECT FIRST_NAME, HIRE_DATE, DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 100
    OR HIRE_DATE >= '16/02/02';

--      3) 부서 ID가 100이거나, 50인 직원 중 연봉이 10000이상인 직원의 ID와 이름
--          그리고 연봉을 출력하시오 ( 이 때 연봉은 ANNSAL 이라는 별칭 사용)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY*12 AS "ANNSAL"
  FROM EMPLOYEES
 WHERE (DEPARTMENT_ID = 100 
    OR DEPARTMENT_ID = 50) -- AND가 OR보다 우선순위여서 괄호를 쳐야한다.
   AND SALARY*12 >= 10000; 
   
-- AND 연산자는 OR 연산자보다 힘이 강하기 때문에 먼저 진행
-- 만약 OR 연산자를 먼저 진행하고 싶다면 ()괄호를 이용할 것! (2+2)*2 랑 같은느낌


-- 5. IS NULL, IS NOT NULL
-- NULL 이 가질 수 있는 유일한 연산자

-- 핸드폰 번호가 NULL인 직원의 이름과 핸드폰번호를 출력
SELECT FIRST_NAME, PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER IS NULL;
 
-- NULL 이 아닌 직원들
SELECT FIRST_NAME, PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER IS NOT NULL;
 
/* 엔터 쳐도 안풀리는 장문 주석*/
/*
    SQLD/정보처리기사에 나올 만한 문제
    다음 중 올바른 식은? 정답 : (4) 
    풀이 : NULL값이 쓸수 있는 연산자는 밑에서 IS NOT뿐
    1. SELECT * FROM 직원 WHERE 나이 = NULL
    2. SELECT * FROM 직원 WHERE 나이 != NULL
    3. SELECT * FROM 직원 WHERE 나이 ^= NULL
    4. SELECT * FROM 직원 WHERE 나이 IS NOT NULL
    5. SELECT * FROM 직원 WHERE 나이 <>= NULL

*/


-- 6. IN 연산자

-- 부서 ID가 30, 50, 90인 대상의 정보를 출력하고 싶을 때?
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 30
    OR DEPARTMENT_ID = 50
    OR DEPARTMENT_ID = 90;
    
-- IN 연산자는 = + OR  을 합친구조
SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID IN (30,50,90); --()안에 숫자 값을 추가할수 있어서 편함
                                    --()안에 NULL값 넣어도 변하는게 없음
-- IN 연산자 안에 NULL을 넣으면 아무일도 일어나지 않음
-- OR DEPARTMENT_ID = NULL  => 이 틀린식이기 때문. 왜나하면 NULL은(IS NULL, IS NOT NULL제외) 연산자를 쓸수 없어서
-- 그 문장은 FALSE 지만, OR연산자로 엮여있는 나머지 구문들을 실행한다.



-- 7. NOT IN 연산자 : 입력된 조건 값을 제외한 대상 출력
-- NOT은 부정의 의미, 부정은 모든 것을 반대로 만들어준다
-- 즉, =는 <>가 되고, OR는 AND로 변한다
-- NOT IN => <> AND
-- 괄호속에 있는건 전부 아니다

SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID NOT IN (30,50,90);
 
 -- NULL을 추가한다면?
 SELECT *
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID NOT IN (30,50,90, NULL);
 
-- 아무것도 안나온다. 왜냐하면 NULL은 존재하지 않는 값으로 비교가 불가능하기 때문
-- DEPARTMENT_ID <> NULL => FALSE ! 
-- OR 연산자는 NULL값 하나가 FALSE라도 나머지 TRUE값이 출력 되는데 AND 연산자는 하나라도 FALSE면 전부 FALSE가 되기 때문에 데이터가 나오지 않음  
-- 그래서 NOT IN을 쓸때는 NULL값 사용에 더욱 주의해야 한다.


-- 실습
-- 매니저ID가 100이거나 120인 직원의 이름과 매니저ID를 출력
SELECT FIRST_NAME, MANAGER_ID
  FROM EMPLOYEES
 WHERE MANAGER_ID IN(100, 120);
-- JOB_ID가 AD_VP이거나 ST_MAN인 사람의 이름과 JOB_ID 출력
SELECT FIRST_NAME, JOB_ID
  FROM EMPLOYEES
 WHERE JOB_ID IN('AD_VP','ST_MAN');
-- 매니저ID가 145, 146, 147, 148, 149이 아닌 직원의 이름과 매니저ID출력
SELECT FIRST_NAME, MANAGER_ID
  FROM EMPLOYEES
 WHERE MANAGER_ID NOT IN(145,146,147,148,149);
 
 
 
-- 8. BETWEEN : 범위조건 연산자
-- 범위를 지정할 수 있다!

-- 급여가 10000~ 19999까지 인 직원들을 출력
SELECT FIRST_NAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 10000 AND 19999;
 

-- 2005년에 입사한 직원들을 출력
SELECT FIRST_NAME, HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE BETWEEN '05/01/01' AND '05/12/31';
 


-- 9. LIKE : 특정 조건을 검색할 때 사용
-- 와일드카드 % : 문자 대체

-- 컬럼 LIKE '문자%' : 문자로 시작하는 데이터를 검색. S 글자수는 상관X
-- 이름이 S로 시작하는 직원 출력
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'S%';


-- 컬럼 LIKE '%문자' : 문자로 끝나는 데이터를 검색
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%s'; --이름 끝자리는 소문자니까 소문자로 구별해서 써야함
 
 
-- 컬럼 LIKE '%문자%' : 해당 문자를 포함하는 데이터를 검색
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '%s%' -- 소문자니까 대문자 S로 시작하는 값은 안나옴
    OR FIRST_NAME LIKE '%S%'; -- 이렇게 하면 됨



-- 와일드 카드 _ : 글자수 지정

-- 직원 아이디가 1로 시작하는 직원을 출력
SELECT EMPLOYEE_ID
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID LIKE '1__';  
 
 
-- 직원 아이디 중간에 1이 들어가는 직원을 출력
SELECT EMPLOYEE_ID
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID LIKE '_1_';   


-- 직원 아이디가 1로 끝나는 직원을 출력
SELECT EMPLOYEE_ID
  FROM EMPLOYEES
 WHERE EMPLOYEE_ID LIKE '__1';
 
 
 
-- 실습
-- 1. 650으로 시작하는 핸드폰 번호를 가진 직원의 이름과 핸드폰 번호 출력
SELECT FIRST_NAME, PHONE_NUMBER
  FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '650%';
 
-- 2. 이름이 S로 시작하고 n으로 끝나는 직원의 이름을 출력
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE 'S%'
   AND FIRST_NAME LIKE '%n'; -- WHERE FIRST_NAME LIKE 'S%n' 이렇게 해도 됨
 
-- 3. 이름에 두번째 글자가 e인 직원의 이름을 출력
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE FIRST_NAME LIKE '_e%';
 
-- 4. 01월에 입사한 직원을 찾기
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE HIRE_DATE LIKE '___01___'; -- '___01%' 이렇게 써도 됨
                                  -- 날짜는 /이것도 숫자 세면 됨                                  
