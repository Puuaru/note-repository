# SQL 排名

## 通过 limit 语句完成排名

可以通过 order by 子句 + limit 来完成排名，但是这样的排名并不准确：

1. 要求只要对数值排名或排名不算并排，比如 “搜索前三的薪资” 而不是 “搜索前三薪资的员工”，
后者可能出现相同薪资导致并列者被挤占
2. 无法分组，比如 “搜索各部门前三的薪资员工”，因只能显示三条数据而不能进行分组操作

```SQL
select e.name, e.salary
from Employee as e
order by e.salary desc
limit 0, 3
```

## 通过 count + 子查询完成排名

通过 count 函数统计遍历时比当前记录大/小的其他记录个数，从而控制搜索排名

```SQL
select d.name as 'department', e.name as 'employee', e.salary as 'salary'
from Employee as e
join Department as d on e.departmentId = d.id
where 3 > (
    select count(distinct et.salary)
    from Employee as et
    where et.salary > e.salary
        and et.departmentId = e.departmentId
)
```

上面的代码记当前记录的薪资为 `e.salary`，子查询统计比 `e.salary` 大的数据个数，
条件语句要求查找出来的记录 “在整个表中比它大的数据个数小于3个”，由此完成排名，
若要排序还可以再加上 order by 子句

上面的代码虽然冗长，但是还可以搭配连接完成分组排名
