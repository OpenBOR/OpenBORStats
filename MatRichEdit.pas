unit MatRichEdit;//V0.05
//Pls note this uses the jedi's JvRichEdit Component

interface

uses
  Windows, SysUtils, Classes, JvRichEdit, ComCtrls;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
Procedure MatFontsGet(var FontLizt:Tstringlist);



function CurrText(RichEdt: TJvRichEdit ): TJvTextAttributes;

implementation

//Use this to get the selected text's attributes
function CurrText(RichEdt: TJvRichEdit ): TJvTextAttributes;
Begin
  if RichEdt.SelLength > 0 then
    Result := RichEdt.SelAttributes
  else
    Result := RichEdt.WordAttributes;
End;

//What it does
 //part of MatFontsGet
function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
End;

//What it does
 //Gets a list of currently installed fonts on the system
Procedure MatFontsGet(var FontLizt:Tstringlist);
var
  DC: HDC;
begin
  DC := GetDC(0);
  FontLizt.Sorted := True;
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontLizt));
  ReleaseDC(0, DC);
End;




End.
