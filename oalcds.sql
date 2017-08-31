

select r.request_desc 流程名称,to_char(r.create_date,'yy-mm-dd hh24:mi:ss') 发起时间,sysdate-r.create_date 距今为止多少天, (sysdate-r.create_date)*12 距今为止多少天,ub.MI 发起人姓名
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
   ON ub.user_id = r.create_user_id
where r.container_type=4 and r.folder_id =0




select r.request_desc 发起流程名称,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') 发起时间,
to_char(sysdate-r.create_date,'fm9999990.9') 走了多少天, 
to_char(（sysdate-r.create_date）*12,'fm9999990.9') 走了多少小时,
ub.MI 发起人姓名
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
   ON ub.user_id = r.create_user_id

where r.container_type=4 and r.folder_id =0



select *
from newsoft.ecl_task_action_hist


select 
r.request_desc 超时流程,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') 发起时间,
to_char(（sysdate-r.create_date）*12,'fm9999990.9') 超时数,
ub.MI 发起人,
et.assignee_name 审批人
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
ON ub.user_id = r.create_user_id
LEFT OUTER JOIN ECL_TASKS et
ON et.request_id=r.request_id

where r.container_type=4 and (r.folder_id =1 or r.folder_id =3 )and to_number(to_char(（sysdate-r.create_date）*12,'fm9999990.9'))>= 24 
order by sysdate-r.create_date

select case ecl_tasks.status_id
when 1 then '待办' 
when 3 then '处理中'
end  流程状态 , 
      ecl_request_sheet.request_desc 流程名称, 
      ecl_request_sheet.str_att_1 流程流水号, 
      to_char(ecl_tasks.create_date, 'yyyy-mm-dd') 审批起点, 
      to_char(sysdate,'YYYY-MM-DD')as 当前日期, 
      trunc(sysdate-ecl_tasks.create_date) 流程耗时, 
      ecl_request_sheet.create_user_id 流程发起人, 
      ecl_tasks.assignee_name 审批人 , 
      user_table.user_id 审批人ID, 
      user_table.mi 审批人姓名 
from ecl_request_sheet  
inner join ecl_tasks on ecl_tasks.request_id=ecl_request_sheet.request_id  
inner join user_table on ecl_tasks.assignee = user_table.myws_id 
where ecl_request_sheet.folder_id=0 and ecl_request_sheet.status_id=1 
and ecl_tasks.status_id in (1,3) 
AND user_table.mi not in ('过锦涛','莫紫枫','廖文华','章亮','孙刘涛','鲍程成','孙刘涛') 


order by user_table.mi

select *  from USER_TABLE  where MI ='黄栋璟'
select *  from USER_TABLE  where MI ='实习生'
 update USER_TABLE
 set DEPT_ID = '12916',MI='实习生',LAST_NAME='实',FIRST_NAME='习生'
 where USER_ID ='u000222'

 update USER_TABLE
 set STATUS_CODE='1'
 where USER_ID ='u000222'




select 
r.str_att_1 流程流水号,
r.request_desc 流程,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') 发起时间,
to_char(（sysdate-r.create_date）*12,'fm9999990.9') 超时数,
ub.MI 发起人,
et.assignee_name 审批人
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
ON ub.user_id = r.create_user_id
LEFT OUTER JOIN ECL_TASKS et
ON et.request_id=r.request_id

where r.container_type=4 and r.create_user_id = 'u000222'
order by sysdate-r.create_date




