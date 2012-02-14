unit formCharacterEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExExtCtrls, JvNetscapeSplitter, ComCtrls, ToolWin,
  clsopenBorSystemVst, clsanimeEntityListVst, marioImg, mario,
  clsEntityDetails, unCommon, frameEditor,
  xmlopenBorSystemClass, clsLevelDesign,
  jvStrings, frameGifList,
  formSystemEditor, GIFImage, clsirfanView,
  SynEditPythonBehaviour, SynURIOpener, SynEditRegexSearch,
  SynEditMiscClasses, SynEditSearch, SynAutoCorrect, SynEditPrint,
  SynEditPlugins, SynMacroRecorder, SynCompletionProposal,
  SynHighlighterMulti, SynEditCodeFolding, SynUniHighlighter,
  SynEditHighlighter, FTGifAnimate,
  JvExComCtrls, JvToolBar, JvExControls, JvComponent, JvAnimatedImage,
  JvGIFCtrl, VirtualTrees, StdCtrls, Mask, JvExMask, JvSpin, JvgGroupBox,
  JvgScrollBox, Menus, JvArrowButton, pngextra, JvExStdCtrls, JvHtControls,
  JvRichEdit, JvPanel, JvComCtrls, SynHighlighterTeX, SynHighlighterST,
  SynHighlighterCpp, SynEdit,  JvComponentBase, JvBaseDlg,
  JvBrowseFolder, JvGroupBox;

type
  TfrmCharacterEditor = class(TForm)
    JvToolBar1: TJvToolBar;
    pnlAnimGrxList: TPanel;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    pnlTopMain: TPanel;
    pnlAnimList: TPanel;
    JvNetscapeSplitter2: TJvNetscapeSplitter;
    vstAnimList: TVirtualStringTree;
    ToolButton1: TToolButton;
    cbGifLocation: TComboBox;
    ToolButton2: TToolButton;
    seGifSize: TJvSpinEdit;
    ToolButton3: TToolButton;
    sbGifList: TJvgScrollBox;
    popVstImport: TPopupMenu;
    EditText1: TMenuItem;
    popOffSet: TPopupMenu;
    SettoPrevious1: TMenuItem;
    Add1: TMenuItem;
    SettoNull1: TMenuItem;
    SettoNext1: TMenuItem;
    Remove1: TMenuItem;
    N1: TMenuItem;
    popMoveAxis: TPopupMenu;
    Add2: TMenuItem;
    Remove2: TMenuItem;
    N2: TMenuItem;
    Settonull2: TMenuItem;
    SetfromPrevious1: TMenuItem;
    SetfromNext1: TMenuItem;
    popBeatBox: TPopupMenu;
    Add3: TMenuItem;
    Remove3: TMenuItem;
    N3: TMenuItem;
    SettoNull3: TMenuItem;
    SetfromPrevious2: TMenuItem;
    SetfromNext2: TMenuItem;
    popAttack: TPopupMenu;
    Add4: TMenuItem;
    Remove4: TMenuItem;
    N4: TMenuItem;
    SettoNull4: TMenuItem;
    SetfromPrevious3: TMenuItem;
    SettoNext2: TMenuItem;
    cbListbBox: TCheckBox;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    seCurrentFrame: TJvSpinEdit;
    JvPageControl1: TJvPageControl;
    tabGrx: TTabSheet;
    pnlGrx: TPanel;
    sbGif: TScrollBox;
    pnlFrameOptions: TPanel;
    ScrollBox1: TScrollBox;
    gbBoxes: TJvgGroupBox;
    JvgGroupBox1: TJvgGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    JvArrowButton1: TJvArrowButton;
    seOffSetX: TJvSpinEdit;
    seOffSetY: TJvSpinEdit;
    JvgGroupBox2: TJvgGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    JvArrowButton2: TJvArrowButton;
    seMoveX: TJvSpinEdit;
    seMoveA: TJvSpinEdit;
    seMoveZ: TJvSpinEdit;
    JvgGroupBox3: TJvgGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    JvArrowButton3: TJvArrowButton;
    seBBxX: TJvSpinEdit;
    seBBxY: TJvSpinEdit;
    seBBxW: TJvSpinEdit;
    seBBxH: TJvSpinEdit;
    bgAttack: TJvgGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    JvArrowButton4: TJvArrowButton;
    seAttckBoxX: TJvSpinEdit;
    seAttckBoxW: TJvSpinEdit;
    seAttckBoxH: TJvSpinEdit;
    seAttckBoxY: TJvSpinEdit;
    seatDamage: TJvSpinEdit;
    seatPower: TJvSpinEdit;
    cbatBlockable: TCheckBox;
    cbatFlash: TCheckBox;
    seatDepth: TJvSpinEdit;
    seatPause: TJvSpinEdit;
    cbAttackName1: TJvHTComboBox;
    cbAttackName: TComboBox;
    JvNetscapeSplitter3: TJvNetscapeSplitter;
    taEditor: TTabSheet;
    N5: TMenuItem;
    Add5: TMenuItem;
    False1: TMenuItem;
    Dublicate1: TMenuItem;
    cbShowHints: TCheckBox;
    PopupMenu1: TPopupMenu;
    AddFrame1: TMenuItem;
    pnlEditor: TPanel;
    gif: TImage;
    OpenDialog1: TOpenDialog;
    N6: TMenuItem;
    Import1: TMenuItem;
    AnimatedGif1: TMenuItem;
    Selection1: TMenuItem;
    Directory1: TMenuItem;
    JvBrowseForFolderDialog1: TJvBrowseForFolderDialog;
    Delete1: TMenuItem;
    DeleteFiles1: TMenuItem;
    cbFocus: TCheckBox;
    cbOffSet: TComboBox;
    gbRange: TJvGroupBox;
    gbMisc: TJvgGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    seDelay: TJvSpinEdit;
    seLoopp: TJvSpinEdit;
    memFrameInfo: TMemo;
    btnRangeX: TJvArrowButton;
    seRangeMinX: TJvSpinEdit;
    seRangeMaxX: TJvSpinEdit;
    Label20: TLabel;
    Label21: TLabel;
    popRangeX: TPopupMenu;
    Add6: TMenuItem;
    Remove5: TMenuItem;
    StatusBar1: TStatusBar;
    Label22: TLabel;
    Label23: TLabel;
    seRangeMinA: TJvSpinEdit;
    seRangeMaxA: TJvSpinEdit;
    btnRangeA: TJvArrowButton;
    popRangeA: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    LinkFiles1: TMenuItem;
    N7: TMenuItem;
    btnExecuteBor: TJvArrowButton;
    ToolButton7: TToolButton;
    popAddSetBox: TPopupMenu;
    popAddSetBox1: TMenuItem;
    AttackBox1: TMenuItem;
    Export1: TMenuItem;
    AsEntity1: TMenuItem;
    N8: TMenuItem;
    GroupBox1: TGroupBox;
    cmbOverlay: TComboBox;
    cbOverlay: TCheckBox;
    Label25: TLabel;
    seOverlayX: TJvSpinEdit;
    seOverlayY: TJvSpinEdit;
    Label26: TLabel;
    cbLoop: TCheckBox;
    cboverlayAnim: TComboBox;
    Label24: TLabel;
    jvOverlayFrameNumber: TJvSpinEdit;
    Label27: TLabel;
    cbOverlayVFlip: TCheckBox;
    cbOverlayHFlip: TCheckBox;
    Label28: TLabel;
    edtOverlayResult: TEdit;
    jeOverlayLeft: TJvSpinEdit;
    Label29: TLabel;
    OffSet1: TMenuItem;
    SetViaMouse1: TMenuItem;
    SetViaMouse2: TMenuItem;
    SetViaMouse3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure vstAnimListFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure FormResize(Sender: TObject);
    procedure cbGifLocationCloseUp(Sender: TObject);
    procedure seGifSizeChange(Sender: TObject);

    procedure seOffSetXChange(Sender: TObject);
    procedure memFrameInfoExit(Sender: TObject);
    procedure seMoveXChange(Sender: TObject);
    procedure seBBxXChange(Sender: TObject);
    procedure vstAnimListGetHint(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex;
      var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure seAttckBoxXChange(Sender: TObject);
    procedure cbAttackName1CloseUp(Sender: TObject);
    procedure cbatBlockableClick(Sender: TObject);
    procedure seLooppChange(Sender: TObject);
    procedure memFrameInfoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memFrameInfoEnter(Sender: TObject);

    procedure gifClick(Sender: TObject);
    procedure EditText1Click(Sender: TObject);
    procedure vstAnimListEnter(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure SettoNull1Click(Sender: TObject);
    procedure Add2Click(Sender: TObject);
    procedure Remove2Click(Sender: TObject);
    procedure Settonull2Click(Sender: TObject);
    procedure Add3Click(Sender: TObject);
    procedure Remove3Click(Sender: TObject);
    procedure SettoNull3Click(Sender: TObject);
    procedure Add4Click(Sender: TObject);
    procedure Remove4Click(Sender: TObject);
    procedure SettoNull4Click(Sender: TObject);
    procedure vstAnimListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstAnimListDblClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure seCurrentFrameChange(Sender: TObject);
    procedure SettoPrevious1Click(Sender: TObject);
    procedure SettoNext1Click(Sender: TObject);
    procedure SetfromPrevious1Click(Sender: TObject);
    procedure SetfromPrevious2Click(Sender: TObject);
    procedure SetfromNext1Click(Sender: TObject);
    procedure SetfromNext2Click(Sender: TObject);
    procedure SetfromPrevious3Click(Sender: TObject);
    procedure SettoNext2Click(Sender: TObject);
    procedure JvPageControl1Change(Sender: TObject);
    procedure vstAnimListNewText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
    procedure Add5Click(Sender: TObject);
    procedure vstAnimListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Dublicate1Click(Sender: TObject);
    procedure AddFrame1Click(Sender: TObject);
    procedure JvPageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure AnimatedGif1Click(Sender: TObject);
    procedure Selection1Click(Sender: TObject);
    procedure Directory1Click(Sender: TObject);
    procedure DeleteFiles1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure cbFocusClick(Sender: TObject);
    procedure PNGButton1MouseMove(Sender: TObject; Shift: TShiftState;  X, Y: Integer);
    procedure PNGButton1MouseExit(Sender: TObject);
    procedure PNGButton1Click(Sender: TObject);
    procedure seRangeMinXChange(Sender: TObject);
    procedure Add6Click(Sender: TObject);
    procedure Remove5Click(Sender: TObject);
    procedure seRangeMinAChange(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure gifMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbAttackNameChange(Sender: TObject);
    procedure cbOffSetCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbListbBoxClick(Sender: TObject);
    procedure seOffSetXKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure seMoveXKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure seBBxXKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbAttackNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JvPanel1Paint(Sender: TObject);
    procedure sbGifEnter(Sender: TObject);
    procedure LinkFiles1Click(Sender: TObject);
    procedure popAddSetBox1Click(Sender: TObject);
    procedure gifMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gifMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnExecuteBorClick(Sender: TObject);
    procedure sbGifMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AttackBox1Click(Sender: TObject);
    procedure AsEntity1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure cbOverlayClick(Sender: TObject);
    procedure cmbOverlayChange(Sender: TObject);
    procedure cboverlayAnimSelect(Sender: TObject);
    procedure cbOverlayVFlipClick(Sender: TObject);
    procedure edtOverlayResultEnter(Sender: TObject);
    procedure jvOverlayFrameNumberChange(Sender: TObject);
    procedure OffSet1Click(Sender: TObject);
  private
    { Private declarations }
    //aSyn : TSynUniSyn;
    aWall : TLvlWall;
    EntityDetails : TEntityDetails;
    treeVst : TclsanimeEntityListVst;
    //treeEditorVst : TclsopenBorSystemVst;
    editorMode : integer;
    workingCharacterFile : String;
    workingGifx, workingGify : integer;
    workingFolder : String;

    workingFrame : TEntityDetailFrames;
    workingFrameID: integer;
    pnlWall : TJvPanel;
    offSetGif, bBoxGif, attBoxGif : TJvGIFAnimator;
    //pEntityHeader, pEntityAnimTypes, pEntityAnimData : PVirtualNode;
    characterDetailsNode : PVirtualNode;
    pngbBox, pngAttBox, pngOffset, pngRange :TPNGButton;
    //pngOverlay :TPNGButton;
    pngOverlay :TImage;

    bboxpnl : TJvPanel;
    beginDraging : integer;
    beginDragingx, beginDragingy : integer;
    endDragingx, endDragingy : integer;

    procedure alldrag(Draggin:boolean);
    procedure drawPlatform(listData:TStringList);
    function coloriseGetText:String;
    procedure coloriseAttackBox2Default;
    procedure coloriseAttackBox(listData:TStringList);
    procedure coloriseAttackBoxItem(searchText:string);
    procedure showMessageStatus(zmessage:String);
    procedure updateVisuals;
    //Synedit Methods
      //remove
    //procedure loadHighlighter(aFilename:String; ExcludeHgl:Boolean=false);
    //Gif Methods
    procedure gifPosition(location:integer);
    procedure gifPopulateListFrame(listData:TStringList);
    procedure gifPopulateList(listData:TStringList);
    procedure gifClearList;
    //Frames at the bottom
    function frameGetCountFromTree:integer;
    function frameGetCount:Integer;
    function frameGetByFrameNumber(frameNumber:Integer):TfrmGifList;
    procedure frameUpdate(aFrame:TfrmGifList); Overload;
    procedure frameUpdate(frameNumber:Integer); Overload;
    procedure frameShow(totalToShow:integer); Overload;
    procedure frameShow(frameNumber:Integer;frameDetails : TEntityDetailFrames); Overload;
    procedure frameHideAll;
    procedure frameLoadGifs(listData:TStringList);
    procedure frameCreates(totalToExists:Integer);

    //updateMethods
    procedure addFrameHeaderDetails(node2Update:PVirtualNode;line2Add:String);
    function updateAnimNode(node2Update:PVirtualNode;EntityHeader:TStringList;reDraw:boolean=true):panimeEntityList; overload;
    function updateAnimNode(node2Update:PVirtualNode;EntityHeader:TStrings;reDraw:boolean=true):panimeEntityList; overload;
    function isNodeDetails(node:PVirtualNode):boolean;

    //Frame Methods
    function getFrameByFileName(var id:integer;fileName:String):TEntityDetailFrames;
    function getOffSetImage(atype:integer):string;

    procedure setFrameDetails2Default;
    //Import
    procedure importFileList(listData:TStringList;copy:boolean=true);
  public
    { Public declarations }
    isLoading : Boolean;
    modified : Boolean;
    frameEditor : TfrmEditorSyn;
    procedure selectFrame(framename:integer);
    procedure showOverlay(entityName:string; x:integer; y:integer; reloadAnim:boolean=false; reshape:boolean=false);
    //Editor Methods
    procedure editorLoadMedia(lineData:String);
      //remove ????
    procedure setEditorMode(iMode:integer);
    //Previous Next bBox's
    procedure directionOffSet(var x, y:Integer; isForward:Boolean;fromFrameNumber:Integer);
    procedure directionMoveSet(var x, a, z:Integer; isForward:Boolean;fromFrameNumber:Integer);
    procedure directionbBoxSet(var x, y, w, h:Integer; isForward:Boolean;fromFrameNumber:Integer);
    function directionatBoxSet(var x, y, w, h:Integer; isForward:Boolean;fromFrameNumber:Integer;atName:String):TfrmGifList;
    //entityDetail
    function updateEntityDetail(treeNode:PVirtualNode):TEntityDetail;
    procedure updateEntityDetailFrame(aFrame:TEntityDetailFrames);
    //Frames
    procedure FrameSelectNext;
    procedure FrameSelectprevious;
    procedure FrameSelectByNumber(fNumber:integer);
    //Anim Types
    function animSelect(Node : PVirtualNode;isNext:Boolean):PVirtualNode;
    //Load
    procedure loadCharacterEntityFile(fileName:String);
    procedure gifLoad(fileNameOnly:String; theGif:TImage;frameDetails : TEntityDetailFrames=nil; loadPrevious:Boolean=False); Overload;
    procedure findframeineditor(framenumber:integer);
    //Populate Methods
    procedure populateCharacterEntity(EntityDetails : TEntityDetails);
    procedure populateFrame(aFrame:TEntityDetailFrames;frameID:Integer);
    //procedure populateEditorTree;
    //Box's
    function drawoBox(x,y, zMultiPly:integer;theGif:TJvGIFAnimator; pngBox:TPNGButton;gifParent:TWinControl;pngFileName:String;useMultiply:Boolean=True):TPNGButton; Overload;
    function drawoBox(x,y, zMultiPly:integer;theGif:TImage; pngBox:TPNGButton;gifParent:TWinControl;pngFileName:String;useMultiply:Boolean=True):TPNGButton; Overload;
    function drawbBox(x,y, w,h, zMultiPly:integer;theGif:TJvGIFAnimator; pngBox:TPNGButton;gifParent:TWinControl;pngFileName:String;useMultiply:Boolean=True):TPNGButton; overload;
    function drawbBox(x,y, w,h, zMultiPly:integer;theGif:TImage; pngBox:TPNGButton;gifParent:TWinControl;pngFileName:String;boxType:Integer;useMultiply:Boolean=True):TPNGButton; overload;
    //procedure setOffset(x,y:integer;theGid:TJvGIFAnimator);
    procedure setbBox(x,y, w,h:integer;theGid:TJvGIFAnimator); Overload;
    function setbBox(x,y, w,h, zMultiPly:integer;theGif, zattBoxGif:TJvGIFAnimator;gifParent:TWinControl;useMultiply:Boolean=True):TJvGIFAnimator; Overload;
    function setAttBox(x,y, w,h, zMultiPly:integer;theGif, zattBoxGif:TJvGIFAnimator;gifParent:TWinControl;useMultiply:Boolean=True):TJvGIFAnimator;

    procedure formSave(reDraw:Boolean = true);
  end;

var
  frmCharacterEditor: TfrmCharacterEditor;
  inters:set of char=['0','1','2','3','4','5','6','7','8','9'];

implementation
Uses
  unMain, formEditor, formFormat,  clsModels;
{$R *.dfm}

{ TfrmCharacterEditor }

procedure TfrmCharacterEditor.loadCharacterEntityFile(fileName: String);
Var
  iAnser : Integer;
begin
  try
    if not FileExists(fileName) then
      exit;
    FreeAndNil(pnlWall);  
    isLoading := true;
    if frameEditor.modified = true then
      modified := true;
    if modified = true then
      iAnser := MessageDlg('Character file has been updated! Would you like to save?'+#10+#10+workingCharacterFile, mtWarning, [mbYes,mbNo,mbCancel], 0);
    //yes = 6
    //no =  7
    //cancel = 2
    if iAnser = 6 then Begin
      EntityDetails.savetofile(workingCharacterFile,EntityDetails);
      modified := false;
    end;
    if iAnser = 2 then
      exit;
    ses.characterDir := ExtractFileDir(fileName);

    cbAttackName.Text := 'attack';
    cbAttackName.SelText := 'attack';
    cbAttackName.ItemIndex := 0;
    cbAttackName.SelStart := 0;

    if EntityDetails = nil then
      EntityDetails := TEntityDetails.create
    else
      EntityDetails.list.Clear;

    Form1.JvSaveDialog1.InitialDir := ExtractFileDir(fileName);
    workingCharacterFile := fileName;
    gifClearList;
    setFrameDetails2Default;
    Caption := 'Character Editor: ' + ExtractFileName(fileName);
    EntityDetails := EntityDetails.loadEntitryDetails(filename);
    workingFolder := ExtractFileDir(fileName);
    populateCharacterEntity(EntityDetails);
    modified := false;
  finally
    isLoading := false;
  end;
end;

procedure TfrmCharacterEditor.populateCharacterEntity(
  EntityDetails: TEntityDetails);
Var
  aEntityDetail : TEntityDetail;
  rData : ranimeEntityList;
  i : integer;
begin
  vstAnimList.Clear;

  for i := 0 to EntityDetails.list.Count -1 do Begin
    aEntityDetail := (EntityDetails.list.Objects[i] as TEntityDetail);
    rData := treeVst.clearanimeEntityListrData;
    if aEntityDetail <> nil then Begin
      rData.anme := aEntityDetail.animeName;
      rData.entityHeader := aEntityDetail.header;
      rData.entityDetail := aEntityDetail;
      rData.id := i;
      rData.zType := 1;
      treeVst.addanimeEntityListNode(rData,nil);
    end;
  end;
  rData := treeVst.clearanimeEntityListrData;
  rData.id := -1;
  rData.anme := 'Character Details';
  rData.entityHeader := EntityDetails.headers;
  rData.entityDetail := nil;
  rData.zType := 0;
  characterDetailsNode := treeVst.addanimeEntityListNode(rData,nil);
  vstAnimList.SortTree(0,sdAscending);
  vstAnimList.FocusedNode := characterDetailsNode;
  vstAnimList.Selected[characterDetailsNode] := True;
  vstAnimListFocusChanged(vstAnimList,characterDetailsNode,0);
  frameEditor.JvNetscapeSplitter2.Minimized := true;
end;

procedure TfrmCharacterEditor.FormCreate(Sender: TObject);
begin
  
  treeVst := TclsanimeEntityListVst.Create(vstAnimList);

  frameEditor := TfrmEditorSyn.Create(pnlEditor);
  frameEditor.Parent := pnlEditor;
  frameEditor.Align := alClient;
  frameEditor.formCreate;
  vstAnimList := treeVisuals(vstAnimList);

  //populateEditorTree;

  //loadHighlighter('Text Files');
end;

procedure TfrmCharacterEditor.vstAnimListFocusChanged(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex);
Var
  pData : panimeEntityList;
  aEntityDetail : TEntityDetail;
  FirstGif : String;
  aFrame : TEntityDetailFrames;
begin
  Try
    alldrag(false);
    if pngOverlay <> nil then
      if cbOverlay.Checked = false then
        pngOverlay.Visible := false;
    isLoading := true;
    if Node <> nil then Begin
      pData := Sender.GetNodeData(Node);
      aEntityDetail := pData.entityDetail;
      ses.workingEntityDetail := aEntityDetail;
      aFrame := nil;
      case pData.zType of
        0: Begin
          //Activate editor
            frameEditor.formStartup(frmFormat.format(EntityDetails.headers),0,EntityDetails,1);
            JvPageControl1.ActivePageIndex := 1;
            setEditorMode(0);
            frameHideAll;
        end;
        1: Begin
          if pData.entityDetail <> nil then Begin
            //Load syntaxeditor for a frame
            if JvPageControl1.ActivePageIndex = 1 then Begin
              frameEditor.formStartup(frmFormat.format(pData.entityHeader),2,EntityDetails,1);
              try
                if aEntityDetail.frameList.count > 0 then
                  aFrame := (aEntityDetail.frameList.Objects[0] as TEntityDetailFrames);

                if aFrame <> nil then Begin
                  workingFrame := aFrame;
                  gifPopulateListFrame(aEntityDetail.frameList);
                  updateVisuals;
                end;
              except
              end;
            end Else Begin
            //Load frame editor for a frame
              if aEntityDetail.frameList.Count > 0 then Begin
                Try
                  aFrame := (aEntityDetail.frameList.Objects[0] as TEntityDetailFrames);
                  //aFrame.frameCount := workingFrameCount;
                  populateFrame(aFrame,0);
                  gifLoad(aEntityDetail.frameList.Strings[0],gif);
                  //gifLoad(workingFrame.frameFile,gif,workingFrame,true);
                  gifPopulateListFrame(aEntityDetail.frameList);
                  updateVisuals;
                  //gifPopulateList(aEntityDetail.frameList);
                Except
                end;
              End;
            end;
          end;
          //editorMode := -1;
        end;

      end;
        //ListBox1.Items := pData.stringList;

    end;
  finally
    isLoading := false;
  end;
end;


procedure TfrmCharacterEditor.gifPosition(location: integer);
Var
  gifMultiply : Integer;
  useMultiply : Boolean;
  offSetX, offSetY, rngMinA, rngMaxA : integer;
  x, y, w, h : integer;
begin
  if JvPageControl1.ActivePageIndex <> 0 then
    exit;
  if location < 0 then
    location := 0;
  gifMultiply := seGifSize.AsInteger;
  if seGifSize.AsInteger = 0 then
    gifMultiply := 1;

  if gifMultiply > 0 then Begin
    gif.Width := gif.Picture.Width * gifMultiply;
    gif.Height := gif.Picture.Height * gifMultiply;
    {gif.Width := gif.Picture.Width * gifMultiply;
    gif.Height := gif.Picture.Height * gifMultiply;}
    useMultiply := True;
  end else Begin
    gifMultiply := gifMultiply - gifMultiply - gifMultiply;
    gif.Width := gif.Picture.Width div gifMultiply;
    gif.Height := gif.Picture.Height div gifMultiply;
    useMultiply := false;
  end;
  //Get RangeA position
  rngMinA := seRangeMinA.AsInteger;
  rngMaxA := seRangeMaxA.AsInteger;
  if rngMinA < 0 then
    rngMinA := rngMinA - rngMinA - rngMinA;
  if rngMaxA < 0 then
    rngMaxA := rngMaxA - rngMaxA - rngMaxA;
  if rngMaxA = 0 then
    rngMaxA := -30;
  //Get offset position
  offSetX := seOffSetX.AsInteger;
  offSetY := seOffSetY.AsInteger;
  if (offSetX = 0) and
     (offSetY = 0) then
       directionOffSet(offSetX,offSetY,false,workingFrame.frameNumber);
  if (offSetX = 0) and
     (offSetY = 0) then Begin
     offSetX := sbGif.Width div 2;
     offSetY := sbGif.Height div 2;
  end;
  //Position gif
  Case location of
    0 : //center
      Begin
        gif.Left := (sbGif.Width div 2 ) - (gif.Width div 2);
        gif.Top := (sbGif.Height div 2 ) - (gif.Height div 2);
        pngOffset := drawoBox(seOffSetX.AsInteger,seOffSetY.AsInteger,
                      seGifSize.AsInteger,gif,pngOffset,sbGif,getOffSetImage(cbOffSet.ItemIndex));//config.ofSetImage);
      end;
    1 : Begin
//pngOffset
          if pngOffset = nil then
            pngOffset := drawoBox(OffSetX,OffSetY,
                      seGifSize.AsInteger,gif,pngOffset,sbGif,getOffSetImage(cbOffSet.ItemIndex));//config.ofSetImage);
          pngOffset.Left := ((sbGif.Width div 2) - (pngOffset.ImageNormal.Width div 2));
          pngOffset.Top := ((sbGif.Height div 2) + (((sbGif.Height div 2)div 2))) - (pngOffset.ImageNormal.Width div 2);
          //((y * multiPly) - (pngBox.Height div 2))
          gif.Left := pngOffset.Left - ((offSetX * gifMultiply) - (pngOffset.ImageNormal.Width div 2));
          gif.Top := pngOffset.Top - ((offSetY * gifMultiply) - (pngOffset.ImageNormal.Height div 2));
        end;
  end;

  if seBBxX.Font.Color = config.noValue then Begin
    directionbBoxSet(x,y,w,h,false,workingFrame.frameNumber);
    pngbBox := drawbBox(x,y,w,h,
                      seGifSize.AsInteger,gif,pngbBox,sbGif, config.bBoxImagePrevious,1);
  end Else Begin
    pngbBox := drawbBox(seBBxX.AsInteger,seBBxY.AsInteger,
                      seBBxW.AsInteger,seBBxH.AsInteger,
                      seGifSize.AsInteger,gif,pngbBox,sbGif,'\bBox1.png',1);
  end;

  pngAttBox := drawbBox(seAttckBoxX.AsInteger,seAttckBoxY.AsInteger,
                      seAttckBoxW.AsInteger,seAttckBoxH.AsInteger,
                      seGifSize.AsInteger,gif,pngAttBox,sbGif,'\attBox1.png',2);

  {pngbBox := drawbBox(seBBxX.AsInteger,seBBxY.AsInteger,
                      seBBxW.AsInteger,seBBxH.AsInteger,
                      gifMultiply,gif,pngbBox,sbGif,'\bBox1.png',1,useMultiply);
  pngAttBox := drawbBox(seAttckBoxX.AsInteger,seAttckBoxY.AsInteger,
                      seAttckBoxW.AsInteger,seAttckBoxH.AsInteger,
                      gifMultiply,gif,pngAttBox,sbGif,'\attBox1.png',2,useMultiply);}
  {
  pngRange := drawbBox(offSetX+seRangeMinX.AsInteger,offSetY+rngMinA,//(sbGif.Height div 2),
                      seRangeMaxX.AsInteger,rngMaxA,
                      gifMultiply,gif,pngRange,sbGif,'\attRangeX.png',-1,useMultiply);}

  pngRange := drawbBox(offSetX+seRangeMinX.AsInteger, offSetY-seRangeMaxA.AsInteger ,// (seRangeMaxA.AsInteger-seRangeMaxA.AsInteger-seRangeMaxA.AsInteger) ,
                      seRangeMaxX.AsInteger, rngMinA+rngMaxA ,// (seRangeMinA.AsInteger+seRangeMaxA.AsInteger),// (( seRangeMinA.AsInteger+offSetY)+(seRangeMaxA.AsInteger+offSetY)),
                      gifMultiply,gif,pngRange,sbGif,'\attRangeX.png',-1,useMultiply); 
  //Still Fucked!
  {
  y := offSetY+seRangeMinA.AsInteger ;//- ( pngOffset.ImageNormal.Height div 2 );
  h := seRangeMinA.AsInteger+seRangeMaxA.AsInteger; //offSetY+seRangeMaxA.AsInteger ;//+(seRangeMinA.AsInteger+seRangeMaxA.AsInteger);
  if ( h = 0 ) then h := 20;
  pngRange := drawbBox(offSetX+seRangeMinX.AsInteger, y ,// (seRangeMaxA.AsInteger-seRangeMaxA.AsInteger-seRangeMaxA.AsInteger) ,
                      seRangeMaxX.AsInteger,  h,// (seRangeMinA.AsInteger+seRangeMaxA.AsInteger),// (( seRangeMinA.AsInteger+offSetY)+(seRangeMaxA.AsInteger+offSetY)),
                      gifMultiply,gif,pngRange,sbGif,'\attRangeX.png',-1,useMultiply);
  }
  if workingFrame <> nil then
    drawPlatform(workingFrame.header);
end;

procedure TfrmCharacterEditor.FormResize(Sender: TObject);
begin
  updateVisuals;
end;

procedure TfrmCharacterEditor.updateVisuals;
begin
  gifPosition(cbGifLocation.ItemIndex);
  if workingFrame <> nil then
    drawPlatform(workingFrame.header);
  //setOffset(seOffSetX.AsInteger,seOffSetY.AsInteger,gif);
  //setbBox(seBBxX.AsInteger,seBBxY.AsInteger,seBBxW.AsInteger,seBBxH.AsInteger,gif);
  //TODO: StatusBar1.Panels[0].Text := 'Frame: ' + IntToStr(workingFrameID +1) + ' of ' + IntToStr(workingFrameCount);
end;

procedure TfrmCharacterEditor.cbGifLocationCloseUp(Sender: TObject);
begin
  gifPosition(cbGifLocation.ItemIndex);
  config.gifLocation := cbGifLocation.ItemIndex;
  
end;

procedure TfrmCharacterEditor.seGifSizeChange(Sender: TObject);
begin
  updateVisuals;
end;

procedure TfrmCharacterEditor.populateFrame(aFrame: TEntityDetailFrames; frameID: Integer);
Var
  i, x, y, w, h, a, z : Integer;
  s, s2, s3 : string;

begin
  setFrameDetails2Default;
  workingFrame := aFrame;
  workingFrameID := frameID;
  seCurrentFrame.MinValue := 0;
  seCurrentFrame.AsInteger := workingFrame.frameNumber;
  if aFrame.header.Count > 0 then
    memFrameInfo.Lines := aFrame.header;
  for i := 0 to aFrame.header.Count -1 do Begin
    Try
      s := aFrame.header.Strings[i];

      if PosStr('offset',s) > 0 then Begin
        seOffSetX.AsInteger := aFrame.offSetX;
        seOffSetX.Font.Color := config.hasValue;
        seOffSetY.AsInteger := aFrame.offSetY;
        seOffSetY.Font.Color := config.hasValue;

        //setOffset(aFrame.offSetX,aFrame.offSetY,gif);
      end;
      if PosStr('delay',s) > 0 then Begin
        seDelay.AsInteger := aFrame.Delay;
        seDelay.Font.Color := config.hasValue;
      end;
      if PosStr('loop',s) > 0 then Begin
        //seLoop.AsInteger := aFrame.Loop;
        cbLoop.Checked := Int2Bool(aFrame.Loop);
        cbLoop.Font.Color := config.hasValue;
        //seLoop.Font.Color := config.hasValue;
      end;
      //if PosStr('move',s) > 0 then Begin
      if isMove(s) = true then Begin
        seMoveX.AsInteger := aFrame.moveX;
        seMoveX.Font.Color := config.hasValue;
        seMoveA.AsInteger := aFrame.moveA;
        seMoveA.Font.Color := config.hasValue;
        seMoveZ.AsInteger := aFrame.moveZ;
        seMoveZ.Font.Color := config.hasValue;
      end;
      //if PosStr('bbox',s) > 0 then Begin
      if isbBox(s) = true then Begin
        seBBxX.AsInteger := aFrame.bBoxX;
        seBBxX.Font.Color := config.hasValue;
        seBBxY.AsInteger := aFrame.bBoxY;
        seBBxY.Font.Color := config.hasValue;
        seBBxW.AsInteger := aFrame.bBoxW;
        seBBxW.Font.Color := config.hasValue;
        seBBxH.AsInteger := aFrame.bBoxH;
        seBBxH.Font.Color := config.hasValue;
        //setbBox(aFrame.bBoxX,aFrame.bBoxY,aFrame.bBoxW,aFrame.bBoxH,gif);
      end;
      if isRangeX(s) = true then Begin
        seRangeMinX.AsInteger := aFrame.rangeMinX;
        seRangeMaxX.AsInteger := aFrame.rangeMaxX;
        seRangeMinX.Font.Color := config.hasValue;
        seRangeMaxX.Font.Color := config.hasValue;
      end;
      if isRangeA(s) = true then Begin
        seRangeMinA.AsInteger := aFrame.rangeMinA;
        seRangeMaxA.AsInteger := aFrame.rangeMaxA;
        seRangeMinA.Font.Color := config.hasValue;
        seRangeMaxA.Font.Color := config.hasValue;
      end;
      //if PosStr('attack',s) > 0 then Begin
      if isAttackBlock(s) = true then Begin
        aFrame.hasAttackBox := aFrame.stripAttackBox(aFrame.atBoxX,aFrame.atBoxY,aFrame.atBoxW,aFrame.atBoxH,aFrame.atDmg,aFrame.atPwr,aFrame.atFlsh,aFrame.atBlck,aFrame.atPause,aFrame.atDepth,aFrame.atBoxName,s);

        seAttckBoxX.AsInteger := aFrame.atBoxX;
        seAttckBoxX.Font.Color := config.hasValue;
        seAttckBoxY.AsInteger := aFrame.atBoxY;
        seAttckBoxY.Font.Color := config.hasValue;
        seAttckBoxW.AsInteger := aFrame.atBoxW;
        seAttckBoxW.Font.Color := config.hasValue;
        seAttckBoxH.AsInteger := aFrame.atBoxH;
        seAttckBoxH.Font.Color := config.hasValue;

        seatDamage.AsInteger := aFrame.atDmg;
        seatDamage.Font.Color := config.hasValue;
        seatPower.AsInteger := aFrame.atPwr;
        seatPower.Font.Color := config.hasValue;
        cbatBlockable.Checked := Int2Bool(aFrame.atBlck);
        cbatBlockable.Font.Color := config.hasValue;
        cbatFlash.Checked := Int2Bool(aFrame.atFlsh);
        cbatFlash.Font.Color := config.hasValue;
        seatPause.AsInteger := aFrame.atPause;
        seatPause.Font.Color := config.hasValue;
        seatDepth.AsInteger := aFrame.atDepth;
        seatDepth.Font.Color := config.hasValue;

        s2 := s;
        Form1.StringDeleteFirstChar(s2,' ');
        Form1.StringDeleteFirstChar(s2,#09);
        Form1.StringDelete2End(s2,' ');
        Form1.StringDelete2End(s2,#09);
        cbAttackName.Text := s2;
        cbAttackName.Font.Color := config.hasValue;
      end;
      //Platform

      {if PosStr('platform',s) > 0 then Begin
        s := strip2Bar('platform',s);
        aWall := TLvlWall.create(s);
        FreeAndNil(pnlWall);
        pnlWall := TJvPanel.Create(sbgif);
        pnlWall.Parent := sbgif;
        pnlWall.Left := gif.Left;
        pnlWall.Top := gif.Top;
        pnlWall.FlatBorder := true;
        pnlWall.Width := gif.Width;
        pnlWall.Height := gif.Height;
        pnlWall.Transparent := true;
        pnlWall.OnPaint := JvPanel1Paint;
        pnlWall.Repaint;
        pnlWall := paintWall(pnlWall,
                  aWall.xPos * seGifSize.AsInteger,
                  aWall.yPos * seGifSize.AsInteger,
                  aWall.upperLeft * seGifSize.AsInteger,
                  aWall.LowerLeft * seGifSize.AsInteger,
                  aWall.UpperRight * seGifSize.AsInteger,
                  aWall.LowerRight * seGifSize.AsInteger,
                  aWall.Depth * seGifSize.AsInteger,
                  aWall.height * seGifSize.AsInteger);
      end;}
    except
    end;
  end;
  //coloriseAttackBox(aFrame.header);
end;

procedure TfrmCharacterEditor.setFrameDetails2Default;
begin
  if JvPageControl1.ActivePageIndex = 0 then Begin
    seOffSetX.AsInteger := 0;
    seOffSetX.Font.Color := config.noValue;
    seOffSetY.AsInteger := 0;
    seOffSetY.Font.Color := config.noValue;

    seMoveX.AsInteger := 0;
    seMoveX.Font.Color := config.noValue;
    seMoveA.AsInteger := 0;
    seMoveA.Font.Color := config.noValue;
    seMoveZ.AsInteger := 0;
    seMoveZ.Font.Color := config.noValue;

    seBBxX.AsInteger := 0;
    seBBxX.Font.Color := config.noValue;
    seBBxY.AsInteger := 0;
    seBBxY.Font.Color := config.noValue;
    seBBxW.AsInteger := 0;
    seBBxW.Font.Color := config.noValue;
    seBBxH.AsInteger := 0;
    seBBxH.Font.Color := config.noValue;

    cbAttackName.Text := 'attack';
    cbAttackName.Font.Color := config.noValue;
    seAttckBoxX.AsInteger := 0;
    seAttckBoxX.Font.Color := config.noValue;
    seAttckBoxW.AsInteger := 0;
    seAttckBoxW.Font.Color := config.noValue;
    seAttckBoxH.AsInteger := 0;
    seAttckBoxH.Font.Color := config.noValue;
    seAttckBoxY.AsInteger := 0;
    seAttckBoxY.Font.Color := config.noValue;
    seatDamage.AsInteger := 0;
    seatDamage.Font.Color := config.noValue;
    seatPower.AsInteger := 0;
    seatPower.Font.Color := config.noValue;
    seatPause.AsInteger := 0;
    seatPause.Font.Color := config.noValue;
    seatDepth.AsInteger := 0;
    seatDepth.Font.Color := config.noValue;
    cbatBlockable.Checked := false;
    cbatBlockable.Font.Color := config.noValue;
    cbatFlash.Checked := True;
    cbatFlash.Font.Color := config.noValue;

    //seLoop.AsInteger := 0;
    cbLoop.Checked := false;
    cbLoop.Font.Color := config.noValue;
    //seLoop.Font.Color := config.noValue;
    seDelay.AsInteger := 0;
    seDelay.Font.Color := config.noValue;

    seRangeMinX.AsInteger := 0;
    seRangeMinX.Font.Color := config.noValue;
    seRangeMaxX.AsInteger := 0;
    seRangeMaxX.Font.Color := config.noValue;

    seRangeMinA.AsInteger := 0;
    seRangeMinA.Font.Color := config.noValue;
    seRangeMaxA.AsInteger := 0;
    seRangeMaxA.Font.Color := config.noValue;

    memFrameInfo.Clear;
  end;
end;

procedure TfrmCharacterEditor.gifPopulateList(listData: TStringList);
Var
  i : Integer;
  aGif : TJvGIFAnimator;
  s : string;
begin
  gifClearList;
  i := listData.Count -1;
  //for i := (listData.Count -1) to 0 do Begin
  while i > -1 do Begin
    s := listData.Strings[i];
    aGif := TJvGIFAnimator.Create(sbGifList);
    aGif.Parent := sbGifList;
    aGif.Align := alLeft;
    aGif.Hint := s;
    aGif.OnClick := gifClick;

    //gifLoad(s,aGif);
    i := i -1;
  end;
end;

procedure TfrmCharacterEditor.gifClick(Sender: TObject);
var
  s: string;
  i : integer;
  aEnt : TEntityDetailFrames;
begin
  Try
    isLoading := True;
    s := (sender as TJvGIFAnimator).hint;
    gifLoad(s,gif);
    aEnt := getFrameByFileName(i,s);
    workingFrame := aEnt;
    workingFrameID := i;
    populateFrame(aEnt,i);
    updateVisuals;
  finally
    isLoading := false;
  end;
end;

function TfrmCharacterEditor.getFrameByFileName(var id: integer;
  fileName: String): TEntityDetailFrames;
Var
  pData : panimeEntityList;
  aEntityDetail : TEntityDetail;
  aEntityDetailFrame : TEntityDetailFrames;
  i : integer;
  s :String;
begin
  if vstAnimList.FocusedNode <> nil then Begin
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
    aEntityDetail := pData.entityDetail;
    i := 0;
    while i < aEntityDetail.frameList.Count do Begin
      s := aEntityDetail.frameList.Strings[i];
      if s = fileName then Begin
        id := i;
        aEntityDetailFrame := (aEntityDetail.frameList.Objects[i] as TEntityDetailFrames);
        i := aEntityDetail.frameList.Count;
      end;
      inc(i);
    End;
  End;
  Result := aEntityDetailFrame;
end;

{procedure TfrmCharacterEditor.setOffset(x, y: integer;
  theGid: TJvGIFAnimator);
Var
  multiPly : Integer;
  isnegative : Boolean;
begin
  if offSetGif = nil then Begin
   offSetGif := TJvGIFAnimator.Create(sbGif);
   offSetGif.Parent := sbGif;
   offSetGif.Image.LoadFromFile(config.imageDir+'\offSet.gif');
  end;
  multiPly := seGifSize.AsInteger;

  if multiPly = 0 then
    multiPly := 1;

  if multiPly > 0 then Begin
    offSetGif.Top :=  theGid.Top + (y * multiPly - (offSetGif.Height div 2));
    offSetGif.Left := theGid.Left + (x * multiPly - (offSetGif.Width div 2));
  end else Begin
    multiPly := multiPly - multiPly - multiPly;
    offSetGif.Top :=  theGid.Top + (y div multiPly - (offSetGif.Height div 2));
    offSetGif.Left := theGid.Left + (x div multiPly - (offSetGif.Width div 2));

  end;
end;}

procedure TfrmCharacterEditor.seOffSetXChange(Sender: TObject);
Var
  pData : panimeEntityList;
  aFrame : TEntityDetailFrames;
begin
  if isLoading = false then Begin
    if (sender as TJvSpinEdit).Font.Color = config.noValue then
      showMessageStatus('Please add a offSet using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      //setOffset(seOffSetX.AsInteger,seOffSetY.AsInteger,gif);
      case cbGifLocation.ItemIndex of
        0:
      pngOffset := drawoBox(seOffSetX.AsInteger,seOffSetY.AsInteger,
                      seGifSize.AsInteger,gif,pngOffset,sbGif,getOffSetImage(cbOffSet.ItemIndex));//config.ofSetImage);
        1: Begin
             gifPosition(cbGifLocation.ItemIndex);
        end;
      end;                
      workingFrame.setOffSet(seOffSetX.AsInteger,seOffSetY.AsInteger,workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      updateEntityDetailFrame(workingFrame);
    end;
  end;
  //memFrameInfo.Lines := workingFrame.header;
end;

procedure TfrmCharacterEditor.memFrameInfoExit(Sender: TObject);
Var
  newFrame : TEntityDetailFrames;
begin
  if isLoading = false then Begin
    //newFrame := TEntityDetailFrames.create;
    workingFrame.header.Text := memFrameInfo.Lines.Text;
    workingFrame := workingFrame.updateAllValue(workingFrame.header,workingFrame);
    //newFrame := workingFrame.updateAllValue(workingFrame.header,workingFrame);
    Try
      isLoading := True;
      populateFrame(workingFrame,workingFrameID);
    Finally
      isLoading := false;
    end;
    modified := True;
  end;
end;

procedure TfrmCharacterEditor.seMoveXChange(Sender: TObject);
begin
  if isLoading = false then Begin
    if (sender as TJvSpinEdit).Font.Color = config.noValue then
      showMessageStatus('Please add a move set using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      workingFrame.setMove(seMoveX.AsInteger, seMoveA.AsInteger, seMoveZ.AsInteger,workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      updateEntityDetailFrame(workingFrame);
    end;
  end;
end;

procedure TfrmCharacterEditor.seBBxXChange(Sender: TObject);
begin
  if isLoading = false then Begin
    if (sender as TJvSpinEdit).Font.Color = config.noValue then
      showMessageStatus('Please add a bBox set using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      workingFrame.setbBox(seBBxX.AsInteger, seBBxY.AsInteger, seBBxW.AsInteger, seBBxH.AsInteger, workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      //setbBox(seBBxX.AsInteger,seBBxY.AsInteger,seBBxW.AsInteger,seBBxH.AsInteger,gif);
      pngbBox := drawbBox(seBBxX.AsInteger,seBBxY.AsInteger,
                      seBBxW.AsInteger,seBBxH.AsInteger,
                      seGifSize.AsInteger,gif,pngbBox,sbGif,'\bBox1.png',1);
      updateEntityDetailFrame(workingFrame);
    end;
  end;
end;

procedure TfrmCharacterEditor.vstAnimListGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: WideString);
Var
  pData : panimeEntityList;
begin
  if cbShowHints.Checked = false then
    exit;
  if node <> nil then Begin
    pData := Sender.GetNodeData(Node);
    HintText := pData.entityHeader.Text;
  end;
end;

procedure TfrmCharacterEditor.seAttckBoxXChange(Sender: TObject);
begin
  if isLoading = false then Begin
    if (sender as TJvSpinEdit).Font.Color = config.noValue then
      showMessageStatus('Please add a attack box set using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      workingFrame.setAttackBox(seAttckBoxX.AsInteger, seAttckBoxY.AsInteger, seAttckBoxw.AsInteger,seAttckBoxh.AsInteger,
      seatDamage.AsInteger,seatPower.AsInteger,Bool2Int(cbatFlash.Checked),Bool2Int(cbatBlockable.Checked),seatPause.AsInteger,
      seatDepth.AsInteger,cbAttackName.Text,workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      //attBoxGif := setAttBox(seAttckBoxX.AsInteger,seAttckBoxY.AsInteger,seAttckBoxW.AsInteger,seAttckBoxH.AsInteger, seGifSize.AsInteger,gif, attBoxGif,sbGif);
      pngAttBox := drawbBox(seAttckBoxX.AsInteger,seAttckBoxY.AsInteger,
                      seAttckBoxW.AsInteger,seAttckBoxH.AsInteger,
                      seGifSize.AsInteger,gif,pngAttBox,sbGif,'\attBox1.png',2);
      updateEntityDetailFrame(workingFrame);
    end;
  end;
end;

procedure TfrmCharacterEditor.cbAttackName1CloseUp(Sender: TObject);
begin
 if isLoading = false then Begin
    workingFrame.setAttackBox(seAttckBoxX.AsInteger, seAttckBoxY.AsInteger, seAttckBoxw.AsInteger,seAttckBoxh.AsInteger,
    seatDamage.AsInteger,seatPower.AsInteger,Bool2Int(cbatFlash.Checked),Bool2Int(cbatBlockable.Checked),seatPause.AsInteger,
    seatDepth.AsInteger,cbAttackName.Text,workingFrame.header);
    memFrameInfo.Lines := workingFrame.header;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.cbatBlockableClick(Sender: TObject);
begin
  if isLoading = false then Begin
    workingFrame.setAttackBox(seAttckBoxX.AsInteger, seAttckBoxY.AsInteger, seAttckBoxw.AsInteger,seAttckBoxh.AsInteger,
    seatDamage.AsInteger,seatPower.AsInteger,Bool2Int(cbatFlash.Checked),Bool2Int(cbatBlockable.Checked),seatPause.AsInteger,
    seatDepth.AsInteger,cbAttackName.Text,workingFrame.header);
    memFrameInfo.Lines := workingFrame.header;
    updateEntityDetailFrame(workingFrame);
  end else
    exit;
end;

procedure TfrmCharacterEditor.seLooppChange(Sender: TObject);
Var
  s : string;
begin
  if isLoading = false then Begin

    if (seDelay.Font.Color = config.noValue) and
       (seDelay.AsInteger <> 0) then Begin
      s := #09 + 'delay' + #09 + '0';
      workingFrame.header.Insert(0,s);
      workingFrame.Delay := 0;
      seDelay.Font.Color := config.hasValue;
    end;
    //if (seLoop.Font.Color = config.noValue) and
    //   (seLoop.AsInteger <> 0) then Begin
    if (cbLoop.Font.Color = config.noValue) and
       (cbLoop.Checked = true) then Begin
      cbLoop.Checked := false;
      cbLoop.Font.Color := config.noValue;

      s := #09 + 'loop' + #09 + '0';
      workingFrame.header.Insert(0,s);
      workingFrame.Loop := 0;
      cbLoop.Font.Color := config.hasValue;
      //seLoop.Font.Color := config.hasValue;
    end;

    //workingFrame.setMisc(seLoop.AsInteger, seDelay.AsInteger,workingFrame.header);
    workingFrame.setMisc( Bool2Int(cbLoop.checked), seDelay.AsInteger,workingFrame.header);
    memFrameInfo.Lines := workingFrame.header;
    updateEntityDetailFrame(workingFrame);
    modified := True;
  end;
end;

procedure TfrmCharacterEditor.memFrameInfoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    memFrameInfoExit(sender);
end;

procedure TfrmCharacterEditor.memFrameInfoEnter(Sender: TObject);
begin
  if (sender is TJvSpinEdit) then
    StatusBar1.Panels[2].Text :=  (sender as TJvSpinEdit).Hint;
  if (sender is TMemo) then
    StatusBar1.Panels[2].Text :=  (sender as TMemo).Hint;
  if (sender is TComboBox) then
    StatusBar1.Panels[2].Text :=  (sender as TComboBox).Hint;
  if (sender is TCheckBox) then
    StatusBar1.Panels[2].Text :=  (sender as TCheckBox).Hint;
end;

procedure TfrmCharacterEditor.setbBox(x, y, w,h: integer;
  theGid: TJvGIFAnimator);
Var
  multiPly : Integer;
begin
  if bBoxGif = nil then Begin
   bBoxGif := TJvGIFAnimator.Create(sbGif);
   bBoxGif.Parent := sbGif;
   bBoxGif.AutoSize := false;
   bBoxGif.Stretch := true;
   bBoxGif.Image.LoadFromFile(config.imageDir +'\bBox1.gif');
  end;

  if seGifSize.AsInteger > 0 then
    multiPly := seGifSize.AsInteger
  else
    multiPly := 1;

  bBoxGif.Top :=  theGid.Top + (y * multiPly);
  bBoxGif.Left := theGid.Left + (x * multiPly);
  bBoxGif.Width := w * multiPly;
  bBoxGif.Height := h * multiPly;
end;

procedure TfrmCharacterEditor.gifClearList;
Var
  i : integer;
  aGif : TJvGIFAnimator;
  aFrm : TfrmGifList;
begin
  i := 0;
  //remove if gif
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TJvGIFAnimator then Begin
      aGif := (sbGifList.Components[i] as TJvGIFAnimator);
      aGif.Free;
      i := 0;
    end
    else
      inc(i);
  end;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      FreeAndNil(aFrm);
      i := 0;
    end
    else
      inc(i);
  end;
end;

procedure TfrmCharacterEditor.gifPopulateListFrame(listData: TStringList);
Var
  i : Integer;
  aGif : TJvGIFAnimator;
  s : string;
  aFrm : TfrmGifList;
  theEntityFrame : TEntityDetailFrames;
begin
  //gifClearList;
  selectFrame(1);
  i := listData.Count;
  workingFrame.frameCount := listData.Count;
  //for i := (listData.Count -1) to 0 do Begin
  if listData.Count > 0 then Begin
    frameCreates(listData.Count);
    frameHideAll;
    //frameShow(listData.Count);
    //frameLoadGifs(listData);
  end;
  i := listData.Count;
  while i > 0 do Begin
    theEntityFrame := (listData.Objects[i-1] as TEntityDetailFrames);
    frameShow(i,theEntityFrame);
    i := i -1;
  end;
end;

function TfrmCharacterEditor.frameGetCount: Integer;
Var
  i, iFound : Integer;
begin
  iFound := 0;
  i := 0;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      inc(iFound);
    end;
    inc(i);
  end;
  Result := iFound;
end;

procedure TfrmCharacterEditor.frameCreates(totalToExists: Integer);
Var
  iCount, i : Integer;
  aFrm : TfrmGifList;
begin
  iCount := frameGetCount;

  if iCount < totalToExists then Begin
    i := totalToExists;
    while i > iCount do Begin
      aFrm := TfrmGifList.Create(sbGifList);
      aFrm.Visible := false;
      aFrm.Parent := sbGifList;
      aFrm.Align := alLeft;
      aFrm.workingFolder := workingFolder;
      aFrm.Width := 50;
      aFrm.Name := 'zzGifzz' + IntToStr(i);
      aFrm.edtGifName.Text := IntToStr(i);

      i := i -1;
    end;
  end;
end;

procedure TfrmCharacterEditor.frameShow(totalToShow: integer);
Var
  i, iFound : Integer;
  aFrm : TfrmGifList;
begin
  iFound := 0;
  i := 0;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      aFrm.Visible := true;
      inc(iFound);
      if iFound > totalToShow then Begin
        aFrm.Visible := false;
      end;

    end;
    inc(i);
  end;
end;

procedure TfrmCharacterEditor.frameLoadGifs(listData: TStringList);
Var
  i, iFound, iGif : Integer;
  aFrm : TfrmGifList;
  aEntityDetailFrame : TEntityDetailFrames;
begin
  iFound := 0;
  i := 0;
  iGif := 0;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      if aFrm.Visible = true then Begin
        //aFrm.loadImage(listData.Strings[iGif]);
        aFrm.Width := aFrm.gifWidth;
      end;
      inc(iGif);
      inc(iFound);


    end;
    inc(i);
  end;
end;

procedure TfrmCharacterEditor.frameHideAll;
Var
  i, iFound : Integer;
  aFrm : TfrmGifList;
begin
  iFound := 0;
  i := 0;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      aFrm.Visible := false;
    end;
    inc(i);
  end;
end;

procedure TfrmCharacterEditor.frameShow(frameNumber: Integer;
  frameDetails: TEntityDetailFrames);
Var
  i, iFound,j : Integer;
  aFrm : TfrmGifList;
begin
  iFound := 0;
  i := 0;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      if aFrm.Name = 'zzGifzz' + IntToStr(frameNumber) then Begin
        j := 0;
        aFrm.workingFolder := workingFolder;
        aFrm.loadImage(frameDetails.frameFile,frameDetails);
        aFrm.Width := aFrm.gifWidth;
        aFrm.Height := sbGifList.Height;//aFrm.gifHeight;
        j := aFrm.updateVisuals(aFrm.Width,aFrm.Height-aFrm.edtGifName.Height-4);
        if j > 0 then
          aFrm.Width := j;
        aFrm.Left := 0;
        aFrm.Visible := true;

      end;

    end;
    inc(i);
  end;
end;

procedure TfrmCharacterEditor.EditText1Click(Sender: TObject);
Var
  pData : panimeEntityList;
  newEntityDetail : TEntityDetail;
begin
  if vstAnimList.FocusedNode <> nil then Begin
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);

    frmEditor.populateEditor(pData.entityHeader);
    frmEditor.ShowModal;
    pData.entityHeader.Text := frmEditor.JvRichEdit1.Lines.Text;
    newEntityDetail := TEntityDetail.create;
    newEntityDetail := pData.entityDetail.stripAnimeFrames(pData.entityHeader,newEntityDetail);
    pData.entityDetail := newEntityDetail;
    EntityDetails := EntityDetails.updateEntityDetail(pData.entityDetail,EntityDetails);
    vstAnimListFocusChanged(vstAnimList,vstAnimList.FocusedNode,0);
  end;
end;

procedure TfrmCharacterEditor.vstAnimListEnter(Sender: TObject);
Var
  pData :panimeEntityList;
  newEntityDetail : TEntityDetail;
begin
  //if modified = true then Begin
  if frameEditor.modified = true then
    modified := true;
  if vstAnimList.FocusedNode <> nil then Begin
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
    case JvPageControl1.ActivePageIndex of
      0: Begin
           //Image
           if pData.zType = 1 then Begin
             if modified = true then
               updateEntityDetail(vstAnimList.FocusedNode);
           end Else begin
             if pData.zType = 0 then
               if modified = true then Begin
                 //TODO syn
                 EntityDetails := frmCharacterEditor.EntityDetails;
                 EntityDetails.headers.Text := frameEditor.SynEdit1.Lines.Text;
                 //EntityDetails.headers.Text := SynEdit1.Lines.Text;
                 setEditorMode(2);
               end;
           end;
         end;
      1: Begin
          //Editor
          if pData.zType = 1 then Begin
            if modified = true then Begin
              //TODO syn
              EntityDetails := frmCharacterEditor.EntityDetails;
              pData := updateAnimNode(vstAnimList.FocusedNode,frameEditor.SynEdit1.Lines);
              //pData := updateAnimNode(vstAnimList.FocusedNode,SynEdit1.Lines);
            end;
          end else Begin
            if modified = true then Begin
              //TODO syn
              EntityDetails := frmCharacterEditor.EntityDetails;
              EntityDetails.headers.Text := frameEditor.SynEdit1.Lines.Text;
              //EntityDetails.headers.Text := SynEdit1.Lines.Text;
            end;
          end;
         setEditorMode(2);
         end;
    end;
  end;
  //end;
end;

function TfrmCharacterEditor.updateEntityDetail(
  treeNode: PVirtualNode): TEntityDetail;
Var
  pData : panimeEntityList;
  newEntityDetail : TEntityDetail;
begin
  newEntityDetail := nil;
  if treeNode <> nil then Begin
    pData := vstAnimList.GetNodeData(treeNode);
    pData.entityDetail := pData.entityDetail.updateEntityDetailFromFrameList(pData.entityDetail);
    newEntityDetail := TEntityDetail.create;
    newEntityDetail := pData.entityDetail.stripAnimeFrames(pData.entityHeader,newEntityDetail);
    newEntityDetail := pData.entityDetail.updateEntityDetailFromFrameList(pData.entityDetail);
    pData.entityDetail := newEntityDetail;
    //pData.stringList.savetoFile('c:\123.txt') newEntityDetail.header.savetoFile('c:\123.txt')
    pData.entityHeader.Text := newEntityDetail.header.Text;

  end;
  Result := newEntityDetail;
end;

procedure TfrmCharacterEditor.updateEntityDetailFrame(
  aFrame: TEntityDetailFrames);
Var
  pData : panimeEntityList;
begin
  if vstAnimList.FocusedNode <> nil then Begin
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
    pData.entityDetail := pData.entityDetail.updateFrame(aFrame,pData.entityDetail);
    EntityDetails := EntityDetails.updateEntityDetail(pData.entityDetail,EntityDetails);
    workingFrame := workingFrame.dublicateFrame(workingFrame,aFrame);
    frameUpdate(workingFrame.frameNumber);
    modified := True;
  end;
end;

procedure TfrmCharacterEditor.Add1Click(Sender: TObject);
Var
  s: string;
begin
  if seOffSetX.Font.Color = config.hasValue then Begin
    //ShowMessage('All ready contains a offset!')
  end  
  else Begin
    s := #09 + 'offset' + #09 + '0 0';
    workingFrame.header.Insert(0,s);
    workingFrame.offSetX := 0;
    workingFrame.offSetY := 0;
    seOffSetX.Font.Color := config.hasValue;
    seOffSetY.Font.Color := config.hasValue;
    memFrameInfo.Lines.Text := workingFrame.header.Text;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.Remove1Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
begin
  if seOffSetX.Font.Color = config.noValue then
    ShowMessage('Contains no offset to remove!')
  else Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if PosStr('offset',s) > 0 then Begin
        workingFrame.header.Delete(i);
        i := workingFrame.header.Count;
        isLoading := True;
        seOffSetX.AsInteger := 0;
        seOffSetY.AsInteger := 0;
        isLoading := false;
        seOffSetX.Font.Color := config.noValue;
        seOffSetY.Font.Color := config.noValue;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.SettoNull1Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
  canProceed : boolean;
begin
  canProceed := false;
  if seOffSetX.Font.Color = config.noValue then Begin
    If MessageDlg('No offset defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add1Click(Add1);
             canProceed := True;
           End;
  end else
    canProceed := true;
  if canProceed = true then Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if PosStr('offset',s) > 0 then Begin
        f := #09 + 'offset' + #09 + '0 0';
        workingFrame.header.Strings[i] := f;
        i := workingFrame.header.Count;
        isLoading := True;
        seOffSetX.AsInteger := 0;
        seOffSetY.AsInteger := 0;
        isLoading := false;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.Add2Click(Sender: TObject);
Var
  s: string;
begin
  if seMoveX.Font.Color = config.hasValue then
    ShowMessage('All ready contains a Move Set!')
  else Begin
    s := #09 + 'move' + #09 + '0';
    workingFrame.header.Insert(0,s);
    s := #09 + 'movea' + #09 + '0';
    workingFrame.header.Insert(0,s);
    s := #09 + 'movez' + #09 + '0';
    workingFrame.header.Insert(0,s);
    workingFrame.moveX := 0;
    workingFrame.moveA := 0;
    workingFrame.moveZ := 0;
    seMoveX.Font.Color := config.hasValue;
    seMoveA.Font.Color := config.hasValue;
    seMoveZ.Font.Color := config.hasValue;
    memFrameInfo.Lines.Text := workingFrame.header.Text;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.Remove2Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
begin
  if seMoveX.Font.Color = config.noValue then
    ShowMessage('Contains no move set to remove!')
  else Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if PosStr('move',s) > 0 then Begin
        workingFrame.header.Delete(i);
        isLoading := True;
        seMoveX.AsInteger := 0;
        seMoveA.AsInteger := 0;
        seMoveZ.AsInteger := 0;
        isLoading := false;
        seMoveX.Font.Color := config.noValue;
        seMoveA.Font.Color := config.noValue;
        seMoveZ.Font.Color := config.noValue;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.Settonull2Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
  canProceed : Boolean;
begin
  canProceed := false;
  if seMoveX.Font.Color = config.noValue then Begin
    If MessageDlg('No move set defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add2Click(Add2);
             canProceed := True;
           End;
  end else
    canProceed := true;
  if canProceed = true then Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if PosStr('move',s) > 0 then Begin
        if (PosStr('move ', s) > 0) or
           (PosStr('move'+#09, s) >0) then
          f := #09 + 'move' + #09 + '0'
        else
        if (PosStr('movea',s)>0) then
          f := #09 + 'movea' + #09 + '0'
        else
        if (PosStr('movez',s)>0) then
          f := #09 + 'movez' + #09 + '0';
        workingFrame.header.Strings[i] := f;
        i := workingFrame.header.Count;
        isLoading := True;
        seOffSetX.AsInteger := 0;
        seOffSetY.AsInteger := 0;
        isLoading := false;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.Add3Click(Sender: TObject);
Var
  s: string;
begin
  if seBBxX.Font.Color = config.hasValue then
    showMessageStatus('All ready contains a bBox set!')
    //ShowMessage('All ready contains a bBox set!')
  else Begin
    s := #09 + 'bbox' + #09 + '0 0 0 0';
    workingFrame.header.Insert(0,s);
    workingFrame.bBoxX := 0;
    workingFrame.bBoxY := 0;
    workingFrame.bBoxW := 0;
    workingFrame.bBoxH := 0;
    seBBxX.Font.Color := config.hasValue;
    seBBxY.Font.Color := config.hasValue;
    seBBxW.Font.Color := config.hasValue;
    seBBxH.Font.Color := config.hasValue;
    memFrameInfo.Lines.Text := workingFrame.header.Text;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.Remove3Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
begin
  if seBBxX.Font.Color = config.noValue then
    showMessageStatus('Contains no bBox set to remove!')
    //ShowMessage('Contains no bBox set to remove!')
  else Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if isbBox(s) = true then Begin
        workingFrame.header.Delete(i);
        i := workingFrame.header.Count;
        isLoading := True;
        seBBxX.AsInteger := 0;
        seBBxY.AsInteger := 0;
        seBBxW.AsInteger := 0;
        seBBxH.AsInteger := 0;
        isLoading := false;
        seBBxX.Font.Color := config.noValue;
        seBBxY.Font.Color := config.noValue;
        seBBxW.Font.Color := config.noValue;
        seBBxH.Font.Color := config.noValue;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.SettoNull3Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
  canproceed : boolean;
begin
  canproceed := false;
  if seBBxX.Font.Color = config.noValue then Begin
    If MessageDlg('No body box defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add3Click(Add3);
             canProceed := True;
           End;
  end else
    canProceed := true;

  if canProceed = true then Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := LowerCase(workingFrame.header.Strings[i]);
      if PosStr('bbox',s) > 0 then Begin
        f := #09 + 'bbox' + #09 + '0 0 0 0';
        workingFrame.header.Strings[i] := f;
        i := workingFrame.header.Count;
        isLoading := True;
        workingFrame.bBoxX := 0;
        workingFrame.bBoxY := 0;
        workingFrame.bBoxW := 0;
        workingFrame.bBoxH := 0;
        seBBxX.AsInteger := 0;
        seBBxY.AsInteger := 0;
        seBBxW.AsInteger := 0;
        seBBxH.AsInteger := 0;
        isLoading := false;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.Add4Click(Sender: TObject);
Var
  s: string;
begin
  if seAttckBoxX.Font.Color = config.hasValue then
    showMessageStatus('All ready contains a attack set!')
    //ShowMessage('All ready contains a attack set!')
  else Begin
    s := #09 + cbAttackName.Text + #09 + '0 0 0 0 0 0 0 0 0 0';
    workingFrame.header.Insert(0,s);
    workingFrame.atBoxName := cbAttackName.Text;
    workingFrame.atBoxX := 0;
    workingFrame.atBoxY := 0;
    workingFrame.atBoxW := 0;
    workingFrame.atBoxH := 0;
    workingFrame.atDmg := 0;
    workingFrame.atPwr := 0;
    workingFrame.atFlsh := 0;
    workingFrame.atBlck := 0;
    workingFrame.atPause := 0;
    workingFrame.atDepth := 0;
    cbAttackName.Font.Color := config.hasValue;
    seAttckBoxX.Font.Color := config.hasValue;
    seAttckBoxY.Font.Color := config.hasValue;
    seAttckBoxW.Font.Color := config.hasValue;
    seAttckBoxH.Font.Color := config.hasValue;
    seatDamage.Font.Color := config.hasValue;
    seatPower.Font.Color := config.hasValue;
    cbatFlash.Font.Color := config.hasValue;
    cbatBlockable.Font.Color := config.hasValue;
    seatPause.Font.Color := config.hasValue;
    seatDepth.Font.Color := config.hasValue;
    memFrameInfo.Lines.Text := workingFrame.header.Text;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.Remove4Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
  shouldDelete : Boolean;
begin
  if seAttckBoxX.Font.Color = config.noValue then
    showMessageStatus('Contains no attack set to remove!')
    //ShowMessage('Contains no attack set to remove!')
  else Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if  PosStr('attack',s) > 0 then Begin
        if cbAttackName.Text = 'attack' then Begin
          if (PosStr('attack ',s) > 0) or
             (PosStr('attack'+#09,s)>0) then
           shouldDelete := true;
        end else
         if PosStr(cbAttackName.Text,s) > 0 then
           shouldDelete := True
         else
           shouldDelete := false;
        if shouldDelete = true then Begin
          workingFrame.header.Delete(i);
          i := workingFrame.header.Count;
          isLoading := True;
          workingFrame.atBoxX := 0;
          workingFrame.atBoxY := 0;
          workingFrame.atBoxW := 0;
          workingFrame.atBoxH := 0;
          workingFrame.atDmg := 0;
          workingFrame.atPwr := 0;
          workingFrame.atFlsh := 0;
          workingFrame.atBlck := 0;
          workingFrame.atPause := 0;
          workingFrame.atDepth := 0;
          seAttckBoxX.Font.Color := config.noValue;
          seAttckBoxY.Font.Color := config.noValue;
          seAttckBoxW.Font.Color := config.noValue;
          seAttckBoxH.Font.Color := config.noValue;
          seatDamage.Font.Color := config.noValue;
          seatPower.Font.Color := config.noValue;
          cbatFlash.Font.Color := config.noValue;
          cbatBlockable.Font.Color := config.noValue;
          seatPause.Font.Color := config.noValue;
          seatDepth.Font.Color := config.noValue;
          isLoading := false;
          memFrameInfo.Lines.Text := workingFrame.header.Text;
          updateEntityDetailFrame(workingFrame);
        end;
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.SettoNull4Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
  shouldUpdate, canProceed : Boolean;
begin
  canProceed := false;
  if seAttckBoxX.Font.Color = config.noValue then Begin
    If MessageDlg('No attack set defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add4Click(Add4);
             canProceed := True;
           End;
  end else
    canProceed := true;
  if canProceed = true then Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := strClearAll(workingFrame.header.Strings[i]);
      //if PosStr('attack',s) > 0 then Begin
      if isAttackBlock(s) = true then begin
        shouldUpdate := true;
        {if (PosStr('attack ',s) > 0) or
           (PosStr('attack'+#09,s) > 0) then
           shouldUpdate := True
         else
         if (PosStr(cbAttackName.Text,s) > 0) then
           shouldUpdate := true
         else
           shouldUpdate := false;}
        if shouldUpdate = true then Begin
          f := #09 + cbAttackName.Text + #09 + '0 0 0 0 0 0 0 0 0 0';
          workingFrame.header.Strings[i] := f;
          i := workingFrame.header.Count;
          isLoading := True;
          workingFrame.atBoxX := 0;
          workingFrame.atBoxY := 0;
          workingFrame.atBoxW := 0;
          workingFrame.atBoxH := 0;
          workingFrame.atDmg := 0;
          workingFrame.atPwr := 0;
          workingFrame.atFlsh := 0;
          workingFrame.atBlck := 0;
          workingFrame.atPause := 0;
          workingFrame.atDepth := 0;

          seAttckBoxX.AsInteger := 0;
          seAttckBoxY.AsInteger := 0;
          seAttckBoxW.AsInteger := 0;
          seAttckBoxH.AsInteger := 0;
          seatDamage.AsInteger := 0;
          seatPower.AsInteger := 0;
          cbatFlash.Checked := false;
          cbatBlockable.Checked := false;
          seatPause.AsInteger := 0;
          seatDepth.AsInteger := 0;

          isLoading := false;
          memFrameInfo.Lines.Text := workingFrame.header.Text;
          updateEntityDetailFrame(workingFrame);
        end;
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.vstAnimListPaintText(
  Sender: TBaseVirtualTree; const TargetCanvas: TCanvas;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
Var
  pData : panimeEntityList;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(Node);
    if pData.entityDetail <> nil then Begin
      if pData.entityDetail.containsScript = true then
        TargetCanvas.Font.Color := config.hasScript;
    end else Begin
      TargetCanvas.Font.Style := [fsBold];
      TargetCanvas.Font.Color := clMaroon;
    end;
      if Sender.FocusedNode = node then
        TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsUnderline]
      else
        TargetCanvas.Font.Style := TargetCanvas.Font.Style - [fsUnderline];
  end;
end;

procedure TfrmCharacterEditor.vstAnimListDblClick(Sender: TObject);
begin
  //EditText1Click(self);
end;

function TfrmCharacterEditor.setAttBox(x, y, w, h, zMultiPly: integer;
  theGif, zattBoxGif: TJvGIFAnimator;gifParent:TWinControl;useMultiply:Boolean):TJvGIFAnimator;
Var
  multiPly : Integer;
begin
  if (w > 0) and
     (h > 0) then Begin
    if zattBoxGif = nil then Begin
     zattBoxGif := TJvGIFAnimator.Create(gifParent);
     zattBoxGif.Parent := gifParent;
     zattBoxGif.AutoSize := false;
     zattBoxGif.Stretch := true;
     zattBoxGif.Threaded := false;
     zattBoxGif.Image.LoadFromFile(config.imageDir +'\attBox.gif');
    end else
      zattBoxGif.Visible := True;

    if zMultiPly > 0 then
      multiPly := zMultiPly
    else
      multiPly := 1;

    if useMultiply = true then Begin
      zattBoxGif.Top :=  theGif.Top + (y * zMultiPly);
      zattBoxGif.Left := theGif.Left + (x * zMultiPly);
      zattBoxGif.Width := w * zMultiPly;
      zattBoxGif.Height := h * zMultiPly;
    end else Begin
      zattBoxGif.Top :=  theGif.Top + (y div zMultiPly);
      zattBoxGif.Left := theGif.Left + (x div zMultiPly);
      zattBoxGif.Width := w div zMultiPly;
      zattBoxGif.Height := h div zMultiPly;
    end;
  end else Begin
    if zattBoxGif <> nil then
      zattBoxGif.Visible := false;
  end;
  Result := zattBoxGif;
end;

function TfrmCharacterEditor.setbBox(x, y, w, h, zMultiPly: integer;
  theGif, zattBoxGif: TJvGIFAnimator; gifParent: TWinControl;
  useMultiply: Boolean): TJvGIFAnimator;
Var
  multiPly : Integer;
begin
  if (w > 0) and
     (h > 0) then Begin
    if zattBoxGif = nil then Begin
     zattBoxGif := TJvGIFAnimator.Create(gifParent);
     zattBoxGif.Parent := gifParent;
     zattBoxGif.AutoSize := false;
     zattBoxGif.Stretch := true;
     zattBoxGif.Threaded := false;
     zattBoxGif.Loop := false;
     zattBoxGif.Image.LoadFromFile(config.imageDir +'\bBox1.gif');
    end else
      zattBoxGif.Visible := True;

    if zMultiPly > 0 then
      multiPly := zMultiPly
    else
      multiPly := 1;

    if useMultiply = true then Begin
      zattBoxGif.Top :=  theGif.Top + (y * zMultiPly);
      zattBoxGif.Left := theGif.Left + (x * zMultiPly);
      zattBoxGif.Width := w * zMultiPly;
      zattBoxGif.Height := h * zMultiPly;
    end else Begin
      zattBoxGif.Top :=  theGif.Top + (y div zMultiPly);
      zattBoxGif.Left := theGif.Left + (x div zMultiPly);
      zattBoxGif.Width := w div zMultiPly;
      zattBoxGif.Height := h div zMultiPly;
    end;
  end else Begin
    if zattBoxGif <> nil then
      zattBoxGif.Visible := false;
  end;
  Result := zattBoxGif;
end;

procedure TfrmCharacterEditor.showMessageStatus(zmessage: String);
begin
  StatusBar1.Panels[1].Text := zmessage;
  showBubble('Message',zmessage,1000);
  //ShowMessage(zmessage);
end;

procedure TfrmCharacterEditor.ToolButton4Click(Sender: TObject);
begin
  if Form1.JvSaveDialog1.Execute then Begin
    EntityDetails.savetofile(Form1.JvSaveDialog1.FileName,EntityDetails);
    modified := false;
    showMessageStatus('Succesfully save: ' + Form1.JvSaveDialog1.FileName);
  end;
end;

function TfrmCharacterEditor.drawbBox(x, y, w, h, zMultiPly: integer;
  theGif: TJvGIFAnimator; pngBox: TPNGButton; gifParent: TWinControl;
  pngFileName:String;useMultiply: Boolean): TPNGButton;
Var
  multiPly : Integer;
begin
  if (w > 0) or
     (h > 0) then Begin
    if pngBox = nil then Begin
     pngBox := TPNGButton.Create(gifParent);
     pngBox.ButtonStyle := pbsNoFrame;
     pngBox.Parent := gifParent;
     pngBox.Hint := pngFileName;
     pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName); // +'\bBox1.png');
    end else
      pngBox.Visible := True;
    if pngBox.hint <> pngFileName then Begin
      pngBox.Hint := pngFileName;
      pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName);
    end;
    if zMultiPly = 0 then
      multiPly := 1
    else
    if zMultiPly < 0 then
      multiPly := zMultiPly - zMultiPly - zMultiPly
    else
      multiPly := zMultiPly;

    if useMultiply = true then Begin
      pngBox.Top :=  theGif.Top + (y * zMultiPly);
      pngBox.Left := theGif.Left + (x * zMultiPly);
      pngBox.Width := w * zMultiPly;
      pngBox.Height := h * zMultiPly;
    end else Begin
      pngBox.Top :=  theGif.Top + (y div zMultiPly);
      pngBox.Left := theGif.Left + (x div zMultiPly);
      pngBox.Width := (w div zMultiPly);
      pngBox.Height := (h div zMultiPly);
    end;
  end else Begin
    if pngBox <> nil then
      pngBox.Visible := false;
  end;
  Result := pngBox;
end;

procedure TfrmCharacterEditor.ToolButton6Click(Sender: TObject);
begin
  //if Form1.JvSaveDialog1.Execute then Begin
    //JvPageControl1Change(JvPageControl1);
    if frameEditor.modified = true then
      modified := true;
    vstAnimListEnter(vstAnimList);
    EntityDetails.savetofile(workingCharacterFile,EntityDetails);
    modified := false;
    frameEditor.modified := false;

    showMessageStatus('Succesfully saved: ' + workingCharacterFile);
  //end;
end;

procedure TfrmCharacterEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  iAnser : integer;  
begin
  if frameEditor.modified = true then
    modified := true;
  if modified = true then
    iAnser := MessageDlg('Character file has been updated! Would you like to save?', mtWarning, [mbYes,mbNo,mbCancel], 0);
  //yes = 6
  //no =  7
  //cancel = 2
  if iAnser = 6 then Begin
    ToolButton6.Click;
    //EntityDetails.savetofile(workingCharacterFile,EntityDetails);
    modified := false;
    //TODO syn
    frameEditor.formClear;
    //vstEditor.Clear;
  end;
  if iAnser = 7 then Begin
    modified := false;
    //TODO syn
    frameEditor.formClear;
    //vstEditor.Clear;
  end;
  if iAnser = 2 then
    Action := caNone;
end;

function TfrmCharacterEditor.frameGetByFrameNumber(
  frameNumber: Integer): TfrmGifList;
Var
  i, iFound : Integer;
  aFrm, retrnFrame : TfrmGifList;
  found : Boolean;
begin
  iFound := 0;
  i := 0;
  found := false;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      if aFrm.workingFrame <> nil then Begin
        if aFrm.workingFrame.frameNumber = frameNumber then Begin
          found := True;
          retrnFrame := aFrm;
        end;
        end  else Begin
          if StrToInt(aFrm.edtGifName.Text) = frameNumber then Begin
            found := True;
            retrnFrame := aFrm;
          end;
      end;
      end;
    inc(i);
  end;
  if found = false then
    retrnFrame := nil;
  Result := retrnFrame;
end;

procedure TfrmCharacterEditor.frameUpdate(aFrame: TfrmGifList);
Var
  j : integer;
begin
  //This only updates bBox's for now
  aFrame.workingFrame := aFrame.workingFrame.dublicateFrame(aFrame.workingFrame,workingFrame);
  //aFrame.dublicateFrame();
  aFrame.Width := aFrame.gifWidth;
  aFrame.Height := aFrame.Height;
  j := aFrame.updateVisuals(aFrame.Width,aFrame.Height-aFrame.edtGifName.Height-4,True);
  if j > 0 then
    aFrame.Width := j;
end;

procedure TfrmCharacterEditor.frameUpdate(frameNumber: Integer);
Var
  aFrame:TfrmGifList;
begin
  aFrame := frameGetByFrameNumber(frameNumber);
  frameUpdate(aFrame);
end;

procedure TfrmCharacterEditor.FrameSelectNext;
Var
  aFrm : TfrmGifList;
begin
  if JvPageControl1.ActivePageIndex = 0 then Begin
    workingFrame.frameCount := frameGetCountFromTree;
    if seCurrentFrame.AsInteger >= workingFrame.frameCount then
      exit;
    aFrm := frameGetByFrameNumber(workingFrame.frameNumber + 1);
    if aFrm <> nil then Begin
      aFrm.gifClick(aFrm.gif);
    end;
  end;
end;

procedure TfrmCharacterEditor.FrameSelectprevious;
Var
  aFrm : TfrmGifList;
begin

  if JvPageControl1.ActivePageIndex = 0 then Begin
    if seCurrentFrame.AsInteger < 1 then
      exit;
    aFrm := frameGetByFrameNumber(workingFrame.frameNumber - 1);
    if aFrm <> nil then Begin
      aFrm.gifClick(aFrm.gif);
    end;
  end;
end;

procedure TfrmCharacterEditor.seCurrentFrameChange(Sender: TObject);
begin
  workingFrame.frameCount := frameGetCountFromTree;
  if (Sender as TJvSpinEdit).AsInteger > workingFrame.frameCount then
    exit;
  if isLoading = false then Begin
    (Sender as TJvSpinEdit).MaxValue := workingFrame.frameCount;
    FrameSelectByNumber(seCurrentFrame.AsInteger)
  end;
end;

procedure TfrmCharacterEditor.FrameSelectByNumber(fNumber:integer);
Var
  aFrm : TfrmGifList;
begin
  if JvPageControl1.ActivePageIndex = 0 then Begin
    aFrm := frameGetByFrameNumber(fNumber);
    if aFrm <> nil then Begin
      aFrm.gifClick(aFrm.gif);
    end;
  end;
end;

procedure TfrmCharacterEditor.directionOffSet(var x, y: Integer;
  isForward: Boolean; fromFrameNumber: Integer);
Var
  aFrm : TfrmGifList;
begin
  x := 0;
  y := 0;
  if isForward = false then Begin
    //Go Backwards
    while fromFrameNumber > 0 do Begin
      fromFrameNumber := fromFrameNumber -1;
      aFrm := frameGetByFrameNumber(fromFrameNumber);
      if aFrm <> nil then
        if (aFrm.workingFrame.offSetX > 0) or
         (aFrm.workingFrame.offSetY > 0) then Begin
           x := aFrm.workingFrame.offSetX;
           y := aFrm.workingFrame.offSetY;
           fromFrameNumber := 0;
         end;
    end;
  end else Begin
  //Go Forward
  workingFrame.frameCount := frameGetCountFromTree;
    while fromFrameNumber < workingFrame.frameCount do Begin
      inc(fromFrameNumber);
      aFrm := frameGetByFrameNumber(fromFrameNumber);
      if aFrm <> nil then
        if (aFrm.workingFrame.offSetX > 0) or
         (aFrm.workingFrame.offSetY > 0) then Begin
           x := aFrm.workingFrame.offSetX;
           y := aFrm.workingFrame.offSetY;
           fromFrameNumber := workingFrame.frameCount;
         end;
    end;
  end;
end;

function TfrmCharacterEditor.drawoBox(x, y, zMultiPly: integer;
  theGif: TJvGIFAnimator; pngBox: TPNGButton; gifParent: TWinControl;
  pngFileName: String; useMultiply: Boolean): TPNGButton;
Var
  multiPly : Integer;
begin
  if (x > 0) or
     (y > 0) then Begin
    if pngBox = nil then Begin
     pngBox := TPNGButton.Create(gifParent);
     pngBox.ButtonStyle := pbsNoFrame;
     pngBox.Parent := gifParent;
     pngBox.Hint := config.imageDir + pngFileName;
     pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName); // +'\bBox1.png');
    end else
      pngBox.Visible := True;
    if pngBox.Hint <> config.imageDir + pngFileName then Begin
      pngBox.Hint := config.imageDir + pngFileName;
      pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName);
    end;
    if zMultiPly = 0 then
      multiPly := 1
    else
      multiPly := zMultiPly;

  if multiPly > 0 then Begin
    pngBox.Top :=  theGif.Top + ((y * multiPly) - (pngBox.Height div 2));
    pngBox.Left := theGif.Left + ((x * multiPly) - (pngBox.Width div 2));
  end else Begin
    multiPly := multiPly - multiPly - multiPly;
    pngBox.Top :=  theGif.Top + ((y div multiPly) - (pngBox.Height div 2));
    pngBox.Left := theGif.Left + ((x div multiPly) - (pngBox.Width div 2));
  end;

    {if useMultiply = true then Begin
      pngBox.Top :=  theGif.Top + (y * zMultiPly);
      pngBox.Left := theGif.Left + (x * zMultiPly);
    end else Begin
      pngBox.Top :=  theGif.Top + (y div zMultiPly);
      pngBox.Left := theGif.Left + (x div zMultiPly);
    end;}
  end else Begin
    if pngBox <> nil then
      pngBox.Visible := false;
  end;
  Result := pngBox;
end;

procedure TfrmCharacterEditor.SettoPrevious1Click(Sender: TObject);
Var
  x,y :Integer;
  canProceed : boolean;
begin
  if seOffSetX.Font.Color = config.noValue then Begin
    If MessageDlg('No offset defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add1Click(Add1);
             canProceed := True;
           End;
  end  else
    canProceed := true;
  if workingFrame.frameNumber > 1 then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    directionOffSet(x,y,false,workingFrame.frameNumber);
    seOffSetX.AsInteger := x;
    seOffSetY.AsInteger := y;
  end;
end;

procedure TfrmCharacterEditor.SettoNext1Click(Sender: TObject);
Var
  x,y :Integer;
  canProceed : boolean;
begin
  if seOffSetX.Font.Color = config.noValue then Begin
    If MessageDlg('No offset defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add1Click(Add1);
             canProceed := True;
           End;
  end else
    canProceed := true;
  workingFrame.frameCount := frameGetCountFromTree;
  if workingFrame.frameNumber < workingFrame.frameCount  then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    directionOffSet(x,y,True,workingFrame.frameNumber);
    seOffSetX.AsInteger := x;
    seOffSetY.AsInteger := y;
  end;
end;

function TfrmCharacterEditor.frameGetCountFromTree: integer;
Var
  pData : panimeEntityList;
  i : Integer;
begin
  i := 0;
  if vstAnimList.FocusedNode <> nil then Begin
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode );
    i := pData.entityDetail.frameList.Count;
  end;
  result := i;
end;

procedure TfrmCharacterEditor.directionMoveSet(var x, a, z: Integer;
  isForward: Boolean; fromFrameNumber: Integer);
Var
  aFrm : TfrmGifList;
begin
  x := 0;
  a := 0;
  z := 0;
  if isForward = false then Begin
    //Go Backwards
    while fromFrameNumber > 0 do Begin
      fromFrameNumber := fromFrameNumber -1;
      aFrm := frameGetByFrameNumber(fromFrameNumber);
      if aFrm <> nil then
        if (aFrm.workingFrame.moveX > 0) or
         (aFrm.workingFrame.moveA > 0) or
         (aFrm.workingFrame.moveZ > 0)  then Begin
           x := aFrm.workingFrame.moveX;
           a := aFrm.workingFrame.moveA;
           z := aFrm.workingFrame.moveZ;
           fromFrameNumber := 0;
         end;
    end;
  end else Begin
  //Go Forward
  workingFrame.frameCount := frameGetCountFromTree;
    while fromFrameNumber < workingFrame.frameCount do Begin
      inc(fromFrameNumber);
      aFrm := frameGetByFrameNumber(fromFrameNumber);
      if aFrm <> nil then
        if (aFrm.workingFrame.moveX > 0) or
         (aFrm.workingFrame.moveA > 0) or
         (aFrm.workingFrame.moveZ > 0) then Begin
           x := aFrm.workingFrame.moveX;
           a := aFrm.workingFrame.moveA;
           z := aFrm.workingFrame.moveZ;
           fromFrameNumber := workingFrame.frameCount;
         end;
    end;
  end;
end;

procedure TfrmCharacterEditor.SetfromPrevious1Click(Sender: TObject);
Var
  x,a,z : Integer;
  canProceed : boolean;
begin
  x := 0;
  a := 0;
  z := 0;
  if seMoveX.Font.Color = config.noValue then Begin
    If MessageDlg('No move set defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add2Click(Add2);
             canProceed := True;
           End;
  end else
    canProceed := true;
  if workingFrame.frameNumber > 1 then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    directionMoveSet(x,a,z,false,workingFrame.frameNumber);
    seMoveX.AsInteger := x;
    seMoveA.AsInteger := a;
    seMoveZ.AsInteger := z;
  end;
end;

procedure TfrmCharacterEditor.directionbBoxSet(var x, y, w, h: Integer;
  isForward: Boolean; fromFrameNumber: Integer);
Var
  aFrm : TfrmGifList;
begin
  x := 0;
  y := 0;
  w := 0;
  h := 0;
  if isForward = false then Begin
    //Go Backwards
    while fromFrameNumber > 0 do Begin
      fromFrameNumber := fromFrameNumber -1;
      aFrm := frameGetByFrameNumber(fromFrameNumber);
      if aFrm <> nil then
        if (aFrm.workingFrame.bBoxX > 0) or
         (aFrm.workingFrame.bBoxY > 0) or
         (aFrm.workingFrame.bBoxW > 0) or
         (aFrm.workingFrame.bBoxH > 0)  then Begin
           x := aFrm.workingFrame.bBoxX;
           y := aFrm.workingFrame.bBoxY;
           w := aFrm.workingFrame.bBoxW;
           h := aFrm.workingFrame.bBoxH;
           fromFrameNumber := 0;
         end;
    end;
  end else Begin
  //Go Forward
  workingFrame.frameCount := frameGetCountFromTree;
    while fromFrameNumber < workingFrame.frameCount do Begin
      inc(fromFrameNumber);
      aFrm := frameGetByFrameNumber(fromFrameNumber);
      if aFrm <> nil then
        if (aFrm.workingFrame.bBoxX > 0) or
         (aFrm.workingFrame.bBoxY > 0) or
         (aFrm.workingFrame.bBoxW > 0) or
         (aFrm.workingFrame.bBoxH > 0)  then Begin
           x := aFrm.workingFrame.bBoxX;
           y := aFrm.workingFrame.bBoxY;
           w := aFrm.workingFrame.bBoxW;
           h := aFrm.workingFrame.bBoxH;
           fromFrameNumber := workingFrame.frameCount;
         end;
    end;
  end;
end;

procedure TfrmCharacterEditor.SetfromPrevious2Click(Sender: TObject);
Var
  x,y,w,h : Integer;
  canProceed : boolean;
begin
  x := 0;
  y := 0;
  w := 0;
  h := 0;
  if seBBxX.Font.Color = config.noValue then Begin
    If MessageDlg('No body box defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add3Click(Add3);
             canProceed := True;
           End;
  end else
    canProceed := true;
  if workingFrame.frameNumber > 1 then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    directionbBoxSet(x,y,w,h,false,workingFrame.frameNumber);
    seBBxX.AsInteger := x;
    seBBxY.AsInteger := y;
    seBBxW.AsInteger := w;
    seBBxH.AsInteger := h;
  end;
end;

procedure TfrmCharacterEditor.SetfromNext1Click(Sender: TObject);
Var
  x,a,z : Integer;
  canProceed : boolean;
begin
  x := 0;
  a := 0;
  z := 0;
  if seMoveX.Font.Color = config.noValue then Begin
    If MessageDlg('No offset defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add2Click(Add2);
             canProceed := True;
           End;
  end else
    canProceed := true;
  workingFrame.frameCount := frameGetCountFromTree;
  if workingFrame.frameNumber < workingFrame.frameCount  then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    directionMoveSet(x,a,z,True,workingFrame.frameNumber);
    seMoveX.AsInteger := x;
    seMoveA.AsInteger := a;
    seMoveZ.AsInteger := z;
  end;
end;

procedure TfrmCharacterEditor.SetfromNext2Click(Sender: TObject);
Var
  x,y,w,h : Integer;
  canProceed : boolean;
begin
  x := 0;
  y := 0;
  w := 0;
  h := 0;
  if seBBxX.Font.Color = config.noValue then Begin
    If MessageDlg('No bBox defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add3Click(Add3);
             canProceed := True;
           End;
  end else
    canProceed := true;
  workingFrame.frameCount := frameGetCountFromTree;
  if workingFrame.frameNumber < workingFrame.frameCount  then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    directionbBoxSet(x,y,w,h,True,workingFrame.frameNumber);
    seBBxX.AsInteger := x;
    seBBxY.AsInteger := y;
    seBBxW.AsInteger := w;
    seBBxH.AsInteger := h;
    //seBBxXChange(seBBxX);
  end;
end;

function TfrmCharacterEditor.directionatBoxSet(var x, y, w, h: Integer;
  isForward: Boolean; fromFrameNumber: Integer; atName: String):TfrmGifList;
Var
  aFrm, foundFrame : TfrmGifList;
  found : Boolean;
begin
  x := 0;
  y := 0;
  w := 0;
  h := 0;
  found := false;
  if workingFrame <> nil then Begin
    if isForward = false then Begin
      //Go Backwards
      while fromFrameNumber > 0 do Begin
        fromFrameNumber := fromFrameNumber -1;
        aFrm := frameGetByFrameNumber(fromFrameNumber);
        if aFrm <> nil then
          if aFrm.workingFrame.hasAttackBox = true then
            if (aFrm.workingFrame.atBoxName = atName) then Begin
               x := aFrm.workingFrame.atBoxX;
               y := aFrm.workingFrame.atBoxY;
               w := aFrm.workingFrame.atBoxW;
               h := aFrm.workingFrame.atBoxH;
               foundFrame := afrm;
               found := true;
               fromFrameNumber := 0;
            end;
      end;
    end else Begin
    //Go Forward
    workingFrame.frameCount := frameGetCountFromTree;
      while fromFrameNumber < workingFrame.frameCount do Begin
        inc(fromFrameNumber);
        aFrm := frameGetByFrameNumber(fromFrameNumber);
        if aFrm <> nil then
          if aFrm.workingFrame.hasAttackBox = true then
            if (aFrm.workingFrame.atBoxName = atName) then Begin
               x := aFrm.workingFrame.atBoxX;
               y := aFrm.workingFrame.atBoxY;
               w := aFrm.workingFrame.atBoxW;
               h := aFrm.workingFrame.atBoxH;
               foundFrame := afrm;
               found := true;
               fromFrameNumber := workingFrame.frameCount;
             end;
      end;
    end;
  end;
  if found = true then
    Result := foundFrame
  else
    result := nil;
end;

procedure TfrmCharacterEditor.SetfromPrevious3Click(Sender: TObject);
Var
  x,y,w,h : Integer;
  canProceed : boolean;
  foundFrame : TfrmGifList;
begin
  x := 0;
  y := 0;
  w := 0;
  h := 0;
  if seAttckBoxX.Font.Color = config.noValue then Begin
    If MessageDlg('No attack box defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add4Click(Add4);
             canProceed := True;
           End;
  end else
    canProceed := true;
  if workingFrame.frameNumber > 1 then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    foundFrame := directionatBoxSet(x,y,w,h,false,workingFrame.frameNumber,cbAttackName.Text);
    seAttckBoxX.AsInteger := x;
    seAttckBoxY.AsInteger := y;
    seAttckBoxW.AsInteger := w;
    seAttckBoxH.AsInteger := h;
    if foundFrame <> nil then Begin
      seatDamage.AsInteger := foundFrame.workingFrame.atDmg;
      seatPower.AsInteger := foundFrame.workingFrame.atPwr;
      seatDepth.AsInteger := foundFrame.workingFrame.atDepth;
      seatPause.AsInteger := foundFrame.workingFrame.atPause;
      //cheating it here but o well
      cbatFlash.Checked := Int2Bool(foundFrame.workingFrame.atBlck);
      cbatBlockable.Checked := Int2Bool(foundFrame.workingFrame.atFlsh);
      {cbatBlockable.Checked := Int2Bool(foundFrame.workingFrame.atBlck);
      cbatFlash.Checked := Int2Bool(foundFrame.workingFrame.atFlsh);}
    end;
  end;
end;

procedure TfrmCharacterEditor.SettoNext2Click(Sender: TObject);
Var
  x,y,w,h : Integer;
  canProceed : boolean;
  foundFrame : TfrmGifList;
begin
  x := 0;
  y := 0;
  w := 0;
  h := 0;
  if seAttckBoxX.Font.Color = config.noValue then Begin
    If MessageDlg('No offset defined. Would you like to create one?', MtConfirmation,
         [MbYes, MbNo],0) = MrYes Then
           Begin
             Add4Click(Add4);
             canProceed := True;
           End;
  end else
    canProceed := true;
  workingFrame.frameCount := frameGetCountFromTree;
  if workingFrame.frameNumber < workingFrame.frameCount  then
    canProceed := True
  else
    canProceed := false;
  if canProceed = True then Begin
    foundFrame := directionatBoxSet(x,y,w,h,True,workingFrame.frameNumber,cbAttackName.Text);
    seAttckBoxX.AsInteger := x;
    seAttckBoxY.AsInteger := y;
    seAttckBoxW.AsInteger := w;
    seAttckBoxH.AsInteger := h;
    if foundFrame <> nil then Begin
      seatDamage.AsInteger := foundFrame.workingFrame.atDmg;
      seatPower.AsInteger := foundFrame.workingFrame.atPwr;
      seatDepth.AsInteger := foundFrame.workingFrame.atDepth;
      seatPause.AsInteger := foundFrame.workingFrame.atPause;
      cbatFlash.Checked := Int2Bool(foundFrame.workingFrame.atBlck);
      cbatBlockable.Checked := Int2Bool(foundFrame.workingFrame.atFlsh);
      {cbatBlockable.Checked := Int2Bool(foundFrame.workingFrame.atBlck);
      cbatFlash.Checked := Int2Bool(foundFrame.workingFrame.atFlsh);}
    end;
  end;
end;

procedure TfrmCharacterEditor.coloriseAttackBox(listData: TStringList);
Var
  i : integer;
  s : string;
begin
  coloriseAttackBox2Default;
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    if PosStr('attack',s) > 0 then Begin
      strClearStartEnd(s);
      Form1.StringDelete2End(s,' ');
      Form1.StringDelete2End(s,#09);
      coloriseAttackBoxItem(s);
    end;
  end;
end;

procedure TfrmCharacterEditor.coloriseAttackBoxItem(searchText:string);
Var
  i, j : Integer;
  s : string;
begin
  //<b><font color="$0000FF">Filename:   </font></b><u><FIELD="Filename"></u><br><b><font color="$0000FF">Type:   </font></b><i><FIELD="Type"></i>
  for i := 0 to cbAttackName.Items.Count -1 do Begin
    s := cbAttackName.Items.Strings[i];
    if s = searchText then Begin
      s := '<b>'+s+'</b>';
      j := i;
    end;
    cbAttackName.Items.Strings[i] := s;
  end;
  cbAttackName.Text := searchText;
  cbAttackName.SelText := searchText;
  cbAttackName.ItemIndex := j;
  cbAttackName.SelStart := j;
end;

procedure TfrmCharacterEditor.coloriseAttackBox2Default;
Var
  i : Integer;
  s : string;
begin
  //<b><font color="$0000FF">Filename:   </font></b><u><FIELD="Filename"></u><br><b><font color="$0000FF">Type:   </font></b><i><FIELD="Type"></i>
  for i := 0 to cbAttackName.Items.Count -1 do Begin
    s := cbAttackName.Items.Strings[i];
    Form1.StringDeleteUp2(s,'>');
    Form1.StringDelete2End(s,'<');
    cbAttackName.Items.Strings[i] := s;
  end;
end;

function TfrmCharacterEditor.coloriseGetText: String;
Var
  s : string;
begin
  s := cbAttackName.Items.Strings[cbAttackName.ItemIndex];
  Form1.StringDeleteUp2(s,'>');
  Form1.StringDelete2End(s,'<');
  Result := s;
end;

{procedure TfrmCharacterEditor.loadHighlighter(aFilename:String; ExcludeHgl:Boolean=false);
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
  If aFilename = 'SQL' then
    SynEdit1.Highlighter.UseUserSettings(2);
end;}

{procedure TfrmCharacterEditor.populateEditorTree;
Var
  i : integer;
  rData : ropenBorSystem;

begin
  //Add Root Nodes
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Header';
  rData.htyp := 0;
  pEntityHeader := nil;
  pEntityHeader := treeEditorVst.addopenBorSystemNode(rData,nil,false);
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'Entity Anim Types';
  rData.htyp := 1;
  pEntityAnimTypes := treeEditorVst.addopenBorSystemNode(rData,nil);
  rData := ses.borSys.clearopenBorSystemrData(rdata);
  rData.title := 'pEntity Anim Data';
  rData.htyp := 2;
  pEntityAnimData := treeEditorVst.addopenBorSystemNode(rData,nil);
  //Populate data from xml to type
  for i := 0 to ses.borSys.fopenBorSystem.Count -1 do Begin
    rData := ses.borSys.getopenBorSystemData(i);
    case rData.htyp of
      0: Begin
           treeEditorVst.addopenBorSystemNode(rData,pEntityHeader);
      end;
      1: Begin
           treeEditorVst.addopenBorSystemNode(rData,pEntityAnimTypes);
      end;
      2: Begin
           treeEditorVst.addopenBorSystemNode(rData,pEntityAnimData);
      end;
    end;
  end;
  vstEditor.SortTree(0,sdAscending);
end;}

procedure TfrmCharacterEditor.setEditorMode(iMode: integer);
begin
  editorMode := iMode;
  //TODO syn
  frameEditor.setSectionMode(iMode);
  {//pEntityHeader, pEntityAnimTypes, pEntityAnimData
  case iMode of
    0: Begin
         vstEditor.Expanded[pEntityHeader] := True;
         vstEditor.Expanded[pEntityAnimTypes] := false;
         vstEditor.Expanded[pEntityAnimData] := false;
    end;
    1: Begin
         vstEditor.Expanded[pEntityHeader] := false;
         vstEditor.Expanded[pEntityAnimTypes] := True;
         vstEditor.Expanded[pEntityAnimData] := false;
    end;
    2: Begin
         vstEditor.Expanded[pEntityHeader] := false;
         vstEditor.Expanded[pEntityAnimTypes] := false;
         vstEditor.Expanded[pEntityAnimData] := True;
    end;
  end;
  vstEditor.Refresh;}
  StatusBar1.Panels[1].Text := 'Glossary editor mode set to : ' + IntToStr(iMode);
end;

procedure TfrmCharacterEditor.editorLoadMedia(lineData: String);
Var
  i, j : integer;
  s : string;
  containsGif : Boolean;
  aFrm : TfrmGifList;
begin
  frameHideAll;
  lineData := strRemoveDbls(lineData);
  lineData := strClearStartEnd(lineData);
  StringReplace(lineData,#09,' ');
  StringDeleteUp2(lineData,' ');
  lineData := LowerCase(lineData);
  //if PosStr('.gif',lineData) > 0 then
  if isImageFile(lineData) = true then
    containsGif := true
  else
    containsGif := false;
  i := 1;
  if containsGif then Begin
    while PosStr('.gif', lineData) > 0 do begin
      s := lineData;
      StringDelete2End(s,' ');
      StringDeleteUp2(lineData,'.gif',4);
      frameCreates(i);
      aFrm := frameGetByFrameNumber(i);
      aFrm.loadImage(s,nil);
      aFrm.Left := 0;
      aFrm.Width := aFrm.gifWidth;
      aFrm.Visible := true;
      j := aFrm.updateVisuals(aFrm.Width,aFrm.Height-aFrm.edtGifName.Height-4);
      if j > 0 then
        aFrm.Width := j;
      inc(i);
    end;
    while PosStr('.png', lineData) > 0 do begin
      s := lineData;
      StringDelete2End(s,' ');
      StringDeleteUp2(lineData,'.png',4);
      frameCreates(i);
      aFrm := frameGetByFrameNumber(i);
      aFrm.loadImage(s,nil);
      aFrm.Left := 0;
      aFrm.Width := aFrm.gifWidth;
      aFrm.Visible := true;
      j := aFrm.updateVisuals(aFrm.Width,aFrm.Height-aFrm.edtGifName.Height-4);
      if j > 0 then
          aFrm.Width := j;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.JvPageControl1Change(Sender: TObject);
Var
  pData : panimeEntityList;
  newEntityDetail : TEntityDetail;
  node : PVirtualNode;
begin
  alldrag(false);
  if pngOverlay <> nil then
      if cbOverlay.Checked = false then
        pngOverlay.Visible := false;
  if vstAnimList.FocusedNode <> nil then
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode)
  else
    pData := nil;
  case JvPageControl1.ActivePageIndex of
    0: Begin
       //Image
       try
         if vstAnimList.FocusedNode = characterDetailsNode then Begin
          node := vstAnimList.GetNext(vstAnimList.FocusedNode);
           vstAnimList.FocusedNode := node;
           vstAnimList.Selected[node] := True;

         end else Begin
           if vstAnimList.FocusedNode <> nil then Begin
             //TODO syn
             EntityDetails := frmCharacterEditor.EntityDetails;
             pData := updateAnimNode(vstAnimList.FocusedNode,frameEditor.SynEdit1.Lines);
           end;
         end;
       except
       end;
       end;
    1: Begin
       //Editor
         if pData <> nil then Begin
           //TODO Syn
           frameEditor.SynEdit1.Lines := pData.entityHeader;
           pData := updateAnimNode(vstAnimList.FocusedNode,frameEditor.SynEdit1.Lines,false);
           setEditorMode(2);
         end;
       end;
  end;
  //vstAnimListFocusChanged(vstAnimList,vstAnimList.FocusedNode,0);
end;

procedure TfrmCharacterEditor.vstAnimListNewText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; NewText: WideString);
Var
  pData : panimeEntityList;
  s : string;
  aList : TStringList;
begin
  if node = characterDetailsNode then
    exit;
  if Node <> nil then Begin
    aList := TStringList.Create;
    pData := Sender.GetNodeData(node);
    pData.anme := NewText;
    s := 'anim' + #09 + NewText;
    aList.Text := pData.entityDetail.header.Text;
    aList.Strings[0] := s;
    pData.entityDetail.header.Text := aList.Text;
    //pData.entityDetail.header.Strings[0] := s;
    pData.entityDetail.animeName := NewText;
    pData := updateAnimNode(Node,pData.entityDetail.header);
    aList.Free;
    //vstAnimListFocusChanged(vstAnimList,node,0);
  end;
end;

function TfrmCharacterEditor.updateAnimNode(
  node2Update: PVirtualNode;EntityHeader:TStringList;reDraw:boolean): panimeEntityList;
Var
  newEntityDetail : TEntityDetail;
  pData : panimeEntityList;
begin

  pData := vstAnimList.GetNodeData(node2Update);
  pData.entityHeader.Text := EntityHeader.Text;
  newEntityDetail := TEntityDetail.create;
  newEntityDetail.header.Text := EntityHeader.Text;
  newEntityDetail.LineNumber := pData.entityDetail.LineNumber;
  newEntityDetail := newEntityDetail.stripAnimeFrames(EntityHeader,newEntityDetail);
  pData.entityDetail := newEntityDetail;
  EntityDetails := EntityDetails.updateEntityDetail(newEntityDetail,EntityDetails);
  if reDraw = true then
    vstAnimListFocusChanged(vstAnimList,vstAnimList.FocusedNode,0);
  pData.anme := pData.entityDetail.animeName;

  Result := pData;
end;

function TfrmCharacterEditor.updateAnimNode(node2Update: PVirtualNode;
  EntityHeader: TStrings;reDraw:boolean): panimeEntityList;
Var
  listData : TStringList;
begin
  listData := TStringList.Create;
  listData.Text := EntityHeader.Text;
  Result := updateAnimNode(node2Update,listData,reDraw);
end;

procedure TfrmCharacterEditor.Add5Click(Sender: TObject);
Var
  newEntityDetail : TEntityDetail;
  rData : ranimeEntityList;
  i : integer;
begin
  Randomize;
  i := EntityDetails.list.Count;
  rData := treeVst.clearanimeEntityListrData;
  newEntityDetail := TEntityDetail.create;
  //Add EntityDetails
  EntityDetails.lastKnownLineNumber := EntityDetails.lastKnownLineNumber + 1;
  newEntityDetail.LineNumber := EntityDetails.lastKnownLineNumber;
  newEntityDetail.animeName := 'new' + inttostr(i);
  newEntityDetail.header.add('anim'+#09+'new' + inttostr(i));

  rData.id := newEntityDetail.LineNumber;
  rData.anme := 'new' + inttostr(i);

  rData.entityHeader.Add( 'anim'+#09+'new' + inttostr(i) );
  rData.entityDetail := newEntityDetail;
  //rData.zType := 0;
  rData.zType := 1;
  EntityDetails.list.AddObject(rData.anme,newEntityDetail);
  treeVst.addanimeEntityListNode(rData,nil);
  modified := true;


end;

procedure TfrmCharacterEditor.vstAnimListKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_RIGHT: FrameSelectNext;
    VK_LEFT: FrameSelectprevious;
  end;
end;

procedure TfrmCharacterEditor.Dublicate1Click(Sender: TObject);
Var
  pData : panimeEntityList;
  rData : ranimeEntityList;
  newEntityDetail : TEntityDetail;
  i, j : integer;
  entityDetailHeader : TStringList;
begin
  if vstAnimList.FocusedNode <> nil then Begin
    Randomize;
    j := EntityDetails.list.Count;
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
    i := 0;
    //add rData
      rData := treeVst.clearanimeEntityListrData;

      entityDetailHeader := TStringList.Create;
      newEntityDetail := TEntityDetail.create;
      //Add EntityDetails
      entityDetailHeader.Text := pData.entityDetail.header.Text;
      entityDetailHeader.Strings[0] := 'anim'+#09+'new'+ inttostr(j);
      EntityDetails.lastKnownLineNumber := EntityDetails.lastKnownLineNumber + 1;
      newEntityDetail := newEntityDetail.stripAnimeFrames(entityDetailHeader,newEntityDetail);
      newEntityDetail.LineNumber := EntityDetails.lastKnownLineNumber;
      newEntityDetail.animeName := 'new'+ inttostr(j);
      //newEntityDetail.header := entityDetailHeader;

      rData.id := newEntityDetail.LineNumber;
      rData.anme := 'new'+ inttostr(j);
      rData.entityHeader := newEntityDetail.header;
      rData.entityDetail := newEntityDetail;
      rData.zType := 1;
      EntityDetails.list.AddObject(rData.anme,newEntityDetail);
      treeVst.addanimeEntityListNode(rData,nil);
      modified := true;


  end;
end;

procedure TfrmCharacterEditor.AddFrame1Click(Sender: TObject);
Var
  pData : panimeEntityList;
begin
  if vstAnimList.FocusedNode <> nil then Begin
    pData :=  vstAnimList.GetNodeData(vstAnimList.FocusedNode);

  end;
end;

procedure TfrmCharacterEditor.formSave(reDraw:Boolean = true);
Var
  pData : panimeEntityList;
begin
  if frameEditor.modified = true then
      modified := true;
  if vstAnimList.FocusedNode <> nil then Begin
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
    if JvPageControl1.ActivePageIndex = 1 then Begin
      //In Editor mode
      if pData.zType = 1 then Begin
        //TODO syn
        EntityDetails := frmCharacterEditor.EntityDetails;
        pData := updateAnimNode(vstAnimList.FocusedNode,frameEditor.SynEdit1.Lines,reDraw);
      end Else Begin
        //Character Details
        //TODO syn
        EntityDetails := frmCharacterEditor.EntityDetails;
        EntityDetails.headers.Text := frameEditor.SynEdit1.Lines.Text;

        //EntityDetails.headers.Text := SynEdit1.Lines.Text;
      end;
    end Else Begin
      //In Frame edit mode
      //Standard Frame
      if pData.zType = 1 then Begin
        if modified = true then
          updateEntityDetail(vstAnimList.FocusedNode);
      end Else begin
        //Character Details
        if pData.zType = 0 then
          if modified = true then Begin
            //TODO syn
            EntityDetails := frmCharacterEditor.EntityDetails;
            EntityDetails.headers.Text := frameEditor.SynEdit1.Lines.Text;
            //EntityDetails.headers.Text := SynEdit1.Lines.Text;
            //setEditorMode(2);
          end;
      end;
    end;
  end;
  if memFrameInfo.Focused then
    memFrameInfoExit(memFrameInfo);
end;

function TfrmCharacterEditor.animSelect(Node: PVirtualNode;
  isNext: Boolean): PVirtualNode;
begin
  if Node <> nil then Begin
    formSave;
    if isNext = true then Begin
      node := vstAnimList.GetNextSibling(Node);
      vstAnimList.FocusedNode := Node;
      vstAnimListFocusChanged(vstAnimList,node,0);
    end else Begin
    //Go BackWards
      node := vstAnimList.GetPreviousSibling(Node);
      vstAnimList.FocusedNode := Node;
      vstAnimListFocusChanged(vstAnimList,node,0);
    end;
  end;
  Result := Node;
end;

procedure TfrmCharacterEditor.JvPageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  formSave(false);
end;

function TfrmCharacterEditor.drawbBox(x, y, w, h, zMultiPly: integer;
  theGif: TImage; pngBox: TPNGButton; gifParent: TWinControl;
  pngFileName: String;boxType:Integer; useMultiply: Boolean): TPNGButton;
Var
  multiPly : Integer;
begin
  if (w > 0) or
     (h > 0) then Begin
    if pngBox = nil then Begin
     pngBox := TPNGButton.Create(gifParent);
     pngBox.ButtonStyle := pbsNoFrame;
     pngBox.Parent := gifParent;
     pngBox.Hint := pngFileName;
     pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName); // +'\bBox1.png');
     if boxType > 0 then Begin
       pngBox.OnClick := PNGButton1Click;
       //pngBox.OnMouseMove := PNGButton1MouseMove;
       pngBox.OnMouseExit := PNGButton1MouseExit;
     end;
     //box type 1 = bBox ; 2 = Attack Box
     pngBox.Tag := boxType;
    end else
      pngBox.Visible := True;
    if pngBox.hint <> pngFileName then Begin
      pngBox.Hint := pngFileName;
      pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName);
    end;
    if zMultiPly = 0 then
      multiPly := 1
    else
    if zMultiPly < 0 then
      multiPly := zMultiPly - zMultiPly - zMultiPly
    else
      multiPly := zMultiPly;

    if useMultiply = true then Begin
      pngBox.Top :=  theGif.Top + (y * zMultiPly);
      pngBox.Left := theGif.Left + (x * zMultiPly);
      pngBox.Width := w * zMultiPly;
      pngBox.Height := h * zMultiPly;
    end else Begin
      pngBox.Top :=  theGif.Top + (y div zMultiPly);
      pngBox.Left := theGif.Left + (x div zMultiPly);
      pngBox.Width := (w div zMultiPly);
      pngBox.Height := (h div zMultiPly);
    end;
  end else Begin
    if pngBox <> nil then
      pngBox.Visible := false;
  end;
  Result := pngBox;
end;

function TfrmCharacterEditor.drawoBox(x, y, zMultiPly: integer;
  theGif: TImage; pngBox: TPNGButton; gifParent: TWinControl;
  pngFileName: String; useMultiply: Boolean): TPNGButton;
Var
  multiPly : Integer;
begin
  if (x > 0) or
     (y > 0) then Begin
    if pngBox = nil then Begin
     pngBox := TPNGButton.Create(gifParent);
     pngBox.ButtonStyle := pbsNoFrame;
     pngBox.Parent := gifParent;
     pngBox.Hint := config.imageDir + pngFileName;
     pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName); // +'\bBox1.png');
    end else
      pngBox.Visible := True;
    if pngBox.Hint <> config.imageDir + pngFileName then Begin
      pngBox.Hint := config.imageDir + pngFileName;
      pngBox.ImageNormal.LoadFromFile(config.imageDir + pngFileName);
    end;
    if zMultiPly = 0 then
      multiPly := 1
    else
      multiPly := zMultiPly;

  if multiPly > 0 then Begin
    pngBox.Top :=  theGif.Top + ((y * multiPly) - (pngBox.Height div 2));
    pngBox.Left := theGif.Left + ((x * multiPly) - (pngBox.Width div 2));
    pngBox.Width := pngBox.ImageNormal.Width;
    pngBox.Height := pngBox.ImageNormal.Height;
  end else Begin
    multiPly := multiPly - multiPly - multiPly;
    pngBox.Top :=  theGif.Top + ((y div multiPly) - (pngBox.Height div 2));
    pngBox.Left := theGif.Left + ((x div multiPly) - (pngBox.Width div 2));
    {pngBox.Width := pngBox.ImageNormal.Width;
    pngBox.Height := pngBox.ImageNormal.Height;}
  end;

    {if useMultiply = true then Begin
      pngBox.Top :=  theGif.Top + (y * zMultiPly);
      pngBox.Left := theGif.Left + (x * zMultiPly);
    end else Begin
      pngBox.Top :=  theGif.Top + (y div zMultiPly);
      pngBox.Left := theGif.Left + (x div zMultiPly);
    end;}
  end else Begin
    if pngBox <> nil then
      pngBox.Visible := false;
  end;

  Result := pngBox;
end;

procedure TfrmCharacterEditor.gifLoad(fileNameOnly: String; theGif: TImage;
  frameDetails: TEntityDetailFrames; loadPrevious: Boolean);
Var
  GifFile : String;
  x, y, w, h : integer;
begin
  //GifFile := workingFolder + '\'+ fileNameOnly;
  fileNameOnly := strClearAll(fileNameOnly);
  if FileExists(fileNameOnly) then
    GifFile := fileNameOnly
  else
    GifFile := ses.dataDirecotry + '\' + fileNameOnly;
  if frameDetails <> nil then Begin
    //workingFrame := getFrameByFileName(workingFrameID,frameDetails.frameFile);
    workingFrame := frameDetails;
  end;
  if FileExists(GifFile) then Begin
    theGif.Hint := GifFile;
    theGif := registerextlessimag(theGif);
    theGif.Picture.LoadFromFile(GifFile);
    workingGifx := theGif.Picture.Width;
    workingGify := theGif.Picture.Height;
  end else
    theGif.Picture.LoadFromFile(config.noImage);
  if theGif = gif then Begin
      workingGifx := theGif.Picture.Width;
      workingGify := theGif.Picture.Height;
    end;
  if workingFrame <> nil then Begin
    populateFrame(workingFrame,workingFrameID);
    //updateVisuals;
  end;

  if cbGifLocation.ItemIndex = 1 then
    gifPosition(1)
  else
    gifPosition(0);
  if workingFrame <> nil then
    drawPlatform(workingFrame.header);
end;

procedure TfrmCharacterEditor.AnimatedGif1Click(Sender: TObject);
Var
  zGif : TGIFImage;
  i, iDelay : integer;
  sFileName, sDir, sDelay, sborFile : string;
begin
  if isNodeDetails(vstAnimList.FocusedNode) then exit;
  OpenDialog1.Options := OpenDialog1.Options + [ofAllowMultiSelect];
  if OpenDialog1.Execute then Begin
    zGif := gifLoadFromFile(OpenDialog1.FileName);
    sFileName := LowerCase(OpenDialog1.FileName);
    sFileName := ExtractFileName(sFileName);
    StringReplace(sFileName,'.gif','');
    sDir := ExtractFileDir(workingCharacterFile);
    zGif.Animate := false;
    //zGif.Images.List .[i].Image
    i := 0;
    while i < zGif.Images.Count -1 do Begin
      try
        iDelay := gifGetFrameDelay(zGif,i);
        gifSaveFrameSubToFile(zGif,i,sdir+'\'+sFileName+IntToStr(i)+'.gif');

        sDelay :=   #09+ 'delay ' + IntToStr(iDelay);
        sborFile := #09+ 'frame ' + File2BorFile(sdir+'\'+sFileName+IntToStr(i)+'.gif');
        addFrameHeaderDetails(vstAnimList.FocusedNode,sDelay);
        addFrameHeaderDetails(vstAnimList.FocusedNode,sborFile);
        inc(i);
      except
      end;
    end;
    zGif.Free;
  end;
end;

procedure TfrmCharacterEditor.addFrameHeaderDetails(
  node2Update: PVirtualNode; line2Add: String);
Var
  pData : panimeEntityList;
begin
  if node2Update <> nil then Begin
    pData := vstAnimList.GetNodeData(node2Update);
    if JvPageControl1.ActivePageIndex = 1 then Begin
      frameEditor.SynEdit1.Lines.Add(line2Add);
    end else Begin
      pData.entityHeader.Add(line2Add);
      updateAnimNode(node2Update,pData.entityHeader);
    end;
  end;
end;

procedure TfrmCharacterEditor.Selection1Click(Sender: TObject);
var
  aList : TStringList;

begin
  if isNodeDetails(vstAnimList.FocusedNode) then exit;
  OpenDialog1.Options := OpenDialog1.Options + [ofAllowMultiSelect];
  if OpenDialog1.Execute then Begin
    aList := TStringList.Create;
    aList.Sorted := true;
    aList.Text := OpenDialog1.Files.Text;
    aList.Sort;
    importFileList(aList);
    aList.Free;
  end;
end;

procedure TfrmCharacterEditor.importFileList(listData: TStringList;copy:boolean);
Var
  i : integer;
  s, borFileName, ext, sfilename : string;
  sdir : string;
begin
  sDir := ExtractFileDir(workingCharacterFile);
  for i := 0 to listData.Count -1 do Begin
    s := listData.Strings[i];
    sfilename := ExtractFileName(s);
    ext := matFileGetExt(s);
    if copy = true then
      CopyFile(pchar(s),pchar(sdir+'\'+sFileName),false);
    borFileName := #09+ 'frame ' + File2BorFile(sdir+'\'+sFileName);
    addFrameHeaderDetails(vstAnimList.FocusedNode,borFileName);
  end;
end;

procedure TfrmCharacterEditor.Directory1Click(Sender: TObject);
var
  aList : TStringList;
begin
  if isNodeDetails(vstAnimList.FocusedNode) then exit;
  if JvBrowseForFolderDialog1.Execute then Begin
    aList := TStringList.Create;

    Form1.JvSearchFiles1.FileParams.FileMasks.Text := '*.gif';
    Form1.JvSearchFiles1.RootDirectory := JvBrowseForFolderDialog1.Directory;
    Form1.JvSearchFiles1.Search;
    aList.Text := Form1.JvSearchFiles1.Files.Text;
    aList.Sorted := true;
    aList.Sort;
    importFileList(aList);

    Form1.JvSearchFiles1.FileParams.FileMasks.Text := '*.png';
    Form1.JvSearchFiles1.RootDirectory := JvBrowseForFolderDialog1.Directory;
    Form1.JvSearchFiles1.Search;
    aList.Text := Form1.JvSearchFiles1.Files.Text;
    aList.Sorted := true;
    aList.Sort;
    importFileList(aList);
    aList.Free;
  end;
end;

function TfrmCharacterEditor.isNodeDetails(node: PVirtualNode): boolean;
Var
  pData : panimeEntityList;
  isCharacter: boolean;
begin
  isCharacter := false;
  if node <> nil then Begin
    pData := vstAnimList.GetNodeData(node);
    case pData.zType of
      0: isCharacter := True;
      1: isCharacter := False;
    end;
  end;
  Result := isCharacter;
end;

procedure TfrmCharacterEditor.DeleteFiles1Click(Sender: TObject);
Var
  s, file2Del : string;
  i : integer;
begin
   If MessageDlg('Are you sure you want to delete the linked files?', MtConfirmation,
  [MbYes, MbNo],0) = MrYes Then
    Begin
      if workingFrame <> nil then
        for i := 0 to ses.workingEntityDetail.header.Count -1 do Begin
          s := ses.workingEntityDetail.header.Strings[i];
          //if isImageFile(s) then Begin
            file2Del := strClearAll(s);
            StringDeleteUp2(file2Del,' ');
            file2Del := borFile2File(file2Del);
            file2Del := ses.dataDirecotry + '\' + file2Del;
            if FileExists(file2Del) then
              DeleteFile(file2Del);
          //end;
        end;
       Delete1Click(Delete1);
    End
end;

procedure TfrmCharacterEditor.Delete1Click(Sender: TObject);
Var
  pData : panimeEntityList;
  nextNode : PVirtualNode;
  tmpEntityDetail : TEntityDetail;
  i : integer;
begin
  if vstAnimList.FocusedNode <> nil then Begin
    nextNode := vstAnimList.GetNextSibling(vstAnimList.FocusedNode);
    pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
    i := 0;
    while i < EntityDetails.list.Count do Begin
      tmpEntityDetail := (EntityDetails.list.objects[i] as TEntityDetail);

      //if tmpEntityDetail = pData.entityDetail then Begin
      if tmpEntityDetail.animeName = pData.entityDetail.animeName then Begin
        EntityDetails.list.Delete(i);
        i := EntityDetails.list.Count;
        modified := true;
        vstAnimList.DeleteNode(vstAnimList.FocusedNode);
        if nextNode = nil then Begin
          vstAnimList.FocusedNode := characterDetailsNode;
          vstAnimList.Selected[characterDetailsNode] := true;
        end
        else Begin
          vstAnimList.FocusedNode := nextNode;
          vstAnimList.Selected[nextNode] := true;
        end;

      end;
      inc(i);
    end;
    vstAnimList.FocusedNode := nextNode;

  end;
end;

procedure TfrmCharacterEditor.cbFocusClick(Sender: TObject);
begin
  frameEditor.cbFocus.Checked := cbFocus.Checked;
end;

function TfrmCharacterEditor.getOffSetImage(atype: integer): string;
Var
  s : string;
begin
  s := config.ofSetImage;
  case atype of
    -1: s := config.ofSetImagePrevious;
     0: s := '\offSet1.png';
     1: s := '\offSet2.png';
     2: s := '\offSet3.png';
     3: s := '\offSet4.png';
  end;
  Result := s;
end;

procedure TfrmCharacterEditor.PNGButton1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (sender as TPNGButton).ButtonStyle = pbsFlat then Begin
    if Shift = [ssCtrl] then Begin
      (sender as TPNGButton).Left := x +(sbGif.Width div 2) -((sender as TPNGButton).Width div 2);//(Mouse.CursorPos.X - frmCharacterEditor.left)-((sender as TPNGButton).Width div 2);
      (sender as TPNGButton).top := y +(sbGif.Height div 2) -((sender as TPNGButton).Height div 2);//(Mouse.CursorPos.Y - frmCharacterEditor.top)- ((sender as TPNGButton).Height div 2);
      {(sender as TPNGButton).Left := (Mouse.CursorPos.X - frmCharacterEditor.left)-((sender as TPNGButton).Width div 2);
      (sender as TPNGButton).top := (Mouse.CursorPos.Y - frmCharacterEditor.top)- ((sender as TPNGButton).Height div 2);}
    end;
  end;
end;

procedure TfrmCharacterEditor.PNGButton1MouseExit(Sender: TObject);
begin
  (sender as TPNGButton).ButtonStyle := pbsNoFrame;
end;

procedure TfrmCharacterEditor.PNGButton1Click(Sender: TObject);
begin
  (sender as TPNGButton).ButtonStyle := pbsFlat;
end;


procedure TfrmCharacterEditor.seRangeMinXChange(Sender: TObject);
Var
  pData : panimeEntityList;
  aFrame : TEntityDetailFrames;
begin
  if isLoading = false then Begin
    if (sender as TJvSpinEdit).Font.Color = config.noValue then
      showMessageStatus('Please add a offSet using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      //setOffset(seOffSetX.AsInteger,seOffSetY.AsInteger,gif);
      case cbGifLocation.ItemIndex of
        0:
            gifPosition(cbGifLocation.ItemIndex);
             {pngRange := drawbBox(seRangeMinX.AsInteger,(sbGif.Height div 2),
                      seRangeMaxX.AsInteger,30,
                      seGifSize.AsInteger,gif,pngRange,sbGif,'\attRangeX.png',-1,false);}
        {
      pngOffset := drawoBox(seOffSetX.AsInteger,seOffSetY.AsInteger,
                  seGifSize.AsInteger,gif,pngOffset,sbGif,getOffSetImage(cbOffSet.ItemIndex));//config.ofSetImage);}
        1: Begin
             gifPosition(cbGifLocation.ItemIndex);
        end;
        else Begin
          gifPosition(cbGifLocation.ItemIndex);
          {pngRange := drawbBox(seRangeMinX.AsInteger,(sbGif.Height div 2),
                      seRangeMaxX.AsInteger,30,
                      seGifSize.AsInteger,gif,pngRange,sbGif,'\attRangeX.png',-1,false);}
        end;
      end;
      workingFrame.setRangeX(seRangeMinX.AsInteger,seRangeMaxX.AsInteger,workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      updateEntityDetailFrame(workingFrame);
    end;
  end;
  //memFrameInfo.Lines := workingFrame.header;
end;

procedure TfrmCharacterEditor.Add6Click(Sender: TObject);
Var
  s: string;
begin
  if seRangeMinX.Font.Color = config.hasValue then
    ShowMessage('All ready contains a range set!')
  else Begin
    s := #09 + 'range' + #09 + '0 0';
    workingFrame.header.Insert(0,s);
    workingFrame.rangeMinX := 0;
    workingFrame.rangeMaxX := 0;
    seRangeMinX.Font.Color := config.hasValue;
    seRangeMaxX.Font.Color := config.hasValue;

    memFrameInfo.Lines.Text := workingFrame.header.Text;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.Remove5Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
begin
  if seRangeMinX.Font.Color = config.noValue then
    ShowMessage('Contains no offset to remove!')
  else Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if isRangeX(s) = true then Begin
        workingFrame.header.Delete(i);
        i := workingFrame.header.Count;
        isLoading := True;
        seRangeMinX.AsInteger := 0;
        seRangeMaxX.AsInteger := 0;
        isLoading := false;
        seRangeMinX.Font.Color := config.noValue;
        seRangeMaxX.Font.Color := config.noValue;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.seRangeMinAChange(Sender: TObject);
Var
  pData : panimeEntityList;
  aFrame : TEntityDetailFrames;
begin
  if isLoading = false then Begin
    if (sender as TJvSpinEdit).Font.Color = config.noValue then
      showMessageStatus('Please add a offSet using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      //setOffset(seOffSetX.AsInteger,seOffSetY.AsInteger,gif);
      case cbGifLocation.ItemIndex of
        0:
            gifPosition(cbGifLocation.ItemIndex);
             {pngRange := drawbBox(seRangeMinX.AsInteger,(sbGif.Height div 2),
                      seRangeMaxX.AsInteger,30,
                      seGifSize.AsInteger,gif,pngRange,sbGif,'\attRangeX.png',-1,false);}
        {
      pngOffset := drawoBox(seOffSetX.AsInteger,seOffSetY.AsInteger,
                  seGifSize.AsInteger,gif,pngOffset,sbGif,getOffSetImage(cbOffSet.ItemIndex));//config.ofSetImage);}
        1: Begin
             gifPosition(cbGifLocation.ItemIndex);
        end;
        else Begin
          gifPosition(cbGifLocation.ItemIndex);
          {pngRange := drawbBox(seRangeMinX.AsInteger,(sbGif.Height div 2),
                      seRangeMaxX.AsInteger,30,
                      seGifSize.AsInteger,gif,pngRange,sbGif,'\attRangeX.png',-1,false);}
        end;
      end;
      workingFrame.setRangeA(seRangeMinA.AsInteger,seRangeMaxA.AsInteger,workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      updateEntityDetailFrame(workingFrame);
    end;
  end;
  //memFrameInfo.Lines := workingFrame.header;
end;

procedure TfrmCharacterEditor.MenuItem1Click(Sender: TObject);
Var
  s: string;
begin
  if seRangeMinA.Font.Color = config.hasValue then
    ShowMessage('All ready contains a range set!')
  else Begin
    s := #09 + 'rangea' + #09 + '0 0';
    workingFrame.header.Insert(0,s);
    workingFrame.rangeMinA := 0;
    workingFrame.rangeMaxA := 0;
    seRangeMinA.Font.Color := config.hasValue;
    seRangeMaxA.Font.Color := config.hasValue;

    memFrameInfo.Lines.Text := workingFrame.header.Text;
    updateEntityDetailFrame(workingFrame);
  end;
end;

procedure TfrmCharacterEditor.MenuItem2Click(Sender: TObject);
Var
  i : integer;
  s, f : string;
begin
  if seRangeMinA.Font.Color = config.noValue then
    ShowMessage('Contains no offset to remove!')
  else Begin
    i := 0;
    while i < workingFrame.header.Count do Begin
      s := workingFrame.header.Strings[i];
      if isRangeA(s) = true then Begin
        workingFrame.header.Delete(i);
        i := workingFrame.header.Count;
        isLoading := True;
        seRangeMinA.AsInteger := 0;
        seRangeMaxA.AsInteger := 0;
        isLoading := false;
        seRangeMinA.Font.Color := config.noValue;
        seRangeMaxA.Font.Color := config.noValue;
        memFrameInfo.Lines.Text := workingFrame.header.Text;
        updateEntityDetailFrame(workingFrame);
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.gifMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels[0].Text := 'X: ' + IntToStr(x div seGifSize.AsInteger) + ' Y: ' + IntToStr(Y div seGifSize.AsInteger);
  If (ssCtrl in Shift) then
    popAddSetBox1.Click;
  If (ssSHIFT in Shift) then
    AttackBox1.Click;

    if beginDraging = 1  then
      if (beginDragingx > 0) or
         (beginDragingy > 0) then begin
           if pngbBox <> nil then
             pngbBox.Visible := true;

        seBBxX.Value := (beginDragingx / seGifSize.Value);
        seBBxY.Value := (beginDragingy / seGifSize.Value);
        seBBxW.Value := (X / seGifSize.Value) - (beginDragingx / seGifSize.Value) ;
        seBBxH.Value := (Y / seGifSize.Value) - (beginDragingy / seGifSize.Value) ;
        Application.ProcessMessages;
      end;

    if beginDraging = 2  then
      if (beginDragingx > 0) or
         (beginDragingy > 0) then begin
           if pngAttBox <> nil then
             pngAttBox.Visible := true;

        seAttckBoxX.Value := (beginDragingx / seGifSize.Value);
        seAttckBoxY.Value := (beginDragingy / seGifSize.Value);
        seAttckBoxW.Value := (X / seGifSize.Value) - (beginDragingx / seGifSize.Value) ;
        seAttckBoxH.Value := (Y / seGifSize.Value) - (beginDragingy / seGifSize.Value) ;
        Application.ProcessMessages;
      end;

      //pngbBox.Left := beginDragingx + gif.Left;
      //pngbBox.Top := beginDragingy + gif.Top;
      //pngbBox.Width := X + gif.Left;
      //pngbBox.Height := Y + gif.Height;
      //pngbBox.Left := (beginDragingx + gif.Left) div seGifSize.AsInteger;//trunc(beginDragingx + gif.Left / seGifSize.value) ;
      //pngbBox.Top := (beginDragingy + gif.top) div seGifSize.asInteger;
      //pngbBox.Width := trunc((X div seGifSize.asInteger) - (beginDragingx / seGifSize.Value)) + gif.Left;
      //pngbBox.Height := trunc((Y div seGifSize.asInteger) - (beginDragingy / seGifSize.Value)) + gif.top;
    //end;
  {If (ssAlt in Shift) then
    Exit;
  If (ssSHIFT in Shift) then
    Exit;}
end;

procedure TfrmCharacterEditor.cbAttackNameChange(Sender: TObject);
begin
  if isLoading = false then Begin
    if (sender as TComboBox).Font.Color = config.noValue then
      showMessageStatus('Please add a attack box set using the drop down menu to the right or manually edit it in the command box below.')
    else Begin
      workingFrame.setAttackBox(seAttckBoxX.AsInteger, seAttckBoxY.AsInteger, seAttckBoxw.AsInteger,seAttckBoxh.AsInteger,
      seatDamage.AsInteger,seatPower.AsInteger,Bool2Int(cbatFlash.Checked),Bool2Int(cbatBlockable.Checked),seatPause.AsInteger,
      seatDepth.AsInteger,cbAttackName.Text,workingFrame.header);
      memFrameInfo.Lines := workingFrame.header;
      //attBoxGif := setAttBox(seAttckBoxX.AsInteger,seAttckBoxY.AsInteger,seAttckBoxW.AsInteger,seAttckBoxH.AsInteger, seGifSize.AsInteger,gif, attBoxGif,sbGif);
      pngAttBox := drawbBox(seAttckBoxX.AsInteger,seAttckBoxY.AsInteger,
                      seAttckBoxW.AsInteger,seAttckBoxH.AsInteger,
                      seGifSize.AsInteger,gif,pngAttBox,sbGif,'\attBox1.png',2);
      updateEntityDetailFrame(workingFrame);
    end;
  end;
end;

procedure TfrmCharacterEditor.cbOffSetCloseUp(Sender: TObject);
Var
  aFrm : TfrmGifList;
begin
  try
    isLoading := true;
    //gifLoad(workingFrame.frameFile,gif,workingFrame,true);
    //gifPosition(cbGifLocation.ItemIndex);
    //updateVisuals;
    aFrm := frameGetByFrameNumber(seCurrentFrame.AsInteger);
    if aFrm <> nil then Begin
      aFrm.gifClick(aFrm.gif);
    end;
    config.OffsetPic := cbOffSet.ItemIndex;
  finally
    isLoading := false;
  end;
end;

procedure TfrmCharacterEditor.FormShow(Sender: TObject);
begin
  cbGifLocation.ItemIndex := config.gifLocation;
  cbOffSet.ItemIndex := config.OffsetPic;
  cbListbBox.Checked := config.bBoxInList;
  if form1.models <> nil then
    if form1.models.listEntities <> nil then
      cmbOverlay.Items := form1.models.listEntities;
end;

procedure TfrmCharacterEditor.cbListbBoxClick(Sender: TObject);
begin
  
  config.bBoxInList := cbListbBox.Checked;
end;

procedure TfrmCharacterEditor.seOffSetXKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and
     (key = VK_LEFT) then
     SettoPrevious1.Click;
  if (ssCtrl in Shift) and
     (key = VK_RIGHT) then
     SettoNext1.Click;
end;

procedure TfrmCharacterEditor.seMoveXKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and
     (key = VK_LEFT) then
     SetfromPrevious1.Click;
  if (ssCtrl in Shift) and
     (key = VK_RIGHT) then
     SetfromNext1.Click;
end;

procedure TfrmCharacterEditor.seBBxXKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in shift) and
    (ssShift in shift) and
     (key = VK_LEFT) then Begin
    Add3.Click;
    SetfromPrevious2.Click;
  end;
  if (ssCtrl in shift) and
    (ssShift in shift) and
     (key = VK_RIGHT) then Begin
    Add3.Click;
    SetfromNext2.Click
  end;
  if (ssCtrl in Shift) and
     (key = VK_LEFT) then
     SetfromPrevious2.Click;
  if (ssCtrl in Shift) and
     (key = VK_RIGHT) then
     SetfromNext2.Click;

end;

procedure TfrmCharacterEditor.cbAttackNameKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and
     (key = VK_LEFT) then
     SetfromPrevious3.Click;
  if (ssCtrl in Shift) and
     (key = VK_RIGHT) then
     SettoNext2.Click;
end;

procedure TfrmCharacterEditor.drawPlatform(listData: TStringList);
Var
  i : integer;
  s : string;
begin
  i := 0;
  if aWall <> nil then
    FreeAndNil(aWall);
  if pnlWall <> nil then
    pnlWall.Visible := false;
  while i < listData.Count do Begin
    s := strClearAll(listData.Strings[i]);
    if PosStr('platform',s) > 0 then Begin
      s := strip2Bar('platform',s);
        aWall := TLvlWall.create(s);
        if pnlWall = nil then Begin
          pnlWall := TJvPanel.Create(sbgif);
          pnlWall.Parent := sbgif;
          pnlWall.Align := alClient;
          pnlWall.FlatBorder := true;
          pnlWall.Transparent := true;
          pnlWall.OnPaint := JvPanel1Paint;
        end;
        pnlWall.Width := gif.Width;
        pnlWall.Height := gif.Height;
        pnlWall.Repaint;
        pnlWall.Visible := true;

    end;
    inc(i);
  end;
end;

procedure TfrmCharacterEditor.JvPanel1Paint(Sender: TObject);
begin
  if aWall <> nil then Begin
    if pnlWall <> nil then
      pnlWall := paintWall2(pnlWall,
                  gif.Left + (aWall.xPos * seGifSize.AsInteger),
                  gif.Top + (aWall.yPos * seGifSize.AsInteger),
                  aWall.upperLeft * seGifSize.AsInteger,
                  aWall.LowerLeft * seGifSize.AsInteger,
                  aWall.UpperRight * seGifSize.AsInteger,
                  aWall.LowerRight * seGifSize.AsInteger,
                  aWall.Depth * seGifSize.AsInteger,
                  aWall.height * seGifSize.AsInteger);

end;

end;


procedure TfrmCharacterEditor.sbGifEnter(Sender: TObject);
begin
  if pnlWall <> nil then
    pnlWall.Repaint;
end;

procedure TfrmCharacterEditor.LinkFiles1Click(Sender: TObject);
var
  aList : TStringList;
begin
  if isNodeDetails(vstAnimList.FocusedNode) then exit;
  OpenDialog1.Options := OpenDialog1.Options + [ofAllowMultiSelect];
  if OpenDialog1.Execute then Begin
    aList := TStringList.Create;
    aList.Sorted := true;
    aList.Text := OpenDialog1.Files.Text;
    aList.Sort;
    importFileList(aList,false);
    aList.Free;
  end;
end;

procedure TfrmCharacterEditor.popAddSetBox1Click(Sender: TObject);


begin
  btnExecuteBor.Font.Color := clBlue;
  Add3.Click;
  beginDragingx := 0;
  beginDragingy := 0;
  beginDraging := 1;

  alldrag(true);
  

end;



procedure TfrmCharacterEditor.gifMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if beginDraging > 0 then begin
    beginDragingx := x;
    beginDragingy := y;
  end;
end;

procedure TfrmCharacterEditor.gifMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    endDragingx := x;
    endDragingy := y;
  if beginDraging = 1 then begin
    Add3.Click;
    seBBxX.Value := (beginDragingx / seGifSize.Value);
    seBBxY.Value := (beginDragingy / seGifSize.Value);
    seBBxW.Value := (endDragingx / seGifSize.Value) - (beginDragingx / seGifSize.Value);
    seBBxH.Value := (endDragingy / seGifSize.Value) - (beginDragingy / seGifSize.Value);
    alldrag(false);
    beginDraging := -1;
  end;
  if beginDraging = 2 then begin

    endDragingx := x;
    endDragingy := y;
    Add4.Click;
    seAttckBoxX.Value := (beginDragingx / seGifSize.Value);
    seAttckBoxY.Value := (beginDragingy / seGifSize.Value);
    seAttckBoxW.Value := (endDragingx / seGifSize.Value) - (beginDragingx / seGifSize.Value);
    seAttckBoxH.Value := (endDragingy / seGifSize.Value) - (beginDragingy / seGifSize.Value);

    alldrag(false);

    beginDraging := -1;
  end;
  if beginDraging = 3 then begin //Off-Set

    endDragingx := x;
    endDragingy := y;
    Add1.Click;
    seOffSetX.Value := beginDragingx / seGifSize.Value;
    seOffSetY.Value := beginDragingy / seGifSize.Value;

    alldrag(false);

    beginDraging := -1;
  end;


  //seBBxW.Value := (beginDragingx / seGifSize.Value) + (endDragingx / seGifSize.Value);
  //seBBxH.Value := (beginDragingy / seGifSize.Value) + (endDragingy / seGifSize.Value);
end;

procedure TfrmCharacterEditor.alldrag(Draggin: boolean);
begin
  if Draggin = true then begin
    Screen.Cursor := crDrag;

    if pngbBox <> nil then
      pngbBox.Visible := false;
    if pngAttBox <> nil then
      pngAttBox.Visible := false;
    if pngOffset  <> nil then
      pngOffset.Visible := false;
    if pngRange  <> nil then
      pngRange.Visible := false;

  end else begin
    btnExecuteBor.Font.Color := clBlack;
    Screen.Cursor := crDefault;
    if (seBBxX.AsInteger <> 0) or
       (seBBxY.AsInteger <> 0) or
       (seBBxW.AsInteger <> 0) or
       (seBBxH.AsInteger <> 0) then
      if pngbBox <> nil then
        pngbBox.Visible := true;
    if (seAttckBoxX.AsInteger <> 0) or
       (seAttckBoxY.AsInteger <> 0) or
       (seAttckBoxW.AsInteger <> 0) or
       (seAttckBoxH.AsInteger <> 0) then
      if pngAttBox <> nil then
        pngAttBox.Visible := true;
    if pngOffset  <> nil then
      pngOffset.Visible := true;
    if (seRangeMaxX.AsInteger <> 0) or
       (seRangeMaxA.AsInteger <> 0) then
        if (pngRange <> nil) then
          pngRange.Visible := True;
  end;
end;

procedure TfrmCharacterEditor.btnExecuteBorClick(Sender: TObject);
begin
  popAddSetBox1.Click;
end;

procedure TfrmCharacterEditor.sbGifMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  If (ssCtrl in Shift) then
    popAddSetBox1.Click;
  If (ssSHIFT in Shift) then
    AttackBox1.Click;
  {If (ssAlt in Shift) then
    Exit;
  }
end;

procedure TfrmCharacterEditor.AttackBox1Click(Sender: TObject);
begin
  btnExecuteBor.Font.Color := clRed;
  Add4.Click;
  beginDragingx := 0;
  beginDragingy := 0;
  beginDraging := 2;

  alldrag(true);
end;

procedure TfrmCharacterEditor.AsEntity1Click(Sender: TObject);
Var
  pData : panimeEntityList;
  exportList : TStringList;
  i : integer;
  s : string;
begin
  i := 0;
  //TODO: Export to file
  pData := vstAnimList.GetNodeData(vstAnimList.FocusedNode);
  //pData.entityHeader
  //exportList
end;

procedure TfrmCharacterEditor.ToolButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then Begin
    loadCharacterEntityFile(OpenDialog1.FileName);
  end;
end;

procedure TfrmCharacterEditor.findframeineditor( framenumber:integer);
var
  s : string;
  i, framefound : integer;
begin
  if JvPageControl1.ActivePageIndex = 1 then Begin
    framefound := 0;
    i := 0;
    while i < frameEditor.SynEdit1.Lines.Count do begin
      s := LowerCase(frameEditor.SynEdit1.Lines.Strings[i]);
      if (PosStr('frame',s) > 0) and
         (PosStr('landframe',s) = 0) then Begin
        inc(framefound);
      end;
      if (framefound = framenumber) then Begin

        frameEditor.SynEdit1.CaretY := i+1;
        //frameEditor.SynEdit1.SelStart := i;
        //frameEditor.SynEdit1.SelEnd := i;
        i := frameEditor.SynEdit1.Lines.Count;
        //frameEditor.SynEdit1.Lines[i].Count
      end;
      inc(i);
    end;
  end;
end;

procedure TfrmCharacterEditor.showOverlay(entityName: string; x:integer; y:integer; reloadAnim:boolean; reshape:boolean);
Var
  idleImage, s, s2 : string;
  idleOffsetX, idleOffsetY : integer;
  i, j : integer;
  entityData : TEntityDetails;
  entityframes : TEntityDetail;
  eFrame : TEntityDetailFrames;
  irfanViewOptions : TirfanViewOptions;
  irfanView : TirfanView;
  acolor : TColor;
begin
  try
    i := 0;
    if entityName = '' then exit;
    if form1.models.listEntities <> nil then Begin

      entityData := form1.models.getEntityByName(cmbOverlay.Items.Strings[cmbOverlay.ItemIndex]);
      if cboverlayAnim.ItemIndex > -1 then
        entityframes := entityData.getData(cboverlayAnim.Items.Strings[cboverlayAnim.ItemIndex])
      else
        entityframes := entityData.getData('idle');
      if entityframes <> nil then Begin
        eFrame := entityframes.getframebyindex( jvOverlayFrameNumber.AsInteger );
        if eFrame <> nil then Begin
          jvOverlayFrameNumber.MinValue := 0;
          jvOverlayFrameNumber.MaxValue := entityframes.totalFrames-1;

          if reloadAnim = true then begin
              cboverlayAnim.Items.Clear;
              for j := 0 to entityData.list.Count -1 do Begin
                s := entityData.list.Strings[j];
                cboverlayAnim.Items.Add(s);
              end;
              cboverlayAnim.Text := 'idle';
            end;

          if pngOverlay = nil then
            pngOverlay := TImage.Create(nil);

          s := form1.edtDirectory.Text + '\' +  eFrame.frameFile;
          if FileExists(s) then Begin

            if (cbOverlayVFlip.Checked) or
               (cbOverlayHFlip.Checked) then Begin
               irfanViewOptions := TirfanViewOptions.Create;
               irfanViewOptions.vFlip := cbOverlayVFlip.Checked;
               irfanViewOptions.hFlip := cbOverlayHFlip.Checked;
               irfanViewOptions.rotate := jeOverlayLeft.AsInteger;

               irfanViewOptions.sourceFile := s;
               irfanViewOptions.outputFile := config.tempDirectory + '\tmp.gif';
               if reshape = true then
                 irfanView := TirfanView.create(irfanViewOptions,config.iView);
               if FileExists(irfanViewOptions.outputFile) then begin
                 pngOverlay.Picture.LoadFromFile(irfanViewOptions.outputFile);
                 
                 //pngOverlay.Picture.Bitmap.Mask(acolor);
                 //pngOverlay.Picture.Bitmap.
                 //pngOverlay.Picture.Bitmap.MaskHandle

                 //pngOverlay.Transparent := true;
                 //pngOverlay.Picture.Bitmap.TransparentMode := tmFixed;
                 //pngOverlay.Picture.Bitmap.TransparentColor  := clFuchsia;

                 //pngOverlay.Transparent := true;

                 //acolor := getFirstColor(pngOverlay);
                 //pngOverlay.Picture.Bitmap..BkColor :=
                 //pngOverlay.Picture.Bitmap.TransparentColor := acolor;
                 //pngOverlay.Transparent := false;
               end;
            end else //if no converting conditions are required
              pngOverlay.Picture.LoadFromFile(s);
          end;

          pngOverlay.Parent := sbGif;
          pngOverlay.Visible := true;
          pngOverlay.Stretch := true;

          //pngOverlay.Picture.Bitmap.TransparentColor := getFirstColor(pngOverlay);
          pngOverlay.Transparent := true;
          pngOverlay.AutoSize := false;
          pngOverlay.Width  := ( pngOverlay.Picture.Width*seGifSize.AsInteger);
          pngOverlay.Height := ( pngOverlay.Picture.Height*seGifSize.AsInteger);

          pngOverlay.Left := (pngOffset.Left + (pngOffset.Width div 2)) + ( (x- eFrame.offSetX)*seGifSize.AsInteger );
          pngOverlay.Top := (pngOffset.Top + (pngOffset.Height div 2)) - ( (y*seGifSize.AsInteger) + (eFrame.offSetY*seGifSize.AsInteger) );
          pngOverlay.Refresh;
          pngOverlay.Repaint;

        end;
      end;

    end;
    edtOverlayResult.Text := '"' + cmbOverlay.Text + '" ' + IntToStr(seOverlayX.asInteger) + ' ' + IntToStr(seOverlayY.asInteger);
    if irfanViewOptions <> nil then
      FreeAndNil(irfanViewOptions);
    if irfanView <> nil then
      FreeAndNil(irfanView);

  except
  end;
end;

procedure TfrmCharacterEditor.cbOverlayClick(Sender: TObject);
Var
  s :string;
begin
  if cbOverlay.Checked = true then Begin
    if cmbOverlay.ItemIndex > -1 then
      s := cmbOverlay.Items.Strings[cmbOverlay.ItemIndex]
    else
      s := cmbOverlay.Text;
    showOverlay(s,seOverlayX.asinteger,seOverlayY.asinteger)
  end else
    if pngOverlay <> nil then
      pngOverlay.Visible := false;
end;

procedure TfrmCharacterEditor.selectFrame(framename: integer);
Var
  i, iFound : Integer;
  aFrm : TfrmGifList;
begin
  iFound := 0;
  i := 0;
  //Remove if frame
  while i < sbGifList.ComponentCount  do Begin
    if sbGifList.Components[i] is TfrmGifList then Begin
      aFrm := (sbGifList.Components[i] as TfrmGifList);
      if aFrm.edtGifName.Text = IntToStr(framename) then
        aFrm.pnlBottom.Color := clBlue
      else
        aFrm.pnlBottom.Color := clBtnFace;
    end;
    inc(i);
  end;

end;



procedure TfrmCharacterEditor.cmbOverlayChange(Sender: TObject);
Var
  s :string;
begin
  if cbOverlay.Checked = true then Begin
    if cmbOverlay.ItemIndex > -1 then
      s := cmbOverlay.Items.Strings[cmbOverlay.ItemIndex]
    else
      s := cmbOverlay.Text;
    showOverlay(s,seOverlayX.asinteger,seOverlayY.asinteger,true,true)
  end else
    if pngOverlay <> nil then
      pngOverlay.Visible := false;
end;

procedure TfrmCharacterEditor.cboverlayAnimSelect(Sender: TObject);
Var
  s: string;
  idleOffsetX, idleOffsetY : integer;
  i, j : integer;
  entityData : TEntityDetails;
  entityframes : TEntityDetail;
  eFrame : TEntityDetailFrames;
begin
  jvOverlayFrameNumber.AsInteger := 0;
    if cbOverlay.Checked = true then Begin
      if cmbOverlay.ItemIndex > -1 then
        s := cmbOverlay.Items.Strings[cmbOverlay.ItemIndex]
      else
        s := cmbOverlay.Text;
    showOverlay( s,seOverlayX.asinteger,seOverlayY.asinteger,false,true );
  end else
    if pngOverlay <> nil then
      pngOverlay.Visible := false;
end;

procedure TfrmCharacterEditor.cbOverlayVFlipClick(Sender: TObject);
  Var
  s :string;
begin
  if cbOverlay.Checked = true then Begin
    if cmbOverlay.ItemIndex > -1 then
      s := cmbOverlay.Items.Strings[cmbOverlay.ItemIndex]
    else
      s := cmbOverlay.Text;
    showOverlay(s,seOverlayX.asinteger,seOverlayY.asinteger,false,true)
  end else
    if pngOverlay <> nil then
      pngOverlay.Visible := false;
end;

procedure TfrmCharacterEditor.edtOverlayResultEnter(Sender: TObject);
begin
  edtOverlayResult.SelectAll;
  edtOverlayResult.CopyToClipboard;
end;

procedure TfrmCharacterEditor.jvOverlayFrameNumberChange(Sender: TObject);
Var
  s: string;
begin
  if jvOverlayFrameNumber.AsInteger > jvOverlayFrameNumber.MaxValue then
    jvOverlayFrameNumber.Value := jvOverlayFrameNumber.MinValue;
    if cbOverlay.Checked = true then Begin
      if cmbOverlay.ItemIndex > -1 then
        s := cmbOverlay.Items.Strings[cmbOverlay.ItemIndex]
      else
        s := cmbOverlay.Text;
    showOverlay( s,seOverlayX.asinteger,seOverlayY.asinteger,false,true );
  end else
    if pngOverlay <> nil then
      pngOverlay.Visible := false;
end;

procedure TfrmCharacterEditor.OffSet1Click(Sender: TObject);
begin
  btnExecuteBor.Font.Color := clPurple;
  Add1.Click;
  beginDragingx := 0;
  beginDragingy := 0;
  beginDraging := 3;

  alldrag(true);
end;



end.
