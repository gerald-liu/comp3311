/* Query 1 */
select studentId as "Id", firstName as "First name", lastName as "Last name", email as "Email"
from Student
where departmentId = 'COMP';

/* Query 2 */
select studentId, firstName, lastName, cga
from Student
where departmentId in ('ELEC', 'MATH') and cga not between 2.4 and 2.8;

/* Query 3 */
select firstName from Student where firstName like '__r%';

/* Query 4 */
select lastName from Student where lastName like '%c%' or lastName like '%z%';

commit;