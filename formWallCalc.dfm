object frmWallCalc: TfrmWallCalc
  Left = 192
  Top = 107
  Width = 362
  Height = 224
  Caption = 'WallCalc'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 332
    Height = 13
    Caption = 
      'Sane Syntax: enter x,y of topleft, bottomleft, topright, bottomr' +
      'ight points'
  end
  object edtSane: TEdit
    Left = 16
    Top = 32
    Width = 265
    Height = 25
    TabOrder = 0
    Text = '100,105 100,200 200,105 200,200'
  end
  object edtBor: TEdit
    Left = 16
    Top = 104
    Width = 265
    Height = 21
    TabOrder = 1
    Text = 'edtBor'
  end
  object btnSane2Bor: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'btnSane2Bor'
    TabOrder = 2
    OnClick = btnSane2BorClick
  end
  object btnBor2Sane: TButton
    Left = 16
    Top = 136
    Width = 75
    Height = 25
    Caption = 'btnBor2Sane'
    TabOrder = 3
  end
end
