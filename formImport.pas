unit formImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, clsmugenAir, jvstrings, unCommon, VirtualTrees, ComCtrls,
  clsimportTreeVst, mario,
  ToolWin, JvExComCtrls, JvToolBar, Menus;

type
  TfrmImport = class(TForm)
    JvToolBar1: TJvToolBar;
    ToolButton1: TToolButton;
    vstImport: TVirtualStringTree;
    popImport: TPopupMenu;
    CheckAll1: TMenuItem;
    UnCheckAll1: TMenuItem;
    N1: TMenuItem;
    CheckSelected1: TMenuItem;
    UnCheckSelected1: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ProgressBar1: TProgressBar;
    ToolButton4: TToolButton;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure vstImportPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType);
    procedure vstImportChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure CheckAll1Click(Sender: TObject);
    procedure UnCheckAll1Click(Sender: TObject);
    procedure CheckSelected1Click(Sender: TObject);
    procedure UnCheckSelected1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    vstTree : TclsimportTreeVst;
    aFont : TFont;
    function convertMugenCharacter(aMugen : TmugenAirsData;outPutDir:String):String;
    procedure extractMugenCharacter(airFileName, outPutDir:String;doOnlyGraphics:Boolean);
    procedure checkAll(CheckState:Boolean);
    procedure checkSelected(CheckState:Boolean);
    procedure renameAllImageFiles(outPutDir:string);
    procedure getxyOffsetfromexport(var x:integer;var y:integer;searchstr:string;searchlist:TStringList);
  public
    { Public declarations }
    function nameAni(atype:integer):string;
    procedure importMugenCharacter(airFileName:String);
    procedure importMugenDirecotory(mugenDirectory:String);

  end;

var
  frmImport: TfrmImport;

implementation

uses unMain;

{$R *.dfm}

{ TfrmImport }

function TfrmImport.convertMugenCharacter(aMugen: TmugenAirsData;
  outPutDir: String):String;
Var
  i, j : integer;
  mugenActionData : TmugenAirDataAction;
  mugenData : TmugenAirData;
  s, s2, gifDir, sHigh, sLow, offset, LastComment, LastGifFile : string;
  offXs, offYs : string;
  aHigh, aLow, offX, offY, bx, by : Integer;
  outPutOpenBorCharacter : TStringList;
  convertText : TStringList;
begin
  if not DirectoryExists(outPutDir) then
    CreateDirectory(pChar(outPutDir), nil);
  outPutOpenBorCharacter := TStringList.Create;
  outPutOpenBorCharacter.Add('name' +#09 + ExtractFileName(outPutDir));
  outPutOpenBorCharacter.Add('');
  convertText := TStringList.Create();
  if FileExists(config.tempDirectory+'\oBStats\'+ExtractFileName(outPutDir)+'.txt') then
    convertText.LoadFromFile(config.tempDirectory+'\oBStats\'+ExtractFileName(outPutDir)+'.txt');

  gifDir := 'data/chars/' + ExtractFileName(outPutDir) + '/';
  for i := 0 to aMugen.list.Count -1 do Begin
    LastComment := aMugen.list.Strings[i];
    mugenData := (aMugen.list.Objects[i] as TmugenAirData);
    Form1.StringDeleteUp2(LastComment,';');
    Form1.StringReplace(LastComment,' ','');
    outPutOpenBorCharacter.Add('anim' + #09 + IntToStr(i)+LastComment);
    for j := 0 to mugenData.mugenAirDataActionTemp.FrameList.Count -1 do Begin
      s := mugenData.mugenAirDataActionTemp.FrameList.Strings[j];
      try
        if s <> '' then Begin
          s2 := s;
          offset := s;

          form1.StringDelete2End(s2,',');
          aHigh := StrToInt(s2);
          Form1.StringDeleteUp2(s,',');
          Form1.StringDelete2End(s,',');
          aLow := StrToInt(s);
          //offset     38 107
          Try

            Form1.StringDeleteUp2(offset,',');
            Form1.StringDeleteUp2(offset,',');
            Form1.StringDeleteFirstChar(offset,' ');
            s2 := offset;
            Form1.StringDelete2End(s2,',');
            strClearAll(s2);
            offX := StrToInt(s2);
            s2 := offset;
            Form1.StringDeleteUp2(s2,',');
            Form1.StringDelete2End(s2,',');
            s2 := strClearAll(s2);
            offY := StrToInt(s2);
          except
            offX := 0;
            offY := 0;
          end;

          if aHigh = 0 then
            sHigh := '0000';
          if ((aHigh < 10) and
             (aHigh > 0)) then
            sHigh := '0000';
          if ((aHigh < 100) and
             (aHigh > 9)) then
            sHigh := '000';
          if ((aHigh < 1000) and
             (aHigh > 99)) then
            sHigh := '00';
          if ((aHigh < 10000) and
             (aHigh > 999)) then
            sHigh := '0';
          if ((aHigh < 100000) and
             (aHigh > 9999)) then
          sHigh := '';
          if aLow < 10 then
            sLow := '0000';
          if (aLow < 100) and
             (aLow > 9) then
            sLow := '000';
          if (aLow < 1000) and
             (aLow > 99) then
            sLow := '00';
          if (aLow < 10000) and
             (aLow > 999) then
            sLow := '0';
          if (aLow < 100000) and
             (aLow > 9999) then
            sLow := '';
          {if (offX <> 0) or
             (offY <> 0) then Begin
             //Remove dbl 00
             offXs := IntToStr(offX);
             offYs := IntToStr(offY);
             StringReplace(offXs,'00','');
             StringReplace(offYs,'00','');
             outPutOpenBorCharacter.Add(#09+'offset'+#09+offXs+#09+offYs);
          end;}
          //Remove dbl 00
           offXs := sHigh+ IntToStr(aHigh);
           offYs := sLow+ IntToStr(aLow);
           offXs := offXs + offYs;
           StringReplace(offXs,'00','');
           s2 := sHigh + IntToStr(aHigh) + sLow + IntToStr(aLow)+'.pcx';
           getxyOffsetfromexport(bx,by,s2,convertText);
           //#09+'frame'+#09+gifDir+offXs+'.gif'
           //outPutOpenBorCharacter.Add(#09+'offset	'+IntToStr(offX)+' ' + IntToStr(offY) + ''');
           //outPutOpenBorCharacter.Add(#09+'offset	25 25');
           outPutOpenBorCharacter.Add(#09+'offset	'+ IntToStr(bx) +' ' + IntToStr(by) + ' ');
           outPutOpenBorCharacter.Add(#09+'frame'+#09+gifDir+offXs+'.gif');
          //outPutOpenBorCharacter.Add(#09+'frame'+#09+gifDir+sHigh+IntToStr(aHigh)+sLow+IntToStr(aLow)+'.gif')

        end;
      except
      end;
    end;
    outPutOpenBorCharacter.Add('');
  end;
  outPutOpenBorCharacter.SaveToFile(outPutDir + '\' + ExtractFileName(outPutDir) + '.txt');
  outPutOpenBorCharacter.Free;
end;

procedure TfrmImport.extractMugenCharacter(airFileName, outPutDir: String;doOnlyGraphics:Boolean);
Var
  sffFile, tmpSffFile, tmpsffExe, airFile, soutput : String;
begin
  if FileExists(airFileName) then Begin
    sffFile := LowerCase(airFileName);

    tmpsffExe := config.tempDirectory+'\oBStats\'+ExtractFileName(config.sffExtract);
    Form1.StringReplace(sffFile,'.air','.sff');
    tmpSffFile := config.tempDirectory+'\oBStats\'+ExtractFileName(sffFile);
    airFile := ExtractFileName(airFileName);
    Form1.StringReplace(airFile,'.air','');


    if not DirectoryExists(config.tempDirectory + '\oBStats') then
      CreateDirectory(pChar(config.tempDirectory + '\oBStats'),nil);
    CopyFile(pChar(airFileName),pChar(config.tempDirectory+'\oBStats\'+ExtractFileName(airFileName)),false);
    CopyFile(pChar(sffFile),pChar(tmpSffFile),false);
    CopyFile(pChar(config.sffExtract),pChar(tmpsffExe),false);
    soutput := ExtractFileName(sffFile);
    MatStringReplace(soutput,'.sff','.txt');
    if doOnlyGraphics = false then //sffextract.exe -d aba.sff -i -o 123.txt
      exeApp(tmpsffExe,' -d "'+ ExtractFileName(sffFile) + '" -i  -o '+soutput+' ',True,True); //to get output txt file with x,y offsets.. -o 123.txt
    Sleep(1000);
    Application.ProcessMessages;
    //showmessage('A delay is needed!' + #13 + 'If no gifs are converted try again and wait longer!');

    if doOnlyGraphics = True then
      convertPcxDir2GifDir(config.tempDirectory+'\oBStats\'+airFile,outPutDir+airFile,config.iView);
    Sleep(1000);
    //renameAllImageFiles(outPutDir+airFile);

    //RemoveDirectory(pchar(config.tempDirectory + '\oBStats\'));

  end;
end;

procedure TfrmImport.importMugenCharacter(airFileName: String);
Var
  airList, beginList, bortxtfile : TStringList;
  aMugen : TmugenAirsData;
  outPutDir, s, s2, LastComment, noAir : String;
  orgFile, newFile :string;
  sffFile :string;
  BeginNew : Boolean;
  i, lastGroup : Integer;
  mugsff : tmugenSff;
  mugData : TmugenSffData;
begin

  if FileExists(airFileName) then Begin
    airList := TStringList.create;
    airList.LoadFromFile(airFileName);
    beginList := TStringList.Create;
    aMugen := TmugenAirsData.create;
    BeginNew := False;
    outPutDir := LowerCase(form1.edtDirectory.Text + '\Chars\');
    extractMugenCharacter(airFileName,outPutDir,false);



    {for i := 0 to airList.Count -1 do Begin
      s := LowerCase(airList.Strings[i]);
      if PosStr(';',s) > 0 then
        LastComment := s;
      if PosStr('[begin',s) > 0 then Begin
        BeginNew := true;
      End;
      if BeginNew = true then Begin
        beginList.Add(s);
      end;
      if (BeginNew = true) and
         (isLineEmpty(s) = true) then Begin
         aMugen.addmugenAirData(beginList,LastComment);
         BeginNew := false;
         beginList.Clear;
      end;
    end;
    }
    //outPutDir := outPutDir + ExtractFileName(airFileName);
    noAir := outPutDir + ExtractFileName(airFileName);
    Form1.StringReplace(noAir,'.air','');
    //Reads the Air file and Creates a borScript File
    //convertMugenCharacter(aMugen,noAir);
    //Extracts all files from the mugen sff file and converts them to gif into the openBor directory
    extractMugenCharacter(airFileName,outPutDir,True);

    sffFile := LowerCase(config.tempDirectory+'\oBStats\'+ExtractFileName(airFileName));
    Form1.StringReplace(sffFile,'.air','.txt');
    mugsff := tmugenSff.Create(sffFile);
    bortxtfile := TStringList.Create;
    bortxtfile.Add('name '+ s2);
    bortxtfile.Add('');
    for i := 0 to mugsff.mugenList.Count -1 do Begin
      mugData := mugsff.getmugensffData(i);
      if lastGroup <> mugData.groupId then Begin
        bortxtfile.Add('');
        lastGroup := mugData.groupId;
        bortxtfile.Add('anim ' + nameAni(lastGroup));
        bortxtfile.Add( ' delay 7' );
      end;

      s := mugData.imageFile;
      StringReplace(s, '.pcx','.gif');
      s2 := ExtractFileName(airFileName);
      StringReplace(s2, '.air','');
      orgFile := outPutDir + s2 + '\' + s ;
      newFile := outPutDir + s2 + '\' + IntToStr(i) + '.gif';
      RenameFile(orgFile,newFile);
      bortxtfile.Add( ' offset ' + IntToStr(mugData.x) + ' ' + IntToStr(mugData.y) );
      bortxtfile.Add( ' frame' + ' data/chars/'+s2+'/'+IntToStr(i)+'.gif' );
      //gif output dir outPutDir
    end;
    bortxtfile.SaveToFile( outPutDir+s2+'\'+s2+'.txt' );

    DelTree(config.tempDirectory + '\oBStats\');
    aMugen.Free;
    airList.Free;
    beginList.Free;
  end;
end;

procedure TfrmImport.FormCreate(Sender: TObject);
begin
  vstTree := TclsimportTreeVst.Create(vstImport);
  aFont := TFont.Create;
end;

procedure TfrmImport.importMugenDirecotory(mugenDirectory: String);
Var
  lastFilter, s, s2 : String;
  i : Integer;
  rData : rimportTree;
begin
  lastFilter := Form1.JvSearchFiles1.FileParams.FileMasks.Text;
  vstImport.Clear;

  Form1.JvSearchFiles1.FileParams.FileMasks.Text := '*.air';
  Form1.JvSearchFiles1.RootDirectory := mugenDirectory;
  Form1.JvSearchFiles1.Search;

  for i:= 0 to Form1.JvSearchFiles1.Files.Count -1 do Begin
    s := LowerCase(Form1.JvSearchFiles1.Files.Strings[i]);
    s2 := s;
    Form1.StringReplace(s2,'.air','.sff');
    rData := vstTree.clearimportTreerData(rData);
    rData.airFile := s;
    if FileExists(s2) then
      rData.hasSff := true
    else
      rData.hasSff := false;
    vstTree.addimportTreeNode(rData,nil);    
  end;

  Form1.JvSearchFiles1.FileParams.FileMasks.Text := lastFilter;
end;

procedure TfrmImport.vstImportPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
Var
  pData : pimportTree;
begin
  if Node <> nil then Begin
    pData := Sender.GetNodeData(node);
    TargetCanvas.Font := aFont;
    if pData.hasSff = false then
      TargetCanvas.Font.Color := clLtGray
    else
      TargetCanvas.Font.Color := clBlack;  
  end;
end;

procedure TfrmImport.vstImportChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
Var
  pData : pimportTree;
begin
  if Node <> nil then Begin
    pData := vstImport.GetNodeData(Node);
    if pData.enble = true then
      pData.enble := false
    else
      pData.enble := True;
    vstImport.Refresh;
    {if Node.CheckState = csUnCheckedNormal then Begin
      pData.enble := True;
      //Node.CheckState := csCheckedNormal;
    end Else Begin
      pData.enble := False;
      //Node.CheckState := csUncheckedNormal;
    end;  }

  end;
  {If  (Node.CheckState = csUnCheckedNormal) then
    setNodeStatus(vstTasks,'100%')
  Else
  If  (Node.CheckState = csCheckedNormal) then
    setNodeStatus(vstTasks,'0%')}
end;

procedure TfrmImport.checkAll(CheckState: Boolean);
Var
 aNode : PVirtualNode;
 pData : pimportTree;
begin
  aNode := vstImport.GetFirst;
  while aNode <> nil do Begin
    pData := vstImport.GetNodeData(aNode);
    pData.enble := CheckState;
    aNode := vstImport.GetNext(aNode);
  end;
  vstImport.Refresh;
end;

procedure TfrmImport.checkSelected(CheckState: Boolean);
Var
 aNode : PVirtualNode;
 pData : pimportTree;
begin
  aNode := vstImport.GetFirstSelected;
  while aNode <> nil do Begin
    pData := vstImport.GetNodeData(aNode);
    pData.enble := CheckState;
    aNode := vstImport.GetNextSelected(aNode);
  end;
  vstImport.Refresh;
end;

procedure TfrmImport.CheckAll1Click(Sender: TObject);
begin
  checkAll(True);
end;

procedure TfrmImport.UnCheckAll1Click(Sender: TObject);
begin
  checkAll(False);
end;

procedure TfrmImport.CheckSelected1Click(Sender: TObject);
begin
  checkSelected(True);
end;

procedure TfrmImport.UnCheckSelected1Click(Sender: TObject);
begin
  checkSelected(False);
end;

procedure TfrmImport.ToolButton3Click(Sender: TObject);
Var
 aNode : PVirtualNode;
 pData : pimportTree;
begin
  aNode := vstImport.GetFirst;
  ProgressBar1.Min := 0;
  ProgressBar1.Position := 0;
  ProgressBar1.Max := vstImport.RootNodeCount;
  while aNode <> nil do Begin
    ProgressBar1.Position := ProgressBar1.Position + 1;
    if StatusBar1.Font.Color = clBtnText then
      StatusBar1.Font.Color := clBtnText
    else
      StatusBar1.Font.Color := clMaroon;  
    Application.ProcessMessages;
    pData := vstImport.GetNodeData(aNode);
    if pData.enble = True Then Begin
      importMugenCharacter(pData.airFile);
    end;
    aNode := vstImport.GetNext(aNode);
  end;
end;

procedure TfrmImport.ToolButton1Click(Sender: TObject);
begin
  if Form1.JvBrowseForFolderDialog1.Execute then Begin
    importMugenDirecotory(Form1.JvBrowseForFolderDialog1.Directory);
  End;
end;

procedure TfrmImport.renameAllImageFiles(outPutDir: string);
Var
  i, idb : integer;
  orgFile, newFile : string;
  fileDir, dirDir : TStringList;
begin
  //code here
  {Form1.JvSearchFiles1.FileParams.FileMasks.Text := '*.gif';
  Form1.JvSearchFiles1.RootDirectory := outPutDir;
  Form1.JvSearchFiles1.Search;}
  fileDir := TStringList.Create;
  dirDir := TStringList.Create;
  MatDirSubStructure(outPutDir,'*.gif',fileDir,dirDir,false);
  for i := 0 to fileDir.Count -1 do Begin
    idb := 0;
    orgFile := LowerCase(fileDir.Strings[i]);
    newFile := ExtractFileName(orgFile);
    StringReplace(newFile,'00','');
    if newFile = '.gif' then
      newFile := '00.gif';
    newFile := outPutDir + '\' + newFile;
    while FileExists(newFile) do Begin
      inc(idb);
      StringReplace(newFile,'.gif','-'+IntToStr(idb)+'.gif',true);
    end;
    RenameFile(orgFile,newFile);
  end;

  fileDir.Free;
  dirDir.Free;
end;

procedure TfrmImport.getxyOffsetfromexport(var x, y: integer; searchstr:string;
  searchlist: TStringList);
var
  i : integer;
  s, s2 : string;
begin
  i := 0;
  x := 0;
  y := 0;
  while i < searchlist.Count do begin
    s := searchlist.Strings[i];
    if PosStr(searchstr,s) > 0 then Begin
      try
        s2 := searchlist.Strings[i+4];
        s2 := strClearAll(s2);
        y := StrToInt(s2);
        s2 := searchlist.Strings[i+3];
        s2 := strClearAll(s2);
        x := StrToInt(s2);
        i := searchlist.Count;
      except
        x := 0;
        y := 0;
      end;
    end;
    inc(i);
  end;
end;

function TfrmImport.nameAni(atype: integer): string;
var
  s : string;
begin
  s:= '0';
  case atype of
   0: s := 'idle';
   5: s := 'turn';
   20: s:= 'walk';
   21: s:= 'backwalk';
   41: s:= 'jump';
   42: s:= 'jumpforward';
   47: s:= 'jumpland';
   100: s:= 'run';
   105: s:= 'dodge';
   //130: s:= 'block';
   190: s:= 'respawn';
   195: s:= 'select';
   {
   5000: s:= 'pain';
   5001: s:= 'pain2';
   5002: s:= 'pain3';
   5003: s:= 'pain4';
   5004: s:= 'pain5';
   5005: s:= 'pain6';
   5006: s:= 'pain7';
   5007: s:= 'pain8';
   5008: s:= 'pain9';
   5009: s:= 'pain10';
   }
   5120: s:= 'rise';
   5300: s:= 'faint';
   else begin
     s:= IntToStr(atype);
     if (atype < 10) then
       s:= '000' + IntToStr(atype);
     if (atype > 9) and (atype < 100) then
       s:= '00' + IntToStr(atype);
     if (atype > 99) and (atype < 1000) then
       s:= '0' + IntToStr(atype);

     if (atype > 119) and (atype < 153) then
       s:= 'block' + IntToStr(atype);
     if (atype > 199) and (atype < 600) then
       s:= 'attack' + IntToStr(atype);
     if (atype > 599) and (atype < 800) then
       s:= 'jumpattack' + IntToStr(atype);
     if (atype > 999) and (atype < 5000) then
       s:= 'freespecial' + IntToStr(atype);
     if (atype > 4999) and (atype < 5030) then
       s:= 'pain' + IntToStr(atype);
     if (atype > 5029) and (atype < 5120) then
       s:= 'fall' + IntToStr(atype);

   end;
  end;
  Result := s;
end;

end.