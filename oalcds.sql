

select r.request_desc ��������,to_char(r.create_date,'yy-mm-dd hh24:mi:ss') ����ʱ��,sysdate-r.create_date ���Ϊֹ������, (sysdate-r.create_date)*12 ���Ϊֹ������,ub.MI ����������
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
   ON ub.user_id = r.create_user_id
where r.container_type=4 and r.folder_id =0




select r.request_desc ������������,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') ����ʱ��,
to_char(sysdate-r.create_date,'fm9999990.9') ���˶�����, 
to_char(��sysdate-r.create_date��*12,'fm9999990.9') ���˶���Сʱ,
ub.MI ����������
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
   ON ub.user_id = r.create_user_id

where r.container_type=4 and r.folder_id =0



select *
from newsoft.ecl_task_action_hist


select 
r.request_desc ��ʱ����,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') ����ʱ��,
to_char(��sysdate-r.create_date��*12,'fm9999990.9') ��ʱ��,
ub.MI ������,
et.assignee_name ������
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
ON ub.user_id = r.create_user_id
LEFT OUTER JOIN ECL_TASKS et
ON et.request_id=r.request_id

where r.container_type=4 and (r.folder_id =1 or r.folder_id =3 )and to_number(to_char(��sysdate-r.create_date��*12,'fm9999990.9'))>= 24 
order by sysdate-r.create_date

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


order by user_table.mi

select *  from USER_TABLE  where MI ='�ƶ��Z'
select *  from USER_TABLE  where MI ='ʵϰ��'
 update USER_TABLE
 set DEPT_ID = '12916',MI='ʵϰ��',LAST_NAME='ʵ',FIRST_NAME='ϰ��'
 where USER_ID ='u000222'

 update USER_TABLE
 set STATUS_CODE='1'
 where USER_ID ='u000222'




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




