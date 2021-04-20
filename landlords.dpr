program landlords;

uses
  System.StartUpCopy,
  FMX.Forms,
  game in 'game.pas' {GameInterface},
  uDSimpleTcpClient in 'uDSimpleTcpClient.pas',
  tcp in 'tcp.pas',
  login in 'login.pas' {LoginFrame: TFrame},
  handler in 'handler.pas',
  user in 'user.pas',
  setUserName in 'setUserName.pas' {setUserNameFrame: TFrame},
  room in 'room.pas',
  common in 'common.pas',
  card in 'card.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.CreateForm(TLoginInterface, LoginInterface);
  Application.CreateForm(TGameInterface, GameInterface);
  Application.Run;
end.
