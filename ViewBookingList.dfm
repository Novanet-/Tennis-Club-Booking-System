object frmViewBookingList: TfrmViewBookingList
  Left = 0
  Top = 0
  Caption = 'frmViewBookingList'
  ClientHeight = 477
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnmMainMenu
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object shpBody: TShape
    Left = -1
    Top = 0
    Width = 762
    Height = 105
    Brush.Color = 6362432
  end
  object shpHeader: TShape
    Left = -1
    Top = 80
    Width = 762
    Height = 401
    Brush.Color = 1544758
  end
  object lblBookingList: TLabel
    Left = 32
    Top = 111
    Width = 241
    Height = 17
    AutoSize = False
    Caption = 'Booking List'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSelectedBooking: TLabel
    Left = 366
    Top = 111
    Width = 241
    Height = 17
    AutoSize = False
    Caption = 'Selected Booking'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblViewBookingList: TLabel
    Left = 2
    Top = 0
    Width = 758
    Height = 81
    Align = alCustom
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'View Bookings'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 759
  end
  object lblFilters: TLabel
    Left = 32
    Top = 303
    Width = 73
    Height = 17
    AutoSize = False
    Caption = 'Filters'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblDate: TLabel
    Left = 81
    Top = 326
    Width = 24
    Height = 13
    Caption = 'Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCourtsNeededFilter: TLabel
    Left = 32
    Top = 364
    Width = 73
    Height = 13
    Caption = 'Court Needed'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTypeOfEvent: TLabel
    Left = 32
    Top = 407
    Width = 72
    Height = 13
    Caption = 'Type Of Event'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNameFilter: TLabel
    Left = 2
    Top = 448
    Width = 102
    Height = 13
    Caption = 'Firstname/Surname'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnHome: TBitBtn
    Left = 8
    Top = 8
    Width = 97
    Height = 49
    Caption = 'Home'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnHomeClick
  end
  object lboBookingList: TListBox
    Left = 32
    Top = 134
    Width = 241
    Height = 153
    ItemHeight = 13
    TabOrder = 1
    OnClick = lboBookingListClick
  end
  object lboSelectedBooking: TListBox
    Left = 366
    Top = 134
    Width = 379
    Height = 249
    ItemHeight = 13
    TabOrder = 2
    OnClick = btnHomeClick
  end
  object btnEditBooking: TBitBtn
    Left = 366
    Top = 412
    Width = 105
    Height = 49
    Caption = 'Edit Booking'
    TabOrder = 3
    OnClick = btnDeleteBookingClick
  end
  object btnDeleteBooking: TBitBtn
    Left = 640
    Top = 412
    Width = 105
    Height = 49
    Caption = 'Delete Booking'
    TabOrder = 4
    OnClick = btnDeleteBookingClick
  end
  object btnCalendarView: TBitBtn
    Left = 640
    Top = 8
    Width = 105
    Height = 49
    Caption = 'Calendar View'
    TabOrder = 5
    OnClick = btnCalendarViewClick
  end
  object edtDateFilter: TMaskEdit
    Left = 120
    Top = 323
    Width = 72
    Height = 21
    EditMask = '!99/99/00;1;_'
    MaxLength = 8
    TabOrder = 6
    Text = '  /  /  '
  end
  object cmbCourtNeededFilter: TComboBox
    Left = 120
    Top = 361
    Width = 89
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8')
  end
  object cmbTypeOfEventFilter: TComboBox
    Left = 120
    Top = 404
    Width = 185
    Height = 21
    ItemHeight = 13
    TabOrder = 8
    Items.Strings = (
      'Club Championship'
      'Club Mix-in'
      'Coaching Session'
      'Court Renovations'
      'League Matches'
      'LTA Tournament'
      'Postal Match'
      'School Booking'
      'Team Practise')
  end
  object edtFirstNameFilter: TEdit
    Left = 120
    Top = 445
    Width = 97
    Height = 21
    TabOrder = 9
  end
  object edtSurnameFilter: TEdit
    Left = 223
    Top = 445
    Width = 121
    Height = 21
    TabOrder = 10
  end
  object btnFilter: TButton
    Left = 247
    Top = 323
    Width = 97
    Height = 30
    Caption = 'Filter'
    TabOrder = 11
    OnClick = btnFilterClick
  end
  object btnReset: TButton
    Left = 296
    Top = 368
    Width = 48
    Height = 30
    Caption = 'Reset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = btnResetClick
  end
  object mnmMainMenu: TMainMenu
    Left = 552
    Top = 32
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
  end
end
