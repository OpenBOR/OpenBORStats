unit clsEntityDetails;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  unCommon, formFormat, ExtCtrls;

//Yes , you can add script directly in to an entity.txt file....
//You place them between @script and @end_script

type
  TEntityDetailFrames = class(TObject)
  private
  public
    header : tstringList;
    frameNumber, frameCount : integer;

    containsScript : Boolean;
    offSetX, offSetY : Integer;
    moveX, moveA, moveZ : integer;
    bBoxX, bBoxY, bBoxW, bBoxH : Integer;
    attackBoxCommand, atBoxName : String;
    rangeMinX, rangeMaxX : Integer;
    rangeMinA, rangeMaxA : Integer;
    atBoxX, atBoxY, atBoxW, atBoxH, atDmg, atPwr, atFlsh, atBlck, atPause, atDepth : Integer;
    hasAttackBox : Boolean;
    Delay, Loop : Integer;
    frameLine : String;
    frameFile : String;
    //Set Methods
    procedure setMisc(aloop, aDelay:integer;listData:TstringList);
    procedure setOffSet(x, y:integer; listData:TstringList); Overload;
    procedure setOffSet(x, y:integer; listData:Tstrings); Overload;
    procedure setMove(x, a, z : Integer; listData:TStringList);
    procedure setRangeX(min, max : Integer; listData:TStringList);
    procedure setRangeA(min, max : Integer; listData:TStringList);
    procedure setbBox(x, y, w, h : Integer; listData:TStringList);
    procedure setAttackBox(X, Y, W, H, Dmg, Pwr, Flsh, Blck, Pause, Depth : Integer; zatName:String; listData:TStringList);
    function updateAllValue(listData:TStringList;oldFrame:TEntityDetailFrames):TEntityDetailFrames;
    //Strip Commands
    function populatebBox(aFrame:TEntityDetailFrames):TEntityDetailFrames;
    function populateAttackBox(aFrame:TEntityDetailFrames):TEntityDetailFrames;
    function stripAttackBox(var x, y, w, h, dmg, pwr, Blck, Flsh, Pause, Depth :Integer;var Name:String;line2Strip:String):boolean;
    function detectAttackBoxType(line2strip:string):string;
    procedure stripBBox(var x, y, w, h :Integer;line2Strip:String);
    procedure stripRangeX(var min, max : integer;line2Strip:String);
    procedure stripRangeA(var min, max : integer;line2Strip:String);
    function stripDelay(line2Strip:String):String;
    procedure stripOffSet(var x, y :Integer;Line2Strip:string);

    function dublicateFrame(dublicateFrame, originalFrame:TEntityDetailFrames):TEntityDetailFrames;
    constructor create;
  end;

type
  TEntityDetail = class(Tobject)
  private
  public
    containsScript : Boolean;
    LineNumber : integer;
    animeName : string;
    totalFrames : integer;
    totalDelay : integer;

    idleImage : string;

    totalDamage : integer;
    totalSeparateHits : integer;

    header : TStringList;
    frameList : TStringList;
    function getframebyindex(index:integer):TEntityDetailFrames;
    function updateFrame(aFrame:TEntityDetailFrames;aEnt:TEntityDetail):TEntityDetail;
    function updateEntityDetailFromFrameList(entityDetail:TEntityDetail):TEntityDetail;
    function stripAnimeFrames(listData:TStringList;entityDetail:TEntityDetail):TEntityDetail; Overload;
    function stripAnimeFrames(listData:TStrings;entityDetail:TEntityDetail):TEntityDetail; Overload;
    constructor create;
  end;

type
  TEntityDetails = class(TObject)
  private
    function stripEntityDetail(listData:TStringList):TEntityDetail;
    function stripAttackDamage(comand:string):integer;
    function getEntityType(entityDetails:TEntityDetails):String;
  public
    containsScript : Boolean;
    headers : TStringList;
    entityType : String;
    list : TStringList;
    lastKnownLineNumber : integer;
    idleImageF : string;
    iIcon : tImage; //TGraphic;  //TPicture; //TBitmap;// ;
    function getAnimations:TStringList;
    function getIdleImage:string;
    function getIdleImageOffset:String;
    function getIcon:tImage;
    function updateEntityDetail(ent:TEntityDetail;entityDetails:TEntityDetails):TEntityDetails;

    function loadEntitryDetails(FileName:String):TEntityDetails;
    procedure addData(listData:TStringList;LineNumber:integer);
    function getData(animeName:String):TEntityDetail;

    function savetofile(filename:string; entityDetails:TEntityDetails):boolean;

    constructor create;
end;

implementation
uses
  unMain, Math;
{ TEntityDetails }

procedure TEntityDetails.addData(listData: TStringList;LineNumber:integer);
Var
  sCurrentLine : string;
  i: integer;
  aEntityDetail, existingEntityDetail : TEntityDetail;
  scriptFound : Boolean;
begin
  if listData.Count > 0 then Begin

    if (PosStr('@script',sCurrentLine) > 0) then
      scriptFound := true;
    if (PosStr('@end_script',sCurrentLine) > 0) then
      scriptFound := False;

    Application.ProcessMessages;
    aEntityDetail := stripEntityDetail(listData);
    aEntityDetail.LineNumber := LineNumber;
    idleImageF := aEntityDetail.idleImage;
    existingEntityDetail := getData(aEntityDetail.animeName);
    if existingEntityDetail <> nil then Begin
      existingEntityDetail.LineNumber := LineNumber;
      existingEntityDetail.totalFrames := existingEntityDetail.totalFrames + aEntityDetail.totalFrames;
      existingEntityDetail.totalDamage := existingEntityDetail.totalDamage + aEntityDetail.totalDamage;
      existingEntityDetail.totalDelay := existingEntityDetail.totalDelay + aEntityDetail.totalDelay;
      existingEntityDetail.totalSeparateHits := existingEntityDetail.totalSeparateHits + aEntityDetail.totalSeparateHits;
    end else Begin
     list.AddObject(aEntityDetail.animeName,aEntityDetail);
    end;
  end;
end;

constructor TEntityDetails.create;
begin
  list := TStringList.Create;
  list.Sorted := true;
  list.Duplicates := dupIgnore;
  containsScript := true;
  headers := TStringList.Create;
end;

function TEntityDetails.getData(animeName: String): TEntityDetail;
Var
  i : integer;
  currentEntityDetail ,foundEntityDetail : TEntityDetail;
begin
  foundEntityDetail := nil;
  if list <> nil then
    for i := 0 to list.count -1 do Begin
      currentEntityDetail := (list.objects[i] as TEntityDetail);
      if currentEntityDetail.animeName = animeName then
        foundEntityDetail := currentEntityDetail;
    end;
  Result := foundEntityDetail;
end;

function TEntityDetails.loadEntitryDetails(FileName: String): TEntityDetails;
Var
  aEntity : TEntityDetails;
  aFileList, iAnimList : TStringList;
  i, iAnimLineNumber : integer;
  animeNew, scriptFound, firstAnimeFound, nextAnimeStarted : Boolean;
  sCurrentLine : String;
begin
  if not FileExists(FileName) then
    exit;
  aFileList := TStringList.Create;
  iAnimList := TStringList.Create;
  animeNew := false;
  scriptFound := false;
  firstAnimeFound := false;
  nextAnimeStarted := False;

  aEntity := TEntityDetails.create;

  aFileList.LoadFromFile(filename);
  for i := 0 to aFileList.count -1 do Begin
    Try
    sCurrentLine := aFileList.Strings[i];// LowerCase(aFileList.Strings[i]);
    //Check for edited by openBor line and delete
    if PosStr('#|edited',sCurrentLine) > 0 then
      sCurrentLine := '';


    //Detect scripts
    if (PosStr('@script',sCurrentLine) > 0) then
      scriptFound := true;
    if (PosStr('@end_script',sCurrentLine) > 0) then
      scriptFound := False;
    {if scriptFound = false then
      sCurrentLine := strClearAll(sCurrentLine);}
    if isLineEmpty(sCurrentLine) then
      sCurrentLine := '';

    //Search for anim details
    //Search for a Entity creation position
        //if PosStr('anim',sCurrentLine) > 0 then Begin
          if (isNewAnimBlock(sCurrentLine) = true) and
             (scriptFound = false)  then Begin
            if firstAnimeFound = false then Begin
              animeNew := True;
              nextAnimeStarted := false;
            end else Begin
              animeNew := True;
              nextAnimeStarted := True;
            end;

            iAnimLineNumber := i;
            firstAnimeFound := true;
          end;
        //end;
        //Add entity data into datalist
        if (animeNew = true) and
           (nextAnimeStarted = false) then Begin
          if scriptFound = false then Begin
            {if PosStr('@cmd',sCurrentLine) < 1 then
              sCurrentLine := strClearAll(sCurrentLine)
              //sCurrentLine := LowerCase(sCurrentLine)}
          end else Begin
            aEntity.containsScript := true;
          end;
          //if isLineEmpty(sCurrentLine) = false then
          iAnimList.Add(sCurrentLine);
        end;
        //Check for end of Entity state
        if (animeNew = true) and
           (nextAnimeStarted = true) and
             (scriptFound = false) then Begin
          nextAnimeStarted := false;
          aEntity.addData(iAnimList, iAnimLineNumber);
          aEntity.lastKnownLineNumber := iAnimLineNumber;
          iAnimList.Clear;
          iAnimList.Add(sCurrentLine);
        end;
        if firstAnimeFound = false then
          aEntity.headers.Add(sCurrentLine);
     Except
     end;
  end;
  //add final anime block
  aEntity.addData(iAnimList, aFileList.count);
  //Get All other quick info
  aEntity.entityType := getEntityType(aEntity);
  iAnimList.Free;
  aFileList.Free;

  Result := aEntity;
end;

function TEntityDetails.stripEntityDetail(listData: TStringList): TEntityDetail;
Var
  sCurrentLine, tst : string;
  i, iDmge : integer;
  LastDelayValue : integer;
  newFrame, previousFrameattacked, attackFound : Boolean;
  ScriptFound : Boolean;
  aEntityDetail : TEntityDetail;
begin
  newFrame := True;
  LastDelayValue := 0;
  previousFrameattacked := false;
  attackFound := false;
  ScriptFound := false;
  aEntityDetail := TEntityDetail.Create;
  while (isLineEmpty(listData.Strings[0]) = true) and
        ( listData.Count > 0 ) do Begin
       listData.Delete(0);
  end;
  for i := 0 to listData.Count -1 do begin
    sCurrentLine := listData.Strings[i];

    if ( PosStr('@script',sCurrentLine)>0 ) then Begin
      ScriptFound := true;
      aEntityDetail.containsScript := true;
    end;
    if ( PosStr('@end_script',sCurrentLine)>0 ) then
      ScriptFound := false;

    if ( PosStr('@cmd',sCurrentLine) > 0 ) then Begin
      aEntityDetail.containsScript := true;
    end;
    //Add script segment
    if ScriptFound = true then Begin
      aEntityDetail.header.Add(sCurrentLine);
      aEntityDetail.containsScript := true;
    end else Begin
      //if not scripted then continue normally
      //sCurrentLine := strClearStartEnd(sCurrentLine);
      {if (PosStr('@cmd',sCurrentLine) > 0) then Begin
        sCurrentLine := sCurrentLine;
      end else
        sCurrentLine := strClearAll(sCurrentLine);}
      if isLineEmpty(sCurrentLine) = false then
        aEntityDetail.header.Add(sCurrentLine);
      Form1.StringDelete2End(sCurrentLine,'#');

      if isNewAnimBlock(sCurrentLine) = true then
        aEntityDetail.animeName := strip2Bar('anim',sCurrentLine);
      if isDelay(sCurrentLine) = true then Begin
        try
          tst := strip2Bar('delay',sCurrentLine);
          if tst <> '' then
            LastDelayValue :=  StrToInt(tst)
          else
            LastDelayValue := 0;
        except
          LastDelayValue := 0;
        end;
      end;
      //if PosStr('frame',sCurrentLine) > 0 then Begin
      if isFrameBlock(sCurrentLine) = true then Begin
        newFrame := true;
        //if attack wasn't found in loop
        if attackFound = false then
          iDmge := 0;
        if iDmge = 0 then
          previousFrameattacked := false;
        aEntityDetail.totalFrames := aEntityDetail.totalFrames + 1;
        aEntityDetail.totalDelay := aEntityDetail.totalDelay + LastDelayValue;
      end;

      //Figure out the attack routine
      if isAttackBlock(sCurrentLine) = true then Begin
          attackFound := true;
          iDmge := stripAttackDamage(sCurrentLine);
          if newFrame = true then
            if iDmge > 0 then Begin
              if previousFrameattacked = false then Begin
                newFrame := false;
                aEntityDetail.totalDamage := aEntityDetail.totalDamage + iDmge;
                aEntityDetail.totalSeparateHits := aEntityDetail.totalSeparateHits + 1;
                previousFrameattacked := true;
              end;
          end;
      end;
    End;
  end;
  //aEntityDetail.totalDelay := aEntityDetail.totalDelay + LastDelayValue;
  aEntityDetail := aEntityDetail.stripAnimeFrames(aEntityDetail.header,aEntityDetail);
  result := aEntityDetail;
end;

function TEntityDetails.stripAttackDamage(comand: string): integer;
Var
  iDmge : integer;
begin
  iDmge := 0;
  //Get rid of all attacks
  //TODO: will need to update to handle all attack types
  //blast
  //shock
  //burn
  //freeze
  //steal
  if ( PosStr('attack',comand) > 0 ) or
     ( PosStr('blast',comand) > 0 ) or
     ( PosStr('shock',comand) > 0 ) or
     ( PosStr('burn',comand) > 0 ) or
     ( PosStr('freeze',comand) > 0 ) or
     ( PosStr('steal',comand) > 0 ) then
  begin
    Form1.StringDeleteUp2(comand,'attack10',7);
    Form1.StringDeleteUp2(comand,'attack9',6);
    Form1.StringDeleteUp2(comand,'attack8',6);
    Form1.StringDeleteUp2(comand,'attack7',6);
    Form1.StringDeleteUp2(comand,'attack6',6);
    Form1.StringDeleteUp2(comand,'attack5',6);
    Form1.StringDeleteUp2(comand,'attack4',6);
    Form1.StringDeleteUp2(comand,'attack3',6);
    Form1.StringDeleteUp2(comand,'attack2',6);
    Form1.StringDeleteUp2(comand,'attack1',6);
    Form1.StringDeleteUp2(comand,'attack',5);

    Form1.StringDeleteUp2(comand,'blast',4);
    Form1.StringDeleteUp2(comand,'shock',4);
    Form1.StringDeleteUp2(comand,'burn',3);
    Form1.StringDeleteUp2(comand,'freeze',5);
    Form1.StringDeleteUp2(comand,'steal',4);

    Form1.StringDeleteFirstChar(comand,' ');
    Form1.StringDeleteFirstChar(comand,#09);
    //Get rif of all for axis's
    Form1.StringDeleteUp2(comand,' ');
    Form1.StringDeleteFirstChar(comand,' ');
    Form1.StringDeleteFirstChar(comand,#09);
    Form1.StringDeleteUp2(comand,' ');
    Form1.StringDeleteFirstChar(comand,' ');
    Form1.StringDeleteFirstChar(comand,#09);
    Form1.StringDeleteUp2(comand,' ');
    Form1.StringDeleteFirstChar(comand,' ');
    Form1.StringDeleteFirstChar(comand,#09);
    Form1.StringDeleteUp2(comand,' ');
    Form1.StringDeleteFirstChar(comand,' ');
    Form1.StringDeleteFirstChar(comand,#09);
    Form1.StringDelete2End(comand,' ');
    Form1.StringDelete2End(comand,#09);
    //Retrieve attack value
    try
      if comand <> '' then
        iDmge := StrToInt(comand)
      else
        iDmge := 0;
    except
      iDmge := 0;
    end;
  end;
  Result := iDmge;
end;

function TEntityDetails.savetofile(filename: string; entityDetails:TEntityDetails): boolean;
Var
  i, j : Integer;
  s : String;
  aEntityDetail : TEntityDetail;
  fileList : TStringList;
begin
  try
    Result := true;
    fileList := TStringList.Create;
    aEntityDetail := TEntityDetail.create;
    //Save Character header details
    for i := 0 to entityDetails.headers.Count -1 do Begin
      s := entityDetails.headers.Strings[i];
      fileList.Add(s);
    end;
    fileList.Add('');
    //Add all Anim data
    for i := 0 to entityDetails.list.Count -1 do Begin
      aEntityDetail := (entityDetails.list.Objects[i] as TEntityDetail);
      for j:= 0 to aEntityDetail.header.Count -1 do Begin
        s := aEntityDetail.header.Strings[j];
        fileList.Add(s);
      end;
      fileList.Add('');
    end;
    fileList.Add('#|edited by ' + form1.caption);
    fileList.Add('');
    fileList := frmFormat.format(fileList);
    fileList.SaveToFile(filename);
    fileList.Free;
  except
    result := false;
  end;
end;

function TEntityDetails.updateEntityDetail(
  ent: TEntityDetail;entityDetails:TEntityDetails): TEntityDetails;
Var
  i : Integer;
  zEnt : TEntityDetail;
  fnd : boolean;
begin
  fnd := false;
  for i:= 0 to entityDetails.list.Count -1 do Begin
    zEnt := entityDetails.list.objects[i] as TEntityDetail;
    //if zEnt.animeName = ent.animeName then Begin
    if zEnt.LineNumber = ent.LineNumber then Begin
    //if (zEnt.animeName = ent.animeName) and
       //(fnd = false) then Begin
      fnd := true;
      zEnt.containsScript := ent.containsScript;
      zEnt.animeName := ent.animeName;
      zEnt.LineNumber := ent.LineNumber;
      zEnt.totalFrames := ent.totalFrames;
      zEnt.totalDelay := ent.totalDelay;
      zEnt.totalDamage := ent.totalDamage;
      zEnt.totalSeparateHits := ent.totalSeparateHits;
      //ent.frameList.Count zEnt.frameList.Count
      //sizeof(zEnt.frameList) sizeof(ent.frameList)
      zEnt.frameList := ent.frameList;
      zEnt.header := ent.header;

    end;
  end;
  Result := entityDetails;
end;

function TEntityDetails.getEntityType(entityDetails:TEntityDetails): String;
Var
  i : integer;
  s : string;
  found : boolean;
begin
  i := 0;
    if entityDetails <> nil then
      while i < entityDetails.headers.Count do Begin
        s := strClearAll(entityDetails.headers.Strings[i]);
        StringDelete2End(s,'#');
        if isEntityType(s) then Begin
          s := strip2Bar('type',s);
          found := true;
          i :=  entityDetails.headers.Count ;
        end;
        inc(i);
      end;
  if found = true then
    Result := s
  else
    Result := '';
end;

function TEntityDetails.getIdleImage: string;
Var
  i, j : integer;
  entityDetail : TEntityDetail;
  s : string;
begin
  i := 0;
  if list <> nil then Begin
    while i < list.Count  do begin
      entityDetail := list.objects[i] as TEntityDetail;
      if entityDetail.animeName = 'idle' then Begin
        j := 0;
        while j < entityDetail.header.Count do Begin
          s := strClearAll(entityDetail.header.Strings[j]);
          If isFrameBlock(s) then Begin
            s := borFile2File(strip2Bar('frame',s));
            j := entityDetail.header.Count;
            i := list.Count;
          end;
          inc(j);
        end;
        i := list.Count;
      end;
      inc(i);
    end;
  end;
  Result := s;
end;

function TEntityDetails.getIdleImageOffset: String;
Var
  i, j : integer;
  entityDetail : TEntityDetail;
  s : string;
begin
  i := 0;
  if list <> nil then
    while i < list.Count  do begin
      entityDetail := list.objects[i] as TEntityDetail;
      if entityDetail <> nil then
        if entityDetail.animeName = 'idle' then Begin
          j := 0;
          while j < entityDetail.header.Count do Begin
            s := strClearAll(entityDetail.header.Strings[j]);
            If PosStr('offset',s) > 0 then Begin
              s := strip2Bar('offset',s);
              j := entityDetail.header.Count;
              i := list.Count;
            end;
            inc(j);
          end;
        i := list.Count;
      end;
      inc(i);
    end;
  Result := s;
end;

function TEntityDetails.getIcon: tImage;
Var
  i : integer;
  s : string;
begin
  i := 0;
  try
  if self <> nil then
  if iIcon = nil then
    if headers <> nil then Begin
      while i < headers.Count do Begin
        //icon	data/chars/rayne/09.gif
        s := LowerCase(headers.Strings[i]);
        s := strClearAll(s);
        if ( Pos('icon',s) > 0) then Begin
          s := borFile2File(strip2Bar('icon',s));
          if (FileExists(Form1.edtDirectory.Text+ '\' + s)) then Begin
            if iIcon = nil then
              iIcon := tImage.Create(nil);
            iIcon.Picture.LoadFromFile(Form1.edtDirectory.Text + '\' + s);
          end;
          i := headers.Count;
        end;
        inc(i);
      end;
    End;
    Result := iIcon;
   except
   end;
end;

function TEntityDetails.getAnimations: TStringList;
Var
  rtrnList : TStringList;
  s : string;
  i : integer;
begin
  rtrnList := TStringList.create;
  i := 0;
  while i < list.Count do begin
    s := list.Strings[i];
    s := strClearAll(s);
    if ( pos('anim',s) > 0) then begin
      StringDeleteUp2(s,' ');
      rtrnList.Add(s);
    end else
      rtrnList.Add(s);
    inc(i);
  end;
  Result := rtrnList;
end;

{ TEntityDetail }

constructor TEntityDetail.create;
begin
  animeName := '';
  containsScript := false;

  totalFrames := 0;
  totalDelay := 0;

  totalDamage := 0;
  totalSeparateHits := 0;

  header := TStringList.Create;
  frameList := TStringList.Create;
end;

function TEntityDetail.stripAnimeFrames(listData: TStringList;entityDetail:TEntityDetail):TEntityDetail;
Var
  i, iFrameNumber: Integer;
  s, tst, sGifFile : String;
  aFrame : TEntityDetailFrames;
  newFrame, scriptFound : Boolean;
  isIdle : boolean;
begin
  newFrame := false;
  iFrameNumber := 1;
  aFrame := TEntityDetailFrames.create;
  scriptFound := false;
  //strip and reset name
  s := listData.Strings[0];
  s := strClearAll(s);
  //s := strRemoveDbls(s);
  //StringReplace(s,#09,' ');
  StringDeleteUp2(s,' ');
  entityDetail.animeName := s;
  s := 'anim' + #09 + s;
  listData.Strings[0] := s;

  //Strip rest
  for i := 1 to listData.Count -1 do Begin
    Application.ProcessMessages;
    s := listData.Strings[i];
    //s := strClearAll(s);
    Form1.StringDelete2End(s,'#');
    Form1.StringDeleteLastChar(s,' ');
    Form1.StringDeleteLastChar(s,#09);

    //Search for scripts
    if (PosStr('@script',s)>0) then
      scriptFound := true;
    if (PosStr('@end_script',s)>0) then
      scriptFound := false;
    if (PosStr('@cmd',s) > 0) then begin
      aFrame.containsScript := true;
    end;

    if (scriptFound = true) or
       ( PosStr('@cmd',s) > 0 ) then Begin
      aFrame.header.Add(s);
      aFrame.containsScript := true;
    end Else Begin
      //If is a frame block then start adding it
      if isLineEmpty(s) = false then
        aFrame.header.Add(s);
      if PosStr(' idle',strClearAll(s)) > 0 then
        isIdle := true;
      if PosStr('offset',s) > 0 then
        aFrame.stripOffSet(aFrame.offSetX,aFrame.offSetY,s);
      if isDelay(s) = true then
        aFrame.Delay := StrToInt(aFrame.stripDelay(s));
      if PosStr('loop',s) > 0 then
        Try
          tst := strip2Bar('loop',s);
          if tst <> '' then
            aFrame.Loop := StrToInt(tst)
          else
            aFrame.Loop := 0;
        except
          aFrame.Loop := 0;
        end;
      if isAttackBlock(s) = true then Begin
        aFrame.attackBoxCommand := s;
        aFrame.hasAttackBox := true;
      end;
      if PosStr('bbox',s) > 0 then
        aFrame.stripBBox(aFrame.bBoxX,aFrame.bBoxY,aFrame.bBoxW,aFrame.bBoxH,s);
      if isRangeX(s) = true then
        aFrame.stripRangeX(aFrame.rangeMinX, aFrame.rangeMaxX,s);
      if isRangeA(s) = true then
        aFrame.stripRangeA(aFrame.rangeMinA, aFrame.rangeMaxA,s);
      if isMove(s) = true then Begin
        //check if its x
          if (PosStr('move ',s) > 0) or
             (PosStr('move'+#09,s) > 0)then
             Try
               aFrame.moveX := StrToInt(strip2Bar('move',s));
             Except
               aFrame.moveX := 0;
             end;
          if (PosStr('movea',s) > 0)then
            Try
              aFrame.moveA := StrToInt(strip2Bar('movea',s));
            Except
              aFrame.moveA := 0;
            end;
          if (PosStr('movez',s) > 0)then
            Try
              aFrame.moveZ := StrToInt(strip2Bar('movez',s));
            Except
              aFrame.moveZ := 0;
            end;
      end;
      //if PosStr('frame',s) > 0 then Begin
      if isFrameBlock(s) = true then Begin
        aFrame.frameNumber := iFrameNumber;
        Inc(iFrameNumber);
        aFrame.frameLine := s;
        sGifFile := s;
        Form1.StringReplace(sGifFile,'frame','');
        sGifFile := strClearStartEnd(sGifFile);
        Form1.StringReplace(sGifFile,'data/','');
        Form1.StringReplace(sGifFile,'/','\');
        aFrame.frameFile := sGifFile;
        if isIdle = true then Begin
          entityDetail.idleImage := sGifFile;
          isIdle := false;
        end;
        //aFrame.frameFile := sGifFile;
        newFrame := true;

        //entityDetail.frameList.AddObject(IntToStr(entityDetail.frameList.Count),aFrame);
        entityDetail.frameList.AddObject(aFrame.frameFile,aFrame);
        aFrame := TEntityDetailFrames.create;
      end;
    End;
  end;
  entityDetail.header.text := listData.text;
  Result := entityDetail;
end;


function TEntityDetail.getframebyindex(
  index: integer): TEntityDetailFrames;
Var
  tframe : TEntityDetailFrames;
begin
  if frameList <> nil then
    tframe := frameList.Objects[index] as TEntityDetailFrames;
  Result := tframe;
end;

function TEntityDetail.stripAnimeFrames(listData: TStrings;
  entityDetail: TEntityDetail): TEntityDetail;
Var
  NewList : TStringList;
begin
  NewList := TStringList.Create;
  NewList.Text := listData.Text;
  result := stripAnimeFrames(NewList,entityDetail);
end;

function TEntityDetail.updateEntityDetailFromFrameList(entityDetail:TEntityDetail):TEntityDetail;
Var
  updatedList : TStringList;
  i, j : integer;
  aFrm : TEntityDetailFrames;
  s : String;
begin
  updatedList := TStringList.Create;
  for i := 0 to entityDetail.frameList.Count -1 do Begin
    aFrm := (entityDetail.frameList.Objects[i] as TEntityDetailFrames);
    for j := 0 to aFrm.header.Count - 1 do Begin
      s := aFrm.header.Strings[j];
      updatedList.Add(s);
    end;
  end;  //updatedList.savetofile('c:\123.txt')   entityDetail.header.savetofile('c:\123.txt')

  updatedList.Insert(0, #09 +'anim'+#09+entityDetail.animeName );//entityDetail.header.Strings[0]);
  entityDetail.header.Text := updatedList.Text;
  Result := entityDetail;
end;

function TEntityDetail.updateFrame(aFrame:TEntityDetailFrames;aEnt:TEntityDetail): TEntityDetail;
Var
  i, j : integer;
  newHeader : TStringList;
  aFrm : TEntityDetailFrames;
begin
  newHeader := TStringList.Create;
  for i := 0 to aEnt.frameList.Count - 1 do Begin
    aFrm := (aEnt.framelist.Objects[i] as TEntityDetailFrames);
    if aFrm.frameNumber = aFrame.frameNumber then Begin
      aFrame.setOffSet(aFrame.offSetX,aFrame.offSetY,aFrame.header);
      aFrame.setMisc(aFrame.Loop,aFrame.Delay,aFrame.header);
      aFrame.setMove(aFrame.moveX,aFrame.moveA,aFrame.moveZ,aFrame.header);
      aFrame.setbBox(aFrame.bBoxX,aFrame.bBoxY,aFrame.bBoxW,aFrame.bBoxH,aFrame.header);
      aFrame.setAttackBox(aFrame.atBoxX,aFrame.atBoxY,aFrame.atBoxW,aFrame.atBoxH,
                         aFrame.atDmg,aFrame.atPwr,aFrame.atFlsh,aFrame.atBlck,
                         aFrame.atPause,aFrame.atDepth,aFrame.atBoxName,aFrame.header);
      aFrm.header.Text := aFrame.header.Text;
      aFrm.frameNumber := aFrame.frameNumber;
      aFrm.offSetX := aFrame.offSetX;
      aFrm.offSetY := aFrame.offSetY;
      aFrm.moveX := aFrame.moveX;
      aFrm.moveA := aFrame.moveA;
      aFrm.moveZ := aFrame.moveZ;
      aFrm.bBoxX := aFrame.bBoxX;
      aFrm.bBoxY := aFrame.bBoxY;
      aFrm.bBoxW := aFrame.bBoxW;
      aFrm.bBoxH := aFrame.bBoxH;
      aFrm.attackBoxCommand := aFrame.attackBoxCommand;
      aFrm.atBoxX := aFrame.atBoxX;
      aFrm.atBoxY := aFrame.atBoxY;
      aFrm.atBoxW := aFrame.atBoxW;
      aFrm.atBoxH := aFrame.atBoxH;
      aFrm.atDmg := aFrame.atDmg;
      aFrm.atPwr := aFrame.atPwr;
      aFrm.atFlsh := aFrame.atFlsh;
      aFrm.atBlck := aFrame.atBlck;
      aFrm.atPause := aFrame.atPause;
      aFrm.atDepth := aFrame.atDepth;
      aFrm.hasAttackBox := aFrame.hasAttackBox;
      aFrm.Delay := aFrame.Delay;
      aFrm.Loop := aFrame.Loop;
      aFrm.frameLine := aFrame.frameLine;
      aFrm.frameFile := aFrame.frameFile;
      aFrm.atBoxName := aFrame.atBoxName;
    end;
    for j := 0 to aFrm.header.Count -1 do
      newHeader.Add(aFrm.header.Strings[j]);
  end;
  aEnt.header.Text := newHeader.Text;
  aEnt.header.Insert(0,'anim'+#09+aEnt.animeName);
  Result := aEnt;
  newHeader.Free;
end;

{ TEntityDetailFrames }

constructor TEntityDetailFrames.create;
begin
  header := TStringList.Create;
  containsScript := false;
  frameLine := '';
  frameFile := '';
  offSetX := 0;
  offSetY := 0;
  Delay := 0;
  Loop := 0;
  moveX := 0;
  moveA := 0;
  moveZ := 0;
  bBoxX := 0;
  bBoxY := 0;
  bBoxW := 0;
  bBoxH := 0;
  rangeMinX := 0;
  rangeMaxX := 0;
  rangeMinA := 0;
  rangeMaxA := 0;
  hasAttackBox := false;
end;

procedure TEntityDetailFrames.setOffSet(x, y:integer;listData:TstringList);
Var
  i : Integer;
  s, offSet : String;
  found : boolean;
begin
  found := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if PosStr('offset', s) > 0 then Begin
      offSet := #09 + 'offset' + #09 + IntToStr(x) + ' ' + IntToStr(y);
      listData.Strings[i] := offSet;
      offSetX := x;
      offSetY := y;
      found := True;
    end;
  End;
  if found = false then Begin
    offSetX := 0;
    offSetY := 0;
  end;
end;

procedure TEntityDetailFrames.setMove(x, a, z: Integer;
  listData: TStringList);
Var
  i : Integer;
  s, newLine : String;
  found : Boolean;
begin
  found := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if isMove(s) = true then Begin
      //check if its x
      if (PosStr('move ',s) > 0) or
         (PosStr('move'+#09,s) > 0)then Begin
         newLine := #09+'move'+#09+IntToStr(x);
         listData.Strings[i] := newLine;
         moveX := x;
      end;
      if (PosStr('movea',s) > 0)then Begin
        newLine := #09+'movea'+#09+IntToStr(a);
        listData.Strings[i] := newLine;
        moveA := a;
      end;
      if (PosStr('movez',s) > 0)then Begin
        newLine := #09+'movez'+#09+IntToStr(z);
        listData.Strings[i] := newLine;
        moveZ := z;
      end;
      found := true;
    end;
  End;
  if found = false then Begin
    moveX := 0;
    moveA := 0;
    moveZ := 0
  end;
end;

procedure TEntityDetailFrames.setOffSet(x, y: integer; listData: Tstrings);
Var
  i : Integer;
  s, offSet : String;
  found : boolean;
begin
  found := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if PosStr('offset', s) > 0 then Begin
      offSet := #09 + 'offset' + #09 + IntToStr(x) + ' ' + IntToStr(y);
      listData.Strings[i] := offSet;
      offSetX := x;
      offSetY := y;
      found := true;
    end;
  End;
  if found = false then Begin
    offSetX := x;
    offSetY := y;
  end;
end;

function TEntityDetailFrames.stripAttackBox(var x, y, w, h, dmg, pwr, Blck, Flsh, Pause, Depth: Integer;
  var Name:String;line2Strip: String):boolean;
Var
  sX, sY, sW, sH, sDmg, sPwr, sFlsh, sBlck, sPause, sDepth : String;
  iSpaces : Integer;
  attacjBoxType : string;
  found : boolean;
begin
  if isAttackBlock(line2Strip) = true then Begin
    found := true;
    //line2Strip := strClearAll(line2Strip);
    Form1.StringDelete2End(line2Strip,'#');
    line2Strip := strRemoveDbls(line2Strip);
    line2Strip := strClearStartEnd(line2Strip);
    Form1.StringReplace(line2Strip,#09,' ');
    name := line2Strip;
    Form1.StringDelete2End(Name,' ');
    Form1.StringDelete2End(Name,#09);
    attacjBoxType := detectAttackBoxType(line2Strip);
    //Form1.StringDeleteUp2(line2Strip,'attack',6);
    Form1.StringDeleteUp2(line2Strip,attacjBoxType,length(attacjBoxType));
    line2Strip := strClearStartEnd(line2Strip);
    line2Strip := strRemoveDbls(line2Strip);

    iSpaces := howManyValues(line2Strip,' ');
    //get x axis
    sX := line2Strip;
    Form1.StringDelete2End(sX,' ');
    Try
      if sX <> '' then
        x := StrToInt(sX)
      else
        x := 0;
    except
      x := 0;
    end;
    iSpaces := iSpaces - 1;
    //get y axis
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sY := line2Strip;
      Form1.StringDelete2End(sY,' ');
      Try
        if sY <> '' then
          y := StrToInt(sY)
        else
          y := 0;
      except
        y := 0;
      end;
    end else
      y := 0;
    iSpaces := iSpaces - 1;
    //get w axis
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sW := line2Strip;
      Form1.StringDelete2End(sW,' ');
      Try
        if sW <> '' then
          w := StrToInt(sW)
        else
          w := 0;
      except
        w := 0;
    end; end else
      w := 0;
    iSpaces := iSpaces - 1;
    //get h axis
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sH := line2Strip;
      Form1.StringDelete2End(sH,' ');
      try
        if sH <> '' then
          h := StrToInt(sH)
        else
          h := 0;
      except
        h := 0;
    end; end else
      h := 0;
    iSpaces := iSpaces - 1;
    //get Damage
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sDmg := line2Strip;
      Form1.StringDelete2End(sdmg,' ');
      try
        if sDmg <> '' then
          dmg := StrToInt(sdmg)
        else
          dmg := 0;
      except
        dmg := 0;
    end; end else
      dmg := 0;
    //Always check if new value exists
    iSpaces := iSpaces - 1;
    //get Power
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sPwr := line2Strip;
      Form1.StringDelete2End(sPwr,' ');
      try
        if sPwr <> '' then
          pwr := StrToInt(sPwr)
        else
          pwr := 0;
      except
        pwr := 0;
    end; end else
      pwr := 0;
     iSpaces := iSpaces - 1;
    //get Block
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sBlck := line2Strip;
      Form1.StringDelete2End(sBlck,' ');
      try
        if sBlck <> '' then
          Blck := StrToInt(sBlck)
        else
          Blck := 0;
      except
        Blck := 1;
    end; end else
      Blck := 0;
    iSpaces := iSpaces - 1;
    //get Flash
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sFlsh := line2Strip;
      Form1.StringDelete2End(sFlsh,' ');
      try
        if sFlsh <> '' then
          Flsh := StrToInt(sFlsh)
        else
          Flsh := 0;
      except
        Flsh := 1;
    end; end else
      Flsh := 0;
    iSpaces := iSpaces - 1;
    //get Pause
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sPause := line2Strip;
      Form1.StringDelete2End(sPause,' ');
      try
        if sPause <> '' then
          Pause := StrToInt(sPause)
        else
          Pause := 0;
      except
        Pause := 0;
    end; end else
      Pause := 0;
    iSpaces := iSpaces - 1;
    //get Depth
    if iSpaces >= 0 then Begin
      Form1.StringDeleteUp2(line2Strip,' ');
      sDepth := line2Strip;
      Form1.StringDelete2End(sDepth,' ');
      try
        if sDepth <> '' then
          Depth := StrToInt(sDepth)
        else
          Depth := 0;
      except
        //TODO: It defaults to their grabdistance. That defaults to 36 if not declared
        Depth := 0;
    end; end else
      Depth := 0;
  end;
  result := found;
end;

procedure TEntityDetailFrames.stripBBox(var x, y, w, h: Integer;line2Strip: String);
Var
  sX, sY, sW, sH : String;
begin
  if PosStr('bbox',line2Strip) > 0 then Begin
    line2Strip := strip2Bar('bbox',line2Strip);
    Form1.StringDelete2End(line2Strip,'#');
    line2Strip := strClearStartEnd(line2Strip);
    line2Strip := strRemoveDbls(line2Strip);
    Form1.StringReplace(line2Strip,#09,' ');
    sX := line2Strip;
    Form1.StringDelete2End(sX,' ');
    Try
      if sx <> '' then
        x := StrToInt(sX)
      else
        x := 0;
    except
      x := 0;
    end;
    Form1.StringDeleteUp2(line2Strip,' ');
    sY := line2Strip;
    Form1.StringDelete2End(sY,' ');
    Try
      if sY <> '' then
        y := StrToInt(sY)
      else
        y := 0;
    except
      y := 0;
    end;
    Form1.StringDeleteUp2(line2Strip,' ');
    sW := line2Strip;
    Form1.StringDelete2End(sW,' ');
    Try
      if sw <> '' then
        w := StrToInt(sW)
      else
        w := 0;
    except
      w := 0;
    end;
    Form1.StringDeleteUp2(line2Strip,' ');
    sH := line2Strip;
    Form1.StringDelete2End(sH,' ');
    try
      if sH <> '' then
        h := StrToInt(sH)
      else
        h := 0;
    except
      h := 0;
    end;
  end;
end;

function TEntityDetailFrames.stripDelay(line2Strip: String): String;
Var
  i : Integer;
begin
  if isDelay(line2Strip) = true then Begin
    Form1.StringDelete2End(line2Strip,'#');
    line2strip := strClearAll(line2Strip);
    line2Strip := strip2Bar('delay',line2Strip);
    //line2Strip := strClearStartEnd(line2Strip);
    //line2Strip := strRemoveDbls(line2Strip);
    //Form1.StringReplace(line2Strip,#09,' ');
  end;
  Try
    if line2Strip <> '' then
      i := StrToInt(line2Strip)
    else
      line2Strip := '0';
  Except
    line2Strip := '0';
  end;
  Result := line2Strip;
end;

procedure TEntityDetailFrames.stripOffSet(var x, y: Integer;
  Line2Strip: string);
Var
  s, s2, s3 : String;
begin
  s := Line2Strip;
  Form1.StringDelete2End(s,'#');
  s := strClearStartEnd(s);
  s := strRemoveDbls(s);
  if PosStr('offset',s) > 0 then Begin
    s2 := strip2Bar('offset',s);
    s2 := strClearAll(s2);
    s3 := s2;
    Form1.StringDelete2End(s2,' ');
    Try
      if s2 <> '' then
        x := StrToInt(s2)
      else
        x := 0;
    except
      x := 0;
    end;
    Form1.StringDeleteUp2(s3,' ');
    s3 := strClearStartEnd(s3);
    Try
      if s3 <> '' then
        y := StrToInt(s3)
      else
        y := 0;
    Except
      y := 0;
    end;
  end;
end;

procedure TEntityDetailFrames.setbBox(x, y, w, h: Integer;
  listData: TStringList);
Var
  i : Integer;
  s, newLine : String;
  found : Boolean;
begin
  found := False;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if PosStr('bbox',s) > 0 then Begin
      newLine := #09 + 'bbox' + #09 + IntToStr(x) + ' ' + IntToStr(y) + ' ' + IntToStr(w) + ' ' + IntToStr(h) + ' ';
      listData.Strings[i] := newLine;
      bBoxX := x;
      bBoxY := y;
      bBoxW := w;
      bBoxH := h;
      found := True;
    end;
  End;
  if found = false then Begin
    bBoxX := 0;
    bBoxY := 0;
    bBoxW := 0;
    bBoxH := 0;
  end;
end;

procedure TEntityDetailFrames.setAttackBox(X, Y, W, H, Dmg, Pwr, Flsh,
  Blck, Pause, Depth: Integer; zatName: String; listData: TStringList);
Var
  i : Integer;
  s, newLine : String;
  found : Boolean;
begin
  found := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    {if (PosStr('attack ',s) > 0) or
       (PosStr('attack'+#09,s) > 0) then Begin}
    if isAttackBlock(s) = true then Begin
      newLine := #09 + zatName + #09 + IntToStr(x) + ' ' + IntToStr(y) + ' ' + IntToStr(w) + ' ' + IntToStr(h) + ' '
              + IntToStr(Dmg) + ' ' + IntToStr(Pwr) + ' ' + IntToStr(Flsh) + ' '
              + IntToStr(Blck) + ' ' + IntToStr(Pause) + ' ' + IntToStr(Depth) + ' ';
      listData.Strings[i] := newLine;
      atBoxX := x;
      atBoxY := y;
      atBoxW := w;
      atBoxH := h;
      atDmg := Dmg;
      atPwr := Pwr;
      atFlsh := Flsh;
      atBlck := Blck;
      atPause := Pause;
      atDepth := Depth;
      atBoxName := zatName;
      hasAttackBox := true;
      attackBoxCommand := newLine;
      Found := True;
    end else
    {
    //if (PosStr(zatName,s) > 0) then Begin
    Begin
      newLine := #09 + zatName + #09 + IntToStr(x) + ' ' + IntToStr(y) + ' ' + IntToStr(w) + ' ' + IntToStr(h) + ' '
              + IntToStr(Dmg) + ' ' + IntToStr(Pwr) + ' ' + IntToStr(Flsh) + ' '
              + IntToStr(Blck) + ' ' + IntToStr(Pause) + ' ' + IntToStr(Depth) + ' ';
      listData.Strings[i] := newLine;
      atBoxX := x;
      atBoxY := y;
      atBoxW := w;
      atBoxH := h;
      atDmg := Dmg;
      atPwr := Pwr;
      atFlsh := Flsh;
      atBlck := Blck;
      atPause := Pause;
      atDepth := Depth;
      hasAttackBox := true;
      attackBoxCommand := newLine;
      atBoxName := zatName;
      Found := True;
    end;
    }
  End;
  if found = false then Begin
    atBoxX := 0;
    atBoxY := 0;
    atBoxW := 0;
    atBoxH := 0;
    atDmg := 0;
    atPwr := 0;
    atFlsh := 0;
    atBlck := 0;
    atPause := 0;
    atDepth := 0;
    hasAttackBox := false;
    attackBoxCommand := '';
    zatName := '';
  end;
end;

procedure TEntityDetailFrames.setMisc(aloop, aDelay: integer;
  listData: TstringList);
Var
  i : Integer;
  s, newLine : String;
begin
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if (PosStr('loop',s) > 0) then Begin
       newLine := #09+'loop'+#09+IntToStr(aloop);
       listData.Strings[i] := newLine;
       loop := aloop;
    end;
    if isDelay(s) = true then Begin
      newLine := #09+'delay'+#09+IntToStr(aDelay);
      listData.Strings[i] := newLine;
      Delay := aDelay;
    end;
  End;

end;

function TEntityDetailFrames.updateAllValue(listData:TStringList;oldFrame:TEntityDetailFrames):TEntityDetailFrames;
Var
  i: integer;
  s, sGifFile: string;
  scriptFound : Boolean;
begin
  scriptFound := false;
  for i := 1 to listData.Count -1 do Begin
    s := listData.Strings[i];
    Form1.StringDelete2End(s,'#');
    //Search for scripts
    if (PosStr('@script',s)>0) then
      scriptFound := true;
    if (PosStr('@end_script',s)>0) then
      scriptFound := false;
    if scriptFound = true then Begin
      //oldFrame.header.Add(s);
    end Else Begin
      if PosStr('offset',s) > 0 then
        stripOffSet(oldFrame.offSetX,oldFrame.offSetY,s);
      if isDelay(s) = true then
        oldFrame.Delay := StrToInt(stripDelay(s));
      if PosStr('loop',s) > 0 then
        Try
          oldFrame.Loop := StrToInt(strip2Bar('loop',s));
        Except
          oldFrame.Loop := 0;
        end;
      if PosStr('attack',s) > 0 then Begin
        oldFrame.attackBoxCommand := s;
        oldFrame.hasAttackBox := oldFrame.stripAttackBox(oldFrame.atBoxX, oldFrame.atBoxY, oldFrame.atBoxW, oldFrame.atBoxH, oldFrame.atDmg, oldFrame.atPwr, oldFrame.atBlck, oldFrame.atFlsh, oldFrame.atPause, oldFrame.atDepth,oldFrame.atBoxName,s);
      end;
      if PosStr('bbox',s) > 0 then
        stripBBox(oldFrame.bBoxX,oldFrame.bBoxY,oldFrame.bBoxW,oldFrame.bBoxH,s);
      if isRangeX(s) = true then
        stripRangeX(oldFrame.rangeMinX,oldFrame.rangeMaxX,s);
      if isRangeA(s) = true then
        stripRangeA(oldFrame.rangeMinA, oldFrame.rangeMaxA,s);
      if isMove(s) = true then Begin
        //check if its x
        if (PosStr('move ',s) > 0) or
           (PosStr('move'+#09,s) > 0)then
           Try
             oldFrame.moveX := StrToInt(strip2Bar('move',s));
           Except
             oldFrame.moveX := 0;
           end;
        if (PosStr('movea',s) > 0)then
          Try
            oldFrame.moveA := StrToInt(strip2Bar('movea',s));
          Except
            oldFrame.moveA := 0;
          end;
        if (PosStr('movez',s) > 0)then
          Try
            oldFrame.moveZ := StrToInt(strip2Bar('movez',s));
          Except
            oldFrame.moveZ := 0;
          end;
      end;
      //if PosStr('frame',s) > 0 then Begin
      if isFrameBlock(s) = true then Begin
        oldFrame.frameLine := s;
        sGifFile := s;
        Form1.StringReplace(sGifFile,'frame','');
        sGifFile := strClearStartEnd(sGifFile);
        Form1.StringReplace(sGifFile,'data/','');
        Form1.StringReplace(sGifFile,'/','\');
        oldFrame.frameFile := sGifFile;
        {
         Form1.StringReplace(sGifFile,'frame','');
        sGifFile := strClearStartEnd(sGifFile);
        Form1.StringReplace(sGifFile,'data/','');
        Form1.StringReplace(sGifFile,'/','\');
        aFrame.frameFile := sGifFile;
        }
      end;
    End;
  end;
  Result := oldFrame;
end;

function TEntityDetailFrames.populateAttackBox(
  aFrame: TEntityDetailFrames): TEntityDetailFrames;
Var
  i : integer;
  s : string;
begin
  for i := 0 to aFrame.header.Count -1 do Begin
    s := aFrame.header.Strings[i];
    if isAttackBlock(s) then
      aFrame.hasAttackBox :=  aFrame.stripAttackBox(aFrame.atBoxX,aFrame.atBoxY,aFrame.atBoxW,aFrame.atBoxH,aFrame.atDmg,aFrame.atPwr,aFrame.atBlck ,aFrame.atFlsh,aFrame.atPause,aFrame.atDepth,aFrame.atBoxName,s);
  end;

  Result := aFrame;
end;

function TEntityDetailFrames.populatebBox(
  aFrame: TEntityDetailFrames): TEntityDetailFrames;
Var
  i : integer;
  s : string;
begin
  for i := 0 to aFrame.header.Count -1 do Begin
    s := aFrame.header.Strings[i];
    if isbBox(s) then
      aFrame.stripBBox(aFrame.bBoxX,aFrame.bBoxY,aFrame.bBoxW,aFrame.bBoxH,s);
  end;
  Result := aFrame;
end;

function TEntityDetailFrames.dublicateFrame(dublicateFrame,
  originalFrame: TEntityDetailFrames): TEntityDetailFrames;
begin
  //doesn't do all variables yet.
  dublicateFrame.header.Text := originalFrame.header.Text;
  dublicateFrame.frameNumber := originalFrame.frameNumber;
  dublicateFrame.frameCount := originalFrame.frameNumber;
  dublicateFrame.containsScript := originalFrame.containsScript;
  dublicateFrame.offSetX := originalFrame.offSetX;
  dublicateFrame.offSetY := originalFrame.offSetY;
  dublicateFrame.moveX := originalFrame.moveX;
  dublicateFrame.moveA := originalFrame.moveA;
  dublicateFrame.moveZ := originalFrame.moveZ;
  dublicateFrame.bBoxX := originalFrame.bBoxX;
  dublicateFrame.bBoxY := originalFrame.bBoxY;
  dublicateFrame.bBoxW := originalFrame.bBoxW;
  dublicateFrame.bBoxH := originalFrame.bBoxH;
  dublicateFrame.attackBoxCommand := originalFrame.attackBoxCommand;
  dublicateFrame.atBoxName := originalFrame.atBoxName;
  dublicateFrame.atBoxX := originalFrame.atBoxX;
  dublicateFrame.atBoxY := originalFrame.atBoxY;
  dublicateFrame.atBoxW := originalFrame.atBoxW;
  dublicateFrame.atBoxH := originalFrame.atBoxH;
  dublicateFrame.atDmg := originalFrame.atDmg;
  dublicateFrame.atPwr := originalFrame.atPwr;
  dublicateFrame.atFlsh := originalFrame.atFlsh;
  dublicateFrame.atBlck := originalFrame.atBlck;
  dublicateFrame.atPause := originalFrame.atPause;
  dublicateFrame.atDepth := originalFrame.atDepth;
  dublicateFrame.rangeMinX := originalFrame.rangeMinX;
  dublicateFrame.rangeMaxX := originalFrame.rangeMaxX;
  dublicateFrame.rangeMinA := originalFrame.rangeMinA;
  dublicateFrame.rangeMaxA := originalFrame.rangeMaxA;
  dublicateFrame.hasAttackBox := originalFrame.hasAttackBox;
  dublicateFrame.Delay := originalFrame.Delay;
  dublicateFrame.Loop := originalFrame.Loop;
  dublicateFrame.frameLine := originalFrame.frameLine;
  dublicateFrame.frameFile := originalFrame.frameFile;

  Result := dublicateFrame;
end;

procedure TEntityDetailFrames.stripRangeX(var min, max: integer;
  line2Strip: String);
Var
  sX, sY, sW, sH : String;
begin
  if isRangeX(line2Strip) = true then Begin
    line2Strip := strip2Bar('range',line2Strip);
    sX := strClearAll(line2Strip);
    Form1.StringDelete2End(sX,' ');
    Try
      if sx <> '' then
        min := StrToInt(sX)
      else
        min := 0;
    except
      min := 0;
    end;
    Form1.StringDeleteUp2(line2Strip,' ');
    sY := strClearAll(line2Strip);
    Form1.StringDelete2End(sY,' ');
    Try
      if sY <> '' then
        max := StrToInt(sY)
      else
        max := 0;
    except
      max := 0;
    end;

  end;
end;

procedure TEntityDetailFrames.setRangeX(min, max: Integer;
  listData: TStringList);
Var
  i : Integer;
  s, newLine : String;
  found : Boolean;
begin
  found := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if isRangeX(s) = true then Begin

      newLine := #09+'range'+#09+IntToStr(min)+ ' ' + IntToStr(max);
      listData.Strings[i] := newLine;
      rangeMinX := min;
      rangeMaxX := max;

      found := true;
    end;
  End;
  if found = false then Begin
    rangeMinX := 0;
    rangeMaxX := 0;
  end;
end;

procedure TEntityDetailFrames.setRangeA(min, max: Integer;
  listData: TStringList);
Var
  i : Integer;
  s, newLine : String;
  found : Boolean;
begin
  found := false;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if isRangeA(s) = true then Begin

      newLine := #09+'rangea'+#09+IntToStr(min)+ ' ' + IntToStr(max);
      listData.Strings[i] := newLine;
      rangeMinA := min;
      rangeMaxA := max;

      found := true;
    end;
  End;
  if found = false then Begin
    rangeMinA := 0;
    rangeMaxA := 0;
  end;
end;

procedure TEntityDetailFrames.stripRangeA(var min, max: integer;
  line2Strip: String);
Var
  sX, sY, sW, sH : String;
begin
  if isRangeA(line2Strip) = true then Begin
    line2Strip := strip2Bar('rangea',line2Strip);
    sX := strClearAll(line2Strip);
    Form1.StringDelete2End(sX,' ');
    Try
      if sx <> '' then
        min := StrToInt(sX)
      else
        min := 0;
    except
      min := 0;
    end;
    Form1.StringDeleteUp2(line2Strip,' ');
    sY := strClearAll(line2Strip);
    Form1.StringDelete2End(sY,' ');
    Try
      if sY <> '' then
        max := StrToInt(sY)
      else
        max := 0;
    except
      max := 0;
    end;

  end;
end;

function TEntityDetailFrames.detectAttackBoxType(
  line2strip: string): string;
Var
  s, sType : string;
begin
  if PosStr('blast',line2strip) > 0 then
    sType := 'blast'
  else
  if PosStr('shock',line2strip) > 0 then
    sType := 'shock'
  else
  if PosStr('burn',line2strip) > 0 then
    sType := 'burn'
  else
  if PosStr('freeze',line2strip) > 0 then
    sType := 'freeze'
  else
  if PosStr('steal',line2strip) > 0 then
    sType := 'steal'
  else
  if PosStr('attack20',line2strip) > 0 then
    sType := 'attack20'

  else
  if PosStr('attack19',line2strip) > 0 then
    sType := 'attack19'
  else
  if PosStr('attack18',line2strip) > 0 then
    sType := 'attack18'
  else
  if PosStr('attack17',line2strip) > 0 then
    sType := 'attack17'
  else
  if PosStr('attack16',line2strip) > 0 then
    sType := 'attack16'
  else
  if PosStr('attack15',line2strip) > 0 then
    sType := 'attack15'
  else
  if PosStr('attack14',line2strip) > 0 then
    sType := 'attack14'
  else
  if PosStr('attack13',line2strip) > 0 then
    sType := 'attack13'
  else
  if PosStr('attack13',line2strip) > 0 then
    sType := 'attack13'
  else
  if PosStr('attack12',line2strip) > 0 then
    sType := 'attack12'
  else
  if PosStr('attack11',line2strip) > 0 then
    sType := 'attack11'
  else
  if PosStr('attack10',line2strip) > 0 then
    sType := 'attack10'
  else
  if PosStr('attack9',line2strip) > 0 then
    sType := 'attack9'
  else
  if PosStr('attack8',line2strip) > 0 then
    sType := 'attack8'
  else
  if PosStr('attack7',line2strip) > 0 then
    sType := 'attack7'
  else
  if PosStr('attack6',line2strip) > 0 then
    sType := 'attack6'
  else
  if PosStr('attack5',line2strip) > 0 then
    sType := 'attack5'
  else
  if PosStr('attack4',line2strip) > 0 then
    sType := 'attack4'
  else
  if PosStr('attack3',line2strip) > 0 then
    sType := 'attack3'
  else
  if PosStr('attack2',line2strip) > 0 then
    sType := 'attack2'
  else
  if PosStr('attack1',line2strip) > 0 then
    sType := 'attack1'
  else
  if PosStr('attack',line2strip) > 0 then
    sType := 'attack';

  result := sType;
end;

end.