unit ViewBookingList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, StrUtils, Menus, Globals;

type
  TfrmViewBookingList = class(TForm)
    shpBody: TShape;
    shpHeader: TShape;
    btnHome: TBitBtn;
    lboBookingList: TListBox;
    lblBookingList: TLabel;
    lboSelectedBooking: TListBox;
    lblSelectedBooking: TLabel;
    lblViewBookingList: TLabel;
    btnEditBooking: TBitBtn;
    btnDeleteBooking: TBitBtn;
    btnCalendarView: TBitBtn;
    lblFilters: TLabel;
    lblDate: TLabel;
    edtDateFilter: TMaskEdit;
    cmbCourtNeededFilter: TComboBox;
    lblCourtsNeededFilter: TLabel;
    cmbTypeOfEventFilter: TComboBox;
    lblTypeOfEvent: TLabel;
    lblNameFilter: TLabel;
    edtFirstNameFilter: TEdit;
    edtSurnameFilter: TEdit;
    btnFilter: TButton;
    btnReset: TButton;
    mnmMainMenu: TMainMenu;
    mnuTools: TMenuItem;
    btnLoginasAdmin: TMenuItem;
    btnFormatBookingsforWeb: TMenuItem;
    btnCreateManualBackup: TMenuItem;
    procedure btnHomeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lboBookingListClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnDeleteBookingClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnCalendarViewClick(Sender: TObject);
    procedure btnLoginasAdminClick(Sender: TObject);
    procedure btnFormatBookingsforWebClick(Sender: TObject);
    procedure btnCreateManualBackupClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InitBookingList(var lboBookingList: TListBox);
    function FetchRelatedMember(RequestedBooking: TBooking; var ItemFound: boolean): TMember;
    function ConcatBookingArray(array1,array2:TBookingArray):TBookingArray;
    function ConcatMemberArray(array1,array2:TmemberArray):TMemberArray;
  end;

var
  frmViewBookingList: TfrmViewBookingList;

implementation

uses MainMenu, AddBooking, ViewBookingCalendar;

var
   UnfilteredBookingArray, TempBookingArray, FilteredBookingArray: TBookingArray;

procedure InsertionSortTBookingDate(var List: TBookingArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTBookingBookingID(var List: TBookingArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTBookingCourtNo(var List: TBookingArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTBookingEventType(var List: TBookingArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTSubmissionBookingID(var List: TSubmissionArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTMemberMemberID(var List: TMemberArray); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTBookingBookingID(var List: TBookingArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTBookingDate(var List: TBookingArray; var DateSought: TDateTime; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTBookingCourtNo(var List: TBookingArray; var CourtSought: Byte; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTBookingEventType(var List: TBookingArray; var EventSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTSubmissionBookingID(var List: TSubmissionArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTMemberMemberID(var List: TMemberArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';
{$R *.dfm}

function TfrmViewBookingList.FetchRelatedMember(RequestedBooking: TBooking; var ItemFound: boolean): TMember;
var
   ItemSought: shortstring;
   RequestedItemPosition: integer;
begin
{Combination of insertion sorts and binary searches to find the position of the member
associated with the  booking selected}
InsertionSortTBookingBookingId(BookingArray);
ItemFound:= false;
//Sorts submission array by member ID for binary search
InsertionSortTSubmissionBookingID(SubmissionArray);
//Searches for the location of the record containing the current booking ID in submission array
ItemSought:= RequestedBooking.BookingId;
BinarySearchTSubmissionBookingID(SubmissionArray, ItemSought, RequestedItemPosition, ItemFound);

if ItemFound = true then
begin
     ItemFound:= false;
     //Sorts member array by member ID for binary search
     InsertionSortTMemberMemberID(MemberArray);
     //Searches for the location of the record containing the current member ID in the member array
     ItemSought:= SubmissionArray[RequestedItemPosition].MemberID;
     BinarySearchTMemberMemberID(MemberArray, ItemSought, RequestedItemPosition, ItemFound);

     if ItemFound = true then
     begin
          //Returns the position of the associated member
          FetchRelatedMember:= MemberArray[RequestedItemPosition];
     end
     else
         ShowMessage('Member ID not found in Member table');
end
else
    ShowMessage('Booking ID not found in Submission table');
InsertionSortTBookingDate(BookingArray);
end;

function TfrmViewBookingList.ConcatBookingArray(Array1,Array2:TBookingArray):TBookingArray;
var
  Index, Position:integer;
begin
  {Concatenates two arrays of the type TBooking}
  SetLength(Result,(High(Array1)-Low(Array1))+(High(Array2)-Low(Array2)+2));
  Position:=0;
  for Index := Low(Array1) to High(Array1) do
  begin
    Result[Position]:= Array1[Index];
    Inc(Position);
  end;
  for Index := Low(Array2) to High(Array2) do
  begin
    Result[Position] := Array2[Index];
    Inc(Position);
  end;
end;

function TfrmViewBookingList.ConcatMemberArray(Array1,Array2:TmemberArray):TMemberArray;
var
  Index,Position:integer;
begin
  {Concatenates two arrays of the type TMember}
  SetLength(Result,(High(Array1)-Low(Array1))+(High(Array2)-Low(Array2)+2));
  Position:=0;
  for Index := Low(Array1) to High(Array1) do
  begin
    Result[Position]:= Array1[Index];
    Inc(Position);
  end;
  for Index := Low(Array2) to High(Array2) do
  begin
    Result[Position] := Array2[Index];
    Inc(Position);
  end;
end;


procedure TfrmViewBookingList.InitBookingList(var lboBookingList: TListBox);
var
   count: integer;
   FormattedDate: string;
begin
  {Reads the database and populates the form with a list of bookings stored}
  //Open booking file
  reset(BookingFile);
  BookingCounter:= FileSize(BookingFile);
  SetLength(BookingArray,BookingCounter);

  //Read booking file to booking array
  for count := 1 to BookingCounter do
  begin
       Read(BookingFile, SingleBooking);
       BookingArray[count-1]:= SingleBooking;
  end;
  closefile(BookingFile);

  //Open Submission file
  reset(SubmissionFile);
  SubmissionCounter:= FileSize(SubmissionFile);
  SetLength(SubmissionArray,SubmissionCounter);

  //Read Submission file to Submission array
  for count := 1 to SubmissionCounter do
  begin
       Read(SubmissionFile, SingleSubmission);
       SubmissionArray[count-1]:= SingleSubmission;
  end;
  closefile(SubmissionFile);

  //Open Member file
  reset(MemberFile);
  MemberCounter:= FileSize(MemberFile);
  SetLength(MemberArray,MemberCounter);

  //Read Member file to Member array
  for count := 1 to MemberCounter do
  begin
       Read(MemberFile, SingleMember);
       MemberArray[count-1]:= SingleMember;
  end;
  closefile(MemberFile);


  //Sorts the array by date
  InsertionSortTBookingDate(BookingArray);

  //Adds the dates to a listbox
  lboBookingList.clear;
  for count := 0 to Length(BookingArray) - 1 do
  begin
       DateTimeToString(FormattedDate, 'dd mmmm yyyy', BookingArray[count].Date);
       lboBookingList.Items.Add(FormattedDate);
  end;
end;

procedure TfrmViewBookingList.btnCalendarViewClick(Sender: TObject);
begin
  frmViewBookingList.hide;
  frmViewBookingCalendar.show;
end;

procedure TfrmViewBookingList.btnCreateManualBackupClick(Sender: TObject);
begin
     frmMainMenu.btnCreateManualBackupClick(btnCreateManualBackup);
end;

procedure TfrmViewBookingList.btnDeleteBookingClick(Sender: TObject);
var
   ArrayLength, count: Cardinal;
   ItemSought: ShortString;
   ItemFound: boolean;
   RequestedItemPosition: integer;
begin
{Procedure that deletes the selected booking from the database}
//Checks that a booking has been selected
if (lboBookingList.ItemIndex < Low(BookingArray)) OR (lboBookingList.ItemIndex > High(BookingArray)) then
   ShowMessage('Booking must be selected');
if (lboBookingList.ItemIndex >= Low(BookingArray)) AND (lboBookingList.ItemIndex <= High(BookingArray)) then
begin
     if Sender = btnDeleteBooking then
     begin
          //Finds the location of the currently selected booking
          SelectedItemIndex:= lboBookingList.ItemIndex;
          ItemSought:= BookingArray[SelectedItemIndex].BookingId;
          InsertionSortTBookingBookingID(BookingArray);
          InsertionSortTSubmissionBookingID(SubmissionArray);
          //Sorts booking array by booking id so it aligns with submission array
          //Finds the currently selected booking location in the newly sorted array
          BinarySearchTBookingBookingID(BookingArray, ItemSought, RequestedItemPosition, ItemFound);

          //Deletes the requested bookign from the array
          ArrayLength := Length(BookingArray);
          for count := RequestedItemPosition + 1 to ArrayLength - 1 do
              BookingArray[count - 1] := BookingArray[count];
          SetLength(BookingArray, ArrayLength - 1);

          //Writes the new booking array back to file
          rewrite(BookingFile);
          for count := 0 to Length(BookingArray) - 1 do
          begin
               SingleBooking:= BookingArray[count];
               write(BookingFile, SingleBooking);
          end;
          closefile(BookingFile);

          //Deletes the submission associated with the deleted booking
          ArrayLength := Length(SubmissionArray);
          for count := RequestedItemPosition + 1 to ArrayLength - 1 do
              SubmissionArray[count - 1] := SubmissionArray[count];
          SetLength(SubmissionArray, ArrayLength - 1);

          //Writes the new booking array back to file
          rewrite(SubmissionFile);
          for count := 0 to Length(SubmissionArray) - 1 do
          begin
               SingleSubmission:= SubmissionArray[count];
               write(SubmissionFile, SingleSubmission);
          end;
          closefile(SubmissionFile);
          
          InitBookingList(lboBookingList);
end;
if Sender = btnEditBooking then
begin
   //Fetches the currently selected booking
   SelectedItemIndex:= lboBookingList.ItemIndex;
   SingleBooking:= BookingArray[SelectedItemIndex];

   FromEditBooking:= true;

   //Adds the properties of the selected booking to the add booking form
   frmAddBooking.dtpDate.Date:= SingleBooking.Date;
   frmAddBooking.dtpTime.Time:= SingleBooking.Time;
   frmAddBooking.edtDuration.Text:= IntToStr(SingleBooking.Duration);
   frmAddBooking.cmbTypeofEvent.Text:= SingleBooking.EventType;
   frmAddBooking.cmbMemberName.Text:= SingleMember.FirstName +' '+SingleMember.Surname;
   frmAddBooking.edtMemberID.Text:= SingleMember.MemberId;
   frmAddBooking.chkCourtsNeeded.Checked[(SingleBooking.CourtNo)-1]:= true;

   frmViewBookingList.Hide;
   frmAddBooking.Show;
end;
end;
end;


procedure TfrmViewBookingList.btnFilterClick(Sender: TObject);
var
   DateSought: TDateTime;
   RequestedItemPosition, TempPosition, Index, position, count: integer;
   CourtSought: byte;
   EventSought, FirstNameSought, SurnameSought: ShortString;
   ItemFound, BeenFiltered, SearchFailed: boolean;
   MemberIDSoughtArray: array of string;
   BookingIDSoughtArray: array of string;
   FormattedDate: string;
begin
{Filters the list of bookings according to the parameters input by the user}
//Populates the booking list as it might not have been populated yet from these forms
if (Sender = frmAddBooking.btnSubmit) OR (Sender = frmViewBookingCalendar.clndBooking) then
   InitBookingList(lboBookingList);

//Initialises counters and variables
SearchFailed:= false;
BeenFiltered:= false;
SetLength(TempBookingArray, 0);
SetLength(FilteredBookingArray, 0);
RequestedItemPosition:= -1;
UnFilteredBookingArray:= BookingArray;
FilteredBookingArray:= BookingArray;

//Only allows the procedure if the booking array has data in it
if Length(BookingArray) > 0 then
begin
if (edtDateFilter.Text) <> '  /  /  ' then
begin
     //Finds an element in the sorted booking array matching the date selected
     index:= 0;
     SetLength(TempBookingArray, index);
     DateSought:= StrToDate(edtDateFilter.Text);
     InsertionSortTBookingDate(FilteredBookingArray);
     BinarySearchTBookingDate(FilteredBookingArray, DateSought, RequestedItemPosition, ItemFound);
     //Only allow next step if an item has been found
     if (RequestedItemPosition >= Low(BookingArray)) AND (RequestedItemPosition <= High(BookingArray)) then
     begin
          SetLength(TempBookingArray, Index+1);
          TempBookingArray[Index]:= FilteredBookingArray[RequestedItemPosition];
          TempPosition:= RequestedItemPosition;
          if TempPosition > Low(FilteredBookingArray) then
          begin
               //Finds any additional elemnts with the same date above the original element
               while Trunc(FilteredBookingArray[TempPosition -1].Date) = DateSought do
               begin
                    Index:= Length(TempBookingArray);
                    TempPosition:= TempPosition-1;
                    SetLength(TempBookingArray, Index+1);
                    TempBookingArray[Index]:= FilteredBookingArray[TempPosition]
               end;
          end;
          TempPosition:= RequestedItemPosition;
          if TempPosition < High(FilteredBookingArray) then
          begin
               //Finds any additional elements with the same date below the original element
               while Trunc(FilteredBookingArray[TempPosition +1].Date) = DateSought do
               begin
                    Index:= Length(TempBookingArray);
                    TempPosition:= TempPosition+1;
                    SetLength(TempBookingArray, Index+1);
                    TempBookingArray[Index]:= FilteredBookingArray[TempPosition];
                    FilteredBookingArray:= TempBookingArray;
               end;
          end;
          if not BeenFiltered then
             FilteredBookingArray:= TempBookingArray;
          BeenFiltered:= true;
     end
     else
         SearchFailed:= true;
end;
if ((cmbCourtNeededFilter.Text <> '') AND (StrToInt(cmbCourtNeededFilter.Text) >= 1) AND (StrToInt(cmbCourtNeededFilter.Text) <= 8)) then
begin
     //Finds an element in the sorted booking array matching the date selected
     index:= 0;
     SetLength(TempBookingArray, index);
     CourtSought:= StrToInt(cmbCourtNeededFilter.Text);
     InsertionSortTBookingCourtNo(FilteredBookingArray);
     BinarySearchTBookingCourtNo(FilteredBookingArray, CourtSought, RequestedItemPosition, ItemFound);
     //Only allow next step if an item has been found
     if (RequestedItemPosition >= Low(FilteredBookingArray)) AND (RequestedItemPosition <= High(FilteredBookingArray))  then
     begin
          SetLength(TempBookingArray, Index+1);
          TempBookingArray[Index]:= FilteredBookingArray[RequestedItemPosition];
          TempPosition:= RequestedItemPosition;
          //Finds any additional elemnts with the same court no. above the original element
          while FilteredBookingArray[TempPosition -1].CourtNo = CourtSought do
          begin
               Index:= Length(TempBookingArray);
               TempPosition:= TempPosition-1;
               SetLength(TempBookingArray, Index+1);
               TempBookingArray[Index]:= BookingArray[TempPosition]
          end;
          TempPosition:= RequestedItemPosition;
          //Finds any additional elements with the same court no. below the original element
          while FilteredBookingArray[TempPosition +1].CourtNo = CourtSought do
          begin
               Index:= Length(TempBookingArray);
               TempPosition:= TempPosition+1;
               SetLength(TempBookingArray, Index+1);
               TempBookingArray[Index]:= BookingArray[TempPosition]
          end;
          if not BeenFiltered then
             FilteredBookingArray:= TempBookingArray
          else
              FilteredBookingArray:= ConcatBookingArray(FilteredBookingArray, TempBookingArray);
          BeenFiltered:= true;
     end
     else
         SearchFailed:= true;
end;
if (cmbTypeOfEventFilter.Text) <> '' then
begin
     //Finds an element in the sorted booking array matching the date selected
     index:= 0;
     SetLength(TempBookingArray, index);
     EventSought:= cmbTypeOfEventFilter.Text;
     InsertionSortTBookingEventType(FilteredBookingArray);
     BinarySearchTBookingEventType(FilteredBookingArray, EventSought, RequestedItemPosition, ItemFound);
     //Only allow next step if an item has been found
     if (RequestedItemPosition >= Low(FilteredBookingArray)) AND (RequestedItemPosition <= High(FilteredBookingArray))  then
     begin
          SetLength(TempBookingArray, Index+1);
          TempBookingArray[Index]:= FilteredBookingArray[RequestedItemPosition];
          TempPosition:= RequestedItemPosition;
          //Finds any additional elemnts with the same event type above the original element
          while FilteredBookingArray[TempPosition -1].EventType = EventSought do
          begin
               Index:= Length(TempBookingArray);
               TempPosition:= TempPosition-1;
               SetLength(TempBookingArray, Index+1);
               TempBookingArray[Index]:= FilteredBookingArray[TempPosition]
          end;
          TempPosition:= RequestedItemPosition;
          //Finds any additional elements with the same event type below the original element
          while FilteredBookingArray[TempPosition +1].EventType = EventSought do
          begin
               Index:= Length(TempBookingArray);
               TempPosition:= TempPosition+1;
               SetLength(TempBookingArray, Index+1);
               TempBookingArray[Index]:= FilteredBookingArray[TempPosition]
          end;
          if not BeenFiltered then
             FilteredBookingArray:= TempBookingArray
          else
              FilteredBookingArray:= ConcatBookingArray(FilteredBookingArray, TempBookingArray);
          BeenFiltered:= true;
     end
     else
         SearchFailed:= true;
end;
if (edtFirstNameFilter.Text) <> '' then
begin
     index:= 0;
     SetLength(TempBookingArray, index); //Clear temp array
     FirstNameSought:= edtFirstNameFilter.Text;
     SearchFailed:= true;

     //Sorts the tables by their unique ids
     InsertionSortTBookingBookingID(TempBookingArray);
     InsertionSortTSubmissionBookingID(SubmissionArray);
     InsertionSortTMemberMemberID(MemberArray);

     SetLength(MemberIDSoughtArray, 0);

     //Searches for the member IDs matching the first name filter
     for index := Low(MemberArray) to High(MemberArray) do
     begin
          if StartsStr(FirstNameSought, MemberArray[index].FirstName) then
          begin
               SetLength(MemberIDSoughtArray, Length(MemberIDSoughtArray)+1);
               MemberIDSoughtArray[Length(MemberIDSoughtArray)-1]:= MemberArray[index].MemberID;
               SearchFailed:= false;
          end;
     end;

     if Length(MemberIDSoughtArray) <> 0 then
     begin
          SetLength(BookingIDSoughtArray, 0);

          for Position:= Low(SubmissionArray) to High(SubmissionArray) do
          begin
               //Searches for the location of the record containing the current member ID in submission array
               if MatchStr(SubmissionArray[Position].MemberID, MemberIDSoughtArray) then
               begin
                    SetLength(BookingIDSoughtArray, Length(BookingIDSoughtArray)+1);
                    BookingIDSoughtArray[Length(BookingIDSoughtArray)-1]:= SubmissionArray[Position].BookingID;
               end;
          end;

          for Position:= Low(FilteredBookingArray) to High(FilteredBookingArray) do
          begin
               //Searches for the location of the record containing the current member ID in submission array
               if MatchStr(FilteredBookingArray[Position].BookingID, BookingIDSoughtArray) then
               begin
                    Index:= Length(TempBookingArray);
                    SetLength(TempBookingArray, Index+1);
                    TempBookingArray[Index]:= FilteredBookingArray[Position]
               end;
          end;
     end;

     if not BeenFiltered then
         FilteredBookingArray:= TempBookingArray
     else
         FilteredBookingArray:= ConcatBookingArray(FilteredBookingArray, TempBookingArray);
     if not SearchFailed then     
        BeenFiltered:= true;
end;
if (edtSurnameFilter.Text) <> '' then
begin
     index:= 0;
     SetLength(TempBookingArray, index); //Clear temp array
     SurnameSought:= edtSurnameFilter.Text;
     SearchFailed:= true;

     //Sorts the tables by their unique ids
     InsertionSortTBookingBookingID(TempBookingArray);
     InsertionSortTSubmissionBookingID(SubmissionArray);
     InsertionSortTMemberMemberID(MemberArray);

     SetLength(MemberIDSoughtArray, 0);

     //Searches for the member IDs matchign the surname filter
     for index := Low(MemberArray) to High(MemberArray) do
     begin
          if StartsStr(SurnameSought, MemberArray[index].Surname) then
          begin
               SetLength(MemberIDSoughtArray, Length(MemberIDSoughtArray)+1);
               MemberIDSoughtArray[Length(MemberIDSoughtArray)-1]:= MemberArray[index].MemberID;
               SearchFailed:= false;
          end;
     end;

     if Length(MemberIDSoughtArray) <> 0 then
     begin
          SetLength(BookingIDSoughtArray, 0);

          for Position:= Low(SubmissionArray) to High(SubmissionArray) do
          begin
               //Searches for the location of the record containing the current member ID in submission array
               if MatchStr(SubmissionArray[Position].MemberID, MemberIDSoughtArray) then
               begin
                    SetLength(BookingIDSoughtArray, Length(BookingIDSoughtArray)+1);
                    BookingIDSoughtArray[Length(BookingIDSoughtArray)-1]:= SubmissionArray[Position].BookingID;
               end;
          end;

          for Position:= Low(FilteredBookingArray) to High(FilteredBookingArray) do
          begin
               //Searches for the location of the record containing the current member ID in submission array
               if MatchStr(FilteredBookingArray[Position].BookingID, BookingIDSoughtArray) then
               begin
                    Index:= Length(TempBookingArray);
                    SetLength(TempBookingArray, Index+1);
                    TempBookingArray[Index]:= FilteredBookingArray[Position]
               end;
          end;
     end;

     if not BeenFiltered then
         FilteredBookingArray:= TempBookingArray
     else
         FilteredBookingArray:= ConcatBookingArray(FilteredBookingArray, TempBookingArray);
     if not SearchFailed then
        BeenFiltered:= true;
end;
//If the filters selected failed to find anything then alerts the user
if ((FilteredBookingArray = BookingArray) and (BeenFiltered = false)) OR (SearchFailed = true) then
begin
   if Sender = btnFilter then
   begin
       SetLength(FilteredBookingArray, 0);
       ShowMessage('No matches found');
   end;
   if (Sender = frmAddBooking.btnSubmit) OR (Sender = frmViewBookingCalendar.clndBooking) then
   begin
       SetLength(BookingArray,0);
       edtDateFilter.Text:= '  /  /  ';
   end;
end
else
    BookingArray:= FilteredBookingArray;

lboBookingList.Clear;
InsertionSortTBookingDate(BookingArray);
if (Sender = btnFilter) OR (Sender = frmViewBookingCalendar.clndBooking) then
begin
     //Adds the dates to a listbox
     for count := 0 to Length(BookingArray) - 1 do
     begin
          DateTimeToString(FormattedDate, 'dd mmmm yyyy', BookingArray[count].Date);
          lboBookingList.Items.Add(FormattedDate);
     end;

end;
end
else
  if not (Sender = frmAddBooking.btnSubmit) then  
    ShowMessage('Can''''t filter an empty list');
end;

procedure TfrmViewBookingList.btnFormatBookingsforWebClick(Sender: TObject);
begin
     frmMainMenu.btnFormatBookingsForWebClick(btnFormatBookingsForWeb);
end;

procedure TfrmViewBookingList.btnHomeClick(Sender: TObject);
begin
     frmViewBookingList.hide;
     frmMainMenu.show;
end;

procedure TfrmViewBookingList.btnLoginasAdminClick(Sender: TObject);
begin
     frmMainMenu.btnLoginAsAdminClick(btnLoginAsAdmin);
end;

procedure TfrmViewBookingList.btnResetClick(Sender: TObject);
begin
     //Clears the filter fields and repopulates the booking list
     edtDateFilter.Text:= '  /  /  ';
     cmbCourtNeededFilter.Text:= '';
     cmbTypeOfEventFilter.Text:= '';
     edtFirstNameFilter.Text:= '';
     edtSurnameFilter.Text:= '';
     BookingArray:= UnfilteredBookingArray;
     lboBookingList.Clear;
     InitBookingList(lboBookingList);
end;

procedure TfrmViewBookingList.FormShow(Sender: TObject);
begin
  if FromCalendar = false then
  begin  
     lboBookingList.Clear;
     InitBookingList(lboBookingList);
  end;
  FromCalendar:= false;
end;

procedure TfrmViewBookingList.lboBookingListClick(Sender: TObject);
const
  // The maximum number of Tabs
  MAX_TABS = 4;
  Tab = #9;
var
   FormattedDate, FormattedTime: string;
   Tabulators: array[0..MAX_TABS] of Integer;
   ItemFound: boolean;
begin
     SelectedItemIndex:= lboBookingList.ItemIndex;
     SingleMember:= FetchRelatedMember(BookingArray[SelectedItemIndex], ItemFound);

     //Set up the tabulators
     Tabulators[0] := 80;
     Tabulators[1] := 120;
     Tabulators[2] := 100;
     Tabulators[3] := 80;
     lboSelectedBooking.TabWidth := 1;
     SendMessage(lboSelectedBooking.Handle, LB_SETTABSTOPS, MAX_TABS, Longint(@Tabulators));

     //Finds the selected date and fetches the relevant booking and displays it
     SelectedItemIndex:= lboBookingList.ItemIndex;
     lboSelectedBooking.Clear;

     DateTimeToString(FormattedDate, 'dddddd', BookingArray[SelectedItemIndex].Date);
     DateTimeToString(FormattedTime, 't', BookingArray[SelectedItemIndex].Time);
     lboSelectedBooking.Items.Add('Booking ID:'+ Tab +BookingArray[SelectedItemIndex].BookingID);
     lboSelectedBooking.Items.Add('Date:'+ Tab +FormattedDate);
     lboSelectedBooking.Items.Add('Time:'+ Tab +FormattedTime);
     lboSelectedBooking.Items.Add('Duration:'+ Tab +(IntToStr(BookingArray[SelectedItemIndex].Duration)+'m'));
     lboSelectedBooking.Items.Add('Court Number:'+ Tab +IntToStr(BookingArray[SelectedItemIndex].CourtNo));
     lboSelectedBooking.Items.Add('Event Type:'+ Tab +BookingArray[SelectedItemIndex].EventType);
     lboSelectedBooking.Items.Add('Member:'+ Tab + SingleMember.FirstName + ' ' + SingleMember.Surname);
     lboSelectedBooking.Items.Add('')
end;

end.
