// V1.06
// This Class was generated with Total Text Container
// This class is Ideally written for Parent-Child Trees
// It's also written for Multi Columns
// With a little deleting it can be updated to handle neither of the above.
unit clsimportTreeVst;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActiveX, ShellAPI,
  VirtualTrees, mario
  ;

Type
  rimportTree = Record
    id : Integer;
    airFile : String;
    hasSff : Boolean;
    enble : Boolean;
  end;
  pimportTree = ^rimportTree;

type
  TclsimportTreeVst = class(TObject)
  procedure vstimportTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  procedure vstimportTreeHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure vstimportTreeGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
  procedure vstimportTreeInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  procedure vstimportTreeCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  procedure vstimportTreeBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
  procedure vstimportTreeDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
  procedure vstimportTreeDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
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
    procedure ImportDroppedFile(ImportFileName:String;ParentNode:PVirtualNode;rData:rimportTree); Overload;
    procedure ImportDroppedFile(sender:TVirtualStringTree;ImportFileName:String;ParentNode:PVirtualNode;rData:rimportTree); Overload;
    //Add functions
    function addimportTreeNode(sender:TVirtualStringTree;pimportTreeData:pimportTree;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addimportTreeNode(rimportTreeData:rimportTree;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addimportTreeNode(sender:TVirtualStringTree;rimportTreeData:rimportTree;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
   //Misc
    Function pData2importTreerData(pData:pimportTree):rimportTree;
    Function getimportTreeNew:rimportTree;
    function clearimportTreerData(rData:rimportTree):rimportTree;
  end;
implementation
constructor TclsimportTreeVst.Create(vTree: TVirtualStringTree;includeXml:Boolean);
begin
  fTree := vTree;
  
  fTree.OnGetNodeDataSize := vstimportTreeGetNodeDataSize;
  fTree.OnGetText := vstimportTreeGetText;
  fTree.OnHeaderClick := vstimportTreeHeaderClick;
  fTree.OnInitNode := vstimportTreeInitNode;
  fTree.OnCompareNodes := vstimportTreeCompareNodes;
  setXmlStatus(includeXml);
  setTreeSetting(vTree);
end;
procedure TclsimportTreeVst.setXmlStatus(include: Boolean);
begin
  setXmlStatus(fTree,include);
end;
procedure TclsimportTreeVst.setXmlStatus(sender: TVirtualStringTree;
  include: Boolean);
begin
  if include = true then Begin
    sender.OnBeforeItemErase := vstimportTreeBeforeItemErase;
  End else Begin
    sender.OnBeforeItemErase := nil;
  End;
end;
procedure TclsimportTreeVst.setTreeSetting;
begin
  setTreeSetting(fTree);
end;
procedure TclsimportTreeVst.setTreeSetting(sender: TVirtualStringTree);
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
procedure TclsimportTreeVst.ImportDroppedFile(ImportFileName: String;
  ParentNode: PVirtualNode; rData: rimportTree);
begin
  ImportDroppedFile(fTree,ImportFileName,ParentNode,rData);
end;
procedure TclsimportTreeVst.ImportDroppedFile(sender: TVirtualStringTree;
  ImportFileName: String; ParentNode: PVirtualNode; rData: rimportTree);
Var
  ext : String;
begin
  ext := ExtractFileExt(ImportFileName);
  //rData.name := ExtractFileName(ImportFileName);
  //MatStringReplace(rData.Name,ext,'');
  addimportTreeNode(sender,rData,ParentNode,xmlIncluded);
end;
procedure TclsimportTreeVst.vstimportTreeCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  pData1,
  pData2: pimportTree;
  s1,s2: WideString;
begin
    pData1 := Sender.GetNodeData(Node1);
    pData2 := Sender.GetNodeData(Node2);
    case Column of
    0: Begin
         s1 := IntToStr(pData1.id);
         s2 := IntToStr(pData2.id);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    1: Begin
         s1 := pData1.airFile;
         s2 := pData2.airFile;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    2: Begin
         s1 := MatBool2Str((pData1.hasSff));
         s2 := MatBool2Str((pData2.hasSff));
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    3: Begin
         s1 := MatBool2Str((pData1.enble));
         s2 := MatBool2Str((pData2.enble));
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;

    end;
end;
procedure TclsimportTreeVst.vstimportTreeBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
Var
  pData : pimportTree;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(Node);
    
  End;
end;
procedure TclsimportTreeVst.vstimportTreeDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  pDataSelected, pDataDropTarget : pimportTree;
  rData : rimportTree;
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
    
    {if DataObject <> nil then Begin
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
      xmlimportTree.setimportTreeData(pDataSelected);   }
end;

procedure TclsimportTreeVst.vstimportTreeDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
    Accept := sender = Sender;
end;
procedure TclsimportTreeVst.vstimportTreeGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := sizeof(rimportTree);
end;
procedure TclsimportTreeVst.vstimportTreeGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  pData: pimportTree;
  s : Widestring;
begin
  pData := Sender.GetNodeData(Node);
  if Assigned(pData) then
    Case Column of
     0: CellText := IntToStr(pData.id);
     1: Begin
          CellText := pData.airFile;
          if pData.enble = false then
            Node.CheckState := csUncheckedNormal
          else
            Node.CheckState := csCheckedNormal;
        end;
     2: Begin
          CellText := MatBool2Str((pData.hasSff));
          if pData.hasSff = True then
        end;
     3: Begin
          CellText := MatBool2Str((pData.enble));

        end;

    end;
end;
procedure TclsimportTreeVst.vstimportTreeHeaderClick(Sender: TVTHeader;
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
procedure TclsimportTreeVst.vstimportTreeInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  pData: pimportTree;
begin
  with Sender do
  begin
    pData := GetNodeData(Node);
    Node.CheckType := ctTriStateCheckBox;

  end;
end;
function TclsimportTreeVst.addimportTreeNode(sender: TVirtualStringTree;
  pimportTreeData: pimportTree; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  rimportTreeData : rimportTree;
begin
  rimportTreeData := pData2importTreerData(pimportTreeData);
  Result := addimportTreeNode(sender,rimportTreeData,parentNode,includeXml);
end;
function TclsimportTreeVst.addimportTreeNode(rimportTreeData: rimportTree;
  parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
begin
  result := addimportTreeNode(fTree,rimportTreeData,parentNode,includeXml);
end;
function TclsimportTreeVst.addimportTreeNode(sender: TVirtualStringTree;
  rimportTreeData: rimportTree; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  aNode : PVirtualNode;
  pimportTreeData : pimportTree;
  pimportTreeParentData : pimportTree;
begin
  aNode := sender.AddChild(parentNode);
  pimportTreeData := sender.GetNodeData(aNode);
    pimportTreeData.id := rimportTreeData.id;
    pimportTreeData.airFile := rimportTreeData.airFile;
    pimportTreeData.hasSff := rimportTreeData.hasSff;
    pimportTreeData.enble := rimportTreeData.enble;

  
  result := aNode;
end;
function TclsimportTreeVst.clearimportTreerData(
  rData: rimportTree): rimportTree;
Var
  rimportTreeData : rimportTree;
Begin
  rimportTreeData.id := -1;
  rimportTreeData.airFile := '';
  rimportTreeData.hasSff := false;
  rimportTreeData.enble := false;

  Result := rimportTreeData;
end;

function TclsimportTreeVst.getimportTreeNew: rimportTree;
Var
  rimportTreeData : rimportTree;
Begin
  rimportTreeData := clearimportTreerData(rimportTreeData);
  rimportTreeData.id := 1;//getHighestimportTreeID + 1;
  Result := rimportTreeData;
end;

function TclsimportTreeVst.pData2importTreerData(
  pData: pimportTree): rimportTree;
Var
  rData : rimportTree;
begin
  Try
    rData.id := pData.id;
    rData.airFile := ExtractFileName(pData.airFile);
    rData.hasSff := pData.hasSff;
    rData.enble := pData.enble;

  Finally
    Result := rData;
  End;
end;

end.
