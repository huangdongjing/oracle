-- oa sql ��ѯ��¼
--���� ��������̨���̲��ܳ���24Сʱ�涨,��Ҫoa����
-- �������ṩ��ԭʼ��ѯ
select r.request_desc,r.folder_id,r.create_user_id,r.create_date from newsoft.ecl_request_sheet r where r.container_type=4
/*
request_desc(�������ƣ���folder_id������״̬��0�ǽ����У�1������ɣ������Ĳ�����ȡ������δ���������Թ�Ϊͬһ�ࣩ��create_user_id�������ˣ���create_date������ʱ�䣩
*/
-- �����ѯ
select r.request_desc ������������,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') ����ʱ��,
to_char(sysdate-r.create_date,'fm9999990.9') ���˶�����, 
to_char(��sysdate-r.create_date��*12,'fm9999990.9') ���˶���Сʱ,
ub.MI ����������
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
   ON ub.user_id = r.create_user_id
where r.container_type=4 and r.folder_id <>1; --���е���˼ʱѡ������Ϊ���� ����״̬��Ϊ��ɵ�����


--�����ѯ1
select 
r.request_desc ��ʱ����,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') ����ʱ��,
to_char(��sysdate-r.create_date��*12,'fm9999990.9') ��ʱ��,
ub.MI ������,
et.assignee_name ������
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub--�����û���
ON ub.user_id = r.create_user_id--ͨ���û�id����
LEFT OUTER JOIN ECL_TASKS et--�������̱�
ON et.request_id=r.request_id--ͨ����ˮ������
where r.container_type=4 and r.folder_id <>1 and to_number(to_char(��sysdate-r.create_date��*12,'fm9999990.9'))>= 24 --���е���˼ѡ������Ϊ���� ����״̬Ϊ��Ϊ���,����ʱ������24Сʱ������
order by sysdate-r.create_date;--���մ�����������

--oa�������ṩ�������ѯ ͨ��case then ѡ��1��3 2��״̬������
select case ecl_tasks.status_id
when 1 then '����' 
when 3 then '������'
end  ����״̬ , 
      ecl_request_sheet.request_desc ��������, 
      ecl_request_sheet.str_att_1 ������ˮ��, 
      to_char(ecl_tasks.create_date, 'yyyy-mm-dd') �������, 
      to_char(sysdate,'YYYY-MM-DD')as ��ǰ����, 
      trunc(sysdate-ecl_tasks.create_date) ���̺�ʱ, 
      ecl_request_sheet.create_user_id ���̷�����, 
      ecl_tasks.assignee_name ������ , 
      user_table.user_id ������ID, 
      user_table.mi ���������� 
from ecl_request_sheet  
inner join ecl_tasks 
on ecl_tasks.request_id=ecl_request_sheet.request_id  
inner join user_table 
on ecl_tasks.assignee = user_table.myws_id 
where ecl_request_sheet.folder_id=0 and ecl_request_sheet.status_id=1 
and ecl_tasks.status_id in (1,3) --����״̬��1��3
AND user_table.mi not in ('������','Ī�Ϸ�','���Ļ�','����','������','���̳�','������')--����������˵������������˷���Ĳ�������
order by user_table.mi

-- ����  ��ѯ��ְ��Ա�Ļ�������
select *  from USER_TABLE  where MI ='ʵϰ��'--�Ȳ���û��������Ϣ
--�Բ�����������ǰ̨�޷�������ְ��Ա��״̬ ���粿����ʧ�޷�ʹ��ְ��Ա��Ч��ְ
 update USER_TABLE
 set DEPT_ID = '12916',MI='ʵϰ��',LAST_NAME='ʵ',FIRST_NAME='ϰ��'--�Ĳ���id��Ϊ�����ԭ�Ȳ��ű�����,���û�����Ϊ�˷����ѯ����
 where USER_ID ='u000222'

 update USER_TABLE
 set STATUS_CODE='1'--1Ϊ��ְ״̬,2Ϊ��ְ״̬
 where USER_ID ='u000222'


/*
�����ѯ������ѯĳЩ��ְ��Ա�������������
*/

select 
r.str_att_1 ������ˮ��,
r.request_desc ����,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') ����ʱ��,
to_char(��sysdate-r.create_date��*12,'fm9999990.9') ��ʱ��,
ub.MI ������,
et.assignee_name ������
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
ON ub.user_id = r.create_user_id
LEFT OUTER JOIN ECL_TASKS et
ON et.request_id=r.request_id
where r.container_type=4 and r.create_user_id = 'u000222'
order by sysdate-r.create_date

--����Ŀǰ���µĳ�ʱ���̲�ѯ
select case ecl_tasks.status_id
when 1 then '����' 
when 3 then '������'
end  ����״̬ , 
      ecl_request_sheet.request_desc ��������, 
      ecl_request_sheet.str_att_1 ������ˮ��, 
      to_char(ecl_tasks.create_date, 'yyyy-mm-dd') �������, 
      to_char(sysdate,'YYYY-MM-DD')as ��ǰ����, 
      trunc(sysdate-ecl_tasks.create_date) ���̺�ʱ, 
      ecl_request_sheet.create_user_id ���̷�����, 
      ecl_tasks.assignee_name ������ , 
      user_table.user_id ������ID, 
      user_table.mi ���������� 
from ecl_request_sheet  
inner join ecl_tasks on ecl_tasks.request_id=ecl_request_sheet.request_id  
inner join user_table on ecl_tasks.assignee = user_table.myws_id 
where ecl_request_sheet.folder_id=0 and ecl_request_sheet.status_id=1 
and ecl_tasks.status_id in (1,3) 
AND user_table.mi not in ('������','Ī�Ϸ�','���Ļ�','����','������','���̳�','������')
and ecl_tasks.create_date between '1-8��-17' and sysdate--����8��1��-����
and to_char(trunc(sysdate-ecl_tasks.create_date))<>0--����ʱ�䲻Ϊ0��
order by user_table.mi;


