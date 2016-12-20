unit RepositorioParametrosNFCe;

interface

uses DB, Repositorio, System.StrUtils;

type
  TRepositorioParametrosNFCe = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;

end;

implementation

uses SysUtils, ParametrosNFCe;

{ TRepositorioParametrosNFCe }

function TRepositorioParametrosNFCe.Get(Dataset: TDataSet): TObject;
var
  ParametrosNFCe :TParametrosNFCe;
begin
   ParametrosNFCe:= TParametrosNFCe.Create;
   ParametrosNFCe.codigo_empresa       := self.FQuery.FieldByName('codigo_empresa').AsInteger;
   ParametrosNFCe.forma_emissao        := self.FQuery.FieldByName('forma_emissao').AsInteger;
   ParametrosNFCe.intervalo_tentativas := self.FQuery.FieldByName('intervalo_tentativas').AsInteger;
   ParametrosNFCe.tentativas           := self.FQuery.FieldByName('tentativas').AsInteger;
   ParametrosNFCe.versao_df            := self.FQuery.FieldByName('versao_df').AsInteger;
   ParametrosNFCe.id_token             := self.FQuery.FieldByName('id_token').AsString;
   ParametrosNFCe.token                := self.FQuery.FieldByName('token').AsString;
   ParametrosNFCe.visualiza_impressao  := self.FQuery.FieldByName('visualiza_impressao').AsString = 'S';
   ParametrosNFCe.via_consumidor       := self.FQuery.FieldByName('via_consumidor').AsString = 'S';
   ParametrosNFCe.imprime_itens        := self.FQuery.FieldByName('imprime_itens').AsString = 'S';
   ParametrosNFCe.dt_contingencia      := self.FQuery.FieldByName('dt_contingencia').AsDateTime;
   ParametrosNFCe.leiaute_impressao    := self.FQuery.FieldByName('leiaute_impressao').AsInteger;
   ParametrosNFCe.imp_comp_pedido      := self.FQuery.FieldByName('imp_comp_pedido').AsString = 'S';

   result := ParametrosNFCe;
end;

function TRepositorioParametrosNFCe.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TParametrosNFCe(Objeto).codigo_empresa;
end;

function TRepositorioParametrosNFCe.GetNomeDaTabela: String;
begin
  result := 'PARAMETROS_NFCE';
end;

function TRepositorioParametrosNFCe.GetRepositorio: TRepositorio;
begin
  result := TRepositorioParametrosNFCe.Create;
end;

function TRepositorioParametrosNFCe.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TParametrosNFCe(Objeto).codigo_empresa <= 0);
end;

procedure TRepositorioParametrosNFCe.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TParametrosNFCe(Objeto).codigo_empresa := Integer(Identificador);
end;
procedure TRepositorioParametrosNFCe.SetParametros(Objeto: TObject);
var
  ParametrosNFCe :TParametrosNFCe;
begin
  ParametrosNFCe := (Objeto as TParametrosNFCe);

  self.FQuery.ParamByName('codigo_empresa').AsInteger       := ParametrosNFCe.codigo_empresa;
  self.FQuery.ParamByName('forma_emissao').AsInteger        := ParametrosNFCe.forma_emissao;
  self.FQuery.ParamByName('intervalo_tentativas').AsInteger := ParametrosNFCe.intervalo_tentativas;
  self.FQuery.ParamByName('tentativas').AsInteger           := ParametrosNFCe.tentativas;
  self.FQuery.ParamByName('versao_df').AsInteger            := ParametrosNFCe.versao_df;
  self.FQuery.ParamByName('id_token').AsString              := ParametrosNFCe.id_token;
  self.FQuery.ParamByName('token').AsString                 := ParametrosNFCe.token;
  self.FQuery.ParamByName('visualiza_impressao').AsString   := IfThen(ParametrosNFCe.visualiza_impressao, 'S', 'N');
  self.FQuery.ParamByName('via_consumidor').AsString        := IfThen(ParametrosNFCe.via_consumidor, 'S', 'N');
  self.FQuery.ParamByName('imprime_itens').AsString         := IfThen(ParametrosNFCe.imprime_itens, 'S', 'N');
  if ParametrosNFCe.forma_emissao <> 0 then
    self.FQuery.ParamByName('dt_contingencia').AsDateTime     := ParametrosNFCe.dt_contingencia;
  self.FQuery.ParamByName('leiaute_impressao').AsInteger    := ParametrosNFCe.leiaute_impressao;
  self.FQuery.ParamByName('imp_comp_pedido').AsString       := IfThen(ParametrosNFCe.imp_comp_pedido, 'S', 'N');
end;

function TRepositorioParametrosNFCe.SQLGet: String;
begin
  result := 'select * from PARAMETROS_NFCE where codigo_empresa = :ncod';
end;

function TRepositorioParametrosNFCe.SQLGetAll: String;
begin
  result := 'select * from PARAMETROS_NFCE';
end;

function TRepositorioParametrosNFCe.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from PARAMETROS_NFCE where '+ campo +' = :ncampo';
end;

function TRepositorioParametrosNFCe.SQLRemover: String;
begin
  result := ' delete from PARAMETROS_NFCE where codigo_empresa = :codigo ';
end;

function TRepositorioParametrosNFCe.SQLSalvar: String;
begin
  result := 'update or insert into PARAMETROS_NFCE (CODIGO_EMPRESA ,FORMA_EMISSAO ,INTERVALO_TENTATIVAS ,TENTATIVAS ,VERSAO_DF ,ID_TOKEN ,TOKEN ,VISUALIZA_IMPRESSAO ,VIA_CONSUMIDOR ,IMPRIME_ITENS, DT_CONTINGENCIA, LEIAUTE_IMPRESSAO, IMP_COMP_PEDIDO) '+
           '                      values ( :CODIGO_EMPRESA , :FORMA_EMISSAO , :INTERVALO_TENTATIVAS , :TENTATIVAS , :VERSAO_DF , :ID_TOKEN , :TOKEN , :VISUALIZA_IMPRESSAO , :VIA_CONSUMIDOR , :IMPRIME_ITENS, :DT_CONTINGENCIA, :LEIAUTE_IMPRESSAO, :IMP_COMP_PEDIDO) ';
end;

end.

