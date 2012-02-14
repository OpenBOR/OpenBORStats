// V1.06
// This Class was generated with Total Text Container
// This class is Ideally written for Parent-Child Trees
// It's also written for Multi Columns
// With a little deleting it can be updated to handle neither of the above.
unit clsanimeEntityListVst;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActiveX, ShellAPI, clsEntityDetails,
  VirtualTrees, mario
  ;

Type
  ranimeEntityList = Record
    id : Integer;
    anme : String;
    zType : integer;
    entityHeader : TStringList;

    entityDetail : TEntityDetail;

  end;
  panimeEntityList = ^ranimeEntityList;

type
  TclsanimeEntityListVst = class(TObject)
  procedure vstanimeEntityListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  procedure vstanimeEntityListHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure vstanimeEntityListGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
  procedure vstanimeEntityListInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  procedure vstanimeEntityListCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  procedure vstanimeEntityListBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
  procedure vstanimeEntityListDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
  procedure vstanimeEntityListDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
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
    procedure ImportDroppedFile(ImportFileName:String;ParentNode:PVirtualNode;rData:ranimeEntityList); Overload;
    procedure ImportDroppedFile(sender:TVirtualStringTree;ImportFileName:String;ParentNode:PVirtualNode;rData:ranimeEntityList); Overload;
    //Add functions
    function addanimeEntityListNode(sender:TVirtualStringTree;panimeEntityListData:panimeEntityList;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addanimeEntityListNode(ranimeEntityListData:ranimeEntityList;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addanimeEntityListNode(sender:TVirtualStringTree;ranimeEntityListData:ranimeEntityList;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    //Record Methods
    Function pData2animeEntityListrData(pData:panimeEntityList):ranimeEntityList;
    function clearanimeEntityListrData:ranimeEntityList; Overload;
    function clearanimeEntityListrData(rData:ranimeEntityList):ranimeEntityList; Overload;
  end;
implementation
constructor TclsanimeEntityListVst.Create(vTree: TVirtualStringTree;includeXml:Boolean);
begin
  fTree := vTree;
  fTree.OnGetNodeDataSize := vstanimeEntityListGetNodeDataSize;
  fTree.OnGetText := vstanimeEntityListGetText;
  fTree.OnHeaderClick := vstanimeEntityListHeaderClick;
  fTree.OnInitNode := vstanimeEntityListInitNode;
  fTree.OnCompareNodes := vstanimeEntityListCompareNodes;

  setXmlStatus(includeXml);
  setTreeSetting(vTree);
end;
procedure TclsanimeEntityListVst.setXmlStatus(include: Boolean);
begin
  setXmlStatus(fTree,include);
end;
procedure TclsanimeEntityListVst.setXmlStatus(sender: TVirtualStringTree;
  include: Boolean);
begin
  if include = true then Begin
    sender.OnBeforeItemErase := vstanimeEntityListBeforeItemErase;
  End else Begin
    sender.OnBeforeItemErase := nil;
  End;
end;
procedure TclsanimeEntityListVst.setTreeSetting;
begin
  setTreeSetting(fTree);
end;
procedure TclsanimeEntityListVst.setTreeSetting(sender: TVirtualStringTree);
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
procedure TclsanimeEntityListVst.ImportDroppedFile(ImportFileName: String;
  ParentNode: PVirtualNode; rData: ranimeEntityList);
begin
  ImportDroppedFile(fTree,ImportFileName,ParentNode,rData);
end;
procedure TclsanimeEntityListVst.ImportDroppedFile(sender: TVirtualStringTree;
  ImportFileName: String; ParentNode: PVirtualNode; rData: ranimeEntityList);
Var
  ext : String;
begin
  {ext := ExtractFileExt(ImportFileName);
  rData.name := ExtractFileName(ImportFileName);
  MatStringReplace(rData.Name,ext,'');
  addanimeEntityListNode(sender,rData,ParentNode,xmlIncluded);}
end;
procedure TclsanimeEntityListVst.vstanimeEntityListCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  pData1,
  pData2: panimeEntityList;
  s1,s2: WideString;
begin
    pData1 := Sender.GetNodeData(Node1);
    pData2 := Sender.GetNodeData(Node2);
    case Column of
    {0: Begin
         s1 := IntToStr(pData1.id);
         s2 := IntToStr(pData2.id);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;}
    0: Begin
         s1 := pData1.anme;
         s2 := pData2.anme;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         if (s1 = 'CharacterDetails') or
            (s2 = 'CharacterDetails') then
           result := 1
         else
           Result := CompareText(s1, s2);
       end;
    {2: Begin
         s1 := IntToStr(pData1.aSLst);
         s2 := IntToStr(pData2.aSLst);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;}

    end;
end;
procedure TclsanimeEntityListVst.vstanimeEntityListBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
Var
  pData : panimeEntityList;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(Node);

  End;
end;
procedure TclsanimeEntityListVst.vstanimeEntityListDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  pDataSelected, pDataDropTarget : panimeEntityList;
  rData : ranimeEntityList;
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
    {rData := xmlanimeEntityList.getanimeEntityListNew;
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
                { On fait un premier tour pour avoir la longueur du nom 
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
      xmlanimeEntityList.setanimeEntityListData(pDataSelected);}
end;

procedure TclsanimeEntityListVst.vstanimeEntityListDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
    Accept := sender = Sender;
end;
procedure TclsanimeEntityListVst.vstanimeEntityListGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := sizeof(ranimeEntityList);
end;
procedure TclsanimeEntityListVst.vstanimeEntityListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  pData: panimeEntityList;
  s : Widestring;
begin
  pData := Sender.GetNodeData(Node);
  if Assigned(pData) then
    Case Column of
     //0: CellText := IntToStr(pData.id);
     0: CellText := pData.anme;
     //2: CellText := IntToStr(pData.aSLst);

    end;
end;
procedure TclsanimeEntityListVst.vstanimeEntityListHeaderClick(Sender: TVTHeader;
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
procedure TclsanimeEntityListVst.vstanimeEntityListInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  pData: panimeEntityList;
begin
  with Sender do
  begin
    pData := GetNodeData(Node);
  end;
end;
function TclsanimeEntityListVst.addanimeEntityListNode(sender: TVirtualStringTree;
  panimeEntityListData: panimeEntityList; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  ranimeEntityListData : ranimeEntityList;
begin
  Result := addanimeEntityListNode(sender,ranimeEntityListData,parentNode,includeXml);
end;

function TclsanimeEntityListVst.addanimeEntityListNode(ranimeEntityListData: ranimeEntityList;
  parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
begin
  result := addanimeEntityListNode(fTree,ranimeEntityListData,parentNode,includeXml);
end;
function TclsanimeEntityListVst.addanimeEntityListNode(sender: TVirtualStringTree;
  ranimeEntityListData: ranimeEntityList; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  aNode : PVirtualNode;
  panimeEntityListData : panimeEntityList;
  panimeEntityListParentData : panimeEntityList;
begin
  aNode := sender.AddChild(parentNode);
  panimeEntityListData := sender.GetNodeData(aNode);
    panimeEntityListData.id := ranimeEntityListData.id;
    panimeEntityListData.anme := ranimeEntityListData.anme;
    panimeEntityListData.entityHeader := ranimeEntityListData.entityHeader;
    panimeEntityListData.entityDetail := ranimeEntityListData.entityDetail;
    panimeEntityListData.zType := ranimeEntityListData.zType;
  result := aNode;
end;

function TclsanimeEntityListVst.clearanimeEntityListrData: ranimeEntityList;
Var
  ranimeEntityListData : ranimeEntityList;
Begin
  ranimeEntityListData.id := -1;
  ranimeEntityListData.anme := '';
  Try
    ranimeEntityListData.entityHeader := TStringList.Create
    {if ranimeEntityListData.entityHeader.count > 0 then
      ranimeEntityListData.entityHeader.Clear;}
  except
    ranimeEntityListData.entityHeader := TStringList.Create
  end;
  try
    {ranimeEntityListData.entityDetail.free;
    ranimeEntityListData.entityDetail := nil;}
  except
  end;
  ranimeEntityListData.entityDetail := TEntityDetail.create;
  Result := ranimeEntityListData;
end;
function TclsanimeEntityListVst.clearanimeEntityListrData(rData: ranimeEntityList): ranimeEntityList;
Var
  ranimeEntityListData : ranimeEntityList;
Begin
  ranimeEntityListData.id := -1;
  ranimeEntityListData.anme := '';


  if ranimeEntityListData.entityHeader = nil then
    ranimeEntityListData.entityHeader := TStringList.Create
  else
    ranimeEntityListData.entityHeader.Clear;

  Result := ranimeEntityListData;
end;
Function TclsanimeEntityListVst.pData2animeEntityListrData(pData:panimeEntityList):ranimeEntityList;
Var
  rData : ranimeEntityList;
begin
  Try
    rData.id := pData.id;
    rData.anme := pData.anme;
    rData.entityHeader := pData.entityHeader;
    rData.entityDetail := pData.entityDetail;
    rData.zType := pData.zType;
  Finally
    Result := rData;
  End;
End;



end.
