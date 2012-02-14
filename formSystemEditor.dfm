object frmSystemEditor: TfrmSystemEditor
  Left = 332
  Top = 172
  Width = 800
  Height = 600
  Caption = 'System Editor'
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
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 582
    Top = 29
    Height = 484
    Align = alRight
    Visible = False
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
  end
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 29
    ButtonHeight = 25
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 0
    object tbSave: TToolButton
      Left = 0
      Top = 2
      Caption = 'tbSave'
      ImageIndex = 3
      OnClick = tbSaveClick
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 2
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnImportText: TButton
      Left = 31
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Import'
      TabOrder = 0
      Visible = False
      OnClick = btnImportTextClick
    end
  end
  object vstopenBorSystemList: TVirtualStringTree
    Left = 592
    Top = 29
    Width = 200
    Height = 484
    Hint = 'Bold = Has Description; Italic = Has Command;'
    Align = alRight
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Palatino Linotype'
    Font.Style = []
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.Options = [hoAutoResize, hoColumnResize, hoDrag]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    Visible = False
    OnEnter = vstopenBorSystemListEnter
    OnFocusChanged = vstopenBorSystemListFocusChanged
    OnPaintText = vstopenBorSystemListPaintText
    Columns = <
      item
        Position = 0
        Width = 196
        WideText = 'Name'
      end>
  end
  object pnlSystemEditor: TPanel
    Left = 0
    Top = 29
    Width = 582
    Height = 484
    Align = alClient
    Caption = 'pnlSystemEditor'
    TabOrder = 2
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 513
    Width = 792
    Height = 41
    Align = alBottom
    TabOrder = 3
    object btnOk: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      OnClick = btnOkClick
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 1
      OnClick = btnCancelClick
      Kind = bkCancel
    end
    object btnSave: TButton
      Left = 504
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 2
      Visible = False
      OnClick = btnSaveClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 554
    Width = 792
    Height = 19
    Panels = <
      item
        Width = 500
      end>
  end
  object PopupMenu1: TPopupMenu
    Left = 688
    Top = 240
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ExportAnimationScript1: TMenuItem
      Caption = 'Export Animation Script'
      Hint = 'Export to "data\scripts\aniscp.c"'
      object Standard: TMenuItem
        Caption = 'Standard'
        OnClick = StandardClick
      end
      object LogMode1: TMenuItem
        Caption = 'Log Mode'
        OnClick = LogMode1Click
      end
    end
  end
end
