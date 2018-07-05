/* COMP3311 Lab 5  Lab5CgaCalculations.sql */

declare
	/* TODO: Complete the declaration of all the variables needed for the CGA calculation */
	gradePoint float;
	varCredits int;
	varTotalCredits int;
	varSumGradeMultCredits float;
	varCga float;

	currSId Student.studentId%type;

	/* TODO: Complete the declaration of the cursors for the Student and EnrollsIn tables */
	cursor studentCursor is select * from Student; 
	cursor enrollsInCursor is select * from EnrollsIn where studentId = currSId;
    
	begin
		/* TODO: Complete the loop to fetch each Student record */
		for studentRecord in studentCursor loop
			varTotalCredits := 0;
			varSumGradeMultCredits := 0;
			varCga := 0;
			currSId := studentRecord.studentId;
			
			/* TODO: Complete the loop to fetch each EnrollsIn record of the current student */
			for enrollsInRecord in enrollsInCursor loop
				/* Determine the grade point from the course grade */
				gradePoint := greatest((enrollsInRecord.grade / 20) - 1, 0);
				
				/* TODO: Collect the data needed to calculate the current student's CGA  */
				select credits into varCredits from Course where courseId = enrollsInRecord.courseId;
				varTotalCredits := varTotalCredits + varCredits;
				varSumGradeMultCredits := varSumGradeMultCredits + gradePoint * varCredits;
			end loop; /* For fetching each EnrollsIn record of the current student */

			/* TODO: Calculate and update the current student's CGA */
			varCga := varSumGradeMultCredits / varTotalCredits;
			update Student set cga = varCga where studentId = currSId;
			
			/* TODO: Add the current student to the LowCga table if needed */
			if (varCga <= 2) then
				insert into LowCga (select * from Student where studentId = currSId);
			end if;
		end loop; /* For fetching each Student record */
	end;
	/