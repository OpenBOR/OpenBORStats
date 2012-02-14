object frmImport: TfrmImport
  Left = 335
  Top = 202
  Width = 560
  Height = 424
  Caption = 'Import'
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
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 552
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Hint = 'Select Import Directory'
      Caption = 'ToolButton1'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton3: TToolButton
      Left = 31
      Top = 2
      Caption = 'ToolButton3'
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton3Click
    end
    object ToolButton4: TToolButton
      Left = 54
      Top = 2
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ProgressBar1: TProgressBar
      Left = 62
      Top = 2
      Width = 150
      Height = 22
      TabOrder = 0
    end
  end
  object vstImport: TVirtualStringTree
    Left = 0
    Top = 29
    Width = 552
    Height = 349
    Align = alClient
    CheckImageKind = ckXP
    Header.AutoSizeIndex = 1
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = 1
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    PopupMenu = popImport
    TabOrder = 1
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
    TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toMultiSelect, toRightClickSelect]
    OnChecked = vstImportChecked
    OnPaintText = vstImportPaintText
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 0
        WideText = 'id'
      end
      item
        Position = 1
        Width = 200
        WideText = 'airFile'
      end
      item
        Position = 2
        Width = 100
        WideText = 'hasSffFile'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark]
        Position = 3
        Width = 100
        WideText = 'Checked'
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 378
    Width = 552
    Height = 19
    Panels = <
      item
        Text = 'Give credit where credit is due when importing characters!'
        Width = 250
      end>
  end
  object popImport: TPopupMenu
    Left = 376
    Top = 184
    object CheckAll1: TMenuItem
      Caption = 'Check All'
      OnClick = CheckAll1Click
    end
    object UnCheckAll1: TMenuItem
      Caption = 'UnCheck All'
      OnClick = UnCheckAll1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CheckSelected1: TMenuItem
      Caption = 'Check Selected'
      OnClick = CheckSelected1Click
    end
    object UnCheckSelected1: TMenuItem
      Caption = 'UnCheck Selected'
      OnClick = UnCheckSelected1Click
    end
  end
end
