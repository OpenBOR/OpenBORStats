Unit ZipMstr;
(* TZipMaster VCL by Chris Vleghert and Eric W. Engler
   e-mail: englere@abraxis.com
   www:    http://www.geocities.com/SiliconValley/Network/2114
 v1.72 by Russell Peters January 8, 2003.

            *)

{$DEFINE DEBUGCALLBACK}
//{$DEFINE ZipDLL173}
//{$DEFINE NO_SPAN}
//{$DEFINE NO_SFX}
// define 'OLD_STYLE' to include SFXSlave
{.$DEFINE OLDSTYLE}

{$INCLUDE ZipVers.inc}
{$IFDEF VER140}
{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
{$ENDIF}

Interface

Uses
    Forms, WinTypes, WinProcs, SysUtils, Classes, Messages, Dialogs, Controls,
    ZipDLL, UnzDLL, ZCallBck, ZipMsg, ShellApi, Graphics, Buttons, StdCtrls,
    FileCtrl;

Const
    ZIPMASTERVERSION: String = '1.72';
	ZIPMASTERBUILD: String = '1.72.1.0';
	ZIPMASTERVER: integer = 172;		// 1.72.0.4
{$IFDEF ZipDLL173}
    Min_ZipDll_Vers: integer = 173;
{$ELSE}
    Min_ZipDll_Vers: integer = 172;
{$ENDIF}
    Min_UnzDll_Vers: integer = 172;

    BUSY_ERROR = -255;                  // new 1.72y

{$IFDEF VERD2D3}
Type
    LargeInt = Comp;
Type
    pLargeInt = ^Comp;
Type
    LongWord = Cardinal;
Type
    TDate = Type TDateTime;
Const
    mrNoToAll = mrNo + 1;
{$ENDIF}
{$IFDEF VERD4+}
Type
    LargeInt = Int64;
Type
    pLargeInt = ^Int64;
{$ENDIF}

    //------------------------------------------------------------------------
Type
    ProgressType = (NewFile, ProgressUpdate, EndOfBatch, TotalFiles2Process,
        TotalSize2Process);

    AddOptsEnum = (AddDirNames, AddRecurseDirs, AddMove, AddFreshen, AddUpdate,
        AddZipTime, AddForceDOS, AddHiddenFiles, AddArchiveOnly, AddResetArchive,
        AddEncrypt, AddSeparateDirs, AddVolume, AddFromDate, AddSafe
        , AddDiskSpan, AddDiskSpanErase);
    AddOpts = Set Of AddOptsEnum;
    // new 1.72
    SpanOptsEnum = (spNoVolumeName, spCompatName, spWipeFiles, spTryFormat);
    SpanOpts = Set Of SpanOptsEnum;

    // When changing this enum also change the pointer array in the function AddSuffix,
    // and the initialisation of ZipMaster. Also keep assGIF as first and assEXE as last value.
    AddStoreSuffixEnum = (assGIF, assPNG, assZ, assZIP, assZOO, assARC,
        assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR,
        assACE, assCAB, assGZ, assGZIP, assJAR, assEXE, assEXT); // 1.71 added assEXT

    AddStoreExts = Set Of AddStoreSuffixEnum;

    ExtrOptsEnum = (ExtrDirNames, ExtrOverWrite, ExtrFreshen, ExtrUpdate, ExtrTest);
    ExtrOpts = Set Of ExtrOptsEnum;

    SFXOptsEnum = (SFXAskCmdLine, SFXAskFiles, SFXAutoRun, SFXHideOverWriteBox, SFXCheckSize, SFXNoSuccessMsg);
    SFXOpts = Set Of SFXOptsEnum;

    OvrOpts = (OvrConfirm, OvrAlways, OvrNever);

    CodePageOpts = (cpAuto, cpNone, cpOEM);
    CodePageDirection = (cpdOEM2ISO, cpdISO2OEM);

    DeleteOpts = (htdFinal, htdAllowUndo);

    UnZipSkipTypes = (stOnFreshen, stNoOverwrite, stFileExists, stBadPassword, stNoEncryptionDLL,
        stCompressionUnknown, stUnknownZipHost, stZipFileFormatWrong, stGeneralExtractError);

    ZipDiskStatusEnum = (zdsEmpty, zdsHasFiles, zdsPreviousDisk, zdsSameFileName, zdsNotEnoughSpace);
    TZipDiskStatus = Set Of ZipDiskStatusEnum;
    TZipDiskAction = (zdaOk, zdaErase, zdaReject, zdaCancel);

Type
    ZipDirEntry = Packed Record         // fixed part size = 42
        MadeByVersion: Byte;
        HostVersionNo: Byte;
        Version: Word;
        Flag: Word;
        CompressionMethod: Word;
        DateTime: Integer;              // Time: Word; Date: Word; }
        CRC32: Integer;
        CompressedSize: Integer;
        UncompressedSize: Integer;
        FileNameLength: Word;
        ExtraFieldLength: Word;
        FileCommentLen: Word;
        StartOnDisk: Word;
        IntFileAttrib: Word;
        ExtFileAttrib: LongWord;
        RelOffLocalHdr: LongWord;
        FileName: String;               // variable size
        FileComment: String;            // variable size
        Encrypted: Boolean;
        ExtraData: pChar;               // New v1.6, used in CopyZippedFiles()
    End;
    pZipDirEntry = ^ZipDirEntry;

Type
    ZipEndOfCentral = Packed Record     //Fixed part size : 22 bytes
        HeaderSig: LongWord;            //(4)  hex=06054B50
        ThisDiskNo: Word;               //(2)This disk's number
        CentralDiskNo: Word;            //(2)Disk number central dir start
        CentralEntries: Word;           //(2)Number of central dir entries on this disk
        TotalEntries: Word;             //(2)Number of entries in central dir
        CentralSize: LongWord;          //(4)Size of central directory
        CentralOffSet: LongWord;        //(4)offsett of central dir on 1st disk
        ZipCommentLen: Word;            //(2)
        // not used as part of this record structure:
        // ZipComment
    End;

Type
    ZipRenameRec = Record
        Source: String;
        Dest: String;
        DateTime: Integer;
    End;
    pZipRenameRec = ^ZipRenameRec;

Type
    EZipMaster = Class(Exception)
    PUBLIC
        FDisplayMsg: Boolean;           // We do not always want to see a message after an exception.
        // We also save the Resource ID in case the resource is not linked in the application.
        FResIdent: Integer;

        Constructor CreateResDisp(Const Ident: Integer; Const Display: Boolean);
        Constructor CreateResDisk(Const Ident: Integer; Const DiskNo: Integer);
        Constructor CreateResDrive(Const Ident: Integer; Const Drive: String);
        Constructor CreateResFile(Const Ident: Integer; Const File1, File2: String);
    End;

    TPasswordButton = (pwbOk, pwbCancel, pwbCancelAll, pwbAbort);
    TPasswordButtons = Set Of TPasswordButton;

    // 1.72.1.0 - FileSize changed to cardinal
    TProgressEvent = Procedure(Sender: TObject; ProgrType: ProgressType; Filename: String; FileSize: cardinal) Of Object;
    TMessageEvent = Procedure(Sender: TObject; ErrCode: Integer; Message: String) Of Object;
    TSetNewNameEvent = Procedure(Sender: TObject; Var OldFileName: String; Var IsChanged: Boolean) Of Object;
    TNewNameEvent = Procedure(Sender: TObject; SeqNo: Integer; ZipEntry: ZipDirEntry) Of Object;
    TPasswordErrorEvent = Procedure(Sender: TObject; IsZipAction: Boolean; Var NewPassword: String; ForFile: String; Var RepeatCount: LongWord; Var Action: TPasswordButton) Of Object;
    TCRC32ErrorEvent = Procedure(Sender: TObject; ForFile: String; FoundCRC, ExpectedCRC: LongWord; Var DoExtract: Boolean) Of Object;
    TExtractOverwriteEvent = Procedure(Sender: TObject; ForFile: String; IsOlder: Boolean; Var DoOverwrite: Boolean; DirIndex: Integer) Of Object;
    TExtractSkippedEvent = Procedure(Sender: TObject; ForFile: String; SkipType: UnZipSkipTypes; ExtError: Integer) Of Object;
    TCopyZipOverwriteEvent = Procedure(Sender: TObject; ForFile: String; Var DoOverwrite: Boolean) Of Object;
    TGetNextDiskEvent = Procedure(Sender: TObject; DiskSeqNo, DiskTotal: Integer; Drive: String; Var AbortAction: Boolean) Of Object;
    TStatusDiskEvent = Procedure(Sender: TObject; PreviousDisk: Integer; PreviousFile: String; Status: TZipDiskStatus; Var Action: TZipDiskAction) Of Object;
    TFileCommentEvent = Procedure(Sender: TObject; ForFile: String; Var FileComment: String; Var IsChanged: Boolean) Of Object;
    TAfterCallbackEvent = Procedure(Sender: TObject; Var abort: boolean) Of Object; // new 1.72
    TTickEvent = Procedure(Sender: TObject) Of Object; // new 1.72.1.0
    TFileExtraEvent = Procedure(Sender: TObject; ForFile: String; Var Data: pByteArray; Var Size: cardinal; Var IsChanged: Boolean) Of Object; // new 1.72

    TZipStream = Class(TMemoryStream)
    PUBLIC
        Constructor Create;
        Destructor Destroy; OVERRIDE;

        Procedure SetPointer(Ptr: Pointer; Size: Integer); VIRTUAL;
    End;
{$IFNDEF NO_SFX}
    // 1.72x
	TZipMaster = Class;
	TSFXProperties = class
		SFXCaption: String;
		SFXCommandLine: String;
		SFXDefaultDir: String;
		SFXIcon: TIcon;
		SFXMessage: String;
		SFXOptions: SfxOpts;
		SFXOverWriteMode: OvrOpts;
		SFXPath: String;
	end;

	TZipSFXBase = Class(TComponent)
    PROTECTED
		fVer: integer;
        Function ConvertToSFX(caller: TZipMaster): integer; VIRTUAL; ABSTRACT;
        Function ConvertToZip(caller: TZipMaster): integer; VIRTUAL; ABSTRACT;
        Function CreateNewSFX(caller: TZipMaster; Const SFXExeName: String): Integer; VIRTUAL; ABSTRACT;
        Function IsZipSFX(caller: TZipMaster; Const SFXExeName: String): Integer; VIRTUAL; ABSTRACT;
    PUBLIC
        Constructor Create(AOwner: TComponent); OVERRIDE;
        Destructor Destroy; OVERRIDE;
        Function VersionString: String; VIRTUAL; ABSTRACT;
		Function BinaryName: String; VIRTUAL; ABSTRACT;
		Property Ver: integer read fVer;
    End;
{$ENDIF}

    TZipMaster = Class(TComponent)
    PRIVATE
        // fields of published properties
        FAddCompLevel: Integer;
        fAddOptions: AddOpts;
        FAddStoreSuffixes: AddStoreExts;
        fExtAddStoreSuffixes: String;   // new 1.71
        { Private versions of property variables }
        fCancel: Boolean;
        FDirOnlyCount: Integer;
        fErrCode: Integer;
        fFullErrCode: Integer;
        fHandle: HWND;
        FIsSpanned: Boolean;
        fMessage: String;
        fVerbose: Boolean;
        fTrace: Boolean;
        fZipContents: TList;
        fExtrBaseDir: String;
        fZipBusy: Boolean;
        fUnzBusy: Boolean;
        FExtrOptions: ExtrOpts;
        FFSpecArgs: TStrings;
        FZipFileName: String;
        FSuccessCnt: Integer;
        FPassword: String;
        FEncrypt: Boolean;
        FSFXOffset: Integer;
        FDLLDirectory: String;
        FUnattended: Boolean;
        FEventErr: String;              // new  1.71
        FSpanOptions: SpanOpts;         // new 1.72
		FBusy: boolean;                 // new 1.72
		FVer: integer;					// new 1.72.0.4

        AutoExeViaAdd: Boolean;
        FVolumeName: String;
        FSizeOfDisk: LargeInt;          { Int64 or Comp }
        FDiskFree: LargeInt;
        FFreeOnDisk: LargeInt;
        //1.72        FDiskSerial: Integer;
        FDrive: String;
        FDriveFixed: Boolean;           // new 1.72
        FHowToDelete: DeleteOpts;
        FTotalSizeToProcess: Cardinal;
        FDiskNr: Integer;
        FTotalDisks: Integer;
        FFileSize: Integer;
        FRealFileSize: Cardinal;
        FWrongZipStruct: Boolean;
        FInFileName: String;
        FInFileHandle: Integer;
        FOutFileHandle: Integer;
        FVersionMadeBy1: Integer;
        FVersionMadeBy0: Integer;
        FDateStamp: Integer; { DOS formatted date/time - use Delphi's
        FileDateToDateTime function to give you TDateTime format.}
        fFromDate: TDate;
        FTempDir: String;
        FShowProgress: Boolean;
        FFreeOnDisk1: Integer;
        FFreeOnAllDisks: cardinal;      // new 1.72
        FMaxVolumeSize: Integer;
        FMinFreeVolSize: Integer;
        FCodePage: CodePageOpts;
        FZipEOC: Integer;               // End-Of-Central-Dir location
        FZipSOC: Integer;               // Start-Of-Central-Dir location
        FZipComment: String;
        FVersionInfo: String;
        FZipStream: TZipStream;
        FPasswordReqCount: LongWord;
        GAssignPassword: Boolean;
        GModalResult: TModalResult;
        FFSpecArgsExcl: TStrings;
        FUseDirOnlyEntries: Boolean;
        FRootDir: String;
        FCurWaitCount: Integer;
        FSaveCursor: TCursor;
        // Dll related variables
        fMinZipDllVer: integer;         // new 1.70
        fMinUnzDllVer: integer;         // new 1.70
        { Main call to execute a ZIP add or Delete.  This call returns the
          number of files that were sucessfully operated on. }
        ZipDllExec: Function(ZipRec: pZipParms): DWord; STDCALL;
        GetZipDllVersion: Function: DWord; STDCALL;
        ZipDllHandle: HWND;
        { Main call to execute a ZIP add or Delete.  This call returns the
          number of files that were sucessfully operated on. }
        UnzDllExec: Function(UnZipRec: pUnZipParms): DWord; STDCALL;
        GetUnzDllVersion: Function: DWord; STDCALL;
        UnzDllHandle: HWND;

        ZipParms: pZipParms;            { declare an instance of ZipParms 1 or 2 }
        UnZipParms: pUnZipParms;        { declare an instance of UnZipParms 2 }

        { Event variables }
        FOnDirUpdate: TNotifyEvent;
        FOnProgress: TProgressEvent;
        FOnMessage: TMessageEvent;
        FOnSetNewName: TSetNewNameEvent;
        FOnNewName: TNewNameEvent;
        FOnPasswordError: TPasswordErrorEvent;
        FOnCRC32Error: TCRC32ErrorEvent;
        FOnExtractOverwrite: TExtractOverwriteEvent;
        FOnExtractSkipped: TExtractSkippedEvent;
        FOnCopyZipOverwrite: TCopyZipOverwriteEvent;
        FOnFileComment: TFileCommentEvent;
        FOnAfterCallback: TAfterCallbackEvent; // new 1.72
        FOnTick: TTickEvent;        // new 1.72
        FOnFileExtra: TFileExtraEvent;  // new 1.72
{$IFNDEF NO_SPAN}
        fConfirmErase: Boolean;
        FDiskWritten: Integer;
        FDriveNr: Integer;
        // 1.72		FFormatErase: Boolean;          // New 1.70
        FInteger: Integer;
        FNewDisk: Boolean;
        FOnGetNextDisk: TGetNextDiskEvent;
        FOnStatusDisk: TStatusDiskEvent;
        FOutFileName: String;
        FZipDiskAction: TZipDiskAction;
        FZipDiskStatus: TZipDiskStatus;
{$ENDIF}
		FSFX: TZipSFXBase;              // 1.72y
		FSFXProps: TSFXProperties;		// 1.72.0.4
{$IFNDEF NO_SFX}
{$IFDEF OLDSTYLE}
        FAutoSFXSlave: TZipSFXBase;     // 1.72x
{$ENDIF}    {
        FSFXCaption: String;            // dflt='Self-extracting Archive'
        FSFXCommandLine: String;        // dflt=''
        FSFXDefaultDir: String;         // dflt=''
        FSFXIcon: TIcon;
        FSFXMessage: String;
        FSFXOptions: SFXOpts;
        FSFXOverWriteMode: OvrOpts;     // ovrConfirm  (others: ovrAlways, ovrNever)
		FSFXPath: String;         }
{$ENDIF}

        { Property get/set functions }
        Function GetCount: Integer;
        Procedure SetFSpecArgs(Value: TStrings);
        Procedure SetFileName(Value: String);
        Function GetZipVers: Integer;
        Function GetUnzVers: Integer;
        Procedure SetDLLDirectory(Value: String);
        Procedure SetVersionInfo(Value: String);
        Function GetZipComment: String;
        Procedure SetZipComment(zComment: String);
        Procedure SetPasswordReqCount(Value: LongWord);
        Procedure SetFSpecArgsExcl(Value: TStrings);
        Procedure SetExtAddStoreSuffixes(Value: String); // new 1.71

        { Private "helper" functions }
        Function IsFixedDrive(drv: String): boolean; // new 1.72
        Function Load_ZipDll(Var autoload: boolean): integer;
        Function Load_UnzDll(Var autoload: boolean): integer;
        Procedure SetMinZipDllVers(Value: integer);
        Procedure SetMinUnzDllVers(Value: integer);
        Function GetDirEntry(idx: integer): ZipDirEntry;
        Function GetZipDllPath(handle: cardinal): String;
        Function GetUnzDllPath(handle: cardinal): String;
        Procedure FreeZipDirEntryRecords;
        Procedure SetZipSwitches(Var NameOfZipFile: String; zpVersion: Integer);
        Procedure SetUnZipSwitches(Var NameOfZipFile: String; uzpVersion: Integer);
        //        Procedure ShowExceptionError(Const ZMExcept: EZipMaster);   //1.72 promoted
        Function LoadZipStr(Ident: Integer; DefaultStr: String): String;
        Function ConvCodePage(Source: String; Direction: CodePageDirection): String;
        Function IsDiskPresent: Boolean;
        Function CheckIfLastDisk(Var EOC: ZipEndOfCentral; DoExcept: Boolean): Boolean;
        Function ReplaceForwardSlash(aStr: String): String;
        Function CopyBuffer(InFile, OutFile, ReadLen: Integer): Integer;
        Procedure WriteJoin(Buffer: pChar; BufferSize, DSErrIdent: Integer);
        Procedure GetNewDisk(DiskSeq: Integer);

		Procedure DiskFreeAndSize(Action: Integer);
        Procedure AddSuffix(Const SufOption: AddStoreSuffixEnum; Var sStr: String; sPos: Integer);
        Procedure ExtExtract(UseStream: Integer; MemStream: TMemoryStream);
        Procedure ExtAdd(UseStream: Integer; StrFileDate, StrFileAttr: DWORD; MemStream: TMemoryStream);
        Procedure SetDeleteSwitches;
        Procedure StartWaitCursor;
        Procedure StopWaitCursor;
        Procedure TraceMessage(Msg: String);
		Procedure CreateMVFileName(Var FileName: String; StripPartNbr: Boolean); //new in 1.72
		procedure NoWrite(any: integer);   					// 1.72.0.4

{$IFNDEF NO_SPAN}
		Procedure CheckForDisk(writing: bool); 			// 1.70/2 changed
		Procedure ClearFloppy(dir: String); 			// New 1.70
		Function  IsRightDisk {(drt: Integer)}: Boolean; // 1.72 Changed
		Function  MakeString(Buffer: pChar; Size: Integer): String;
        Procedure RWJoinData(Buffer: pChar; ReadLen, DSErrIdent: Integer);
        Procedure RWSplitData(Buffer: pChar; ReadLen, ZSErrVal: Integer);
        Procedure WriteSplit(Buffer: pChar; Len: Integer; MinSize: Integer);
		Function  ZipFormat: Integer;    				// New 1.70
{$ENDIF}
{$IFNDEF NO_SFX}                 
		Procedure SetSFXIcon(aIcon: TIcon);        	// rest added 1.72.0.4
		function  GetSFXIcon: TIcon;
		function  GetSFXCaption: string;
		procedure SetSFXCaption(aString: string);
		function  GetSFXCommandLine: String;
		procedure SetSFXCommandLine(aString: string);
		function  GetSFXDefaultDir: String;
		procedure SetSFXDefaultDir(aString: string);
		function  GetSFXMessage: String;
		procedure SetSFXMessage(aString: string);
		function  GetSFXOptions: SfxOpts;
		procedure SetSFXOptions(aOpts: SfxOpts);
		function  GetSFXOverWriteMode: OvrOpts;
		procedure SetSFXOverWriteMode(aOpts: OvrOpts);
		function  GetSFXPath: String;
		procedure SetSFXPath(aString: string);
{$ENDIF}
    PROTECTED
        // new 1.72
        Function CallBack(ActionCode, ErrorCode: integer; NameOrMsg: pChar;
            FileSize: cardinal; ZRec: PZCallBackStruct): integer;
        Procedure _List;                // 1.72 the original
		Procedure _Delete;              // 1.72 original
		Property  SFXProperties: TSFXProperties read FSFXProps;

    PUBLIC
        Constructor Create(AOwner: TComponent); OVERRIDE;
        Destructor Destroy; OVERRIDE;

        { Public Properties (run-time only) }
        Property Handle: HWND READ fHandle WRITE fHandle;
        Property ErrCode: Integer READ fErrCode WRITE fErrCode;
        Property Message: String READ fMessage WRITE fMessage;

        Property ZipContents: TList READ FZipContents;
		Property Cancel: Boolean READ fCancel WRITE fCancel;
        Property ZipBusy: Boolean READ fZipBusy;
        Property UnzBusy: Boolean READ fUnzBusy;

        Property Count: Integer READ GetCount;
        Property SuccessCnt: Integer READ FSuccessCnt;

        Property ZipVers: Integer READ GetZipVers;
        Property UnzVers: Integer READ GetUnzVers; 
		property Ver: integer read fVer write NoWrite;

        Property SFXOffset: Integer READ FSFXOffset;
        Property ZipSOC: Integer READ FZipSOC DEFAULT 0;
        Property ZipEOC: Integer READ FZipEOC DEFAULT 0;
        Property IsSpanned: Boolean READ FIsSpanned DEFAULT False;
        Property ZipFileSize: Cardinal READ FRealFileSize DEFAULT 0;
        Property FullErrCode: Integer READ FFullErrCode;
        Property TotalSizeToProcess: Cardinal READ FTotalSizeToProcess;

        Property ZipComment: String READ GetZipComment WRITE SetZipComment;
        Property ZipStream: TZipStream READ FZipStream;
        Property DirOnlyCount: Integer READ FDirOnlyCount DEFAULT 0;

        { Public Methods }
		{ NOTE: Test is an sub-option of extract }
        Function Add: integer;          // changed 1.72
        Function Delete: integer;       // changed 1.72
        Function Extract: integer;      // changed 1.72
        Function List: integer;         // changed 1.72
        // load dll - return version
        Function Load_Zip_Dll: integer;
        Function Load_Unz_Dll: integer;
        Procedure Unload_Zip_Dll;
        Procedure Unload_Unz_Dll;
        Function ZipDllPath: String;    // new 1.72
        Function UnzDllPath: String;    // new 1.72
        Procedure AbortDlls;
        Function Busy: boolean;         // new 1.72
        Function CopyFile(Const InFileName, OutFileName: String): Integer;
        Function EraseFile(Const Fname: String; How: DeleteOpts): Integer;
        Function GetAddPassword: String;
        Function GetExtrPassword: String;
        Function AppendSlash(sDir: String): String;
        { New in v1.6 }
        Function Rename(RenameList: TList; DateTime: Integer): Integer;
        Function ExtractFileToStream(Filename: String): TZipStream;
        Function AddStreamToStream(InStream: TMemoryStream): TZipStream;
{$IFDEF VERD4+}
        Function ExtractStreamToStream(InStream: TMemoryStream; OutSize: LongWord = 32768): TZipStream;
        // 1.72 changed
        Function AddStreamToFile(Filename: String = ''; FileDate: DWord = 0; FileAttr: DWord = 0): integer;
        Function MakeTempFileName(Prefix: String = 'zip'; Extension: String = '.zip'): String;
        Procedure ShowZipMessage(Ident: Integer; UserStr: String = '');
{$ELSE}
        Procedure AddStreamToFile(Filename: String; FileDate, FileAttr: Dword);
        Function ExtractStreamToStream(InStream: TMemoryStream; OutSize: Longword): TZipStream;
        Function MakeTempFileName(Prefix, Extension: String): String;
        Procedure ShowZipMessage(Ident: Integer; UserStr: String);
{$ENDIF}
        Procedure ShowExceptionError(Const ZMExcept: EZipMaster); //1.72 promoted
        Function GetPassword(DialogCaption, MsgTxt: String; pwb: TPasswordButtons; Var ResultStr: String): TPasswordButton;
        Function CopyZippedFiles(DestZipMaster: TZipMaster; DeleteFromSource: boolean; OverwriteDest: OvrOpts): Integer;

        Property DirEntry[idx: integer]: ZipDirEntry READ GetDirEntry;
        Function FullVersionString: String; // New 1.70
{$IFNDEF NO_SPAN}
        Function ReadSpan(InFileName: String; Var OutFilePath: String): Integer;
        Function WriteSpan(InFileName, OutFileName: String): Integer;
{$ENDIF}
{$IFNDEF NO_SFX}
		Function NewSFXFile(Const ExeName: String): Integer;
        Function ConvertSFX: Integer;
        Function ConvertZIP: Integer;
        Function IsZipSFX(Const SFXExeName: String): Integer;
{$IFDEF OLDSTYLE}
        Function GetSFXLink: TZipSFXBase; // 1.72x
{$ENDIF}
{$ENDIF}

    PUBLISHED
        { Public properties that also show on Object Inspector }
        Property Verbose: Boolean READ FVerbose
            WRITE FVerbose;
        Property Trace: Boolean READ FTrace
            WRITE FTrace;
        Property AddCompLevel: Integer READ FAddCompLevel
            WRITE FAddCompLevel;
        Property AddOptions: AddOpts READ FAddOptions
            WRITE fAddOptions;
        Property AddFrom: TDate READ fFromDate WRITE fFromDate;
        Property ExtrBaseDir: String READ FExtrBaseDir
            WRITE FExtrBaseDir;
        Property ExtrOptions: ExtrOpts READ FExtrOptions
			WRITE FExtrOptions;
        Property FSpecArgs: TStrings READ FFSpecArgs
            WRITE SetFSpecArgs;
        Property Unattended: Boolean READ FUnattended
            WRITE FUnattended;
        { At runtime: every time the filename is assigned a value,
    the ZipDir will automatically be read. }
        Property ZipFileName: String READ FZipFileName
            WRITE SetFileName;
        Property Password: String READ FPassword
            WRITE FPassword;
        Property DLLDirectory: String READ FDLLDirectory
            WRITE SetDLLDirectory;
        Property MinZipDllVers: integer READ fMinZipDllVer
            WRITE SetMinZipDllVers;     // default Min_ZipDll_Vers; // new 1.70
        Property MinUnzDllVers: integer READ fMinUnzDllVer
            WRITE SetMinUnzDllVers;     // default Min_UnzDll_Vers; // new 1.70
        Property TempDir: String READ FTempDir
            WRITE FTempDir;
        Property CodePage: CodePageOpts READ FCodePage
            WRITE FCodePage DEFAULT cpAuto;
        Property HowToDelete: DeleteOpts READ FHowToDelete
            WRITE FHowToDelete DEFAULT htdAllowUndo;
		Property VersionInfo: String READ FVersionInfo
			WRITE SetVersionInfo;
        Property AddStoreSuffixes: AddStoreExts READ FAddStoreSuffixes
            WRITE FAddStoreSuffixes;
        Property ExtAddStoreSuffixes: String READ fExtAddStoreSuffixes
            WRITE SetExtAddStoreSuffixes; // new 1.71
        Property PasswordReqCount: LongWord READ FPasswordReqCount
            WRITE SetPasswordReqCount DEFAULT 1;
        Property FSpecArgsExcl: TStrings READ FFSpecArgsExcl
            WRITE SetFSpecArgsExcl;
        Property UseDirOnlyEntries: Boolean READ FUseDirOnlyEntries
            WRITE FUseDirOnlyEntries DEFAULT False;
        Property RootDir: String READ FRootDir
			WRITE fRootDir;
        { Events }
        Property OnDirUpdate: TNotifyEvent READ FOnDirUpdate
            WRITE FOnDirUpdate;
        Property OnProgress: TProgressEvent READ FOnProgress
            WRITE FOnProgress;
        Property OnMessage: TMessageEvent READ fOnMessage WRITE fOnMessage;
        Property OnSetNewName: TSetNewNameEvent READ FOnSetNewName
            WRITE FOnSetNewName;
		Property OnNewName: TNewNameEvent READ FOnNewName
            WRITE FOnNewName;
        Property OnCRC32Error: TCRC32ErrorEvent READ FOnCRC32Error
            WRITE FOnCRC32Error;
        Property OnPasswordError: TPasswordErrorEvent READ FOnPasswordError
            WRITE FOnPasswordError;
        Property OnExtractOverwrite: TExtractOverwriteEvent READ FOnExtractOverwrite
            WRITE FOnExtractOverwrite;
        Property OnExtractSkipped: TExtractSkippedEvent READ FOnExtractSkipped
            WRITE FOnExtractSkipped;
        Property OnCopyZipOverwrite: TCopyZipOverwriteEvent READ FOnCopyZipOverwrite
            WRITE FOnCopyZipOverwrite;
        Property OnFileComment: TFileCommentEvent READ FOnFileComment
            WRITE FOnFileComment;
        Property OnAfterCallback: TAfterCallbackEvent READ fOnAfterCallback
            WRITE fOnAfterCallback;     // new 1.72
		Property OnTick: TTickEvent READ FOnTick
            WRITE FOnTick;
{$IFDEF ZipDLL173}                      // new 1.72
        Property OnFileExtra: TFileExtraEvent READ FOnFileExtra
            WRITE FOnFileExtra;         // new 1.72
{$ENDIF}
{$IFNDEF NO_SPAN}
		Property SpanOptions: SpanOpts READ FSpanOptions WRITE FSpanOptions;
        Property ConfirmErase: Boolean READ fConfirmErase WRITE fConfirmErase DEFAULT True;
        // 1.72       property FormatErase: Boolean read FFormatErase write FFormatErase default False;
        Property KeepFreeOnDisk1: Integer READ FFreeOnDisk1 WRITE FFreeOnDisk1;
        Property KeepFreeOnAllDisks: Cardinal READ FFreeOnAllDisks WRITE FFreeOnAllDisks; // new 1.72
        Property MaxVolumeSize: Integer READ FMaxVolumeSize WRITE FMaxVolumesize DEFAULT 0;
        Property MinFreeVolumeSize: Integer READ FMinFreeVolSize WRITE FMinFreeVolSize DEFAULT 65536;
        Property OnGetNextDisk: TGetNextDiskEvent READ FOnGetNextDisk WRITE FOnGetNextDisk;
        Property OnStatusDisk: TStatusDiskEvent READ FOnStatusDisk WRITE FOnStatusDisk;
{$ENDIF}
{$IFDEF OLDSTYLE}
        Property SFXSlave: TZipSFXBase READ GetSFXLink WRITE fSFX; // 1.72x
{$ELSE}
        Property SFXSlave: TZipSFXBase READ fSFX WRITE fSFX; // 1.72x
{$ENDIF} 
{$IFNDEF NO_SFX}
		Property SFXCaption: String READ GetSFXCaption WRITE SetSFXCaption;
		Property SFXCommandLine: String READ GetSFXCommandLine WRITE SetSFXCommandLine;
		Property SFXDefaultDir: String READ GetSFXDefaultDir WRITE SetSFXDefaultDir;
		Property SFXIcon: TIcon READ GetSFXIcon WRITE SetSFXIcon;
		Property SFXMessage: String READ GetSFXMessage WRITE SetSFXMessage;
		Property SFXOptions: SfxOpts READ GetSFXOptions WRITE SetSFXOptions DEFAULT [SFXCheckSize];
		Property SFXOverWriteMode: OvrOpts READ GetSFXOverWriteMode WRITE SetSFXOverWriteMode;
		Property SFXPath: String READ GetSFXPath WRITE SetSFXPath;
{$ENDIF}
    End;

    //	add extra to path ensuring single backslash
Function PathConcat(path, extra: String): String;

Procedure Register;

Implementation

Uses
{$IFDEF OLDSTYLE}
    ZSFXSlave,
{$ENDIF}
    ZipStructs;
{$R ZipMstr.Res}

Const                                   { these are stored in reverse order }
    LocalFileHeaderSig = $04034B50;     { 'PK'34  (in file: 504b0304) }
    CentralFileHeaderSig = $02014B50;   { 'PK'12 }
    EndCentralDirSig = $06054B50;       { 'PK'56 }
    ExtLocalSig = $08074B50;            { 'PK'78 }
	BufSize = 10240;                    //8192;                     // Keep under 12K to avoid Winsock problems on Win95.
    // If chunks are too large, the Winsock stack can
    // lose bytes being sent or received.
    FlopBufSize = 65536;
    RESOURCE_ERROR: String = 'ZipMsgXX.res is probably not linked to the executable' + #10 + 'Missing String ID is: ';

    ZIPVERSION = 172;
    UNZIPVERSION = 172;

Type
	TBuffer = Array[0..BufSize - 1] Of Byte;
    pBuffer = ^TBuffer;
    { Define the functions that are not part of the TZipMaster class. }
    { The callback function must NOT be a member of a class. }
 { We use the same callback function for ZIP and UNZIP. }

Function ZCallback(ZCallBackRec: pZCallBackStruct): LongBool; STDCALL; FORWARD;

Type
    CallBackData = Record
        Case boolean Of
            false: (FilenameOrMessage: Array[0..511] Of byte);
            true: (FileName: Array[0..503] Of byte;
				Data: pByteArray);
    End;

Type
    TPasswordDlg = Class(TForm)
    PRIVATE
        PwBtn: Array[0..3] Of TBitBtn;
        PwdEdit: TEdit;
        PwdTxt: TLabel;

    PUBLIC
        Constructor CreateNew2(Owner: TComponent; pwb: TPasswordButtons); VIRTUAL;
        Destructor Destroy; OVERRIDE;

		Function ShowModalPwdDlg(DlgCaption, MsgTxt: String): String; VIRTUAL;
    End;

Type
    MDZipData = Record                  // MyDirZipData
        Diskstart: Word;                // The disk number where this file begins
        RelOffLocal: LongWord;          // offset from the start of the first disk
        FileNameLen: Word;              // length of current filename
        FileName: Array[0..254] Of Char; // Array of current filename
		CRC32: LongWord;
        ComprSize: LongWord;
        UnComprSize: LongWord;
        DateTime: Integer;
    End;
    pMZipData = ^MDZipData;

    TMZipDataList = Class(TList)
    PRIVATE
        Function GetItems(Index: integer): pMZipData;
    PUBLIC
        Constructor Create(TotalEntries: integer);
        Destructor Destroy; OVERRIDE;
        Property Items[Index: integer]: pMZipData READ GetItems;
        Function IndexOf(fname: String): integer;
    End;

    // ==================================================================
{$IFDEF VER90}                          // if Delphi 2

Function AnsiStrPos(S1, S2: pChar): pChar;
Begin
    Result := StrPos(S1, S2);           // not will not work with MBCS
End;

Function AnsiStrIComp(S1, S2: pChar): Integer;
Begin
    Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, S1, -1, S2, -1) - 2;
End;

Function AnsiPos(Const Substr, S: String): Integer;
Begin
    Result := Pos(Substr, S);
End;
{$ENDIF}
// ---------------------------- ZipDataList --------------------------------

Function TMZipDataList.GetItems(Index: integer): pMZipData;
Begin
    If Index >= Count Then
        Raise Exception.CreateFmt('Index (%d) outside range 1..%d',
            [Index, Count - 1]);
    Result := Inherited Items[Index];
End;

Constructor TMZipDataList.Create(TotalEntries: integer);
Var
    i: Integer; MDZDp: pMZipData;
Begin
    Inherited Create;
    Capacity := TotalEntries;
    For i := 1 To TotalEntries Do
    Begin
        New(MDZDp);
        MDZDp^.FileName := '';
        Add(MDZDp);
    End;
End;

Destructor TMZipDataList.Destroy;
Var
    i: Integer; MDZDp: pMZipData;
Begin
    If Count > 0 Then
    Begin
        For i := (Count - 1) Downto 0 Do
        Begin
            MDZDp := Items[i];
            If Assigned(MDZDp) Then     // dispose of the memory pointed-to by this entry
				Dispose(MDZDp);

            Delete(i);                  // delete the TList pointer itself
		End;
    End;
    Inherited Destroy;
End;

Function TMZipDataList.IndexOf(fname: String): integer;
Var
    MDZDp: pMZipData;
Begin
    For Result := 0 To (Count - 1) Do
    Begin
        MDZDp := Items[Result];
        If CompareText(fname, MDZDp^.FileName) = 0 Then // case insensitive compare
            break;
    End;

    // Should not happen, but maybe in a bad archive...
    If Result = Count Then
        Raise EZipMaster.CreateResDisp(DS_EntryLost, True);
End;
//----------------------------------------------------------------------------
{ Dennis Passmore (Compuserve: 71640,2464) contributed the idea of passing an
  instance handle to the DLL, and, in turn, getting it back from the callback.
  This lets us referance variables in the TZipMaster class from within the
  callback function.  Way to go Dennis!
  Modified by Russell Peters }

Function ZCallback(ZCallBackRec: PZCallBackStruct): LongBool; STDCALL;
Begin
    With TObject(ZCallBackRec^.Caller) As TZipMaster, ZCallBackRec^ Do
        Result := CallBack(ActionCode, ErrorCode, FileNameOrMsg, cardinal(FileSize), ZCallBackRec) <> 0;
End;

// 1.72 use class function to process callbacks (allows vcl to call callback)
// now catches exceptions in events
// 1.72 added ActionCode = 0 - Tick
// 1.72 added ActionCode = 14 - Get Extra Data

Function TZipMaster.CallBack(ActionCode, ErrorCode: integer; NameOrMsg: pChar; FileSize: cardinal; ZRec: PZCallBackStruct): integer;
Var
    OldFileName, pwd, FileComment: String;
    DoStop,
        IsChanged, DoExtract, DoOverwrite: Boolean;
	RptCount: LongWord;
    Response: TPasswordButton;
    Extra: pByteArray;

    Function Msg: String;
    Begin
        Result := ReplaceForwardSlash(TrimRight(NameOrMsg));
    End;

    Function ProgMsg(code: integer): String;
    Begin
		Result := '';
        If code > 0 Then
            //			Result := LoadZipMsg(DS_Progress + code);
            Case code Of
                1: Result := 'Resetting Archive Bit';
                2: Result := 'Copy file';
            Else
                Result := 'Progress ' + IntToStr(code);
            End;
    End;

Begin
	Try
        Case ActionCode Of
			0:                          { 'Tick' Just checking / processing messages}
				If assigned(fOnTick) Then
                    fOnTick(self);

            1:                          { progress type 1 = starting any ZIP operation on a new file }
				If Assigned(FOnProgress) Then
					FOnProgress(self, NewFile, Msg, FileSize);

            2:                          { progress type 2 = increment bar }
                If Assigned(FOnProgress) Then
                    FOnProgress(self, ProgressUpdate, '', FileSize);

            3:                          { end of a batch of 1 or more files }
				If Assigned(FOnProgress) Then
                    FOnProgress(self, EndOfBatch, ProgMsg(ErrorCode), 0);

            4:                          { a routine status message }
                Begin
                    Message := Msg;
                    If ErrorCode <> 0 Then // W'll always keep the last ErrorCode
                    Begin
						ErrCode := Integer(Char(ErrorCode And $FF));
                        If (ErrCode = 9) And (fEventErr <> '') Then // user cancel
                            Message := 'Exception in Event ' + fEventErr;
                        fFullErrCode := ErrorCode;
                    End;
                    If Assigned(OnMessage) Then
                        OnMessage(self, ErrorCode, Message);
                End;

            5:                          { total number of files to process }
                If Assigned(OnProgress) Then
                    OnProgress(self, TotalFiles2Process, ProgMsg(ErrorCode), FileSize);

            6:                          { total size of all files to be processed }
                Begin
                    FTotalSizeToProcess := FileSize;

                    If Assigned(FOnProgress) Then
                        FOnProgress(self, TotalSize2Process, ProgMsg(ErrorCode), FileSize);
				End;

            7:                          { request for a new path+name just before zipping or extracting }
                If Assigned(FOnSetNewName) Then
				Begin
                    OldFileName := Msg;
                    IsChanged := False;

                    FOnSetNewName(self, OldFileName, IsChanged);
                    If IsChanged Then
                    Begin
                        StrPLCopy(ZRec^.FileNameOrMsg, OldFileName, 512);
                        ZRec^.ErrorCode := 1;
                    End
                    Else
                        ZRec^.ErrorCode := 0;
                End;

            8:                          { New or other password needed during Extract() }
                Begin
                    pwd := '';
                    RptCount := FileSize;
                    Response := pwbOk;

                    GAssignPassword := False;
                    If Assigned(FOnPasswordError) Then
                    Begin
						GModalResult := mrNone;
                        FOnPasswordError(self, ZRec^.IsOperationZip, pwd, Msg, RptCount, Response);
                        If Response <> pwbOk Then
                            pwd := '';
                        If Response = pwbCancelAll Then
                            GModalResult := mrNoToAll;
                        If Response = pwbAbort Then
                            GModalResult := mrAbort;
                    End
                    Else
                        If (ErrorCode And $01) <> 0 Then
                            pwd := GetAddPassword()
                        Else
                            pwd := GetExtrPassword();

                    If pwd <> '' Then
                    Begin
                        StrPLCopy(ZRec^.FileNameOrMsg, pwd, PWLEN);
                        ZRec^.ErrorCode := 1;
                    End
                    Else
                    Begin
                        RptCount := 0;
						ZRec^.ErrorCode := 0;
                    End;
                    If RptCount > 15 Then
                        RptCount := 15;
					ZRec^.FileSize := RptCount;
                    If GModalResult = mrNoToAll Then // Cancel all
                        ZRec^.ActionCode := 0;
                    If GModalResult = mrAbort Then // Abort
                        Cancel := True;
                    GAssignPassword := True;
                End;

            9:                          { CRC32 error, (default action is extract/test the file) }
                Begin
                    DoExtract := true;  // This was default for versions <1.6
                    If Assigned(FOnCRC32Error) Then
                        FOnCRC32Error(self, Msg, ErrorCode, FileSize, DoExtract);
                    ZRec^.ErrorCode := Integer(DoExtract);
                    { This will let the Dll know it should send some warnings }
                    If Not Assigned(FOnCRC32Error) Then
                        ZRec^.ErrorCode := 2;
                End;

			10:                         { Extract(UnZip) Overwrite ask }
                If Assigned(FOnExtractOverwrite) Then
                Begin
                    DoOverwrite := Boolean(FileSize);
                    FOnExtractOverwrite(self, Msg, (ErrorCode And $10000) = $10000, DoOverwrite, ErrorCode And $FFFF);
                    ZRec^.FileSize := Integer(DoOverwrite);
                End;

			11:                         { Extract(UnZip) and Skipped }
                Begin
                    If ErrorCode <> 0 Then
                    Begin
                        ErrCode := Integer(Char(ErrorCode And $FF));
                        FFullErrCode := ErrorCode;
                    End;
                    If Assigned(FOnExtractSkipped) Then
                        FOnExtractSkipped(self, Msg, UnZipSkipTypes((FileSize And $FF) - 1), ZRec^.ErrorCode);
                End;

            12:                         { Add(Zip) FileComments. v1.60L }
                If Assigned(FOnFileComment) Then
                Begin
                    FileComment := ZRec^.FileNameOrMsg[256];
					IsChanged := False;
                    FOnFileComment(self, Msg, FileComment, IsChanged);
                    If IsChanged And (FileComment <> '') Then
                        StrPLCopy(ZRec^.FileNameOrMsg, FileComment, 511)
                    Else
                        ZRec^.FileNameOrMsg[0] := #0;
                    ZRec^.ErrorCode := Integer(IsChanged);
                    FileSize := Length(FileComment);
                    If FileSize > 511 Then
                        FileSize := 511;
                    ZRec^.FileSize := FileSize;
                End;

            13:                         { Stream2Stream extract. v1.60M }
                Begin
                    Try
                        FZipStream.SetSize(FileSize);
                    Except
                        ZRec^.ErrorCode := 1;
                        ZRec^.FileSize := 0;
                    End;
                    If ZRec^.ErrorCode <> 1 Then
                        ZRec^.FileSize := Integer(FZipStream.Memory);
				End;
            14:                         { Set Extra Data v1.72 }
                If Assigned(FOnFileExtra) Then
                Begin
                    Extra := CallBackData(ZRec^.FileNameOrMsg).Data;
                    IsChanged := False;
                    FOnFileExtra(self, Msg, Extra, FileSize, IsChanged);
                    If IsChanged {and (FileComment <> '')} Then
                    Begin
                        CallBackData(ZRec^.FileNameOrMsg).Data := Extra;
                    End;
                    If Extra = Nil Then
                        FileSize := 0;
                    ZRec^.ErrorCode := Integer(IsChanged);
                    ZRec^.FileSize := FileSize;
                End;
		End;                            {end case }
    Except
        On E: Exception Do
        Begin
            If fEventErr = '' Then      // catch first exception only
                fEventErr := ' #' + IntToStr(ActionCode) + ' "' + E.Message + '"';
            Cancel := true;
		End;
    End;
    If assigned(fOnAfterCallback) Then
    Begin
        DoStop := Cancel;
{$IFDEF DEBUGCALLBACK}
        fOnAfterCallback(TObject(ZRec), DoStop);
{$ELSE}
        fOnAfterCallback(self, DoStop);
{$ENDIF}
        If DoStop Then
            Cancel := true;
    End
    Else
        Application.ProcessMessages;
    { If you return TRUE, then the DLL will abort it's current
      batch job as soon as it can. }
    Result := ord(Cancel);
End;

{ Implementation of TZipMaster class member functions }
{-----------------------------------------------------}

Constructor TZipMaster.Create(AOwner: TComponent);
Begin
    Inherited Create(AOwner);
    fZipContents := TList.Create;
    FFSpecArgs := TStringList.Create;
    FFSpecArgsExcl := TStringList.Create; { New in v1.6 }
    fHandle := Application.Handle;
    FZipBusy := false;                  // 1.72
    FUnzBusy := false;                  // 1.72
    FBusy := false;                     // new 1.72
    FOnAfterCallback := Nil;            // new 1.72
    FOnTick := Nil;                     // new 1.72
    FOnFileExtra := Nil;                // new 1.72
    FOnDirUpdate := Nil;
    FOnProgress := Nil;
    FOnMessage := Nil;
    FOnSetNewName := Nil;
    FOnNewName := Nil;
    FOnPasswordError := Nil;
    FOnCRC32Error := Nil;
    FOnExtractOverwrite := Nil;
    FOnExtractSkipped := Nil;
    FOnCopyZipOverwrite := Nil;
    FOnFileComment := Nil;
	FOnFileExtra := Nil;                // 1.72
	ZipParms := Nil;
    UnZipParms := Nil;
    FZipFileName := '';
    FPassword := '';
    FPasswordReqCount := 1;             { New in v1.6 }
    FEncrypt := False;
    FSuccessCnt := 0;
    FAddCompLevel := 9;                 { dflt to tightest compression }
    FDLLDirectory := '';
    AutoExeViaAdd := False;
    FUnattended := False;
    FRealFileSize := 0;
    FSFXOffset := 0;
    FZipSOC := 0;
    FFreeOnDisk1 := 0;                  { Don't leave any freespace on disk 1. }
    FFreeOnAllDisks := 0;               // 1.72 { use all space }
    FMaxVolumeSize := 0;                { Use the maximum disk size. }
    FMinFreeVolSize := 65536;           { Reject disks with less free bytes than... }
    FCodePage := cpAuto;
    FIsSpanned := False;
    FZipComment := '';
    HowToDelete := htdAllowUndo;
    FAddStoreSuffixes := [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ
        , assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR];
    FZipStream := TZipStream.Create;
    FUseDirOnlyEntries := False;
	FDirOnlyCount := 0;
	FVersionInfo := ZIPMASTERVERSION;
	FVer := ZIPMASTERVER;				// 1.72.0.4
    FCurWaitCount := 0;
    ZipDllHandle := 0;
    UnzDllHandle := 0;
    fMinZipDllVer := Min_ZipDll_Vers;   // new 1.70
    fMinUnzDllVer := Min_UnzDll_Vers;   // new 1.70
    FSpanOptions := [];                 // new 1.72
{$IFNDEF NO_SPAN}
    FOnGetNextDisk := Nil;
    FOnStatusDisk := Nil;
    //1.72    fFormatErase := False;
	fConfirmErase := True;
{$ENDIF}      
	FSFX := Nil;                        // 1.72
	FSFXProps := Nil;					// 1.72.0.4
{$IFNDEF NO_SFX}
{$IFDEF OLDSTYLE}
    FAutoSFXSlave := Nil;               // 1.72x
{$ENDIF}                    
	FSFXProps := TSFXProperties.Create;
	FSFXProps.SFXIcon := TIcon.Create;  // 1.72.0.4
	FSFXProps.SFXOverWriteMode := ovrConfirm;
	FSFXProps.SFXCaption := 'Self-extracting Archive';
	FSFXProps.SFXDefaultDir := '';
	FSFXProps.SFXCommandLine := '';
	FSFXProps.SFXOptions := [SFXCheckSize];      { Select this opt by default. }
	FSFXProps.SFXPath := '';                     // 1.72 'ZipSFX.bin';
{$ENDIF}
End;

Destructor TZipMaster.Destroy;
Begin
    Unload_Zip_Dll;
    Unload_Unz_Dll;
    FZipStream.Free;
    FreeZipDirEntryRecords;
    fZipContents.Free;
    FFSpecArgsExcl.Free;
    FFSpecArgs.Free;
    //{$IFNDEF NO_SPAN}
    //{$ENDIF}
{$IFNDEF NO_SFX}
	if assigned(FSFXProps) then
		FSFXProps.SFXIcon.Free;
	FSFXProps.Free;
{$IFDEF OLDSTYLE}
    If (Not (csDesigning In ComponentState)) And assigned(FAutoSFXSlave) Then
        FreeAndNil(FAutoSFXSlave);
{$ENDIF}
{$ENDIF}
    Inherited Destroy;
End;                

procedure TZipMaster.NoWrite(any: integer);   					// 1.72.0.4
begin
end;

Function TPasswordDlg.ShowModalPwdDlg(DlgCaption, MsgTxt: String): String;
Begin
    Caption := DlgCaption;
    PwdTxt.Caption := MsgTxt;
    ShowModal();
    If ModalResult = mrOk Then
        Result := PwdEdit.Text
    Else
        Result := '';
End;

Constructor TPasswordDlg.CreateNew2(Owner: TComponent; pwb: TPasswordButtons);
Var
    BtnCnt, Btns, i, k: Integer;
Begin
    Inherited CreateNew(Owner{$IFDEF VERD4+}, 0{$ENDIF});
    // Convert Button Set to a bitfield
    BtnCnt := 1;                        // We need at least the Ok button
    Btns := 1;

    If pwbCancel In pwb Then
    Begin
        Inc(BtnCnt);
        Btns := Btns Or 2;
    End;
    If pwbCancelAll In pwb Then
    Begin
        Inc(BtnCnt);
        Btns := Btns Or 4;
    End;
    If pwbAbort In pwb Then
    Begin
        Inc(BtnCnt);
        Btns := Btns Or 8;
    End;

    Parent := Self;
    Width := 124 * BtnCnt + 35;
    Height := 137;
    Font.Name := 'Arial';
    Font.Height := -12;
    Font.Style := Font.Style + [fsBold];
    BorderStyle := bsDialog;
    Position := poScreenCenter;

    PwdTxt := TLabel.Create(Self);
    PwdTxt.Parent := Self;
    PwdTxt.Left := 20;
    PwdTxt.Top := 8;
    PwdTxt.Width := 297;
    PwdTxt.Height := 18;
    PwdTxt.AutoSize := False;

    PwdEdit := TEdit.Create(Self);
    PwdEdit.Parent := Self;
    PwdEdit.Left := 20;
    PwdEdit.Top := 40;
    PwdEdit.Width := 124 * BtnCnt - 10;
    PwdEdit.PasswordChar := '*';
    PwdEdit.MaxLength := PWLEN;

    For i := 1 To 3 Do
        PwBtn[i] := Nil;
    k := 0;
    For i := 1 To 8 Do
    Begin
        If (i = 3) Or ((i > 4) And (i < 8)) Then
            Continue;
        If (Btns And i) = 0 Then
            Continue;
        PwBtn[k] := TBitBtn.Create(Self);
        PwBtn[k].Parent := Self;
        PwBtn[k].Top := 72;
        PwBtn[k].Height := 28;
        PwBtn[k].Width := 114;
        PwBtn[k].Left := 20 + 124 * k;
        Case i Of
            1: PwBtn[k].Kind := bkOk;
            2: PwBtn[k].Kind := bkCancel;
            4: PwBtn[k].Kind := bkNo;
            8: PwBtn[k].Kind := bkAbort;
        End;
        If i = 4 Then
            PwBtn[k].ModalResult := mrNoToAll;
        Case i Of
            1: PwBtn[k].Caption := LoadStr(PW_Ok);
            2: PwBtn[k].Caption := LoadStr(PW_Cancel);
            4: PwBtn[k].Caption := LoadStr(PW_CancelAll);
            8: PwBtn[k].Caption := LoadStr(PW_Abort);
        End;
        Inc(k);
    End;
End;

Destructor TPasswordDlg.Destroy;
Var
    i: Integer;
Begin
    For i := 0 To 3 Do
        PwBtn[i].Free;
    PwdEdit.Free;
    PwdTxt.Free;
    Inherited Destroy;
End;

// defaults if old resource used

Function LoadZipMsg(Ident: Integer): String;
Begin
    Case Ident Of
        LZ_OldZipDll: Result := 'Old Dll from ';
        LU_OldUnzDll: Result := 'Old Dll from ';
        SF_NOSFXSupport: Result := 'SFX not supported';
        DS_NoDiskSpan: Result := 'Span not supported';
    Else
        Result := RESOURCE_ERROR + IntToStr(Ident);
    End;
End;

Procedure TZipMaster.ShowZipMessage(Ident: Integer; UserStr: String);
Var
    Msg: String;
Begin
    //    Msg := LoadZipStr(Ident, RESOURCE_ERROR + IntToStr(Ident)) + UserStr;
    Msg := LoadStr(Ident);
    If Msg = '' Then
        Msg := LoadZipMsg(Ident);
    Msg := Msg + UserStr;
    Message := Msg;
    ErrCode := Ident;

    If FUnattended = False Then
        ShowMessage(Msg);

    If Assigned(OnMessage) Then
        OnMessage(Self, 0, Msg);        // No ErrCode here else w'll get a msg from the application
End;

Function TZipMaster.LoadZipStr(Ident: Integer; DefaultStr: String): String;
Begin
    Result := LoadStr(Ident);

    If Result = '' Then
        Result := DefaultStr;
End;

Procedure TZipMaster.TraceMessage(Msg: String);
Begin
    If Trace And Assigned(OnMessage) Then
        OnMessage(Self, 0, Msg);        // No ErrCode here else w'll get a msg from the application
End;

//---------------------------------------------------------------------------
// Somewhat different from ShowZipMessage() because the loading of the resource
// string is already done in the constructor of the exception class.

Procedure TZipMaster.ShowExceptionError(Const ZMExcept: EZipMaster);
Begin
    If (ZMExcept.FDisplayMsg = True) And (Unattended = False) Then
        ShowMessage(ZMExcept.Message);

    ErrCode := ZMExcept.FResIdent;
    Message := ZMExcept.Message;

    If Assigned(OnMessage) Then
        OnMessage(Self, ErrCode {0}, ZMExcept.Message); // 1.72
End;

{  Convert filename (and file comment string) into "internal" charset (ISO).
 * This function assumes that Zip entry filenames are coded in OEM (IBM DOS)
 * codepage when made on:
 *  -> DOS (this includes 16-bit Windows 3.1) (FS_FAT_  0 )
 *  -> OS/2                                   (FS_HPFS_ 6 )
 *  -> Win95/WinNT with Nico Mak's WinZip     (FS_NTFS_ 11 && hostver == "5.0" 50)
 *
 * All other ports are assumed to code zip entry filenames in ISO 8859-1.
 *
 * NOTE: Norton Zip v1.0 sets the host byte incorrectly. In this case you need
 * to set the CodePage property manually to cpOEM to force the conversion.
}

Function TZipMaster.ConvCodePage(Source: String; Direction: CodePageDirection): String;
Const
    FS_FAT: Integer = 0;
    FS_HPFS: Integer = 6;
    FS_NTFS: Integer = 11;
Var
    i: Integer;
Begin
    SetLength(Result, Length(Source));
    If ((FCodePage = cpAuto) And (FVersionMadeBy1 = FS_FAT) Or (FVersionMadeBy1 = FS_HPFS)
        Or ((FVersionMadeBy1 = FS_NTFS) And (FVersionMadeBy0 = 50))) Or (FCodePage = cpOEM) Then
    Begin
        For i := 1 To Length(Source) Do
            If Char(Source[i]) < Char($80) Then
                Result[i] := Source[i]
            Else
                If Direction = cpdOEM2ISO Then
                    OemToCharBuff(@Source[i], @Result[i], 1)
                Else
                    CharToOemBuff(@Source[i], @Result[i], 1)
    End
    Else
        Result := Source;
End;

{ We'll normally have a TStringList value, since TStrings itself is an
  abstract class. }

Procedure TZipMaster.SetFSpecArgs(Value: TStrings);
Begin
    FFSpecArgs.Assign(Value);
End;

Procedure TZipMaster.SetFSpecArgsExcl(Value: TStrings);
Begin
    FFSpecArgsExcl.Assign(Value);
End;

Procedure TZipMaster.SetFilename(Value: String);
Begin
    FZipFileName := Value;
    If Not (csDesigning In ComponentState) Then
        _List;                          { automatically build a new TLIST of contents in "ZipContents" }
End;

// NOTE: we will allow a dir to be specified that doesn't exist,
// since this is not the only way to locate the DLLs.

Procedure TZipMaster.SetDLLDirectory(Value: String);
Var
    ValLen: Integer;
Begin
    If Value <> FDLLDirectory Then
    Begin
        ValLen := Length(Value);
        // if there is a trailing \ in dirname, cut it off:
        If ValLen > 0 Then
            If Value[ValLen] = '\' Then
                SetLength(Value, ValLen - 1); // shorten the dirname by one
        FDLLDirectory := Value;
    End;
End;

Function TZipMaster.GetCount: Integer;
Begin
    If ZipFileName <> '' Then
        Result := ZipContents.Count
    Else
        Result := 0;
End;

// We do not want that this can be changed, but we do want to see it in the OI.

Procedure TZipMaster.SetVersionInfo(Value: String);
Begin
End;

Procedure TZipMaster.SetPasswordReqCount(Value: LongWord);
Begin
    If Value <> FPasswordReqCount Then
    Begin
        If Value > 15 Then
            Value := 15;
        FPasswordReqCount := Value;
    End;
End;

Function TZipMaster.GetZipComment: String;
Begin
    Result := ConvCodePage(FZipComment, cpdOEM2ISO);
End;

Procedure TZipMaster.SetZipComment(zComment: String);
Var
    EOC: ZipEndOfCentral;
    len: Integer;
    CommentBuf: pChar;
    Fatal: Boolean;
Begin
    FInFileHandle := -1;
    Fatal := False;
    CommentBuf := Nil;

    Try
        { ============================ Changed by Jim Turner =========================}
        If Length(zComment) = 0 Then
            FZipComment := ''
        Else
            FZipComment := ConvCodePage(zComment, cpdISO2OEM);
        If Length(ZipFileName) = 0 Then
            Raise EZipMaster.CreateResDisp(GE_NoZipSpecified {DS_NoInFile}, True);
        len := Length(FZipComment);
        GetMem(CommentBuf, len + 1);
        StrPLCopy(CommentBuf, zComment, len + 1);
        FInFileHandle := FileOpen(ZipFileName, fmShareDenyWrite Or fmOpenReadWrite);

        If FInFileHandle <> -1 Then     // RP 1.60
        Begin
            If FileSeek(FInFileHandle, FZipEOC, 0) = -1 Then
                Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
            If (FileRead(FInFileHandle, EOC, SizeOf(EOC)) <> SizeOf(EOC)) Or (EOC.HeaderSig <> EndCentralDirSig) Then
                Raise EZipMaster.CreateResDisp(DS_EOCBadRead, True);
            EOC.ZipCommentLen := len;
            If FileSeek(FInFileHandle, -SizeOf(EOC), 1) = -1 Then
                Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
            Fatal := True;
            If FileWrite(FInFileHandle, EOC, SizeOf(EOC)) <> SizeOf(EOC) Then
                Raise EZipMaster.CreateResDisp(DS_EOCBadWrite, True);
            If FileWrite(FInFileHandle, CommentBuf^, len) <> len Then
                Raise EZipMaster.CreateResDisp(DS_NoWrite, True);
            Fatal := False;
            // if SetEOF fails we get garbage at the end of the file, not nice but
                     // also not important.
            SetEndOfFile(FInFileHandle);
        End;
    Except
        On ews: EZipMaster Do
        Begin
            ShowExceptionError(ews);
            FZipComment := '';
        End;
        On EOutOfMemory Do
        Begin
            ShowZipMessage(GE_NoMem, '');
            FZipComment := '';
        End;
    End;
    FreeMem(CommentBuf);
    If FInFileHandle <> -1 Then
        FileClose(FInFileHandle);
    If Fatal Then                       // Try to read the zipfile, maybe it still works.
        _List;
End;

{ Empty fZipContents and free the storage used for dir entries }

Procedure TZipMaster.FreeZipDirEntryRecords;
Var
    i: Integer;
Begin
    If ZipContents.Count = 0 Then
        Exit;
    For i := (ZipContents.Count - 1) Downto 0 Do
    Begin
        If Assigned(ZipContents[i]) Then
        Begin
            StrDispose(pZipDirEntry(ZipContents[i]).ExtraData);
            // dispose of the memory pointed-to by this entry
            Dispose(pZipDirEntry(ZipContents[i]));
        End;
        ZipContents.Delete(i);          // delete the TList pointer itself
    End;                                { end for }
    // The caller will free the FZipContents TList itself, if needed
End;

Procedure TZipMaster.StartWaitCursor;
Begin
    If ForegroundTask Then              // 1.72
    Begin
        If FCurWaitCount = 0 Then
        Begin
            FSaveCursor := Screen.Cursor;
            Screen.Cursor := crHourglass;
        End;
        Inc(FCurWaitCount);
    End;
End;

Procedure TZipMaster.StopWaitCursor;
Begin
    If ForegroundTask Then              // 1.72
    Begin
        If FCurWaitCount > 0 Then
        Begin
            Dec(FCurWaitCount);
            If FCurWaitCount = 0 Then
                Screen.Cursor := FSaveCursor;
        End;
    End;
End;

// new 1.72

Function TZipMaster.Busy: Boolean;
Begin
    Result := FBusy Or FZipBusy Or FUnzBusy;
End;

{ New in v1.50: We are now looking at the Central zip Dir, instead of
  the local zip dir.  This change was needed so we could support
  Disk-Spanning, where the dir for the whole disk set is on the last disk.}
{ The List method reads thru all entries in the central Zip directory.
  This is triggered by an assignment to the ZipFilename, or by calling
  this method directly. }

Function TZipMaster.List: integer;      // public
Begin
    Result := BUSY_ERROR;
    If Busy Then
        exit;
    Try
        fBusy := true;
        _List;
    Finally
        fBusy := false;
    End;
    Result := fErrCode;
End;

Procedure TZipMaster._List;             { all work is local - no DLL calls }
Var
    pzd: pZipDirEntry;
    EOC: ZipEndOfCentral;
    CEH: ZipCentralHeader;
    OffsetDiff: Integer;
    Name: String;
    i, LiE: Integer;
Begin
    LiE := 0;
    If (csDesigning In ComponentState) Then
        Exit;                           { can't do LIST at design time }

    { zero out any previous entries }
    FreeZipDirEntryRecords;

    FRealFileSize := 0;
    FZipSOC := 0;
    FSFXOffset := 0;                    // must be before the following "if"
    FZipComment := '';
    OffsetDiff := 0;
    FIsSpanned := False;
    FDirOnlyCount := 0;
    fErrCode := 0;                      // 1.72

    If Not FileExists(FZipFileName) Then
    Begin
        { let user's program know there's no entries }
        If Assigned(FOnDirUpdate) Then
            FOnDirUpdate(Self);
        Exit;
    End;

    Try
        StartWaitCursor;
        Try
            FInfileName := FZipFileName;
            FDrive := ExtractFileDrive(ExpandFileName(FInFileName)) + '\';
            FDriveFixed := IsFixedDrive(FDrive);
            IsDiskPresent;
            CheckIfLastDisk(EOC, true); // exception if not
            { The function CheckIfLastDisk read the EOC record, and set some
             global values such as FFileSize.  It also opens the zipfile
             and left it's open handle in: FInFileHandle }

            FTotalDisks := EOC.ThisDiskNo; // Needed in case GetNewDisk is called.

            // This could also be set to True if it's the first and only disk.
            If EOC.ThisDiskNo > 0 Then
                FIsSpanned := True;

            // Do we have to request for a previous disk first?
            If EOC.ThisDiskNo <> EOC.CentralDiskNo Then
            Begin
                GetNewDisk(EOC.CentralDiskNo);
                FFileSize := FileSeek(FInFileHandle, 0, 2); //v1.52i
                OffsetDiff := EOC.CentralOffset; //v1.52i
            End
            Else                        //v1.52i
                // Due to the fact that v1.3 and v1.4x programs do not change the archives
                // EOC and CEH records in case of a SFX conversion (and back) we have to
                // make this extra check.
                OffsetDiff := Longword(FFileSize) - EOC.CentralSize - SizeOf(EOC) - EOC.ZipCommentLen;
            FZipSOC := OffsetDiff;      // save the location of the Start Of Central dir
            FSFXOffset := FFileSize;    // initialize this - we will reduce it later
            If FFileSize = 22 Then
                FSFXOffset := 0;

            FWrongZipStruct := False;
            If EOC.CentralOffset <> Longword(OffsetDiff) Then
            Begin
                FWrongZipStruct := True; // We need this in the ConvertXxx functions.
                ShowZipMessage(LI_WrongZipStruct, '');
            End;

            // Now we can go to the start of the Central directory.
            If FileSeek(FInFileHandle, OffsetDiff, 0) = -1 Then
                Raise EZipMaster.CreateResDisp(LI_ReadZipError, True);

            // Read every entry: The central header and save the information.
            For i := 0 To (EOC.TotalEntries - 1) Do
            Begin
                // Read a central header entry for 1 file
                While FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) Do //v1.52i
                Begin
                    // It's possible that we have the central header split up.
                    If FDiskNr >= EOC.ThisDiskNo Then
                        Raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
                    // We need the next disk with central header info.
                    GetNewDisk(FDiskNr + 1);
                End;

                //validate the signature of the central header entry
                If CEH.HeaderSig <> CentralFileHeaderSig Then
                    Raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

                // Now the filename
                SetLength(Name, CEH.FileNameLen);
                If FileRead(FInFileHandle, Name[1], CEH.FileNameLen) <> CEH.FileNameLen Then
                    Raise EZipMaster.CreateResDisp(DS_CENameLen, True);

                // Save version info globally for use by codepage translation routine
                FVersionMadeBy0 := CEH.VersionMadeBy0;
                FVersionMadeBy1 := CEH.VersionMadeBy1;
                Name := ConvCodePage(Name, cpdOEM2ISO);

                // Create a new ZipDirEntry pointer.
                New(pzd);               // These will be deleted in: FreeZipDirEntryRecords.

                // Copy the needed file info from the central header.
                CopyMemory(pzd, @CEH.VersionMadeBy0, 42);
                pzd^.FileName := ReplaceForwardSlash(Name);
                pzd^.Encrypted := (pzd^.Flag And 1) > 0;

                // Read the extra data if present new v1.6
                If pzd^.ExtraFieldLength > 0 Then
                Begin
                    pzd^.ExtraData := StrAlloc(CEH.ExtraLen + 1);
                    If FileRead(FInFileHandle, pzd^.ExtraData[0], CEH.ExtraLen) <> CEH.ExtraLen Then // v1.60m
                        Raise EZipMaster.CreateResDisp(LI_ReadZipError, True);
                End
                Else
                    pzd^.ExtraData := Nil;

                // Read the FileComment, if present, and save.
                If CEH.FileComLen > 0 Then
                Begin
                    // get the file comment
                    SetLength(pzd^.FileComment, CEH.FileComLen);
                    If FileRead(FInFileHandle, pzd^.FileComment[1], CEH.FileComLen) <> CEH.FileComLen Then
                        Raise EZipMaster.CreateResDisp(DS_CECommentLen, True);
                    pzd^.FileComment := ConvCodePage(pzd^.FileComment, cpdOEM2ISO);
                End;

                If FUseDirOnlyEntries Or (ExtractFileName(pzd^.FileName) <> '') Then
                Begin                   // Add it to our contents tabel.
                    ZipContents.Add(pzd);
                    // Notify user, when needed, of the next entry in the ZipDir.
                    If Assigned(FOnNewName) Then
                        FOnNewName(self, i + 1, pzd^);
                End
                Else
                Begin
                    Inc(FDirOnlyCount);
                    StrDispose(pzd^.ExtraData);
                    Dispose(pzd);
                End;

                // Calculate the earliest Local Header start
                If Longword(FSFXOffset) > CEH.RelOffLocal Then
                    FSFXOffset := CEH.RelOffLocal;
            End;
            FTotalDisks := EOC.ThisDiskNo; // We need this when we are going to extract.
        Except
            On ezl: EZipMaster Do       // Catch all Zip List specific errors.
            Begin
                ShowExceptionError(ezl);
                LiE := 1;
            End;
            On EOutOfMemory Do
            Begin
                ShowZipMessage(GE_NoMem, '');
                LiE := 1;
            End;
            On E: Exception Do
            Begin
                // the error message of an unknown error is displayed ...
                ShowZipMessage(LI_ErrorUnknown, E.Message);
                LiE := 1;
            End;
        End;
    Finally
        StopWaitCursor;
        If FInFileHandle <> -1 Then
            FileClose(FInFileHandle);
        If LiE = 1 Then
        Begin
            FZipFileName := '';
            FSFXOffset := 0;
        End
        Else
            FSFXOffset := FSFXOffset + (OffsetDiff - Integer(EOC.CentralOffset)); // Correct the offset for v1.3 and 1.4x

        // Let the user's program know we just refreshed the zip dir contents.
        If Assigned(FOnDirUpdate) Then
            FOnDirUpdate(Self);
    End;
End;

// new 1.72 tests for 'fixed' drives

Function TZipMaster.IsFixedDrive(drv: String): boolean;
Var
    drt: integer;
Begin
    drt := GetDriveType(pChar(drv));
    Result := (drt = DRIVE_FIXED) Or (drt = DRIVE_REMOTE) Or (drt = DRIVE_RAMDISK);
End;

// new 1.72

Procedure TZipMaster.CreateMVFileName(Var FileName: String; StripPartNbr: Boolean);
Var
    ext: String; StripLen: integer;
Begin                                   // changes filename into multi volume filename
    If (spCompatName In FSpanOptions) Then
    Begin
        If (FDiskNr <> FTotalDisks) Then
            ext := '.z' + copy(IntToStr(101 + FDiskNr), 2, 2)
        Else
            ext := '.zip';
        FileName := ChangeFileExt(FileName, ext);
    End
    Else
    Begin
        StripLen := 0;
        If StripPartNbr Then
            StripLen := 3;
        FileName := Copy(FileName, 1, length(FileName) - Length(ExtractFileExt(FileName)) - StripLen)
            + Copy(IntToStr(1001 + FDiskNr), 2, 3)
            + ExtractFileExt(FileName);
    End;

End;

Procedure TZipMaster.SetExtAddStoreSuffixes(Value: String);
Var
    str: String; i: integer; c: char;
Begin
    If Value <> '' Then
    Begin
        c := ':';
        i := 1;
        While i <= length(Value) Do
        Begin
            c := Value[i];
            If c <> '.' Then
                str := str + '.';
            While (c <> ':') And (i <= length(Value)) Do
            Begin
                c := Value[i];
                If (c = ';') Or (c = ':') Or (c = ',') Then
                    c := ':';
                str := str + c;
                inc(i);
            End;
        End;
        If c <> ':' Then
            str := str + ':';
        fAddStoreSuffixes := fAddStoreSuffixes + [assEXT];
        fExtAddStoreSuffixes := Lowercase(str);
    End
    Else
    Begin
        fAddStoreSuffixes := fAddStoreSuffixes - [assEXT];
        fExtAddStoreSuffixes := '';
    End;
End;
// Add a new suffix to the suffix string if contained in the set 'FAddStoreSuffixes'
// changed 1.71

Procedure TZipMaster.AddSuffix(Const SufOption: AddStoreSuffixEnum; Var sStr: String; sPos: Integer);
Const
    SuffixStrings: Array[0..17, 0..3] Of Char = ('gif', 'png', 'z', 'zip', 'zoo', 'arc', 'lzh', 'arj', 'taz', 'tgz', 'lha', 'rar', 'ace', 'cab', 'gz', 'gzip', 'jar', 'exe');
Begin
    If SufOption = assEXT Then
    Begin
        sStr := sStr + fExtAddStoreSuffixes;
    End
    Else
        If SufOption In fAddStoreSuffixes Then
            sStr := sStr + '.' + String(SuffixStrings[sPos]) + ':';
End;

Procedure TZipMaster.SetZipSwitches(Var NameOfZipFile: String; zpVersion: Integer);
Var
    i: Integer;
    SufStr, Dts: String;
    pExFiles: pExcludedFileSpec;
Begin
    With ZipParms^ Do
    Begin
        If Length(FZipComment) <> 0 Then
        Begin
            fArchComment := StrAlloc(Length(FZipComment) + 1);
            StrPLCopy(fArchComment, FZipComment, Length(FZipComment) + 1);
        End;
        If AddArchiveOnly In fAddOptions Then
            fArchiveFilesOnly := 1;
        If AddResetArchive In fAddOptions Then
            fResetArchiveBit := 1;

        If (FFSpecArgsExcl.Count <> 0) Then
        Begin
            fTotExFileSpecs := FFSpecArgsExcl.Count;
            fExFiles := AllocMem(SizeOf(ExcludedFileSpec) * FFSpecArgsExcl.Count);
            For i := 0 To (fFSpecArgsExcl.Count - 1) Do
            Begin
                pExFiles := fExFiles;
                Inc(pExFiles, i);
                pExFiles.fFileSpec := StrAlloc(Length(fFSpecArgsExcl[i]) + 1);
                StrPLCopy(pExFiles.fFileSpec, fFSpecArgsExcl[i], Length(fFSpecArgsExcl[i]) + 1);
            End;
        End;
        // New in v 1.6M Dll 1.6017, used when Add Move is choosen.
        If FHowToDelete = htdAllowUndo Then
            fHowToMove := True;
        If FCodePage = cpOEM Then
            fWantedCodePage := 2;
    End;                                { end with }

    If (Length(FTempDir) <> 0) Then
    Begin
        ZipParms.fTempPath := StrAlloc(Length(FTempDir) + 1);
        StrPLCopy(ZipParms.fTempPath, FTempDir, Length(FTempDir) + 1);
    End;

    With ZipParms^ Do
    Begin
        Version := zpVersion;           //ZIPVERSION;          // version we expect the DLL to be
        Caller := Self;                 // point to our VCL instance; returned in callback

        fQuiet := True;                 { we'll report errors upon notification in our callback }
        { So, we don't want the DLL to issue error dialogs }

        ZCallbackFunc := ZCallback;     // pass addr of function to be called from DLL
        fJunkSFX := False;              { if True, convert input .EXE file to .ZIP }

        SufStr := '';
        For i := 0 To Integer(assEXE) Do
            AddSuffix(AddStoreSuffixEnum(i), SufStr, i);
        If assEXT In fAddStoreSuffixes Then // new 1.71
            SufStr := SufStr + fExtAddStoreSuffixes;
        If Length(SufStr) <> 0 Then
        Begin
            System.Delete(SufStr, Length(SufStr), 1);
            pSuffix := StrAlloc(Length(SufStr) + 1);
            StrPLCopy(pSuffix, SufStr, Length(SufStr) + 1);
        End;
        // fComprSpecial := False;     { if True, try to compr already compressed files }

        fSystem := False;               { if True, include system and hidden files }

        If AddVolume In fAddOptions Then
            fVolume := True             { if True, include volume label from root dir }
        Else
            fVolume := False;

        fExtra := False;                { if True, include extended file attributes-NOT SUPTED }

        fDate := AddFromDate In fAddOptions; { if True, exclude files earlier than specified date }
        { Date := '100592'; }{ Date to include files after; only used if fDate=TRUE }
        dts := FormatDateTime('mm dd yy', fFromDate);
        For i := 0 To 7 Do
            Date[i] := dts[i + 1];

        fLevel := FAddCompLevel;        { Compression level (0 - 9, 0=none and 9=best) }
        fCRLF_LF := False;              { if True, translate text file CRLF to LF (if dest Unix)}
        If AddSafe In FAddOptions Then
            fGrow := false
        Else
            fGrow := True;              { if True, Allow appending to a zip file (-g)}

        fDeleteEntries := False;        { distinguish bet. Add and Delete }

        If fTrace Then
            fTraceEnabled := True
        Else
            fTraceEnabled := False;
        If fVerbose Then
            fVerboseEnabled := True
        Else
            fVerboseEnabled := False;
        If (fTraceEnabled And Not fVerbose) Then
            fVerboseEnabled := True;    { if tracing, we want verbose also }

        If FUnattended Then
            Handle := 0
        Else
            Handle := fHandle;

        If AddForceDOS In fAddOptions Then
            fForce := True              { convert all filenames to 8x3 format }
        Else
            fForce := False;
        If AddZipTime In fAddOptions Then
            fLatestTime := True         { make zipfile's timestamp same as newest file }
        Else
            fLatestTime := False;
        If AddMove In fAddOptions Then
            fMove := True               { dangerous, beware! }
        Else
            fMove := False;
        If AddFreshen In fAddOptions Then
            fFreshen := True
        Else
            fFreshen := False;
        If AddUpdate In fAddOptions Then
            fUpdate := True
        Else
            fUpdate := False;
        If (fFreshen And fUpdate) Then
            fFreshen := False;          { Update has precedence over freshen }

        If AddEncrypt In fAddOptions Then
            fEncrypt := True            { DLL will prompt for password }
        Else
            fEncrypt := False;

        { NOTE: if user wants recursion, then he probably also wants
          AddDirNames, but we won't demand it. }
        If AddRecurseDirs In fAddOptions Then
            fRecurse := True
        Else
            fRecurse := False;

        If AddHiddenFiles In fAddOptions Then
            fSystem := True
        Else
            fSystem := False;

        If AddSeparateDirs In fAddOptions Then
            fNoDirEntries := False { do make separate dirname entries - and also
            include dirnames with filenames }
        Else
            fNoDirEntries := True; { normal zip file - dirnames only stored
        with filenames }

        If AddDirNames In fAddOptions Then
            fJunkDir := False           { we want dirnames with filenames }
        Else
            fJunkDir := True;           { don't store dirnames with filenames }

        pZipFN := StrAlloc(Length(NameOfZipFile) + 1); { allocate room for null terminated string }
        StrPLCopy(pZipFN, NameOfZipFile, Length(NameOfZipFile) + 1); { name of zip file }
        If Length(FPassword) > 0 Then
        Begin
            pZipPassword := StrAlloc(Length(FPassword) + 1); { allocate room for null terminated string }
            StrPLCopy(pZipPassword, FPassword, PWLEN + 1); { password for encryption/decryption }
        End;
    End;                                {end else with do }
End;

Procedure TZipMaster.SetDeleteSwitches; { override "add" behavior assumed by SetZipSwitches: }
Begin
    With ZipParms^ Do
    Begin
        fDeleteEntries := True;
        fGrow := False;
        fJunkDir := False;
        fMove := False;
        fFreshen := False;
        fUpdate := False;
        fRecurse := False;              // bug fix per Angus Johnson
        fEncrypt := False;              // you don't need the pwd to delete a file
    End;
End;

Procedure TZipMaster.SetUnZipSwitches(Var NameOfZipFile: String; uzpVersion: Integer);
Begin
    With UnZipParms^ Do
    Begin
        Version := uzpVersion;          //UNZIPVERSION;        // version we expect the DLL to be
        Caller := Self;                 // point to our VCL instance; returned in callback

        fQuiet := True;                 { we'll report errors upon notification in our callback }
        { So, we don't want the DLL to issue error dialogs }

        ZCallbackFunc := ZCallback;     // pass addr of function to be called from DLL

        If fTrace Then
            fTraceEnabled := True
        Else
            fTraceEnabled := False;
        If fVerbose Then
            fVerboseEnabled := True
        Else
            fVerboseEnabled := False;
        If (fTraceEnabled And Not fVerboseEnabled) Then
            fVerboseEnabled := True;    { if tracing, we want verbose also }

        If FUnattended Then
            Handle := 0
        Else
            Handle := fHandle;          // used for dialogs (like the pwd dialogs)

        fQuiet := True;                 { no DLL error reporting }
        fComments := False;             { zipfile comments - not supported }
        fConvert := False;              { ascii/EBCDIC conversion - not supported }

        If ExtrDirNames In fExtrOptions Then
            fDirectories := True
        Else
            fDirectories := False;
        If ExtrOverWrite In fExtrOptions Then
            fOverwrite := True
        Else
            fOverwrite := False;

        If ExtrFreshen In fExtrOptions Then
            fFreshen := True
        Else
            fFreshen := False;
        If ExtrUpdate In fExtrOptions Then
            fUpdate := True
        Else
            fUpdate := False;
        If fFreshen And fUpdate Then
            fFreshen := False;          { Update has precedence over freshen }

        If ExtrTest In fExtrOptions Then
            fTest := True
        Else
            fTest := False;

        { allocate room for null terminated string }
        pZipFN := StrAlloc(Length(NameOfZipFile) + 1);
        StrPLCopy(pZipFN, NameOfZipFile, Length(NameOfZipFile) + 1); { name of zip file }

        UnZipParms.fPwdReqCount := FPasswordReqCount;
		{ We have to be carefull doing an unattended Extract when a password is needed
         for some file in the archive. We set it to an unlikely password, this way
		 encrypted files won't be extracted.
           From verion 1.60 and up the event OnPasswordError is called in this case. }

        pZipPassword := StrAlloc(Length(FPassword) + 1); // Allocate room for null terminated string.
        StrPLCopy(pZipPassword, FPassword, Length(FPassword) + 1); // Password for encryption/decryption.
    End;                                { end with }
End;

Function TZipMaster.GetAddPassword: String;
Var
    p1, p2: String;
Begin
    p2 := '';
    If FUnattended Then
        ShowZipMessage(PW_UnatAddPWMiss, '')
    Else
    Begin
        If (GetPassword(LoadZipStr(PW_Caption, RESOURCE_ERROR), LoadStr(PW_MessageEnter), [pwbCancel], p1) = pwbOk) And (p1 <> '') Then
        Begin
            If (GetPassword(LoadZipStr(PW_Caption, RESOURCE_ERROR), LoadStr(PW_MessageConfirm), [pwbCancel], p2) = pwbOk) And (p2 <> '') Then
            Begin
                If AnsiCompareStr(p1, p2) <> 0 Then
                Begin
                    ShowZipMessage(GE_WrongPassword, '');
                    p2 := '';
                End
                Else
                    If GAssignPassword Then
                        FPassword := p2;
            End;
        End;
    End;
    Result := p2;
End;

// Same as GetAddPassword, but does NOT verify

Function TZipMaster.GetExtrPassword: String;
Var
    p1: String;
Begin
    p1 := '';
    If FUnattended Then
        ShowZipMessage(PW_UnatExtPWMiss, '')
    Else
        If (GetPassword(LoadZipStr(PW_Caption, RESOURCE_ERROR), LoadStr(PW_MessageEnter), [pwbCancel, pwbCancelAll], p1) = pwbOk) And (p1 <> '') Then
            If GAssignPassword Then
                FPassword := p1;
    Result := p1;
End;

Function TZipMaster.GetPassword(DialogCaption, MsgTxt: String; pwb: TPasswordButtons; Var ResultStr: String): TPasswordButton;
Var
    Pdlg: TPasswordDlg;
Begin
    Pdlg := TPasswordDlg.CreateNew2(Self, pwb);
    ResultStr := Pdlg.ShowModalPwdDlg(DialogCaption, MsgTxt);
    GModalResult := Pdlg.ModalResult;
    Pdlg.Free;
    Case GModalResult Of
        mrOk: Result := pwbOk;
        mrCancel: Result := pwbCancel;
        mrNoToAll: Result := pwbCancelAll;
    Else
        Result := pwbAbort;
    End;
End;

Function TZipMaster.Add: integer;
Begin
    Result := BUSY_ERROR;
    If Busy Then
        exit;
    Try
        FBusy := true;
        ExtAdd(0, 0, 0, Nil);
    Finally
        FBusy := false;
    End;
    Result := fErrCode;
End;

//---------------------------------------------------------------------------
// FileAttr are set to 0 as default.
// FileAttr can be one or a logical combination of the following types:
// FILE_ATTRIBUTE_ARCHIVE, FILE_ATTRIBUTE_HIDDEN, FILE_ATTRIBUTE_READONLY, FILE_ATTRIBUTE_SYSTEM.
// FileName is as default an empty string.
// FileDate is default the system date.

// EWE: I think 'Filename' is the name you want to use in the zip file to
// store the contents of the stream under.

Function TZipMaster.AddStreamToFile(Filename: String; FileDate, FileAttr: DWORD): integer;
Var
    st: TSystemTime;
    ft: TFileTime;
    FatDate, FatTime: Word;
Begin
    Result := BUSY_ERROR;
    If Busy Then
        exit;
    Try
        FBusy := true;
        TraceMessage('AddStreamToFile, fname=' + Filename); //  qqq
        If Length(Filename) > 0 Then
        Begin
            FFSpecArgs.Clear();
            FFSpecArgs.Append(FileName);
        End;
        If FileDate = 0 Then
        Begin
            GetLocalTime(st);
            SystemTimeToFileTime(st, ft);
            FileTimeToDosDateTime(ft, FatDate, FatTime);
            FileDate := (DWORD(FatDate) Shl 16) + FatTime;
        End;
        // Check if wildcards are set.
        If FFSpecArgs.Count > 0 Then
        Begin
            If (AnsiPos(FFSpecArgs.Strings[0], '*') > 0) Or (AnsiPos(FFSpecArgs.Strings[0], '?') > 0) Then
                ShowZipMessage(AD_InvalidName, '')
            Else
                ExtAdd(1, FileDate, FileAttr, Nil);
        End
        Else
            ShowZipMessage(AD_NothingToZip, '');
    Finally
        fBusy := false;
    End;
    Result := fErrCode;
End;

//---------------------------------------------------------------------------

Function TZipMaster.AddStreamToStream(InStream: TMemoryStream): TZipStream;
Begin
    Result := Nil;
    If Busy Then
        Exit;
    If InStream = FZipStream Then
    Begin
        ShowZipMessage(AD_InIsOutStream, '');
        Exit;
    End;
    If InStream.Size > 0 Then
    Begin
        FZipStream.SetSize(InStream.Size + 6);
        // Call the extended Add procedure:
        ExtAdd(2, 0, 0, InStream);
		{ The size of the output stream is reset by the dll in ZipParms2 in fOutStreamSize.
			Also the size is 6 bytes more than the actual output size because:
			 - the first two bytes are used as flag, STORED=0 or DEFLATED=8.
			 - the next four bytes are set to the calculated CRC value.
			 The size is reset from Inputsize +6 to the actual data size +6.
			 (you do not have to set the size yourself, in fact it won't be taken into account.
			 The start of the stream is set to the actual data start. }
        If FSuccessCnt = 1 Then
            FZipStream.Position := 6
        Else
            FZipStream.SetSize(0);
    End
    Else
        ShowZipMessage(AD_NothingToZip, '');
    Result := FZipStream;
End;

//---------------------------------------------------------------------------
// UseStream = 0 ==> Add file to zip archive file.
// UseStream = 1 ==> Add stream to zip archive file.
// UseStream = 2 ==> Add stream to another (zipped) stream.

Procedure TZipMaster.ExtAdd(UseStream: Integer; StrFileDate, StrFileAttr: DWORD; MemStream: TMemoryStream);
Var
	i, DLLVers: Integer;
{$IFNDEF NO_SFX}
    SFXResult: Integer;
{$ENDIF}
    AutoLoad: Boolean;
    TmpZipName: String;
    pFDS: pFileData;
    pExFiles: pExcludedFileSpec;
    len, b, p, RootLen: Integer;
    rdir: String;
Begin
    FSuccessCnt := 0;
    If (UseStream = 0) And (fFSpecArgs.Count = 0) Then
    Begin
        ShowZipMessage(AD_NothingToZip, '');
        Exit;
    End;
    If (AddDiskSpanErase In FAddOptions) Then
    Begin
        FAddOptions := FAddOptions + [AddDiskSpan]; // make certain set
        FSpanOptions := FSpanOptions + [spWipeFiles];
    End;
{$IFDEF NO_SPAN}
    If {(AddDiskSpanErase In FAddOptions) Or}(AddDiskSpan In FAddOptions) Then
    Begin
        ShowZipMessage(DS_NODISKSPAN, '');
        Exit;
    End;
{$ENDIF}
    { We must allow a zipfile to be specified that doesn't already exist,
         so don't check here for existance. }
    If (UseStream < 2) And (FZipFileName = '') Then { make sure we have a zip filename }
    Begin
        ShowZipMessage(GE_NoZipSpecified, '');
        Exit;
    End;
    // We can not do an Unattended Add if we don't have a password.
    If FUnattended And (AddEncrypt In FAddOptions) And (FPassword = '') Then
    Begin
        ShowZipMessage(AD_UnattPassword, '');
        Exit
    End;

    // If we are using disk spanning, first create a temporary file
    If (UseStream < 2) And (AddDiskSpan In FAddOptions) {Or (AddDiskSpanErase In FAddOptions)} Then
    Begin
{$IFDEF NO_SPAN}
        ShowZipMessage(DS_NoDiskSpan, '');
        exit;
{$ELSE}
        // We can't do this type of Add() on a spanned archive.
        If (AddFreshen In FAddOptions) Or (AddUpdate In FAddOptions) Then
        Begin
            ShowZipMessage(AD_NoFreshenUpdate, '');
            Exit;
        End;
        // We can't make a spanned SFX archive
        If (UpperCase(ExtractFileExt(FZipFileName)) = '.EXE') Then
        Begin
            ShowZipMessage(DS_NoSFXSpan, '');
            Exit;
        End;
        TmpZipName := MakeTempFileName('', '');

        If FVerbose And Assigned(FOnMessage) Then
            FOnMessage(Self, 0, 'Temporary zipfile: ' + TmpZipName);
{$ENDIF}
    End
    Else
        TmpZipName := FZipFileName;     // not spanned - create the outfile directly

    { Make sure we can't get back in here while work is going on }
    If fZipBusy Then
        Exit;

    If (UseStream < 2) And (Uppercase(ExtractFileExt(FZipFileName)) = '.EXE')
        And (FSFXOffset = 0) And Not FileExists(FZipFileName) Then
    Begin
{$IFDEF NO_SFX}
        ShowZipMessage(SF_NOSFXSUPPORT, '');
        exit;
{$ELSE}
        Try
            { This is the first "add" operation following creation of a new
              .EXE archive.  We need to add the SFX code now, before we add
              the files. }
            AutoExeViaAdd := True;
            SFXResult := NewSFXFile(FZipFileName); //1.72x ConvertSFX;
            AutoExeViaAdd := False;
            If SFXResult <> 0 Then
                Raise EZipMaster.CreateResDisk(AD_AutoSFXWrong, SFXResult);
        Except
            On ews: EZipMaster Do       // All SFX creation errors will be caught and returned in this one message.
            Begin
                ShowExceptionError(ews);
                Exit;
            End;
        End;
{$ENDIF}
    End;

    DLLVers := Load_ZipDll(AutoLoad);
    If DLLVers = 0 Then
        exit;                           // could not load valid dll

    fZipBusy := True;
    Cancel := False;

    Try
        Try
            ZipParms := AllocMem(SizeOf(ZipParms2));
            SetZipSwitches(TmpZipName, DLLVers);

            With ZipParms^ Do
            Begin
                If UseStream = 1 Then
                Begin
                    fUseInStream := True;
                    fInStream := FZipStream.Memory;
                    fInStreamSize := FZipStream.Size;
                    fStrFileAttr := StrFileAttr;
                    fStrFileDate := StrFileDate;
                End;
                If UseStream = 2 Then
                Begin
                    fUseOutStream := True;
                    fOutStream := FZipStream.Memory;
                    fOutStreamSize := MemStream.Size + 6;
                    fUseInStream := True;
                    fInStream := MemStream.Memory;
                    fInStreamSize := MemStream.Size;
                End;
                fFDS := AllocMem(SizeOf(FileData) * FFSpecArgs.Count);
                For i := 0 To (fFSpecArgs.Count - 1) Do
                Begin
                    len := Length(FFSpecArgs.Strings[i]);
                    p := 1;
                    pFDS := fFDS;
                    Inc(pFDS, i);

                    // Added to version 1.60L to support recursion and encryption on a FFileSpec basis.
                    // Regardless of what AddRecurseDirs is set to, a '>' will force recursion, and a '|' will stop recursion.
                    pFDS.fRecurse := Word(fRecurse); // Set default
                    If Copy(FFSpecArgs.Strings[i], 1, 1) = '>' Then
                    Begin
                        pFDS.fRecurse := $FFFF;
                        Inc(p);
                    End;
                    If Copy(FFSpecArgs.Strings[i], 1, 1) = '|' Then
                    Begin
                        pFDS.fRecurse := 0;
                        Inc(p);
                    End;

                    // Also it is possible to specify a password after the FFileSpec, separated by a '<'
                    // If there is no other text after the '<' then, an existing password, is temporarily canceled.
                    pFDS.fEncrypt := LongWord(fEncrypt); // Set default
                    If Length(pZipPassword) > 0 Then // v1.60L
                    Begin
                        pFDS.fPassword := StrAlloc(Length(pZipPassword) + 1);
                        StrLCopy(pFDS.fPassword, pZipPassword, Length(pZipPassword));
                    End;
                    b := AnsiPos('<', FFSpecArgs.Strings[i]);
                    If b <> 0 Then
                    Begin               // Found...
                        pFDS.fEncrypt := $FFFF; // the new default, but...
                        StrDispose(pFDS.fPassword);
                        pFDS.fPassword := Nil;
                        If Copy(FFSpecArgs.Strings[i], b + 1, 1) = '' Then
                            pFDS.fEncrypt := 0 // No password, so cancel for this FFspecArg
                        Else
                        Begin
                            pFDS.fPassword := StrAlloc(len - b + 1);
                            StrPLCopy(pFDS.fPassword, Copy(FFSpecArgs.Strings[i], b + 1, len - b), len - b + 1);
                            len := b - 1;
                        End;
                    End;

                    // And to set the RootDir, possibly later with override per FSpecArg v1.70
                    If RootDir <> '' Then
                    Begin
                        rdir := ExpandFileName(fRootDir); // allow relative root
                        RootLen := Length(rdir);
                        pFDS.fRootDir := StrAlloc(RootLen + 1);
                        StrPLCopy(pFDS.fRootDir, rdir, RootLen + 1);
                    End;
                    pFDS.fFileSpec := StrAlloc(len - p + 2);
                    StrPLCopy(pFDS.fFileSpec, Copy(FFSpecArgs.Strings[i], p, len - p + 1), len - p + 2);
                End;
                fSeven := 7;
            End;                        { end with }

            ZipParms.argc := fSpecArgs.Count;
            FEventErr := '';            // added
            { pass in a ptr to parms }
            fSuccessCnt := ZipDLLExec(ZipParms);
            // If Add was successful and we want spanning, copy the
            // temporary file to the destination.
            If (UseStream < 2) And (fSuccessCnt > 0) And
                ((AddDiskSpan In FAddOptions) {Or (AddDiskSpanErase In FAddOptions)}) Then
{$IFDEF NO_SPAN}
                Raise EZipMaster.CreateResDisp(DS_NODISKSPAN, true);
{$ELSE}
            Begin
                // write the temp zipfile to the right target:
                If WriteSpan(TmpZipName, FZipFileName) = 0 Then
                Begin                   // Change the zipfilename when needed 1.52N, 1.60N
                    If FDriveFixed Or (spNoVolumeName In SpanOptions) Then
                        CreateMVFileName(FZipFileName, true);
                End
                Else
                    fSuccessCnt := 0;   // error occurred during write span
                DeleteFile(TmpZipName);
            End;
{$ENDIF}
            If (UseStream = 2) And (FSuccessCnt = 1) Then
                FZipStream.SetSize(ZipParms.fOutStreamSize);
        Except
            ShowZipMessage(GE_FatalZip, '');
        End;
    Finally
        fFSpecArgs.Clear;
        fFSpecArgsExcl.Clear;
        With ZipParms^ Do
        Begin
            { Free the memory for the zipfilename and parameters }
            { we know we had a filename, so we'll dispose it's space }
            StrDispose(pZipFN);
            StrDispose(pZipPassword);
            StrDispose(pSuffix);
            pZipPassword := Nil;        // v1.60L

            StrDispose(fTempPath);
            StrDispose(fArchComment);
            For i := (Argc - 1) Downto 0 Do
            Begin
                pFDS := fFDS;
                Inc(pFDS, i);
                StrDispose(pFDS.fFileSpec);
                StrDispose(pFDS.fPassword); // v1.60L
                StrDispose(pFDS.fRootDir); // v1.60L
            End;
            FreeMem(fFDS);
            For i := (fTotExFileSpecs - 1) Downto 0 Do
            Begin
                pExFiles := fExFiles;
                Inc(pExFiles, i);
                StrDispose(pExFiles.fFileSpec);
            End;
            FreeMem(fExFiles);
        End;
        FreeMem(ZipParms);
        ZipParms := Nil;
    End;                                {end try finally }

    If AutoLoad Then
        Unload_Zip_Dll;

    Cancel := False;
    fZipBusy := False;
    If fSuccessCnt > 0 Then
        _List;                          { Update the Zip Directory by calling List method }
End;

Function TZipMaster.Delete: integer;    // 1.72 new public version
Begin
    Result := BUSY_ERROR;
    If Busy Then
        exit;
    Try
        fBusy := true;
        _Delete;
    Finally
        fBusy := false;
    End;
    Result := fErrCode;
End;

Procedure TZipMaster._Delete;
Var
    i, DLLVers: Integer;
    AutoLoad: Boolean;
    pFDS: pFileData;
    EOC: ZipEndOfCentral;
    pExFiles: pExcludedFileSpec;
Begin
    FSuccessCnt := 0;
    If fFSpecArgs.Count = 0 Then
    Begin
        ShowZipMessage(DL_NothingToDel, '');
        Exit;
    End;
    If Not FileExists(FZipFileName) Then
    Begin
        ShowZipMessage(GE_NoZipSpecified, '');
        Exit;
    End;
    // new 1.7 - stop delete from spanned
    CheckIfLastDisk(EOC, false);        //1.72 true);
    FileClose(fInFileHandle);           // only needed to test it
    If (IsSpanned) Then
        Raise EZipMaster.CreateResDisp(DL_NoDelOnSpan, true);

    { Make sure we can't get back in here while work is going on }
    If fZipBusy Then
        Exit;
    fZipBusy := True;                   { delete uses the ZIPDLL, so it shares the FZipBusy flag }
    Cancel := False;

    If ZipDllHandle = 0 Then
    Begin
        AutoLoad := True;               // user's program didn't load the DLL
        Load_Zip_Dll;                   // load it
    End
    Else
        AutoLoad := False;              // user's pgm did load the DLL, so let him unload it
    If ZipDllHandle = 0 Then
    Begin
        fZipBusy := False;
        Exit;                           // load failed - error msg was shown to user
    End;

    DLLVers := ZipVers;
    If DLLVers < 170 Then
    Begin
        ShowZipMessage(LZ_OldZipDll, GetZipDllPath(ZipDllHandle));
        exit;
    End;
    Try
        Try
            ZipParms := AllocMem(SizeOf(ZipParms2));
            SetZipSwitches(fZipFileName, DLLVers);
            SetDeleteSwitches;

            With ZipParms^ Do
            Begin
                fFDS := AllocMem(SizeOf(FileData) * FFSpecArgs.Count);
                For i := 0 To (fFSpecArgs.Count - 1) Do
                Begin
                    pFDS := fFDS;
                    Inc(pFDS, i);
                    pFDS.fFileSpec := StrAlloc(Length(fFSpecArgs[i]) + 1);
                    StrPLCopy(pFDS.fFileSpec, fFSpecArgs[i], Length(fFSpecArgs[i]) + 1);
                End;
                Argc := fSpecArgs.Count;
                fSeven := 7;
            End;                        { end with }
            { pass in a ptr to parms }
            FEventErr := '';            // added
            fSuccessCnt := ZipDLLExec(ZipParms);
        Except
            ShowZipMessage(GE_FatalZip, '');
        End;
    Finally
        fFSpecArgs.Clear;
        fFSpecArgsExcl.Clear;

        With ZipParms^ Do
        Begin
            StrDispose(pZipFN);
            StrDispose(pZipPassword);
            StrDispose(pSuffix);
            StrDispose(fTempPath);
            StrDispose(fArchComment);
            For i := (Argc - 1) Downto 0 Do
            Begin
                pFDS := fFDS;
                Inc(pFDS, i);
                StrDispose(pFDS.fFileSpec);
            End;
            FreeMem(fFDS);
            For i := (fTotExFileSpecs - 1) Downto 0 Do
            Begin
                pExFiles := fExFiles;
                Inc(pExFiles, i);
                StrDispose(pExFiles.fFileSpec);
            End;
            FreeMem(fExFiles);
        End;
        FreeMem(ZipParms);
        ZipParms := Nil;
    End;

    If AutoLoad Then
        Unload_Zip_Dll;
    fZipBusy := False;
    Cancel := False;
    If fSuccessCnt > 0 Then
        _List;                          { Update the Zip Directory by calling List method }
End;

Constructor TZipStream.Create;
Begin
    Inherited Create;
    Clear();
End;

Destructor TZipStream.Destroy;
Begin
    Inherited Destroy;
End;

Procedure TZipStream.SetPointer(Ptr: Pointer; Size: Integer);
Begin
    Inherited SetPointer(Ptr, Size);
End;

Function TZipMaster.ExtractFileToStream(FileName: String): TZipStream;
Begin
    // Use FileName if set, if not expect the filename in the FFSpecArgs.
    If FileName <> '' Then
    Begin
        FFSpecArgs.Clear();
        FFSpecArgs.Add(FileName);
    End;
    FZipStream.Clear();
    ExtExtract(1, Nil);
    If FSuccessCnt <> 1 Then
        Result := Nil
    Else
        Result := FZipStream;
End;

Function TZipMaster.ExtractStreamToStream(InStream: TMemoryStream; OutSize: Longword): TZipStream;
Begin
    If Busy Then
    Begin
        Result := Nil;
        Exit;
    End;
    If InStream = FZipStream Then
    Begin
        ShowZipMessage(AD_InIsOutStream, '');
        Result := Nil;
        Exit;
    End;
    FZipStream.Clear();
    FZipStream.SetSize(OutSize);
    ExtExtract(2, InStream);
    If FSuccessCnt <> 1 Then
        Result := Nil
    Else
        Result := FZipStream;
End;

Function TZipMaster.Extract: integer;
Begin
    Result := BUSY_ERROR;
    If Busy Then
        exit;
    Try
        fBusy := true;
        ExtExtract(0, Nil);
    Finally
        fBusy := false;
    End;
    Result := fErrCode;
End;

// UseStream = 0 ==> Extract file from zip archive file.
// UseStream = 1 ==> Extract stream from zip archive file.
// UseStream = 2 ==> Extract (zipped) stream from another stream.

Procedure TZipMaster.ExtExtract(UseStream: Integer; MemStream: TMemoryStream);
Var
    i, UnzDLLVers: Integer;
    OldPRC: Integer;
    AutoLoad: Boolean;
    TmpZipName: String;
    pUFDS: pUnzFileData;
{$IFNDEF NO_SPAN}
    NewName: Array[0..512] Of Char;
{$ENDIF}
Begin
    FSuccessCnt := 0;
    FErrCode := 0;
    FMessage := '';
    OldPRC := FPasswordReqCount;

    If (UseStream < 2) Then
    Begin
        If (Not FileExists(FZipFileName)) Then
        Begin
            ShowZipMessage(GE_NoZipSpecified, '');
            Exit;
        End;
        If Count = 0 Then
            _List;                      // try again
        If Count = 0 Then
        Begin
            ShowZipMessage(DS_FileOpen, '');
            exit;
        End;
    End;

    { Make sure we can't get back in here while work is going on }
    If fUnzBusy Then
        Exit;

    // We have to be carefull doing an unattended Extract when a password is needed
    // for some file in the archive.
    If FUnattended And (FPassword = '') And Not Assigned(FOnPasswordError) Then
    Begin
        FPasswordReqCount := 0;
        ShowZipMessage(EX_UnAttPassword, '');
    End;

    Cancel := False;
    fUnzBusy := True;

    // We do a check if we need UnSpanning first, this depends on
    // The number of the disk the EOC record was found on. ( provided by List() )
    // If we have a spanned set consisting of only one disk we don't use ReadSpan().
    If FTotalDisks <> 0 Then
    Begin
{$IFDEF NO_SPAN}
        fUnzBusy := False;
        ShowZipMessage(DS_NODISKSPAN, '');
        exit;
{$ELSE}
        If FTempDir = '' Then
        Begin
            GetTempPath(MAX_PATH, NewName);
            TmpZipName := NewName;
        End
        Else
            TmpZipName := AppendSlash(FTempDir);
        If ReadSpan(FZipFileName, TmpZipName) <> 0 Then
        Begin
            fUnzBusy := False;
            {            if AutoLoad then
                Unload_Unz_Dll(); }
            Exit;
        End;
        // We returned without an error, now  TmpZipName contains a real name.
{$ENDIF}
    End
    Else
        TmpZipName := FZipFileName;

    UnzDLLVers := Load_UnzDll(AutoLoad);
    If UnzDllVers = 0 Then
    Begin
        FUnzBusy := false;
        exit;                           // could not load valid DLL
    End;
    Try
        Try
            UnZipParms := AllocMem(SizeOf(UnZipParms2));
            SetUnZipSwitches(TmpZipName, UnzDLLVers);

            With UnzipParms^ Do
            Begin
                If ExtrBaseDir <> '' Then
                Begin
                    fExtractDir := StrAlloc(Length(fExtrBaseDir) + 1);
                    StrPLCopy(fExtractDir, fExtrBaseDir, Length(fExtrBaseDir));
                End
                Else
                    fExtractDir := Nil;

                fUFDS := AllocMem(SizeOf(UnzFileData) * FFSpecArgs.Count);
                // 1.70 added test - speeds up extract all
                If (fFSpecArgs.Count <> 0) And (fFSpecArgs[0] <> '*.*') Then
                Begin
                    For i := 0 To (fFSpecArgs.Count - 1) Do
                    Begin
                        pUFDS := fUFDS;
                        Inc(pUFDS, i);
                        pUFDS.fFileSpec := StrAlloc(Length(fFSpecArgs[i]) + 1);
                        StrPLCopy(pUFDS.fFileSpec, fFSpecArgs[i], Length(fFSpecArgs[i]) + 1);
                    End;
                    fArgc := FFSpecArgs.Count;
                End
                Else
                    fArgc := 0;
                If UseStream = 1 Then
                Begin
                    For i := 0 To Count - 1 Do { Find the wanted file in the ZipDirEntry list. }
                    Begin
                        With ZipDirEntry(ZipContents[i]^) Do
                        Begin
                            If AnsiStrIComp(pChar(FFSpecArgs.Strings[0]), pChar(FileName)) = 0 Then { Found? }
                            Begin
                                FZipStream.SetSize(UncompressedSize);
                                fUseOutStream := True;
                                fOutStream := FZipStream.Memory;
                                fOutStreamSize := UncompressedSize;
                                fArgc := 1;
                                Break;
                            End;
                        End;
                    End;
                End;
                If UseStream = 2 Then
                Begin
                    fUseInStream := True;
                    fInStream := MemStream.Memory;
                    fInStreamSize := MemStream.Size;
                    fUseOutStream := True;
                    fOutStream := FZipStream.Memory;
                    fOutStreamSize := FZipStream.Size;
                End;
                fSeven := 7;
            End;
            FEventErr := '';            // added
            { Argc is now the no. of filespecs we want extracted }
            If (UseStream = 0) Or ((UseStream > 0) And UnZipParms.fUseOutStream) Then
                fSuccessCnt := UnzDLLExec(Pointer(UnZipParms));
            { Remove from memory if stream is not Ok. }
            If (UseStream > 0) And (FSuccessCnt <> 1) Then
                FZipStream.Clear();
            { If UnSpanned we still have this temporary file hanging around. }
            If FTotalDisks > 0 Then
                DeleteFile(TmpZipName);
        Except
            ShowZipMessage(EX_FatalUnZip, '');
        End;
    Finally
        fFSpecArgs.Clear;
        With UnZipParms^ Do
        Begin
            StrDispose(pZipFN);
            StrDispose(pZipPassword);
            If (fExtractDir <> Nil) Then
                StrDispose(fExtractDir);

            For i := (fArgc - 1) Downto 0 Do
            Begin
                pUFDS := fUFDS;
                Inc(pUFDS, i);
                StrDispose(pUFDS.fFileSpec);
            End;
            FreeMem(fUFDS);
        End;
        FreeMem(UnZipParms);

        UnZipParms := Nil;
    End;

    If FUnattended And (FPassword = '') And Not Assigned(FOnPasswordError) Then
        FPasswordReqCount := OldPRC;

    If AutoLoad Then
        Unload_Unz_Dll;
    Cancel := False;
    fUnzBusy := False;
    { no need to call the List method; contents unchanged }
End;

//---------------------------------------------------------------------------
// Returns 0 if good copy, or a negative error code.

Function TZipMaster.CopyFile(Const InFileName, OutFileName: String): Integer;
Const
    SE_CreateError = -1;                { Error in open or creation of OutFile. }
    SE_OpenReadError = -3;              { Error in open or Seek of InFile.      }
    SE_SetDateError = -4;               { Error setting date/time of OutFile.   }
    SE_GeneralError = -9;
Var
    InFile, OutFile, InSize, OutSize: Integer;
Begin
    InSize := -1;
    OutSize := -1;
    Result := SE_OpenReadError;
    FShowProgress := False;

    If Not FileExists(InFileName) Then
        Exit;
    StartWaitCursor;
    InFile := FileOpen(InFileName, fmOpenRead Or fmShareDenyWrite);
    If InFile <> -1 Then
    Begin
        If FileExists(OutFileName) Then
            EraseFile(OutFileName, FHowToDelete);
        OutFile := FileCreate(OutFileName);
        If OutFile <> -1 Then
        Begin
            Result := CopyBuffer(InFile, OutFile, -1);
            If (Result = 0) And (FileSetDate(OutFile, FileGetDate(InFile)) <> 0) Then
                Result := SE_SetDateError;
            OutSize := FileSeek(OutFile, 0, 2);
            FileClose(OutFile);
        End
        Else
            Result := SE_CreateError;
        InSize := FileSeek(InFile, 0, 2);
        FileClose(InFile);
    End;
    // An extra check if the filesizes are the same.
    If (Result = 0) And ((InSize = -1) Or (OutSize = -1) Or (InSize <> OutSize)) Then
        Result := SE_GeneralError;
    // Don't leave a corrupted outfile lying around. (SetDateError is not fatal!)
    If (Result <> 0) And (Result <> SE_SetDateError) Then
        DeleteFile(OutFileName);

    StopWaitCursor;
End;

{ Delete a file and put it in the recyclebin on demand. }

Function TZipMaster.EraseFile(Const Fname: String; How: DeleteOpts): Integer;
Var
    SHF: TSHFileOpStruct;
    DelFileName: String;
Begin
    // If we do not have a full path then FOF_ALLOWUNDO does not work!?
    DelFileName := Fname;
    If ExtractFilePath(Fname) = '' Then
        DelFileName := GetCurrentDir() + '\' + Fname;

    Result := -1;
    // We need to be able to 'Delete' without getting an error
    // if the file does not exists as in ReadSpan() can occur.
    If Not FileExists(DelFileName) Then
        Exit;
    With SHF Do
    Begin
        Wnd := Application.Handle;
        wFunc := FO_DELETE;
        pFrom := pChar(DelFileName + #0);
        pTo := Nil;
        fFlags := FOF_SILENT Or FOF_NOCONFIRMATION;
        If How = htdAllowUndo Then
            fFlags := fFlags Or FOF_ALLOWUNDO;
    End;
    Result := SHFileOperation(SHF);
End;

// Make a temporary filename like: C:\...\zipxxxx.zip
// Prefix and extension are default: 'zip' and '.zip'

Function TZipMaster.MakeTempFileName(Prefix, Extension: String): String;
Var
    Buffer: pChar;
    len: DWORD;
Begin
    Buffer := Nil;
    If Prefix = '' Then
        Prefix := 'zip';
    If Extension = '' Then
        Extension := '.zip';
    Try
        If Length(FTempDir) = 0 Then    // Get the system temp dir
        Begin
            // 1.	The path specified by the TMP environment variable.
            //	2.	The path specified by the TEMP environment variable, if TMP is not defined.
            //	3.	The current directory, if both TMP and TEMP are not defined.
            len := GetTempPath(0, Buffer);
            GetMem(Buffer, len + 12);
            GetTempPath(len, Buffer);
        End
        Else                            // Use Temp dir provided by ZipMaster
        Begin
            FTempDir := AppendSlash(FTempDir);
            GetMem(Buffer, Length(FTempDir) + 13);
            StrPLCopy(Buffer, FTempDir, Length(FTempDir) + 1);
        End;
        If GetTempFileName(Buffer, pChar(Prefix), 0, Buffer) <> 0 Then
        Begin
            DeleteFile(Buffer);         // Needed because GetTempFileName creates the file also.
            Result := ChangeFileExt(Buffer, Extension); // And finally change the extension.
        End;
    Finally
        FreeMem(Buffer);
    End;
End;

Function TZipMaster.CopyBuffer(InFile, OutFile, ReadLen: Integer): Integer;
Const
    SE_CopyError = -2;                  // Write error or no memory during copy.
Var
    SizeR, ToRead: Integer;
    Buffer: pBuffer;
Begin
    // both files are already open
    Result := 0;
    ToRead := BufSize;
    Buffer := Nil;
    Try
        New(Buffer);
        Repeat
            If ReadLen >= 0 Then
            Begin
                ToRead := ReadLen;
                If BufSize < ReadLen Then
                    ToRead := BufSize;
            End;
            SizeR := FileRead(InFile, Buffer^, ToRead);
            If FileWrite(OutFile, Buffer^, SizeR) <> SizeR Then
            Begin
                Result := SE_CopyError;
                Break;
            End;
            If Assigned(FOnProgress) And FShowProgress Then
                FOnProgress(Self, ProgressUpdate, '', SizeR);
            If ReadLen > 0 Then
                Dec(ReadLen, SizeR);
            If ForegroundTask Then
                Application.ProcessMessages; // Mostly for winsock.
        Until ((ReadLen = 0) Or (SizeR <> ToRead));
    Except
        Result := SE_CopyError;
    End;
    If Buffer <> Nil Then
        Dispose(Buffer);
    // leave both files open
End;

//---------------------------------------------------------------------------
// Function to find the EOC record at the end of the archive (on the last disk.)
// We can get a return value( true::Found, false::Not Found ) or an exception if not found.

Function TZipMaster.CheckIfLastDisk(Var EOC: ZipEndOfCentral; DoExcept: boolean): boolean;
Var
    Sig: Cardinal;
    DiskNo, Size, i, j: Integer;
    ShowGarbageMsg: Boolean;
    First: Boolean;
    ZipBuf: pChar;
Begin
    FZipComment := '';
    First := False;
    //    DiskNo := 0;
    ZipBuf := Nil;
    FZipEOC := 0;

    // Open the input archive, presumably the last disk.
    FInFileHandle := FileOpen(FInFileName, fmShareDenyWrite Or fmOpenRead);
    If FInFileHandle = -1 Then
    Begin
        If DoExcept = True Then
            Raise EZipMaster.CreateResDisp(DS_NoInFile, True);
        ShowZipMessage(DS_FileOpen, '');
        Result := False;
        Exit;
    End;

    // Get the volume number if it's disk from a set. - 1.72 moved
    If Pos('PKBACK# ', FVolumeName) = 1 Then
        DiskNo := StrToIntDef(Copy(FVolumeName, 9, 3), 0)
    Else
    Begin
        If spCompatName In FSpanOptions Then
            DiskNo := StrToIntDef(copy(ExtractFileExt(FInFileName), 2, 2), 0)
        Else
            DiskNo := StrToIntDef(Copy(FInFileName, length(FInFileName)
                - length(ExtractFileExt(FInFileName)) - 3 + 1, 3), 0);
    End;

    // First a check for the first disk of a spanned archive,
    // could also be the last so we don't issue a warning yet.
    If (FileRead(FInFileHandle, Sig, 4) = 4) And (Sig = ExtLocalSig) And
        (FileRead(FInFileHandle, Sig, 4) = 4) And (Sig = LocalFileHeaderSig) Then
    Begin
        First := True;
        FIsSpanned := True;
    End;

    // Next we do a check at the end of the file to speed things up if
    // there isn't a Zip archive comment.
    FFileSize := FileSeek(FInFileHandle, -SizeOf(EOC), 2);
    If FFileSize <> -1 Then
    Begin
        Inc(FFileSize, SizeOf(EOC));    // Save the archive size as a side effect.
        FRealFileSize := FFileSize;     // There could follow a correction on FFileSize.
        If (FileRead(FInFileHandle, EOC, SizeOf(EOC)) = SizeOf(EOC)) And
            (EOC.HeaderSig = EndCentralDirSig) Then
        Begin
            FZipEOC := FFileSize - SizeOf(EOC);
            Result := True;
            Exit;
        End;
    End;

    // Now we try to find the EOC record within the last 65535 + sizeof( EOC ) bytes
    // of this file because we don't know the Zip archive comment length at this time.
    Try
        Size := 65535 + SizeOf(EOC);
        If FFileSize < Size Then
            Size := FFileSize;
        GetMem(ZipBuf, Size + 1);
        If FileSeek(FInFileHandle, -Size, 2) = -1 Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
        If Not (FileRead(FInFileHandle, ZipBuf^, Size) = Size) Then
            Raise EZipMaster.CreateResDisp(DS_EOCBadRead, True);
        For i := Size - SizeOf(EOC) - 1 Downto 0 Do
            If (ZipBuf[i] = 'P') And (ZipBuf[i + 1] = 'K') And (ZipBuf[i + 2] = #$05) And (ZipBuf[i + 3] = #$06) Then
            Begin
                FZipEOC := FFileSize - Size + i;
                Move(ZipBuf[i], EOC, SizeOf(EOC)); // Copy from our buffer to the EOC record.
                // Check if we really are at the end of the file, if not correct the filesize
                // and give a warning. (It should be an error but we are nice.)
                If Not (i + SizeOf(EOC) + EOC.ZipCommentLen - Size = 0) Then
                Begin
                    Inc(FFileSize, i + SizeOf(EOC) + Integer(EOC.ZipCommentLen) - Size);
                    // Now we need a check for WinZip Self Extractor which makes SFX files which
                    // allmost always have garbage at the end (Zero filled at 512 byte boundary!)
                    // In this special case 'we' don't give a warning.
                    ShowGarbageMsg := True;
                    If (FRealFileSize - Cardinal(FFileSize) < 512) And ((FRealFileSize Mod 512) = 0) Then
                    Begin
                        j := i + SizeOf(EOC) + EOC.ZipCommentLen;
                        While (ZipBuf[j] = #0) And (j <= Size) Do
                            Inc(j);
                        If j = Size + 1 Then
                            ShowGarbageMsg := False;
                    End;
                    If ShowGarbageMsg Then
                        ShowZipMessage(LI_GarbageAtEOF, '');
                End;
                // If we have ZipComment: Save it, must be after Garbage check because a #0 is set!
                If Not (EOC.ZipCommentLen = 0) Then
                Begin
                    ZipBuf[i + SizeOf(EOC) + EOC.ZipCommentLen] := #0;
                    FZipComment := ZipBuf + i + SizeOf(EOC); // No codepage translation yet, wait for CEH read.
                End;
                FreeMem(ZipBuf);
                Result := True;
                Exit;
            End;
        FreeMem(ZipBuf);
    Except
        FreeMem(ZipBuf);
        If DoExcept = True Then
            Raise;
    End;
    If DoExcept = True Then
    Begin
        If (Not First) And (DiskNo <> 0) Then
            Raise EZipMaster.CreateResDisk(DS_NotLastInSet, DiskNo);
        If First = True Then
            If DiskNo = 1 Then
                Raise EZipMaster.CreateResDisp(DS_FirstInSet, True)
            Else
                Raise EZipMaster.CreateResDisp(DS_FirstFileOnHD, True)
        Else
            Raise EZipMaster.CreateResDisp(DS_NoValidZip, True);
    End;
    Result := False;
End;

// concat path

Function PathConcat(path, extra: String): String;
Var
    pathLst: char; pathLen: integer;
Begin
    pathLen := Length(path);
    Result := path;
    If pathLen > 0 Then
    Begin
        pathLst := path[pathLen];
        If (pathLst <> ':') And (Length(extra) > 0) Then
        Begin
            If (extra[1] = '\') = (pathLst = '\') Then
            Begin
                If pathLst = '\' Then
                    Result := Copy(path, 1, pathLen - 1) // remove trailing
                Else
                    Result := path + '\'; // append trailing
            End;
        End;
    End;
    Result := Result + extra;
End;

// returns version - checks valid

Function TZipMaster.Load_ZipDll(Var autoload: boolean): integer; // New 1.70
Begin
    autoload := false;
    If ZipDllHandle = 0 Then
    Begin
        Result := Load_Zip_Dll;
        autoload := Result <> 0;
    End
    Else
        Result := GetZipDllVersion;
    If Result = 0 Then
        exit;
    If Result < FMinZipDllVer Then
    Begin
        ShowZipMessage(LZ_OldZipDll, GetZipDllPath(ZipDllHandle));
        Unload_Zip_Dll;
        Result := 0;
        autoload := false;
    End
    Else
        If Verbose Then
            CallBack(4, 0, pChar('Loaded ZipDll ver: ' + IntToStr(Result)
                + ' from ' + GetZipDllPath(ZipDllHandle)), 0, Nil);
    {		if FVerbose and Assigned(FOnMessage) then
       FOnMessage(Self, 0, 'Loaded ZipDll ver: ' + IntToStr(Result)
        + ' from ' + GetZipDllPath(ZipDllHandle));   }
End;

Function TZipMaster.Load_Zip_Dll: integer; // CHANGED 1.70
Var
    fullpath: String;
Begin
    // This is new code that tries to locate the DLL before loading it.
    // The user can specify a dir in the DLLDirectory property.
    // The user's dir is our first choice, but we'll still try the
    // standard Windows DLL dirs (Windows, Windows System, Current dir).
    Result := 0;                        // dll version
    fullpath := '';
    If FDLLDirectory <> '' Then
    Begin
        fullpath := PathConcat(FDLLDirectory, '\ZIPDLL.DLL');
        If Not FileExists(fullpath) Then
        Begin
            fullpath := PathConcat(ExtractFilePath(ParamStr(0)), fullpath);
            If (copy(FDLLDirectory, 1, 1) <> '.') Or Not FileExists(fullpath) Then
                fullpath := '';
        End;
    End;
    If fullpath = '' Then
        fullpath := 'ZIPDLL.DLL';       // Let Windows search the std dirs

    SetErrorMode(SEM_FAILCRITICALERRORS Or SEM_NOGPFAULTERRORBOX);
    Try
        ZipDllHandle := LoadLibrary(pChar(fullpath));
        If ZipDllHandle > HInstance_Error Then
        Begin
            If FTrace Then
                ShowZipMessage(LZ_ZipDllLoaded, ' ' + GetZipDllPath(ZipDllHandle));
            @ZipDllExec := GetProcAddress(ZipDllHandle, 'ZipDllExec');
            @GetZipDllVersion := GetProcAddress(ZipDllHandle, 'GetZipDllVersion');
            If @ZipDllExec = Nil Then
                ShowZipMessage(LZ_NoZipDllExec, '');
            If @GetZipDllVersion = Nil Then
                ShowZipMessage(LZ_NoZipDllVers, '');
        End
        Else
        Begin
            ZipDllHandle := 0;          {reset}
            ShowZipMessage(LZ_NoZipDll, '');
        End;
    Except
    End;
    SetErrorMode(0);
    If (ZipDllHandle <> 0) And (@ZipDllExec <> Nil) And (@GetZipDllVersion <> Nil) Then
        Result := GetZipDllVersion;
    If Result = 0 Then
    Begin
        Unload_Zip_Dll;
        ShowZipMessage(LZ_NoZipDll, ' unloaded');
    End;
End;

Function TZipMaster.Load_UnzDll(Var autoload: boolean): integer; // New 1.70
Begin
    autoload := false;
    If UnzDllHandle = 0 Then
    Begin
        Result := Load_Unz_Dll;
        autoload := Result <> 0;
    End
    Else
        Result := GetUnzDllVersion;
    If Result = 0 Then
        exit;
    If Result < FMinUnzDllVer Then
    Begin
        ShowZipMessage(LU_OldUnzDll, GetUnzDllPath(UnzDllHandle));
        Unload_Unz_Dll;
        Result := 0;
        autoload := false;
    End
    Else
        If FVerbose And Assigned(FOnMessage) Then
            FOnMessage(Self, 0, 'Loaded UnzDll ver: ' + IntToStr(Result)
                + ' from ' + GetUnzDllPath(UnzDllHandle));
End;

// CHANGED 1.70 - return version if loaded

Function TZipMaster.Load_Unz_Dll: integer;
Var
    fullpath: String;
Begin
    Result := 0;
    // This is new code that tries to locate the DLL before loading it.
    // The user can specify a dir in the DLLDirectory property.
 // The user's dir is our first choice, but we'll still try the
 // standard Windows DLL dirs (Windows, Windows System, Current dir).
    fullpath := '';
    If FDLLDirectory <> '' Then
    Begin
        fullpath := PathConcat(FDLLDirectory, '\UNZDLL.DLL');
        If Not FileExists(fullpath) Then
        Begin
            fullpath := PathConcat(ExtractFilePath(ParamStr(0)), fullpath);
            If (copy(FDLLDirectory, 1, 1) <> '.') Or Not FileExists(fullpath) Then
                fullpath := '';
        End;
    End;
    If fullpath = '' Then
        fullpath := 'UNZDLL.DLL';       // Let Windows search the std dirs

    SetErrorMode(SEM_FAILCRITICALERRORS Or SEM_NOGPFAULTERRORBOX);
    Try
        UnzDllHandle := LoadLibrary(pChar(fullpath));
        If UnzDllHandle > HInstance_Error Then
        Begin
            If FTrace Then
                ShowZipMessage(LU_UnzDllLoaded, ' ' + GetUnzDllPath(UnzDllHandle));
            @UnzDllExec := GetProcAddress(UnzDllHandle, 'UnzDllExec');
            @GetUnzDllVersion := GetProcAddress(UnzDllHandle, 'GetUnzDllVersion');
            If @UnzDllExec = Nil Then
                ShowZipMessage(LU_NoUnzDllExec, '');
            If @GetUnzDllVersion = Nil Then
                ShowZipMessage(LU_NoUnzDllVers, '');
        End
        Else
        Begin
            UnzDllHandle := 0;          {reset}
            ShowZipMessage(LU_NoUnzDll, '');
        End;
    Except
    End;
    SetErrorMode(0);
    If (UnzDllHandle <> 0) And (@UnzDllExec <> Nil) And (@GetUnzDllVersion <> Nil) Then
        Result := GetUnzDllVersion;
    If Result = 0 Then
    Begin
        Unload_Unz_Dll;
        ShowZipMessage(LU_NoUnzDll, ' unloaded');
    End;
End;

Procedure TZipMaster.Unload_Zip_Dll;
Begin
    If ZipDllHandle <> 0 Then
        FreeLibrary(ZipDllHandle);
    ZipDllHandle := 0;
End;

Procedure TZipMaster.Unload_Unz_Dll;
Begin
    If UnzDllHandle <> 0 Then
        FreeLibrary(UnzDllHandle);
    UnzDllHandle := 0;
End;

Function TZipMaster.GetZipDllPath(handle: cardinal): String;
Var
    buf: Array[0..4097] Of char; AutoLoad: boolean;
Begin
    AutoLoad := false;
    If handle = 0 Then                  // load ZipDll
    Begin
        If ZipDllHandle = 0 Then
        Begin
            AutoLoad := True;           // user's program didn't load the DLL
            Load_Zip_Dll;               // load it
        End;
        handle := ZipDllHandle;
    End;
    If handle <> 0 Then
    Begin
        If GetModuleFileName(handle, buf, 4096) <> 0 Then
            Result := buf;
    End;
    If AutoLoad Then
        Unload_Zip_Dll;
End;

// new 1.72

Function TZipMaster.ZipDllPath: String;
Begin
    Result := GetZipDllPath(ZipDllHandle);
End;

Function TZipMaster.UnzDllPath: String;
Begin
    Result := GetUnzDllPath(UnzDllHandle);
End;

Function TZipMaster.GetUnzDllPath(handle: cardinal): String;
Var
    buf: Array[0..4097] Of char; AutoLoad: boolean;
Begin
    AutoLoad := false;
    If handle = 0 Then                  // load UnzDll
    Begin
        If UnzDllHandle = 0 Then
        Begin
            AutoLoad := True;           // user's program didn't load the DLL
            Load_Unz_Dll;               // load it
        End;
        handle := UnzDllHandle;
    End;
    If handle <> 0 Then
    Begin
        If GetModuleFileName(handle, buf, 4096) <> 0 Then
            Result := buf;
    End;
    If AutoLoad Then
        Unload_Unz_Dll;
End;

Function TZipMaster.GetZipVers: Integer;
Begin
    If ZipDllHandle = 0 Then
    Begin
        Result := Load_Zip_Dll;         // load it - get version
        Unload_Zip_Dll;
    End
    Else
        Result := GetZipDLLVersion;
End;

Function TZipMaster.GetUnzVers: Integer;
Begin
    If UnzDllHandle = 0 Then
    Begin
        Result := Load_Unz_Dll;         // load it
        Unload_Unz_Dll;
    End
    Else
        Result := GetUnzDLLVersion;
End;

Procedure TZipMaster.AbortDlls;
Begin
    Cancel := true;
End;


{ Replacement for the functions DiskFree and DiskSize. }
{ This should solve problems with drives > 2Gb and UNC filenames. }
{ Path FDrive ends with a backslash. }
{ Action=1 FreeOnDisk, 2=SizeOfDisk, 3=Both }

Procedure TZipMaster.DiskFreeAndSize(Action: Integer); // RCV150199
Var
    GetDiskFreeSpaceEx: Function(RootName: pChar; Var FreeForCaller, TotNoOfBytes: LargeInt; TotNoOfFreeBytes: pLargeInt): BOOL; stdcall;
    SectorsPCluster, BytesPSector, FreeClusters, TotalClusters: DWORD;
    LDiskFree, LSizeOfDisk: LargeInt;
    Lib: THandle;
Begin
    LDiskFree := -1;
    LSizeOfDisk := -1;
    Lib := GetModuleHandle('Kernel32');
    If Lib <> 0 Then
    Begin
        @GetDiskFreeSpaceEx := GetProcAddress(Lib, 'GetDiskFreeSpaceExA');
        If (@GetDiskFreeSpaceEx <> Nil) Then // We probably have W95+OSR2 or better.
            If Not GetDiskFreeSpaceEx(pChar(FDrive), LDiskFree, LSizeOfDisk, Nil) Then
            Begin
                LDiskFree := -1;
                LSizeOfDisk := -1;
            End;
        FreeLibrary(Lib);               //v1.52i
    End;
    If (LDiskFree = -1) Then            // We have W95 original or W95+OSR1 or an error.
    Begin                               // We use this because DiskFree/Size don't support UNC drive names.
        If GetDiskFreeSpace(pChar(FDrive), SectorsPCluster, BytesPSector, FreeClusters, TotalClusters) Then
        Begin
            LDiskFree := {$IFDEF VERD2D3}(1.0 * BytesPSector)
{$ELSE}LargeInt(BytesPSector){$ENDIF}
            * SectorsPCluster * FreeClusters;
            LSizeOfDisk := {$IFDEF VERD2D3}(1.0 * BytesPSector)
{$ELSE}LargeInt(BytesPSector){$ENDIF}
            * SectorsPCluster * TotalClusters;
        End;
    End;
    If (Action And 1) <> 0 Then
        FFreeOnDisk := LDiskFree;
    If (Action And 2) <> 0 Then
        FSizeOfDisk := LSizeOfDisk;
End;

// Check to see if drive in FDrive is a valid drive.
// If so, put it's volume label in FVolumeName,
//        put it's size in FSizeOfDisk,
//        put it's free space in FDiskFree,
//        and return true.
// If not valid, return false.
// Called by _List() and CheckForDisk().

Function TZipMaster.IsDiskPresent: Boolean;
Var
    SysFlags, OldErrMode: DWord;
    NamLen: Cardinal;
    SysLen: {$IFDEF VERD2D3}Integer{$ELSE}DWord{$ENDIF};
    VolNameAry: Array[0..255] Of Char;
    Num: Integer;
    Bits: Set Of 0..25;
    DriveLetter: Char;
    DiskSerial: integer;
Begin
    NamLen := 255;
    SysLen := 255;
    FSizeOfDisk := 0;
    FDiskFree := 0;
    FVolumeName := '';
    Result := False;
    DriveLetter := UpperCase(FDrive)[1];

    If DriveLetter <> '\' Then          // Only for local drives
    Begin
        If (DriveLetter < 'A') Or (DriveLetter > 'Z') Then
            Raise EZipMaster.CreateResDrive(DS_NotaDrive, FDrive);

        Integer(Bits) := GetLogicalDrives();
        Num := Ord(DriveLetter) - Ord('A');
        If Not (Num In Bits) Then
            Raise EZipMaster.CreateResDrive(DS_DriveNoMount, FDrive);
    End;

    OldErrMode := SetErrorMode(SEM_FAILCRITICALERRORS); // Turn off critical errors:

    // Since v1.52c no exception will be raised here; moved to List() itself.
    If (Not FDriveFixed) And            // 1.72 only get Volume label for removable drives
    {If}(Not GetVolumeInformation(pChar(FDrive), VolNameAry, NamLen, @ {F} DiskSerial, SysLen, SysFlags, Nil, 0)) Then
    Begin
        // W'll get this if there is a disk but it is not or wrong formatted
        // so this disk can only be used when we also want formatting.
        If (GetLastError() = 31) And (AddDiskSpanErase In FAddOptions) Then
            Result := True;
        SetErrorMode(OldErrMode);       //v1.52i
        Exit;
    End;

    FVolumeName := VolNameAry;
    { get free disk space and size. }
    DiskFreeAndSize(3);                 // RCV150199

    SetErrorMode(OldErrMode);           // Restore critical errors:

    // -1 is not very likely to happen since GetVolumeInformation catches errors.
    // But on W95(+OSR1) and a UNC filename w'll get also -1, this would prevent
    // opening the file. !!!Potential error while using spanning with a UNC filename!!!
    If (DriveLetter = '\') Or ((DriveLetter <> '\') And (FSizeOfDisk <> -1)) Then
        Result := True;
End;

Function TZipMaster.AppendSlash(sDir: String): String;
Begin
    If (sDir <> '') And (sDir[Length(sDir)] <> '\') Then
        Result := sDir + '\'
    Else
        Result := sDir;
End;

Function TZipMaster.ReplaceForwardSlash(aStr: String): String;
Var
    i: Integer;
Begin
    SetLength(Result, Length(aStr));
    For i := 1 To Length(aStr) Do
        If aStr[i] = '/' Then
            Result[i] := '\'
        Else
            Result[i] := aStr[i];
End;

//---------------------------------------------------------------------------

Procedure TZipMaster.WriteJoin(Buffer: pChar; BufferSize, DSErrIdent: Integer);
Begin
    If FileWrite(FOutFileHandle, Buffer^, BufferSize) <> BufferSize Then
        Raise EZipMaster.CreateResDisp(DSErrIdent, True);

    // Give some progress info while writing.
    // While processing the central header we don't want messages.
    If Assigned(FOnProgress) And FShowProgress Then
        FOnProgress(Self, ProgressUpdate, '', BufferSize);
End;

//---------------------------------------------------------------------------

// Function to read a Zip archive and change one or more file specifications.
// Source and Destination should be of the same type. (path or file)
// If NewDateTime is 0 then no change is made in the date/time fields.
// Return values:
// 0            All Ok.
// -7           Rename errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown Rename error.
// -10          Dest should also be a filename.

Function TZipMaster.Rename(RenameList: TList; DateTime: Integer): Integer;
Var
    EOC: ZipEndOfCentral;
    CEH: ZipCentralHeader;
    LOH: ZipLocalHeader;
    OrigFileName: String;
    MsgStr: String;
    OutFilePath: String;
    Buffer: Array[0..BufSize - 1] Of Char;
    i, k, m: Integer;
    TotalBytesToRead: Integer;
    TotalBytesWrite: Integer;
    RenRec: pZipRenameRec;
    MDZD: TMZipDataList; MDZDp: pMZipData;
Begin
	Result := BUSY_ERROR;                       // error
    If Busy Then
        exit;
    Result := 0;
    TotalBytesToRead := 0;
    fZipBusy := True;
    FShowProgress := False;

    FInFileName := FZipFileName;
    FInFileHandle := -1;
    MDZD := Nil;

    StartWaitCursor;

    // If we only have a source path make sure the destination is also a path.
    For i := 0 To RenameList.Count - 1 Do
    Begin
        RenRec := RenameList.Items[i];
        RenRec^.Source := ReplaceForwardSlash(RenRec^.Source);
        RenRec^.Dest := ReplaceForwardSlash(RenRec^.Dest);
        If Length(ExtractFileName(RenRec^.Source)) = 0 Then // Assume it's a path.
        Begin                           // Make sure destination is a path also.
            RenRec^.Dest := AppendSlash(ExtractFilePath(RenRec^.Dest));
            RenRec^.Source := AppendSlash(RenRec^.Source);
        End
        Else
            If Length(ExtractFileName(RenRec^.Dest)) = 0 Then
            Begin
                StopWaitCursor;
                fZipBusy := false;
                Result := -10;          // Dest should also be a filename.
                Exit;
            End;
    End;
    Try
        // Check the input file.
        If Not FileExists(FZipFileName) Then
            Raise EZipMaster.CreateResDisp(GE_NoZipSpecified {DS_NoInFile}, True);
        // Make a temporary filename like: C:\...\zipxxxx.zip
        OutFilePath := MakeTempFileName('', '');
        If OutFilePath = '' Then
            Raise EZipMaster.CreateResDisp(DS_NoTempFile, True);

        // Create the output file.
        FOutFileHandle := FileCreate(OutFilePath);
        If FOutFileHandle = -1 Then
            Raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

        // The following function will read the EOC and some other stuff:
        CheckIfLastDisk(EOC, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(FInFileHandle);

        // Now we now the number of zipped entries in the zip archive
        FTotalDisks := EOC.ThisDiskNo;
        If EOC.ThisDiskNo <> 0 Then
            Raise EZipMaster.CreateResDisp(RN_NoRenOnSpan, True);

        // Go to the start of the input file.
        If FileSeek(FInFileHandle, 0, 0) = -1 Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        // Write the SFX header if present.
        If CopyBuffer(FInFileHandle, FOutFileHandle, FSFXOffset) <> 0 Then
            Raise EZipMaster.CreateResDisp(RN_ZipSFXData, True);

        // Go to the start of the Central directory.
        If FileSeek(FInFileHandle, EOC.CentralOffset, 0) = -1 Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        MDZD := TMZipDataList.Create(EOC.TotalEntries);

        // Read for every entry: The central header and save information for later use.
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // Read a central header.
            If FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) Then
                Raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);

            If CEH.HeaderSig <> CentralFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            If FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the file name info in the MDZD structure.
            MDZDp := MDZD[i];
            MDZDp^.FileNameLen := CEH.FileNameLen;
            StrLCopy(MDZDp^.FileName, Buffer, CEH.FileNameLen);
            MDZDp^.RelOffLocal := CEH.RelOffLocal;
            MDZDp^.DateTime := DateTime;

            // We need the total number of bytes we are going to read for the progress event.
            TotalBytesToRead := TotalBytesToRead + Integer(CEH.ComprSize + CEH.FileNameLen + CEH.ExtraLen);

            // Seek past the extra field and the file comment.
            If FileSeek(FInFileHandle, CEH.ExtraLen + CEH.FileComLen, 1) = -1 Then
                Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
        End;

        FShowProgress := True;
        If Assigned(FOnProgress) Then
        Begin
            FOnProgress(Self, TotalFiles2Process, '', EOC.TotalEntries);
            FOnProgress(Self, TotalSize2Process, '', TotalBytesToRead);
        End;

        // Read for every zipped entry: The local header, variable data, fixed data
        // and if present the Data descriptor area.
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // Seek to the first entry.
            MDZDp := MDZD[i];
            FileSeek(FInFileHandle, MDZDp^.RelOffLocal, 0);

            // First the local header.
            While FileRead(FInFileHandle, LOH, SizeOf(LOH)) <> SizeOf(LOH) Do
                Raise EZipMaster.CreateResDisp(DS_LOHBadRead, True);
            If LOH.HeaderSig <> LocalFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_LOHWrongSig, True);

            // Now the filename.
            If FileRead(FInFileHandle, Buffer, LOH.FileNameLen) <> LOH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_LONameLen, True);

            // Set message info on the start of this new fileread because we still have the old filename.
            MsgStr := LoadZipStr(RN_ProcessFile, 'Processing: ') + MDZDp^.FileName;

            // Calculate the bytes we are going to write; we 'forget' the difference
            // between the old and new filespecification.
            TotalBytesWrite := LOH.FileNameLen + LOH.ExtraLen + LOH.ComprSize;

            // Check if the original path and/or filename needs to be changed.
            OrigFileName := ReplaceForwardSlash(MDZDp^.FileName);
            For m := 0 To RenameList.Count - 1 Do
            Begin
                RenRec := RenameList.Items[m];
                k := Pos(UpperCase(RenRec^.Source), UpperCase(OrigFileName));
                If k <> 0 Then
                Begin
                    System.Delete(OrigFileName, k, Length(RenRec^.Source));
                    Insert(RenRec^.Dest, OrigFileName, k);
                    LOH.FileNameLen := Length(OrigFileName);
                    For k := 1 To Length(OrigFileName) Do
                        If OrigFileName[k] = '\' Then
                            OrigFileName[k] := '/';
                    MsgStr := MsgStr + LoadZipStr(RN_RenameTo, ' renamed to: ') + OrigFileName;
                    StrPLCopy(MDZDp^.FileName, OrigFileName, LOH.FileNameLen + 1);
                    MDZDp^.FileNameLen := LOH.FileNameLen;
                    // Change Date and Time if needed.
                    If RenRec^.DateTime <> 0 Then
                        MDZDp^.DateTime := RenRec^.DateTime;
                End;
            End;
            If Assigned(FOnMessage) Then
                OnMessage(Self, 0, MsgStr);

            // Change Date and/or Time if needed.
            If MDZDp^.DateTime <> 0 Then
            Begin
                LOH.ModifDate := HIWORD(MDZDp^.DateTime);
                LOH.ModifTime := LOWORD(MDZDp^.DateTime);
            End;
            // Change info for later while writing the central dir.
            MDZDp^.RelOffLocal := FileSeek(FOutFileHandle, 0, 1);

            If Assigned(FOnProgress) Then
                FOnProgress(Self, NewFile, ReplaceForwardSlash(MDZDp^.FileName), TotalBytesWrite);

            // Write the local header to the destination.
            WriteJoin(@LOH, SizeOf(LOH), DS_LOHBadWrite);

            // Write the filename.
            WriteJoin(MDZDp^.FileName, LOH.FileNameLen, DS_LOHBadWrite);

            // And the extra field
            If CopyBuffer(FInFileHandle, FOutFileHandle, LOH.ExtraLen) <> 0 Then
                Raise EZipMaster.CreateResDisp(DS_LOExtraLen, True);

            // Read and write Zipped data
            If CopyBuffer(FInFileHandle, FOutFileHandle, LOH.ComprSize) <> 0 Then
                Raise EZipMaster.CreateResDisp(DS_ZipData, True);

            // Read DataDescriptor if present.
            If (LOH.Flag And Word(#$0008)) = 8 Then
                If CopyBuffer(FInFileHandle, FOutFileHandle, SizeOf(ZipDataDescriptor)) <> 0 Then
                    Raise EZipMaster.CreateResDisp(DS_DataDesc, True);
        End;                            // Now we have written al entries.

        // Now write the central directory with possibly changed offsets and filename(s).
        FShowProgress := False;
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            MDZDp := MDZD[i];
            // Read a central header which can be span more than one disk.
            If FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) Then
                Raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
            If CEH.HeaderSig <> CentralFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Change Date and/or Time if needed.
            If MDZDp^.DateTime <> 0 Then
            Begin
                CEH.ModifDate := HIWORD(MDZDp^.DateTime);
                CEH.ModifTime := LOWORD(MDZDp^.DateTime);
            End;

            // Now the filename.
            If FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the first Central directory offset for use in EOC record.
            If i = 0 Then
                EOC.CentralOffset := FileSeek(FOutFileHandle, 0, 1);

            // Change the central header info with our saved information.
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            CEH.DiskStart := 0;
            EOC.CentralSize := EOC.CentralSize - CEH.FileNameLen + MDZDp^.FileNameLen;
            CEH.FileNameLen := MDZDp^.FileNameLen;

            // Write this changed central header to disk
            WriteJoin(@CEH, SizeOf(CEH), DS_CEHBadWrite);

            // Write to destination the central filename and the extra field.
            WriteJoin(MDZDp^.FileName, CEH.FileNameLen, DS_CEHBadWrite);

            // And the extra field
            If CopyBuffer(FInFileHandle, FOutFileHandle, CEH.ExtraLen) <> 0 Then
                Raise EZipMaster.CreateResDisp(DS_CEExtraLen, True);

            // And the file comment.
            If CopyBuffer(FInFileHandle, FOutFileHandle, CEH.FileComLen) <> 0 Then
                Raise EZipMaster.CreateResDisp(DS_CECommentLen, True);
        End;
        // Write the changed EndOfCentral directory record.
        EOC.CentralDiskNo := 0;
        EOC.ThisDiskNo := 0;
        WriteJoin(@EOC, SizeOf(EOC), DS_EOCBadWrite);

        // And finally the archive comment
  { ==================== Changed by Jin Turner ===================}
        If (FZipComment <> '')
            And (FileWrite(FOutFileHandle, FZipComment[1], Length(FZipComment)) < 0) Then
            //        if CopyBuffer(FInFileHandle, FOutFileHandle, EOC.ZipCommentLen) <> 0 then
            Raise EZipMaster.CreateResDisp(DS_EOArchComLen, True);
    Except
        On ers: EZipMaster Do           // All Rename specific errors.
        Begin
            ShowExceptionError(ers);
            Result := -7;
        End;
        On EOutOfMemory Do              // All memory allocation errors.
        Begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        End;
        On E: Exception Do
        Begin
            // the error message of an unknown error is displayed ...
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        End;
    End;
    If Assigned(MDZD) Then
        MDZD.Free;

    // Give final progress info at the end.
    If Assigned(FOnProgress) Then
        FOnProgress(Self, EndOfBatch, '', 0);

    If FInFileHandle <> -1 Then
        FileClose(FInFileHandle);
    If FOutFileHandle <> -1 Then
    Begin
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        If Result <> 0 Then             // An error somewhere, OutFile is not reliable.
            DeleteFile(OutFilePath)
        Else
        Begin
            EraseFile(FZipFileName, FHowToDelete);
            RenameFile(OutFilePath, FZipFileName);
            _List;
        End;
    End;

    fZipBusy := False;
    StopWaitCursor;
End;

// Function to copy one or more zipped files from the zip archive to another zip archive
// FSpecArgs in source is used to hold the filename(s) to be copied.
// When this function is ready FSpecArgs contains the file(s) that where not copied.
// Return values:
// 0            All Ok.
// -6           CopyZippedFiles Busy
// -7           CopyZippedFiles errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown CopyZippedFiles error.

Function TZipMaster.CopyZippedFiles(DestZipMaster: TZipMaster; DeleteFromSource: boolean; OverwriteDest: OvrOpts): Integer;
Var
    EOC: ZipEndOfCentral;
    CEH: ZipCentralHeader;
    OutFilePath: String;
    In2FileHandle: Integer;
    Found, Overwrite: Boolean;
    DestMemCount: Integer;
    NotCopiedFiles: TStringList;
    pzd, zde: pZipDirEntry;
    s, d: Integer;
    MDZD: TMZipDataList; MDZDp: pMZipData;
Begin
    If Busy Then
    Begin
		Result := BUSY_ERROR;
        Exit;
    End;
    fZipBusy := True;
    FShowProgress := False;
    NotCopiedFiles := Nil;
    Result := 0;
    In2FileHandle := -1;
    MDZD := Nil;

    StartWaitCursor;
    Try
        // Are source and destination different?
        If (DestZipMaster = self) Or (AnsiStrIComp(pChar(ZipFileName), pChar(DestZipMaster.ZipFileName)) = 0) Then
            Raise EZipMaster.CreateResDisp(CF_SourceIsDest, True);
        // new 1.7 - stop attempt to copy spanned file
        CheckIfLastDisk(EOC, True);
        If (DestZipMaster.IsSpanned Or IsSpanned) Then
            Raise EZipMaster.CreateResDisp(CF_NoCopyOnSpan, True);
        // Now check for every source file if it is in the destination archive and determine what to do.
        // we use the three most significant bits from the Flag field from ZipDirEntry to specify the action
        // None           = 000xxxxx, Destination no change. Action: Copy old Dest to New Dest
        // Add            = 001xxxxx (New).                  Action: Copy Source to New Dest
        // Overwrite      = 010xxxxx (OvrAlways)             Action: Copy Source to New Dest
        // AskToOverwrite = 011xxxxx (OvrConfirm)	Action to perform: Overwrite or NeverOverwrite
        // NeverOverwrite = 100xxxxx (OvrNever)				  Action: Copy old Dest to New Dest
        For s := 0 To FSpecArgs.Count - 1 Do
        Begin
            Found := False;
            For d := 0 To DestZipMaster.Count - 1 Do
            Begin
                zde := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
                If AnsiStrIComp(pChar(FSpecArgs.Strings[s]), pChar(zde^.FileName)) = 0 Then
                Begin
                    Found := True;
                    zde^.Flag := zde^.Flag And $1FFF; // Clear the three upper bits.
                    If OverwriteDest = OvrAlways Then
                        zde^.Flag := zde^.Flag Or $4000
                    Else
                        If OverwriteDest = OvrNever Then
                            zde^.Flag := zde^.Flag Or $8000
                        Else
                            zde^.Flag := zde^.Flag Or $6000;
                    Break;
                End;
            End;
            If Not Found Then
            Begin                       // Add the Filename to the list and set flag
                New(zde);
                DestZipMaster.ZipContents.Add(zde);
                zde^.FileName := FSpecArgs.Strings[s];
                zde^.FileNameLength := Length(FSpecArgs.Strings[s]);
                zde^.Flag := zde^.Flag Or $2000; // (a new entry)
                zde^.ExtraData := Nil;  // Needed when deleting zde
            End;
        End;
        // Make a temporary filename like: C:\...\zipxxxx.zip for the new destination
        OutFilePath := MakeTempFileName('', '');
        If OutFilePath = '' Then
            Raise EZipMaster.CreateResDisp(DS_NoTempFile, True);

        // Create the output file.
        FOutFileHandle := FileCreate(OutFilePath);
        If FOutFileHandle = -1 Then
            Raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

        // The following function a.o. open the input file no. 1.
        CheckIfLastDisk(EOC, True);

        // Open the second input archive, i.e. the original destination.
        In2FileHandle := FileOpen(DestZipMaster.ZipFileName, fmShareDenyWrite Or fmOpenRead);
        If In2FileHAndle = -1 Then
            Raise EZipMaster.CreateResDisp(CF_DestFileNoOpen, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(In2FileHandle);

        // Write the SFX header if present.
        If CopyBuffer(In2FileHandle, FOutFileHandle, DestZipMaster.SFXOffset) <> 0 Then
            Raise EZipMaster.CreateResDisp(CF_SFXCopyError, True);

        NotCopiedFiles := TStringList.Create();
        // Now walk trough the destination, copying and replacing
        DestMemCount := DestZipMaster.ZipContents.Count;

        MDZD := TMZipDataList.Create(DestMemCount);

        // Copy the local data and save central header info for later use.
        For d := 0 To DestMemCount - 1 Do
        Begin
            zde := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
            If (zde^.Flag And $E000) = $6000 Then // Ask first if we may overwrite.
            Begin
                Overwrite := False;
                // Do we have a event assigned for this then don't ask.
                If Assigned(FOnCopyZipOverwrite) Then
                    FOnCopyZipOverwrite(DestZipMaster, zde^.FileName, Overwrite)
                Else
                    If MessageBox(Handle, pChar(Format(LoadZipStr(CF_OverwriteYN, 'Overwrite %s in %s ?'), [zde^.FileName, DestZipMaster.ZipFileName])),
                        pChar(Application.Title), MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2) = IDYES Then
                        Overwrite := True;
                zde^.Flag := zde^.Flag And $1FFF; // Clear the three upper bits.
                If Overwrite Then
                    zde^.Flag := zde^.Flag Or $4000
                Else
                    zde^.Flag := zde^.Flag Or $8000;
            End;
            // Change info for later while writing the central dir in new Dest.
            MDZDp := MDZD[d];
            MDZDp^.RelOffLocal := FileSeek(FOutFileHandle, 0, 1);

            If (zde^.Flag And $6000) = $0000 Then // Copy from original dest to new dest.
            Begin
                // Set the file pointer to the start of the local header.
                FileSeek(In2FileHandle, zde^.RelOffLocalHdr, 0);
                If CopyBuffer(In2FileHandle, FOutFileHandle, SizeOf(ZipLocalHeader) + zde^.FileNameLength + zde^.ExtraFieldLength + zde^.CompressedSize) <> 0 Then
                    Raise EZipMaster.CreateResFile(CF_CopyFailed, DestZipMaster.ZipFileName, DestZipMaster.ZipFileName);
                If zde^.Flag And $8000 <> 0 Then
                Begin
                    NotCopiedFiles.Add(zde^.FileName);
                    // Delete also from FSpecArgs, should not be deleted from source later.
                    FSpecArgs.Delete(FSpecArgs.IndexOf(zde^.FileName));
                End;
            End
            Else
            Begin                       // Copy from source to new dest.
                // Find the filename in the source archive and position the file pointer.
                For s := 0 To Count - 1 Do
                Begin
                    pzd := pZipDirEntry(ZipContents.Items[s]);
                    If AnsiStrIComp(pChar(pzd^.FileName), pChar(zde^.FileName)) = 0 Then
                    Begin
                        FileSeek(FInFileHandle, pzd^.RelOffLocalHdr, 0);
                        If CopyBuffer(FInFileHandle, FOutFileHandle, SizeOf(ZipLocalHeader) + pzd^.FileNameLength + pzd^.ExtraFieldLength + pzd^.CompressedSize) <> 0 Then
                            Raise EZipMaster.CreateResFile(CF_CopyFailed, ZipFileName, DestZipMaster.ZipFileName);
                        Break;
                    End;
                End;
            End;
            // Save the file name info in the MDZD structure.
            MDZDp^.FileNameLen := zde^.FileNameLength;
            StrPLCopy(MDZDp^.FileName, zde^.FileName, zde^.FileNameLength);
        End;                            // Now we have written al entries.

        // Now write the central directory with possibly changed offsets.
        // Remember the EOC we are going to use is from the wrong input file!
        EOC.CentralSize := 0;
        For d := 0 To DestMemCount - 1 Do
        Begin
            zde := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
            pzd := Nil;
            Found := False;
            // Rebuild the CEH structure.
            If (zde^.Flag And $6000) = $0000 Then // Copy from original dest to new dest.
            Begin
                pzd := pZipDirEntry(DestZipMaster.ZipContents.Items[d]);
                Found := True;
            End
            Else                        // Copy from source to new dest.
            Begin
                // Find the filename in the source archive and position the file pointer.
                For s := 0 To Count - 1 Do
                Begin
                    pzd := pZipDirEntry(ZipContents.Items[s]);
                    If AnsiStrIComp(pChar(pzd^.FileName), pChar(zde^.FileName)) = 0 Then
                    Begin
                        Found := True;
                        Break;
                    End;
                End;
            End;
            If Not Found Then
                Raise EZipMaster.CreateResFile(CF_SourceNotFound, zde^.FileName, ZipFileName);
            CopyMemory(@CEH.VersionMadeBy0, pzd, SizeOf(ZipCentralHeader) - 4);
            CEH.HeaderSig := CentralFileHeaderSig;
            CEH.Flag := CEH.Flag And $1FFF;
            MDZDp := MDZD[d];
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            // Save the first Central directory offset for use in EOC record.
            If d = 0 Then
                EOC.CentralOffset := FileSeek(FOutFileHandle, 0, 1);
            EOC.CentralSize := EOC.CentralSize + SizeOf(CEH) + CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen;

            // Write this changed central header to disk
            WriteJoin(@CEH, SizeOf(CEH), DS_CEHBadWrite);

            // Write to destination the central filename.
            WriteJoin(MDZDp^.FileName, CEH.FileNameLen, DS_CEHBadWrite);

            // And the extra field from zde or pzd.
            If CEH.ExtraLen <> 0 Then
                WriteJoin(pzd^.ExtraData, CEH.ExtraLen, DS_CEExtraLen);

            // And the file comment.
            If CEH.FileComLen <> 0 Then
                WriteJoin(pChar(pzd^.FileComment), CEH.FileComLen, DS_CECommentLen);
        End;
        EOC.CentralEntries := DestMemCount;
        EOC.TotalEntries := EOC.CentralEntries;
        EOC.ZipCommentLen := Length(DestZipMaster.ZipComment);

        // Write the changed EndOfCentral directory record.
        WriteJoin(@EOC, SizeOf(EOC), DS_EOCBadWrite);

        // And finally the archive comment
        FileSeek(In2FileHandle, DestZipMaster.ZipEOC + SizeOf(EOC), 0);
        If CopyBuffer(In2FileHandle, FOutFileHandle, Length(DestZipMaster.ZipComment)) <> 0 Then
            Raise EZipMaster.CreateResDisp(DS_EOArchComLen, True);

        If FInFileHandle <> -1 Then
            FileClose(FInFileHandle);
        // Now delete all copied files from the source when deletion is wanted.
        If DeleteFromSource And (FSpecArgs.Count > 0) Then
        Begin
            fZipBusy := False;
            Delete();                   // Delete files specified in FSpecArgs and update the contents.
        End;
        FSpecArgs.Assign(NotCopiedFiles); // Info for the caller.
    Except
        On ers: EZipMaster Do           // All CopyZippedFiles specific errors..
        Begin
            ShowExceptionError(ers);
            Result := -7;
        End;
        On EOutOfMemory Do              // All memory allocation errors.
        Begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        End;
        On E: Exception Do
        Begin
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        End;
    End;

    If Assigned(MDZD) Then
        MDZD.Free;
    NotCopiedFiles.Free;

    If In2FileHandle <> -1 Then
        FileClose(In2FileHandle);
    If FOutFileHandle <> -1 Then
    Begin
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        If Result <> 0 Then             // An error somewhere, OutFile is not reliable.
            DeleteFile(OutFilePath)
        Else
        Begin
            EraseFile(DestZipMaster.FZipFileName, DestZipMaster.HowToDelete);
            If Not RenameFile(OutFilePath, DestZipMaster.FZipFileName) Then
                EraseFile(OutFilePath, DestZipMaster.HowToDelete);
        End;
    End;
    DestZipMaster.List;                 // Update the old(possibly some entries were added temporarily) or new destination.
    StopWaitCursor;
    fZipBusy := False;
End;

Function TZipMaster.GetDirEntry(idx: integer): ZipDirEntry;
Begin
    Result := pZipDirEntry(ZipContents.Items[idx])^;
End;

Function FileVersion(fname: String): String;
Var
    siz: Integer; buf, value: pChar; hndl: DWORD;
Begin
    Result := '?.?.?.?';
    siz := GetFileVersionInfoSize(PChar(fname), hndl);
    If siz > 0 Then
    Begin
        buf := AllocMem(siz);
        Try
            GetFileVersionInfo(PChar(fname), 0, siz, buf);
            If VerQueryValue(buf, pChar('StringFileInfo\040904E4\FileVersion')
                , pointer(value), hndl) Then
                Result := value
            Else
                If VerQueryValue(buf, pChar('StringFileInfo\040904B0\FileVersion')
                    , pointer(value), hndl) Then
                    Result := value;
        Finally
            FreeMem(buf);
        End;
    End;
End;

Function TZipMaster.FullVersionString: String;
Begin
    Result := 'ZipMaster ' + ZIPMASTERBUILD + ' '
{$IFDEF NO_SPAN}
    + ' -SPAN '
{$ELSE}
{$ENDIF}
{$IFDEF NO_SFX}
    + ' ,SFX- ';
{$ELSE}
    + ' ,SFX = ';
{$IFDEF OLDSTYLE}
    If assigned(fAutoSFXSlave) Then
		Result := Result + ' [' + fAutoSFXSlave.VersionString + ']'
    Else
		Result := Result + ' []';
{$ENDIF}
    If assigned(fSFX) Then
        Result := Result + ' ' + fSFX.VersionString;
{$ENDIF}
    If ZipDllHandle <> 0 Then
    Begin
        Result := Result + ', ZipDll ' + FileVersion(GetZipDllPath(ZipDllHandle));
    End;
    If UnzDllHandle <> 0 Then
        Result := Result + ', UnzDll ' + FileVersion(GetUnzDllPath(UnzDllHandle));
End;

Procedure TZipMaster.SetMinZipDllVers(Value: integer); // New 1.70
Begin
    If Value >= Min_ZipDll_Vers Then
        fMinZipDllVer := Value;
End;

Procedure TZipMaster.SetMinUnzDllVers(Value: integer); // New 1.70
Begin
    If Value >= Min_UnzDll_Vers Then
        fMinUnzDllVer := Value;
End;
//================================================================================
// The default exception constructor used.

Constructor EZipMaster.CreateResDisp(Const Ident: Integer; Const Display: Boolean);
Begin
    Inherited CreateRes(Ident);

    If Message = '' Then
        Message := RESOURCE_ERROR + IntToStr(Ident);
    FDisplayMsg := Display;
    FResIdent := Ident;
End;

Constructor EZipMaster.CreateResDisk(Const Ident: Integer; Const DiskNo: Integer);
Begin
    Inherited CreateRes(Ident);

    If Message = '' Then
        Message := LoadZipMsg(Ident)    //RESOURCE_ERROR + IntToStr(Ident)
    Else
        Message := Format(Message, [DiskNo]);
    FDisplayMsg := True;
    FResIdent := Ident;
End;

Constructor EZipMaster.CreateResDrive(Const Ident: Integer; Const Drive: String);
Begin
    Inherited CreateRes(Ident);

    If Message = '' Then
        Message := LoadZipMsg(Ident)    //RESOURCE_ERROR + IntToStr(Ident)
    Else
        Message := Format(Message, [Drive]);
    FDisplayMsg := True;
    FResIdent := Ident;
End;

Constructor EZipMaster.CreateResFile(Const Ident: Integer; Const File1, File2: String);
Begin
    Inherited CreateRes(Ident);

    If Message = '' Then
        Message := LoadZipMsg(Ident)    //RESOURCE_ERROR + IntToStr(Ident)
    Else
        Message := Format(Message, [File1, File2]);
    FDisplayMsg := True;
    FResIdent := Ident;
End;

// ================================================================================
{$IFDEF NO_SPAN}

Procedure TZipMaster.GetNewDisk(DiskSeq: Integer);
Begin
    Raise EZipMaster.CreateResDisp(DS_NODISKSPAN, True);
End;
{$ELSE}
Procedure TZipMaster.GetNewDisk(DiskSeq: Integer);
Begin
    //    drt := DRIVE_REMOVABLE;
    FileClose(FInFileHandle);           // Close the file on the old disk first.
    FDiskNr := DiskSeq;
    Repeat
        If FInFileHandle = -1 Then
        Begin
            If FDriveFixed Then
                Raise EZipMaster.CreateResDisp(DS_NoInFile, True)
            Else
                ShowZipMessage(DS_NoInFile, '');
            { This prevents and endless loop if for some reason spanned parts
            on harddisk are missing.}
        End;
        Repeat
            FNewDisk := True;
            CheckForDisk(false);
        Until IsRightDisk;

        // Open the the input archive on this disk.
        FInFileHandle := FileOpen(FInFileName, fmShareDenyWrite Or fmOpenRead);
    Until Not (FInFileHandle = -1);
End;

//---------------------------------------------------------------------------
// Function to read a split up Zip source file from multiple disks and write it to one destination file.
// Return values:
// 0            All Ok.
// -7           ReadSpan errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown ReadSpan error.

Function TZipMaster.ReadSpan(InFileName: String; Var OutFilePath: String): Integer;
Var
    Buffer: Array[0..BufSize - 1] Of Char;
    TotalBytesToRead: Integer;
    EOC: ZipEndOfCentral;
    LOH: ZipLocalHeader;
    DD: ZipDataDescriptor;
    CEH: ZipCentralHeader;
    i, k: Integer;
    ExtendedSig: Integer;
    MsgStr: String;
    TotalBytesWrite: Integer;
    MDZD: TMZipDataList;
    MDZDp: pMZipData;
Begin          {
	If Busy Then
	Begin
		Result := -9;
		exit;
	End;      }
    Result := 0;
    TotalBytesToRead := 0;

    fUnzBusy := True;
    FDrive := ExtractFileDrive(InFileName) + '\';
    FDriveFixed := IsFixedDrive(FDrive); // 1.72
    FDiskNr := -1;
    FNewDisk := False;
    FShowProgress := False;
    FInFileName := InFileName;
    FInFileHandle := -1;
    MDZD := Nil;

    StartWaitCursor;
    Try
        // If we don't have a filename we make one first.
        If ExtractFileName(OutFilePath) = '' Then
        Begin
            OutFilePath := MakeTempFileName('', '');
            If OutFilePath = '' Then
                Raise EZipMaster.CreateResDisp(DS_NoTempFile, True);
        End
        Else
        Begin
            EraseFile(OutFilePath, FHowToDelete);
            OutFilePath := ChangeFileExt(OutFilePath, '.zip');
        End;

        // 1.72
        IsDiskPresent;                  // get details
        If FDriveFixed Or (spNoVolumeName In SpanOptions) Then
            CheckIfLastDisk(EOC, true)  // exception if not
        Else
        Begin
            // Try to get the last disk from the user.
            FNewDisk := false;
            While Not CheckIfLastDisk(EOC, false) Do
            Begin
                CheckForDisk(false);
                FNewDisk := True;
            End;
        End;

        // Create the output file.
        FOutFileHandle := FileCreate(OutFilePath);
        If FOutFileHandle = -1 Then
            Raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(FInFileHandle);

        // Now we now the number of zipped entries in the zip archive
        // and the starting disk number of the central directory.
        FTotalDisks := EOC.ThisDiskNo;
        If EOC.ThisDiskNo <> EOC.CentralDiskNo Then
            GetNewDisk(EOC.CentralDiskNo); // request a previous disk first
        // We go to the start of the Central directory. v1.52i
        If FileSeek(FInFileHandle, EOC.CentralOffset, 0) = -1 Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        MDZD := TMZipDataList.Create(EOC.TotalEntries);

        // Read for every entry: The central header and save information for later use.
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // Read a central header.
            While FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) Do //v1.52i
            Begin
                // It's possible that we have the central header split up
                If FDiskNr >= EOC.ThisDiskNo Then
                    Raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
                // We need the next disk with central header info.
                GetNewDisk(FDiskNr + 1);
            End;

            If CEH.HeaderSig <> CentralFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            If FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the file name info in the MDZD structure.
            MDZDp := MDZD[i];
            MDZDp^.FileNameLen := CEH.FileNameLen;
            StrLCopy(MDZDp^.FileName, Buffer, CEH.FileNameLen);

            // Save the compressed size, we need this because WinZip sometimes sets this to
            // zero in the local header. New v1.52d
            MDZDp^.ComprSize := CEH.ComprSize;

            // We need the total number of bytes we are going to read for the progress event.
            TotalBytesToRead := TotalBytesToRead + Integer(CEH.ComprSize + CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen);

            // Seek past the extra field and the file comment.
            If FileSeek(FInFileHandle, CEH.ExtraLen + CEH.FileComLen, 1) = -1 Then
                Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);
        End;

        // Now we need the first disk and start reading.
        GetNewDisk(0);

        FShowProgress := True;
        //		CallBack(
        If Assigned(FOnProgress) Then
        Begin
            FOnProgress(Self, TotalFiles2Process, '', EOC.TotalEntries);
            FOnProgress(Self, TotalSize2Process, '', TotalBytesToRead);
        End;

        // Read extended local Sig. first; is only present if it's a spanned archive.
        If FileRead(FInFileHandle, ExtendedSig, 4) <> 4 Then
            Raise EZipMaster.CreateResDisp(DS_ExtWrongSig, True);
        If ExtendedSig <> ExtLocalSig Then
            Raise EZipMaster.CreateResDisp(DS_ExtWrongSig, True);

        // Read for every zipped entry: The local header, variable data, fixed data
        // and if present the Data decriptor area.
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // First the local header.
            While FileRead(FInFileHandle, LOH, SizeOf(LOH)) <> SizeOf(LOH) Do
            Begin
                // Check if we are at the end of a input disk not very likely but...
                If FileSeek(FInFileHandle, 0, 1) <> FileSeek(FInFileHandle, 0, 2) Then
                    Raise EZipMaster.CreateResDisp(DS_LOHBadRead, True);
                // Well it seems we are at the end, so get a next disk.
                GetNewDisk(FDiskNr + 1);
            End;
            If LOH.HeaderSig <> LocalFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_LOHWrongSig, True);

            // Now the filename, should be on the same disk as the LOH record.
            If FileRead(FInFileHandle, Buffer, LOH.FileNameLen) <> LOH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_LONameLen, True);

            // Change some info for later while writing the central dir.
            k := MDZD.IndexOf(MakeString(Buffer, LOH.FileNameLen));
            MDZDp := MDZD[k];
            MDZDp^.DiskStart := 0;
            MDZDp^.RelOffLocal := FileSeek(FOutFileHandle, 0, 1);

            // Give message and progress info on the start of this new file read.
            MsgStr := LoadZipStr(GE_CopyFile, 'Copying: ') + ReplaceForwardSlash(MDZDp^.FileName);
            If Assigned(FOnMessage) Then
                OnMessage(Self, 0, MsgStr);

            TotalBytesWrite := SizeOf(LOH) + LOH.FileNameLen + LOH.ExtraLen + LOH.ComprSize;
            If (LOH.Flag And Word(#$0008)) = 8 Then
                Inc(TotalBytesWrite, SizeOf(DD));
            If Assigned(FOnProgress) Then
                FOnProgress(Self, NewFile, ReplaceForwardSlash(MDZDp^.FileName), TotalBytesWrite);

            // Write the local header to the destination.
            WriteJoin(@LOH, SizeOf(LOH), DS_LOHBadWrite);

            // Write the filename.
            WriteJoin(Buffer, LOH.FileNameLen, DS_LOHBadWrite);

            // And the extra field
            RWJoinData(Buffer, LOH.ExtraLen, DS_LOExtraLen);

            // Read Zipped data, if the size is not known use the size from the central header.
            If LOH.ComprSize = 0 Then
                LOH.ComprSize := MDZDp^.ComprSize; // New v1.52d
            RWJoinData(Buffer, LOH.ComprSize, DS_ZipData);

            // Read DataDescriptor if present.
            If (LOH.Flag And Word(#$0008)) = 8 Then
                RWJoinData(@DD, SizeOf(DD), DS_DataDesc);
        End;                            // Now we have written al entries to the (hard)disk.

        // Now write the central directory with changed offsets.
        FShowProgress := False;
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // Read a central header which can be span more than one disk.
            While FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) Do
            Begin
                // Check if we are at the end of a input disk.
                If FileSeek(FInFileHandle, 0, 1) <> FileSeek(FInFileHandle, 0, 2) Then
                    Raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
                // Well it seems we are at the end, so get a next disk.
                GetNewDisk(FDiskNr + 1);
            End;
            If CEH.HeaderSig <> CentralFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            If FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Save the first Central directory offset for use in EOC record.
            If i = 0 Then
                EOC.CentralOffset := FileSeek(FOutFileHandle, 0, 1);

            // Change the central header info with our saved information.
            //			k := FindZipEntry(EOC.TotalEntries, MakeString(Buffer, CEH.FileNameLen));
            k := MDZD.IndexOf(MakeString(Buffer, CEH.FileNameLen));
            MDZDp := MDZD[k];
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            CEH.DiskStart := 0;

            // Write this changed central header to disk
            // and make sure it fit's on one and the same disk.
            WriteJoin(@CEH, SizeOf(CEH), DS_CEHBadWrite);

            // Write to destination the central filename and the extra field.
            WriteJoin(Buffer, CEH.FileNameLen, DS_CEHBadWrite);

            // And the extra field
            RWJoinData(Buffer, CEH.ExtraLen, DS_CEExtraLen);

            // And the file comment.
            RWJoinData(Buffer, CEH.FileComLen, DS_CECommentLen);
        End;

        // Write the changed EndOfCentral directory record.
        EOC.CentralDiskNo := 0;
        EOC.ThisDiskNo := 0;
        WriteJoin(@EOC, SizeOf(EOC), DS_EOCBadWrite);

        // Skip past the original EOC to get to the ZipComment if present. v1.52M
        If (FileSeek(FInFileHandle, SizeOf(EOC), 1) = -1) Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        // And finally the archive comment
        RWJoinData(Buffer, EOC.ZipCommentLen, DS_EOArchComLen);
    Except
        On ers: EZipMaster Do           // All ReadSpan specific errors.
        Begin
            ShowExceptionError(ers);
            Result := -7;
        End;
        On EOutOfMemory Do              // All memory allocation errors.
        Begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        End;
        On E: Exception Do
        Begin
            // The remaining errors, should not occur.
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        End;
    End;

    // Give final progress info at the end.
    If Assigned(FOnProgress) Then
        FOnProgress(Self, EndOfBatch, '', 0);

    If Assigned(MDZD) Then
        MDZD.Free;

    If FInFileHandle <> -1 Then
        FileClose(FInFileHandle);
    If FOutFileHandle <> -1 Then
    Begin
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        If Result <> 0 Then             // An error somewhere, OutFile is not reliable.
        Begin
            DeleteFile(OutFilePath);
            OutFilePath := '';
        End;
    End;

    fUnzBusy := False;
    StopWaitCursor;
End;

// 1.70 changed - no longer check fZipBusy
// 1.72 changed - now a procedure

Procedure TZipMaster.CheckForDisk(writing: bool);
Var
    Res, MsgFlag: Integer;
    SizeOfDisk: LargeInt;               // RCV150199
    MsgStr: String;
    AbortAction: Boolean;
Begin
    FDriveFixed := IsFixedDrive(FDrive);
    If FDriveFixed Then
    Begin                               // If it is a fixed disk we don't want a new one.
        FNewDisk := False;
        exit;
    End;
    If ForegroundTask Then
        Application.ProcessMessages;

    Res := IDOK;
    MsgFlag := MB_OKCANCEL;

    // First check if we want a new one or if there is a disk (still) present.
    While (((Res = IDOK) And Not IsDiskPresent) Or FNewDisk) Do
    Begin
        If FUnattended Then
            Raise EZipMaster.CreateResDisp(DS_NoUnattSpan, True);
        If FDiskNr < 0 Then             // -1=ReadSpan(), 0=WriteSpan()
        Begin
            MsgStr := LoadZipStr(DS_InsertDisk, 'Please insert last disk in set');
            MsgFlag := MsgFlag Or MB_ICONERROR;
        End
        Else
        Begin
            If writing Then             // Are we from ReadSpan() or WriteSpan()?
            Begin
                // This is an estimate, we can't know if every future disk has the same space available and
                // if there is no disk present we can't determine the size unless it's set by MaxVolumeSize.
                SizeOfDisk := FSizeOfDisk - FFreeOnAllDisks;
                If (FMaxVolumeSize <> 0) And (FMaxVolumeSize < FSizeOfDisk) Then
                    SizeOfDisk := FMaxVolumeSize;

                FTotalDisks := FDiskNr;
                If (SizeOfDisk > 0) And (FTotalDisks < Trunc((FFileSize + 4 + FFreeOnDisk1) / SizeOfDisk)) Then // RCV150199
                    FTotalDisks := Trunc((FFileSize + 4 + FFreeOnDisk1) / SizeOfDisk);
                If SizeOfDisk > 0 Then
                    MsgStr := Format(LoadZipStr(DS_InsertVolume, 'Please insert disk volume %.1d of %.1d'), [FDiskNr + 1, FTotalDisks + 1])
                Else
                    MsgStr := Format(LoadZipStr(DS_InsertAVolume, 'Please insert disk volume %.1d'), [FDiskNr + 1]);
            End
            Else
                MsgStr := Format(LoadZipStr(DS_InsertVolume, 'Please insert disk volume %.1d of %.1d'), [FDiskNr + 1, FTotalDisks + 1]);
        End;
        MsgStr := MsgStr + Format(LoadZipStr(DS_InDrive, #13#10'in drive: %s'), [FDrive]);

        If Assigned(FOnGetNextDisk) Then // v1.60L
        Begin
            AbortAction := False;
            FOnGetNextDisk(self, FDiskNr + 1, FTotalDisks + 1, Copy(FDrive, 1, 1), AbortAction);
            If AbortAction Then
                Res := IDABORT
            Else
                Res := IDOK;
        End
        Else
            Res := MessageBox(Handle, pChar(MsgStr), pChar(Application.Title), MsgFlag);
        FNewDisk := False;
    End;

    // Check if user pressed Cancel or memory is running out.
    If Res <> IDOK Then
        Raise EZipMaster.CreateResDisp(DS_Canceled, False);
    If Res = 0 Then
        Raise EZipMaster.CreateResDisp(DS_NoMem, True);
End;

//---------------------------------------------------------------------------
// 1.72 changed

Function TZipMaster.IsRightDisk: Boolean;
Begin
    Result := true;
    If (Not FDriveFixed) And (FVolumeName = 'PKBACK# ' + copy(IntToStr(1001 + FDiskNr), 2, 3)) Then
        exit;

    CreateMVFileName(FInFileName, true);
    If Not FDriveFixed Then
        Result := FileExists(FInFileName);
End;

//---------------------------------------------------------------------------
// Read data from the input file with a maximum of 8192(BufSize) bytes per read
// and write this to the output file.
// In case of an error an Exception is raised and this will
// be caught in WriteSpan.

Procedure TZipMaster.RWSplitData(Buffer: pChar; ReadLen, ZSErrVal: Integer);
Var
    SizeR, ToRead: Integer;
Begin
    While ReadLen > 0 Do
    Begin
        ToRead := BufSize;
        If ReadLen < BufSize Then
            ToRead := ReadLen;
        SizeR := FileRead(FInFileHandle, Buffer^, ToRead);
        If SizeR <> ToRead Then
            Raise EZipMaster.CreateResDisp(ZSErrVal, True);
        WriteSplit(Buffer, SizeR, 0);
        Dec(ReadLen, SizeR);
    End;
End;

//---------------------------------------------------------------------------

Procedure TZipMaster.RWJoinData(Buffer: pChar; ReadLen, DSErrIdent: Integer);
Var
    ToRead, SizeR: Integer;
Begin
    While ReadLen > 0 Do
    Begin
        ToRead := BufSize;
        If ReadLen < BufSize Then
            ToRead := ReadLen;
        SizeR := FileRead(FInFileHandle, Buffer^, ToRead);
        If SizeR <> ToRead Then
        Begin
            // Check if we are at the end of a input disk.
            If FileSeek(FInFileHandle, 0, 1) <> FileSeek(FInFileHandle, 0, 2) Then
                Raise EZipMaster.CreateResDisp(DSErrIdent, True);
            // It seems we are at the end, so get a next disk.
            GetNewDisk(FDiskNr + 1);
        End;
        If SizeR > 0 Then               // Fix by Scott Schmidt v1.52n
        Begin
            WriteJoin(Buffer, SizeR, DSErrIdent);
            Dec(ReadLen, SizeR);
        End;
    End;
End;

//---------------------------------------------------------------------------
//  Format floppy disk

Procedure TZipMaster.ClearFloppy(dir: String);
Var
    SRec: TSearchRec; Name: String;
Begin
    If FindFirst(Dir + '*.*', faAnyFile, SRec) = 0 Then
        Repeat
            name := Dir + SRec.Name;
            If ((SRec.Attr And faDirectory) <> 0) And (SRec.Name <> '.') And (SRec.Name <> '..') Then
            Begin
                Name := Name + '\';
                ClearFloppy(Name);
                TraceMessage('EraseFloopy - Removing ' + Name);
                If ForegroundTask Then
                    Application.ProcessMessages; //allow time for OS to delete last file
                RemoveDir(Name);
            End
            Else
            Begin
                TraceMessage('EraseFloopy - Deleting ' + Name);
                DeleteFile(Name);
            End;
        Until FindNext(SRec) <> 0;
    FindClose(SRec);
End;

Function FormatFloppy(WND: HWND; Drive: String): integer;
Const
    SHFMT_ID_DEFAULT = $FFFF;
    {options}
    SHFMT_OPT_FULL = $0001;
    SHFMT_OPT_SYSONLY = $0002;
    {return values}
    SHFMT_ERROR = $FFFFFFFF;            // -1 Error on last format, drive may be formatable
    SHFMT_CANCEL = $FFFFFFFE;           // -2 last format cancelled
    SHFMT_NOFORMAT = $FFFFFFFD;         // -3 drive is not formatable
Type
    TSHFormatDrive = Function(WND: HWND; Drive, fmtID, Options: DWORD): DWORD; stdcall;
Const
    SHFormatDrive: TSHFormatDrive = Nil;
Var
    drv: integer; hLib: THandle; OldErrMode: integer;
Begin
    result := -3;                       // error
    If Not ((Length(Drive) > 1) And (Drive[2] = ':') And (Upcase(Drive[1]) In ['A'..'Z'])) Then
        exit;
    If GetDriveType(pChar(Drive)) <> DRIVE_REMOVABLE Then
        exit;
    drv := ord(Upcase(Drive[1])) - ord('A');
    OldErrMode := SetErrorMode(SEM_FAILCRITICALERRORS Or SEM_NOGPFAULTERRORBOX);
    hLib := LoadLibrary('Shell32');
    If hLib <> 0 Then
    Begin
        @SHFormatDrive := GetProcAddress(hLib, 'SHFormatDrive');
        If @SHFormatDrive <> Nil Then
        Try
            Result := SHFormatDrive(WND, drv, SHFMT_ID_DEFAULT, SHFMT_OPT_FULL);
        Finally
            FreeLibrary(hLib);
        End;
        SetErrorMode(OldErrMode);
    End;
End;

//---------------------------------------------------------------------------

Function TZipMaster.ZipFormat: Integer;
Var
    Vol: String; Res {, drt}: Integer;
Begin
    Result := -3;
    If (spTryFormat In SpanOptions) And Not FDriveFixed Then
        //	if FormatErase then
        Result := FormatFloppy(Application.Handle, FDrive);
    If Result = -3 Then
    Begin
        Res := MessageBox(Handle, pChar('Erase ' + FDrive), pChar('Confirm')
            , MB_YESNO Or MB_DEFBUTTON2 Or MB_ICONWARNING);
        If Res <> IDYES Then
        Begin
            Result := -2;               // cancel
            Exit;
        End;
        ClearFloppy(FDrive);
        Result := 0;
    End;
    If Length(FVolumeName) > 11 Then
        Vol := Copy(FVolumeName, 1, 11)
    Else
        Vol := FVolumeName;
    If (Result = 0) And Not (spNoVolumeName In SpanOptions) Then // did it
        SetVolumeLabel(pChar(FDrive), pChar(Vol));
End;

//---------------------------------------------------------------------------
// Function to read a Zip source file and write it back to one or more disks.
// Return values:
//  0           All Ok.
// -7           WriteSpan errors. See ZipMsgXX.rc
// -8           Memory allocation error.
// -9           General unknown WriteSpan error.

Function TZipMaster.WriteSpan(InFileName, OutFileName: String): Integer;
Var
    LOH: ZipLocalHeader;
    DD: ZipDataDescriptor;
    CEH: ZipCentralHeader;
    EOC: ZipEndOfCentral;
    i, k: Integer;
    TmpStr, t, MsgStr: String;
    TotalBytesWrite: Integer;
    StartCentral: Integer;
    CentralOffset: Integer;
    Buffer: Array[0..BufSize - 1] Of Char;
    MDZD: TMZipDataList; MDZDp: pMZipData;
Begin
    Result := 0;
    fZipBusy := True;
    FDiskNr := 0;
    FFreeOnDisk := 0;
    FNewDisk := True;
    FDiskWritten := 0;
    FTotalDisks := -1;                  // 1.72 don't know number
    FInFileName := InFileName;
    FOutFileName := OutFileName;
    FOutFileHandle := -1;
    FShowProgress := False;
    CentralOffset := 0;
    MDZD := Nil;

    FDrive := ExtractFileDrive(OutFileName) + '\';
    FDriveFixed := IsFixedDrive(FDrive); // 1.72

    If ExtractFileName(OutFileName) = '' Then
        Raise EZipMaster.CreateResDisp(DS_NoOutFile, True);
    If Not FileExists(InFileName) Then
        Raise EZipMaster.CreateResDisp(DS_NoInFile, True);

    StartWaitCursor;
    Try
        // The following function will read the EOC and some other stuff:
        CheckIfLastDisk(EOC, True);

        // Get the date-time stamp and save for later.
        FDateStamp := FileGetDate(FInFileHandle);

        // go back to the start the zip archive.
        If (FileSeek(FInFileHandle, 0, 0) = -1) Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        MDZD := TMZipDataList.Create(EOC.TotalEntries);

        // Write extended local Sig. needed for a spanned archive.
        FInteger := ExtLocalSig;
        WriteSplit(@FInteger, 4, 0);

        // Read for every zipped entry: The local header, variable data, fixed data
    // and, if present, the Data decriptor area.
        FShowProgress := True;
        If Assigned(FOnProgress) Then
        Begin
            FOnProgress(Self, TotalFiles2Process, '', EOC.TotalEntries);
            FOnProgress(Self, TotalSize2Process, '', FFileSize);
        End;

        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // First the local header.
            If Not (FileRead(FInFileHandle, LOH, SizeOf(LOH)) = SizeOf(LOH)) Then
                Raise EZipMaster.CreateResDisp(DS_LOHBadRead, True);
            If Not (LOH.HeaderSig = LocalFileHeaderSig) Then
                Raise EZipMaster.CreateResDisp(DS_LOHWrongSig, True);

            // Now the filename
            If Not (FileRead(FInFileHandle, Buffer, LOH.FileNameLen) = LOH.FileNameLen) Then
                Raise EZipMaster.CreateResDisp(DS_LONameLen, True);

            // Save some information for later. ( on the last disk(s) ).
            MDZDp := MDZD.Items[i];
            MDZDp^.DiskStart := FDiskNr;
            MDZDp^.FileNameLen := LOH.FileNameLen;

            StrLCopy(MDZDp^.FileName, Buffer, LOH.FileNameLen); // like makestring

            // Give message and progress info on the start of this new file read.
            If Assigned(OnMessage) Then
            Begin
                MsgStr := LoadZipStr(GE_CopyFile, 'Copying: ') + ReplaceForwardSlash(MDZDp^.FileName);
                OnMessage(Self, 0, MsgStr);
            End;

            TotalBytesWrite := SizeOf(LOH) + LOH.FileNameLen + LOH.ExtraLen + LOH.ComprSize;
            If (LOH.Flag And Word(#$0008)) = 8 Then
                Inc(TotalBytesWrite, SizeOf(DD));

            If Assigned(FOnProgress) Then
                FOnProgress(Self, NewFile, ReplaceForwardSlash(MDZDp^.FileName), TotalBytesWrite);

            // Write the local header to the destination.
            WriteSplit(@LOH, SizeOf(LOH), SizeOf(LOH) + LOH.FileNameLen + LOH.ExtraLen);

            // Save the offset of the LOH on this disk for later.
            MDZDp^.RelOffLocal := FDiskWritten - SizeOf(LOH);

            // Write the filename.
            WriteSplit(Buffer, LOH.FileNameLen, 0);

            // And the extra field
            RWSplitData(Buffer, LOH.ExtraLen, DS_LOExtraLen);

            // Read Zipped data !!!For now assume we know the size!!!
            RWSplitData(Buffer, LOH.ComprSize, DS_ZipData);

            // Read DataDescriptor if present.
            If (LOH.Flag And Word(#$0008)) = 8 Then
                RWSplitData(@DD, SizeOf(DD), DS_DataDesc);
        End;
        // We have written all entries to disk.
        If Assigned(FOnMessage) Then
            OnMessage(Self, 0, LoadZipStr(GE_CopyFile, 'Copying: ') + LoadZipStr(DS_CopyCentral, 'Central directory'));
        If Assigned(FOnProgress) Then
            FOnProgress(Self, NewFile, LoadZipStr(DS_CopyCentral, 'Central directory'), EOC.CentralSize + SizeOf(EOC) + EOC.ZipCommentLen);

        // Now write the central directory with changed offsets.
        StartCentral := FDiskNr;
        For i := 0 To (EOC.TotalEntries - 1) Do
        Begin
            // Read a central header.
            If FileRead(FInFileHandle, CEH, SizeOf(CEH)) <> SizeOf(CEH) Then
                Raise EZipMaster.CreateResDisp(DS_CEHBadRead, True);
            If CEH.HeaderSig <> CentralFileHeaderSig Then
                Raise EZipMaster.CreateResDisp(DS_CEHWrongSig, True);

            // Now the filename.
            If FileRead(FInFileHandle, Buffer, CEH.FileNameLen) <> CEH.FileNameLen Then
                Raise EZipMaster.CreateResDisp(DS_CENameLen, True);

            // Change the central directory with information stored previously in MDZD.
                  //            k := FindZipEntry(EOC.TotalEntries, MakeString(Buffer, CEH.FileNameLen));
            k := MDZD.IndexOf(MakeString(Buffer, CEH.FileNameLen));
            MDZDp := MDZD[k];
            CEH.DiskStart := MDZDp^.DiskStart;
            CEH.RelOffLocal := MDZDp^.RelOffLocal;
            // Write this changed central header to disk
            // and make sure it fit's on one and the same disk.
            WriteSplit(@CEH, SizeOf(CEH), SizeOf(CEH) + CEH.FileNameLen + CEH.ExtraLen + CEH.FileComLen);

            // Save the first Central directory offset for use in EOC record.
            If i = 0 Then
                CentralOffset := FDiskWritten - SizeOf(CEH);

            // Write to destination the central filename and the extra field.
            WriteSplit(Buffer, CEH.FileNameLen, 0);

            // And the extra field
            RWSplitData(Buffer, CEH.ExtraLen, DS_CEExtraLen);

            // And the file comment.
            RWSplitData(Buffer, CEH.FileComLen, DS_CECommentLen);
        End;

        // Write the changed EndOfCentral directory record.
        EOC.CentralDiskNo := StartCentral;
        EOC.ThisDiskNo := FDiskNr;
        EOC.CentralOffset := CentralOffset;
        WriteSplit(@EOC, SizeOf(EOC), SizeOf(EOC) + EOC.ZipCommentLen);

        // Skip past the original EOC to get to the ZipComment if present. v1.52j
        If (FileSeek(FInFileHandle, SizeOf(EOC), 1) = -1) Then
            Raise EZipMaster.CreateResDisp(DS_FailedSeek, True);

        // And finally the archive comment
        RWSplitData(Buffer, EOC.ZipCommentLen, DS_EOArchComLen);
        FShowProgress := False;
    Except
        On ews: EZipMaster Do           // All WriteSpan specific errors.
        Begin
            ShowExceptionError(ews);
            Result := -7;
        End;
        On EOutOfMemory Do              // All memory allocation errors.
        Begin
            ShowZipMessage(GE_NoMem, '');
            Result := -8;
        End;
        On E: Exception Do
        Begin
            // The remaining errors, should not occur.
            ShowZipMessage(DS_ErrorUnknown, E.Message);
            Result := -9;
        End;
    End;

    StopWaitCursor;
    // Give the last progress info on the end of this file read.
    If Assigned(FOnProgress) Then
        FOnProgress(Self, EndOfBatch, '', 0);

    If Assigned(MDZD) Then
        MDZD.Free;

    FileSetDate(FOutFileHandle, FDateStamp);
    If FOutFileHandle <> -1 Then
        FileClose(FOutFileHandle);
    If FInFileHandle <> -1 Then
        FileClose(FInFileHandle);
    // rename last file
    If (FDriveFixed Or (spNoVolumeName In SpanOptions)) And (spCompatName In SpanOptions) Then
    Begin
        Try
            TmpStr := FOutFileName;
            CreateMVFileName(TmpStr, false);
            i := 0;
            t := '';
            If FileExists(FOutFileName) Then
            Begin
                Repeat
                    inc(i);
                    t := FOutFileName + '.tmp' + IntToHex(Random(5000), 3);
                Until (Not FileExists(t)) Or (i > 20);
            End;
            // Will combine errors and create new resources when checked out
            If i > 0 Then               // only happens when source and dest same
                If Not RenameFile(FOutFileName, t) Then
                    Raise EZipMaster.Create('Could not rename old file');
            If Not RenameFile(TmpStr, FOutFileName) Then
                Raise EZipMaster.Create('Could not rename last file in set');
            If FileExists(t) Then
                If Not DeleteFile(t) Then // remove old
                    Raise EZipMaster.Create('Could not remove old file');
        Except
            On E: Exception Do
            Begin
                // The remaining errors, should not occur.
                ShowZipMessage(DS_ErrorUnknown, E.Message);
                Result := -9;
            End;
        End;
    End;
    FTotalDisks := FDiskNr;
	fZipBusy := False;
End;

Function TZipMaster.MakeString(Buffer: pChar; Size: Integer): String;
Begin
    SetLength(Result, Size);
    StrLCopy(pChar(Result), Buffer, Size);
End;

//---------------------------------------------------------------------------
// This function actually writes the zipped file to the destination while
// taking care of disk changes and disk boundary crossings.
// In case of an write error, or user abort, an exception is raised.

Procedure TZipMaster.WriteSplit(Buffer: pChar; Len: Integer; MinSize: Integer);
Var
    Res, MaxLen: Integer;
    Buf: pChar;                         // Used if Buffer doesn't fit on the present disk.
    DiskSeq: Integer;
    DiskFile, MsgQ: String;
Begin
    Buf := Buffer;
    If ForegroundTask Then
        Application.ProcessMessages;
    If Cancel Then
        Raise EZipMaster.CreateResDisp(DS_Canceled, False);

    While True Do                       // Keep writing until error or buffer is empty.
    Begin
        // Check if we have an output file already opened, if not: create one,
        // do checks, gather info.
        If FOutFileHandle = -1 Then
        Begin
            FDriveFixed := IsFixedDrive(FDrive); // 1.72
            CheckForDisk(true);         // 1.70 changed
            DiskFile := FOutFileName;

            // If we write on a fixed disk the filename must change.
            // We will get something like: FileNamexxx.zip where xxx is 001,002 etc.
            //   or AltSpanNames FileName.zxx where xx is 01,02 etc.
            If FDriveFixed Or (spNoVolumeName In SpanOptions) Then
                CreateMVFileName(DiskFile, false);
            // Allow clearing of removeable media even if no volume names
            If (Not FDriveFixed) And (spWipeFiles In SpanOptions) {(AddDiskSpanErase In FAddOptions)} Then
            Begin
                If (Not Assigned(FOnGetNextDisk))
                    Or (Assigned(FOnGetNextDisk)
                    And (FZipDiskAction = zdaErase)) Then // Added v1.60L
                Begin
                    // Do we want a format first?
                    FDriveNr := Ord(UpperCase(FDrive)[1]) - Ord('A');
                    If (spNoVolumeName In SpanOptions) Then
                        FVolumeName := 'ZipSet_' + IntToStr(succ(FDiskNr)) // default name
                    Else
                        FVolumeName := 'PKBACK# ' + Copy(IntToStr(1001 + FDiskNr), 2, 3);
                    // Ok=6 NoFormat=-3, Cancel=-2, Error=-1
                    Case ZipFormat Of   // Start formating and wait until finished...
                        -1: Raise EZipMaster.CreateResDisp(DS_Canceled, True);
                        -2: Raise EZipMaster.CreateResDisp(DS_Canceled, False);
                    End;
                End;
            End;

            // Do we want to overwrite an existing file?
            If FileExists(DiskFile) Then
            Begin
                If FDriveFixed Or (spNoVolumeName In SpanOptions) Then
                    DiskSeq := FDiskNr + 1
                Else
                    DiskSeq := StrToIntDef(Copy(FVolumeName, 9, 3), 1);
                If Unattended Then
                    Raise EZipMaster.CreateResDisp(DS_NoUnattSpan, True); // we assume we don't.
                FZipDiskStatus := [];   // v1.60L
                // A more specific check if we have a previous disk from this set.
                If (FileAge(DiskFile) = FDateStamp) And (Pred(DiskSeq) < FDiskNr) Then
                Begin
                    MsgQ := Format(LoadZipStr(DS_AskPrevFile, 'Overwrite previous disk no %d'), [DiskSeq]);
                    FZipDiskStatus := FZipDiskStatus + [zdsPreviousDisk]; // v1.60L
                End
                Else
                Begin
                    MsgQ := Format(LoadZipStr(DS_AskDeleteFile, 'Overwrite previous file %s'), [DiskFile]);
                    FZipDiskStatus := FZipDiskStatus + [zdsSameFileName]; // v1.60L
                End;
                If FSizeOfDisk - FFreeOnDisk <> 0 Then // v1.60L
                    FZipDiskStatus := FZipDiskStatus + [zdsHasFiles] // But not the same name
                Else
                    FZipDiskStatus := FZipDiskStatus + [zdsEmpty];
                If Assigned(FOnStatusDisk) Then // v1.60L
                Begin
                    FZipDiskAction := zdaOk; // The default action
                    FOnStatusDisk(Self, DiskSeq, DiskFile, FZipDiskStatus, FZipDiskAction);
                    Case FZipDiskAction Of
                        zdaCancel: Res := IDCANCEL;
                        zdaReject: Res := IDNO;
                        zdaErase: Res := IDOK;
                        zdaOk: Res := IDOK;
                    Else
                        Res := IDOK;
                    End;
                End
                Else
                    Res := MessageBox(Handle, pChar(MsgQ), pChar('Confirm'), MB_YESNOCANCEL Or MB_DEFBUTTON2 Or MB_ICONWARNING);
                If (Res = 0) Or (Res = IDCANCEL) Then
                    Raise EZipMaster.CreateResDisp(DS_Canceled, False);

                If Res = IDNO Then
                Begin                   // we will try again...
                    FDiskWritten := 0;
                    FNewDisk := True;
                    Continue;
                End;
            End;

            // Create the output file.
            FOutFileHandle := FileCreate(DiskFile);
            If FOutFileHandle = -1 Then
                Raise EZipMaster.CreateResDisp(DS_NoOutFile, True);

            // Get the free space on this disk, correct later if neccessary.
            DiskFreeAndSize(1);         // RCV150199

            // Set the maximum number of bytes that can be written to this disk(file).
            // Reserve space on/in all the disk/file.
            FFreeOnDisk := FFreeOnDisk - KeepFreeOnAllDisks;
            // Reserve additional space on/in the first disk/file.
            If FDiskNr = 0 Then
                FFreeOnDisk := FFreeOnDisk - KeepFreeOnDisk1;

            If (MaxVolumeSize > 0) And (MaxVolumeSize < FFreeOnDisk) Then
                FFreeOnDisk := MaxVolumeSize;

            // Do we still have enough free space on this disk.
            If FFreeOnDisk < MinFreeVolumeSize Then // No, too bad...
            Begin
                FileClose(FOutFileHandle);
                DeleteFile(DiskFile);
                FOutFileHandle := -1;
                If FUnattended Then
                    Raise EZipMaster.CreateResDisp(DS_NoUnattSpan, True);
                If Assigned(FOnStatusDisk) Then // v1.60L
                Begin
                    If spNoVolumeName In SpanOptions Then
                        DiskSeq := FDiskNr + 1
                    Else
                        DiskSeq := StrToIntDef(Copy(FVolumeName, 9, 3), 1);
                    FZipDiskAction := zdaOk; // The default action
                    FZipDiskStatus := [zdsNotEnoughSpace];
                    FOnStatusDisk(Self, DiskSeq, DiskFile, FZipDiskStatus, FZipDiskAction);
                    Case FZipDiskAction Of
                        zdaCancel: Res := IDCANCEL;
                        zdaOk: Res := IDRETRY;
                        zdaErase: Res := IDRETRY;
                        zdaReject: Res := IDRETRY;
                    Else
                        Res := IDRETRY;
                    End;
                End
                Else
                Begin
                    MsgQ := LoadZipStr(DS_NoDiskSpace, 'This disk has not enough free space available');
                    Res := MessageBox(Handle, pChar(MsgQ), pChar(Application.Title), MB_RETRYCANCEL Or MB_ICONERROR);
                End;
                If Res = 0 Then
                    Raise EZipMaster.CreateResDisp(DS_NoMem, True);
                If Res <> IDRETRY Then
                    Raise EZipMaster.CreateResDisp(DS_Canceled, False);
                FDiskWritten := 0;
                FNewDisk := True;
                // If all this was on a HD then this would't be useful but...
                Continue;
            End;

            // Set the volume label of this disk if it is not a fixed one.
            If Not (FDriveFixed Or (spNoVolumeName In SpanOptions)) Then
            Begin
                FVolumeName := 'PKBACK# ' + Copy(IntToStr(1001 + FDiskNr), 2, 3);
                If Not SetVolumeLabel(pChar(FDrive), pChar(FVolumeName)) Then
                    Raise EZipMaster.CreateResDisp(DS_NoVolume, True);
            End;
        End;                            // END OF: if FOutFileHandle = -1

        // Check if we have at least MinSize available on this disk,
  // headers are not allowed to cross disk boundaries. ( if zero than don't care.)
        If (MinSize > 0) And (MinSize > FFreeOnDisk) Then
        Begin
            FileSetDate(FOutFileHandle, FDateStamp);
            FileClose(FOutFileHandle);
            FOutFileHandle := -1;
            FDiskWritten := 0;
            FNewDisk := True;
            Inc(FDiskNr);               // RCV270299
            Continue;
        End;

        // Don't try to write more bytes than allowed on this disk.
        MaxLen := {$IFDEF VERD4+}Integer(FFreeOnDisk){$ELSE}Trunc(FFreeOnDisk){$ENDIF}; // RCV150199
        If Len < FFreeOnDisk Then
            MaxLen := Len;
        Res := FileWrite(FOutFileHandle, Buf^, MaxLen);

        // Sleep( 250 );  // This will keep the progress events more synchronised, but it's slower.
        // Give some progress info while writing
        // While processing the central header we don't want messages.
        If Assigned(FOnProgress) And FShowProgress Then
            FOnProgress(Self, ProgressUpdate, '', MaxLen);
        If Res = -1 Then
            Raise EZipMaster.CreateResDisp(DS_NoWrite, True); // A write error (disk removed?)
        Inc(FDiskWritten, Res);
        FFreeOnDisk := FFreeOnDisk - MaxLen; // RCV150199
        If MaxLen = Len Then
            Break;

        // We still have some data left, we need a new disk.
        FileSetDate(FOutFileHandle, FDateStamp);
        FileClose(FOutFileHandle);
        FOutFileHandle := -1;
        FFreeOnDisk := 0;
        FDiskWritten := 0;
        Inc(FDiskNr);
        FNewDisk := True;
        Inc(Buf, MaxLen);
        Dec(Len, MaxLen);
    End;
End;

{$ENDIF}
{$IFNDEF NO_SFX}

{$IFDEF OLDSTYLE}

Function TZipMaster.GetSFXLink: TZipSFXBase; // 1.72x
Begin
    Result := fSFX;
	If not assigned(Result) Then
	begin
		If Not assigned(FAutoSFXSlave) Then
			FAutoSFXSlave := TZipSFXSlave.create(Nil);
		Result := FAutoSFXSlave;
	end;
End;
{$ENDIF}

Constructor TZipSFXBase.Create(Aowner: TComponent);
Begin
    Inherited;
End;

Destructor TZipSFXBase.Destroy;
Begin
    Inherited;
End;

// SFX support

Procedure TZipMaster.SetSFXIcon(aIcon: TIcon);
Begin
	FSFXProps.SFXIcon.Assign(aIcon);      // 1.72.0.4
End;
function  TZipMaster.GetSFXIcon: TIcon;        	// rest added 1.72.0.4
begin
	Result := FSFXProps.SFXIcon;
end;
function  TZipMaster.GetSFXCaption: string; 
begin
	Result := FSFXProps.SFXCaption;
end;
procedure TZipMaster.SetSFXCaption(aString: string);
Begin
	FSFXProps.SFXCaption := aString;
End;
function  TZipMaster.GetSFXCommandLine: String;
begin
	Result := FSFXProps.SFXCommandLine;
end;
procedure TZipMaster.SetSFXCommandLine(aString: string);
Begin
	FSFXProps.SFXCommandLine := aString;
End;
function  TZipMaster.GetSFXDefaultDir: String;
begin
	Result := FSFXProps.SFXDefaultDir;
end;
procedure TZipMaster.SetSFXDefaultDir(aString: string);
Begin
	FSFXProps.SFXDefaultDir := aString;
End;
function  TZipMaster.GetSFXMessage: String;
begin
	Result := FSFXProps.SFXMessage;
end;
procedure TZipMaster.SetSFXMessage(aString: string);
Begin
	FSFXProps.SFXMessage := aString;
End;
function  TZipMaster.GetSFXOptions: SfxOpts;
begin
	Result := FSFXProps.SFXOptions;
end;
procedure TZipMaster.SetSFXOptions(aOpts: SfxOpts);
Begin
	FSFXProps.SFXOptions := aOpts;
End;
function  TZipMaster.GetSFXOverWriteMode: OvrOpts;
begin
	Result := FSFXProps.SFXOverWriteMode;
end;
procedure TZipMaster.SetSFXOverWriteMode(aOpts: OvrOpts);
Begin
	FSFXProps.SFXOverWriteMode := aOpts;
End;
function  TZipMaster.GetSFXPath: String;
begin
	Result := FSFXProps.SFXPath;
end;
procedure  TZipMaster.SetSFXPath(aString: string);
Begin
	FSFXProps.SFXPath := aString;
End;

Function TZipMaster.ConvertSFX: Integer;
Begin
    If assigned(SFXSlave) Then
        Result := SFXSlave.ConvertToSFX(self)
    Else
        Raise EZipMaster.CreateRes(SF_NoSFXSupport);
End;

Function TZipMaster.NewSFXFile(Const ExeName: String): Integer;
Begin
    If assigned(SFXSlave) Then
        Result := SFXSlave.CreateNewSFX(self, ExeName)
    Else
        Raise EZipMaster.CreateRes(SF_NoSFXSupport);
End;

{ Convert an .EXE archive to a .ZIP archive. }
{ returns 0 if good, or else a negative error code }

Function TZipMaster.ConvertZIP: Integer;
Begin
    If assigned(SFXSlave) Then
        Result := SFXSlave.ConvertToZip(self)
    Else
        Raise EZipMaster.CreateRes(SF_NoSFXSupport);
End;

{* Return value:
 0 = The specified file is not a SFX
 1 = It is one
 -7  = Open, read or seek error
 -8  = memory error
 -9  = exception error
 -10 = all other exceptions
*}

Function TZipMaster.IsZipSFX(Const SFXExeName: String): Integer;
Begin
	If assigned(SFXSlave) Then
		Result := SFXSlave.IsZipSFX(self, SFXExeName)
	Else
		Raise EZipMaster.CreateRes(SF_NoSFXSupport);
End;

{$ENDIF}

Procedure Register;
Begin
    RegisterComponents('Delphi Zip', [TZipMaster]);
End;
End.

