unit handler;

interface

uses uDSimpleTcpClient,System.Classes,System.SysUtils,System.Generics.Collections,
FMX.Dialogs,system.JSON,user;

type  executeFunction= procedure(LStr :TStringStream) of object;

type executeHandler = class

  private
  procedure DoLoginSuccess(LStr:TStringStream);
  procedure DoErrorAck(LStr:TStringStream);
  procedure DoStartGameSuccess(LStr:TStringStream);
  procedure DoOutOfTheCardSuccess(LStr:TStringStream);
  procedure DoUserRegisterSuccess(LStr:TStringStream);
  procedure DoPullUserDataSuccess(LStr:TStringStream);
  procedure DoPvpPlayerSuccess(LStr:TStringStream);
  procedure DoCancelPvpMatchSuccess(LStr:TStringStream);
  procedure AddCallBackDictionary;
//  procedure AddCode;


  public
  CallBackDictionary: TDictionary<int16,executeFunction>;
//  Code : TDictionary<string,int16>;
  constructor Create;
  destructor Destroy; override;


end;


var ExHandler :executeHandler;

implementation

uses game,tcp,room;

constructor executeHandler.Create;
begin
   CallBackDictionary:= TDictionary<int16,executeFunction>.Create;
//   Code := TDictionary<string,int16>.Create;
//   AddCode();
   AddCallBackDictionary();
end;

destructor executeHandler.Destroy;
begin
   CallBackDictionary.DisposeOf;
//   Code.DisposeOf;
   inherited;
end;

//procedure executeHandler.AddCode();
//begin
////  Code.Add();
//end;

procedure executeHandler.AddCallBackDictionary();
begin
   CallBackDictionary.Add(2001,DoLoginSuccess);              //登陆成功，进入游戏界面
   CallBackDictionary.Add(2002,DoErrorAck);                  //错误统一处理
   CallBackDictionary.Add(2003,DoStartGameSuccess);          //开始游戏成功，等待匹配结果
   CallBackDictionary.Add(2005,DoUserRegisterSuccess);       //新用户注册成功
   CallBackDictionary.Add(2006,DoPullUserDataSuccess);       //拉取用户信息成功
   CallBackDictionary.Add(2007,DoOutOfTheCardSuccess);       //出牌成功
   CallBackDictionary.Add(3000,DoPvpPlayerSuccess);          //匹配成功
   CallBackDictionary.Add(2009,DoCancelPvpMatchSuccess);     //取消匹配成功
end;


procedure executeHandler.DoErrorAck(LStr:TStringStream);
 var
  JS: TJsonObject;
  msg: string;
begin
    JS:=TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
    JS.TryGetValue('f_msg',msg);
    showMessage(msg);
    JS.DisposeOf;
end;

procedure executeHandler.DoLoginSuccess(LStr:TStringStream);
begin
      LFrame.Visible:=false;
      GameInterface.AniIndicator1.Visible:=false;
      G_TcpMessage.SendTcpMessageToService('',2006);
end;

procedure executeHandler.DoStartGameSuccess(LStr:TStringStream);
begin

end;

procedure  executeHandler.DoOutOfTheCardSuccess(LStr:TStringStream);
begin

end;

procedure executeHandler.DoUserRegisterSuccess(LStr:TStringStream);
begin

end;

procedure executeHandler.DoPullUserDataSuccess(LStr:TStringStream);
var
  Js:TJsonObject;
  name:string;
  uid:string;
begin
  Js:=TJsonObject.ParseJSONValue(Lstr.DataString)as TJsonObject;
  Js.TryGetValue('name',name);
  Js.TryGetValue('uid',uid);

  SName.Visible:=false;

  UI.SetUserId(uid);

  if not (name='') then
  begin
     SName.Visible:=false;
     UI.SetUserName(name);
  end;
  Js.DisposeOf;
end;

procedure executeHandler.DoPvpPlayerSuccess(LStr:TStringStream);
var
  Js : TJsonObject;
  HoleCards :TjsonArray;
  LPlayers : TJsonArray;
  LPlayer : TJsonObject;
  roomId : string;
  I : integer;
  Id : string;
  cards : TjsonArray;
  pj : TJsonObject;

begin
    RM:=RmInfo.Create;
   Js:=TJsonObject.ParseJSONValue(Lstr.DataString) as TJsonObject;
   js.TryGetValue('players',LPlayers);
   js.TryGetValue('roomId',roomId);
   js.TryGetValue('hole_cards',HoleCards);
   Rm.SetHoleCards(roomId,HoleCards);
   if (Lplayers<>nil)and (not LPlayers.Null) then
   begin
     for I:=0 to Lplayers.Count-1 do
       begin
           LPlayer:=LPlayers.Items[I] as TJsonObject;
           PJ:=TJsonOBject.ParseJSONValue(LPlayer.ToString) as TJsonObject;
           pJ.TryGetValue('id',Id);
           pj.TryGetValue('cards',cards);
           RM.SetOrUpdatePlayerMap(id,cards);
           pj.DisposeOf;
       end;
   end;
   js.DisposeOf;
   GameInterface.cancelMatch.Visible := false;
   GameInterface.AniIndicator1.Visible := false;
   GameInterface.AniIndicator1.Enabled := false;
   GameInterface.outOfCard.Visible := true;
   GameInterface.giveUpCard.Visible := true;
end;

procedure executeHandler.DoCancelPvpMatchSuccess(LStr:TStringStream);
begin
   GameInterface.cancelMatch.Visible := false;
   GameInterface.StartGame.Visible := true;
end;

end.
