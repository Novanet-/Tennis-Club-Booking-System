object frmAddBooking: TfrmAddBooking
  Left = 0
  Top = 0
  Caption = 'frmAddBooking'
  ClientHeight = 447
  ClientWidth = 717
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnmMainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    717
    447)
  PixelsPerInch = 96
  TextHeight = 13
  object shpBody: TShape
    Left = -9
    Top = 80
    Width = 729
    Height = 376
    Brush.Color = 1544758
  end
  object shpHeader: TShape
    Left = 0
    Top = 0
    Width = 729
    Height = 81
    Brush.Color = 6362432
  end
  object lblAddBooking: TLabel
    Left = 0
    Top = 1
    Width = 709
    Height = 80
    Align = alCustom
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Add Booking'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 720
  end
  object lblCourtsNeeded: TLabel
    Left = 360
    Top = 302
    Width = 131
    Height = 18
    Alignment = taRightJustify
    Anchors = [akLeft]
    AutoSize = False
    Caption = 'Courts Needed'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ExplicitTop = 303
  end
  object lblDate: TLabel
    Left = 48
    Top = 140
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
  object lblTypeOfEvent: TLabel
    Left = 8
    Top = 384
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
  object lblTime: TLabel
    Left = 48
    Top = 220
    Width = 25
    Height = 13
    Caption = 'Time'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblMemberName: TLabel
    Left = 413
    Top = 140
    Width = 78
    Height = 13
    Caption = 'Member Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDuration: TLabel
    Left = 26
    Top = 303
    Width = 46
    Height = 13
    Caption = 'Duration'
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
    TabOrder = 7
    OnClick = btnHomeClick
  end
  object edtMemberID: TLabeledEdit
    Left = 497
    Top = 220
    Width = 48
    Height = 21
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = 'Member ID'
    EditLabel.Font.Charset = ANSI_CHARSET
    EditLabel.Font.Color = clWhite
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'Segoe UI'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    LabelPosition = lpLeft
    LabelSpacing = 10
    ReadOnly = True
    TabOrder = 8
  end
  object chkCourtsNeeded: TCheckListBox
    Left = 497
    Top = 300
    Width = 128
    Height = 110
    ItemHeight = 13
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8')
    TabOrder = 5
  end
  object btnSubmit: TBitBtn
    Left = 320
    Top = 401
    Width = 129
    Height = 41
    Caption = 'Submit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btnSubmitClick
  end
  object cmbTypeofEvent: TComboBox
    Left = 88
    Top = 380
    Width = 185
    Height = 21
    ItemHeight = 13
    TabOrder = 3
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
  object cmbMemberName: TComboBox
    Left = 497
    Top = 140
    Width = 161
    Height = 21
    ItemHeight = 0
    TabOrder = 4
    OnSelect = cmbMemberNameSelect
  end
  object dtpDate: TDateTimePicker
    Left = 88
    Top = 140
    Width = 99
    Height = 21
    Date = 0.452974780091608400
    Time = 0.452974780091608400
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnChange = dtpDateChange
  end
  object dtpTime: TDateTimePicker
    Left = 88
    Top = 217
    Width = 57
    Height = 24
    Date = 41656.000000000000000000
    Format = 'HH:mm'
    Time = 41656.000000000000000000
    Kind = dtkTime
    TabOrder = 1
  end
  object edtDuration: TMaskEdit
    Left = 88
    Top = 300
    Width = 24
    Height = 21
    EditMask = '999;0;_'
    MaxLength = 3
    TabOrder = 2
  end
  object mnmMainMenu: TMainMenu
    Left = 624
    Top = 32
    object mnuTools: TMenuItem
      Caption = 'Tools'
      object btnLoginasAdmin: TMenuItem
        Caption = 'Login as Admin'
        OnClick = btnLoginasAdminClick
      end
      object btnFormatBookingsForWeb: TMenuItem
        Caption = 'Format Bookings for Web'
        OnClick = btnFormatBookingsForWebClick
      end
      object btnCreateManualBackup: TMenuItem
        Caption = 'Create Manual Backup'
        OnClick = btnCreateManualBackupClick
      end
    end
  end
end
