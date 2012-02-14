unit formStairs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvSpin, Buttons;

type
  TfrmStairs = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    spnX: TJvSpinEdit;
    spnY: TJvSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    spnRear: TJvSpinEdit;
    spnFront: TJvSpinEdit;
    Label3: TLabel;
    Label4: TLabel;
    cbDirection: TComboBox;
    Label5: TLabel;
    spnCount: TJvSpinEdit;
    Label6: TLabel;
    spnDepth: TJvSpinEdit;
    Label7: TLabel;
    Label8: TLabel;
    spnHeight: TJvSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    rsltList : TStringList;
  end;

var
  frmStairs: TfrmStairs;

implementation

{$R *.dfm}

procedure TfrmStairs.FormCreate(Sender: TObject);
begin
  rsltList := TStringList.Create;
  cbDirection.ItemIndex := 0;
end;

procedure TfrmStairs.BitBtn2Click(Sender: TObject);
begin
  rsltList.Clear;
end;

procedure TfrmStairs.BitBtn1Click(Sender: TObject);
Var
  s : string;
  i : integer;
  x, y, depth, aheight : integer;
begin
  //#     {xpos} {ypos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{height}
  //#wall   240    260       0          0          30           30          40    80
  rsltList.Clear;
  x := spnX.AsInteger;
  y := spnY.AsInteger;
  if cbDirection.ItemIndex = 0 then Begin
    for i := 1 to spnCount.AsInteger do Begin
      x := x + ( spnFront.AsInteger );
      {if i > 1 then
        y := y - ( spnHeight.AsInteger );}
      depth := spnDepth.AsInteger;
      aheight := spnHeight.AsInteger;
      s := 'wall' + #09
          + IntToStr(x) //X
          + ' '
          + IntToStr(y) //Y
          + ' '
          + IntToStr(-spnRear.AsInteger ) //UPPERLEFT
          + ' '
          + IntToStr(-spnFront.AsInteger) //lowerleft
          + ' 0 0'
          //+ IntToStr(spnRear.AsInteger) // upper right
          + ' '
          //+ IntToStr(spnFront.AsInteger) // lower right
          + ' '
          + IntToStr(depth)
          + ' '
          + IntToStr(spnHeight.AsInteger * i);
      rsltList.Add(s);
    end
  end else Begin
    for i := 1 to spnCount.AsInteger do Begin
      x := x - ( spnFront.AsInteger );
      {if i > 1 then
        y := y - ( spnHeight.AsInteger );}
      depth := spnDepth.AsInteger;
      aheight := spnHeight.AsInteger;
      s := 'wall' + #09
          + IntToStr(x) //X
          + ' '
          + IntToStr(y) //Y
          + ' 0 0'
          //+ IntToStr(-spnRear.AsInteger ) //UPPERLEFT
          + ' '
          //+ IntToStr(-spnFront.AsInteger) //lowerleft
          //+ ' 0 0'
          + IntToStr(spnRear.AsInteger) // upper right
          + ' '
          + IntToStr(spnFront.AsInteger) // lower right
          + ' '
          + IntToStr(depth)
          + ' '
          + IntToStr(spnHeight.AsInteger * i);
      rsltList.Add(s);
    end
  end;
end;









end.
