unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login,handler,user,setUserName,
  common;

type
  TGameInterface = class(TForm)
    MySelf: TMemo;
    PlayerOne: TMemo;
    PlayerTwo: TMemo;
    StartGame: TButton;
    outOfCard: TButton;
    giveUpCard: TButton;
    tableCard: TMemo;
    holeCards: TMemo;
    cancelMatch: TButton;
    AniIndicator1: TAniIndicator;
    Text1: TText;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartGameClick(Sender: TObject);
    procedure cancelMatchClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure showImage(images : Tarray<string>);

  private
    { Private declarations }
//     image1ClickCount:integer;
  private
//    procedure OnSocketRead(AStream: TMemoryStream);
  public
    { Public declarations }
  end;

var
  GameInterface: TGameInterface;
  LFrame: TLoginFrame;
  SName:TsetUserNameFrame;


implementation

{$R *.fmx}


procedure TGameInterface.FormCreate(Sender: TObject);
begin
    G_TcpMessage := TcpMessage.Create;
    ExHandler := executeHandler.Create;
    UI := UserInfo.Create;
    CM:=cmFunction.Create;

    G_TcpMessage.ConnectionService();

    LFrame := TLoginFrame.Create(Self);
    LFrame.Parent := Self;

    SName:=TsetUserNameFrame.Create(Self);
    SName.Parent:=Self;

    SName.BringToFront;
    LFrame.BringToFront;
end;

procedure TGameInterface.FormDestroy(Sender: TObject);
begin
    G_TcpMessage.DisposeOf;
end;

procedure TGameInterface.Image1Click(Sender: TObject);
begin
//
end;

procedure TGameInterface.StartGameClick(Sender: TObject);
//var
//  js:TJsonObject;
begin
//     js:=TJsonObject.Create;
       G_TcpMessage.SendTcpMessageToService('',2003);
       AniIndicator1.Visible:=true;
       AniIndicator1.Enabled:=true;
       startGame.Visible:=false;
       cancelMatch.Visible := true;
end;

procedure TGameInterface.cancelMatchClick(Sender: TObject);
begin
     G_TcpMessage.SendTcpMessageToService('',2008);
     AniIndicator1.Enabled:=false;
     AniIndicator1.Visible:=false;
end;

procedure  TGameInterface.showImage(images : Tarray<string>) ;
var
 i : integer;
begin
   for I := 0 to 1 do
     begin
      image1.Visible:=true;
      Image1.Position.Y:= holeCards.Position.Y+50;
      image1.Position.X:=(self.Width / 2)+10;
     end;
end;

end.

