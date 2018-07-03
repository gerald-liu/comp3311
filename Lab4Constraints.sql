alter table Student add constraint student_fk_dept foreign key (departmentId) references Department(departmentId)
    on delete cascade;
alter table Course add constraint course_fk_dept foreign key (departmentId) references Department(departmentId)
    on delete cascade;
alter table Facility add constraint facility_fk_dept foreign key (departmentId) references Department(departmentId)
    on delete cascade;
alter table EnrollsIn add constraint enrollsin_fk_student foreign key (studentId) references Student(studentId)
    on delete cascade;
alter table EnrollsIn add constraint enrollsin_fk_course foreign key (courseId) references Course(courseId)
    on delete cascade;

alter table Student add constraint student_cga_range check (cga between 0 and 4);

alter table EnrollsIn add constraint enrollsin_grade_range check (grade between 0 and 100);