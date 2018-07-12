/* COMP3311 Lab 6 lab6DuplicateEmailCheck.sql */

declare
	begin
		/* Check whether a unique index has been created on the email attribute of the student relation */
		insert into Student values ('26189999', 'Duplicate', 'Email', 'bs_wb', '29566035', null, 'BUS', '2013');
	exception
		when DUP_VAL_ON_INDEX then
			dbms_output.put_line('### Tried to insert duplicate email into student relation.');
	end;
/