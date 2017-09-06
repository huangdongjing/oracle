select  er_bxzb.djbh  单据号,
case er_bxzb.spzt--这是一个单据的审批状态 '1'表示已完成'2'表示修改后完成 '-1'表示无审批流
when 1 then '完成' 
when 2 then '修改后完成'
when -1 then '未完成'
end  审批状态,
er_bxzb.total 合计金额,
er_bxzb.zy  出差事由,
er_busitem.defitem1  启程日期,
er_busitem.defitem2  回程日期,
to_char(（to_date(to_char(er_busitem.defitem2),'RR-MM-DD HH24:MI:SS')-to_date(to_char(er_busitem.defitem1),'RR-MM-DD HH24:MI:SS')）*24,'fm9999990.999') 历时小时数,--为提高阅读性 3种方式任选一种
to_char(（to_date(to_char(er_busitem.defitem2),'RR-MM-DD HH24:MI:SS')-to_date(to_char(er_busitem.defitem1),'RR-MM-DD HH24:MI:SS')）*24*60,'fm9999990.99') 历时分钟数,--为提高阅读性 3种方式任选一种
to_char(to_date(to_char(er_busitem.defitem2),'RR-MM-DD HH24:MI:SS')-to_date(to_char(er_busitem.defitem1),'RR-MM-DD HH24:MI:SS'),'fm9999990.99') 历时天数,--为提高阅读性 3种方式任选一种
bd_psndoc.name  报销人,
org_dept.name  报销部门  
from  er_bxzb--报销总表
left  join  er_busitem--报销/借款业务行表   
on  er_bxzb.pk_jkbx  =  er_busitem.pk_jkbx--连接条件:报销单标识 
left  join  bd_psndoc--人员基本信息表   
on  er_bxzb.jkbxr  =  bd_psndoc.pk_psndoc--连接条件:报销单标识和人员 
left  join  org_dept--组织部门表  
on  er_bxzb.deptid  =  org_dept.pk_dept--连接条件:部门
where er_bxzb.spzt ='-1'
and er_busitem.defitem1  >=  '2017-01-01'  and  er_busitem.defitem2  <=  '2017-02-28'--这里用来更改时间段来获取想要的数据
and  er_bxzb.pk_org  =  '0001E4100000000030JH'--这里通过更改组织编号来获取你想要的数据
order  by  er_bxzb.djbh;--通过单据号来排序