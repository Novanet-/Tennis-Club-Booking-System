unit MainMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, IniFiles;

type
  TfrmMainMenu = class(TForm)
    lblMenuHeader: TLabel;
    btnAddBooking: TButton;
    btnAddMember: TButton;
    btnViewBookings: TButton;
    btnViewMembers: TButton;
    shpBody: TShape;
    shpHeader: TShape;
    mnmMainMenu: TMainMenu;
    mnuTools: TMenuItem;
    btnLoginasAdmin: TMenuItem;
    btnFormatBookingsforWeb: TMenuItem;
    btnCreateManualBackup: TMenuItem;
    procedure btnAddBookingClick(Sender: TObject);
    procedure btnAddMemberClick(Sender: TObject);
    procedure btnViewBookingsClick(Sender: TObject);
    procedure btnViewMembersClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);                  
    procedure FormShow(Sender: TObject);
    procedure btnLoginasAdminClick(Sender: TObject);
    procedure btnFormatBookingsforWebClick(Sender: TObject);
    procedure btnCreateManualBackupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

uses Globals, AddBooking, AddMember, ViewBookingList, ViewMember, DisplayFormattedBookings;

procedure InsertionSortTBookingBookingID(var List: TBookingArray); stdcall; external 'GlobalSubroutines.dll';
procedure InsertionSortTSubmissionBookingID(var List: TSubmissionArray); stdcall; external 'GlobalSubroutines.dll';

{$R *.dfm}

procedure TfrmMainMenu.btnAddBookingClick(Sender: TObject);
begin
  frmMainMenu.hide;
  frmAddBooking.show;
end;

procedure TfrmMainMenu.btnAddMemberClick(Sender: TObject);
begin
  frmMainMenu.Hide;
  frmAddMember.show;
end;

procedure TfrmMainMenu.btnCreateManualBackupClick(Sender: TObject);
var
   CurrentDir, TempDir: string;
begin
  //Copies the 3 database tables from /db to /backup
  CurrentDir:= GetCurrentDir;
  TempDir:= CurrentDir+'/backup/tblBookings.dat';
  CopyFile(PChar(CurrentDir+'/db/tblBookings.dat'), PChar(TempDir), false);
  TempDir:= CurrentDir+'/backup/tblSubmissions.dat';
  CopyFile(PChar(CurrentDir+'/db/tblSubmissions.dat'), PChar(TempDir), false);
  TempDir:= CurrentDir+'/backup/tblMembers.dat';
  CopyFile(PChar(CurrentDir+'/db/tblMembers.dat'), PChar(TempDir), false);
  //Updates the last backup date in the config file
  LastBackup:= Date;
  ConfigFile:= TMemIniFile.Create(ConfigDir);
  ConfigFile.WriteDate('Backup','LastBackupDate',LastBackup);
  ConfigFile.UpdateFile;
  ConfigFIle.Free;
  if not (Sender = frmMainMenu) then
     ShowMessage('Backup created');
end;

procedure TfrmMainMenu.btnFormatBookingsforWebClick(Sender: TObject);
var
   Position: integer;
   FormattedDate, FormattedTime: string;
   ItemFound: boolean;
begin
  frmDisplayFormattedBookings.edtFormattedBookings.Clear;
  //Formats the currently stored bookings into the table format that the club website uses
  frmDisplayFormattedBookings.edtFormattedBookings.Lines.Add('[table]');
  //Header row
  frmDisplayFormattedBookings.edtFormattedBookings.Lines.Add('[row][cell]Date[/cell][cell]Time[/cell][cell]Duration(minutes)[/cell][cell]Court/s[/cell][cell]Member[/cell][/row]');
  frmViewBookingList.InitBookingList(frmViewBookingList.lboBookingList);
  //Content rows
  for Position := Low(BookingArray) to High(BookingArray) do
  begin
      SingleMember:= frmViewBookingList.FetchRelatedMember(BookingArray[Position], ItemFound);
      if ItemFound then
      begin
         DateTimeToString(FormattedDate,'ddd d mmmm',BookingArray[Position].Date);
         DateTimeToString(FormattedTime,'hh:mmam/pm',BookingArray[Position].Time);
         frmDisplayFormattedBookings.edtFormattedBookings.Lines.Add('[row][cell]'+FormattedDate+'[/cell][cell]'+FormattedTime+'[/cell][cell]'+IntToStr(BookingArray[Position].Duration)+'[/cell][cell]'+IntToStr(BookingArray[Position].CourtNo)+'[/cell][cell]'+SingleMember.FirstName+'[/cell][/row]');
      end;
  end;
  frmDisplayFormattedBookings.edtFormattedBookings.Lines.Add('[/table]');
  frmDisplayFormattedBookings.Show;
end;

procedure TfrmMainMenu.btnViewBookingsClick(Sender: TObject);
begin
  frmMainMenu.hide;
  frmViewBookingList.Show;
end;

procedure TfrmMainMenu.btnViewMembersClick(Sender: TObject);
begin
  frmMainMenu.Hide;
  frmViewMember.Show;
end;

procedure TfrmMainMenu.FormCreate(Sender: TObject);
var
  CurrentDir, PrevDir: string;
  DayDifference: TDateTime;
begin
  Application.Title := 'Tennis Club Booking System';
  ShortDateFormat:= 'dd/mm/yy';
  FromEditBooking:= false;
  FromEditMember:= false;
  FromCalendar:= false;
  AdminAccess:= false;
  CurrentDir:= GetCurrentDir;

  //Creates all required directories if they don't already exist
  if not DirectoryExists('backup') then
     CreateDir('backup');
  if not DirectoryExists('db') then
     CreateDir('db');
  if not DirectoryExists('cfg') then
     CreateDir('cfg');
  //Check that the required libraries are in the program directory
  if not FileExists('GlobalSubroutines.dll') then
     ShowMessage('Missing GlobalSubroutines.dll, program will not function properly');
  if not FileExists('borlndmm.dll') then
     ShowMessage('Missing borlndmm.dll, program will not function properly');

  //Assigns tables of the database to respective directories/files in windows
  ConfigDir:= (CurrentDir + '\cfg');
  DatabaseDir:= (CurrentDir + '\db');
  BookingDir:= (DatabaseDir + '\tblBookings.dat');
  SubmissionDir:= (DatabaseDir + '\tblSubmissions.dat');
  MemberDir:= (DatabaseDir + '\tblMembers.dat');
  ConfigDir:= (ConfigDir + '\Config.ini');

  //Creates database files if they don't already exists
  //If a database file doesn't exist then recreates the id counters to keep the databse structure correct
  AssignFile(BookingFile, BookingDir);
  AssignFile(SubmissionFile, SubmissionDir);
  AssignFile(MemberFile, MemberDir);
  PrevDir:= CurrentDir;
  SetCurrentDir(PrevDir + '\db');
  if not FileExists('tblBookings.dat') then
  begin
    rewrite(BookingFile);
    closefile(BookingFile);
    ConfigFile:= TMemIniFile.Create(ConfigDir);
    ConfigFile.WriteString('Database','NextBookingID','1');
    ConfigFile.WriteString('Database','NextMemberID','1');
    ConfigFile.WriteDate('Backup','LastBackupDate',Date);
    ConfigFile.UpdateFile;
    ConfigFile.Free;
  end;
  if not FileExists('tblSubmissions.dat') then
  begin
    rewrite(SubmissionFile);
    closefile(SubmissionFile);
    ConfigFile:= TMemIniFile.Create(ConfigDir);
    ConfigFile.WriteString('Database','NextBookingID','1');
    ConfigFile.WriteString('Database','NextMemberID','1');
    ConfigFile.WriteDate('Backup','LastBackupDate',Date);
    ConfigFile.UpdateFile;
    ConfigFile.Free;
  end;
  if not FileExists('tblMembers.dat') then
  begin
    rewrite(MemberFile);
    closefile(MemberFile);
    ConfigFile:= TMemIniFile.Create(ConfigDir);
    ConfigFile.WriteString('Database','NextBookingID','1');
    ConfigFile.WriteString('Database','NextMemberID','1');
    ConfigFile.WriteDate('Backup','LastBackupDate',Date);
    ConfigFile.UpdateFile;
    ConfigFile.Free;
  end;
  SetCurrentDir(PrevDir + '\cfg');
  if not FileExists('config.ini') then
  begin
    ConfigFile:= TMemIniFile.Create(ConfigDir);
    ConfigFile.WriteString('Database','NextBookingID','1');
    ConfigFile.WriteString('Database','NextMemberID','1');
    ConfigFile.WriteDate('Backup','LastBackupDate',Date);
    ConfigFile.UpdateFile;
    ConfigFile.Free;
  end;
  SetCurrentDir(PrevDir);

  //If the last backup date more than 7 days before the current date, creates a backup
  ConfigFile:= TMemIniFile.Create(ConfigDir);
  LastBackup:= ConfigFile.ReadDate('Backup','LastBackupDate',Date);
  DayDifference := Date - LastBackup;
  if DayDifference >= 7 then
     btnCreateManualBackupClick(frmMainMenu);
end;

procedure TfrmMainMenu.FormShow(Sender: TObject);
begin
  Application.Title := 'Tennis Club Booking System';
end;

procedure TfrmMainMenu.btnLoginasAdminClick(Sender: TObject);
var
   EnteredPassword: string;
begin
     //Dialog box to allow the user acces to members' email addresses and telephone numbers
     InputQuery('Admin Login','Enter admin password',EnteredPassword);
     if EnteredPassword = 'rltc123admin' then
        AdminAccess:= true
     else
        ShowMessage('Incorrect password');
end;

end.
