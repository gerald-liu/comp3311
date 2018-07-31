/*select 'alter table'||u.table_name||'drop constraint'||c,constraint_name
from user_tables u, user_constraints c 
where u.table_name=c.table_name;*/

drop table Remark;
drop table JoinsEvent;
drop table HasMember;
drop table ClubMember;
drop table HoldsEvent;
drop table Event;
drop table Employee;
drop table FanClub;
drop table RegisteredUser;


create table RegisteredUser(
	userName		char(10) primary key,
	firstName		varchar2(15) not null,
	lastName		varchar2(20) not null,
	gender			char(1) not null,
	phoneNo			char(8) not null,
	userEmail		varchar2(30)not null,
	constraint	GENDER_WORD check (gender='M' or gender='F'),
	constraint	PHONE_NUMBER_FORM check (phoneNo not like '%[^0-9]%'));

create table FanClub(
	clubId			smallint primary key,
	clubName		varchar2(50)not null,
	description		varchar2(150),
	dateEstablished	date not null);

create table Employee(
	employeeId		smallint primary key,
	employeeName	varchar2(30) not null,
	position		varchar2(20) not null);

create table Event(
	eventId			smallint primary key,
	eventName		varchar2(50) not null,
	eventDate		date,
	eventTime		char(4),
	venue			varchar2(50),
	memberFee		numeric(7,2) default 0,
	nonmemberFee	numeric(7,2) default 0,
	eventQuota		smallint,
	isAvailable		char(1) default 'N',
	isMemberOnly	char(1) default 'N',
	employeeId		smallint references Employee(employeeId) on delete cascade,
	constraint	AVAILABLE_CHECK check (isAvailable='Y' or isAvailable='N'),
	constraint	MEM_ONLY_CHECK check (isMemberOnly='Y' or isMemberOnly='N'),
    constraint  FEE_CHECK1 check (memberFee>=0),
    constraint  FEE_CHECK2 check (nonmemberFee>=0),
    constraint  EVENT_QUOTA_CHECK check (eventQuota>=0)
    );

create table HoldsEvent(
	clubId			smallint references FanClub(clubId) on delete cascade,
	eventId			smallint references Event(eventId) on delete cascade,
	primary key(clubId,eventId)
	);

create table ClubMember(
	userName char(10) references RegisteredUser(userName) on delete cascade,
	birthdate date not null,
	occupation varchar2(25) not null,
	educationLevel char(13) not null,
	primary key (userName),
	constraint EDU_CHECK check (educationLevel='none'or educationLevel='primary'or educationLevel='secondary'or educationLevel='tertiary'or educationLevel='post tertiary')
);

create table HasMember(
	clubId			smallint references FanClub(clubId) on delete cascade,
	userName		char(10) references ClubMember(userName) on delete cascade,
	joinDate		date not null,
	howInformed		char(15),
	primary key (clubId, userName),
	constraint INFORM_CHECK check (howInformed='friend' or howInformed='print ad'or howInformed='social media'or howInformed='web ad'or howInformed='other')
);

create table JoinsEvent(
	eventId			smallint references Event(eventId) on delete cascade,
	userName		char(10) references RegisteredUser(userName) on delete cascade,
	paidFee			char(1) default 'N',
	attended		char(1) default null,
	primary key (eventId,userName),
	constraint PAID_CHECK check (paidFee='N'or paidFee='Y'),
	constraint ATTENDED_CHECK check (attended='N'or attended='Y'or attended = null)
);

create table Remark(
	subject			varchar2(50),
	text			varchar2(150),
	submissionDate	date not null,
	status			char(10) default null,
	actionTaken		varchar2(50),
	remarkType		char(5)not null,
	userName		char(10) references ClubMember(userName) on delete cascade,
	employeeId		smallint references Employee(employeeId) on delete set null,
	clubId			smallint references FanClub(clubId) on delete cascade,
	eventId			smallint references Event(eventId) on delete cascade,
	constraint TYPE_CHECK check (remarkType='club'or remarkType='event'),
	constraint IS_ABOUT_CHECK check (((remarkType='event')and(clubId IS NULL)and(eventId IS NOT NULL))or((clubId IS NOT NULL)and(eventId IS NULL)and(remarkType='club'))),
	constraint STATUS_CHECK check (status='read'or status='processing'or status='done')
);
/* Write the data to disk */

/* COMP 3311: Task 2 - Fan Club Management System: Schema Check */
/********** RegisteredUser relation **********/
insert into RegisteredUser values ('username01','First1','Last1','M','99999999','fl@nomail.com');
insert into RegisteredUser values ('username02','First2','Last2','F','99999999','fl@nomail.com');
insert into RegisteredUser values ('username03','First3','Last3','M','99999999','fl@nomail.com');
insert into RegisteredUser values ('username04','First4','Last4','F','99999999','fl@nomail.com');
insert into RegisteredUser values ('username04','First5','Last5','M','99999999','fl@nomail.com');
insert into RegisteredUser values ('checkphone#','First6','Last6','M','99999asd','fl@nomail.com');

/*********** ClubMember relation ***********/
insert into ClubMember values ('username01','20-MAR-87','occupation','none');
insert into ClubMember values ('username02','20-MAR-87','occupation','none');
insert into ClubMember values ('username04','20-OCT-87','occupation','none');

/********** FanClub relation  **********/
insert into FanClub values (99,'FunClub1','Welcome','20-OCT-87');
insert into FanClub values (98,'FunClub2','Welcome','20-OCT-87');
insert into FanClub values (97,'FunClub3','Welcome','20-OCT-87');
insert into FanClub values (96,'FunClub4','Welcome','20-OCT-87');
insert into FanClub values (95,'FunClub5','Welcome','20-OCT-87');

/********** Employee relation **********/
insert into Employee values (99,'employee','position');

/********** Event relation **********/
insert into Event values (99,'Event name99','01-AUG-18','1900','Venue',20,0,15,'Y','Y',99);
insert into Event values (98,'Event name98','01-AUG-18','1900','Venue',20,0,15,'Y','Y',99);
insert into Event values (97,'Event name97','01-AUG-18','1900','Venue',20,0,15,'Y','Y',99);
insert into Event values (96,'Event name96','01-AUG-18','1900','Venue',20,0,15,'Y','Y',99);

/********** HasMember relation **********/
insert into HasMember values (99,'username01','10-OCT-07','friend');
insert into HasMember values (98,'username01','10-OCT-07','friend');
insert into HasMember values (97,'username01','10-OCT-07','friend');
insert into HasMember values (96,'username01','10-OCT-07','friend');
insert into HasMember values (95,'username01','10-OCT-07','friend');

insert into HasMember values (98,'username02','10-OCT-07','friend');
insert into HasMember values (97,'username02','10-OCT-07','friend');
insert into HasMember values (97,'username04','10-OCT-07','friend');

/********** HoldsEvent relation  **********/
insert into HoldsEvent values (99,99);
insert into HoldsEvent values (98,98);
insert into HoldsEvent values (99,98);
insert into HoldsEvent values (97,97);
insert into HoldsEvent values (95,96);

/********** JoinsEvent relation **********/
insert into JoinsEvent values (99,'username01','N','N');
insert into JoinsEvent values (99,'username04','N','N');
insert into JoinsEvent values (99,'username02','N','N');
insert into JoinsEvent values (98,'username02','N','N');
insert into JoinsEvent values (98,'username01','N','N');
insert into JoinsEvent values (97,'username02','N','N');

/********** Remark relation **********/
insert into Remark values ('Subject','Remark','10-DEC-17','done','Action taken.','club','username01',99,99,null);

/*1.Find the user name, first name and last name of the registered users who both are not club members and
have not joined any event.*/
select userName,firstName,lastName 
from RegisteredUser 
where userName not in (select userName from ClubMember) 
and userName not in (select userName from JoinsEvent);
/*2.For those fan clubs that have held joint events, find the names of the fan club, the event id and the event
name. Order the result by event id.*/
select clubName,H1.eventId,eventName
from FanClub,HoldsEvent H1,HoldsEvent H2,Event
where H1.eventId=H2.eventId
and H1.clubId<>H2.clubId
and H1.eventId=event.eventId
and FanClub.clubId=H1.clubId
group by clubName,H1.eventId,eventName
order by H1.eventId;
/*order by HoldsEvent.eventId;
/*3.Find the first name, last name, gender and birthdate of the registered users who have joined all the fan
clubs.*/
select firstName,lastName,gender,birthdate
from RegisteredUser,ClubMember C
where RegisteredUser.userName=C.userName 
and not exists (select * 
				from FanClub 
				where clubId not in (select clubId from HasMember where C.userName=HasMember.userName));
/*4.Find the name of the fan clubs and the number of members for those fan clubs that have the most and the 
least number of members*/
select clubName,count(userName)
from FanClub left outer join HasMember on hasmember.clubid = FanClub.CLUBID
group by FanClub.CLUBID,CLUBNAME
having (count(userName)>=all(  select count(userName)
                        from FanClub left outer join HasMember on hasmember.clubid = FanClub.CLUBID
                        group by FanClub.CLUBID,FanClub.CLUBNAME))
     or (count(userName)<=all(  select count(userName)
                        from FanClub left outer join HasMember on hasmember.clubid = FanClub.CLUBID
                        group by FanClub.CLUBID,FanClub.CLUBNAME));
/*5.*/
select eventName, clubName 
from FanClub F,HoldsEvent H,Event E
where F.clubId=H.clubId
and H.eventId=E.eventId
and not exists (select * from HasMember
                where F.CLUBID=HASMEMBER.CLUBID
                and hasmember.userName not in (select JOINSEVENT.USERNAME 
                                                from joinsevent 
                                                where JOINSEVENT.eventId=H.eventId));
commit;