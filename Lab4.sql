/* COMP3311 Lab 4 Lab4.sql */

/* Drop any existing user constraints */
select 'alter table '||u.table_name||' drop constraint '||c.constraint_name  
from user_tables u, user_constraints c
where u.table_name=c.table_name;

/* Start with a clean database */
drop table EnrollsIn;
drop table Facility;
drop table Student;
drop table Course;
drop table Department;

/* Create the tables */
create table Department (
	departmentId    char(4) primary key,
	departmentName  varchar2(40) not null,
	roomNo          number(4));

create table Student (
	studentId       char(8) primary key,
	firstName       varchar2(20) not null,
	lastName        varchar2(25) not null,
	email           varchar2(30) not null,
	phoneNo         char(8),
	cga             number(3,2),
	departmentId    char(4) not null,
	admissionYear   char(4) not null);

create table course (
	courseId        char(8) primary key,
	departmentId    char(4) not null,
	course_name     varchar2(40) not null,
	instructor      varchar2(30) not null);

create table EnrollsIn (
 	studentId   char(8),
	courseId    char(8),
	grade       number(4,1),
	primary key(studentId,courseId));

create table Facility ( 
	departmentId        char(4) primary key,
	departmentName      varchar2(40) not null,
	numberProjectors    number(4),
	numberComputers     number(5));

/* Populate the tables with data */
insert into Student values ('13455789','Harry','Potter','cs_hpx','23581234',2.76,'COMP','2013');
insert into Student values ('15456789','Leonardo','Da Vinci','cs_ldv','23585678',2.72,'COMP','2014');
insert into Student values ('13556789','Legolas','Greenleaf','ma_lgx','23582468',3.36,'MATH','2015');
insert into Student values ('13456789','Rita','Lai','cs_rlx','23581234',2.83,'COMP','2015');
insert into Student values ('15678989','Maria','Yip','cs_mya','23589876',2.73,'COMP','2015');
insert into Student values ('15678901','Albert','Yip','cs_ayx','23585678',2.56,'COMP','2014');
insert into Student values ('16789012','Robert','Ko','ma_rkx','23582468',2.57,'MATH','2015');
insert into Student values ('14567890','Julus','Ceasar','ee_jcx','23589876',1.90,'ELEC','2015');
insert into Student values ('99987654','Lazy','Lazy','lz_llx','23581357',1.67,'COMP','2015');

insert into EnrollsIn values ('13456789','COMP3311',85.6);
insert into EnrollsIn values ('14567890','COMP3311',66.4);
insert into EnrollsIn values ('15456789','COMP3311',77.9);
insert into EnrollsIn values ('13556789','COMP3311',89.5);
insert into EnrollsIn values ('15678989','COMP3311',72.3);
insert into EnrollsIn values ('16789012','COMP3311',82.1);

insert into EnrollsIn values ('13456789','COMP4021',61.3);
insert into EnrollsIn values ('14567890','COMP4021',66.8);
insert into EnrollsIn values ('16789012','COMP4021',65.3);

insert into EnrollsIn values ('13456789','ELEC3100',74.1);
insert into EnrollsIn values ('15456789','ELEC3100',60.0);
insert into EnrollsIn values ('99987654','ELEC3100',78.3);
insert into EnrollsIn values ('15678989','ELEC3100',77.9);

insert into EnrollsIn values ('13456789','HUMA1020',82.4);
insert into EnrollsIn values ('16789012','HUMA1020',87.2);
insert into EnrollsIn values ('99987654','HUMA1020',90.2);

insert into EnrollsIn values ('13456789','MATH2421',73.5);
insert into EnrollsIn values ('14567890','MATH2421',77.5);
insert into EnrollsIn values ('13556789','MATH2421',88.3);
insert into EnrollsIn values ('16789012','MATH2421',66.9);

insert into course values ('COMP3311','COMP','Database Management Systems','Chen Lei');
insert into course values ('COMP4021','COMP','Internet Computing','David Rossiter');
insert into course values ('ELEC3100','ELEC','Signal Processing and Communications','Electronic Man');
insert into course values ('MATH2421','MATH','Probability','Isaac Newton');
insert into course values ('HUMA1020','HUMA','Chinese Writing and Culture','Human Man');

insert into Department values ('COMP','Computer Science',3528);
insert into Department values ('MATH','Mathematics',3461);
insert into Department values ('ELEC','Electronic Engineering',2528);
insert into Department values ('BUS','Business',4528);
insert into Department values ('HUMA','Humanities',1200);

insert into Facility values ('COMP','Computer Science',5,150);
insert into Facility values ('MATH','Mathematics',5,30);
insert into Facility values ('ELEC','Electronic Engineering',5,150);
insert into Facility values ('BUS','Business',5,30);

/* Execute the InsertMyself script file */
@Lab4InsertMyself

/* Write the data to disk */
commit;