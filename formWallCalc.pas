unit formWallCalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;


type
  sArray= array of string;

  TfrmWallCalc = class(TForm)
    edtSane: TEdit;
    Label1: TLabel;
    edtBor: TEdit;
    btnSane2Bor: TButton;
    btnBor2Sane: TButton;
    procedure btnSane2BorClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmWallCalc: TfrmWallCalc;

implementation

{$R *.dfm}

function Split(s:string; delim: string):sarray;
var l,p:dword;
begin
   l:=0;
   while s <> '' do begin
      p := pos(delim,s);
      if p = 0 then p := length(s) + 1;
      inc(l);
      setlength(result,l);
      result[l-1]:=copy(s,1,p-1);
      delete(s,1,p);
   end;
end;

function sane2Bor(topleft, bottomleft, topright, bottomright: TPoint) : string;
var
  //depth: double;
  depth: integer;
begin
  //depth := sqrt( power(topleft.x - bottomleft.x, 2) + power(topleft.y - bottomleft.y, 2));
  depth := abs(topleft.Y - bottomleft.Y);
  result := Format('%d %d %d %d %d %d %d',
    [
    bottomleft.x, // x
    bottomleft.y, //z
    topleft.x - bottomleft.x, // upperleft
    0,         // lowerleft
    topright.x - bottomleft.x, //upperright
    bottomright.x - bottomleft.x, //lowerright
    depth
    ]
  );
end;

procedure TfrmWallCalc.btnSane2BorClick(Sender: TObject);
var
 list, list2 : sarray;
 coords: array[0..3] of TPoint;
 i : integer;
 label syntax;
begin
 list := split(edtSane.Text, ' ');
 if length(list) <> 4 then begin
   syntax:
   showmessage('syntax error')
 end
 else for i := 0 to 3 do begin
   list2 := split(list[i], ',');
   if length(list2) <> 2 then goto syntax;
   coords[i].x := strtoint(list2[0]);
   coords[i].y := strtoint(list2[1]);
 end;
 edtBor.Text := sane2bor(coords[0],coords[1],coords[2],coords[3]); 
end;

end.
