/*
����:����Ҫ�󵼳�NC�ϵ������Ա�ĳ����¼����,���Ҽ����ʱ��,�����˹�����
*/
select  er_bxzb.djbh  ���ݺ�,
er_busitem.defitem1  ��������,
er_busitem.defitem2  �س�����,
to_char(��to_date(to_char(er_busitem.defitem2),'RR-MM-DD HH24:MI:SS')-to_date(to_char(er_busitem.defitem1),'RR-MM-DD HH24:MI:SS')��*24,'fm9999990.999') ��ʱСʱ��,--Ϊ����Ķ��� 3�ַ�ʽ��ѡһ��
to_char(��to_date(to_char(er_busitem.defitem2),'RR-MM-DD HH24:MI:SS')-to_date(to_char(er_busitem.defitem1),'RR-MM-DD HH24:MI:SS')��*24*60,'fm9999990.99') ��ʱ������,--Ϊ����Ķ��� 3�ַ�ʽ��ѡһ��
to_char(to_date(to_char(er_busitem.defitem2),'RR-MM-DD HH24:MI:SS')-to_date(to_char(er_busitem.defitem1),'RR-MM-DD HH24:MI:SS'),'fm9999990.99') ��ʱ����,--Ϊ����Ķ��� 3�ַ�ʽ��ѡһ��
bd_psndoc.name  ������,
org_dept.name  ��������  
from  er_bxzb--�����ܱ�
left  join  er_busitem--����/���ҵ���б�   
on  er_bxzb.pk_jkbx  =  er_busitem.pk_jkbx--��������:��������ʶ 
left  join  bd_psndoc--��Ա������Ϣ��   
on  er_bxzb.jkbxr  =  bd_psndoc.pk_psndoc--��������:��������ʶ����Ա 
left  join  org_dept--��֯���ű�  
on  er_bxzb.deptid  =  org_dept.pk_dept--��������:����
where  er_busitem.defitem1  >=  '2017-01-01'  and  er_busitem.defitem2  <=  '2017-02-28'--������������ʱ�������ȡ��Ҫ������
and  er_bxzb.pk_org  =  '0001E4100000000030JH'--����ͨ��������֯�������ȡ����Ҫ������
group  by  er_bxzb.djbh  ,er_busitem.defitem1  ,er_busitem.defitem2  ,bd_psndoc.name  ,org_dept.name--����������п���ע�͵� ��Ӱ����  
order  by  er_bxzb.djbh;--ͨ�����ݺ�������