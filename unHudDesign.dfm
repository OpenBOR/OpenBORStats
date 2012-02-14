object frmHudDesign: TfrmHudDesign
  Left = 228
  Top = 206
  Width = 1024
  Height = 552
  Caption = 'Level Hud Design'
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
  object GroupBox13: TGroupBox
    Left = 0
    Top = 301
    Width = 1016
    Height = 224
    Align = alBottom
    TabOrder = 0
    object scrollbox: TJvgScrollBox
      Left = 2
      Top = 15
      Width = 1012
      Height = 207
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      Align = alClient
      TabOrder = 0
      BufferedDraw = True
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 1008
        Height = 203
        Caption = 'Level Hud Design'
        TabOrder = 0
        object cbPlayer: TComboBox
          Left = 8
          Top = 24
          Width = 113
          Height = 21
          ItemHeight = 13
          TabOrder = 0
          Text = 'Player 1'
          OnCloseUp = cbPlayerCloseUp
          Items.Strings = (
            'Player 1'
            'Player 2'
            'Player 3'
            'Player 4')
        end
        object GroupBox2: TGroupBox
          Left = 8
          Top = 56
          Width = 113
          Height = 48
          Caption = 'Player Icon'
          TabOrder = 1
          object Label1: TLabel
            Left = 8
            Top = 12
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label2: TLabel
            Left = 56
            Top = 12
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object sex: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object sey: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object Memo1: TMemo
          Left = 834
          Top = 13
          Width = 163
          Height = 180
          ScrollBars = ssBoth
          TabOrder = 2
        end
        object GroupBox3: TGroupBox
          Left = 688
          Top = 56
          Width = 113
          Height = 48
          Caption = 'Enemy Name'
          TabOrder = 3
          object Label3: TLabel
            Left = 8
            Top = 12
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label4: TLabel
            Left = 56
            Top = 12
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jeNameX: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 29.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jeNameY: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 247.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox4: TGroupBox
          Left = 688
          Top = 104
          Width = 113
          Height = 48
          Caption = 'Enemy Life Bar'
          TabOrder = 4
          object Label5: TLabel
            Left = 8
            Top = 11
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label6: TLabel
            Left = 56
            Top = 11
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jeEnemyLifeX: TJvSpinEdit
            Left = 8
            Top = 24
            Width = 49
            Height = 21
            Value = 29.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jeEnemyLifeY: TJvSpinEdit
            Left = 56
            Top = 24
            Width = 49
            Height = 21
            Value = 256.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox5: TGroupBox
          Left = 5
          Top = 152
          Width = 113
          Height = 48
          Caption = 'Player MP'
          TabOrder = 5
          object Label7: TLabel
            Left = 8
            Top = 12
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label8: TLabel
            Left = 56
            Top = 12
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jePlayerMpX: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 28.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jePlayerMpY: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 10.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox6: TGroupBox
          Left = 8
          Top = 104
          Width = 113
          Height = 48
          Caption = 'Player Health'
          TabOrder = 6
          object Label9: TLabel
            Left = 7
            Top = 10
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label10: TLabel
            Left = 63
            Top = 10
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jePlayerHealthX: TJvSpinEdit
            Left = 7
            Top = 23
            Width = 49
            Height = 21
            Value = 28.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jePlayerHealthY: TJvSpinEdit
            Left = 63
            Top = 23
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox7: TGroupBox
          Left = 125
          Top = 8
          Width = 113
          Height = 48
          Caption = 'Player * Value'
          TabOrder = 7
          object Label11: TLabel
            Left = 8
            Top = 11
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label12: TLabel
            Left = 56
            Top = 11
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jePlayerxValueX: TJvSpinEdit
            Left = 8
            Top = 24
            Width = 49
            Height = 22
            Value = 12.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jePlayerxValueY: TJvSpinEdit
            Left = 56
            Top = 24
            Width = 49
            Height = 22
            Value = 29.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox8: TGroupBox
          Left = 125
          Top = 56
          Width = 113
          Height = 48
          Caption = 'Player'#39's Left'
          TabOrder = 8
          object Label13: TLabel
            Left = 8
            Top = 12
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label14: TLabel
            Left = 56
            Top = 12
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jePlayerLeftX: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 19.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jePlayerLeftY: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 29.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox9: TGroupBox
          Left = 357
          Top = 8
          Width = 324
          Height = 48
          Caption = 'Player Name/Score'
          TabOrder = 9
          object Label15: TLabel
            Left = 8
            Top = 12
            Width = 38
            Height = 13
            Caption = 'Name X'
          end
          object Label16: TLabel
            Left = 56
            Top = 12
            Width = 38
            Height = 13
            Caption = 'Name Y'
          end
          object Label17: TLabel
            Left = 112
            Top = 12
            Width = 35
            Height = 13
            Caption = 'Dash X'
          end
          object Label18: TLabel
            Left = 160
            Top = 12
            Width = 35
            Height = 13
            Caption = 'Dash Y'
          end
          object Label19: TLabel
            Left = 216
            Top = 12
            Width = 38
            Height = 13
            Caption = 'Score X'
          end
          object Label20: TLabel
            Left = 264
            Top = 12
            Width = 38
            Height = 13
            Caption = 'Score Y'
          end
          object jvNameX: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 29.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jvNameY: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 30.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
          object jvDashX: TJvSpinEdit
            Left = 112
            Top = 25
            Width = 49
            Height = 21
            Value = 29.000000000000000000
            TabOrder = 2
            OnChange = sexChange
          end
          object jvDashY: TJvSpinEdit
            Left = 160
            Top = 25
            Width = 49
            Height = 21
            Value = 18.000000000000000000
            TabOrder = 3
            OnChange = sexChange
          end
          object jeScoreX: TJvSpinEdit
            Left = 216
            Top = 25
            Width = 49
            Height = 21
            Value = 35.000000000000000000
            TabOrder = 4
            OnChange = sexChange
          end
          object jeScoreY: TJvSpinEdit
            Left = 264
            Top = 25
            Width = 49
            Height = 21
            Value = 19.000000000000000000
            TabOrder = 5
            OnChange = sexChange
          end
        end
        object GroupBox10: TGroupBox
          Left = 688
          Top = 8
          Width = 113
          Height = 48
          Caption = 'Enemy Icon'
          TabOrder = 10
          object Label21: TLabel
            Left = 8
            Top = 12
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label22: TLabel
            Left = 56
            Top = 12
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jeEnemyIconX: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jeEnemyIconY: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 247.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
        end
        object GroupBox11: TGroupBox
          Left = 357
          Top = 64
          Width = 324
          Height = 59
          Caption = 'Player Select (After Death)'
          TabOrder = 11
          object Label23: TLabel
            Left = 8
            Top = 23
            Width = 38
            Height = 13
            Caption = 'Name X'
          end
          object Label24: TLabel
            Left = 56
            Top = 23
            Width = 38
            Height = 13
            Caption = 'Name Y'
          end
          object Label25: TLabel
            Left = 112
            Top = 23
            Width = 40
            Height = 13
            Caption = 'Select X'
          end
          object Label26: TLabel
            Left = 160
            Top = 23
            Width = 40
            Height = 13
            Caption = 'Select Y'
          end
          object Label27: TLabel
            Left = 216
            Top = 23
            Width = 36
            Height = 13
            Caption = 'Press X'
          end
          object Label28: TLabel
            Left = 264
            Top = 23
            Width = 36
            Height = 13
            Caption = 'Press Y'
          end
          object jeNameJX: TJvSpinEdit
            Left = 8
            Top = 36
            Width = 49
            Height = 21
            Value = 29.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jeNameJY: TJvSpinEdit
            Left = 56
            Top = 36
            Width = 49
            Height = 21
            Value = 10.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
          object jeSelectPlayerX: TJvSpinEdit
            Left = 112
            Top = 36
            Width = 49
            Height = 21
            Value = 30.000000000000000000
            TabOrder = 2
            OnChange = sexChange
          end
          object jeSelectPlayerY: TJvSpinEdit
            Left = 160
            Top = 36
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 3
            OnChange = sexChange
          end
          object jePressPlayerX: TJvSpinEdit
            Left = 216
            Top = 36
            Width = 49
            Height = 21
            Value = 19.000000000000000000
            TabOrder = 4
            OnChange = sexChange
          end
          object jePressPlayerY: TJvSpinEdit
            Left = 264
            Top = 36
            Width = 49
            Height = 21
            Value = 21.000000000000000000
            TabOrder = 5
            OnChange = sexChange
          end
          object cbNameJ: TCheckBox
            Left = 258
            Top = 8
            Width = 52
            Height = 17
            Caption = 'Visible'
            TabOrder = 6
            OnClick = cbNameJClick
          end
        end
        object GroupBox12: TGroupBox
          Left = 125
          Top = 104
          Width = 113
          Height = 59
          Caption = 'Mp Icon'
          TabOrder = 12
          object Label29: TLabel
            Left = 8
            Top = 20
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label30: TLabel
            Left = 56
            Top = 20
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jeMpIconX: TJvSpinEdit
            Left = 8
            Top = 33
            Width = 49
            Height = 21
            Value = 28.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jeMpIconY: TJvSpinEdit
            Left = 56
            Top = 33
            Width = 49
            Height = 21
            Value = 10.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
          object cbmpIcon: TCheckBox
            Left = 58
            Top = 6
            Width = 51
            Height = 17
            Caption = 'Visible'
            TabOrder = 2
            OnClick = cbmpIconClick
          end
        end
        object GroupBox14: TGroupBox
          Left = 241
          Top = 8
          Width = 113
          Height = 59
          Caption = 'Weapon Icon'
          TabOrder = 13
          object Label31: TLabel
            Left = 8
            Top = 20
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label32: TLabel
            Left = 56
            Top = 20
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jepIconwX: TJvSpinEdit
            Left = 8
            Top = 33
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jepIconwY: TJvSpinEdit
            Left = 56
            Top = 33
            Width = 49
            Height = 21
            Value = 69.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
          object cbpIconw: TCheckBox
            Left = 58
            Top = 8
            Width = 51
            Height = 17
            Caption = 'Visible'
            TabOrder = 2
            OnClick = cbpIconwClick
          end
        end
        object GroupBox15: TGroupBox
          Left = 241
          Top = 68
          Width = 113
          Height = 59
          Caption = 'W Counter'
          TabOrder = 14
          object Label33: TLabel
            Left = 8
            Top = 20
            Width = 7
            Height = 13
            Caption = 'X'
          end
          object Label34: TLabel
            Left = 56
            Top = 20
            Width = 7
            Height = 13
            Caption = 'Y'
          end
          object jeShootX: TJvSpinEdit
            Left = 8
            Top = 33
            Width = 49
            Height = 21
            Value = 28.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jeShootY: TJvSpinEdit
            Left = 56
            Top = 33
            Width = 49
            Height = 21
            Value = 69.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
          object cbShoot: TCheckBox
            Left = 58
            Top = 8
            Width = 51
            Height = 17
            Caption = 'Visible'
            TabOrder = 2
            OnClick = cbShootClick
          end
        end
        object GroupBox16: TGroupBox
          Left = 241
          Top = 126
          Width = 441
          Height = 48
          Caption = 'Rush'
          TabOrder = 15
          object Label35: TLabel
            Left = 8
            Top = 12
            Width = 32
            Height = 13
            Caption = 'Now X'
          end
          object Label36: TLabel
            Left = 56
            Top = 12
            Width = 32
            Height = 13
            Caption = 'Now Y'
          end
          object Label37: TLabel
            Left = 112
            Top = 12
            Width = 37
            Height = 13
            Caption = 'nVale X'
          end
          object Label38: TLabel
            Left = 160
            Top = 12
            Width = 43
            Height = 13
            Caption = 'nValue Y'
          end
          object Label39: TLabel
            Left = 216
            Top = 12
            Width = 30
            Height = 13
            Caption = 'Max X'
          end
          object Label40: TLabel
            Left = 264
            Top = 12
            Width = 30
            Height = 13
            Caption = 'Max Y'
          end
          object Label41: TLabel
            Left = 320
            Top = 12
            Width = 45
            Height = 13
            Caption = 'mValue X'
          end
          object Label42: TLabel
            Left = 368
            Top = 12
            Width = 45
            Height = 13
            Caption = 'mValue Y'
          end
          object jvRushNowX: TJvSpinEdit
            Left = 8
            Top = 25
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 0
            OnChange = sexChange
          end
          object jvRushNowY: TJvSpinEdit
            Left = 56
            Top = 25
            Width = 49
            Height = 21
            Value = 44.000000000000000000
            TabOrder = 1
            OnChange = sexChange
          end
          object jvRushnValueX: TJvSpinEdit
            Left = 112
            Top = 25
            Width = 49
            Height = 21
            Value = 59.000000000000000000
            TabOrder = 2
            OnChange = sexChange
          end
          object jvRushnValueY: TJvSpinEdit
            Left = 160
            Top = 25
            Width = 49
            Height = 21
            Value = 44.000000000000000000
            TabOrder = 3
            OnChange = sexChange
          end
          object jvRushMaxX: TJvSpinEdit
            Left = 216
            Top = 25
            Width = 49
            Height = 21
            Value = 2.000000000000000000
            TabOrder = 4
            OnChange = sexChange
          end
          object jvRushMaxY: TJvSpinEdit
            Left = 264
            Top = 25
            Width = 49
            Height = 21
            Value = 54.000000000000000000
            TabOrder = 5
            OnChange = sexChange
          end
          object jvRushmValueY: TJvSpinEdit
            Left = 368
            Top = 25
            Width = 49
            Height = 21
            Value = 54.000000000000000000
            TabOrder = 6
            OnChange = sexChange
          end
          object jvRushmValueX: TJvSpinEdit
            Left = 320
            Top = 25
            Width = 49
            Height = 21
            Value = 57.000000000000000000
            TabOrder = 7
            OnChange = sexChange
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1016
    Height = 57
    Align = alTop
    TabOrder = 1
    object Label43: TLabel
      Left = 24
      Top = 16
      Width = 30
      Height = 13
      Caption = 'Divide'
      Visible = False
    end
    object JvRuler1: TJvRuler
      Left = 1
      Top = 40
      Width = 1014
      Height = 16
      Align = alBottom
      Position = 20.000000000000000000
      UseUnit = ruPixels
    end
    object jeDivide: TJvSpinEdit
      Left = 72
      Top = 12
      Width = 49
      Height = 21
      Value = 2.000000000000000000
      TabOrder = 0
      Visible = False
      OnChange = sexChange
    end
    object btnLineVert: TButton
      Left = 152
      Top = 8
      Width = 65
      Height = 25
      Caption = 'Add V Line'
      TabOrder = 1
      OnClick = btnLineVertClick
    end
    object Button1: TButton
      Tag = 1
      Left = 224
      Top = 8
      Width = 65
      Height = 25
      Caption = 'Add H Line'
      TabOrder = 2
      OnClick = btnLineVertClick
    end
    object jeLineX: TJvSpinEdit
      Left = 296
      Top = 9
      Width = 49
      Height = 21
      Value = 2.000000000000000000
      TabOrder = 3
      OnChange = jeLineXChange
    end
    object jeLineY: TJvSpinEdit
      Left = 352
      Top = 9
      Width = 49
      Height = 21
      Value = 2.000000000000000000
      TabOrder = 4
      OnChange = jeLineYChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 1016
    Height = 244
    Align = alClient
    TabOrder = 2
    OnMouseMove = Panel2MouseMove
    object JvRuler2: TJvRuler
      Left = 1000
      Top = 1
      Width = 15
      Height = 223
      Align = alRight
      Orientation = roVertical
      UseUnit = ruPixels
    end
    object JvPanel1: TJvPanel
      Left = 464
      Top = 152
      Width = 500
      Height = 13
      Cursor = crSizeAll
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      OnPaint = JvPanel1Paint
      ArrangeSettings.WrapControls = False
      BevelOuter = bvNone
      Color = clBackground
      TabOrder = 0
      Visible = False
      OnMouseDown = JvPanel1MouseDown
      OnMouseMove = JvPanel1MouseMove
      OnMouseUp = JvPanel1MouseUp
    end
    object JvStatusBar1: TJvStatusBar
      Left = 1
      Top = 224
      Width = 1014
      Height = 19
      Panels = <>
    end
  end
end
