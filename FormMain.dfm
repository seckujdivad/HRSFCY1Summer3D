object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 317
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RdoChoices: TRadioGroup
    Left = 8
    Top = 112
    Width = 185
    Height = 105
    Items.Strings = (
      'Render output'
      'Scene database')
    TabOrder = 0
    OnClick = RdoChoicesClick
  end
  object PnlParent: TPanel
    Left = 199
    Top = 8
    Width = 400
    Height = 300
    Caption = 'PnlParent'
    TabOrder = 1
  end
end
