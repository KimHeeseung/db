/*
    ���� 1 ]
        ������ MANAGER �� �����
        ����̸�, ����, �Ի���, �޿�, �μ��̸��� ��ȸ�ϼ���.

*/
SELECT
    ename, job, hiredate, sal, dname
FROM
    emp e, dept d
WHERE
    job = 'MANAGER'
;
/*
    ���� 2 ]
        ����̸��� 5������ �������
        ����̸�, ����, �Ի���, �޿�, �޿������ ��ȸ�ϼ���.
*/
SELECT
    ename,job,hiredate,sal,grade
FROM
    emp e,salgrade
WHERE
    sal BETWEEN losal AND hisal
    AND LENGTH(ename) = 5
    ;
/*
    ���� 3 ]
        �Ի����� 81���̰�
        ������ MANAGER�� �������
        ����̸�, ����, �Ի���, �޿�, �޿����, �μ��̸�, �μ���ġ�� ��ȸ�ϼ���.
*/
SELECT
    ename, job, hiredate, sal, grade, dname, loc
FROM
    emp e, dept d, salgrade
WHERE
    e.deptno = d.deptno
    AND sal BETWEEN losal AND hisal
    AND TO_CHAR(hiredate, 'YY') = '81'
    AND job = 'MANAGER'
;


/*
    ���� 4 ]
        �������
        ����̸�, ����, �޿�, �޿����, ����̸�
        �� ��ȸ�ϼ���.
*/
SELECT
    e.ename , e.job, e.sal, grade, NVL(s.ename,'������')����̸�
FROM   
    emp e, salgrade, emp s
WHERE
    e.sal BETWEEN losal AND hisal
    AND e.mgr = s.empno(+)
;
/*
    e.sal BETWEEN losal AND hisal
    AND e.mgr = s.empno(+) -- ����� ����ȣ�� ����� �����ȣ�Դϴ�.
;
    ���� 5 ]
        �������
        ����̸�, ����, �޿�, ����̸�, �μ��̸�, �޿������ ��ȸ�ϼ���.
*/

SELECT
    e.ename ����̸�, e.job ����, e.sal �޿�, NVL(s.ename,'������')����̸�, dname �μ��̸�, grade �޿����
FROM   
    emp e, emp s, dept d, salgrade
WHERE
   e.mgr = s.empno(+)
   AND e.deptno = d.deptno
   AND e.sal BETWEEN losal AND hisal
;


-- �� �������� ANSI JOIN �� ����� ���Ǹ���� �ۼ��ϼ���
