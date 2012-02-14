unit unMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls,
  unLevels, clsLevels, unCommon, clsModels, clstreeProjectVst,
  clsLevelsHeader, clsEntityDetails, clsVideo, clsLevelDesign,
  xmlopenBorSystemClass, xmlopenBorSystem, frameEditor, clsopenBorSystemVst,
  jvstrings, Grids, JvExGrids, JvStringGrid, StdCtrls, Mask, JvExMask,
  JvToolEdit, JvBaseDlg, JvSelectDirectory, ImgList, JvComponentBase,
  JvSearchFiles, JvBrowseFolder, Menus, JvExControls, JvComponent,
  JvArrowButton, JvDialogs, inifiles, GraphicEx, JvComputerInfoEx,
  ActnList, XPStyleActnCtrls, ActnMan, JvBalloonHint, VirtualTrees,
  ExtCtrls, formLevelDesign, CoolTrayIcon, pngextra, JvThread;

type
  rSession = record
  borSys : aXmlopenBorSystem;
  video : Tvideo;
  characterDir : string;
  //Directories
  dataDirecotry, localDir, openBorData, openBorTestApp, testDir : String;
  modelsFile, levelFile, videoFile : String;
  ropenBorSystemSelected : ropenBorSystem;
  workingEntityDetail : TEntityDetail;
  currentLeveldesign : TLevelDesign;
  reloadsystem : boolean;
end;

type
  TForm1 = class(TForm)
    JvToolBar1: TJvToolBar;
    tbClear: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    JvSearchFiles1: TJvSearchFiles;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    ToolButton4: TToolButton;
    btnExecuteBor: TJvArrowButton;
    PopupMenu1: TPopupMenu;
    ExportEntitycsv1: TMenuItem;
    JvSaveDialog1Csv: TJvSaveDialog;
    ExportLevelcsv1: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Help1: TMenuItem;
    License1: TMenuItem;
    About1: TMenuItem;
    cbSort: TCheckBox;
    JvOpenDialog1: TJvOpenDialog;
    JvSaveDialog1: TJvSaveDialog;
    btnImport: TJvArrowButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    popImport: TPopupMenu;
    Mugen1: TMenuItem;
    Multiple1: TMenuItem;
    AirFileSingle1: TMenuItem;
    JvComputerInfoEx1: TJvComputerInfoEx;
    jvOpenImport: TJvOpenDialog;
    edtDirectory: TComboBox;
    ActionManager1: TActionManager;
    actNextFrame: TAction;
    actPreviousFrame: TAction;
    JvBalloonHint1: TJvBalloonHint;
    ools1: TMenuItem;
    SystemEditor1: TMenuItem;
    actFrames: TAction;
    actEditor: TAction;
    actPreviousAnim: TAction;
    actNextAnim: TAction;
    StatsViewer1: TMenuItem;
    JvPageControl1: TJvPageControl;
    tabmain: TTabSheet;
    vstProject: TVirtualStringTree;
    tabEditor: TTabSheet;
    pnlEditor: TPanel;
    popProject: TPopupMenu;
    FormatFactory1: TMenuItem;
    estFactory1: TMenuItem;
    estFactory2: TMenuItem;
    actTest: TAction;
    CoolTrayIcon1: TCoolTrayIcon;
    btnRefresh: TToolButton;
    ToolButton7: TToolButton;
    N1: TMenuItem;
    LevelEditor1: TMenuItem;
    CharacterEditor1: TMenuItem;
    MainScreen1: TMenuItem;
    ToolButton8: TToolButton;
    ExecuteProjectOpenBor1: TMenuItem;
    JvArrowButton2: TJvArrowButton;
    popOpenBor: TPopupMenu;
    ExecuteOpenBorexe1: TMenuItem;
    ViewErrorLog1: TMenuItem;
    ViewScriptLog1: TMenuItem;
    FileCheck1: TMenuItem;
    JvThread1: TJvThread;
    LevelHudDesign1: TMenuItem;
    N2: TMenuItem;
    ImportPak1: TMenuItem;
    N3: TMenuItem;
    Donate1: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbClearClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure edtDirectory1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExportEntitycsv1Click(Sender: TObject);
    procedure cbLevelsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ExportLevelcsv1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure License1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure AirFileSingle1Click(Sender: TObject);
    procedure Multiple1Click(Sender: TObject);
    procedure edtDirectoryKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDirectoryCloseUp(Sender: TObject);
    procedure actNextFrameExecute(Sender: TObject);
    procedure actPreviousFrameExecute(Sender: TObject);
    procedure SystemEditor1Click(Sender: TObject);
    procedure actFramesExecute(Sender: TObject);
    procedure actEditorExecute(Sender: TObject);
    procedure actNextAnimExecute(Sender: TObject);
    procedure actPreviousAnimExecute(Sender: TObject);
    procedure StatsViewer1Click(Sender: TObject);
    procedure vstProjectDblClick(Sender: TObject);
    procedure JvPageControl1Change(Sender: TObject);
    procedure vstProjectPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure FormatFactory1Click(Sender: TObject);
    procedure estFactory1Click(Sender: TObject);
    procedure JvPageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure actTestExecute(Sender: TObject);
    procedure CoolTrayIcon1Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure LevelEditor1Click(Sender: TObject);
    procedure CharacterEditor1Click(Sender: TObject);
    procedure MainScreen1Click(Sender: TObject);
    procedure btnExecuteBorClick(Sender: TObject);
    procedure ViewErrorLog1Click(Sender: TObject);
    procedure ViewScriptLog1Click(Sender: TObject);
    procedure vstProjectAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellRect: TRect);
    procedure vstProjectMeasureItem(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
    procedure vstProjectResize(Sender: TObject);
    procedure vstProjectScroll(Sender: TBaseVirtualTree; DeltaX,
      DeltaY: Integer);
    procedure FileCheck1Click(Sender: TObject);
    procedure JvThread1Execute(Sender: TObject; Params: Pointer);
    procedure LevelHudDesign1Click(Sender: TObject);
    procedure ImportPak1Click(Sender: TObject);
    procedure Donate1Click(Sender: TObject);
  private
    { Private declarations }
    localDir : string;
    rEntitylist : TStringList;
    rDataList : TStringList;
    treeProject : TclstreeProjectVst;


    nodeModels, nodeLevelHeader : PVirtualNode;

    procedure clearrDataList;

    procedure iniLoad;
    procedure iniSave;

    procedure createEntity(filename:String);
    procedure retrieveEntityData(filename:String);
    procedure addEntityGridData(filename:String);
    function getListNumber(description:String):integer;
    procedure addopenBorProject(dataDir:String);

    procedure importPakFile(filename:String);
  public
    { Public declarations }
    //abcdefghijklmnopqrstuvwxyz0123456789@
    frameEditor : TfrmEditorSyn;
    LevelDirectory : string;
    xSystem : aXmlopenBorSystem;
    models : TModelssData;
    Levels : TLevelHeadersData;
    procedure addSubGroupsEntity(parentNode:PVirtualNode;listData:TStringList;treeType:integer;treecls:TObject);
    function getSubGroupsEntity(parentNode:PVirtualNode;Title:String;treeType:integer;vstTree:TVirtualStringTree):PVirtualNode;

    Procedure StringReplace(Var Str:string;ExistingStr :String; ReplaceWith:String;Single:Boolean=false); Overload;
    function stripEmptyLines(list:TStringList):TStringList;
    Procedure StringDeleteFirstChar(Var StrLine:String;ExistingStr:String);
    Procedure StringDeleteLastChar(Var StrLine:String;ExistingStr:String);
    Procedure StringDelete2End(Var StrLine:String;SubtractStr:String); Overload;
    Procedure StringDeleteUp2(Var StrLine:String;SubtractStr:String;Xtra:integer=-1);

    procedure populateEntityData(DataDir:string);

    //Load
    procedure loadProject(projectDir:String);
    procedure loadEditor(Node:PVirtualNode);

    function getnodefromtitle(titlename:string):ptreeProject;
  end;

var
  Form1: TForm1;
  delims:set of char=[' ',',','.',';',':','(',')',#11,#13,#09];
  validKeys:set of char=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
  ses : rSession;

implementation

uses unDetails, unEntityDetails, formFormat, formEditor, formImport,
  formCharacterEditor, formSystemEditor, formStats, formTestFactory, Types,
  untFndFileVst, unHudDesign;

{$R *.dfm}

{ TForm1 }



procedure TForm1.createEntity(filename: String);
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
      if frmStats <> nil then
        if frmStats.gridEntity <> nil then Begin
          frmStats.gridEntity.ColCount := rEntitylist.Count +1;
          for i := 0 to rEntitylist.Count -1 do Begin
            frmStats.gridEntity.Cells[i+1,0] := rEntitylist.Strings[i];
          end;
          frmStats.gridEntity.RowCount := 2;
      end;
    end else
      ShowMessage('"Entity header.txt" file not found!');
  finally
  end;
end;

function TForm1.stripEmptyLines(list: TStringList): TStringList;
Var
  i : Integer;
Begin
  i := 0;
  try
  while i < list.Count do Begin
    try
      if list.Strings[i] = '' then
        list.Delete(i)
      else
        inc(i);
    except
      inc(i);
    end;
  end;
  finally
    Result := list;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.HintHidePause := 10000;
  rDataList := TStringList.Create;
  rEntitylist := TStringList.Create;
  localDir := ExtractFileDir(Application.ExeName);
  ses.localDir := localDir;
  config.iView := localDir + '\Tools\i_view32.exe';
  config.sffExtract := localDir + '\Tools\sffextract.exe';
  config.tempDirectory := JvComputerInfoEx1.Folders.Temp;
  config.noValue := clMaroon;
  config.hasValue := clBlue;
  config.hasScript :=  clNavy;
  config.noImage := localDir + '\Res\no.gif';
  config.imageDir := localDir + '\Res';
  config.ofSetImage := '\offSet3.png';
  config.ofSetImagePrevious := '\offSetP.png';

  config.atBoxImage := '\attBox1.png';
  config.atBoxImagePrevious := '\attBoxP.png';
  config.bBoxImage := '\bBox1.png';
  config.bBoxImagePrevious := '\bBoxP.png';

  iniLoad;
  //xCodePro : aXmlCodePro;
  //xCodePro := xCodePro.Create(FrmInv.OpenDialog.FileName);
  //xPassBook : aXmlpassbook;
  //xPassBook := aXmlpassbook.Create(aFileName);
  //xSystem := aXmlopenBorSystem.Create(localDir+'\System\system.xml');

  ses.borSys := aXmlopenBorSystem.Create(localDir+'\System\system.xml');
  ses.openBorData := ses.localDir + '\Tools\OBor\data';
  ses.testDir := ses.localDir + '\Tools\Test';
  ses.openBorTestApp := localDir + '\Tools\OBor\OpenBOR.exe';
  ses.reloadsystem := true;

  frameEditor := TfrmEditorSyn.Create(pnlEditor);
  frameEditor.Parent := pnlEditor;
  frameEditor.Align := alClient;
  frameEditor.formCreate;
  vstProject := treeVisuals(vstProject); 
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //ses.borSys.SavetoFile(localDir+'\System\system.xml');

  rDataList.Free;
  rEntitylist.Free;
  iniSave;
end;

procedure TForm1.retrieveEntityData(filename: String);
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

function TForm1.getListNumber(description: String): integer;
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

procedure TForm1.StringReplace(var Str: string; ExistingStr,
  ReplaceWith: String; Single: Boolean);
Var
  j :Integer;
Begin
  j := Pos(Lowercase(ExistingStr),Lowercase(Str));
  If Single = false then Begin
   While j <> 0 Do
    Begin
    //Keep finding and replaceing the string
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
     j := Pos(Lowercase(ExistingStr),Lowercase(Str));
    End;
  End Else Begin
     delete(Str,j,length(ExistingStr));
     Insert(ReplaceWith, Str,j);
  End;
end;

procedure TForm1.clearrDataList;
Var
  i : integer;
begin
  for i := 0 to rDataList.Count -1 do Begin
    rDataList.Strings[i] := '';
  end;
end;

procedure TForm1.tbClearClick(Sender: TObject);
begin
  frmStats.gridEntity.RowCount := 2;
  frmStats.gridEntity.ColCount := 2;
end;

procedure TForm1.addEntityGridData(filename:String);
Var
  i : integer;
begin
  //gridEntity.Cells[0,gridEntity.RowCount-1] := ExtractFileName(filename);
  if frmStats <> nil then
    if frmStats.gridEntity <> nil then Begin
      frmStats.gridEntity.Cells[0,frmStats.gridEntity.RowCount-1] := filename;
      for i := 0 to rDataList.Count -1 do Begin
        frmStats.gridEntity.Cells[i+1,frmStats.gridEntity.RowCount-1] := rDataList.Strings[i];
      end;
      frmStats.gridEntity.RowCount := frmStats.gridEntity.RowCount +1;
  end;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if DirectoryExists(edtDirectory.Text) then
      JvBrowseForFolderDialog1.Directory := edtDirectory.Text;
  if JvBrowseForFolderDialog1.Execute then Begin
    addopenBorProject(JvBrowseForFolderDialog1.Directory);
    edtDirectory.Text := JvBrowseForFolderDialog1.Directory;
    //populateEntityData(edtDirectory.Text);
    loadProject(edtDirectory.Text);
  end;
  {if PosStr(' ',edtDirectory.Text) > 0 then

    showBubble('Warning','Space found in file path. Images may not display properly');}

end;

procedure TForm1.populateEntityData(DataDir: string);
var
  s : string;
  i : integer;
begin
  if DirectoryExists(DataDir) then Begin
    ses.dataDirecotry := DataDir;
    //Create Entity columns
    createEntity(ExtractFileDir(Application.ExeName)+'\Entity header.txt');
    //Search for and populate all Entity files
    JvSearchFiles1.FileParams.FileMasks.Text := '*.txt';
    JvSearchFiles1.RootDirectory := DataDir + '\chars\';
    JvSearchFiles1.Search;
    for i := 0 to JvSearchFiles1.Files.Count -1 do Begin
      s := JvSearchFiles1.Files[i];
      retrieveEntityData(s);
    end;
    //Search for and populate all Level files
    JvSearchFiles1.RootDirectory := DataDir + '\hard\';
    JvSearchFiles1.Search;
    if JvSearchFiles1.Files.Count = 0 then Begin
      JvSearchFiles1.RootDirectory := DataDir + '\levels\';
      JvSearchFiles1.Search;
    end;
    if JvSearchFiles1.Files.Count = 0 then Begin
      JvSearchFiles1.RootDirectory := LevelDirectory;
      JvSearchFiles1.Search;
    end;
    if frmStats <> nil then
      frmStats.cbLevels.Items.Assign(JvSearchFiles1.Files);

  end;
end;

procedure TForm1.edtDirectory1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Begin
    populateEntityData(edtDirectory.Text);
  end;
end;

procedure TForm1.ExportEntitycsv1Click(Sender: TObject);
begin
  if JvSaveDialog1Csv.Execute then
    frmStats.gridEntity.SaveToCSV(JvSaveDialog1Csv.FileName);
end;

procedure TForm1.iniLoad;
Var
  s : TIniFile;
  f : string;
  i : Integer;
begin
  s := TIniFile.Create(localDir+'\obConfig.ini');
  edtDirectory.Text := s.ReadString('Config','LastDir','Please select Data directory!');
  LevelDirectory := s.ReadString('Config','LevelDir','');
  config.mugen := s.ReadBool('Config','qckAdt',false);
  config.blankFiles := s.ReadString('Config','BlankFiles','gif');
  config.debugmode := s.ReadBool('sometimes','correct',false);
  if config.mugen = true then
    btnImport.Visible := true;
  if edtDirectory.Text = '.' then
    edtDirectory.Text := '';
  if DirectoryExists(edtDirectory.Text) then Begin
    JvBrowseForFolderDialog1.Directory := edtDirectory.Text;
    try
      populateEntityData(edtDirectory.Text);
      if frmStats <> nil then Begin
        frmStats.gridEntity.Row := s.ReadInteger('Config','EntityRow', 0);
        frmStats.cbLevels.text := s.ReadString('Config','LastLevel','Please select one from the drop down list or manually type a level with a valid path and press return!');
        if FileExists(frmStats.cbLevels.Text) then Begin
          retrieveLevelData(frmStats.cbLevels.Text);
          frmStats.GridLevels.Row := s.ReadInteger('Config','LevelRow', 0);
        end;
      end;
    except
    end;
  end;
  //Character editor
    //Charecter editor
  config.gifLocation := s.ReadInteger('charEditor','location',1);
  config.OffsetPic := s.ReadInteger('charEditor','offsetpic',0);
  config.bBoxInList := s.ReadBool('charEditor','bBoxList',true);
  //Pen details
  config.penColor := StringToColor(s.ReadString('Config','pencolor','00000000'));
  config.penWidth := s.ReadInteger('Config','penwidth',2);
  config.depthangle := s.ReadInteger('Config','depthAngel',10);
  s.ReadSection('Projects',edtDirectory.Items);
  for i := 0 to edtDirectory.Items.Count -1 do Begin
    f := s.ReadString('Projects',IntToStr(i),'');
    edtDirectory.Items.Strings[i] := f;
  end;
  s.Free;
end;

procedure TForm1.iniSave;
Var
  s : TIniFile;
  i : integer;
begin
  s := TIniFile.Create(localDir+'\obConfig.ini');
  s.WriteString('Config','LastDir',edtDirectory.Text);
  s.WriteString('Config','LevelDir',LevelDirectory);
  s.WriteInteger('Config','EntityRow', frmStats.gridEntity.Row);
  s.WriteInteger('Config','LevelRow', frmStats.GridLevels.Row);
  s.WriteString('Config','LastLevel',frmStats.cbLevels.text);
  s.WriteString('Config','BlankFiles',config.blankFiles);
  //Charecter editor
  s.WriteInteger('charEditor','location',config.gifLocation);
  s.WriteInteger('charEditor','offsetpic',config.OffsetPic);
  s.WriteBool('charEditor','bBoxList',config.bBoxInList);
  //Pen details
  s.WriteString('Config','pencolor',ColorToString(config.penColor));
  s.WriteInteger('Config','penwidth',config.penWidth);
  s.WriteInteger('Config','depthAngel',config.depthangle);
  //save projects
  s.EraseSection('Projects');
  for i := 0 to edtDirectory.Items.Count -1 do Begin
    s.WriteString('Projects',IntToStr(i),edtDirectory.Items.Strings[i]);
  end;
  s.Free;
end;

procedure TForm1.StringDelete2End(var StrLine: String;
  SubtractStr: String);
begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    Delete(StrLine,Pos(SubtractStr,StrLine),length(StrLine));
   End;
end;

procedure TForm1.StringDeleteFirstChar(var StrLine: String;
  ExistingStr: String);
Var
  s : String;
Begin
  if StrLine <> '' then Begin
    s := StrLine[1];
    While s = ExistingStr do Begin
      try
        if length(StrLine) > 0 then
          Delete(StrLine,1,1);
        if length(StrLine) > 0 then
          s := StrLine[1]
        else
          exit;  
      except
        s := '';
      end;
    End;
  end;
end;

procedure TForm1.StringDeleteLastChar(var StrLine: String;
  ExistingStr: String);
Var
  s : String;
Begin

  s := StrLine;
  if s <> '' then Begin
    if Length(StrLine) > 1 then
      s := StrLine[Length(StrLine)]
    else
      s := StrLine;
    While (s = ExistingStr) and
          (length(StrLine) > 0) do Begin
      Delete(StrLine,Length(StrLine),1);
      if length(StrLine) > 0 then
        s := StrLine[Length(StrLine)];
    End;
  end;

end;

procedure TForm1.cbLevelsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    retrieveLevelData(frmStats.cbLevels.Text);
end;

procedure TForm1.ExportLevelcsv1Click(Sender: TObject);
begin
  if JvSaveDialog1Csv.Execute then
    frmStats.GridLevels.SaveToCSV(JvSaveDialog1Csv.FileName);
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  JvSearchFiles1.FileParams.FileMasks.Text := '*.txt';
  if DirectoryExists(LevelDirectory) then
      JvBrowseForFolderDialog1.Directory := LevelDirectory;
  if JvBrowseForFolderDialog1.Execute then Begin
    LevelDirectory := JvBrowseForFolderDialog1.Directory;
    JvSearchFiles1.RootDirectory := LevelDirectory;
    JvSearchFiles1.Search;
    frmStats.cbLevels.Items.Assign(JvSearchFiles1.Files);
  end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.License1Click(Sender: TObject);
begin
  ShowMessage('This application is released under the Gnu V2 License!');
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  ShowMessage('Written by MatMan');
end;

procedure TForm1.StringDeleteUp2(var StrLine: String; SubtractStr: String;
  Xtra: integer);
begin
  If Pos(SubtractStr,StrLine) <> 0 then
   Begin
    if Xtra <> -1 then
      Delete(StrLine,1,Pos(SubtractStr,StrLine)+Xtra)
    else
      Delete(StrLine,1,Pos(SubtractStr,StrLine));
   End;
end;

procedure TForm1.Edit1Click(Sender: TObject);
Var
  searchName:string;
begin
    searchName := frmStats.gridEntity.Cells[0,frmStats.gridEntity.Row];
    if FileExists(searchName) then Begin
      exeApp(searchName);
    end;
end;

procedure TForm1.AirFileSingle1Click(Sender: TObject);
begin
  jvOpenImport.Filter := 'Mugen Char File(*.air)|*.air|All Files (*.*)|*.*';
  if jvOpenImport.Execute then Begin
    frmImport.importMugenCharacter(jvOpenImport.FileName);
    ShowMessage('Succesfully Imported, please manually add character to models.txt file ');
  end;
end;

procedure TForm1.Multiple1Click(Sender: TObject);
begin
  if JvBrowseForFolderDialog1.Execute then Begin
    frmImport.importMugenDirecotory(JvBrowseForFolderDialog1.Directory);
    frmImport.Show;
  End;
end;

procedure TForm1.edtDirectoryKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Begin
    populateEntityData(edtDirectory.Text);
  end;
end;

procedure TForm1.addopenBorProject(dataDir: String);
Var
  i : integer;
  s : string;
  found : boolean;
begin
  found := false;
  for i := 0 to edtDirectory.Items.Count -1 do begin
    s := LowerCase(edtDirectory.Items.Strings[i]);
    if s = LowerCase(dataDir) then
      found := true;
  end;
  if found = false then
    edtDirectory.Items.Add(dataDir);

end;

procedure TForm1.importPakFile(filename:String);
Var
  zFile : string;
  createDir, filenameDir : string;
  s : string;
begin
  zFile := LowerCase(filename);
  while Pos('\',zFile) <> 0 do begin
    StringDeleteUp2(zFile,'\');
  end;
  MatStringReplace(zFile,' ', '');
  MatStringReplace(zFile,'.pak', '');
  createDir := localDir+'\xtract\'+zFile;
  ForceDirectories(createDir);
  //CreateDirectory(Pchar(createDir),nil);
  //..\openBorStats\Tools>borpak.exe -d C:\Del\5 "H:\Del\6\CastleVania Pulse Of Animosity.PAK"
  //borpak.exe  -d "c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xtract\castlevaniapulseofanimosity" "H:\Del\6\CastleVania Pulse Of Animosity.PAK"
  s := '-d "' +LowerCase(createDir) + '" "' + filename + '"';
  //exeApp(localDir+'\Tools\borpak.exe', s);
  exeAppBor(localDir+'\Tools\borpak.exe',s,true,true);

  If MessageDlg('Click Yes once the DosBox window finish''s extracting all files?', MtConfirmation,
  [MbYes, MbNo],0) = MrYes Then
    Begin
      filenameDir := ExtractFilePath(filename) + '\data';
      if DirectoryExists(localDir+'\Tools\data\') = true then begin
        MoveDir(localDir+'\Tools\data',createDir, );
        //RenameFile(localDir+'\Tools\data\', createDir);
      end;
      //exeAppBor2('"'+localDir+'\Tools\borpak.exe" ' + s);
      edtDirectory.Items.Add(createDir + '\data');
      edtDirectory.Text := createDir + '\data';
    End



end;

procedure TForm1.edtDirectoryCloseUp(Sender: TObject);
begin
  try
  if edtDirectory.ItemIndex = -1 then
    edtDirectory.ItemIndex := 0;
  except
  end;
  if DirectoryExists(edtDirectory.Text) then Begin
    JvBrowseForFolderDialog1.Directory := edtDirectory.Text;
    //populateEntityData(edtDirectory.Items.Strings[edtDirectory.ItemIndex]);
    loadProject(edtDirectory.Items.Strings[edtDirectory.ItemIndex]);
  end;
  {if PosStr(' ',edtDirectory.Text) > 0 then
    showBubble('Warning','Space found in file path. Images may not display properly');}
end;

procedure TForm1.actNextFrameExecute(Sender: TObject);
begin
  if frmCharacterEditor.Visible = True then Begin
    frmCharacterEditor.formSave;
    frmCharacterEditor.FrameSelectNext;
  end;
end;

procedure TForm1.actPreviousFrameExecute(Sender: TObject);
begin
  if frmCharacterEditor.Visible = True then Begin
    frmCharacterEditor.formSave;
    frmCharacterEditor.FrameSelectprevious;
  end;
end;

procedure TForm1.SystemEditor1Click(Sender: TObject);
begin
  frmSystemEditor.setMode(1);
  frmSystemEditor.show;
end;

procedure TForm1.actFramesExecute(Sender: TObject);
begin
  if frmCharacterEditor.Visible = true then Begin
    frmCharacterEditor.formSave;
    frmCharacterEditor.JvPageControl1.ActivePageIndex := 0;
    frmCharacterEditor.JvPageControl1Change(frmCharacterEditor.JvPageControl1);
  end;
  if Form1.Visible = true then Begin
    JvPageControl1.ActivePageIndex := 0;
    JvPageControl1Change(JvPageControl1);
  end;
end;

procedure TForm1.actEditorExecute(Sender: TObject);
begin
  if frmCharacterEditor.Visible = true then Begin
    frmCharacterEditor.formSave;
    frmCharacterEditor.JvPageControl1.ActivePageIndex := 1;
    frmCharacterEditor.JvPageControl1Change(frmCharacterEditor.JvPageControl1);
  end;
  if Form1.Visible = true then Begin
    JvPageControl1.ActivePageIndex := 1;
    JvPageControl1Change(JvPageControl1);
  end;
end;

procedure TForm1.actNextAnimExecute(Sender: TObject);
Var
  allow : boolean;
begin
  if frmCharacterEditor.Visible = true then Begin
    frmCharacterEditor.animSelect(frmCharacterEditor.vstAnimList.FocusedNode,true);
  end;
  if Form1.Visible = true then Begin
    JvPageControl1Changing(JvPageControl1,allow);
    vstProject.FocusedNode := vstProject.GetNext(vstProject.FocusedNode);
    loadEditor(vstProject.FocusedNode);
  end;
end;

procedure TForm1.actPreviousAnimExecute(Sender: TObject);
Var
  allow : boolean;
begin
  if frmCharacterEditor.Visible = true then Begin
    frmCharacterEditor.animSelect(frmCharacterEditor.vstAnimList.FocusedNode,False);
  end;
  if Form1.Visible = true then Begin
    JvPageControl1Changing(JvPageControl1,allow);
    vstProject.FocusedNode := vstProject.GetPrevious(vstProject.FocusedNode);
    loadEditor(vstProject.FocusedNode);
  end;
end;

procedure TForm1.StatsViewer1Click(Sender: TObject);
begin
  frmStats.Show;
end;

procedure TForm1.loadProject(projectDir: String);
Var
  i,j, iNum : integer;
  rData : TModelsData;
  lData : TLevelHeaderSet;
  groupNode : PVirtualNode;
  rProjectData : rtreeProject;
  aList : TStringList;
  s : string;
begin
  Try
    vstProjectResize(nil);
    if PosStr(' ',projectDir) > 0 then
      ShowMessage('Warning! Space''s found in file the path. Images may not display properly!');
      //showBubble('Warning','Space found in file path. Images may not display properly!');
    Screen.Cursor := crHourGlass;
    if DirectoryExists(projectDir) then Begin
      vstProject.Clear;
      ses.dataDirecotry := projectDir;
      ses.modelsFile := projectDir + '\models.txt';
      ses.levelFile := projectDir + '\levels.txt';
      ses.videoFile := projectDir + '\video.txt';
      ses.video := Tvideo.create(ses.videoFile);
      if treeProject = nil then
        treeProject := TclstreeProjectVst.Create(vstProject);
      models := TModelssData.create(ses.modelsFile);
      Levels := TLevelHeadersData.create(ses.levelFile);
      //Add parent nodes
      //Model
      rProjectData := treeProject.cleartreeProjectrData;
      rProjectData.title := 'Models';
      rProjectData.fileName := ses.modelsFile;
      rProjectData.typeFile := 3;
      rProjectData.info1 := '';
      rProjectData.info2 := '';
      nodeModels := treeProject.addtreeProjectNode(rProjectData,nil);
      //Level
      rProjectData := treeProject.cleartreeProjectrData;
      rProjectData.title := 'Levels';
      rProjectData.fileName := ses.levelFile;
      rProjectData.typeFile := 4;
      rProjectData.info1 := '';
      rProjectData.info2 := '';
      nodeLevelHeader := treeProject.addtreeProjectNode(rProjectData,nil);
      //Add Subgroups
      aList := models.getEntityTypeList;
      addSubGroupsEntity(nodeModels,aList,0,treeProject);
      addSubGroupsEntity(nodeLevelHeader,Levels.levelsSets,0,treeProject);
      //Add Model Details
      for i := 0 to models.listEntities.Count -1 do Begin
        rProjectData := treeProject.cleartreeProjectrData;
        rData := models.listEntities.Objects[i] as TModelsData;
        rProjectData.id := i;
        rProjectData.title := rData.entName;
        rProjectData.fileName := rData.entFile;
        rProjectData.typeFile := 0;
        rProjectData.EntityDetails := models.getEntity(i);
        rProjectData.info1 := models.getEntityType(i);
        groupNode := getSubGroupsEntity(nodeModels,rProjectData.info1,0,vstProject);
        treeProject.addtreeProjectNode(rProjectData,groupNode);//nodeModels);
      end;
      //Add level Details
      for i := 0 to Levels.levelsSets.Count -1 do begin
        lData := Levels.levelsSets.Objects[i] as TLevelHeaderSet;
        iNum := 0;
        for j := 0 to lData.listSetHeader.Count -1 do Begin
          s := lData.listSetHeader.Strings[j];
          s := strClearAll(s);
          if PosStr('.txt',s) > 0 then Begin
            Inc(iNum);
            rProjectData := treeProject.cleartreeProjectrData;
            rProjectData.id := i;

            if PosStr('scene',s) > 0 then
              rProjectData.typeFile := -1
            else
              rProjectData.typeFile := 6;
            StringDeleteUp2(s,' ');
            s := borFile2File(s);
            if iNum > 99 then
              rProjectData.title := IntToStr(iNum) + ' ' + ExtractFileName(s)
            else
            if (iNum > 9) and
               (iNum < 100) then
              rProjectData.title := '0' + IntToStr(iNum) + ' ' + ExtractFileName(s)
            else
              rProjectData.title := '00' + IntToStr(iNum) + ' ' + ExtractFileName(s);
            rProjectData.fileName := s;

            rProjectData.info1 := '';//models.getEntityType(i);
            groupNode := getSubGroupsEntity(nodeLevelHeader,lData.Title,0,vstProject);
            treeProject.addtreeProjectNode(rProjectData,groupNode);
          end;
        end;
      end;

      vstProject.SortTree(0,sdAscending);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.vstProjectDblClick(Sender: TObject);
Var
  pData : ptreeProject;
begin
  try
    Screen.Cursor := crHourGlass;
  if vstProject.FocusedNode <> nil then Begin
    pData := vstProject.GetNodeData(vstProject.FocusedNode);
    case pData.typeFile of
      //Entity File
      0: Begin
          if FileExists(ses.dataDirecotry+ '\' +pData.fileName) then Begin
            frmCharacterEditor.loadCharacterEntityFile(ses.dataDirecotry+ '\' +pData.fileName);
            frmCharacterEditor.Show;
          end;
         end;
      6: Begin
          if FileExists(ses.dataDirecotry+ '\' +pData.fileName) then Begin
            frmLevelDesign.loadLevelDesignFile(ses.dataDirecotry+ '\' +pData.fileName);
            frmLevelDesign.Show;
          end;
         end;
    end;
  end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.loadEditor( Node: PVirtualNode);
Var
  pData : ptreeProject;
begin
  frameEditor.formClear;
  if node <> nil then Begin
    pData := vstProject.GetNodeData(Node);
    case pData.typeFile of
      //Entity File

     -1: frameEditor.formStartup(ses.dataDirecotry + '\' + pData.fileName,pData.typeFile,pData.EntityDetails);
      0: frameEditor.formStartup(ses.dataDirecotry + '\' + pData.fileName,pData.typeFile,pData.EntityDetails);
      3: frameEditor.formStartup(pData.fileName,pData.typeFile,pData.EntityDetails);
      4: frameEditor.formStartup(pData.fileName,pData.typeFile,pData.EntityDetails);
      6: frameEditor.formStartup(ses.dataDirecotry + '\' + pData.fileName,pData.typeFile,pData.EntityDetails);
    end;
  end;
end;

procedure TForm1.JvPageControl1Change(Sender: TObject);
begin
  if JvPageControl1.ActivePageIndex = 1 then Begin
    loadEditor(vstProject.FocusedNode);
  end;
end;

procedure TForm1.vstProjectPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
Var
  pData : ptreeProject;
begin
  if node <> nil then Begin
    pData := Sender.GetNodeData(node);
    case pData.typeFile of
      0: Begin
        //Entity
           if pData.info1 = 'player' then
             TargetCanvas.Font.Color := clNavy
           else
           if pData.info1 = 'enemy' then
             TargetCanvas.Font.Color := clRed;
         end;
      3: Begin
       //Project Group
            TargetCanvas.Font.Style := [fsBold];
            TargetCanvas.Font.Color := clMaroon;
          end;
      6: Begin
            TargetCanvas.Font.Color := clPurple;
         end;
    end;
      if Sender.FocusedNode = node then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsUnderline];
  end;
end;

procedure TForm1.addSubGroupsEntity(parentNode: PVirtualNode;
  listData: TStringList;treeType:integer;treecls:TObject);
Var
  i : integer;
  s : string;
  rData : rtreeProject;
  rDataSystem : ropenBorSystem;
begin
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    s := strClearAll(s);
    //if s <> '' then Begin
    case treeType of
      0: Begin
          rData := (treecls as TclstreeProjectVst).cleartreeProjectrData;
          rData.title := s;
          rData.typeFile := 0;
          (treecls as TclstreeProjectVst).addtreeProjectNode(rData,parentNode);
         end;
      1: Begin
           rDataSystem := ses.borSys.clearopenBorSystemrData(rDataSystem);
           rDataSystem.title := s;
           rDataSystem.htyp := -1;
           (treecls as TclsopenBorSystemVst).addopenBorSystemNode(rDataSystem,parentNode);
         end;
    end;
    //end;
  end;
end;

function TForm1.getSubGroupsEntity(parentNode: PVirtualNode;
  Title: String;treeType:integer;vstTree:TVirtualStringTree): PVirtualNode;
Var
  node, foundNode : PVirtualNode;
  pData : ptreeProject;
  pDataAni : popenBorSystem;

begin
  case treeType of
    0: Begin
        node := vstTree.GetFirstChild(parentNode);
        Title := LowerCase(Title);
         while node <> nil do Begin
           pData := vstTree.GetNodeData(node);
           if pData.title = Title then Begin
             foundNode := node;
             node := nil;
           end;
           node := vstTree.GetNextSibling(node);
         end;
       end;
     1: Begin
          node := vstTree.GetFirstChild(parentNode);
        Title := LowerCase(Title);
         while node <> nil do Begin
           pDataAni := vstTree.GetNodeData(node);
           if pDataAni.title = Title then Begin
             foundNode := node;
             node := nil;
           end;
           node := vstTree.GetNextSibling(node);
         end;
        end;
  end;
  Result := foundNode;
end;

procedure TForm1.FormatFactory1Click(Sender: TObject);
Var
  searchName:string;
  pData : ptreeProject;
begin
  if vstProject.FocusedNode <> nil then Begin
    pData := vstProject.GetNodeData(vstProject.FocusedNode);
    case pData.typeFile of
      //Entity File
     -1: frmFormat.populateFile(ses.dataDirecotry + '\' + pData.fileName);
      0: frmFormat.populateFile(ses.dataDirecotry + '\' + pData.fileName);
      3: frmFormat.populateFile(pData.fileName);
      4: frmFormat.populateFile(pData.fileName);
      6: frmFormat.populateFile(ses.dataDirecotry + '\' + pData.fileName);
      else
        frmFormat.populateFile(pData.fileName);
    end;
    frmFormat.Show;
  end;
    {searchName := frmStats.gridEntity.Cells[0,frmStats.gridEntity.Row];
    if FileExists(searchName) then Begin
      frmFormat.populateFile(searchName);
      frmFormat.Show;
    end;}
end;

procedure TForm1.estFactory1Click(Sender: TObject);
Var
  node : PVirtualNode;
  pData : ptreeProject;
  rData : rtreeProject;
begin
  node := vstProject.GetFirstSelected;
  frmTestFactory.vstEntity.Clear;
  while node <> nil do Begin
    pData := vstProject.GetNodeData(node);
    if pData.typeFile = 0 then Begin
      rData := treeProject.pData2treeProjectrData(pData);
      frmTestFactory.treeProject.addtreeProjectNode(rData,nil);
    end;
    node := vstProject.GetNextSelected(node);
  end;

  frmTestFactory.show;
end;

procedure TForm1.JvPageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  IF JvPageControl1.ActivePageIndex = 1 then Begin
    if frameEditor.modified = true then Begin
      frameEditor.formSave;
    end;
  end;
end;

procedure TForm1.actTestExecute(Sender: TObject);
begin
  frmTestFactory.show;
end;

procedure TForm1.CoolTrayIcon1Click(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;

procedure TForm1.btnRefreshClick(Sender: TObject);
begin
  if DirectoryExists(edtDirectory.Text) then Begin
    JvBrowseForFolderDialog1.Directory := edtDirectory.Text;

    loadProject( edtDirectory.Text );
  end;
end;

procedure TForm1.LevelEditor1Click(Sender: TObject);
begin
  frmLevelDesign.Show;
end;

procedure TForm1.CharacterEditor1Click(Sender: TObject);
begin
  frmCharacterEditor.show;
end;

procedure TForm1.MainScreen1Click(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm1.btnExecuteBorClick(Sender: TObject);
var
  s : string;
begin
  s := LowerCase(edtDirectory.Text);
  StringReplace(s,'\data','');
  s := s + '\openbor.exe';
  if FileExists(s) then
    exeAppBor( s, '' , false,true )
  else
    ShowMessage('could not find...' + s);  
end;

procedure TForm1.ViewErrorLog1Click(Sender: TObject);
var
  s : string;
begin
  s := LowerCase(edtDirectory.Text);
  StringReplace(s,'\data','');
  s := s + '\Logs\OpenBorLog.txt';
  if FileExists(s) then
    exeAppBor2( s )
  else
    ShowMessage('could not find...' + s);

end;

procedure TForm1.ViewScriptLog1Click(Sender: TObject);
var
  s : string;
begin
  s := LowerCase(edtDirectory.Text);
  StringReplace(s,'\data','');
  s := s + '\Logs\ScriptLog.txt';
  if FileExists(s) then
    exeAppBor2( s  )
  else
    ShowMessage('could not find...' + s);

end;

procedure TForm1.vstProjectAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellRect: TRect);
Var
  pData : ptreeProject;
  aImage : tImage;
  xx : trect;
 begin
  pData:= vstProject.GetNodeData(node);
  if pData.EntityDetails <> nil then Begin
    aImage := pData.EntityDetails.getIcon;
    if aImage <> nil then Begin
      //vstProject.Header.Columns[0].ca
      //xx:= vstProject.Header.Columns[0].GetRect  ;
      xx := vstProject.GetDisplayRect(Node,0,false);
      aImage.Top := xx.Top + 1; //TargetCanvas.ClipRect.Top;// ItemRect.TopLeft.X;// // CellRect.Top;// TargetCanvas.ClipRect.Top;
      aImage.Left := xx.Left + 1; // TargetCanvas.ClipRect.Left; //ItemRect.TopLeft.Y;//  // CellRect.Left;// TargetCanvas.ClipRect.Left;
      aImage.Stretch := true;
      aImage.Transparent := true;
      aImage.Proportional := true;
      aImage.Width := 24;
      aImage.Height := 24;
      aImage.Parent := vstProject;
      aImage.Visible := true;
      //xx.Bottom
      //TargetCanvas.draw(xx.Left, xx.Top, aImage);
    end;

  end;
end;

procedure TForm1.vstProjectMeasureItem(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; var NodeHeight: Integer);
begin
  NodeHeight := 26;
end;

procedure TForm1.vstProjectResize(Sender: TObject);
var
  aImage : tImage;
  pData : ptreeProject;
  node : PVirtualNode;
begin
  node := vstProject.GetFirst;
  while node <> nil do Begin
    pData:= vstProject.GetNodeData(node);
    if pData.EntityDetails <> nil then Begin
      aImage := pData.EntityDetails.getIcon;
      if aImage <> nil then
        aImage.Visible := false;
      //if (vstProject.IsVisible[node] = false) and
    //  if (node.States = [vsVisible]) and
  //       (aImage <> nil) then
//         aImage.Visible := false;
    end;
    node := vstProject.GetNext(node);
  end;

end;

procedure TForm1.vstProjectScroll(Sender: TBaseVirtualTree; DeltaX,
  DeltaY: Integer);
begin
  vstProjectResize(sender);
end;

procedure TForm1.FileCheck1Click(Sender: TObject);
begin
  frmFndFileVst.show;
  frmFndFileVst.checkFiles(edtDirectory.Text);
end;

function TForm1.getnodefromtitle(titlename: string): ptreeProject;
Var
  node: PVirtualNode;
  pData : ptreeProject;
begin
  node := vstProject.GetFirst;
  while node <> nil do begin
    pData := vstProject.GetNodeData(node);
    if pData.title = titlename then
      node := nil;
    node := vstProject.GetNext(node);
  end;
  result := pData;
end;

procedure TForm1.JvThread1Execute(Sender: TObject; Params: Pointer);
begin
  //water
end;

procedure TForm1.LevelHudDesign1Click(Sender: TObject);
begin
  frmHudDesign.show;
end;

procedure TForm1.ImportPak1Click(Sender: TObject);
begin
  jvOpenImport.Filter := 'OpenBor Pak File(*.pak)|*.pak|All Files (*.*)|*.*';
  if jvOpenImport.Execute then Begin
    importPakFile(jvOpenImport.FileName);
    btnRefresh.Click;
  end;
end;

procedure TForm1.Donate1Click(Sender: TObject);
begin
  exeAppBor2('https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=mtirnanic%2bpay%40gmail%2ecom&lc=GB&item_name=Donating&currency_code=GBP&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted');
end;

end.
