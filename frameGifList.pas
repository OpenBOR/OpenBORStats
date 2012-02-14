unit frameGifList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComponent, JvAnimatedImage, JvGIFCtrl, StdCtrls,
  clsEntityDetails, unCommon, JvStrings, GIFImage,
  ExtCtrls,pngextra, GraphicEx;

type
  TfrmGifList = class(TFrame)
    pnlBottom: TPanel;
    edtGifName: TEdit;
    Panel1: TPanel;
    gif: TImage;
    procedure gif2Click(Sender: TObject);
    procedure PNGButton2Click(Sender: TObject);
    procedure gifClick(Sender: TObject);
  private
    { Private declarations }
    //offSetGif, bBoxGif, attBoxGif : TJvGIFAnimator;
    offSetGif, bBoxGif, attBoxGif : TImage;
    pngbBox, pngAttBox, pngRangx :TPNGButton;
  public
    { Public declarations }
    workingFolder : String;
    workingFrame : TEntityDetailFrames;

    gifWidth : Integer;
    gifHeight : Integer;
    multiply : Integer;

    procedure loadImage(fileName:String;curntFrame : TEntityDetailFrames);
    function updateVisuals(x,y:integer;isRefresh:Boolean=False):integer;
    procedure formStartup(curntFrame : TEntityDetailFrames; workingFrameID:integer;fileName:String;ShowBox:Boolean=False);
  end;

implementation
Uses
  formCharacterEditor,
  unMain;
{$R *.dfm}

{ TfrmGifList }

procedure TfrmGifList.formStartup(curntFrame: TEntityDetailFrames;
  workingFrameID: integer;fileName:String; ShowBox: Boolean);
Var
  gifFile : String;
begin
  gifFile := workingFolder + '\'+ fileName;
  if FileExists(gifFile) then Begin
    //gif.Image.LoadFromFile(gifFile);
    gif.Picture.LoadFromFile(gifFile);
    gif.Width := gif.Picture.Width;
    gif.Height := gif.Picture.Height;
    gifWidth := gif.Picture.Width;
  end;
end;

procedure TfrmGifList.loadImage(fileName: String;curntFrame : TEntityDetailFrames);
Var
  gifFile : String;
begin
  //gifFile := workingFolder + '\'+ fileName;
  try
    multiply := 1;
  except
  end;
  if FileExists(fileName) then Begin
    GifFile := fileName;
  end else Begin
    fileName := strClearAll(fileName);
    //fileName := strRemoveDbls(fileName);
    //fileName := strClearStartEnd(fileName);
    StringReplace(fileName,'data/','');
    StringReplace(fileName,'/','\');
    GifFile := ses.dataDirecotry + '\' + fileName;
  end;
  workingFrame := curntFrame;
  if FileExists(gifFile) then Begin
    gif := registerextlessimag(gif);
    gif.Picture.LoadFromFile(gifFile);
  end else
    gif.Picture.LoadFromFile(config.noImage);
  gif.Width := gif.Picture.Width;
  gif.Height := gif.Picture.Height;
  gifWidth := gif.Picture.Width;
  gifHeight := gif.Picture.Height;

  //gif.Picture.Bitmap.TransparentColor := getFirstColor(gif);
  //gif.Picture.Bitmap.TransparentMode := tmFixed;
end;

procedure TfrmGifList.gif2Click(Sender: TObject);
begin
  try
    if workingFrame <> nil then Begin
      frmCharacterEditor.isLoading := true;
      frmCharacterEditor.gifLoad(workingFrame.frameFile,frmCharacterEditor.gif,workingFrame,True);
      frmCharacterEditor.findframeineditor(StrToInt(edtGifName.Text));
    end;
  finally
    frmCharacterEditor.isLoading := false;
  end;
end;

function TfrmGifList.updateVisuals(x, y: integer;isRefresh:Boolean):integer;
Var
  aVal : integer;
  canShow : Boolean;
begin

  canShow := false;
  while canShow = false do Begin
    if (gif.Height div multiply) > y then Begin
      inc(multiply);
    end else
      canshow := true;
  end;
  Begin
    if isRefresh = false then Begin
      aVal := gif.Picture.Width div multiply;

      gif.Width := aVal;
      aVal := gif.Picture.Height div multiply;
      gif.Height := aVal;
    end;
  end;
  if workingFrame = nil then Begin
    if pngbBox <> nil then
      pngbBox.Visible := false;
    if pngAttBox <> nil then
      pngAttBox.Visible := false;
     if pngRangx <> nil then
      pngRangx.Visible := true; 
  end else Begin
    if frmCharacterEditor.cbListbBox.Checked then Begin
      workingFrame :=  workingFrame.populateAttackBox(workingFrame);
      pngbBox := frmCharacterEditor.drawbBox(workingFrame.bBoxX,workingFrame.bBoxY,workingFrame.bBoxW,workingFrame.bBoxH,multiply,gif,pngbBox,Panel1,'\Box xSml\bBox1.png',-1,false);

      if pngbBox <> nil then
        pngbBox.OnClick := PNGButton2Click;
      pngAttBox := frmCharacterEditor.drawbBox(workingFrame.atBoxX,workingFrame.atBoxY,workingFrame.atBoxW,workingFrame.atBoxH,multiply,gif,pngAttBox,Panel1,'\Box xSml\attBox1.png',-1,false);

      if pngAttBox <> nil then
        pngAttBox.OnClick := PNGButton2Click;

      if pngRangx <> nil then
        pngRangx.OnClick := PNGButton2Click;
      pngRangx := frmCharacterEditor.drawbBox(workingFrame.rangeMinX + workingFrame.offSetX,0,workingFrame.rangeMaxX,20,multiply,gif,pngRangx,Panel1,'\Box xSml\attRangeX.png',-1,false);

    end else Begin
      if bBoxGif <> nil then
        bBoxGif.Visible := false;
      if attBoxGif <> nil then
        attBoxGif.Visible := false;
    end;
  end;
  Result := gif.Width +1;

end;

procedure TfrmGifList.PNGButton2Click(Sender: TObject);
begin
  try
    if workingFrame <> nil then Begin
      frmCharacterEditor.isLoading := true;
      frmCharacterEditor.gifLoad(workingFrame.frameFile,frmCharacterEditor.gif,workingFrame,True);
      frmCharacterEditor.findframeineditor(StrToInt(edtGifName.Text));
      frmCharacterEditor.selectFrame( StrToInt(edtGifName.Text) );
    end;
  finally
    frmCharacterEditor.isLoading := false;
  end;
end;

procedure TfrmGifList.gifClick(Sender: TObject);
begin
  try
    if workingFrame <> nil then Begin
      frmCharacterEditor.isLoading := true;
      frmCharacterEditor.gifLoad(workingFrame.frameFile,frmCharacterEditor.gif,workingFrame,True);
      frmCharacterEditor.findframeineditor(StrToInt(edtGifName.Text));
      frmCharacterEditor.selectFrame( StrToInt(edtGifName.Text) );
    end;
  finally
    frmCharacterEditor.isLoading := false;
  end;
end;

end.

