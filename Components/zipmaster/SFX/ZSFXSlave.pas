(* TZipSFXSlave (C) 2002<br><br>

   written by markus stephany, http://delphizip.mirkes.de, mailto:merkes@@mirkes.de<br><br>

   modified by Russell Peters for use with ZipMaster 1.72

   last changed: 09/06/2002<br><br>

   this component is part of the Delphi Zip VCL by Chris Vleghert and Eric W. Engler
   www: http://www.geocities.com/SiliconValley/Network/2114/zipbeta.html<br><br>

   this component is some kind of "snap-in" for TZipMaster to support the new sfx.<br><br>

*)

Unit ZSFXSlave;

Interface

Uses
    ZipMstr, ZipMsg, SFXInterface, Windows, Messages, SysUtils,
    Classes, Controls, Graphics, Forms, SFXStructs;

Const
    SFXVERSION: integer = 171;          // not yet 172
Type
    TZipSFXSlave = Class(TZipSFXBase)
    PRIVATE
        FMySFXMessage: String;
        FMySFXOptions: TSFXOptions;
        FMySFXOverwriteMode: TSFXOverwriteMode;
        FMySFXMessageFlags: cardinal;
        FZipMaster: TZipMaster;
        FSFXPath: TFileName;
        Procedure CheckZipMaster;
        Procedure SetVersion(Const Value: String);
        Function GetVersion: String;
        Function GetSFXPath: TFileName; // RP default get ZipMaster
        //        Function GetZipMaster: TZipMaster;
        Function _IsZipSFX(Const SFXExeName: String): Integer;
        Function _ConvertToZip: integer;
        Function IsInstallShield(Const fh: THandle): Boolean;
    PROTECTED
        //		Property ZipMaster: TZipMaster READ GetZipMaster;
                //@exclude()
        Procedure Notification(aComponent: TComponent; Operation: TOperation); OVERRIDE;
        //@exclude()
        Procedure GetPropertiesFromZipMaster; VIRTUAL;
        //@exclude()
        Function DoConvertOrCreateSFX(Const sFile: String;
            Const bCreateNew: boolean): integer;
        //@exclude()
        Function ReadSFXProperties(Const iInFile, iMaxPos: integer): Integer;
        //@exclude()
        Function ReadNewSFXProperties(Const iInFile, iMaxPos: integer): Integer;
        //@exclude()
        Function ReadSFXIcon(sFile: String): integer;
        (* Converts the ZIP archive (according to the sfx related options of the ZipMaster component)  to a SFX archive
           and updates the ZipMaster component to use the newly created file.
  *)
        Function ConvertToSFX(caller: TZipMaster): integer; OVERRIDE;
        (* Converts the SFX archive (in the ZipMaster property's ZipFileName) to a ZIP archive and updates the
                 ZipMaster component to use the newly created file.
        *)
        Function ConvertToZip(caller: TZipMaster): integer; OVERRIDE;
        (* Creates a new, empty SFX archive (according to the sfx related options of the ZipMaster component) and
           updates the ZipMaster component to use this newly created file.
        *)
        Function CreateNewSFX(caller: TZipMaster; Const sFile: String): integer; OVERRIDE;
        (* test if file is SFX
        *)
        Function IsZipSFX(caller: TZipMaster; Const SFXExeName: String): Integer; OVERRIDE;
    PUBLIC
        // @exclude()
        Constructor Create(aOwner: TComponent); OVERRIDE;
        (* return version string
        *)
        Function VersionString: String; OVERRIDE;
        (* return default name of binary file
        *)
        Function BinaryName: String; OVERRIDE;
    PUBLISHED
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
//        Property SFXPath: TFileName READ FSFXPath WRITE FSFXPath;
        (* Set this to a TZipMaster component on your form, the TZipSFXSlave will use its properties and also its
           event handlers (to display messages and so on).
     *)
//        Property ZipMaster;             //: TZipMaster read ZipLink write ZipLink;

        // Shows the release/version of the TZipSFXSlave component.
        Property Version: String READ GetVersion WRITE SetVersion;
    End;
    (*
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
*)
//@exclude()
Procedure Register;

{$IFNDEF PASDOC}
{$I SFXVER.INC}
{$ENDIF}

Implementation
Uses
    ShellAPI{$IFDEF ZM170UP}, ZipStructs{$ENDIF};

{$I LANG2.INC}

Const
    SE_CreateError = -1;
    SE_CopyError = -2;
    SE_OpenReadError = -3;
    SE_SetDateError = -4;
    SE_GeneralError = -9;
    SE_NoFoundError = -10;
    SE_OutOfMemError = -10;             // duplicate id! in zipmstr
    SE_MemStreamError = -11;
    SE_IconSizeError = -12;
    SE_NoSpanningSupport = -101;
    SE_ErrorInCentral = -102;
    {
Type
TZipMasterFriend = class(TZipMaster)
end;}

// copy a buffer from a file to another, returns 0 on ok
// iReadLen: amount of data to copy, if -1, then up to eof
//@exclude()
Function CopyBuffer(Const iInFile, iOutFile: integer; iReadLen: integer): integer; FORWARD;

// replace an icon in the given file
//@exclude()
Function ReplaceIcon(Const iExeFile, iMaxPos: integer; oIcon: TIcon): integer; FORWARD;

// read end of central record from iInFile and return its position
//@exclude()
Function ReadEOC(Const iInFile: integer; Var recEOC: ZipEndOfCentral): integer; FORWARD;

// copy and adjust central dirs and end of central dir
//@exclude()
Function CopyAndAdjustCentralDir(Const iInFile, iOutFile, iNumEntries, iDiskToAdjust,
    iOffset: integer): integer; FORWARD;

// return the position of the first local file header in the file
// -1 on error, else not the absolute file position is read but the value from the central directory
//@exclude()
Function GetFirstLocalHeader(Const iInFile, iNumEntries, iWhichDisk, iPosition: integer): integer; FORWARD;

Procedure Register;
Begin
    RegisterComponents('Delphi Zip', [TZipSFXSlave]);
End;

// copy a buffer from a file to another, returns 0 on ok
// iReadLen: amount of data to copy, if -1, then up to eof

Function CopyBuffer(Const iInFile, iOutFile: integer; iReadLen: integer): integer;
Var
    recBuffer: TSFXBuffer;
    iRead, iToRead: integer;
Begin
    Result := 0;
    iToRead := SFXBufSize;
    Try
        Repeat
            If iReadLen >= 0 Then
            Begin
                iToRead := iReadLen;
                If SFXBufSize < iReadLen Then iToRead := SFXBufSize;
            End;

            iRead := FileRead(iInFile, recBuffer, iToRead);
            If FileWrite(iOutFile, recBuffer, iRead) <> iRead Then
            Begin
                Result := SE_CopyError;
                break;
            End;

            If iReadLen > 0 Then dec(iReadLen, iRead);

            Application.ProcessMessages; // needed for winsock ?
        Until ((iReadLen = 0) Or (iRead <> iToRead));
    Except
        Result := SE_CopyError;
    End;
End;

// replace an icon in the given file

Function ReplaceIcon(Const iExeFile, iMaxPos: integer; oIcon: TIcon): integer;

    Function BrowseResDir(Const pResStart: pIRD; Const pDir: pIRD; iDepth: integer): cardinal;
        FORWARD;

    // search for the right(with our icon) resource directory entry.

    Function SearchResDirEntry(Const pResStart: pIRD; Const pEntry: pIRDirE;
        iDepth: integer): cardinal;
    Var
        pData: pIRDatE;
    Begin
        Result := 0;
        With pEntry^ Do
        Begin
            If (un1.NameIsString And $80000000) <> 0 Then Exit; // No named resources.
            If (iDepth = 0) And (un1.Id <> 3) Then Exit; // Only icon resources.
            If (iDepth = 1) And (un1.Id <> 1) Then Exit; // Only icon with ID 0x1.
            If (un2.DataIsDirectory And $80000000) = 0 Then
            Begin
                pData := pIRDatE(PChar(pResStart) + un2.OffsetToData);
                With pData^ Do
                    If Size = 744 Then Result := OffsetToData;
            End
            Else
                Result := BrowseResDir(pResStart, pIRD(PChar(pResStart) +
                    (un2.OffsetToDirectory And $7FFFFFFF)), iDepth + 1)
        End;
    End;

    // browse through all resource directories.

    Function BrowseResDir(Const pResStart: pIRD; Const pDir: pIRD;
        iDepth: integer): cardinal;
    Var
        pSingleRes: pIRDirE;
        i: integer;
    Begin
        Result := 0;
        pSingleRes := pIRDirE(PChar(pDir) + SizeOf(IMAGE_RESOURCE_DIRECTORY));
        With pDir^ Do
            For i := 0 To Pred(NumberOfNamedEntries + NumberOfIdEntries) Do
            Begin
                Result := SearchResDirEntry(pResStart, pSingleRes, iDepth);
                If Result <> 0 Then Break; // Found the one w're looking for.
                Inc(pSingleRes, 1);
            End;
    End;

    // find resource directory entry.

    Function LookForDirs(Const pSectionData: Pointer; Const cSectionVirtualStart: cardinal;
        Const iSectionLen: integer; Const pDirectories: pIDD): cardinal;
    Var
        pResStart: Pointer;
        pDirs: pIDD;
    Begin
        Result := 0;
        pDirs := pDirectories;
        Inc(pDirs, IMAGE_DIRECTORY_ENTRY_RESOURCE);
        With pDirs^ Do
        Begin
            If (VirtualAddress <> 0) And (PChar(VirtualAddress) >= PChar(cSectionVirtualStart))
                And
                (PChar(VirtualAddress) < (PChar(cSectionVirtualStart) + iSectionLen)) Then
            Begin
                pResStart := PChar(pSectionData) + (VirtualAddress - cSectionVirtualStart);
                Result := BrowseResDir(pResStart, pResStart, 0);
            End;
        End;
    End;

Var
    pEXE: PChar;                        // buffer that holds the executable
    strIco: TMemoryStream;              // icon stream

    // pe structures
    iSection: integer;                  // current section
    cFoundAddr: cardinal;
    pSectionHeader: pISH;               // section header
Begin
    Result := SE_NoFoundError;
    cFoundAddr := 0;

    GetMem(pEXE, iMaxPos + 1);
    strIco := TMemoryStream.Create;
    Try
        Try

            // read in the sfx
            FileSeek(iExeFile, 0, FILE_BEGIN);
            FileRead(iExeFile, pEXE^, iMaxPos);

            // search for dos/pe
            With IMAGE_DOS_HEADER(Pointer(pEXE)^) Do
            Begin
                If e_magic <> IMAGE_DOS_SIGNATURE Then exit; // not a dos exe
                With PEheader(Pointer(pEXE + _lfanew)^) Do
                Begin
                    If signature <> IMAGE_NT_SIGNATURE Then exit; // not a pe executable
                    If _head.NumberOfSections = 0 Then exit; // no sections ???

                    // get 1st section header pos
                    pSectionHeader := @section_header;

                    // iterate over all sections
                    For iSection := 0 To Pred(_head.NumberOfSections) Do
                    Begin
                        // search for resource section
                        If StrComp(@(pSectionHeader^.Name), '.rsrc') = 0 Then
                        Begin
                            // resource section found
                            With pSectionHeader^ Do
                            Begin
                                // search for icon resource
                                cFoundAddr := LookForDirs(pEXE + PointerToRawData, VirtualAddress,
                                    SizeOfRawData, @opt_head.DataDirectory);
                                If cFoundAddr = 0 Then exit; // no matching resource found

                                // change memory offset to file offset.
                                cFoundAddr := cFoundAddr - VirtualAddress + PointerToRawData;
                                Break;
                            End;
                        End;
                        Inc(pSectionHeader, 1);
                    End;
                End;
            End;

            With strIco Do
            Begin
                oIcon.SaveToStream(strIco);
                // Only handle icons with this size.
                If Size = 766 Then
                Begin
                    // Reposition to the actual data and put it into a buffer.
                    Seek(22, soFromBeginning);
                    ReadBuffer(pEXE^, 744);
                    // Go to start of the icon resource in the new created file.
                    FileSeek(iEXEFile, cFoundAddr, FILE_BEGIN);
                    // And write the changed icon data from the buffer.
                    FileWrite(iEXEFile, pExe^, 744);
                    FileSeek(iExeFile, 0, FILE_END);
                    Result := 0;
                End
                Else
                    Result := SE_IconSizeError;
            End;

        Except
            Result := SE_MemStreamError;
        End;
    Finally
        strIco.Free;
        FreeMem(pEXE);
    End;
End;

// read end of central record from iInFile and return its position

Function ReadEOC(Const iInFile: integer; Var recEOC: ZipEndOfCentral): integer;
Var
    pRec: ^ZipEndOfCentral;
    iBufferSize, iRead: integer;
    pBuffer: PChar;
    i: integer;
    bOK: boolean;
    iFileSize: integer;
Begin
    bOK := False;
    iFileSize := FileSeek(iInFile, 0, FILE_END);
    iBufferSize := iFileSize;
    If iBufferSize > (sizeof(ZipEndOfCentral) + 65536) Then
        iBufferSize := (sizeof(ZipEndOfCentral) + 65536);

    // first try to read the record straight from the end ( works if no comment is stored)
    Result := FileSeek(iInFile, -sizeof(ZipEndOfCentral), FILE_CURRENT);
    If Result <> -1 Then
    Begin
        FileRead(iInFile, recEOC, sizeof(ZipEndOfCentral));
        If recEOC.HeaderSig <> EndCentralDirSig Then
        Begin
            // not found at the end, read in a buffer
            If iBufferSize > sizeof(ZipEndOfCentral) Then
            Begin
                Result := FileSeek(iInFile, -iBufferSize, FILE_END);
                If Result <> -1 Then
                Begin
                    GetMem(pBuffer, iBufferSize + 1);
                    Try
                        iRead := FileRead(iInFile, pBuffer^, iBufferSize);
                        If iRead = iBufferSize Then
                        Begin
                            // now search from start
                            For i := 0 To iBufferSize - sizeof(ZipEndOfCentral) Do
                            Begin
                                pRec := Pointer(integer(pBuffer) + i);
                                With pRec^ Do
                                    If HeaderSig = EndCentralDirSig Then
                                    Begin
                                        If (ZipCommentLen + Result + i +
                                            sizeof(ZipEndOfCentral)) <= iFileSize Then // changed because of trash at end of winzip sfx'es
                                        Begin
                                            bOK := True; // set ok flag
                                            Result := Result + i;
                                            Move(pRec^, recEOC, sizeof(ZipEndOfCentral));
                                            Break;
                                        End;
                                    End;
                            End;
                        End
                    Finally
                        FreeMem(pBuffer);
                    End;
                End;
            End;
        End
        Else
            bOK := True;
    End;

    If Not bOK Then
        Result := -1;
End;

// copy and adjust central dirs and end of central dir

Function CopyAndAdjustCentralDir(Const iInFile, iOutFile, iNumEntries, iDiskToAdjust,
    iOffset: integer): integer;
Var
    iCur: integer;
    recCentral: ZipCentralHeader;
    recEOC: ZipEndOfCentral;
    pData: Pointer;
Begin
    Result := SE_ErrorInCentral;
    GetMem(pData, 65536 * 3);           // filename + extrafield + filecomment
    Try
        If iNumEntries > 0 Then
        Begin
            // write all central directory entries
            For iCur := 0 To Pred(iNumEntries) Do
            Begin
                If (FileRead(iInFile, recCentral, sizeof(ZipCentralHeader)) <>
                    sizeof(ZipCentralHeader)) Or
                    (recCentral.HeaderSig <> CentralFileHeaderSig) Then
                    exit;               // invalid record

                If recCentral.DiskStart = iDiskToAdjust Then
                    Inc(recCentral.RelOffLocal, iOffset); // adjust offset

                If FileWrite(iOutFile, recCentral, sizeof(ZipCentralHeader)) <>
                    sizeof(ZipCentralHeader) Then
                Begin
                    Result := SE_CopyError;
                    exit;
                End;

                // read and write extra data
                With recCentral Do
                Begin
                    If (FileNameLen + ExtraLen + FileComLen) > 0 Then
                    Begin
                        If FileRead(iInFile, pData^, FileNameLen + ExtraLen + FileComLen)
                            <> (FileNameLen + ExtraLen + FileComLen) Then
                            exit;
                        If FileWrite(iOutFile, pData^, FileNameLen + ExtraLen + FileComLen) <>
                            (FileNameLen + ExtraLen + FileComLen) Then
                        Begin
                            Result := SE_CopyError;
                            exit;
                        End;
                    End;
                End;
            End;
        End;

        // read, adjust and write end of central
        If (FileRead(iInFile, recEOC, sizeof(ZipEndOfCentral)) <> sizeof(ZipEndOfCentral)) Or
            (recEOC.HeaderSig <> EndCentralDirSig) Then
            exit;
        Inc(recEOC.CentralOffSet, iOffset);
        If FileWrite(iOutFile, recEOC, sizeof(ZipEndOfCentral)) <> sizeof(ZipEndOfCentral) Then
        Begin
            Result := SE_CopyError;
            exit;
        End;

        // read an eventually existing file comment
        With recEOC Do
            If ZipCommentLen > 0 Then
            Begin
                If FileRead(iInFile, pData^, ZipCommentLen) <> ZipCommentLen Then
                    exit;
                If FileWrite(iOutFile, pData^, ZipCommentLen) <> ZipCommentLen Then
                Begin
                    Result := SE_CopyError;
                    exit;
                End;

                Result := 0;
            End
            Else
                Result := 0;

    Finally
        FreeMem(pData);
    End;
End;

// return the position of the first local file header in the file
// -1 on error, else not the absolute file position is read but the value from the central directory

Function GetFirstLocalHeader(Const iInFile, iNumEntries, iWhichDisk, iPosition: integer): integer;
Var
    recCentral: ZipCentralHeader;
    iCur: Integer;                      // loop
Begin
    Result := SE_ErrorInCentral;
    If (iNumEntries < 1) Or (FileSeek(iInFile, iPosition, FILE_BEGIN) <> iPosition) Then
        exit
    Else
        For iCur := 0 To Pred(iNumEntries) Do
        Begin
            // read central dir
            If (FileRead(iInFile, recCentral, sizeof(ZipCentralHeader)) <> sizeof(ZipCentralHeader)) Or
                (recCentral.HeaderSig <> CentralFileHeaderSig) Then
            Begin
                Result := SE_ErrorInCentral;
                exit;                   // invalid record
            End;

            // first ?
            If ((Result < 0) Or (integer(recCentral.RelOffLocal) < Result)) And (recCentral.DiskStart = iWhichDisk) Then
                Result := recCentral.RelOffLocal; // store

            // read over extra data
            With recCentral Do
                If (FileNameLen + ExtraLen + FileComLen) > 0 Then
                    FileSeek(iInFile, FileNameLen + ExtraLen + FileComLen, FILE_CURRENT);
        End;
End;

{ TZipSFXSlave }

Constructor TZipSFXSlave.Create(aOwner: TComponent);
Begin
    Inherited;
    FZipMaster := Nil;
    FVer := SFXVERSION;
    FSFXPath := '';                     //RP 'DZSFX'+DZSFX_LANG+'.BIN';  // set at compile time when using make -DLANG=<lg> vcl
End;

Function TZipSFXSlave.IsZipSFX(caller: TZipMaster; Const SFXExeName: String): Integer;
Begin
    If Not assigned(FZipMaster) Then
    Try
        FZipMaster := caller;
        Result := _IsZipSFX(SFXExeName);
    Finally
        FZipMaster := Nil;
    End
    Else
        Result := BUSY_ERROR;           // busy
End;

// RP adapted from TZipMaster.IsZipSFX

Function TZipSFXSlave._IsZipSFX(Const SFXExeName: String): Integer;
Var
    EOC: ZipEndOfCentral;
    n, Size, BufPos: LongWord;
    CentralSig: LongWord;
    ZipBuf: pChar;
    br: DWord;
    fh: THandle;
    i: Char;
    crSave: TCursor;                    // save cursor
    FJumpValue: Array[#0..#255] Of Integer;
    FFileSize: cardinal;
Begin
    // zipmaster must exist
    CheckZipMaster;

    Result := 0;
    BufPos := 0;
    fh := 0;
    ZipBuf := Nil;

    With FZipMaster Do
    Begin
        crSave := Screen.Cursor;
        Screen.Cursor := crHourGlass;

        If FJumpValue[#0] = 0 Then
        Begin
            For i := #0 To #255 Do
                FJumpValue[i] := 4;
            FJumpValue['P'] := 3;
            FJumpValue['K'] := 2;
            FJumpValue[#5] := 1;
            FJumpValue[#6] := 0;
        End;
        Try
            // Open the input archive, presumably the last disk.
            fh := CreateFile(pChar(SFXExeName), GENERIC_READ, FILE_SHARE_READ, Nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
            If fh = INVALID_HANDLE_VALUE Then
                Raise EZipMaster.CreateResDisp(DS_NoInFile, True);

            Repeat
                If IsInstallShield(fh) Then
                    Break;

                // A test for a zip archive without a ZipComment.
                FFileSize := Integer(SetFilePointer(fh, -SizeOf(EOC), Nil, FILE_END));
                If DWord(FFileSize) <> $FFFFFFFF Then
                Begin
                    Inc(FFileSize, SizeOf(EOC)); // Save the archive size as a side effect.
                    ReadFile(fh, EOC, sizeof(EOC), br, Nil);
                    If (br = SizeOf(EOC)) And (EOC.HeaderSig = EndCentralDirSig) Then
                    Begin
                        Result := 1;
                        Break;
                    End;
                End;
                If FFileSize < {LongInt}(65535 + SizeOf(EOC)) Then
                    Size := FFileSize
                Else
                    Size := LongInt(65535 + SizeOf(EOC));
                GetMem(ZipBuf, Size + 1);
                If SetFilePointer(fh, (0 - Size), Nil, FILE_END) = $FFFFFFFF Then
                    Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
                ReadFile(fh, ZipBuf^, Size, br, Nil);
                If br <> Size Then
                    Raise EZipMaster.CreateResDisp(DS_EOCBadRead, True);

                // Finally try to find the EOC record within the last 65K...
                While BufPos < Size Do
                Begin
                    n := FJumpValue[(ZipBuf + BufPos)^];
                    If n = 0 Then       // a '6' found at least...
                    Begin
                        If ((ZipBuf + BufPos - 3)^ = 'P') And ((ZipBuf + BufPos - 2)^ = 'K') And ((ZipBuf + BufPos - 1)^ = #5) And (BufPos + SizeOf(EOC) - 4 < Size) Then
                        Begin
                            Move((ZipBuf + BufPos - 3)^, EOC, SizeOf(EOC));
                            If (SetFilePointer(fh, EOC.CentralOffset, Nil, FILE_BEGIN) <> $FFFFFFFF) And
                                (ReadFile(fh, CentralSig, 4, br, Nil)) And (CentralSig = CentralFileHeaderSig) Then
                            Begin
                                Result := 1;
                                Break;
                            End
                            Else
                                Inc(BufPos, 4);
                        End
                        Else
                            Inc(BufPos, 4);
                    End
                    Else
                        Inc(BufPos, n);
                End;
                Break;
            Until False;
        Except
            On ers: EZipMaster Do       // All IsZipSFX specific errors.
            Begin
                FZipMaster.ShowExceptionError(ers);
                Result := -7;
            End;
            On EOutOfMemory Do          // All memory allocation errors.
            Begin
                FZipMaster.ShowZipMessage(GE_NoMem, '');
                Result := -8;
            End;
            On E: Exception Do
            Begin
                ShowZipMessage(DS_ErrorUnknown, E.Message);
                Result := -9;
            End;
        Else                            // The remaining errors, should not occur.
            ShowZipMessage(DS_ErrorUnknown, '');
            Result := -10;
        End;
    End;

    FreeMem(ZipBuf);
    CloseHandle(fh);
    Screen.Cursor := crSave;
End;

// RP adapted from TZipMaster.IsInstallShield

Function TZipSFXSlave.IsInstallShield(Const fh: THandle): Boolean;
Var
    buf: pChar;
    br, i: DWORD;
Begin
    Result := False;
    buf := Nil;

    Try
        GetMem(buf, 2049);
        ReadFile(fh, buf^, 2048, br, Nil);

        // Make zero terminated string by eliminating zeros
        // and setting last byte to zero
        For i := 0 To br - 1 Do
            If (buf + i)^ = #0 Then
                (buf + i)^ := ' ';
        (buf + br)^ := #0;
        If AnsiStrPos(buf, 'InstallShield Self-Extracting Stub program') <> Nil Then
            Result := True
    Except
    End;
    FreeMem(buf);
End;

Function TZipSFXSlave.VersionString: String;
Begin
    Result := Version + ' 1.72.0.0';
End;

Function TZipSFXSlave.BinaryName: String;
Begin
    Result := 'DZSFX' + DZSFX_LANG + '.BIN';
End;

// default get ZipMaster.SFXPath

Function TZipSFXSlave.GetSFXPath: TFileName;
Begin
    Result := FSFXPath;
    If Result = '' Then
    Begin
        Result := FZipMaster.SFXPath;
        If Uppercase(ExtractFileName(Result)) = 'ZIPSFX.BIN' Then
            Result := PathConcat(ExtractFilePath(Result), BinaryName);
    End;

End;

Function TZipSFXSlave.DoConvertOrCreateSFX(Const sFile: String;
    Const bCreateNew: boolean): integer;
Var
    sOutFile: String;                   // output filename
    iOutFile: integer;                  // handle to output file
    szSearchPath: Array[0..MAX_PATH] Of char; // buffer for searchpath
    p: PChar;                           // buffer for searchpath (temp) and TSFXHeader
    recEnd: TSFXFileEndOfHeader;        // stored to quickly find an TSFXFileHeader
    sErrMsg: String;                    // error if strings are too long (> 255 chars)
    iHeaderSize: integer;               // overall size of the header + strings
    crSave: TCursor;                    // save cursor
    i: integer;                         // position counter for string storing
    iInFile: integer;                   // input file handle
    iSizeOfSFX: integer;                // size of the sfx exe part
    iSizeOfOut: integer;                // overall resulting file size
    iSizeOfZip: integer;                // size of the zip file
    iPosOfEOC: integer;                 // position of the end of central record in the zip file
    iDelta: integer;                    // eventually wrong central dir offsets
    recEOC: ZipEndOfCentral;            // eoc record in zip
    s: String;
Begin
    p := Nil;
    // get sfx options from zipmaster
    GetPropertiesFromZipMaster;

    // assume error
    Result := SE_GeneralError;
    iSizeOfSFX := -1;
    iSizeOfOut := -1;
    iSizeOfZip := -1;

    With FZipMaster Do
    Begin
        // convert a zip to an sfx
        If Not bCreateNew Then
        Begin
            // file must exist
            If Not FileExists(sFile) Then
            Begin
                ShowZipMessage(GE_NoZipSpecified, '');
                exit;
            End;

            // file must be a zip
            If UpperCase(ExtractFileExt(sFile)) <> '.ZIP' Then
            Begin
                ShowZipMessage(SF_InputIsNoZip, '');
                exit;
            End;

            // rename to exe
            sOutFile := ChangeFileExt(sFile, '.exe');
        End
        Else
            sOutFile := sFile;

        // try to find FSFXPath
        s := GetSFXPath;
        //	if not FileExists({RP}GetSFXPath) then
        If Not FileExists(s) Then
        Begin
            SetString(FSFXPath, szSearchPath, SearchPath(Nil,
                PChar(BinaryName), Nil, sizeof(szSearchPath), szSearchPath, p));
            //	  if not FileExists(FSFXPath) then
            s := GetSFXPath;
            If Not FileExists(s) Then
            Begin
                //        FSFXPath := DLLDirectory + '\DZSFX'+DZSFX_LANG+'.BIN';
                FSFXPath := PathConcat(DLLDirectory, BinaryName);
                If Not FileExists(FSFXPath) Then
                Begin
                    FSFXPath := PathConcat(ExtractFilePath(Application.ExeName), FSFXPath);
                End;
                If Not FileExists(FSFXPath) Then
                Begin
                    ShowZipMessage(SF_NoZipSFXBin, '');
                    exit;
                End;
            End;
        End;

        // check string lengths
        sErrMsg := '';
        If Length(SFXCaption) > 255 Then sErrMsg := 'SFXCaption';

        If Length(SFXCommandLine) > 255 Then
        Begin
            If sErrMsg <> '' Then sErrMsg := sErrMsg + ', ';
            sErrMsg := sErrMsg + 'SFXCommandLine';
        End;

        If Length(SFXDefaultDir) > 255 Then
        Begin
            If sErrMsg <> '' Then sErrMsg := sErrMsg + ', ';
            sErrMsg := sErrMsg + 'SFXDefaultDir';
        End;

        If Length(FMySFXMessage) > 255 Then
        Begin
            If sErrMsg <> '' Then
                sErrMsg :=
                    sErrMsg + ', ';
            sErrMsg := sErrMsg + 'SFXMessage';
        End;

        // string too long, show error and exit
        If sErrMsg <> '' Then
        Begin
            ShowZipMessage(SF_StringToLong, #13#10 + sErrMsg);
            exit;
        End;

        // calculate overall header size
        iHeaderSize := sizeof(TSFXFileHeader) + Length(SFXCaption) +
            Length(SFXCommandLine) + Length(SFXDefaultDir) + Length(FMySFXMessage);
        // make dword aligned
        iHeaderSize := ((iHeaderSize + 3) Div 4) * 4;

        Try
            GetMem(p, iHeaderSize + 1);
        Except
            ShowZipMessage(GE_NoMem, '');
            exit;
        End;

        // save curosor and show wait
        crSave := Screen.Cursor;
        Screen.Cursor := crHourGlass;

        Try
            // create header
            With PSFXFileHeader(p)^ Do
            Begin
                Signature := SFX_HEADER_SIG;
                Size := iHeaderSize;
                Options := FMySFXOptions;
                DefOVW := FMySFXOverwriteMode;
                CaptionSize := Length(SFXCaption);
                PathSize := Length(SFXDefaultDir);
                CmdlineSize := Length(SFXCommandLine);
                RegFailPathSize := 0;
                // not implemented in zipmaster, use TZipSFX rather than TZipSFXSlave
                StartMsgSize := Length(FMySFXMessage);
                StartMsgType := FMySFXMessageFlags;
            End;

            // set end of fileheader
            recEnd.Signature := SFX_HEADER_END_SIG;
            recEnd.HeaderSize := iHeaderSize;

            // store strings
            i := sizeof(TSFXFileHeader);
            If SFXCaption <> '' Then
            Begin
                StrPCopy(p + i, SFXCaption);
                i := i + Length(SFXCaption);
            End;

            If SFXDefaultDir <> '' Then
            Begin
                StrPCopy(p + i, SFXDefaultDir);
                i := i + Length(SFXDefaultDir);
            End;

            If SFXCommandLine <> '' Then
            Begin
                StrPCopy(p + i, SFXCommandLine);
                i := i +
                    Length(SFXCommandLine);
            End;

            If FMySFXMessage <> '' Then
            Begin
                StrPCopy(p + i, FMySFXMessage);
                // i := i + Length(FMySFXMessage);
            End;

            // delete existing file
            If FileExists(sOutFile) Then
                EraseFile(sOutFile, HowToDelete);

            // start writing
            iOutFile := FileCreate(sOutFile);
            If iOutFile <> -1 Then
            Begin
                iInFile := FileOpen(FSFXPath, fmOpenRead Or fmShareDenyWrite);
                If iInFile = -1 Then
                    Result := SE_OpenReadError
                Else
                Begin
                    // copy sfx stub
                    Result := CopyBuffer(iInFile, iOutFile, -1);
                    iSizeOfSFX := FileSeek(iInFile, 0, FILE_END);
                    FileClose(iInFile);

                    // replace icon
                    If (Result = 0) And (Not SFXIcon.Empty) Then
                        Result := ReplaceIcon(iOutFile, iSizeOfSFX, SFXIcon);

                    If Result = 0 Then
                    Begin
                        // write TSFXFileHeader and end header
                        If (FileWrite(iOutFile, p^, iHeaderSize) <> iHeaderSize) Or
                            (FileWrite(iOutFile, recEnd, sizeof(recEnd)) <> sizeof(recEnd)) Then
                            Result := SE_CopyError
                        Else
                        Begin
                            // if conversion
                            If Not bCreateNew Then
                            Begin
                                iInFile := FileOpen(sFile, fmOpenRead Or fmShareDenyWrite);
                                If iInFile = -1 Then
                                    Result := SE_OpenReadError
                                Else
                                Begin
                                    // read end of central from zipfile
                                    iPosOfEOC := ReadEOC(iInFile, recEOC);
                                    If iPosOfEOC > 0 Then // ok, eoc found
                                    Begin
                                        // calculate delta (if wrong offsets are stored in zip-file)
                                        iDelta := iPosOfEOC - {?RP} integer(recEOC.CentralOffset + recEOC.CentralSize);

                                        // currently only nonspanned archives are supported
                                        If (recEOC.ThisDiskNo <> recEOC.CentralDiskNo) Or
                                            (recEOC.CentralEntries <> recEOC.TotalEntries) Then
                                            Result := SE_NoSpanningSupport
                                        Else
                                        Begin
                                            // write zip file
                                            iSizeOfZip := iPosOfEOC + sizeof(ZipEndOfCentral) +
                                                recEOC.ZipCommentLen;
                                            FileSeek(iInFile, 0, FILE_BEGIN);

                                            // copy local data
                                            Result := CopyBuffer(iInFile, iOutFile,
                                                {?RP} integer(recEOC.CentralOffset) + iDelta);

                                            // copy and adjust central dir
                                            If Result = 0 Then
                                                Result := CopyAndAdjustCentralDir(iInFile, iOutFile, recEOC.CentralEntries,
                                                    recEOC.ThisDiskNo, iDelta + iSizeOfSFX + iHeaderSize + sizeof(recEnd));

                                            iSizeOfOut := FileSeek(iOutFile, 0, FILE_END);
                                        End;
                                    End
                                    Else
                                        Result := SE_ErrorInCentral;
                                    FileClose(iInFile);
                                End;
                            End
                            Else
                            Begin
                                // create a new file

                                // fill in the eoc record
                                FillChar(recEOC, sizeof(ZipEndOfCentral), 0);
                                recEOC.HeaderSig := EndCentralDirSig;
                                recEOC.CentralOffset := iSizeOfSFX + iHeaderSize + sizeof(recEnd);

                                // and write it to the file
                                If FileWrite(iOutFile, recEOC, SizeOf(ZipEndOfCentral)) <>
                                    SizeOf(ZipEndOfCentral) Then
                                    Result := SE_CopyError
                                Else
                                Begin
                                    Result := 0;
                                    iSizeOfOut := FileSeek(iOutFile, 0, FILE_END);
                                    iSizeOfZip := 0;
                                End;
                            End;
                        End;
                    End;
                End;
                FileClose(iOutFile);
            End
            Else
                Result := SE_CreateError;

            // extra check
            If (Result = 0) And ((iSizeOfSFX = -1) Or (iSizeOfOut = -1) Or (iSizeOfZip = -1)) Then
                Result := SE_GeneralError;

            If (Result = 0) And (Not bCreateNew) Then
                EraseFile(sFile, HowToDelete);

            If Result <> 0 Then
            Begin
                If FileExists(sOutFile) Then
                    DeleteFile(sOutFile);
            End
            Else
                // update the associated TZipMaster component
                ZipFileName := sOutFile;

        Finally
            Screen.Cursor := crSave;
            Try
                FreeMem(p);
            Except
            End;
        End;
    End;
End;

Function TZipSFXSlave.ConvertToZip(caller: TZipMaster): integer;
Begin
    If Not assigned(FZipMaster) Then
    Try
        FZipMaster := caller;
        Result := _ConvertToZip;
    Finally
        FZipMaster := Nil;
    End
    Else
        Result := -255;                 // busy
End;

Function TZipSFXSlave._ConvertToZip: integer;
Var
    sOutFile: String;                   // output filename
    iOutFile: integer;                  // handle to output file
    crSave: TCursor;                    // save cursor
    iInFile: integer;                   // input file handle
    iSizeOfSFX: integer;                // size of the sfx exe part + MPV/MPU/TSFXHeader block
    iSizeOfOut: integer;                // overall size of the written file
    iSizeOfIn: integer;                 // overall size of the input file
    iPosOfEOC: integer;                 // position of the end of central record in the zip file
    iDelta: integer;                    // eventually wrong central dir offsets
    recEOC: ZipEndOfCentral;            // eoc record in zip
Begin
    // zipmaster must exist
    CheckZipMaster;

    // get sfx options from zipmaster
    GetPropertiesFromZipMaster;

    // assume error
    Result := SE_GeneralError;
    iSizeOfSFX := -1;
    iSizeOfIn := -1;
    iSizeOfOut := -1;

    With FZipMaster Do
    Begin

        // file must exist
        If Not FileExists(ZipFileName) Then
        Begin
            ShowZipMessage(CZ_NoExeSpecified, '');
            exit;
        End;

        // file must be a exe
        If UpperCase(ExtractFileExt(ZipFileName)) <> '.EXE' Then
        Begin
            ShowZipMessage(CZ_InputNotExe, '');
            exit;
        End;

        // rename to zip
        sOutFile := ChangeFileExt(ZipFileName, '.zip');

        crSave := Screen.Cursor;
        Screen.Cursor := crHourGlass;
        Try

            // open in file
            iInFile := FileOpen(ZipFileName, fmOpenRead Or fmShareDenyWrite);
            If iInFile = -1 Then
                Result := SE_OpenReadError
            Else
            Begin
                // read the eoc record
                iPosOfEOC := ReadEOC(iInFile, recEOC);
                If iPosOfEOC = 0 Then
                    Result := SE_ErrorInCentral
                Else
                Begin
                    // calculate delta (if wrong offsets are stored in zip-file)
                    iDelta := iPosOfEOC - {?RP} integer(recEOC.CentralOffset + recEOC.CentralSize);

                    // now find the first local file header
                    iSizeOfSFX := GetFirstLocalHeader(iInFile, recEOC.CentralEntries, recEOC.ThisDiskNo,
                        {?RP} integer(recEOC.CentralOffSet) + iDelta);
                    If iSizeOfSFX < 0 Then
                        Result := SE_ErrorInCentral // no local file header found
                    Else
                    Begin
                        Inc(iSizeOfSFX, iDelta);

                        // delete an existing output file
                        If FileExists(sOutFile) Then
                            EraseFile(sOutFile, HowToDelete);

                        // open output file
                        iOutFile := FileCreate(sOutFile);
                        If iOutFile = -1 Then
                            Result := SE_CreateError
                        Else
                        Begin
                            FileSeek(iInFile, iSizeOfSFX, FILE_BEGIN);

                            // write local data
                            Result := CopyBuffer(iInFile, iOutFile, {?RP} integer(recEOC.CentralOffSet) - iSizeOfSFX + iDelta);

                            // write and adjust central data
                            If Result = 0 Then
                            Begin
                                Result := CopyAndAdjustCentralDir(iInFile,
                                    iOutFile, recEOC.CentralEntries, recEOC.ThisDiskNo, iDelta - iSizeOfSFX);
                                If Result = 0 Then
                                    iSizeOfOut := FileSeek(iOutFile, 0, FILE_END);
                            End;

                            FileClose(iOutFile);
                        End;
                    End;
                End;

                If Result = 0 Then
                Begin
                    // read headers etc from input file
                    Result := ReadSFXProperties(iInFile, iSizeOfSFX);
                    If Result = 0 Then
                    Begin
                        // get the icon from the sfx
                        ReadSFXIcon(ZipFileName);
                        iSizeOfIn := FileSeek(iInFile, 0, FILE_END);
                    End;
                End;

                FileClose(iInFile);
            End;

            If (Result = 0) And ((iSizeOfSFX = -1) Or (iSizeOfOut = -1) Or (iSizeOfIn = -1)) Then
                Result := SE_GeneralError;

            If (Result = 0) Then
            Begin
                EraseFile(ZipFileName, HowToDelete);
                ZipFileName := sOutFile;
            End
            Else
                If FileExists(sOutFile) Then
                    DeleteFile(sOutFile);

        Finally
            Screen.Cursor := crSave;
        End;
    End;
End;

Procedure TZipSFXSlave.GetPropertiesFromZipMaster;
Var
    sMsg: String;                       // convert #1/#2message to message and flags
Begin
    CheckZipMaster;

    // use zipmaster properties, so convert them to our own properties
    If Assigned(FZipMaster) Then
        With FZipMaster Do
        Begin
            // convert message
            FMySFXMessageFlags := MB_OK;
            sMsg := SFXMessage;
            If sMsg <> '' Then
                Case sMsg[1] Of
                    #1:
                        Begin
                            FMySFXMessageFlags := MB_OKCANCEL Or MB_ICONINFORMATION;
                            System.Delete(sMsg, 1, 1);
                        End;
                    #2:
                        Begin
                            FMySFXMessageFlags := MB_YESNO Or MB_ICONQUESTION;
                            System.Delete(sMsg, 1, 1);
                        End;
                End;
            FMySFXMessage := sMsg;

            // translate overwrite
            Case SFXOverWriteMode Of
                ovrConfirm: FMySFXOverwriteMode := somAsk;
                ovrAlways: FMySFXOverwriteMode := somOverwrite;
                ovrNever: FMySFXOverwriteMode := somSkip;
            End;

            // translate options
            FMySFXOptions := [soCheckAutoRunFileName]; // compatibility
            If SFXAskCmdLine In SFXOptions Then
                Include(FMySFXOptions, soAskCmdLine);
            If SFXAskFiles In SFXOptions Then
                Include(FMySFXOptions, soAskFiles);
            If SFXAutoRun In SFXOptions Then
                Include(FMySFXOptions, soAutoRun);
            If SFXHideOverWriteBox In SFXOptions Then
                Include(FMySFXOptions, soHideOverWriteBox);
            If SFXNoSuccessMsg In SFXOptions Then
                Include(FMySFXOptions, soNoSuccessMsg);
        End;
End;

Procedure TZipSFXSlave.Notification(aComponent: TComponent; Operation: TOperation);
Begin
    Inherited;
    If (Operation = opRemove) And (aComponent = FZipMaster) Then
        FZipMaster := Nil;
End;

Function TZipSFXSlave.ConvertToSFX(caller: TzipMaster): integer;
Begin
    If Not assigned(FZipMaster) Then
    Begin
        Try
            FZipMaster := caller;
            // need zipmaster for messages, properties etc
            CheckZipMaster;

            Result := DoConvertOrCreateSFX(FZipMaster.ZipFileName, False);
        Finally
            FZipMaster := Nil;
        End;
    End
    Else
        Result := -255;                 // busy
End;

Function TZipSFXSlave.CreateNewSFX(caller: TzipMaster; Const sFile: String): integer;
Begin
    If Not assigned(FZipMaster) Then
    Begin
        Try
            FZipMaster := caller;
            // need zipmaster for messages, properties etc
            CheckZipMaster;

            // file must be an exe
            If UpperCase(ExtractFileExt(sFile)) <> '.EXE' Then
            Begin
                FZipMaster.ShowZipMessage(CZ_InputNotExe, '');
                Result := SE_GeneralError;
            End
            Else
                Result := DoConvertOrCreateSFX(sFile, True);
        Finally
            FZipMaster := Nil;
        End;
    End
    Else
        Result := -255;                 // busy
End;

Procedure TZipSFXSlave.CheckZipMaster;
Begin
    // need zipmaster for messages, properties etc
    If Not Assigned(FZipMaster) Then
        Raise Exception.Create('No TZipMaster component assigned');
End;
{
Function TZipSFXSlave.GetZipMaster: TZipMaster;
Begin
// need zipmaster for messages, properties etc
If Not HasZipLink Then
Raise Exception.Create('No TZipMaster component assigned');
Result := ZipMaster;
End;    }

Function TZipSFXSlave.ReadSFXProperties(Const iInFile,
    iMaxPos: integer): Integer;
Var
    pData: PChar;
    iMax, i: Integer;
    bFlags: Byte;
    sTemp: String;                      // temp string for zipmaster assignment
    pLoop: PChar;                       // loop pchar
Begin
    CheckZipMaster;

    Result := ReadNewSFXProperties(iInFile, iMaxPos);
    If Result <> 0 Then
    Begin
        iMax := 1032;                   // taken from zimstr.pas, hope it's enough for old headers ;-)
        If iMax > iMaxPos Then
            iMax := iMaxPos;

        Try
            GetMem(pData, iMax + 1);
        Except
            Result := SE_OutOfMemError;
            Exit;
        End;

        With FZipMaster Do
        Try

            // go to iMaxPos - iMax and read a complete buffer
            If (FileSeek(iInFile, iMaxPos - iMax, FILE_BEGIN) = -1) Or (FileRead(iInFile, pData^, iMax) <> iMax) Then
                Result := SE_OpenReadError
            Else
            Begin
                Result := 0;            // ok, also if no header found (could be winzip sfx or something like this)
                // ok, block read, now try to find MPV/MPU
                For i := 0 To iMax - 3 Do
                Begin
                    If (pData[i] = 'M') And (pData[i + 1] = 'P') And ((pData[i + 2] = 'U') Or (pData[i + 2] = 'V')) Then
                    Begin
                        // read back the original values from the MPU block.
                        SFXOptions := [];
                        SFXOverWriteMode := OvrConfirm;
                        bFlags := Byte(pData[i + 3]);
                        If (bFlags And 1) > 0 Then SFXOptions := SFXOptions + [SFXAskCmdLine];
                        If (bFlags And 2) > 0 Then SFXOptions := SFXOptions + [SFXAskFiles];
                        If (bFlags And 4) > 0 Then SFXOptions := SFXOptions + [SFXHideOverWriteBox];
                        If (bFlags And 8) > 0 Then SFXOverWriteMode := OvrAlways;
                        If (bFlags And 16) > 0 Then SFXOverWriteMode := OvrNever;
                        If Not (bFlags And 32 > 0) Then SFXOptions := SFXOptions + [SFXCheckSize];
                        If (bFlags And 64) > 0 Then SFXOptions := SFXOptions + [SFXAutoRun];

                        If pData[i + 2] = 'U' Then
                        Begin
                            SetString(sTemp, pData + i + 7, Integer(pData[i + 4]));
                            SFXCaption := sTemp;
                            SetString(sTemp, pData + i + Integer(pData[i + 4]) + 7, Integer(pData[i + 5]));
                            SFXDefaultDir := sTemp;
                            SetString(sTemp, pData + i + Integer(pData[i + 4]) + Integer(pData[i + 5]) + 7, Integer(pData[i + 6]));
                            SFXCommandLine := sTemp;
                        End
                        Else
                        Begin
                            If (bFlags And 128) > 0 Then SFXOptions := SFXOptions + [SFXNoSuccessMsg];
                            pLoop := pData + i + 8;
                            SetString(sTemp, pLoop + 1, Integer(pLoop[0]));
                            SFXCaption := sTemp;
                            pLoop := pLoop + Integer(pLoop[0]) + 1;
                            SetString(sTemp, pLoop + 1, Integer(pLoop[0]));
                            SFXDefaultDir := sTemp;
                            pLoop := pLoop + Integer(pLoop[0]) + 1;
                            SetString(sTemp, pLoop + 1, Integer(pLoop[0]));
                            SFXCommandLine := sTemp;
                            pLoop := pLoop + Integer(pLoop[0]) + 1;
                            SetString(sTemp, pLoop + 1, Integer(pLoop[0]));
                            SFXMessage := sTemp;
                        End;
                        Break;
                    End;
                End;
            End;
        Finally
            FreeMem(pData);
        End;
    End;
End;

Function TZipSFXSlave.ReadNewSFXProperties(Const iInFile,
    iMaxPos: integer): Integer;
Var
    recEnd: TSFXFileEndOfHeader;
    recSFX: TSFXFileHeader;
    sRead: String;
Begin
    CheckZipMaster;

    Result := SE_GeneralError;
    If (FileSeek(iInFile, iMaxPos - sizeof(recEnd), FILE_BEGIN) = -1) Or
        (FileRead(iInFile, recEnd, sizeof(recEnd)) <> sizeof(recEnd)) Or
        (recEnd.Signature <> SFX_HEADER_END_SIG) Or
        (FileSeek(iInFile, 0 - {?RP} integer(sizeof(recEnd) - recEnd.HeaderSize), FILE_CURRENT) = -1) Or
        (FileRead(iInFile, recSFX, sizeof(recSFX)) <> sizeof(recSFX)) Or
        (recSFX.Size <> recEnd.HeaderSize) Or
        (recSFX.Signature <> SFX_HEADER_SIG) Then exit;

    // new sfx header found, now parse it
    With recSFX, FZipMaster Do
    Begin

        Case DefOVW Of
            somOverwrite: SFXOverwriteMode := OvrAlways;
            somSkip: SFXOverwriteMode := OvrNever;
        Else
            SFXOverwriteMode := OvrConfirm;
        End;

        SFXOptions := [SFXCheckSize];   // compatibility
        If soAskCmdLine In Options Then
            SFXOptions := SFXOptions + [SFXAskCmdLine];
        If soAskFiles In Options Then
            SFXOptions := SFXOptions + [SFXAskFiles];
        If soAutoRun In Options Then
            SFXOptions := SFXOptions + [SFXAutoRun];
        If soHideOverWriteBox In Options Then
            SFXOptions := SFXOptions + [SFXHideOverWriteBox];
        If soNoSuccessMsg In Options Then
            SFXOptions := SFXOptions + [SFXNoSuccessMsg];

        Result := SE_OpenReadError;

        If CaptionSize > 0 Then
        Begin
            SetLength(sRead, CaptionSize);
            If FileRead(iInFile, sRead[1], CaptionSize) <> CaptionSize Then
                Exit;
            SFXCaption := sRead;
        End
        Else
            SFXCaption := '';

        If PathSize > 0 Then
        Begin
            SetLength(sRead, PathSize);
            If FileRead(iInFile, sRead[1], PathSize) <> PathSize Then
                Exit;
            SFXDefaultDir := sRead;
        End
        Else
            SFXDefaultDir := '';

        If CmdLineSize > 0 Then
        Begin
            SetLength(sRead, CmdLineSize);
            If FileRead(iInFile, sRead[1], CmdLineSize) <> CmdLineSize Then
                Exit;
            SFXCommandLine := sRead;
        End
        Else
            SFXCommandLine := '';

        If RegFailPathSize > 0 Then
        Begin
            SetLength(sRead, CmdLineSize);
            If FileRead(iInFile, sRead[1], RegFailPathSize) <> RegFailPathSize Then
                Exit;
        End;

        If StartMsgSize > 0 Then
        Begin
            SetLength(sRead, StartMsgSize);
            If FileRead(iInFile, sRead[1], StartMsgSize) <> StartMsgSize Then
                Exit;
            SFXMessage := sRead;
        End
        Else
            SFXMessage := '';

        Case StartMsgType Of
            MB_OKCANCEL Or MB_ICONINFORMATION: SFXMessage := #1 + SFXMessage;
            MB_YESNO Or MB_ICONQUESTION: SFXMessage := #2 + SFXMessage;
        End;

        Result := 0;
    End;
End;

Function TZipSFXSlave.ReadSFXIcon(sFile: String): integer;
Var
    hIco: HICON;
Begin
    CheckZipMaster;

    // read the 'custom' icon back from the executable.
    Result := 0;
    hIco := ExtractIcon(HInstance, pChar(sFile), 0);
    If (hIco <> 0) And (hIco <> INVALID_HANDLE_VALUE) Then
        With FZipMaster Do
        Begin
            If SFXIcon.Handle <> 0 Then
                SFXIcon.ReleaseHandle();
            SFXIcon.Handle := hIco;
        End;
End;

Function TZipSFXSlave.GetVersion: String;
Begin
    Result := SFX_RELEASE;
End;

Procedure TZipSFXSlave.SetVersion(Const Value: String);
Begin
    //
End;

End.

