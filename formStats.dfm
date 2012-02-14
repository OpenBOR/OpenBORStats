object frmStats: TfrmStats
  Left = 265
  Top = 200
  Width = 870
  Height = 500
  Caption = 'Stats'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvPageControl1: TJvPageControl
    Left = 0
    Top = 0
    Width = 862
    Height = 473
    ActivePage = tabEntity
    Align = alClient
    TabOrder = 0
    TabStop = False
    object tabEntity: TTabSheet
      Caption = 'Entity'
      object gridEntity: TJvStringGrid
        Left = 0
        Top = 0
        Width = 854
        Height = 445
        Align = alClient
        DefaultRowHeight = 16
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        PopupMenu = popEntity
        TabOrder = 0
        OnClick = gridEntityClick
        OnDblClick = gridEntityDblClick
        Alignment = taLeftJustify
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
      end
    end
    object tablevel: TTabSheet
      Caption = 'Levels'
      ImageIndex = 1
      object GridLevels: TJvStringGrid
        Left = 0
        Top = 29
        Width = 854
        Height = 416
        Align = alClient
        DefaultRowHeight = 16
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        PopupMenu = popLevelDetails
        TabOrder = 0
        OnClick = GridLevelsClick
        OnDblClick = GridLevelsDblClick
        Alignment = taLeftJustify
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = []
      end
      object JvToolBar2: TJvToolBar
        Left = 0
        Top = 0
        Width = 854
        Height = 29
        Caption = 'JvToolBar2'
        TabOrder = 1
        DesignSize = (
          854
          27)
        object ToolButton2: TToolButton
          Left = 0
          Top = 2
          Hint = 'Set Levels Directory'
          Caption = 'ToolButton2'
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
        end
        object Label1: TLabel
          Left = 23
          Top = 2
          Width = 44
          Height = 22
          Caption = 'Level:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Palatino Linotype'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbLevels: TComboBox
          Left = 67
          Top = 2
          Width = 500
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          DropDownCount = 30
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
          Text = 
            'Please select one from the drop down list or manually type a lev' +
            'el with a valid path and press return!'
          OnChange = cbLevelsChange
          OnCloseUp = cbLevelsCloseUp
        end
      end
    end
  end
  object popEntity: TPopupMenu
    Left = 236
    Top = 181
    object EditCharacter1: TMenuItem
      Caption = 'Edit Character'
      OnClick = EditCharacter1Click
    end
    object ViewDetails1: TMenuItem
      Caption = 'View Statistics'
      OnClick = ViewDetails1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Edit2: TMenuItem
      Caption = 'Edit'
      OnClick = Edit2Click
    end
    object Edit1: TMenuItem
      Caption = 'Edit(External)'
      OnClick = Edit1Click
    end
    object Format1: TMenuItem
      Caption = 'Format'
      OnClick = Format1Click
    end
  end
  object popLevelDetails: TPopupMenu
    Left = 460
    Top = 253
    object ViewDetails2: TMenuItem
      Caption = 'View Details'
      OnClick = ViewDetails2Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Edit3: TMenuItem
      Caption = 'Edit'
      Hint = 'Edit'
      OnClick = Edit3Click
    end
    object EditFile1: TMenuItem
      Caption = 'Edit(External)'
      OnClick = EditFile1Click
    end
    object Format2: TMenuItem
      Caption = 'Format'
      OnClick = Format2Click
    end
  end
end
