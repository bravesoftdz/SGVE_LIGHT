object frmAguarde: TfrmAguarde
  Left = 400
  Top = 288
  BorderStyle = bsDialog
  Caption = 'frmAguarde'
  ClientHeight = 182
  ClientWidth = 564
  Color = clBtnHighlight
  TransparentColorValue = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gifAguarde: TACBrGIF
    Left = 10
    Top = 52
    Width = 81
    Height = 88
    Transparent = True
  end
  object Shape1: TShape
    Left = -6
    Top = -1
    Width = 576
    Height = 49
    Brush.Color = 16381416
    Pen.Color = 15329496
  end
  object lbAviso: TLabel
    Left = 112
    Top = 16
    Width = 100
    Height = 20
    Caption = 'Processando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 3684408
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Shape2: TShape
    Left = -6
    Top = 146
    Width = 576
    Height = 38
    Brush.Color = 16381416
    Pen.Color = 15329496
  end
  object memoAguarde: TMemo
    Left = 135
    Top = 69
    Width = 294
    Height = 52
    TabStop = False
    BevelInner = bvNone
    BorderStyle = bsNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'Aguarde um momento por favor')
    ParentFont = False
    TabOrder = 0
  end
end
