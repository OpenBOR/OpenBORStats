object frmStairs: TfrmStairs
  Left = 480
  Top = 224
  Width = 207
  Height = 247
  Caption = 'Stair Builder'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 7
    Height = 13
    Caption = 'X'
  end
  object Label2: TLabel
    Left = 72
    Top = 8
    Width = 7
    Height = 13
    Caption = 'Y'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 54
    Height = 13
    Caption = 'Rear Width'
  end
  object Label4: TLabel
    Left = 72
    Top = 48
    Width = 55
    Height = 13
    Caption = 'Front Width'
  end
  object Label5: TLabel
    Left = 8
    Top = 136
    Width = 42
    Height = 13
    Caption = 'Direction'
  end
  object Label6: TLabel
    Left = 8
    Top = 96
    Width = 52
    Height = 13
    Caption = 'Stair Count'
  end
  object Label7: TLabel
    Left = 136
    Top = 8
    Width = 29
    Height = 13
    Caption = 'Depth'
  end
  object Label8: TLabel
    Left = 136
    Top = 48
    Width = 31
    Height = 13
    Caption = 'Height'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 8
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 118
    Top = 184
    Width = 75
    Height = 25
    TabOrder = 9
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object spnX: TJvSpinEdit
    Left = 8
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 0
  end
  object spnY: TJvSpinEdit
    Left = 72
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 1
  end
  object spnRear: TJvSpinEdit
    Left = 8
    Top = 64
    Width = 57
    Height = 21
    TabOrder = 3
  end
  object spnFront: TJvSpinEdit
    Left = 72
    Top = 64
    Width = 57
    Height = 21
    TabOrder = 4
  end
  object cbDirection: TComboBox
    Left = 8
    Top = 152
    Width = 97
    Height = 21
    ItemHeight = 13
    TabOrder = 7
    Items.Strings = (
      'Left to Right'
      'Right to Left')
  end
  object spnCount: TJvSpinEdit
    Left = 8
    Top = 112
    Width = 57
    Height = 21
    Value = 1.000000000000000000
    TabOrder = 6
  end
  object spnDepth: TJvSpinEdit
    Left = 136
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 2
  end
  object spnHeight: TJvSpinEdit
    Left = 136
    Top = 64
    Width = 57
    Height = 21
    TabOrder = 5
  end
end
