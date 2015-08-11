object frmMainMenu: TfrmMainMenu
  Left = 0
  Top = 0
  Caption = 'Tennis Club Booking System'
  ClientHeight = 450
  ClientWidth = 322
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnmMainMenu
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object shpHeader: TShape
    Left = 0
    Top = 0
    Width = 332
    Height = 73
    Brush.Color = 6362432
  end
  object shpBody: TShape
    Left = 0
    Top = 72
    Width = 322
    Height = 378
    Align = alBottom
    Brush.Color = 1544758
    ExplicitWidth = 320
  end
  object lblMenuHeader: TLabel
    Left = 0
    Top = 0
    Width = 332
    Height = 73
    Alignment = taCenter
    AutoSize = False
    Caption = 'Tennis Club Booking System'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object btnAddBooking: TButton
    Left = 16
    Top = 96
    Width = 289
    Height = 57
    Caption = 'Add Booking'
    TabOrder = 0
    OnClick = btnAddBookingClick
  end
  object btnAddMember: TButton
    Left = 16
    Top = 184
    Width = 289
    Height = 57
    Caption = 'Add Member'
    TabOrder = 1
    OnClick = btnAddMemberClick
  end
  object btnViewBookings: TButton
    Left = 16
    Top = 272
    Width = 289
    Height = 57
    Caption = 'View Bookings'
    TabOrder = 2
    OnClick = btnViewBookingsClick
  end
  object btnViewMembers: TButton
    Left = 16
    Top = 360
    Width = 289
    Height = 57
    Caption = 'View Members'
    TabOrder = 3
    OnClick = btnViewMembersClick
  end
  object mnmMainMenu: TMainMenu
    Left = 16
    Top = 24
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
