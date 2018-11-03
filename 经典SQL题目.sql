# 题目地址：https://blog.csdn.net/qq_36330228/article/details/77893368
#1、查询”01”课程比”02”课程成绩高的学生的信息及课程分数
# Having
# 重点：把课程1 课程2的成绩变换到一行(sc1.cid = 1 and sc2.cid = 2)
select
  s.sname,
  c1.cname,
  sc1.score C1,
  c2.cname,
  sc2.score C2
from sc sc1, sc as sc2, course c1, course c2, student s
where
  sc1.cid = 1
  and sc2.cid = 2
  and sc1.sid = sc2.sid
  and sc1.score > sc2.score
  and c1.cid = sc1.cid
  and c2.cid = sc2.cid
  and s.sid = sc1.sid;

#2、查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩

select
  sc.sid,
  student.sname,
  avg(score)
from sc, student
where sc.sid = student.sid
group by sid
having avg(score) > 60;

#3、查询名字中含有”风”字的学生信息
select *
from student
where sname like '%风%';

# 4、查询课程名称为”数学”，且分数低于60的学生姓名和分数
select
  s.sname,
  sc.score
from student s, sc, course c
where s.sid = sc.sid and sc.cid = c.cid
      and c.cname = '数学' and score < 60;

# 5、查询没学过”张三”老师授课的同学的信息
# 思路: 查出所有张三老师关联的课程的成绩(X)，学生id不存在于X中的即为结果
select * from student
where sid not in (
  select sid
  from sc s,course c,teacher t
  where s.cid = c.cid and c.tid = t.tid and t.tname = '张三'
);

#6、学过张三老师授课的同学的信息
select * from student
where sid in (
  select sid
  from sc s,course c,teacher t
  where s.cid = c.cid and c.tid = t.tid and t.tname = '张三'
);

# 将in的子查询 改写成join的关联查询 原理：not in 关联出来的为null
explain select * from student left join
(select sid
 from sc s, course c, teacher t
 where s.cid = c.cid and c.tid = t.tid and t.tname = '张三'
) tmp on student.sid = tmp.sid and tmp.sid is null
where tmp.sid is null;

show tables ;



