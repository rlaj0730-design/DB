-- 함수 FUNCTION 
-- 하나의 작업을 수행하기 위해 독립적으로 설계된 프로그램 코드의 집합

-- 오렌지 -> 믹서기 -> 오렌지주스
-- 매개변수 -> 함수 -> f(x)

-- 자주 사용하기 때문에 오라클에서 제공하는 함수(내장함수)

-- 1. 문자함수(매개변수가 문자로 이루어진 함수)

-- UPPER : 대문자로 변환
-- LOWER : 소문자로 변환

SELECT FIRST_NAME
        ,UPPER(FIRST_NAME)
        ,EMAIL
        ,LOWER(EMAIL)
  FROM EMPLOYEES;
  
-- 이름에 S가 들어간 직원을 출력
SELECT FIRST_NAME
  FROM EMPLOYEES
 WHERE LOWER(FIRST_NAME) LIKE '%s%';
 

-- LENGTH : 문자열길이
SELECT FIRST_NAME
        ,LENGTH(FIRST_NAME)
  FROM EMPLOYEES
 WHERE LENGTH(FIRST_NAME) >= 8;
 
-- SUBSTR : 문자열 추출  => 자주 씀
-- SUBSTR(데이터, 시작위치) : 시작위치부터 끝까지 문자 추출
-- SUBSTR(데이터, 시작위치, 추출길이) : 시작 위치부터 추출할 길이만큼 추출
SELECT JOB_ID
       , SUBSTR(JOB_ID, 4)
       , SUBSTR(JOB_ID, 1,2)
  FROM EMPLOYEES;
  
-- 예제) 직원들의 입사일 연도, 월, 일 출력
--      각각 별칭을 입사일 / 연도 / 월 / 일로 설정
SELECT HIRE_DATE AS "입사일"
       , SUBSTR(HIRE_DATE, 1,2) AS "연도"
       , SUBSTR(HIRE_DATE, 4,2) AS "월"
       , SUBSTR(HIRE_DATE, 7,2) AS "일" --끝자리니까 7만 써도 됨
  FROM EMPLOYEES;
  

-- REPLACE 문자열 대체
SELECT HIRE_DATE
        ,REPLACE(HIRE_DATE, '/', '-') AS "하이픈"
        ,REPLACE(HIRE_DATE, '/') AS "제거"
  FROM EMPLOYEES;
  
  
-- CONCAT 문자열 합치기
SELECT CONCAT('입사일', HIRE_DATE)
  FROM EMPLOYEES;

-- CONCAT 괄호 안에 3개를 써서 합치는 건 불가능!(두개만 됨) 에러남
-- CONCAT안에 CONCAT을 넣으면 가능하다
SELECT CONCAT('입사일', CONCAT(HIRE_DATE, '입니다'))
  FROM EMPLOYEES;
  
-- || 연산자
-- 위처럼 콘캣 안에 콘캣 넣기 너무 귀찮으니까 쓰는 연산자
SELECT '입사일은' || HIRE_DATE || '입니다.'
  FROM EMPLOYEES;
  


-- 2. 숫자 함수

-- MOD : 나누고 난 후 나머지
SELECT MOD(15,6)
        ,MOD(14,2)
  FROM DUAL; -- 그냥 비어 있는 테이블
  
--DUAL : 최고 권한 관리자인 SYSTEM 소유의 테이블로, 임시 연산이나 함수의 결과값을
--     확인할 용도로 사용되는 더미 테이블
SELECT 3+3
  FROM DUAL;
  

-- ROUND : 반올림   => 를 실무에서 많이씀
-- TRUNC : 버림
-- 숫자 X : 소수점 첫째자리
-- 1 : 소수점 둘째자리
-- 2 : 소수점 셋째자리

SELECT ROUND(15.65)
        ,TRUNC(15.65)
        ,ROUND(15.65,1)-- 내가 원하는 소수점자리 반올림
        ,TRUNC(15.65,1)-- 내가 원하는 소수점 자리 버림
  FROM DUAL;
  


-- 3. 날짜함수 SYSDATE
-- 날짜를 다르게 지정하는 방법
-- 도구 > 환경설정 > 데이터베이스> NLS > 날짜형식변경 칸에 YYYY-MM--DD HH24:MI:SS 로 작성
SELECT SYSDATE AS 현재시각 -- 지금 날짜 기록
        ,SYSDATE+1 AS "하루 더함"
        ,SYSDATE+1/24 AS "한시간 더함"
        ,SYSDATE+1/24/60 AS "일분 더함"
        ,SYSDATE+1/24/60/60 AS "일초 더함"
  FROM DUAL;
  
-- ADD_MONTHS : 몇개월 이후의 날짜를 구하는 함수
SELECT SYSDATE AS "현재"
        ,ADD_MONTHS(SYSDATE, 1) AS "한달 뒤"
        ,ADD_MONTHS(SYSDATE, -1) AS "한달 전"
  FROM DUAL;
  
  
  
-- 4. 형변환 함수
-- 문자로 변경 : TO_CHAR  => 보통 날짜를 문자로 변경할때 많이 쓴다
-- 예를 들어 현업에서 사용자마다 날짜보는 방식을 설정해 놓은 값이 다르기 때문에 내가 형식을 딱 정해둘때 사용.
SELECT SYSDATE
        ,TO_CHAR(SYSDATE, 'YY/MM/DD/DAY')
  FROM DUAL;
  
-- 숫자로 변경 : TO_NUMBER
SELECT TO_NUMBER('1')+1--문자 1을 숫자로 바꿔주기. 명시적 형변환
        , ('1')+1 --암시적 형변환(알아서 숫자로 처리함)
  FROM DUAL;
-- 형변환 함수 -> 명시적 형변환
-- 자동으로 형변환 진행 -> 암시적 형변환
-- 내가 내일의 나, 혹은 다른사람들과 협업할때 누가봐도 결과를 알수있도록 만드는게 중요하기
-- 에 명시적 형변환을 해주는게 좋다
-- 우선순위 : 날짜형 > 숫자형 > 문자형
-- 우선순위가 낮은 문자형부터 형변환을 진행.
  
-- 날짜로 변경 : TO_DATE
SELECT TO_DATE('20230504', 'YYYY/MM/DD')
  FROM DUAL;
  


--5. NULL 함수
-- NULL에 산술 연산을 하면 무조건 NULL을 반환하고
-- NULL에 비교 연산을 하면 무조건 FALSE를 반환함
-- 그래서 자료 사용에 불편함을 준다!
--   EX> 전직원의 급여의 총 합을 구하고 싶음 => NULL이 있으면? NULL로 반환됨
-- 그래서 필요한게 NULL 함수 : NULL에 다른값을 대체하는 기능

-- 현업에서는 NVL이 많이 사용된다
-- NVL(대상 컬럼, NULL일때 어떻게 바꿀지)

SELECT FIRST_NAME
        ,NVL(FIRST_NAME,'없음')
  FROM EMPLOYEES;
  
-- NVL2(대상 컬럼, NULL이 아닐 때 어떻게 바꿀지, NULL일때 어떻게 바꿀지)

SELECT FIRST_NAME
        ,NVL2(FIRST_NAME, '있음', '없음')
  FROM EMPLOYEES;
  
-- 예제 1) 직원 테이블의 커미션이 NULL일 경우 0으로 대체해서 반환
SELECT COMMISSION_PCT
        ,NVL(COMMISSION_PCT, 0)
  FROM EMPLOYEES;
  
-- 예제 2) 직원 테이블중 매니저가 있는 직원은 '직원'으로, 매니저가 없는 직원은 '관리자'로 출력
-- 왜냐하면 담당하는 매니저가 없는 사람이 관리자니까.
SELECT MANAGER_ID
        ,NVL2(MANAGER_ID, '직원', '관리자')
  FROM EMPLOYEES;
-- 2번 캡쳐해서 단톡방에 업로드!


-- DECODE(검사대상, 비교1, 일치시 반환값1, 비교2, 일치시 반환값 2 ..., 일치하지 않을때 반환값)
-- 분기함수를 의미.(IF, ELIF, ELSE조건문 같은거)
-- 특정 값에 따라 다른 결과를 반환하는 DB 전용 함수

SELECT FIRST_NAME, DEPARTMENT_ID, SALARY --부서별로 성과급 다르게 주기
        ,DECODE(DEPARTMENT_ID,           --현업에서 사용 많이 함
                100, SALARY*2,
                90, SALARY*1.9,
                80, SALARY*1.8,
                SALARY) AS 성과급
  FROM EMPLOYEES;
  

-- 6. 그룹함수(다중행 함수. 위는 단일 함수)
-- 합계, 개수, 평균, 최대값, 최소값... 여러개의 데이터들을 하나의 데이터로 만드는거


SELECT SUM(SALARY) AS "급여총합"
        ,COUNT(SALARY) AS " 급여개수"
        ,MAX(SALARY) AS "최대급여"
        ,MIN(SALARY) AS "최소급여"
        ,ROUND(AVG(SALARY)) AS "급여평균" --소수점 자리 너무 길어서 라운드로 감쌈.
  FROM EMPLOYEES;

  
  

  

  

