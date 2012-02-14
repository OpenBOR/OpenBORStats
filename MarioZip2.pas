unit MarioZip2;//V0.8

interface

uses
  Windows, SysUtils, Classes, Forms, mario, MarioSec,
  AbArcTyp, AbUtils, AbBase, AbBrowse,
  AbZipKit;

          ////////Procedures that use's basic units////////
Procedure zzOpen(aZipObject:TAbZipKit);
Procedure ZZDeleteFile(ZFileName:String; aZipObject:TAbZipKit; isDir:Boolean = False);

Function ZZAddfile(SrcFile:String; aZipObject:TAbZipKit):Boolean;  Overload;
Function ZZAddFile(SrcFile, DestName:string;aZipObject:TAbZipKit):Boolean; Overload;
Function ZZAddEnCryptFile(aStream:TMemoryStream;Destname:String; aZipObject:TAbZipKit; Code, key:WideString):Boolean;
Procedure ZZExtractFile(SrcFile, DestinationFile:String; aZipObject:TAbZipKit);
Function ZZExtractFile2Stream(SrcFile :String; aZipObject:TAbZipKit):TMemoryStream;
Function ZZExtractEnCryptedFile2Stream(SrcFile :String; aZipObject:TAbZipKit;  Code, key:WideString):TMemoryStream;

Function ZZgetFileList(aZipObject:TAbZipKit):TStringList;
Function zzGetFileListC(ContainingStr:String; aZipObject:TAbZipKit) : TStringList;
Function ZZGetFileSize(SrcFile:String; aZipObject:TAbZipKit):Int64;
Function ZZGetFileCompSize(SrcFile:String; aZipObject:TAbZipKit):Int64;
Function ZZFileExists(SrcFile:String;aZipObject:TAbZipKit):Boolean;
{Procedure ZZExtractFile(ZFileName:String; aZipObject:TZipMaster); Overload;

}

var
  zzBusy : Boolean =false;
  WorkingZipFile : WideString;

implementation

Procedure zzOpen(aZipObject:TAbZipKit);
Begin
  {if aZipObject.FileName = '' then
      aZipObject.OpenArchive(WorkingZipFile)
    Else Begin
      WorkingZipFile := aZipObject.FileName;
      aZipObject.OpenArchive(aZipObject.FileName);
    End;}
End;

Procedure ZZDeleteFile(ZFileName:String; aZipObject:TAbZipKit; isDir:Boolean);
Begin
  Try
    zzOpen(aZipObject);
    if ZFileName <> '' then Begin
      MatStringReplace(ZFileName,'\','/');
      MatStringDeleteFirstChar(ZFileName,'/');
      aZipObject.DeleteFiles(ZFileName);
    end;
  Finally
    //aZipObject.CloseArchive;
  End;
  //Application.ProcessMessages;
End;

Procedure ZZExtractFile(SrcFile, DestinationFile:String; aZipObject:TAbZipKit);
Var
  FileStream : TMemoryStream;
Begin
    Try
      zzOpen(aZipObject);
      FileStream := TMemoryStream.Create;
      MatStringReplace(SrcFile,'\','/');
      aZipObject.ExtractToStream(SrcFile,FileStream);
      If FileStream.Size > 0 then
        FileStream.SaveToFile(DestinationFile);
      If fileStream <> nil then
        fileStream.Free;
      //Application.ProcessMessages;
    Finally
      //aZipObject.CloseArchive;
      //aZipObject.FileName := WorkingFile;
  End;
End;

Function ZZExtractFile2Stream(SrcFile :String; aZipObject:TAbZipKit):TMemoryStream;
Var
  FileStream : TMemoryStream;
Begin
    Try
      zzOpen(aZipObject);
      FileStream := TMemoryStream.Create;
      MatStringReplace(SrcFile,'\','/');
      aZipObject.ExtractToStream(SrcFile,FileStream);
      FileStream.Position := 0;
      Result := FileStream;

      //Application.ProcessMessages;
    Finally
      //aZipObject.CloseArchive;
      //aZipObject.FileName := WorkingFile;
  End;

End;

Function ZZExtractEnCryptedFile2Stream(SrcFile :String; aZipObject:TAbZipKit;  Code, key:WideString):TMemoryStream;
Var
  FileStream : TMemoryStream;
  s : WideString;
Begin
    Try
      zzOpen(aZipObject);
      FileStream := TMemoryStream.Create;
      MatStringReplace(SrcFile,'\','/');
      aZipObject.ExtractToStream(SrcFile,FileStream);
      FileStream.Position := 0;

      s := EncodeStream(FileStream);
      s := MatSecBlowFishDecrypt(s,key);
      FileStream := DecodeString2(s);
      FileStream.Position := 0;

      Result := FileStream;

      //Application.ProcessMessages;
    Finally
    //aZipObject.CloseArchive;
  End;
End;

Function ZZAddFile(SrcFile, DestName:string;aZipObject:TAbZipKit):Boolean;
Var
  fileStream : TMemoryStream;
Begin
  Try
    zzOpen(aZipObject);
    ZZDeleteFile(DestName,aZipObject,false);
    zzOpen(aZipObject);

    Result := false;
    MatStringReplace(DestName,'\','/');
    fileStream := TMemoryStream.Create;
    If FileExists(SrcFile) then Begin
      fileStream.LoadFromFile(SrcFile);
      aZipObject.AddFromStream(DestName,fileStream);
    End;
    Result := True;
  Finally
    If fileStream <> nil then
      fileStream.Free;
    //aZipObject.CloseArchive;
    //Application.ProcessMessages;
  end;
End;

Function ZZAddEnCryptFile(aStream:TMemoryStream;Destname:String; aZipObject:TAbZipKit; Code, key:WideString):Boolean;
Var
  s : WideString;
Begin
  Try
    zzOpen(aZipObject);
    Result := false;
    MatStringReplace(DestName,'\','/');
    s := EncodeStream(aStream);
    s := MatSecBlowFishEncrypt(s,key);
    aStream := DecodeString2(s);
    aStream.Position := 0;
    aZipObject.AddFromStream(DestName,aStream);


    Result := True;
  Finally
    If aStream <> nil then
      aStream.Free;
    //aZipObject.CloseArchive;
    //Application.ProcessMessages;
  end;
End;

Function ZZAddfile(SrcFile:String; aZipObject:TAbZipKit):Boolean;
Var
  fileStream : TMemoryStream;
Begin
  Try
    zzOpen(aZipObject);
    Result := false;

    fileStream := TMemoryStream.Create;
    If FileExists(SrcFile) then Begin
      fileStream.LoadFromFile(SrcFile);
      aZipObject.AddFromStream(ExtractFileName(SrcFile),fileStream);
    End;
    Result := True;
  Finally
    If fileStream <> nil then
      fileStream.Free;
    //aZipObject.CloseArchive;
    //Application.ProcessMessages;
  end;
End;



Function ZZgetFileList(aZipObject:TAbZipKit):TStringList;
Var
  aList : TStringList;
  i : Integer;
Begin
  Try
    zzOpen(aZipObject);
    Try

      aList := TStringList.Create;

      For i := 0 to aZipObject.Count -1 do Begin
        aList.Add(aZipObject.Items[i].DiskFileName);
      End;
      Result := aList;
      //Application.ProcessMessages;
    Except
      Result := nil;
    End;
  Finally
    //aZipObject.CloseArchive;
  End;
End;

Function zzGetFileListC(ContainingStr:String; aZipObject:TAbZipKit) : TStringList;
Var
  aList : TStringList;
  i : Integer;
Begin
  Try
    zzOpen(aZipObject);
    Try

      aList := TStringList.Create;
      MatStringReplace(ContainingStr,'\','/');
      For i := 0 to aZipObject.Count -1 do Begin
        If pos(LowerCase(aZipObject.Items[i].DiskFileName),LowerCase(ContainingStr)) > 0 then
          aList.Add(aZipObject.Items[i].DiskFileName);
      End;
      Result := aList;
      //Application.ProcessMessages;
    Except
      Result := nil;
    End;
  Finally
    //aZipObject.CloseArchive;
  End;
End;

Function ZZGetFileSize(SrcFile:String; aZipObject:TAbZipKit):Int64;
Var
  i : Integer;
  s1, s2 : widestring;
Begin
  Try
    zzOpen(aZipObject);
    Result := 0;
    i := 0;
    MatStringReplace(SrcFile,'\','/');
    s1 := LowerCase(SrcFile);
    While i < aZipObject.Count do Begin
      s2 := LowerCase(aZipObject.Items[i].FileName);
      if s1 = s2 then Begin
        Result := aZipObject.Items[i].UncompressedSize;
        i := aZipObject.Count;
      End;
      inc(i);
    End;
  Finally
    //aZipObject.CloseArchive;
  End;
End;

Function ZZGetFileCompSize(SrcFile:String; aZipObject:TAbZipKit):Int64;
Var
  i : Integer;
Begin
  Try
    zzOpen(aZipObject);
    Result := -1;
    MatStringReplace(SrcFile,'\','/');
    For i := 0 to aZipObject.Count -1 do Begin
       if LowerCase(SrcFile) = LowerCase(aZipObject.Items[i].FileName) then Begin
         Result := aZipObject.Items[i].CompressedSize;
         exit;
       End;
    End;
  Finally
    //aZipObject.CloseArchive;
  End;
End;

Function ZZFileExists(SrcFile:String;aZipObject:TAbZipKit):Boolean;
Var
  i : integer;
  Fnd : Bool;
Begin
  Try
    zzOpen(aZipObject);
    i := aZipObject.FindFile(SrcFile);
    If i > 0 then
      Fnd := true
    Else
      Fnd := false;
    Result := Fnd;
  Finally
    //aZipObject.CloseArchive;
  End;
End;

End.