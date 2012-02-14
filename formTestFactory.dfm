object frmTestFactory: TfrmTestFactory
  Left = 385
  Top = 239
  Width = 359
  Height = 336
  Caption = 'Test Factory'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 33
    Height = 13
    Caption = 'Entity *'
    Visible = False
  end
  object Label2: TLabel
    Left = 8
    Top = 88
    Width = 53
    Height = 13
    Caption = 'Stop points'
  end
  object Label3: TLabel
    Left = 144
    Top = 16
    Width = 68
    Height = 13
    Caption = 'Entities to Add'
  end
  object btnTest: TJvArrowButton
    Left = 96
    Top = 264
    Width = 57
    Height = 25
    DropDown = popTest
    Caption = 'Test'
    FillFont.Charset = DEFAULT_CHARSET
    FillFont.Color = clWindowText
    FillFont.Height = -11
    FillFont.Name = 'MS Sans Serif'
    FillFont.Style = []
    OnClick = btnTestClick
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
    OnClick = BitBtn2Click
  end
  object seEntityCount: TJvSpinEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 21
    Value = 1.000000000000000000
    TabOrder = 1
    Visible = False
  end
  object seStopPoints: TJvSpinEdit
    Left = 8
    Top = 104
    Width = 121
    Height = 21
    Value = 3.000000000000000000
    TabOrder = 2
  end
  object vstEntity: TVirtualStringTree
    Left = 144
    Top = 32
    Width = 193
    Height = 217
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
    TabOrder = 3
    Columns = <
      item
        Position = 0
        Width = 189
        WideText = 'Title'
      end>
  end
  object Button1: TButton
    Left = 8
    Top = 264
    Width = 75
    Height = 25
    Hint = 'Deletes all non essential files from the Test Factory'
    Caption = 'Clean Up'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = Button1Click
  end
  object cbScript: TCheckBox
    Left = 8
    Top = 240
    Width = 97
    Height = 17
    Caption = 'Include Script'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object btnError: TButton
    Left = 168
    Top = 264
    Width = 83
    Height = 25
    Caption = 'Show Error Log'
    TabOrder = 6
    OnClick = btnErrorClick
  end
  object JvSearchFiles1: TJvSearchFiles
    Left = 104
    Top = 152
  end
  object popTest: TPopupMenu
    Left = 224
    Top = 272
    object CopyRun1: TMenuItem
      Caption = 'Copy + Run'
      OnClick = CopyRun1Click
    end
    object UpdateRun1: TMenuItem
      Tag = 1
      Caption = 'NoCopy + Run'
      OnClick = UpdateRun1Click
    end
    object Execute1: TMenuItem
      Caption = 'Run'
      OnClick = Execute1Click
    end
  end
end
