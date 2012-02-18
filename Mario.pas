unit Mario;//V0.60
//A unit with usefull Methods

interface

uses
  Windows, SysUtils, Classes, IniFiles, Registry, ShlObj, Tlhelp32, ShellApi,
  JclMime, Jpeg, Graphics, URLMon, JclShell, Controls, ImgList, TntClasses,
  JvBalloonHint, JvDialogs, JvComCtrls, Forms, ExtCtrls, TntStdCtrls,
  JvFormWallpaper, JvPanel;


type
  PHICON = ^HICON;

  TIntArr8 = array [0..7] of integer;

//------------------------------------------------------------------------------
          ////////Procedures that use's basic units////////
//------------------------------------------------------------------------------
//Procedure SerielFileCreate1(Sender:TObject;MyFile:String);

Function MatInt2Bool(I:integer):Boolean;
Function MatBool2Int(bl:Boolean):integer;
Function MatBool2Str(bl:Boolean):String;
Procedure MatDirSubStructure(StartDir,WildCard:String;Var FileList:TStringList;
            Var DirList:TStringList;IncludeDetails:Boolean);

Procedure MatDirCopy(StartDir:String;Destination:String);
Procedure MatDirMirrorCopy(StartDir:String;Destination:String);
Function MatDirLocal(StarDir:String;Destination:String):String;
Function MatStringDelete(Var StrLine:String;SubtractStr:String):Boolean;
Procedure MatStringDeleteFirstChar(Var StrLine:String;ExistingStr:String); Overload;
Procedure MatStringDeleteFirstChar(Var StrLine:WideString;ExistingStr:WideString); overload;
Procedure MatStringDeleteLastChar(Var StrLine:String;ExistingStr:String); Overload;
Procedure MatStringDeleteLastChar(Var StrLine:WideString;ExistingStr:WideString); Overload;
Procedure MatStringDelete2End(Var StrLine:String;SubtractStr:String); Overload;
Procedure MatStringDelete2End(Var StrLine:WideString;SubtractStr:WideString); Overload;
Procedure MatStringDeleteUp2(Var StrLine:String;SubtractStr:String;Xtra:integer=-1); Overload;
Procedure MatStringDeleteUp2(Var StrLine:WideString;SubtractStr:WideString;Xtra:integer=-1); Overload;
Procedure MatStringDirCheck(Var Dir:String);
Procedure MatStringReplace(Var Str:string;ExistingStr :String; ReplaceWith:String;Single:Boolean=false); Overload;
Procedure MatStringReplace(Var Str:WideString;ExistingStr :WideString; ReplaceWith:WideString;Single:Boolean=false); Overload;
Procedure MatWideStringReplace(Var Str:WideString;ExistingStr :WideString;
            ReplaceWith:WideString);
Procedure MatStringsReplace(Var StrList:TstringList;ExistingStr :String;
            ReplaceWith:String);
Procedure MatStringsDelete2End(var StrList:TStringList;ExistingStr:String);
Procedure MatStringAddComa(Var Str:String); Overload;
Procedure MatStringAddComa(Var Str:WideString); Overload;
function stringListTostrings(listData:TStringList):TStrings;
function stringsTostringList(listData:TStrings):TStringList;
function matStringCopyRemoveBack(Str:String;SearchCharacter:String):String;
function matStringCopyRemoveFrontBack(Str:String;SearchCharacter:String):String;
procedure MatDelay(msec:longint);
function matStringListNotEmpty(aList:TStringList):TStringList;
Function MatString2List(source, Delimiter:String):TStringList;
Function MatString2TntList(source, Delimiter:String;IgnDublicates:Boolean=False):TTntStringList;
Procedure MatStringFindLastSen(Var StrLine:string;DeleteChar:String);

function  MatProcessKill(ExeFileName: string): Integer; //Uses Tlhelp32
Function MatStrToList(s,Delimiter:String):Tstringlist; Overload;
Function MatStrToList(s,Delimiter:WideString):TTntStringList; Overload;
function matListToStr(listData:tstringlist;Delimiter:string):string; Overload;
function matListToStr(listData:tstrings;Delimiter:string):string; overload;
function CountInLine(Str: string): Integer;
function stripEmptyLines(list:TTntStringList):TTntStringList;
//This takes the system settings into consideration
function floatString2DateTime(str:string):TDateTime;

function GetCharFromVirtualKey(Key: Word): string;
//------------------------------------------------------------------------------
           ////////Strip Procedures////////
//------------------------------------------------------------------------------
function stripStringIntegers(s:string; var intarr: TIntArr8):integer;
function getBORCommand(borline : string):string;

//------------------------------------------------------------------------------
           ////////Url Functions////////
//------------------------------------------------------------------------------

function MatUrlgetUrlList(aString:String):TStringList; Overload;

//------------------------------------------------------------------------------
           ////////Procedures that use the Files////////
//------------------------------------------------------------------------------
function  MatTextLineFind(const AFileName: string; ALine: Integer): String;
function  MatGetFileSize(const FileName: string): Integer;
function matFileStripExt(aFileName:String):String;
function matFileGetExt(aFileName:String):String;
procedure MatProcessRunWait(FileName,Paramters:String);
Procedure MatProcessRun( cmdline: String; hidden: Boolean );
function MatFileInUse(fName : string ) : Boolean;
Function MatGetfilesizeEx( const filename: String ): int64;
Function MatCompareFile2Stream(mmstrem:TMemoryStream;filename:String):Boolean;
//------------------------------------------------------------------------------
           ////////Procedures that use the SHELLAPI////////
//------------------------------------------------------------------------------
//Function executeApplication(FileName:String):Boolean; Overload
//Function executeApplicationzz(ProgramName, Paramaters : String; Wait: Boolean):Boolean;
Function exeAppBor(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=false):Boolean;
Function exeApp2(ProgramName  : String):Boolean; overload;
Function exeApp(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=false):Boolean; overload;

//------------------------------------------------------------------------------
           ////////Procedures that use the JPEG unit////////
//------------------------------------------------------------------------------

Procedure MatJpeg2Bmp(JpgImage:TJPEGImage;Var ConvertedBmp:TBitmap);

//------------------------------------------------------------------------------
          ////////Procedures that use the UNIT "Registry"////////
//------------------------------------------------------------------------------
Procedure MatRegistryStartup(AddEntry:Boolean;Title:String;ProgramFile:string);
procedure MatRegistryAssociate(CMyExt:string;CMyFileType:string;
            ProgramFile:string); //Also uses "ShlObj"
//------------------------------------------------------------------------------
          ////////Procedures that use the UNIT "URLMon"////////
//------------------------------------------------------------------------------

function DownloadFile(SourceFile, DestFile: string): Boolean;
function GetSystemDir: TFileName;
Function Component2String(Component: TComponent): string;
Function String2Component(Value: string;aComp: Tobject): TComponent;
procedure GetAssociatedIcon(FileName: TFilename;
    PLargeIcon, PSmallIcon: PHICON);
//------------------------------------------------------------------------------
          ////////Balloon////////
//------------------------------------------------------------------------------
Procedure matMessageMouse(aMessage,Heading:String;Delay:Integer=2000;sender:TJvBalloonHint=nil);
//------------------------------------------------------------------------------
          ////////Jv Dialogs////////
//------------------------------------------------------------------------------
Procedure odSetExtension(oDialog:TJvOpenDialog;ext:WideString); overload;
Procedure odSetExtension(oDialog:TJvOpenDialog;ext:WideString;extDescription:Widestring); overload;
//------------------------------------------------------------------------------
          ////////Other////////
//------------------------------------------------------------------------------
Function isValidBitmap(aFileName:String):Boolean;
Procedure pcSetFont(pController:TJvPageControl;newFont:TFont);
procedure centreFisrtInsideSecond(var innerPanel:TPanel; outerObject:TObject; innersubheight:integer = 0); Overload;
procedure centreFisrtInsideSecond(var innerPanel:TjvPanel; outerObject:TObject; top:integer=0; innersubheight:integer=0); Overload;
procedure centreFisrtInsideSecond(var innerMemo:TTntMemo; outerObject:TObject; innersubheight:integer=0); Overload;
//------------------------------------------------------------------------------
          ////////Dates////////
//------------------------------------------------------------------------------
function stripDateTime(isDate:Boolean;fDateTime:TDateTime):TDateTime;

function CopyDir(const fromDir, toDir: string): Boolean;
function MoveDir(const fromDir, toDir: string): Boolean;
function DelDir(dir: string): Boolean;

implementation

uses VarCmplx;

//Create a proccess and locks until its closed
{Function executeApplication(FileName:String):Boolean;
var
  StartupInfo: TStartupinfo;
  ProcessInfo: TProcessInformation;
  ShortFileName, DirNme, s : String;
begin
  Try
    If FileName = '' then
      exit;
    Result := True;
    FillChar(Startupinfo,Sizeof(TStartupinfo),0);
    Startupinfo.cb:=Sizeof(TStartupInfo);
    StartupInfo.wShowWindow := SW_HIDE ; //add this to start it hidden
    ShortFileName := LowerCase(ExtractFileName(FileName));
    DirNme := LowerCase(ExtractFilePath(FileName));
    s := ShellFindExecutable(ShortFileName,DirNme);
    If s <> '' then begin
      ShortFileName := ExtractFileName(s);
      DirNme := ExtractFilePath(s);
      s := DirNme + ShortFileName + ' "' + FileName + '"';
      if CreateProcess(nil,
                   pchar(s),
                   nil,
                   nil,
                   false,
                   normal_priority_class,
                   nil,
                   pchar(DirNme),
                   Startupinfo,
                   ProcessInfo) then
      begin
        WaitforSingleObject(Processinfo.hProcess, infinite);
        CloseHandle(ProcessInfo.hProcess);
        Result := True;
      end;
    end
    else
      Result := False;
  Except
     Result := False;
  end;
end;}

Procedure MatJpeg2Bmp(JpgImage:TJPEGImage;Var ConvertedBmp:TBitmap);
Begin
  try
    ConvertedBmp.Assign(JpgImage);
  finally
  end;
End;



//What It Does
 //Deletes from the begining of a string up to the intended character
Procedure MatStringDeleteUp2(Var StrLine:String;SubtractStr:String;Xtra:integer=-1);
Begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    if Xtra <> -1 then
      Delete(StrLine,1,Pos(SubtractStr,StrLine)+Xtra)
    else
      Delete(StrLine,1,Pos(SubtractStr,StrLine));
   End;
End;

Procedure MatStringDeleteUp2(Var StrLine:WideString;SubtractStr:WideString;Xtra:integer=-1); Overload;
Begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    if Xtra <> -1 then
      Delete(StrLine,1,Pos(SubtractStr,StrLine)+Xtra)
    else
      Delete(StrLine,1,Pos(SubtractStr,StrLine));
   End;
End;

//What It Does
 //Checks if a file is currently being used by a program
function MatFileInUse(fName : string ) : boolean;
var
  HFileRes : HFILE;
begin
  Result := false;
  if not FileExists(fName) then
    exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE,0, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;

Function MatGetfilesizeEx( const filename: String ): int64;
 Var
   SRec: TSearchrec;
   converter: packed record
     case Boolean of
       false: ( n: int64 );
       true : ( low, high: DWORD );
     end;
 Begin
   If FindFirst( filename, faAnyfile, SRec ) = 0 Then Begin
     converter.low := SRec.FindData.nFileSizeLow;
     converter.high:= SRec.FindData.nFileSizeHigh;
     Result:= converter.n;
     FindClose( SRec );
   End
   Else
     Result := -1;
 End;

 Function MatCompareFile2Stream(mmstrem:TMemoryStream;filename:String):Boolean;
 Var
   aStream: TMemoryStream;
 Begin
  try
  if FileExists(filename) then Begin
    aStream := TMemoryStream.Create;
    aStream.LoadFromFile(filename);
    if aStream.Size = mmstrem.Size then
      Result := true
    Else
      Result := false;
    FreeAndNil(aStream);
  End else
  Result := false;
  except
    Result := false;
  end;

 End;

//What it does
 //Can run a dos command and include writing the results to a file with the
 // ' > c:\file.txt ' command
Procedure MatProcessRun( cmdline: String; hidden: Boolean );
Const
  flags : Array [Boolean] of Integer = (SW_SHOWNORMAL, SW_HIDE);
Var
  cmdbuffer: Array [0..MAX_PATH] of Char;
Begin
  GetEnvironmentVariable( 'COMSPEC', cmdBUffer, Sizeof(cmdBuffer));
  StrCat( cmdbuffer, ' /C ');
  StrPCopy( StrEnd(cmdbuffer), cmdline );
  WinExec( cmdbuffer, flags[hidden] );
End;

//What It Does
 //Starts a program and waits until it has finished running then carry's on
//Notes
 //Has A String length limit not to sure how much yet
procedure MatProcessRunWait(FileName,Paramters:String);
var
  StartupInfo: TStartupinfo;
  ProcessInfo: TProcessInformation;
  cmdbuffer: Array [0..MAX_PATH] of Char;
  FileDetailz :WideString;
  Filez  :PAnsiChar;
begin
  FileDetailz := FileName + ' ' + Paramters;
  StrPCopy( StrEnd(cmdbuffer), FileDetailz );
  Filez := PAnsichar(FileName + ' ' + Paramters);
  FillChar(Startupinfo,Sizeof(TStartupinfo),0);
  Startupinfo.cb:=Sizeof(TStartupInfo);
  //StartupInfo.wShowWindow := SW_HIDE ; //add this to start it hidden
  CreateProcess(nil,
                   cmdbuffer,
                   nil,
                   nil,
                   false,
                   normal_priority_class,
                   nil,
                   Nil,
                   Startupinfo,
                   ProcessInfo);
  begin
    WaitforSingleObject(Processinfo.hProcess, infinite);
    CloseHandle(ProcessInfo.hProcess);
  end;
End;

function MatGetFileSize(const FileName: string): Integer;
var
  SearchRec: TSearchRec;
  OldMode: Cardinal;
begin
  Result := -1;
  OldMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    if FindFirst(FileName, faAnyFile, SearchRec) = 0 then
    begin
      Result := SearchRec.Size;
      SysUtils.FindClose(SearchRec);
    end;
  finally
    SetErrorMode(OldMode);
  end;
End;



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

Procedure MatStringReplace(Var Str:WideString;ExistingStr :WideString; ReplaceWith:WideString;Single:Boolean=false); Overload;
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


Procedure MatWideStringReplace(Var Str:WideString;ExistingStr :WideString;
            ReplaceWith:WideString);
Var
  j :Integer;
Begin
  j := Pos(Lowercase(ExistingStr),Lowercase(Str));
   While j <> 0 Do
    Begin
    //Keep finding and replaceing the string
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
     j := Pos(Lowercase(ExistingStr),Lowercase(Str));
    End;

End;

//What It Does
 //retrieves a line from a text file in a real high speed manner
function MatTextLineFind(const AFileName: string; ALine: Integer): string;
var
  fs: TFileStream;
  buf: packed array[0..4095] of Char;
  bufRead: Integer;
  bufPos: PChar;
  lineStart: PChar;
  tmp: string;
begin
  fs := TFileStream.Create(AFileName, fmOpenRead);
  try
    Dec(ALine);
    bufRead := 0;
    bufPos := nil;

    { read the first line specially }
    if ALine = 0 then
    begin
      bufRead := fs.Read(buf, SizeOf(buf));
      if bufRead = 0 then
        raise Exception.Create('Line not found');
      bufPos := buf;
    end else
      while ALine > 0 do
      begin
        { read in a buffer }
        bufRead := fs.Read(buf, SizeOf(buf));
        if bufRead = 0 then
          raise Exception.Create('Line not found');
        bufPos := buf;
        while (bufRead > 0) and (ALine > 0) do
        begin
          if bufPos^ = #10 then
            Dec(ALine);
          Inc(bufPos);
          Dec(bufRead);
        end;
      end;
    { Found the beginning of the line at bufPos... scan for end.
      2 cases:
        1) we'll find it before the end of this buffer
        2) it'll go beyond this buffer and into n more buffers}
    lineStart := bufPos;
    while (bufRead > 0) and (bufPos^ <> #10) do
    begin
      Inc(bufPos);
      Dec(bufRead);
    end;
    { if bufRead is positive, we'll have found the end and we can leave. }
    SetString(Result, lineStart, bufPos - lineStart);
    { determine if there are more buffers to process }
    while bufRead = 0 do
    begin
      bufRead := fs.Read(buf, SizeOf(buf));
      lineStart := buf;
      bufPos := buf;
      while (bufRead > 0) and (bufPos^ <> #10) do
      begin
        Inc(bufPos);
        Dec(bufRead);
      end;
      SetString(tmp, lineStart, bufPos - lineStart);
      Result := Result + tmp;
    end;
  finally
    fs.Free;
  end;
end;

//What it does
 //shuts down a chosen running program
 //Seems to only work with NT OS's  
function MatProcessKill(ExeFileName: string): integer;
const
  PROCESS_TERMINATE=$0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot
                     (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle,
                                 FProcessEntry32);
  while integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
         UpperCase(ExeFileName))
     or (UpperCase(FProcessEntry32.szExeFile) =
         UpperCase(ExeFileName))) then
      Result := Integer(TerminateProcess(OpenProcess(
                        PROCESS_TERMINATE, BOOL(0),
                        FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle,
                                  FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
End;



//What it does
 //Associates file type with a program
 //Example - MatRegistryAssociate('.Dxi','Calculater File','c:\Calculate.exe')
procedure MatRegistryAssociate(CMyExt:string;CMyFileType:string;ProgramFile:string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
   // Set the root key to HKEY_CLASSES_ROOT
    Reg.RootKey := HKEY_CLASSES_ROOT;
   // Now open the key, with the possibility to create
   // the key if it doesn't exist.
    Reg.OpenKey(cMyExt, True);
   // Write my file type to it.
   // This adds HKEY_CLASSES_ROOT\.abc\(Default) = 'Project1.FileType'
    Reg.WriteString('', cMyFileType);
    Reg.CloseKey;
   // Now create an association for that file type
    Reg.OpenKey(cMyFileType, True);
   // This adds HKEY_CLASSES_ROOT\Project1.FileType\(Default)
   //   = 'Project1 File'
   // This is what you see in the file type description for
   // the a file's properties.
    Reg.WriteString('', 'Project1 File');
    Reg.CloseKey;
   // Now write the default icon for my file type
   // This adds HKEY_CLASSES_ROOT\Project1.FileType\DefaultIcon
   //  \(Default) = 'Application Dir\Project1.exe,0'
    Reg.OpenKey(cMyFileType + '\DefaultIcon', True);
    Reg.WriteString('', ProgramFile + ',0');
    Reg.CloseKey;
   // Now write the open action in explorer
    Reg.OpenKey(cMyFileType + '\Shell\Open', True);
    Reg.WriteString('', '&Open');
    Reg.CloseKey;
   // Write what application to open it with
   // This adds HKEY_CLASSES_ROOT\Project1.FileType\Shell\Open\Command
   //  (Default) = '"Application Dir\Project1.exe" "%1"'
   // Your application must scan the command line parameters
   // to see what file was passed to it.
    Reg.OpenKey(cMyFileType + '\Shell\Open\Command', True);
    Reg.WriteString('', '"' + ProgramFile + '" "%1"');
    Reg.CloseKey;
   // Finally, we want the Windows Explorer to realize we added
   // our file type by using the SHChangeNotify API.
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  finally
    Reg.Free;
  end;
end;


//What it Does
 //Add or remove program to windows startup in the registry
 //If u say false then it removes it from the registry
 //Example - MatRegistryStartup(True,'Windows Manager','C:\ProgrammStartetr.exe');
Procedure MatRegistryStartup(AddEntry:Boolean;Title:String;ProgramFile:string);
var
  reg: TRegistry;
begin
 Try
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.LazyWrite := false;
  reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',false);
  reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run',
               false);
 //If true then add to startup
  If AddEntry = true then
   reg.WriteString(Title, ProgramFile)
  Else
   //If false then remove from startup
    If reg.ValueExists(Title) then
     Reg.DeleteValue(Title);
 Finally
  reg.CloseKey;
  reg.free;
 End;
End;

//What it does
 //Causes a delay
procedure MatDelay(msec:longint);
var
  start,stop:longint;
begin
  start := gettickcount;
  repeat
  stop := gettickcount;
  //application.processmessages;
  until (stop - start ) >= msec;
end;

function matStringListNotEmpty(aList:TStringList):TStringList;
Var
  i : Integer;
  s : string;
Begin
  i := 0;
  while i < aList.Count do Begin
    s := aList.Strings[i];
    if s = ' ' then
      aList.Delete(i)
    Else
      inc(i);
  End;
  Result := aList;
End;

//Example MatStringList('Edit1\bob\sweet\what','\')
Function MatString2List(source, Delimiter:String):TStringList;
Var
  list : TStringList;
  s,s1 : String;
Begin
  If source  = '' then exit;
  If Delimiter = '' then exit;
  list := TStringList.Create;
  s := source;
  s1 := source;
  While pos(Delimiter,s1) >0 do Begin
    MatStringDelete2End(s,Delimiter);
    list.Add(s);
    MatStringDeleteUp2(s1,Delimiter);
    s := s1
  End;
  If s1 <> '' then
    list.Add(s1);
  Result := list;
End;

Function MatString2TntList(source, Delimiter:String;IgnDublicates:Boolean=False):TTntStringList;
Var
  list : TTntStringList;
  s,s1 : String;
Begin
  If source  = '' then exit;
  If Delimiter = '' then exit;
  list := TTntStringList.Create;
  if IgnDublicates = true then Begin
    list.Sorted := true;
    List.Duplicates := dupIgnore;
  End;
  s := source;
  s1 := source;
  While pos(Delimiter,s1) >0 do Begin
    MatStringDelete2End(s,Delimiter);
    list.Add(s);
    MatStringDeleteUp2(s1,Delimiter);
    s := s1
  End;
  If s1 <> '' then
    list.Add(s1);
  Result := list;
End;

//What it does
 //It deletes a section from the given string and returns it
Function MatStringDelete(Var StrLine:String;SubtractStr:String):Boolean;
Begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
      Delete(StrLine,Pos(SubtractStr,StrLine),Length(SubtractStr));
      Result := true;
   End
   Else
     Result := False;
End;

//What it does
 //It deletes to the end of a given string and returns it

Procedure MatStringDeleteFirstChar(Var StrLine:String;ExistingStr:String);
Var
  s : String;
Begin
  if StrLine <> '' then Begin
    s := StrLine[1];
    While s = ExistingStr do Begin
      Delete(StrLine,1,1);
      s := StrLine[1];
    End;
  end;
End;

Procedure MatStringDeleteFirstChar(Var StrLine:WideString;ExistingStr:WideString); overload;
Var
  s : WideString;
Begin
  s := StrLine[1];
  While s = ExistingStr do Begin
    Delete(StrLine,1,1);
    s := StrLine[1];
  End;
End;

Procedure MatStringDeleteLastChar(Var StrLine:String;ExistingStr:String);
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
          (s <> '') do Begin
      Delete(StrLine,Length(StrLine),1);
      if s <> '' then
        s := StrLine[Length(StrLine)];
    End;
  end;
End;

Procedure MatStringDeleteLastChar(Var StrLine:WideString;ExistingStr:WideString); Overload;
Var
  s : WideString;
Begin

  s := StrLine;
  if s <> '' then Begin
    if Length(StrLine) > 1 then
      s := StrLine[Length(StrLine)]
    else
      s := StrLine;
    While s = ExistingStr do Begin
      Delete(StrLine,Length(StrLine),1);
      s := StrLine[Length(StrLine)];
    End;
  end;
End;

Procedure MatStringDelete2End(Var StrLine:String;SubtractStr:String);
Begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    Delete(StrLine,Pos(SubtractStr,StrLine),50000);
   End;
End;

Procedure MatStringDelete2End(Var StrLine:WideString;SubtractStr:WideString); Overload;
Begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    Delete(StrLine,Pos(SubtractStr,StrLine),50000);
   End;
End;

//What it does
 //Checks if the last line of a dir is a \ or not then adds if needed.
Procedure MatStringDirCheck(Var Dir:String);
Begin
    If Dir[Length(Dir)] = '\' then
      Dir := Dir
     Else
      Dir := Dir+'\';
End;

Function MatInt2Bool(I:integer):Boolean;
Begin
  If I = 1 then
    Result := True
  Else
    Result := False;
End;

Function MatBool2Int(bl:Boolean):integer;
Begin
  If bl = true then
    Result := 1
  Else
    Result := 0;
End;

Function MatBool2Str(bl:Boolean):String;
Begin
  if bl = true then
    result := 'True'
  Else
    Result := 'False';  
End;

//Fully operational, however I think that it can still be optimized.
//what it does
  //it scan's the given directory and returns
  //a file list and a directory list
  //Not Yet - Also you can Ask for file sizes aswell
Procedure MatDirSubStructure(StartDir, WildCard:String;Var FileList:TStringList;Var DirList:TStringList;IncludeDetails:Boolean);
Var
  FileDetails     : TSearchRec;
  DirToCheckList  :TstringList;
  i               : Integer;
  TmpStr01        :String;
Begin
 Try
   if FileList = nil then
     FileList := TStringList.Create;
   if DirList = nil then
     DirList := TStringList.Create;
   //Sort File/Dir list and don't allow duplicates
    If FileList.Sorted = False then
     Begin
    FileList.Sorted := True;
    FileList.Duplicates := dupIgnore;
     End;
    If DirList.Sorted = False then
     Begin
    DirList.Sorted := True;
    DirList.Duplicates := dupIgnore;
     End;
    If StartDir[Length(StartDir)] = '\' then
     StartDir := StartDir
    Else
     StartDir := StartDir +'\';
    DirList.Add(StartDir);
   //Create a list for sub directorys to be checked
    DirToCheckList := TStringList.Create;
    DirToCheckList.Sorted := True;
    DirToCheckList.Duplicates := dupIgnore;

   //Find the first file/dir of selected dir
     FindFirst(StartDir + WildCard, faAnyFile, FileDetails);
  //  If (FileDetails.Size > 0) then
    If FileExists(StartDir + FileDetails.Name) then
     Begin
      //Add the existing file into the file list with all its details
       If IncludeDetails = false then
        FileList.Add(StartDir
              + FileDetails.Name)
        Else
        FileList.Add(StartDir
              + FileDetails.Name
              + #09
              + IntToStr(FileDetails.size));
     End
    Else
     //Add the existing Directory into the Dir list with all its details
      If (FileDetails.Name <> '.') then
       If (FileDetails.Name <> '..') then
        If DirectoryExists(StartDir + FileDetails.Name) then
        Begin
         DirList.Add(StartDir
              + FileDetails.Name
              + '\');
         DirToCheckList.Add(StartDir
              + FileDetails.Name
              + '\');
        End;

   //Repeat until all files/dirs have been found
    While (FindNext(FileDetails)) = 0 do
     Begin
  //      If (FileDetails.Size > 0)   then
     If FileExists(StartDir + FileDetails.Name) then
      Begin
      //Add the existing file into the file list with all its details
      If IncludeDetails = false then
       FileList.Add(StartDir
           + FileDetails.Name)
      Else
      FileList.Add(StartDir
           + FileDetails.Name
           + #09
           + IntToStr(FileDetails.size));
      End
     Else
      If (FileDetails.Name <> '.') then
      If (FileDetails.Name <> '..') then
      If DirectoryExists(StartDir + FileDetails.Name) then
      Begin
       //Add the existing Directory into the Dir list with all its details
        DirList.Add(StartDir
             + FileDetails.Name
             + '\');
        DirToCheckList.Add(StartDir
             + FileDetails.Name
             +'\');
      End;
     End;
    FindClose(FileDetails);
   //Recall this procedure to find all subdirectorys
    i := 0;
    While i < DirToCheckList.Count  do
     Begin
     TmpStr01 := DirToCheckList.Strings[i];
    MatDirSubStructure(DirToCheckList.Strings[i],'*.*',FileList,DirList,IncludeDetails);
     Inc(i);
     End;
 Finally
   DirToCheckList.Free;
 End;
End;

//What it does
 //Copy's the given dir and subdirs to the destination dir
Procedure MatDirCopy(StartDir:String;Destination:String);
Var
  MySourceFileList, MySourceDirList  :TstringList;
  MyDestFileList, MyDestDirList      :TstringList;
  TmpStr01,TmpStr02                  :String;
  i :Integer;
Begin
  Try
   //Create all file lists
    MySourceFileList := TStringList.Create;
    MySourceFileList.Sorted := True;
    MySourceDirList := TStringList.Create;
    MyDestFileList := TStringList.Create;
    MyDestFileList.Sorted := True;
    MyDestDirList := TStringList.Create;
   // Make sure the startdir is set right
    If StartDir[Length(StartDir)] = '\' then
     StartDir := StartDir
    Else
     StartDir := StartDir +'\';
   // Make sure the startdir is set right
    If Destination[Length(Destination)] = '\' then
     Destination := Destination
    Else
     Destination := Destination +'\';
   //Find all files/dirs and subdirs
    MatDirSubStructure(StartDir,'*.*',MySourceFileList,MySourceDirList,False);
    For i := 0 to MySourceFileList.Count -1 do
     Begin
     //Make sure all destination files are to be saved at the right places
    TmpStr01 := MySourceFileList.Strings[i];
    MatStringDelete(TmpStr01,StartDir);
    TmpStr02 := ExtractFileDir(Startdir);
    TmpStr02 := ExtractFileName(TmpStr02);
    MyDestFileList.Add(Destination
            +TmpStr02
            +'\'
            +TmpStr01);
     End;
    For i := 0 to MySourceDirList.Count -1 do
     Begin
     //Make sure all destination Directories are to be saved at the right places
    TmpStr01 := MySourceDirList.Strings[i];
    MatStringDelete(TmpStr01,StartDir);
    TmpStr02 := ExtractFileDir(Startdir);
    TmpStr02 := ExtractFileName(TmpStr02);
    If i <> 0 then
     MyDestDirList.Add(Destination
            +TmpStr02
            +'\'
            +TmpStr01)
    Else
       MyDestDirList.Add(Destination
            +TmpStr02);
     End;
    For i := 0 to MyDestDirList.Count -1 do
     Begin
     //Create all needed directories
    If not DirectoryExists(MyDestDirList.Strings[i]) then
     CreateDirectory(Pchar(MyDestDirList.Strings[i]),nil);
     End;
    For i := 0 to MyDestFileList.Count -1 do
     Begin
    //Copy All Files
     CopyFile(pchar(MySourceFileList.Strings[i]),pchar(MyDestFileList.strings[i]),False);
     End;
  //  MyDestFileList.SaveToFile('c:\DestFile');
  //  MyDestDirList.SaveToFile('c:\DestDir');
  Finally
    MySourceFileList.Free;
    MySourceDirList.Free;
    MyDestFileList.Free;
    MyDestDirList.Free;
  End;
End;


//What It Does
 //Compares and Copy's Diff. files/Dirs/SubDirs
 //It will only copy a file if it either doesn't exist or if it's Diff.
Procedure MatDirMirrorCopy(StartDir:String;Destination:String);
Var
  MySourceFileList, MySourceDirList :TstringList;
  MyDestFileList, MyDestDirList     :TstringList;
  MyMirrorFileList, MyMirrorDirList :TstringList;
  TmpStr01,TmpStr02                 :String;
  i, Index                          :Integer;
Begin
 //Create all file lists
  MySourceFileList := TStringList.Create;
  MySourceFileList.Sorted := True;
  MySourceDirList := TStringList.Create;
  MyDestFileList := TStringList.Create;
  MyDestFileList.Sorted := True;
  MyDestDirList := TStringList.Create;
  MyMirrorFileList := TStringList.Create;
  MyMirrorFileList.Sorted := True;
  MyMirrorDirList := TStringList.Create;
  MyMirrorDirList.Sorted := True;
 // Make sure the startdir is set right
  If StartDir[Length(StartDir)] = '\' then
   StartDir := StartDir
  Else
   StartDir := StartDir +'\';
 // Make sure the Destinationdir is set right
  If Destination[Length(Destination)] = '\' then
   Destination := Destination
  Else
   Destination := Destination +'\';
 //Find all files/dirs and subdirs
  MatDirSubStructure(StartDir,'*.*',MySourceFileList,MySourceDirList,True);
  For i := 0 to MySourceFileList.Count -1 do
   Begin
   //Make sure all destination files are to be saved at the right places
   TmpStr01 := MySourceFileList.Strings[i];
   MatStringDelete(TmpStr01,StartDir);
   TmpStr02 := ExtractFileDir(Startdir);
   TmpStr02 := ExtractFileName(TmpStr02);
   MyDestFileList.Add(Destination
              +TmpStr02
              +'\'
              +TmpStr01);
   End;
  For i := 0 to MySourceDirList.Count -1 do
   Begin
   //Make sure all destination Directories are to be saved at the right places
   TmpStr01 := MySourceDirList.Strings[i];
   MatStringDelete(TmpStr01,StartDir);
   TmpStr02 := ExtractFileDir(Startdir);
   TmpStr02 := ExtractFileName(TmpStr02);
   If i <> 0 then
    MyDestDirList.Add(Destination
              +TmpStr02
              +'\'
              +TmpStr01)
   Else
       MyDestDirList.Add(Destination
              +TmpStr02);
   End;
  For i := 0 to MyDestDirList.Count -1 do
   Begin
   //Create all needed directories
   If not DirectoryExists(MyDestDirList.Strings[i]) then
    CreateDirectory(Pchar(MyDestDirList.Strings[i]),nil);
   End;
  MatDirSubStructure(Destination,'*.*',MyMirrorFileList,MyMirrorDirList,True);
  For i := 0 to MyDestFileList.Count -1 do
   Begin
   //Copy All Diff. Files
   If MyMirrorFileList.Find(MyDestFileList.Strings[i], Index) then
    begin
    end
   Else
    Begin
     TmpStr01 := MySourceFileList.Strings[i];
     If Pos(#09, TmpStr01) > 0 then
      Delete(TmpStr01,Pos(#09, TmpStr01),250);
     TmpStr02 := MyDestFileList.Strings[i];
     If Pos(#09, TmpStr02) > 0 then
      Delete(TmpStr02,Pos(#09, TmpStr02),250);
     CopyFile(pchar(TmpStr01),pchar(Tmpstr02),False);
    End;
   End;
//  MyDestFileList.SaveToFile('c:\DestFile.zzz');
//  MyDestDirList.SaveToFile('c:\DestDir.zzz');
//  MySourceFileList.SaveToFile('c:\SourceFile.zzz');
//  MySourceDirList.SaveToFile('c:\SourceDir.zzz');
//  MyMirrorFileList.SaveToFile('c:\MirrorFile.zzz');
//  MyMirrorDirList.SaveToFile('c:\MiirorDir.zzz');
  MySourceFileList.Free;
  MySourceDirList.Free;
  MyDestFileList.Free;
  MyDestDirList.Free;
  MyMirrorFileList.Free;
  MyMirrorDirList.Free;
End;

Function MatDirLocal(StarDir:String;Destination:String):String;
Var
  s, d : String;
Begin
  s := Destination;
  MatStringDirCheck(s);
  d := StarDir;
  MatStringDirCheck(d);
  MatStringReplace(s,d,'.\');
  Result := s;
End;

//What it does
 //Finds and replaces all intended strings in the stringlist
Procedure MatStringsReplace(Var StrList:TstringList;ExistingStr :String;ReplaceWith:String);
Var
  i, J :Integer;
  OldStrList  :TStringList;
  TmpStr01  :String;
Begin
  Try
 //Change Existing string to lower case
  ExistingStr := ExistingStr;
 //Copy the stringlist to another stringlist
  OldStrList := TStringList.Create;
  OldStrList.AddStrings(StrList);
  StrList.Clear;
    For i := 0 to OldStrList.Count - 1 do
     Begin
     //Change String from stringlist to lowercase
      TmpStr01  := OldStrList.Strings[i];
      j := Pos(Lowercase(ExistingStr),Lowercase(TmpStr01));
       While j <> 0 Do
        Begin
        //Keep finding and replaceing the string
         delete(TmpStr01,j,length(ExistingStr));
         Insert(ReplaceWith, TmpStr01,j);
         j := Pos(Lowercase(ExistingStr),Lowercase(TmpStr01));
        End;
      StrList.Add(TmpStr01);
     End;
  Finally
  OldStrList.Free;
  End;
End;

//What It Does
 //Deletes from the intended character to the end of the line for every
 //existing line in a StringList;
Procedure MatStringsDelete2End(var StrList:TStringList;ExistingStr:String);
Var
  TmpStrz :TStringList;
  TmpStr01  :String;
  i :Integer;
Begin
  Try
   if StrList.Count <> 0 then
    Begin
      TmpStrz := TStringList.Create;
      TmpStrz.AddStrings(StrList);
      StrList.Clear;
      for i := 0 to TmpStrz.Count -1 do
       Begin
         TmpStr01:= TmpStrz.Strings[i];
         MatStringDelete2End(TmpStr01,ExistingStr);
         StrList.Add(TmpStr01);
       End;
    End;
  Finally
    TmpStrz.Free;
  End;
End;


Procedure MatStringAddComa(Var Str:String);
begin
  If (Length(Str) > 3) and
     (Length(Str) < 7) then
    Insert(',', Str,Length(Str)-2)
  Else
    If (Length(Str) > 6) and
       (Length(Str) < 10) then begin
      Insert(',', Str,Length(Str)-5);
      Insert(',', Str,Length(Str)-2);
    End
  Else
    If (Length(Str) > 9) then begin
      Insert(',', Str,Length(Str)-8);
      Insert(',', Str,Length(Str)-5);
      Insert(',', Str,Length(Str)-2);
    End    ;
End;

Procedure MatStringAddComa(Var Str:WideString); Overload
begin
  If (Length(Str) > 3) and
     (Length(Str) < 7) then
    Insert(',', Str,Length(Str)-2)
  Else
    If (Length(Str) > 6) and
       (Length(Str) < 10) then begin
      Insert(',', Str,Length(Str)-5);
      Insert(',', Str,Length(Str)-2);
    End
  Else
    If (Length(Str) > 9) then begin
      Insert(',', Str,Length(Str)-8);
      Insert(',', Str,Length(Str)-5);
      Insert(',', Str,Length(Str)-2);
    End    ;
End;

function stringListTostrings(listData:TStringList):TStrings;
Var
  rData : TStrings;
  i : integer;
Begin
  rData := TStrings.Create;
  for i := 0 to listData.Count -1 do Begin
    rData.Add(listData.Strings[i]);
  end;
  result := rData;
end;
function stringsTostringList(listData:TStrings):TStringList;
Var
  rData : TStringList;
  i : integer;
Begin
  rData := TStringList.Create;
  for i := 0 to listData.Count -1 do Begin
    rData.Add(listData.Strings[i]);
  end;
  result := rData;
end;

function matStringCopyRemoveBack(Str:String;SearchCharacter:String):String;
Var
  s : String;
  i, ifound : integer;
Begin
  //Used to return the front part of a given string removing every from the SearchCharacter Working Backwards
  if str <> '' then Begin
    i := Length(Str);
    while i >= 0 do Begin
      s := Str[i];
      if s = SearchCharacter then Begin
        Delete(Str,i,Length(Str));
        i := -1;
      End;
      i := i - 1;
    End;
  end;
  Result := Str;
End;

function matStringCopyRemoveFrontBack(Str:String;SearchCharacter:String):String;
Var
  s : String;
  i, ifound : integer;
Begin
  //Returns everything after the SearchCharacter working backwords
  i := Length(Str);
  while i >= 0 do Begin
    s := Str[i];
    if s = SearchCharacter then Begin
      Delete(Str,1,i);
      i := -1;
    End;
    i := i - 1;
  End;
  Result := Str;
End;

function DownloadFile(SourceFile, DestFile: string): Boolean;
begin
  try
    Result := UrlDownloadToFile(nil, PChar(SourceFile), PChar(DestFile), 0, nil) = 0;
  except
    Result := False;
  end;
end;

function GetSystemDir: TFileName;
var
  SysDir: array [0..MAX_PATH-1] of char;
begin
  SetString(Result, SysDir, GetSystemDirectory(SysDir, MAX_PATH));
  if Result = '' then
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

//Memo1.Text :=  Component2String(ImageList1);
Function Component2String(Component: TComponent): string;
Var
  BinStream:TMemoryStream;
  StrStream: TStringStream;
  s: string;
begin
  Try
    BinStream := TMemoryStream.Create;
    StrStream := TStringStream.Create(s);
    BinStream.WriteComponent(Component);
    BinStream.Seek(0, soFromBeginning);
    ObjectBinaryToText(BinStream, StrStream);
    StrStream.Seek(0, soFromBeginning);
    Result := StrStream.DataString;
  Finally
    StrStream.Free;
    BinStream.Free
    End;
End;

//Label1 := String2Component(Memo1.Text,Label1 as TObject) as TLabel;
Function String2Component(Value: string;aComp: TObject): TComponent;
  Var
    StrStream:TStringStream;
    BinStream: TMemoryStream;
Begin
  Result := nil;
  Try
    StrStream := TStringStream.Create(Value);
    BinStream := TMemoryStream.Create;
    ObjectTextToBinary(StrStream, BinStream);
    BinStream.Seek(0, soFromBeginning);
    Result := BinStream.ReadComponent(aComp as TComponent);
    //Result := BinStream.ReadComponent(nil);
  Finally
    //BinStream.Free;
    StrStream.Free;
  End;
End;

procedure GetAssociatedIcon(FileName: TFilename;
    PLargeIcon, PSmallIcon: PHICON);
// Gets the icons of a given file
var
  IconIndex: UINT;  // Position of the icon in the file
  FileExt, FileType: string;
  Reg: TRegistry;
  p: integer;
  p1, p2: pchar;
label
  noassoc;
begin
  IconIndex := 0;
  // Get the extension of the file
  FileExt := UpperCase(ExtractFileExt(FileName));
  if ((FileExt <> '.EXE') and (FileExt <> '.ICO')) or
      not FileExists(FileName) then begin
    // If the file is an EXE or ICO and it exists, then
    // we will extract the icon from this file. Otherwise
    // here we will try to find the associated icon in the
    // Windows Registry...
    Reg := nil;
    try
      Reg := TRegistry.Create(KEY_QUERY_VALUE);
      Reg.RootKey := HKEY_CLASSES_ROOT;
      if FileExt = '.EXE' then FileExt := '.COM';
      if Reg.OpenKeyReadOnly(FileExt) then
        try
          FileType := Reg.ReadString('');
        finally
          Reg.CloseKey;
        end;
      if (FileType <> '') and Reg.OpenKeyReadOnly(
          FileType + '\DefaultIcon') then
        try
          FileName := Reg.ReadString('');
        finally
          Reg.CloseKey;
        end;
    finally
      Reg.Free;
    end;

    // If we couldn't find the association, we will
    // try to get the default icons
    if FileName = '' then goto noassoc;

    // Get the filename and icon index from the
    // association (of form '"filaname",index')
    p1 := PChar(FileName);
    p2 := StrRScan(p1, ',');
    if p2 <> nil then begin
      p := p2 - p1 + 1; // Position of the comma
      IconIndex := StrToInt(Copy(FileName, p + 1,
        Length(FileName) - p));
      SetLength(FileName, p - 1);
    end;
  end;
  // Attempt to get the icon
  if ExtractIconEx(pchar(FileName), IconIndex,
      PLargeIcon^, PSmallIcon^, 1) <> 1 then
  begin
noassoc:
    // The operation failed or the file had no associated
    // icon. Try to get the default icons from SHELL32.DLL

    try // to get the location of SHELL32.DLL
      FileName := IncludeTrailingBackslash(GetSystemDir)
        + 'SHELL32.DLL';
    except
      FileName := 'C:\WINDOWS\SYSTEM\SHELL32.DLL';
    end;
    // Determine the default icon for the file extension
    if      (FileExt = '.DOC') then IconIndex := 1
    else if (FileExt = '.EXE')
         or (FileExt = '.COM') then IconIndex := 2
    else if (FileExt = '.HLP') then IconIndex := 23
    else if (FileExt = '.INI')
         or (FileExt = '.INF') then IconIndex := 63
    else if (FileExt = '.TXT') then IconIndex := 64
    else if (FileExt = '.BAT') then IconIndex := 65
    else if (FileExt = '.DLL')
         or (FileExt = '.SYS')
         or (FileExt = '.VBX')
         or (FileExt = '.OCX')
         or (FileExt = '.VXD') then IconIndex := 66
    else if (FileExt = '.FON') then IconIndex := 67
    else if (FileExt = '.TTF') then IconIndex := 68
    else if (FileExt = '.FOT') then IconIndex := 69
    else IconIndex := 0;
    // Attempt to get the icon.
    if ExtractIconEx(pchar(FileName), IconIndex,
        PLargeIcon^, PSmallIcon^, 1) <> 1 then
    begin
      // Failed to get the icon. Just "return" zeroes.
      if PLargeIcon <> nil then PLargeIcon^ := 0;
      if PSmallIcon <> nil then PSmallIcon^ := 0;
    end;
  end;
end;

Procedure matMessageMouse(aMessage,Heading:String;Delay:Integer;sender:TJvBalloonHint);
Var
  aBalloon : TJvBalloonHint;
Begin
  If sender <> nil then Begin
    (Sender as TJvBalloonHint).ActivateHintPos(nil,Mouse.CursorPos,Heading,aMessage,Delay);
  End Else Begin
    aBalloon := TJvBalloonHint.Create(nil);
    aBalloon.ActivateHintPos(nil,Mouse.CursorPos,Heading,aMessage,Delay);
    aBalloon.Free;
  End;
End;

{//Need to fix this procedure
//but for now it shows how to use create a component variable
Procedure SerielFileCreate1(Sender:TObject;MyFile:String);
Var
  MyIniFile   :Tinifile;
  MyBackup    :TBackupFile;
  MyFileList  :TStringList;
begin
 //if the seriel file doesn't exists then create a new one with a new and
 //random serial number
  If not FileExists(MyFile) then
   Begin
   MyiniFile := TIniFile.Create(MyFile);
   Randomize;
   //Save The New Random Value
   MyiniFile.WriteString('Code','Value', FormatDateTime('yyyyMMdd',now) + IntToStr(random(10000)));
   MyiniFile.Free;
   //Encrypt The "MyInifile" with the newly created Seriel Number
   MyBackup := TBackupFile.Create(nil);
   try
     //create a file list so the encrypter knows which files to encrypt
     MyFileList := TStringList.Create;
     try
      MyFileList.Add(MyFile);
      //encrypt the selected files and name it
      MyBackup.Backup(MyFileList,MyFile+'.Dll');
      //delete the serial number file
      If FileExists(MyFile) then
       DeleteFile(MyFile);
     finally
      MyFileList.Free;
     end;
   finally
     MyBackup.Free;
   end;
   End;
End;}

function MatUrlgetUrlList(aString:String):TStringList;
Var
  s, org: String;
  alist : TStringList;
Begin
  alist := TStringList.Create;
  org := aString;
  While pos('www.',astring) > 0 do Begin
    s := aString;
    MatStringDeleteUp2(s,'www.');
    Insert('w',s,0);
    MatStringDelete2End(s,#$D);
    MatStringDelete2End(s,#$A);
    MatStringDelete2End(s,' ');
    MatStringDelete2End(s,'"');
    MatStringDeleteUp2(aString,'www.');
    Insert('w',aString,0);
    MatStringReplace(aString,s,'');
    alist.Add('http://' + s);
  End;
  aString := org;
  While pos('http',astring) > 0 do Begin
    s := aString;
    MatStringDeleteUp2(s,'http');
    Insert('h',s,0);
    MatStringDelete2End(s,#$D);
    MatStringDelete2End(s,#$A);
    MatStringDelete2End(s,' ');
    MatStringDelete2End(s,'"');
    MatStringDeleteUp2(aString,'http');
    Insert('h',aString,0);
    MatStringReplace(aString,s,'');
    if pos('www.',s) = 0 then
      alist.Add(s);
  End;
  Result := alist;
End;


Function MatStrToList(s,Delimiter:String):Tstringlist;
Var
  aLst : TStringList;
  s1, s2 : String;
Begin
  Try
    aLst := TStringList.Create;
    s1 := s;
    While pos(Delimiter,s) >0 do Begin
      MatStringDelete2End(s1,Delimiter);
      MatStringDeleteUp2(s,Delimiter);
      TrimLeft(s1);
      TrimRight(s1);
      aLst.Add(s1);
      s1 := s;
    End;
    If s <> '' then
      aLst.Add(s);
  Finally
    Result := aLst;
  End;
End;

Function MatStrToList(s,Delimiter:WideString):TTntStringList;
Var
  aLst : TTntStringList;
  s1, s2 : WideString;
Begin
  Try
    aLst := TTntStringList.Create;
    s1 := s;
    While pos(Delimiter,s) >0 do Begin
      MatStringDelete2End(s1,Delimiter);
      MatStringDeleteUp2(s,Delimiter);
      TrimLeft(s1);
      TrimRight(s1);
      aLst.Add(s1);
      s1 := s;
    End;
    If s <> '' then
      aLst.Add(s);
  Finally
    Result := aLst;
  End;
End;

function matListToStr(listData:tstringlist;Delimiter:string):string;
Var
  i : integer;
  s : string;
Begin

  for i := 0 to listData.Count -1 do Begin
    s := s + listData.Strings[i] + Delimiter;
  end;

  Result := s;
end;

function matListToStr(listData:tstrings;Delimiter:string):string; overload;
Var
  i : integer;
  s : string;
Begin

  for i := 0 to listData.Count -1 do Begin
    s := s + listData.Strings[i] + Delimiter;
  end;

  Result := s;
end;  

Procedure MatStringFindLastSen(Var StrLine:string;DeleteChar:String);
Var
  i: Integer;
Begin
  i := length(StrLine);
  delete(StrLine,i,1);
  //Delete(StrLine,1,Pos(SubtractStr,StrLine)+Xtra)
  While pos(DeleteChar,StrLine) >0 do
    MatStringDeleteUp2(StrLine,DeleteChar);
End;

Procedure odSetExtension(oDialog:TJvOpenDialog;ext:WideString);
Begin
  oDialog.DefaultExt := ext;
  oDialog.Filter := ext + ' Files(*.'+ext+';)|*.'+ext+';|All Files|*.*';
End;

Procedure odSetExtension(oDialog:TJvOpenDialog;ext:WideString;extDescription:Widestring); overload;
Begin
  oDialog.DefaultExt := ext;
  oDialog.Filter := extDescription + ' Files(*.'+ext+';)|*.'+ext+';|All Files|*.*';
End;

Function isValidBitmap(aFileName:String):Boolean;
Var
  isValid : Boolean;
  BitmapHeaderSize, FileSize,ImageSize: integer;  // size of header of bitmap
  bmf: TBITMAPFILEHEADER;  // the bitmap header
  Stream : TStream;
Begin
  Try
    Try
      Stream := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
      // total size of bitmap
      FileSize := Stream.Size;
    // read the header
      Stream.ReadBuffer(bmf, SizeOf(TBITMAPFILEHEADER));
    // calculate header size
      BitmapHeaderSize := bmf.bfOffBits - SizeOf(TBITMAPFILEHEADER);
    // calculate size of bitmap bits
      ImageSize := FileSize - Integer(bmf.bfOffBits);
    // check for valid bitmap and exit if not
    if ((bmf.bfType <> $4D42) or
      (Integer(bmf.bfOffBits) < 1) or
      (FileSize < 1) or (BitmapHeaderSize < 1) or (ImageSize < 1) or
      (FileSize < (SizeOf(TBITMAPFILEHEADER) + BitmapHeaderSize + ImageSize))) then
    begin
      //Stream.Free;
      isValid := false
    end
  Else
    isValid := true;
    Except
      isValid := False;
    End;
  Finally
    result := isValid;
    if Stream <> nil then
      Try
        FreeAndNil(Stream);
      Except
      End;
  End;
End;

Procedure pcSetFont(pController:TJvPageControl;newFont:TFont);
Var
  defFont : TFont;
Begin
  if newFont <> nil then Begin
    pController.Font := newFont;
  End else Begin
    defFont := TFont.Create;
    defFont.Color := clBlack;
    defFont.Style := [fsBold];
    pController.Font := defFont;
  End;
End;

procedure centreFisrtInsideSecond(var innerPanel:TPanel; outerObject:TObject;innersubheight:integer = 0);
Var
  outerTop, outerLeft, outerWidth, outerHeight : Integer;
  innerTop, innerLeft, innerWidth, innerHeight : Integer;
Begin
  //get outer settings
  if outerObject is TForm then Begin
    outerTop := (outerObject as TForm).Top;
    outerLeft := (outerObject as TForm).Left;
    outerWidth := (outerObject as TForm).Width;
    outerHeight := (outerObject as TForm).Height;
  End;
  if outerObject is TPanel then Begin
    outerTop := (outerObject as TPanel).Top;
    outerLeft := (outerObject as TPanel).Left;
    outerWidth := (outerObject as TPanel).Width;
    outerHeight := (outerObject as TPanel).Height;
  End;
  if outerObject is TJvPanel then Begin
    outerTop := (outerObject as TJvPanel).Top;
    outerLeft := (outerObject as TJvPanel).Left;
    outerWidth := (outerObject as TJvPanel).Width;
    outerHeight := (outerObject as TJvPanel).Height;
  End;
  if outerObject is TJvFormWallpaper then Begin
    outerTop := (outerObject as TJvFormWallpaper).Top;
    outerLeft := (outerObject as TJvFormWallpaper).Left;
    outerWidth := (outerObject as TJvFormWallpaper).Width;
    outerHeight := (outerObject as TJvFormWallpaper).Height;
  End;
  if innersubheight > 0 then
    innerPanel.Height := outerHeight - innersubheight;
  innerPanel.Top :=  (outerHeight div 2) - (innerPanel.Height div 2);
  innerPanel.Left := (outerWidth div 2) - (innerPanel.Width div 2);


End;

procedure centreFisrtInsideSecond(var innerPanel:TjvPanel; outerObject:TObject; top:integer; innersubheight:integer); Overload;
Var
  outerTop, outerLeft, outerWidth, outerHeight : Integer;
  innerTop, innerLeft, innerWidth, innerHeight : Integer;
Begin
  //get outer settings
  if outerObject is TForm then Begin
    outerTop := (outerObject as TForm).Top;
    outerLeft := (outerObject as TForm).Left;
    outerWidth := (outerObject as TForm).Width;
    outerHeight := (outerObject as TForm).Height;
  End;
  if outerObject is TJvPanel then Begin
    outerTop := (outerObject as TJvPanel).Top;
    outerLeft := (outerObject as TJvPanel).Left;
    outerWidth := (outerObject as TJvPanel).Width;
    outerHeight := (outerObject as TJvPanel).Height;
  End;
  if outerObject is TPanel then Begin
    outerTop := (outerObject as TPanel).Top;
    outerLeft := (outerObject as TPanel).Left;
    outerWidth := (outerObject as TPanel).Width;
    outerHeight := (outerObject as TPanel).Height;
  End;
  if outerObject is TJvFormWallpaper then Begin
    outerTop := (outerObject as TJvFormWallpaper).Top;
    outerLeft := (outerObject as TJvFormWallpaper).Left;
    outerWidth := (outerObject as TJvFormWallpaper).Width;
    outerHeight := (outerObject as TJvFormWallpaper).Height;
  End;

  if innersubheight > 0 then
    innerPanel.Height := outerHeight - innersubheight;

  innerPanel.Top :=  (outerHeight div 2) - (innerPanel.Height div 2) + top;
  innerPanel.Left := (outerWidth div 2) - (innerPanel.Width div 2);


End;

procedure centreFisrtInsideSecond(var innerMemo:TTntMemo; outerObject:TObject;innersubheight:integer); Overload;
Var
  outerTop, outerLeft, outerWidth, outerHeight : Integer;
  innerTop, innerLeft, innerWidth, innerHeight : Integer;
Begin
  //get outer settings
  if outerObject is TForm then Begin
    outerTop := (outerObject as TForm).Top;
    outerLeft := (outerObject as TForm).Left;
    outerWidth := (outerObject as TForm).Width;
    outerHeight := (outerObject as TForm).Height;
  End;
  if outerObject is TJvPanel then Begin
    outerTop := (outerObject as TJvPanel).Top;
    outerLeft := (outerObject as TJvPanel).Left;
    outerWidth := (outerObject as TJvPanel).Width;
    outerHeight := (outerObject as TJvPanel).Height;
  End;
  if outerObject is TPanel then Begin
    outerTop := (outerObject as TPanel).Top;
    outerLeft := (outerObject as TPanel).Left;
    outerWidth := (outerObject as TPanel).Width;
    outerHeight := (outerObject as TPanel).Height;
  End;

  if innersubheight > 0 then
    innerMemo.Height := outerHeight - innersubheight;

  innerMemo.Top :=  (outerHeight div 2) - (innerMemo.Height div 2);
  innerMemo.Left := (outerWidth div 2) - (innerMemo.Width div 2);
End;

{Function executeApplicationzz(ProgramName, Paramaters  : WideString; Wait: Boolean):Boolean;
Var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
  CreateOK : Boolean;
begin
    // fill with known state
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);
  if Paramaters = '' then Begin
    CreateOK := CreateProcess(nil, PChar(ProgramName), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);
  end Else Begin
    CreateOK := CreateProcess(PChar(ProgramName),  PChar(Paramaters), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, nil, StartInfo, ProcInfo);
  End;
    // check to see if successful
  if CreateOK then
    begin
        //may or may not be needed. Usually wait for child processes
      if Wait then
        WaitForSingleObject(ProcInfo.hProcess, INFINITE);
    end
  else
    begin
      //ShowMessage('Unable to run '+ProgramName);
     end;

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
  Result := CreateOK;
end;}

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

Function exeApp2(ProgramName  : String):Boolean; overload;
Begin
  ShellExecute(0, nil, PChar(ProgramName), nil, nil, SW_SHOW);
end;

Function exeApp(ProgramName  : String; Paramaters:String=''; Wait: Boolean=False;UseProgramDir:Boolean=false):Boolean;
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

function stripDateTime(isDate:Boolean;fDateTime:TDateTime):TDateTime;
Var
  zDateTime : TDateTime;
  s : String;
  rDateTime : TFormatSettings;
begin
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, rDateTime);
  //Fucking delphi is not returning time and dates the way its suppose to, its fucking returning it as the FULL DateTime :(
  zDateTime := now;

  If isdate = True then Begin
    s := FloatToStr(fDateTime);
    MatStringDelete2End(s,rDateTime.DecimalSeparator);
    zDateTime := StrToFloat(s + rDateTime.DecimalSeparator + '0')
  End Else Begin
    s := FloatToStr(fDateTime);
    MatStringDeleteUp2(s,rDateTime.DecimalSeparator);
    zDateTime := StrToFloat('0' + rDateTime.DecimalSeparator + s );
  End;
  //zDateTime := zDate + zTime;
  Result := zDateTime
end;

function matFileStripExt(aFileName:String):String;
Var
  s : String;
Begin
  s := aFileName;
  s := matStringCopyRemoveBack(s,'.');
  Result := s;
End;

function matFileGetExt(aFileName:String):String;
Var
  s : String;
Begin
  s := aFileName;
  s := matStringCopyRemoveFrontBack(s,'.');
  Result := s;
end;

function CountInLine(Str: string): Integer;
var
  Count,Inter: Integer;
  TimeStr,Symbol: string;
begin
  Symbol:='!@#$%^&*()~[]{}":?<>,.|\/*';
  Count:=0;
  while Length(Str)>0 do
  begin
    if Pos(' ',Str)=1 then Delete(Str,1,1)
    else
    begin
      TimeStr:=Copy(Str,1,Pos(' ',Str)-1);
      try
        Inter:=StrToInt(TimeStr);
        Count:=Count-1;
      except
        on EConvertError do Count:=Count;
      end;
      if (Length(TimeStr)=1) and (Pos(TimeStr,Symbol)<>0) then
        Count:=Count-1;
      if TimeStr='' then Str:=''
      else Delete(Str,1,Pos(' ',Str)-1);
      Count:=Count+1;
    end;
  end;
  CountInLine:=Count;
end;

function stripEmptyLines(list:TTntStringList):TTntStringList;
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

function floatString2DateTime(str:string):TDateTime;
Var
  aDateTime : TDateTime;
  rDateTime : TFormatSettings;
Begin
  try
    if str <> '' then Begin
      if Pos('\',str) > 0 then
        aDateTime := now
      else
      if Pos('/',str) > 0 then
        aDateTime := now
      else
        aDateTime := StrToFloat(str)
    end else
      aDateTime := now;
  except
    aDateTime := now;
    Try
      GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, rDateTime);
      MatStringReplace(str,'.',rDateTime.DecimalSeparator,True);
      MatStringReplace(str,',',rDateTime.DecimalSeparator,True);
      aDateTime := StrToFloat(str);
    except
    end;
  end;
  result := aDateTime;
end;

function CopyDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_COPY;
    //fFlags := FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;


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

function DelDir(dir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_DELETE;
    fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    pFrom  := PChar(dir + #0);
  end;
  Result := (0 = ShFileOperation(fos));
end;

function GetCharFromVirtualKey(Key: Word): string;
var
   keyboardState: TKeyboardState;
   asciiResult: Integer;
begin
   GetKeyboardState(keyboardState) ;

   SetLength(Result, 2) ;
   asciiResult := ToAscii(key, MapVirtualKey(key, 0), keyboardState, @Result[1], 0) ;
   case asciiResult of
     0: Result := '';
     1: SetLength(Result, 1) ;
     2:;
     else
       Result := '';
   end;
end;


// returns the command in a bor "statement" as lowercase
// e.g: '     aTTaCk'#9'   '134   545'    -> 'attack'
function getBORCommand(borline : string):string;
var
  i, l : integeR;
  s : string;
begin
  s := lowercase(borline);
  s := trim(sysutils.stringreplace(s, #9 , ' ', [rfReplaceAll]));
  i := 0; l := length(s);
  while(i < l) do begin
    if s[i + 1] = ' ' then begin
      result := copy(s, 1, i + 1);
      exit;
    end;
    inc(i);
  end;
  if(i > 0) then result := copy(s, 1, i + 1)
  else result := '';
end;


// returns the number of integers found.
function stripStringIntegers(s:string; var intarr: TIntArr8):integer;
var
  p, intstart, stringstart : pchar;
  l : integer;
  temp: string;
  label addint;
begin
  result := 0;
  l := length(s);
  stringstart := @s[1];
  p := stringstart;
  intstart := nil;
  // skip leading whitespace:
  while(l > 0) do begin
      case p^ of
         #9, ' ', #13, #10:
         begin
           inc(p);
           dec(l);
         end;
         '#': exit;
      else break;
      end;
  end;
  //skip first "word"
  while(l > 0) do begin
      case p^ of
         'A' .. 'Z', 'a' .. 'z', '0'..'9':
         begin
           inc(p);
           dec(l);
         end;
         '#': exit;
      else break;
      end;
  end;
  // now find the ints..
  while(l > 0) do begin
      case p^ of
         #9, ' ', #13, #10, '#': begin
           addint:
           if(intstart <> nil) then begin
             if(result >= (sizeof(TIntArr8) / sizeof(intarr[0]))) then exit;
             // TODO the string allocation is costly, write a custom strtoint working on pchars
             temp := copy(s, 1 + cardinal(intstart) - cardinal(stringstart), cardinal(p) - cardinal(intstart));
             intarr[result] := strtoint(temp);
             inc(result);
           end;
           intstart := nil;
           if p^ = '#' then exit;
         end;
         '0' .. '9':
           if not assigned(intstart) then intstart := p;
      end;
      dec(l);
      inc(p);
  end;
  if intstart <> nil then goto addint;
end;

End.
