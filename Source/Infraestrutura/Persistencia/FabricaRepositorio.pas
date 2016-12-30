unit FabricaRepositorio;

interface

uses
  Repositorio;

type
  TFabricaRepositorio = class

  public
    class function GetRepositorio(NomeDaEntidade :String) :TRepositorio;
end;

implementation

uses
  SysUtils,
  uModulo,
  ExcecaoRepositorioNaoEncontrado,
  RepositorioProduto,
  RepositorioNcmIBPT,
  RepositorioCFOP,
  RepositorioPessoa,
  RepositorioConfiguracoesNF,
  RepositorioConfiguracoesNFEmail,
  RepositorioParametrosNFCe,
  RepositorioEmpresa,
  RepositorioEndereco,
  RepositorioCidade,
  RepositorioEstado,
  RepositorioFornecedor,
  RepositorioCliente,
  RepositorioVersao,
  RepositorioPedido,
  RepositorioItem,
  RepositorioMovimento,
  RepositorioNFCe,
  RepositorioNotaInutilizada,
  RepositorioContador,
  RepositorioParametros,
  RepositorioFormaPagamento,
  RepositorioTransportadora,
  RepositorioItemAvulso,
  RepositorioLocalEntregaNotaFiscal,
  RepositorioIcms00,
  RepositorioTotaisNotaFiscal,
  RepositorioRetornoNFe,
  RepositorioRetornoLoteNFe,
  RepositorioPisAliq,
  RepositorioIpiNt,
  RepositorioVolumesNotaFiscal,
  RepositorioPisNt,
  RepositorioObservacoesNotaFiscal,
  RepositorioIpiTrib,
  RepositorioIcmsSn101,
  RepositorioCofinsAliq,
  RepositorioCofinsNt,
  RepositorioNotaFiscal,
  RepositorioItemNotaFiscal,
  RepositorioLoteNFe,
  RepositorioNFe,
  RepositorioAliqInternaIcms;

{ TFabricaRepositorio }

class function TFabricaRepositorio.GetRepositorio(NomeDaEntidade: String) :TRepositorio;
begin
   result           := nil;
   NomeDaEntidade   := Trim(NomeDaEntidade);


        if (NomeDaEntidade  = 'TProduto')                  then result := TRepositorioProduto.Create
   else if (NomeDaEntidade  = 'TNcmIBPT')                  then result := TRepositorioNcmIBPT.Create
   else if (NomeDaEntidade  = 'TCFOP')                     then result := TRepositorioCFOP.Create
   else if (NomeDaEntidade  = 'TPessoa')                   then result := TRepositorioPessoa.Create
   else if (NomeDaEntidade  = 'TParametrosNFCe')           then result := TRepositorioParametrosNFCe.Create
   else if (NomeDaEntidade  = 'TEmpresa')                  then result := TRepositorioEmpresa.Create
   else if (NomeDaEntidade  = 'TConfiguracoesNF')          then result := TRepositorioConfiguracoesNF.Create
   else if (NomeDaEntidade  = 'TConfiguracoesNFEmail')     then result := TRepositorioConfiguracoesNFEmail.Create
   else if (NomeDaEntidade  = 'TEndereco')                 then result := TRepositorioEndereco.Create
   else if (NomeDaEntidade  = 'TCidade')                   then result := TRepositorioCidade.Create
   else if (NomeDaEntidade  = 'TEstado')                   then result := TRepositorioEstado.Create
   else if (NomeDaEntidade  = 'TFornecedor')               then result := TRepositorioFornecedor.Create
   else if (NomeDaEntidade  = 'TCliente')                  then result := TRepositorioCliente.Create
   else if (NomeDaEntidade  = 'TVersao')                   then result := TRepositorioVersao.Create
   else if (NomeDaEntidade  = 'TPedido')                   then result := TRepositorioPedido.Create
   else if (NomeDaEntidade  = 'TItem')                     then result := TRepositorioItem.Create
   else if (NomeDaEntidade  = 'TMovimento')                then result := TRepositorioMovimento.Create
   else if (NomeDaEntidade  = 'TNFCe')                     then result := TRepositorioNFCe.Create
   else if (NomeDaEntidade  = 'TNotaInutilizada')          then result := TRepositorioNotaInutilizada.Create
   else if (NomeDaEntidade  = 'TContador')                 then result := TRepositorioContador.Create
   else if (NomeDaEntidade  = 'TParametros')               then result := TRepositorioParametros.Create
   else if (NomeDaEntidade  = 'TFormaPagamento')           then result := TRepositorioFormaPagamento.Create
   else if (NomeDaEntidade  = 'TTransportadora')           then result := TRepositorioTransportadora.Create
   else if (NomeDaEntidade  = 'TItemAvulso')               then result := TRepositorioItemAvulso.Create
   else if (NomeDaEntidade  = 'TLocalEntregaNotaFiscal')   then result := TRepositorioLocalEntregaNotaFiscal.Create
   else if (NomeDaEntidade  = 'TIcms00')                   then result := TRepositorioIcms00.Create
   else if (NomeDaEntidade  = 'TTotaisNotaFiscal')         then result := TRepositorioTotaisNotaFiscal.Create
   else if (NomeDaEntidade  = 'TRetornoNFe')               then result := TRepositorioRetornoNFe.Create
   else if (NomeDaEntidade  = 'TRetornoLoteNFe')           then result := TRepositorioRetornoLoteNFe.Create
   else if (NomeDaEntidade  = 'TPisAliq')                  then result := TRepositorioPisAliq.Create
   else if (NomeDaEntidade  = 'TIpiNt')                    then result := TRepositorioIpiNt.Create
   else if (NomeDaEntidade  = 'TVolumesNotaFiscal')        then result := TRepositorioVolumesNotaFiscal.Create
   else if (NomeDaEntidade  = 'TPisNt')                    then result := TRepositorioPisNt.Create
   else if (NomeDaEntidade  = 'TObservacoesNotaFiscal')    then result := TRepositorioObservacoesNotaFiscal.Create
   else if (NomeDaEntidade  = 'TIpiTrib')                  then result := TRepositorioIpiTrib.Create
   else if (NomeDaEntidade  = 'TIcmsSn101')                then result := TRepositorioIcmsSn101.Create
   else if (NomeDaEntidade  = 'TCofinsAliq')               then result := TRepositorioCofinsAliq.Create
   else if (NomeDaEntidade  = 'TCofinsNt')                 then result := TRepositorioCofinsNt.Create
   else if (NomeDaEntidade  = 'TNotaFiscal')               then result := TRepositorioNotaFiscal.Create
   else if (NomeDaEntidade  = 'TItemNotaFiscal')           then result := TRepositorioItemNotaFiscal.Create
   else if (NomeDaEntidade  = 'TObservacaoNotaFiscal')     then result := TRepositorioObservacoesNotaFiscal.Create
   else if (NomeDaEntidade  = 'TLoteNFe')                  then result := TRepositorioLoteNFe.Create
   else if (NomeDaEntidade  = 'TNFe')                      then result := TRepositorioNFe.Create
   else if (NomeDaEntidade  = 'TAliqInternaIcms')          then result := TRepositorioAliqInternaIcms.Create

   else begin
     dm.LogErros.AdicionaErro('FabricaRepositorio', 'TExcecaoRepositorioNaoEncontrado', 'Repositório para a '+ NomeDaEntidade + ' não foi encontrado!');
     raise TExcecaoRepositorioNaoEncontrado.Create(NomeDaEntidade);
   end;
end;

end.
