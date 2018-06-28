/* Query 1 */
select studentId, firstName, lastName, email
from student
where departmentId = 'COMP' and cga = (select max(cga) from student);

/* Query 2 */
select courseId, avg(cga)
from student, enrollsIn
where student.studentId = enrollsIn.studentId
group by courseId;

/* Query 3 */
select enrollsIn.courseId, lastName, firstName, departmentId, cga
from (select courseId, max(cga) as maxcga
      from student, enrollsIn
      where student.studentId = enrollsIn.studentId
      group by courseId) result,
      student, enrollsIn
where cga = maxcga and result.courseId = enrollsIn.courseId and student.studentId = enrollsIn.studentId;

commit;