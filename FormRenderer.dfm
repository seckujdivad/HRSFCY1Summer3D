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
    Width = 305
    Height = 57
    Caption = 'Render type'
    ItemIndex = 1
    Items.Strings = (
      'Orthographic'
      'Perspective')
    TabOrder = 1
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
    Left = 504
    Top = 8
  end
  object SQLQueryScene: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = SQLConnScene
    Left = 568
    Top = 8
  end
end
