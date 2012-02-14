unit untFndFileVst;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, clsFndFileVst, VirtualTrees, mario, clsModels, clsEntityDetails,
  ComCtrls, Menus, StdCtrls, JvComponentBase, JvBaseDlg, JvBrowseFolder;

type
  TfrmFndFileVst = class(TForm)
    vstFndFileVst: TVirtualStringTree;
    StatusBar1: TStatusBar;
    popFiles: TPopupMenu;
    Check1: TMenuItem;
    UnCheck1: TMenuItem;
    Button1: TButton;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure vstFndFileVstPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstFndFileVstDblClick(Sender: TObject);
    procedure Check1Click(Sender: TObject);
    procedure UnCheck1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    treevst :  TclsFndFileVst;
    procedure scanfordefaultfiles(datadir : string);
    procedure searchforfile(fullfilename:string; parentfile:string);
    procedure checkfile(filename:string;datadir : string);
    procedure countfiles();
  public
    { Public declarations }
    procedure checkFiles(datadir : string);
  end;

var
  frmFndFileVst: TfrmFndFileVst;

implementation

uses unMain;

{$R *.dfm}

procedure TfrmFndFileVst.checkfile(filename: string;datadir : string);
var
  loadedfile, loadedfiles : TStringList;
  searchfile, s, s2 : string;
  rData : rFndFile;
  i, j : integer;
  node : PVirtualNode;
begin
  try
    if (FileExists(filename)) then Begin
      loadedfile := TStringList.Create;
      loadedfiles := TStringList.Create;

      loadedfiles.LoadFromFile(filename);
      //check models file
      for i := 0 to loadedfiles.Count -1 do Begin
        s2 := LowerCase(loadedfiles.Strings[i]);
        if (pos('data/', s2) > 0 ) then Begin
            MatStringDeleteUp2(s2,' data/',5);
            MatStringDeleteUp2(s2,(#09+'data/'),5);
            MatStringDelete2End(s2,' ');
            MatStringDelete2End(s2,#09);
            s2 := datadir + '\' + s2;
            MatStringReplace(s2,'/','\');
            searchforfile(LowerCase(s2), 'models.txt');
            if (pos('.txt',s2)>0) then
              checkfile(s2,datadir);
          end;

        //Check all files in models.txt
        if (FileExists(s2)) then Begin
          loadedfile.LoadFromFile(s2);
          for j := 0 to loadedfile.Count -1 do begin
            s := LowerCase(loadedfile.Strings[j]);
            if (pos('data/', s) > 0 ) then Begin
              MatStringDeleteUp2(s,' data/',5);
              MatStringDeleteUp2(s,(#09+'data/'),5);
              MatStringDelete2End(s,' ');
              MatStringDelete2End(s,#09);
              s := datadir + '\' + s;
              MatStringReplace(s,'/','\');
              searchforfile(LowerCase(s), ExtractFileName(s2));
              if (pos('.txt',s)>0) then
              checkfile(s,datadir);
            end;
          end;
        end;
      end;
      loadedfile.Free;
      loadedfiles.Free;
    end;
  except
  end;
end;

procedure TfrmFndFileVst.checkFiles(datadir: string);
var
  fileList, dirList : TStringList;
  loadedfile, loadedfiles : TStringList;
  searchfile, s, s2 : string;
  rData : rFndFile;
  i, j : integer;
  node : PVirtualNode;
  modelData : TModelsData;// TEntityDetails;// TModelsData;// TModelsData;
begin
  try
    Screen.Cursor := crHourGlass;
    fileList := TStringList.Create;
    dirList := TStringList.Create;
    MatDirSubStructure(datadir,'*.*',fileList,dirList,false);
    for i := 0 to fileList.Count -1 do Begin
      rData.ID := i;
      rData.FullFileName := LowerCase(fileList.Strings[i]);
      rData.Checked := true;
      rData.FromFile := '';
      rData.InUse := false;
      treevst.addFndFileNode(vstFndFileVst,rData,nil,false);
    end;
    Application.ProcessMessages;
    checkfile(datadir+'\models.txt',datadir);
    checkfile(datadir+'\levels.txt',datadir);
    checkfile(datadir+'\video.txt',datadir);
    checkfile(datadir+'\script.txt',datadir);

    checkfile(datadir+'\scenes\ending.txt',datadir);
    checkfile(datadir+'\scenes\gameover.txt',datadir);
    checkfile(datadir+'\scenes\howto.txt',datadir);
    checkfile(datadir+'\scenes\intro.txt',datadir);
    checkfile(datadir+'\scenes\logo.txt',datadir);
    checkfile(datadir+'\scenes\select1.txt',datadir);


    scanfordefaultfiles(datadir);
    countfiles;

    fileList.Free;
    dirList.Free;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TfrmFndFileVst.countfiles;
var
  inuse, notused : integer;
  rData : pFndFile;
  node : PVirtualNode;
begin
  inuse := 0;
  notused := 0;

  node := vstFndFileVst.GetFirst();
  while node <> nil do Begin
    rData := vstFndFileVst.GetNodeData(node);
    if rData.InUse = true then
      inc(inuse)
    else
      inc(notused);
    node := vstFndFileVst.GetNext(node);
  end;

  StatusBar1.Panels[0].Text := 'In use: ' + IntToStr(inuse);
  StatusBar1.Panels[1].Text := 'Not used: ' + IntToStr(notused);
end;

procedure TfrmFndFileVst.FormCreate(Sender: TObject);
begin
  treeVst := TclsFndFileVst.Create(vstFndFileVst);
end;

procedure TfrmFndFileVst.searchforfile(fullfilename: string; parentfile:string);
Var
  rData : pFndFile;
  node : PVirtualNode;
begin
  node := vstFndFileVst.GetFirst;
  fullfilename := LowerCase(fullfilename);
  while node <> nil do Begin

    rData := vstFndFileVst.GetNodeData(node);
    if (fullfilename = rData.FullFileName) then Begin
      rData.InUse := true;
      rData.Checked := false;
      rData.FromFile := parentfile;
      node := nil;
    end;
    node:= vstFndFileVst.GetNext(node);
  end;
end;

procedure TfrmFndFileVst.vstFndFileVstPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
Var
  rData : pFndFile;
begin
  rData := vstFndFileVst.GetNodeData(node);
  if (rData.Checked = true) then
    TargetCanvas.Font.Color := clBlue
  else
    TargetCanvas.Font.Color := clBlack;
end;

procedure TfrmFndFileVst.vstFndFileVstDblClick(Sender: TObject);
Var
  rData : pFndFile;
  node : PVirtualNode;
begin
  node := vstFndFileVst.FocusedNode;
  if node <> nil then Begin
    rData := vstFndFileVst.GetNodeData(node);
    exeApp2(rData.FullFileName);
  end;
end;

procedure TfrmFndFileVst.Check1Click(Sender: TObject);
Var
  rData : pFndFile;
  node : PVirtualNode;
begin
  node := vstFndFileVst.GetFirstSelected;
  while node <> nil do Begin
    rData := vstFndFileVst.GetNodeData(node);
    rData.Checked := true;
    node := vstFndFileVst.GetNextSelected(node);
  end;

end;

procedure TfrmFndFileVst.UnCheck1Click(Sender: TObject);
Var
  rData : pFndFile;
  node : PVirtualNode;
begin
  node := vstFndFileVst.GetFirstSelected;
  while node <> nil do Begin
    rData := vstFndFileVst.GetNodeData(node);
    rData.Checked := False;
    node := vstFndFileVst.GetNextSelected(node);
  end;

end;

procedure TfrmFndFileVst.Button1Click(Sender: TObject);
Var
  s, s2 :string;
    rData : pFndFile;
  node : PVirtualNode;
begin
  if JvBrowseForFolderDialog1.Execute then Begin
    try
      Screen.Cursor := crHourGlass;
      node := vstFndFileVst.GetFirst;
      while node <> nil do Begin
        try
          rData := vstFndFileVst.GetNodeData(node);
          if rData.Checked = true then Begin
            s := rData.FullFileName;
            MatStringReplace(s,Form1.edtDirectory.Text,JvBrowseForFolderDialog1.Directory);
            s2 := ExtractFilePath(s);
            ForceDirectories(s2);
            if CheckBox1.Checked = true then
              MoveFile( PAnsiChar(AnsiString(rData.FullFileName)),PAnsiChar(AnsiString(s)) )
            else
              copyFile( PAnsiChar(AnsiString(rData.FullFileName)),PAnsiChar(AnsiString(s)),true );
          End;
          node := vstFndFileVst.GetNext(node);
        except
        end;
      end;
      finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmFndFileVst.scanfordefaultfiles(datadir : string);
begin
  searchforfile(datadir+'\bgs\logo.gif', 'openBor');
  searchforfile(datadir+'\bgs\select.gif', 'openBor');
  searchforfile(datadir+'\bgs\title.gif', 'openBor');
  searchforfile(datadir+'\bgs\titleb.gif', 'openBor');
  searchforfile(datadir+'\bgs\complete.gif', 'openBor');
  searchforfile(datadir+'\bgs\hiscore.gif', 'openBor');
  searchforfile(datadir+'\bgs\loading.gif', 'openBor');

  searchforfile(datadir+'\models.txt', 'openBor');
  searchforfile(datadir+'\levels.txt', 'openBor');
  searchforfile(datadir+'\video.txt', 'openBor');
  searchforfile(datadir+'\script.txt', 'openBor');
  searchforfile(datadir+'\pal.act', 'openBor');
  searchforfile(datadir+'\lifebar.txt', 'openBor');
  searchforfile(datadir+'\menu.txt', 'openBor');

  searchforfile(datadir+'\scripts\level.c', 'openBor');
  searchforfile(datadir+'\scripts\endlevel.c', 'openBor');

  searchforfile(datadir+'\scenes\ending.txt', 'openBor');
  searchforfile(datadir+'\scenes\gameover.txt', 'openBor');
  searchforfile(datadir+'\scenes\howto.txt', 'openBor');
  searchforfile(datadir+'\scenes\intro.txt', 'openBor');
  searchforfile(datadir+'\scenes\logo.txt', 'openBor');
  searchforfile(datadir+'\scenes\select1.txt', 'openBor');

  searchforfile(datadir+'\sprites\arrow.gif', 'openBor');
  searchforfile(datadir+'\sprites\font.gif', 'openBor');
  searchforfile(datadir+'\sprites\font2.gif', 'openBor');
  searchforfile(datadir+'\sprites\font3.gif', 'openBor');
  searchforfile(datadir+'\sprites\font4.gif', 'openBor');
  searchforfile(datadir+'\sprites\font5.gif', 'openBor');
  searchforfile(datadir+'\sprites\font6.gif', 'openBor');
  searchforfile(datadir+'\sprites\font7.gif', 'openBor');
  searchforfile(datadir+'\sprites\hole.gif', 'openBor');
  searchforfile(datadir+'\sprites\shadow1.gif', 'openBor');
  searchforfile(datadir+'\sprites\shadow2.gif', 'openBor');
  searchforfile(datadir+'\sprites\shadow3.gif', 'openBor');
  searchforfile(datadir+'\sprites\shadow4.gif', 'openBor');
  searchforfile(datadir+'\sprites\shadow5.gif', 'openBor');
  searchforfile(datadir+'\sprites\shadow6.gif', 'openBor');

  searchforfile(datadir+'\sounds\1up.wav', 'openBor');
  searchforfile(datadir+'\sounds\beep.wav', 'openBor');
  searchforfile(datadir+'\sounds\beep2.wav', 'openBor');
  searchforfile(datadir+'\sounds\get.wav', 'openBor');
  searchforfile(datadir+'\sounds\fall.wav', 'openBor');
  searchforfile(datadir+'\sounds\jump.wav', 'openBor');
  searchforfile(datadir+'\sounds\timeover.wav', 'openBor');
  searchforfile(datadir+'\sounds\block.wav', 'openBor');
  searchforfile(datadir+'\sounds\go.wav', 'openBor');
  searchforfile(datadir+'\sounds\land.wav', 'openBor');
  searchforfile(datadir+'\sounds\money.wav', 'openBor');

  searchforfile(datadir+'\music\complete.bor', 'openBor');
  searchforfile(datadir+'\music\gameover.bor', 'openBor');
  searchforfile(datadir+'\music\menu.bor', 'openBor');
  searchforfile(datadir+'\music\plane.bor', 'openBor');

  //searchforfile(datadir+'\bgs\select.gif', 'Default');
end;

procedure TfrmFndFileVst.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then Begin
    CheckBox1.Caption := 'Move';
  end else begin
    CheckBox1.Caption := 'Copy';
  end;
end;

end.
