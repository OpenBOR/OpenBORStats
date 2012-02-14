object frmEntityDetails: TfrmEntityDetails
  Left = 265
  Top = 200
  Width = 870
  Height = 500
  Caption = 'Entity Details'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
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
    object tbOpen: TToolButton
      Left = 0
      Top = 2
      Hint = 'Open Entity File'
      Caption = 'tbOpen'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = tbOpenClick
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 2
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object edtEntityFile: TEdit
      Left = 31
      Top = 2
      Width = 400
      Height = 22
      TabOrder = 0
    end
  end
  object gridEntityDetails: TJvStringGrid
    Left = 0
    Top = 29
    Width = 862
    Height = 444
    Align = alClient
    DefaultColWidth = 80
    DefaultRowHeight = 16
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 1
    OnClick = gridEntityDetailsClick
    OnDblClick = gridEntityDetailsDblClick
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'MS Sans Serif'
    FixedFont.Style = []
  end
end
