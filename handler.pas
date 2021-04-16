unit handler;

interface

uses uDSimpleTcpClient,System.Classes,System.SysUtils,System.Generics.Collections,
FMX.Dialogs,system.JSON;

type  executeFunction= procedure(LStr :TStringStream) of object;

type executeHandler = class

  private
  procedure DoLoginSuccess(LStr:TStringStream);
  procedure DoErrorAck(LStr:TStringStream);
  procedure DoStartGameSuccess(LStr:TStringStream);
  procedure DoOutOfTheCardSuccess(LStr:TStringStream);
  procedure DoUserRegisterSuccess(LStr:TStringStream);
  procedure DoPullUserDataSuccess(LStr:TStringStream);
  procedure AddCallBackDictionary;


  public
  CallBackDictionary: TDictionary<int16,executeFunction>;
  constructor Create;
  destructor Destroy; override;


end;


var ExHandler :executeHandler;

implementation

uses game;

constructor executeHandler.Create;
begin
   CallBackDictionary:= TDictionary<int16,executeFunction>.Create;
   AddCallBackDictionary();
end;

destructor executeHandler.Destroy;
begin
   CallBackDictionary.DisposeOf;
   inherited;
end;

procedure executeHandler.AddCallBackDictionary();
begin
   CallBackDictionary.Add(2001,DoLoginSuccess);              //登陆成功，进入游戏界面
   CallBackDictionary.Add(2002,DoErrorAck);                  //错误统一处理
   CallBackDictionary.Add(2004,DoStartGameSuccess);          //开始游戏成功，等待匹配结果
   CallBackDictionary.Add(2005,DoUserRegisterSuccess);       //新用户注册成功
   CallBackDictionary.Add(2006,DoPullUserDataSuccess);       //拉取用户信息成功
   CallBackDictionary.Add(2007,DoOutOfTheCardSuccess);       //出牌成功
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
    LFrame.Visible:=false
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
begin

end;

end.
