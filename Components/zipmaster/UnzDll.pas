{ UNZDLL.PAS   - Delphi v2 translation of file "wizunzip.h" by Eric W. Engler }
{ Import Unit for UNZDLL - put this into the "uses" clause of any
  other unit that wants to access the UNZDLL. }

{ I changed this to use dynamic loading of the DLL in order to allow
  the user program to control when to load and unload the DLLs.
  Thanks to these people for sending me dynamic loading code:
     Ewart Nijburg, Nijsoft@Compuserve.com
     P.A. Gillioz,  pag.aria@rhone.ch
}

unit UNZDLL;

interface

uses Windows, Dialogs, ZCallBck;

{ These records are very critical.  Any changes in the order of items, the
  size of items, or modifying the number of items, may have disasterous
 results.  You have been warned! }

type
    UnzFileData = packed record
        fFileSpec: pChar;
        fFileAltName: pChar;
        fPassword: pChar;
        fNotUsed: array[0..14] of Cardinal;
    end;
    pUnzFileData = ^UnzFileData;

type
    UnzExFileData = packed record
        fFileSpec: pChar;
        fNotUsed: array[0..2] of Cardinal;
    end;
    pUnzExFileData = ^UnzExFileData;

type
    UnZipParms2 = packed record
        Handle: HWND;
        Caller: Pointer;
        Version: LongInt;
        ZCallbackFunc: ZFunctionPtrType;
        fTraceEnabled: LongBool;
        fPromptToOverwrite: LongBool;
        pZipPassword: pChar;
        fTest: LongBool;
        fComments: LongBool;
        fConvert: LongBool;
        fQuiet: LongBool;
        fVerboseEnabled: LongBool;
        fUpdate: LongBool;
        fFreshen: LongBool;
        fDirectories: LongBool;
        fOverwrite: LongBool;
        fArgc: LongInt;
        pZipFN: pChar;
        { After this point the record is different from UnZipParms1 }
        { Pointer to an Array of UnzFileData records,
          the last pointer MUST be nil! The UnzDll requires this! }
        fUFDS: pUnzFileData;
        { Pointer to an Array of ExUnzFileData records }
        fXUFDS: pUnzExFileData;
        fUseOutStream: LongBool;        // NEW Use Memory stream as output.
        fOutStream: Pointer;            // NEW Pointer to the start of streaam data.
        fOutStreamSize: LongInt;        // NEW Size of the output data.
        fUseInStream: LongBool;         // NEW Use memory stream as input.
        fInStream: Pointer;             // NEW Pointer to the start of the input stream data.
        fInStreamSize: LongInt;         // NEW Size of the input data.
        fPwdReqCount: Cardinal;         // NEW PasswordRequestCount, How many times a password will be asked per file
        fExtractDir: pChar;
        fNotUsed: array[0..7] of Cardinal;
        fSeven: LongInt;
    end;
    pUnZipParms = ^UnZipParms2;

implementation

end.

