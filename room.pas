unit room;

interface

uses System.Generics.Collections,FMX.Dialogs,system.JSON;

type roomPlayer = class
  uid : string;
  name : string;
  cards : Tarray<string>;
end;

type RmInfo = class
  roomId : string;
  playerMap : TDictionary<string,roomPlayer>;
  holeCards : Tarray<string>;
  constructor Create;
  destructor Destory;

  public
  procedure SetOrUpdatePlayerMap(uid :string ;TJCards :TJsonArray);
  procedure SetHoleCards(roomId :string;HCards : TJsonArray);


end;

var RM :RmInfo;

implementation

uses game,common,user;

constructor RmInfo.Create;
begin
    playerMap:=TDictionary<string,roomPlayer>.Create;
end;

destructor RmInfo.Destory;
begin
   playerMap.DisposeOf;
end;

procedure  RmInfo.SetHoleCards(roomId : string;HCards :TJsonArray);
var
  i : integer;
begin
   rm.roomId := roomId;
   rm.holeCards:=  CM.TJosnArray2TArray(HCards);
   GameInterface.holeCards.Lines.Clear;
   GameInterface.holeCards.Lines.Add(Hcards.ToString);


    GameInterface.showImage(rm.holeCards);

end;


procedure RmInfo.SetOrUpdatePlayerMap(uid:string ; TJCards :TJsonArray);
var
  rp :roomPlayer;
begin
   rp:=roomplayer.Create;
   rp.cards:=CM.TJosnArray2TArray(TJCards);
   rp.uid := uid;
   playerMap.TryAdd(uid,rp);

   if (UI.GetUserId() = uid )then
   begin
   GameInterface.MySelf.Lines.Clear;
   GameInterface.MySelf.Lines.Add(TJcards.ToString);
   end;

end;

end.
