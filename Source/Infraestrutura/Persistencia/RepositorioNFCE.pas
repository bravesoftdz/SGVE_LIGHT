unit RepositorioNFCe;

interface

uses DB, Repositorio, Classes, System.StrUtils;

type
  TRepositorioNFCe = class(TRepositorio)

  protected
    function Get             (Dataset :TDataSet) :TObject; overload; override;
    function GetNomeDaTabela                     :String;            override;
    function GetIdentificador(Objeto :TObject)   :Variant;           override;
    function GetRepositorio                     :TRepositorio;       override;

  protected
    function SQLGet                      :String;            override;
    function SQLSalvar                   :String;            override;
    function SQLGetAll                   :String;            override;
    function CondicaoSQLGetAll           :String;            override;
    function SQLRemover                  :String;            override;
    function SQLGetExiste(campo: String): String;            override;

  protected
    function IsInsercao(Objeto :TObject) :Boolean;           override;
  protected
    procedure SetParametros   (Objeto :TObject                        ); override;
    procedure SetIdentificador(Objeto :TObject; Identificador :Variant); override;
end;

implementation

uses SysUtils, NFCe;

{ TRepositorioNFCe }

function TRepositorioNFCe.CondicaoSQLGetAll: String;
begin
  result := ' WHERE '+FIdentificador;
end;

function TRepositorioNFCe.Get(Dataset: TDataSet): TObject;
var
  XMLBlob   :TBlobField;
  XMLStream :TMemoryStream;
  NFCe :TNFCe;
begin
   NFCe:= TNFCe.Create;
   NFCe.codigo         := self.FQuery.FieldByName('codigo').AsInteger;
   NFCe.nr_nota        := self.FQuery.FieldByName('nr_nota').AsInteger;
   NFCe.codigo_pedido  := self.FQuery.FieldByName('codigo_pedido').AsInteger;
   NFCe.serie          := self.FQuery.FieldByName('serie').AsString;
   NFCe.chave          := self.FQuery.FieldByName('chave').AsString;
   NFCe.protocolo      := self.FQuery.FieldByName('protocolo').AsString;
   NFCe.dh_recebimento := self.FQuery.FieldByName('dh_recebimento').AsDateTime;
   NFCe.status         := self.FQuery.FieldByName('status').AsString;
   NFCe.motivo         := self.FQuery.FieldByName('motivo').AsString;
   NFCe.justificativa  := self.FQuery.FieldByName('justificativa').AsString;

   result := NFCe;
   
   if not self.FQuery.FieldByName('xml').IsNull then begin
     XMLStream := nil;
     try
       XMLBlob   := TBlobField(Dataset.FieldByName('XML'));
       XMLStream := TMemoryStream.Create;
       XMLBlob.SaveToStream(XMLStream);
       TNFCe(result).AdicionarXML(XMLStream);
     finally
       FreeAndNil(XMLStream);
     end;
   end;
end;

function TRepositorioNFCe.GetIdentificador(Objeto: TObject): Variant;
begin
  result := TNFCe(Objeto).Codigo;
end;

function TRepositorioNFCe.GetNomeDaTabela: String;
begin
  result := 'NFCE';
end;

function TRepositorioNFCe.GetRepositorio: TRepositorio;
begin
  result := TRepositorioNFCe.Create;
end;

function TRepositorioNFCe.IsInsercao(Objeto: TObject): Boolean;
begin
  result := (TNFCe(Objeto).Codigo <= 0);
end;

procedure TRepositorioNFCe.SetIdentificador(Objeto: TObject; Identificador: Variant);
begin
  TNFCe(Objeto).Codigo := Integer(Identificador);
end;
procedure TRepositorioNFCe.SetParametros(Objeto: TObject);
var
  NFCe :TNFCe;
begin
  NFCe := (Objeto as TNFCe);

  self.FQuery.ParamByName('codigo').AsInteger         := NFCe.codigo;
  self.FQuery.ParamByName('nr_nota').AsInteger        := NFCe.nr_nota;
  self.FQuery.ParamByName('codigo_pedido').AsInteger  := NFCe.codigo_pedido;
  self.FQuery.ParamByName('serie').AsString          := NFCe.serie;
  self.FQuery.ParamByName('chave').AsString          := NFCe.chave;
  self.FQuery.ParamByName('protocolo').AsString      := NFCe.protocolo;
  self.FQuery.ParamByName('dh_recebimento').AsDateTime := NFCe.dh_recebimento;
  self.FQuery.ParamByName('status').AsString         := NFCe.status;
  self.FQuery.ParamByName('motivo').AsString         := NFCe.motivo;
  self.FQuery.ParamByName('justificativa').AsString         := NFCe.justificativa;

  self.FQuery.ParamByName('xml').LoadFromStream(NFCe.XML, ftBlob);
end;

function TRepositorioNFCe.SQLGet: String;
begin
  result := 'select * from NFCE where codigo = :ncod';
end;

function TRepositorioNFCe.SQLGetAll: String;
begin
  result := 'select * from NFCE'+ IfThen(FIdentificador = '','', CondicaoSQLGetAll);
end;

function TRepositorioNFCe.SQLGetExiste(campo: String): String;
begin
  result := 'select '+ campo +' from NFCE where '+ campo +' = :ncampo';
end;

function TRepositorioNFCe.SQLRemover: String;
begin
  result := ' delete from NFCE where codigo = :codigo ';
end;

function TRepositorioNFCe.SQLSalvar: String;
begin
  result := 'update or insert into NFCE ( CODIGO ,NR_NOTA ,CODIGO_PEDIDO ,SERIE ,CHAVE ,PROTOCOLO ,DH_RECEBIMENTO ,XML ,STATUS ,MOTIVO, justificativa) '+
            '                     values ( :CODIGO , :NR_NOTA , :CODIGO_PEDIDO , :SERIE , :CHAVE , :PROTOCOLO , :DH_RECEBIMENTO , :XML , :STATUS , :MOTIVO, :justificativa)';
end;

end.

