unit clsLevels;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  unCommon;

type
  TLevelDataSub = class(Tobject)

  private
  public
    LineNumber : integer;
    coOrds : string;
    at : string;
    alias : string;
    health : string;
    map : string;
    item : string;
    boss : string;
  end;

type
  TLevelData =class(TObject)
  private

  Public
    SpawnName : string;
    SpawnMinHealth : integer;
    SpawnMaxHealth : integer;
    SpawnCount : integer;
    SpawnItem : integer;
    SpawnBoss : integer;
    aSub : TStringList;
    tmpSub : TLevelDataSub;
    constructor Create;
  end;


type
  TLevelsData = class(TObject)

  private

    function stripData(listData:TStringList;lineNumber:Integer):TLevelData;
  public
    list : TStringList;
    procedure addData(listData:TStringList;lineNumber:Integer);
    function getData(spawnName:String):TLevelData;

    constructor create;
end;

implementation
uses
  unMain;
{ TLevelsData }

procedure TLevelsData.addData(listData: TStringList;lineNumber:Integer);
Var
  i: integer;
  foundData : boolean;
  aData, existingData : TLevelData;

  s : string;
begin
  //listData := Form1.stripEmptyLines(listData);
  aData := stripData(listData,lineNumber);
  foundData := false;
  for i := 0 to list.Count -1 do Begin
    existingData := (list.Objects[i] as TLevelData);
    if existingData.SpawnName = aData.SpawnName then Begin
      existingData.SpawnCount := existingData.SpawnCount + 1;
      if aData.SpawnMinHealth < existingData.SpawnMinHealth then
        existingData.SpawnMinHealth := aData.SpawnMinHealth;
      if aData.SpawnMaxHealth > existingData.SpawnMaxHealth then
        existingData.SpawnMaxHealth := aData.SpawnMaxHealth;
      existingData.SpawnItem := existingData.SpawnItem + aData.SpawnItem;
      existingData.SpawnBoss := existingData.SpawnBoss + aData.SpawnBoss;
      //Add Each detail
      existingData.aSub.AddObject(IntToStr(existingData.aSub.Count),aData.tmpSub);
      foundData := true;
    end;
  end;
  if foundData = false then Begin
     aData.aSub.AddObject(IntToStr(aData.aSub.Count),aData.tmpSub);
     list.AddObject(aData.SpawnName,aData);
  end;
end;

constructor TLevelsData.create;
begin
  list := TStringList.Create;
  list.Sorted := true;
  list.Duplicates := dupIgnore;
end;

function TLevelsData.getData(spawnName: String): TLevelData;
Var
  existingData, foundData : TLevelData;
  i : integer;
begin
  foundData := nil;
  for i := 0 to list.Count -1 do Begin
    existingData := (list.Objects[i] as TLevelData);
    if existingData.SpawnName = SpawnName then
      foundData := existingData;
  end;
  Result := foundData;
end;



function TLevelsData.stripData(listData: TStringList;lineNumber:Integer): TLevelData;
Var
  i, iHealth, iSpawnLineNumber : integer;
  aData : TLevelData;
  s : string;
  aSub : TLevelDataSub;
begin
  aData := TLevelData.Create;
  aSub := TLevelDataSub.Create;
  aSub.LineNumber := lineNumber;
  aData.SpawnName := '';
  iHealth := 0;
  aData.SpawnCount := 1;
  aData.SpawnItem := 0;
  aData.SpawnBoss := 0;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if PosStr('spawn',s) > 0 then Begin
      aData.SpawnName := strip2Bar('spawn',s);
      iSpawnLineNumber := i;
    end;
    if PosStr('health',s) > 0 then Begin
      try
        aSub.health := strip2Bar('health',s);
        iHealth := StrToInt(strip2Bar('health',s));
      except
        iHealth := 0;
      end;
    end;
    if PosStr('item',s) > 0 then Begin
      aSub.item := strip2Bar('item',s);
      aData.SpawnItem := 1;
    end;
    if PosStr('boss',s) > 0 then Begin
      aSub.boss := '1'; //strip2Bar('boss',s);
      aData.SpawnBoss := 1; //StrToInt();
    end;
    if PosStr('coords',s) > 0 then Begin
      aSub.coOrds := strip2Bar('coords',s);
    end;
    if PosStr('alias',s) > 0 then Begin
      aSub.alias := strip2Bar('alias',s);
    end;
    if PosStr('at',s) > 0 then Begin
      aSub.at := strip2Bar('at',s);
    end;
    if PosStr('map',s) > 0 then Begin
      aSub.map := strip2Bar('map',s);
    end;
  end;
  aData.SpawnCount := 1;
  aData.SpawnMinHealth := iHealth;
  aData.SpawnMaxHealth := iHealth;
  aData.tmpSub := aSub;
  Result := aData;
end;

{ TLevelData }

constructor TLevelData.Create;
begin
  aSub := TStringList.Create;
end;

end.
