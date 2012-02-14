object frmGifList: TfrmGifList
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  TabOrder = 0
  object pnlBottom: TPanel
    Left = 0
    Top = 212
    Width = 320
    Height = 28
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      320
      28)
    object edtGifName: TEdit
      Left = 0
      Top = 3
      Width = 313
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 212
    Align = alClient
    TabOrder = 1
    object gif: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      Center = True
      Stretch = True
      OnClick = gifClick
    end
  end
end
