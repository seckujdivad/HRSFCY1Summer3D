object RenderForm: TRenderForm
  Left = 0
  Top = 0
  Caption = 'RenderForm'
  ClientHeight = 300
  ClientWidth = 400
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
  object RenderOutput: TPaintBox
    Left = 0
    Top = 0
    Width = 400
    Height = 300
    Align = alClient
    ExplicitLeft = 32
    ExplicitTop = 24
  end
end
