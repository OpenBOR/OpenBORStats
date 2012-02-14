object frmLevelSub: TfrmLevelSub
  Left = 534
  Top = 231
  Width = 548
  Height = 369
  Caption = 'Level Entity Details'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GridLevelsSub: TJvStringGrid
    Left = 0
    Top = 29
    Width = 540
    Height = 313
    Align = alClient
    DefaultRowHeight = 16
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    TabOrder = 0
    OnClick = GridLevelsSubClick
    OnDblClick = GridLevelsSubDblClick
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'MS Sans Serif'
    FixedFont.Style = []
  end
  object JvToolBar1: TJvToolBar
    Left = 0
    Top = 0
    Width = 540
    Height = 29
    Caption = 'JvToolBar1'
    Images = Form1.ImageList1
    TabOrder = 1
    object edtFileName: TEdit
      Left = 0
      Top = 2
      Width = 400
      Height = 22
      TabOrder = 0
    end
  end
end
