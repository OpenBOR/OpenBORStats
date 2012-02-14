unit formLevelDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvExExtCtrls, JvNetscapeSplitter, ComCtrls, ToolWin,
  clsopenBorSystemVst, clsanimeEntityListVst, marioImg, mario,
  clsEntityDetails, unCommon, frameEditor, clsLevelDesign,
  xmlopenBorSystemClass,
  jvStrings, frameGifList,
  formSystemEditor, GIFImage,
  SynEditPythonBehaviour, SynURIOpener, SynEditRegexSearch,
  SynEditMiscClasses, SynEditSearch, SynAutoCorrect, SynEditPrint,
  SynEditPlugins, SynMacroRecorder, SynCompletionProposal,
  SynHighlighterMulti, SynEditCodeFolding, SynUniHighlighter,
  SynEditHighlighter, FTGifAnimate,
  JvExComCtrls, JvToolBar, JvExControls, JvComponent, JvAnimatedImage,
  JvGIFCtrl, VirtualTrees, StdCtrls, Mask, JvExMask, JvSpin, JvgGroupBox,
  JvgScrollBox, Menus, JvArrowButton, pngextra, JvExStdCtrls, JvHtControls,
  JvRichEdit, JvPanel, JvComCtrls, SynHighlighterTeX, SynHighlighterST,
  SynHighlighterCpp, SynEdit, GraphicEx, JvComponentBase, JvBaseDlg,
  JvBrowseFolder, JvGroupBox, JvImage{,

  ImagingTypes,
  Imaging,
  ImagingClasses,
  ImagingComponents,
  ImagingCanvases,
  ImagingUtility}
  ;

  type
  TPal = Array [0..255] of TPaletteEntry;

type
  TfrmLevelDesign = class(TForm)
    pnlEditor: TPanel;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    JvToolBar1: TJvToolBar;
    btnSave: TToolButton;
    StatusBar1: TStatusBar;
    sblevel: TJvgScrollBox;
    pnlLevel: TPanel;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    cbBack: TCheckBox;
    cbPanel: TCheckBox;
    cbFront: TCheckBox;
    cbFocus: TCheckBox;
    cbEntities: TComboBox;
    Entities: TCheckBox;
    JvPanel1: TJvPanel;
    cbHoles: TCheckBox;
    ProgressBar1: TProgressBar;
    popLevel: TPopupMenu;
    StaircaseBuilder1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure cbFocusClick(Sender: TObject);
    procedure sblevelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure JvPanel1Paint(Sender: TObject);
    procedure JvPanel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure StaircaseBuilder1Click(Sender: TObject);


    procedure sblevelDragDrop(Sender, Source: TObject; X, Y: Integer);

    procedure JvPanel1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure JvPanel1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Image1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Image1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);



  private
    { Private declarations }

    bgLayer : TImage;
    fgLayerList, bgLayerList, panelList, entitiesList, frontPanelList : TStringList;
    currentFile : string;
    pnlWall : TJvPanel;
    lastX, lastY : integer;
    function setImage(image:TImage;x,y:Integer;filename:string='';setwidth:boolean=false):TImage;

    procedure drawcanvasline;

    procedure updatebackground;
    procedure drawbackgroundlayer;
    procedure drawpanelLayer;
    procedure drawDrawfrontpanel;
    procedure drawMultipleforegroundlayer;
    procedure drawEntities;
    function drawWalls(prntPanl:TJvPanel):TJvPanel;


    function getBackgroundTotalWidth:integer; overload;
    function getForegroundTotalWidth(addSpaceing:integer=0):integer; overload;
    function getForegroundTotalWidth(bgLayer:integer;addSpaceing:integer=0):integer; overload;
    function getBackgroundTotalWidth(bgLayer:integer):integer; overload;
    function getPanelTotalWidth:integer;
    function getFrontPanelTotalWidth:integer;
    procedure formclear;
  public
    { Public declarations }
    modified : boolean;
    frameEditor : TfrmEditorSyn;
    procedure loadLevelDesignFile(fileName:string);


  end;

var
  frmLevelDesign: TfrmLevelDesign;

implementation
uses
  unMain, formStairs;

{$R *.dfm}

procedure TfrmLevelDesign.formclear;
Var
  i, j :  integer;
  listData : TStringList;
  img : TImage;
begin
  Try
    if frameEditor.nodeEntities <> nil then Begin
      frameEditor.vstEditor.DeleteNode(frameEditor.nodeEntities);
      frameEditor.nodeEntities := nil;
    end;
  except
  end;
  for i := 0 to panelList.Count -1 do Begin
    try
      img := panelList.Objects[i] as TImage;
      img.free;
    except
    end;
  end;
  panelList.Clear;
  for i := 0 to frontPanelList.Count -1 do Begin
    try
      img := frontPanelList.Objects[i] as TImage;
      img.free;
    except
    end;
  end;
  frontPanelList.Clear;
  i := 0;
  while i < bgLayerList.Count do Begin
    listData := bgLayerList.Objects[i] as TStringList;
    for j := 0 to listData.Count -1 do Begin
      try
        img := listData.Objects[j] as TImage;
        img.free;
      except
      end;
    end;
    listData.Free;
    bgLayerList.Delete(i);
  end;
  bgLayerList.Clear;
  //Foreground
  i := 0;
  while i < fgLayerList.Count do Begin
    listData := fgLayerList.Objects[i] as TStringList;
    for j := 0 to listData.Count -1 do Begin
      try
        img := listData.Objects[j] as TImage;
        img.free;
      except
      end;
    end;
    listData.Free;
    fgLayerList.Delete(i);
  end;
  fgLayerList.Clear;
  modified := false;
end;

procedure TfrmLevelDesign.FormCreate(Sender: TObject);
begin
  frameEditor := TfrmEditorSyn.Create(pnlEditor);
  frameEditor.Parent := pnlEditor;
  frameEditor.Align := alClient;
  frameEditor.formCreate;
  frameEditor.JvNetscapeSplitter2.Minimized := true;
  frameEditor.loadEntities := true;
  bgLayerList := TStringList.Create;
  fgLayerList := TStringList.Create;
  panelList := TStringList.Create;
  entitiesList := TStringList.Create;
  frontPanelList := TStringList.Create;
end;

function TfrmLevelDesign.getBackgroundTotalWidth: integer;
var
  i, ireslt : integer;
  img : TImage;
begin
  ireslt := 0;
  for i := 0 to bgLayerList.Count -1 do Begin
    img := bgLayerList.Objects[i] as TImage;
    ireslt := ireslt + img.Picture.Width;
  end;
  result := ireslt;
end;

function TfrmLevelDesign.getFrontPanelTotalWidth: integer;
var
  i, ireslt : integer;
  img : TImage;
begin
  ireslt := 0;
  for i := 0 to frontPanelList.Count -1 do Begin
    img := frontPanelList.Objects[i] as TImage;
    ireslt := ireslt + img.Picture.Width;
  end;
  result := ireslt;
end;

function TfrmLevelDesign.getPanelTotalWidth: integer;
var
  i, ireslt : integer;
  img : TImage;
begin
  ireslt := 0;
  for i := 0 to panelList.Count -1 do Begin
    img := panelList.Objects[i] as TImage;
    ireslt := ireslt + img.Picture.Width;
  end;
  result := ireslt;
end;

procedure TfrmLevelDesign.loadLevelDesignFile(fileName: string);
begin
  formclear;
  currentFile := fileName;
  if ses.currentLeveldesign <> nil then
    ses.currentLeveldesign.Free;
  ses.currentLeveldesign := TLevelDesign.create(fileName);
  frameEditor.SynEdit1.Lines.LoadFromFile(fileName);
  frameEditor.startSectionMode := 0;
  frameEditor.setSectionMode(6);
  frameEditor.populateEntities;
  pnlLevel.Width := 10;
  cbEntities.Items := form1.models.getEntityTypeList;
  case ses.video.videoSize of
    0: pnlLevel.Height := 260;
    1: pnlLevel.Height := 295;
    2: pnlLevel.Height := 500;
    4: pnlLevel.Height := 500;
    5: pnlLevel.Height := 560;
  end;
  ses.currentLeveldesign.refresh(mario.stringsTostringList(frameEditor.SynEdit1.Lines));
  updatebackground;
end;

function TfrmLevelDesign.setImage(image: TImage; x, y: Integer;filename:string;setwidth:boolean): TImage;
//var
//  aa : TColor;
begin
  if image = nil then Begin
    image := TImage.Create(pnlLevel);

  end;
  MatStringDelete2End(filename,' ');
  if FileExists(filename) then Begin
    image.Parent := pnlLevel;
    image.Transparent := True;
    image := registerextlessimag(image);
    image.Picture.LoadFromFile(filename);
    image.Width := image.Picture.Width;
    image.Height := image.Picture.Height;
    image.Transparent := True;
    image.Picture.Graphic.Transparent := True;
    //image.Repaint;
    //aaImage := TImage.Create(nil);
    //aaImage.Picture.LoadFromFile(filename);
    //aa := getFirstColor(Image);
    //image.Picture.Bitmap.TransparentColor := aa;
    //image.Picture.Bitmap.Transparent := True;
  end;
  image.Left := x;
  image.Top := y;
  if image.Height > pnlLevel.Height then
    pnlLevel.Height := image.Height + 10;
  if x > pnlLevel.Width then
    setwidth := true;
  if image.Width > pnlLevel.Width then
    setwidth := true;
  if setwidth = true then
    pnlLevel.Width := pnlLevel.Width + image.Picture.Width;
  //pnlLevel.Height := pnlLevel.Height + image.Picture.Height;
  Result := image;
end;

procedure TfrmLevelDesign.updatebackground;
Var
  i, j, pnlWidth : integer;
  s, s1, panelImage : string;
  aImage : TImage;
  bck : TLvlBackground;
  newList :TStringList;
  FrontPanelTotalWidth : integer;
begin
  if cbBack.Checked then
    drawbackgroundlayer;

  s := ses.currentLeveldesign.order;

  //Draw panel Layer
  if cbPanel.Checked then
    drawpanelLayer;

  //Draw Entity Layer
  if Entities.Checked then
    drawEntities;

  //Draw front panel layer
  if cbFront.Checked then
    drawDrawfrontpanel;

  //Multiple foreground layer method
  if cbFront.Checked then
    drawMultipleforegroundlayer;


  drawcanvasline;

  //drawEntities;
  ProgressBar1.Visible := false;
end;


procedure TfrmLevelDesign.FormClose(Sender: TObject;
  var Action: TCloseAction);
Var
  iAnser : integer;  
begin
  if frameEditor.SynEdit1.Modified = true
   then modified := true;
  if modified = true then
    iAnser := MessageDlg('Level file has been updated! Would you like to save?', mtWarning, [mbYes,mbNo,mbCancel], 0);
  //yes = 6
  //no =  7
  //cancel = 2
  if iAnser = 6 then Begin
    btnSave.Click;
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



  //formclear;
end;

procedure TfrmLevelDesign.btnSaveClick(Sender: TObject);
begin
  frameEditor.SynEdit1.Lines.SaveToFile(currentFile);
  frameEditor.SynEdit1.Modified := false;
  frameEditor.modified := false;
  modified := false;
  showBubble('Save','Succesfully Saved');
end;

procedure TfrmLevelDesign.ToolButton2Click(Sender: TObject);
begin
  try
    ProgressBar1.Position := 0;
    ProgressBar1.Visible := true;
    Screen.Cursor := crHourGlass;
    formclear;
    frameEditor.populateEntities;
    ses.currentLeveldesign.refresh( stringsTostringList(frameEditor.SynEdit1.Lines) );
    updatebackground;
  finally
    ProgressBar1.Visible := false;
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmLevelDesign.cbFocusClick(Sender: TObject);
begin
  frameEditor.cbFocus.Checked := cbFocus.Checked;
end;

procedure TfrmLevelDesign.sblevelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels[0].Text := 'Xpos: ' + IntToStr(X);
  StatusBar1.Panels[1].Text := 'Ypos: ' + IntToStr(Y);
end;

procedure TfrmLevelDesign.Image1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  //fuck
  StatusBar1.Panels[0].Text := 'Xpos: ' + IntToStr(X);
  StatusBar1.Panels[1].Text := 'Ypos: ' + IntToStr(Y);
end;

function TfrmLevelDesign.getBackgroundTotalWidth(
  bgLayer: integer): integer;
var
  i, ireslt : integer;
  img : TImage;
  listData : TStringList;
begin
  ireslt := 0;
  listData := bgLayerList.objects[bgLayer] as TStringList;
  for i := 0 to listData.Count -1 do Begin
    img := listData.Objects[i] as TImage;
    ireslt := ireslt + img.Picture.Width;
  end;
  result := ireslt;
end;

procedure TfrmLevelDesign.drawEntities;
Var
  i : integer;
  img : TImage;
  spwn : TLvlSpawn;
  entity : TEntityDetails;
  offset, s : string;
  offX, offY : integer;
begin
  //Draw Entities Layer
  for i := 0 to entitiesList.Count -1 do Begin
    try
      img := entitiesList.Objects[i] as TImage;
      img.free;
    except
    end;
  end;
  entitiesList.Clear;
  if Entities.Checked = false then Begin
    exit;
  end;
  for i := 0 to ses.currentLeveldesign.spawnList.Count -1 do Begin
    try
      ProgressBar1.Position := ProgressBar1.Position + 1;
      //Application.ProcessMessages;
      spwn := ses.currentLeveldesign.spawnList.objects[i] as TLvlSpawn;
      entity := Form1.models.getEntityByName(spwn.spName);
      if entity <> nil then Begin
        img := TImage.Create(pnlLevel);

        offset := strClearAll(entity.getIdleImageOffset);
        s := strip2Bar('offset',offset);
        StringDelete2End(s,' ');
        offX := StrToInt(s);
        s := strip2Bar('offset',offset);
        StringDeleteUp2(s,' ');
        offY := StrToInt(s);
        img := setImage( img,((spwn.coX+spwn.coAt)-offX ),(spwn.coY -offY),ses.dataDirecotry+'\'+entity.getIdleImage,true );

        //I think because the image is not a bmp the tcolor is read only and can't be set...very sad
        //img.Picture.Bitmap.TransparentColor := getFirstColor(img);
        //img.Picture.Bitmap.TransparentMode := tmFixed;
        //img.Picture.Bitmap.Transparent := true;

        img.DragMode := dmAutomatic;
        img.DragKind := dkDrag;
        img.OnDragOver := Image1DragOver;
        img.OnDragDrop := Image1DragDrop;
        img.OnMouseDown := Image1MouseDown;
        img.Tag := i;

        entitiesList.AddObject( IntToStr(entitiesList.Count),img );
      end;
    except
    end;
  end;
end;

procedure TfrmLevelDesign.drawcanvasline;
var
  aimg : TImage;


  //TImagingBitmap.Create;
begin
  if pnlWall <> nil then
    FreeAndNil(pnlWall);
  if pnlWall = nil then
    pnlWall := TJvPanel.Create(pnlLevel);

  pnlWall.Parent := pnlLevel;
  pnlWall.Align := alClient;
  pnlWall.Transparent := True;

  pnlWall.DragMode := dmAutomatic;
  pnlWall.DragKind := dkDrag;

  //pnlWall.DockSite := true;
  pnlWall.DragCursor := crDrag;

  pnlWall.OnPaint := JvPanel1Paint;
  pnlWall.OnMouseMove := JvPanel1MouseMove;
  pnlWall.OnDragDrop := JvPanel1DragDrop;
  pnlWall.OnDragOver := JvPanel1DragOver;
  {
  // Set the red color to the pen of the convas
    Canvas.Pen.Color := clRed;
    // Start the line on the previous point we reserved
    Canvas.MoveTo(StartX, StartY);
    // End the line on the current point
    Canvas.LineTo(X, Y);

  }

end;

procedure TfrmLevelDesign.JvPanel1Paint(Sender: TObject);
begin

 {(sender as TJvPanel).Canvas.Pen.Color := config.penColor;
 //psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear,   psInsideFrame
 (sender as TJvPanel).Canvas.Pen.Style := psDash;
 (sender as TJvPanel).Canvas.Pen.Width := config.penWidth;
 (sender as TJvPanel).Canvas.MoveTo(10,10);
 (sender as TJvPanel).Canvas.LineTo(100,100);}
 if cbHoles.Checked = true then begin
   if pnlWall <> nil then
     pnlWall := drawWalls(sender as TJvPanel);
 end;

end;

procedure TfrmLevelDesign.JvPanel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  lastX := x;
  lastY := y;
  StatusBar1.Panels[0].Text := 'Xpos: ' + IntToStr(X);
  StatusBar1.Panels[1].Text := 'Ypos: ' + IntToStr(Y);
end;

function TfrmLevelDesign.drawWalls(prntPanl:TJvPanel):TJvPanel;
var
  i : integer;
  aWall : TLvlWall;
  x,y,w,h,depth : integer;
begin
  for i := 0 to ses.currentLeveldesign.wallsList.Count -1 do Begin
    try
    aWall := ses.currentLeveldesign.wallsList.Objects[i] as TLvlWall;
    //{xpos} {ypos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{alt}
    if aWall <> nil then Begin
      x := aWall.xPos - aWall.LowerLeft;
      y := aWall.yPos - aWall.upperLeft;
      w := aWall.LowerLeft + aWall.LowerRight;
      h := aWall.height;
      depth := aWall.Depth;
      //prntPanl := paintWall(prntPanl,x,y,w,h,depth);
      if prntPanl <> nil then
        prntPanl := paintWall2(prntPanl,aWall.xPos,aWall.yPos,aWall.upperLeft,aWall.LowerLeft,aWall.UpperRight,aWall.LowerRight,aWall.Depth,aWall.height);
    end;
    except
    end;
  end;
  for i := 0 to ses.currentLeveldesign.holesList.Count -1 do Begin
    try
    aWall := ses.currentLeveldesign.holesList.Objects[i] as TLvlWall;
    //{xpos} {ypos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{alt}
    if aWall <> nil then Begin
      x := aWall.xPos - aWall.LowerLeft;
      y := aWall.yPos - aWall.upperLeft;
      w := aWall.LowerLeft + aWall.LowerRight;
      h := aWall.height;
      depth := aWall.Depth;
      //prntPanl := paintWall(prntPanl,x,y,w,h,depth);
      if prntPanl <> nil then
        prntPanl := paintWall2(prntPanl,aWall.xPos,aWall.yPos,aWall.upperLeft,aWall.LowerLeft,aWall.UpperRight,aWall.LowerRight,aWall.Depth,aWall.height);
    end;
    except
    end;
  end;
  prntPanl.PopupMenu := popLevel;
  Result := prntPanl;
end;



function TfrmLevelDesign.getForegroundTotalWidth(addSpaceing:integer): integer;
var
  i, ireslt : integer;
  img : TImage;
begin
  ireslt := 0;
  for i := 0 to fgLayerList.Count -1 do Begin
    img := fgLayerList.Objects[i] as TImage;
    ireslt := ireslt + img.Picture.Width+addSpaceing;
  end;
  result := ireslt;
end;

function TfrmLevelDesign.getForegroundTotalWidth(
  bgLayer: integer;addSpaceing:integer): integer;
var
  i, ireslt : integer;
  img : TImage;
  listData : TStringList;
begin
  ireslt := 0;
  listData := fgLayerList.objects[bgLayer] as TStringList;
  for i := 0 to listData.Count -1 do Begin
    img := listData.Objects[i] as TImage;
    ireslt := ireslt + img.Picture.Width + addSpaceing;
  end;
  result := ireslt;
end;

procedure TfrmLevelDesign.StaircaseBuilder1Click(Sender: TObject);
Var
  s : string;
  i : integer;
begin
  frmStairs.spnX.AsInteger := lastX;
  frmStairs.spnY.AsInteger := lastY;
  frmStairs.ShowModal;
  i := frmStairs.rsltList.Count -1;
  if frmStairs.rsltList.Count > 0 then begin
    //for i := (frmStairs.rsltList.Count -1) to 0  do Begin
    while i >= 0 do begin
      s := frmStairs.rsltList.Strings[i];
      frameEditor.SynEdit1.Lines.Insert(frameEditor.SynEdit1.CaretY-1,s);
      i := i - 1;
      //SynEdit1.Lines.Strings[SynEdit1.CaretY-1];
    end;
  end;
end;



procedure TfrmLevelDesign.sblevelDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AttachMode: TVTNodeAttachMode;
  pData : popenBorSystem;
begin
  lastX := x;
  lastY := y;
  StatusBar1.Panels[0].Text := 'Xpos: ' + IntToStr(X);
  StatusBar1.Panels[1].Text := 'Ypos: ' + IntToStr(Y);

  AttachMode := amInsertBefore;
  pData := frameEditor.vstEditor.GetNodeData(frameEditor.vstEditor.FocusedNode);

  showmessage(pData.title);

end;





procedure TfrmLevelDesign.JvPanel1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  //ShowMessage('sucky');
  lastX := x;
  lastY := y;
  StatusBar1.Panels[0].Text := 'Xpos: ' + IntToStr(X);
  StatusBar1.Panels[1].Text := 'Ypos: ' + IntToStr(Y);
  {
  if sender is TJvPanel then
    Accept := false
  else
    Accept := true;

  if Source.InheritsFrom(TVirtualStringTree) then Begin
    Accept := true;
  end;
  }
  Accept := false;
  if Source is TBaseVirtualTree then
    Accept := true ;
  if Source is TImage then
      Accept := true;
  {
  if Source is TVirtualTreeClass then
    Accept := true;

  if Source is TVirtualStringTree then
    Accept := true;

  if Source is TNode then
    Accept := true;

  if Source is TVTDataObject then
    Accept := true;

  if Source is TVirtualDrawTree then
    Accept := true;
  }
end;

procedure TfrmLevelDesign.JvPanel1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  AttachMode: TVTNodeAttachMode;
  pData : popenBorSystem;
begin

  if Source is TBaseVirtualTree then Begin
    AttachMode := amInsertBefore;
    //pData := frameEditor.vstEditor.GetNodeData(frameEditor.vstEditor.FocusedNode);
    pData := (source as TBaseVirtualTree).GetNodeData((source as TBaseVirtualTree).FocusedNode);

    frameEditor.SynEdit1.Lines.Add( 'spawn ' + pData.title );
    frameEditor.SynEdit1.Lines.Add( 'coords	0 '+ IntToStr(y)+' 1' );
    frameEditor.SynEdit1.Lines.Add( 'at ' + IntToStr(x) );

    ToolButton2.Click;
  end;
  //coords	380 260 200
  //at      550
  //ShowMessage(pData.title);
end;

procedure TfrmLevelDesign.Image1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
 //
 showBubble('DragOver','x' + IntToStr(X) + 'y' + IntToStr(Y),1000);
end;

procedure TfrmLevelDesign.Image1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  //w
end;

procedure TfrmLevelDesign.Image1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  showBubble('MouseDown','clicked',1000);
end;

procedure TfrmLevelDesign.drawMultipleforegroundlayer;
var
  i, j, pnlWidth : integer;
  nextX:integer;
  s, s1, panelImage : string;
  aImage : TImage;
  bck : TLvlBackground;
  newList :TStringList;
  FrontPanelTotalWidth : integer;
begin
  if cbFront.Checked = true then
  for i := 0 to ses.currentLeveldesign.FrontPanelListing.Count -1 do begin
    try
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;
      bck := ses.currentLeveldesign.FrontPanelListing.objects[i] as TLvlBackground;
      newList := TStringList.Create;
      fgLayerList.AddObject(IntToStr(fgLayerList.Count),newList);

      if bck.xRepeat < 1 then Begin
        while (getForegroundTotalWidth(i,bck.xSpacing) < ses.currentLeveldesign.atMax) and
            (FileExists(ses.dataDirecotry+'\'+(bck.imageFile))) do Begin
             aImage := TImage.Create(pnlLevel);
             //aImage.OnMouseMove := Image1MouseMove;
             aImage := setImage(aImage,getForegroundTotalWidth(i,bck.xSpacing)+bck.xPosition,0+bck.yPosition,ses.dataDirecotry+'\'+(bck.imageFile));

             //aImage.Picture.Bitmap.TransparentColor := getFirstColor(aImage);

             newList.AddObject(IntToStr(newList.Count),aImage);
        end;
      end else Begin

        for j := 0 to Trunc(bck.xRepeat) -1 do Begin
          aImage := TImage.Create(pnlLevel);
           //aImage.OnMouseMove := Image1MouseMove;
           aImage := setImage(aImage,getForegroundTotalWidth(i,bck.xSpacing)+bck.xPosition,0+bck.yPosition,ses.dataDirecotry+'\'+(bck.imageFile));

           //aImage.Picture.Bitmap.TransparentColor := getFirstColor(aImage);

            {//set drag drop properties
            aImage.DragMode := dmAutomatic;
            aImage.DragKind := dkDrag;
            aImage.OnDragOver := Image1DragOver;
            aImage.OnDragDrop := Image1DragDrop;
            }

           newList.AddObject(IntToStr(newList.Count),aImage);
        end;
      end;
    except
    end;
  end;
end;

procedure TfrmLevelDesign.drawDrawfrontpanel;
var
  i, j, pnlWidth : integer;
  nextX:integer;
  s, s1, panelImage : string;
  aImage : TImage;
  bck : TLvlBackground;
  newList :TStringList;
  FrontPanelTotalWidth : integer;
begin
  if cbFront.Checked = true then
  if ses.currentLeveldesign.frontPanelList.Count > 0 then
    ProgressBar1.Position := ProgressBar1.Position + 1;
    Application.ProcessMessages;
    j := pnlLevel.Width;
    while (getFrontPanelTotalWidth < j)  do Begin
      FrontPanelTotalWidth := getFrontPanelTotalWidth;
      for i := 0 to ses.currentLeveldesign.frontPanelList.Count -1  do Begin
        try
          if FileExists(ses.dataDirecotry+'\'+(ses.currentLeveldesign.frontPanelList.Strings[i])) then Begin
            aImage := TImage.Create(pnlLevel);
            //aImage.OnMouseMove := Image1MouseMove;
            aImage := setImage(aImage,getFrontPanelTotalWidth,0,ses.dataDirecotry+'\'+(ses.currentLeveldesign.frontPanelList.Strings[i]),false);

            //aImage.Picture.Bitmap.TransparentColor := getFirstColor(aImage);

            {//set drag drop properties
            aImage.DragMode := dmAutomatic;
            aImage.DragKind := dkDrag;
            aImage.OnDragOver := Image1DragOver;
            aImage.OnDragDrop := Image1DragDrop;
            }
            frontPanelList.AddObject(IntToStr(frontPanelList.Count),aImage);
            if aImage <> nil then begin
              if aImage.Picture.Width = 0 then
                j := -1;
            end else
              j := -1;
          end;
        except
        end;

      end;
      if FrontPanelTotalWidth = getFrontPanelTotalWidth then
          j := -1;
    end;
end;

procedure TfrmLevelDesign.drawpanelLayer;
var
  i, j, pnlWidth : integer;
  nextX:integer;
  s, s1, panelImage : string;
  aImage : TImage;
  bck : TLvlBackground;
  newList :TStringList;
  FrontPanelTotalWidth : integer;
  apal : HPalette;
begin
  s := ses.currentLeveldesign.order;
  if cbPanel.Checked = true then
  while length(s) > 0 do Begin
    try
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;
      s1 := s[1];
      delete(s,1,1);
      panelImage := ses.currentLeveldesign.getPanelByLetter(s1);
      aImage := TImage.Create(pnlLevel);
      //aImage.OnMouseMove := Image1MouseMove;
      pnlWidth := getPanelTotalWidth;
      if pnlLevel.Width < pnlWidth then
        aImage := setImage(aImage,pnlWidth,0,ses.dataDirecotry+'\'+panelImage,true)
      else
        aImage := setImage(aImage,pnlWidth,0,ses.dataDirecotry+'\'+panelImage,false);

      //aImage.Picture.Bitmap.TransparentColor := getFirstColor(aImage);

      //TransparentColor := clMaroon;
      //TransparentMode := tmFixed;
      panelList.AddObject(IntToStr(panelList.Count),aImage);
    except
    end;
  end;
end;

procedure TfrmLevelDesign.drawbackgroundlayer;
var
  i, j, pnlWidth : integer;
  nextX:integer;
  s, s1, panelImage : string;
  aImage : TImage;
  bck : TLvlBackground;
  newList :TStringList;
  FrontPanelTotalWidth : integer;
begin
  //Draw background layer
  ProgressBar1.Position := 0;
  ProgressBar1.Max := ses.currentLeveldesign.backGroundList.count
                    + length(ses.currentLeveldesign.order)
                    + ses.currentLeveldesign.frontPanelList.Count
                    + ses.currentLeveldesign.spawnList.Count
                    + ses.currentLeveldesign.FrontPanelListing.Count;
  if cbBack.Checked = true then
  //Multiple background layer method
  for i := 0 to ses.currentLeveldesign.backGroundList.Count -1 do begin
    try
      ProgressBar1.Position := ProgressBar1.Position + 1;
      Application.ProcessMessages;
      bck := ses.currentLeveldesign.backGroundList.objects[i] as TLvlBackground;
      newList := TStringList.Create;
      bgLayerList.AddObject(IntToStr(bgLayerList.Count),newList);
      if bck.xRepeat < 1 then Begin
      while (getBackgroundTotalWidth(i) < ses.currentLeveldesign.atMax) and
          (FileExists(ses.dataDirecotry+'\'+(bck.imageFile))) do Begin
           aImage := TImage.Create(pnlLevel);
           //aImage.OnMouseMove := Image1MouseMove;
           aImage := setImage(aImage,getBackgroundTotalWidth(i)+bck.xPosition,0+bck.yPosition,ses.dataDirecotry+'\'+(bck.imageFile));

          // aImage.Picture.Bitmap.TransparentColor := getFirstColor(aImage);

           newList.AddObject(IntToStr(newList.Count),aImage);
      end;
      end else Begin

        for j := 0 to Trunc(bck.xRepeat) -1 do Begin
          aImage := TImage.Create(pnlLevel);
           //aImage.OnMouseMove := Image1MouseMove;
           aImage := setImage(aImage,getBackgroundTotalWidth(i)+bck.xPosition,0+bck.yPosition,ses.dataDirecotry+'\'+(bck.imageFile));

           //aImage.Picture.Bitmap.TransparentColor := getFirstColor(aImage);
            {//set drag drop properties
            aImage.DragMode := dmAutomatic;
            aImage.DragKind := dkDrag;
            aImage.OnDragOver := Image1DragOver;
            aImage.OnDragDrop := Image1DragDrop;
             }
           newList.AddObject(IntToStr(newList.Count),aImage);
        end;
      end;
    except
    end;
  end;
end;

end.