unit AddMember;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, Menus, IniFiles;

type
  TfrmAddMember = class(TForm)
    shpHeader: TShape;
    shpBody: TShape;
    btnHome: TBitBtn;
    lblAddMember: TLabel;
    edtMemberID: TLabeledEdit;
    btnSubmit: TBitBtn;
    edtTelephone: TMaskEdit;
    lblTelephone: TLabel;
    edtFirstName: TMaskEdit;
    lblFirstName: TLabel;
    lblSurname: TLabel;
    edtSurname: TMaskEdit;
    mnmMainMenu: TMainMenu;
    mnuTools: TMenuItem;
    btnLoginasAdmin: TMenuItem;
    btnFormatBookingsforWeb: TMenuItem;
    btnCreateManualBackup: TMenuItem;
    edtEmailAddress: TMaskEdit;
    lblEmailAddress: TLabel;
    procedure btnHomeClick(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
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
  frmAddMember: TfrmAddMember;

implementation

uses Globals, MainMenu, ViewMember;

var
  NextBookingID, NextMemberID: string;

procedure InsertionSortTMemberMemberID(var List: TMemberArray); stdcall; external 'GlobalSubroutines.dll';

{$R *.dfm}

procedure TfrmAddMember.btnCreateManualBackupClick(Sender: TObject);
begin
     frmMainMenu.btnCreateManualBackupClick(btnCreateManualBackup);
end;

procedure TfrmAddMember.btnFormatBookingsforWebClick(Sender: TObject);
begin
     frmMainMenu.btnFormatBookingsForWebClick(btnFormatBookingsForWeb);
end;

procedure TfrmAddMember.btnHomeClick(Sender: TObject);
begin
  frmAddMember.hide;
  frmMainMenu.show;
end;

procedure TfrmAddMember.btnLoginasAdminClick(Sender: TObject);
begin
     frmMainMenu.btnLoginAsAdminClick(btnLoginAsAdmin);
end;

procedure TfrmAddMember.btnSubmitClick(Sender: TObject);
var
   MemberValid: boolean;
   count: SmallInt;
   ErrorMessage: string;
begin
MemberValid:= false;

//Checks that the entered email address contains an @
if edtFirstName.Text = '' then
begin
     MemberValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'First name must be entered';
end;
if edtSurname.Text = '' then
begin
     MemberValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Surname must be entered';
end;
if edtEmailAddress.Text = '' then
begin
     MemberValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Email address must be entered';
end;
if edtTelephone.Text = '     -      ' then
begin
     MemberValid:= false;
     ErrorMessage:= ErrorMessage +sLineBreak+ 'Telephone number must be entered';
end;


for count := 0 to Length(edtEmailAddress.Text) do
begin
     if edtEmailAddress.Text[count] = '@' then
         MemberValid:= true
end;
if MemberValid = false then
   ErrorMessage:= 'Email address must contain an @';

if MemberValid = true then
begin
     if FromEditMember = false then
     begin
          //Fetches unique IDs from file
          ConfigFile:= TMemIniFile.Create(ConfigDir);
          NextMemberID:= ConfigFile.ReadString('Database','NextMemberID','1');
          ConfigFile.Free;
     end;


     //Assigns the values in the input fields to the pending member submission
     SingleMember.FirstName:= edtFirstName.Text;
     SingleMember.Surname:= edtSurname.Text;
     SingleMember.EmailAddress:= edtEmailAddress.Text;
     SingleMember.TelephoneNumber:= edtTelephone.Text;

     if FromEditMember = false then
     begin
          SingleMember.MemberId:= NextMemberID;

          //Writes the member record to the file
          reset(MemberFile);
          MemberCounter:= FileSize(MemberFile);
          Seek(MemberFile, MemberCounter);
          write(MemberFile, SingleMember);
          closefile(MemberFile);

          //Increments the member ID and writes it back to file for use in the next member submission
          ConfigFile:= TMemIniFile.Create(ConfigDir);
          ConfigFile.WriteString('Database','NextMemberID',IntToStr(StrToInt(NextMemberID)+1));
          ConfigFile.UpdateFile;
          ConfigFile.Free;
     end;

     if FromEditMember = true then
     begin
          MemberArray[SelectedItemIndex]:= SingleMember;

          InsertionSortTMemberMemberID(MemberArray);

          //Rewrites the member file with the edited member record
          rewrite(MemberFile);
          for count:= Low(MemberArray) to  High(MemberArray) do
          begin
               MemberCounter:= FileSize(MemberFile);
               Seek(MemberFile, MemberCounter);
               write(MemberFile, MemberArray[count]);
          end;
          closefile(MemberFile);
     end;

     //Clears all input fields in the form for subsequent member submissions
     edtFirstName.Clear;
     edtSurname.Clear;
     edtEmailAddress.Clear;
     edtTelephone.Clear;
     edtFirstName.SetFocus;

    if FromEditMember = true then
    begin
         FromEditBooking:= false;
         frmAddMember.Hide;
         frmViewMember.Show;
    end;
end
else
    ShowMessage(ErrorMessage);
end;

procedure TfrmAddMember.FormShow(Sender: TObject);
begin
     edtFirstName.SetFocus;
end;

end.
