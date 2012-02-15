unit ZipMsg;

interface

const
    BaseOffset = 10000;

    GE_FatalZip = BaseOffset + 101;
    GE_NoZipSpecified = BaseOffset + 102;
    GE_NoMem = BaseOffset + 103;
    GE_WrongPassword = BaseOffset + 104;
    GE_CopyFile = BaseOffset + 105;

    RN_ZipSFXData = BaseOffset + 140;              // new v1.6    Rename
    RN_NoRenOnSpan = BaseOffset + 141;             // new v1.6    Rename
    RN_ProcessFile = BaseOffset + 142;             // new v1.6    Rename
    RN_RenameTo = BaseOffset + 143;                // new v1.6    Rename

    PW_UnatAddPWMiss = BaseOffset + 150;
    PW_UnatExtPWMiss = BaseOffset + 151;
    PW_Ok = BaseOffset + 152;                      // new v1.6    Password dialog
    PW_Cancel = BaseOffset + 153;                  // new v1.6    Password dialog
    PW_Caption = BaseOffset + 154;                 // new v1.6    Password dialog
    PW_MessageEnter = BaseOffset + 155;            // new v1.6    Password dialog
    PW_MessageConfirm = BaseOffset + 156;          // new v1.6    Password dialog
    PW_CancelAll = BaseOffset + 157;               // new v1.6    Password dialog
    PW_Abort = BaseOffset + 158;                   // new v1.6    Password dialog
    PW_ForFile = BaseOffset + 159;                 // new v1.6    Password dialog

    CF_SourceIsDest = BaseOffset + 180;            // new v1.6	 CopyZippedFiles
    CF_OverwriteYN = BaseOffset + 181;             // new v1.6	 CopyZippedFiles
    CF_CopyFailed = BaseOffset + 182;              // new v1.6	 CopyZippedFiles
    CF_SourceNotFound = BaseOffset + 183;          // new v1.6	 CopyZippedFiles
    CF_SFXCopyError = BaseOffset + 184;            // new v1.6	 CopyZippedFiles
    CF_DestFileNoOpen = BaseOffset + 185;          // new v1.6	 CopyZippedFiles
    CF_NoCopyOnSpan = BaseOffset + 186;            // new v1.7

    LI_ReadZipError = BaseOffset + 201;
    LI_ErrorUnknown = BaseOffset + 202;
    LI_WrongZipStruct = BaseOffset + 203;
    LI_GarbageAtEOF = BaseOffset + 204;

    AD_NothingToZip = BaseOffset + 301;
    AD_UnattPassword = BaseOffset + 302;
    AD_NoFreshenUpdate = BaseOffset + 303;
    AD_AutoSFXWrong = BaseOffset + 304;            // new v1.6    Add AutoSFX
    AD_NoStreamDLL = BaseOffset + 305;             // new v1.6		Add Stream
    AD_InIsOutStream = BaseOffset + 306;           // new v1.6		Add Stream
    AD_InvalidName = BaseOffset + 307;             // new v1.6		Add Stream

    DL_NothingToDel = BaseOffset + 401;
    DL_NoDelOnSpan = BaseOffset + 402;             // new v1.7

    EX_FatalUnZip = BaseOffset + 501;
    EX_UnAttPassword = BaseOffset + 502;
    EX_NoStreamDLL = BaseOffset + 503;             // new v1.6    MemoryExtract

    LZ_ZipDllLoaded = BaseOffset + 601;
    LZ_NoZipDllExec = BaseOffset + 602;
    LZ_NoZipDllVers = BaseOffset + 603;
    LZ_NoZipDll = BaseOffset + 604;
    LZ_OldZipDll = BaseOffset + 605;               // new v1.7

    LU_UnzDllLoaded = BaseOffset + 701;
    LU_NoUnzDllExec = BaseOffset + 702;
    LU_NoUnzDllVers = BaseOffset + 703;
    LU_NoUnzDll = BaseOffset + 704;
    LU_OldUnzDll = BaseOffset + 705;               // new v1.7

    SF_StringToLong = BaseOffset + 801;            // Changed v1.6
    SF_NoZipSFXBin = BaseOffset + 802;
    SF_InputIsNoZip = BaseOffset + 803;
    SF_NoSFXSupport = BaseOffset + 804;            // new v1.7 (v2.0)

    CZ_NoExeSpecified = BaseOffset + 901;
    CZ_InputNotExe = BaseOffset + 902;
    CZ_SFXTypeUnknown = BaseOffset + 903;

    DS_NoInFile = BaseOffset + 1001;
    DS_FileOpen = BaseOffset + 1002;
    DS_NotaDrive = BaseOffset + 1003;               // Changed a bit v1.52c
    DS_DriveNoMount = BaseOffset + 1004;            // Changed a bit v1.52c
    DS_NoVolume = BaseOffset + 1005;
    DS_NoMem = BaseOffset + 1006;
    DS_Canceled = BaseOffset + 1007;
    DS_FailedSeek = BaseOffset + 1008;
    DS_NoOutFile = BaseOffset + 1009;
    DS_NoWrite = BaseOffset + 1010;
    DS_EOCBadRead = BaseOffset + 1011;
    DS_LOHBadRead = BaseOffset + 1012;
    DS_CEHBadRead = BaseOffset + 1013;
    DS_LOHWrongSig = BaseOffset + 1014;
    DS_CEHWrongSig = BaseOffset + 1015;
    DS_LONameLen = BaseOffset + 1016;
    DS_CENameLen = BaseOffset + 1017;
    DS_LOExtraLen = BaseOffset + 1018;
    DS_CEExtraLen = BaseOffset + 1019;
    DS_DataDesc = BaseOffset + 1020;
    DS_ZipData = BaseOffset + 1021;
    DS_CECommentLen = BaseOffset + 1022;
    DS_EOArchComLen = BaseOffset + 1023;
    DS_ErrorUnknown = BaseOffset + 1024;
    DS_NoUnattSpan = BaseOffset + 1025;
    DS_EntryLost = BaseOffset + 1026;
    DS_NoTempFile = BaseOffset + 1027;
    DS_LOHBadWrite = BaseOffset + 1028;
    DS_CEHBadWrite = BaseOffset + 1029;
    DS_EOCBadWrite = BaseOffset + 1030;
    DS_ExtWrongSig = BaseOffset + 1031;
    DS_NoDiskSpace = BaseOffset + 1032;
    DS_InsertDisk = BaseOffset + 1033;
    DS_InsertVolume = BaseOffset + 1034;
    DS_InDrive = BaseOffset + 1035;
    DS_NoValidZip = BaseOffset + 1036;
    DS_FirstInSet = BaseOffset + 1037;
    DS_NotLastInSet = BaseOffset + 1038;
    DS_AskDeleteFile = BaseOffset + 1039;
    DS_AskPrevFile = BaseOffset + 1040;
    DS_NoSFXSpan = BaseOffset + 1041;
    DS_CEHBadCopy = BaseOffset + 1042;
    DS_EOCBadSeek = BaseOffset + 1043;
    DS_EOCBadCopy = BaseOffset + 1044;
    DS_FirstFileOnHD = BaseOffset + 1045;
    DS_InsertAVolume = BaseOffset + 1046;           // new v1.52c  DiskSpan
    DS_CopyCentral = BaseOffset + 1047;             // new v1.52i  DiskSpan
    DS_NoDiskSpan = BaseOffset + 1048;              // new v1.7 (v2.0)

implementation

end.

