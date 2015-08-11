object frmViewBookingCalendar: TfrmViewBookingCalendar
  Left = 0
  Top = 0
  Caption = 'frmViewBookingCalendar'
  ClientHeight = 431
  ClientWidth = 967
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnmMainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object clndBooking: TMonthCalendar
    Left = -8
    Top = -9
    Width = 985
    Height = 449
    Date = 41650.441890949070000000
    TabOrder = 0
    WeekNumbers = True
    OnClick = clndBookingClick
  end
  object tskBookingOptions: TTaskDialog
    Buttons = <
      item
        Caption = 'Add Booking'
        ModalResult = 100
      end
      item
        Caption = 'View Booking/s'
        ModalResult = 101
      end>
    Caption = 'Booking Options'
    CommonButtons = [tcbCancel]
    RadioButtons = <>
    Text = 'What would you like to do?'
    Title = 'Bookings Found'
    Left = 544
    Top = 400
  end
  object mnmMainMenu: TMainMenu
    Left = 392
    Top = 400
    object mnuTools: TMenuItem
      Caption = 'Tools'
      object btnLoginasAdmin: TMenuItem
        Caption = 'Login as Admin'
        OnClick = btnLoginasAdminClick
      end
      object btnFormatBookingsforWeb: TMenuItem
        Caption = 'Format Bookings for Web'
        OnClick = btnFormatBookingsforWebClick
      end
      object btnCreateManualBackup: TMenuItem
        Caption = 'Create Manual Backup'
        OnClick = btnCreateManualBackupClick
      end
    end
    object mnuListView: TMenuItem
      Caption = 'List View'
      OnClick = mnuListViewClick
    end
  end
end
