/* File:    Task2Queries.sql
 * Author:  Weiyang Liu
 */

/* Query 1 */
select userName, firstName, lastName
from RegisteredUser
where userName not in (select userName from ClubMember)
    and userName not in (select userName from JoinsEvent);

/* Query 2 */
select FanClub.clubName, HE1.eventId, eventName
from HoldsEvent HE1, HoldsEvent HE2, FanClub, Event
where HE1.eventId = HE2.eventId
    and HE1.clubId <> HE2.clubId
    and HE1.eventId = Event.eventId
    and HE1.clubId = FanClub.clubId
order by eventId;

/* Query 3 */
select firstName, lastName, gender, birthdate
from RegisteredUser, ClubMember
where RegisteredUser.userName = ClubMember.userName
    and RegisteredUser.userName in (
        select userName from HasMember group by userName
        having count(distinct clubId) = (select count(*) from FanClub)
    );

/* Query 4 */
with ClubMemberNum(clubId, numOfMembers) as (
    select clubId, count(distinct userName) from HasMember
    group by clubId
)
select clubName, numOfMembers
from ClubMemberNum, FanClub
where (numOfMembers = (select max(numOfMembers) from ClubMemberNum)
    or numOfMembers = (select min(numOfMembers) from ClubMemberNum))
    and FanClub.clubId = ClubMemberNum.clubId;

/* Query 5 */
with AllMembersJoinedEvent(clubId, eventId) as (
    select HoldsEvent.clubId, HoldsEvent.eventId
    from HoldsEvent, HasMember, JoinsEvent
    where HoldsEvent.clubId = HasMember.clubId
        and HasMember.userName = JoinsEvent.userName
        and HoldsEvent.eventId = JoinsEvent.eventId
    group by HoldsEvent.clubId, HoldsEvent.eventId
    having count(distinct JoinsEvent.userName) = (
        select count(distinct userName) from HasMember
        group by clubId
        having clubId = HoldsEvent.clubId
    )
)
select eventName, clubName
from AllMembersJoinedEvent, Event, FanClub
where Event.eventId = AllMembersJoinedEvent.eventId
    and FanClub.clubId = AllMembersJoinedEvent.clubId;
