unit AddBooking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls, CheckLst, ComCtrls, DateUtils,
  Menus, IniFiles;

type
  TfrmAddBooking = class(TForm)
    btnHome: TBitBtn;
    shpBody: TShape;
    shpHeader: TShape;
    lblAddBooking: TLabel;
    edtMemberID: TLabeledEdit;
    lblCourtsNeeded: TLabel;
    chkCourtsNeeded: TCheckListBox;
    btnSubmit: TBitBtn;
    lblDate: TLabel;
    cmbTypeofEvent: TComboBox;
    lblTypeOfEvent: TLabel;
    lblTime: TLabel;
    cmbMemberName: TComboBox;
    lblMemberName: TLabel;
    dtpDate: TDateTimePicker;
    dtpTime: TDateTimePicker;
    edtDuration: TMaskEdit;
    lblDuration: TLabel;
    mnmMainMenu: TMainMenu;
    mnuTools: TMenuItem;
    btnLoginasAdmin: TMenuItem;
    btnFormatBookingsForWeb: TMenuItem;
    btnCreateManualBackup: TMenuItem;
    procedure btnHomeClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbMemberNameSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure btnLoginasAdminClick(Sender: TObject);
    procedure btnFormatBookingsForWebClick(Sender: TObject);
    procedure btnCreateManualBackupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddBooking: TfrmAddBooking;

implementation

uses Globals, MainMenu, ViewBookingList, ViewBookingCalendar;

var
  NextBookingID, NextMemberID: string;

procedure InsertionSortTBookingBookingID(var List: TBookingArray); stdcall; external 'GlobalSubroutines.dll';

{$R *.dfm}

procedure TfrmAddBooking.btnCreateManualBackupClick(Sender: TObject);
begin
     frmMainMenu.btnCreateManualBackupClick(btnCreateManualBackup);
end;

procedure TfrmAddBooking.btnFormatBookingsForWebClick(Sender: TObject);
begin
     frmMainMenu.btnFormatBookingsForWebClick(btnFormatBookingsForWeb);
end;

procedure TfrmAddBooking.btnHomeClick(Sender: TObject);
begin
  frmAddBooking.hide;
  frmMainMenu.show;
end;

procedure TfrmAddBooking.btnSubmitClick(Sender: TObject);
var
  ChecklistCount, ArrayCount, CourtCount, count, I, GetLength, CourtsSelected, CurrentCourts, position, LeagueMatches: integer;
  CourtsNeededArray: array of integer;
  SelectedHour, SelectedMinute, SelectedSecond, SelectedMs: word;
  BookingValid, ValidEventType, ValidName, ItemFound: boolean;
  ErrorMessage, GetString, T, TempMinDate, TempDate, TempMaxDate, FormattedDate: string;
  MinTime, MaxTime, TempTime: TDateTime;
begin
//Sets the minimum and maximum time allowed for bookings
MinTime:= StrToDateTime('07:00');
MaxTime:= StrToDateTime('21:00');
//Fetches the minimum and maximum date for bookings from the date time picker components
TempMinDate:= DateTimeToStr(dtpDate.MinDate);
TempDate:= DateTimeToStr(dtpDate.DateTime);
TempMaxDate:= DateTimeToStr(dtpDate.MaxDate);
//Initialise counters
CourtCount:= 0;
ArrayCount:= 0;
LeagueMatches:= 0;
ValidEventType:= false;
ValidName:= false;
//Find the number of courts selected
for CheckListCount := 0 to chkCourtsNeeded.Items.Count -1 do
begin
     if chkCourtsNeeded.checked[ChecklistCount] = true then
     begin
          CourtCount:= CourtCount+1;
     end;
end;

//Adds all courts selected to an array
for CheckListCount := 0 to chkCourtsNeeded.Items.Count -1 do
begin
     if chkCourtsNeeded.checked[ChecklistCount] = true then
     begin
          ArrayCount:= ArrayCount+1;
          SetLength(CourtsNeededArray, ArrayCount);
          CourtsNeededArray[ArrayCount -1]:= StrToInt(chkCourtsNeeded.Items[ChecklistCount]);
     end;
end;

//Forces the first letter of the event type of a capital
if cmbTypeOfEvent.SelLength > 0 then
    GetString:= cmbTypeOfEvent.Seltext
else
    GetString:= cmbTypeOfEvent.Text;
GetLength:= Length(GetString) ;
if GetLength>0 then
begin
     for I:= 0 to GetLength do
     begin
          if (GetString = ' ') or (I=0) then
          begin
               if GetString[I+1] in ['a'..'z'] then
               begin
                  T:=GetString[I+1];
                  T:=UpperCase(T) ;
                  GetString[I+1]:=T[1];
               end;
          end;
     end;
     if cmbTypeOfEvent.SelLength>0 then
        cmbTypeOfEvent.SelText:=GetString
     else cmbTypeOfEvent.Text:=GetString;
end;
{The following large block of code is the various validation rules applied to the submitted booking}

BookingValid:= true;
//Postal matches and league matches can't be booked more than 10 weeks in advance
if (cmbTypeOfEvent.Text = 'Postal Match') OR (cmbTypeOfEvent.Text = 'League Match') then
begin
     if dtpDate.DateTime > IncDay(dtpDate.MinDate, 7*10) then //If requested DateTime is more than 10 weeks in advance
        BookingValid:= false;
        ErrorMessage:= ErrorMessage +sLineBreak+ 'This type of booking can not be booked further than 10 weeks in advance';
end;
//Booking date presence check
if (dtpDate.DateTime < dtpDate.MinDate) OR (dtpDate.DateTime > dtpDate.MaxDate) then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Booking date must be selected';
end;
//Booking time range/presence check
if (frac(dtpTime.Time) < frac(MinTime)) OR (frac(dtpTime.Time) > frac(MaxTime)) then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Booking time must be between 7am and 9pm';
end;
DecodeTime(dtpTime.Time,SelectedHour,SelectedMinute,SelectedSecond,SelectedMS);
//Booking time can only be in 15 minute increments apst the hour (:00,:15,:30,:45);
if SelectedMinute mod 15 <> 0 then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Bookings must be made in 15 mintues increments e.g xx:15, xx:30 etc..';
end;
//Booking duration presense check
if edtDuration.Text = '' then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Duration must be entered';
end;
//Booking duration range check
if StrToInt(edtDuration.Text) < 30 then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Duration must be longer than 30 minutes';
end;
//Additional duration range check for coaching session event
if (StrToInt(edtDuration.Text) > 180) AND (cmbTypeOfEvent.Text <> 'Coaching Session') then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Duration must be shorter than 180 minutes';
end;
//Event Type presence check
if cmbTypeOfEvent.Text = '' then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Event type must be selected';
end;
//Event Type lookup check
for count := 0 to cmbTypeOfEvent.Items.Count - 1 do
    if cmbTypeOfEvent.Text = cmbTypeOFEvent.Items[count] then
       ValidEventType:= true;
if ValidEventType = false then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Event type must be one of the options in the drop-down menu';
end;
//Member name presence check
if cmbMemberName.Text = '' then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Member name must be entered';
end;
//Member name lookup check
for count := 0 to cmbMemberName.Items.Count - 1 do
    if cmbMemberName.Text = cmbMemberName.Items[count] then
       ValidName:= true;
if ValidName = false then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Member name must be one of the options in the drop-down menu';
end;
//Number of courts selected range check
if (CourtCount = 0) OR (CourtCount > 4) then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Between 1 and 4 courts must be selected';
end;
//Filters booking array to the requested booking date
DateTimeToString(FormattedDate, 'dd/mm/yy', dtpDate.Date);
frmViewBookingList.edtDateFilter.Text:= DateToStr(dtpDate.Date);
frmViewBookingList.btnFilterClick(frmAddBooking.btnSubmit);
CurrentCourts:= 0;
//Checks if any current bookings fall within the time range of requested booking
for count := Low(BookingArray) to Length(BookingArray) -1 do
begin
  TempTime:= IncMinute(BookingArray[count].Time, BookingArray[count].Duration);
  if (TempTime >= dtpTime.Time) AND (TempTime <= IncMinute(dtpTime.Time, StrToInt(edtDuration.Text))) then
     Inc(CurrentCourts);
     for position := Low(CourtsNeededArray) to High(CourtsNeededArray) do
     begin
          //Check if court is already booked at the requested time
          if (BookingArray[count].CourtNo = CourtsNeededArray[position]) then
          begin
               BookingValid:= false;
               ErrorMessage:= ErrorMessage +sLineBreak+ 'Court'+IntToStr(BookingArray[count].CourtNo)+' already booked at this time';
          end;
          //Check that only 2 league matches can occur at a time
          if cmbTypeOfEvent.Text = 'League Match' then
            if BookingArray[count].EventType = 'League Match' then
              Inc(LeagueMatches);
              if LeagueMatches >= 2 then
                 ErrorMessage:= ErrorMessage +sLineBreak+ 'Only 2 league matches can be booked at one time, please choose a different time';

     end;
end;
//Check if current court is already booked at this time
frmViewBookingList.edtDateFilter.Text:= '  /  /  ';
if (CurrentCourts + CourtsSelected) > 4 then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Too many courts already booked at this time, four courts must be available for general play';
end;
//When editing a booking, only allow one court to be selected
if (FromEditBooking = true) AND (CourtCount <> 1) then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Only one court can be selected when editing a booking';
end;
//When editing a booking, do not alloiw member name to be changed
if (FromEditBooking = true) AND (edtMemberID.Text <> SingleMember.MemberID) then
begin
     BookingValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Member name cannot be changed when editing a booking';
end;

if BookingValid = true then
begin
     //Forces the first letter of the event type of a capital
     if cmbTypeOfEvent.SelLength > 0 then
        GetString:= cmbTypeOfEvent.Seltext
     else GetString:= cmbTypeOfEvent.Text;
     GetLength:= Length(GetString) ;
     if GetLength>0 then
     begin
        for I:= 0 to GetLength do
        begin
            if (GetString = ' ') or (I=0) then
            begin
               if GetString[I+1] in ['a'..'z'] then
               begin
                  T:=GetString[I+1];
                  T:=UpperCase(T) ;
                  GetString[I+1]:=T[1];
               end;
            end;
        end;
        if cmbTypeOfEvent.SelLength>0 then
           cmbTypeOfEvent.SelText:=GetString
        else cmbTypeOfEvent.Text:=GetString;
     end;


    if FromEditBooking = false then
    begin
         //Fetches next unique ID to be used from file
         ConfigFile:= TMemIniFile.Create(ConfigDir);
         NextBookingID:= ConfigFile.ReadString('Database','NextBookingID','1');
         ConfigFile.Free;

         //Initialise array counter
         ArrayCount:= 0;
    end;

    //Fetches desired booking to be added from frmAddBooking
    SingleBooking.Date:= dtpDate.Date;
    SingleBooking.Time:= dtpTime.Time;
    SingleBooking.Duration:= StrToInt(edtDuration.Text);
    SingleBooking.EventType:= cmbTypeOfEvent.Text;

    if FromEditBooking = false then
    begin
         SetLength(CourtsNeededArray,0);
         //Adds all courts selected to an array
         for CheckListCount := 0 to chkCourtsNeeded.Items.Count -1 do
         begin
              if chkCourtsNeeded.checked[ChecklistCount] = true then
              begin
                   ArrayCount:= ArrayCount+1;
                   SetLength(CourtsNeededArray, ArrayCount);
                   CourtsNeededArray[ArrayCount -1]:= StrToInt(chkCourtsNeeded.Items[ChecklistCount]);
              end;
         end;


         //Populates a Submission record to be added to the database
         SingleSubmission.MemberId:= edtMemberID.Text;
         SingleSubmission.DateOfSubmission:= Now;
    end;


    if FromEditBooking = false then
    begin
         for CourtCount := 0 to (ArrayCount -1) do  //Selects a court number from the previously poplated array
         begin
              SingleBooking.CourtNo:= CourtsNeededArray[CourtCount]; //Adds each court number as a seperate entry in the database

              //Refetches the unique id from the text file
              if ((ArrayCount -1) >= 1) then
              begin
                   ConfigFile:= TMemIniFile.Create(ConfigDir);;
                   NextBookingID:= ConfigFile.ReadString('Database','NextBookingID','1');
                   ConfigFile.Free;
              end;


              //Assigns the next available booking ids to the pending booking
              SingleBooking.BookingID:= NextBookingID;
              SingleSubmission.BookingID:= SingleBooking.BookingID;

              //Adds a single booking to database
              reset(BookingFile);
              BookingCounter:= FileSize(BookingFile);
              Seek(BookingFile, BookingCounter);
              write(BookingFile, SingleBooking);
              closefile(BookingFile);

              //Adds a single submission to the database
              reset(SubmissionFile);
              SubmissionCounter:= FileSize(SubmissionFile);
              Seek(SubmissionFile, SubmissionCounter);
              write(SubmissionFile, SingleSubmission);
              closefile(SubmissionFile);

              //Increments the booking id and writes it back to file for use in the next booking
              ConfigFile:= TMemIniFile.Create(ConfigDir);
              ConfigFile.WriteString('Database','NextBookingID',IntToStr(StrToInt(NextBookingID)+1));
              ConfigFile.UpdateFile;
              ConfigFile.Free;
         end;
    end;

    if FromEditBooking = true then
    begin
         BookingArray[SelectedItemIndex]:= SingleBooking;

         InsertionSortTBookingBookingID(BookingArray);

         //Rewrites the booking file with the edited booking record
         rewrite(BookingFile);
         for count:= Low(BookingArray) to  High(BookingArray) do
         begin
             BookingCounter:= FileSize(BookingFile);
             Seek(BookingFile, BookingCounter);
             write(BookingFile, BookingArray[count]);
         end;
         closefile(BookingFile);
    end;



    //Clears all input fields in the form for subsequent bookings
    dtpDate.Format := '__/__/____';
    dtpTime.Time:= StrToTime('00:00');
    edtDuration.Clear;
    cmbTypeofEvent.ClearSelection;
    cmbMemberName.ClearSelection;
    edtMemberID.Clear;
    for count:= 0 to chkCourtsNeeded.Count -1 do
        chkCourtsNeeded.Checked[count]:= false;

    dtpDate.SetFocus;

    if FromEditBooking = true then
    begin
         FromEditBooking:= false;
         frmAddBooking.Hide;
         frmViewBookingList.Show;
    end;
    if FromCalendar then
    begin
         FromCalendar:= false;
         frmAddBooking.Hide;
         frmViewBookingCalendar.Show;
    end;
end
else
    ShowMessage(ErrorMessage);
end;




procedure TfrmAddBooking.cmbMemberNameSelect(Sender: TObject);
var
   RequestedMemberPosition: integer;
   RequestedMemberID: string[3];
begin
if FromEditBooking = false then
begin
     //Fetches the appropriate member id for the selected member and displays it
     RequestedMemberPosition:= cmbMemberName.ItemIndex;
     RequestedMemberID:= MemberArray[RequestedMemberPosition].MemberID;
     edtMemberID.Text:= RequestedMemberID;
end
else
     ShowMessage('Member name can'+''''+'t be changed when editing booking, please change back to original value');
end;


procedure TfrmAddBooking.dtpDateChange(Sender: TObject);
begin
     //Changes the date format back to defualt when a date is entered
     if (FromEditBooking = false) OR (FromCalendar = false) then
      dtpDate.Format := '';
end;


procedure TfrmAddBooking.FormCreate(Sender: TObject);
begin
     dtpDate.MinDate:= Now; //Sets minimum date to the current date
     dtpDate.MaxDate:= IncYear(Date, 2); //Sets maximum date to current date + 2 years
end;

procedure TfrmAddBooking.FormShow(Sender: TObject);
var
   count: SmallInt;
   TempMember: TMember;
begin
  if (FromEditBooking = false) AND (FromCalendar = false) then
  begin
    dtpDate.Format := '__/__/____';
    dtpTime.Time:= StrToTime('00:00');
  end;

  //Fetches the next batch of unique IDs to be allocated
  ConfigFile:= TMemIniFile.Create(ConfigDir);
  NextBookingID:= ConfigFile.ReadString('Database','NextBookingID','1');
  ConfigFile.Free;

  //Open Member file
  reset(MemberFile);
  MemberCounter:= FileSize(MemberFile);
  SetLength(MemberArray,MemberCounter);

  //Read Member file to Member array
  if FromEditBooking = true then
     TempMember:= SingleMember;

  for count := 1 to MemberCounter do
  begin
       Read(MemberFile, SingleMember);
       MemberArray[count-1]:= SingleMember;
  end;
  closefile(MemberFile);

  if FromEditBooking = true then
     SingleMember:= TempMember;

  //Displays an entry in the listbox for all currently stored members in the system
  for count := 0 to MemberCounter - 1 do
  begin
       cmbMemberName.Items.Add(MemberArray[count].FirstName+' '+MemberArray[count].Surname);
  end;
end;

procedure TfrmAddBooking.btnLoginasAdminClick(Sender: TObject);
begin
     frmMainMenu.btnLoginAsAdminClick(btnLoginAsAdmin);
end;

end.
