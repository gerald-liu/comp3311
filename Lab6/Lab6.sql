/* COMP3311 Lab 6 Lab6.sql */

/* Drop any existing constraints */
select 'alter table '||u.table_name||' drop constraint '||c.constraint_name  
from user_tables u, user_constraints c
where u.table_name=c.table_name;

/* NOTE: Due to the integrity constraints, the order in which tables are dropped is important */
drop table EnrollsIn;
drop table Facility;
drop table Student;
drop table Course;
drop table Department;
drop table LowCga;

/* NOTE: Due to the integrity constraints, the order in which tables are created is important */
create table Department (
	departmentId    char(4) primary key,
	departmentName  varchar2(40),
	roomNo          char(4));

create table Student (
	studentId       char(8) primary key,
	firstName       varchar2(20) not null,
	lastName        varchar2(25) not null,
	email           varchar2(30) not null,
	phoneNo         char(8),
	cga             number(3,2),
	departmentId    char(4) not null references Department(departmentId) on delete set null,
	admissionYear	char(4),
	constraint cgaCheck check (cga between 0.00 and 12.00));

create table Course (
	courseId        char(8) primary key,
	departmentId    char(4) not null references Department(departmentId) on delete cascade,
	courseName      varchar2(40),
	credits         int,
	instructor		varchar2(30) not null);

create table EnrollsIn (
 	studentId   char(8) references Student(studentId) on delete cascade,
	courseId	char(8) references Course(courseId) on delete cascade,
	grade       number(4,1),
	primary key(studentId,courseId),
	constraint gradeCheck check (grade between 0.0 and 100.0));

create table Facility ( 
  	departmentId		char(4) primary key references Department(departmentId) on delete cascade,
	departmentName		varchar2(40),
	numberProjectors    number(4),
	numberComputers  	number(5)
);

create table LowCga (
	studentId		char(8) primary key,
	firstName		varchar2(20) not null,
	lastName		varchar2(25) not null,
	email			varchar2(30) not null,
	phoneNo         char(8),
	cga				number(3,2),
	departmentId	char(4) not null,
	admissionYear   char(4));

/* Populate the tables with data */
insert into Department values ('COMP','Computer Science',3528);
insert into Department values ('MATH','Mathematics',3461);
insert into Department values ('ELEC','Electronic Engineering',2528);
insert into Department values ('BUS','Business',4528);
insert into Department values ('HUMA','Humanities',1200);

insert into Student values ('13455789','Harry','Potter','cs_hpx','23581234',null,'COMP','2013');
insert into Student values ('15456789','Leonardo','Da Vinci','cs_ldv','23585678',null,'COMP','2014');
insert into Student values ('13556789','Legolas','Greenleaf','ma_lgx','23582468',null,'MATH','2015');
insert into Student values ('13456789','Rita','Lai','cs_rlx','23581234',null,'COMP','2015');
insert into Student values ('15678989','Maria','Yip','cs_mya','23589876',null,'COMP','2015');
insert into Student values ('15678901','Albert','Yip','cs_ayx','23585678',null,'COMP','2014');
insert into Student values ('16789012','Robert','Ko','ma_rkx','23582468',null,'MATH','2015');
insert into Student values ('14567890','Julius','Caeser','ee_jcx','23589876',null,'ELEC','2013');
insert into Student values ('99987654','Lazy','Lazy','lz_llx','23581357',null,'COMP','2015');
insert into Student values ('26184624','Bruce','Wayne','ee_bwab','28261057',null,'ELEC','2013');
insert into Student values ('26184444','Donald','Trump','bs_dt','28255057',null,'BUS','2014');
insert into Student values ('26186666','Warren','Bufffet','bs_wb','28266027',null,'BUS','2015');
insert into Student values ('66666666','Ferris','Bueller','bs_fb','28282727',null,'BUS','2014');

insert into Course values ('COMP3311','COMP','Database Management Systems',3,'Chen Lei');
insert into Course values ('COMP4021','COMP','Internet Computing',3,'David Rossiter');
insert into Course values ('ELEC3100','ELEC','Signal Processing and Communications',4,'Electronic Man');
insert into Course values ('MATH2421','MATH','Probability',4,'Isaac Newton');
insert into Course values ('HUMA1020','HUMA','Chinese Writing and Culture',3,'Human Man');

insert into EnrollsIn values ('13455789','COMP3311',85.6);
insert into EnrollsIn values ('15456789','COMP3311',77.9);
insert into EnrollsIn values ('13556789','COMP3311',89.5);
insert into EnrollsIn values ('14567890','COMP3311',60.4);
insert into EnrollsIn values ('99987654','COMP3311',50.0);
insert into EnrollsIn values ('13456789','COMP3311',66.9);
insert into EnrollsIn values ('15678989','COMP3311',71.8);
insert into EnrollsIn values ('15678901','COMP3311',64.3);
insert into EnrollsIn values ('26184624','COMP3311',62.1);
insert into EnrollsIn values ('26184444','COMP3311',52.1);
insert into EnrollsIn values ('26186666','COMP3311',82.1);

insert into EnrollsIn values ('13455789','COMP4021',61.3);
insert into EnrollsIn values ('15456789','COMP4021',65.9);
insert into EnrollsIn values ('13556789','COMP4021',83.1);
insert into EnrollsIn values ('14567890','COMP4021',56.8);
insert into EnrollsIn values ('13456789','COMP4021',71.3);
insert into EnrollsIn values ('15678989','COMP4021',55.2);
insert into EnrollsIn values ('15678901','COMP4021',82.1);
insert into EnrollsIn values ('16789012','COMP4021',75.3);
insert into EnrollsIn values ('26184624','COMP4021',77.1);
insert into EnrollsIn values ('26186666','COMP4021',92.1);

insert into EnrollsIn values ('13455789','ELEC3100',74.1);
insert into EnrollsIn values ('15456789','ELEC3100',60.0);
insert into EnrollsIn values ('13556789','ELEC3100',86.2);
insert into EnrollsIn values ('14567890','ELEC3100',59.1);
insert into EnrollsIn values ('99987654','ELEC3100',58.3);
insert into EnrollsIn values ('13456789','ELEC3100',68.3);
insert into EnrollsIn values ('15678989','ELEC3100',74.6);
insert into EnrollsIn values ('15678901','ELEC3100',72.9);
insert into EnrollsIn values ('26184624','ELEC3100',83.7);
insert into EnrollsIn values ('26184444','ELEC3100',55.6);
insert into EnrollsIn values ('26186666','ELEC3100',95.1);

insert into EnrollsIn values ('13455789','HUMA1020',82.4);
insert into EnrollsIn values ('15456789','HUMA1020',95.2);
insert into EnrollsIn values ('13556789','HUMA1020',88.4);
insert into EnrollsIn values ('14567890','HUMA1020',56.2);
insert into EnrollsIn values ('99987654','HUMA1020',50.2);
insert into EnrollsIn values ('13456789','HUMA1020',91.6);
insert into EnrollsIn values ('15678989','HUMA1020',99.0);

insert into EnrollsIn values ('13455789','MATH2421',73.5);
insert into EnrollsIn values ('15456789','MATH2421',77.2);
insert into EnrollsIn values ('14567890','MATH2421',57.5);
insert into EnrollsIn values ('13556789','MATH2421',88.3);
insert into EnrollsIn values ('13456789','MATH2421',84.3);
insert into EnrollsIn values ('15678989','MATH2421',73.1);
insert into EnrollsIn values ('15678901','MATH2421',66.4);
insert into EnrollsIn values ('16789012','MATH2421',68.4);
insert into EnrollsIn values ('26184624','MATH2421',55.1);
insert into EnrollsIn values ('26184444','MATH2421',42.1);
insert into EnrollsIn values ('26186666','MATH2421',83.5);

insert into Facility values ('COMP','Computer Science',5,150);
insert into Facility values ('MATH','Mathematics',5,30);
insert into Facility values ('ELEC','Electronic Engineering',5,150);
insert into Facility values ('BUS','Business',5,30);

/* Execute the InsertMyself script file */
@Lab6InsertMyself

/* Lab 6 Task */
create unique index student_index on Student(email);

/* Write the data to disk */
commit;