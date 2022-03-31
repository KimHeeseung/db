/*
    문제 1 ]
        이름이 SMITH인 사원과 동일한 직급을 가진 사원들의 정보를 출력하세요.
*/
SELECT
    ename 사원이름, job 직급
FROM
    emp
WHERE
    job IN (
                SELECT
                    job
                FROM
                    emp
                WHERE
                    ename = 'SMITH'
             )
;
/*
    문제 2 ]
        회사 평균 급여보다 급여를 적게 받는 사원들의
        사원이름, 직급, 급여[, 회사평균급여]
        를 조회하세요.
*/
SELECT
    ename 사원이름,job,sal 사원급여
FROM
    emp
WHERE
    sal < any (
            SELECT
                AVG(sal)평균보다적은
            FROM
                emp
          )
;



/*
    문제 3 ]
        사원들중 급여가 제일 높은 사원의
        사원이름, 직급, 급여[, 최고급여]
        를 조회하세요.
*/
SELECT
    ename 사원이름,job, sal 사원급여
FROM
    emp
WHERE
    sal = (
            SELECT
                max(sal)
            FROM
                emp
          )
;

/*
    문제 4 ]
        KING 사원보다 이후에 입사한 사원들의
        사원이름, 직급, 입사일[, KING사원입사일]
        을 조회하세요.
*/
SELECT
    ename,job,hiredate
FROM emp

WHERE
    hiredate >= (SELECT
                    hiredate
                FROM emp
                
                WHERE
                    ename = 'KING'
                );
                
/*
    문제 5 ]
        각 사원의 급여와 회사평균급여의 차를 출력하세요.
        조회형식은
            사원이름, 급여, 급여의 차, 회사평균급여
        로 조회하세요.
*/
SELECT
    ename 사원이름,job, sal 사원급여, 평균급여차, 평균
FROM
    emp,
    (
        SELECT
         ROUND(STDDEV(sal),2) 평균급여차 ,ROUND(AVG(sal),2) 평균
          
        FROM
            emp
    )
;

SELECT STDDEV(sal)
from emp;
/*
    문제 6 ]
        부서별 급여의 합이 제일 높은 부서 사원들의
        사원이름, 직급, 부서번호, 부서이름, 부서급여합계, 부서원수
        를 조회하세요.
        
*/

SELECT
    ename 사원이름, deptno 부서번호, 
    cnt 부서원수, sum 부서급여합계
FROM
    emp,
    (
        SELECT
            deptno dno, COUNT(*) cnt, SUM(sal) sum
        FROM
    emp
GROUP BY
    deptno
HAVING
    SUM(sal) = (select max(sum(sal)) from emp
group by 
        deptno)
    )
WHERE 
    deptno = dno
;

/*
    문제 7 ]
        커미션을 받는 사원이 한명이라도 있는 부서의 사원들의
        사원이름, 직급, 부서번호, 커미션
        을 조회하세요.
*/
SELECT
    ename 사원이름, deptno 부서번호, comm 커미션
FROM
    emp,
    (
        SELECT
            deptno dno
        FROM
        emp
        GROUP BY
        deptno
    )
WHERE 
    deptno = dno
    AND COMM IS NOT NULL
;



/*
    문제 8 ]
        회사 평균급여보다 높고 
        이름이 4, 5글자인 사원들의
        사원이름, 급여, 이름글자길이[, 회사평균급여]
        를 조회하세요.
*/
SELECT
    ename 사원이름,sal 급여,LENGTH(ENAME) 이름글자길이, 회사평균급여
FROM
    emp,
    (
        SELECT
        ROUND(AVG(sal),2) 회사평균급여
        FROM
        emp
        )
        WHERE 
        LENGTH(ENAME) = 4
        OR LENGTH(ENAME) = 5
    ;


    

/*
    문제 9 ]
        사원이름의 글자수가 4글자인 사원과 같은 직급을 가진 사워들의
        사원이름, 직급, 급여
        를 조회하세요.
*/

/*
    문제 10 ]
        입사년도가 81년이 아닌 사원과 같은 부서에 있는 사원들의
        사원이름, 직급, 급여, 입사일, 부서번호
        을 조회하세요.
*/

/*
    문제 11 ]
        직급별 평균급여보다 한 직급이라도 급여가 많이 받는 사원의
        사원이름, 직급, 급여, 입사일
        을 조회하세요.
*/

/*
    문제 12 ]
        모든 년도별 입사자의 평균 급여보다 많이 받는 사원들의
        사원이름, 직급, 급여, 입사년도
        를 조회하세요.
*/

/*
    문제 13 ]
        최고급여자의 이름 글자수와 같은 글자수의 직원이 존재하면
        모든 사원의 사원이름, 이름글자수, 직급, 급여 를 조회하고
        존재하지 않으면 출력하지마세요.
*/
