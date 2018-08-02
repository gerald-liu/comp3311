/* 1. GetEmployeeId(string userName): return id*/
select employeeId from Employee where userName='empcafa';

/* 2. GetEmployees(): return id, name; order by name */
select employeeId, employeeName from Employee order by employeeName;

/* 3. GetRegisteredUser(string userName): return all attributes */
select * from RegisteredUser where userName='lesterlo';

/* 4. UpdateRegisteredUser(*) */
update RegisteredUser
set firstName='fn', lastName='ln',
gender='F', phoneNo='12345678', userEmail='test@test.com'
where userName='lesterlo';

select * from RegisteredUser where userName='lesterlo';

update RegisteredUser
set firstName='Lester', lastName='Lo', gender='M',
    phoneNo='93456789', userEmail='llo@nomail.com'
where userName='lesterlo';

/* 5. GetClubMember(string userName): return all attributes */
select * from ClubMember where userName='lesterlo';

/* 6. InsertClubMember(*) */
insert into ClubMember values ('terrytam','01-APR-70','student','primary');

select * from ClubMember where userName='terrytam';

delete from ClubMember where userName='terrytam';

/* 7. UpdateClubMember(*) */
update ClubMember
set birthDate='01-APR-70', occupation='student', educationLevel='primary'
where userName='lesterlo';

select * from ClubMember where userName='lesterlo';

update ClubMember
set birthDate='20-MAR-87', occupation='teacher', educationLevel='tertiary'
where userName='lesterlo';

/* Given: GetCurrentEvents() */
select eventName, eventDate, eventTime, venue, memberFee, nonmemberfee, eventQuota, isMemberOnly
from Event where isAvailable='Y' and eventDate>=sysdate order by eventName;

/* 8. GetEventInformation(string eventId): return all attributes */
select * from Event where eventId='1';

/* 9. GetEventsIdAndName(string clubId): return id, name; order by name */
select Event.eventId, eventName from Event, HoldsEvent
where Event.eventId=HoldsEvent.eventId and HoldsEvent.clubId='1'
order by Event.eventName;

/* 10. GetJoinedEventsIdAndName(string userName): return id, name; order by name */
select Event.eventId, eventName from Event, JoinsEvent
where Event.eventId=JoinsEvent.eventId and userName='lesterlo'
order by Event.eventName;

/* 11. GetCurrentEventsJoined(string userName):
return id, name, date, time, venue, member fee and nonmember fee; order by name */
select Event.eventId, eventName, eventDate, eventTime, venue, memberFee, nonmemberfee
from Event, JoinsEvent
where eventDate>=sysdate and Event.eventId=JoinsEvent.eventId and userName='lesterlo'
order by eventName;

/* 12. GetPastEventsJoined(string userName):
return id, name, date, time, venue, member fee and nonmember fee; order by name */
select Event.eventId, eventName, eventDate, eventTime, venue, memberFee, nonmemberfee
from Event, JoinsEvent
where eventDate<sysdate and Event.eventId=JoinsEvent.eventId and userName='lesterlo'
order by eventName;

/* 13. GetEventsNotJoined(string userName):
return id, name, date, time, venue, member fee and nonmember fee
and REMAINING QUOTA of events not joined and availble to join
(isAvailable='Y', isMemberOnly?) */
select Event.eventId, eventName, eventDate, eventTime, venue,
    memberFee, nonmemberfee, eventQuota-count(*) as remainingQuota
from Event left outer join JoinsEvent on Event.eventId=JoinsEvent.eventId
where isAvailable='Y' and
    Event.eventId not in (select eventId from JoinsEvent where userName='lesterlo') and
    not (isMemberOnly='Y' and
        Event.eventId not in (select eventId from HoldsEvent, HasMember
            where HoldsEvent.clubId=HasMember.clubId and HasMember.userName='lesterlo'))
group by Event.eventId, eventName, eventDate, eventTime, venue,
    memberFee, nonmemberfee, eventQuota
order by eventName;

/* 14. GetJoinsEvent(string eventId): return eventId, userName, paidFee, attended;
order by userName */
select eventId, userName, paidFee, attended from JoinsEvent
where JoinsEvent.eventId='1' order by userName;

/* 15. GetModifiableEventsIdAndName(string clubId):
return eventId, eventName; order by eventName */
select Event.eventId, eventName from Event, HoldsEvent
where isAvailable='Y' and eventDate>=sysdate and
    Event.eventId=HoldsEvent.eventId and HoldsEvent.clubId='2'
order by eventName;

/* 16. JoinEvent(...): insert a registered user */
insert into JoinsEvent values (3, 'fredfan', 'Y', 'N');

select * from JoinsEvent where eventId=3 and userName='fredfan';

delete from JoinsEvent where eventId=3 and userName='fredfan';

/* 17. CreateEvent(*) */
insert into Event values (20,'Test Event','02-SEP-18','1100','Test Venue',10,20,30,'Y','N',1);

select * from Event where eventId=20;

/* 18. relate the new event to a fan club */
insert into HoldsEvent values (1, 20);
insert into HoldsEvent values (2, 20);
insert into HoldsEvent values (3, 20);

/* 19. UpdateEvent(*) */
update Event
set eventName='Test Event 2', eventDate='03-Oct-19', eventTime='2359', venue='Test Venue 2',
    memberFee='299', nonmemberFee='0', eventQuota='10',
    isAvailable='Y', isMemberOnly='Y', employeeId='2'
where eventId='20';

select * from Event where eventId=20;

/* 20. UpdatePaidFeeAndAttendance() */
update JoinsEvent set paidFee='N', attended='N' where eventId='16' and userName='lesterlo';

select * from JoinsEvent where eventId='16';

update JoinsEvent set paidFee='Y', attended='Y' where eventId='16' and userName='lesterlo';

select * from JoinsEvent where eventId='16';

/* 21. SetEventUnavailable(string eventId) */
update Event set isAvailable='N' where eventId='20';

select * from Event where eventId=20;

delete from Event where eventId=20;

/* GetFanClubs() */
select * from FanClub order by clubName;

/* 22. GetFanClubsJoined(string userName):
return id, name, description; order by name */
select FanClub.clubId, clubName, description from FanClub, HasMember
where FanClub.clubId=HasMember.clubId and HasMember.userName='lesterlo'
order by clubName;

/* 23. GetFanClubsNotJoined(string userName):
return id, name, description; order by name */
select distinct FanClub.clubId, clubName, description from FanClub, HasMember
where FanClub.clubId=HasMember.clubId and
    HasMember.clubId not in (select clubId from HasMember where userName='lesterlo')
order by clubName;

/* 24. JoinFanClub(*) */
insert into HasMember values (1,'wendywong','02-AUG-18','web ad');

select * from HasMember where userName='wendywong';

delete from HasMember where clubId='1' and userName='wendywong';

/* 25. CreateFanClub(*) */
insert into FanClub values (11,'Test Club','Test Description','01-AUG-18');

select * from FanClub where clubId='11';

/* 26. UpdateFanClub(*) */
update FanClub
set clubName='Test Club 2', description='Test Description 2', dateEstablished = '31-JUL-18'
where clubId='11';

select * from FanClub where clubId='11';

delete from FanClub where clubId='11';

/* 27. GetEventIdAndNameWithRemarksForEmployee(string employeeId):
return id, name of events whose remarks either
have status not equal to 'done' AND assigned to an employee,
OR the employee id is null. order by eventName */
select distinct Remark.eventId, eventName from Remark, Event
where Remark.eventId=Event.eventId and (Remark.status<>'done' or Remark.status is null) and
    (Remark.employeeId is null or Remark.employeeId=2)
order by eventName;

/* 28. GetAvailableEventRemarksForProcessing(string eventId, string employeeId):
return all attributes for remarks of this event, which
either have status not equal to 'done' AND assigned to an employee,
OR the employee id is null. order by subject */
select * from Remark
where Remark.eventId='7' and (Remark.status<>'done' or Remark.status is null) and
    (Remark.employeeId is null or Remark.employeeId=2)
order by subject;

/* 29. GetEventsWithRemarksFromUserName(string userName):
return id, name of events for which the club member has submitted a remark. order by name */
select distinct Remark.eventId, eventName from Remark, Event
where userName='susansze' and Remark.eventId=Event.eventId
order by eventName;

/* 30. GetEventRemarksForUserName(string userName, string eventId):
return all attributes of all remarks from the user about this event. order by subject */
select * from Remark
where userName='susansze' and eventId='7'
order by subject;

/* 31. GetFanClubIdAndNameWithRemarksForEmployee(string employeeId):
return id, name of clubs whose remarks either
have status not equal to 'done' AND assigned to an employee,
OR the employee id is null. order by clubName */
select distinct Remark.clubId, clubName from Remark, FanClub
where Remark.clubId=FanClub.clubId and (Remark.status<>'done' or Remark.status is null) and
    (Remark.employeeId is null or Remark.employeeId=3)
order by clubName;

/* 32. GetAvailableFanClubRemarksForProcessing(string clubId, string employeeId):
return all attributes for remarks of this club, which
either have status not equal to 'done' AND assigned to an employee,
OR the employee id is null. order by subject */
select * from Remark
where Remark.clubId='6' and (Remark.status<>'done' or Remark.status is null) and
    (Remark.employeeId is null or Remark.employeeId=3)
order by subject;

/* 33. GetFanClubsWithRemarksFromUserName(string userName):
return id, name of clubs for which the club member has submitted a remark. order by name */
select distinct Remark.clubId, clubName from Remark, FanClub
where userName='susansze' and Remark.clubId=FanClub.clubId
order by clubName;

/* 34. GetFanClubRemarksForUserName(string userName, string clubId):
return all attributes of all remarks from the user about this club. order by subject */
select * from Remark
where userName='susansze' and clubId='6'
order by subject;

/* 35. SubmitRemark(*) */
insert into Remark values (11,'Test Subject','Test Text','11-Mar-18','read',null,'event','peterpoon',1,null,7);

select * from Remark where remarkId='11';

/* 36. UpdateRemark(*) */
update Remark set status='processing', actionTaken='Test Action', employeeId='2' where remarkId='11';

select * from Remark where remarkId='11';

delete from Remark where remarkId='11';