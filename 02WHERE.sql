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



