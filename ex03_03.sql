/*
    ����1
    �� ���޺��� �ѱ� ��������
    �������
     ����̸� ���� �ѱ�����
     �� ��ȸ�ϼ���
     
     manager : ������
     salesman : �������
     CLERK : ���� ���
*/
SELECT
        ename ����̸�,job ����,
     DECODE(job, 'MANAGER', '������', 'SALESMAN','�������','CLERK','����','ANALYST','�м���','PRESIDENT','�����') �μ��̸�
FROM
EMP;

/*
    ���� 2 ]
        �� �μ����� �̹��� ���ʽ��� �ٸ��� �����Ϸ��� �Ѵ�.
        10 �� �μ��� �޿��� 10%
        20 �� �μ��� �޿��� 15%
        30 �� �μ��� �޿��� 20% �� �����ϱ�� �ߴ�.
        �׸��� �ű⿡ ������ Ŀ�̼��� ���ؼ� �޿��� �����ϱ�� �ߴ�.
        Ŀ�̼��� ���� ����� Ŀ�̼��� 0���� �ؼ� ����ؼ�
        �������
            ����̸�, �μ���ȣ, �޿�, ���ޱ޿�
        �� ��ȸ�ϼ���.
*/

SELECT
    ename ����̸�, deptno �μ���ȣ, sal �޿�, comm Ŀ�̼�,
    FLOOR(
    CASE
        WHEN deptno = 10 THEN (sal * 1.1)
        WHEN deptno  = 20 THEN (sal * 1.15)
        WHEN deptno  = 30 THEN (sal * 1.20)
    END
    )   "���ޱ޿�1",
        FLOOR(
    CASE
        WHEN deptno = 10 THEN (sal * 1.1) + comm
        WHEN deptno  = 20 THEN (sal * 1.15) + comm
        WHEN deptno  = 30 THEN (sal * 1.20) + comm
    END
    )   "���ޱ޿�2"
    
FROM
    emp
;

SELECT
    ename ����̸�, deptno �μ���ȣ, sal �޿�,
    DECODE(deptno,10,TRUNC(sal * 1.1 + NVL(comm, 0), -1)
    ,20,TRUNC(sal * 1.15 + NVL(comm, 0), -1)
    ,30,TRUNC(sal * 1.20 + NVL(comm, 0), -1)) ���ޱ޿�
FROM
emp;

/*
    ���� 3 ]
        �Ի�⵵�� �������� �ؼ�
            80�� 'A���'
            81�� 'B���'
            82�� 'C���'
            �� �̿��� �ؿ� �Ի��� ����� 'D���'
            ���� ��ȸ�ǵ��� 
            �������
                ����̸�, ����, �Ի���, ���
            �� ��ȸ�ϼ���.
*/

SELECT
    ename ����̸�,job ����, hiredate �Ի���,
    DECODE(SUBSTR(HIREDATE, 1, 2),'80','A���','81','B���','82','C���','D���') ���
       
FROM
    emp;

/*
    ���� 4 ]
        ����̸��� ���ڼ��� 4���ڸ� 'Mr.'�� �̸��տ� ���̰�
        4���ڰ� �ƴϸ� �ڿ� ' ��'���� ��ȸ�ǵ���
        �������
            ����̸�, �̸����ڼ�, ��ȸ�̸�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, LENGTH(ename) �̸����ڼ�,
    CASE
        WHEN LENGTH(ename) = 4 THEN CONCAT('Mr.',ename)
        ELSE CONCAT(ename,'��')
    END
FROM 
emp
;


/*
   lpad(ename, length(ename)+3, 'Mr.')
    ���� 5 ]
        �μ���ȣ�� 10 �Ǵ� 20���̸�   �޿� + Ŀ�̼����� �����ϰ�
        �� �̿��� �μ��� �޿��� �����Ϸ��� �Ѵ�.
        �������
            ����̸�, ����, �μ���ȣ, �޿�, Ŀ�̼�, ���ޱ޿�
        �� ��ȸ�ϼ���.
        ��, Ŀ�̼��� ���� ���� 0���� ����ؼ� ����ϴ� ������ �Ѵ�.
*/
SELECT
    ename ����̸�,job ����, deptno �μ���ȣ, sal �޿�, comm Ŀ�̼�,
    FLOOR(
    CASE
        WHEN deptno = 10 THEN NVL2(comm, sal + comm, sal)
        WHEN deptno  = 20 THEN NVL2(comm, sal + comm, sal)
        ELSE sal
    END
    )   "���ޱ޿�1"
FROM
EMP;

/*
    ���� 6 ]
        �Ի������ �����, �Ͽ��� �� �����
            �޿��� 20% ���ؼ� �����ϰ�
        �� �̿��� ���Ͽ� �Ի��� �����
            �޿��� 10%�� ���ؼ� �����Ϸ��� �Ѵ�.
            
        �������
            ����̸�, �޿�, �Ի���, �Ի����, ���ޱ޿�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, sal �޿�, hiredate �Ի���, TO_CHAR(hiredate,'DY,Month')AS "Date",
        FLOOR(
    CASE
        WHEN TO_CHAR(hiredate,'DY,Month') ='��' THEN sal * 1.20
        WHEN TO_CHAR(hiredate,'DY,Month') ='��' THEN sal * 1.20
        ELSE sal * 1.1
    END) "���ޱ޿�"
    
FROM
emp;

/*
    ���� 7 ]
        �ٹ��������� 490���� �̻��� �����
            Ŀ�̼��� 500 �� �߰��ؼ� �����ϰ�
        �ٹ��������� 490���� �̸��� �����
            Ŀ�̼��� ����Ŀ�̼Ǹ� �����ϵ��� �� �����̴�.
        �������
            ����̸�, Ŀ�̼�, �Ի���, �ٹ�������, ����Ŀ�̼�
        �� ��ȸ�ϼ���.
        ��, Ŀ�̼��� ���� ����� 0���� ����ϴ� ������ �Ѵ�.
*/
SELECT
    ename ����̸�,
    hiredate �Ի���,
    TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) "�ٹ�������",
    comm Ŀ�̼�,
    FLOOR(
    CASE
        WHEN MONTHS_BETWEEN(SYSDATE, hiredate) >= 490 THEN NVL2(comm, 500 + comm, 500)
        WHEN MONTHS_BETWEEN(SYSDATE, hiredate) <= 490  THEN comm
    END
    )   "����Ŀ�̼�"
FROM
    emp
;
/*
    ���� 8 ]
        �̸� ���ڼ��� 5���� �̻��� ����� �̸���
            3����*** �� ǥ���ϰ�(�̸����̿� ���� * �� ǥ��...)
        �̸� ���ڼ��� 4���� ������ ����� �״�� ����� �����̴�.
        �������
            ����̸�, �̸����ڼ�, ��ȸ�̸�
        �� ��ȸ�ϼ���.
*/
SELECT
    ename ����̸�, LENGTH(ename) �̸����ڼ�, 
    CASE
        WHEN LENGTH(ename) >= 5 THEN RPAD(SUBSTR(ename,1,3),LENGTH(ename),'*')
        WHEN LENGTH(ename) <= 4 THEN ename
        
    END "��ȸ�̸�"
    
FROM
EMP;