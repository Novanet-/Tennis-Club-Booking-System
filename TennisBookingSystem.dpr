program TennisBookingSystem;

uses
  Forms,
  IniFiles,
  Globals in 'Globals.pas',
  MainMenu in 'MainMenu.pas' {frmMainMenu},
  AddMember in 'AddMember.pas' {frmAddMember},
  AddBooking in 'AddBooking.pas' {frmAddBooking},
  ViewBookingList in 'ViewBookingList.pas' {frmViewBookingList},
  ViewBookingCalendar in 'ViewBookingCalendar.pas' {frmViewBookingCalendar},
  ViewMember in 'ViewMember.pas' {frmViewMember},
  ShareMem,
  DisplayFormattedBookings in 'DisplayFormattedBookings.pas' {frmDisplayFormattedBookings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := false;
  Application.Title := 'Tennis Club Booking System';
  Application.CreateForm(TfrmMainMenu, frmMainMenu);
  Application.CreateForm(TfrmAddMember, frmAddMember);
  Application.CreateForm(TfrmAddBooking, frmAddBooking);
  Application.CreateForm(TfrmViewBookingList, frmViewBookingList);
  Application.CreateForm(TfrmViewBookingCalendar, frmViewBookingCalendar);
  Application.CreateForm(TfrmViewMember, frmViewMember);
  Application.CreateForm(TfrmDisplayFormattedBookings, frmDisplayFormattedBookings);
  Application.Run;
end.
