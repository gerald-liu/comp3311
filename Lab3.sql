/* COMP3311 Lab 3 Lab3.sql */

/* Start with a clean database */
drop table Student;
drop table Course;
drop table Department;
drop table Facility;
drop table EnrollsIn;

/* Create the tables */
create table student (
	studentId		char(8) not null,
	firstName		varchar2(20) not null,
	lastName		varchar2(25) not null,
	email			varchar2(30) not null,
	phoneNo         char(8),
	cga				number(3,2),
	departmentId	char(4) not null,
	admissionYear   char(4) not null);

create table enrollsIn (
 	studentId	char(8) not null,
	courseId	char(8));

create table course (
	courseId		char(8) not null,
	departmentId	char(4) not null,
	courseName		varchar2(40) not null,
	instructor		varchar2(30) not null);

create table department (
	departmentId	char(4) not null,
	departmentName	varchar2(40) not null,
	roomNo		char(4)	);

create table facility ( 
  	departmentId        char(4) not null,
	departmentName      varchar2(40) not null,
	numberProjectors    number(4),
	numberComputers     number(5));

/* Populate the tables with data */
insert into Student values ('13455789','Harry','Potter','cs_phx','23581234',2.76,'COMP','2013');
insert into Student values ('15456789','Leonardo','Da Vinci','cs_dvl','23585678',2.72,'COMP','2014');
insert into Student values ('13556789','Legolas','Greenleaf','ma_glx','23582468',3.36,'MATH','2015');
insert into Student values ('13456789','Rita','Lai','cs_lrx','23581234',2.83,'COMP','2015');
insert into Student values ('15678989','Maria','Yip','cs_yma','23589876',2.73,'COMP','2015');
insert into Student values ('15678901','Albert','Yip','cs_yax','23585678',2.56,'COMP','2014');
insert into Student values ('16789012','Robert','Ko','ma_krx','23582468',2.57,'MATH','2015');
insert into Student values ('14567890','Julius','Ceasar','ee_cdx','23589876',1.90,'ELEC','2015');
insert into Student values ('99987654','Lazy','Lazy','lz_llx','23581357',1.67,'COMP','2015');

insert into EnrollsIn values ('13456789','COMP3311');
insert into EnrollsIn values ('14567890','COMP3311');
insert into EnrollsIn values ('15456789','COMP3311');
insert into EnrollsIn values ('13556789','COMP3311');
insert into EnrollsIn values ('15678989','COMP3311');
insert into EnrollsIn values ('16789012','COMP3311');

insert into EnrollsIn values ('13456789','COMP4021');
insert into EnrollsIn values ('14567890','COMP4021');
insert into EnrollsIn values ('16789012','COMP4021');

insert into EnrollsIn values ('13456789','ELEC3100');
insert into EnrollsIn values ('15456789','ELEC3100');
insert into EnrollsIn values ('99987654','ELEC3100');
insert into EnrollsIn values ('15678989','ELEC3100');

insert into EnrollsIn values ('13456789','HUMA1020');
insert into EnrollsIn values ('16789012','HUMA1020');
insert into EnrollsIn values ('99987654','HUMA1020');

insert into EnrollsIn values ('13456789','MATH2421');
insert into EnrollsIn values ('14567890','MATH2421');
insert into EnrollsIn values ('13556789','MATH2421');
insert into EnrollsIn values ('16789012','MATH2421');

insert into EnrollsIn values ('99987654',null);

insert into Course values ('COMP3311','COMP','Database Management Systems','Chen Lei');
insert into Course values ('COMP4021','COMP','Internet Computing','David Rossiter');
insert into Course values ('ELEC3100','ELEC','Signal Processing and Communications','Electronic Man');
insert into Course values ('MATH2421','MATH','Probability','Isaac Newton');
insert into Course values ('HUMA1020','HUMA','Chinese Writing and Culture','Human Man');

insert into Department values ('COMP','Computer Science',3528);
insert into Department values ('MATH','Mathematics',3461);
insert into Department values ('ELEC','Electronic Engineering',2528);
insert into Department values ('BUS','Business',4528);
insert into Department values ('HUMA','Humanities',1200);

insert into Facility values ('COMP','Computer Science',5,150);
insert into Facility values ('MATH','Mathematics',5,30);
insert into Facility values ('ELEC','Electronic Engineering',5,150);
insert into Facility values ('BUS','Business',5,30);

/* Write the data to disk */
commit;