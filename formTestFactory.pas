unit formTestFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvSpin, Buttons, CheckLst,
  clstreeProjectVst, unCommon,
  jvStrings, mario,
  VirtualTrees, FlyingOp, JvComponentBase, JvSearchFiles, Menus,
  JvExControls, JvComponent, JvArrowButton;

type
  TfrmTestFactory = class(TForm)
    BitBtn2: TBitBtn;
    seEntityCount: TJvSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    seStopPoints: TJvSpinEdit;
    Label3: TLabel;
    vstEntity: TVirtualStringTree;
    JvSearchFiles1: TJvSearchFiles;
    Button1: TButton;
    btnTest: TJvArrowButton;
    popTest: TPopupMenu;
    CopyRun1: TMenuItem;
    UpdateRun1: TMenuItem;
    Execute1: TMenuItem;
    cbScript: TCheckBox;
    btnError: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure CopyRun1Click(Sender: TObject);
    procedure UpdateRun1Click(Sender: TObject);
    procedure Execute1Click(Sender: TObject);
    procedure btnErrorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure updateModelsFile(Modelsfile:String);
    procedure updateFolders;
    procedure updateLevelFile(levelDesignFile:string);
  public
    { Public declarations }
    treeProject : TclstreeProjectVst;
    procedure runTest(mode:Integer=0);
  end;

var
  frmTestFactory: TfrmTestFactory;

implementation

uses unMain;

{$R *.dfm}

{ TfrmTestFactory }

procedure TfrmTestFactory.updateModelsFile(Modelsfile: String);
Var
  listDat, entityitems : TStringList;
  s : string;
  i : integer;
  node : PVirtualNode;
  pData, depData : ptreeProject;
begin
  try
    listDat := TStringList.Create;
    if FileExists(Modelsfile) then Begin
      listDat.LoadFromFile(Modelsfile);
    end;
    node := vstEntity.GetFirst;
    while node <> nil do Begin
      pData := vstEntity.GetNodeData(node);
      try
        entityitems := Form1.models.getEntitydependencies(Form1.models.getEntityIndexByName(pData.title));
        for i := 0 to entityitems.Count -1 do begin
          depData := Form1.getnodefromtitle(entityitems.Strings[i]);
          s := 'know' + #09 + depData.title  + #09 + File2BorFile(depData.fileName);
          listDat.Add(s);
        end;
        entityitems.Free;
      except
      end;
      if pData.info1 <> 'player' then
        s := 'know' + #09 + pData.title + #09 + File2BorFile(pData.fileName)
      else
        s := 'load' + #09 + pData.title + #09 + File2BorFile(pData.fileName);
      listDat.Add(s);
      node := vstEntity.GetNext(node);
    end;
    listDat.Add('');
    listDat.SaveToFile(ses.openBorData + '\Models.txt');
    listDat.Free;
  finally
  end;
end;

procedure TfrmTestFactory.FormCreate(Sender: TObject);
begin
  if treeProject = nil then
      treeProject := TclstreeProjectVst.Create(vstEntity);
end;

procedure TfrmTestFactory.runTest(mode:Integer);
Var
  i : integer;
begin
  updateModelsFile(ses.testDir + '\Models.txt');

  case mode of
    0 : Begin
          updateFolders;
        end;
  end;
  JvSearchFiles1.FileParams.FileMasks.Text := '*.txt';
  JvSearchFiles1.RootDirectory := ses.testDir + '\Levels';
  JvSearchFiles1.Search;
  for i := 0 to JvSearchFiles1.Files.Count - 1 do Begin
    updateLevelFile(JvSearchFiles1.Files.Strings[i]);
  end;
  exeApp( ses.openBorTestApp,'',false,true );
  //exeApp( '"' + ses.localDir+'\Tools\OBor\OpenBOR.exe' + '"','',false,true);
end;

procedure TfrmTestFactory.updateFolders;
Var
  node : PVirtualNode;
  pData : ptreeProject;
  orgEntityDir, testEntityDir : String;
begin
  node := vstEntity.GetFirst;
  if cbScript.Checked then Begin
    if DirectoryExists(ses.openBorData + '\scripts') then
      DelDir(ses.openBorData + '\scripts');
    if DirectoryExists(ses.dataDirecotry + '\scripts') then
      CopyDir(ses.dataDirecotry + '\scripts',ses.openBorData + '\scripts')
  end;
  while node <> nil do Begin
    pData := vstEntity.GetNodeData(node);
    orgEntityDir := ses.dataDirecotry + '\' + ExtractFileDir(pData.fileName);
    testEntityDir := ses.openBorData + '\chars\' + ExtractFileName(ExtractFileDir(pData.fileName));
    if DirectoryExists(testEntityDir) then
      DelDir(testEntityDir);
    CopyDir(orgEntityDir,testEntityDir);
    node := vstEntity.GetNext(node);
  end;
end;

procedure TfrmTestFactory.updateLevelFile(levelDesignFile: string);
Var
  i, iMaxWidth, iAddEvery : integer;
  s : string;
  listData : TStringList;
  node : PVirtualNode;
  pData : ptreeProject;
begin
  try
    listData := TStringList.Create;
    if FileExists(levelDesignFile) then Begin
      listData.LoadFromFile(levelDesignFile);
      //get max width
      i := 0;
      while i < listData.Count do Begin
        s := listData.Strings[i];
        if PosStr('#|MaxAtPoint',s) > 0 then Begin
          s := strClearAll(s);
          StringDeleteUp2(s,' ');
          try
            iMaxWidth := StrToInt(s);
          except
            iMaxWidth := 900;
          end;
          i := listData.Count;
        end;
        inc(i);
      end;
      //Add Spawn Items
      iAddEvery := iMaxWidth div seStopPoints.AsInteger + 1;
      while iAddEvery <= iMaxWidth do Begin
        node := vstEntity.GetFirst;

        while node <> nil do Begin
          Randomize;
          pData := vstEntity.GetNodeData(node);
          if (pData.info1 = 'player') then Begin

          end Else Begin
            listData.Add('spawn'+#09+pData.title);
            listData.Add('coords'+#09+IntToStr(random(300))+#09+IntToStr(random(50))+#09+'1');
            listData.Add('at'+#09+IntToStr(iAddEvery-5));
          end;
          listData.Add('');
          node := vstEntity.GetNext(node);
        end;
        listData.Add('wait');
        listData.Add('at' +#09+ IntToStr(iAddEvery));
        listData.Add('');
        iAddEvery := (iAddEvery + iAddEvery) - 20;
      end;
      listData.Add('#|edited by '+form1.Caption);
      listData.Add('');
      listData.SaveToFile(ses.openBorData+'\Levels\'+ExtractFileName(levelDesignFile));
    end;


    listData.Free;
  finally
  end;
end;

procedure TfrmTestFactory.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmTestFactory.Button1Click(Sender: TObject);
begin
  ShowMessage('Press return when prompted to extract files!');
  exeApp(ses.localDir+'\Tools\OBor\data\cleanup.bat','',true,true);
end;

procedure TfrmTestFactory.btnTestClick(Sender: TObject);
begin
  if btnTest.Tag = 2 then
    exeApp( ses.openBorTestApp,'',false,true )
    //exeApp('"' + ses.localDir+'\Tools\OBor\OpenBOR.exe' + '"','',false,true)
  else  
  if vstEntity.RootNodeCount > 0 then
    runTest(btnTest.Tag);
end;

procedure TfrmTestFactory.CopyRun1Click(Sender: TObject);
begin
  btnTest.Tag := 0;
  btnTestClick(btnTest);
end;

procedure TfrmTestFactory.UpdateRun1Click(Sender: TObject);
begin
  btnTest.Tag := 1;
  btnTestClick(btnTest);
end;

procedure TfrmTestFactory.Execute1Click(Sender: TObject);
begin
  btnTest.Tag := 2;
  btnTestClick(btnTest);
end;

procedure TfrmTestFactory.btnErrorClick(Sender: TObject);
begin
  exeApp2(ses.localDir + '\Tools\OBor\Logs\OpenBorLog.txt');
end;

procedure TfrmTestFactory.FormShow(Sender: TObject);
begin
  if vstEntity.RootNodeCount = 0 then Begin
    ShowMessage('Please read the readme file on how to use the Test Factory.');
  end;
end;

end.