unit unCommon;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, ShellApi,
  StdCtrls,
  //clsModels,
  xmlopenBorSystemClass, VirtualTrees, JvPanel,
  GraphicEx, GraphicCompression, jvStrings,GuidEx,ExtCtrls, GIFImage;
type
  rConfig = record
  tempDirectory, sffExtract :String;
  //Images
  imageDir : String;
  noImage : String;
  ofSetImage, ofSetImagePrevious : String;
  atBoxImage, atBoxImagePrevious : String;
  bBoxImage, bBoxImagePrevious : String;
  //Font Colors for character Values
  noValue, hasValue : TColor;
  //Font Colors for scripting
  hasScript : TColor;
  mugen : boolean;
  blankFiles : string;
  debugmode : Boolean;
  //Character Editor
  gifLocation, OffsetPic : integer;
  bBoxInList : boolean;
  //Pen
  penColor : TColor;
  penWidth : integer;
  //depth
  depthangle : integer;
  iView : String;
end;

{type
  rSession = record
  borSys : aXmlopenBorSystem;
  characterDir : string;
  //Directories
  dataDirecotry, localDir, openBorData, testDir : String;
  modelsFile, levelFile : String;
  ropenBorSystemSelected : ropenBorSystem;
  workingEntityDetail : TEntityDetail;
end;}
  function nonecharkey(var Key: Word; Shift: TShiftState): Boolean;
  Function ShowHighLightShw(aEditBox:TEdit; aKey:Word;Tree:TVirtualStringTree):Boolean;

  function paintWall(prntPanl:TJvPanel;x,y,w,h,depth:integer):TJvPanel; overload;
  function paintWall(prntPanl:TJvPanel;x,y,upL,lwrLeft,upR,lwrRight,depth,aheight:integer):TJvPanel; overload;
  function paintWall2(prntPanl:TJvPanel;x,y,upL,lwrLeft,upR,lwrRight,depth,aheight:integer):TJvPanel;

  function registerextlessimag(theimg:timage):timage;

  function strClearStartEnd(sCurrentLine:String):String;
  function strClearStart(sCurrentLine:String):String;
  function strClearEnd(sCurrentLine:String):String;
  function strClearAll(sCurrentLine:String):String;

  function treeVisuals(tree:TVirtualStringTree):TVirtualStringTree;
  function CreateGuid : String;
  function borFile2File(borFileName:string):string;
  function File2BorFile(FileName:string):string;
  Procedure showBubble(Headr, s:String; lgth:Integer=2000);
  //Valid Media
  function isImageFile(sCurrentLine:String):Boolean;
  //Valid Blocks
  function isNewAnimBlock(sCurrentLine:String):Boolean;
  function isAttackBlock(sCurrentLine:String):Boolean;
  function isFrameBlock(sCurrentLine:String):Boolean;
  function isbBox(sCurrentLine:String):Boolean;
  function isLevelSetBlock(sCurrentLine:string):boolean;
  function isSpawnBlock(sCurrentLine:string):boolean;
  function isScriptBlock(sCurrentLine:string):boolean;
  function isRangeX(sCurrentLine:string):boolean;
  function isRangeA(sCurrentLine:string):boolean;
  //level design
  function isSpawn(sCurrentLine:string):boolean;
  function isLoad(sCurrentLine:string):boolean;
  function isItem(sCurrentLine:string):boolean;
  function isWall(sCurrentLine:string):boolean;
  //Valid Functions
  function isDelay(sCurrentLine:String):Boolean;
  function isEntityType(sCurrentLine:String):Boolean;
  function isMove(sCurrentLine:String):Boolean;


  function strRemoveDbls(s:string):string;
  function strRemovetabSpace(s:string):string;
  Procedure StringReplace(Var Str:string;ExistingStr :String; ReplaceWith:String;Single:Boolean=false); Overload;
  function stripEmptyLines(list:TStringList):TStringList;
  Procedure StringDeleteFirstChar(Var StrLine:String;ExistingStr:String);
  Procedure StringDeleteLastChar(Var StrLine:String;ExistingStr:String);
  Procedure StringDelete2End(Var StrLine:String;SubtractStr:String); Overload;
  Procedure StringDeleteUp2(Var StrLine:String;SubtractStr:String;Xtra:integer=-1);
    //Use this to check if a value is the last value or not.
    //so if attack 1 1 1 1 2 normally has 10 values but finishes at 2 then no more values
  function howManyValues(s:String;separater:string):integer;

  Function exeApp(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=false):Boolean;
  function isLineEmpty(s:string):boolean;
  function strip2Bar(command,fullStr:string):string;
  procedure convertPcxDir2GifDir(pcxDir, gifDir, ConvertApplication:String);
  Function DelTree(DirName : string): Boolean;
  Function Int2Bool(I:integer):Boolean;
  Function Bool2Int(bl:Boolean):integer;

  Function exeAppBor(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=false):Boolean; overload;
  Function exeAppBor2(ProgramName  : String):Boolean; overload;

  function getFirstColor(abitmap:TImage):TColor;

Procedure MatStringReplace(Var Str:string;ExistingStr :String; ReplaceWith:String;Single:Boolean=false);
  function MoveDir(const fromDir, toDir: string): Boolean;

Var
  config : rConfig;
  //ses : rSession;

implementation
Uses
  unMain;

  //not sure it works
function getFirstColor(abitmap:TImage):TColor;
var
  i: integer;
  fStringList: TStringList;
  fColor,thefirstcolor: TColor;
  fColorString: string;
  fPal: PLogPalette;

  fBitmapPalEntries: Cardinal;
begin
    thefirstcolor := clFuchsia;

    //try
      fPal := nil;
      //try
        //fStringList := TStringList.Create;
        //Image1.Picture.LoadFromFile( OpenPictureDialog1.Filename );
        if abitmap.Picture.Graphic.Palette <> 0 then
        begin
          GetMem( fPal, Sizeof( TLogPalette ) + Sizeof( TPaletteEntry ) * 255 );
          fPal.palversion := $300;
          fPal.palnumentries := 256;
          fBitmapPalEntries := GetPaletteEntries( abitmap.Picture.Graphic.Palette, 0, 256, fPal.palPalEntry[ 0 ] );
          for i := 0 to 1 do // fBitmapPalEntries - 1 do
          begin
            fColor := fPal.PalPalEntry[ i ].PeBlue shl 16
              + fPal.PalPalEntry[ i ].PeGreen shl 8
              + fPal.PalPalEntry[ i ].PeRed;
            fColorString := ColorToString( fColor );
            if (i = 0) then
              thefirstcolor := fColor;
            //fStringList.Add( fColorString );
          end;
        end;
      {finally; FreeMem( fPal ); end;
      if fStringList.Count = 0 then
        ShowMessage('No palette entries!')
      else
      // add the colors to the colorpicker here
      fStringList.Free;
    finally;
    end;
    }
    result :=  thefirstcolor;
end;

function nonecharkey(var Key: Word; Shift: TShiftState): Boolean;
begin
  Result := false;
  Case key of
    VK_RIGHT : Result := true;
    VK_LEFT  : Result := true;
    VK_UP    : Result := true;
    VK_DOWN  : Result := true;
    VK_END   : Result := true;
    VK_HOME  : Result := true;
    33       : Result := true;
    34       : Result := true;
    VK_INSERT : Result := true;
  End;
end;

Function ShowHighLightShw(aEditBox:TEdit; aKey:Word;Tree:TVirtualStringTree):Boolean;
begin
  If aKey <> null then Begin
    aEditBox.Left := tree.Left + 2;
    aEditBox.Top := Tree.Top + Tree.Height - 40;
    aEditBox.Width := Tree.Width - 22;
    aEditBox.Visible := True;
    aEditBox.Text := aEditBox.Text + char(akey);
    aEditBox.Parent := Tree;
    aEditBox.SetFocus;
    aEditBox.SelStart := length(aEditBox.Text);
    aEditBox.SelLength := 0;
  End;
end;

function treeVisuals(tree:TVirtualStringTree):TVirtualStringTree;
Var
  Image : TBitmap;
  aStream : TMemoryStream;
Begin
  if FileExists(ses.localDir + '\Res\Bck.bmp') then Begin
    {if tree.Background <> nil then
      exit;}
    Randomize;

    Image := TBitmap.Create;
    Image.LoadFromFile(ses.localDir + '\Res\Bck.bmp');
    tree.Background.Graphic := Image;
    //tree.Background.Graphic.LoadFromFile(ses.localDir + '\Res\Bck.bmp');
    //tree.Background.LoadFromFile(ses.localDir + '\Res\Bck.bmp');
    tree.BackgroundOffsetX := random(400);
    Randomize;
    tree.BackgroundOffsetY := random(300);
    tree.TreeOptions.PaintOptions := tree.TreeOptions.PaintOptions + [toShowBackground];
  end;
  Result := tree;
end;

function CreateGuid : String;
var
  aguid : TGuidEx;
  a : TGUID;
Begin
  aguid := TGuidEx.Create;
  a := aguid.NewGuid;
  Result := GUIDToString(a);
end;

Procedure showBubble(Headr, s:String; lgth:Integer=2000);
Begin
  Form1.JvBalloonHint1.ActivateHintPos(nil,Mouse.CursorPos,Headr,s,lgth);
End;


Function exeApp(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=False):Boolean;
Var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  handle : THandle;
  CreateOK : Boolean;
  ab : Cardinal;
  s : String;
begin
    // fill with known state
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);
  {if Paramaters = '' then Begin
    ShellExecute(0, nil, PChar(ProgramName), nil, nil, SW_SHOW);
    {CreateOK := CreateProcess(handle, PChar(ProgramName), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);
  end Else Begin}
    s := ProgramName + ' ' + Paramaters;
    {ShellExecute(handle, nil,
                 pchar(ProgramName),
                 pchar(Paramaters),
                 pchar(ExtractFileDir(ProgramName)), SW_SHOWNORMAL)}
    if UseProgramDir = true then
      CreateOK := CreateProcess(pChar(ProgramName), PChar(Paramaters), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil,
              pchar(ExtractFileDir(ProgramName)), StartInfo, ProcInfo)
    else
      CreateOK := CreateProcess(pChar(ProgramName), PChar(Paramaters), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil,
              nil, StartInfo, ProcInfo);
  //End;
    // check to see if successful
  if CreateOK then
    begin
        //may or may not be needed. Usually wait for child processes
      if Wait then Begin
        ab := WaitForSingleObject(ProcInfo.hProcess, INFINITE);
        while ab > 0 do
          ab := WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end;
    end
  else
    begin
      //ShowMessage('Unable to run '+ProgramName);
     end;

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
  Application.ProcessMessages;
  Result := CreateOK;
End;

function isImageFile(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('frame', sCurrentLine) > 0) or
     (PosStr('.gif', sCurrentLine) > 0) or
     (PosStr('.png', sCurrentLine) > 0) then Begin
    found := True;

    {if PosStr('animation',sCurrentLine) > 0 then
      found := false;}
  end;
  result := found;
end;

function isLineEmpty(s:string):boolean;
Var
  isEmpty : boolean;
begin
  //Form1.StringDeleteLastChar(s,' ');
  s := strClearAll(s);
  if (s = '') or
     (s = ' ') or
     (s = '  ') or
     (s = '   ') or
     (s = '    ') or
     (s = '     ') or
     (s = '      ') or
     (s = '       ') or
     (s = '        ') or
     (s = '         ') or
     (s = #09) or
     (s = #09#09) or
     (s = #09#09#09) or
     (s = #09#09#09#09) or
     (s = #09#09#09#09#09) then
       isEmpty := true
  else
    isEmpty := false;
  Result := isEmpty;
end;

function strip2Bar(command, fullStr: string): string;
var
  s : string;
begin
  //retrieve the value of any given command
  s := fullStr;
  Form1.StringReplace(s,command,'',true);
  s := strClearAll(s);
  {
  Form1.StringDeleteFirstChar(s,' ');
  Form1.StringDeleteFirstChar(s,#09);
  Form1.StringDeleteLastChar(s,' ');
  Form1.StringDeleteLastChar(s,#09);
  }
  result := s;
end;

procedure convertPcxDir2GifDir(pcxDir, gifDir, ConvertApplication:String);
Var
  s : string;
Begin
  if DirectoryExists(pcxDir) then
    if not DirectoryExists(gifDir) then
      CreateDirectory(pChar(gifDir),nil);
    if DirectoryExists(gifDir) then Begin
      //c:\*.jpg /convert=d:\temp\*.gif
      s := ' ' + pcxDir + '\*.pcx /convert="' + gifDir + '\*.gif"';
      Application.ProcessMessages;
      exeApp(ConvertApplication,s,True,False);
    End;
end;

Function DelTree(DirName : string): Boolean;
var
  SHFileOpStruct : TSHFileOpStruct;
  DirBuf : array [0..255] of char;
begin
  try
   Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0) ;
   FillChar(DirBuf, Sizeof(DirBuf), 0 ) ;
   StrPCopy(DirBuf, DirName) ;
   with SHFileOpStruct do begin
    Wnd := 0;
    pFrom := @DirBuf;
    wFunc := FO_DELETE;
    fFlags := FOF_ALLOWUNDO;
    fFlags := fFlags or FOF_NOCONFIRMATION;
    fFlags := fFlags or FOF_SILENT;
   end;
    Result := (SHFileOperation(SHFileOpStruct) = 0) ;
   except
    Result := False;
  end;
end;

Function Int2Bool(I:integer):Boolean;
Begin
  If I = 1 then
    Result := True
  Else
    Result := False;
End;

Function Bool2Int(bl:Boolean):integer;
Begin
  If bl = true then
    Result := 1
  Else
    Result := 0;
End;

function isNewAnimBlock(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  //Consider doing a if anim is full word search.
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('anim', sCurrentLine) > 0) then Begin
    found := True;

    if PosStr('@cmd',sCurrentLine) > 0 then
      found := false;
    if PosStr('animal',sCurrentLine) > 0 then
      found := false;
    if PosStr('followanim',sCurrentLine) > 0 then
      found := false;
    if PosStr('animation',sCurrentLine) > 0 then
      found := false;
    if PosStr('animpos',sCurrentLine) > 0 then
      found := false;

    if PosStr('animnum',sCurrentLine) > 0 then
      found := false;
    if PosStr('bindanimation',sCurrentLine) > 0 then
      found := false;
    if PosStr('animid',sCurrentLine) > 0 then
      found := false;
    if PosStr('"anim',sCurrentLine) > 0 then
      found := false;


  end;
  result := found;
end;

function isAttackBlock(sCurrentLine:String):Boolean;
Var
  found : Boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if PosStr('blast',sCurrentLine) > 0 then Begin
    found := true;
    if PosStr('ani_blast',sCurrentLine) > 0 then
      found := false;
  end else
  if PosStr('freeze',sCurrentLine) > 0 then Begin
    found := true;
    if PosStr('ani_freeze',sCurrentLine) > 0 then
      found := false;
  end else
  if PosStr('burn',sCurrentLine) > 0 then Begin
    found := true;
    if PosStr('ani_burn',sCurrentLine) > 0 then
      found := false;
  end else
  if PosStr('shock',sCurrentLine) > 0 then Begin
    found := true;
    if PosStr('ani_shock',sCurrentLine) > 0 then
      found := false;
  end else
  if PosStr('steal',sCurrentLine) > 0 then Begin
    found := true;
    if PosStr('ani_steal',sCurrentLine) > 0 then
      found := false;
  end else
  if PosStr('attack',sCurrentLine) > 0 then Begin
    found := true;

    if PosStr('@cmd',sCurrentLine) > 0 then
      found := false;
    if PosStr('maxattacks',sCurrentLine) > 0 then
      found := false;
    if PosStr('maxattacktypes',sCurrentLine) > 0 then
      found := false;
    if PosStr('runattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('runjumpattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('chargeattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('attackboth',sCurrentLine) > 0 then
      found := false;
    if PosStr('jumpattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('attackup',sCurrentLine) > 0 then
      found := false;
    if PosStr('attackdown',sCurrentLine) > 0 then
      found := false;
    if PosStr('attackforward',sCurrentLine) > 0 then
      found := false;
    if PosStr('attackbackward',sCurrentLine) > 0 then
      found := false;
    if PosStr('grabattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('riseattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('fastattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('attackone',sCurrentLine) > 0 then
      found := false;
    if PosStr('counterattack',sCurrentLine) > 0 then
      found := false;
    if PosStr('ani_attack',sCurrentLine) > 0 then
      found := false;
    if PosStr('performattack',sCurrentLine) > 0 then
      found := false;
    //Additional possibilities
    if PosStr('sound',sCurrentLine) > 0 then
      found := false;
    if PosStr('frame',sCurrentLine) > 0 then
      found := false;
  end;
  if PosStr('data/',sCurrentLine) > 0 then
     found := false;
  Result := found;
end;

function isDelay(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('delay', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('turndelay',sCurrentLine) > 0 then
      found := false;
    if PosStr('jumpdelay',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;

function isEntityType(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('type', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('subtype',sCurrentLine) > 0 then
      found := false;
    if PosStr('typeshot',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;

function isMove(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('move', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('nomove',sCurrentLine) > 0 then
      found := false;
    if PosStr('remove',sCurrentLine) > 0 then
      found := false;
    if PosStr('aimove',sCurrentLine) > 0 then
      found := false;
    if PosStr('jumpmove',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;

function isFrameBlock(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('frame', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('throwframewait',sCurrentLine) > 0 then
      found := false;
    if PosStr('quakeframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('pshotframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('throwframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('tossframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('jumpframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('shootframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('flipframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('counterframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('spawnframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('summonframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('unsummonframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('weaponframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('dropframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('landframe',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;

function isbBox(sCurrentLine:String):Boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('bbox', sCurrentLine) > 0) then Begin
    found := True;
    {if PosStr('throwframewait',sCurrentLine) > 0 then
      found := false;}
  end;
  result := found;
end;
function isLevelSetBlock(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('set', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('offset',sCurrentLine) > 0 then
      found := false;
    if PosStr('setlayer',sCurrentLine) > 0 then
      found := false;
    if PosStr('risetime',sCurrentLine) > 0 then
      found := false;
    if PosStr('seta',sCurrentLine) > 0 then
      found := false;
    if PosStr('setweap',sCurrentLine) > 0 then
      found := false;
    if PosStr('settime',sCurrentLine) > 0 then
      found := false;
    if PosStr('noreset',sCurrentLine) > 0 then
      found := false;
    if PosStr('setpallet',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;
function isSpawnBlock(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('spawn', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('spawnframe',sCurrentLine) > 0 then
      found := false;
    if PosStr('2pspawn',sCurrentLine) > 0 then
      found := false;
    if PosStr('3pspawn',sCurrentLine) > 0 then
      found := false;
    if PosStr('4pspawn',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;
function isScriptBlock(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('@script', sCurrentLine) > 0) then Begin
    found := True;
    {if PosStr('spawnframe',sCurrentLine) > 0 then
      found := false;    }
  end;
  result := found;
end;
function isRangeX(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('range', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('rangez',sCurrentLine) > 0 then
      found := false;
    if PosStr('rangea',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;

function isRangeA(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('rangea', sCurrentLine) > 0) then Begin
    found := True;
    {if PosStr('rangea',sCurrentLine) > 0 then
      found := false;}
  end;
  result := found;
end;

function isSpawn(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('spawn', sCurrentLine) > 0) then Begin
    found := True;
    if PosStr('spawn1',sCurrentLine) > 0 then
      found := false;
    if PosStr('spawn2',sCurrentLine) > 0 then
      found := false;
    if PosStr('spawn3',sCurrentLine) > 0 then
      found := false;
    if PosStr('spawn4',sCurrentLine) > 0 then
      found := false;
  end;
  result := found;
end;

function isLoad(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('load', sCurrentLine) > 0) then Begin
    found := True;
  end;
  result := found;
end;

function isItem(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('item', sCurrentLine) > 0) then Begin
    found := True;
    {if PosStr('spawn1',sCurrentLine) > 0 then
      found := false;}

  end;
  result := found;
end;

function isWall(sCurrentLine:string):boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('wall', sCurrentLine) > 0) then Begin
    found := True;
    //if PosStr('spawn1',sCurrentLine) > 0 then
    //  found := false;

  end;
  result := found;
end;

function strClearStart(sCurrentLine:String):String;
begin
  Form1.StringDeleteFirstChar(sCurrentLine,' ');
  Form1.StringDeleteFirstChar(sCurrentLine,#09);

  Result := sCurrentLine;
end;

function strClearEnd(sCurrentLine:String):String;
begin
  Form1.StringDeleteLastChar(sCurrentLine,' ');
  Form1.StringDeleteLastChar(sCurrentLine,#09);

  Result := sCurrentLine;
end;

function strRemoveDbls(s:string):string;
Begin
  Form1.StringReplace(s,'  ',' ');
  Form1.StringReplace(s,#09#09,#09);
  Result := s;
end;

function strRemovetabSpace(s:string):string;
Begin
  Form1.StringReplace(s,' '+#09,' ');
  Form1.StringReplace(s,#09+' ',#09);
  Result := s;
end;

procedure StringReplace(var Str: string; ExistingStr,
  ReplaceWith: String; Single: Boolean);
Var
  j :Integer;
Begin
  j := Pos(Lowercase(ExistingStr),Lowercase(Str));
  If Single = false then Begin
   While j <> 0 Do
    Begin
    //Keep finding and replaceing the string
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
     j := Pos(Lowercase(ExistingStr),Lowercase(Str));
    End;
  End Else Begin
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
  End;
end;

function stripEmptyLines(list: TStringList): TStringList;
Var
  i : Integer;
Begin
  i := 0;
  try
  while i < list.Count do Begin
    try
      if list.Strings[i] = '' then
        list.Delete(i)
      else
        inc(i);
    except
      inc(i);
    end;
  end;
  finally
    Result := list;
  end;
end;

procedure StringDeleteFirstChar(var StrLine: String;
  ExistingStr: String);
Var
  s : String;
Begin
  if StrLine <> '' then Begin
    s := StrLine[1];
    While s = ExistingStr do Begin
      try
        Delete(StrLine,1,1);
        if length(s) > 0 then
          s := StrLine[1];
      except
        s := '';
      end;
    End;
  end;
end;

procedure StringDeleteLastChar(var StrLine: String;
  ExistingStr: String);
Var
  s : String;
Begin

  s := StrLine;
  if s <> '' then Begin
    if Length(StrLine) > 1 then
      s := StrLine[Length(StrLine)]
    else
      s := StrLine;
    While (s = ExistingStr) and
          (length(StrLine) > 0) do Begin
      Delete(StrLine,Length(StrLine),1);
      if length(StrLine) > 0 then
        s := StrLine[Length(StrLine)];
    End;
  end;
end;

procedure StringDelete2End(var StrLine: String;
  SubtractStr: String);
begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    Delete(StrLine,Pos(SubtractStr,StrLine),length(StrLine));
   End;
end;

procedure StringDeleteUp2(var StrLine: String; SubtractStr: String;
  Xtra: integer);
begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    if Xtra <> -1 then
      Delete(StrLine,1,Pos(SubtractStr,StrLine)+Xtra)
    else
      Delete(StrLine,1,Pos(SubtractStr,StrLine));
   End;
end;

function howManyValues(s:String;separater:string):integer;
Var
  i,j : integer;
Begin
  i := 0;
  j := PosStr(separater,s);
  while j > 0  do Begin
    delete(s,j,1);
    j := PosStr(separater,s);
    inc(i);
  end;
  result := i;
end;

function paintWall(prntPanl: TJvPanel; x, y, w, h,
  depth: integer):TJvPanel;
begin
  prntPanl.Canvas.Pen.Color := config.penColor;
  //psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear,   psInsideFrame
  prntPanl.Canvas.Pen.Width := config.penWidth;
  prntPanl.Canvas.Pen.Style := psDashDot;
  //Draw top line
  prntPanl.Canvas.MoveTo(x,y);
  prntPanl.Canvas.LineTo(x+w,y);
  //Draw left line
  prntPanl.Canvas.MoveTo(x,y);
  prntPanl.Canvas.LineTo(x,y+h);
  //Draw bottom line
  prntPanl.Canvas.MoveTo(x,y+h);
  prntPanl.Canvas.LineTo(x+w,y+h);
  //Draw right line
  prntPanl.Canvas.MoveTo(x+w,y);
  prntPanl.Canvas.LineTo(x+w,y+h);

  //Draw 3D connections
  prntPanl.Canvas.Pen.Color := config.penColor;
  //Draw top left line
  prntPanl.Canvas.MoveTo(x,y);
  prntPanl.Canvas.LineTo(x-depth,y-depth);
  //Draw top right line
  prntPanl.Canvas.MoveTo(x+w,y);
  prntPanl.Canvas.LineTo((x+w)-depth,y-depth);
  //Draw bottom left line
  prntPanl.Canvas.MoveTo(x,y+h);
  prntPanl.Canvas.LineTo(x-depth,(y+h)-depth);
  prntPanl.Canvas.Pen.Color := clGray;
  //Draw bottom right line
  prntPanl.Canvas.MoveTo(x+w,y+h);
  prntPanl.Canvas.LineTo((x+w)-depth,(y+h)-depth);



  /////Draw rear box
  prntPanl.Canvas.Pen.Color := config.penColor;
  //Draw top line
  prntPanl.Canvas.MoveTo(x-depth,y-depth);
  prntPanl.Canvas.LineTo((x+w)-depth,y-depth);
  //Draw left line
  prntPanl.Canvas.MoveTo(x-depth,y-depth);
  prntPanl.Canvas.LineTo(x-depth,(y+h)-depth);
  prntPanl.Canvas.Pen.Color := clGray;
  //Draw bottom line
  prntPanl.Canvas.MoveTo(x-depth,(y+h)-depth);
  prntPanl.Canvas.LineTo((x+w)-depth,(y+h)-depth);
  //Draw right line
  prntPanl.Canvas.MoveTo((x+w)-depth,y-depth);
  prntPanl.Canvas.LineTo((x+w)-depth,(y+h)-depth);
  {//Draw top line
  prntPanl.Canvas.MoveTo(x-config.depthangle,y-config.depthangle);
  prntPanl.Canvas.LineTo((x+w)-config.depthangle,y-config.depthangle);
  //Draw left line
  prntPanl.Canvas.MoveTo(x-config.depthangle,y-config.depthangle);
  prntPanl.Canvas.LineTo(x-config.depthangle,(y+h)-config.depthangle);
  //Draw bottom line
  prntPanl.Canvas.MoveTo(x-config.depthangle,(y+h)-config.depthangle);
  prntPanl.Canvas.LineTo((x+w)-config.depthangle,(y+h)-config.depthangle);
  //Draw right line
  prntPanl.Canvas.MoveTo((x+w)-config.depthangle,y-config.depthangle);
  prntPanl.Canvas.LineTo((x+w)-config.depthangle,(y+h)-config.depthangle);}
  Result := prntPanl;
end;

function paintWall2(prntPanl:TJvPanel;x,y,upL,lwrLeft,upR,lwrRight,depth,aheight:integer):TJvPanel;
Begin
 //{xpos} {ypos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{alt}
  if prntPanl <> nil then Begin
    prntPanl.Canvas.Pen.Color := config.penColor;
    //psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear,   psInsideFrame
    prntPanl.Canvas.Pen.Width := config.penWidth;

    //Draw Bass bottom
    //Draw bottom line 2 >> 4
    prntPanl.Canvas.Pen.Color := clBlue;
    prntPanl.Canvas.MoveTo(x+lwrLeft,y);
    prntPanl.Canvas.LineTo(x+lwrRight,y);
    //Draw bottom left line 2 >> 1
    prntPanl.Canvas.Pen.Color := clRed;
    prntPanl.Canvas.MoveTo(x+lwrLeft,y);
    prntPanl.Canvas.LineTo(x+upL,y-depth);
    //Draw bottom right line 4 >> 3
    prntPanl.Canvas.Pen.Color := clGreen;
    prntPanl.Canvas.MoveTo(x+lwrRight,y);
    prntPanl.Canvas.LineTo(x+upR,y-depth);
    //Draw top line 1 > 3
    prntPanl.Canvas.Pen.Color := clMaroon;
    prntPanl.Canvas.MoveTo(x+upL,y-depth);
    prntPanl.Canvas.LineTo(x+upR,y-depth);

    //Draw Bass Top
    //Draw bottom line 2 >> 4
    prntPanl.Canvas.Pen.Color := clGray;
    prntPanl.Canvas.MoveTo(x+lwrLeft,y-aheight);
    prntPanl.Canvas.LineTo(x+lwrRight,y-aheight);
    //Draw bottom left line 2 >> 1
    prntPanl.Canvas.MoveTo(x+lwrLeft,y-aheight);
    prntPanl.Canvas.LineTo(x+upL,(y-depth)-aheight);
    //Draw bottom right line 4 >> 3
    prntPanl.Canvas.MoveTo(x+lwrRight,y-aheight);
    prntPanl.Canvas.LineTo(x+upR,(y-depth)-aheight);
    //Draw top line 1 > 3
    prntPanl.Canvas.MoveTo(x+upL,(y-depth)-aheight);
    prntPanl.Canvas.LineTo(x+upR,(y-depth)-aheight);

    //Draw Rear connection
    // 1 > 1
    prntPanl.Canvas.MoveTo(x+upL,y-depth);
    prntPanl.Canvas.LineTo(x+upL,(y-depth)-aheight);
    // 2 > 2
    prntPanl.Canvas.MoveTo(x+lwrLeft,y);
    prntPanl.Canvas.LineTo(x+lwrLeft,y-aheight);
    // 3 > 3
    prntPanl.Canvas.MoveTo(x+upR,y-depth);
    prntPanl.Canvas.LineTo(x+upR,(y-depth)-aheight);
    // 4 > 4
    prntPanl.Canvas.MoveTo(x+lwrRight,y);
    prntPanl.Canvas.LineTo(x+lwrRight,y-aheight);

    Result := prntPanl;
  end;
end;

function paintWall(prntPanl: TJvPanel; x, y, upL, lwrLeft,
  upR, lwrRight, depth, aheight: integer): TJvPanel;
begin
   //{xpos} {ypos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{alt}
  prntPanl.Canvas.Pen.Color := config.penColor;
  //psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear,   psInsideFrame
  prntPanl.Canvas.Pen.Width := config.penWidth;

  //Draw Bass Front
  //Draw bottom line 2 >> 4
  prntPanl.Canvas.Pen.Color := clBlue;
  prntPanl.Canvas.MoveTo(x+lwrLeft,y);
  prntPanl.Canvas.LineTo(x+lwrRight,y);
  //Draw bottom left line 2 >> 1
  prntPanl.Canvas.Pen.Color := clRed;
  prntPanl.Canvas.MoveTo(x+lwrLeft,y);
  prntPanl.Canvas.LineTo(x+upL,y);
  //Draw bottom right line 4 >> 3
  prntPanl.Canvas.Pen.Color := clGreen;
  prntPanl.Canvas.MoveTo(x+lwrRight,y);
  prntPanl.Canvas.LineTo(x+upR,y);
  //Draw top line 1 > 3
  prntPanl.Canvas.Pen.Color := clMaroon;
  prntPanl.Canvas.MoveTo(x+upL,y);
  prntPanl.Canvas.LineTo(x+upR,y);

  //Draw bass front Connect bass rear
  prntPanl.Canvas.Pen.Color := clDkGray;
  //Draw bottom line 1 >> 1
  prntPanl.Canvas.Pen.Color := clRed;
  prntPanl.Canvas.MoveTo(x+upL,y);
  prntPanl.Canvas.LineTo((x+upL)+depth,y-depth);
  //Draw bottom left line 2 >> 2
  prntPanl.Canvas.Pen.Color := clMaroon;
  prntPanl.Canvas.MoveTo(x+lwrLeft,y);
  prntPanl.Canvas.LineTo((x+lwrLeft)+depth,y-depth);
  //Draw bottom right line 3 >> 3
  prntPanl.Canvas.Pen.Color := clGreen;
  prntPanl.Canvas.MoveTo(x+upR,y);
  prntPanl.Canvas.LineTo((x+upR)+depth,y-depth);
  //Draw top line 4 > 4
  prntPanl.Canvas.Pen.Color := clBlue;
  prntPanl.Canvas.MoveTo(x+lwrRight,y);
  prntPanl.Canvas.LineTo((x+lwrRight)+depth,y-depth);

  //Draw Bass Rear
  //prntPanl.Canvas.Pen.Color := clOlive;
  prntPanl.Canvas.Pen.Color := clDkGray;
  //Draw bottom line 2 >> 4
  prntPanl.Canvas.MoveTo((x+lwrLeft)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+lwrRight)+depth,y-depth);
  //Draw bottom left line 2 >> 1
  prntPanl.Canvas.MoveTo((x+lwrLeft)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+upL)+depth,y-depth);
  //Draw bottom right line 4 >> 3
  prntPanl.Canvas.MoveTo((x+lwrRight)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+upR)+depth,y-depth);
  //Draw top line 1 > 3
  prntPanl.Canvas.MoveTo((x+upL)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+upR)+depth,y-depth);

  //Draw Bass Front Connect Height
  //prntPanl.Canvas.Pen.Color := clNavy;
  prntPanl.Canvas.Pen.Color := clBlack;
  //Draw bottom line 1 >> 1
  prntPanl.Canvas.MoveTo(x+upL,y);
  prntPanl.Canvas.LineTo(x+upL,y-aheight);
  //Draw bottom left line 2 >> 2
  prntPanl.Canvas.MoveTo(x+lwrLeft,y);
  prntPanl.Canvas.LineTo(x+lwrLeft,y-aheight);
  //Draw bottom right line 3 >> 3
  prntPanl.Canvas.MoveTo(x+upR,y);
  prntPanl.Canvas.LineTo(x+upR,y-aheight);
  //Draw top line 4 > 4
  prntPanl.Canvas.MoveTo(x+lwrRight,y);
  prntPanl.Canvas.LineTo(x+lwrRight,y-aheight);

  //Draw Bass Rear Connect Height Rear
  //prntPanl.Canvas.Pen.Color := clGreen;
  prntPanl.Canvas.Pen.Color := clDkGray;
  //Draw bottom line 1 >> 1
  prntPanl.Canvas.MoveTo((x+upL)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+upL)+depth,y-depth-aheight);
  //Draw bottom left line 2 >> 2
  prntPanl.Canvas.MoveTo((x+lwrLeft)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+lwrLeft)+depth,y-depth-aheight);
  //Draw bottom right line 3 >> 3
  prntPanl.Canvas.MoveTo((x+upR)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+upR)+depth,y-depth-aheight);
  //Draw top line 4 > 4
  prntPanl.Canvas.MoveTo((x+lwrRight)+depth,y-depth);
  prntPanl.Canvas.LineTo((x+lwrRight)+depth,y-depth-aheight);

  if aHeight > 0 then Begin
    //Draw Height Bass Front
    //Draw bottom line 2 >> 4
    //prntPanl.Canvas.Pen.Color := clLtGray;
    prntPanl.Canvas.Pen.Color := clDkGray;
    prntPanl.Canvas.MoveTo(x+lwrLeft,y-aheight);
    prntPanl.Canvas.LineTo(x+lwrRight,y-aheight);
    //Draw bottom left line 2 >> 1
    prntPanl.Canvas.MoveTo(x+lwrLeft,y-aheight);
    prntPanl.Canvas.LineTo(x+upL,y-aheight);
    //Draw bottom right line 4 >> 3
    prntPanl.Canvas.MoveTo(x+lwrRight,y-aheight);
    prntPanl.Canvas.LineTo(x+upR,y-aheight);
    //Draw top line 1 > 3
    prntPanl.Canvas.MoveTo(x+upL,y-aheight);
    prntPanl.Canvas.LineTo(x+upR,y-aheight);

    //Draw height bass front Connect bass rear
    //prntPanl.Canvas.Pen.Color := clPurple;
    prntPanl.Canvas.Pen.Color := clDkGray;
    //Draw bottom line 1 >> 1
    prntPanl.Canvas.MoveTo(x+upL,y-aheight);
    prntPanl.Canvas.LineTo((x+upL)+depth,y-depth-aheight);
    //Draw bottom left line 2 >> 2
    prntPanl.Canvas.MoveTo(x+lwrLeft,y-aheight);
    prntPanl.Canvas.LineTo((x+lwrLeft)+depth,y-depth-aheight);
    //Draw bottom right line 3 >> 3
    prntPanl.Canvas.MoveTo(x+upR,y-aheight);
    prntPanl.Canvas.LineTo((x+upR)+depth,y-depth-aheight);
    //Draw top line 4 > 4
    prntPanl.Canvas.MoveTo(x+lwrRight,y-aheight);
    prntPanl.Canvas.LineTo((x+lwrRight)+depth,y-depth-aheight);

    //Draw Height Bass Rear
    //prntPanl.Canvas.Pen.Color := clTeal;
    prntPanl.Canvas.Pen.Color := clDkGray;
    //Draw bottom line 2 >> 4
    prntPanl.Canvas.MoveTo((x+lwrLeft)+depth,y-depth-aheight);
    prntPanl.Canvas.LineTo((x+lwrRight)+depth,y-depth-aheight);
    //Draw bottom left line 2 >> 1
    prntPanl.Canvas.MoveTo((x+lwrLeft)+depth,y-depth-aheight);
    prntPanl.Canvas.LineTo((x+upL)+depth,y-depth-aheight);
    //Draw bottom right line 4 >> 3
    prntPanl.Canvas.MoveTo((x+lwrRight)+depth,y-depth-aheight);
    prntPanl.Canvas.LineTo((x+upR)+depth,y-depth-aheight);
    //Draw top line 1 > 3
    prntPanl.Canvas.MoveTo((x+upL)+depth,y-depth-aheight);
    prntPanl.Canvas.LineTo((x+upR)+depth,y-depth-aheight);
  end;
  //Draw line
  //prntPanl.Canvas.MoveTo(x,y);
  //prntPanl.Canvas.LineTo(x,y);
  Result := prntPanl;

end;
function registerextlessimag(theimg:timage):timage;
Begin
  if LowerCase(config.blankFiles) = 'png' then
    theimg.Picture.RegisterFileFormat('',config.blankFiles,TPNGGraphic)
  else
  if LowerCase(config.blankFiles) = 'gif' then
    theimg.Picture.RegisterFileFormat('',config.blankFiles,TGIFImage);

  result := theimg;
end;


function strClearStartEnd(sCurrentLine:String):String;
begin
  sCurrentLine := strClearStart(sCurrentLine);
  sCurrentLine := strClearEnd(sCurrentLine);

  Result := sCurrentLine;
end;

function strClearAll(sCurrentLine:String):String;
Begin
  //Remove comments
  StringDelete2End(sCurrentLine,'#');
  //Change all tabs to spaces
  StringReplace(sCurrentLine,#09,' ');
  //Remove space tabs
  sCurrentLine := strRemovetabSpace(sCurrentLine);
  //Remove dbl spaces and tabs
  sCurrentLine := strRemoveDbls(sCurrentLine);
  //Trim text
  sCurrentLine := strClearStartEnd(sCurrentLine);
  //Lowercase
  sCurrentLine := LowerCase(sCurrentLine);
  Result := sCurrentLine;
end;


function borFile2File(borFileName:string):string;
Begin
  borFileName := strClearStartEnd(borFileName);
  StringReplace(borFileName,'data/','');
  StringReplace(borFileName,'/','\');
  Result := borFileName;
end;

function File2BorFile(FileName:string):string;
Begin
  FileName := strClearAll(FileName);
  if FileExists(FileName) then Begin
    StringReplace(FileName,'\','/');
    StringDeleteUp2(FileName,'/data/',5);
  end;
  StringReplace(FileName,'\','/');
  FileName := 'data/' + FileName;
  Result := FileName;
end;

Function exeAppBor(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=false):Boolean;
Var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  handle : THandle;
  CreateOK : Boolean;
  ab : Cardinal;
  s : String;
begin
    // fill with known state
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);
  if UseProgramDir = false then
  if Paramaters = '' then Begin
    ShellExecute(0, nil, PChar(ProgramName), nil, nil, SW_SHOW);
    {CreateOK := CreateProcess(handle, PChar(ProgramName), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);}
  end Else Begin
    s := ProgramName + ' ' + Paramaters;
    ShellExecute(handle, nil,
                 pchar(ProgramName),
                 pchar(Paramaters),
                 pchar(ExtractFileDir(ProgramName)), SW_SHOWNORMAL);
  end;
    if UseProgramDir = true then
      CreateOK := CreateProcess(pChar(ProgramName), PChar(Paramaters), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil,
              pchar(ExtractFileDir(ProgramName)), StartInfo, ProcInfo)
    else
      CreateOK := CreateProcess(pChar(ProgramName), PChar(Paramaters), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil,
              nil, StartInfo, ProcInfo);
  //End;
    // check to see if successful
  {if CreateOK then
    begin
        //may or may not be needed. Usually wait for child processes
      if Wait then Begin
        ab := WaitForSingleObject(ProcInfo.hProcess, INFINITE);
        while ab > 0 do
          ab := WaitForSingleObject(ProcInfo.hProcess, INFINITE);
      end;
    end
  else
    begin
      //ShowMessage('Unable to run '+ProgramName);
     end;}

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
  Application.ProcessMessages;
  Result := CreateOK;
End;

Function exeAppBor2(ProgramName  : String):Boolean; overload;
Begin
  ShellExecute(0, nil, PChar(ProgramName), nil, nil, SW_SHOW);
end;

Procedure MatStringReplace(Var Str:string;ExistingStr :String;
            ReplaceWith:String;Single:Boolean=false);
Var
  j :Integer;
Begin
  j := Pos(Lowercase(ExistingStr),Lowercase(Str));
  If Single = false then Begin
   While j <> 0 Do
    Begin
    //Keep finding and replaceing the string
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
     j := Pos(Lowercase(ExistingStr),Lowercase(Str));
    End;
  End Else Begin
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
  End;
End;

function MoveDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_MOVE;
    //fFlags := FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;

end.