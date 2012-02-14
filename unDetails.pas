unit unDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, JvExGrids, JvStringGrid, clsLevels, unLevels, StdCtrls,
  ComCtrls, ToolWin, JvExComCtrls, JvToolBar;

type
  TfrmLevelSub = class(TForm)
    GridLevelsSub: TJvStringGrid;
    JvToolBar1: TJvToolBar;
    edtFileName: TEdit;
    procedure GridLevelsSubClick(Sender: TObject);
    procedure GridLevelsSubDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure populateData(aData : TLevelData;fileName:String);
  end;

var
  frmLevelSub: TfrmLevelSub;

implementation

uses unMain, formEditor;

{$R *.dfm}

{ TfrmLevelSub }

procedure TfrmLevelSub.populateData(aData: TLevelData;fileName:String);
Var
  i : integer;
  aDataSub : TLevelDataSub;
begin
  Form1.JvOpenDialog1.InitialDir := ExtractFilePath(fileName);
  edtFileName.Text := fileName;
  GridLevelsSub.ColCount := 2;
  GridLevelsSub.RowCount := 2;
  GridLevelsSub.ColCount := 8;
  GridLevelsSub.Cells[0,0] := 'Line Number';
  GridLevelsSub.Cells[1,0] := 'coords';
  GridLevelsSub.Cells[2,0] := 'at';
  GridLevelsSub.Cells[3,0] := 'alias';
  GridLevelsSub.Cells[4,0] := 'health';
  GridLevelsSub.Cells[5,0] := 'map';
  GridLevelsSub.Cells[6,0] := 'item';
  GridLevelsSub.Cells[7,0] := 'boss';
  if aData <> nil then Begin
    for i := 0 to aData.aSub.Count -1 do Begin
      aDataSub := (aData.aSub.Objects[i] as TLevelDataSub);
      GridLevelsSub.Cells[0,GridLevelsSub.RowCount] := IntToStr(aDataSub.LineNumber);
      GridLevelsSub.Cells[1,GridLevelsSub.RowCount] := aDataSub.coOrds;
      GridLevelsSub.Cells[2,GridLevelsSub.RowCount] := aDataSub.at;
      GridLevelsSub.Cells[3,GridLevelsSub.RowCount] := aDataSub.alias;
      GridLevelsSub.Cells[4,GridLevelsSub.RowCount] := aDataSub.health;
      GridLevelsSub.Cells[5,GridLevelsSub.RowCount] := aDataSub.map;
      GridLevelsSub.Cells[6,GridLevelsSub.RowCount] := aDataSub.item;
      GridLevelsSub.Cells[7,GridLevelsSub.RowCount] := aDataSub.boss;
      GridLevelsSub.RowCount := GridLevelsSub.RowCount + 1;
    end;
  end;
end;

procedure TfrmLevelSub.GridLevelsSubClick(Sender: TObject);
Var
  SStat : TShiftState;
begin
  if Form1.cbSort.Checked = true then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
  SStat := KeyboardStateToShiftState;
  If SStat = [ssCtrl..ssLeft] then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
end;

procedure TfrmLevelSub.GridLevelsSubDblClick(Sender: TObject);
Var
  searchName:string;
  i : integer;
begin
  try
    searchName := edtFileName.Text;
    i := StrToInt((Sender as TJvStringGrid).Cells[0,(Sender as TJvStringGrid).Row]);
    frmEditor.populateEditor(searchName,i);
    frmEditor.Show;
  except
  end;
end;

end.
