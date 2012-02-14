unit frameEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExExtCtrls, JvNetscapeSplitter, JvComponent, JvPanel,
  clsopenBorSystemVst, clsanimeEntityListVst,
  clsEntityDetails, unCommon, clsModels,
  xmlopenBorSystemClass, frameGifList, mario,
  jvStrings, SynHighlighterTeX, SynHighlighterST, SynUniHighlighter, frmSynSearch,
  SynHighlighterCpp, SynEdit, ToolWin, ComCtrls, JvExComCtrls, JvToolBar,
  VirtualTrees, SynCompletionProposal, StdCtrls, JvgScrollBox,
  SynEditMiscClasses, SynEditSearch, Menus, ActiveX;

type
  TfrmEditorSyn = class(TFrame)
    pnlEditor: TJvPanel;
    pnlTree: TJvPanel;
    SynEdit1: TSynEdit;
    vstEditor: TVirtualStringTree;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    JvToolBar1: TJvToolBar;
    SynCompletionProposal1: TSynCompletionProposal;
    tbSave: TToolButton;
    cbSave: TCheckBox;
    cbFocus: TCheckBox;
    sbGifList: TJvgScrollBox;
    JvNetscapeSplitter2: TJvNetscapeSplitter;
    edtSearch: TEdit;
    SynEditSearch1: TSynEditSearch;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    popEditorTree: TPopupMenu;
    EditEntity1: TMenuItem;
    procedure vstEditorDblClick(Sender: TObject);
    procedure vstEditorGetHint(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex;
      var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure vstEditorPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure SynEdit1Click(Sender: TObject);
    procedure SynEdit1DblClick(Sender: TObject);
    procedure SynEdit1Enter(Sender: TObject);
    procedure SynEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SynEdit1Change(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure vstEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchChange(Sender: TObject);
    procedure vstEditorScroll(Sender: TBaseVirtualTree; DeltaX,
      DeltaY: Integer);
    procedure ToolButton1Click(Sender: TObject);
    procedure EditEntity1Click(Sender: TObject);
    procedure sbGifListDragDrop(Sender, Source: TObject; X, Y: Integer);


  private
    { Private declarations }
    mediaFrame : TfrmGifList;
    treeEditorVst : TclsopenBorSystemVst;
    aSyn : TSynUniSyn;
    entityDetails : TEntityDetails;
    nodeEntityHeader, nodeEntityAnimTypes, nodeEntityAnimData,
    nodeModels, nodeLevelHeader, nodeLevelSets, nodeLevelDesign,
    nodeLevelObjects, nodeFunctions : PVirtualNode;

    editorMode : Integer;
    sectionedMode : Integer;
    workingFile : String;
    emptyline : boolean;


    procedure loadHighlighter(aFilename:String; ExcludeHgl:Boolean=false);

    procedure editorCheckCommands;

    function editorGetCommandFromEdit(cmdName:String):String;
    function editorGetCommandListFromEdit(cmdName:String):TStringList;
    function editorCommandExists(cmd:String):Boolean;
    procedure editorSetCommandFromEdit(cmdName,newValue:String);
    procedure editorSetCommandListFromEdit(cmdName:String;newValue:TStrings);
    procedure discoverSectionMode;
    function hasAnimationScript:Integer;
    procedure addAnimationScript(foundMode:integer);
    procedure ScriptProcess(node:PVirtualNode);

    procedure editorLoadMedia(lineData:String);
  public
    { Public declarations }
    nodeEntities : PVirtualNode;
    modified : boolean;
    loadEntities : boolean;
    isLoading : boolean;
    startSectionMode : integer;
    nodeAnimationScript : PVirtualNode;
    procedure populateEntities;
    procedure populateEditorTree;
    function editorSearchViaMode(searchStr:String;mode:integer;partialfind:boolean=false):Boolean;
    procedure saveNodeScriptToFile(parentNode:PVirtualNode;fileName:String;logmode:boolean=false);
    function  logifymethod(pData : popenBorSystem):string;
    procedure formCreate;
    procedure formSave;
    procedure formStartup(fileName:String;mode:Integer;zEntityDetails:TEntityDetails;zsectionedMode:Integer=0); Overload;
    procedure formStartup(listData:TStringList;mode:Integer;zEntityDetails:TEntityDetails;zsectionedMode:Integer=0); Overload;
    procedure formClear;
    procedure setSectionMode(iMode:integer);
  end;

implementation

uses formSystemEditor, formCharacterEditor, unMain;

{$R *.dfm}

{ TfrmEditorSyn }

function TfrmEditorSyn.editorGetCommandFromEdit(cmdName: String): String;
Var
  i : integer;
  s, foundcmd : string;
  containsScript : boolean;
begin
  i := 0;
  foundcmd := '';
  containsScript := false;
  while i < SynEdit1.Lines.Count -1 do begin
    s := SynEdit1.Lines.Strings[i];
    //Detect scripts
    if (PosStr('@script',s) > 0) then
      containsScript := true;
    if (PosStr('@end_script',s) > 0) then
      containsScript := False;
    if containsScript = true then Begin

    end else Begin
      StringDelete2End(s,' ');
      if PosStr(cmdName,s) > 0 then Begin
        foundcmd := SynEdit1.Lines.Strings[i];
        i:= SynEdit1.Lines.Count;
      end;
    end;
    inc(i);
  end;
  result := foundcmd;
end;

function TfrmEditorSyn.editorGetCommandListFromEdit(
  cmdName: String): TStringList;
Var
  i : integer;
  s, s1, foundcmd : string;
  listsdata : TStringList;
  containsScript : boolean;
begin
  i := 0;

  listsdata := TStringList.Create;
  foundcmd := '';
  containsScript := false;
  while i < SynEdit1.Lines.Count -1 do begin
    s := SynEdit1.Lines.Strings[i];
    //Detect scripts
    if (PosStr('@script',s) > 0) then
      containsScript := true;
    if (PosStr('@end_script',s) > 0) then
      containsScript := False;
    if containsScript = true then Begin

    end else Begin
      s1 := s;
      StringReplace(s,#09,' ');
      StringDelete2End(s,' ');
      if PosStr(cmdName,s) > 0 then Begin
        listsdata.Add(s1);
        //listData.Add(s1);
      end;
    end;
    inc(i);
  end;
  result := listsdata;
end;

procedure TfrmEditorSyn.editorSetCommandFromEdit(cmdName,
  newValue: String);
Var
  i : integer;
  s, foundcmd : string;
  found, containsScript : boolean;

begin
  i := 0;
  found := false;
  foundcmd := '';
  containsScript := false;
  while i < SynEdit1.Lines.Count -1 do begin
    s := SynEdit1.Lines.Strings[i];

    //Detect scripts
    if (PosStr('@script',s) > 0) then
      containsScript := true;
    if (PosStr('@end_script',s) > 0) then
      containsScript := False;
    if containsScript = true then Begin

    end else Begin
      StringDelete2End(s,' ');
      if PosStr(cmdName,s) > 0 then Begin
        found := true;
        SynEdit1.Lines.Strings[i] := newValue;
        i:= SynEdit1.Lines.Count;
      end;
    end;
    inc(i);
  end;
  if found = false then Begin

    if SynEdit1.CaretY > 0 then
      SynEdit1.Lines.Insert(SynEdit1.CaretY,newValue)
    else
      SynEdit1.Lines.add(newValue);
  end;
end;

procedure TfrmEditorSyn.editorSetCommandListFromEdit(cmdName: String;
  newValue: TStrings);
Var
  i, iFoundAt : integer;
  s, foundcmd : string;
  found, containsScript : boolean;
begin
  i := 0;
  found := false;
  foundcmd := '';
  containsScript := false;
  while i < SynEdit1.Lines.Count -1 do begin
    s := SynEdit1.Lines.Strings[i];

    //Detect scripts
    if (PosStr('@script',s) > 0) then
      containsScript := true;
    if (PosStr('@end_script',s) > 0) then
      containsScript := False;
    if containsScript = true then Begin
      inc(i);
    end else Begin
      StringDelete2End(s,' ');
      if PosStr(cmdName,s) > 0 then Begin
        found := true;
        SynEdit1.Lines.Delete(i);
        iFoundAt := i;
        //SynEdit1.Lines.Strings[i] := newValue;
      end else
        inc(i);
    end;
  end;
  i := newValue.Count -1;
  while i >= 0 do Begin
  //for i:= 0 to newValue.Count -1 do Begin
    if found = true then
      SynEdit1.Lines.Insert(iFoundAt,newValue.Strings[i])
    else
      SynEdit1.Lines.Add(newValue.Strings[i]);
    i := i - 1;
  end;
{  end Else
  if found = false then Begin

    if SynEdit1.CaretY > 0 then
      SynEdit1.Lines.Insert(SynEdit1.CaretY,newValue)
    else
      SynEdit1.Lines.add(newValue);
  end;}
end;

procedure TfrmEditorSyn.formClear;
begin
  Try
    isLoading := True;
    SynEdit1.Clear;
    modified := false;
    workingFile := '';
  Finally
    isLoading := False;
  end;
end;

procedure TfrmEditorSyn.formCreate;
begin
  try
    isLoading := True;
    loadEntities := False;
    treeEditorVst := TclsopenBorSystemVst.Create(vstEditor,ses.borSys);
    vstEditor.TreeOptions.MiscOptions := vstEditor.TreeOptions.MiscOptions - [toEditable];
    aSyn := TSynUniSyn.Create(SynEdit1);
    loadHighlighter('Text Files');
    populateEditorTree;
    vstEditor := treeVisuals(vstEditor);

    mediaFrame := TfrmGifList.Create(sbGifList);
    mediaFrame.Parent := sbGifList;
    mediaFrame.Align := alLeft;
    //mediaFrame.workingFolder := workingFolder;
    mediaFrame.Width := 50;
    Randomize;
    mediaFrame.Name := 'zzGifzzeditor'+IntToStr(random(100));
    //mediaFrame.edtGifName.Text := IntToStr(i);
    mediaFrame.pnlBottom.Visible := false;

  finally
    isLoading := False;
  end;
end;

procedure TfrmEditorSyn.formStartup(fileName: String; mode: Integer;zEntityDetails:TEntityDetails;zsectionedMode:Integer=0);
begin
  Try
    isLoading := True;
    if FileExists(fileName) then Begin
      entityDetails := zEntityDetails;
      JvToolBar1.Visible := true;
      workingFile := fileName;
      startSectionMode := mode;
      sectionedMode := zsectionedMode;
      setSectionMode(mode);
      SynEdit1.Lines.LoadFromFile(fileName);
      if ses.reloadsystem = true then Begin
        populateEditorTree;
        ses.reloadsystem := false;
      end;
      modified := false;
    end;
  finally
    isLoading := False;
  end;
end;

procedure TfrmEditorSyn.formStartup(listData: TStringList; mode: Integer;zEntityDetails:TEntityDetails;zsectionedMode:Integer=0);
begin
  Try
    isLoading := True;
    JvToolBar1.Visible := false;
    entityDetails := zEntityDetails;
    startSectionMode := mode;
    sectionedMode := zsectionedMode;
    setSectionMode(mode);
    SynEdit1.Lines := listData;
    modified := false;
  Finally
    isLoading := False;
  end;
end;

procedure TfrmEditorSyn.vstEditorDblClick(Sender: TObject);
Var
  pData : popenBorSystem;
  rData : ropenBorSystem;
  changedString : string;
  changedStrings : tstrings;
begin
  //pEntityHeader, pEntityAnimTypes, pEntityAnimData : PVirtualNode;
  ScriptProcess(vstEditor.FocusedNode);
  if (vstEditor.FocusedNode = nodeEntityHeader) or
     (vstEditor.FocusedNode = nodeEntityAnimTypes) or
     (vstEditor.FocusedNode = nodeEntityAnimData) or
     (vstEditor.FocusedNode = nodeModels) or
     (vstEditor.FocusedNode = nodeLevelHeader) or
     (vstEditor.FocusedNode = nodeLevelSets) or
     (vstEditor.FocusedNode = nodeLevelDesign) or
     (vstEditor.FocusedNode = nodeLevelObjects) or
     (vstEditor.FocusedNode = nodeFunctions) or
     (vstEditor.FocusedNode = nodeAnimationScript) then
     exit;
  if vstEditor.FocusedNode <> nil then Begin
    pData := vstEditor.GetNodeData(vstEditor.FocusedNode);
    ses.ropenBorSystemSelected := ses.borSys.pData2openBorSystemrData(pData);
    rData := ses.borSys.pData2openBorSystemrData(pData);
    frmSystemEditor.setMode(0);
    if rData.Multiple < 0 then
      rData.Multiple := 0;
    //if editorMode = 2 then Begin
    rData.Multiple := 0;
    changedString := SynEdit1.Lines.Strings[SynEdit1.CaretY-1];
    frmSystemEditor.populateData(rData,changedString,entityDetails);
    {end else Begin
      Case rData.Multiple of
        0 : Begin
              changedString := editorGetCommandFromEdit(pData.title);
              frmSystemEditor.populateData(rData,changedString);
            end;
        1 : Begin
              changedStrings := editorGetCommandListFromEdit(pData.title);
              frmSystemEditor.populateData(rData,changedStrings);
            end;
      end;
    end;}
    frmSystemEditor.workingrData := rData;
    frmSystemEditor.ShowModal;
    if frmSystemEditor.returnString <> '' then Begin
      //if editorMode = 2 then Begin
        SynEdit1.Lines.Strings[SynEdit1.CaretY-1] := frmSystemEditor.returnString;
      {end else
        if editorMode = 0 then Begin
          editorSetCommandFromEdit(rData.title,frmSystemEditor.returnString);
        end;}
      modified := true;
    end else
      if frmSystemEditor.returnValues.count > 0 then Begin
        editorSetCommandListFromEdit(rData.title,frmSystemEditor.returnValues);
      end;
  end;
end;

procedure TfrmEditorSyn.vstEditorGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: WideString);
Var
  pData : popenBorSystem;
begin
  try
    if node <> nil then Begin
      pData := Sender.GetNodeData(node);
      HintText := pData.dscrp;
    end;
  except
  end;
end;

procedure TfrmEditorSyn.vstEditorPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
Var
  pData : popenBorSystem;
  pBlack : boolean;
begin
  {if JvPageControl1.ActivePageIndex <> 1 then
    exit
  else }Begin
    if node <> nil then Begin
      pData := Sender.GetNodeData(node);
      if (pData.htyp = editorMode) or
         (cbFocus.Checked = false) then Begin
        pBlack := true;
      end else
      if (pData.htyp = 9) and
         (editorMode = 2) then
           pBlack := true
      else
        pBlack := false;
      if pBlack = true then Begin
        TargetCanvas.Font.Color := clBlack;
        if pData.hasCommand = true then
          TargetCanvas.Font.Style := [fsBold]
        else
          TargetCanvas.Font.Style := [];
      end else Begin
        TargetCanvas.Font.Color := clLtGray;
      end;
      if Sender.FocusedNode = node then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsUnderline];
      //Check search
      if edtSearch.Visible = true then
        if PosStr(LowerCase(edtSearch.Text),LowerCase(pData.title)) > 0 then
          TargetCanvas.Font.Color := clBlue
        else
          TargetCanvas.Font.Color := clBlack;
   end;
  end;
end;

procedure TfrmEditorSyn.SynEdit1Click(Sender: TObject);
Var
  s, fllLine : string;
begin
  if SynEdit1.CaretY >= 0 then Begin
    if sectionedMode = 0 then
      discoverSectionMode;
    fllLine := SynEdit1.Lines.Strings[SynEdit1.CaretY-1];
    s := strClearAll(fllLine);
    if s = '' then
      emptyline := true
    else
      emptyline := false;
    //search Tree
    if PosStr('@cmd',fllLine) > 0 then Begin
      StringDeleteUp2(s,' ');
      StringDelete2End(s,' ');
      if editorMode = 2 then
        editorSearchViaMode(s,9);
    end else Begin
      StringDelete2End(s,' ');
      editorSearchViaMode(s,editorMode);
    end;
    if sectionedMode = 1 then Begin
      mediaFrame.Visible := false;
      frmCharacterEditor.editorLoadMedia(strClearAll(SynEdit1.Lines.Strings[SynEdit1.CaretY-1]));
      //JvNetscapeSplitter2.Minimized := true;
    end
    else Begin
      editorLoadMedia(strClearAll(SynEdit1.Lines.Strings[SynEdit1.CaretY-1]));
      mediaFrame.Visible := true;
    end;
  end;
end;

procedure TfrmEditorSyn.SynEdit1DblClick(Sender: TObject);
Var
  s : string;
  found : Boolean;
begin
  if SynEdit1.CaretY >= 0 then Begin
    s := SynEdit1.Lines.Strings[SynEdit1.CaretY-1];
    s := strRemoveDbls(s);
    StringReplace(s,#09,' ');
    s := strClearStartEnd(s);
    StringDelete2End(s,' ');

    //search Tree
    found := editorSearchViaMode(s,editorMode);
    if found = true then
      vstEditorDblClick(vstEditor);
  end;
end;

function TfrmEditorSyn.editorSearchViaMode(searchStr: String;
  mode: integer;partialfind:boolean): Boolean;
Var
  node, groupNode, parentNode : PVirtualNode;
  pData : popenBorSystem;
  found, canProceed: boolean;
  grp : string;
begin
  if (cbFocus.Checked = false) and
     (partialfind = false) then
    exit;
  LowerCase(searchStr);
  found := false;
  canProceed := false;
  grp := '';
  Try
    if Length(searchStr) > 0 then
      while searchStr[Length(searchStr)] in inters do Begin
        delete(searchStr,length(searchStr),1);
      end;
  except
  end;
  if vstEditor.FocusedNode <> nil then Begin
    pData := vstEditor.GetNodeData(vstEditor.FocusedNode);
    if pData.title = searchStr then Begin
      grp := pData.Group;
      found := true;
    end;
  end;
  try
    if found = false then Begin
      case mode of
        0: Begin
            node := nodeEntityHeader;
            canProceed := true;
           end;
        1: Begin
            node := nodeEntityAnimTypes;
            canProceed := true;
           end;
        2: Begin
            node := nodeEntityAnimData;
            canProceed := true;
           end;
        3: Begin
            node := nodeModels;
            canProceed := true;
           end;
        4: Begin
            node := nodeLevelHeader;
            canProceed := true;
           end;
        5: Begin
            node := nodeLevelSets;
            canProceed := true;
           end;
        6: Begin
            node := nodeLevelDesign;
            canProceed := true;
           end;
        7: Begin
            node := nodeLevelObjects;
            canProceed := true;
           end;
        8: Begin
            node := nodeFunctions;
            canProceed := true;
           end;
        9: Begin
            node := nodeAnimationScript;
            canProceed := true;
           end;
      end;
      if canProceed = true then Begin
        if partialfind = true then Begin
          node := vstEditor.FocusedNode;
        end;
        node := vstEditor.GetNext(node);
        while (node <> nil) and
              (found = false) do Begin
           pData := vstEditor.GetNodeData(node);
           if partialfind = false then Begin
             if pData.title = searchStr then Begin
               vstEditor.FocusedNode := node;
               vstEditor.Selected[node] := true;

               parentNode := vstEditor.NodeParent[node];
               vstEditor.Expanded[parentNode] := true;
               found := true;
             end;
           end else begin
             if (PosStr(searchStr,LowerCase(pData.title)) > 0) then begin
               vstEditor.FocusedNode := node;
               vstEditor.Selected[node] := true;

               parentNode := vstEditor.NodeParent[node];
               vstEditor.Expanded[parentNode] := true;
               found := true;
             end;
           end;
             node := vstEditor.GetNext(node)
         end;
      end;
    end;
  except
  end;
  if (partialfind = true) and
     (found = false) then begin
     vstEditor.FocusedNode := vstEditor.GetFirst;
  end;
  Result := found;
end;

procedure TfrmEditorSyn.SynEdit1Enter(Sender: TObject);
Var
  pData : panimeEntityList;
begin
  {if frmCharacterEditor.vstAnimList.FocusedNode <> nil then Begin
    pData := frmCharacterEditor.vstAnimList.GetNodeData(frmCharacterEditor.vstAnimList.FocusedNode);
    case pData.zType of
      0: Begin
           setSectionMode(0);
         end;
      1: Begin
           setSectionMode(2);
         end;
    end;
  end; }
end;

procedure TfrmEditorSyn.setSectionMode(iMode: integer);
begin
  editorMode := iMode;
  if sectionedMode = 1 then
    editorCheckCommands;
  //nodeEntityHeader, nodeEntityAnimTypes, nodeEntityAnimData
  if cbFocus.Checked = false then Begin

  end else Begin
    case iMode of
      0: Begin
           vstEditor.Expanded[nodeEntityHeader] := True;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := false;
           vstEditor.Expanded[nodeModels] := false;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      1: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := True;
           vstEditor.Expanded[nodeEntityAnimData] := false;
           vstEditor.Expanded[nodeModels] := false;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      2: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := True;
           vstEditor.Expanded[nodeModels] := false;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      3: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := True;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;

      4: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := False;
           vstEditor.Expanded[nodeLevelHeader] := True;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      5: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := False;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := True;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      6: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := false;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := true;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      7: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := False;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := True;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      8: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := False;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := True;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := False;
         end;
      9: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := False;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := True;
           vstEditor.Expanded[nodeEntities] := False;
         end;
       10: Begin
           vstEditor.Expanded[nodeEntityHeader] := false;
           vstEditor.Expanded[nodeEntityAnimTypes] := false;
           vstEditor.Expanded[nodeEntityAnimData] := False;
           vstEditor.Expanded[nodeModels] := False;
           vstEditor.Expanded[nodeLevelHeader] := False;
           vstEditor.Expanded[nodeLevelSets] := False;
           vstEditor.Expanded[nodeLevelDesign] := False;
           vstEditor.Expanded[nodeLevelObjects] := False;
           vstEditor.Expanded[nodeFunctions] := False;
           vstEditor.Expanded[nodeAnimationScript] := False;
           vstEditor.Expanded[nodeEntities] := True;
         end;
    end;
  end;
  vstEditor.Refresh;
end;

procedure TfrmEditorSyn.editorCheckCommands;
Var
  pData : popenBorSystem;
  node : PVirtualNode;
  canProceed : Boolean;
begin
  canProceed := false;
  //pEntityHeader, pEntityAnimTypes, pEntityAnimData
  case editorMode of
    0: Begin
         node := vstEditor.GetFirstChild(nodeEntityHeader);
         canProceed := True;
       end;
    1: Begin
         node := vstEditor.GetFirstChild(nodeEntityAnimTypes);
         canProceed := True;
       end;
    2: Begin
         node := vstEditor.GetFirstChild(nodeEntityAnimData);
         canProceed := True;
       end;
    3: Begin
         node := vstEditor.GetFirstChild(nodeModels);
         canProceed := True;
       end;
    4: Begin
         node := vstEditor.GetFirstChild(nodeLevelHeader);
         canProceed := True;
       end;
    5: Begin
         node := vstEditor.GetFirstChild(nodeLevelSets);
         canProceed := True;
       end;
    6: Begin
         node := vstEditor.GetFirstChild(nodeLevelDesign);
         canProceed := True;
       end;
    7: Begin
         node := vstEditor.GetFirstChild(nodeLevelObjects);
         canProceed := True;
       end;
    8: Begin
         node := vstEditor.GetFirstChild(nodeFunctions);
         canProceed := True;
       end;
    9: Begin
         node := vstEditor.GetFirstChild(nodeAnimationScript);
         canProceed := True;
       end;
  end;
  if canProceed = true then Begin
    while node <> nil do Begin
       pData := vstEditor.GetNodeData(node);
       if editorCommandExists(pData.title) = true then Begin
         pData.hasCommand := true;
       end else
         pData.hasCommand := false;
       node := vstEditor.GetNextSibling(node);
     end;
  end;
  vstEditor.Refresh;
end;

function TfrmEditorSyn.editorCommandExists(cmd: String): Boolean;
Var
  i : integer;
  s : string;
  found : boolean;
  containsScript : Boolean;
begin
  i := 0;
  found := false;
  containsScript := False;
  while i < SynEdit1.Lines.Count -1 do begin
    s := SynEdit1.Lines.Strings[i];

    //Detect scripts
    if (PosStr('@script',s) > 0) then
      containsScript := true;
    if (PosStr('@end_script',s) > 0) then
      containsScript := False;
    if containsScript = true then Begin

    end else Begin
      s := strClearAll(s);
      StringDelete2End(s,' ');
      if PosStr(cmd,s) > 0 then Begin
        found := true;
        i:= SynEdit1.Lines.Count;
      end;
    end;
    inc(i);
  end;
  result := found;
end;

procedure TfrmEditorSyn.SynEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  fllLine : string;
begin
  case key of
    VK_UP: SynEdit1Click(SynEdit1);
    VK_DOWN: SynEdit1Click(SynEdit1);
    VK_RETURN: SynEdit1Click(SynEdit1);
  end;
  if (ssCtrl in shift) and (Key = VK_RETURN) then
    SynEdit1DblClick(SynEdit1);
  if emptyline = true then Begin
    fllLine := SynEdit1.Lines.Strings[SynEdit1.CaretY-1];
    fllLine := strClearAll(fllLine);
    editorSearchViaMode(LowerCase(fllLine),editorMode,true);
  end;

end;

procedure TfrmEditorSyn.loadHighlighter(aFilename: String;
  ExcludeHgl: Boolean);
Var
  s : String;
begin
  Try
  s := ExtractFilePath(Application.ExeName)+'Highlighters\'+aFilename+'.hgl';
  If FileExists(s) then Begin
    if ExcludeHgl = false then
      aSyn.LoadHglFromFile(s);
    SynEdit1.Highlighter := aSyn;
    //SynExporterRTF.Highlighter := SynEdit1.Highlighter;
  End;
  If FileExists(ExtractFilePath(Application.ExeName)+'Highlighters\'+aFilename+'.Dst') then Begin
    SynCompletionProposal1.ItemList.LoadFromFile(ExtractFilePath(Application.ExeName)+'Highlighters\'+aFilename+'.Dst');
  End;
  If FileExists(ExtractFilePath(Application.ExeName)+'Highlighters\'+aFilename+'.Ist') then Begin
    SynCompletionProposal1.InsertList.LoadFromFile(ExtractFilePath(Application.ExeName)+'Highlighters\'+aFilename+'.Ist');
    SynCompletionProposal1.Options := [scoLimitToMatchedText,scoUseInsertList,scoUsePrettyText,scoUseBuiltInTimer,scoEndCharCompletion,scoCompleteWithTab,scoCompleteWithEnter];
  End;
  If SynCompletionProposal1.ItemList.Count < 1 then
    //SynCompletionProposal1.ItemList.LoadFromFile(aConfig.GlobalDictFile);
  Except
  End;
{  If aFilename = 'SQL' then
    SynEdit1.Highlighter.UseUserSettings(2);}
end;

procedure TfrmEditorSyn.populateEditorTree;
Var
  i : integer;
  rData : ropenBorSystem;
  groupNode : PVirtualNode;
begin
  //Add Root Nodes
  //Entity header
  vstEditor.Clear;
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Header';
  rData.htyp := 0;
  nodeEntityHeader := nil;
  nodeEntityHeader := treeEditorVst.addopenBorSystemNode(rData,nil,false);
  form1.addSubGroupsEntity(nodeEntityHeader,ses.borSys.getGroupList(0),1,treeEditorVst);
  //Entity Anim Types
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Anim Types';
  rData.htyp := 1;
  nodeEntityAnimTypes := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeEntityAnimTypes,ses.borSys.getGroupList(1),1,treeEditorVst);
  //Entity Anim Data
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Anim Data';
  rData.htyp := 2;
  nodeEntityAnimData := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeEntityAnimData,ses.borSys.getGroupList(2),1,treeEditorVst);
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
  //inbuilt Functions
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Script Functions';
  rData.htyp := 8;
  nodeFunctions := treeEditorVst.addopenBorSystemNode(rData,nil);
  form1.addSubGroupsEntity(nodeFunctions,ses.borSys.getGroupList(8),1,treeEditorVst);
  //inbuilt Functions
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
           groupNode := form1.getSubGroupsEntity(nodeEntityHeader,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//pEntityHeader);
         end;
      1: Begin
           groupNode := form1.getSubGroupsEntity(nodeEntityAnimTypes,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//pEntityAnimTypes);
         end;
      2: Begin
           groupNode := form1.getSubGroupsEntity(nodeEntityAnimData,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//pEntityAnimData);
         end;
      3: Begin
           groupNode := form1.getSubGroupsEntity(nodeModels,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeModels);
         end;
      4: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelHeader,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelHeader);
         end;
      5: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelSets,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelSets);
         end;
      6: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelDesign,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelDesign);
         end;
      7: Begin
           groupNode := form1.getSubGroupsEntity(nodeLevelObjects,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeLevelObjects);
         end;
      8: Begin
           groupNode := form1.getSubGroupsEntity(nodeFunctions,rData.Group,1,vstEditor);
           treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeFunctions);
         end;
      9: Begin
           //if config.debugmode = true then Begin
             groupNode := form1.getSubGroupsEntity(nodeAnimationScript,rData.Group,1,vstEditor);
             treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeAnimationScript);
           //End;
         end;
    end;
  end;
  vstEditor.SortTree(0,sdAscending);
end;

procedure TfrmEditorSyn.discoverSectionMode;
var
  i, iNewMode : integer;
  s : string;
  found : boolean;
begin
  i := SynEdit1.CaretY-1;
  iNewMode := -1;
  while i >= 0 do Begin
    s := SynEdit1.Lines.Strings[i];
    s := strClearAll(s);
    if isNewAnimBlock(s) = true then Begin
      iNewMode := 2;
      found := true;
      i := -1;
    end;
    if isLevelSetBlock(s) = true then Begin
      iNewMode := 5;
      found := true;
      i := -1;
    end;
    if isSpawnBlock(s) = true then Begin
      iNewMode := 7;
      found := true;
      i := -1;
    end;
    if isScriptBlock(s) = true then Begin
      iNewMode := 8;
      found := true;
      i := -1;
    end;
    if PosStr('load', s) > 0 then Begin

    end;
    i := i - 1;
  end;
  if found = true then
    setSectionMode(iNewMode)
  else
    setSectionMode(startSectionMode);
end;

procedure TfrmEditorSyn.SynEdit1Change(Sender: TObject);
begin
  if isLoading = false then Begin
    modified := true;
  end;
end;

procedure TfrmEditorSyn.tbSaveClick(Sender: TObject);
begin

    formSave;
    showBubble('Save','Succesfully Saved: ' + workingFile,1000);

end;

procedure TfrmEditorSyn.formSave;
Var
  i, iFoundAt : integer;
  s : string;
  fnd : Boolean;
begin
  if cbSave.Checked = true then
    if workingFile <> '' then Begin
      i := SynEdit1.Lines.Count;
      while i > 0 do Begin
         //#|edited by openBor Stats v 0.15
         s := SynEdit1.Lines.Strings[i];
         if PosStr('#|edited by', s) > 0 then Begin
           iFoundAt := i;
           fnd := true;
           i := 0;
         end;
         i := i -1;
      end;
      if fnd = true then Begin
        SynEdit1.Lines.Strings[iFoundAt] := '#|edited by ' + Form1.Caption;
      end else Begin
        SynEdit1.Lines.Add('');
        SynEdit1.Lines.Add('//#|edited by ' + Form1.Caption);
        SynEdit1.Lines.Add('');
      end;
      SynEdit1.Lines.SaveToFile(workingFile);
    end;
end;

procedure TfrmEditorSyn.saveNodeScriptToFile(parentNode: PVirtualNode;
  fileName: String;logmode:boolean);
Var
  node : PVirtualNode;
  pData : popenBorSystem;
  aList : TStringList;
begin
  node := vstEditor.GetFirstChild(parentNode);
  aList := TStringList.Create;
  while node <> nil do Begin
    //vstEditor.HasAsParent
    if vstEditor.HasAsParent(node,parentNode) = false then
      node := nil
    else Begin
      pData := vstEditor.GetNodeData(node);
      if ( logmode = false ) then
        aList.Text := aList.Text + #10+#13 + pData.ScrCode
      else
        aList.Text := aList.Text + #10+#13 + logifymethod(pData);
      //aList.Text := aList.Text + pData.dscrp;
      node := vstEditor.GetNext(node);
    end;
  end;
  aList.Add('');
  aList.Add('//#|edited by ' + Form1.Caption);
  aList.Add('');
  aList.SaveToFile(fileName);
  aList.Free;
end;

procedure TfrmEditorSyn.ScriptProcess(node: PVirtualNode);
Var
  pData : popenBorSystem;
  iAnim : integer;
begin
  //sectionedMode
  //editorMode
  //if config.debugmode = true then Begin
    if node <> nil then Begin
      pData := vstEditor.GetNodeData(node);
    end;
    case editorMode of
      2: Begin //Only work in Anim Data modes for animation script
           if node <> nil then Begin
             pData := vstEditor.GetNodeData(node);
             if pData.htyp = 9 then Begin
               iAnim := hasAnimationScript;
               addAnimationScript(iAnim);
             end;
           end;
         End;
        else
        if node <> nil then
          if pData.htyp = 9 then
            showBubble('Warning','Animation Scripts belong in "Anim" data blocks!');
    end;
  //end;
end;

function TfrmEditorSyn.hasAnimationScript: Integer;
Var
  i, iFound : integer;

  s : string;
begin
  iFound := -1;
  case sectionedMode of
    0: Begin
         i := 0;
         while i < SynEdit1.Lines.Count do Begin
           s := strClearAll(SynEdit1.Lines.Strings[i]);
           if PosStr('animationscript',s) > 0 then Begin
             iFound := i;
             i := SynEdit1.Lines.Count;
           end;
           inc(i);
         end;
       end;
    1: Begin //is Section of
         i := 0;
         while i < entityDetails.headers.Count do Begin
           s := strClearAll(entityDetails.headers.Strings[i]);
           if PosStr('animationscript',s) > 0 then Begin
             iFound := i;
             i := entityDetails.headers.Count;
           end;
           inc(i);
         end;
       end;
  end;
  //Returns where it found the line number.
  Result := iFound;
end;

procedure TfrmEditorSyn.addAnimationScript(foundMode:integer);
Var
  i : integer;
  s, sd : string;
begin
  s := #09+'animationscript'+#09+ 'data/scripts/aniScp.c';
  if not DirectoryExists(ses.dataDirecotry + '\scripts') then
    CreateDirectory(pchar(ses.dataDirecotry + '\scripts'),nil);
  case sectionedMode of
    0: Begin
         i := 0;
         if foundMode = -1 then
           while i < SynEdit1.Lines.Count do begin
             sd := SynEdit1.Lines.Strings[i];
             if isLineEmpty(sd) then Begin

               SynEdit1.Lines.Strings[i] := s;
               synedit1.Lines.Insert(i,'');
               i := SynEdit1.Lines.Count;
             end;
             inc(i);
           end;
       end;
    1: Begin
      //animationscript data/scripts/script.c
        if foundMode = -1 then
         entityDetails.headers.Add(s);
       end;
  end;
  saveNodeScriptToFile(nodeAnimationScript,ses.dataDirecotry+'\scripts\aniScp.c');
end;

procedure TfrmEditorSyn.editorLoadMedia(lineData: String);
Var
  i : integer;
  s : string;
  containsGif : Boolean;
  aFrm : TfrmGifList;
  entity : TEntityDetails;
begin
  if (isSpawn(lineData)) or
     (isItem(lineData)) or
     (isLoad(lineData)) then Begin
    containsGif := true;
    if Form1.models <> nil then Begin
      entity := Form1.models.getEntityByName(strip2Bar('spawn',lineData));
      if entity = nil then
        entity := Form1.models.getEntityByName(strip2Bar('item',lineData));
      if entity <> nil then
        lineData := strClearAll(ses.dataDirecotry+'\'+entity.getIdleImage)
      else
        lineData := '';
    end;
  end else Begin
    lineData := strRemoveDbls(lineData);
    lineData := strClearStartEnd(lineData);
    StringReplace(lineData,#09,' ');
    StringDeleteUp2(lineData,' ');
    lineData := LowerCase(lineData);
  end;
  //if PosStr('.gif',lineData) > 0 then
  if isImageFile(lineData) = true then
    containsGif := true
  else
    containsGif := false;
  i := 1;
  if containsGif then Begin
    //while PosStr('.gif', lineData) > 0 do begin

    while PosStr('.gif', lineData) > 0 do begin
      s := lineData;
      StringDelete2End(s,' ');
      StringDeleteUp2(lineData,'.gif',4);
      mediaFrame.loadImage(s,nil);
      mediaFrame.Left := 0;
      mediaFrame.Width := mediaFrame.gifWidth;
      mediaFrame.Visible := true;
      mediaFrame.updateVisuals(mediaFrame.Width,mediaFrame.Height);
      inc(i);
    end;
    while PosStr('.png', lineData) > 0 do begin
      s := lineData;
      StringDelete2End(s,' ');
      StringDeleteUp2(lineData,'.png',4);
      mediaFrame.loadImage(s,nil);
      mediaFrame.Left := 0;
      mediaFrame.Width := mediaFrame.gifWidth;
      mediaFrame.Visible := true;
      mediaFrame.updateVisuals(mediaFrame.Width,mediaFrame.Height);
      inc(i);
    end;
  end;
end;

procedure TfrmEditorSyn.populateEntities;
Var
  i : integer;
  rData : ropenBorSystem;
  bData : TModelsData;
  groupNode : PVirtualNode;
begin
  //Add Root Nodes
  //Entity header
  if loadEntities = false then
    exit;
  EditEntity1.Visible := True;
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entities';
  rData.htyp := 3;
  groupNode := nil;
  nodeEntities := treeEditorVst.addopenBorSystemNode(rData,nil,false);
  form1.addSubGroupsEntity(nodeEntities,form1.models.getEntityTypeList,1,treeEditorVst);
  for i := 0 to form1.models.listEntities.Count -1 do Begin
    rData := ses.borSys.clearopenBorSystemrData(rdata);
    bData := form1.models.listEntities.Objects[i] as TModelsData;

    rData.id := i;
    rData.title := bData.entName;
    rData.htyp := -1;
    rData.dscrp := bData.entFile;

    groupNode := Form1.getSubGroupsEntity( nodeEntities,form1.models.getEntityType(i),1,vstEditor );
    treeEditorVst.addopenBorSystemNode(rData,groupNode);//nodeModels);
  end;
end;
















procedure TfrmEditorSyn.vstEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var
  s : char;
begin
  if nonecharkey(key,Shift) = false then Begin
    if edtSearch.Visible = false then Begin
      edtSearch.Text := '';

      //edtSearch.Visible := true;
      //edtSearch.SetFocus;
    end;
    ShowHighLightShw(edtSearch,Key,vstEditor);
  end;
  IF KEY = VK_ESCAPE then
    edtSearch.Visible := false;
end;

procedure TfrmEditorSyn.edtSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF KEY = VK_ESCAPE then
    edtSearch.Visible := false;
  case key of
    VK_UP: vstEditor.SetFocus;
    VK_DOWN: vstEditor.SetFocus;
    VK_RETURN: editorSearchViaMode(LowerCase((sender as TEdit).Text),editorMode,true);
  end;
end;

procedure TfrmEditorSyn.edtSearchChange(Sender: TObject);
begin
  vstEditor.Repaint;
  editorSearchViaMode( LowerCase((sender as TEdit).Text),editorMode,true );
end;

procedure TfrmEditorSyn.vstEditorScroll(Sender: TBaseVirtualTree; DeltaX,
  DeltaY: Integer);
begin
  if edtSearch.Visible = true then Begin
    edtSearch.Top := vstEditor.Top + vstEditor.Height - 40;
  end;
end;

procedure TfrmEditorSyn.ToolButton1Click(Sender: TObject);
var
  dlg: TTextSearchDialog1;
      gbSearchBackwards: boolean;
    gbSearchCaseSensitive: boolean;
    gbSearchFromCaret: boolean;
    gbSearchSelectionOnly: boolean;
    gbSearchTextAtCaret: boolean;
    gbSearchWholeWords: boolean;
    gbSearchRegex: boolean;
    gsSearchText: string;
    gsSearchTextHistory: string;
    gsReplaceText: string;
    gsReplaceTextHistory: string;
    fSearchFromCaret: boolean;
    lastSearch : WideString;
    searchStr : string;
    ShowDialog : boolean;
begin
  //if form1.canProceed = true then Begin
    ShowDialog := true;
    {if AReplace then
      dlg := TTextReplaceDialog.Create(Self)
    else}
      dlg := TTextSearchDialog1.Create(Self);
    //fSearchFromCaret := fSearchFromCaret;
    with dlg do try
      // assign search options
      {SearchBackwards := gbSearchBackwards;
      SearchCaseSensitive := gbSearchCaseSensitive;
      SearchFromCursor := gbSearchFromCaret;
      SearchInSelectionOnly := gbSearchSelectionOnly;}
      // start with last search text
      if searchStr <> '' then
        SearchText := searchStr
      else
        SearchText := gsSearchText;
      if gbSearchTextAtCaret then begin
        // if something is selected search for that text
        if SynEdit1.SelAvail and (SynEdit1.BlockBegin.Line = SynEdit1.BlockEnd.Line)
        then
          SearchText := SynEdit1.SelText
        else
          SearchText := SynEdit1.GetWordAtRowCol(SynEdit1.CaretXY);
      end;
      SearchTextHistory := gsSearchTextHistory;
      {if AReplace then with dlg as TTextReplaceDialog do begin
        ReplaceText := gsReplaceText;
        ReplaceTextHistory := gsReplaceTextHistory;
      end;}
      SearchWholeWords := gbSearchWholeWords;
      gbSearchBackwards := SearchBackwards;
      gbSearchCaseSensitive := SearchCaseSensitive;
      gbSearchFromCaret := SearchFromCursor;
      gbSearchSelectionOnly := SearchInSelectionOnly;
      gbSearchWholeWords := SearchWholeWords;
      gbSearchRegex := SearchRegularExpression;

      gsSearchTextHistory := SearchTextHistory;
      if ShowDialog = true then Begin
          if ShowModal = mrOK then begin
            gsSearchText := dlg.SearchText;
            {if AReplace then with dlg as TTextReplaceDialog do begin
              gsReplaceText := ReplaceText;
              gsReplaceTextHistory := ReplaceTextHistory;
            end;}

            {if gsSearchText <> '' then begin
              DoSearchReplaceText(AReplace, gbSearchBackwards);
              fSearchFromCaret := TRUE;
            end;}
          end;
        End else Begin
          {if gsSearchText <> '' then begin
            DoSearchReplaceText(AReplace, gbSearchBackwards);
            fSearchFromCaret := TRUE;
          end;}
        End;
      fSearchFromCaret := fSearchFromCaret;
      lastSearch := gsSearchText;
      SynEdit1.SearchEngine.FindAll(dlg.cbSearchText.Text);
    finally
      dlg.Free;
    End;
  //end;
end;

procedure TfrmEditorSyn.EditEntity1Click(Sender: TObject);
var
  pData : popenBorSystem;
begin
  pData := vstEditor.GetNodeData(vstEditor.FocusedNode);
  if FileExists( ses.dataDirecotry+ '\' +pData.dscrp ) then Begin
    frmCharacterEditor.loadCharacterEntityFile( ses.dataDirecotry+ '\' + pData.dscrp  );
    frmCharacterEditor.Show;
  end;
end;

procedure TfrmEditorSyn.sbGifListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AttachMode: TVTNodeAttachMode;
  pData : popenBorSystem;
begin

  AttachMode := amInsertBefore;
  pData := vstEditor.GetNodeData(vstEditor.FocusedNode);
  //pData := ( (Sender as TVirtualStringTree).GetNodeData((Sender as TVirtualStringTree).FocusedNode);

  showmessage(pData.title);
end;





function TfrmEditorSyn.logifymethod( pData : popenBorSystem): string;
var
  sCode, s, s1 : string;
  i : integer;
  found, returned : boolean;
begin
  sCode := pData.ScrCode;
  returned := false;
  if (sCode <> '') then begin
    s1 := '{ log("\n ' + pData.title + ' 0");';
    MatStringReplace(sCode,'{',s1,true);
    i := Length(sCode);
    s := sCode[Length(sCode)];
    While (s <> '') and
          (found = false) and
          (i > 0)  do Begin
      if (s = '}') then Begin
        found := true;
      end else
        i := i-1;
      try
        s := sCode[Length(sCode)-i];
      except
        s := '';
      end;
    End;
    s := ' log(".' + pData.title + ' 1 ");';
    if (pos('return',sCode) > 0) then Begin
      MatStringReplace(sCode, 'return',s+'retur#n');
      MatStringReplace(sCode, 'retur#n','return');
      returned := true;
    end else
    if (i > 1) and
       (returned = false) then Begin
      insert(s, sCode,i-1);
    end;
  end;
  result := sCode;
end;
end.
