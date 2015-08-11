object frmViewMember: TfrmViewMember
  Left = 0
  Top = 0
  Caption = 'frmViewMember'
  ClientHeight = 450
  ClientWidth = 719
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
  object shpHeader: TShape
    Left = -1
    Top = 0
    Width = 729
    Height = 81
    Brush.Color = 6362432
  end
  object shpBody: TShape
    Left = 0
    Top = 80
    Width = 729
    Height = 383
    Brush.Color = 1544758
  end
  object lblViewMember: TLabel
    Left = 0
    Top = 0
    Width = 719
    Height = 81
    Align = alCustom
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'View Member'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    ExplicitWidth = 728
  end
  object lblMemberList: TLabel
    Left = 24
    Top = 102
    Width = 241
    Height = 17
    AutoSize = False
    Caption = 'Member List'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSelectedMember: TLabel
    Left = 325
    Top = 102
    Width = 241
    Height = 17
    AutoSize = False
    Caption = 'Selected Member'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblFirstNameFilter: TLabel
    Left = 24
    Top = 342
    Width = 51
    Height = 13
    Caption = 'Firstname'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblFilters: TLabel
    Left = 24
    Top = 319
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
  object lblSurnameFilter: TLabel
    Left = 24
    Top = 368
    Width = 46
    Height = 13
    Caption = 'Surname'
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
  object lboMemberList: TListBox
    Left = 24
    Top = 125
    Width = 241
    Height = 188
    ItemHeight = 13
    TabOrder = 1
    OnClick = lboMemberListClick
  end
  object lboSelectedMember: TListBox
    Left = 325
    Top = 125
    Width = 379
    Height = 249
    ItemHeight = 13
    TabOrder = 2
    OnClick = btnHomeClick
  end
  object btnEditMember: TBitBtn
    Left = 325
    Top = 393
    Width = 105
    Height = 49
    Caption = 'Edit Member'
    TabOrder = 3
    OnClick = btnDeleteMemberClick
  end
  object btnDeleteMember: TBitBtn
    Left = 599
    Top = 393
    Width = 105
    Height = 49
    Caption = 'Delete Member'
    TabOrder = 4
    OnClick = btnDeleteMemberClick
  end
  object edtFirstNameFilter: TEdit
    Left = 133
    Top = 341
    Width = 97
    Height = 21
    TabOrder = 5
  end
  object edtSurnameFilter: TEdit
    Left = 133
    Top = 368
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object btnFilter: TButton
    Left = 24
    Top = 416
    Width = 97
    Height = 30
    Caption = 'Filter'
    TabOrder = 7
    OnClick = btnFilterClick
  end
  object btnReset: TButton
    Left = 206
    Top = 416
    Width = 48
    Height = 30
    Caption = 'Reset'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnResetClick
  end
  object mnmMainMenu: TMainMenu
    Left = 632
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
