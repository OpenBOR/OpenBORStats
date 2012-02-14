object frmLevelDesign: TfrmLevelDesign
  Left = 296
  Top = 212
  Width = 870
  Height = 500
  Caption = 'Level Design'
  Color = clBtnFace
  DockSite = True
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 0
    Top = 204
    Width = 862
    Height = 10
    Cursor = crVSplit
    Align = alBottom
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
  end
  object pnlEditor: TPanel
    Left = 0
    Top = 29
    Width = 862
    Height = 175
    Align = alClient
    TabOrder = 0
  end
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 862
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 1
    object btnSave: TToolButton
      Left = 0
      Top = 2
      Hint = 'Save'
      Caption = 'btnSave'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = btnSaveClick
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Hint = 'Reload'
      Caption = 'ToolButton2'
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 46
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object cbBack: TCheckBox
      Left = 54
      Top = 2
      Width = 83
      Height = 22
      Caption = 'Background'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object cbPanel: TCheckBox
      Left = 137
      Top = 2
      Width = 56
      Height = 22
      Caption = 'Panels'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object Entities: TCheckBox
      Left = 193
      Top = 2
      Width = 56
      Height = 22
      Caption = 'Entities'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
    object cbFront: TCheckBox
      Left = 249
      Top = 2
      Width = 48
      Height = 22
      Caption = 'Front'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object cbHoles: TCheckBox
      Left = 297
      Top = 2
      Width = 87
      Height = 22
      Caption = 'Holes/Walls'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object cbEntities: TComboBox
      Left = 384
      Top = 2
      Width = 104
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Visible = False
    end
    object cbFocus: TCheckBox
      Left = 488
      Top = 2
      Width = 97
      Height = 22
      Caption = 'Focus Glossary'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = cbFocusClick
    end
    object ProgressBar1: TProgressBar
      Left = 585
      Top = 2
      Width = 150
      Height = 22
      TabOrder = 7
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 454
    Width = 862
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
  end
  object sblevel: TJvgScrollBox
    Left = 0
    Top = 214
    Width = 862
    Height = 240
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alBottom
    DragCursor = crHandPoint
    DragMode = dmAutomatic
    TabOrder = 3
    OnDragDrop = sblevelDragDrop
    OnMouseMove = sblevelMouseMove
    BufferedDraw = True
    object pnlLevel: TPanel
      Left = 0
      Top = 0
      Width = 41
      Height = 41
      DragMode = dmAutomatic
      TabOrder = 0
    end
    object JvPanel1: TJvPanel
      Left = 368
      Top = 72
      Width = 185
      Height = 41
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      OnPaint = JvPanel1Paint
      Caption = 'JvPanel1'
      PopupMenu = popLevel
      TabOrder = 1
      Visible = False
      OnDragDrop = JvPanel1DragDrop
      OnDragOver = JvPanel1DragOver
      OnMouseMove = JvPanel1MouseMove
    end
  end
  object popLevel: TPopupMenu
    Left = 104
    Top = 254
    object StaircaseBuilder1: TMenuItem
      Caption = 'Staircase Builder'
      OnClick = StaircaseBuilder1Click
    end
  end
end
