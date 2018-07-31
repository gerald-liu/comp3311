/* File:    Task2TableCreation.sql
 * Author:  Weiyang Liu
 */
 
/* Drop existing constraints */
select 'alter table' || u.table_name || 'drop constraint' || c.constraint_name
from user_tables u, user_constraints c 
where u.table_name = c.table_name; 

/* Drop existing tables */
drop table Remark;
drop table JoinsEvent;
drop table HasMember;
drop table ClubMember;
drop table HoldsEvent;
drop table Event;
drop table Employee;
drop table FanClub;
drop table RegisteredUser;

/* Create tables */
create table RegisteredUser (
    userName char(10) primary key,
    firstName varchar2(15) not null,
    lastName varchar2(20) not null,
    gender char(1),
    phoneNo char(8),
    userEmail varchar2(30) not null,
    constraint genderCheck check (gender in ('M', 'F')),
    constraint phoneNoCheck check (phoneNo not like '%[^0-9.]%')
);

create table ClubMember (
    userName char(10) primary key references RegisteredUser(userName) on delete cascade,
    birthdate date not null,
    occupation varchar2(25) not null,
    educationLevel char(13),
    constraint eduCheck check (educationLevel in ('none', 'primary', 'secondary', 'tertiary', 'post tertiary'))
);

create table Employee (
    employeeId smallint primary key,
    employeeName varchar2(30) not null,
    position varchar2(20) not null
);

create table Event (
    eventId smallint primary key,
    eventName varchar2(50) not null,
    eventDate date not null,
    eventTime char(4) not null,
    venue varchar2(50) not null,
    memberFee numeric(7,2) default 0 not null,
    nonmemberFee numeric(7,2) default 0 not null,
    eventQuota smallint not null,
    isAvailable char(1) default 'N' not null,
    isMemberOnly char(1) default 'N' not null,
    employeeId smallint not null,
    constraint fk_Event_employeeId foreign key (employeeId) references Employee(employeeId) on delete cascade,
    constraint memberFeeCheck check (memberFee >= 0),
    constraint nonmemberFeeCheck check (nonmemberFee >= 0),
    constraint eventQuotaCheck check (eventQuota >= 0),
    constraint isAvailableCheck check (isAvailable in ('Y', 'N')),
    constraint isMemberOnlyCheck check (isMemberOnly in ('Y', 'N'))
);

create table FanClub (
    clubId smallint primary key,
    clubName varchar2(50) not null,
    description varchar2(150),
    dateEstablished date not null
);

create table HoldsEvent (
    clubId smallint,
    eventId smallint,
    primary key (clubId, eventId),
    constraint fk_HoldsEvent_clubId foreign key (clubId) references FanClub(clubId) on delete cascade,
    constraint fk_HoldsEvent_eventId foreign key (eventId) references Event(eventId) on delete cascade
);

create table HasMember (
    clubId smallint,
    userName char(10),
    joinDate date not null,
    howInformed char(15) not null,
    primary key (clubId, userName),
    constraint fk_HasMember_clubId foreign key (clubId) references FanClub(clubId) on delete cascade,
    constraint fk_HasMember_userName foreign key (userName) references RegisteredUser(userName) on delete cascade,
    constraint howInformedCheck check (howInformed in ('friend', 'print ad', 'social media', 'web ad', 'other'))
);

create table JoinsEvent (
    eventId smallint,
    userName char(10),
    paidFee char(1) default 'N' not null,
    attended char(1) default null,
    primary key (eventId, userName),
    constraint fk_JoinsEvent_eventId foreign key (eventId) references Event(eventId) on delete cascade,
    constraint fk_JoinsEvent_userName foreign key (userName) references RegisteredUser(userName) on delete cascade,
    constraint paidFeeCheck check (paidFee in ('Y', 'N')),
    constraint attendedCheck check (attended in ('Y', 'N'))
);

create table Remark (
    subject varchar2(50) not null,
    text varchar2(150) not null,
    submissionDate date not null,
    status char(10) default null,
    actionTaken varchar2(50),
    remarkType char(5) not null,
    userName char(10) not null,
    employeeId smallint not null,
    clubId smallint not null,
    eventId smallint not null,
    constraint fk_Remark_userName foreign key (userName) references RegisteredUser(userName) on delete cascade,
    constraint fk_Remark_employeeId foreign key (employeeId) references Employee(employeeId) on delete cascade,
    constraint fk_Remark_clubId foreign key (clubId) references FanClub(clubId) on delete cascade,
    constraint fk_Remark_eventId foreign key (eventId) references Event(eventId) on delete cascade,
    constraint statusCheck check (status in ('read', 'processing', 'done')),
    constraint remarkTypeCheck check (remarkType in ('club', 'event'))
);

commit;