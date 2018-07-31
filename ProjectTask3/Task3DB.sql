/* COMP 3311: Task 3 – Fan Club Management System */

/* Schemas */

set termout off;

drop table Remark;
drop table JoinsEvent;
drop table HoldsEvent;
drop table HasMember;
drop table Event;
drop table ClubMember;
drop table RegisteredUser;
drop table FanClub;
drop table Employee;

create table Employee(
	employeeId      smallint primary key,
	employeeName    varchar2(30) not null,
	position        varchar2(20) not null,
    userName		char(10));

create table FanClub(
	clubId          smallint primary key,
	clubName		varchar2(50) not null,
    description     varchar2(150) not null,
	dateEstablished	date not null);

create table RegisteredUser(
	userName		char(10) primary key,
	firstName	    varchar2(15) not null,
    lastName	    varchar2(20) not null,
	gender			char(1) not null,
	phoneNo			char(8) not null,
    userEmail		varchar2(30) not null unique,
    constraint CHK_RegisteredUser_gender check(gender in ('M', 'F')),
    constraint CHK_RegisteredUser_phoneNo check(regexp_like(phoneNo, '[[:digit:]]{8}')));

create table ClubMember(
	userName 		char(10) primary key references RegisteredUser(userName) on delete cascade,
	birthDate		date not null,
	occupation		varchar2(25) not null,
	educationLevel	char(13) not null,
    constraint CHK_ClubMember_educationLevel check(educationLevel in ('none', 'primary', 'secondary', 'tertiary', 'post tertiary')));

create table Event(
	eventId			smallint primary key,
	eventName		varchar2(50) not null,
	eventDate		date not null,
    eventTime       char(4) not null,
	venue			varchar2(50) not null,
	memberFee		numeric(7,2) default 0 not null,
	nonmemberFee	numeric(7,2) default 0 not null,
    eventQuota      smallint not null,
    isAvailable     char(1) default 'N' not null,
	isMemberOnly	char(1) default 'N' not null,
	employeeId		smallint not null references Employee(employeeId) on delete cascade,
    constraint CHK_Event_memberFee check(memberFee >= 0),
    constraint CHK_Event_nonmemberFee check (nonmemberFee >= 0),
    constraint CHK_Event_eventQuota check (eventQuota >= 0),
    constraint CHK_Event_isAvailable check(isAvailable in ('Y', 'N')),
    constraint CHK_Event_isMemberOnly check(isMemberOnly in ('Y', 'N')));

create table HasMember(
	clubId			smallint references FanClub(clubId) on delete cascade,
	userName		char(10) references RegisteredUser(userName) on delete cascade,
	joinDate		date not null,
	howInformed	    char(15) not null, 
    constraint CHK_HasMember_howInformed check(howInformed in ('friend', 'print ad', 'social media', 'web ad', 'other')),
	primary key(clubId, userName));

create table HoldsEvent(
	clubId          smallint references FanClub(clubId) on delete cascade,
	eventId         smallint references Event(eventId) on delete cascade,
	primary key(clubId, eventId));

create table JoinsEvent(
	eventId         smallint references Event(eventId) on delete cascade,
	userName        char(10) references RegisteredUser(userName) on delete cascade,
	paidFee         char(1) default 'N' not null,
	attended        char(1),
    constraint CHK_JoinsEvent_paidFee check(paidFee in ('Y', 'N')),
    constraint CHK_JoinsEvent_attended check(attended in ('Y', 'N')),
	primary key(eventId, userName));
	
create table Remark(
    remarkId        smallint primary key,
	subject			varchar2(50) not null,
	text			varchar2(150) not null,
	submissionDate	date not null,
	status			char(10),
	actionTaken		varchar2(50),
	remarkType		char(5) not null,
	userName		char(10) not null references ClubMember(userName) on delete cascade,
	employeeId      smallint references Employee(employeeId) on delete set null,
	clubId          smallint references FanClub(clubId) on delete cascade,
	eventId         smallint references Event(eventId) on delete cascade,
    constraint CHK_Remark_status check(status in ('read', 'processing', 'done')),
    constraint CHK_Remark_remarkType check(remarkType in ('club', 'event')),
    constraint CHK_Remark_Xor check ((clubId is null and eventId is not null) or (clubId is not null and eventId is null)));

/* Sample Database */

/********** Employee table data - 3 tuples **********/
insert into Employee values (1,'Michelle Cafa','Manager','empcafa');
insert into Employee values (2,'Eric Chen','Event Coordinator','empchen');
insert into Employee values (3,'Judy Wang','Fan Club Relations','empwang');

/********** FanClub table data - 10 tuples **********/
insert into FanClub values (1,'The Beyhive','The Beyhive provides Beyonce fans access to news, special experiences, exclusive merchandise and more.','10-OCT-03');
insert into FanClub values (2,'Pottermore','Pottermore provides a forum for discussing everything related to the Harry Potter books and movies.','01-NOV-14');
insert into FanClub values (3,'BigBang Fan Club','Share and discover content and connect with other fans of the K-pop group BigBang.','15-MAY-14');
insert into FanClub values (4,'STARFLEET','STARFLEET offers members a wealth of resources related to the Star Trek universe.','05-DEC-85');
insert into FanClub values (5,'Superman Fan Club','A club for people who are fans of the Man of Steel, the first and best comic book superhero.','25-JUL-95');
insert into FanClub values (6,'Dan Brown Fan Club','Share and discover content and connect with other fans of Dan Brown.','05-DEC-85');
insert into FanClub values (7,'The Swifters','Sign up and join us for exclusive access to Taylor Swift photos, videos, news and updates.','13-SEP-07');
insert into FanClub values (8,'Drake Fan Club','Sign up to get access to the latest Drake news, music, exclusive photos, videos as well as fantastic products.','05-DEC-10');
insert into FanClub values (9,'Jay-Z Fan Club','Share, discover content and connect with other fans of Jay-Z. Find Jay-Z videos, photos, wallpapers, forums, polls, news and more.','12-AUG-98');
insert into FanClub values (10,'MCU Fan Club','The best place to connect with other fans and get news about comics'' greatest super-heroes: Iron Man, Thor, Captain America, the X-Men, and more.','01-APR-15');

/********** RegisteredUser table data - 25 tuples **********/
insert into RegisteredUser values ('lesterlo','Lester','Lo','M','93456789','llo@nomail.com');
insert into RegisteredUser values ('cindychan','Cindy','Chan','F','98126629','cchan@nomail.com');
insert into RegisteredUser values ('fredfan','Fred','Fan','M','93788769','ffan@nomail.com');
insert into RegisteredUser values ('henryho','Henry','Ho','M','94678835','hho@nomail.com');
insert into RegisteredUser values ('peterpoon','Peter','Poon','M','92234876','ppoon@nomail.com');
insert into RegisteredUser values ('terrytam','Terry','Tam','M','69872395','ttam@nomail.com');
insert into RegisteredUser values ('tracytse','Tracy','Tse','F','62340751','ttse@nomail.com');
insert into RegisteredUser values ('wendywong','Wendy','Wong','F','98456781','wwong@nomail.com');
insert into RegisteredUser values ('yvonneyu','Yvonne','Yu','F','61276529','yyu@nomail.com');
insert into RegisteredUser values ('frankfung','Frank','Fung','M','96571245','ffung@nomail.com');
insert into RegisteredUser values ('larrylai','Larry','Lai','M','69871062','llai@nomail.com');
insert into RegisteredUser values ('susansze','Susan','Sze','F','90126523','ssze@nomail.com');
insert into RegisteredUser values ('walterwu','Walter','Wu','M','61904576','wwu@nomail.com');
insert into RegisteredUser values ('daisyyeung','Daisy','Yeung','F','98230110','dyeung@nomail.com');
insert into RegisteredUser values ('timothytu','Timothy','Tu','M','66450912','ttu@nomail.com');
insert into RegisteredUser values ('victoriayu','Victoria','Yu','F','93467812','vyu@nomail.com');
insert into RegisteredUser values ('rezanlim','Rezan','Lim','M','68201835','rlim@nomail.com');
insert into RegisteredUser values ('jennyjones','Jenny','Jones','F','99205718','jjones@nomail.com');
insert into RegisteredUser values ('brianmak','Brian','Mak','M','94467812','bmak@nomail.com');
insert into RegisteredUser values ('sharonsu','Sharon','Su','F','95567185','ssu@nomail.com');
insert into RegisteredUser values ('tiffanytan','Tiffany','Tan','F','64458901','ttan@nomail.com');
insert into RegisteredUser values ('carolchen','Carol','Chen','F','66891204','cchen@nomail.com');
insert into RegisteredUser values ('xavierxie','Xavier','Xie','M','92671073','xxie@nomail.com');
insert into RegisteredUser values ('shirleysit','Shirley','Sit','F','63578892','ssit@nomail.com');
insert into RegisteredUser values ('ireneip','Irene','Ip','F','68340820','iip@nomail.com');

/********** Event table data - 19 tuples **********/
insert into Event values (1,'Beyonce Photo Session','21-DEC-17','1930','Grand Hyatt Ballroom',25,50,15,'N','N',2);
insert into Event values (2,'Beyonce Pre-concert Autograph Session','22-SEP-18','1800','Asia World Expo Room 12',0,0,15,'Y','Y',2);
insert into Event values (3,'Harry Potter Movie Night','20-AUG-18','1930','The Grand SC Starsuite',250,280,10,'Y','N',3);
insert into Event values (4,'J.K. Rowling Harry Potter Reading','21-JUN-17','1930','Conrad Hotel Meeting Room 1',20,0,20,'N','Y',3);
insert into Event values (5,'Harry Potter: A History of Magic','20-OCT-18','1400','Hong Kong History Museum',50,60,12,'Y','N',3);
insert into Event values (6,'BigBang Autograph Session','10-FEB-17','1430','HKCEC Exhibit Room A',10,0,25,'N','Y',3);
insert into Event values (7,'STARFLEET Fan Club Annual Meeting','27-JAN-18','1900','HKUST - Room 5530',0,0,18,'N','Y',2);
insert into Event values (8,'Star Trek Movie Marathon','25-AUG-18','1300','The Grand SC Starsuite',225,250,15,'Y','N',2);
insert into Event values (9,'STARFLEET Annual Dress-up Night','01-SEP-18','2000','HKUST - Tsang Shiu Tim Art Hall',50,100,30,'Y','N',3);
insert into Event values (10,'Superman Movie Night','10-FEB-18','1800','The Grand SC Starsuite',260,280,15,'N','N',3);
insert into Event values (11,'Hong Kong Wants Taylor Swift! Fan Project','16-AUG-18','1400','HKCEC Exhibit Room B',0,0,25,'Y','N',3);
insert into Event values (12,'Swifters New Year''s Eve Party','31-DEC-18','1900','Grand Hyatt Hotel ballroom',1000,1500,60,'Y','N',3);
insert into Event values (13,'Drake Pre-concert Party','17-NOV-18','1700','SkyCity Marriott Hotel - Meeting Room B',150,0,10,'Y','Y',2);
insert into Event values (14,'Jay-Z Photo and Autograph Session','30-NOV-18','1300','Grand Hyatt Meeting Room C',0,0,20,'Y','Y',3);
insert into Event values (15,'Jay-Z Fan Club Party Night','16-JUN-18','2030','Conrad Hotel Ballroom',100,150,60,'N','N',3);
insert into Event values (16,'MCU Movie Night','24-MAR-18','1930','The Grand SC Starsuite',250,300,15,'N','N',2);
insert into Event values (17,'STARFLEET and MCU Movie Night','01-JAN-18','1900','The Grand SC Starsuite',250,300,13,'N','N',2);
insert into Event values (18,'OTR II Pre-concert Party','01-DEC-18','1730','SkyCity Marriott Hotel - Meeting Room A',50,75,25,'Y','N',2);
insert into Event values (19,'Superman and MCU Movie Night','01-SEP-18','1900','The Grand SC Starsuite',240,0,10,'Y','Y',3);

/*********** ClubMember table data - 16 tuples ***********/
insert into ClubMember values ('lesterlo','20-MAR-87','teacher','tertiary');
insert into ClubMember values ('fredfan','15-AUG-80','construction manager','secondary');
insert into ClubMember values ('henryho','17-MAR-55','retired','secondary');
insert into ClubMember values ('peterpoon','05-APR-50','retired','tertiary');
insert into ClubMember values ('tracytse','07-MAY-90','accountant','tertiary');
insert into ClubMember values ('wendywong','09-FEB-91','house wife','primary');
insert into ClubMember values ('larrylai','11-OCT-70','chief financial officer','tertiary');
insert into ClubMember values ('susansze','25-JUN-00','student','secondary');
insert into ClubMember values ('victoriayu','19-JUN-04','student','secondary');
insert into ClubMember values ('jennyjones','24-AUG-89','receptionist','secondary');
insert into ClubMember values ('brianmak','18-AUG-92','sales rep','secondary');
insert into ClubMember values ('sharonsu','23-APR-88','executive assistant','tertiary');
insert into ClubMember values ('tiffanytan','30-JAN-86','financial analyst','secondary');
insert into ClubMember values ('carolchen','18-DEC-05','student','secondary');
insert into ClubMember values ('xavierxie','31-JAN-66','sales manager','secondary');
insert into ClubMember values ('ireneip','25-OCT-82','housewife','secondary');

/********** HasMember table data - 77 tuples **********/
insert into HasMember values (1,'lesterlo','10-OCT-07','friend');
insert into HasMember values (1,'fredfan','17-MAY-12','social media');
insert into HasMember values (1,'henryho','07-OCT-11','other');
insert into HasMember values (1,'peterpoon','10-AUG-12','friend');
insert into HasMember values (1,'tracytse','06-JUN-17','social media');
insert into HasMember values (1,'susansze','19-JUL-15','web ad');
insert into HasMember values (1,'victoriayu','21-SEP-17','web ad');
insert into HasMember values (1,'brianmak','14-FEB-17','web ad');
insert into HasMember values (1,'carolchen','22-MAR-07','web ad');
insert into HasMember values (1,'xavierxie','31-MAR-08','print ad');
insert into HasMember values (1,'ireneip','15-JUL-17','social media');
insert into HasMember values (2,'peterpoon','10-DEC-17','friend');
insert into HasMember values (2,'tracytse','02-JUL-16','social media');
insert into HasMember values (2,'wendywong','17-AUG-15','social media');
insert into HasMember values (2,'susansze','19-JUL-15','web ad');
insert into HasMember values (2,'victoriayu','08-MAR-18','friend');
insert into HasMember values (2,'jennyjones','07-Jan-15','social media');
insert into HasMember values (2,'sharonsu','23-FEB-15','friend');
insert into HasMember values (2,'carolchen','29-NOV-15','other');
insert into HasMember values (2,'ireneip','16-MAY-17','print ad');
insert into HasMember values (3,'lesterlo','11-JUL-14','social media');
insert into HasMember values (3,'fredfan','11-FEB-16','web ad');
insert into HasMember values (3,'henryho','04-SEP-14','other');
insert into HasMember values (3,'peterpoon','13-APR-17','friend');
insert into HasMember values (3,'wendywong','10-DEC-14','web ad');
insert into HasMember values (3,'susansze','21-SEP-15','social media');
insert into HasMember values (3,'brianmak','24-JAN-15','social media');
insert into HasMember values (3,'xavierxie','07-JAN-18','friend');
insert into HasMember values (3,'sharonsu','25-DEC-16','social media');
insert into HasMember values (3,'ireneip','07-NOV-14','social media');
insert into HasMember values (4,'lesterlo','12-SEP-03','friend');
insert into HasMember values (4,'peterpoon','08-JAN-12','friend');
insert into HasMember values (4,'larrylai','14-JUN-06','print ad');
insert into HasMember values (4,'susansze','11-JAN-10','web ad');
insert into HasMember values (4,'carolchen','18-SEP-16','social media');
insert into HasMember values (4,'xavierxie','08-MAY-88','print ad');
insert into HasMember values (4,'ireneip','25-JUL-00','friend');
insert into HasMember values (5,'peterpoon','21-OCT-07','web ad');
insert into HasMember values (5,'susansze','07-NOV-12','friend');
insert into HasMember values (6,'lesterlo','31-Jul-00','friend');
insert into HasMember values (6,'peterpoon','09-DEC-10','friend');
insert into HasMember values (6,'larrylai','15-MAR-10','friend');
insert into HasMember values (6,'susansze','31-MAR-15','web ad');
insert into HasMember values (6,'brianmak','26-OCT-05','other');
insert into HasMember values (6,'xavierxie','28-MAR-98','friend');
insert into HasMember values (6,'ireneip','23-MAY-17','social media');
insert into HasMember values (7,'lesterlo','22-MAY-14','other');
insert into HasMember values (7,'fredfan','16-JUN-08','friend');
insert into HasMember values (7,'peterpoon','19-NOV-12','friend');
insert into HasMember values (7,'tracytse','27-AUG-10','social media');
insert into HasMember values (7,'susansze','12-FEB-14','print ad');
insert into HasMember values (7,'xavierxie','18-JUL-08','web ad');
insert into HasMember values (8,'lesterlo','14-FEB-12','social media');
insert into HasMember values (8,'fredfan','17-MAY-12','social media');
insert into HasMember values (8,'henryho','20-MAR-11','other');
insert into HasMember values (8,'peterpoon','21-MAY-12','print ad');
insert into HasMember values (8,'tracytse','28-SEP-16','friend');
insert into HasMember values (8,'wendywong','03-DEC-15','web ad');
insert into HasMember values (8,'susansze','22-JUL-11','friend');
insert into HasMember values (8,'tiffanytan','03-JAN-15','friend');
insert into HasMember values (8,'xavierxie','17-MAY-12','web ad');
insert into HasMember values (8,'ireneip','12-OCT-15','friend');
insert into HasMember values (9,'lesterlo','18-NOV-15','friend');
insert into HasMember values (9,'fredfan','18-JUL-12','social media');
insert into HasMember values (9,'peterpoon','28-FEB-12','friend');
insert into HasMember values (9,'susansze','17-MAY-16','web ad');
insert into HasMember values (9,'carolchen','29-FEB-04','other');
insert into HasMember values (9,'xavierxie','18-AUG-08','social media');
insert into HasMember values (9,'ireneip','03-JUL-11','social media');
insert into HasMember values (10,'lesterlo','28-MAR-17','web ad');
insert into HasMember values (10,'fredfan','02-OCT-16','other');
insert into HasMember values (10,'peterpoon','12-JAN-14','friend');
insert into HasMember values (10,'tracytse','30-JUN-17','friend');
insert into HasMember values (10,'susansze','13-APR-14','social media');
insert into HasMember values (10,'carolchen','19-AUG-15','social media');
insert into HasMember values (10,'xavierxie','08-JUN-18','print ad');
insert into HasMember values (10,'ireneip','17-APR-18','friend');

/********** Remark table data - 10 tuples **********/
insert into Remark values (1,'Venue too small','The venue for the meeting was not large enough to accommodate all those attending.','10-FEB-18','read',null,'event','peterpoon',2,null,7);
insert into Remark values (2,'Not enough quota','Can more quota be added for such events in future?','10-DEC-17','processing','Noted for future events.','event','tracytse',2,null,1);
insert into Remark values (3,'Great movie night','The movie night was well organized.','12-FEB-18','done',null,'event','susansze',2,null,10);
insert into Remark values (4,'Well run event!','Thank you to the organizers for a well run event.','22-FEB-18',null,null,'event','carolchen',null,null,4);
insert into Remark values (5,'Chaotic meeting!','The meeting was not well organized.','02-FEB-18',null,null,'event','susansze',null,null,7);
insert into Remark values (6,'More movie nights','Can there be more movie nights?','20-JUN-18','read',null,'club','carolchen',3,10,null);
insert into Remark values (7,'No club events!','Can this club please have some events?','10-APR-18','processing','Organizing events.','club','lesterlo',3,6,null);
insert into Remark values (8,'More members needed','The club is in serious need of more members.','30-MAY-18','done','Organizing membership drive.','club','susansze',3,5,null);
insert into Remark values (9,'No events?','Why are we not having any events?','20-JUL-18',null,null,'club','peterpoon',null,6,null);
insert into Remark values (10,'Events needed!','This fan club needs to have some events or I will leave it!','10-JUL-18',null,null,'club','susansze',null,6,null);

/********** HoldsEvent table data - 22 tuples **********/
insert into HoldsEvent values (1,1);
insert into HoldsEvent values (1,2);
insert into HoldsEvent values (2,3);
insert into HoldsEvent values (2,4);
insert into HoldsEvent values (2,5);
insert into HoldsEvent values (3,6);
insert into HoldsEvent values (4,7);
insert into HoldsEvent values (4,8);
insert into HoldsEvent values (4,9);
insert into HoldsEvent values (5,10);
insert into HoldsEvent values (7,11);
insert into HoldsEvent values (7,12);
insert into HoldsEvent values (8,13);
insert into HoldsEvent values (9,14);
insert into HoldsEvent values (9,15);
insert into HoldsEvent values (10,16);
insert into HoldsEvent values (4,17);
insert into HoldsEvent values (10,17);
insert into HoldsEvent values (1,18);
insert into HoldsEvent values (9,18);
insert into HoldsEvent values (5,19);
insert into HoldsEvent values (10,19);

/********** JoinsEvent table data - 124 tuples **********/
insert into JoinsEvent values (1,'lesterlo','Y','Y');
insert into JoinsEvent values (1,'cindychan','Y','Y');
insert into JoinsEvent values (1,'fredfan','Y','Y');
insert into JoinsEvent values (1,'peterpoon','Y','Y');
insert into JoinsEvent values (1,'tracytse','Y','Y');
insert into JoinsEvent values (1,'wendywong','Y','N');
insert into JoinsEvent values (1,'yvonneyu','Y','Y');
insert into JoinsEvent values (1,'susansze','Y','Y');
insert into JoinsEvent values (1,'daisyyeung','Y','Y');
insert into JoinsEvent values (1,'timothytu','Y','Y');
insert into JoinsEvent values (1,'victoriayu','Y','Y');
insert into JoinsEvent values (1,'jennyjones','Y','Y');
insert into JoinsEvent values (1,'brianmak','Y','Y');
insert into JoinsEvent values (1,'sharonsu','Y','Y');
insert into JoinsEvent values (1,'ireneip','Y','Y');
insert into JoinsEvent values (2,'lesterlo','Y',null);
insert into JoinsEvent values (2,'fredfan','N',null);
insert into JoinsEvent values (2,'henryho','Y',null);
insert into JoinsEvent values (2,'peterpoon','Y',null);
insert into JoinsEvent values (2,'tracytse','N',null);
insert into JoinsEvent values (2,'susansze','Y',null);
insert into JoinsEvent values (2,'carolchen','N',null);
insert into JoinsEvent values (2,'xavierxie','Y',null);
insert into JoinsEvent values (2,'ireneip','Y',null);
insert into JoinsEvent values (3,'lesterlo','Y',null);
insert into JoinsEvent values (3,'terrytam','N',null);
insert into JoinsEvent values (3,'frankfung','Y',null);
insert into JoinsEvent values (3,'henryho','Y',null);
insert into JoinsEvent values (3,'timothytu','N',null);
insert into JoinsEvent values (3,'victoriayu','Y',null);
insert into JoinsEvent values (3,'tiffanytan','Y',null);
insert into JoinsEvent values (3,'shirleysit','N',null);
insert into JoinsEvent values (4,'tracytse','Y','Y');
insert into JoinsEvent values (4,'wendywong','Y','Y');
insert into JoinsEvent values (4,'susansze','Y','Y');
insert into JoinsEvent values (4,'victoriayu','Y','Y');
insert into JoinsEvent values (4,'jennyjones','Y','Y');
insert into JoinsEvent values (4,'sharonsu','Y','Y');
insert into JoinsEvent values (4,'carolchen','Y','Y');
insert into JoinsEvent values (4,'ireneip','Y','Y');
insert into JoinsEvent values (5,'lesterlo','N','Y');
insert into JoinsEvent values (5,'henryho','Y','Y');
insert into JoinsEvent values (5,'peterpoon','N','Y');
insert into JoinsEvent values (5,'tracytse','Y','Y');
insert into JoinsEvent values (5,'wendywong','Y','Y');
insert into JoinsEvent values (5,'susansze','Y','Y');
insert into JoinsEvent values (5,'victoriayu','Y','Y');
insert into JoinsEvent values (5,'jennyjones','Y','Y');
insert into JoinsEvent values (5,'sharonsu','Y','Y');
insert into JoinsEvent values (5,'carolchen','Y','Y');
insert into JoinsEvent values (5,'ireneip','Y','Y');
insert into JoinsEvent values (6,'lesterlo','Y','Y');
insert into JoinsEvent values (6,'henryho','Y','Y');
insert into JoinsEvent values (6,'wendywong','Y','Y');
insert into JoinsEvent values (6,'susansze','Y','Y');
insert into JoinsEvent values (6,'brianmak','Y','Y');
insert into JoinsEvent values (6,'sharonsu','Y','Y');
insert into JoinsEvent values (6,'xavierxie','Y','Y');
insert into JoinsEvent values (7,'lesterlo','Y','Y');
insert into JoinsEvent values (7,'peterpoon','Y','Y');
insert into JoinsEvent values (7,'susansze','Y','Y');
insert into JoinsEvent values (7,'carolchen','Y','N');
insert into JoinsEvent values (7,'xavierxie','Y','Y');
insert into JoinsEvent values (7,'ireneip','Y','Y');
insert into JoinsEvent values (8,'cindychan','Y',null);
insert into JoinsEvent values (8,'brianmak','Y',null);
insert into JoinsEvent values (9,'lesterlo','Y',null);
insert into JoinsEvent values (9,'terrytam','N',null);
insert into JoinsEvent values (9,'frankfung','Y',null);
insert into JoinsEvent values (9,'walterwu','Y',null);
insert into JoinsEvent values (9,'daisyyeung','Y',null);
insert into JoinsEvent values (9,'jennyjones','Y',null);
insert into JoinsEvent values (10,'lesterlo','Y','Y');
insert into JoinsEvent values (10,'cindychan','Y','Y');
insert into JoinsEvent values (10,'tracytse','Y','Y');
insert into JoinsEvent values (10,'yvonneyu','Y','Y');
insert into JoinsEvent values (10,'fredfan','Y','Y');
insert into JoinsEvent values (11,'lesterlo','Y',null);
insert into JoinsEvent values (11,'peterpoon','Y',null);
insert into JoinsEvent values (11,'frankfung','Y',null);
insert into JoinsEvent values (11,'jennyjones','Y',null);
insert into JoinsEvent values (11,'shirleysit','Y',null);
insert into JoinsEvent values (12,'lesterlo','Y',null);
insert into JoinsEvent values (12,'peterpoon','N',null);
insert into JoinsEvent values (12,'tracytse','Y',null);
insert into JoinsEvent values (12,'susansze','Y',null);
insert into JoinsEvent values (13,'lesterlo','Y',null);
insert into JoinsEvent values (15,'lesterlo','Y','Y');
insert into JoinsEvent values (15,'wendywong','Y','Y');
insert into JoinsEvent values (15,'daisyyeung','Y','Y');
insert into JoinsEvent values (15,'victoriayu','Y','Y');
insert into JoinsEvent values (16,'lesterlo','Y','Y');
insert into JoinsEvent values (16,'fredfan','Y','Y');
insert into JoinsEvent values (16,'carolchen','Y','Y');
insert into JoinsEvent values (17,'lesterlo','Y','Y');
insert into JoinsEvent values (17,'fredfan','Y','Y');
insert into JoinsEvent values (17,'henryho','Y','Y');
insert into JoinsEvent values (17,'tracytse','Y','Y');
insert into JoinsEvent values (17,'wendywong','Y','Y');
insert into JoinsEvent values (17,'yvonneyu','Y','Y');
insert into JoinsEvent values (17,'xavierxie','Y','Y');
insert into JoinsEvent values (17,'susansze','Y','Y');
insert into JoinsEvent values (17,'daisyyeung','Y','Y');
insert into JoinsEvent values (17,'victoriayu','Y','Y');
insert into JoinsEvent values (17,'sharonsu','Y','Y');
insert into JoinsEvent values (17,'carolchen','Y','Y');
insert into JoinsEvent values (17,'ireneip','Y','Y');
insert into JoinsEvent values (18,'lesterlo','Y',null);
insert into JoinsEvent values (18,'cindychan','N',null);
insert into JoinsEvent values (18,'fredfan','Y',null);
insert into JoinsEvent values (18,'henryho','Y',null);
insert into JoinsEvent values (18,'peterpoon','Y',null);
insert into JoinsEvent values (18,'terrytam','N',null);
insert into JoinsEvent values (18,'frankfung','Y',null);
insert into JoinsEvent values (18,'susansze','Y',null);
insert into JoinsEvent values (18,'brianmak','Y',null);
insert into JoinsEvent values (18,'sharonsu','N',null);
insert into JoinsEvent values (19,'fredfan','N',null);
insert into JoinsEvent values (19,'peterpoon','Y',null);
insert into JoinsEvent values (19,'tracytse','Y',null);
insert into JoinsEvent values (19,'susansze','N',null);
insert into JoinsEvent values (19,'carolchen','N',null);
insert into JoinsEvent values (19,'xavierxie','Y',null);
insert into JoinsEvent values (19,'ireneip','Y',null);

set termout on;

commit;