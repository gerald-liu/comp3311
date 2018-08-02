using Oracle.DataAccess.Client;
using System.Data;

/// <summary>
/// This class implements the database access layer which provides the SQL
/// statements needed by the website to access and maintain the fan club database.
/// </summary>

public class FanClubDB
{
    OracleDBAccess myOracleDBAccess = new OracleDBAccess();
    private string sql;

    #region SQL Statements for Employees
    /********************************/
    /* SQL statements for employees */
    /********************************/

    public DataTable GetEmployeeId(string userName)
    {
        //**********************************************************
        // TODO 01: Construct the SQL statement to retrieve the id *
        //          of an employee given the employee's user name. *
        //**********************************************************
        sql = "select employeeId from Employee where userName='" + userName + "'";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetEmployees()
    {
        //**************************************************************
        // TODO 02: Construct the SQL statement to retrieve the id and *
        //          name of ALL employees ordered by employee name.    *
        //**************************************************************
        sql = "select employeeId, employeeName from Employee order by employeeName";
        return myOracleDBAccess.GetData(sql);
    }

    #endregion SQL Statements for Employees

    #region SQL Statements for Registered Users
    /***************************************************************************/
    /* SQL statements for managing registered user and club member information */
    /***************************************************************************/

    public DataTable GetRegisteredUser(string userName)
    {
        //**********************************************************************
        // TODO 03: Construct the SQL statement to retrieve ALL the attributes *
        //          of a registered user identified by a user name.            *
        //**********************************************************************
        sql = "select * from RegisteredUser where userName='" + userName + "'";
        return myOracleDBAccess.GetData(sql);
    }

    public bool UpdateRegisteredUser(string userName, string firstName, string lastName,
        string gender, string phoneNo, string email)
    {
        //*************************************************************************************
        // TODO 04: Construct the SQL statement to update ALL the registered user attributes. *
        //*************************************************************************************
        sql = "update RegisteredUser" +
              " set firstName='" + firstName + "', lastName='" + lastName + "', gender='" + gender +
              "', phoneNo='" + phoneNo + "', userEmail='" + email +
              "' where userName='" + userName + "'";
        return UpdateData(sql);
    }

    #endregion SQL Statements for Registered Users

    #region SQL Statements for Club Members
    public DataTable GetClubMember(string userName)
    {
        //******************************************************************
        // TODO 05: Construct the SQL statement to retrieve ALL the        *
        //          attributes of a club member identified by a user name. *
        //******************************************************************
        sql = "select * from ClubMember where userName='" + userName + "'";
        return myOracleDBAccess.GetData(sql);
    }

    public bool InsertClubMember(string userName, string birthdate, string occupation, string educationLevel)
    {
        //************************************************************************************
        // TODO 06: Construct the SQL statement to insert the information for a club member. *
        //************************************************************************************
        sql = "insert into ClubMember values ('" + userName + "', '" + birthdate + "', '" + occupation + "', '" + educationLevel + "')";
        return UpdateData(sql);
    }

    public bool UpdateClubMember(string userName, string birthdate, string occupation, string educationLevel)
    {
        //********************************************************************
        // TODO 07: Construct the SQL statement to update ALL the attributes *
        //          of a club member identified by a user name.              *
        //************************************W********************************
        sql = "update ClubMember" +
              " set birthDate = '"+birthdate+"', occupation = '"+occupation+"', educationLevel = '"+educationLevel+
              "'where userName = '"+userName+"'";
        return UpdateData(sql);
    }

    #endregion SQL Statements for Club Members

    #region SQL Statements for Events
    /******************************/
    /* SQL statements for events. */
    /******************************/

    public DataTable GetCurrentEvents()
    {
        //***************************************************************************************************
        // Construct the SQL statement to retrieve the event name, date, time, venue, member fee, nonmember *
        // fee, quota and whether the event is only for members of All the events that are available        *
        // and whose event date is greater than or equal to today. Order the result by event name.          *
        //***************************************************************************************************
        sql = "select eventName, eventDate, eventTime, venue, memberFee, nonmemberfee, eventQuota, isMemberOnly " + 
            " from Event where isAvailable='Y' and eventDate>=sysdate order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetEventInformation(string eventId)
    {
        //**************************************************************
        // TODO 08: Construct the SQL statement to retrieve ALL the    *
        //          attributes for an event identified by an event id. *
        //**************************************************************
        sql = "select * from Event where eventId="+eventId;
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetEventsIdAndName(string clubId)
    {
        //************************************************************************************************
        // TODO 09: Construct the SQL statement to retrieve the id and name of a fan club's events given *
        //          the club id of the fan club holding the event. Order the result by event name.       *
        //************************************************************************************************
        sql = "select Event.eventId, eventName from Event, HoldsEvent"+
              " where Event.eventId = HoldsEvent.eventId and HoldsEvent.clubId = "+clubId+
              " order by Event.eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetJoinedEventsIdAndName(string userName)
    {
        //***************************************************************************************************
        // TODO 10: Construct the SQL statement to retrieve the id and name of ALL the events that a        *
        //          registered user, identified by a user name, has joined. Order the result by event name. *
        //***************************************************************************************************
        sql = "select Event.eventId, eventName from Event, JoinsEvent"+
              " where Event.eventId = JoinsEvent.eventId and userName = '"+userName+
              "'order by Event.eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetCurrentEventsJoined(string userName)
    {
        //*************************************************************************************
        // TODO 11: Construct the SQL statement to retrieve the id, name, date, time, venue,  *
        //          member fee and nonmember fee of the current events a registered user,     *
        //          identified by a user name, HAS JOINED. Order the result by event name. A  *
        //          current event is one whose date is greater than or equal to today's date. *
        //*************************************************************************************
        sql = "select Event.eventId, eventName, eventDate, eventTime, venue, memberFee, nonmemberfee"+
              " from Event, JoinsEvent"+
              " where eventDate>= sysdate and Event.eventId = JoinsEvent.eventId and userName = '"+userName+
              "'order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetPastEventsJoined(string userName)
    {
        //************************************************************************************
        // TODO 12: Construct the SQL statement to retrieve the id, name, date, time, venue, *
        //          member fee and nonmember fee of the past events a registered user,       *
        //          identified by a user name, HAS JOINED. Order the result by event name. A * 
        //          past event is one whose date is less than today's date.                  *
        //************************************************************************************
        sql = "select Event.eventId, eventName, eventDate, eventTime, venue, memberFee, nonmemberfee" +
              " from Event, JoinsEvent" +
              " where eventDate< sysdate and Event.eventId = JoinsEvent.eventId and userName = '" + userName +
              "'order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetEventsNotJoined(string userName)
    {
        //*************************************************************************************************
        // TODO 13: Construct the SQL statement to retrieve the id, name, date, time, venue, member fee,  *
        //          nonmember fee and REMAINING QUOTA of the events a registered user, identified by a    *
        //          user name, HAS NOT JOINED. Order the result by event name. Retrieve only those events *
        //          that are still available to join and that the registered user is allowed to join      *
        //          (e.g., if the event is member only and the registered user is not a member of the fan *
        //          club holding the event, then the event should not be in the query result).            *
        //*************************************************************************************************
        sql = "select Event.eventId, eventName, eventDate, eventTime, venue,"+
                    "memberFee, nonmemberfee, eventQuota - count(*) as remainingQuota"+
                " from Event left outer join JoinsEvent on Event.eventId = JoinsEvent.eventId"+
                " where isAvailable = 'Y' and "+
                    "Event.eventId not in (select eventId from JoinsEvent where userName = '"+userName+"') and "+
                    "not(isMemberOnly = 'Y' and "+
                        "Event.eventId not in (select eventId from HoldsEvent, HasMember"+
                            " where HoldsEvent.clubId = HasMember.clubId and HasMember.userName = '"+userName+"'))"+
                " group by Event.eventId, eventName, eventDate, eventTime, venue,"+
                    "memberFee, nonmemberfee, eventQuota"+
                " order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetJoinsEvent(string eventId)
    {
        //*********************************************************************************
        // TODO 14: Construct the SQL statement to retrieve the event id, user name, paid *
        //          fee and attended information, IN THIS ORDER, for everyone who joined  *
        //          an event identified by its event id. Order the result by user name.   *
        //*********************************************************************************
        sql = "select eventId, userName, paidFee, attended from JoinsEvent"+
                " where JoinsEvent.eventId = "+eventId+" order by userName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetModifiableEventsIdAndName(string clubId)
    {
        //*********************************************************************************
        // TODO 15: Construct the SQL statement to retrieve the id and name of the        *
        //          modifiable events of a fan club, identified by its club id,           *
        //          that holds the event. Order the result by event name. An event is     *
        //          modifiable if the event date is greater or equal to the current date. *
        //*********************************************************************************
        sql = "select Event.eventId, eventName from Event, HoldsEvent"+
                " where isAvailable = 'Y' and eventDate>= sysdate and "+
                    "Event.eventId = HoldsEvent.eventId and HoldsEvent.clubId ="+clubId+
                " order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public bool JoinEvent(string eventId, string userName, string paidFee, string attended)
    {
        //**************************************************************************
        // TODO 16: Construct the SQL statement to insert a registered user for an *
        //          event (i.e., to allow a registered user to join an event).     *               
        //**************************************************************************
        sql = "insert into JoinsEvent values ("+eventId+", '"+userName+"', '"+paidFee+"', '"+attended+"')";
        return UpdateData(sql);
    }

    public bool CreateEvent(DataTable clubIds, string eventId, string eventName, string eventDate, string eventTime, string venue,
        string memberFee, string nonmemberFee, string eventQuota, string isAvailable, string isMemberOnly, string employeeId)
    {
        //**************************************************************
        // TODO 17: Construct the SQL statement to insert a new event. *
        //**************************************************************
        sql = "insert into Event values ("+eventId+",'"+eventName+"','"+eventDate+"','"+eventTime+
                "','"+venue+"',"+memberFee+","+nonmemberFee+","+eventQuota+",'"+isAvailable+"','"+isMemberOnly+"',"+employeeId+")";
        OracleTransaction trans = myOracleDBAccess.BeginTransaction();
        if (trans == null) { return false; }
        if (myOracleDBAccess.SetData(sql, trans))
        {
            foreach (DataRow row in clubIds.Rows)
            {
                //*******************************************************************************************
                // TODO 18: Construct the SQL statement to relate the new event to a fan club holding the   *
                //          event. Since multiple fan clubs can hold an event, the ids of all the fan clubs *
                //          holding the event are contained in the DataTable clubIds. Each club id can be   *
                //          accessed within the foreach loop as follows: row["CLUBID"].ToString().Trim().   *
                //*******************************************************************************************
                sql = "insert into HoldsEvent values ("+ row["CLUBID"].ToString().Trim() +", "+eventId+")";
                if (!myOracleDBAccess.SetData(sql, trans))
                { myOracleDBAccess.DisposeTransaction(trans); return false; }
            }
        }
        else
        { return false; }
        myOracleDBAccess.CommitTransaction(trans);
        return true;
    }

    public bool UpdateEvent(string eventId, string eventName, string eventDate, string eventTime, string venue,
        string memberFee, string nonmemberFee, string eventQuota, string isAvailable, string isMemberOnly, string employeeId)
    {
        //**************************************************************
        // TODO 19: Construct the SQL statement to update All the      *
        //          attributes of an event identified by its event id. *
        //**************************************************************
        sql = "update Event"+
              " set eventName = '"+eventName+"', eventDate = '"+eventDate+"', eventTime = '"+eventTime+
                "', venue = '"+venue+"', memberFee = "+memberFee+", nonmemberFee = "+nonmemberFee+
                ", eventQuota = "+eventQuota+", isAvailable = '"+isAvailable+"', isMemberOnly = '"+isMemberOnly+"', employeeId = "+employeeId+
              " where eventId = "+eventId;
        return UpdateData(sql);
    }

    public bool UpdatePaidFeeAndAttendance(string eventId, string userName, string paidFee, string attended)
    {
        //******************************************************************************
        // TODO 20: Construct the SQL statement to update the paid fee and attended    *
        //          values of everyone who joined an event identified by its event id. *
        //******************************************************************************
        sql = "update JoinsEvent set paidFee='"+paidFee+"', attended='"+attended+
              "' where eventId="+eventId+" and userName='"+userName+"'";
        return UpdateData(sql);
    }

    public bool SetEventUnavailable(string eventId)
    {
        //*********************************************************************
        // TODO 21: Construct the SQL statement to make an event unavailable. *
        //*********************************************************************
        sql = "update Event set isAvailable='N' where eventId="+eventId;
        return UpdateData(sql);
    }

    #endregion SQL Statements for Events

    #region SQL Statements for Fan Clubs
    /********************************/
    /* SQL statements for fan clubs */
    /********************************/

    public DataTable GetFanClubs()
    {
        //***************************************************************
        // Construct the SQL statement to retrieve all the fan club     *
        // attribute values for all the fan clubs ordered by club name. *
        //***************************************************************
        sql = "select * from FanClub order by clubName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetFanClubsJoined(string userName)
    {
        //**********************************************************************
        // TODO 22: Construct the SQL statement to retrieve the id, name and   *
        //          description of all the fan clubs a club member, identified *
        //          by a user name, HAS JOINED. Order the result by club name. *
        //**********************************************************************
        sql = "select FanClub.clubId, clubName, description from FanClub, HasMember"+
                " where FanClub.clubId = HasMember.clubId and HasMember.userName = '"+userName+
                "' order by clubName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetFanClubsNotJoined(string userName)
    {
        //*****************************************************************************
        // TODO 23: Construct the SQL statement to retrieve the id, name, description *
        //          and date established of the fan clubs a club member, identified   *
        //          by a user name, HAS NOT JOINED. Order the result by club name.    *
        //*****************************************************************************
        sql = "select distinct FanClub.clubId, clubName, description from FanClub, HasMember"+
                " where FanClub.clubId = HasMember.clubId and "+
                    "HasMember.clubId not in (select clubId from HasMember where userName = '"+userName+"')"+
                " order by clubName";
        return myOracleDBAccess.GetData(sql);
    }

    public bool JoinFanClub(string clubId, string userName, string joinDate, string howInformed)
    {
        //***************************************************************************
        // TODO 24: Construct the SQL statement to add a new member for a fan club. *
        //***************************************************************************
        sql = "insert into HasMember values ("+clubId+",'"+userName+"','"+joinDate+"','"+howInformed+"')";
        return UpdateData(sql);
    }

    public bool CreateFanClub(string clubId, string clubName, string description, string dateEstablished)
    {
        //*************************************************************
        // TODO 25: Construct the SQL statement to create a fan club. *
        //*************************************************************
        sql = "insert into FanClub values ("+clubId+",'"+clubName+"','"+description+"','"+dateEstablished+"')";
        return UpdateData(sql);
    }

    public bool UpdateFanClub(string clubId, string clubName, string description, string dateEstablished)
    {
        //***************************************************************
        // TODO 26: Construct the SQL statement to update ALL the       *
        //          attributes of a fan club identified by its club id. *
        //***************************************************************
        sql = "update FanClub"+
                " set clubName = '"+clubName+"', description = '"+description+"', dateEstablished = '"+dateEstablished+
                "' where clubId ="+clubId;
        return UpdateData(sql);
    }

    #endregion SQL Statements for Fan Clubs

    #region SQL Statements for Remarks
    /******************************/
    /* SQL statements for Remarks */
    /******************************/

    public DataTable GetEventIdAndNameWithRemarksForEmployee(string employeeId)
    {
        //*****************************************************************************************************
        // TODO 27: Construct the SQL statement to retrieve the event id and name for ONLY those events that  *
        //          have remarks whose status is not equal to 'done' AND that either have already been        *
        //          assigned to an employee, identified by his/her employee id, OR that have not yet been     *
        //          assigned to any employee (i.e., the employee id is null). Order the result by event name. *
        //*****************************************************************************************************
        sql = "select distinct Remark.eventId, eventName from Remark, Event"+
                " where Remark.eventId = Event.eventId and(Remark.status <> 'done' or Remark.status is null) and "+
                       "(Remark.employeeId is null or Remark.employeeId = "+employeeId+")"+
                " order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetAvailableEventRemarksForProcessing(string eventId, string employeeId)
    {
        //****************************************************************************************************
        // TODO 28: Construct the SQL statement to retrieve ALL the remark attributes, for ONLY those events *
        //          identified by event id, whose status is not equal to 'done' AND that either have already *
        //          been assigned to an employee, identified by an employee id, OR that have not yet been    * 
        //          assigned to any employee (i.e., the employee id is null). Order the result by subject.   *
        //****************************************************************************************************
        sql = "select * from Remark"+
                " where Remark.eventId = "+eventId+" and(Remark.status <> 'done' or Remark.status is null) and "+
                        "(Remark.employeeId is null or Remark.employeeId = "+employeeId+")"+
                " order by subject";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetEventsWithRemarksFromUserName(string userName)
    {
        //*****************************************************************************
        // TODO 29: Construct the SQL statement to retrieve the event id and name for *
        //          ONLY those events for which a club member, identified by a user   *
        //          name, has submitted a remark. Order the result by event name.     *
        //*****************************************************************************
        sql = "select distinct Remark.eventId, eventName from Remark, Event"+
                " where userName = '"+userName+"' and Remark.eventId = Event.eventId"+
                " order by eventName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetEventRemarksForUserName(string userName, string eventId)
    {
        //**********************************************************************************
        // TODO 30: Construct the SQL statement to retrieve ALL the attributes for ALL the *
        //          remarks that a club member, identified by a user name, has submitted   *
        //          for an event, identified by its event id. Order the result by subject. *
        //**********************************************************************************
        sql = "select * from Remark"+
                " where userName = '"+userName+"' and eventId ="+eventId+
                " order by subject";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetFanClubIdAndNameWithRemarksForEmployee(string employeeId)
    {
        //*****************************************************************************************************
        // TODO 31: Construct the SQL statement to retrieve the fan club id and name, for ONLY those fan      *
        //          clubs that have remarks, whose status is not equal to 'done' AND that either have already *
        //          been assigned to an employee, identified by an employee id, OR that have not yet been     *
        //          assigned to any employee (i.e., the employee id is null). Order the result by club name.  *
        //*****************************************************************************************************
        sql = "select distinct Remark.clubId, clubName from Remark, FanClub"+
                " where Remark.clubId = FanClub.clubId and(Remark.status <> 'done' or Remark.status is null) and "+
                       "(Remark.employeeId is null or Remark.employeeId = "+employeeId+")"+
                " order by clubName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetAvailableFanClubRemarksForProcessing(string clubId, string employeeId)
    {
        //*******************************************************************************************************
        // TODO 32: Construct the SQL statement to retrieve ALL the remark attributes, for ONLY those           *
        //          fan clubs identified by club id, whose status is not equal to 'done' AND that either have   *
        //          already been assigned to an employee, identified by an employee id, OR that have not yet    * 
        //          been assigned to any employee (i.e., the employee id is null). Order the result by subject. *
        //*******************************************************************************************************
        sql = "select * from Remark"+
                " where Remark.clubId = "+clubId+" and(Remark.status <> 'done' or Remark.status is null) and "+
                       "(Remark.employeeId is null or Remark.employeeId = " + employeeId + ")" +
                " order by subject";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetFanClubsWithRemarksFromUserName(string userName)
    {
        //*****************************************************************************
        // TODO 33: Construct the SQL statement to retrieve the fan club id and name  *
        //          for ONLY those fan clubs for which a club member, identified by a *
        //          user name, has submitted a remark. Order the result by club name. *
        //*****************************************************************************
        sql = "select distinct Remark.clubId, clubName from Remark, FanClub"+
                " where userName = '"+userName+"' and Remark.clubId = FanClub.clubId"+
                " order by clubName";
        return myOracleDBAccess.GetData(sql);
    }

    public DataTable GetFanClubRemarksForUserName(string userName, string clubId)
    {
        //************************************************************************************
        // TODO 34: Construct the SQL statement to retrieve ALL the attributes for ALL the   *
        //          remarks that a club member, identified by a user name, has submitted for *
        //          a fan club, identified by its club id. Order the result by subject.      *
        //************************************************************************************
        sql = "select * from Remark"+
                " where userName = '"+userName+"' and clubId = "+clubId+
                " order by subject";
        return myOracleDBAccess.GetData(sql);
    }

    public bool SubmitRemark(string remarkId, string subject, string text, string submissionDate, string status, 
        string actionTaken, string remarkType, string userName, string employeeId, string clubId, string eventId)
    {
        //***************************************************************
        // TODO 35: Construct the SQL statement to insert a new remark. *
        //***************************************************************
        sql = "insert into Remark values ("+remarkId+",'"+subject+"','"+text+"','"+submissionDate+"','"+status+
            "','"+actionTaken+"','"+remarkType+"','"+userName+"',"+employeeId+","+clubId+","+eventId+")";
        return UpdateData(sql);
    }

    public bool UpdateRemark(string remarkId, string status, string actionTaken, string employeeId)
    {
        //**************************************************************************
        // TODO 36: Construct the SQL statement to update the status, action taken *
        //          and employee id of a remark identified by its remark id.       *
        //**************************************************************************
        sql = "update Remark set status='"+status+"', actionTaken='"+actionTaken+
            "', employeeId="+employeeId+" where remarkId="+remarkId;
        return UpdateData(sql);
    }

    #endregion SQL Statements for Remarks

    #region *** DO NOT CHANGE THE METHOD BELOW THIS LINE. IT IS NOT A TODO!!! ***!
    public bool UpdateData(string sql)
    {
        OracleTransaction trans = myOracleDBAccess.BeginTransaction();
        if (trans == null) { return false; }
        if (myOracleDBAccess.SetData(sql, trans))
        { myOracleDBAccess.CommitTransaction(trans); return true; } // The update succeeded.
        else
        { myOracleDBAccess.DisposeTransaction(trans); return false; } // The update failed.
    }
    #endregion
}