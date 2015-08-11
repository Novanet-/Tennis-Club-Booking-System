object frmSearchBooking: TfrmSearchBooking
  Left = 0
  Top = 0
  Caption = 'frmSearchBooking'
  ClientHeight = 450
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object shpHeader: TShape
    Left = -1
    Top = 0
    Width = 729
    Height = 105
    Brush.Color = 6362432
  end
  object shpBody: TShape
    Left = -1
    Top = 104
    Width = 729
    Height = 345
    Brush.Color = 1544758
  end
  object lblSearchBooking: TLabel
    Left = 200
    Top = 0
    Width = 338
    Height = 108
    Align = alCustom
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Search Booking'
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
end
