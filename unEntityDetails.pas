unit unEntityDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  clsEntityDetails,
  Dialogs, Grids, JvExGrids, JvStringGrid, ToolWin, ComCtrls, JvExComCtrls,
  JvToolBar, jvStrings, StdCtrls;

type
  TfrmEntityDetails = class(TForm)
    JvToolBar1: TJvToolBar;
    gridEntityDetails: TJvStringGrid;
    tbOpen: TToolButton;
    ToolButton2: TToolButton;
    edtEntityFile: TEdit;
    procedure gridEntityDetailsClick(Sender: TObject);
    procedure tbOpenClick(Sender: TObject);
    procedure gridEntityDetailsDblClick(Sender: TObject);
  private
    { Private declarations }
    function emptyLine(s:string):boolean;
  public
    { Public declarations }
    EntityDetails : TEntityDetails;
    procedure populateEntityDetails(filename:string);
    procedure populateGrid;
  end;

var
  frmEntityDetails: TfrmEntityDetails;

implementation
Uses
  unMain, formEditor;

{$R *.dfm}

function TfrmEntityDetails.emptyLine(s: string): boolean;
Var
  isEmpty : boolean;
begin
  if (s = '  ') or
     (s = '   ') or
     (s = '    ') or
     (s = #09) or
     (s = #09#09) or
     (s = #09#09#09) then
       isEmpty := true
  else
    isEmpty := false;
  Result := isEmpty;
end;

procedure TfrmEntityDetails.gridEntityDetailsClick(Sender: TObject);
Var
  SStat : TShiftState;
begin
  if Form1.cbSort.Checked = true then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
  SStat := KeyboardStateToShiftState;
  If SStat = [ssCtrl..ssLeft] then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
end;

procedure TfrmEntityDetails.populateEntityDetails(filename: string);
{Var
  //aFileList, iAnimList : TStringList;
  i, iAnimLineNumber : integer;
  iAnimStart : Boolean;
  sCurrentLine : String;}
begin
  {edtEntityFile.Text := filename;
  aFileList := TStringList.Create;
  iAnimList := TStringList.Create;
  iAnimStart := false;
  Caption := ExtractFileName(filename);}
  edtEntityFile.Text := filename;
  if EntityDetails = nil then
    EntityDetails := TEntityDetails.create
  else
    EntityDetails.list.Clear;
  EntityDetails := EntityDetails.loadEntitryDetails(filename);
  {aFileList.LoadFromFile(filename);
  for i := 0 to aFileList.count -1 do Begin
    sCurrentLine := LowerCase(aFileList.Strings[i]);
    Form1.StringDelete2End(sCurrentLine,'#');
    if emptyLine(sCurrentLine) then
      sCurrentLine := '';
    //Search for anim details
    //Search for a Entity creation position
        if PosStr('anim',sCurrentLine) > 0 then Begin
          iAnimStart := True;
          iAnimLineNumber := i;
        end;
        //Add entity data into datalist
        if iAnimStart = true then Begin
          iAnimList.Add(sCurrentLine);
        end;
        //Check for end of Entity state
        if (iAnimStart = true) and
           (sCurrentLine = '') then Begin
          iAnimStart := false;
          EntityDetails.addData(iAnimList, iAnimLineNumber);
          iAnimLineNumber := 0;
          iAnimList.Clear;
        end;
  end;}
  populateGrid;
  {iAnimList.Free;
  aFileList.Free;}
end;

procedure TfrmEntityDetails.populateGrid;
Var
  i : integer;
  currentEntity : TEntityDetail;
begin
  if EntityDetails <> nil then Begin
    gridEntityDetails.RowCount := 2;
    gridEntityDetails.ColCount := 2;
    gridEntityDetails.ColCount := 6;
    gridEntityDetails.Cells[0,0] := 'Line Number';
    gridEntityDetails.Cells[1,0] := 'Anime Name';
    gridEntityDetails.Cells[2,0] := 'Total Frames';
    gridEntityDetails.Cells[3,0] := 'Total Delay';
    gridEntityDetails.Cells[4,0] := 'Total Damage';
    gridEntityDetails.Cells[5,0] := 'Total Hits';
    for i := 0 to EntityDetails.list.Count -1 do Begin
      currentEntity := (EntityDetails.list.Objects[i] as TEntityDetail);
      gridEntityDetails.Cells[0,gridEntityDetails.RowCount] := IntToStr(currentEntity.LineNumber);
      gridEntityDetails.Cells[1,gridEntityDetails.RowCount] := currentEntity.animeName;
      gridEntityDetails.Cells[2,gridEntityDetails.RowCount] := IntToStr(currentEntity.totalFrames);
      gridEntityDetails.Cells[3,gridEntityDetails.RowCount] := IntToStr(currentEntity.totalDelay);
      gridEntityDetails.Cells[4,gridEntityDetails.RowCount] := IntToStr(currentEntity.totalDamage);
      gridEntityDetails.Cells[5,gridEntityDetails.RowCount] := IntToStr(currentEntity.totalSeparateHits);
      gridEntityDetails.RowCount := gridEntityDetails.RowCount + 1;
    end;
  end;
end;

procedure TfrmEntityDetails.tbOpenClick(Sender: TObject);
begin
  if Form1.JvOpenDialog1.Execute then Begin
    populateEntityDetails(Form1.JvOpenDialog1.FileName);
  end;
end;

procedure TfrmEntityDetails.gridEntityDetailsDblClick(Sender: TObject);
Var
  searchName:string;
  i : integer;
begin
  try
    searchName := edtEntityFile.Text;
    i := StrToInt((Sender as TJvStringGrid).Cells[0,(Sender as TJvStringGrid).Row]);
    frmEditor.populateEditor(searchName,i);
    frmEditor.Show;
  except
  end;
end;



end.