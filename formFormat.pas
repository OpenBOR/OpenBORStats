unit formFormat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvRichEdit, ToolWin, ComCtrls,
  unCommon,
  JvExComCtrls, JvToolBar, ExtCtrls, JvExExtCtrls, JvSplitter, jvStrings,
  JvDialogs;

type
  TfrmFormat = class(TForm)
    JvToolBar1: TJvToolBar;
    richOrg: TJvRichEdit;
    JvSplitter1: TJvSplitter;
    richModded: TJvRichEdit;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Edit1: TEdit;
    JvSaveDialog1: TJvSaveDialog;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    JvOpenDialog1: TJvOpenDialog;
    procedure richOrgVerticalScroll(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { Private declarations }
    function removeDbls(s:string):string;
    function removeLast(s:string):string;
    function removeMisc(s:string):string;
    function formatValue(s:String; startTabbed:boolean=false):string;
  public
    { Public declarations }
    procedure populateFile(fileName:String);
    function format(bList:TStringList):TStringList; Overload;
    function format(bList:TStrings):TStrings; Overload;
  end;

var
  frmFormat: TfrmFormat;

implementation

uses unMain;

{$R *.dfm}

function TfrmFormat.format(bList: TStringList): TStringList;
Var
  i{, iAnime} : integer;
  aList : TStringList;
  sCrnt, previousLine : string;
  FirstAnimeFound, scriptFound : Boolean;
begin
  aList := TStringList.Create;
  aList.AddStrings(bList);
  i := 0;
  //for i := 0 to aList.Count -1 do Begin
  while i < aList.Count do Begin
    try
      sCrnt := aList.Strings[i];
      if isNewAnimBlock(sCrnt) = true then
        FirstAnimeFound := true;
      //iAnime := PosStr('anim',LowerCase(sCrnt));
        {if iAnime > 0 then
          newAnime := true;}

        //Detect scripts
        if (PosStr('@script',sCrnt) > 0) then
          scriptFound := true;
        if (PosStr('@end_script',sCrnt) > 0) then
          scriptFound := False;

        if (FirstAnimeFound = false) or
           (scriptFound = true) or
           (PosStr('#',sCrnt) > 0) then Begin
          aList.Strings[i] := sCrnt;
        end else Begin
          sCrnt := removeDbls(sCrnt);
          sCrnt := removeLast(sCrnt);
          sCrnt := removeMisc(sCrnt);

          if isNewAnimBlock(sCrnt) = false then
            sCrnt := formatValue(sCrnt, true)
          else Begin
            try
              if i > 0 then
                previousLine := aList.Strings[i-1]
              else
                previousLine := '';
              if isLineEmpty(previousLine) = false then Begin
                aList.Insert(i,'');
                inc(i);
              end;
            except
            end;
            sCrnt := formatValue(sCrnt);
          end;


          aList.Strings[i] := sCrnt;
        end;
        inc(i);
    except
    end;
  end;
  Result := aList;
end;

{function TfrmFormat.format(bList: TStringList): TStringList;

begin

end;}

function TfrmFormat.format(bList: TStrings): TStrings;
Var
  i{, iAnime} : integer;
  aList : TStringList;
  sCrnt, previousLine : string;
  FirstAnimeFound, scriptFound : Boolean;
begin
  aList := TStringList.Create;
  aList.AddStrings(bList);
  i := 0;
  //for i := 0 to aList.Count -1 do Begin
  while i < aList.Count do Begin
    sCrnt := aList.Strings[i];
    if isNewAnimBlock(sCrnt) = true then
      FirstAnimeFound := true;
    //iAnime := PosStr('anim',LowerCase(sCrnt));
      {if iAnime > 0 then
        newAnime := true;}

      //Detect scripts
      if (PosStr('@script',sCrnt) > 0) then
        scriptFound := true;
      if (PosStr('@end_script',sCrnt) > 0) then
        scriptFound := False;

      if (FirstAnimeFound = false) or
         (scriptFound = true) or
         (PosStr('#',sCrnt) > 0) then Begin
        aList.Strings[i] := sCrnt;
      end else Begin
        sCrnt := removeDbls(sCrnt);
        sCrnt := removeLast(sCrnt);
        sCrnt := removeMisc(sCrnt);

        if isNewAnimBlock(sCrnt) = false then
          sCrnt := formatValue(sCrnt, true)
        else Begin
          try
            previousLine := aList.Strings[i-1];
            if isLineEmpty(previousLine) = false then Begin
              aList.Insert(i,'');
              inc(i);
            end;
          except
          end;
          sCrnt := formatValue(sCrnt);
        end;


        aList.Strings[i] := sCrnt;
      end;
      inc(i);
  end;
  Result := aList;
end;

function TfrmFormat.formatValue(s: String; startTabbed:boolean): string;
Var
  s1, s2 : string;
begin
  s1 := s;
  Form1.StringDeleteFirstChar(s1,' ');
  Form1.StringDeleteFirstChar(s1,#09);
  Form1.StringDelete2End(s1,' ');
  Form1.StringDelete2End(s1,#09);

  s2 := s;
  Form1.StringDeleteUp2(s2,s1,length(s1)-1);
  Form1.StringDeleteFirstChar(s2,' ');
  Form1.StringDeleteFirstChar(s2,#09);
  Form1.StringDeleteLastChar(s2,' ');
  Form1.StringDeleteLastChar(s2,#09);

  if startTabbed = true then
    s := #09 + s1 + #09 + s2
  else
    s := s1 + #09 + s2;

  {Form1.StringDeleteFirstChar(s,' ');
  Form1.StringDeleteFirstChar(s,#09);
  s := #09 + s;}
  Result := s;
end;

procedure TfrmFormat.populateFile(fileName:String);
begin
  richOrg.Lines.LoadFromFile(fileName);
  richModded.Lines := format(richOrg.Lines);
  JvSaveDialog1.InitialDir := ExtractFilePath(fileName);
  JvOpenDialog1.InitialDir := ExtractFilePath(fileName);
  Edit1.Text := fileName;
end;

function TfrmFormat.removeDbls(s: string): string;
begin
  form1.StringReplace(s,'      ',#09);
  form1.StringReplace(s,'     ',#09);
  form1.StringReplace(s,'    ',#09);
  form1.StringReplace(s,'   ',#09);
  form1.StringReplace(s,'  ',' ');
  form1.StringReplace(s,#09#09,#09);
  Result := s;
end;

function TfrmFormat.removeLast(s: string): string;
begin
  Form1.StringDeleteLastChar(s,' ');
  Form1.StringDeleteLastChar(s,#09);

  Result := s;
end;

function TfrmFormat.removeMisc(s: string): string;
begin
  Form1.StringReplace(s,#09+' ',#09);
  Result := s;
end;

procedure TfrmFormat.richOrgVerticalScroll(Sender: TObject);
begin
  richModded.ScrollBars := richOrg.ScrollBars;

end;

procedure TfrmFormat.ToolButton1Click(Sender: TObject);
begin
  richModded.Lines.SaveToFile(Edit1.Text);
  ShowMessage('Succesfully Saved: ' + ExtractFileName(Edit1.Text));
end;

procedure TfrmFormat.ToolButton2Click(Sender: TObject);
begin
  if JvSaveDialog1.Execute then
    richModded.Lines.SaveToFile(JvSaveDialog1.FileName);
end;

procedure TfrmFormat.ToolButton4Click(Sender: TObject);
begin
  if JvOpenDialog1.Execute then Begin
    populateFile(JvOpenDialog1.FileName);
  end;
end;

end.
