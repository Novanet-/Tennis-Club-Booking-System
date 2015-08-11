object frmAddMember: TfrmAddMember
  Left = 0
  Top = 0
  Caption = 'frmAddMember'
  ClientHeight = 429
  ClientWidth = 718
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
    Left = -1
    Top = 81
    Width = 729
    Height = 376
    Brush.Color = 1544758
  end
  object lblAddMember: TLabel
    Left = 8
    Top = -1
    Width = 710
    Height = 82
    Align = alCustom
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Add Member'
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
  object lblTelephone: TLabel
    Left = 358
    Top = 143
    Width = 101
    Height = 13
    Alignment = taRightJustify
    Caption = 'Telephone Number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblFirstName: TLabel
    Left = 59
    Top = 143
    Width = 56
    Height = 13
    Alignment = taRightJustify
    Caption = 'First Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSurname: TLabel
    Left = 69
    Top = 223
    Width = 46
    Height = 13
    Alignment = taRightJustify
    Caption = 'Surname'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblEmailAddress: TLabel
    Left = 42
    Top = 303
    Width = 73
    Height = 13
    Alignment = taRightJustify
    Caption = 'Email Address'
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
    TabOrder = 5
    OnClick = btnHomeClick
  end
  object edtMemberID: TLabeledEdit
    Left = 465
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
    TabOrder = 6
  end
  object btnSubmit: TBitBtn
    Left = 258
    Top = 360
    Width = 201
    Height = 57
    Caption = 'Submit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnSubmitClick
  end
  object edtTelephone: TMaskEdit
    Left = 465
    Top = 140
    Width = 185
    Height = 21
    EditMask = '!00000-000000;1; '
    MaxLength = 12
    TabOrder = 3
    Text = '     -      '
  end
  object edtFirstName: TMaskEdit
    Left = 121
    Top = 140
    Width = 183
    Height = 21
    EditMask = '>L<llllllllllllllllllll;0; '
    MaxLength = 21
    TabOrder = 0
  end
  object edtSurname: TMaskEdit
    Left = 121
    Top = 220
    Width = 183
    Height = 21
    EditMask = '>L<llllllllllllllllllll;0; '
    MaxLength = 21
    TabOrder = 1
  end
  object edtEmailAddress: TMaskEdit
    Left = 121
    Top = 300
    Width = 179
    Height = 21
    EditMask = 'cccccccccccccccccccccccccccccc;0; '
    MaxLength = 30
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
