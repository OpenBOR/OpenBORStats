#ifndef ZipMsgH
#define ZipMsgH

#define BaseOffset 10000

#define GE_FatalZip		BaseOffset + 101
#define GE_NoZipSpecified	BaseOffset + 102
#define GE_NoMem		BaseOffset + 103
#define GE_WrongPassword	BaseOffset + 104
#define GE_CopyFile		BaseOffset + 105

#define RN_ZipSFXData		BaseOffset + 140   
#define RN_NoRenOnSpan	   	BaseOffset + 141   
#define RN_ProcessFile	   	BaseOffset + 142   
#define RN_RenameTo		BaseOffset + 143   

#define PW_UnatAddPWMiss	BaseOffset + 150
#define PW_UnatExtPWMiss	BaseOffset + 151
#define PW_Ok			BaseOffset + 152   
#define PW_Cancel		BaseOffset + 153   
#define PW_Caption		BaseOffset + 154   
#define PW_MessageEnter		BaseOffset + 155   
#define PW_MessageConfirm	BaseOffset + 156   
#define PW_CancelAll		BaseOffset + 157   
#define PW_Abort		BaseOffset + 158   
#define PW_ForFile		BaseOffset + 159   

#define CF_SourceIsDest		BaseOffset + 180	
#define CF_OverwriteYN		BaseOffset + 181	
#define CF_CopyFailed		BaseOffset + 182	
#define CF_SourceNotFound	BaseOffset + 183	
#define CF_SFXCopyError		BaseOffset + 184	
#define CF_DestFileNoOpen	BaseOffset + 185
#define CF_NoCopyOnSpan  	BaseOffset + 186	

#define LI_ReadZipError		BaseOffset + 201
#define LI_ErrorUnknown		BaseOffset + 202	
#define LI_WrongZipStruct	BaseOffset + 203
#define LI_GarbageAtEOF		BaseOffset + 204

#define AD_NothingToZip		BaseOffset + 301
#define AD_UnattPassword	BaseOffset + 302
#define AD_NoFreshenUpdate 	BaseOffset + 303
#define AD_AutoSFXWrong		BaseOffset + 304	
#define AD_NoStreamDLL		BaseOffset + 305	
#define AD_InIsOutStream	BaseOffset + 306	
#define AD_InvalidName		BaseOffset + 307	

#define DL_NothingToDel		BaseOffset + 401
#define DL_NoDelOnSpan     	BaseOffset + 402

#define EX_FatalUnZip		BaseOffset + 501
#define EX_UnAttPassword	BaseOffset + 502
#define EX_NoStreamDLL		BaseOffset + 503   

#define LZ_ZipDllLoaded		BaseOffset + 601
#define LZ_NoZipDllExec		BaseOffset + 602
#define LZ_NoZipDllVers		BaseOffset + 603
#define LZ_NoZipDll		BaseOffset + 604
#define LZ_OldZipDll       	BaseOffset + 605
#define LZ_ZipDllUnloaded  	BaseOffset + 606
 
#define LU_UnzDllLoaded		BaseOffset + 701
#define LU_NoUnzDllExec		BaseOffset + 702
#define LU_NoUnzDllVers		BaseOffset + 703
#define LU_NoUnzDll		BaseOffset + 704
#define LU_OldUnzDll       	BaseOffset + 705
#define LU_UnzDllUnloaded  	BaseOffset + 706

#define SF_StringToLong		BaseOffset + 801	
#define SF_NoZipSFXBin		BaseOffset + 802
#define SF_InputIsNoZip		BaseOffset + 803
#define SF_NoSFXSupport    	BaseOffset + 804

#define CZ_NoExeSpecified	BaseOffset + 901
#define CZ_InputNotExe		BaseOffset + 902
#define CZ_SFXTypeUnknown	BaseOffset + 903

#define DS_NoInFile		BaseOffset + 1001
#define DS_FileOpen		BaseOffset + 1002
#define DS_NotaDrive		BaseOffset + 1003	
#define DS_DriveNoMount		BaseOffset + 1004	
#define DS_NoVolume		BaseOffset + 1005
#define DS_NoMem		BaseOffset + 1006
#define DS_Canceled		BaseOffset + 1007
#define DS_FailedSeek		BaseOffset + 1008
#define DS_NoOutFile		BaseOffset + 1009
#define DS_NoWrite		BaseOffset + 1010
#define DS_EOCBadRead		BaseOffset + 1011
#define DS_LOHBadRead		BaseOffset + 1012
#define DS_CEHBadRead		BaseOffset + 1013
#define DS_LOHWrongSig		BaseOffset + 1014
#define DS_CEHWrongSig		BaseOffset + 1015
#define DS_LONameLen		BaseOffset + 1016
#define DS_CENameLen		BaseOffset + 1017
#define DS_LOExtraLen		BaseOffset + 1018
#define DS_CEExtraLen		BaseOffset + 1019
#define DS_DataDesc		BaseOffset + 1020
#define DS_ZipData		BaseOffset + 1021
#define DS_CECommentLen		BaseOffset + 1022
#define DS_EOArchComLen		BaseOffset + 1023
#define DS_ErrorUnknown		BaseOffset + 1024	
#define DS_NoUnattSpan		BaseOffset + 1025
#define DS_EntryLost		BaseOffset + 1026
#define DS_NoTempFile		BaseOffset + 1027
#define DS_LOHBadWrite		BaseOffset + 1028
#define DS_CEHBadWrite		BaseOffset + 1029
#define DS_EOCBadWrite		BaseOffset + 1030
#define DS_ExtWrongSig		BaseOffset + 1031
#define DS_NoDiskSpace		BaseOffset + 1032
#define DS_InsertDisk		BaseOffset + 1033
#define DS_InsertVolume		BaseOffset + 1034
#define DS_InDrive		BaseOffset + 1035
#define DS_NoValidZip		BaseOffset + 1036
#define DS_FirstInSet		BaseOffset + 1037
#define DS_NotLastInSet		BaseOffset + 1038
#define DS_AskDeleteFile	BaseOffset + 1039
#define DS_AskPrevFile		BaseOffset + 1040
#define DS_NoSFXSpan		BaseOffset + 1041
#define DS_CEHBadCopy		BaseOffset + 1042
#define DS_EOCBadSeek		BaseOffset + 1043
#define DS_EOCBadCopy		BaseOffset + 1044
#define DS_FirstFileOnHD	BaseOffset + 1045
#define DS_InsertAVolume	BaseOffset + 1046   
#define DS_CopyCentral		BaseOffset + 1047
#define DS_NoDiskSpan      	BaseOffset + 1048

#define FM_Erase           	BaseOffset + 1101
#define FM_Confirm         	BaseOffset + 1102

#endif
