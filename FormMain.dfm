object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 680
  ClientWidth = 901
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  DesignSize = (
    901
    680)
  PixelsPerInch = 96
  TextHeight = 13
  object PnlParent: TPanel
    AlignWithMargins = True
    Left = 96
    Top = 28
    Width = 802
    Height = 649
    Align = alRight
    ShowCaption = False
    TabOrder = 0
  end
  object ActmenubrMain: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 901
    Height = 25
    UseSystemFont = False
    ActionManager = ActmgrMain
    Caption = 'ActmenubrMain'
    Color = clMenuBar
    ColorMap.DisabledFontColor = 7171437
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedFont = clBlack
    ColorMap.UnusedColor = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Spacing = 0
  end
  object BtngrpTools: TButtonGroup
    AlignWithMargins = True
    Left = 0
    Top = 31
    Width = 97
    Height = 322
    Anchors = [akLeft, akTop, akRight]
    ButtonWidth = 90
    Items = <
      item
        Caption = 'Scene renderer'
        OnClick = ButtonGroup1Items0Click
      end>
    TabOrder = 2
  end
  object ActmgrMain: TActionManager
    ActionBars = <
      item
      end
      item
        Items = <
          item
            Items = <
              item
                Action = FileOpen1
                ImageIndex = 7
                ShortCut = 16463
              end>
            Caption = '&File'
          end>
        ActionBar = ActmenubrMain
      end>
    Left = 72
    Top = 640
    StyleName = 'Platform Default'
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = FileOpen1Accept
    end
  end
end
