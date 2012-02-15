(* TZipMasterSFX (C) 2002<br><br>

   written by markus stephany, http://delphizip.mirkes.de, mailto:merkes@@mirkes.de<br><br>

   last changed: 09/06/2002<br><br>

   this component is part of the Delphi Zip VCL by Chris Vleghert and Eric W. Engler
   www: http://www.geocities.com/SiliconValley/Network/2114/zipbeta.html<br><br>

   this component is some kind of "snap-in" for TZipMaster to support the new sfx.<br><br>

   it tries to be compatible (as much as possible) with TZipMaster's sfx handling,
   so some of the new sfx features are not available in TZipMasterSFX.<br><br>

   To use all features of the new sfx, use the (not yet available ;-)) TZipSfx
   component instead (http://delphizip.mirkes.de), but that one works quite
   different.<br><br>

   differences between TZipMasterSFX and TZipMaster's sfx handling:<br><br>

   - it uses a different sfx stub 'dzsfx[lang].bin' (not ZIPsfx.bin), this one should be
   placed in the same directory where the old zipsfx.bin is (or set its own
   SFXPath property properly).<br><br>

   - it uses an associated TZipMaster component to get the SFX... properties (and
     also for ShowZipMessage and things like this)<br><br>

   - to convert a TZipMaster's zip to an exe, set all properties in the associated
     TZipMaster component and then call TZipMasterSFX.ConvertToExe rather than
     TZipMaster.ConvertEXE, if conversion was successfull, the TZipMaster will
     automatically use the converted SFX as its ZipFileName (no special action
     must be taken).<br><br>

   - to convert a TZipmaster's sfx-zip to an ordinary zipfile, call
     TZipMasterSFX.ConvertToZip instead of TZipMaster.ConvertZip.<br><br>

   - to create a new sfx-zip, you should do something like this (this one's not
     yet tested):<br><br>
     1) set the sfx's properties in the ZipMaster component.<br><br>
     2) call ZipMasterSFX1.CreateNewSFX(FileName).<br><br>
     3) if creation was successfull, the associated ZipMaster should automatically<br><br>
        use the newly created SFX as its ZipFile(Name).<br><br>

*)

unit ZipMstrSFX;

interface

uses
  ZipMstr, ZipMsg, SFXInterface, Windows, Messages, SysUtils,
  Classes, Controls, Graphics, Forms, SFXStructs;

type
  TZipMasterSFX = class(TComponent)
  private
    FMySFXMessage: string;
    FMySFXOptions: TSFXOptions;
    FMySFXOverwriteMode: TSFXOverwriteMode;
    FMySFXMessageFlags: cardinal;
    FZipMaster: TZipMaster;
    FSFXPath: TFileName;
    procedure CheckZipMaster;
    function GetVersion: string;
    procedure SetVersion(const Value: string);
  protected
    //@exclude()
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    //@exclude()
    procedure GetPropertiesFromZipMaster; virtual;
    //@exclude()
    function DoConvertOrCreateSFX(const sFile: string;
      const bCreateNew: boolean): integer;
    //@exclude()
    function ReadSFXProperties(const iInFile, iMaxPos: integer): Integer;
    //@exclude()
    function ReadNewSFXProperties(const iInFile, iMaxPos: integer): Integer;
    //@exclude()
    function ReadSFXIcon(sFile: string): integer;
  public
    // @exclude()
    constructor Create(aOwner: TComponent); override;
    (* Converts the ZIP archive (according to the sfx related options of the ZipMaster component)  to a SFX archive
       and updates the ZipMaster component to use the newly created file.
    *)
    function ConvertToSFX: integer;
    (* Converts the SFX archive (in the ZipMaster property's ZipFileName) to a ZIP archive and updates the
       ZipMaster component to use the newly created file.
    *)
    function ConvertToZip: integer;
    (* Creates a new, empty SFX archive (according to the sfx related options of the ZipMaster component) and
       updates the ZipMaster component to use this newly created file.
    *)
    function CreateNewSFX(const sFile: string): integer;
  published
    (* This is the path of the binary SFX stub "DZSFX[lang].BIN". This stub is needed to convert ZIP archives to
       self extracting EXE archives and also to create a new SFX.<br><br>

       There are at least two possibilities how to manage the stub:<br><br>
       1) Place the file dzsfx.bin in your application directory and set the SFXPath property to
          "dzsfx[lang].bin".<br><br>
       2) Place the stub in your windows system directory and set the SFXPath property accordingly
          or just also to "dzsfx[lang].bin").<br><br>

       <u>Notes:</u><br><br>
       the [lang] placeholder stands for the desired language of the sfx stub. currently the are sfx's in english,
       german and italian. you can change the language at runtime by setting the global variable @link(DZSFX_LANG)
       to a different language identifier (currently 'US', 'IT' and 'DE').<br><br><br><br>
    *)
    property SFXPath: TFileName read FSFXPath write FSFXPath;
    (* Set this to a TZipMaster component on your form, the TZipMasterSFX will use its properties and also its
       event handlers (to display messages and so on).
    *)
    property ZipMaster: TZipMaster read FZipMaster write FZipMaster;
    // Shows the release/version of the TZipMasterSFX component.
    property Version: string read GetVersion write SetVersion;
  end;

  // copy a buffer from a file to another, returns 0 on ok
  // iReadLen: amount of data to copy, if -1, then up to eof
  //@exclude()
function CopyBuffer(const iInFile, iOutFile: integer; iReadLen: integer): integer;

  // replace an icon in the given file
  //@exclude()
function ReplaceIcon(const iExeFile, iMaxPos: integer; oIcon: TIcon): integer;

  // read end of central record from iInFile and return its position
  //@exclude()
function ReadEOC(const iInFile: integer; var recEOC: ZipEndOfCentral): integer;

  // copy and adjust central dirs and end of central dir
  //@exclude()
function CopyAndAdjustCentralDir(const iInFile, iOutFile, iNumEntries, iDiskToAdjust,
  iOffset: integer): integer;

  // return the position of the first local file header in the file
  // -1 on error, else not the absolute file position is read but the value from the central directory
  //@exclude()
function GetFirstLocalHeader(const iInFile, iNumEntries, iWhichDisk, iPosition: integer): integer;

  //@exclude()
procedure Register;

{$IFNDEF PASDOC}
{$I SFXVER.INC}
{$ENDIF}

implementation
uses
  ShellAPI{$IFDEF ZM170UP}, ZipStructs{$ENDIF};

{$I LANG2.INC}

const
  SE_CreateError = -1;
  SE_CopyError = -2;
  SE_OpenReadError = -3;
  SE_SetDateError = -4;
  SE_GeneralError = -9;
  SE_NoFoundError = -10;
  SE_OutOfMemError = -10; // duplicate id! in zipmstr
  SE_MemStreamError = -11;
  SE_IconSizeError = -12;
  SE_NoSpanningSupport = -101;
  SE_ErrorInCentral = -102;

procedure Register;
begin
  RegisterComponents('Delphi Zip', [TZipMasterSFX]);
end;

// copy a buffer from a file to another, returns 0 on ok
// iReadLen: amount of data to copy, if -1, then up to eof
function CopyBuffer(const iInFile, iOutFile: integer; iReadLen: integer): integer;
var
  recBuffer: TSFXBuffer;
  iRead, iToRead: integer;
begin
  Result := 0;
  iToRead := SFXBufSize;
  try
    repeat
      if iReadLen >= 0 then
      begin
        iToRead := iReadLen;
        if SFXBufSize < iReadLen then iToRead := SFXBufSize;
      end;

      iRead := FileRead(iInFile, recBuffer, iToRead);
      if FileWrite(iOutFile, recBuffer, iRead) <> iRead then
      begin
        Result := SE_CopyError;
        break;
      end;

      if iReadLen > 0 then dec(iReadLen, iRead);

      Application.ProcessMessages;  // needed for winsock ?
    until ((iReadLen = 0) or (iRead <> iToRead));
  except
    Result := SE_CopyError;
  end;
end;


// replace an icon in the given file
function ReplaceIcon(const iExeFile, iMaxPos: integer; oIcon: TIcon): integer;


  function BrowseResDir(const pResStart: pIRD; const pDir: pIRD; iDepth: integer): cardinal;
  forward;

    // search for the right(with our icon) resource directory entry.
  function SearchResDirEntry(const pResStart: pIRD; const pEntry: pIRDirE;
    iDepth: integer): cardinal;
  var
    pData: pIRDatE;
  begin
    Result := 0;
    with pEntry^ do
    begin
      if (un1.NameIsString and $80000000) <> 0 then Exit;   // No named resources.
      if (iDepth = 0) and (un1.Id <> 3) then Exit;           // Only icon resources.
      if (iDepth = 1) and (un1.Id <> 1) then Exit;           // Only icon with ID 0x1.
      if (un2.DataIsDirectory and $80000000) = 0 then
      begin
        pData := pIRDatE(PChar(pResStart) + un2.OffsetToData);
        with pData^ do
          if Size = 744 then Result := OffsetToData;
      end
      else
        Result := BrowseResDir(pResStart, pIRD(PChar(pResStart) +
          (un2.OffsetToDirectory and $7FFFFFFF)), iDepth + 1)
    end;
  end;

    // browse through all resource directories.
  function BrowseResDir(const pResStart: pIRD; const pDir: pIRD;
    iDepth: integer): cardinal;
  var
    pSingleRes: pIRDirE;
    i: integer;
  begin
    Result := 0;
    pSingleRes := pIRDirE(PChar(pDir) + SizeOf(IMAGE_RESOURCE_DIRECTORY));
    with pDir^ do
      for i := 0 to Pred(NumberOfNamedEntries + NumberOfIdEntries) do
      begin
        Result := SearchResDirEntry(pResStart, pSingleRes, iDepth);
        if Result <> 0 then Break;   // Found the one w're looking for.
        Inc(pSingleRes, 1);
      end;
  end;

    // find resource directory entry.
  function LookForDirs(const pSectionData: Pointer; const cSectionVirtualStart: cardinal;
    const iSectionLen: integer; const pDirectories: pIDD): cardinal;
  var
    pResStart: Pointer;
    pDirs: pIDD;
  begin
    Result := 0;
    pDirs := pDirectories;
    Inc(pDirs, IMAGE_DIRECTORY_ENTRY_RESOURCE);
    with pDirs^ do
    begin
      if (VirtualAddress <> 0) and (PChar(VirtualAddress) >= PChar(cSectionVirtualStart))
        and
        (PChar(VirtualAddress) < (PChar(cSectionVirtualStart) + iSectionLen)) then
      begin
        pResStart := PChar(pSectionData) + (VirtualAddress - cSectionVirtualStart);
        Result := BrowseResDir(pResStart, pResStart, 0);
      end;
    end;
  end;


var
  pEXE: PChar; // buffer that holds the executable
  strIco: TMemoryStream; // icon stream

  // pe structures
  iSection: integer; // current section
  cFoundAddr: cardinal;
  pSectionHeader: pISH; // section header
begin
  Result := SE_NoFoundError;
  cFoundAddr := 0;

  GetMem(pEXE, iMaxPos+1);
  strIco := TMemoryStream.Create;
  try
    try

      // read in the sfx
      FileSeek(iExeFile, 0, FILE_BEGIN);
      FileRead(iExeFile, pEXE^, iMaxPos);

      // search for dos/pe
      with IMAGE_DOS_HEADER(Pointer(pEXE)^) do
      begin
        if e_magic <> IMAGE_DOS_SIGNATURE then exit; // not a dos exe
        with PEheader(Pointer(pEXE + _lfanew)^) do
        begin
          if signature <> IMAGE_NT_SIGNATURE then exit; // not a pe executable
          if _head.NumberOfSections = 0 then exit; // no sections ???

          // get 1st section header pos
          pSectionHeader := @section_header;

          // iterate over all sections
          for iSection := 0 to Pred(_head.NumberOfSections) do
          begin
            // search for resource section
            if StrComp(@(pSectionHeader^.Name), '.rsrc') = 0 then
            begin
              // resource section found
              with pSectionHeader^ do
              begin
                // search for icon resource
                cFoundAddr := LookForDirs(pEXE + PointerToRawData, VirtualAddress,
                  SizeOfRawData, @opt_head.DataDirectory);
                if cFoundAddr = 0 then exit; // no matching resource found

                // change memory offset to file offset.
                cFoundAddr := cFoundAddr - VirtualAddress + PointerToRawData;
                Break;
              end;
            end;
            Inc(pSectionHeader, 1);
          end;
        end;
      end;

      with strIco do
      begin
        oIcon.SaveToStream(strIco);
        // Only handle icons with this size.
        if Size = 766 then
        begin
          // Reposition to the actual data and put it into a buffer.
          Seek(22, soFromBeginning);
          ReadBuffer(pEXE^, 744);
          // Go to start of the icon resource in the new created file.
          FileSeek(iEXEFile, cFoundAddr, FILE_BEGIN);
          // And write the changed icon data from the buffer.
          FileWrite(iEXEFile, pExe^, 744);
          FileSeek(iExeFile, 0, FILE_END);
          Result := 0;
        end
        else
          Result := SE_IconSizeError;
      end;

    except
      Result := SE_MemStreamError;
    end;
  finally
    strIco.Free;
    FreeMem(pEXE);
  end;
end;

// read end of central record from iInFile and return its position
function ReadEOC(const iInFile: integer; var recEOC: ZipEndOfCentral): integer;
var
  pRec: ^ZipEndOfCentral;
  iBufferSize, iRead: integer;
  pBuffer: PChar;
  i: integer;
  bOK: boolean;
  iFileSize: integer;
begin
  bOK := False;
  iFileSize := FileSeek(iInFile, 0, FILE_END);
  iBufferSize := iFileSize;
  if iBufferSize > (sizeof(ZipEndOfCentral) + 65536) then
    iBufferSize := (sizeof(ZipEndOfCentral) + 65536);

  // first try to read the record straight from the end ( works if no comment is stored)
  Result := FileSeek(iInFile, - sizeof(ZipEndOfCentral), FILE_CURRENT);
  if Result <> -1 then
  begin
    FileRead(iInFile, recEOC, sizeof(ZipEndOfCentral));
    if recEOC.HeaderSig <> EndCentralDirSig then
    begin
      // not found at the end, read in a buffer
      if iBufferSize > sizeof(ZipEndOfCentral) then
      begin
        Result := FileSeek(iInFile, - iBufferSize, FILE_END);
        if Result <> -1 then
        begin
          GetMem(pBuffer, iBufferSize+1);
          try
            iRead := FileRead(iInFile, pBuffer^, iBufferSize);
            if iRead = iBufferSize then
            begin
              // now search from start
              for i := 0 to iBufferSize - sizeof(ZipEndOfCentral) do
              begin
                pRec := Pointer(integer(pBuffer) + i);
                with pRec^ do
                  if HeaderSig = EndCentralDirSig then
                  begin
                    if (ZipCommentLen + Result + i +
                      sizeof(ZipEndOfCentral)) <= iFileSize then // changed because of trash at end of winzip sfx'es
                    begin
                      bOK := True; // set ok flag
                      Result := Result + i;
                      Move(pRec^, recEOC, sizeof(ZipEndOfCentral));
                      Break;
                    end;
                  end;
              end;
            end
          finally
            FreeMem(pBuffer);
          end;
        end;
      end;
    end
    else
      bOK := True;
  end;

  if not bOK then
    Result := -1;
end;

// copy and adjust central dirs and end of central dir
function CopyAndAdjustCentralDir(const iInFile, iOutFile, iNumEntries, iDiskToAdjust,
  iOffset: integer): integer;
var
  iCur: integer;
  recCentral: ZipCentralHeader;
  recEOC: ZipEndOfCentral;
  pData: Pointer;
begin
  Result := SE_ErrorInCentral;
  GetMem(pData, 65536 * 3); // filename + extrafield + filecomment
  try
    if iNumEntries > 0 then
    begin
      // write all central directory entries
      for iCur := 0 to Pred(iNumEntries) do
      begin
        if (FileRead(iInFile, recCentral, sizeof(ZipCentralHeader)) <>
          sizeof(ZipCentralHeader)) or
          (recCentral.HeaderSig <> CentralFileHeaderSig) then
          exit;  // invalid record

        if recCentral.DiskStart = iDiskToAdjust
        then
          Inc(recCentral.RelOffLocal, iOffset);  // adjust offset

        if FileWrite(iOutFile, recCentral, sizeof(ZipCentralHeader)) <>
          sizeof(ZipCentralHeader) then
        begin
          Result := SE_CopyError;
          exit;
        end;

        // read and write extra data
        with recCentral do
        begin
          if (FileNameLen + ExtraLen + FileComLen) > 0 then
          begin
            if FileRead(iInFile, pData^, FileNameLen + ExtraLen + FileComLen)
              <> (FileNameLen + ExtraLen + FileComLen) then
              exit;
            if FileWrite(iOutFile, pData^, FileNameLen + ExtraLen + FileComLen) <>
              (FileNameLen + ExtraLen + FileComLen) then
            begin
              Result := SE_CopyError;
              exit;
            end;
          end;
        end;
      end;
    end;

    // read, adjust and write end of central
    if (FileRead(iInFile, recEOC, sizeof(ZipEndOfCentral)) <> sizeof(ZipEndOfCentral)) or
      (recEOC.HeaderSig <> EndCentralDirSig) then
      exit;
    Inc(recEOC.CentralOffSet, iOffset);
    if FileWrite(iOutFile, recEOC, sizeof(ZipEndOfCentral)) <> sizeof(ZipEndOfCentral) then
    begin
      Result := SE_CopyError;
      exit;
    end;

    // read an eventually existing file comment
    with recEOC do
      if ZipCommentLen > 0 then
      begin
        if FileRead(iInFile, pData^, ZipCommentLen) <> ZipCommentLen then
          exit;
        if FileWrite(iOutFile, pData^, ZipCommentLen) <> ZipCommentLen then
        begin
          Result := SE_CopyError;
          exit;
        end;

        Result := 0;
      end
    else
      Result := 0;

  finally
    FreeMem(pData);
  end;
end;

  // return the position of the first local file header in the file
  // -1 on error, else not the absolute file position is read but the value from the central directory
function GetFirstLocalHeader(const iInFile, iNumEntries, iWhichDisk, iPosition: integer): integer;
var
  recCentral: ZipCentralHeader;
  iCur: Integer; // loop
begin
  Result := SE_ErrorInCentral;
  if (iNumEntries < 1) or (FileSeek(iInFile, iPosition, FILE_BEGIN) <> iPosition) then exit
  else
    for iCur := 0 to Pred(iNumEntries) do
    begin
      // read central dir
      if (FileRead(iInFile, recCentral, sizeof(ZipCentralHeader)) <> sizeof(ZipCentralHeader)) or
        (recCentral.HeaderSig <> CentralFileHeaderSig) then
      begin
        Result := SE_ErrorInCentral;
        exit;  // invalid record
      end;

      // first ?
      if ((Result < 0) or (recCentral.RelOffLocal < Result)) and (recCentral.DiskStart = iWhichDisk)
      then
        Result := recCentral.RelOffLocal; // store

        // read over extra data
        with recCentral
        do
          if (FileNameLen + ExtraLen + FileComLen) > 0
          then
            FileSeek(iInFile, FileNameLen + ExtraLen + FileComLen, FILE_CURRENT);
    end;
end;


{ TZipMasterSFX }

constructor TZipMasterSFX.Create(aOwner: TComponent);
begin
  inherited;
  FZipMaster := nil;
  FSFXPath := 'DZSFX'+DZSFX_LANG+'.BIN';  // set at compile time when using make -DLANG=<lg> vcl
end;


function TZipMasterSFX.DoConvertOrCreateSFX(const sFile: string;
  const bCreateNew: boolean): integer;
var
  sOutFile: string; // output filename
  iOutFile: integer; // handle to output file
  szSearchPath: array[0..MAX_PATH] of char; // buffer for searchpath
  p: PChar; // buffer for searchpath (temp) and TSFXHeader
  recEnd: TSFXFileEndOfHeader; // stored to quickly find an TSFXFileHeader
  sErrMsg: string; // error if strings are too long (> 255 chars)
  iHeaderSize: integer; // overall size of the header + strings
  crSave: TCursor; // save cursor
  i: integer; // position counter for string storing
  iInFile: integer; // input file handle
  iSizeOfSFX: integer; // size of the sfx exe part
  iSizeOfOut: integer; // overall resulting file size
  iSizeOfZip: integer; // size of the zip file
  iPosOfEOC: integer; // position of the end of central record in the zip file
  iDelta: integer; // eventually wrong central dir offsets
  recEOC: ZipEndOfCentral; // eoc record in zip
begin
  p := nil;
  // get sfx options from zipmaster
  GetPropertiesFromZipMaster;

  // assume error
  Result := SE_GeneralError;
  iSizeOfSFX := -1;
  iSizeOfOut := -1;
  iSizeOfZip := -1;


  with FZipMaster do
  begin
    // convert a zip to an sfx
    if not bCreateNew then
    begin
      // file must exist
      if not FileExists(sFile) then
      begin
        ShowZipMessage(GE_NoZipSpecified, '');
        exit;
      end;

      // file must be a zip
      if UpperCase(ExtractFileExt(sFile)) <> '.ZIP' then
      begin
        ShowZipMessage(SF_InputIsNoZip, '');
        exit;
      end;

      // rename to exe
      sOutFile := ChangeFileExt(sFile, '.exe');
    end
    else
      sOutFile := sFile;

    // try to find FSFXPath
    if not FileExists(FSFXPath) then
    begin
      SetString(FSFXPath, szSearchPath, SearchPath(nil,
        PChar('DZSFX'+DZSFX_LANG+'.BIN'), nil, sizeof(szSearchPath), szSearchPath, p));
      if not FileExists(FSFXPath) then
      begin
        FSFXPath := DLLDirectory + '\DZSFX'+DZSFX_LANG+'.BIN';
        if not FileExists(FSFXPath) then
        begin
          ShowZipMessage(SF_NoZipSFXBin, '');
          exit;
        end;
      end;
    end;

    // check string lengths
    sErrMsg := '';
    if Length(SFXCaption) > 255 then sErrMsg := 'SFXCaption';

    if Length(SFXCommandLine) > 255 then
    begin
      if sErrMsg <> '' then sErrMsg := sErrMsg + ', ';
      sErrMsg := sErrMsg + 'SFXCommandLine';
    end;

    if Length(SFXDefaultDir) > 255 then
    begin
      if sErrMsg <> '' then sErrMsg := sErrMsg + ', ';
      sErrMsg := sErrMsg + 'SFXDefaultDir';
    end;

    if Length(FMySFXMessage) > 255 then
    begin
      if sErrMsg <> '' then sErrMsg :=
          sErrMsg + ', ';
      sErrMsg := sErrMsg + 'SFXMessage';
    end;

    // string too long, show error and exit
    if sErrMsg <> '' then
    begin
      ShowZipMessage(SF_StringToLong, #13#10 + sErrMsg);
      exit;
    end;

    // calculate overall header size
    iHeaderSize := sizeof(TSFXFileHeader) + Length(SFXCaption) +
      Length(SFXCommandLine) + Length(SFXDefaultDir) + Length(FMySFXMessage);
    // make dword aligned
    iHeaderSize := ((iHeaderSize + 3) div 4) * 4;

    try
      GetMem(p, iHeaderSize+1);
    except
      ShowZipMessage(GE_NoMem, '');
      exit;
    end;

    // save curosor and show wait
    crSave := Screen.Cursor;
    Screen.Cursor := crHourGlass;

    try
      // create header
      with PSFXFileHeader(p)^ do
      begin
        Signature := SFX_HEADER_SIG;
        Size := iHeaderSize;
        Options := FMySFXOptions;
        DefOVW := FMySFXOverwriteMode;
        CaptionSize := Length(SFXCaption);
        PathSize := Length(SFXDefaultDir);
        CmdlineSize := Length(SFXCommandLine);
        RegFailPathSize := 0;
        // not implemented in zipmaster, use TZipSFX rather than TZipMasterSFX
        StartMsgSize := Length(FMySFXMessage);
        StartMsgType := FMySFXMessageFlags;
      end;

      // set end of fileheader
      recEnd.Signature := SFX_HEADER_END_SIG;
      recEnd.HeaderSize := iHeaderSize;

      // store strings
      i := sizeof(TSFXFileHeader);
      if SFXCaption <> '' then
      begin
        StrPCopy(p + i, SFXCaption);
        i := i + Length(SFXCaption);
      end;

      if SFXDefaultDir <> '' then
      begin
        StrPCopy(p + i, SFXDefaultDir);
        i := i + Length(SFXDefaultDir);
      end;

      if SFXCommandLine <> '' then
      begin
        StrPCopy(p + i, SFXCommandLine);
        i := i +
          Length(SFXCommandLine);
      end;

      if FMySFXMessage <> '' then
      begin
        StrPCopy(p + i, FMySFXMessage);
        // i := i + Length(FMySFXMessage);
      end;

      // delete existing file
      if FileExists(sOutFile) then
        EraseFile(sOutFile, HowToDelete);

      // start writing
      iOutFile := FileCreate(sOutFile);
      if iOutFile <> -1 then
      begin
        iInFile := FileOpen(FSFXPath, fmOpenRead or fmShareDenyWrite);
        if iInFile = -1 then Result := SE_OpenReadError
        else
        begin
          // copy sfx stub
          Result := CopyBuffer(iInFile, iOutFile, - 1);
          iSizeOfSFX := FileSeek(iInFile, 0, FILE_END);
          FileClose(iInFile);

          // replace icon
          if (Result = 0) and (not SFXIcon.Empty) then
            Result := ReplaceIcon(iOutFile, iSizeOfSFX, SFXIcon);

          if Result = 0 then
          begin
            // write TSFXFileHeader and end header
            if (FileWrite(iOutFile, p^, iHeaderSize) <> iHeaderSize) or
               (FileWrite(iOutFile, recEnd, sizeof(recEnd)) <> sizeof(recEnd))
            then
              Result := SE_CopyError
            else
            begin
              // if conversion
              if not bCreateNew then
              begin
                iInFile := FileOpen(sFile, fmOpenRead or fmShareDenyWrite);
                if iInFile = -1 then Result := SE_OpenReadError
                else
                begin
                  // read end of central from zipfile
                  iPosOfEOC := ReadEOC(iInFile, recEOC);
                  if iPosOfEOC > 0 then   // ok, eoc found
                  begin
                    // calculate delta (if wrong offsets are stored in zip-file)
                    iDelta := iPosOfEOC - (recEOC.CentralOffset + recEOC.CentralSize);

                    // currently only nonspanned archives are supported
                    if (recEOC.ThisDiskNo <> recEOC.CentralDiskNo) or
                      (recEOC.CentralEntries <> recEOC.TotalEntries) then
                      Result := SE_NoSpanningSupport
                    else
                    begin
                      // write zip file
                      iSizeOfZip := iPosOfEOC + sizeof(ZipEndOfCentral) +
                        recEOC.ZipCommentLen;
                      FileSeek(iInFile, 0, FILE_BEGIN);

                      // copy local data
                      Result := CopyBuffer(iInFile, iOutFile,
                        recEOC.CentralOffset + iDelta);

                      // copy and adjust central dir
                      if Result = 0 then
                        Result := CopyAndAdjustCentralDir(iInFile, iOutFile, recEOC.CentralEntries,
                          recEOC.ThisDiskNo, iDelta + iSizeOfSFX + iHeaderSize + sizeof(recEnd));

                      iSizeOfOut := FileSeek(iOutFile, 0, FILE_END);
                    end;
                  end
                  else
                    Result := SE_ErrorInCentral;
                  FileClose(iInFile);
                end;
              end
              else
              begin
                // create a new file

                // fill in the eoc record
                FillChar(recEOC, sizeof(ZipEndOfCentral), 0);
                recEOC.HeaderSig := EndCentralDirSig;
                recEOC.CentralOffset := iSizeOfSFX + iHeaderSize + sizeof(recEnd);

                // and write it to the file
                if FileWrite(iOutFile, recEOC, SizeOf(ZipEndOfCentral)) <>
                  SizeOf(ZipEndOfCentral) then
                  Result := SE_CopyError
                else
                begin
                  Result := 0;
                  iSizeOfOut := FileSeek(iOutFile, 0, FILE_END);
                  iSizeOfZip := 0;
                end;
              end;
            end;
          end;
        end;
        FileClose(iOutFile);
      end
      else
        Result := SE_CreateError;

      // extra check
      if (Result = 0) and ((iSizeOfSFX = -1) or (iSizeOfOut = -1) or (iSizeOfZip = -1)) then
        Result := SE_GeneralError;

      if (Result = 0) and (not bCreateNew) then
        EraseFile(sFile, HowToDelete);

      if Result <> 0 then
      begin
        if FileExists(sOutFile) then
          DeleteFile(sOutFile);
      end
      else
        // update the associated TZipMaster component
        ZipFileName := sOutFile;

    finally
      Screen.Cursor := crSave;
      try
        FreeMem(p);
      except
      end;
    end;
  end;
end;

function TZipMasterSFX.ConvertToZip: integer;
var
  sOutFile: string; // output filename
  iOutFile: integer; // handle to output file
  crSave: TCursor; // save cursor
  iInFile: integer; // input file handle
  iSizeOfSFX: integer; // size of the sfx exe part + MPV/MPU/TSFXHeader block
  iSizeOfOut: integer; // overall size of the written file
  iSizeOfIn: integer; // overall size of the input file
  iPosOfEOC: integer; // position of the end of central record in the zip file
  iDelta: integer; // eventually wrong central dir offsets
  recEOC: ZipEndOfCentral; // eoc record in zip
begin
  // zipmaster must exist
  CheckZipMaster;

  // get sfx options from zipmaster
  GetPropertiesFromZipMaster;

  // assume error
  Result := SE_GeneralError;
  iSizeOfSFX := -1;
  iSizeOfIn := -1;
  iSizeOfOut := -1;

  with FZipMaster do
  begin

    // file must exist
    if not FileExists(ZipFileName) then
    begin
      ShowZipMessage(CZ_NoExeSpecified, '');
      exit;
    end;

    // file must be a exe
    if UpperCase(ExtractFileExt(ZipFileName)) <> '.EXE' then
    begin
      ShowZipMessage(CZ_InputNotExe, '');
      exit;
    end;

    // rename to zip
    sOutFile := ChangeFileExt(ZipFileName, '.zip');

    crSave := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try

      // open in file
      iInFile := FileOpen(ZipFileName, fmOpenRead or fmShareDenyWrite);
      if iInFile = -1 then Result := SE_OpenReadError
      else
      begin
        // read the eoc record
        iPosOfEOC := ReadEOC(iInFile, recEOC);
        if iPosOfEOC = 0 then Result := SE_ErrorInCentral
        else
        begin
          // calculate delta (if wrong offsets are stored in zip-file)
          iDelta := iPosOfEOC - (recEOC.CentralOffset + recEOC.CentralSize);

          // now find the first local file header
          iSizeOfSFX := GetFirstLocalHeader(iInFile, recEOC.CentralEntries, recEOC.ThisDiskNo, 
            recEOC.CentralOffSet + iDelta);
          if iSizeOfSFX < 0 then Result := SE_ErrorInCentral // no local file header found
          else
          begin
            Inc(iSizeOfSFX, iDelta);

            // delete an existing output file
            if FileExists( sOutFile ) then
               EraseFile( sOutFile, HowToDelete );

            // open output file
            iOutFile := FileCreate( sOutFile);
            if iOutFile = -1 then Result := SE_CreateError
            else
            begin
              FileSeek(iInFile, iSizeOfSFX, FILE_BEGIN);

              // write local data
              Result := CopyBuffer(iInFile, iOutFile, recEOC.CentralOffSet - iSizeOfSFX + iDelta);

              // write and adjust central data
              if Result = 0 then
              begin
                Result := CopyAndAdjustCentralDir(iInFile,
                  iOutFile, recEOC.CentralEntries, recEOC.ThisDiskNo, iDelta - iSizeOfSFX);
                if Result = 0
                then
                  iSizeOfOut := FileSeek(iOutFile, 0 ,FILE_END);
              end;

              FileClose(iOutFile);
            end;
          end;
        end;

        if Result = 0 then
        begin
          // read headers etc from input file
          Result := ReadSFXProperties(iInFile, iSizeOfSFX);
          if Result = 0 then
          begin
            // get the icon from the sfx
            ReadSFXIcon(ZipFileName);
            iSizeOfIn := FileSeek(iInFile, 0, FILE_END);
          end;
        end;

        FileClose(iInFile);
      end;

      if (Result = 0) and ((iSizeOfSFX = -1) or (iSizeOfOut = -1) or (iSizeOfIn = -1)) then
        Result := SE_GeneralError;

      if (Result = 0) then
      begin
        EraseFile(ZipFileName, HowToDelete);
        ZipFileName := sOutFile;
      end
      else
        if FileExists(sOutFile) then
          DeleteFile(sOutFile);

    finally
      Screen.Cursor := crSave;
    end;
  end;
end;

procedure TZipMasterSFX.GetPropertiesFromZipMaster;
var
  sMsg: string; // convert #1/#2message to message and flags
begin
  CheckZipMaster;

  // use zipmaster properties, so convert them to our own properties
  if Assigned(FZipMaster) then
    with FZipMaster do
    begin
      // convert message
      FMySFXMessageFlags := MB_OK;
      sMsg := SFXMessage;
      if sMsg <> '' then
        case sMsg[1] of
          #1:
            begin
              FMySFXMessageFlags := MB_OKCANCEL or MB_ICONINFORMATION;
              System.Delete(sMsg, 1,1);
            end;
          #2:
            begin
              FMySFXMessageFlags := MB_YESNO or MB_ICONQUESTION;
              System.Delete(sMsg, 1,1);
            end;
        end;
      FMySFXMessage := sMsg;

      // translate overwrite
      case SFXOverWriteMode of
        ovrConfirm: FMySFXOverwriteMode := somAsk;
        ovrAlways: FMySFXOverwriteMode := somOverwrite;
        ovrNever: FMySFXOverwriteMode := somSkip;
      end;

      // translate options
      FMySFXOptions := [soCheckAutoRunFileName]; // compatibility
      if SFXAskCmdLine in SFXOptions then
        Include(FMySFXOptions, soAskCmdLine);
      if SFXAskFiles in SFXOptions then
        Include(FMySFXOptions, soAskFiles);
      if SFXAutoRun in SFXOptions then
        Include(FMySFXOptions, soAutoRun);
      if SFXHideOverWriteBox in SFXOptions then
        Include(FMySFXOptions, soHideOverWriteBox);
      if SFXNoSuccessMsg in SFXOptions then
        Include(FMySFXOptions, soNoSuccessMsg);
    end;
end;

procedure TZipMasterSFX.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (aComponent = FZipMaster) then
    FZipMaster := nil;
end;


function TZipMasterSFX.ConvertToSFX: integer;
begin
  // need zipmaster for messages, properties etc
  CheckZipMaster;

  Result := DoConvertOrCreateSFX(FZipMaster.ZipFileName, False);
end;


function TZipMasterSFX.CreateNewSFX(const sFile: string): integer;
begin
  // need zipmaster for messages, properties etc
  CheckZipMaster;

  // file must be an exe
  if UpperCase(ExtractFileExt(sFile)) <> '.EXE' then
  begin
    FZipMaster.ShowZipMessage(CZ_InputNotExe, '');
    Result := SE_GeneralError;
  end
  else
    Result := DoConvertOrCreateSFX(sFile, True);
end;

procedure TZipMasterSFX.CheckZipMaster;
begin
  // need zipmaster for messages, properties etc
  if not Assigned(FZipMaster) then raise Exception.Create('No TZipMaster component assigned');
end;

function TZipMasterSFX.ReadSFXProperties(const iInFile,
  iMaxPos: integer): Integer;
var
  pData: PChar;
  iMax, i: Integer;
  bFlags: Byte;
  sTemp: string; // temp string for zipmaster assignment
  pLoop: PChar; // loop pchar
begin
  CheckZipMaster;

  Result := ReadNewSFXProperties(iInFile, iMaxPos);
  if Result <> 0 then
  begin
    iMax := 1032; // taken from zimstr.pas, hope it's enough for old headers ;-)
    if iMax > iMaxPos
    then
      iMax := iMaxPos;

    try
      GetMem(pData, iMax+1);
    except
      Result := SE_OutOfMemError;
      Exit;
    end;

    with FZipMaster do
    try

      // go to iMaxPos - iMax and read a complete buffer
      if (FileSeek(iInFile, iMaxPos-iMax, FILE_BEGIN) = -1) or (FileRead(iInFile, pData^, iMax) <> iMax)
      then  Result := SE_OpenReadError
      else
      begin
        Result := 0; // ok, also if no header found (could be winzip sfx or something like this)
        // ok, block read, now try to find MPV/MPU
        for i := 0 to iMax - 3 do
        begin
          if (pData[i] = 'M') and (pData[i + 1] = 'P') and ((pData[i + 2] = 'U') or (pData[i + 2] = 'V')) then
          begin
            // read back the original values from the MPU block.
            SFXOptions := [];
            SFXOverWriteMode := OvrConfirm;
            bFlags := Byte( pData[i + 3] );
            if (bFlags and  1) > 0 then SFXOptions := SFXOptions + [SFXAskCmdLine];
            if (bFlags and  2) > 0 then SFXOptions := SFXOptions + [SFXAskFiles];
            if (bFlags and  4) > 0 then SFXOptions := SFXOptions + [SFXHideOverWriteBox];
            if (bFlags and  8) > 0 then SFXOverWriteMode := OvrAlways;
            if (bFlags and 16) > 0 then SFXOverWriteMode := OvrNever;
            if not (bFlags and 32 > 0) then SFXOptions := SFXOptions + [SFXCheckSize];
            if (bFlags and 64) > 0 then SFXOptions := SFXOptions + [SFXAutoRun];

            if pData[i + 2] = 'U' then
            begin
              SetString( sTemp, pData + i + 7, Integer( pData[i + 4] ) );
              SFXCaption := sTemp;
              SetString( sTemp, pData + i + Integer( pData[i + 4] ) + 7, Integer( pData[i + 5] ) );
              SFXDefaultDir := sTemp;
              SetString( sTemp, pData + i + Integer( pData[i + 4] ) + Integer( pData[i + 5] ) + 7, Integer( pData[i + 6] ) );
              SFXCommandLine := sTemp;
            end
            else
            begin
              if (bFlags and 128) > 0 then SFXOptions := SFXOptions + [SFXNoSuccessMsg];
              pLoop := pData + i + 8;
              SetString( sTemp, pLoop + 1, Integer( pLoop[0] ) );
              SFXCaption := sTemp;
              pLoop := pLoop + Integer( pLoop[0] ) + 1;
              SetString( sTemp, pLoop + 1, Integer( pLoop[0] ) );
              SFXDefaultDir := sTemp;
              pLoop := pLoop + Integer( pLoop[0] ) + 1;
              SetString( sTemp, pLoop + 1, Integer( pLoop[0] ) );
              SFXCommandLine := sTemp;
              pLoop := pLoop + Integer( pLoop[0] ) + 1;
              SetString( sTemp, pLoop + 1, Integer( pLoop[0] ) );
              SFXMessage := sTemp;
            end;
            Break;
          end;
        end;
      end;
    finally
      FreeMem(pData);
    end;
  end;
end;

function TZipMasterSFX.ReadNewSFXProperties(const iInFile,
  iMaxPos: integer): Integer;
var
  recEnd: TSFXFileEndOfHeader;
  recSFX: TSFXFileHeader;
  sRead: string;
begin
  CheckZipMaster;

  Result := SE_GeneralError;
  if (FileSeek(iInFile, iMaxPos- sizeof(recEnd), FILE_BEGIN) = -1) or
    (FileRead(iInFile, recEnd, sizeof(recEnd)) <> sizeof(recEnd)) or
    (recEnd.Signature <> SFX_HEADER_END_SIG) or
    (FileSeek(iInFile, 0-sizeof(recEnd)-recEnd.HeaderSize, FILE_CURRENT) = -1) or
    (FileRead(iInFile, recSFX, sizeof(recSFX)) <> sizeof(recSFX)) or
    (recSFX.Size <> recEnd.HeaderSize) or
    (recSFX.Signature <> SFX_HEADER_SIG)
  then exit;

  // new sfx header found, now parse it
  with recSFX, FZipMaster do
  begin

    case DefOVW of
      somOverwrite: SFXOverwriteMode := OvrAlways;
      somSkip: SFXOverwriteMode := OvrNever;
    else
      SFXOverwriteMode := OvrConfirm;
    end;

    SFXOptions := [SFXCheckSize]; // compatibility
    if soAskCmdLine in Options then
      SFXOptions := SFXOptions + [SFXAskCmdLine];
    if soAskFiles in Options then
      SFXOptions := SFXOptions + [SFXAskFiles];
    if soAutoRun in Options then
      SFXOptions := SFXOptions + [SFXAutoRun];
    if soHideOverWriteBox in Options then
      SFXOptions := SFXOptions + [SFXHideOverWriteBox];
    if soNoSuccessMsg in Options then
      SFXOptions := SFXOptions + [SFXNoSuccessMsg];

    Result := SE_OpenReadError;

    if CaptionSize > 0 then
    begin
      SetLength(sRead, CaptionSize);
      if FileRead(iInFile, sRead[1], CaptionSize) <> CaptionSize
      then
        Exit;
      SFXCaption := sRead;
    end
    else
      SFXCaption := '';

    if PathSize > 0 then
    begin
      SetLength(sRead, PathSize);
      if FileRead(iInFile, sRead[1], PathSize) <> PathSize
      then
        Exit;
      SFXDefaultDir := sRead;
    end
    else
      SFXDefaultDir := '';

    if CmdLineSize > 0 then
    begin
      SetLength(sRead, CmdLineSize);
      if FileRead(iInFile, sRead[1], CmdLineSize) <> CmdLineSize
      then
        Exit;
      SFXCommandLine := sRead;
    end
    else
      SFXCommandLine := '';

    if RegFailPathSize > 0 then
    begin
      SetLength(sRead, CmdLineSize);
      if FileRead(iInFile, sRead[1], RegFailPathSize) <> RegFailPathSize
      then
        Exit;
    end;

    if StartMsgSize > 0 then
    begin
      SetLength(sRead, StartMsgSize);
      if FileRead(iInFile, sRead[1], StartMsgSize) <> StartMsgSize
      then
        Exit;
      SFXMessage := sRead;
    end
    else
      SFXMessage := '';

    case StartMsgType of
      MB_OKCANCEL or MB_ICONINFORMATION: SFXMessage := #1+SFXMessage;
      MB_YESNO or MB_ICONQUESTION : SFXMessage := #2+SFXMessage;
    end;

    Result := 0;
  end;
end;

function TZipMasterSFX.ReadSFXIcon(sFile: string): integer;
var
  hIco: HICON;
begin
  CheckZipMaster;

  // read the 'custom' icon back from the executable.
  Result := 0;
  hIco := ExtractIcon( HInstance, pChar( sFile ), 0 );
  if (hIco <> 0) and (hIco <> INVALID_HANDLE_VALUE)
  then
    with FZipMaster do
    begin
      if SFXIcon.Handle <> 0 then
        SFXIcon.ReleaseHandle();
      SFXIcon.Handle := hIco;
    end;
end;

function TZipMasterSFX.GetVersion: string;
begin
  Result := SFX_RELEASE;
end;

procedure TZipMasterSFX.SetVersion(const Value: string);
begin
  //
end;

end.
