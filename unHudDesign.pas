unit unHudDesign;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, unCommon, StdCtrls, Mask, JvExMask, JvSpin,
  JvgScrollBox, mario, JvExExtCtrls, JvComponent, JvPanel, ComCtrls,
  JvExComCtrls, JvStatusBar, JvExControls, JvRuler, JvExtComponent;

type
  TfrmHudDesign = class(TForm)
    GroupBox13: TGroupBox;
    scrollbox: TJvgScrollBox;
    GroupBox1: TGroupBox;
    cbPlayer: TComboBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    sex: TJvSpinEdit;
    sey: TJvSpinEdit;
    Memo1: TMemo;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    jeNameX: TJvSpinEdit;
    jeNameY: TJvSpinEdit;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    jeEnemyLifeX: TJvSpinEdit;
    jeEnemyLifeY: TJvSpinEdit;
    GroupBox5: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    jePlayerMpX: TJvSpinEdit;
    jePlayerMpY: TJvSpinEdit;
    GroupBox6: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    jePlayerHealthX: TJvSpinEdit;
    jePlayerHealthY: TJvSpinEdit;
    GroupBox7: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    jePlayerxValueX: TJvSpinEdit;
    jePlayerxValueY: TJvSpinEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    jePlayerLeftX: TJvSpinEdit;
    jePlayerLeftY: TJvSpinEdit;
    GroupBox9: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    jvNameX: TJvSpinEdit;
    jvNameY: TJvSpinEdit;
    jvDashX: TJvSpinEdit;
    jvDashY: TJvSpinEdit;
    jeScoreX: TJvSpinEdit;
    jeScoreY: TJvSpinEdit;
    GroupBox10: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    jeEnemyIconX: TJvSpinEdit;
    jeEnemyIconY: TJvSpinEdit;
    GroupBox11: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    jeNameJX: TJvSpinEdit;
    jeNameJY: TJvSpinEdit;
    jeSelectPlayerX: TJvSpinEdit;
    jeSelectPlayerY: TJvSpinEdit;
    jePressPlayerX: TJvSpinEdit;
    jePressPlayerY: TJvSpinEdit;
    cbNameJ: TCheckBox;
    GroupBox12: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    jeMpIconX: TJvSpinEdit;
    jeMpIconY: TJvSpinEdit;
    cbmpIcon: TCheckBox;
    GroupBox14: TGroupBox;
    Label31: TLabel;
    Label32: TLabel;
    jepIconwX: TJvSpinEdit;
    jepIconwY: TJvSpinEdit;
    cbpIconw: TCheckBox;
    GroupBox15: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    jeShootX: TJvSpinEdit;
    jeShootY: TJvSpinEdit;
    cbShoot: TCheckBox;
    GroupBox16: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    jvRushNowX: TJvSpinEdit;
    jvRushNowY: TJvSpinEdit;
    jvRushnValueX: TJvSpinEdit;
    jvRushnValueY: TJvSpinEdit;
    jvRushMaxX: TJvSpinEdit;
    jvRushMaxY: TJvSpinEdit;
    jvRushmValueY: TJvSpinEdit;
    jvRushmValueX: TJvSpinEdit;
    Label41: TLabel;
    Label42: TLabel;
    Panel1: TPanel;
    jeDivide: TJvSpinEdit;
    Label43: TLabel;
    Panel2: TPanel;
    JvPanel1: TJvPanel;
    JvRuler1: TJvRuler;
    JvRuler2: TJvRuler;
    JvStatusBar1: TJvStatusBar;
    btnLineVert: TButton;
    Button1: TButton;
    jeLineX: TJvSpinEdit;
    jeLineY: TJvSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure sexChange(Sender: TObject);
    procedure cbNameJClick(Sender: TObject);
    procedure cbmpIconClick(Sender: TObject);
    procedure cbpIconwClick(Sender: TObject);
    procedure cbShootClick(Sender: TObject);
    procedure cbPlayerCloseUp(Sender: TObject);
    procedure JvPanel1Paint(Sender: TObject);
    procedure Panel2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnLineVertClick(Sender: TObject);
    procedure JvPanel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvPanel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure JvPanel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure jeLineXChange(Sender: TObject);
    procedure jeLineYChange(Sender: TObject);
  private
    { Private declarations }
    background : Timage;
    icon : TImage;
    mp : TImage;
    health : TImage;
    lifeX : TImage;
    lifen : TImage;
    PlayerName : Timage;
    PlayerDash : Timage;
    PlayerScore : TImage;
    PlayerSelect : TImage;
    PlayerStart : TImage;
    mpIcon : TImage;
    piconw : TImage;
    shootcount : TImage;

    now : TImage;
    nowValue : TImage;
    max : TImage;
    maxValue : TImage;

    enemyicon : TImage;
    enemyName : TImage;
    enemyLifeBar : TImage;

    lastLine : TJvPanel;

    procedure drawdivides(img:TJvPanel);
    procedure populateFromFile;
  public
    { Public declarations }
    procedure populateHud;
  end;

var
  frmHudDesign: TfrmHudDesign;

implementation

uses unMain;

{$R *.dfm}

{ TfrmHudDesign }

procedure TfrmHudDesign.populateHud;
var
  i : integer;
begin
  if background = nil then
    background := TImage.Create(nil);

  background.OnMouseMove := Panel2MouseMove;

  if icon = nil then Begin
    icon := TImage.Create(nil);
    icon.Transparent := true;
    icon.Visible := true;
  end;
  if enemyName = nil then Begin
    enemyName := TImage.Create(nil);
    enemyName.Transparent := true;
    enemyName.Visible := true;
  end;
  if enemyLifeBar = nil then Begin
    enemyLifeBar := TImage.Create(nil);
    enemyLifeBar.Transparent := true;
    enemyLifeBar.Visible := true;
  end;
  if mp = nil then Begin
    mp := TImage.Create(nil);
    mp.Transparent := true;
    mp.Visible := true;
  end;
  if health = nil then Begin
    health := TImage.Create(nil);
    health.Transparent := true;
    health.Visible := true;
  end;
  if lifeX = nil then Begin
    lifeX := TImage.Create(nil);
    lifeX.Transparent := true;
    lifeX.Visible := true;
  end;
  if lifen = nil then Begin
    lifen := TImage.Create(nil);
    lifen.Transparent := true;
    lifen.Visible := true;
  end;
  if PlayerName = nil then Begin
    PlayerName := TImage.Create(nil);
    PlayerName.Transparent := true;
    PlayerName.Visible := true;
  end;
  if PlayerDash = nil then Begin
    PlayerDash := TImage.Create(nil);
    PlayerDash.Transparent := true;
    PlayerDash.Visible := true;
  end;
  if PlayerScore = nil then Begin
    PlayerScore := TImage.Create(nil);
    PlayerScore.Transparent := true;
    PlayerScore.Visible := true;
  end;
  if enemyicon = nil then Begin
    enemyicon := TImage.Create(nil);
    enemyicon.Transparent := true;
    enemyicon.Visible := true;
  end;
  if PlayerSelect = nil then Begin
    PlayerSelect := TImage.Create(nil);
    PlayerSelect.Transparent := true;
    PlayerSelect.Visible := false;
  end;
  if PlayerStart = nil then Begin
    PlayerStart := TImage.Create(nil);
    PlayerStart.Transparent := true;
    PlayerStart.Visible := false;
  end;
  if mpIcon = nil then Begin
    mpIcon := TImage.Create(nil);
    mpIcon.Transparent := true;
    mpIcon.Visible := false;
  end;
  if piconw = nil then Begin
    piconw := TImage.Create(nil);
    piconw.Transparent := true;
    piconw.Visible := false;
  end;
  if shootcount = nil then Begin
    shootcount := TImage.Create(nil);
    shootcount.Transparent := true;
    shootcount.Visible := false;
  end;
  if now = nil then Begin
    now := TImage.Create(nil);
    now.Transparent := true;
    now.Visible := true;
  end;
  if nowValue = nil then Begin
    nowValue := TImage.Create(nil);
    nowValue.Transparent := true;
    nowValue.Visible := true;
  end;
  if max = nil then Begin
    max := TImage.Create(nil);
    max.Transparent := true;
    max.Visible := true;
  end;
  if maxValue = nil then Begin
    maxValue := TImage.Create(nil);
    maxValue.Transparent := true;
    maxValue.Visible := true;
  end;


  if cbPlayer.ItemIndex = -1 then
    cbPlayer.ItemIndex := 0;
    
  if ses.video = nil then exit;

  i := ses.video.videoSize;
  //Background
  case i of
   0: Begin
        background.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\back0.jpg');
        background.Width := 320;
        background.Height := 240;
      end;
   1: Begin
        background.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\back1.jpg');
        background.Width := 480;
        background.Height := 272;
      end;
   2: Begin
        background.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\back2.jpg');
        background.Width := 640;
        background.Height := 480;
      end;
   3: Begin
        background.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\back3.jpg');
        background.Width := 720;
        background.Height := 480;
      end;
   4: Begin
        background.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\back4.jpg');
        background.Width := 800;
        background.Height := 480;
      end;
   5: Begin
        background.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\back5.jpg');
        background.Width := 960;
        background.Height := 540;
      end;
  end;
  background.Parent := Panel2;
  background.Visible := true;
  background.Left := 0;
  background.Top := 0;
  //Icon
  icon.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\Icon.gif');
  icon.Parent := Panel2;
  icon.Left := sex.AsInteger;
  icon.Top := sey.AsInteger;
  Memo1.Lines.Clear;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'icon ' + IntToStr(sex.AsInteger) + ' ' + IntToStr(sey.AsInteger) );
  //Mp
  mp.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\mp.gif');
  mp.Parent := Panel2;
  mp.Left :=  jePlayerMpX.AsInteger;
  mp.Top := jePlayerMpY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'mp ' + IntToStr(jePlayerMpX.AsInteger) + ' ' + IntToStr(jePlayerMpY.AsInteger) );
  //Health
  health.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\LifeBar.gif');
  health.Parent := Panel2;
  health.Left :=  jePlayerHealthX.AsInteger;
  health.Top := jePlayerHealthY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'life ' + IntToStr(jePlayerHealthX.AsInteger) + ' ' + IntToStr(jePlayerHealthY.AsInteger) );
  //Life * Value
  lifeX.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\Lifex.gif');
  lifeX.Parent := Panel2;
  lifeX.Left :=  jePlayerxValueX.AsInteger;
  lifeX.Top := jePlayerxValueY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'lifex ' + IntToStr(jePlayerxValueX.AsInteger) + ' ' + IntToStr(jePlayerxValueY.AsInteger) );
  //Life Amount Left
  lifen.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\lifen.gif');
  lifen.Parent := Panel2;
  lifen.Left :=  jePlayerLeftX.AsInteger;
  lifen.Top := jePlayerLeftY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'lifen ' + IntToStr(jePlayerLeftX.AsInteger) + ' ' + IntToStr(jePlayerLeftY.AsInteger) );
  //Player Score Name
  PlayerName.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\Name.gif');
  PlayerName.Parent := Panel2;
  if cbNameJ.Checked = true then Begin
    PlayerName.Left :=  jeNameJX.AsInteger;
    PlayerName.Top := jeNameJY.AsInteger;
  end else Begin
    PlayerName.Left :=  jvNameX.AsInteger;
    PlayerName.Top := jvNameY.AsInteger;
  end;
  //Player Score Dash
  PlayerDash.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\PlayerScoreDash.gif');
  PlayerDash.Parent := Panel2;
  PlayerDash.Left :=  jvDashX.AsInteger;
  PlayerDash.Top := jvDashY.AsInteger;
  //Player Score Score
  PlayerScore.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\PlayerScore.gif');
  PlayerScore.Parent := Panel2;
  PlayerScore.Left :=  jeScoreX.AsInteger;
  PlayerScore.Top := jeScoreY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'score '
                + IntToStr(jvNameX.AsInteger) + ' ' + IntToStr(jvNameY.AsInteger)
                + ' ' + IntToStr(jvDashX.AsInteger) + ' ' + IntToStr(jvDashY.AsInteger)
                + ' ' + IntToStr(jeScoreX.AsInteger) + ' ' + IntToStr(jeScoreY.AsInteger) + ' 0' );
  //Player Select
  PlayerSelect.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\Select.gif');
  PlayerSelect.Parent := Panel2;
  PlayerSelect.Left :=  jeSelectPlayerX.AsInteger;
  PlayerSelect.Top := jeSelectPlayerY.AsInteger;
  //Player Start
  PlayerStart.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\PressStart.gif');
  PlayerStart.Parent := Panel2;
  PlayerStart.Left :=  jePressPlayerX.AsInteger;
  PlayerStart.Top := jePressPlayerY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'namej '
                + IntToStr(jeNameJX.AsInteger) + ' ' + IntToStr(jeNameJY.AsInteger) + ' '
                + IntToStr(jeSelectPlayerX.AsInteger) + ' ' + IntToStr(jeSelectPlayerY.AsInteger) + ' '
                + IntToStr(jePressPlayerX.AsInteger) + ' ' + IntToStr(jePressPlayerY.AsInteger) + ' ' );
  //mp Icon
  mpIcon.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\mpIcon.gif');
  mpIcon.Parent := Panel2;
  mpIcon.Left :=  jeMpIconX.AsInteger;
  mpIcon.Top := jeMpIconY.AsInteger;
  if mpIcon.Visible = true then
    Memo1.Lines.Add( 'mp' + IntToStr(cbPlayer.ItemIndex+1) + 'icon ' + IntToStr(jeMpIconX.AsInteger) + ' ' + IntToStr(jeMpIconY.AsInteger) );
   //Weapon Icon
  piconw.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\piconw.gif');
  piconw.Parent := Panel2;
  piconw.Left :=  jepIconwX.AsInteger;
  piconw.Top := jepIconwY.AsInteger;
  if piconw.Visible = true then
    Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'iconw ' + IntToStr(jepIconwX.AsInteger) + ' ' + IntToStr(jepIconwY.AsInteger) );
  //shootcount
  shootcount.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\shoot.gif');
  shootcount.Parent := Panel2;
  shootcount.Left :=  jeShootX.AsInteger;
  shootcount.Top := jeShootY.AsInteger;
  if shootcount.Visible = true then
    Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'shoot ' + IntToStr(jeShootX.AsInteger) + ' ' + IntToStr(jeShootY.AsInteger) );

  //Rush Now
  now.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\Now.gif');
  now.Parent := Panel2;
  now.Left :=  jvRushNowX.AsInteger;
  now.Top := jvRushNowY.AsInteger;
  //Rush Now Value
  nowValue.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\nValue.gif');
  nowValue.Parent := Panel2;
  nowValue.Left :=  jvRushnValueX.AsInteger;
  nowValue.Top := jvRushnValueY.AsInteger;
  //Rush Max
  max.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\Max.gif');
  max.Parent := Panel2;
  max.Left :=  jvRushMaxX.AsInteger;
  max.Top := jvRushMaxY.AsInteger;
  //Rush Max Value
  maxValue.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\mValue.gif');
  maxValue.Parent := Panel2;
  maxValue.Left :=  jvRushmValueX.AsInteger;
  maxValue.Top := jvRushmValueY.AsInteger;
  Memo1.Lines.Add( 'p' + IntToStr(cbPlayer.ItemIndex+1) + 'rush '
              + IntToStr(jvRushNowX.AsInteger) + ' ' + IntToStr(jvRushNowY.AsInteger)
              + ' ' + IntToStr(jvRushnValueX.AsInteger)+ ' ' +  IntToStr(jvRushnValueY.AsInteger)
              + ' ' + IntToStr(jvRushMaxX.AsInteger) + ' ' + IntToStr(jvRushMaxY.AsInteger)
              + ' ' + IntToStr(jvRushmValueX.AsInteger) + ' ' + IntToStr(jvRushmValueY.AsInteger) );

  //Enemy Icon
  enemyicon.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\EIcon.gif');
  enemyicon.Parent := Panel2;
  enemyicon.Left :=  jeEnemyIconX.AsInteger;
  enemyicon.Top := jeEnemyIconY.AsInteger;
  Memo1.Lines.Add( 'e' + IntToStr(cbPlayer.ItemIndex+1) + 'icon ' + IntToStr(jeEnemyIconX.AsInteger) + ' ' + IntToStr(jeEnemyIconY.AsInteger) );
  //Enemy Name
  enemyName.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\enemyName.gif');
  enemyName.Parent := Panel2;
  enemyName.Left :=  jeNameX.AsInteger;
  enemyName.Top := jeNameY.AsInteger;
  Memo1.Lines.Add( 'e' + IntToStr(cbPlayer.ItemIndex+1) + 'name ' + IntToStr(jeNameX.AsInteger) + ' ' + IntToStr(jeNameY.AsInteger) );
  //Enemy Life Bar
  enemyLifeBar.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Res\LifeBar.gif');
  enemyLifeBar.Parent := Panel2;
  enemyLifeBar.Left :=  jeEnemyLifeX.AsInteger;
  enemyLifeBar.Top := jeEnemyLifeY.AsInteger;
  Memo1.Lines.Add( 'e' + IntToStr(cbPlayer.ItemIndex+1) + 'life ' + IntToStr(jeEnemyLifeX.AsInteger) + ' ' + IntToStr(jeEnemyLifeY.AsInteger) );

  {
  if JvPanel1 <> nil then Begin
    FreeAndNil(JvPanel1);
    JvPanel1 := TJvPanel.Create(nil);
    JvPanel1.Parent := Panel2;
    //JvPanel1.Caption := 'should work dammit';
    JvPanel1.Visible := true;
    JvPanel1.Transparent := true;
    JvPanel1.OnPaint := JvPanel1Paint;
  end;

  JvPanel1.Top := background.Top;
  JvPanel1.Left := background.left;
  JvPanel1.Width := background.width;
  JvPanel1.Height := background.height+30;
  }
end;

procedure TfrmHudDesign.FormShow(Sender: TObject);
begin
  if cbPlayer.ItemIndex = -1 then
    cbPlayer.ItemIndex := 0;
  populateFromFile;
  populateHud;
end;

procedure TfrmHudDesign.sexChange(Sender: TObject);
begin
  populateHud;
end;

procedure TfrmHudDesign.cbNameJClick(Sender: TObject);
begin
  if cbNameJ.Checked = true then Begin

    mp.Visible := false;
    health.Visible := false;
    lifeX.Visible := false;
    lifen.Visible := false;
    PlayerDash.Visible := false;
    PlayerScore.Visible := false;

    PlayerSelect.Visible := true;
    PlayerStart.Visible := true;

    enemyicon.Visible := false;
    enemyName.Visible := false;
    enemyLifeBar.Visible := false;
  end else Begin
    mp.Visible := true;
    health.Visible := true;
    lifeX.Visible := true;
    lifen.Visible := true;
    PlayerDash.Visible := true;
    PlayerScore.Visible := true;

    PlayerSelect.Visible := false;
    PlayerStart.Visible := false;

    enemyicon.Visible := true;
    enemyName.Visible := true;
    enemyLifeBar.Visible := true;
  end;
  populateHud;
end;

procedure TfrmHudDesign.cbmpIconClick(Sender: TObject);
begin
  if cbmpIcon.Checked = true then
    mpIcon.Visible := true
  else
    mpIcon.Visible := false;
  populateHud;  
end;

procedure TfrmHudDesign.cbpIconwClick(Sender: TObject);
begin
  if cbpIconw.Checked = true then
    piconw.Visible := true
  else
    piconw.Visible := false;  
end;

procedure TfrmHudDesign.cbShootClick(Sender: TObject);
begin
  if cbShoot.Checked = true then
    shootcount.Visible := true
  else
    shootcount.Visible := false;

end;

procedure TfrmHudDesign.cbPlayerCloseUp(Sender: TObject);
begin
  populateFromFile;
  populateHud;
end;

procedure TfrmHudDesign.drawdivides(img:TJvPanel);
var
  i,drawvalue : integer;
Begin
  //try

    if img <> nil then Begin
      //psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear,   psInsideFrame
      img.Canvas.Pen.Width := 2;
      img.Canvas.Pen.Style := psDash;
      img.Canvas.Pen.Color := clBlack;

      drawvalue := background.Width div jeDivide.AsInteger;

      img.Canvas.MoveTo( 10, 0 );
      img.Canvas.MoveTo( 100, background.Height + 20 );

      for i:= 1 to jeDivide.AsInteger do Begin
        img.Canvas.MoveTo( (drawvalue*i), 0 );
        img.Canvas.MoveTo( (drawvalue*i), background.Height + 20 );

        //img.Canvas.MoveTo( (background.Width div i ), 0 );
        //img.Canvas.LineTo( (background.Width div i ), background.Height + 20 );
      end;
    end;
  //except
  //end;
end;

const playerCommands : array [0..11] of string = (
  'p%dicon',
  'p%dmp',
  'p%dlife',
  'p%dlifex',
  'p%dlifen',
  'mp%dicon',
  'e%dicon',
  'e%dname',
  'e%dlife',
  'e%dnamej',
  'p%dscore',
  'p%drush'
);

type
  TSpinArr = array [0..7] of pointer;
  TTargetSpinEdits = array [0..11] of TSpinArr;
var
  targetSpinEdits : TTargetSpinEdits = (
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil),
    (nil,nil,nil,nil,nil,nil,nil,nil)
  );

function hardcodeSpinArr(const input: array of TJvSpinEdit): TSpinArr;
var
  i: Integer;
begin
  assert(High(input) < 8);
  for i := 0 to High(input) do
    Result[i] := input[i];
  for i := High(input) + 1 to 7 do
    Result[i] := nil;
end;

procedure fillTargetSpinEdits;
var
  i : integer;
begin
  i := -1;
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.sex, frmHudDesign.sey]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jePlayerMpX, frmHudDesign.jePlayerMpY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jePlayerHealthX, frmHudDesign.jePlayerHealthY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jePlayerxValueX, frmHudDesign.jePlayerxValueY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jePlayerLeftX, frmHudDesign.jePlayerLeftX]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jeMpIconX, frmHudDesign.jeMpIconY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jeEnemyIconX, frmHudDesign.jeEnemyIconY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jeNameX, frmHudDesign.jeNameY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jeEnemyLifeX, frmHudDesign.jeEnemyLifeY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jeNameJX, frmHudDesign.jeNameJY, frmHudDesign.jeSelectPlayerX, frmHudDesign.jeSelectPlayerY, frmHudDesign.jePressPlayerX, frmHudDesign.jePressPlayerY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jvNameX, frmHudDesign.jvNameY, frmHudDesign.jvDashX, frmHudDesign.jvDashY, frmHudDesign.jeScoreX, frmHudDesign.jeScoreY]);
  inc(i); targetSpinEdits[i] := hardcodeSpinArr([frmHudDesign.jvRushNowX, frmHudDesign.jvRushNowY, frmHudDesign.jvRushnValueX, frmHudDesign.jvRushnValueY, frmHudDesign.jvRushMaxX, frmHudDesign.jvRushMaxY, frmHudDesign.jvRushmValueX, frmHudDesign.jvRushmValueY]);
end;

procedure TfrmHudDesign.populateFromFile;
var
  i, j, x : integer;
  int8 : TIntArr8;
  res : integer;
  player: integer;
  testcommand, command: string;
begin
  if Form1.Levels = nil then exit;

  player := cbPlayer.ItemIndex + 1;
  fillTargetSpinEdits;

  for i := 0 to Form1.Levels.LevelsFile.Count -1 do Begin
    command := getBORCommand(Form1.Levels.LevelsFile.Strings[i]);
    if(length(command) = 0) then continue;
    for j := 0 to high(playerCommands) do begin
       testcommand := format(playerCommands[j], [player]);
       if(command = testcommand) then begin
         res := stripStringIntegers(Form1.Levels.LevelsFile.Strings[i], int8);
         x := 0;
         while ((x < 8) and (nil <> targetSpinEdits[j][x])) do begin
           if(x >= res) then
             break;
           TJvSpinEdit(targetSpinEdits[j][x]).AsInteger := int8[x];
           inc(x);
         end;
         break;
       end;
    end;

    {

      -p1icon 2 2
      -p1mp 28 10
      -p1life 28 2
      -p1lifex 12 28
      -p1lifen 19 29
      -p1score 29 30 29 18 35 19 0
      -p1namej 29 10 30 2 19 21
      -mp1icon 28 10
      -p1rush 2 44 59 44 2 54 57 54
      -e1icon 2 249
      -e1name 29 249
      -e1life 29 257

    }
  end;
end;

procedure TfrmHudDesign.JvPanel1Paint(Sender: TObject);
begin
  drawdivides(sender as TJvPanel);
end;

procedure TfrmHudDesign.Panel2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  JvRuler1.Position := x;
  JvRuler2.Position := Y;
end;

procedure TfrmHudDesign.btnLineVertClick(Sender: TObject);
var
  newpanel : TJvPanel;
begin
  newpanel := TJvPanel.Create(nil);
  newpanel.Parent := Panel2;
  newpanel.Color := clBackground;
  newpanel.Transparent := false;
  newpanel.Movable := false;

  //newpanel.DragMode := dmAutomatic;
  newpanel.FlatBorder := true;
  newpanel.BevelOuter := bvNone;
  if (Sender as TButton).Tag = 0 then Begin
    newpanel.Height := 2;
    newpanel.Width := background.Width + 10;
  end else Begin
    newpanel.Height := background.Height + 10;
    newpanel.Width := 2;
  end;
  newpanel.Top := 20;
  newpanel.Left := 20;
  newpanel.OnMouseDown := JvPanel1MouseDown;
  newpanel.OnMouseUp := JvPanel1MouseUp;
  newpanel.OnMouseMove := JvPanel1MouseMove;

end;

procedure TfrmHudDesign.JvPanel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  (sender as TJvPanel).Tag := 1;
  Cursor := crDrag;
  lastLine := (sender as TJvPanel);
end;

procedure TfrmHudDesign.JvPanel1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   jeLineY.asinteger := y + (sender as TJvPanel).top-1;
   jeLineX.asinteger := x + (sender as TJvPanel).Left-1;
   (sender as TJvPanel).Tag := 0;
   Cursor := crDefault;

end;

procedure TfrmHudDesign.JvPanel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (sender as TJvPanel).Tag = 1 then Begin
    (sender as TJvPanel).Left := x + (sender as TJvPanel).Left-1;
    (sender as TJvPanel).top := y + (sender as TJvPanel).top-1;
  end;
end;

procedure TfrmHudDesign.jeLineXChange(Sender: TObject);
begin
  if lastLine <> nil then
    if lastLine.Tag = 0 then Begin
      lastLine.Left := (Sender as TJvSpinEdit).AsInteger;
    end;
end;

procedure TfrmHudDesign.jeLineYChange(Sender: TObject);
begin
  if lastLine <> nil then
    if lastLine.Tag = 0 then Begin
      lastLine.top := (Sender as TJvSpinEdit).AsInteger;
    end;
end;

end.

