// V1.07
// This Class was generated with Total Text Container
// This class is Ideally written for Parent-Child Trees
// It's also written for Multi Columns
// With a little deleting it can be updated to handle neither of the above.
//Remove various comments for it to use the xml
unit clsopenBorSystemVst;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActiveX, ShellAPI,
  VirtualTrees, mario,
  xmlopenBorSystemClass
  ;
{Type
  ropenBorSystem = Record
    id : Integer;
    gd : String;
    title : String;
    dscrp : String;
    htyp : Integer;
    vald : String;
    lgth : String;
    usd : String;
    avar : String;

  end;
  popenBorSystem = ^ropenBorSystem;}
type
  TclsopenBorSystemVst = class(TObject)
  procedure vstopenBorSystemGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
  procedure vstopenBorSystemHeaderClick(Sender: TVTHeader; Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  procedure vstopenBorSystemGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
  procedure vstopenBorSystemInitNode(Sender: TBaseVirtualTree; ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
  procedure vstopenBorSystemCompareNodes(Sender: TBaseVirtualTree; Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
  procedure vstopenBorSystemBeforeItemErase(Sender: TBaseVirtualTree; TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect; var ItemColor: TColor; var EraseAction: TItemEraseAction);
  procedure vstopenBorSystemDragDrop(Sender: TBaseVirtualTree; Source: TObject; DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
  procedure vstopenBorSystemDragOver(Sender: TBaseVirtualTree; Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
  private
    { Private declarations }
    fTree : TVirtualStringTree;
    xmlIncluded : Boolean;
    xmlopenBorSystem : aXmlopenBorSystem;
  public
    { Public declarations }
    constructor Create(vTree:TVirtualStringTree;zxmlTopenBorSystem:aXmlopenBorSystem;includeXml:Boolean=false); Overload;
    destructor destroy; override;
    //Xml Functions
    procedure setXmlStatus(include:Boolean); Overload;
    procedure setXmlStatus(sender:TVirtualStringTree;include:Boolean); Overload;
    //Tree Settings
    procedure setTreeSetting; overload;
    procedure setTreeSetting(sender:TVirtualStringTree); overload;
    //How to handle file imports
    procedure ImportDroppedFile(ImportFileName:String;ParentNode:PVirtualNode;rData:ropenBorSystem); Overload;
    procedure ImportDroppedFile(sender:TVirtualStringTree;ImportFileName:String;ParentNode:PVirtualNode;rData:ropenBorSystem); Overload;
    //Add functions
    function addopenBorSystemNode(sender:TVirtualStringTree;popenBorSystemData:popenBorSystem;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addopenBorSystemNode(ropenBorSystemData:ropenBorSystem;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function addopenBorSystemNode(sender:TVirtualStringTree;ropenBorSystemData:ropenBorSystem;parentNode:PVirtualNode;includeXml:Boolean=False):PVirtualNode; Overload;
    function rData2openBorSystempData(rData:ropenBorSystem;pData:popenBorSystem):popenBorSystem;
    //Record Methods
    {Function pData2openBorSystemrData(pData:popenBorSystem):ropenBorSystem;
    Function getopenBorSystemNew:ropenBorSystem;
    function clearopenBorSystemrData:ropenBorSystem; Overload;
    function clearopenBorSystemrData(rData:ropenBorSystem):ropenBorSystem; Overload;}
  end;
implementation

destructor TclsopenBorSystemVst.destroy;
begin
  if(assigned(fTree)) then freeAndNil(ftree);
  if(assigned(xmlopenBorSystem)) then freeAndNil(xmlopenBorSystem);
  inherited Destroy;
end;

constructor TclsopenBorSystemVst.Create(vTree: TVirtualStringTree;zxmlTopenBorSystem:aXmlopenBorSystem;includeXml:Boolean);
begin
  fTree := vTree;
  xmlopenBorSystem := zxmlTopenBorSystem;
  fTree.OnGetNodeDataSize := vstopenBorSystemGetNodeDataSize;
  fTree.OnGetText := vstopenBorSystemGetText;
  fTree.OnHeaderClick := vstopenBorSystemHeaderClick;
  fTree.OnInitNode := vstopenBorSystemInitNode;
  fTree.OnCompareNodes := vstopenBorSystemCompareNodes;
  setXmlStatus(includeXml);
  setTreeSetting(vTree);
end;
procedure TclsopenBorSystemVst.setXmlStatus(include: Boolean);
begin
  setXmlStatus(fTree,include);
end;
procedure TclsopenBorSystemVst.setXmlStatus(sender: TVirtualStringTree;
  include: Boolean);
begin
  if include = true then Begin
    sender.OnBeforeItemErase := vstopenBorSystemBeforeItemErase;
  End else Begin
    sender.OnBeforeItemErase := nil;
  End;
end;
procedure TclsopenBorSystemVst.setTreeSetting;
begin
  setTreeSetting(fTree);
end;
procedure TclsopenBorSystemVst.setTreeSetting(sender: TVirtualStringTree);
begin
  //Drag&Drop Feature
  sender.TreeOptions.AutoOptions := sender.TreeOptions.AutoOptions - [toAutoDeleteMovedNodes];
  //Allow Edit
  sender.TreeOptions.MiscOptions := sender.TreeOptions.MiscOptions + [toEditable];
  //Selection
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toFullRowSelect];
  //sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toMultiSelect];
  sender.TreeOptions.SelectionOptions := sender.TreeOptions.SelectionOptions + [toRightClickSelect];
end;
procedure TclsopenBorSystemVst.ImportDroppedFile(ImportFileName: String;
  ParentNode: PVirtualNode; rData: ropenBorSystem);
begin
  ImportDroppedFile(fTree,ImportFileName,ParentNode,rData);
end;
procedure TclsopenBorSystemVst.ImportDroppedFile(sender: TVirtualStringTree;
  ImportFileName: String; ParentNode: PVirtualNode; rData: ropenBorSystem);
Var
  ext : String;
begin
  {ext := ExtractFileExt(ImportFileName);
  rData.name := ExtractFileName(ImportFileName);
  MatStringReplace(rData.Name,ext,'');
  addopenBorSystemNode(sender,rData,ParentNode,xmlIncluded);}
end;
procedure TclsopenBorSystemVst.vstopenBorSystemCompareNodes(Sender: TBaseVirtualTree;
  Node1, Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  pData1,
  pData2: popenBorSystem;
  s1,s2: WideString;
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
       end;
    -: Begin
         s1 := pData1.gd;
         s2 := pData2.gd;
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
    {-: Begin
         s1 := pData1.dscrp;
         s2 := pData2.dscrp;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    -: Begin
         s1 := IntToStr(pData1.htyp);
         s2 := IntToStr(pData2.htyp);
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    -: Begin
         s1 := pData1.vald;
         s2 := pData2.vald;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    -: Begin
         s1 := pData1.lgth;
         s2 := pData2.lgth;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    -: Begin
         s1 := pData1.usd;
         s2 := pData2.usd;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;
    -: Begin
         s1 := pData1.avar;
         s2 := pData2.avar;
         MatStringReplace(s1,' ','');
         MatStringReplace(s2,' ','');
         Result := CompareText(s1, s2);
       end;  }

    end;
end;
procedure TclsopenBorSystemVst.vstopenBorSystemBeforeItemErase(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; ItemRect: TRect;
  var ItemColor: TColor; var EraseAction: TItemEraseAction);
Var
  pData : popenBorSystem;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(Node);
    //xmlopenBorSystem.delopenBorSystemData(pData);
  End;
end;
procedure TclsopenBorSystemVst.vstopenBorSystemDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  pDataSelected, pDataDropTarget : popenBorSystem;
  rData : ropenBorSystem;
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
    {//rData := xmlopenBorSystem.getopenBorSystemNew;
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
      xmlopenBorSystem.setopenBorSystemData(pDataSelected);}
end;

procedure TclsopenBorSystemVst.vstopenBorSystemDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: Integer; var Accept: Boolean);
begin
    Accept := sender = Sender;
end;
procedure TclsopenBorSystemVst.vstopenBorSystemGetNodeDataSize(
  Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := sizeof(ropenBorSystem);
end;
procedure TclsopenBorSystemVst.vstopenBorSystemGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  pData: popenBorSystem;
  s : Widestring;
begin
  pData := Sender.GetNodeData(Node);
  if Assigned(pData) then
    Case Column of
     {-: CellText := IntToStr(pData.id);
     -: CellText := pData.gd;}
     0: CellText := pData.title;
     {-: CellText := pData.dscrp;
     -: CellText := IntToStr(pData.htyp);
     -: CellText := pData.vald;
     -: CellText := pData.lgth;
     -: CellText := pData.usd;
     -: CellText := pData.avar;}

    end;
end;
procedure TclsopenBorSystemVst.vstopenBorSystemHeaderClick(Sender: TVTHeader;
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
procedure TclsopenBorSystemVst.vstopenBorSystemInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  pData: popenBorSystem;
begin
  with Sender do
  begin
    pData := GetNodeData(Node);
  end;
end;
function TclsopenBorSystemVst.addopenBorSystemNode(sender: TVirtualStringTree;
  popenBorSystemData: popenBorSystem; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  ropenBorSystemData : ropenBorSystem;
begin
  //ropenBorSystemData := xmlopenBorSystem.pData2openBorSystemrData(popenBorSystemData);
  Result := addopenBorSystemNode(sender,ropenBorSystemData,parentNode,includeXml);
end;
function TclsopenBorSystemVst.addopenBorSystemNode(ropenBorSystemData: ropenBorSystem;
  parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
begin
  result := addopenBorSystemNode(fTree,ropenBorSystemData,parentNode,includeXml);
end;
function TclsopenBorSystemVst.addopenBorSystemNode(sender: TVirtualStringTree;
  ropenBorSystemData: ropenBorSystem; parentNode: PVirtualNode;includeXml:Boolean): PVirtualNode;
Var
  aNode : PVirtualNode;
  popenBorSystemData : popenBorSystem;
  popenBorSystemParentData : popenBorSystem;
begin
  aNode := sender.AddChild(parentNode);
  popenBorSystemData := sender.GetNodeData(aNode);
  popenBorSystemData.id := ropenBorSystemData.id;
  popenBorSystemData.gd := ropenBorSystemData.gd;
  popenBorSystemData.title := ropenBorSystemData.title;
  popenBorSystemData.dscrp := ropenBorSystemData.dscrp;
  popenBorSystemData.htyp := ropenBorSystemData.htyp;
  popenBorSystemData.vald := ropenBorSystemData.vald;
  popenBorSystemData.lgth := ropenBorSystemData.lgth;
  popenBorSystemData.usd := ropenBorSystemData.usd;
  popenBorSystemData.avar := ropenBorSystemData.avar;
  popenBorSystemData.hasCommand := ropenBorSystemData.hasCommand;
  popenBorSystemData.Multiple := ropenBorSystemData.Multiple;
  popenBorSystemData.iCommand := ropenBorSystemData.iCommand;
  //New
  popenBorSystemData.Group := ropenBorSystemData.Group;
  //Script
  popenBorSystemData.ScrResult := ropenBorSystemData.ScrResult;
  popenBorSystemData.ScrName := ropenBorSystemData.ScrName;
  popenBorSystemData.ScrCode := ropenBorSystemData.ScrCode;
  popenBorSystemData.ScrType := ropenBorSystemData.ScrType;
  //xmlopenBorSystem.addopenBorSystemData(popenBorSystemData);
  result := aNode;
end;
{function TclsopenBorSystemVst.getopenBorSystemNew: ropenBorSystem;
Var
  ropenBorSystemData : ropenBorSystem;
Begin
  ropenBorSystemData := clearopenBorSystemrData(ropenBorSystemData);
  ropenBorSystemData.id := getHighestopenBorSystemID + 1;
  Result := ropenBorSystemData;
end;
function TclsopenBorSystemVst.clearopenBorSystemrData: ropenBorSystem;
Var
  ropenBorSystemData : ropenBorSystem;
Begin
  ropenBorSystemData.id := -1;
  ropenBorSystemData.gd := '';
  ropenBorSystemData.title := '';
  ropenBorSystemData.dscrp := '';
  ropenBorSystemData.htyp := -1;
  ropenBorSystemData.vald := '';
  ropenBorSystemData.lgth := '';
  ropenBorSystemData.usd := '';
  ropenBorSystemData.avar := '';

  Result := ropenBorSystemData;
end;
function TclsopenBorSystemVst.clearopenBorSystemrData(rData: ropenBorSystem): ropenBorSystem;
Var
  ropenBorSystemData : ropenBorSystem;
Begin
  ropenBorSystemData.id := -1;
  ropenBorSystemData.gd := '';
  ropenBorSystemData.title := '';
  ropenBorSystemData.dscrp := '';
  ropenBorSystemData.htyp := -1;
  ropenBorSystemData.vald := '';
  ropenBorSystemData.lgth := '';
  ropenBorSystemData.usd := '';
  ropenBorSystemData.avar := '';

  Result := ropenBorSystemData;
end;
Function TclsopenBorSystemVst.pData2openBorSystemrData(pData:popenBorSystem):ropenBorSystem;
Var
  rData : ropenBorSystem;
begin
  Try
    rData.id := pData.id;
    rData.gd := pData.gd;
    rData.title := pData.title;
    rData.dscrp := pData.dscrp;
    rData.htyp := pData.htyp;
    rData.vald := pData.vald;
    rData.lgth := pData.lgth;
    rData.usd := pData.usd;
    rData.avar := pData.avar;

  Finally
    Result := rData;
  End;
End;}
function TclsopenBorSystemVst.rData2openBorSystempData(
  rData: ropenBorSystem;pData:popenBorSystem): popenBorSystem;
begin
  Try
    pData.id := rData.id;
    pData.gd := rData.gd;
    pData.title := rData.title;
    pData.dscrp := rData.dscrp;
    pData.htyp := rData.htyp;
    pData.vald := rData.vald;
    pData.lgth := rData.lgth;
    pData.usd := rData.usd;
    pData.avar := rData.avar;
    pData.hasCommand := rData.hasCommand;
    pData.Multiple := rData.Multiple;
    pData.iCommand := rData.iCommand;
    //New
    pData.Group := rData.Group;
    //Script
    pData.ScrResult := rData.ScrResult;
    pData.ScrName := rData.ScrName;
    pData.ScrCode := rData.ScrCode;
    pData.ScrType := rData.ScrType;
  Finally
    Result := pData;
  End;
end;

end.
