object frmFormat: TfrmFormat
  Left = 312
  Top = 258
  Width = 870
  Height = 500
  Caption = 'Format Factory'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object JvSplitter1: TJvSplitter
    Left = 385
    Top = 29
    Width = 6
    Height = 444
  end
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 862
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 0
    object ToolButton4: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton4'
      ImageIndex = 0
      OnClick = ToolButton4Click
    end
    object ToolButton5: TToolButton
      Left = 23
      Top = 2
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 31
      Top = 2
      Hint = 'Save Right Text'
      Caption = 'ToolButton1'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton1Click
    end
    object ToolButton2: TToolButton
      Left = 54
      Top = 2
      Hint = 'Save Right Text As'
      Caption = 'ToolButton2'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 77
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object Edit1: TEdit
      Left = 85
      Top = 2
      Width = 450
      Height = 22
      TabStop = False
      TabOrder = 0
    end
  end
  object richOrg: TJvRichEdit
    Left = 0
    Top = 29
    Width = 385
    Height = 444
    Align = alLeft
    AllowObjects = False
    PlainText = True
    StreamFormat = sfPlainText
    StreamMode = [smNoObjects]
    TabOrder = 1
    WantTabs = True
    WordWrap = False
    OnVerticalScroll = richOrgVerticalScroll
  end
  object richModded: TJvRichEdit
    Left = 391
    Top = 29
    Width = 471
    Height = 444
    Align = alClient
    AllowObjects = False
    PlainText = True
    StreamFormat = sfPlainText
    StreamMode = [smNoObjects]
    TabOrder = 2
    WantTabs = True
    WordWrap = False
  end
  object JvSaveDialog1: TJvSaveDialog
    DefaultExt = 'txt'
    Filter = 'txt Files (*.txt)|*.txt|all Files (*.*)|*.*'
    Height = 0
    Width = 0
    Left = 600
    Top = 80
  end
  object JvOpenDialog1: TJvOpenDialog
    DefaultExt = 'txt'
    Filter = 'txt Files (*.txt)|*.txt|all Files (*.*)|*.*'
    Height = 0
    Width = 0
    Left = 520
    Top = 80
  end
end
