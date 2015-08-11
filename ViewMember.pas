unit ViewMember;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, StrUtils;

type
  TfrmViewMember = class(TForm)
    shpHeader: TShape;
    shpBody: TShape;
    btnHome: TBitBtn;
    lblViewMember: TLabel;
    lboMemberList: TListBox;
    lblMemberList: TLabel;
    lboSelectedMember: TListBox;
    lblSelectedMember: TLabel;
    btnEditMember: TBitBtn;
    btnDeleteMember: TBitBtn;
    lblFirstNameFilter: TLabel;
    edtFirstNameFilter: TEdit;
    lblFilters: TLabel;
    lblSurnameFilter: TLabel;
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
    procedure lboMemberListClick(Sender: TObject);
    procedure btnDeleteMemberClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnFormatBookingsforWebClick(Sender: TObject);
    procedure btnCreateManualBackupClick(Sender: TObject);
    procedure btnLoginasAdminClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewMember: TfrmViewMember;

implementation

uses Globals, MainMenu, AddMember, ViewBookingList;

var
   UnfilteredMemberArray: TMemberArray;

procedure InsertionSortTMemberMemberID(var List: TMemberArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTMemberSurname(var List: TMemberArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTSubmissionMemberID(var List: TSubmissionArray); stdcall; external 'GlobalSubroutines.dll';
procedure BinarySearchTMemberMemberID(var List: TMemberArray; var ItemSought: ShortString; var ItemLocation: integer; var ItemFound: boolean); stdcall; external 'GlobalSubroutines.dll';

{$R *.dfm}

procedure TfrmViewMember.btnCreateManualBackupClick(Sender: TObject);
begin
     frmMainMenu.btnCreateManualBackupClick(btnCreateManualBackup);
end;

procedure TfrmViewMember.btnDeleteMemberClick(Sender: TObject);
var
   ArrayLength, count: Cardinal;
   BookingIDToBeDeleted: string[4];
   ItemSought: ShortString;
   ItemFound: boolean;
   RequestedItemPosition: integer;
   FormattedDate: string;
begin
if (lboMemberList.ItemIndex < Low(MemberArray)) OR (lboMemberList.ItemIndex > High(MemberArray)) then
   ShowMessage('Member must be selected');
if (lboMemberList.ItemIndex >= Low(MemberArray)) AND (lboMemberList.ItemIndex <= High(MemberArray)) then
begin
if Sender = btnDeleteMember then
begin
  //Finds the location of the currently selected member
  SelectedItemIndex:= lboMemberList.ItemIndex;
  ItemSought:= MemberArray[SelectedItemIndex].MemberID;
  InsertionSortTMemberMemberID(MemberArray);
  InsertionSortTSubmissionMemberID(SubmissionArray);
  //Sorts member array by member id so it aligns with submission array
  //Finds the currently selected member location in the newly sorted array
  BinarySearchTMemberMemberID(MemberArray, ItemSought, RequestedItemPosition, ItemFound);

  //Deletes the requested member from the array
  ArrayLength := Length(MemberArray);
  for count := RequestedItemPosition + 1 to ArrayLength - 1 do
      MemberArray[count - 1] := MemberArray[count];
  SetLength(MemberArray, ArrayLength - 1);

  //Writes the new member array back to file
  rewrite(MemberFile);
  for count := 0 to Length(MemberArray) - 1 do
  begin
      SingleMember:= MemberArray[count];
      write(MemberFile, SingleMember);
  end;
  closefile(MemberFile);
  lboMemberList.Clear;

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
  InsertionSortTMemberSurname(MemberArray);

  //Adds the dates to a listbox
  for count := 0 to MemberCounter - 1 do
  begin
       lboMemberList.Items.Add(MemberArray[count].Firstname+' '+MemberArray[count].Surname);
  end;
end;
if Sender = btnEditMember then
begin
   //Fetches the currently selected member
   SelectedItemIndex:= lboMemberList.ItemIndex;
   SingleMember:= MemberArray[SelectedItemIndex];

   FromEditMember:= true;

   //Fills add member form with the selected member's properties
   frmAddMember.edtFirstName.Text:= SingleMember.FirstName;
   frmAddMember.edtSurname.Text:= SingleMember.Surname;
   frmAddMember.edtEmailAddress.Text:= SingleMember.EmailAddress;
   frmAddMember.edtTelephone.Text:= SingleMember.TelephoneNumber;
   frmAddMember.edtMemberID.Text:= SingleMember.MemberId;
   frmViewMember.Hide;
   frmAddMember.Show;
end;
end;
end;

procedure TfrmViewMember.btnFilterClick(Sender: TObject);
var
   RequestedItemPosition, TempPosition, Index, position, count: integer;
   FirstNameSought, SurnameSought: ShortString;
   ItemFound, BeenFiltered, SearchFailed: boolean;
   TempMemberArray, FilteredMemberArray: TMemberArray;
begin
{Filters the list of bookings according to the parameters input by the user}

//Initialises counters and variables
SearchFailed:= false;
BeenFiltered:= false;
SetLength(TempMemberArray, 0);
SetLength(FilteredMemberArray, 0);
RequestedItemPosition:= -1;
UnFilteredMemberArray:= MemberArray;
FilteredMemberArray:= MemberArray;

//Only allows the procedure if the booking array has data in it
if Length(MemberArray) > 0 then
begin
if (edtFirstNameFilter.Text) <> '' then
begin
     index:= 0;
     SetLength(TempMemberArray, index); //Clear temp array
     FirstNameSought:= edtFirstNameFilter.Text;

     //Sorts the table by its unique id
     InsertionSortTMemberMemberID(MemberArray);


     //Searches for the member IDs matching the first name filter
     for index := Low(MemberArray) to High(MemberArray) do
     begin
          if StartsStr(FirstNameSought, MemberArray[index].FirstName) then
          begin
               SetLength(TempMemberArray, Length(TempMemberArray)+1);
               TempMemberArray[Length(TempMemberArray)-1]:= MemberArray[index];
          end;
     end;

     if not BeenFiltered then
     begin
         FilteredMemberArray:= TempMemberArray;
         BeenFiltered:= true;
     end
     else
         SearchFailed:= true;
end;
if (edtSurnameFilter.Text) <> '' then
begin
     index:= 0;
     SetLength(TempMemberArray, index); //Clear temp array
     SurnameSought:= edtSurnameFilter.Text;

     //Sorts the tbales by their unique ids
     InsertionSortTMemberMemberID(FilteredMemberArray);

     //Searches for the member IDs matchign the first name filter
     for index := Low(FilteredMemberArray) to High(FilteredMemberArray) do
     begin
          if StartsStr(SurnameSought, FilteredMemberArray[index].Surname) then
          begin
               SetLength(TempMemberArray, Length(TempMemberArray)+1);
               TempMemberArray[Length(TempMemberArray)-1]:= MemberArray[index];
          end;
     end;

     if not BeenFiltered then
         FilteredMemberArray:= TempMemberArray
     else
     begin
         FilteredMemberArray:= frmViewBookingList.ConcatMemberArray(FilteredMemberArray, TempMemberArray);
         BeenFiltered:= true;
     end
end;
//Doesn't work if unfiltered array matches all filters
if ((FilteredMemberArray = MemberArray) and (BeenFiltered = false)) OR (SearchFailed = true) then
begin
     SetLength(FilteredMemberArray, 0);
     ShowMessage('No matches found');
end
else
    MemberArray:= FilteredMemberArray;

lbomemberList.Clear;
InsertionSortTMemberSurname(MemberArray);

//Adds the members to a listbox
for count := 0 to High(MemberArray) do
begin
     lboMemberList.Items.Add(MemberArray[count].Firstname+' '+MemberArray[count].Surname);
end;

end;
end;

procedure TfrmViewMember.btnFormatBookingsforWebClick(Sender: TObject);
begin
     frmMainMenu.btnFormatBookingsForWebClick(btnFormatBookingsForWeb);
end;

procedure TfrmViewMember.btnHomeClick(Sender: TObject);
begin
  frmViewMember.hide;
  frmMainMenu.show;
end;

procedure TfrmViewMember.btnLoginasAdminClick(Sender: TObject);
begin
     frmMainMenu.btnLoginAsAdminClick(btnLoginAsAdmin);
end;

procedure TfrmViewMember.btnResetClick(Sender: TObject);
var
   count: integer;
begin
     //Clears the filter fields and repopulates the booking list
     edtFirstNameFilter.Text:= '';
     edtSurnameFilter.Text:= '';
     MemberArray:= UnfilteredMemberArray;
     lboMemberList.Clear;
     lbomemberList.Clear;
     InsertionSortTMemberSurname(MemberArray);

     //Adds the members to a listbox
     for count := 0 to High(MemberArray) do
     begin
          lboMemberList.Items.Add(MemberArray[count].Firstname+' '+MemberArray[count].Surname);
     end;
end;

procedure TfrmViewMember.FormShow(Sender: TObject);
var
   count: integer;
   FormattedDate: string;
begin
     lboMemberList.Clear;

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
     InsertionSortTMemberSurname(MemberArray);

     //Adds the dates to a listbox
     for count := 0 to MemberCounter - 1 do
     begin
          lboMemberList.Items.Add(MemberArray[count].Firstname+' '+MemberArray[count].Surname);
     end;
end;

procedure TfrmViewMember.lboMemberListClick(Sender: TObject);
const
  // The maximum number of Tabs
  MAX_TABS = 4;
  Tab = #9;
var
   SelectedItemIndex: integer;
   Tabulators: array[0..MAX_TABS] of Integer;
begin
  //Set up the tabulators
  Tabulators[0] := 80;
  Tabulators[1] := 120;
  Tabulators[2] := 100;
  Tabulators[3] := 80;
  lboSelectedMember.TabWidth := 1;
  SendMessage(lboSelectedMember.Handle, LB_SETTABSTOPS, MAX_TABS, Longint(@Tabulators));

  //Finds the selected member name and fetches the relevant member details and displays it
  SelectedItemIndex:= lboMemberList.ItemIndex;
  lboSelectedMember.Clear;
  lboSelectedMember.Items.Add('Member ID:'+ Tab + MemberArray[SelectedItemIndex].MemberID);
  if AdminAccess = true then
  begin
       lboSelectedMember.Items.Add('Email Address:'+ Tab +MemberArray[SelectedItemIndex].EmailAddress);
       lboSelectedMember.Items.Add('Telephone Number:'+ Tab +MemberArray[SelectedItemIndex].TelephoneNumber);
  end
  else
  begin
       lboSelectedMember.Items.Add('Email Address:'+ Tab +'********');
       lboSelectedMember.Items.Add('Telephone Number:'+ Tab +'********');
       lboSelectedMember.Items.Add('');
       lboSelectedMember.Items.Add('Must login as admin to view email address and telephone number');
  end;
  lboSelectedMember.Items.Add('');
end;

end.
