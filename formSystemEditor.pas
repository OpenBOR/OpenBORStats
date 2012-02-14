unit formSystemEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, unCommon, jvstrings,
  xmlopenBorSystemClass, xmlopenBorSystem, clsEntityDetails,
  frameSystemEditor, clsopenBorSystemVst,
  ExtCtrls, JvExExtCtrls, JvNetscapeSplitter, VirtualTrees, ToolWin,
  ComCtrls, JvExComCtrls, JvToolBar, Buttons, Menus;

type
  TfrmSystemEditor = class(TForm)
    JvToolBar1: TJvToolBar;
    btnImportText: TButton;
    vstopenBorSystemList: TVirtualStringTree;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    pnlSystemEditor: TPanel;
    pnlBottom: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    PopupMenu1: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    btnSave: TButton;
    tbSave: TToolButton;
    ToolButton1: TToolButton;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    ExportAnimationScript1: TMenuItem;
    Standard: TMenuItem;
    LogMode1: TMenuItem;
    procedure btnImportTextClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure vstopenBorSystemListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure btnSaveClick(Sender: TObject);
    procedure vstopenBorSystemListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure tbSaveClick(Sender: TObject);
    procedure vstopenBorSystemListEnter(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure StandardClick(Sender: TObject);
    procedure LogMode1Click(Sender: TObject);
  private
    { Private declarations }


    entityDetails : TEntityDetails;
    pEntityHeader, pEntityAnimTypes, pEntityAnimData : PVirtualNode;
    nodeModels, nodeLevelHeader, nodeLevelSets, nodeLevelDesign,
    nodeLevelObjects, nodeFunctions, nodeAnimationScript : PVirtualNode;
    modified : Boolean;
    procedure populateEditTree;
  public
    { Public declarations }
    systemEditor : TfsystemEditor;
    treeEditorVst : TclsopenBorSystemVst;
    workingrData : ropenBorSystem;
    returnString : String;
    returnValues : TStrings;
    procedure setMode(mode:integer);
    procedure populateData(rData:ropenBorSystem;zValue:string;zentityDetails : TEntityDetails); Overload;
    procedure populateData(rData:ropenBorSystem;zValue:Tstrings;zentityDetails : TEntityDetails); Overload;
  end;

var
  frmSystemEditor: TfrmSystemEditor;

implementation

uses unMain, formCharacterEditor, formLevelDesign;

{$R *.dfm}

procedure TfrmSystemEditor.btnImportTextClick(Sender: TObject);
begin
  //ses.borSys.fopenBorSystem.Clear;
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\EntityHeader(Var).txt',0);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\EntityAnimTypes(Var).txt',1);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\EntityAnimData(Var).txt',2);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\ModelsHeader(Var).txt',3);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\LevelHeaders(Var).txt',4);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\LevelsSets(Var).txt',5);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\LevelDesign(Var).txt',6);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\LevelObjects(Var).txt',7);
  //ses.borSys.importFromFile('c:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\Function(Var).txt',8);

end;

procedure TfrmSystemEditor.FormCreate(Sender: TObject);
begin
  systemEditor := TfsystemEditor.Create(pnlSystemEditor);
  systemEditor.Parent := pnlSystemEditor;
  systemEditor.Align := alClient;
  systemEditor.formCreate;
   treeEditorVst := TclsopenBorSystemVst.Create(vstopenBorSystemList,ses.borSys);
  returnValues := TStrings.Create;
  vstopenBorSystemList := treeVisuals(vstopenBorSystemList);
end;

procedure TfrmSystemEditor.populateData(rData: ropenBorSystem;
  zValue: string;zentityDetails : TEntityDetails);
begin
  returnString := '';
  entityDetails := zentityDetails;
  try
    if returnValues <> nil then
      returnValues.Clear;
  except
    returnValues := TStringList.Create;
  end;
  systemEditor.formStartup(zValue,rData,zentityDetails);
end;

procedure TfrmSystemEditor.btnOkClick(Sender: TObject);
Var
  i : integer;
  s : string;
begin
  if systemEditor.edtReturnValue.Text <> '' then
    if ses.ropenBorSystemSelected.htyp = 9 then Begin
        if PosStr('@cmd',LowerCase(systemEditor.returnValue)) > 0 then
          returnString := systemEditor.returnValue
        else
          returnString := #09+ '@cmd ' + systemEditor.edtCommandName.Text + ' ' + systemEditor.returnValue
      end
      else
        returnString := systemEditor.edtCommandName.Text + #09 + systemEditor.returnValue
  else Begin
    returnValues.Clear;
    for i := 0 to systemEditor.reMultiReturn.Lines.Count -1 do Begin
      s := systemEditor.reMultiReturn.Lines.Strings[i];
      if ses.ropenBorSystemSelected.htyp = 9 then
        s := #09+ '@cmd ' + systemEditor.edtCommandName.Text + ' ' + s
      else
        s := systemEditor.edtCommandName.Text + #09 + s;
      returnValues.Add(s);
    end;
  end;
end;

procedure TfrmSystemEditor.btnCancelClick(Sender: TObject);
begin
  returnString := '';
  returnValues.Clear;
end;

procedure TfrmSystemEditor.setMode(mode: integer);
begin
  case mode of
    0 : Begin
         vstopenBorSystemList.Visible := false;
         JvNetscapeSplitter1.Visible := False;
         btnSave.Visible := false;
         systemEditor.setMode(mode);
         btnOk.Visible := True;
         btnCancel.Visible := true;
    end;
    1 : Begin
         vstopenBorSystemList.Visible := True;
         JvNetscapeSplitter1.Visible := True;
         btnSave.Visible := True;
         systemEditor.setMode(mode);
         populateEditTree;
         btnOk.Visible := false;
         btnCancel.Visible := false;
         systemEditor.JvPageControl1.HideAllTabs := false;
    end;
  end;
end;

procedure TfrmSystemEditor.populateEditTree;
Var
  i : integer;
  rData : ropenBorSystem;
  groupNode : PVirtualNode;
begin
  //Add Root Nodes
  vstopenBorSystemList.clear;
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Header';
  rData.htyp := 0;
  pEntityHeader := nil;
  pEntityHeader := treeEditorVst.addopenBorSystemNode(rData,nil,false);
  form1.addSubGroupsEntity(pEntityHeader,ses.borSys.getGroupList(0),1,treeEditorVst);
  //Enitity Anim Types
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Anim Types';
  rData.htyp := 1;
  pEntityAnimTypes := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(pEntityAnimTypes,ses.borSys.getGroupList(1),1,treeEditorVst);
  //Entity Anim Data
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Anim Data';
  rData.htyp := 2;
  pEntityAnimData := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(pEntityAnimData,ses.borSys.getGroupList(2),1,treeEditorVst);
  //Models
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Models';
  rData.htyp := 3;
  nodeModels := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeModels,ses.borSys.getGroupList(3),1,treeEditorVst);
  //Level Header
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Level Header';
  rData.htyp := 4;
  nodeLevelHeader := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeLevelHeader,ses.borSys.getGroupList(4),1,treeEditorVst);
  //Level Sets
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Level Sets';
  rData.htyp := 5;
  nodeLevelSets := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeLevelSets,ses.borSys.getGroupList(5),1,treeEditorVst);
  //Level Design
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Level Design';
  rData.htyp := 6;
  nodeLevelDesign := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeLevelDesign,ses.borSys.getGroupList(6),1,treeEditorVst);
  //Level Objects
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Level Objects';
  rData.htyp := 7;
  nodeLevelObjects := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeLevelObjects,ses.borSys.getGroupList(7),1,treeEditorVst);
  //Functions
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Script Functions';
  rData.htyp := 8;
  nodeFunctions := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeFunctions,ses.borSys.getGroupList(8),1,treeEditorVst);
  //Animation Script
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Script Animation';
  rData.htyp := 9;
  nodeAnimationScript := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeAnimationScript,ses.borSys.getGroupList(9),1,treeEditorVst);
  //Populate data from xml to type
  for i := 0 to ses.borSys.fopenBorSystem.Count -1 do Begin
    rData := ses.borSys.getopenBorSystemData(i);
    case rData.htyp of
      0: Begin
           groupNode := form1.getSubGroupsEntity(pEntityHeader,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//pEntityHeader);
         end;
      1: Begin
           groupNode := form1.getSubGroupsEntity(pEntityAnimTypes,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//pEntityAnimTypes);
         end;
      2: Begin
           groupNode := form1.getSubGroupsEntity(pEntityAnimData,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//pEntityAnimData);
         end;
      3: Begin
           groupNode := form1.getSubGroupsEntity(nodeModels,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeModels);
         end;
      4: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelHeader,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelHeader);
         end;
      5: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelSets,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelSets);
         end;
      6: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelDesign,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelDesign);
         end;
      7: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelObjects,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelObjects);
         end;
      8: Begin
           groupNode := form1.getSubGroupsEntity(nodeFunctions,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeFunctions);
         end;
      9: Begin
           groupNode := form1.getSubGroupsEntity(nodeAnimationScript,rData.Group,1,vstopenBorSystemList);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeAnimationScript);
         end;
    end;
  end;
  vstopenBorSystemList.SortTree(0,sdAscending);
end;

procedure TfrmSystemEditor.vstopenBorSystemListFocusChanged(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
Var
  pData : popenBorSystem;
  rData : ropenBorSystem;
begin
  if node <> nil then Begin
    pData := Sender.GetNodeData(Node);
    rData := ses.borSys.pData2openBorSystemrData(pData);
    ses.ropenBorSystemSelected := ses.borSys.pData2openBorSystemrData(pData);
    systemEditor.populaterOpenBorSystem(rData,entityDetails);
  end;
end;

procedure TfrmSystemEditor.btnSaveClick(Sender: TObject);
Var
  rData : ropenBorSystem;
  pData : popenBorSystem;
begin
  if vstopenBorSystemList.FocusedNode <> nil then Begin
    rData := systemEditor.retrieveData;
    if rData.gd <> '' then Begin
      ses.borSys.setopenBorSystemData(rData);
      pdata := vstopenBorSystemList.GetNodeData(vstopenBorSystemList.FocusedNode);
      pdata := treeEditorVst.rData2openBorSystempData(rData,pData);
      //populateEditTree;
      modified := true;
    end;
  end;
end;


procedure TfrmSystemEditor.vstopenBorSystemListPaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
Var
  pData : popenBorSystem;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(node);
    //If has description
    if (pData.dscrp = '') or
       (pData.dscrp = ' ') then
          TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsBold]
    else
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsBold];
    //If has command
    if (pData.iCommand > 0) then
      TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsItalic]
    else
      TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsItalic]
  end;
end;

procedure TfrmSystemEditor.populateData(rData: ropenBorSystem;
  zValue: Tstrings;zentityDetails : TEntityDetails);
begin
  returnString := '';
  entityDetails := zentityDetails;
  returnValues := zValue;
  systemEditor.formStartup(zValue,rData,zentityDetails);
end;

procedure TfrmSystemEditor.tbSaveClick(Sender: TObject);
begin
  ses.borSys.SavetoFile(ses.localDir+'\System\system.xml');
  if Form1.frameEditor <> nil then
    Form1.frameEditor.populateEditorTree;
  if frmCharacterEditor.frameEditor <> nil then
    frmCharacterEditor.frameEditor.populateEditorTree;
  if frmLevelDesign.frameEditor <> nil then
    frmLevelDesign.frameEditor.populateEditorTree;
  //ShowMessage('You will have to restart openBor Stats!'+#10+#13+'Saved!');
end;

procedure TfrmSystemEditor.vstopenBorSystemListEnter(Sender: TObject);
begin
  StatusBar1.Panels[0].Text := vstopenBorSystemList.Hint;
end;

procedure TfrmSystemEditor.Delete1Click(Sender: TObject);
Var
  pData : popenBorSystem;
begin
  if vstopenBorSystemList.FocusedNode <> nil then Begin
    pData := vstopenBorSystemList.GetNodeData(vstopenBorSystemList.FocusedNode);
    ses.borSys.delopenBorSystemData(pData);
    vstopenBorSystemList.DeleteNode(vstopenBorSystemList.FocusedNode);
    modified := true;
  end;
end;

procedure TfrmSystemEditor.Add1Click(Sender: TObject);
Var
  pData : popenBorSystem;
  rData : ropenBorSystem;
begin
  if vstopenBorSystemList.FocusedNode <> nil then Begin
    pData := vstopenBorSystemList.GetNodeData(vstopenBorSystemList.FocusedNode);
    rData := ses.borSys.getopenBorSystemNew;
    rData.htyp := pData.htyp;
    rData.title := 'New';
    //pEntityHeader, pEntityAnimTypes, pEntityAnimData : PVirtualNode;
    case pData.htyp of
      0: Begin
           treeEditorVst.addopenBorSystemNode(rData,pEntityHeader);
           ses.borSys.addopenBorSystemData(rData);
         end;
      1: Begin
           treeEditorVst.addopenBorSystemNode(rData,pEntityAnimTypes);
           ses.borSys.addopenBorSystemData(rData);
         end;
      2: Begin
           treeEditorVst.addopenBorSystemNode(rData,pEntityAnimData);
           ses.borSys.addopenBorSystemData(rData);
         end;
      3: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeModels);
           ses.borSys.addopenBorSystemData(rData);
         end;
      4: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeLevelHeader);
           ses.borSys.addopenBorSystemData(rData);
         end;
      5: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeLevelSets);
           ses.borSys.addopenBorSystemData(rData);
         end;
      6: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeLevelDesign);
           ses.borSys.addopenBorSystemData(rData);
         end;
      7: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeLevelObjects);
           ses.borSys.addopenBorSystemData(rData);
         end;
      8: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeFunctions);
           ses.borSys.addopenBorSystemData(rData);
         end;
      9: Begin
           treeEditorVst.addopenBorSystemNode(rData,nodeAnimationScript);
           ses.borSys.addopenBorSystemData(rData);
         end;
    end;
    modified := true;
  end;
end;

procedure TfrmSystemEditor.StandardClick(Sender: TObject);
begin
  Form1.frameEditor.saveNodeScriptToFile(Form1.frameEditor.nodeAnimationScript,form1.edtDirectory.Text+'\scripts\aniscp.c');
end;

procedure TfrmSystemEditor.LogMode1Click(Sender: TObject);
begin
  Form1.frameEditor.saveNodeScriptToFile(Form1.frameEditor.nodeAnimationScript,form1.edtDirectory.Text+'\scripts\aniscp.c',true);
end;

end.
