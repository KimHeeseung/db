/*
    문제1
    각 직급별로 한글 직급으로
    사원들의
     사원이름 직급 한글직급
     을 조회하세요
     
     manager : 관리자
     salesman : 영업사원
     CLERK : 점원 등등
*/
SELECT
        ename 사원이름,job 직급,
     DECODE(job, 'MANAGER', '관리자', 'SALESMAN','영업사원','CLERK','점원','ANALYST','분석자','PRESIDENT','대통령') 부서이름
FROM
EMP;

/*
    문제 2 ]
        각 부서별로 이번달 보너스를 다르게 지급하려고 한다.
        10 번 부서는 급여의 10%
        20 번 부서는 급여의 15%
        30 번 부서는 급여의 20% 를 지급하기로 했다.
        그리고 거기에 각각의 커미션을 더해서 급여로 지급하기로 했다.
        커미션이 없는 사원은 커미션을 0으로 해서 계산해서
        사원들의
            사원이름, 부서번호, 급여, 지급급여
        를 조회하세요.
*/

SELECT
    ename 사원이름, deptno 부서번호, sal 급여, comm 커미션,
    FLOOR(
    CASE
        WHEN deptno = 10 THEN (sal * 1.1)
        WHEN deptno  = 20 THEN (sal * 1.15)
        WHEN deptno  = 30 THEN (sal * 1.20)
    END
    )   "지급급여1",
        FLOOR(
    CASE
        WHEN deptno = 10 THEN (sal * 1.1) + comm
        WHEN deptno  = 20 THEN (sal * 1.15) + comm
        WHEN deptno  = 30 THEN (sal * 1.20) + comm
    END
    )   "지급급여2"
    
FROM
    emp
;

SELECT
    ename 사원이름, deptno 부서번호, sal 급여,
    DECODE(deptno,10,TRUNC(sal * 1.1 + NVL(comm, 0), -1)
    ,20,TRUNC(sal * 1.15 + NVL(comm, 0), -1)
    ,30,TRUNC(sal * 1.20 + NVL(comm, 0), -1)) 지급급여
FROM
emp;

/*
    문제 3 ]
        입사년도를 기준으로 해서
            80년 'A등급'
            81년 'B등급'
            82년 'C등급'
            그 이외의 해에 입사한 사원은 'D등급'
            으로 조회되도록 
            사원들의
                사원이름, 직급, 입사일, 등급
            을 조회하세요.
*/

SELECT
    ename 사원이름,job 직급, hiredate 입사일,
    DECODE(SUBSTR(HIREDATE, 1, 2),'80','A등급','81','B등급','82','C등급','D등급') 등급
       
FROM
    emp;

/*
    문제 4 ]
        사원이름의 글자수가 4글자면 'Mr.'을 이름앞에 붙이고
        4글자가 아니면 뒤에 ' 님'으로 조회되도록
        사원들의
            사원이름, 이름글자수, 조회이름
        을 조회하세요.
*/
SELECT
    ename 사원이름, LENGTH(ename) 이름글자수,
    CASE
        WHEN LENGTH(ename) = 4 THEN CONCAT('Mr.',ename)
        ELSE CONCAT(ename,'님')
    END
FROM 
emp
;


/*
   lpad(ename, length(ename)+3, 'Mr.')
    문제 5 ]
        부서번호가 10 또는 20번이면   급여 + 커미션으로 지급하고
        그 이외의 부서는 급여만 지급하려고 한다.
        사원들의
            사원이름, 직급, 부서번호, 급여, 커미션, 지급급여
        를 조회하세요.
        단, 커미션이 없는 경우는 0으로 대신해서 계산하는 것으로 한다.
*/
SELECT
    ename 사원이름,job 직급, deptno 부서번호, sal 급여, comm 커미션,
    FLOOR(
    CASE
        WHEN deptno = 10 THEN NVL2(comm, sal + comm, sal)
        WHEN deptno  = 20 THEN NVL2(comm, sal + comm, sal)
        ELSE sal
    END
    )   "지급급여1"
FROM
EMP;

/*
    문제 6 ]
        입사요일이 토요일, 일요일 인 사원은
            급여를 20% 더해서 지급하고
        그 이외의 요일에 입사한 사원은
            급여의 10%를 더해서 지급하려고 한다.
            
        사원들의
            사원이름, 급여, 입사일, 입사요일, 지급급여
        를 조회하세요.
*/
SELECT
    ename 사원이름, sal 급여, hiredate 입사일, TO_CHAR(hiredate,'DY,Month')AS "Date",
        FLOOR(
    CASE
        WHEN TO_CHAR(hiredate,'DY,Month') ='토' THEN sal * 1.20
        WHEN TO_CHAR(hiredate,'DY,Month') ='일' THEN sal * 1.20
        ELSE sal * 1.1
    END) "지급급여"
    
FROM
emp;

/*
    문제 7 ]
        근무개월수가 490개월 이상인 사원은
            커미션을 500 을 추가해서 지급하고
        근무개월수가 490개월 미만인 사원은
            커미션을 현재커미션만 지급하도록 할 예정이다.
        사원들의
            사원이름, 커미션, 입사일, 근무개월수, 지급커미션
        을 조회하세요.
        단, 커미션이 없는 사원은 0으로 계산하는 것으로 한다.
*/
SELECT
    ename 사원이름,
    hiredate 입사일,
    TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) "근무개월수",
    comm 커미션,
    FLOOR(
    CASE
        WHEN MONTHS_BETWEEN(SYSDATE, hiredate) >= 490 THEN NVL2(comm, 500 + comm, 500)
        WHEN MONTHS_BETWEEN(SYSDATE, hiredate) <= 490  THEN comm
    END
    )   "지급커미션"
FROM
    emp
;
/*
    문제 8 ]
        이름 글자수가 5글자 이상인 사원은 이름을
            3글자*** 로 표현하고(이름길이에 맞춰 * 로 표시...)
        이름 글자수가 4글자 이하인 사원은 그대로 출력할 예정이다.
        사원들의
            사원이름, 이름글자수, 조회이름
        을 조회하세요.
*/
SELECT
    ename 사원이름, LENGTH(ename) 이름글자수, 
    CASE
        WHEN LENGTH(ename) >= 5 THEN RPAD(SUBSTR(ename,1,3),LENGTH(ename),'*')
        WHEN LENGTH(ename) <= 4 THEN ename
        
    END "조회이름"
    
FROM
EMP;
