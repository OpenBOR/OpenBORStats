object frmFndFileVst: TfrmFndFileVst
  Left = 276
  Top = 200
  Width = 870
  Height = 500
  Caption = 'File Checker'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    862
    473)
  PixelsPerInch = 96
  TextHeight = 13
  object vstFndFileVst: TVirtualStringTree
    Left = 8
    Top = 40
    Width = 841
    Height = 433
    Anchors = [akLeft, akTop, akRight, akBottom]
    Header.AutoSizeIndex = 2
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = 2
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag, hoVisible]
    PopupMenu = popFiles
    TabOrder = 0
    OnDblClick = vstFndFileVstDblClick
    OnPaintText = vstFndFileVstPaintText
    Columns = <
      item
        MaxWidth = 50
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 0
        WideText = 'Id'
      end
      item
        MaxWidth = 100
        Position = 1
        WideText = 'Selected'
      end
      item
        MinWidth = 400
        Position = 2
        Width = 667
        WideText = 'FullName'
      end
      item
        MinWidth = 70
        Position = 3
        Width = 70
        WideText = 'FromFile'
      end
      item
        MinWidth = 30
        Position = 4
        WideText = 'InUse'
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 454
    Width = 862
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end>
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Move Checked Files'
    TabOrder = 2
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 153
    Top = 14
    Width = 97
    Height = 17
    Caption = 'Move'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object popFiles: TPopupMenu
    Left = 312
    Top = 312
    object Check1: TMenuItem
      Caption = 'Check Selected'
      OnClick = Check1Click
    end
    object UnCheck1: TMenuItem
      Caption = 'UnCheck Selected'
      OnClick = UnCheck1Click
    end
  end
  object JvBrowseForFolderDialog1: TJvBrowseForFolderDialog
    Left = 248
    Top = 8
  end
end
