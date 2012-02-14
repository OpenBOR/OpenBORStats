object frmCharacterEditor: TfrmCharacterEditor
  Left = 275
  Top = 128
  Width = 769
  Height = 592
  Caption = 'Character Editor'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvNetscapeSplitter1: TJvNetscapeSplitter
    Left = 0
    Top = 429
    Width = 761
    Height = 10
    Cursor = crVSplit
    Align = alBottom
    MinSize = 5
    Maximized = False
    Minimized = False
    ButtonCursor = crDefault
  end
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 761
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Hint = 'Open Character File'
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
    object ToolButton6: TToolButton
      Left = 31
      Top = 2
      Hint = 'Save'
      Caption = 'ToolButton6'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton6Click
    end
    object ToolButton4: TToolButton
      Left = 54
      Top = 2
      Hint = 'Save As'
      Caption = 'ToolButton4'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton4Click
    end
    object ToolButton5: TToolButton
      Left = 77
      Top = 2
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object cbGifLocation: TComboBox
      Left = 85
      Top = 2
      Width = 82
      Height = 21
      Hint = 'Gif Location'
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = 'Gif Location'
      OnCloseUp = cbGifLocationCloseUp
      OnEnter = memFrameInfoEnter
      Items.Strings = (
        'Centre'
        'Focus on Offset')
    end
    object ToolButton3: TToolButton
      Left = 167
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object seGifSize: TJvSpinEdit
      Left = 175
      Top = 2
      Width = 48
      Height = 22
      Hint = 'Gif Size'
      Value = 2.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnChange = seGifSizeChange
      OnEnter = memFrameInfoEnter
    end
    object cbListbBox: TCheckBox
      Left = 223
      Top = 2
      Width = 75
      Height = 22
      Hint = 'Displays Body Box'#39's and Attack Box'#39's'
      Caption = 'bBox in List'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = cbListbBoxClick
      OnEnter = memFrameInfoEnter
    end
    object seCurrentFrame: TJvSpinEdit
      Left = 298
      Top = 2
      Width = 48
      Height = 22
      Hint = 
        'Current frame. you can press F11 F12 to goto previous or next fr' +
        'ame.'
      MaxValue = 100000000000000.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnChange = seCurrentFrameChange
      OnEnter = memFrameInfoEnter
    end
    object cbShowHints: TCheckBox
      Left = 346
      Top = 2
      Width = 80
      Height = 22
      Caption = 'Show hints'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object cbFocus: TCheckBox
      Left = 426
      Top = 2
      Width = 97
      Height = 22
      Caption = 'Focus Glossary'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = cbFocusClick
    end
    object cbOffSet: TComboBox
      Left = 523
      Top = 2
      Width = 86
      Height = 21
      ItemHeight = 13
      TabOrder = 6
      Text = 'OffSet Style'
      OnCloseUp = cbOffSetCloseUp
      Items.Strings = (
        'Crossair (Med)'
        'Crossair (Sml)'
        'Circle (Sml)'
        'Crossair (Lrg)')
    end
    object ToolButton7: TToolButton
      Left = 609
      Top = 2
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object btnExecuteBor: TJvArrowButton
      Left = 617
      Top = 2
      Width = 65
      Height = 22
      Hint = 'Save'
      DropDown = popAddSetBox
      Caption = 'Add/Set'
      FillFont.Charset = DEFAULT_CHARSET
      FillFont.Color = clWindowText
      FillFont.Height = -11
      FillFont.Name = 'MS Sans Serif'
      FillFont.Style = []
      ParentShowHint = False
      ShowHint = True
      OnClick = btnExecuteBorClick
    end
  end
  object pnlAnimGrxList: TPanel
    Left = 0
    Top = 439
    Width = 761
    Height = 126
    Align = alBottom
    Caption = 'pnlAnimGrxList'
    TabOrder = 1
    object sbGifList: TJvgScrollBox
      Left = 1
      Top = 1
      Width = 759
      Height = 108
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      Align = alClient
      TabOrder = 0
      BufferedDraw = True
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 109
      Width = 759
      Height = 16
      Panels = <
        item
          Text = 'bBox'
          Width = 100
        end
        item
          Text = 'Attack'
          Width = 200
        end
        item
          Width = 800
        end>
    end
  end
  object pnlTopMain: TPanel
    Left = 0
    Top = 29
    Width = 761
    Height = 400
    Align = alClient
    Caption = 'pnlTopMain'
    TabOrder = 2
    object JvNetscapeSplitter2: TJvNetscapeSplitter
      Left = 153
      Top = 1
      Height = 398
      Align = alLeft
      MinSize = 5
      Maximized = False
      Minimized = False
      ButtonCursor = crDefault
    end
    object pnlAnimList: TPanel
      Left = 1
      Top = 1
      Width = 152
      Height = 398
      Align = alLeft
      Caption = 'pnlAnimList'
      TabOrder = 0
      object vstAnimList: TVirtualStringTree
        Left = 1
        Top = 1
        Width = 150
        Height = 396
        Align = alClient
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
        ParentFont = False
        ParentShowHint = False
        PopupMenu = popVstImport
        ShowHint = True
        TabOrder = 0
        TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowTreeLines, toThemeAware, toUseBlendedImages]
        OnDblClick = vstAnimListDblClick
        OnEnter = vstAnimListEnter
        OnFocusChanged = vstAnimListFocusChanged
        OnPaintText = vstAnimListPaintText
        OnGetHint = vstAnimListGetHint
        OnKeyUp = vstAnimListKeyUp
        OnNewText = vstAnimListNewText
        Columns = <
          item
            Position = 0
            Width = 146
            WideText = 'Name'
          end>
        WideDefaultText = 'TTC'
      end
    end
    object JvPageControl1: TJvPageControl
      Left = 163
      Top = 1
      Width = 597
      Height = 398
      ActivePage = tabGrx
      Align = alClient
      TabOrder = 1
      OnChange = JvPageControl1Change
      OnChanging = JvPageControl1Changing
      object tabGrx: TTabSheet
        Caption = 'Frames'
        object JvNetscapeSplitter3: TJvNetscapeSplitter
          Left = 342
          Top = 0
          Height = 370
          Align = alRight
          MinSize = 5
          Maximized = False
          Minimized = False
          ButtonCursor = crDefault
        end
        object pnlGrx: TPanel
          Left = 0
          Top = 0
          Width = 342
          Height = 370
          Align = alClient
          Caption = 'pnlGrx'
          TabOrder = 0
          object sbGif: TScrollBox
            Left = 1
            Top = 1
            Width = 340
            Height = 368
            Align = alClient
            TabOrder = 0
            OnEnter = sbGifEnter
            OnMouseMove = sbGifMouseMove
            object gif: TImage
              Left = 96
              Top = 72
              Width = 137
              Height = 153
              Center = True
              Stretch = True
              OnMouseDown = gifMouseDown
              OnMouseMove = gifMouseMove
              OnMouseUp = gifMouseUp
            end
          end
        end
        object pnlFrameOptions: TPanel
          Left = 352
          Top = 0
          Width = 237
          Height = 370
          Align = alRight
          Caption = 'pnlFrameOptions'
          TabOrder = 1
          object ScrollBox1: TScrollBox
            Left = 1
            Top = 1
            Width = 235
            Height = 368
            Align = alClient
            TabOrder = 0
            object gbBoxes: TJvgGroupBox
              Left = 0
              Top = 0
              Width = 214
              Height = 473
              Align = alTop
              Caption = 'Boxes'
              TabOrder = 0
              Border.Inner = bvSpace
              Border.Outer = bvNone
              Border.Sides = [fsdTop, fsdBottom]
              Border.Bold = False
              CaptionBorder.Inner = bvSpace
              CaptionBorder.Outer = bvNone
              CaptionBorder.Bold = False
              CaptionGradient.FromColor = clHighlight
              CaptionGradient.Active = False
              CaptionGradient.Orientation = fgdHorizontal
              CaptionShift.X = 8
              CaptionShift.Y = 0
              Colors.Text = clHighlightText
              Colors.TextActive = clHighlightText
              Colors.Caption = clBtnShadow
              Colors.CaptionActive = clBtnShadow
              Colors.Client = clBtnFace
              Colors.ClientActive = clBtnFace
              Gradient.FromColor = clBlack
              Gradient.ToColor = clGray
              Gradient.Active = False
              Gradient.Orientation = fgdHorizontal
              Options = [fgoCanCollapse, fgoFilledCaption, fgoFluentlyCollapse, fgoFluentlyExpand, fgoHideChildrenWhenCollapsed, fgoSaveChildFocus]
              FullHeight = 0
              object JvgGroupBox1: TJvgGroupBox
                Left = 2
                Top = 16
                Width = 210
                Height = 43
                Align = alTop
                Caption = 'Off Set'
                TabOrder = 0
                Border.Inner = bvSpace
                Border.Outer = bvNone
                Border.Bold = False
                CaptionBorder.Inner = bvSpace
                CaptionBorder.Outer = bvNone
                CaptionBorder.Bold = False
                CaptionGradient.Active = False
                CaptionGradient.Orientation = fgdHorizontal
                CaptionShift.X = 8
                CaptionShift.Y = 0
                Colors.Text = clHighlightText
                Colors.TextActive = clHighlightText
                Colors.Caption = clBtnShadow
                Colors.CaptionActive = clBtnShadow
                Colors.Client = clBtnFace
                Colors.ClientActive = clBtnFace
                Gradient.FromColor = clBlack
                Gradient.ToColor = clGray
                Gradient.Active = False
                Gradient.Orientation = fgdHorizontal
                Options = [fgoCanCollapse, fgoFilledCaption, fgoFluentlyCollapse, fgoFluentlyExpand, fgoHideChildrenWhenCollapsed, fgoSaveChildFocus]
                FullHeight = 0
                object Label1: TLabel
                  Left = 56
                  Top = 8
                  Width = 10
                  Height = 13
                  Caption = 'X:'
                end
                object Label2: TLabel
                  Left = 136
                  Top = 8
                  Width = 10
                  Height = 13
                  Caption = 'Y:'
                end
                object JvArrowButton1: TJvArrowButton
                  Left = 171
                  Top = 16
                  Width = 34
                  Height = 25
                  DropDown = popOffSet
                  FillFont.Charset = DEFAULT_CHARSET
                  FillFont.Color = clWindowText
                  FillFont.Height = -11
                  FillFont.Name = 'MS Sans Serif'
                  FillFont.Style = []
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0005232300AAAE9B0049442E00090B
                    050004070A00FF00FF001F252F006A7C8F0020272E00FF00FF00FF00FF00FF00
                    FF00FF00FF0004070A001D2B2C0071A4A70087F2F40080800000A6B581004D5D
                    3200183437001E2B3A0090A7B9005A75830004070A00FF00FF00FF00FF00FF00
                    FF002225270084A7A800A5F4F6008DF4FA0084EFF90085ECF40080800000ABAD
                    83003941470088AFC600547584000D13180004070A00FF00FF00FF00FF00FF00
                    FF0004070A00BAF8F8009AF9FB00A5F4F600778787005B575F00177E76003854
                    59009AB8CC005B808900173F3700041B170004070A0004070A00FF00FF00FF00
                    FF0004070A00CDF7F900B5FAFD00779FA500ACADB000736C7400374B4D0097B0
                    BC005F7E8D00797574004E5F47002532250004070A00FF00FF00FF00FF00FF00
                    FF0004070A00DDF9FA00CDFAFC0080808000DFDCE000B0B3B20057606200758C
                    98001C5B5D0064897300B1AD7D009D9A78006D69580004070A00FF00FF00FF00
                    FF0004070A00DDF9FA00D3FBFB00D6F7F70080808000BBB5B7009C9C9D00736C
                    7400263E42003E7D6A00968F6A001D1C0D006D69580004070A00FF00FF00FF00
                    FF0004070A00F0FBFC00D4EBEC00AAC7C500B4C8C90080808000AEADAC00B0B3
                    B2004C515B00278A89004D7E710025322500FF00FF00FF00FF00FF00FF00FF00
                    FF0004070A00B4C8C900ABCACB007B9C9E0027525500083E410048656600546B
                    6B006B8E930079AAAC00436F6C0016201D00FF00FF00FF00FF00FF00FF000014
                    1400647F880066959E00225C63000742490003515400085A60004D8D9500538B
                    930044828700538B93008CBABE006884860004070A00FF00FF00FF00FF000407
                    0A00376979001E6E7B00045D670006646B0003727300067B80005AB7C1005FAE
                    B90059A8B10067B1B80082C2C900658C940004070A00FF00FF00FF00FF001B2F
                    320059919A006BC3CC005EC2C8003EA7AD0017979A00109F9F006ADBE0008BDD
                    E3009FE0E700B2E7EF00B9E9F200C0E2E90022252700FF00FF00FF00FF00FF00
                    FF0004070A001D2B2C0079ADB1009AE3EB007DE0E7005EC2C8008DC5C800CCF0
                    F500D7F3F900D4EBEC0061686A0004070A00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF0004070A002C33360076A8B1001B2F32001C1A1B00C3BF
                    C2005B5A5B0004070A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF000407
                    0A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
                end
                object seOffSetX: TJvSpinEdit
                  Left = 8
                  Top = 20
                  Width = 60
                  Height = 21
                  Hint = 
                    'Determines where the "base" of the animation is. Ctrl+Left/Right' +
                    ' to copy from previous/next.'
                  TabOrder = 0
                  OnChange = seOffSetXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seOffSetXKeyUp
                end
                object seOffSetY: TJvSpinEdit
                  Left = 88
                  Top = 20
                  Width = 60
                  Height = 21
                  Hint = 'Determines where the "base" of the animation is.'
                  TabOrder = 1
                  OnChange = seOffSetXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seOffSetXKeyUp
                end
              end
              object JvgGroupBox2: TJvgGroupBox
                Left = 2
                Top = 59
                Width = 210
                Height = 51
                Align = alTop
                Caption = 'Move Axis'#39's'
                TabOrder = 1
                Border.Inner = bvSpace
                Border.Outer = bvNone
                Border.Bold = False
                CaptionBorder.Inner = bvSpace
                CaptionBorder.Outer = bvNone
                CaptionBorder.Bold = False
                CaptionGradient.Active = False
                CaptionGradient.Orientation = fgdHorizontal
                CaptionShift.X = 8
                CaptionShift.Y = 0
                Colors.Text = clHighlightText
                Colors.TextActive = clHighlightText
                Colors.Caption = clBtnShadow
                Colors.CaptionActive = clBtnShadow
                Colors.Client = clBtnFace
                Colors.ClientActive = clBtnFace
                Gradient.FromColor = clBlack
                Gradient.ToColor = clGray
                Gradient.Active = False
                Gradient.Orientation = fgdHorizontal
                Options = [fgoCanCollapse, fgoFilledCaption, fgoFluentlyCollapse, fgoFluentlyExpand, fgoHideChildrenWhenCollapsed, fgoSaveChildFocus]
                FullHeight = 0
                object Label3: TLabel
                  Left = 48
                  Top = 16
                  Width = 10
                  Height = 13
                  Caption = 'X:'
                end
                object Label4: TLabel
                  Left = 104
                  Top = 16
                  Width = 10
                  Height = 13
                  Caption = 'A:'
                end
                object Label5: TLabel
                  Left = 160
                  Top = 16
                  Width = 10
                  Height = 13
                  Caption = 'Z:'
                end
                object JvArrowButton2: TJvArrowButton
                  Left = 171
                  Top = 22
                  Width = 34
                  Height = 25
                  DropDown = popMoveAxis
                  FillFont.Charset = DEFAULT_CHARSET
                  FillFont.Color = clWindowText
                  FillFont.Height = -11
                  FillFont.Name = 'MS Sans Serif'
                  FillFont.Style = []
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0005232300AAAE9B0049442E00090B
                    050004070A00FF00FF001F252F006A7C8F0020272E00FF00FF00FF00FF00FF00
                    FF00FF00FF0004070A001D2B2C0071A4A70087F2F40080800000A6B581004D5D
                    3200183437001E2B3A0090A7B9005A75830004070A00FF00FF00FF00FF00FF00
                    FF002225270084A7A800A5F4F6008DF4FA0084EFF90085ECF40080800000ABAD
                    83003941470088AFC600547584000D13180004070A00FF00FF00FF00FF00FF00
                    FF0004070A00BAF8F8009AF9FB00A5F4F600778787005B575F00177E76003854
                    59009AB8CC005B808900173F3700041B170004070A0004070A00FF00FF00FF00
                    FF0004070A00CDF7F900B5FAFD00779FA500ACADB000736C7400374B4D0097B0
                    BC005F7E8D00797574004E5F47002532250004070A00FF00FF00FF00FF00FF00
                    FF0004070A00DDF9FA00CDFAFC0080808000DFDCE000B0B3B20057606200758C
                    98001C5B5D0064897300B1AD7D009D9A78006D69580004070A00FF00FF00FF00
                    FF0004070A00DDF9FA00D3FBFB00D6F7F70080808000BBB5B7009C9C9D00736C
                    7400263E42003E7D6A00968F6A001D1C0D006D69580004070A00FF00FF00FF00
                    FF0004070A00F0FBFC00D4EBEC00AAC7C500B4C8C90080808000AEADAC00B0B3
                    B2004C515B00278A89004D7E710025322500FF00FF00FF00FF00FF00FF00FF00
                    FF0004070A00B4C8C900ABCACB007B9C9E0027525500083E410048656600546B
                    6B006B8E930079AAAC00436F6C0016201D00FF00FF00FF00FF00FF00FF000014
                    1400647F880066959E00225C63000742490003515400085A60004D8D9500538B
                    930044828700538B93008CBABE006884860004070A00FF00FF00FF00FF000407
                    0A00376979001E6E7B00045D670006646B0003727300067B80005AB7C1005FAE
                    B90059A8B10067B1B80082C2C900658C940004070A00FF00FF00FF00FF001B2F
                    320059919A006BC3CC005EC2C8003EA7AD0017979A00109F9F006ADBE0008BDD
                    E3009FE0E700B2E7EF00B9E9F200C0E2E90022252700FF00FF00FF00FF00FF00
                    FF0004070A001D2B2C0079ADB1009AE3EB007DE0E7005EC2C8008DC5C800CCF0
                    F500D7F3F900D4EBEC0061686A0004070A00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF0004070A002C33360076A8B1001B2F32001C1A1B00C3BF
                    C2005B5A5B0004070A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF000407
                    0A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
                end
                object seMoveX: TJvSpinEdit
                  Left = 8
                  Top = 28
                  Width = 50
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (x) p' +
                    'ixels with every new frame until a its cancelled by a 0.Ctrl+Lef' +
                    't/Right to copy from previous/next.'
                  TabOrder = 0
                  OnChange = seMoveXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seMoveXKeyUp
                end
                object seMoveA: TJvSpinEdit
                  Left = 64
                  Top = 28
                  Width = 50
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (a) p' +
                    'ixels with every new frame until a its cancelled by a 0.'
                  TabOrder = 1
                  OnChange = seMoveXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seMoveXKeyUp
                end
                object seMoveZ: TJvSpinEdit
                  Left = 120
                  Top = 28
                  Width = 50
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (z) p' +
                    'ixels with every new frame until a its cancelled by a 0.'
                  TabOrder = 2
                  OnChange = seMoveXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seMoveXKeyUp
                end
              end
              object JvgGroupBox3: TJvgGroupBox
                Left = 2
                Top = 110
                Width = 210
                Height = 83
                Align = alTop
                Caption = 'Body Box'
                TabOrder = 2
                Border.Inner = bvSpace
                Border.Outer = bvNone
                Border.Bold = False
                CaptionBorder.Inner = bvSpace
                CaptionBorder.Outer = bvNone
                CaptionBorder.Bold = False
                CaptionGradient.Active = False
                CaptionGradient.Orientation = fgdHorizontal
                CaptionShift.X = 8
                CaptionShift.Y = 0
                Colors.Text = clHighlightText
                Colors.TextActive = clHighlightText
                Colors.Caption = clBtnShadow
                Colors.CaptionActive = clBtnShadow
                Colors.Client = clBtnFace
                Colors.ClientActive = clBtnFace
                Gradient.FromColor = clBlack
                Gradient.ToColor = clGray
                Gradient.Active = False
                Gradient.Orientation = fgdHorizontal
                Options = [fgoCanCollapse, fgoFilledCaption, fgoFluentlyCollapse, fgoFluentlyExpand, fgoHideChildrenWhenCollapsed, fgoSaveChildFocus]
                FullHeight = 0
                object Label6: TLabel
                  Left = 64
                  Top = 8
                  Width = 10
                  Height = 13
                  Caption = 'X:'
                end
                object Label7: TLabel
                  Left = 160
                  Top = 8
                  Width = 10
                  Height = 13
                  Caption = 'Y:'
                end
                object Label8: TLabel
                  Left = 64
                  Top = 42
                  Width = 14
                  Height = 13
                  Caption = 'W:'
                end
                object Label9: TLabel
                  Left = 160
                  Top = 42
                  Width = 11
                  Height = 13
                  Caption = 'H:'
                end
                object JvArrowButton3: TJvArrowButton
                  Left = 171
                  Top = 51
                  Width = 34
                  Height = 25
                  DropDown = popBeatBox
                  FillFont.Charset = DEFAULT_CHARSET
                  FillFont.Color = clWindowText
                  FillFont.Height = -11
                  FillFont.Name = 'MS Sans Serif'
                  FillFont.Style = []
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0005232300AAAE9B0049442E00090B
                    050004070A00FF00FF001F252F006A7C8F0020272E00FF00FF00FF00FF00FF00
                    FF00FF00FF0004070A001D2B2C0071A4A70087F2F40080800000A6B581004D5D
                    3200183437001E2B3A0090A7B9005A75830004070A00FF00FF00FF00FF00FF00
                    FF002225270084A7A800A5F4F6008DF4FA0084EFF90085ECF40080800000ABAD
                    83003941470088AFC600547584000D13180004070A00FF00FF00FF00FF00FF00
                    FF0004070A00BAF8F8009AF9FB00A5F4F600778787005B575F00177E76003854
                    59009AB8CC005B808900173F3700041B170004070A0004070A00FF00FF00FF00
                    FF0004070A00CDF7F900B5FAFD00779FA500ACADB000736C7400374B4D0097B0
                    BC005F7E8D00797574004E5F47002532250004070A00FF00FF00FF00FF00FF00
                    FF0004070A00DDF9FA00CDFAFC0080808000DFDCE000B0B3B20057606200758C
                    98001C5B5D0064897300B1AD7D009D9A78006D69580004070A00FF00FF00FF00
                    FF0004070A00DDF9FA00D3FBFB00D6F7F70080808000BBB5B7009C9C9D00736C
                    7400263E42003E7D6A00968F6A001D1C0D006D69580004070A00FF00FF00FF00
                    FF0004070A00F0FBFC00D4EBEC00AAC7C500B4C8C90080808000AEADAC00B0B3
                    B2004C515B00278A89004D7E710025322500FF00FF00FF00FF00FF00FF00FF00
                    FF0004070A00B4C8C900ABCACB007B9C9E0027525500083E410048656600546B
                    6B006B8E930079AAAC00436F6C0016201D00FF00FF00FF00FF00FF00FF000014
                    1400647F880066959E00225C63000742490003515400085A60004D8D9500538B
                    930044828700538B93008CBABE006884860004070A00FF00FF00FF00FF000407
                    0A00376979001E6E7B00045D670006646B0003727300067B80005AB7C1005FAE
                    B90059A8B10067B1B80082C2C900658C940004070A00FF00FF00FF00FF001B2F
                    320059919A006BC3CC005EC2C8003EA7AD0017979A00109F9F006ADBE0008BDD
                    E3009FE0E700B2E7EF00B9E9F200C0E2E90022252700FF00FF00FF00FF00FF00
                    FF0004070A001D2B2C0079ADB1009AE3EB007DE0E7005EC2C8008DC5C800CCF0
                    F500D7F3F900D4EBEC0061686A0004070A00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF0004070A002C33360076A8B1001B2F32001C1A1B00C3BF
                    C2005B5A5B0004070A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF000407
                    0A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
                end
                object seBBxX: TJvSpinEdit
                  Left = 8
                  Top = 21
                  Width = 70
                  Height = 21
                  Hint = 
                    'Determines where the entity can be hit.Ctrl+Left/Right to copy f' +
                    'rom previous/next.'
                  TabOrder = 0
                  OnChange = seBBxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seBBxXKeyUp
                end
                object seBBxY: TJvSpinEdit
                  Left = 104
                  Top = 21
                  Width = 70
                  Height = 21
                  Hint = 'Determines where the entity can be hit'
                  TabOrder = 1
                  OnChange = seBBxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seBBxXKeyUp
                end
                object seBBxW: TJvSpinEdit
                  Left = 8
                  Top = 56
                  Width = 70
                  Height = 21
                  Hint = 'Determines where the entity can be hit'
                  TabOrder = 2
                  OnChange = seBBxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seBBxXKeyUp
                end
                object seBBxH: TJvSpinEdit
                  Left = 104
                  Top = 56
                  Width = 70
                  Height = 21
                  Hint = 'Determines where the entity can be hit'
                  TabOrder = 3
                  OnChange = seBBxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = seBBxXKeyUp
                end
              end
              object bgAttack: TJvgGroupBox
                Left = 2
                Top = 193
                Width = 210
                Height = 171
                Align = alTop
                Caption = 'Attack Box'#39's'
                TabOrder = 3
                Border.Inner = bvSpace
                Border.Outer = bvNone
                Border.Bold = False
                CaptionBorder.Inner = bvSpace
                CaptionBorder.Outer = bvNone
                CaptionBorder.Bold = False
                CaptionGradient.Active = False
                CaptionGradient.Orientation = fgdHorizontal
                CaptionShift.X = 8
                CaptionShift.Y = 0
                Colors.Text = clHighlightText
                Colors.TextActive = clHighlightText
                Colors.Caption = clBtnShadow
                Colors.CaptionActive = clBtnShadow
                Colors.Client = clBtnFace
                Colors.ClientActive = clBtnFace
                Gradient.FromColor = clBlack
                Gradient.ToColor = clGray
                Gradient.Active = False
                Gradient.Orientation = fgdHorizontal
                Options = [fgoCanCollapse, fgoFilledCaption, fgoFluentlyCollapse, fgoFluentlyExpand, fgoHideChildrenWhenCollapsed, fgoSaveChildFocus]
                FullHeight = 0
                object Label10: TLabel
                  Left = 48
                  Top = 46
                  Width = 10
                  Height = 13
                  Caption = 'X:'
                end
                object Label11: TLabel
                  Left = 44
                  Top = 80
                  Width = 14
                  Height = 13
                  Caption = 'W:'
                end
                object Label12: TLabel
                  Left = 110
                  Top = 80
                  Width = 11
                  Height = 13
                  Caption = 'H:'
                end
                object Label13: TLabel
                  Left = 111
                  Top = 46
                  Width = 10
                  Height = 13
                  Caption = 'Y:'
                end
                object Label16: TLabel
                  Left = 142
                  Top = 46
                  Width = 43
                  Height = 13
                  Caption = 'Damage:'
                end
                object Label17: TLabel
                  Left = 152
                  Top = 80
                  Width = 33
                  Height = 13
                  Caption = 'Power:'
                end
                object Label18: TLabel
                  Left = 89
                  Top = 116
                  Width = 32
                  Height = 13
                  Caption = 'Depth:'
                end
                object Label19: TLabel
                  Left = 24
                  Top = 116
                  Width = 33
                  Height = 13
                  Caption = 'Pause:'
                end
                object JvArrowButton4: TJvArrowButton
                  Left = 171
                  Top = 143
                  Width = 34
                  Height = 25
                  DropDown = popAttack
                  FillFont.Charset = DEFAULT_CHARSET
                  FillFont.Color = clWindowText
                  FillFont.Height = -11
                  FillFont.Name = 'MS Sans Serif'
                  FillFont.Style = []
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0005232300AAAE9B0049442E00090B
                    050004070A00FF00FF001F252F006A7C8F0020272E00FF00FF00FF00FF00FF00
                    FF00FF00FF0004070A001D2B2C0071A4A70087F2F40080800000A6B581004D5D
                    3200183437001E2B3A0090A7B9005A75830004070A00FF00FF00FF00FF00FF00
                    FF002225270084A7A800A5F4F6008DF4FA0084EFF90085ECF40080800000ABAD
                    83003941470088AFC600547584000D13180004070A00FF00FF00FF00FF00FF00
                    FF0004070A00BAF8F8009AF9FB00A5F4F600778787005B575F00177E76003854
                    59009AB8CC005B808900173F3700041B170004070A0004070A00FF00FF00FF00
                    FF0004070A00CDF7F900B5FAFD00779FA500ACADB000736C7400374B4D0097B0
                    BC005F7E8D00797574004E5F47002532250004070A00FF00FF00FF00FF00FF00
                    FF0004070A00DDF9FA00CDFAFC0080808000DFDCE000B0B3B20057606200758C
                    98001C5B5D0064897300B1AD7D009D9A78006D69580004070A00FF00FF00FF00
                    FF0004070A00DDF9FA00D3FBFB00D6F7F70080808000BBB5B7009C9C9D00736C
                    7400263E42003E7D6A00968F6A001D1C0D006D69580004070A00FF00FF00FF00
                    FF0004070A00F0FBFC00D4EBEC00AAC7C500B4C8C90080808000AEADAC00B0B3
                    B2004C515B00278A89004D7E710025322500FF00FF00FF00FF00FF00FF00FF00
                    FF0004070A00B4C8C900ABCACB007B9C9E0027525500083E410048656600546B
                    6B006B8E930079AAAC00436F6C0016201D00FF00FF00FF00FF00FF00FF000014
                    1400647F880066959E00225C63000742490003515400085A60004D8D9500538B
                    930044828700538B93008CBABE006884860004070A00FF00FF00FF00FF000407
                    0A00376979001E6E7B00045D670006646B0003727300067B80005AB7C1005FAE
                    B90059A8B10067B1B80082C2C900658C940004070A00FF00FF00FF00FF001B2F
                    320059919A006BC3CC005EC2C8003EA7AD0017979A00109F9F006ADBE0008BDD
                    E3009FE0E700B2E7EF00B9E9F200C0E2E90022252700FF00FF00FF00FF00FF00
                    FF0004070A001D2B2C0079ADB1009AE3EB007DE0E7005EC2C8008DC5C800CCF0
                    F500D7F3F900D4EBEC0061686A0004070A00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF0004070A002C33360076A8B1001B2F32001C1A1B00C3BF
                    C2005B5A5B0004070A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF000407
                    0A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
                end
                object seAttckBoxX: TJvSpinEdit
                  Left = 8
                  Top = 59
                  Width = 50
                  Height = 21
                  TabOrder = 1
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object seAttckBoxW: TJvSpinEdit
                  Left = 8
                  Top = 94
                  Width = 50
                  Height = 21
                  TabOrder = 4
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object seAttckBoxH: TJvSpinEdit
                  Left = 71
                  Top = 94
                  Width = 50
                  Height = 21
                  TabOrder = 5
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object seAttckBoxY: TJvSpinEdit
                  Left = 71
                  Top = 59
                  Width = 50
                  Height = 21
                  TabOrder = 2
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object seatDamage: TJvSpinEdit
                  Left = 135
                  Top = 59
                  Width = 50
                  Height = 21
                  Hint = 
                    'Determines how much damage the attack does. Setting it to 0 also' +
                    ' works. Great for making launchers, slams and paralyze attacks.'
                  TabOrder = 3
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object seatPower: TJvSpinEdit
                  Left = 135
                  Top = 94
                  Width = 50
                  Height = 21
                  Hint = 'Determines how strong the knockdown effect of this attack.'
                  TabOrder = 6
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object cbatBlockable: TCheckBox
                  Left = 8
                  Top = 154
                  Width = 89
                  Height = 17
                  Hint = 'Determines if an attack is unblockable. '
                  Caption = 'UnBlockable'
                  TabOrder = 9
                  OnClick = cbatBlockableClick
                  OnEnter = memFrameInfoEnter
                end
                object cbatFlash: TCheckBox
                  Left = 104
                  Top = 154
                  Width = 65
                  Height = 17
                  Hint = 'Determins if a flash animation is played once it hits a BBox.'
                  Caption = 'NoFlash'
                  TabOrder = 10
                  OnClick = cbatBlockableClick
                  OnEnter = memFrameInfoEnter
                end
                object seatDepth: TJvSpinEdit
                  Left = 72
                  Top = 128
                  Width = 49
                  Height = 21
                  Hint = 'Determines attackbox'#39' width in z axis.'
                  TabOrder = 8
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object seatPause: TJvSpinEdit
                  Left = 7
                  Top = 128
                  Width = 50
                  Height = 21
                  Hint = 'The attacker and attackee will be paused if a succesfully hit.'
                  TabOrder = 7
                  OnChange = seAttckBoxXChange
                  OnEnter = memFrameInfoEnter
                  OnKeyUp = cbAttackNameKeyUp
                end
                object cbAttackName1: TJvHTComboBox
                  Left = 136
                  Top = 24
                  Width = 65
                  Height = 22
                  HideSel = False
                  DropWidth = 145
                  ColorHighlight = clHighlight
                  ColorHighlightText = clHighlightText
                  ColorDisabledText = clGrayText
                  DropDownCount = 16
                  Items.Strings = (
                    'attack'
                    'attack1'
                    'attack2'
                    'attack3'
                    'attack4'
                    'attack5'
                    'attack6'
                    'attack7'
                    'attack8'
                    'attack9'
                    'attack10')
                  TabOrder = 11
                  Visible = False
                end
                object cbAttackName: TComboBox
                  Left = 8
                  Top = 24
                  Width = 113
                  Height = 21
                  Hint = 'Ctrl+Left/Right to copy from previous/next.'
                  DropDownCount = 16
                  ItemHeight = 13
                  TabOrder = 0
                  Text = 'attack'
                  OnChange = cbAttackNameChange
                  OnKeyUp = cbAttackNameKeyUp
                  Items.Strings = (
                    'attack'
                    'attack2'
                    'attack3'
                    'attack4'
                    'attack5'
                    'attack6'
                    'attack7'
                    'attack8'
                    'attack9'
                    'attack10'
                    'attack11'
                    'attack12'
                    'attack13'
                    'attack14'
                    'attack15'
                    'attack16'
                    'attack17'
                    'attack18'
                    'attack19'
                    'attack20'
                    'blast'
                    'shock'
                    'burn'
                    'freeze'
                    'steal')
                end
              end
              object gbRange: TJvGroupBox
                Left = 2
                Top = 364
                Width = 210
                Height = 99
                Align = alTop
                Caption = 'Enemy AI Attack Range'
                TabOrder = 4
                object btnRangeX: TJvArrowButton
                  Left = 171
                  Top = 30
                  Width = 34
                  Height = 25
                  DropDown = popRangeX
                  FillFont.Charset = DEFAULT_CHARSET
                  FillFont.Color = clWindowText
                  FillFont.Height = -11
                  FillFont.Name = 'MS Sans Serif'
                  FillFont.Style = []
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0005232300AAAE9B0049442E00090B
                    050004070A00FF00FF001F252F006A7C8F0020272E00FF00FF00FF00FF00FF00
                    FF00FF00FF0004070A001D2B2C0071A4A70087F2F40080800000A6B581004D5D
                    3200183437001E2B3A0090A7B9005A75830004070A00FF00FF00FF00FF00FF00
                    FF002225270084A7A800A5F4F6008DF4FA0084EFF90085ECF40080800000ABAD
                    83003941470088AFC600547584000D13180004070A00FF00FF00FF00FF00FF00
                    FF0004070A00BAF8F8009AF9FB00A5F4F600778787005B575F00177E76003854
                    59009AB8CC005B808900173F3700041B170004070A0004070A00FF00FF00FF00
                    FF0004070A00CDF7F900B5FAFD00779FA500ACADB000736C7400374B4D0097B0
                    BC005F7E8D00797574004E5F47002532250004070A00FF00FF00FF00FF00FF00
                    FF0004070A00DDF9FA00CDFAFC0080808000DFDCE000B0B3B20057606200758C
                    98001C5B5D0064897300B1AD7D009D9A78006D69580004070A00FF00FF00FF00
                    FF0004070A00DDF9FA00D3FBFB00D6F7F70080808000BBB5B7009C9C9D00736C
                    7400263E42003E7D6A00968F6A001D1C0D006D69580004070A00FF00FF00FF00
                    FF0004070A00F0FBFC00D4EBEC00AAC7C500B4C8C90080808000AEADAC00B0B3
                    B2004C515B00278A89004D7E710025322500FF00FF00FF00FF00FF00FF00FF00
                    FF0004070A00B4C8C900ABCACB007B9C9E0027525500083E410048656600546B
                    6B006B8E930079AAAC00436F6C0016201D00FF00FF00FF00FF00FF00FF000014
                    1400647F880066959E00225C63000742490003515400085A60004D8D9500538B
                    930044828700538B93008CBABE006884860004070A00FF00FF00FF00FF000407
                    0A00376979001E6E7B00045D670006646B0003727300067B80005AB7C1005FAE
                    B90059A8B10067B1B80082C2C900658C940004070A00FF00FF00FF00FF001B2F
                    320059919A006BC3CC005EC2C8003EA7AD0017979A00109F9F006ADBE0008BDD
                    E3009FE0E700B2E7EF00B9E9F200C0E2E90022252700FF00FF00FF00FF00FF00
                    FF0004070A001D2B2C0079ADB1009AE3EB007DE0E7005EC2C8008DC5C800CCF0
                    F500D7F3F900D4EBEC0061686A0004070A00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF0004070A002C33360076A8B1001B2F32001C1A1B00C3BF
                    C2005B5A5B0004070A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF000407
                    0A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
                end
                object Label20: TLabel
                  Left = 8
                  Top = 16
                  Width = 27
                  Height = 13
                  Caption = 'Min:X'
                end
                object Label21: TLabel
                  Left = 72
                  Top = 16
                  Width = 30
                  Height = 13
                  Caption = 'Max:X'
                end
                object Label22: TLabel
                  Left = 8
                  Top = 56
                  Width = 27
                  Height = 13
                  Caption = 'Min:Y'
                end
                object Label23: TLabel
                  Left = 72
                  Top = 56
                  Width = 30
                  Height = 13
                  Caption = 'Max:Y'
                end
                object btnRangeA: TJvArrowButton
                  Left = 171
                  Top = 70
                  Width = 34
                  Height = 25
                  DropDown = popRangeA
                  FillFont.Charset = DEFAULT_CHARSET
                  FillFont.Color = clWindowText
                  FillFont.Height = -11
                  FillFont.Name = 'MS Sans Serif'
                  FillFont.Style = []
                  Glyph.Data = {
                    36040000424D3604000000000000360000002800000010000000100000000100
                    2000000000000004000000000000000000000000000000000000FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF0004070A0005232300AAAE9B0049442E00090B
                    050004070A00FF00FF001F252F006A7C8F0020272E00FF00FF00FF00FF00FF00
                    FF00FF00FF0004070A001D2B2C0071A4A70087F2F40080800000A6B581004D5D
                    3200183437001E2B3A0090A7B9005A75830004070A00FF00FF00FF00FF00FF00
                    FF002225270084A7A800A5F4F6008DF4FA0084EFF90085ECF40080800000ABAD
                    83003941470088AFC600547584000D13180004070A00FF00FF00FF00FF00FF00
                    FF0004070A00BAF8F8009AF9FB00A5F4F600778787005B575F00177E76003854
                    59009AB8CC005B808900173F3700041B170004070A0004070A00FF00FF00FF00
                    FF0004070A00CDF7F900B5FAFD00779FA500ACADB000736C7400374B4D0097B0
                    BC005F7E8D00797574004E5F47002532250004070A00FF00FF00FF00FF00FF00
                    FF0004070A00DDF9FA00CDFAFC0080808000DFDCE000B0B3B20057606200758C
                    98001C5B5D0064897300B1AD7D009D9A78006D69580004070A00FF00FF00FF00
                    FF0004070A00DDF9FA00D3FBFB00D6F7F70080808000BBB5B7009C9C9D00736C
                    7400263E42003E7D6A00968F6A001D1C0D006D69580004070A00FF00FF00FF00
                    FF0004070A00F0FBFC00D4EBEC00AAC7C500B4C8C90080808000AEADAC00B0B3
                    B2004C515B00278A89004D7E710025322500FF00FF00FF00FF00FF00FF00FF00
                    FF0004070A00B4C8C900ABCACB007B9C9E0027525500083E410048656600546B
                    6B006B8E930079AAAC00436F6C0016201D00FF00FF00FF00FF00FF00FF000014
                    1400647F880066959E00225C63000742490003515400085A60004D8D9500538B
                    930044828700538B93008CBABE006884860004070A00FF00FF00FF00FF000407
                    0A00376979001E6E7B00045D670006646B0003727300067B80005AB7C1005FAE
                    B90059A8B10067B1B80082C2C900658C940004070A00FF00FF00FF00FF001B2F
                    320059919A006BC3CC005EC2C8003EA7AD0017979A00109F9F006ADBE0008BDD
                    E3009FE0E700B2E7EF00B9E9F200C0E2E90022252700FF00FF00FF00FF00FF00
                    FF0004070A001D2B2C0079ADB1009AE3EB007DE0E7005EC2C8008DC5C800CCF0
                    F500D7F3F900D4EBEC0061686A0004070A00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF0004070A002C33360076A8B1001B2F32001C1A1B00C3BF
                    C2005B5A5B0004070A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00
                    FF00FF00FF00FF00FF00FF00FF00FF00FF0004070A0004070A00FF00FF000407
                    0A0004070A00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
                end
                object seRangeMinX: TJvSpinEdit
                  Left = 8
                  Top = 32
                  Width = 50
                  Height = 21
                  Hint = 
                    'The minimum distance allowed for the enemy to allow this attack.' +
                    ' Only one allowed per Anim Type.'
                  TabOrder = 0
                  OnChange = seRangeMinXChange
                  OnEnter = memFrameInfoEnter
                end
                object seRangeMaxX: TJvSpinEdit
                  Left = 72
                  Top = 32
                  Width = 50
                  Height = 21
                  Hint = 
                    'The maximum distance allowed for the enemy to allow this attack.' +
                    ' Only one allowed per Anim Type.'
                  TabOrder = 1
                  OnChange = seRangeMinXChange
                  OnEnter = memFrameInfoEnter
                end
                object seRangeMinA: TJvSpinEdit
                  Left = 8
                  Top = 72
                  Width = 49
                  Height = 21
                  TabOrder = 2
                  OnChange = seRangeMinAChange
                  OnEnter = memFrameInfoEnter
                end
                object seRangeMaxA: TJvSpinEdit
                  Left = 72
                  Top = 72
                  Width = 49
                  Height = 21
                  TabOrder = 3
                  OnChange = seRangeMinAChange
                  OnEnter = memFrameInfoEnter
                end
              end
            end
            object gbMisc: TJvgGroupBox
              Left = 0
              Top = 473
              Width = 214
              Height = 370
              Align = alTop
              Caption = 'Misc'
              TabOrder = 1
              Border.Inner = bvSpace
              Border.Outer = bvNone
              Border.Sides = [fsdTop, fsdBottom]
              Border.Bold = False
              CaptionBorder.Inner = bvSpace
              CaptionBorder.Outer = bvNone
              CaptionBorder.Bold = False
              CaptionGradient.Active = False
              CaptionGradient.Orientation = fgdHorizontal
              CaptionShift.X = 8
              CaptionShift.Y = 0
              Colors.Text = clHighlightText
              Colors.TextActive = clHighlightText
              Colors.Caption = clBtnShadow
              Colors.CaptionActive = clBtnShadow
              Colors.Client = clBtnFace
              Colors.ClientActive = clBtnFace
              Gradient.FromColor = clBlack
              Gradient.ToColor = clGray
              Gradient.Active = False
              Gradient.Orientation = fgdHorizontal
              Options = [fgoCanCollapse, fgoFilledCaption, fgoFluentlyCollapse, fgoFluentlyExpand, fgoHideChildrenWhenCollapsed, fgoSaveChildFocus]
              FullHeight = 0
              object Label14: TLabel
                Left = 144
                Top = 8
                Width = 30
                Height = 13
                Caption = 'Delay:'
              end
              object Label15: TLabel
                Left = 94
                Top = 8
                Width = 27
                Height = 13
                Caption = 'Loop:'
                Visible = False
              end
              object seDelay: TJvSpinEdit
                Left = 128
                Top = 24
                Width = 49
                Height = 21
                Hint = 'Tells how slowly the frame plays.'
                TabOrder = 1
                OnChange = seLooppChange
                OnEnter = memFrameInfoEnter
              end
              object seLoopp: TJvSpinEdit
                Left = 80
                Top = 24
                Width = 41
                Height = 21
                Hint = 
                  'Determines whether or not an animation repeats itself when finis' +
                  'hed.'
                TabOrder = 0
                Visible = False
                OnChange = seLooppChange
                OnEnter = memFrameInfoEnter
              end
              object memFrameInfo: TMemo
                Left = 2
                Top = 204
                Width = 210
                Height = 164
                Hint = 'Press F2, or Exit to Save'
                Align = alBottom
                ReadOnly = True
                ScrollBars = ssBoth
                TabOrder = 2
                WantTabs = True
                WordWrap = False
                OnEnter = memFrameInfoEnter
                OnExit = memFrameInfoExit
                OnKeyUp = memFrameInfoKeyUp
              end
              object GroupBox1: TGroupBox
                Left = 3
                Top = 48
                Width = 209
                Height = 153
                Caption = 'Entity Overlay'
                TabOrder = 3
                object Label25: TLabel
                  Left = 93
                  Top = 40
                  Width = 7
                  Height = 13
                  Caption = 'X'
                end
                object Label26: TLabel
                  Left = 156
                  Top = 40
                  Width = 7
                  Height = 13
                  Caption = 'Y'
                end
                object Label24: TLabel
                  Left = 5
                  Top = 36
                  Width = 46
                  Height = 13
                  Caption = 'Animation'
                end
                object Label27: TLabel
                  Left = 5
                  Top = 73
                  Width = 69
                  Height = 13
                  Caption = 'Frame Number'
                end
                object Label28: TLabel
                  Left = 5
                  Top = 110
                  Width = 61
                  Height = 13
                  Caption = 'Quick Result'
                end
                object Label29: TLabel
                  Left = 152
                  Top = 78
                  Width = 32
                  Height = 13
                  Caption = 'Rotate'
                  Visible = False
                end
                object cmbOverlay: TComboBox
                  Left = 5
                  Top = 16
                  Width = 113
                  Height = 21
                  ItemHeight = 13
                  TabOrder = 0
                  OnExit = cmbOverlayChange
                  OnSelect = cmbOverlayChange
                end
                object cbOverlay: TCheckBox
                  Left = 120
                  Top = 18
                  Width = 86
                  Height = 17
                  Caption = 'Show Overlay'
                  TabOrder = 1
                  OnClick = cbOverlayClick
                end
                object seOverlayX: TJvSpinEdit
                  Left = 93
                  Top = 52
                  Width = 57
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (x) p' +
                    'ixels with every new frame until a its cancelled by a 0.Ctrl+Lef' +
                    't/Right to copy from previous/next.'
                  TabOrder = 2
                  OnChange = cbOverlayClick
                  OnClick = cbOverlayClick
                end
                object seOverlayY: TJvSpinEdit
                  Left = 153
                  Top = 52
                  Width = 50
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (x) p' +
                    'ixels with every new frame until a its cancelled by a 0.Ctrl+Lef' +
                    't/Right to copy from previous/next.'
                  TabOrder = 3
                  OnChange = cbOverlayClick
                  OnClick = cbOverlayClick
                end
                object cboverlayAnim: TComboBox
                  Left = 5
                  Top = 52
                  Width = 84
                  Height = 21
                  ItemHeight = 13
                  TabOrder = 4
                  OnSelect = cboverlayAnimSelect
                end
                object jvOverlayFrameNumber: TJvSpinEdit
                  Left = 5
                  Top = 86
                  Width = 57
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (x) p' +
                    'ixels with every new frame until a its cancelled by a 0.Ctrl+Lef' +
                    't/Right to copy from previous/next.'
                  CheckMinValue = True
                  CheckMaxValue = True
                  TabOrder = 5
                  OnChange = jvOverlayFrameNumberChange
                  OnExit = jvOverlayFrameNumberChange
                end
                object cbOverlayVFlip: TCheckBox
                  Left = 93
                  Top = 90
                  Width = 60
                  Height = 18
                  Caption = 'V Flip'
                  TabOrder = 6
                  OnClick = cbOverlayVFlipClick
                end
                object cbOverlayHFlip: TCheckBox
                  Left = 93
                  Top = 74
                  Width = 60
                  Height = 18
                  Caption = 'H Flip'
                  TabOrder = 7
                  OnClick = cbOverlayVFlipClick
                end
                object edtOverlayResult: TEdit
                  Left = 5
                  Top = 126
                  Width = 196
                  Height = 21
                  TabOrder = 8
                  OnEnter = edtOverlayResultEnter
                end
                object jeOverlayLeft: TJvSpinEdit
                  Left = 149
                  Top = 92
                  Width = 57
                  Height = 21
                  Hint = 
                    'Starting with the next frame, the entity will move forward (x) p' +
                    'ixels with every new frame until a its cancelled by a 0.Ctrl+Lef' +
                    't/Right to copy from previous/next.'
                  TabOrder = 9
                  Visible = False
                  OnChange = cbOverlayVFlipClick
                  OnClick = cbOverlayVFlipClick
                end
              end
              object cbLoop: TCheckBox
                Left = 5
                Top = 26
                Width = 63
                Height = 17
                Hint = 
                  'Determines whether or not an animation repeats itself when finis' +
                  'hed.'
                Caption = 'Do Loop'
                TabOrder = 4
                OnClick = seLooppChange
                OnEnter = memFrameInfoEnter
              end
            end
          end
        end
      end
      object taEditor: TTabSheet
        Caption = 'Editor'
        ImageIndex = 1
        object pnlEditor: TPanel
          Left = 0
          Top = 0
          Width = 589
          Height = 370
          Align = alClient
          Caption = 'pnlEditor'
          TabOrder = 0
        end
      end
    end
  end
  object popVstImport: TPopupMenu
    Left = 113
    Top = 142
    object Add5: TMenuItem
      Caption = 'Add'
      ShortCut = 45
      OnClick = Add5Click
    end
    object Dublicate1: TMenuItem
      Caption = 'Dublicate'
      ShortCut = 16429
      OnClick = Dublicate1Click
    end
    object False1: TMenuItem
      Caption = 'Delete'
      object Delete1: TMenuItem
        Caption = 'Delete'
        ShortCut = 46
        OnClick = Delete1Click
      end
      object DeleteFiles1: TMenuItem
        Caption = 'Delete + Files'
        ShortCut = 16430
        OnClick = DeleteFiles1Click
      end
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Import1: TMenuItem
      Caption = 'Import'
      object LinkFiles1: TMenuItem
        Caption = 'Link Files'
        Hint = 'Add selected files as frames'
        OnClick = LinkFiles1Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object AnimatedGif1: TMenuItem
        Caption = 'Strip Animated Gif'
        OnClick = AnimatedGif1Click
      end
      object Selection1: TMenuItem
        Caption = 'Copy Files'
        Hint = 'Copies and links files to characters directory'
        OnClick = Selection1Click
      end
      object Directory1: TMenuItem
        Caption = 'Copy Directory'
        OnClick = Directory1Click
      end
    end
    object Export1: TMenuItem
      Caption = 'Export'
      object AsEntity1: TMenuItem
        Caption = 'As Entity'
        Hint = 'Exports current ani as entity file'
        OnClick = AsEntity1Click
      end
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object EditText1: TMenuItem
      Caption = 'View Separately'
      Visible = False
      OnClick = EditText1Click
    end
  end
  object popOffSet: TPopupMenu
    Left = 506
    Top = 35
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object SetViaMouse1: TMenuItem
      Caption = 'Set Via Mouse'
      OnClick = OffSet1Click
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      OnClick = Remove1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object SettoNull1: TMenuItem
      Caption = 'Set to Null'
      OnClick = SettoNull1Click
    end
    object SettoPrevious1: TMenuItem
      Caption = 'Set from Previous'
      OnClick = SettoPrevious1Click
    end
    object SettoNext1: TMenuItem
      Caption = 'Set from Next'
      OnClick = SettoNext1Click
    end
  end
  object popMoveAxis: TPopupMenu
    Left = 537
    Top = 34
    object Add2: TMenuItem
      Caption = 'Add'
      OnClick = Add2Click
    end
    object Remove2: TMenuItem
      Caption = 'Remove'
      OnClick = Remove2Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Settonull2: TMenuItem
      Caption = 'Set to Null'
      OnClick = Settonull2Click
    end
    object SetfromPrevious1: TMenuItem
      Caption = 'Set from Previous'
      OnClick = SetfromPrevious1Click
    end
    object SetfromNext1: TMenuItem
      Caption = 'Set from Next'
      OnClick = SetfromNext1Click
    end
  end
  object popBeatBox: TPopupMenu
    Left = 568
    Top = 34
    object Add3: TMenuItem
      Caption = 'Add'
      OnClick = Add3Click
    end
    object SetViaMouse2: TMenuItem
      Caption = 'Set Via Mouse'
      OnClick = popAddSetBox1Click
    end
    object Remove3: TMenuItem
      Caption = 'Remove'
      OnClick = Remove3Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object SettoNull3: TMenuItem
      Caption = 'Set to Null'
      OnClick = SettoNull3Click
    end
    object SetfromPrevious2: TMenuItem
      Caption = 'Set from Previous'
      OnClick = SetfromPrevious2Click
    end
    object SetfromNext2: TMenuItem
      Caption = 'Set from Next'
      OnClick = SetfromNext2Click
    end
  end
  object popAttack: TPopupMenu
    Left = 593
    Top = 35
    object Add4: TMenuItem
      Caption = 'Add'
      OnClick = Add4Click
    end
    object SetViaMouse3: TMenuItem
      Caption = 'Set Via Mouse'
      OnClick = AttackBox1Click
    end
    object Remove4: TMenuItem
      Caption = 'Remove'
      OnClick = Remove4Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object SettoNull4: TMenuItem
      Caption = 'Set to Null'
      OnClick = SettoNull4Click
    end
    object SetfromPrevious3: TMenuItem
      Caption = 'Set from Previous'
      OnClick = SetfromPrevious3Click
    end
    object SettoNext2: TMenuItem
      Caption = 'Set from Next'
      OnClick = SettoNext2Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 337
    Top = 452
    object AddFrame1: TMenuItem
      Caption = 'Add Frame'
      Visible = False
      OnClick = AddFrame1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'gif'
    Filter = 
      'Animated Gifs (*.gif)|*.gif|Png (*.png)|*.png|Text files (*.txt)' +
      '|*.txt|All Files (*.*)|*.*'
    Left = 448
    Top = 87
  end
  object JvBrowseForFolderDialog1: TJvBrowseForFolderDialog
    Left = 416
    Top = 88
  end
  object popRangeX: TPopupMenu
    Left = 632
    Top = 37
    object Add6: TMenuItem
      Caption = 'Add'
      OnClick = Add6Click
    end
    object Remove5: TMenuItem
      Caption = 'Remove'
      OnClick = Remove5Click
    end
  end
  object popRangeA: TPopupMenu
    Left = 664
    Top = 37
    object MenuItem1: TMenuItem
      Caption = 'Add'
      OnClick = MenuItem1Click
    end
    object MenuItem2: TMenuItem
      Caption = 'Remove'
      OnClick = MenuItem2Click
    end
  end
  object popAddSetBox: TPopupMenu
    Left = 712
    Top = 7
    object popAddSetBox1: TMenuItem
      Caption = 'Body Box'
      OnClick = popAddSetBox1Click
    end
    object AttackBox1: TMenuItem
      Caption = 'Attack Box'
      OnClick = AttackBox1Click
    end
    object OffSet1: TMenuItem
      Caption = 'Off-Set'
      OnClick = OffSet1Click
    end
    object N8: TMenuItem
      Caption = '-'
    end
  end
end
