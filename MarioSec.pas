unit MarioSec;//V0.10
//A unit with security methods


interface

uses
  Windows, SysUtils, Classes, Registry, IniFiles,
  Blowfish, RC2, Base64, JclMime, Graphics, forms, JvRichEdit;

procedure MatSecCallCode(FileName:String);
function MatSecTrans(Ch: Char; K: Byte): Char;
function MatSecVigenereCipherEncrypt(const S, AKey: string): string;
function MatSecVigenereCipherDecrypt(const S, AKey: string): string;
Function MatSecBlowFishEncrypt(S, aKey:String):String;
Function MatSecBlowFishDecrypt(S, aKey:String):String;
Function MatSecRC2Encrypt(S, aKey:String):String;
Function MatSecRC2Decrypt(S, aKey:String):String;
Function MatLst2Str(lst:TStringList):Widestring;
//------------------------------------------------------------------------------
// UUEncoding and decoding utilities:
//------------------------------------------------------------------------------
//Uses JclMime
function DecodeStream(EncodedStream: TStream): TStream;
function DecodeStream2(EncodedStream: TMemoryStream): TMemoryStream;
function DecodeString(EncodedString: Widestring): TStream; Overload;
function DecodeString2(EncodedString: Widestring): TMemoryStream; Overload;
function DecodeStringStr(EncodedString: Widestring): Widestring;
function DecodeStringList(EncodedString: Widestring): TStringList;
function EncodeStream(Stream: TStream): Widestring;
function EncodeString(AString: Widestring): Widestring;

//Uses graphics
function EncodeFont(aFont:Tfont):Widestring;
function DecodeFont(EncodedString:WideString):tfont;
function EncodeJvParaAttributes(Attributes:TJvParaAttributes):WideString;


implementation

//UUEncoding and decoding utilities:

function DecodeStream(EncodedStream: TStream): TStream;
begin
  Result := TMemoryStream.Create;
  EncodedStream.Seek(0, soFromBeginning);
  MimeDecodeStream(EncodedStream, Result);
  Result.Seek(0, soFromBeginning);
end;

function DecodeStream2(EncodedStream: TMemoryStream): TMemoryStream;
begin
  Result := TMemoryStream.Create;
  EncodedStream.Seek(0, soFromBeginning);
  MimeDecodeStream(EncodedStream, Result);
  Result.Seek(0, soFromBeginning);
end;

function DecodeString(EncodedString: Widestring): TStream;
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create(EncodedString);
  try
    Result := DecodeStream(StrStream);
  finally
    StrStream.Free;
  end;
end;

function DecodeString2(EncodedString: Widestring): TMemoryStream;
var
  StrStream: TStringStream;
  sStream : TMemoryStream;
begin
  StrStream := TStringStream.Create(EncodedString);
  sStream := TMemoryStream.Create;
  sStream.LoadFromStream(StrStream);
  try
    Result := DecodeStream2(sStream);
  finally
    StrStream.Free;
  end;
end;

function DecodeStringStr(EncodedString: Widestring): Widestring;
begin
  if EncodedString <> '' then
    Result := MimeDecodeString(EncodedString)
  else
    Result := ' ';
end;

function DecodeStringList(EncodedString: Widestring): TStringList;
Begin

End;

function EncodeStream(Stream: TStream): Widestring;
var
  MimeStream: TStringStream;
begin
  MimeStream := TStringStream.Create('');
  try
    Stream.Seek(0, soFromBeginning);
    MimeEncodeStream(Stream, MimeStream);
    Result := MimeStream.DataString;
  finally
    MimeStream.Free;
  end;
end;

function EncodeString(AString: Widestring): Widestring;
begin
  Result := MimeEncodeString(AString);
end;

function EncodeFont(aFont:Tfont):Widestring;
Var
  List : TStringList;
  bold,italic,underline,strikeout : Boolean;
Begin
  try
  Try
    List := TStringList.Create;
    bold := False;
    italic := False;
    underline := False;
    strikeout := False;
    If aFont = nil then
      Exit;
    List.Add(aFont.Name);
    List.Add(IntToStr(aFont.Size));
    List.Add(IntToStr(aFont.Height));
    List.Add(ColorToString(aFont.Color));
    If ([fsBold] = aFont.Style) then
      bold := true;
    IF ([fsBold,fsUnderline] = aFont.Style)then Begin
      bold := True;
      underline := True;
    End;
    IF ([fsBold,fsItalic] = aFont.Style)then Begin
      bold := True;
      italic := True;
    End;
    IF ([fsBold,fsStrikeOut] = aFont.Style)then Begin
      bold := True;
      strikeout := True;
    End;
    IF ([fsItalic,fsStrikeOut] = aFont.Style)then Begin
      italic := True;
      strikeout := True;
    End;
    IF ([fsItalic,fsUnderline] = aFont.Style)then Begin
      underline := True;
      italic := True;
    End;
    IF ([fsUnderline,fsStrikeOut] = aFont.Style)then Begin
      underline := True;
      strikeout := True;
    End;
    IF ([fsUnderline,fsItalic] = aFont.Style)then Begin
      underline := True;
      italic := True;
    End;
    IF ([fsBold,fsUnderline,fsItalic] = aFont.Style)then Begin
      bold := True;
      underline := True;
      italic := True;
    End;
    IF ([fsBold,fsStrikeOut,fsItalic] = aFont.Style)then Begin
      bold := True;
      underline := True;
      italic := True;
    End;
    IF ([fsBold,fsUnderline,fsStrikeOut,fsItalic] = aFont.Style)then Begin
      bold := True;
      underline := True;
      italic := True;
    End;
    If bold = true then
      List.Add('fsBold')
    Else
      List.Add('');
    If [fsItalic] = aFont.Style then
      italic := True;
    If italic = true then
      List.Add('fsItalic')
    Else
      List.Add('');
    If [fsUnderline] = aFont.Style then
      underline := true;
    If underline = true then
      List.Add('fsUnderline')
    Else
      List.Add('');
    If [fsStrikeOut] = aFont.Style then
      strikeout := True;
    If strikeout = true then
      List.Add('fsStrikeOut')
    Else
      List.Add('');
    Result := EncodeString(List.Text);
  Finally
    List.Free;
  End;
  Except
    Result := '';
  End;
end;

function DecodeFont(EncodedString:WideString):tfont;
Var
  List : TStringList;
  aFont : TFont;
  i : Integer;
Begin
  Try
    List := TStringList.Create;
    If EncodedString = '' then
      Exit;
    aFont := TFont.Create;
    List.Text := DecodeStringStr(EncodedString);
      aFont.Name := List.Strings[0];
      aFont.Size := StrToInt(List.Strings[1]);
      aFont.Height := StrToInt(List.Strings[2]);
      aFont.Color := StringToColor(List.Strings[3]);
      If List.Strings[4] = 'fsBold' then
        aFont.Style := aFont.Style+[fsBold];
      If List.Strings[5] = 'fsItalic' then
        aFont.Style := aFont.Style+[fsItalic];
      If List.Strings[6] = 'fsUnderline' then
        aFont.Style := aFont.Style+[fsUnderline];
      If List.Strings[7] = 'fsStrikeOut' then
        aFont.Style := aFont.Style+[fsStrikeOut];
    Result := aFont;
  Finally
    List.Free;
  End;

end;

//Incomplete
function EncodeJvParaAttributes(Attributes:TJvParaAttributes):WideString;
Var
  s : WideString;
  list : TStringList;
Begin
  //TParaAlignment = (paLeftJustify, paRightJustify, paCenter, paJustify);
  list := TStringList.Create;
  //Alignedment
  if Attributes.Alignment in [paLeftJustify] then
    list.Add('Left')
  Else
  if Attributes.Alignment in [paRightJustify] then
    list.Add('Right')
  Else
  if Attributes.Alignment in [paCenter] then
    list.Add('Center')
  Else
  if Attributes.Alignment in [paJustify] then
    list.Add('Justify');
  //First Indent
  list.Add(IntToStr(Attributes.FirstIndent));
  //TParaTableStyle = (tsNone, tsTableRow, tsTableCellEnd, tsTableCell);
  //HeadingStyle
  list.Add(IntToStr(Attributes.HeadingStyle));
  //IndentationStyle
//  TJvIndentationStyle = (isRichEdit, isOffice); // added by J.G. Boerema
  If Attributes.IndentationStyle in [isRichEdit] then
    list.Add('isRichEdit')
  Else
  If Attributes.IndentationStyle in [isOffice] then
    list.Add('isOffice');
  //LeftIndent
  list.Add(IntToStr(Attributes.LeftIndent));
  //LineSpacing
  list.Add(IntToStr(Attributes.LineSpacing))
  //TLineSpacingRule = (lsSingle, lsOneAndHalf, lsDouble, lsSpecifiedOrMore,lsSpecified, lsMultiple);
//  Attributes.LineSpacingRule;

  //list.Free;
End;

//What It Does
 //Needed for the VigenereCipher
function MatSecTrans(Ch: Char; K: Byte): Char;
begin
  Result := Char((256 + Ord(Ch) + K) mod 256);
End;

//What It Does
 //Decodes the VigenereCipher
function MatSecVigenereCipherDecrypt(const S, AKey: string): string;
var
  I, J: Byte;
begin
  if AKey = '' then
  begin
    Result := '';
    Exit;
  end;
  J := 1;
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
  begin
    Result[I] := MatSecTrans(S[I], -Ord(AKey[J]));
    J := (J mod Length(AKey)) + 1;
  end;
end;

//What It Does
 //Encodes the VigenereCipher
function MatSecVigenereCipherEncrypt(const S, AKey: string): string;
var
  I, J: Byte;
begin
  if AKey = '' then
  begin
    Result := '';
    Exit;
  end;
  J := 1;
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
  begin
    Result[I] := MatSecTrans(S[I], Ord(AKey[J]));
    J := (J mod Length(AKey)) + 1;
  end;
end;

procedure MatSecCallCode(FileName:String);
Var
  TempStrL :TStringList;
  MyIni :TMemIniFile;
  TCode, Fkey : String;
begin
//Get the code
  Try
    MyIni := TMemIniFile.Create(FileName);
    TCode := MyIni.ReadString('JobNames1','Timer',TCode);
    If TCode <> '' then
     Begin
      TCode := MatSecVigenereCipherDecrypt(TCode,Fkey);
     End;
   Finally
    MyIni.UpdateFile;
    MyIni.Free;
   End;
end;

Function MatSecBlowFishEncrypt(S, aKey:String):String;
var
  Cipher: TDCP_blowfish;
begin
  Cipher:= TDCP_blowfish.Create(nil);
  Cipher.InitStr(aKey);  //password-key
  Cipher.EncryptCBC(s[1],s[1],length(s));  //when encrypting strings you must point the algorithm to the first character
  Cipher.Reset;
  Cipher.Burn;
  Cipher.Free;
  s := EncodeString(S);
  Result := s;
End;

Function MatSecBlowFishDecrypt(S, aKey:String):String;
var
  Cipher: TDCP_blowfish;
begin
  Cipher:= TDCP_blowfish.Create(nil);
  s := DecodeStringStr(s);
  Cipher.InitStr(aKey);    // initialize the cipher with the key
  Cipher.DecryptCBC(s[1],s[1],Length(s));
  Cipher.Reset;
  Cipher.Burn;
  Cipher.Free;
  Result := s;
End;

Function MatSecRC2Encrypt(S, aKey:String):String;
var
  Cipher: TDCP_rc2;
begin
  Cipher:= TDCP_rc2.Create(nil);
  Cipher.InitStr(aKey);  //password-key
  Cipher.EncryptCBC(s[1],s[1],length(s));  //when encrypting strings you must point the algorithm to the first character
  Cipher.Reset;
  Cipher.Burn;
  Cipher.Free;
  s := EncodeString(S);
  Result := s;
End;

Function MatSecRC2Decrypt(S, aKey:String):String;
var
  Cipher: TDCP_rc2;
begin
  Cipher:= TDCP_rc2.Create(nil);
  s := DecodeStringStr(s);
  Cipher.InitStr(aKey);    // initialize the cipher with the key
  Cipher.DecryptCBC(s[1],s[1],Length(s));
  Cipher.Reset;
  Cipher.Burn;
  Cipher.Free;
  Result := s;
End;

Function MatLst2Str(lst:TStringList):Widestring;
Var
  aStream : TMemoryStream;
begin
  Try
    aStream := TMemoryStream.Create;
    lst.SaveToStream(aStream);
    Result := EncodeStream(aStream);
  Finally
    aStream.Free;
  end;
End;
  
End.