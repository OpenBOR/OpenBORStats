unit clsmugenAir;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  unCommon;

type
  TmugenAirDataAction =class(TObject)
  private
  Public
    id : Integer;
    Clsn20 : String;
    Clsn21 : String;
    Clsn22 : String;
    Clsn23 : String;
    Clsn24 : String;
    Clsn25 : String;
    frValue : String;
    highFrm : integer;
    lowFrm : integer;
    FrameList : TStringList;
    function stripMugenActionData(listData:TStringList):TmugenAirDataAction;
    constructor Create;
  end;

type
  TmugenSffData = class(TObject)
  private

  public
      imageFile :string;
    groupId :Integer;
    groupFrame :Integer;
    x :Integer;
    y :Integer;

  end;

type
  tmugenSff = class(TObject)
  private
  public
   mugenList :TStringList;
    constructor Create(filename:string);
    function getmugensffData(index:integer):TmugenSffData;
  end;

type
  TmugenAirData =class(TObject)
  private
  Public
    id : Integer;
    abegin : String;

    mugenAirDataActionList : TStringList;
    mugenAirDataActionTemp : TmugenAirDataAction;

    function stripMugenAirData(listData:TStringList):TmugenAirData;

    constructor Create;
  end;

type
  TmugenAirsData = class(TObject)
  private
    function stripmugenAirData(listData:TStringList;lineNumber:Integer=0):TmugenAirData;
  public
    list : TStringList;
    procedure addmugenAirData(listData:TStringList;LastComment:string);
    function getmugenAirData(abegin:String):TmugenAirData;


    constructor create;
end;
implementation
uses
  unMain;
{ TLevelsData }
procedure TmugenAirsData.addmugenAirData(listData: TStringList;LastComment:string);
Var
  i: integer;
  foundData : boolean;
  aData, existingData : TmugenAirData;
  s : string;
begin
  aData := stripmugenAirData(listData,0);
  {foundData := false;
  for i := 0 to list.Count -1 do Begin
    existingData := (list.Objects[i] as TmugenAirData);
    if existingData.abegin = aData.abegin then Begin
       existingData.id := aData.id;
       existingData.abegin := aData.abegin;
       //Set action list to add correctly......
       existingData.mugenAirDataActionList := aData.mugenAirDataActionList;
       existingData.mugenAirDataActionTemp := aData.mugenAirDataActionTemp;

      foundData := true;
    end;
  end;
  if foundData = false then Begin}
     list.AddObject(intToStr(list.count)+LastComment,aData);
  //end;
end;
constructor TmugenAirsData.create;
begin
  list := TStringList.Create;
  list.Sorted := true;
  list.Duplicates := dupIgnore;
end;
function TmugenAirsData.getmugenAirData(abegin: String): TmugenAirData;
Var
  existingData, foundData : TmugenAirData;
  i : integer;
begin
  foundData := nil;
  for i := 0 to list.Count -1 do Begin
    existingData := (list.Objects[i] as TmugenAirData);
    if existingData.abegin = abegin then
      foundData := existingData;
  end;
  Result := foundData;
end;
function TmugenAirsData.stripmugenAirData(listData: TStringList;lineNumber:Integer): TmugenAirData;
Var
  i : integer;
  mugenAirData : TmugenAirData;
  Clsn2New : Boolean;
  MugenActionList : TStringList;
  s : string;
  aSub : TmugenAirData;
  mugenActionData : TmugenAirDataAction;
begin
  mugenAirData := TmugenAirData.Create;
  MugenActionList := TStringList.Create;
  Clsn2New := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if PosStr('[begin',s) > 0 then Begin
      mugenAirData.abegin := s;
    end;

    //Create and Search Action List

    if (PosStr('clsn2:',s) > 0) and
       (Clsn2New = false) then Begin
      Clsn2New := true;
    end;

    if PosStr('[begin',s) < 1 then Begin
      MugenActionList.Add(s);
    end;

    {if ((Clsn2New = true) and
       (PosStr('clsn2:',s) > 0)) or
       ((Clsn2New = true) and
       (isLineEmpty(s) = true)) then Begin
    }
    if isLineEmpty(s) = true then Begin
      mugenActionData := TmugenAirDataAction.Create;
      mugenActionData := mugenActionData.stripMugenActionData(MugenActionList);
      mugenAirData.mugenAirDataActionList.AddObject(IntToStr(mugenAirData.mugenAirDataActionList.Count),mugenActionData);
      mugenAirData.mugenAirDataActionTemp := mugenActionData;
      Clsn2New := false;
      MugenActionList.Clear;
      MugenActionList.Add(s);
    End;

  end;
  MugenActionList.Free;
  Result := mugenAirData;
end;

{ TLevelData }
constructor TmugenAirData.Create;
begin
  mugenAirDataActionList := TStringList.Create;
  mugenAirDataActionList.Sorted := true;
  mugenAirDataActionList.Duplicates := dupIgnore;
  id := 0;
  abegin := '';


end;
{ TmugenAirDataAction }

constructor TmugenAirDataAction.Create;
begin
  id := 0;
  Clsn20 := '';
  Clsn21 := '';
  Clsn22 := '';
  Clsn23 := '';
  Clsn24 := '';
  Clsn25 := '';
  frValue := '';
  highFrm := 0;
  lowFrm := 0;
  FrameList := TStringList.Create;
end;

function TmugenAirData.stripMugenAirData(listData: TStringList): TmugenAirData;
Var
  i : integer;
  aMugenAction : TmugenAirDataAction;
begin

  for i := 0 to listData.Count -1 do Begin

  end;

end;

function TmugenAirDataAction.stripMugenActionData(
  listData: TStringList): TmugenAirDataAction;
Var
  i : integer;
  s : string;
  aMugenActionData : TmugenAirDataAction;
begin
  aMugenActionData := TmugenAirDataAction.Create;

  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    {if PosStr('clsn2:',s) > 0 then
      Try
        aMugenActionData.id := StrToInt(strip2bar('clsn2:',s));
      Except
        aMugenActionData.id := 0;
      end;
    if PosStr('clsn2[0]',s) > 0 then
      aMugenActionData.Clsn20 := strip2bar('clsn2[0]',s);
    if PosStr('clsn2[1]',s) > 0 then
      aMugenActionData.Clsn21 := strip2bar('clsn2[1]',s);
    if PosStr('clsn2[2]',s) > 0 then
      aMugenActionData.Clsn22 := strip2bar('clsn2[2]',s);
    if PosStr('clsn2[3]',s) > 0 then
      aMugenActionData.Clsn23 := strip2bar('clsn2[3]',s);
    if PosStr('clsn2[4]',s) > 0 then
      aMugenActionData.Clsn24 := strip2bar('clsn2[4]',s);
    if PosStr('clsn2[5]',s) > 0 then
      aMugenActionData.Clsn25 := strip2bar('clsn2[5]',s);}
    if PosStr('clsn',s) < 1 then
      aMugenActionData.FrameList.Add(s);
  end;

  Result := aMugenActionData;
end;

{ tmugenSff }


constructor tmugenSff.Create(filename: string);
var
  i :integer;
  s, s2 :string;
  rmugData : TmugenSffData;
  fileList : TStringList;
begin
  if FileExists(filename) then Begin
    mugenList := TStringList.Create();
    fileList := TStringList.Create();
    fileList.LoadFromFile(filename);
    i := 0;
    while i < fileList.Count do Begin
     s := LowerCase(fileList.Strings[i]);
     try
     if PosStr('.pcx',s) > 0 then Begin
       rmugData := TmugenSffData.Create;
       StringDeleteUp2(s,'\');
       rmugData.imageFile := s;
       s2 := fileList.Strings[i+1];
       strClearAll(s2);
       rmugData.groupId := StrToInt(s2);

       s2 := fileList.Strings[i+2];
       strClearAll(s2);
       rmugData.groupFrame := StrToInt(s2);

       s2 := fileList.Strings[i+3];
       strClearAll(s2);
       rmugData.x := StrToInt(s2);

       s2 := fileList.Strings[i+4];
       strClearAll(s2);
       rmugData.y := StrToInt(s2);
       i := i + 4;

       mugenList.AddObject(IntToStr(i),rmugData);
     end;
     except
     end;
     inc(i);
    end;
  end;
end;

function tmugenSff.getmugensffData(index: integer): TmugenSffData;
var
  rData : TmugenSffData;
begin
  if mugenList <> nil then Begin

    rData := mugenList.Objects[index] as TmugenSffData;
  end;
  Result := rData;
end;

end.
