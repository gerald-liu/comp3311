/* COMP3311 Lab 4 Lab4TestQueries.sql */

set linesize 150;

/* Display average grade for each student */
with StudentAvgGrade as
(select EnrollsIn.studentId, avg(grade) as avgGrade
 from Student, EnrollsIn
 group by EnrollsIn.studentId)
 
select Student.studentId, firstName, lastName, avgGrade
from Student, StudentAvgGrade
where Student.studentId=StudentAvgGrade.studentId
order by avgGrade desc;

/* Test on Student table: departmentId cannot be null */
insert into Student values ('22222222', 'John', 'Chan', 'jchan', '23321334', 0.00, null, '2014');

/* Test on student table: no matching departmentId in Department table */ 
insert into Student values ('33333333', 'Amelia', 'Fong', 'afong', '22223334', 0.00, 'PHYS', '2014');

/* Test on Course table: no matching departmentId in Department table */
insert into Course values ('PHYS4311', 'PHYS', 'Nuclear Pasta', 'Albert Einstein');

/* Test on Facility table: no matching departmentId in Department table */
insert into Facility values ('CHEM', 'Chemistry', 2, 5);

/* Test on EnrollsIn table: no matching courseId in Course table */
insert into EnrollsIn values ('13456789', 'PHYS4311', 80.6);

/* Test on EnrollsIn table: no matching studentId in Student table */
insert into EnrollsIn values ('99999999', 'COMP3311', 75.6);

/* Test on Student table: cga not in allowed range */
insert into Student values ('44444444', 'Andrew', 'Li', 'ali', '25524334', 4.50, 'COMP', '2015');

/* Test on EnrollsIn table: grade not in allowed range */
insert into EnrollsIn values ('99987654', 'COMP3311', 100.1);

/* Test cascade delete on Student table */
delete from Student where studentId = '13456789';
select * from EnrollsIn where studentId = '13456789';