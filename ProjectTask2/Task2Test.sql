@Task2TableCreation

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

commit;

@Task2Queries