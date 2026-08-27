-- 주석
-- SQL 문장은 대소문자 구분 X (웬만하면 대문자 쓰는게 국룰)
-- 띄어쓰기와 줄바꿈은 명령어 수행에 영향을 미치지 않음
-- SQL 을 마무리 하려면 반드시 끝에 세미콜론(;)을 붙여야 가능
-- 실행하고 싶으면 실행하려는 SQL 문장을 클릭하고 CTRL + ENTER / F9 둘중 하나 하면 됨


-- [SELECT]
-- SELECT 출력하고 싶은 컬럼
--   FROM 데이터를 가져올 테이블

-- 1. 전체 컬럼 출력(현업에서는 비밀번호 노출 등의 문제가 있어서 전체 컬럼출력은 잘 안쓴다)
-- * : 애스터리스크 -> 전체를 의미
SELECT *
  FROM EMPLOYEES;
 
 SELECT *
   FROM DEPARTMENTS;
   
-- 2. 원하는 컬럼 출력
SELECT FIRST_NAME, LAST_NAME
  FROM EMPLOYEES;
  
-- 예제) 직원(EMPLOYEES) 테이블에서 직원의 ID, 직원의 이름 (FIRST_NAME), 입사일 출력하기
--      컬럼명 잘 모르겠을땐 전체 출력 먼저 하고, 문제 풀이 하기!
--      다 됐으면 질의 결과 캡쳐해서 단톡방에 올리기 !
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
  FROM EMPLOYEES;
  
-- 3. 중복제거(DISTINCT)
-- 우리반의 성별을 쭉 나열하면 여, 여, 남, 여 , 남, 남
-- => 중복을 제거 하면? 여1, 남1 => 종류를 알기위함

-- 컬럼이 1개인 경우
SELECT DISTINCT DEPARTMENT_ID
  FROM EMPLOYEES;

-- 컬럼이 2개인 경우, 그 컬럼 조합의 중복 제거
-- DEPARTMENT_ID가 같아도 JOB_ID가 다르면 출력됨. 두개의 조합이 다르면 출력된다.
SELECT DISTINCT JOB_ID, DEPARTMENT_ID
  FROM EMPLOYEES;

-- 예제 1) 부서테이블에서 부서ID, 부서명, 근무지 ID 출력하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID
  FROM DEPARTMENTS;

-- 예제 2) 직원테이블에서 직원들의 입사일 출력하기
SELECT HIRE_DATE
  FROM EMPLOYEES;

-- 예제 3) 직원테이블에서 직원들의 입사일을 중복없이 출력하기
SELECT DISTINCT HIRE_DATE
  FROM EMPLOYEES;
-- ** 예제 3에 대한 결과 캡쳐해서 업로드


-- 4. 별칭 지정(AS)
SELECT SALARY AS "급여"
        , SALARY*12 AS "연봉"-- 셀러리가 월급, 셀러리*12가 연봉인데 지저분하니까 별칭지정
  FROM EMPLOYEES;

-- 별칭 지정하는 네가지 방법  
SELECT EMPLOYEE_ID
        ,EMPLOYEE_ID AS 직원아이디
        ,EMPLOYEE_ID AS "직원 아이디" --중간에 띄워쓰기가 있으면 ""써야한다
        ,EMPLOYEE_ID "직원아이디"
        ,EMPLOYEE_ID 직원아이디
  FROM EMPLOYEES;
  
  
-- 예제) 우리 회사는 입사한 다음 날이 계약일입니다.
--      직원의 이름(FIRST_NAME)과 계약일을 출력하세요.
--      단, 별칭을 사용해주세요
SELECT FIRST_NAME AS "이름"
        ,HIRE_DATE + 1 AS "계약일"
  FROM EMPLOYEES;
  


-- 5. NULL(EX 쇼핑몰 회원가입시 키와 몸무게 데이터. 선택사항일때)
-- 데이터의 값이 완전히 비어있는 상태
-- 아직 정의되지 않은 값, 0이나 공백과는 다름
-- NULL 과 연산하면 결과 값 NULL


INSERT INTO EMPLOYEES(
    EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (207, '선', 'ZEROTICKET', SYSDATE,'IT_PROG');


SELECT *
  FROM EMPLOYEES;
  
COMMIT; --티씨엘 파트에서 배울건데 저장한다는 뜻. 새로 넣은 데이터를 유지한다는 뜻

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, SALARY*12 --NULL을 연산하면 NULL이 나옴
  FROM EMPLOYEES;
  