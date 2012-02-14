// V1.08
// This Class was generated with Total Text Container
unit clstreeProjectVst;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActiveX, ShellAPI, clsEntityDetails,
  VirtualTrees, mario,unCommon
  ;
//Only use if not using xml
Type
  rtreeProject = Record
    id : Integer;
    title : String;
    entType : String;
    entCache : Boolean;
    fileName : String;
    typeFile : Integer;
    EntityDetails : TEntityDetails;
    loadType : integer; //0: Load, 2: Know, 3:Committed Out

    info1, info2 : String;
  end;
  ptreeProject = ^rtreeProject;
type
  TclstreeProjectVst = class(TObject)
  procedure vsttreeProjectGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  procedure vsttreeProjectHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure vsttreeProjectGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
  procedure vsttreeProjectInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  procedure vsttreeProjectCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  procedure vsttreeProjectBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
  //Some fixing is needed here but does work
  //procedure vsttreeProjectDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
  procedure vsttreeProjectDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
  private
    { Private declarations }
    fTree : TVirtualStringTree;
    xmlIncluded : Boolean;
  public
    { Public declarations }
    constructor Create(vTree:TVirtualStringTree;includeXml:Boolean=false); Overload;
    //Xml Functions
    procedure setXmlStatus(include:Boolean); Overload;
    procedure setXmlStatus(sender:TVirtualStringTree;include:Boolean); Overload;
    //Tree Settings
    procedure setTreeSetting; overload;
    procedure setTreeSetting(sender:TVirtualStringTree); overload;
    //How to handle file imports
    procedure ImportDroppedFile(ImportFileName:String;ParentNode:PVirtualNode;rData:rtreeProject); Overload;
   // procedure ImportDroppedFile(sender:TVirtualStringTree;ImportFileName:String;ParentNode:PVirtualNode;rData:rtreeProject); Overload;
    //Add functions
    function addtreeProjectNode(sender:TVirtualStringTree;ptreeProjectData:ptreeProject;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addtreeProjectNode(rtreeProjectData:rtreeProject;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addtreeProjectNode(sender:TVirtualStringTree;rtreeProjectData:rtreeProject;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    //Record Methods
    //Only use if not using xml
    Function pData2treeProjectrData(pData:ptreeProject):rtreeProject;
    Function gettreeProjectNew:rtreeProject;
    function cleartreeProjectrData:rtreeProject; Overload;
    function cleartreeProjectrData(rData:rtreeProject):rtreeProject; Overload;
  end;
implementation
constructor TclstreeProjectVst.Create(vTree: TVirtualStringTree;includeXml:Boolean);
begin
  fTree := vTree;
  fTree.OnGetNodeDataSize := vsttreeProjectGetNodeDataSize;
  fTree.OnGetText := vsttreeProjectGetText;
  fTree.OnHeaderClick := vsttreeProjectHeaderClick;
  fTree.OnInitNode := vsttreeProjectInitNode;
  fTree.OnCompareNodes := vsttreeProjectCompareNodes;
  setXmlStatus(includeXml);
  setTreeSetting(vTree);
end;
procedure TclstreeProjectVst.setXmlStatus(include: Boolean);
begin
  setXmlStatus(fTree,include);
end;
procedure TclstreeProjectVst.setXmlStatus(sender: TVirtualStringTree;
  include: Boolean);
begin
  if include = true then Begin
    sender.OnBeforeItemErase := vsttreeProjectBeforeItemErase;
  End else Begin
    sender.OnBeforeItemErase := nil;
  End;
end;
procedure TclstreeProjectVst.setTreeSetting;
begin
  setTreeSetting(fTree);
end;
procedure TclstreeProjectVst.setTreeSetting(sender: TVirtualStringTree);
begin
  //Drag&Drop Feature
  sender.TreeOptions.AutoOptions := sender.TreeOptions.AutoOptions - [toAutoDeleteMovedNodes];
  //Allow Edit
  //sender.TreeOptions.MiscOptions := sender.TreeOptions.MiscOptions + [toEditable];
  //Selection
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toFullRowSelect];
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toMultiSelect];
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toRightClickSelect];
end;
procedure TclstreeProjectVst.ImportDroppedFile(ImportFileName: String;
  ParentNode: PVirtualNode; rData: rtreeProject);
begin
  //ImportDroppedFile(fTree,ImportFileName,ParentNode,rData);
end;
{procedure TclstreeProjectVst.ImportDroppedFile(sender: TVirtualStringTree;
  ImportFileName: String; ParentNode: PVirtualNode; rData: rtreeProject);
Var
  ext : String;
begin
  ext := ExtractFileExt(ImportFileName);
  rData.name := ExtractFileName(ImportFileName);
  MatStringReplace(rData.Name,ext,'');
  addtreeProjectNode(sender,rData,ParentNode,xmlIncluded);
end;}
procedure TclstreeProjectVst.vsttreeProjectCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  pData1,
  pData2: ptreeProject;
  s1,s2: String;
begin
    pData1 := Sender.GetNodeData(Node1);
    pData2 := Sender.GetNodeData(Node2);
    case Column of
    {-: Begin
         s1 := IntToStr(pData1.id);
         s2 := IntToStr(pData2.id);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;}
    0: Begin
         s1 := pData1.title;
         s2 := pData2.title;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    1: Begin
         s1 := pData1.info1;
         s2 := pData2.info1;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    2: Begin
         s1 := pData1.info2;
         s2 := pData2.info2;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    {-: Begin
         s1 := pData1.fileName;
         s2 := pData2.fileName;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    -: Begin
         s1 := IntToStr(pData1.typeFile);
         s2 := IntToStr(pData2.typeFile);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;}

    end;
end;
procedure TclstreeProjectVst.vsttreeProjectBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
Var
  pData : ptreeProject;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(Node);
  End;
end;
//Some fixing is needed here but does work
{procedure TclstreeProjectVst.vsttreeProjectDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  pDataSelected, pDataDropTarget : ptreeProject;
  rData : rtreeProject;
  aparentNode : PVirtualNode;
  //FileDrop
  medium : STGMEDIUM;
  fe : FORMATETC;
  res : HRESULT;
  i, filesnum : Integer;
  nameLength : Uint;
  filename : PChar;
  fullFileName : String;
begin
    rData := xmltreeProject.gettreeProjectNew;
    if DataObject <> nil then Begin
    with fe do
    begin
        cfFormat := CF_HDROP;
        ptd := nil;
        dwAspect := DVASPECT_CONTENT;
        lindex := -1;
        tymed := TYMED_HGLOBAL;
    end;
    res := DataObject.GetData(fe, medium);
    if Failed(res) then Begin
      pDataSelected := Sender.GetNodeData(Sender.GetFirstSelected);
    End Else Begin
    try
        filesnum:= DragQueryFile(medium.hGlobal, $FFFFFFFF, nil, 0);
        if filesnum > 0 then
        begin
            for i:= 0 to filesnum-1 do
            begin
                // On fait un premier tour pour avoir la longueur du nom
                nameLength:= DragQueryFile(medium.hGlobal, i, nil, 0) + 1;
                filename:= StrAlloc(nameLength);
                DragQueryFile(medium.hGlobal, i, filename, nameLength);
                //MessageDlg(filename, mtInformation, [mbOK], 0);
                fullFileName := pChar(filename);
                StrDispose(filename);
                res := NOERROR;
            end;
        end
        else
        begin
            res := E_FAIL;
        end;
    finally
        ReleaseStgMedium(medium);
    end;
    End;
  End;
  //pDataSelected := Sender.GetNodeData(Sender.GetFirstSelected);
  pDataDropTarget := Sender.GetNodeData(Sender.DropTargetNode);
  case Mode of
    dmAbove:  Begin
                AttachMode := amInsertBefore;
                if Failed(res) then
                --ToDo // Fix Code Pro Problem
                pDataSelected. := pDataDropTarget.

                else Begin
                  aparentNode := sender.NodeParent[Sender.DropTargetNode];
                  ImportDroppedFile(fullFileName,aparentNode,rData);
                End;
              End;
    dmBelow:  Begin
                AttachMode := amInsertAfter;
                if Failed(res) then
                pDataSelected. := pDataDropTarget.
                else Begin
                  aparentNode := sender.NodeParent[Sender.DropTargetNode];
                  ImportDroppedFile(fullFileName,aparentNode,rData);
                End;
              End;
    dmOnNode: Begin
                AttachMode := amAddChildLast;
                if Failed(res) then
                pDataSelected. := pDataDropTarget.id
                else Begin
                  aparentNode := Sender.DropTargetNode;
                  ImportDroppedFile(fullFileName,aparentNode,rData);
                End;
              End;
  else Begin
    AttachMode := amInsertAfter;
    if Failed(res) then
    else Begin
      aparentNode := sender.NodeParent[Sender.DropTargetNode];
      ImportDroppedFile(fullFileName,aparentNode,rData);
    End;
  End;
  end;
  if Failed(res) then Begin
    Sender.MoveTo(Sender.GetFirstSelected, Sender.DropTargetNode, AttachMode, False);
    //Sender.ReinitNode(Sender.GetFirstSelected,False);
  End;
  if xmlIncluded = true then
    if Failed(res) then
      xmltreeProject.settreeProjectData(pDataSelected);
end;  }

procedure TclstreeProjectVst.vsttreeProjectDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
    Accept := sender = Sender;
end;
procedure TclstreeProjectVst.vsttreeProjectGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := sizeof(rtreeProject);
end;
procedure TclstreeProjectVst.vsttreeProjectGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  pData: ptreeProject;
  s : Widestring;
begin
  pData := Sender.GetNodeData(Node);
  if Assigned(pData) then
    Case Column of
     //-: CellText := IntToStr(pData.id);
     0: CellText := pData.title;
     1: CellText := strClearStartEnd(pData.info1);
     2: CellText := '';
     3: Begin
        Case pData.loadType of
          0:  CellText := 'Load';
          1:  CellText := 'Know';
          2:  CellText := 'Committed Out';
        end;
     end;   
     {-: CellText := pData.fileName;
     -: CellText := IntToStr(pData.typeFile);}

    end;
end;
procedure TclstreeProjectVst.vsttreeProjectHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Button = mbLeft then
  begin
    with Sender do
    begin
      {if Column <> MainColumn then
        SortColumn := NoColumn
      else}
      begin
        if SortColumn = NoColumn then
        begin
          SortColumn := Column;
          SortDirection := sdAscending;
        end
        else
          if SortDirection = sdAscending then
            SortDirection := sdDescending
          else
            SortDirection := sdAscending;
        SortColumn := Column;
        //Sender.SortTree(SortColumn, SortDirection, False);
      end;
    end;
    fTree.SortTree(Column,Sender.SortDirection,false);
  End;
end;
procedure TclstreeProjectVst.vsttreeProjectInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  pData: ptreeProject;
begin
  with Sender do
  begin
    pData := GetNodeData(Node);
  end;
end;
function TclstreeProjectVst.addtreeProjectNode(sender: TVirtualStringTree;
  ptreeProjectData: ptreeProject; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  rtreeProjectData : rtreeProject;
begin
  
  Result := addtreeProjectNode(sender,rtreeProjectData,parentNode,includeXml);
end;
function TclstreeProjectVst.addtreeProjectNode(rtreeProjectData: rtreeProject;
  parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
begin
  result := addtreeProjectNode(fTree,rtreeProjectData,parentNode,includeXml);
end;
function TclstreeProjectVst.addtreeProjectNode(sender: TVirtualStringTree;
  rtreeProjectData: rtreeProject; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  aNode : PVirtualNode;
  ptreeProjectData : ptreeProject;
  ptreeProjectParentData : ptreeProject;
begin
  aNode := sender.AddChild(parentNode);
  ptreeProjectData := sender.GetNodeData(aNode);
    ptreeProjectData.id := rtreeProjectData.id;
    ptreeProjectData.title := rtreeProjectData.title;
    ptreeProjectData.entType := rtreeProjectData.entType;
    ptreeProjectData.entCache := rtreeProjectData.entCache;
    ptreeProjectData.fileName := rtreeProjectData.fileName;
    ptreeProjectData.typeFile := rtreeProjectData.typeFile;
    ptreeProjectData.info1 := rtreeProjectData.info1;
    ptreeProjectData.info2 := rtreeProjectData.info2;
    ptreeProjectData.loadType := rtreeProjectData.loadType;
    ptreeProjectData.EntityDetails := rtreeProjectData.EntityDetails;

  result := aNode;
end;
//Only use if not using xml
function TclstreeProjectVst.gettreeProjectNew: rtreeProject;
Var
  rtreeProjectData : rtreeProject;
Begin
  rtreeProjectData := cleartreeProjectrData(rtreeProjectData);
  //rtreeProjectData.id := getHighesttreeProjectID + 1;
  Result := rtreeProjectData;
end;
function TclstreeProjectVst.cleartreeProjectrData: rtreeProject;
Var
  rtreeProjectData : rtreeProject;
Begin
  rtreeProjectData.id := -1;
  rtreeProjectData.title := '';
  rtreeProjectData.entType := '';
  rtreeProjectData.entCache := false;
  rtreeProjectData.fileName := '';
  rtreeProjectData.typeFile := -1;
  rtreeProjectData.info1 := '';
  rtreeProjectData.info2 := '';
  rtreeProjectData.loadType := 0;
  rtreeProjectData.EntityDetails := nil;

  Result := rtreeProjectData;
end;
function TclstreeProjectVst.cleartreeProjectrData(rData: rtreeProject): rtreeProject;
Var
  rtreeProjectData : rtreeProject;
Begin
  rtreeProjectData.id := -1;
  rtreeProjectData.title := '';
  rtreeProjectData.entType := '';
  rtreeProjectData.entCache := false;
  rtreeProjectData.fileName := '';
  rtreeProjectData.typeFile := -1;
  rtreeProjectData.info1 := '';
  rtreeProjectData.info2 := '';
  rtreeProjectData.loadType := 0;
  rtreeProjectData.EntityDetails := nil;
  Result := rtreeProjectData;
end;
Function TclstreeProjectVst.pData2treeProjectrData(pData:ptreeProject):rtreeProject;
Var
  rData : rtreeProject;
begin
  Try
    rData.id := pData.id;
    rData.title := pData.title;
    rData.entType := pData.entType;
    rData.entCache := pData.entCache;
    rData.fileName := pData.fileName;
    rData.typeFile := pData.typeFile;
    rData.info1 := pData.info1;
    rData.info2 := pData.info2;
    rData.EntityDetails := pData.EntityDetails;
    rData.loadType := pData.loadType;

  Finally
    Result := rData;
  End;
End;
end.
