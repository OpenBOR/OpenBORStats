(******************************************************************)
(* Structures for DelZip v1.6                                     *)
(* Copyright (C)1997-2002 Eric W. Engler, Chris Vleghert          *)
(*                                                                *)
(* written by Markus Stephany                                     *)
(* mailto:merkes@mirkes.de                                        *)
(* http://www.mirkes.de                                           *)
(*                                                                *)
(* last changed: 10/11/2002                                       *)
(*                                                                *)
(******************************************************************)
unit SFXStructs;

{
this unit contains definitions of records and signatures used
in zipfiles.

}

interface

uses
  Windows;
  
{$I DELVER.INC}
{$I missing_types.inc}

type

  // local file header entry
  PZipLocalHeader = ^TZipLocalHeader;
  TZipLocalHeader = packed record
    HeaderSig: LongWord;
    VersionNeed: Word;
    Flag: Word;
    ComprMethod: Word;
    ModifTime: Word;
    ModifDate: Word;
    CRC32: LongWord;
    ComprSize: LongWord;
    UnComprSize: LongWord;
    FileNameLen: Word;
    ExtraLen: Word;
  end;
  ZipLocalHeader = TZipLocalHeader;


  // central directory entry
  PZipCentralHeader = ^TZipCentralHeader;
  TZipCentralHeader = packed record //fixed part size : 42 bytes
    HeaderSig: LongWord; // hex: 02014B50(4)
    VersionMadeBy0: Byte; //version made by(1)
    VersionMadeBy1: Byte; //host number(1)
    VersionNeed: Word; // version needed to extract(2)
    Flag: Word; //generalPurpose bitflag(2)
    ComprMethod: Word; //compression method(2)
    ModifTime: Word; // modification time(2)
    ModifDate: Word; // modification date(2)
    CRC32: LongWord; //Cycling redundancy check (4)
    ComprSize: LongWord; //compressed file size  (4)
    UnComprSize: LongWord; //uncompressed file size (4)
    FileNameLen: Word; //(2)
    ExtraLen: Word; //(2)
    FileComLen: Word; //(2)
    DiskStart: Word; //starts on disk number xx(2)
    IntFileAtt: Word; //internal file attributes(2)
    ExtFileAtt: LongWord; //external file attributes(4)
    RelOffLocal: LongWord; //relative offset of local file header(4)
    // not used as part of this record structure:
    // filename, extra data, file comment
  end;
  ZipCentralHeader = TZipCentralHeader;

  // end of central directory record
  PZipEndOfCentral = ^TZipEndOfCentral;
  TZipEndOfCentral = packed record //Fixed part size : 22 bytes
    HeaderSig: LongWord; //(4)  hex=06054B50
    ThisDiskNo: Word; //(2)This disk's number
    CentralDiskNo: Word; //(2)Disk number central dir start
    CentralEntries: Word; //(2)Number of central dir entries on this disk
    TotalEntries: Word; //(2)Number of entries in central dir
    CentralSize: LongWord; //(4)Size of central directory
    CentralOffSet: LongWord; //(4)offsett of central dir on 1st disk
    ZipCommentLen: Word; //(2)
    // not used as part of this record structure:
    // ZipComment
  end;
  ZipEndOfCentral = TZipEndOfCentral;

  // ext local header (for spanning ?)
  PZipExtLocalHeader = ^TZipExtLocalHeader;
  TZipExtLocalHeader = packed record
    DataDescSig: LongWord; // Should be 0x08074B50
    CRC32: LongWord;
    ComprSize: LongWord;
    UnComprSize: LongWord;
  end;
  ZipExtLocalHeader = TZipExtLocalHeader;
  ZipDataDescriptor = TZipExtLocalHeader;

var { these are stored in reverse order }
  // xyz-1: avoid zip structure signatures in the sfx code
  //        zipdll.dll doesn't like them...
  ZipLocalHeaderSig: DWORD = $04034B50-1; { 'PK'34  (in file: 504b0304) }
  LocalFileHeaderSig: DWORD = $04034B50-1;
  ZipCentralHeaderSig: DWORD = $02014B50-1; { 'PK'12 }
  CentralFileHeaderSig: DWORD = $02014B50-1;
  ZipEndOfCentralSig: DWORD = $06054B50-1; { 'PK'56 }
  EndCentralDirSig: DWORD = $06054B50-1;
  ZipExtLocalHeaderSig: DWORD = $08074B50-1; { 'PK'78 }
  ExtLocalSig: DWORD = $08074B50-1;


// buffer stuff (not anymore public in zipmstr.pas)
const
  SFXBufSize = 8192;

type
  PSFXBuffer = ^TSFXBuffer;
  TSFXBuffer = array[0..SFXBufSize - 1] of Byte;

implementation

initialization
  // adjust the signatures
  Inc(ZipLocalHeaderSig);
  Inc(LocalFileHeaderSig);
  Inc(ZipCentralHeaderSig);
  Inc(CentralFileHeaderSig);
  Inc(ZipEndOfCentralSig);
  Inc(EndCentralDirSig);
  Inc(ZipExtLocalHeaderSig);
  Inc(ExtLocalSig);

end.
