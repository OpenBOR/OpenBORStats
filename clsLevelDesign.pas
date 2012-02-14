unit clsLevelDesign;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  unCommon, formFormat;

type
TLvlWall = class(TObject)
  Private
  Public
    //wall {xpos} {zpos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{alt}
    //hole {xpos} {zpos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}
    fullLine: string;
    xPos, yPos : integer;
    upperLeft, LowerLeft, UpperRight, LowerRight : integer;
    Depth :integer;
    height : integer;
    constructor create(wallLine:string);
end;

type
  TLvlBackground = class(TObject)
  Private
  public
    //{path} {xratio} {zratio} {xposition} {zposition} {xspacing} {zspacing} {xrepeat} {zrepeat} {transparency} {alpha}
    fullLine : string;
    imageFile : string;
    xRatio, yRatio : extended;
    xPosition, yPosition : integer;
    xSpacing, ySpacing : integer;
    xRepeat, yRepeat : extended;
    z : extended;
    constructor create(imageLine:string;addZ:boolean=false);
end;

type
  TLvlSpawn = class(TObject)
  Private
  public
    spName, alias, item : string;
    //coF = fall from hight
    coX, coY, coF, coAt, health : integer;
    procedure stripcoords(coords:string);
    constructor create;
end;

type
  TLevelDesign = class(TObject)
  private
    LevelDesignfileList : TStringList;
    function getBackground:string;
    function getfrontpanel:string;
    function getOrder:string;
    procedure getAt;
    procedure getpanel;
    procedure getBackgrounds;
    procedure getfgLayers;
    procedure getSpawns;
    procedure getWalls;
    procedure getHoles;
    function isHole(sCurrentLine:string):boolean;
  public
    music : string;
    background, panel, frontpanel : string;
    order : string;
    atMax : integer;
    atList : TStringList;
    settime, notime, shadowcolor :integer;
    FrontPanelListing, backGroundList, panelList, frontPanelList, spawnList, wallsList, holesList : TStringList;
    function ordercount:integer;
    function getPanelByLetter(letter:string):string;
    constructor create(LevelDesignfile:string);
    procedure refresh(aList:TStringList);
  end;

implementation

{ TLevelDesign }

constructor TLevelDesign.create(LevelDesignfile: string);
begin
  LevelDesignfileList := TStringList.Create;
  FrontPanelListing := TStringList.Create;
  backGroundList := TStringList.Create;
  frontPanelList := TStringList.Create;
  panelList := TStringList.Create;
  spawnList := TStringList.Create;
  atList := TStringList.Create;
  wallsList := TStringList.Create;
  holesList := TStringList.Create;
  if FileExists(LevelDesignfile) then Begin
    LevelDesignfileList.LoadFromFile(LevelDesignfile);
    //background := borFile2File(getBackground);
    getBackgrounds;
    frontpanel := borFile2File(getfrontpanel);
    order := getOrder;
    getfgLayers;
    getpanel;
    getAt;
    getSpawns;
    getWalls;
    getHoles;
  end;
end;

procedure TLevelDesign.getAt;
Var
  i, iFound : integer;
  s, sFound : string;
begin
  i := 0;
  atMax := 0;
  atList.Clear;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll( LevelDesignfileList.Strings[i] );
    if PosStr('at',s) > 0 then Begin
      try
        iFound := StrToInt( strip2Bar('at',s) );
        if iFound > atMax then
          atMax := iFound;
        atList.Add( IntToStr(iFound) );
      except
      end;
    end;
    inc(i);
  end;
end;

function TLevelDesign.getBackground: string;
Var
  i : integer;
  s, sFound : string;
begin
  i := 0;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if PosStr('background',s) > 0 then Begin
        sFound := (strip2Bar('background',s));
        background := sFound;
      i := LevelDesignfileList.Count;
    end;{ else
    if PosStr('bglayer',s) > 0 then Begin
        sFound := (strip2Bar('bglayer',s));
      i := LevelDesignfileList.Count;
    end;}
    inc(i);
  end;
  Result := sFound;
end;

procedure TLevelDesign.getBackgrounds;
Var
  i : integer;
  s, sFound : string;
  bck : TLvlBackground;
begin
  i := 0;
  sFound := getBackground;
  backGroundList.Clear;
  if sFound <> '' then Begin
    bck := TLvlBackground.create(sFound);
    backGroundList.AddObject(IntToStr(backGroundList.Count),bck);
    StringDelete2End(sFound,' ');
    background := borFile2File(sFound);
  end;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if PosStr('bglayer',s) > 0 then Begin
      sFound := borFile2File((strip2Bar('bglayer',s)));
      bck := TLvlBackground.create(sFound);
      backGroundList.AddObject(IntToStr(backGroundList.Count),bck);
      //panelList.Add(sFound);
    end;
    inc(i);
  end;
end;

procedure TLevelDesign.getfgLayers;
Var
  i : integer;
  s, sFound : string;
  bck : TLvlBackground;
begin
  i := 0;
  //sFound := getBackground;
  FrontPanelListing.Clear;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if PosStr('fglayer',s) > 0 then Begin
      sFound := borFile2File((strip2Bar('fglayer',s)));
      bck := TLvlBackground.create(sFound,true);
      if bck <> nil then
        FrontPanelListing.AddObject(IntToStr(FrontPanelListing.Count),bck);
      //panelList.Add(sFound);
    end;
    inc(i);
  end;
end;

function TLevelDesign.getfrontpanel: string;
Var
  i : integer;
  s, sFound : string;
begin
  i := 0;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
      if PosStr('frontpanel',s) > 0 then Begin
        sFound := borFile2File((strip2Bar('frontpanel',s)));
        frontPanelList.Add(sFound);
      end;
    inc(i);
  end;
end;

procedure TLevelDesign.getHoles;
Var
  i : integer;
  s, s1, sFound : string;
  wall : TLvlWall;
begin
  i := 0;
  holesList.Clear;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if isHole(s) = true then Begin
      wall := TLvlWall.create(strip2Bar('hole',s));
      holesList.AddObject(IntToStr(holesList.Count),wall);
      //spwn.spName := strip2Bar('wall',s);
    end ;//else
    inc(i);
  end;
end;

function TLevelDesign.getOrder: string;
Var
  i : integer;
  s, sFound : string;
begin
  i := 0;
  order := '';
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if PosStr('order',s) > 0 then Begin
        sFound := (strip2Bar('order',s));
        order := order + sFound;
    end;
    inc(i);
  end;
  Result := order;
end;

procedure TLevelDesign.getpanel;
Var
  i : integer;
  s, sFound : string;
begin
  i := 0;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if PosStr('panel',s) > 0 then Begin
      if PosStr('frontpanel',s) = 0 then Begin
        sFound := borFile2File((strip2Bar('panel',s)));
        panelList.Add(sFound);
      end;
    end;
    inc(i);
  end;
end;

function TLevelDesign.getPanelByLetter(letter: string): string;
Var
  s : string;
begin
  s := '';
  letter := LowerCase(letter);
  try
    if letter = 'a' then
      s := panelList.Strings[0]
    else
    if letter = 'b' then
      s := panelList.Strings[1]
    else
    if letter = 'c' then
      s := panelList.Strings[2]
    else
    if letter = 'd' then
      s := panelList.Strings[3]
    else
    if letter = 'e' then
      s := panelList.Strings[4]
    else
    if letter = 'f' then
      s := panelList.Strings[5]
    else
    if letter = 'g' then
      s := panelList.Strings[6]
    else
    if letter = 'h' then
      s := panelList.Strings[7]
    else
    if letter = 'i' then
      s := panelList.Strings[8]
    else
    if letter = 'j' then
      s := panelList.Strings[9]
    else
    if letter = 'k' then
      s := panelList.Strings[10]
    else
    if letter = 'l' then
      s := panelList.Strings[11]
    else
    if letter = 'm' then
      s := panelList.Strings[12]
    else
    if letter = 'o' then
      s := panelList.Strings[13]
    else
    if letter = 'p' then
      s := panelList.Strings[14]
    else
    if letter = 'q' then
      s := panelList.Strings[15]
    else
    if letter = 'r' then
      s := panelList.Strings[16]
    else
    if letter = 's' then
      s := panelList.Strings[17]
    else
    if letter = 't' then
      s := panelList.Strings[18]
    else
    if letter = 'u' then
      s := panelList.Strings[19]
    else
    if letter = '' then
      s := panelList.Strings[20]
    else
    if letter = 'v' then
      s := panelList.Strings[21]
    else
    if letter = 'w' then
      s := panelList.Strings[22]
    else
    if letter = 'x' then
      s := panelList.Strings[23]
    else
    if letter = 'y' then
      s := panelList.Strings[24]
    else
    if letter = 'z' then
      s := panelList.Strings[25];
  except
    s := '';
  end;
  Result := s;
end;

procedure TLevelDesign.getSpawns;
Var
  i : integer;
  s, s1, sFound : string;
  newSpawn, populateSpawn : Boolean;
  spwn : TLvlSpawn;
begin
  i := 0;
  populateSpawn := false;
  spawnList.Clear;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if isSpawn(s) = true then Begin
      newSpawn := true;
      spwn := TLvlSpawn.create;
      spwn.spName := strip2Bar('spawn',s);
    end else
    if newSpawn = true then Begin
      if PosStr('coords',s) > 0 then Begin
        s1 := strip2Bar('coords',s);
        spwn.stripcoords(s1);
      end;
      if PosStr('at ',s) > 0 then Begin
        spwn.coAt := StrToInt(strip2Bar('at',s));
        newSpawn := false;
        spawnList.AddObject(IntToStr(i),spwn);
      end;
    end;

    inc(i);
    end;

end;
procedure TLvlSpawn.stripcoords(coords: string);
Var
  iCnt : integer;
  s : string;
begin
  iCnt := howManyValues(coords,' ');
  if iCnt >= 0 then Begin
    s := coords;
    StringDelete2End(s,' ');
    StringDeleteUp2(coords,' ');
    try
      coX := StrToInt(s);
    except
      coX := 0;
    end;
  end;
  if iCnt >= 1 then Begin
    s := coords;
    StringDelete2End(s,' ');
    StringDeleteUp2(coords,' ');
    try
      coY := StrToInt(s);
    except
      coY := 0;
    end;
  end;
  if iCnt >= 2 then Begin
    s := coords;
    StringDelete2End(s,' ');
    StringDeleteUp2(coords,' ');
    try
      coF := StrToInt(s);
    except
      coF := 0;
    end;
  end;
end;


procedure TLevelDesign.getWalls;
Var
  i : integer;
  s, s1, sFound : string;
  wall : TLvlWall;
begin
  i := 0;
  wallsList.Clear;
  while i < LevelDesignfileList.Count do Begin
    s := strClearAll(LevelDesignfileList.Strings[i]);
    if isWall(s) = true then Begin
      wall := TLvlWall.create(strip2Bar('wall',s));
      wallsList.AddObject(IntToStr(wallsList.Count),wall);
    end ;
    inc(i);
    end;

end;

function TLevelDesign.isHole(sCurrentLine: string): boolean;
Var
  found: boolean;
Begin
  found := false;
  sCurrentLine := strClearAll(sCurrentLine);
  if PosStr('@cmd',sCurrentLine) > 0 then
    found := false
  else
  if (PosStr('hole', sCurrentLine) > 0) then Begin
    found := True;
    //if PosStr('spawn1',sCurrentLine) > 0 then
    //  found := false;

  end;
  result := found;
end;




function TLevelDesign.ordercount: integer;
var
  i : integer;
begin
  i := 0;
  try
    i := length(order);
  except
    i := 0;
  end;
  result := i;
end;

procedure TLevelDesign.refresh(aList: TStringList);
begin
  LevelDesignfileList.Clear;
  LevelDesignfileList := aList;
  //background := borFile2File(getBackground);
  getBackgrounds;
  getfgLayers;
  frontpanel := borFile2File(getfrontpanel);
  order := getOrder;
  getpanel;
  getAt;
  getSpawns;
  getWalls;
  getHoles;
end;

{ TLvlBackground }

constructor TLvlBackground.create(imageLine: string;addZ:boolean);
Var
  i, iOptionsCnt : integer;
  s, s1 : string;
begin
  //Set default settings
  fullLine := imageLine;
  imageFile := borFile2File(imageLine);
  StringDelete2End(imageFile,' ');
  z := 0;
  xRatio := 0.5;
  yRatio := 0.5;
  xPosition := 0;
  yPosition := 0;
  xSpacing := 0;
  ySpacing := 0;
  xRepeat := 1;
  yRepeat := 1;
  //start stripping
  s := imageLine;
  iOptionsCnt := howManyValues(s, ' ');
  StringDeleteUp2(s,' ');
  //Find Z value for front panel
  if addZ = true then Begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      z := strToFloat(s1);
    except
      z := 0;
    end;
  end;
  //{xratio}
  if iOptionsCnt > 0 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      xRatio := strToFloat(s1);
    except
      xRatio := 0;
    end;
  end;
  //{zratio}
  if iOptionsCnt > 1 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      yRatio := strToFloat(s1);
    except
      yRatio := 0;
    end;
  end;
  //{xposition}
  if iOptionsCnt > 2 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    Try
      xPosition := StrToInt(s1);
    except
      xPosition := 0;
    end;
  end;
  //{yposition}
  if iOptionsCnt > 3 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    Try
      yPosition := StrToInt(s1);
    except
      yPosition := 0;
    end;
  end;
  //{xspacing}
  if iOptionsCnt > 4 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    Try
      xSpacing := StrToInt(s1);
    except
      xSpacing := 0;
    end;
  end;
  //{zspacing}
  if iOptionsCnt > 5 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    Try
      ySpacing := StrToInt(s1);
    except
      ySpacing := 0;
    end;
  end;
  //{xrepeat}
  if iOptionsCnt > 6 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    Try
      xRepeat := strToFloat(s1);
    except
      xRepeat := 0;
    end;
  end;
  //{zrepeat}
  if iOptionsCnt > 7 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    Try
      yRepeat := strToFloat(s1);
    except
      yRepeat := 0;
    end;
  end;
  {//transparency
  if iOptionsCnt > 8 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    xSpacing := strToFloat(s1);
  end;
  //alpha
  if iOptionsCnt > 9 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    xSpacing := strToFloat(s1);
  end;}
end;

{ TLvlSpawn }

constructor TLvlSpawn.create;
begin
  coX := 0;
  coY := 0;
  coF := 0;
  coAt := 0;
  health := -1;
  spName := '';
  alias := '';
  item := '';
end;

{ TLvlWall }

constructor TLvlWall.create(wallLine: string);
Var
  iWallcnt : Integer;
  s, s1 : string;
begin
  fullLine := '';
  xPos := 0;
  yPos := 0;
  upperLeft := 0;
  LowerLeft := 0;
  UpperRight := 0;
  LowerRight := 0;
  Depth := 0;
  height := 0;

  fullLine := wallLine;
  s := strClearAll(wallLine);
  //wall {xpos} {ypos} {upperleft} {lowerleft} {upperright} {lowerright} {depth}{alt}
  iWallcnt := howManyValues(s,' ');
  //xPos
  if iWallcnt >= 0 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      xPos := StrToInt(s1);
    except
      xPos := 0;
    end;
  end;
  //yPos
  if iWallcnt >= 1 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      yPos := StrToInt(s1);
    except
      yPos := 0;
    end;
  end;
  //upperLeft
  if iWallcnt >= 2 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      upperLeft := StrToInt(s1);
    except
      upperLeft := 0;
    end;
  end;
  //lowerLeft
  if iWallcnt >= 3 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      LowerLeft := StrToInt(s1);
    except
      LowerLeft := 0;
    end;
  end;
  //upperRight
  if iWallcnt >= 4 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      UpperRight := StrToInt(s1);
    except
      UpperRight := 0;
    end;
  end;
  //lowrRight
  if iWallcnt >= 5 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      LowerRight := StrToInt(s1);
    except
      LowerRight := 0;
    end;
  end;
  //depth
  if iWallcnt >= 6 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      Depth := StrToInt(s1);
    except
      Depth := 0;
    end;
  end;
  //height
  if iWallcnt >= 7 then begin
    s1 := s;
    StringDelete2End(s1,' ');
    StringDeleteUp2(s,' ');
    try
      height := StrToInt(s1);
    except
      height := 0;
    end;
  end;
end;

end.
