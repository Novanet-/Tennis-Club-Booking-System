unit ViewBookingCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, DateUtils;

type
  TfrmViewBookingCalendar = class(TForm)
    clndBooking: TMonthCalendar;
    tskBookingOptions: TTaskDialog;
    mnmMainMenu: TMainMenu;
    mnuTools: TMenuItem;
    btnLoginasAdmin: TMenuItem;
    btnFormatBookingsforWeb: TMenuItem;
    btnCreateManualBackup: TMenuItem;
    mnuListView: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure clndBookingClick(Sender: TObject);
    procedure btnLoginasAdminClick(Sender: TObject);
    procedure btnFormatBookingsforWebClick(Sender: TObject);
    procedure btnCreateManualBackupClick(Sender: TObject);
    procedure mnuListViewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewBookingCalendar: TfrmViewBookingCalendar;

implementation

uses ViewBookingList, AddBooking, Globals, MainMenu;

{$R *.dfm}

procedure TfrmViewBookingCalendar.btnCreateManualBackupClick(Sender: TObject);
begin
     frmMainMenu.btnCreateManualBackupClick(btnCreateManualBackup);
end;

procedure TfrmViewBookingCalendar.btnFormatBookingsforWebClick(Sender: TObject);
begin
     frmMainMenu.btnFormatBookingsForWebClick(btnFormatBookingsForWeb);
end;

procedure TfrmViewBookingCalendar.btnLoginasAdminClick(Sender: TObject);
begin
     frmMainMenu.btnLoginAsAdminClick(btnLoginAsAdmin);
end;

procedure TfrmViewBookingCalendar.clndBookingClick(Sender: TObject);
var
   SelectedDate: TDateTime;
   FormattedDate: string;
   BookingArrayLength: integer;
begin
     SelectedDate:= clndBooking.Date;
     DateTimeToString(FormattedDate, 'dd/mm/yy', SelectedDate);
     frmViewBookingList.edtDateFilter.Text:= FormattedDate;
     //Filters the booking array with the selected date
     frmViewBookingList.btnFilterClick(clndBooking);
     BookingArrayLength:= Length(BookingArray);
     tskBookingOptions.Title:= IntToStr(BookingArrayLength) + ' Booking/s found';
     //If matches were found, enable the view bookings button, otherwise disable it
     if BookingArrayLength > 0 then
        tskBookingOptions.Buttons[1].Enabled:= true
     else
        tskBookingOptions.Buttons[1].Enabled:= false;
     //If selected date is less than the current date, disabel add booking button, otherwise enable it
     if clndBooking.Date < Date then
        tskBookingOptions.Buttons[0].Enabled:= false
     else
        tskBookingOptions.Buttons[0].Enabled:= true;
     //Brings up a dialog showing the no. of bookings found and asking the user if they want to add a booking at that datee or view the matches
     tskBookingOptions.Execute;
     case tskBookingOptions.ModalResult of
          100: begin
                    //Shows add booking form with selected date entered
                    FromCalendar:= true;
                    frmAddBooking.Show;
                    frmAddBooking.dtpDate.Date:= SelectedDate;
                    frmViewBookingCalendar.Hide
               end;
          101: begin
                    //Shows filtered list of bookings
                    FromCalendar:= true;
                    frmViewBookingList.Show;
                    frmViewBookingCalendar.Hide
               end;
          mrCancel: frmViewBookingList.InitBookingList(frmViewBookingList.lboBookingList); //Repopulates booking array
     end;
end;

procedure TfrmViewBookingCalendar.FormCreate(Sender: TObject);
begin
     clndBooking.MinDate:= IncDay(Date, -7); //Sets minimum date to the current date
end;

procedure TfrmViewBookingCalendar.mnuListViewClick(Sender: TObject);
begin
  frmViewBookingCalendar.hide;
  frmViewBookingList.show;
end;

end.
