unit StartGame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Memo.Types, FMX.Objects, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo;

type
  TStartGameFrame1 = class(TFrame)
    MySelf: TMemo;
    Image1: TImage;
    CardTable: TMemo;
    PlayerOne: TMemo;
    PlayerTwo: TMemo;
    Rectangle1: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
