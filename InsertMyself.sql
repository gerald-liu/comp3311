/* COMP3311 Lab 1 Lab1.sql */

/* Start with a clean database */
drop table Student;

/* Create the Student table */
create table Student (
	studentId   char(8) not null,
	firstName   varchar2(20) not null,
	lastName    varchar2(25) not null,
	email       varchar2(30) not null,
	phoneNo     char(8),
	cga         number(4,2));

/* Populate the Student table with data */
insert into Student values ('13455789','Harry','Potter','cs_hpx','23581234',2.76);
insert into Student values ('15456789','Leonardo','Da Vinci','cs_ldv','23585678',2.72);
insert into Student values ('13556789','Legolas','Greenleaf','ma_lgx','23582468',3.36);
insert into Student values ('13456789','Rita','Lai','cs_rlx','23581234',2.83);
insert into Student values ('15678989','Maria','Yip','cs_mya','23589876',2.73);
insert into Student values ('15678901','Albert','Yip','cs_ayx','23585678',2.56);
insert into Student values ('16789012','Robert','Ko','ma_rkx','23582468',2.57);
insert into Student values ('14567890','Julius','Caeser','ee_jcx','23589876',1.90);
insert into Student values ('99987654','Lazy','Lazy','lz_llx','23581357',1.67);
INSERT INTO Student VALUES ('20413306','Weiyang','Liu','wliuax','12345678',3.70);

SELECT * FROM Student

/* Write the data to disk */
commit;