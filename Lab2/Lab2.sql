/* COMP3311 Lab 2 Lab2.sql */

/* Start with a clean database */
drop table Student;
drop table Department;

/* Create the tables */
create table Student (
	studentId		char(8) not null,
	firstName		varchar2(20) not null,
	lastName		varchar2(25) not null,
	email			varchar2(30) not null,
	phoneNo         char(8),
	cga             number(3,2),
	departmentId    char(4) not null);

create table Department (
	departmentId	char(4) not null,
	departmentName	varchar2(40) not null,
	roomNo          number(4));

/* Populate the tables with data */
insert into Student values ('13455789','Harry','Potter','cs_phx','23581234',2.76,'COMP');
insert into Student values ('15456789','Leonardo','Da Vinci','cs_dvl','23585678',2.72,'COMP');
insert into Student values ('13556789','Legolas','Greenleaf','ma_glx','23582468',3.36,'MATH');
insert into Student values ('13456789','Rita','Lai','cs_lrx','23581234',2.83,'COMP');
insert into Student values ('15678989','Maria','Yip','cs_yma','23589876',2.73,'COMP');
insert into Student values ('15678901','Albert','Yip','cs_yax','23585678',2.56,'COMP');
insert into Student values ('16789012','Robert','Ko','ma_krx','23582468',2.57,'MATH');
insert into Student values ('14567890','Julius','Ceasar','ee_xdx','23589876',1.90,'ELEC');
insert into Student values ('99987654','Lazy','Lazy','lz_llx','23581357',null,'COMP');

insert into Department values ('COMP','Computer Science',3528);
insert into Department values ('MATH','Mathematics',3461);
insert into Department values ('ELEC','Electronic Engineering',2528);
insert into Department values ('BUS','Business',4528);
insert into Department values ('HUMA','Humanities',1200);

/* Write the data to disk */
commit;