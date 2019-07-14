object RenderForm: TRenderForm
  Left = 0
  Top = 0
  Caption = 'RenderForm'
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
    Left = 0
    Top = 71
    Width = 801
    Height = 490
    Cursor = crCross
  end
  object LblStatus: TLabel
    Left = 89
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object Label1: TLabel
    Left = 336
    Top = 8
    Width = 47
    Height = 13
    Caption = 'X rotation'
  end
  object LblY: TLabel
    Left = 488
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Y rotation'
  end
  object Label3: TLabel
    Left = 664
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Z rotation'
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
    Left = 126
    Top = 8
    Width = 107
    Height = 57
    Caption = 'Render type'
    ItemIndex = 1
    Items.Strings = (
      'Orthographic'
      'Perspective')
    TabOrder = 1
  end
  object TrkX: TTrackBar
    Left = 280
    Top = 20
    Width = 150
    Height = 45
    Max = 360
    TabOrder = 2
    OnChange = TrkXChange
  end
  object TrkY: TTrackBar
    Left = 436
    Top = 20
    Width = 150
    Height = 45
    Max = 360
    TabOrder = 3
    OnChange = TrkYChange
  end
  object TrkZ: TTrackBar
    Left = 608
    Top = 20
    Width = 150
    Height = 45
    Max = 360
    TabOrder = 4
    OnChange = TrkZChange
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
    Left = 112
    Top = 120
  end
  object SQLQueryScene: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnScene
    Left = 184
    Top = 120
  end
end
