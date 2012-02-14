unit MarioImg;//V0.01
//A unit with usefull Methods

interface

uses
  Windows, SysUtils, Classes, IniFiles, Registry, ShlObj, Tlhelp32, ShellApi,
  JclMime, Jpeg, Graphics, URLMon, JclShell, Controls, ImgList, TntClasses,
  GraphicEx, pngextra, GIFImage, 
  JvBalloonHint, JvDialogs, JvComCtrls, Forms, ExtCtrls, TntStdCtrls,
  JvFormWallpaper, JvPanel, JvAnimatedImage;


type
  PHICON = ^HICON;

//Gif
Function gifLoadFromFile(fileName:String):TGIFImage; Overload;
//Function gifLoadFromFileb(fileName:String):TJvAnimatedImage; Overload;
Function BMP2GIF(bmp:TBitmap):TGIFImage;
procedure gifSaveFrameToFile(zGif:TGIFImage;i:integer;fileName:String);
procedure gifSaveFrameSubToFile(zGif:TGIFImage;i:integer;fileName:String);
function gifGetFrameDelay(zGif:TGIFImage;frameNumber:integer):integer;
//Bitmaps
Function isValidBitmap(aFileName:String):Boolean;
Procedure MatJpeg2Bmp(JpgImage:TJPEGImage;Var ConvertedBmp:TBitmap);


implementation

uses VarCmplx;


Function gifLoadFromFile(fileName:String):TGIFImage;
var
  gif: TGIFImage;
Begin
  if FileExists(fileName) then Begin
    gif := TGIFImage.Create;
    gif.LoadFromFile(fileName);
  end else
    gif := nil;
  Result := gif;
end;

{Function gifLoadFromFileb(fileName:String):TJvAnimatedImage;
var
  gif: TJvAnimatedImage;
Begin
  if FileExists(fileName) then Begin
    gif := TJvAnimatedImage.Create(nil);
    gif.LoadFromFile(fileName);
  end else
    gif := nil;
  Result := gif;
end;}

function BMP2GIF(bmp:TBitmap):TGIFImage;
var
  gif: TGIFImage;
begin
  gif := TGifImage.Create;
  try
    bmp := TBitmap.Create;
    try
      //bmp.LoadFromFile('MyBitmap.BMP');
      gif.Assign(bmp);
    finally
      bmp.Free;
    end;
    //gif.SaveToFile('MyBitmap.GIF');
  finally

  end;
  Result := gif;
end;

//This methods works but does not extract dublicated frames
procedure gifSaveFrameToFile(zGif:TGIFImage;i:integer;fileName:String);
Var
  LoopExt: TGIFAppExtNSLoop;
  Ext		 : TGIFGraphicControlExtension;
  bGif : TGIFImage;
  tCol : TGIFColorMap;
Begin
  //zGif.Images[i].Extensions. = true then Begin
    bGif := TGIFImage.Create;
    bGif.Assign(zGif);
    bGif.Images.Clear;
    bGif.Add(zGif.Images[i]);
    tCol := TGIFColorMap.Create;
    tCol := zGif.GlobalColorMap;
    //LoopExt := TGIFAppExtNSLoop.Create(bGIF.Images[0]);
    //LoopExt.Loops := 0; // Number of loops (0 = forever)
    //bGif.Images[0].Extensions.Add(LoopExt);
    Ext := TGIFGraphicControlExtension.Create(bGIF.Images[0]);
    Ext.Delay := 300;//DelayMS div 10;  // 30; // Animation delay (30 = 300 mS)
    bGIF.Images[0].Extensions.Add(Ext);
    bGif.SaveToFile(fileName);
    bGif.Free;
  //end;
end;

procedure gifSaveFrameSubToFile(zGif:TGIFImage;i:integer;fileName:String);
Var
  LoopExt: TGIFAppExtNSLoop;
  astream : TMemoryStream;
  Ext		 : TGIFGraphicControlExtension;
  bGif : TGIFImage;
Begin
  //zGif.Images[i].Extensions. = true then Begin
    astream :=  TMemoryStream.Create;
    bGif := TGIFImage.Create;
    astream.Clear;
    bGif.GlobalColorMap.Assign(zGif.GlobalColorMap);

    //bGif := BMP2GIF(aBitmap);
    //bGif.Images.Clear;
    //bGif.GlobalColorMap.LoadFromStream(astream,zGif.GlobalColorMap.Count);
    bGif.Add(zGif.Images.SubImages[i]);
    LoopExt := TGIFAppExtNSLoop.Create(bGIF.Images[0]);
    LoopExt.Loops := 0; // Number of loops (0 = forever)
    bGif.Images[0].Extensions.Add(LoopExt);
    Ext := TGIFGraphicControlExtension.Create(bGIF.Images[0]);
    Ext.Delay := 300;//DelayMS div 10;  // 30; // Animation delay (30 = 300 mS)
    bGIF.Images[0].Extensions.Add(Ext);
    bGif.SaveToFile(fileName);
    //bGif.Free;
    astream.Free;
  //end;
end;

function gifGetFrameDelay(zGif:TGIFImage;frameNumber:integer):integer;
Var
  Ext		 : TGIFGraphicControlExtension;
  i, ival : integer;
Begin
  ival := 0;
  //if zGif.Images[frameNumber] <> nil then
    for i := 0 to zGif.Images[frameNumber].Extensions.Count -1 do Begin
      if zGif.Images[frameNumber].Extensions[i] is TGIFGraphicControlExtension then Begin
        Ext := zGif.Images[frameNumber].Extensions[i] as TGIFGraphicControlExtension;
        ival := Ext.Delay;
      end;
    end;
  result := ival;
end;

Procedure MatJpeg2Bmp(JpgImage:TJPEGImage;Var ConvertedBmp:TBitmap);
Begin
  try
    ConvertedBmp.Assign(JpgImage);
  finally
  end;
End;


Function isValidBitmap(aFileName:String):Boolean;
Var
  isValid : Boolean;
  BitmapHeaderSize, FileSize,ImageSize: integer;  // size of header of bitmap
  bmf: TBITMAPFILEHEADER;  // the bitmap header
  Stream : TStream;
Begin
  Try
    Try
      Stream := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
      // total size of bitmap
      FileSize := Stream.Size;
    // read the header
      Stream.ReadBuffer(bmf, SizeOf(TBITMAPFILEHEADER));
    // calculate header size
      BitmapHeaderSize := bmf.bfOffBits - SizeOf(TBITMAPFILEHEADER);
    // calculate size of bitmap bits
      ImageSize := FileSize - Integer(bmf.bfOffBits);
    // check for valid bitmap and exit if not
    if ((bmf.bfType <> $4D42) or
      (Integer(bmf.bfOffBits) < 1) or
      (FileSize < 1) or (BitmapHeaderSize < 1) or (ImageSize < 1) or
      (FileSize < (SizeOf(TBITMAPFILEHEADER) + BitmapHeaderSize + ImageSize))) then
    begin
      //Stream.Free;
      isValid := false
    end
  Else
    isValid := true;
    Except
      isValid := False;
    End;
  Finally
    result := isValid;
    if Stream <> nil then
      Try
        FreeAndNil(Stream);
      Except
      End;
  End;
End;


End.