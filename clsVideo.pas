unit clsVideo;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  unCommon, formFormat;

type
  Tvideo = class(TObject)
  private

  public
//  0 = 320x240
//  1 = 480x272
//  2 = 640x480
//  3 = 720x480
//  4 = 800x480
//  5 = 960x540
    videoSize : integer;
    videofileList : TStringList;
    function getvideosize:integer;
    constructor create(videofile:string);
  end;

implementation

{ Tvideo }

constructor Tvideo.create(videofile: string);
begin
  videofileList := TStringList.Create;
  if FileExists(videofile) then Begin
    videofileList.LoadFromFile(videofile);
    videoSize := getvideosize;
  end;
end;

function Tvideo.getvideosize: integer;
Var
  i, iFound : integer;
  s : string;
begin
  i := 0;
  iFound := 0;
  while i < videofileList.Count do Begin
    s := strClearAll(videofileList.Strings[i]);
    if PosStr('video',s) > 0 then Begin
      try
        iFound := StrToInt(strip2Bar('video',s));
      except
        iFound := 0;
      end;
      i := videofileList.Count;
    end;
    inc(i);
  end;
  Result := iFound;
end;

end.
