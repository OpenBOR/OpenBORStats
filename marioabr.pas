unit Marioabr;//V0.15

interface

uses
  Windows, SysUtils, Classes, ZipMstr, Forms, mario;

          ////////Procedures that use's basic units////////
Procedure ZZExtractFile(ZFileName:String; aZipObject:TZipMaster); Overload;
Procedure ZZExtractFile(ZFileName, DestinationFile:String; aZipObject:TZipMaster); Overload;
  //Disabled cause the comp really has major bugs with this
//function ZZExtractFileToStream(ZFileName:String; aZipObject:TZipMaster):TMemoryStream;
Procedure ZZDeleteFile(ZFileName:String; aZipObject:TZipMaster; isDir:Boolean = False);
Function ZZgetFileList(aZipObject:TZipMaster):TStringList;
Function ZZAddFile(SrcFile, DestName:string;aZipObject:TZipMaster):Boolean; Overload;
Function ZZAddfile(SrcFile:String; aZipObject:TZipMaster):Boolean; Overload;
Function ZZGetFileSize(SrcFile:String; aZipObject:TZipMaster):Int64;
Function ZZGetFileCompSize(SrcFile:String; aZipObject:TZipMaster):Int64;
Function zzGetFileListC(ContainingStr:String; aZipObject:TZipMaster) : TStringList;

var
  zzBusy : Boolean =false;

implementation


Procedure ZZExtractFile(ZFileName:String; aZipObject:TZipMaster);
Var
  Tmpstr01  :String;
  i : Integer;
Begin
  Try
   i := 0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
   If FileExists(ZFileName) then
     DeleteFile(ZFileName);
   If Not FileExists(aZipObject.ZipFileName) then
     Exit;
   aZipObject.FSpecArgs.Clear;
   aZipObject.FSpecArgs.Add(ExtractFileName(ZFileName));
   if not DirectoryExists(ExtractFilePath(ZFileName)) then
    CreateDirectory(Pchar(ExtractFilePath(ZFileName)),nil);
   Tmpstr01 := ExtractFilePath(ZFileName);
   aZipObject.ExtrBaseDir := ExtractFilePath(ZFileName);
   aZipObject.Extract;

    Tmpstr01 := ExtractFileName(ZFileName);
  Except
  End;
  zzBusy := false;
  //1
End;

Procedure ZZExtractFile(ZFileName, DestinationFile:String; aZipObject:TZipMaster);
Var
  i : Integer;
Begin
   i := 0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
  If Not FileExists(aZipObject.ZipFileName) then
    Exit;
  aZipObject.ExtractFileToStream(ZFileName);
  aZipObject.ZipStream.SaveToFile(DestinationFile);
  zzBusy := false;
End;

{function ZZExtractFileToStream(ZFileName:String; aZipObject:TZipMaster):TMemoryStream;
Var
  Tmpstr01  :String;
  aStream :TMemoryStream;
Begin
  Try
    aStream := TMemoryStream.Create;
   aZipObject.FSpecArgs.Clear;
   aZipObject.FSpecArgs.Add(ExtractFileName(ZFileName));
   Tmpstr01 := ExtractFilePath(ZFileName);
   aStream := aZipObject.ExtractFileToStream(ZFileName);
  Finally
    Result := aStream ;
  End;
  //1
end;}

Procedure ZZDeleteFile(ZFileName:String; aZipObject:TZipMaster; isDir:Boolean = False);
Var
  i : Integer;
  Delete : Boolean;
Begin
  Try
   i := 0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
    i := 0;
    Delete := False;
    While i < aZipObject.Count do begin
      If isDir = false then Begin
        If aZipObject.DirEntry[i].FileName = ZFileName then
          Delete := True;
      End
      Else Begin
        If isDir = true then
          If pos(ZFileName,aZipObject.DirEntry[i].FileName) > 0 then
            Delete := True;
      End;
      If Delete then Begin
        aZipObject.FSpecArgs.Clear;
        aZipObject.FSpecArgs.Add(aZipObject.DirEntry[i].FileName);
        aZipObject.Delete;
        //i := aZipObject.Count;
      end;
      Delete := False;
      Inc(i);
    End;
  Finally
    zzBusy := false;
  End;
End;

function ZZgetFileList(aZipObject:TZipMaster):TStringList;
Var
  aList : TStringList;
  i : Integer;
  apointr : pZipDirEntry;
Begin
  Try
   i := 0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
    aList := TStringList.Create;
    for i := 0 to aZipObject.ZipContents.Count -1 do
     Begin
       apointr := aZipObject.ZipContents.Items[i];
       aList.Add(apointr.FileName);
     End;
  Finally
    Result := aList;
    zzBusy := false;
  End;
End;

Function ZZAddFile(SrcFile, DestName:string;aZipObject:TZipMaster):Boolean;
Var
  //aStream : TMemoryStream;
  dne : Integer;
  i : Integer;
begin
  Try
   i := 0;
   Result := false;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
    Try
      //aStream := TMemoryStream.Create;
      aZipObject.ZipStream.Clear;
      iF FileExists(SrcFile) then
        aZipObject.ZipStream.LoadFromFile(SrcFile);
        //aStream.LoadFromFile(SrcFile);
      //aZipObject.ZipStream.LoadFromStream(aStream);
      dne := aZipObject.AddStreamToFile(DestName,DateTimeToFileDate(now),0);
      //aZipObject.ZipStream.LoadFromFile(SrcFile);
      While  dne <> 0 do
        dne := aZipObject.AddStreamToFile(DestName,DateTimeToFileDate(now),0);
      Result := True;
    except
      Result := False;
    End;
  Finally
    zzBusy := false;
    //aStream.Free;
  End;

end;

Function ZZAddfile(SrcFile:String; aZipObject:TZipMaster):Boolean;
Var
  i : Integer;
Begin
  Try
   i := 0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
   aZipObject.FSpecArgs.Clear;
   aZipObject.FSpecArgs.Add(SrcFile);
   aZipObject.Add;
   Result := true;
  except
    Result := False;
  end;
    zzBusy := false;
end;

Function ZZGetFileSize(SrcFile:String; aZipObject:TZipMaster):Int64;
Var
  i : Integer;
  size : Int64;
Begin
   i :=0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
    i := 0;
    While i < aZipObject.Count do begin
        If aZipObject.DirEntry[i].FileName = SrcFile then Begin
           size := aZipObject.DirEntry[i].UncompressedSize;
           i := aZipObject.Count +1;
         End;
       inc(i);
      End;
   if size = 5622850926413640 then
     Size := 0;
  result := size;
  zzBusy := false;
End;

Function ZZGetFileCompSize(SrcFile:String; aZipObject:TZipMaster):Int64;
Var
  i : Integer;
  size : Int64;
Begin
   i :=0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
    i := 0;
    size := 0;
    While i < aZipObject.Count do begin
        If aZipObject.DirEntry[i].FileName = SrcFile then Begin
           size := aZipObject.DirEntry[i].CompressedSize;
           i := aZipObject.Count +1;
         End;
       inc(i);
      End;
   if size = 5622850926413640 then
     Size := 0;      
  result := size;
  zzBusy := false;
End;

Function zzGetFileListC(ContainingStr:String; aZipObject:TZipMaster) : TStringList;
Var
  aList : TStringList;
  i : Integer;
Begin
  Try
   i := 0;
   while (zzBusy = true) and
         (i < 10) do Begin
     MatDelay(100);
     inc(i);
   End;
   zzBusy := True;
    aList := TStringList.Create;
    i := 0;
    While i < aZipObject.Count do begin
        If pos(ContainingStr, aZipObject.DirEntry[i].FileName) > 0 then Begin
           aList.Add(aZipObject.DirEntry[i].FileName);
         End;
       inc(i);
      End;
    Result := aList;
  Finally
    zzBusy := false;
  end;
End;


End.
