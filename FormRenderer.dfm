object RenderForm: TRenderForm
  Left = 0
  Top = 0
  Caption = 'Renderer'
  ClientHeight = 561
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RenderOutput: TPaintBox
    Left = 280
    Top = 80
    Width = 450
    Height = 400
    Cursor = crCross
  end
  object LblStatus: TLabel
    Left = 89
    Top = 8
    Width = 65
    Height = 13
    Caption = 'No file loaded'
  end
  object LblX: TLabel
    Left = 280
    Top = 8
    Width = 47
    Height = 13
    Alignment = taCenter
    Caption = 'X rotation'
  end
  object LblY: TLabel
    Left = 436
    Top = 8
    Width = 47
    Height = 13
    Alignment = taCenter
    Caption = 'Y rotation'
  end
  object LblZ: TLabel
    Left = 576
    Top = 8
    Width = 47
    Height = 13
    Alignment = taCenter
    Caption = 'Z rotation'
  end
  object LblXPos: TLabel
    Left = 280
    Top = 39
    Width = 46
    Height = 13
    Alignment = taCenter
    Caption = 'X position'
  end
  object LblYPos: TLabel
    Left = 436
    Top = 39
    Width = 46
    Height = 13
    Alignment = taCenter
    Caption = 'Y position'
  end
  object LblZPos: TLabel
    Left = 584
    Top = 39
    Width = 46
    Height = 13
    Alignment = taCenter
    Caption = 'Z position'
  end
  object BtnRender: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Render'
    TabOrder = 0
    OnClick = BtnRenderClick
  end
  object RdoMethod: TRadioGroup
    Left = 160
    Top = 8
    Width = 107
    Height = 57
    Caption = 'Render type'
    ItemIndex = 1
    Items.Strings = (
      'Orthographic'
      'Perspective')
    TabOrder = 1
    OnClick = RdoMethodClick
  end
  object TrkX: TTrackBar
    Left = 280
    Top = 20
    Width = 150
    Height = 13
    Max = 360
    TabOrder = 2
    OnChange = TrkXChange
  end
  object TrkY: TTrackBar
    Left = 428
    Top = 20
    Width = 150
    Height = 13
    Max = 360
    TabOrder = 3
    OnChange = TrkYChange
  end
  object TrkZ: TTrackBar
    Left = 576
    Top = 20
    Width = 150
    Height = 13
    Max = 360
    TabOrder = 4
    OnChange = TrkZChange
  end
  object LbSceneItems: TListBox
    Left = 8
    Top = 71
    Width = 259
    Height = 289
    ItemHeight = 13
    TabOrder = 5
    OnClick = LbSceneItemsClick
  end
  object SpEdXPos: TSpinEdit
    Left = 280
    Top = 52
    Width = 150
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
    OnChange = SpEdXPosChange
  end
  object SpEdYPos: TSpinEdit
    Left = 428
    Top = 52
    Width = 150
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
    OnChange = SpEdYPosChange
  end
  object SpEdZPos: TSpinEdit
    Left = 576
    Top = 52
    Width = 150
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
    OnChange = SpEdZPosChange
  end
  object SQLConnScene: TSQLConnection
    DriverName = 'Sqlite'
    Params.Strings = (
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver260.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver260.bpl'
      'FailIfMissing=True'
      'Database=')
    Left = 672
    Top = 512
  end
  object SQLQueryScene: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnScene
    Left = 576
    Top = 512
  end
end
