// V 1.01
unit clsModels;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  clsEntityDetails,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  JvThread;
type
  TModelsData =class(TObject)
  private
  Public
    ID : Integer;
    loadType : integer;
    entName : String;
    entFile : String;
    entityModel : TEntityDetails;
    constructor Create;
  end;
type
  TModelssData = class(TObject)
  private
    function stripEntity(entityLine:string):TModelsData;
    function populateEntityDetails(aData:TModelsData):TModelsData;

    procedure loadModelsFile;
    //function getEntityType(itemIndex: Integer): String; overload;
  public
    modelsHeader,listEntities, modelsFile : TStringList;
    function getEntityByName(entName:string):TEntityDetails;
    function getEntityIndexByName(entName:string):integer;
    function getEntityType(itemIndex:Integer):String; overload;
    function getEntityIdleImage(itemIndex:Integer):String;
    function getEntitydependencies(itemIndex:Integer):TStringList;
    function getEntity(itemIndex:Integer):TEntityDetails;
    procedure JvThread1Execute(Sender: TObject; Params: Pointer);
    function getEntityTypeList:TStringList; overload;
    constructor create(zmodelsFile:String);
end;
implementation
uses
  unMain, unCommon;
{ TLevelsData }

constructor TModelssData.create(zmodelsFile:String);

begin
  modelsFile := TStringList.Create;
  modelsHeader := TStringList.Create;
  listEntities := TStringList.Create;
  listEntities.Sorted := true;
  listEntities.Duplicates := dupIgnore;
  if FileExists(zmodelsFile) then Begin
    modelsFile.LoadFromFile(zmodelsFile);
    loadModelsFile;
  end;

end;

procedure TModelssData.JvThread1Execute(Sender: TObject; Params: Pointer);
begin
  loadModelsFile;
end;

function TModelssData.getEntity(itemIndex: Integer): TEntityDetails;
Var
  aData : TModelsData;
  entity : TEntityDetails;
begin
  aData := listEntities.Objects[itemIndex] as TModelsData;
  entity := nil;
  if aData <> nil then
    entity :=  aData.entityModel;
  Result := entity;
end;

function TModelssData.getEntityByName(entName: string): TEntityDetails;
Var
  aData : TModelsData;
  entity : TEntityDetails;
  i : integer;
begin
  i := 0;
  entity := nil;
  while i < listEntities.Count do Begin
    aData := listEntities.Objects[i] as TModelsData;
    if aData.entName = entName then Begin
      entity := aData.entityModel;
      i := listEntities.Count;
    end;
    inc(i);
  end;
  Result := entity;
end;



function TModelssData.getEntityIndexByName(entName: string): integer;
Var
  aData : TModelsData;
  entity : TEntityDetails;
  i,j : integer;
begin
  i := 0;
  entity := nil;
  while i < listEntities.Count do Begin
    aData := listEntities.Objects[i] as TModelsData;
    if aData.entName = entName then Begin
      j := i;
      i := listEntities.Count;
    end;
    inc(i);
  end;
  Result := j;
end;

function TModelssData.getEntitydependencies(
  itemIndex: Integer): TStringList;
Var
  aData : TModelsData;
  s : string;
  i : integer;
  dependencieslist : TStringList;
begin
  aData := listEntities.Objects[itemIndex] as TModelsData;
  dependencieslist := TStringList.Create;
  s := '';
  if aData <> nil then
    if aData.entityModel <> nil then Begin
      i := 0;
      while i < aData.entityModel.headers.Count do begin
        s := strClearAll(aData.entityModel.headers.Strings[i]);
        if pos('load',s) > 0 then Begin
          StringDeleteUp2(s,' ');
          StringDelete2End(s,' ');
          dependencieslist.Add(s);
        end;
        inc(i);
      end;
      s := aData.entityModel.idleImageF;
    end;
  Result := dependencieslist;
end;

function TModelssData.getEntityIdleImage(itemIndex: Integer): String;
Var
  aData : TModelsData;
  s : string;
begin
  aData := listEntities.Objects[itemIndex] as TModelsData;
  s := '';
  if aData <> nil then
    if aData.entityModel <> nil then
      s := aData.entityModel.idleImageF;
  Result := s;
end;

function TModelssData.getEntityType(itemIndex: Integer): String;
Var
  aData : TModelsData;
  s : string;
begin
  aData := listEntities.Objects[itemIndex] as TModelsData;
  s := '';
  if aData <> nil then
    if aData.entityModel <> nil then
      s := aData.entityModel.entityType;
  Result := s;
end;

function TModelssData.getEntityTypeList: TStringList;
Var
  aList : TStringList;
  i : integer;
begin
  aList := TStringList.Create;
  aList.Sorted := true;
  aList.Duplicates := dupIgnore;

  for i := 0 to listEntities.Count -1 do Begin
    aList.Add(getEntityType(i));
  end;

  Result := aList;
end;

procedure TModelssData.loadModelsFile;
Var
  i: integer;
  headerFinished : Boolean;
  scriptFound : Boolean;
  aData : TModelsData;
  s : string;
begin
  headerFinished := false;
  for i := 0 to modelsFile.Count -1 do Begin
    s := modelsFile.Strings[i];

    //Detect scripts
    if (PosStr('@script',s) > 0) then
      scriptFound := true;
    if (PosStr('@end_script',s) > 0) then
      scriptFound := False;

    if headerFinished = false then
      modelsHeader.Add(s);

    if (scriptFound = true) or
       (PosStr('#',s) > 0) then Begin

    end else Begin
      s := strClearAll(s);
      StringReplace(s,#09,' ');
      aData := stripEntity(s);
      if aData <> nil then Begin
        aData := populateEntityDetails(aData);
        listEntities.AddObject(aData.entName,aData);
        headerFinished := true;
      end;
    end;
 end;
end;


function TModelssData.populateEntityDetails(
  aData: TModelsData): TModelsData;
var
  athread : TJvThread;
begin
  if FileExists(ses.dataDirecotry + '\' + aData.entFile) then Begin

    aData.entityModel := aData.entityModel.loadEntitryDetails(ses.dataDirecotry + '\' + aData.entFile);
  end;
  Result := aData;
end;

function TModelssData.stripEntity(entityLine: string): TModelsData;
Var
  aData : TModelsData;
  canProceed : Boolean;
  s : string;
begin
  canProceed := false;
  aData := nil;
  if (PosStr('load ', entityLine) > 0) or
     (PosStr('know ', entityLine) > 0) then Begin
        aData := TModelsData.Create;
        StringDeleteUp2(entityLine,' ');
        s := entityLine;
        StringDelete2End(s,' ');
        StringDeleteUp2(entityLine,' ');
        aData.entName := strClearStartEnd(s);
        StringReplace(entityLine,'data/','');
        StringReplace(entityLine,'/','\');
        aData.entFile := strClearStartEnd(entityLine);
  end;

  result := aData;
end;
{ TLevelData }
constructor TModelsData.Create;
begin
  ID := 0;
  entName := '';
  entFile := '';
  entityModel := nil;
end;
end.
