/* COMP3311 Lab 6 Lab6CgaCalculations.sql */

declare
	/* Declare the variables needed for the CGA calculation */
    gradePoint decimal(3,2);
	currentStudentId Student.studentId%type;
    courseCredits Course.credits%type;
	honoursCga Student.cga%type := 3.5;
	studentLowCga Student.cga%type := 2;
	studentCga Student.cga%type;
	sumCredits Course.credits%type;
	sumCreditsTimesGradePoint decimal(6,2);
	
	/* Declare the cursors for the Student and EnrollsIn tables */
	cursor studentCursor is select studentId, firstName, lastName from Student;
	cursor enrollsInCursor is select courseId, grade from EnrollsIn where studentId=currentStudentId;
	begin
		/* Fetch each Student record */
		for studentRecord in studentCursor loop
			currentStudentId := studentRecord.studentId;
			/* Reset the variables used to calculate the CGA */
			sumCreditsTimesGradePoint := 0;
			sumCredits := 0;
				
			/* Fetch each EnrollsIn record of the student */
			for enrollsInRecord in enrollsInCursor loop		
				/* Determine grade point from the course grade */
				gradePoint := greatest((enrollsInRecord.grade / 20) - 1, 0);
				select credits into courseCredits from Course where courseId=enrollsInRecord.courseId;
				
				/* Collect the data needed to calculate the student's CGA  */
				sumCredits := sumCredits + courseCredits;
				sumCreditsTimesGradePoint := sumCreditsTimesGradePoint + courseCredits * gradePoint;
			end loop; /* For fetching EnrollsIn records of a student */
			
			/* Calculate and update the student's CGA */
			begin
				/* Throws an exception if there is no EnrollsIn record */
                studentCga := sumCreditsTimesGradePoint / sumCredits;
				update Student set cga=studentCga where studentId=currentStudentId;
			
				/* Output honours message if needed */
				if studentCga >= honoursCga then
					dbms_output.put_line('>>> ' || studentRecord.firstName || ' ' || studentRecord.lastName || 
						' (' || currentStudentId || ') with CGA=' || studentCga || ' is an honours Student.');
				end if;

                /* Add the student to the LowCga table if needed */
				if studentCga <= studentLowCga then
					insert into LowCga select * from Student where studentId=currentStudentId;

					/* TODO: Output low cga message */
					dbms_output.put_line('*** Low CGA alert for ' || studentRecord.firstName || ' ' || studentRecord.lastName || 
						' (' || currentStudentId || ') with CGA=' || studentCga || '.');
			    end if;	
			exception
				/* TODO: Output message no EnrollsIn record for student */
				when ZERO_DIVIDE then
					dbms_output.put_line('### ' || studentRecord.firstName || ' ' || studentRecord.lastName || 
						' (' || currentStudentId || ') is not enrolled in any course.');
			end;
		end loop; /* For fetching each Student record */
	end;
	/