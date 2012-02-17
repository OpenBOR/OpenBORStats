object frmEditorSyn: TfrmEditorSyn
  Left = 0
  Top = 0
  Width = 549
  Height = 386
  TabOrder = 0
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 358
    Top = 29
    Height = 357
    Align = alRight
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
  end
  object pnlEditor: TJvPanel
    Left = 0
    Top = 29
    Width = 358
    Height = 357
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Align = alClient
    TabOrder = 0
    object JvNetscapeSplitter2: TJvNetscapeSplitter
      Left = 1
      Top = 222
      Width = 356
      Height = 10
      Cursor = crVSplit
      Align = alBottom
      MinSize = 1
      Maximized = False
      Minimized = False
      ButtonCursor = crDefault
    end
    object SynEdit1: TSynEdit
      Left = 1
      Top = 1
      Width = 356
      Height = 221
      Align = alClient
      ActiveLineColor = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      TabOrder = 0
      OnClick = SynEdit1Click
      OnDblClick = SynEdit1DblClick
      OnEnter = SynEdit1Enter
      OnKeyUp = SynEdit1KeyUp
      Gutter.AutoSize = True
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.LeadingZeros = True
      Gutter.ShowLineNumbers = True
      Gutter.ZeroStart = True
      Gutter.Gradient = True
      Gutter.GradientEndColor = clHighlight
      Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTrimTrailingSpaces]
      SearchEngine = SynEditSearch1
      WantTabs = True
      OnChange = SynEdit1Change
    end
    object sbGifList: TJvgScrollBox
      Left = 1
      Top = 232
      Width = 356
      Height = 124
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      Align = alBottom
      TabOrder = 1
      OnDragDrop = sbGifListDragDrop
      BufferedDraw = True
    end
  end
  object pnlTree: TJvPanel
    Left = 368
    Top = 29
    Width = 181
    Height = 357
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Align = alRight
    TabOrder = 1
    object vstEditor: TVirtualStringTree
      Left = 1
      Top = 1
      Width = 179
      Height = 355
      Align = alClient
      DragMode = dmAutomatic
      DragType = dtVCL
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
      HintMode = hmHint
      IncrementalSearchTimeout = 100000000
      ParentFont = False
      ParentShowHint = False
      PopupMenu = popEditorTree
      ShowHint = True
      TabOrder = 0
      TreeOptions.AutoOptions = [toAutoDropExpand, toAutoScrollOnExpand, toAutoSort, toAutoTristateTracking]
      OnDblClick = vstEditorDblClick
      OnPaintText = vstEditorPaintText
      OnGetHint = vstEditorGetHint
      OnKeyDown = vstEditorKeyDown
      OnScroll = vstEditorScroll
      Columns = <
        item
          Position = 0
          Width = 175
          WideText = 'Title'
        end>
    end
    object edtSearch: TEdit
      Left = 16
      Top = 304
      Width = 121
      Height = 21
      TabOrder = 1
      Visible = False
      OnChange = edtSearchChange
      OnKeyDown = edtSearchKeyDown
    end
  end
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 549
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 2
    Visible = False
    object cbSave: TCheckBox
      Left = 0
      Top = 2
      Width = 50
      Height = 22
      Hint = 'Auto Save'
      Caption = 'Save'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
    object tbSave: TToolButton
      Left = 50
      Top = 2
      Hint = 'Save'
      Caption = 'tbSave'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = tbSaveClick
    end
    object ToolButton2: TToolButton
      Left = 73
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 81
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 9
      Visible = False
      OnClick = ToolButton1Click
    end
    object cbFocus: TCheckBox
      Left = 104
      Top = 2
      Width = 97
      Height = 22
      Caption = 'Focus Glossary'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
  end
  object SynCompletionProposal1: TSynCompletionProposal
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <>
    ShortCut = 16416
    Left = 384
    Top = 5
  end
  object SynEditSearch1: TSynEditSearch
    Left = 256
    Top = 24
  end
  object popEditorTree: TPopupMenu
    Left = 272
    Top = 88
    object EditEntity1: TMenuItem
      Caption = 'Edit Entity'
      Visible = False
      OnClick = EditEntity1Click
    end
  end
end
