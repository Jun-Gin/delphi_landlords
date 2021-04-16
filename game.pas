unit game;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, System.JSON,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, FMX.Edit,uDSimpleTcpClient,
  System.ImageList, FMX.ImgList, FMX.Objects,tcp,login,handler,user;

type
  TGameInterface = class(TForm)
    MySelf: TMemo;
    Image1: TImage;
    CardTable: TMemo;
    PlayerOne: TMemo;
    PlayerTwo: TMemo;
    StartGame: TButton;
    outOfCard: TButton;
    GiveUpCard: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
     image1ClickCount:integer;
  private
//    procedure OnSocketRead(AStream: TMemoryStream);
  public
    { Public declarations }
  end;

var
  GameInterface: TGameInterface;
  LFrame: TLoginFrame;
//  SGFrame:TStartGameFrame1;


implementation

{$R *.fmx}

procedure TGameInterface.FormCreate(Sender: TObject);
begin
    G_TcpMessage:=TcpMessage.Create;
    ExHandler:=executeHandler.Create;
    UI:= UserInfo.Create;
    G_TcpMessage.ConnectionService();
    LFrame := TLoginFrame.Create(Self);
    LFrame.Parent := Self;
    LFrame.BringToFront;
end;

procedure TGameInterface.FormDestroy(Sender: TObject);
begin
    G_TcpMessage.DisposeOf;
end;

procedure TGameInterface.Image1Click(Sender: TObject);
begin
      if (Image1ClickCount mod 2=0) then
       begin
        Image1.Position.Y:=Image1.Position.Y-40;
       end
       else
       begin
         Image1.Position.Y:=Image1.Position.Y+40;
       end;
       Image1ClickCount:= image1ClickCount+1;
       if Image1ClickCount=2 then
       begin
         Image1ClickCount:=0;
       end;

end;

end.
