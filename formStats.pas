unit formStats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, Grids,
  unLevels, clsLevels, unCommon,
  xmlopenBorSystemClass, xmlopenBorSystem,
  jvStrings,
  JvExGrids, JvStringGrid, JvComCtrls, Menus;

type
  TfrmStats = class(TForm)
    JvPageControl1: TJvPageControl;
    tabEntity: TTabSheet;
    gridEntity: TJvStringGrid;
    tablevel: TTabSheet;
    GridLevels: TJvStringGrid;
    JvToolBar2: TJvToolBar;
    ToolButton2: TToolButton;
    Label1: TLabel;
    cbLevels: TComboBox;
    popEntity: TPopupMenu;
    EditCharacter1: TMenuItem;
    ViewDetails1: TMenuItem;
    N1: TMenuItem;
    Edit2: TMenuItem;
    Edit1: TMenuItem;
    Format1: TMenuItem;
    popLevelDetails: TPopupMenu;
    ViewDetails2: TMenuItem;
    N2: TMenuItem;
    Edit3: TMenuItem;
    EditFile1: TMenuItem;
    Format2: TMenuItem;
    procedure gridEntityClick(Sender: TObject);
    procedure gridEntityDblClick(Sender: TObject);
    procedure GridLevelsClick(Sender: TObject);
    procedure GridLevelsDblClick(Sender: TObject);
    procedure cbLevelsCloseUp(Sender: TObject);
    procedure cbLevelsChange(Sender: TObject);
    procedure EditCharacter1Click(Sender: TObject);
    procedure ViewDetails1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Format1Click(Sender: TObject);
    procedure ViewDetails2Click(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure Format2Click(Sender: TObject);
    procedure EditFile1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    rEntitylist : TStringList;
    rDataList : TStringList;
    procedure createEntity(filename:String);
    procedure clearrDataList;
    function getListNumber(description:String):integer;
    procedure addEntityGridData(filename:String);
    procedure retrieveEntityData(filename:String);
    procedure populateEntityData(DataDir:string);
  public
    { Public declarations }
  end;

var
  frmStats: TfrmStats;

implementation

uses unMain, formCharacterEditor, unDetails, unEntityDetails, formEditor,
  formFormat;

{$R *.dfm}

procedure TfrmStats.gridEntityClick(Sender: TObject);
Var
  SStat : TShiftState;
begin
  if Form1.cbSort.Checked = true then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
  SStat := KeyboardStateToShiftState;
  If SStat = [ssCtrl..ssLeft] then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
end;

procedure TfrmStats.gridEntityDblClick(Sender: TObject);
Var
  searchName:string;
begin
  searchName := frmStats.gridEntity.Cells[0,gridEntity.Row];
  if FileExists(searchName) then Begin
    frmCharacterEditor.loadCharacterEntityFile(searchName);
    frmCharacterEditor.Show;
  end;
end;

procedure TfrmStats.GridLevelsClick(Sender: TObject);
Var
  SStat : TShiftState;
begin
  if Form1.cbSort.Checked = true then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
  SStat := KeyboardStateToShiftState;
  If SStat = [ssCtrl..ssLeft] then
    (sender as TJvStringGrid).SortGridByCols((sender as TJvStringGrid).Col);
end;

procedure TfrmStats.GridLevelsDblClick(Sender: TObject);
Var
  aData : TLevelData;
  searchName : string;
begin
  try
    searchName := GridLevels.Cells[1,GridLevels.Row];
    aData := aLevel.getData(searchName);
    frmLevelSub.populateData(aData,cbLevels.Text);
    frmLevelSub.show;
  except
  end;
end;

procedure TfrmStats.cbLevelsCloseUp(Sender: TObject);
begin
  retrieveLevelData(cbLevels.Items.Strings[cbLevels.ItemIndex]);
end;

procedure TfrmStats.cbLevelsChange(Sender: TObject);
begin
  if FileExists(cbLevels.Text) then
    retrieveLevelData(cbLevels.Text);
end;

procedure TfrmStats.EditCharacter1Click(Sender: TObject);
Var
  searchName:string;
begin
  try
    //frmCharacterEditor.JvPageControl1.ActivePageIndex := 0;
    searchName := frmStats.gridEntity.Cells[0,frmStats.gridEntity.Row];
    if FileExists(searchName) then Begin
      frmCharacterEditor.loadCharacterEntityFile(searchName);
      frmCharacterEditor.Show;
    end;
  except
  end;
end;

procedure TfrmStats.ViewDetails1Click(Sender: TObject);
Var
  searchName:string;
begin
  try
    searchName := (Sender as TJvStringGrid).Cells[0,(Sender as TJvStringGrid).Row];
    frmEntityDetails.populateEntityDetails(searchName);
    frmEntityDetails.show;
    Form1.JvOpenDialog1.InitialDir := ExtractFilePath(searchName);
  except
  end;

end;

procedure TfrmStats.Edit2Click(Sender: TObject);
Var
  searchName:string;
begin
  searchName := frmStats.gridEntity.Cells[0,frmStats.gridEntity.Row];
  if FileExists(searchName) then Begin
    frmEditor.populateEditor(searchName);
    frmEditor.Show;
  end;
end;

procedure TfrmStats.Edit1Click(Sender: TObject);
Var
  searchName:string;
begin
  searchName := frmStats.gridEntity.Cells[0,frmStats.gridEntity.Row];
  if FileExists(searchName) then Begin
    exeApp(searchName);
  end;
end;

procedure TfrmStats.Format1Click(Sender: TObject);
Var
  searchName:string;
begin
    searchName := frmStats.gridEntity.Cells[0,frmStats.gridEntity.Row];
    if FileExists(searchName) then Begin
      frmFormat.populateFile(searchName);
      frmFormat.Show;
    end;
end;

procedure TfrmStats.ViewDetails2Click(Sender: TObject);
begin
  frmStats.GridLevelsDblClick(frmStats.GridLevels);
end;

procedure TfrmStats.Edit3Click(Sender: TObject);
Begin
  if FileExists(frmStats.cbLevels.Text) then Begin
    frmEditor.populateEditor(frmStats.cbLevels.Text);
    frmEditor.Show;
  end;
end;

procedure TfrmStats.Format2Click(Sender: TObject);
Begin
  if FileExists(frmStats.cbLevels.Text) then Begin
    frmFormat.populateFile(frmStats.cbLevels.Text);
    frmFormat.Show;
  end;
end;

procedure TfrmStats.EditFile1Click(Sender: TObject);
begin
    if FileExists(frmStats.cbLevels.Text) then
    exeApp(frmStats.cbLevels.Text);
end;

procedure TfrmStats.populateEntityData(DataDir: string);
var
  s : string;
  i : integer;
begin
  if DirectoryExists(DataDir) then Begin
    ses.dataDirecotry := DataDir;
    //Create Entity columns
    createEntity(ExtractFileDir(Application.ExeName)+'\Entity header.txt');
    //Search for and populate all Entity files
    Form1.JvSearchFiles1.FileParams.FileMasks.Text := '*.txt';
    Form1.JvSearchFiles1.RootDirectory := DataDir + '\chars\';
    Form1.JvSearchFiles1.Search;
    for i := 0 to Form1.JvSearchFiles1.Files.Count -1 do Begin
      s := Form1.JvSearchFiles1.Files[i];
      retrieveEntityData(s);
    end;
    //Search for and populate all Level files
    Form1.JvSearchFiles1.RootDirectory := DataDir + '\hard\';
    Form1.JvSearchFiles1.Search;
    if Form1.JvSearchFiles1.Files.Count = 0 then Begin
      Form1.JvSearchFiles1.RootDirectory := DataDir + '\levels\';
      Form1.JvSearchFiles1.Search;
    end;
    if Form1.JvSearchFiles1.Files.Count = 0 then Begin
      Form1.JvSearchFiles1.RootDirectory := form1.LevelDirectory;
      Form1.JvSearchFiles1.Search;
    end;
    cbLevels.Items.Assign(Form1.JvSearchFiles1.Files);

  end;
end;

procedure TfrmStats.createEntity(filename: String);
Var
  i : integer;
begin
  try
    if FileExists(filename) then Begin
      rEntitylist.LoadFromFile(filename);
      rEntitylist := stripEmptyLines(rEntitylist);
      for i := 0 to rEntitylist.Count -1 do begin
        rDataList.Add('');
      end;
      frmStats.gridEntity.ColCount := rEntitylist.Count +1;
      for i := 0 to rEntitylist.Count -1 do Begin
        frmStats.gridEntity.Cells[i+1,0] := rEntitylist.Strings[i];
      end;
      frmStats.gridEntity.RowCount := 2;
    end else
      ShowMessage('"Entity header.txt" file not found!');
  finally
  end;
end;

procedure TfrmStats.retrieveEntityData(filename: String);
Var
  aList : TStringList;
  i, iEntityID : integer;
  s : string;
begin
  try
    aList := TStringList.Create;
    clearrDataList;
    if FileExists(filename) then Begin
      aList.LoadFromFile(filename);
      for i := 0 to aList.Count -1 do begin
        s := aList.Strings[i];
        iEntityID := getListNumber(s);
        if iEntityID >= 0 then Begin
          StringReplace(s,rEntitylist.Strings[iEntityID],'',false);
          StringReplace(s,'  ','',false);
          StringReplace(s,#09,'',false);
          StringReplace(s,#11,'',false);
          StringReplace(s,#13,'',false);
          StringDeleteFirstChar(s,' ');
          StringDeleteLastChar(s,' ');
          rDataList.Strings[iEntityID] := s;
        end;
      end;
      addEntityGridData(filename);
    end;
    aList.Free;
  finally
  end;
end;

procedure TfrmStats.clearrDataList;
Var
  i : integer;
begin
  for i := 0 to rDataList.Count -1 do Begin
    rDataList.Strings[i] := '';
  end;
end;

function TfrmStats.getListNumber(description: String): integer;
Var
  i, iFound, iText : integer;
  foundstr, s : string;
begin
  iFound := -1;
  i := 0;
  description := LowerCase(description);
  while i < rEntitylist.Count do Begin
    s := rEntitylist.Strings[i];
    iText := PosText(s,description);
    foundstr := copy(description,iText,Length(s));
    if iText > 0 then Begin
     //s[start]in delims)
      if description[iText + length(s)] in delims = true then Begin
        iFound := i;
        i := rEntitylist.Count;
      end;

  end;
  inc(i);
  end;

  Result := iFound;
end;

procedure TfrmStats.addEntityGridData(filename: String);
Var
  i : integer;
begin
  //gridEntity.Cells[0,gridEntity.RowCount-1] := ExtractFileName(filename);
  gridEntity.Cells[0,frmStats.gridEntity.RowCount-1] := filename;
  for i := 0 to rDataList.Count -1 do Begin
    gridEntity.Cells[i+1,frmStats.gridEntity.RowCount-1] := rDataList.Strings[i];
  end;
  gridEntity.RowCount := frmStats.gridEntity.RowCount +1;
end;

procedure TfrmStats.FormCreate(Sender: TObject);
begin
  rDataList := TStringList.Create;
  rEntitylist := TStringList.Create;
end;

procedure TfrmStats.FormShow(Sender: TObject);
begin
  populateEntityData(Form1.edtDirectory.Text);//.Strings[Form1.edtDirectory.ItemIndex]);
end;

end.
