object frmEditor: TfrmEditor
  Left = 265
  Top = 200
  Width = 870
  Height = 500
  Caption = 'Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 862
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Hint = 'Open Text File'
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
    object tbSave: TToolButton
      Left = 31
      Top = 2
      Hint = 'Save'
      Caption = 'tbSave'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = tbSaveClick
    end
    object ToolButton5: TToolButton
      Left = 54
      Top = 2
      Hint = 'Save As'
      Caption = 'ToolButton5'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton5Click
    end
    object ToolButton4: TToolButton
      Left = 77
      Top = 2
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 85
      Top = 2
      Hint = 'Format Text'
      Caption = 'ToolButton6'
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton6Click
    end
    object ToolButton7: TToolButton
      Left = 108
      Top = 2
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton8: TToolButton
      Left = 116
      Top = 2
      Hint = 'Undo'
      Caption = 'ToolButton8'
      ImageIndex = 5
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton8Click
    end
    object ToolButton9: TToolButton
      Left = 139
      Top = 2
      Hint = 'Redo'
      Caption = 'ToolButton9'
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton9Click
    end
    object ToolButton10: TToolButton
      Left = 162
      Top = 2
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object edtFileName: TEdit
      Left = 170
      Top = 2
      Width = 400
      Height = 22
      TabStop = False
      TabOrder = 0
    end
  end
  object JvRichEdit1: TJvRichEdit
    Left = 0
    Top = 29
    Width = 862
    Height = 444
    Align = alClient
    AllowObjects = False
    AllowInPlace = False
    PlainText = True
    StreamMode = [smPlainRtf, smNoObjects]
    TabOrder = 1
    WordWrap = False
  end
end
