// V 1.00
unit clsLevelsHeader;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  clsEntityDetails,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings;

type
  TLevelHeaderSetStage =class(TObject)
  private
  Public
    Title : string;
    StageType : integer;
    containsNext : boolean;
    listHeader : TStringList;
    constructor Create;
  end;

type
  TLevelHeaderSet =class(TObject)
  private
    function stripsetStage(listData:TStringList):TLevelHeaderSetStage;
  Public
    Title : string;
    listSetHeader : TStringList;
    listStages : TStringList;
    constructor Create;
  end;

type
  TLevelHeadersData = class(TObject)
  private
    function stripSets(entityLine:TStringList):TLevelHeaderSet;
    function populateEntityDetails(aData:TLevelHeaderSet):TLevelHeaderSet;

    procedure loadLevelsFile;
  public
    LevelsHeader, LevelsFile : TStringList;
    levelsSets : TStringList;
    function getEntityType(itemIndex:Integer):String;
    function getEntityTypeList:TStringList;
    constructor create(zLevelsFile:String);
end;
implementation
uses
  unMain, unCommon;
{ TLevelsData }

constructor TLevelHeadersData.create(zLevelsFile:String);
begin
  levelsHeader := TStringList.Create;
  levelsSets := TStringList.Create;
  levelsSets.Sorted := true;
  levelsSets.Duplicates := dupIgnore;
  LevelsFile := TStringList.Create;
  if FileExists(zLevelsFile) then Begin
    LevelsFile.LoadFromFile(zLevelsFile);
    loadLevelsFile;
  end;

end;

function TLevelHeadersData.getEntityType(itemIndex: Integer): String;
Var
  aData : TLevelHeaderSet;
  s : string;
begin
  {aData := listEntities.Objects[itemIndex] as TLevelHeaderSet;
  s := '';
  if aData <> nil then
    if aData.entityModel <> nil then
      s := aData.entityModel.entityType;}
  Result := s;
end;

function TLevelHeadersData.getEntityTypeList: TStringList;
Var
  aList : TStringList;
  i : integer;
begin
  {aList := TStringList.Create;
  aList.Sorted := true;
  aList.Duplicates := dupIgnore;

  for i := 0 to listEntities.Count -1 do Begin
    aList.Add(getEntityType(i));
  end;

  Result := aList;}
end;

procedure TLevelHeadersData.loadLevelsFile;
Var
  i: integer;
  headerFinished : Boolean;
  scriptFound, NewSet, nextNewSet : Boolean;
  setHeader : Tstringlist;
  aData : TLevelHeaderSet;
  s : string;
begin
  headerFinished := false;
  setHeader := TStringList.Create;
  NewSet := false;
  nextNewSet := false;
  for i := 0 to LevelsFile.Count -1 do Begin
    s := LevelsFile.Strings[i];

    //Detect scripts
    if (PosStr('@script',s) > 0) then
      scriptFound := true;
    if (PosStr('@end_script',s) > 0) then
      scriptFound := False;
    if scriptFound = false then Begin

    end Else Begin
      s := strClearAll(s);
      StringDelete2End(s,'#');
    end;

    if isLevelSetBlock(s) = true then Begin
      if NewSet = true then
        nextNewSet := true;
      NewSet := True;
      headerFinished := True;
    end;
    if (NewSet = true) and
       (nextNewSet = false) then Begin
      setHeader.Add(s);
    end;


    if headerFinished = false then
      LevelsHeader.Add(s);

    if (NewSet = true) and
       (nextNewSet = true) then Begin
      nextNewSet := false;

      aData :=  stripSets(setHeader);
      if adata <> nil then
        levelsSets.AddObject(aData.Title,aData);
      setHeader.Clear;
      setHeader.Add(s);
    end;

 end;
 if setHeader.Count > 0 then Begin
   aData :=  stripSets(setHeader);
   if adata <> nil then
     levelsSets.AddObject(aData.Title,aData);
 end;
 setHeader.Free;
end;


function TLevelHeadersData.populateEntityDetails(
  aData: TLevelHeaderSet): TLevelHeaderSet;
begin
{  if FileExists(ses.dataDirecotry + '\' + aData.entFile) then
    aData.entityModel := aData.entityModel.loadEntitryDetails(ses.dataDirecotry + '\' + aData.entFile);
  Result := aData;}
end;

function TLevelHeadersData.stripSets(entityLine: TStringList): TLevelHeaderSet;
Var
  aData : TLevelHeaderSet;
  canProceed, ScriptFound : Boolean;
  s : string;
  i : Integer;
begin
  canProceed := false;
  ScriptFound := false;
  aData := TLevelHeaderSet.Create;
  try
    s := entityLine.Strings[0];
    aData.Title := strip2Bar('set',s);
  except
    aData.Title := '';
  end;
  {for i := 1 to entityLine.count -1 do Begin
    s := entityLine.Strings[i];
    if (PosStr('@script',sCurrentLine)>0) then
      ScriptFound := true;
    if (PosStr('@end_script',sCurrentLine)>0) then
      ScriptFound := false;
    if ScriptFound = true then Begin

    end else Begin
      s := strClearAll(s);

    end;
  end;}
  aData.listSetHeader.Text := entityLine.Text;
  result := aData;
end;
{ TLevelData }
constructor TLevelHeaderSet.Create;
begin
  listSetHeader := TStringList.Create;
  listStages := TStringList.Create;
end;
{ TLevelHeaderSetStage }

constructor TLevelHeaderSetStage.Create;
begin
  Title := '';
  StageType := -1;
  containsNext := False;
  listHeader := TStringList.Create;
end;

function TLevelHeaderSet.stripsetStage(
  listData: TStringList): TLevelHeaderSetStage;
begin

end;

end.
