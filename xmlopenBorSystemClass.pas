//V 1.09
//This Class was generated with Total Text Container
//This example is to be used in conjunction with delphi's xml dataBinder.....
//First create a xsd file somewhere on you're pc.... you'll find that in the code tree section to the left under Xml>>Xsd
//Then in delphi File>>New>>Other>>xml data binder. Load up the xsd file and follow instructions.
//Then save xml data binder class that was generated within delphi and call that class in the uses clause of this class.
//Save this class as xmlopenBorSystemClass
unit xmlopenBorSystemClass;
interface
Uses
  xmlopenBorSystem, Classes, graphics, MarioSec, MarioZip;
Type
  ropenBorSystem = Record
    id : Integer;
    gd : String;
    title : String;
    dscrp : String;
    htyp : Integer;
    vald : String;
    lgth : String;
    usd : String;
    avar : string;
    Multiple : Integer;
    iCommand : Integer;
    //New
    Group : string;
    //Scripts
    ScrResult : String;
    ScrName : String;
    ScrCode : String;
    ScrType : integer;
    //Tree only
    hasCommand : boolean;
  end;
  popenBorSystem = ^ropenBorSystem;
Type
  aXmlopenBorSystem = class
  Private
    fxmlFile : String;
    fTree : IXMLTopenBorSystemDef;
    fData :ropenBorSystem;
  Public
    fopenBorSystem : IXMLTopenBorSystemDefList;
    Modified : Boolean;
   //Manipulation
    Function addopenBorSystemData(pData:popenBorSystem):Boolean; Overload;
    Function addopenBorSystemData(rData:ropenBorSystem):Boolean; Overload;
    Function setopenBorSystemData(pData:popenBorSystem):Boolean; Overload;
    Function setopenBorSystemData(rData:ropenBorSystem):Boolean; Overload;
    Function setopenBorSystemData(xmlID:Integer;rData:ropenBorSystem):Boolean; Overload;
    Function setopenBorSystemDataViagd(rData:ropenBorSystem):Boolean;
    Function delopenBorSystemData(pData:popenBorSystem):Boolean; Overload;
    Function delopenBorSystemData(rData:ropenBorSystem):Boolean; Overload;
    Function delopenBorSystemData(ItemID:Integer):Boolean; Overload;
   //Retrieval
    Function getopenBorSystemData(xmlID :Integer):ropenBorSystem;
    Function getopenBorSystemDataViaID(ItemID:Integer):ropenBorSystem;
    Function getopenBorSystemDataViagd(gd:wideString):ropenBorSystem;
    Function pData2openBorSystemrData(pData:popenBorSystem):ropenBorSystem;
    function getGroupList(glossaryType:integer):TStringList;
    Function getHighestopenBorSystemID:Integer;
    Function getopenBorSystemXmlID(pData:popenBorSystem):Integer; Overload;
    Function getopenBorSystemXmlID(rData:ropenBorSystem):Integer; Overload;
    Function getopenBorSystemNew:ropenBorSystem;
    function clearopenBorSystemrData(rData:ropenBorSystem):ropenBorSystem;
   //Misc
    procedure importFromFile(EntitySystemFile:String;asType:Integer);
    Function SavetoFile(xmlFile:String):Boolean;
    {Function SavetoZip:Boolean;
    Function loadFromZip:aXmlopenBorSystem;}
    Function verifyXml(aFileName:String):Boolean;
    constructor Create(xmlFile:String); Overload;
    Destructor Destroy; override;
  end;
implementation
uses SysUtils, XMLIntf, unCommon;
{ aXmlopenBorSystem }
function aXmlopenBorSystem.addopenBorSystemData(pData: popenBorSystem): Boolean;
Var
  rData : ropenBorSystem;
begin
  rData := pData2openBorSystemrData(pData);
  addopenBorSystemData(rData);
end;
function aXmlopenBorSystem.addopenBorSystemData(rData: ropenBorSystem): Boolean;
Begin
  Try
    Result := False;
    //if fopenBorSystem = nil then
    try
      //fopenBorSystem := NewTopenBorSystemList;
    except
    end;
    fTree := fopenBorSystem.Add;
    fTree.id := rData.id;
    fTree.gd := rData.gd;
    fTree.title := rData.title;
    fTree.dscrp := EncodeString(rData.dscrp);
    fTree.htyp := rData.htyp;
    fTree.vald := rData.vald;
    fTree.lgth := rData.lgth;
    fTree.usd := rData.usd;
    fTree.avar := rData.avar;
    fTree.Mltp := rData.Multiple;
    fTree.Icmd := rData.iCommand;
    fTree.Grp := rData.Group;
    //Scripts
    fTree.Rslt := rData.ScrResult;
    fTree.Scnme := rData.ScrName;
    fTree.Sccod := rData.ScrCode;
    fTree.Sctyp := rData.ScrType;

    Result := True;
  Finally
    Modified := True;
  End;
end;
Function aXmlopenBorSystem.setopenBorSystemData(pData:popenBorSystem):Boolean;
Var
  r1Data : ropenBorSystem;
Begin
  Try
    r1Data := pData2openBorSystemrData(pData);
    Result := setopenBorSystemData(r1Data);
  Except
    Result := false;
  End;
End;
Function aXmlopenBorSystem.setopenBorSystemData(rData:ropenBorSystem):Boolean;
Var
  i : integer;
  Found : Boolean;
begin
  Try
  i := 0;
  Result := False;
  if fopenBorSystem <> nil then
    while i < fopenBorSystem.Count do Begin
      If rData.id = fopenBorSystem.TopenBorSystem[i].id then Begin
        Result := setopenBorSystemData(i,rData);
        i:= fopenBorSystem.Count;
        Found := True;
      End;
      inc(i);
    End;
  If Found = false then
    addopenBorSystemData(rData);
  Except
    Result := false;
  End;
End;
Function aXmlopenBorSystem.setopenBorSystemData(xmlID:Integer;rData:ropenBorSystem):Boolean;
begin
  Try
    Result := False;
      fopenBorSystem.TopenBorSystem[xmlID].id := rData.id;
      fopenBorSystem.TopenBorSystem[xmlID].gd := rData.gd;
      fopenBorSystem.TopenBorSystem[xmlID].title := rData.title;
      fopenBorSystem.TopenBorSystem[xmlID].dscrp := EncodeString(rData.dscrp);
      fopenBorSystem.TopenBorSystem[xmlID].htyp := rData.htyp;
      fopenBorSystem.TopenBorSystem[xmlID].vald := rData.vald;
      fopenBorSystem.TopenBorSystem[xmlID].lgth := rData.lgth;
      fopenBorSystem.TopenBorSystem[xmlID].usd := rData.usd;
      fopenBorSystem.TopenBorSystem[xmlID].avar := rData.avar;
      fopenBorSystem.TopenBorSystem[xmlID].Mltp := rData.Multiple;
      fopenBorSystem.TopenBorSystem[xmlID].Icmd := rData.iCommand;
      fopenBorSystem.TopenBorSystem[xmlID].Grp := rData.Group;
      //Scripts
      fopenBorSystem.TopenBorSystem[xmlID].Rslt := rData.ScrResult;
      fopenBorSystem.TopenBorSystem[xmlID].Scnme := rData.ScrName;
      fopenBorSystem.TopenBorSystem[xmlID].Sccod := EncodeString(rData.ScrCode);
      fopenBorSystem.TopenBorSystem[xmlID].Sctyp := rData.ScrType;

    Modified := True;
    Result := True;
  Except
    Result := False;
  End;
End;
function aXmlopenBorSystem.setopenBorSystemDataViagd(rData: ropenBorSystem): Boolean;
Var
  i : integer;
  Found : Boolean;
begin
  Try
  i := 0;
  Result := False;
  if fopenBorSystem <> nil then
    while i < fopenBorSystem.Count do Begin
      If rData.gd = fopenBorSystem.TopenBorSystem[i].gd then Begin
        Result := setopenBorSystemData(i,rData);
        i:= fopenBorSystem.Count;
        Found := True;
      End;
      inc(i);
    End;
  If Found = false then
    addopenBorSystemData(rData);
  Except
    Result := false;
  End;
end;

Function aXmlopenBorSystem.delopenBorSystemData(pData:popenBorSystem):Boolean;
Var
  r1Data : ropenBorSystem;
Begin
  Try
    r1Data := pData2openBorSystemrData(pData);
    Result := delopenBorSystemData(r1Data);
  Except
    Result := false;
  End;
End;
Function aXmlopenBorSystem.delopenBorSystemData(rData:ropenBorSystem):Boolean;
Var
  i : integer;
begin
  Try
  i := 0;
  if fopenBorSystem <> nil then
    while i < fopenBorSystem.Count do Begin
      If rData.id = fopenBorSystem.TopenBorSystem[i].id then Begin
        fopenBorSystem.Delete(i);
        i:= fopenBorSystem.Count;
        Modified := True;
      End;
      inc(i);
    End;
  Result := true;
  Except
    Result := false;
  End;
End;
Function aXmlopenBorSystem.delopenBorSystemData(ItemID:Integer):Boolean;
Var
  i : integer;
begin
  Try
  i := 0;
  if fopenBorSystem <> nil then
    while i < fopenBorSystem.Count do Begin
      If ItemID = fopenBorSystem.TopenBorSystem[i].id then Begin
        fopenBorSystem.Delete(i);
        i:= fopenBorSystem.Count;
        Modified := True;
      End;
      inc(i);
    End;
  Result := true;
  Except
    Result := false;
  End;
End;
function aXmlopenBorSystem.getopenBorSystemData(xmlID: Integer): ropenBorSystem;
Var
  i : Integer;
Begin
  Try
    Try
      fData.id := fopenBorSystem.TopenBorSystem[xmlID].id;
    Except
      fData.id := -1;
    End;
    Try
      fData.gd := fopenBorSystem.TopenBorSystem[xmlID].gd;
    Except
      fData.gd := '';
    End;
    Try
      fData.title := fopenBorSystem.TopenBorSystem[xmlID].title;
    Except
      fData.title := '';
    End;
    Try
      fData.dscrp := DecodeStringStr(fopenBorSystem.TopenBorSystem[xmlID].dscrp);
    Except
      fData.dscrp := '';
    End;
    Try
      fData.htyp := fopenBorSystem.TopenBorSystem[xmlID].htyp;
    Except
      fData.htyp := -1;
    End;
    Try
      fData.vald := fopenBorSystem.TopenBorSystem[xmlID].vald;
    Except
      fData.vald := '';
    End;
    Try
      fData.lgth := fopenBorSystem.TopenBorSystem[xmlID].lgth;
    Except
      fData.lgth := '';
    End;
    Try
      fData.usd := fopenBorSystem.TopenBorSystem[xmlID].usd;
    Except
      fData.usd := '';
    End;
    Try
      fData.avar := fopenBorSystem.TopenBorSystem[xmlID].avar;
    Except
      fData.avar := '';
    End;
    Try
      fData.Multiple := fopenBorSystem.TopenBorSystem[xmlID].Mltp;
    Except
      fData.Multiple := -1;
    End;
    Try
      fData.iCommand := fopenBorSystem.TopenBorSystem[xmlID].Icmd;
    Except
      fData.iCommand := -1;
    End;
    //Script
    Try
      fData.ScrResult := fopenBorSystem.TopenBorSystem[xmlID].Rslt;
    Except
      fData.ScrResult := '';
    End;
    Try
      fData.ScrName := fopenBorSystem.TopenBorSystem[xmlID].Scnme;
    Except
      fData.ScrName := '';
    End;
    Try
      fData.ScrCode := DecodeStringStr(fopenBorSystem.TopenBorSystem[xmlID].Sccod);
    Except
      fData.ScrCode := '';
    End;
    Try
      if fopenBorSystem.TopenBorSystem[xmlID] <> nil then
        fData.ScrType := fopenBorSystem.TopenBorSystem[xmlID].Sctyp;
    Except
      fData.ScrType := -1;
    End;
    Try
      fData.Group := fopenBorSystem.TopenBorSystem[xmlID].Grp;
    Except
      fData.Group := 'none';
    End;

  Finally
    Result := fData;
  End;
end;
function aXmlopenBorSystem.getopenBorSystemDataViaID(ItemID: Integer): ropenBorSystem;
Var
  i : integer;
  rData : ropenBorSystem;
begin
  Try
  rData := clearopenBorSystemrData(rData);
  i := 0;
  if fopenBorSystem <> nil then
    while i < fopenBorSystem.Count do Begin
      If ItemID = fopenBorSystem.TopenBorSystem[i].id then Begin
        rData := getopenBorSystemData(i);
        i:= fopenBorSystem.Count;
    End else
      inc(i);
  End;
  Finally
    Result := rData;
  end;
end;
function aXmlopenBorSystem.getopenBorSystemDataViagd(gd: wideString): ropenBorSystem;
Var
  i : integer;
  rData : ropenBorSystem;
begin
  Try
  i := 0;
  if fopenBorSystem <> nil then
    while i < fopenBorSystem.Count do Begin
      If gd = fopenBorSystem.TopenBorSystem[i].gd then Begin
        rData := getopenBorSystemData(i);
        i:= fopenBorSystem.Count;
    End else
      inc(i);
  End;
  Finally
    Result := rData;
  end;
end;

function aXmlopenBorSystem.getopenBorSystemNew: ropenBorSystem;
Var
  ropenBorSystemData : ropenBorSystem;
  //udtGUID : TGUID;
  //lResult : longint;

Begin
  ropenBorSystemData := clearopenBorSystemrData(ropenBorSystemData);
  ropenBorSystemData.id := getHighestopenBorSystemID + 1;
  //lResult := CoCreateGuid(udtGUID);
  ropenBorSystemData.gd := CreateGuid;
  Result := ropenBorSystemData;
end;
function aXmlopenBorSystem.clearopenBorSystemrData(rData: ropenBorSystem): ropenBorSystem;
Var
  ropenBorSystemData : ropenBorSystem;
Begin
  ropenBorSystemData.id := -1;
  ropenBorSystemData.gd := '';
  ropenBorSystemData.title := '';
  ropenBorSystemData.dscrp := '';
  ropenBorSystemData.htyp := -1;
  ropenBorSystemData.vald := '';
  ropenBorSystemData.lgth := '';
  ropenBorSystemData.usd := '';
  ropenBorSystemData.avar := '';
  ropenBorSystemData.hasCommand := false;
  ropenBorSystemData.Multiple := -1;
  ropenBorSystemData.iCommand := -1;
  //Script
  ropenBorSystemData.ScrResult := '';
  ropenBorSystemData.ScrName := '';
  ropenBorSystemData.ScrCode := '';
  ropenBorSystemData.ScrType := -1;
  Result := ropenBorSystemData;
end;
Function aXmlopenBorSystem.pData2openBorSystemrData(pData:popenBorSystem):ropenBorSystem;
Var
  rData : ropenBorSystem;
begin
  Try
    rData.id := pData.id;
    rData.gd := pData.gd;
    rData.title := pData.title;
    rData.dscrp := pData.dscrp;
    rData.htyp := pData.htyp;
    rData.vald := pData.vald;
    rData.lgth := pData.lgth;
    rData.usd := pData.usd;
    rData.avar := pData.avar;
    rData.hasCommand := pData.hasCommand;
    rData.Multiple := pData.Multiple;
    rData.iCommand := pData.iCommand;
    //New
    rData.Group := pData.Group;
    //Script
    rData.ScrResult := pData.ScrResult;
    rData.ScrName := pData.ScrName;
    rData.ScrCode := pData.ScrCode;
    rData.ScrType := pData.ScrType;
  Finally
    Result := rData;
  End;
End;
Function aXmlopenBorSystem.getHighestopenBorSystemID:Integer;
Var
  i, j : Integer;
Begin
  Try
  j := 0;
    try
      if fopenBorSystem <> nil then
        For i := 0 to fopenBorSystem.Count -1 do Begin
          if j < fopenBorSystem.TopenBorSystem[i].id then
            j := fopenBorSystem.TopenBorSystem[i].id;
        End;
    except
    end;
  Finally
    Result := j;
  End;
End;
Function aXmlopenBorSystem.getopenBorSystemXmlID(pData:popenBorSystem):Integer;
Var
  r1Data : ropenBorSystem;
Begin
  Try
    r1Data := pData2openBorSystemrData(pData);
    Result := getopenBorSystemXmlID(r1Data);
  Except
    Result := -1;
  End;
End;
Function aXmlopenBorSystem.getopenBorSystemXmlID(rData:ropenBorSystem):Integer;
Var
  i, j : integer;
begin
  Try
    i := 0;
    j := -1;
    if fopenBorSystem <> nil then
      while i < fopenBorSystem.Count do Begin
        If rData.id = fopenBorSystem.TopenBorSystem[i].id then Begin
          j := i;
          i:= fopenBorSystem.Count;
        End;
        inc(i);
      End;
  Finally
    Result := j;
  End;
End;
constructor aXmlopenBorSystem.Create(xmlFile:String);
begin
  If FileExists(xmlFile) then Begin
    Try
    fopenBorSystem := LoadTopenBorSystemList(xmlFile)
    Except
      fopenBorSystem := NewTopenBorSystemList;
    End
  End Else
    fopenBorSystem := NewTopenBorSystemList;
  Modified := False;
end;
destructor aXmlopenBorSystem.Destroy;
begin

  inherited Destroy;
end;
function aXmlopenBorSystem.SavetoFile(xmlFile:String): Boolean;
Var
  aList : TStringList;
begin
  Try
    aList := TStringList.Create;
    aList.Text := fopenBorSystem.XML;
    If FileExists(xmlFile) then
      DeleteFile(xmlFile);
    While verifyXml(xmlFile) = false do
      aList.SaveToFile(xmlFile);
    aList.Free;
    Result := True;
    Modified := False;
  Except
    Result := False;
  end;
end;
{//This is more of TTC specific Function
Function aXmlopenBorSystem.SavetoZip:Boolean;
Var
  s : String;
begin
  Try
    Result := True;
    //If ckbxSave.Checked = true then
        If fopenBorSystem <> nil then Begin
          //Form1.setZipOptions(1);
          //s := Form1.tmp +'\openBorSystem.xml';
          SavetoFile(s);
          //ZZAddFile(s,'openBorSystem.xml',Form1.ZipMaster1);
          If FileExists(s) then
            DeleteFile(s);
          Modified := False;
        End;
  except
    Result := False;
  end;
End;
//This is more of TTC specific feature
Function aXmlopenBorSystem.loadFromZip:openBorSystem;
Var
 s : String;
 ax : aXmlopenBorSystem;
Begin
  Try
    //s := Form1.tmp +'\openBorSystem.xml';
    If FileExists(s) then
      DeleteFile(s);
    //ZZExtractFile('openBorSystem.xml',s,Form1.ZipMaster1);
    ax := aXmlopenBorSystem.Create(s);
    If FileExists(s) then
      DeleteFile(s);
    Modified := False;
    Result := ax;
  Except
    Result := ax;
  End;
End;}
//This Function automatically gets called when saving!
//It returns a Ture Value If the XML file is Valid
Function aXmlopenBorSystem.verifyXml(aFileName:String):Boolean;
Var
  tmpXML : IXMLTopenBorSystemDefList;
Begin
  Try
    If FileExists(aFileName) then Begin
      tmpXML := LoadTopenBorSystemList(aFileName);
      Result := True;
      If tmpXML <> nil then
        tmpXML := nil;
    End Else
      Result := False;
  Except
    Result := False;
    If tmpXML <> nil then
      tmpXML := nil;
  End;
End;
procedure aXmlopenBorSystem.importFromFile(EntitySystemFile: String;asType:Integer);
Var
 listData : tstringlist;
 i : Integer;
 s, title, variables : string;
 rData : ropenBorSystem;
begin
  if FileExists(EntitySystemFile) then Begin
    listData := TStringList.Create;
    listData.LoadFromFile(EntitySystemFile);
    for i := 0 to listData.Count -1 do Begin
      s := listData.Strings[i];
      s := strClearAll(s);
      title := s;
      variables := s;
      StringDelete2End(title,' ');
      StringDeleteUp2(variables,' ');
      StringReplace(variables,'{',',');
      StringReplace(variables,'}','');
      variables := strClearStart(variables);
      variables := strClearEnd(variables);
      //StringReplace(variables,' ','');
      //Add to xml
      rData := getopenBorSystemNew;
      rData.title := title;
      rData.avar := variables;
      rData.htyp := asType;
      addopenBorSystemData(rData);
    end;

    listData.Free;
  end;
end;

function aXmlopenBorSystem.getGroupList(
  glossaryType: integer): TStringList;
Var
  listData : TStringList;
  i : integer;
  s : string;
  rData : ropenBorSystem;
begin
  listData := TStringList.Create;
  listData.Sorted := true;
  listData.Duplicates := dupIgnore;

  for i := 0 to fopenBorSystem.Count -1 do Begin
    if fopenBorSystem.TopenBorSystem[i].Htyp = glossaryType then Begin
    //rData := getopenBorSystemData(i);
    //if rData.htyp = glossaryType then Begin
      try
        s := fopenBorSystem.TopenBorSystem[i].Grp;
      except
        s := '';
      end;
      listData.Add(s);
    end;
  end;

  result := listData;
end;

end.
