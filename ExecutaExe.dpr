program ExecutaExe;

uses
  Vcl.Forms,
  Winapi.Windows,
  System.IniFiles,
  System.SysUtils,
  Vcl.Dialogs,
  Winapi.ShellAPI;

{$R *.res}

function LerValorIni(ACaminhoIni, ASecao, AChave: String): String;
var
  ArqIni: TIniFile;
begin
  Result := '';
  Try
    if FileExists(ACaminhoIni) then
    begin
      try
        ArqIni := TIniFile.Create(ACaminhoIni);
        Result := ArqIni.ReadString(ASecao, AChave, '');
      finally
        ArqIni.Free;
      end;
    end
    else
      raise Exception.Create('Arquivo não encontrado.');
  Except
    on E: Exception do
    begin
      ShowMessage(Format('Ocorreu ler arquivo Ini "%s"' + #13#10 + 'Detalhe: %s', [E.ToString, ACaminhoIni]));
    end;
  End;
end;
var
  Caminho: String;
begin
  //Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  //Application.Run;
  Caminho := LerValorIni(ExtractFilePath(Application.ExeName)+'config.ini', 'Geral','Executavel');
  if Caminho <> '' then
    ShellExecute(0, 'open', PChar(Caminho), '', '', SW_NORMAL);
end.
