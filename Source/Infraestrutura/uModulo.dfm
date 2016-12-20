object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 179
  Width = 265
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'Password=masterkey'
      'Port=3050'
      'Server=localhost'
      'User_Name=sysdba'
      'Database=C:\Sistemas\Delphi\SGVE_LIGHT\Dados\base.FDB')
    FetchOptions.AssignedValues = [evCache]
    UpdateOptions.AssignedValues = [uvEDelete, uvEUpdate, uvUpdateChngFields, uvCountUpdatedRecords, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.CheckRequired = False
    LoginPrompt = False
    OnError = FDConnectionError
    Left = 40
    Top = 24
  end
  object qryGenerica: TFDQuery
    Connection = FDConnection
    Left = 184
    Top = 24
  end
  object qryGenerica2: TFDQuery
    Connection = FDConnection
    Left = 184
    Top = 96
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnectionServidor
    Left = 32
    Top = 120
  end
  object FDConnectionServidor: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Password=cbn502323'
      'Port=0'
      'Server=mysql01-farm51.kinghost.net'
      'User_Name=cbninfo'
      'Database=cbninfo'
      'LoginTimeout=3')
    FetchOptions.AssignedValues = [evCache]
    UpdateOptions.AssignedValues = [uvEDelete, uvEUpdate, uvUpdateChngFields, uvCountUpdatedRecords, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.CheckRequired = False
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 112
    Top = 64
  end
end
