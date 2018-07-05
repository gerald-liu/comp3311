/* COMP3311 Lab 5 Lab5TestQueries.sql */

select studentId, firstName, lastName, cga from Student order by cga desc;

select studentId, firstName, lastName, cga from Lowcga order by cga desc;