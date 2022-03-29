/*
    9. REPLACE()
        ==> 문자열의 특정부분을 다른 문자열로 대체해서 반환해주는 함수
        
        형식 ]
            REPLACE(데이터, 찾을문자, 대치문자)
            
    10. TRIM()
        ==> 문자열 중에서 앞 또는 뒤에 있는 지정한 문자를 삭제해서 반환해주는 함수
        
        참고 ]
            중간에 있는 문자는 삭제하지 못한다.
            
        형식 ]
            TRIM([삭제할문자 FROM ] 데이터)
        참고 ]
            같은 문자가 앞, 뒤에 연속되어 있으면 모두 지운다.
            
        참고 ]
            가끔 데이터 앞 또는 뒤에 공백문자가 들어간 경우가 있다.
            이런 경우를 대비해서 앞 뒤에 들어간 공백 문자를 제거할 목적으로 많이 사용한다.
            
        10 - 1 
            LTRIM
            RTRIM
                형식 ]
                    LTRIM(데이터, 삭제문자)
                    
    11. CHR()
        ==> ASCII 코드를 알려주면 그 코드에 해당하는 문자를 알려주는 함수
        
        형식 ]
            CHR(숫자)
        
    12. ASCII()
        ==> 문자열에 해당하는 ASCII 코드를 알려주는 함수
        
        형식 ]
            ASCII(데이터)
            
        참고 ]
            두글자이상으로 된 문자열의 경우는 
            첫문자의 코드값을 반환해준다.
            
    13. TRANSLATE
        ==> REPALCE 와 마찬가지로 문자열 중 지정한 부분을 
            다른 문자열로 바꿔서 반환해주는 함수
            
            차이점 ]
                REPLACE 함수는 바꿀 문자열 전체를 바꾸는데
                이 함수는 문자단위 처리한다.
                
        형식 ]
            TRANSLATE(데이터, 바꿀문자열, 바뀔문자열)
*/

SELECT
    REPLACE('hong gil dong', 'n', 'nn') 홍길동
FROM
    dual
;

SELECT
    REPLACE('     hong gil dong     ', ' ', '') 홍길동
FROM
    dual
;

SELECT
    TRIM('     hong gil dong     ') 홍길동
FROM
    dual
;


SELECT
    TRIM(' ' FROM '     hong gil dong     ') 홍길동
FROM
    dual
;

SELECT
    RTRIM(
        LTRIM('ooooooooooooracleoooooooooooooooo', 'o'),
        'o'
    ),
    TRIM('o' FROM 'ooooooooooooracleoooooooooooooooo')
FROM
    dual
;

-- ASCII()
SELECT
    ASCII('HONG') 코드값,
    CHR(ASCII('HONG')) 알파벳
FROM
    dual
;

SELECT
    TRANSLATE('ADBC', 'ABCD', '1234')
    /*
        A ---> 1
        B ---> 2
        C ---> 3
        D ---> 4
        로 변환한다.
    */
FROM
    dual
;


--------------------------------------------------------------------------------
/*
    날짜 처리 함수
    
        **
        참고 ]
            SYSDATE
            ==> 예약어 
                현재 시스템의 날짜와 시간을 알려주는 예약어
                (의사 컬럼으로 보면 된다.)
                
        참고 ]
            날짜 - 날짜 의 연산식이 가능하다.
            날짜 연번끼리 - 연산을 하게된다.
            
            참고 ]
                날짜연번 : 날수.시간
            
            날짜데이터의 기준점은 1970년 1월 1일 0시 0분 0초를 기준으로 한다.
            
        참고 ]
            날짜데이터의 연산은 오직 - 연산만 가능하다.
            날짜 + 날짜,
            날짜 * 날짜,
            날짜 / 날짜
            는 허락하지 않는다.
            
        참고 ]
            날짜 +(또는 -)  숫자
            의 연산은 가능하다.
            ==> 날짜 연번 +(-) 숫자이므로
                결국 날짜에서 원하는 숫자만큼 이동된 날짜를 표시한다.
                
    2. MONTHS_BETWEEN
        ==> 두 날짜 데이터의 개월수를 알려주는 함수
            
            형식 ]
                MONTHS_BETWEEN(날짜, 날짜)
*/

-- 사원들의 근무일수를 조회하세요.
SELECT
    ename 사원이름, 
    FLOOR(sysdate - hiredate) 근무일수
FROM
    emp
;

SELECT
    SYSDATE + 10 "10일후"
FROM
    DUAL
;

--------------------------------------------------------------------------------
/*
    날짜데이터 처리함수
        
        1. ADD_MONTHS()
            ==> 날짜에 지정한 달수를 더하거나 뺀 날짜를 알려준다.
            
            형식 ]
                ADD_MONTHS(날짜, 더할개월수)
                
            참고 ]
                더할개월수에 음수를 입력하면
                해당 개월수를 뺀 날짜를 알려준다.
                
    3. LAST_DAY
        ==> 지정한 날짜가 포함된 월의 마지막 날짜를 알려주는 함수
            
        형식 ]
            LAST_DAY(날짜)
            
    4. NEXT_DAY
        ==> 지정한 날짜 이후에 가장 처음 오는 지정한 요일에 해당하는 날짜를 알려주는 함수
        
        형식 ]
            NEXT_DAY(날짜, 요일)
            
            참고 ]
                요일 정하는 방법
                    
                    1. 우리는 한글 세팅이 된 오라클이므로
                        '월', '화', '수',...
                        '월요일', '화요일', ...
                    2. 영문권에서는
                        'SUN', 'MON',...
                        'SUNDAY', 'MONDAY', ...
                        
    5. ROUND()
        ==> 날짜를 지정한 부분에서 반올림하는 함수
            이때 지정부분은 년, 월, 일, ...
            
            형식 ]
                ROUND(날짜, 기준단위)
                
--------------------------------------------------------------------------------
*/

SELECT
    ADD_MONTHS(SYSDATE, 4) "4개월후",
    ADD_MONTHS(SYSDATE, -3) "3개월전"
FROM
    dual
;

-- 사원들의 근무개월수를 조회하세요.
SELECT
    ename 사원이름,
    hiredate 입사일,
    TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) "근무개월수"
FROM
    emp
;

-- 이번달 마지막 날짜를 조회하세요.
SELECT LAST_DAY(sysdate) FROM dual;

-- 사원들의 첫번째 월급을 조회하세요. 급여지급은 매월 말일로 한다.
SELECT
    ename 사원이름, sal 급여, hiredate 입사일, LAST_DAY(hiredate) 첫급여일
FROM
    emp
;
-- 사원들의 첫번째 월급을 조회하세요. 급여지급은 매월 1일로 한다.
SELECT
    ename 사원이름, sal 급여, hiredate 입사일, (LAST_DAY(hiredate) + 1) 첫급여일
FROM
    emp
;

-- 이번주 일요일이 몇일인지 조회하세요.
SELECT
    NEXT_DAY(sysdate, '일')
FROM
    dual
;

-- 올 성탄절 이후 첫 토요일은??
SELECT
    NEXT_DAY(TO_DATE('2022/12/25', 'YYYY/MM/DD'), '토') AS "첫토요일"
    -- 이 경우는 날짜데이터를 입력해야 하지만
    -- 문자로 입력해도 실행되는 이유는 문자데이터를 날짜데이터로 변환해주는
    -- 함수가 자동호출되서 날짜데이터로 변환해주기 때문에 그렇다.
FROM
    dual
;

-- 현재시간을 년도를 기준으로 반올림하세요.
SELECT TO_CHAR(ROUND(sysdate, 'YEAR'), 'YYYY/MM/DD HH24:mi:ss') 반올림 FROM dual;

-- 현지시간을 월을 기준으로 반올림하세요.
SELECT SYSDATE, ROUND(sysdate, 'MONTH') 월반올림 FROM dual;

-----------------------------------------------------------------------------------
/*
    변환함수
    ==> 함수는 데이터 형태에 따라서 사용하는 함수가 달라진다.
        그런데 만약 사용하려는 데이터가 함수에 필요한 데이터가 아닌경우에는
        데이터의 형태를 변환해서 사용해야 한다.
        ==> 데이터의 형태를 바꾸어서 특정 함수에 사용가능하도록 만들어 주는 함수
        
                        TO_CHAR()               TO_CHAR()
                    ----------->            <---------
         NUMBER     <---------->    CHAR    <--------->  DATE
                    <----------             ---------->
                        TO_NUMBER               TO_DATE()
    1. TO_CHAR()
        ==> 날짜나 숫자를 문자 데이터로 변환시켜주는 함수
        
        형식 1 ]
            TO_CHAR(날짜 또는 숫자)
            
        형식 2 ]
            
             TO_CHAR(날짜 또는 숫자, 형식)
             ==> 바꿀때 원하는 형태를 지정해서 문자열로 변환시키는 방법
             
             주의사항 ]
                숫자를 문자로 변환할때 형식으로 사용하는 문자는
                    9   - 무효숫자는 표현안한다.
                    0   - 무효숫자도 표현한다.
            
    2. TO_DATE()
    
    3. TO_NUMBER()
    
*/

/*
    사원들의 사원이름, 입사일, 부서번호를 조회하세요.
    단, 입사일은 '0000년 00월 00일' 의 형식으로 조회되게 하세요.
*/
SELECT
    ename 사원이름, TO_CHAR(hiredate, 'YYYY') || '년 ' || TO_CHAR(hiredate, 'MM') || '월 ' || TO_CHAR(hiredate, 'DD') || '일' 입사일,
    TO_CHAR(hiredate, 'YYYY"년 "MM"월 "DD"일"') 한글입사일,
    deptno 부서번호
FROM
    emp
;

-- 급여가 100 ~ 999 사이인 사원의 정보를 조회하세요.
SELECT
    ename, sal
FROM
    emp
WHERE
    sal BETWEEN 100 AND 999
;

SELECT
    ename, sal
FROM
    emp
WHERE
--    TO_CHAR(sal) LIKE '___'
    LENGTH(TO_CHAR(sal)) = 3
;

-- 사원 급여를 조회하는데 앞에는 $를 붙이고 3자리마다 , 를 붙여서 조회하세요.
SELECT
    ename 사원이름, sal 급여, TO_CHAR(sal, '$9,999,999,999,999') 문자급여1,
    TO_CHAR(sal, '$0,000,000') 문자급여2
FROM
    emp
;
