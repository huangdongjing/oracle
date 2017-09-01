-- oa sql 查询记录
--需求 法政部出台流程不能超过24小时规定,需要oa导出
-- 供货商提供的原始查询
select r.request_desc,r.folder_id,r.create_user_id,r.create_date from newsoft.ecl_request_sheet r where r.container_type=4
/*
request_desc(流程名称），folder_id（流程状态，0是进行中，1是已完成，其他的不是已取消就是未操作，可以归为同一类），create_user_id（发起人），create_date（发起时间）
*/
-- 改造查询
select r.request_desc 发起流程名称,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') 发起时间,
to_char(sysdate-r.create_date,'fm9999990.9') 走了多少天, 
to_char(（sysdate-r.create_date）*12,'fm9999990.9') 走了多少小时,
ub.MI 发起人姓名
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub
   ON ub.user_id = r.create_user_id
where r.container_type=4 and r.folder_id <>1; --这行的意思时选择类型为流程 运行状态不为完成的流程


--改造查询1
select 
r.request_desc 超时流程,
to_char(r.create_date,'yy-mm-dd hh24:mi:ss') 发起时间,
to_char(（sysdate-r.create_date）*12,'fm9999990.9') 超时数,
ub.MI 发起人,
et.assignee_name 审批人
from newsoft.ecl_request_sheet r
LEFT OUTER JOIN USER_TABLE ub--连接用户表
ON ub.user_id = r.create_user_id--通过用户id连接
LEFT OUTER JOIN ECL_TASKS et--连接流程表
ON et.request_id=r.request_id--通过流水号连接
where r.container_type=4 and r.folder_id <>1 and to_number(to_char(（sysdate-r.create_date）*12,'fm9999990.9'))>= 24 --这行的意思选择类型为流程 运行状态为不为完成,并且时长大于24小时的流程
order by sysdate-r.create_date;--按照创建日期排序

--oa供货商提供的最初查询 通过case then 选择1和3 2种状态的流程
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
inner join ecl_tasks 
on ecl_tasks.request_id=ecl_request_sheet.request_id  
inner join user_table 
on ecl_tasks.assignee = user_table.myws_id 
where ecl_request_sheet.folder_id=0 and ecl_request_sheet.status_id=1 
and ecl_tasks.status_id in (1,3) --任务状态在1和3
AND user_table.mi not in ('过锦涛','莫紫枫','廖文华','章亮','孙刘涛','鲍程成','孙刘涛')--这个用来过滤当初测试流程人发起的测试审批
order by user_table.mi

-- 需求  查询离职人员的基本操作
select *  from USER_TABLE  where MI ='实习生'--先查出用户表里的信息
--以操作仅仅用于前台无法更新离职人员的状态 比如部门消失无法使离职人员生效在职
 update USER_TABLE
 set DEPT_ID = '12916',MI='实习生',LAST_NAME='实',FIRST_NAME='习生'--改部门id是为了因对原先部门被撤销,改用户名是为了方便查询流程
 where USER_ID ='u000222'

 update USER_TABLE
 set STATUS_CODE='1'--1为在职状态,2为离职状态
 where USER_ID ='u000222'


/*
这个查询用来查询某些离职人员发起的审批流程
*/

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

--这是目前最新的超时流程查询
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
and ecl_tasks.create_date between '1-8月-17' and sysdate--定义8月1日-至今
and to_char(trunc(sysdate-ecl_tasks.create_date))<>0--审批时间不为0的
order by user_table.mi;


