{ ZIPDLL.PAS   - Delphi translation of file "wizzip.h" by Eric W. Engler }
{ Import Unit for ZIPDLL - put this into the "uses" clause of any
  other unit that wants to access the DLL. }

{ I changed this to use dynamic loading of the DLL in order to allow
  the user program to control when to load and unload the DLLs.
  Thanks to these people for sending me dynamic loading code:
     Ewart Nijburg, Nijsoft@Compuserve.com
     P.A. Gillioz,  pag.aria@rhone.ch
}

unit ZIPDLL;

{$INCLUDE ZipVers.inc}

interface

uses Windows, Dialogs, ZCallBck;

{$IFDEF VERD2D3}
type
    LongWord = Cardinal;
    {$ENDIF}

type
    FileData = packed record
        fFileSpec: pChar;
        fFileComment: pChar;            // NEW z->comment and z->com
        fFileAltName: pChar;            // NEW
        fPassword: pChar;               // NEW, Override in v1.60L
        fEncrypt: LongWord;             // NEW, Override in v1.60L
        fRecurse: Word;                 // NEW, Override in v1.60L
        fNoRecurseFiles: Word;          // NEW, Override
        fDateUsed: LongBool;            // NEW, Override
        fDate: array[0..7] of Char;     // NEW, Override
        fRootDir: pChar;                // NEW RootDir support for relative paths in v1.60L.
        fNotUsed: array[0..15] of Cardinal; // NEW
    end;
type
    pFileData = ^FileData;

type
    ExcludedFileSpec = packed record
        fFileSpec: pChar;
    end;
type
    pExcludedFileSpec = ^ExcludedFileSpec;

type
    ZipParms2 = packed record
        Handle: HWND;
        Caller: Pointer;
        Version: LongInt;
        ZCallbackFunc: ZFunctionPtrType;
        fTraceEnabled: LongBool;
        pZipPassword: pChar;
        pSuffix: pChar;
        fEncrypt: LongBool;
        fSystem: LongBool;
        fVolume: LongBool;
        fExtra: LongBool;
        fNoDirEntries: LongBool;
        fDate: LongBool;
        fVerboseEnabled: LongBool;
        fQuiet: LongBool;
        fLevel: LongInt;
        fComprSpecial: LongBool;
        fCRLF_LF: LongBool;
        fJunkDir: LongBool;
        fRecurse: WordBool;
        fNoRecurseFiles: Word;
        fGrow: LongBool;
        fForce: LongBool;
        fMove: LongBool;
        fDeleteEntries: LongBool;
        fUpdate: LongBool;
        fFreshen: LongBool;
        fJunkSFX: LongBool;
        fLatestTime: LongBool;
        Date: array[0..7] of Char;
        Argc: LongInt;
        pZipFN: pChar;
        // After this point the record is different from ZipParms1 structure.
        fTempPath: pChar;               // NEW TempDir v1.5
        fArchComment: pChar;            // NEW ZipComment v1.6
        fArchiveFilesOnly: SmallInt;    // NEW when != 0 only zip when archive bit set
        fResetArchiveBit: SmallInt;     // NEW when != 0 reset the archive bit after a successfull zip
        fFDS: pFileData;                // pointer to Array of FileData
        fForceWin: LongBool;            // NEW
        fTotExFileSpecs: LongInt;       // NEW Number of ExcludedFileSpec structures.
        fExFiles: pExcludedFileSpec;    // NEW Array of file specs to exclude from zipping.
        fUseOutStream: LongBool;        // NEW component v160M, dll v1.6015 Use memory stream as output.
        fOutStream: Pointer;            // NEW component v160M, dll v1.6015 Pointer to the start of the output stream data.
        fOutStreamSize: LongWord;       // NEW component v160M, dll v1.6015 Size of the Output data.
        fUseInStream: LongBool;         // NEW component v160M, dll v1.6015 Use memory stream as input.
        fInStream: Pointer;             // NEW component v160M, dll v1.6015 Pointer to the start of the input stream data.
        fInStreamSize: LongWord;        // NEW component v160M, dll v1.6015 Size of the input data.
        fStrFileAttr: DWORD;            // NEW component v160M, dll v1.6015 File attributes of the file stream.
        fStrFileDate: DWORD;            // NEW component v160M, dll v1.6015 File date/time to set for the streamed file.
        fHowToMove: LongBool;
        fWantedCodePage: SmallInt;
        fNotUsed0: SmallInt;
        fNotUsed: array[0..3] of Cardinal;
        fSeven: Integer;                // End of record (eg. 7)
    end;

type
    pZipParms = ^ZipParms2;

    ZipOpt = (ZipAdd, ZipDelete);
    { NOTE: Freshen, Update, and Move are only variations of Add }

implementation

end.

