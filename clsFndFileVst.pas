// V1.08
// This Class was generated with Total Text Container
// This class is Ideally written for Parent-Child Trees
// It's also written for Multi Columns
// With a little deleting it can be updated to handle neither of the above.
//Remove various comments for it to use the xml
unit clsFndFileVst;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActiveX, ShellAPI,
  VirtualTrees, mario
  ;
//Only use if not using xml
Type
  rFndFile = Record
    ID : Integer;
    Checked : Boolean;
    FullFileName : String;
    FromFile : String;
    InUse : Boolean;

  end;
  pFndFile = ^rFndFile; 
type
  TclsFndFileVst = class(TObject)
  procedure vstFndFileGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  procedure vstFndFileHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure vstFndFileGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
  procedure vstFndFileInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  procedure vstFndFileCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  procedure vstFndFileBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
  //Some fixing is needed here but does work
  //procedure vstFndFileDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
  procedure vstFndFileDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
  private
    { Private declarations }
    fTree : TVirtualStringTree;
    xmlIncluded : Boolean;
  public
    { Public declarations }
    destructor destroy; override;
    constructor Create(vTree:TVirtualStringTree;includeXml:Boolean=false); Overload;
    //Xml Functions
    procedure setXmlStatus(include:Boolean); Overload;
    procedure setXmlStatus(sender:TVirtualStringTree;include:Boolean); Overload;
    //Tree Settings
    procedure setTreeSetting; overload;
    procedure setTreeSetting(sender:TVirtualStringTree); overload;
    //How to handle file imports
    procedure ImportDroppedFile(ImportFileName:String;ParentNode:PVirtualNode;rData:rFndFile); Overload;
    procedure ImportDroppedFile(sender:TVirtualStringTree;ImportFileName:String;ParentNode:PVirtualNode;rData:rFndFile); Overload;
    //Add functions
    function addFndFileNode(sender:TVirtualStringTree;pFndFileData:pFndFile;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addFndFileNode(rFndFileData:rFndFile;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addFndFileNode(sender:TVirtualStringTree;rFndFileData:rFndFile;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    //Record Methods
    //Only use if not using xml
    {Function pData2FndFilerData(pData:pFndFile):rFndFile;
    Function getFndFileNew:rFndFile;
    function clearFndFilerData:rFndFile; Overload;
    function clearFndFilerData(rData:rFndFile):rFndFile; Overload;}
  end;
implementation

destructor TclsFndFileVst.destroy;
begin
   if(assigned(fTree)) then FreeAndNil(fTree);
   inherited destroy;
end;

constructor TclsFndFileVst.Create(vTree: TVirtualStringTree;includeXml:Boolean);
begin
  fTree := vTree;

  fTree.OnGetNodeDataSize := vstFndFileGetNodeDataSize;
  fTree.OnGetText := vstFndFileGetText;
  fTree.OnHeaderClick := vstFndFileHeaderClick;
  fTree.OnInitNode := vstFndFileInitNode;
  fTree.OnCompareNodes := vstFndFileCompareNodes;
  setXmlStatus(includeXml);
  setTreeSetting(vTree);
end;
procedure TclsFndFileVst.setXmlStatus(include: Boolean);
begin
  setXmlStatus(fTree,include);
end;
procedure TclsFndFileVst.setXmlStatus(sender: TVirtualStringTree;
  include: Boolean);
begin
  if include = true then Begin
    sender.OnBeforeItemErase := vstFndFileBeforeItemErase;
  End else Begin
    sender.OnBeforeItemErase := nil;
  End;
end;
procedure TclsFndFileVst.setTreeSetting;
begin
  setTreeSetting(fTree);
end;
procedure TclsFndFileVst.setTreeSetting(sender: TVirtualStringTree);
begin
  //Drag&Drop Feature
  sender.TreeOptions.AutoOptions := sender.TreeOptions.AutoOptions - [toAutoDeleteMovedNodes];
  //Allow Edit
  sender.TreeOptions.MiscOptions := sender.TreeOptions.MiscOptions + [toEditable];
  //Selection
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toFullRowSelect];
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toMultiSelect];
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toRightClickSelect];
end;
procedure TclsFndFileVst.ImportDroppedFile(ImportFileName: String;
  ParentNode: PVirtualNode; rData: rFndFile);
begin
  ImportDroppedFile(fTree,ImportFileName,ParentNode,rData);
end;
procedure TclsFndFileVst.ImportDroppedFile(sender: TVirtualStringTree;
  ImportFileName: String; ParentNode: PVirtualNode; rData: rFndFile);
Var
  ext : String;
begin
  ext := ExtractFileExt(ImportFileName);
  rData.FullFileName := ExtractFileName(ImportFileName);
  MatStringReplace(rData.FullFileName,ext,'');
  addFndFileNode(sender,rData,ParentNode,xmlIncluded);
end;
procedure TclsFndFileVst.vstFndFileCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  pData1,
  pData2: pFndFile;
  s1,s2: WideString;
begin
    pData1 := Sender.GetNodeData(Node1);
    pData2 := Sender.GetNodeData(Node2);
    case Column of
    0: Begin
         s1 := IntToStr(pData1.ID);
         s2 := IntToStr(pData2.ID);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    1: Begin
         s1 := MatBool2Str(pData1.Checked);
         s2 := MatBool2Str(pData2.Checked);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    2: Begin
         s1 := pData1.FullFileName;
         s2 := pData2.FullFileName;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    3: Begin
         s1 := pData1.FromFile;
         s2 := pData2.FromFile;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    4: Begin
         s1 := MatBool2Str(pData1.InUse);
         s2 := MatBool2Str(pData2.InUse);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;

    end;
end;
procedure TclsFndFileVst.vstFndFileBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
Var
  pData : pFndFile;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(Node);

  End;
end;
//Some fixing is needed here but does work
{procedure TclsFndFileVst.vstFndFileDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  pDataSelected, pDataDropTarget : pFndFile;
  rData : rFndFile;
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
    rData := xmlFndFile.getFndFileNew;
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
                pDataSelected. := pDataDropTarget.ID
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
      xmlFndFile.setFndFileData(pDataSelected);
end;  }

procedure TclsFndFileVst.vstFndFileDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
    Accept := sender = Sender;
end;
procedure TclsFndFileVst.vstFndFileGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := sizeof(rFndFile);
end;
procedure TclsFndFileVst.vstFndFileGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  pData: pFndFile;
  s : Widestring;
begin
  pData := Sender.GetNodeData(Node);
  if Assigned(pData) then
    Case Column of
     0: CellText := IntToStr(pData.ID);
     1: CellText := MatBool2Str(pData.Checked);
     2: CellText := pData.FullFileName;
     3: CellText := pData.FromFile;
     4: CellText := MatBool2Str(pData.InUse);

    end;
end;
procedure TclsFndFileVst.vstFndFileHeaderClick(Sender: TVTHeader;
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
procedure TclsFndFileVst.vstFndFileInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  pData: pFndFile;
begin
  with Sender do
  begin
    pData := GetNodeData(Node);
  end;
end;
function TclsFndFileVst.addFndFileNode(sender: TVirtualStringTree;
  pFndFileData: pFndFile; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  rFndFileData : rFndFile;
begin

  Result := addFndFileNode(sender,rFndFileData,parentNode,includeXml);
end;
function TclsFndFileVst.addFndFileNode(rFndFileData: rFndFile;
  parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
begin
  result := addFndFileNode(fTree,rFndFileData,parentNode,includeXml);
end;
function TclsFndFileVst.addFndFileNode(sender: TVirtualStringTree;
  rFndFileData: rFndFile; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  aNode : PVirtualNode;
  pFndFileData : pFndFile;
  pFndFileParentData : pFndFile;
begin
  aNode := sender.AddChild(parentNode);
  pFndFileData := sender.GetNodeData(aNode);
    pFndFileData.ID := rFndFileData.ID;
    pFndFileData.Checked := rFndFileData.Checked;
    pFndFileData.FullFileName := rFndFileData.FullFileName;
    pFndFileData.FromFile := rFndFileData.FromFile;
    pFndFileData.InUse := rFndFileData.InUse;


  result := aNode;
end;
//Only use if not using xml
{function TclsFndFileVst.getFndFileNew: rFndFile;
Var
  rFndFileData : rFndFile;
Begin
  rFndFileData := clearFndFilerData(rFndFileData);
  rFndFileData.ID := getHighestFndFileID + 1;
  Result := rFndFileData;
end;
function TclsFndFileVst.clearFndFilerData: rFndFile;
Var
  rFndFileData : rFndFile;
Begin
  rFndFileData.ID := -1;
  rFndFileData.Checked := false;
  rFndFileData.FullFileName := '';
  rFndFileData.FromFile := '';
  rFndFileData.InUse := false;

  Result := rFndFileData;
end;
function TclsFndFileVst.clearFndFilerData(rData: rFndFile): rFndFile;
Var
  rFndFileData : rFndFile;
Begin
  rFndFileData.ID := -1;
  rFndFileData.Checked := false;
  rFndFileData.FullFileName := '';
  rFndFileData.FromFile := '';
  rFndFileData.InUse := false;

  Result := rFndFileData;
end;
Function TclsFndFileVst.pData2FndFilerData(pData:pFndFile):rFndFile;
Var
  rData : rFndFile;
begin
  Try
    rData.ID := pData.ID;
    rData.Checked := pData.Checked;
    rData.FullFileName := pData.FullFileName;
    rData.FromFile := pData.FromFile;
    rData.InUse := pData.InUse;

  Finally
    Result := rData;
  End;
End;}
end.