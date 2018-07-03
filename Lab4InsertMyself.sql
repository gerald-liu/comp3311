/* COMP3311 InsertMyself.sql */

insert into Student values ('20413306', 'Weiyang', 'Liu', 'wliuax', '12345678', 3.57, 'COMP', '2015');

insert into EnrollsIn values ('20413306','COMP3311', 95.6);
insert into EnrollsIn values ('20413306','COMP4021', 88.3);
insert into EnrollsIn values ('20413306','ELEC3100', 93.1);
insert into EnrollsIn values ('20413306','HUMA1020', 88.4);
insert into EnrollsIn values ('20413306','MATH2421', 90.5);

/* Write the data to disk */
commit;