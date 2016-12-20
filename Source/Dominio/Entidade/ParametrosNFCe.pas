unit ParametrosNFCe;

interface

uses SysUtils, Contnrs;

type
  TParametrosNFCe = class

  private
    Fcodigo_empresa :Integer;
    Fforma_emissao :Integer;
    Fintervalo_tentativas :Integer;
    Ftentativas :Integer;
    Fversao_df :Integer;
    Fid_token :String;
    Ftoken :String;
    Fvisualiza_impressao :Boolean;
    Fvia_consumidor :Boolean;
    Fimprime_itens :Boolean;
    FDt_contingencia: TDateTime;
    FLeiauteImpressao: Integer;
    FImp_comp_pedido: Boolean;

  public
    property codigo_empresa        :Integer read Fcodigo_empresa        write Fcodigo_empresa;
    property forma_emissao         :Integer read Fforma_emissao         write Fforma_emissao;
    property intervalo_tentativas  :Integer read Fintervalo_tentativas  write Fintervalo_tentativas;
    property tentativas            :Integer read Ftentativas            write Ftentativas;
    property versao_df             :Integer read Fversao_df             write Fversao_df;
    property id_token              :String read Fid_token              write Fid_token;
    property token                 :String read Ftoken                 write Ftoken;
    property visualiza_impressao   :Boolean read Fvisualiza_impressao   write Fvisualiza_impressao;
    property via_consumidor        :Boolean read Fvia_consumidor        write Fvia_consumidor;
    property imprime_itens         :Boolean read Fimprime_itens         write Fimprime_itens;
    property dt_contingencia       :TDateTime read FDt_contingencia     write FDt_contingencia;
    property leiaute_impressao     :Integer read FLeiauteImpressao    write FLeiauteImpressao;
    property imp_comp_pedido       :Boolean read FImp_comp_pedido     write FImp_comp_pedido;
end;

implementation

{ TParametrosNFCe }

end.
