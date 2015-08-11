unit Globals;

interface

uses IniFiles;

type  //Declares the structure of the three tables in the database
  TBooking = record
    BookingId: String[4]; //Unique ID
    CourtNo: Byte;
    Date: TDateTime;
    Time: TDateTime;
    Duration: SmallInt;
    EventType: String[20];
  end;

  TBookingArray = array of TBooking;
  TBookingFile = file of TBooking;

  TSubmission = record
    BookingId: String[4];  //Composite unique ID
    MemberId: String[3];   //Composite unique ID
    DateOfSubmission: TDateTime;
  end;

  TSubmissionArray = array of TSubmission;
  TSubmissionFile = file of TSubmission;

  TMember = record
    MemberId: String[3]; //Unique ID
    FirstName: String[20];
    Surname: String[25];
    EmailAddress: String[30];
    TelephoneNumber: String[12];
  end;

  TMemberArray = array of TMember;
  TMemberFile = file of TMember;

var
  //Booking
  SingleBooking: TBooking;
  BookingFile: TBookingFile;
  BookingArray: TBookingArray;
  BookingCounter: integer;

  //Submissions
  SingleSubmission: TSubmission;
  SubmissionFile: TSubmissionFile;
  SubmissionArray: TSubmissionArray;
  SubmissionCounter: integer;

  //Member
  SingleMember: TMember;
  MemberFile: TMemberFile;
  MemberArray: TMemberArray;
  MemberCounter: integer;


  BookingDir, SubmissionDir, MemberDir, DatabaseDir, ConfigDir, IDDir, CurrentYear: string;
  FromEditBooking, FromEditMember, FromCalendar, AdminAccess: boolean;

  SelectedItemIndex: integer;

  LastBackup: TDateTime;
  ConfigFile: TMemIniFile;
implementation

end.
