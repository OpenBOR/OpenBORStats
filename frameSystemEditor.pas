unit frameSystemEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  xmlopenBorSystemClass, mario, unCommon, clsEntityDetails,
  Dialogs, StdCtrls, Buttons, JvExStdCtrls, JvRichEdit, ExtCtrls,
  JvExExtCtrls, JvNetscapeSplitter, JvgScrollBox, Mask, JvExMask,
  JvSpin, jvstrings, SynUniHighlighter,
  JvToolEdit, pngextra, ComCtrls, JvExComCtrls, JvComCtrls, SynEdit,
  SynCompletionProposal, SynEditHighlighter, SynHighlighterCpp,
  SynHighlighterCS;

type
  TfsystemEditor = class(TFrame)
    sbSystemEditor: TJvgScrollBox;
    GroupBox1: TGroupBox;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    pnlSingleReturn: TPanel;
    edtReturnValue: TEdit;
    pnlReturnMulti: TPanel;
    reMultiReturn: TJvRichEdit;
    JvNetscapeSplitter2: TJvNetscapeSplitter;
    pnlOpenSingle: TPanel;
    fEdtOpenSingle: TJvFilenameEdit;
    SpeedButton1: TSpeedButton;
    pnlOpenDbl: TPanel;
    fEdtOpenDbl1: TJvFilenameEdit;
    fEdtOpenDbl2: TJvFilenameEdit;
    SpeedButton2: TSpeedButton;
    pnlJoystick: TPanel;
    SpeedButton3: TSpeedButton;
    PNGButton1: TPNGButton;
    PNGButton2: TPNGButton;
    PNGButton3: TPNGButton;
    PNGButton4: TPNGButton;
    PNGButton5: TPNGButton;
    PNGButton6: TPNGButton;
    PNGButton7: TPNGButton;
    PNGButton8: TPNGButton;
    cbJoystickSpecials: TComboBox;
    edtJoystickResult: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    pnlBuild: TPanel;
    SpeedButton4: TSpeedButton;
    sbBuild: TJvgScrollBox;
    JvPageControl1: TJvPageControl;
    tabDescription: TTabSheet;
    tabScript: TTabSheet;
    Label1: TLabel;
    edtCommandName: TEdit;
    Label4: TLabel;
    edtVariables: TEdit;
    Label5: TLabel;
    cbMultipleType: TComboBox;
    cbInternalCommand: TComboBox;
    Label6: TLabel;
    edtLength: TEdit;
    Label2: TLabel;
    memValidEntries: TMemo;
    Label3: TLabel;
    Label7: TLabel;
    memDescription: TJvRichEdit;
    edtScrResult: TEdit;
    Label10: TLabel;
    edtScrFileName: TEdit;
    Label11: TLabel;
    cbScriptType: TComboBox;
    Label12: TLabel;
    Label13: TLabel;
    btnVariableHelp: TSpeedButton;
    Label14: TLabel;
    cbGroup: TComboBox;
    reScriptCode: TSynEdit;
    SynCompletionProposal1: TSynCompletionProposal;
    SynCSSyn1: TSynCSSyn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtReturnValueChange(Sender: TObject);
    procedure cbMultipleTypeCloseUp(Sender: TObject);
    procedure cbInternalCommandCloseUp(Sender: TObject);
    procedure PNGButton1Click(Sender: TObject);
    procedure cbJoystickSpecialsCloseUp(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure sBtnUpdateBuildClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnVariableHelpClick(Sender: TObject);
  private
    { Private declarations }

    rzData : ropenBorSystem;
    iNewName : integer;
    EntityDetails : TEntityDetails;
    procedure buildVariables;
    procedure clearVariables;
    function returnVariables(variableCommand:string;itemNumber:Integer):String;
    function buildVariableComponent(statsCommand:string;aParent:TComponent):TComponent;
    procedure loadHighlighter(aFilename:String; ExcludeHgl:Boolean=false);
  public
    { Public declarations }
    aSyn : TSynUniSyn;
    returnValue : String;
    returnValues : TStrings;
    procedure setMode(mode:integer);

    procedure formCreate;
    procedure populaterOpenBorSystem(rData:ropenBorSystem;zentityDetails : TEntityDetails);
    procedure formStartup(rtValue:string;rData:ropenBorSystem;zentityDetails : TEntityDetails); Overload;
    procedure formStartup(rtValue:Tstrings;rData:ropenBorSystem;zentityDetails : TEntityDetails); Overload;
    function retrieveData:ropenBorSystem;
  end;

implementation
uses
  unMain;

{$R *.dfm}

procedure TfsystemEditor.BitBtn2Click(Sender: TObject);
begin
  returnValue := edtReturnValue.Text;
end;

procedure TfsystemEditor.BitBtn1Click(Sender: TObject);
begin
  returnValue := '';
end;

procedure TfsystemEditor.populaterOpenBorSystem(rData: ropenBorSystem;zentityDetails : TEntityDetails);
Var
  s : String;
begin
  rzData := rData;
  EntityDetails := zentityDetails;
  fEdtOpenSingle.InitialDir := ses.characterDir;
  fEdtOpenDbl1.InitialDir := ses.characterDir;
  fEdtOpenDbl2.InitialDir := ses.characterDir;
  try
    if returnValues <> nil then
      returnValues.Clear;
  except
    returnValues := TStrings.Create;
  end;
  edtCommandName.Text := rData.title;
  cbGroup.Text := rData.Group;
  try
    if rData.lgth <> '' then Begin
      if StrToInt(rData.lgth) > 0 then
        edtLength.Text := rData.lgth
      else
        edtLength.Text := '';
    end else
      edtLength.Text := '';
  except
    edtLength.Text := '';
  end;
  edtVariables.Text := rData.avar;
  memDescription.Lines.Text := rData.dscrp;
  try
    if rData.vald <> '' then
      memValidEntries.Lines := MatString2List(rData.vald,',')
    else
      memValidEntries.Lines.Text := '';
  except
    memValidEntries.Lines.Text := '';
  end;
  try
    if rData.Multiple >= 0 then
      cbMultipleType.ItemIndex := rData.Multiple
    else
      cbMultipleType.ItemIndex := 0;
  except
    cbMultipleType.ItemIndex := 0;
  end;
  try
    if rData.iCommand >= 0 then
      cbInternalCommand.ItemIndex := rData.iCommand
    else
      cbInternalCommand.ItemIndex := 0;
  except
    cbInternalCommand.ItemIndex := 0;
  end;
  cbMultipleTypeCloseUp(cbMultipleType);
  cbInternalCommandCloseUp(cbInternalCommand);
  //Script
  edtScrResult.Text := rData.ScrResult;
  edtScrFileName.Text := rData.ScrName;
  reScriptCode.Text := rData.ScrCode;
  cbScriptType.ItemIndex := rData.ScrType;
end;

procedure TfsystemEditor.formStartup(rtValue: string;
  rData: ropenBorSystem;zentityDetails : TEntityDetails);
begin
  iNewName := 0;
  EntityDetails := zentityDetails;
  edtReturnValue.Text := '';
  reMultiReturn.Lines.Clear;
  rzData := rData;
  //StringReplace(rtValue,#09,' ');
  rtValue := strClearAll(rtValue);
  if posstr('@cmd',LowerCase(rtValue)) > 0 then Begin
    StringDeleteUp2(rtValue,edtCommandName.Text,length(edtCommandName.Text)-1);
  end else
    StringDeleteUp2(rtValue,' ');
  edtReturnValue.Text := rtValue;
  populaterOpenBorSystem(rData,zEntityDetails);
  try
    if returnValues <> nil then
      returnValues.Clear;
  except
    returnValues := TStringList.Create;
  end;
end;

procedure TfsystemEditor.edtReturnValueChange(Sender: TObject);
begin
  returnValue := edtReturnValue.Text;
end;

function TfsystemEditor.retrieveData: ropenBorSystem;
Var
  rData : ropenBorSystem;
  s : string;
begin
  
  rData := rzData;
  rData.title := LowerCase(edtCommandName.Text);
  rData.Group := cbGroup.Text;
  rData.dscrp := memDescription.Text;
  rData.vald := matListToStr(memValidEntries.Lines,',');
  if edtLength.Text <> '' then
    rData.lgth := edtLength.Text
  else
    rData.lgth := '0';
  rData.avar := edtVariables.Text;
  rData.Multiple := cbMultipleType.ItemIndex;
  rData.iCommand := cbInternalCommand.ItemIndex;
  //Script
  rData.ScrResult := edtScrResult.Text;
  rData.ScrName := edtScrFileName.Text;
  s := reScriptCode.Lines.Strings[reScriptCode.Lines.count];
  if s <> '' then
    reScriptCode.Lines.Add('');
  rData.ScrCode := reScriptCode.Lines.Text;
  rData.ScrType := cbScriptType.ItemIndex;
  result := rData;
end;

procedure TfsystemEditor.setMode(mode: integer);
begin
  case mode of
    0 : Begin
      //Retrieval mode
         edtCommandName.ReadOnly := True;
         edtLength.ReadOnly := True;
         edtVariables.ReadOnly := True;
         memValidEntries.ReadOnly := True;
         memDescription.ReadOnly := True;
         cbMultipleType.Visible := false;
         cbInternalCommand.Visible := false;
         {if config.debugmode = false then
           JvPageControl1.HideAllTabs := true;}
         btnVariableHelp.Visible := false;

    end;
    1 : Begin
      //Edit Mode
         //pnlReturnValue.Visible := false;
         edtCommandName.ReadOnly := false;
         edtLength.ReadOnly := false;
         edtVariables.ReadOnly := false;
         memValidEntries.ReadOnly := false;
         memDescription.ReadOnly := false;
         cbMultipleType.Visible := true;
         cbInternalCommand.Visible := True;
         //JvPageControl1.HideAllTabs := true;
         JvPageControl1.HideAllTabs := false;
         btnVariableHelp.Visible := True;
    end;
  end;
end;

procedure TfsystemEditor.cbMultipleTypeCloseUp(Sender: TObject);
begin
  case cbMultipleType.ItemIndex of
    0: Begin
         pnlSingleReturn.Visible := True;
         pnlSingleReturn.Top := 315;
         pnlReturnMulti.Visible := false;
         {try
           if edtReturnValue.Visible = true then
             edtReturnValue.SetFocus;
         except
         end;   }
    end;
    1: Begin
         pnlSingleReturn.Visible := false;
         pnlReturnMulti.Visible := true;
         pnlReturnMulti.Top := 315;
         {try
           if reMultiReturn.Visible = true then
             reMultiReturn.SetFocus;
         except
         end; }
    end;
  end;
end;

procedure TfsystemEditor.cbInternalCommandCloseUp(Sender: TObject);
begin
  clearVariables;
  case cbInternalCommand.ItemIndex of
    0: Begin
        //None
         pnlOpenSingle.Visible := false;
         pnlOpenDbl.Visible := false;
         pnlJoystick.Visible := false;
         pnlBuild.Visible := false;
       end;
    1: Begin
        //Single open
         pnlOpenSingle.Visible := true;
         pnlOpenDbl.Visible := false;
         pnlJoystick.Visible := false;
         pnlBuild.Visible := false;
       end;
    2: Begin
        //Double open
         pnlOpenSingle.Visible := false;
         pnlOpenDbl.Visible := true;
         pnlJoystick.Visible := false;
         pnlBuild.Visible := false;
       end;
    3: Begin
         //Joystick
         pnlOpenSingle.Visible := false;
         pnlOpenDbl.Visible := false;
         pnlJoystick.Visible := true;
         edtJoystickResult.Text := '';
         pnlBuild.Visible := false;
       end;
    4: Begin
         //Auto Build
         pnlOpenSingle.Visible := false;
         pnlOpenDbl.Visible := false;
         pnlJoystick.Visible := false;
         pnlBuild.Visible := True;
         edtJoystickResult.Text := '';
         buildVariables;
       end;
  end;
end;

procedure TfsystemEditor.formStartup(rtValue: Tstrings;
  rData: ropenBorSystem;zentityDetails : TEntityDetails);
Var
  i : Integer;
  s : string;
begin
  iNewName := 0;
  EntityDetails := zentityDetails;
  edtReturnValue.Text := '';
  reMultiReturn.Clear;
  for i := 0 to rtValue.Count -1 do Begin
    s := rtValue.Strings[i];
    StringReplace(s,#09,' ');
    StringDeleteUp2(s,' ');
    reMultiReturn.Lines.Add(s);
  end;
  populaterOpenBorSystem(rData,zentityDetails);
end;

procedure TfsystemEditor.PNGButton1Click(Sender: TObject);
begin
  edtJoystickResult.Text := edtJoystickResult.Text + ' ' + (Sender as TPNGButton).Hint;
end;

procedure TfsystemEditor.cbJoystickSpecialsCloseUp(Sender: TObject);
begin
  edtJoystickResult.Text := edtJoystickResult.Text + ' ' + cbJoystickSpecials.Items.Strings[cbJoystickSpecials.ItemIndex]
end;

procedure TfsystemEditor.SpeedButton3Click(Sender: TObject);
var
  s : string;
begin
  if edtJoystickResult.Text = '' then
    exit;
  s := edtJoystickResult.Text;
  case cbMultipleType.ItemIndex of
    0 : Begin
          edtReturnValue.Text := s;
        end;
    1 : Begin
          if reMultiReturn.CaretPos.Y > 0 then
            reMultiReturn.Lines.Strings[reMultiReturn.CaretPos.Y] := s
          else
            reMultiReturn.Lines.Add(s);
        end;
  end;
end;

procedure TfsystemEditor.SpeedButton1Click(Sender: TObject);
var
  s : string;
begin
  if fEdtOpenSingle.FileName = '' then
    exit;
  s := lowercase(fEdtOpenSingle.Text);
  StringReplace(s,'\','/');
  StringDeleteUp2(s,'/data/');
  case cbMultipleType.ItemIndex of
    0 : Begin
          edtReturnValue.Text := s;
        end;
    1 : Begin
          if reMultiReturn.CaretPos.Y > 0 then
            reMultiReturn.Lines.Strings[reMultiReturn.CaretPos.Y] := s
          else
            reMultiReturn.Lines.Add(s);
        end;
  end;
end;

procedure TfsystemEditor.SpeedButton2Click(Sender: TObject);
var
  s, s1 : string;
begin
  if fEdtOpenDbl1.FileName = '' then
    exit;
  s := lowercase(fEdtOpenDbl1.Text);
  s1 := lowercase(fEdtOpenDbl2.Text);
  StringReplace(s,'\','/');
  StringDeleteUp2(s,'/data/');
  StringReplace(s1,'\','/');
  StringDeleteUp2(s1,'/data/');
  s := s + ' ' + s1;
  case cbMultipleType.ItemIndex of
    0 : Begin
          edtReturnValue.Text := s;
        end;
    1 : Begin
          if reMultiReturn.CaretPos.Y > 0 then
            reMultiReturn.Lines.Strings[reMultiReturn.CaretPos.Y] := s
          else
            reMultiReturn.Lines.Add(s);
        end;
  end;
end;

procedure TfsystemEditor.buildVariables;
Var
  i : integer;
  s : string;
  variableList : TStringList;
  aWin : TComponent;
begin
  //memValidEntries.Lines := MatString2List(rData.vald,',')
  variableList := MatString2List(edtVariables.Text,',');
  i := variableList.Count -1;
  while i >= 0 do Begin
    s := variableList.Strings[i];
    if s <> '' then Begin
      aWin := buildVariableComponent(s,sbBuild);
      if aWin is TEdit then Begin
        (aWin as TEdit).Parent := sbBuild;
        (aWin as TEdit).Align := alLeft;
        (aWin as TEdit).Left := 0;
        (aWin as TEdit).Tag := i;
      end;
      if aWin is TComboBox then Begin
        (aWin as TComboBox).Parent := sbBuild;
        (aWin as TComboBox).Align := alLeft;
        (aWin as TComboBox).Left := 0;
        (aWin as TComboBox).Tag := i;
      end;
      if aWin is TJvSpinEdit then Begin
        (aWin as TJvSpinEdit).Parent := sbBuild;
        (aWin as TJvSpinEdit).Align := alLeft;
        (aWin as TJvSpinEdit).Left := 0;
        (aWin as TJvSpinEdit).Tag := i;
      end;
      if aWin is TCheckBox then Begin
        (aWin as TCheckBox).Parent := sbBuild;
        (aWin as TCheckBox).Align := alLeft;
        (aWin as TCheckBox).Left := 0;
        (aWin as TCheckBox).Tag := i;
      end;
      if aWin is TJvFilenameEdit then Begin
        (aWin as TJvFilenameEdit).Parent := sbBuild;
        (aWin as TJvFilenameEdit).Align := alLeft;
        (aWin as TJvFilenameEdit).Left := 0;
        (aWin as TJvFilenameEdit).Tag := i;
      end;
    end;
    i := i -1;
  end;
  //Create Updated Button
  aWin := TSpeedButton.Create(sbBuild);
  (aWin as TSpeedButton).Parent := sbBuild;
  (aWin as TSpeedButton).Hint := 'Create Code';
  (aWin as TSpeedButton).ShowHint := True;
  (aWin as TSpeedButton).Align := alRight;
  (aWin as TSpeedButton).Glyph := SpeedButton1.Glyph;
  (aWin as TSpeedButton).OnClick := sBtnUpdateBuildClick;
end;

function TfsystemEditor.buildVariableComponent(
  statsCommand: string; aParent:TComponent):TComponent;
Var
  aWin : TComponent;
begin
  aWin := nil;
  inc(iNewName);
  statsCommand := strClearAll(statsCommand);
  //Create Combo Box
  if (statsCommand = 'entity') then Begin
    aWin := TComboBox.Create(aParent);
    (aWin as TComboBox).Name := 'Item'+IntToStr(iNewName);
    (aWin as TComboBox).ShowHint := True;
    (aWin as TComboBox).hint := statsCommand;
    (aWin as TComboBox).Parent := sbBuild;
    (aWin as TComboBox).Items := Form1.models.listEntities;
    (aWin as TComboBox).Text := '';
    //(aWin as TComboBox).Parent := aParent;
  end;
  if (statsCommand = 'animation') then Begin
    aWin := TComboBox.Create(aParent);
    (aWin as TComboBox).Name := 'Item'+IntToStr(iNewName);
    //(aWin as TComboBox).Parent := aParent;
    (aWin as TComboBox).Text := '';
    (aWin as TComboBox).Parent := aParent as TWinControl;
    (aWin as TComboBox).hint := statsCommand;
    (aWin as TComboBox).ShowHint := True;
    if EntityDetails <> nil then
      (aWin as TComboBox).Items.Text := EntityDetails.list.Text;
  end;
  //Create Spin Box
  if (statsCommand = 'frame') then Begin
    aWin := TJvSpinEdit.Create(aParent);
    (aWin as TJvSpinEdit).Name := 'Spin'+IntToStr(iNewName);
    //(aWin as TJvSpinEdit).Parent := aParent;
    (aWin as TJvSpinEdit).ValueType := vtInteger;
    (aWin as TJvSpinEdit).hint := statsCommand;
    (aWin as TJvSpinEdit).ShowHint := True;
  end;
  if (statsCommand = 'int') then Begin
    aWin := TJvSpinEdit.Create(aParent);
    (aWin as TJvSpinEdit).Name := 'Spin'+IntToStr(iNewName);
    //(aWin as TJvSpinEdit).Parent := aParent;
    (aWin as TJvSpinEdit).ValueType := vtInteger;
    (aWin as TJvSpinEdit).hint := statsCommand;
    (aWin as TJvSpinEdit).ShowHint := True;
  end;
  if (statsCommand = 'float') then Begin
    aWin := TJvSpinEdit.Create(aParent);
    (aWin as TJvSpinEdit).Name := 'Spin'+IntToStr(iNewName);
    //(aWin as TJvSpinEdit).Parent := aParent;
    (aWin as TJvSpinEdit).ValueType := vtFloat;
    (aWin as TJvSpinEdit).hint := statsCommand;
    (aWin as TJvSpinEdit).ShowHint := True;
  end;
  //Check Box
  if (statsCommand = 'bool') then Begin
    aWin := TCheckBox.Create(aParent);
    (aWin as TCheckBox).Name := 'check'+IntToStr(iNewName);
    //(aWin as TCheckBox).Parent := aParent;
    (aWin as TCheckBox).Caption := 'False';
    (aWin as TCheckBox).hint := statsCommand;
    (aWin as TCheckBox).ShowHint := True;
    (aWin as TCheckBox).OnClick := CheckBox1Click;
  end;
  if (statsCommand = 'bi') then Begin
    aWin := TCheckBox.Create(aParent);
    (aWin as TCheckBox).Name := 'check'+IntToStr(iNewName);
    //(aWin as TCheckBox).Parent := aParent;
    (aWin as TCheckBox).Caption := 'False';
    (aWin as TCheckBox).hint := statsCommand;
    (aWin as TCheckBox).ShowHint := True;
    (aWin as TCheckBox).OnClick := CheckBox1Click;
  end;
  //OpenDialog
  if (statsCommand = 'path') then Begin
    aWin := TJvFilenameEdit.Create(aParent);
    (aWin as TJvFilenameEdit).Name := 'fOpen'+IntToStr(iNewName);
    //(aWin as TCheckBox).Parent := aParent;
    (aWin as TJvFilenameEdit).hint := statsCommand;
    (aWin as TJvFilenameEdit).ShowHint := True;
    (aWin as TJvFilenameEdit).InitialDir := ses.characterDir;
    (aWin as TJvFilenameEdit).Filter := 'All files (*.*)|*.*|Image Files (*.gif)|*.gif|Sound Files (*.wav)|*.wav|codeScript Files (*.c)|*.c'
  end;

  //Create edit box if unknown
  if aWin = nil then Begin
    aWin := TEdit.Create(aParent);
    (aWin as TEdit).Name := 'edit'+IntToStr(iNewName);
    (aWin as TEdit).hint := statsCommand;
    (aWin as TEdit).ShowHint := True;
    (aWin as TEdit).Text := '';
    //(aWin as TEdit).Parent := aParent;
  end;

  Result := aWin;
end;

procedure TfsystemEditor.clearVariables;
Var
  i : integer;
  aWin : TObject;
begin
  i := 0;
  while i < sbBuild.ComponentCount do Begin
    aWin := sbBuild.Components[i] as TObject;
    Try
      if aWin <> nil then
        FreeAndNil(aWin as TObject)
      else
        inc(i);
    Except
      inc(i);
    end;

  end;
end;

procedure TfsystemEditor.CheckBox1Click(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked = true then
    (Sender as TCheckBox).Caption := 'True'
  else
    (Sender as TCheckBox).Caption := 'False';
end;

procedure TfsystemEditor.sBtnUpdateBuildClick(Sender: TObject);
Var
  i : integer;
  s, sRtrn : string;
  variableList : TStringList;
  aWin : TComponent;
begin
  //memValidEntries.Lines := MatString2List(rData.vald,',')
  variableList := MatString2List(edtVariables.Text,',');
  i := 0;
  while i < variableList.Count do Begin
    s := variableList.Strings[i];
    if s <> '' then
      sRtrn := sRtrn + ' ' + returnVariables(s,i);
    inc(i);
  end;
  case cbMultipleType.ItemIndex of
    0: edtReturnValue.Text := sRtrn;
    1: Begin
         if reMultiReturn.CaretPos.Y > 0 then
            reMultiReturn.Lines.Strings[reMultiReturn.CaretPos.Y] := sRtrn
          else
            reMultiReturn.Lines.Add(sRtrn);
       end;
  end;
end;

function TfsystemEditor.returnVariables(variableCommand: string;itemNumber:Integer): String;
Var
  i : integer;
  aWin : TObject;
  s : string;
begin
  i := 0;
  s := '';
  while i < sbBuild.ComponentCount do Begin
    aWin := sbBuild.Components[i] as Tobject;
    if aWin is TEdit then
      if (aWin as TEdit).Tag = itemNumber then
        if (aWin as TEdit).Hint = variableCommand then Begin
          if ses.ropenBorSystemSelected.htyp = 9 then
            s := '"'+(aWin as TEdit).Text+'"'
          else
            s := (aWin as TEdit).Text;
        end;
    if aWin is TCheckBox then
      if (aWin as TCheckBox).Tag = itemNumber then
        if (aWin as TCheckBox).Hint = variableCommand then Begin
          s := IntToStr(Bool2Int(((aWin as TCheckBox).checked)));
        end;
    if aWin is TJvFilenameEdit then
      if (aWin as TJvFilenameEdit).Tag = itemNumber then
        if (aWin as TJvFilenameEdit).Hint = variableCommand then Begin
          if ses.ropenBorSystemSelected.htyp = 9 then
            s := '"'+File2BorFile((aWin as TJvFilenameEdit).Text)+'"'
          else
           s := File2BorFile((aWin as TJvFilenameEdit).Text);
        end;
    if aWin is TJvSpinEdit then
      if (aWin as TJvSpinEdit).Tag = itemNumber then
        if (aWin as TJvSpinEdit).Hint = variableCommand then Begin
          s := FloatToStr((aWin as TJvSpinEdit).Value);
        end;
    if aWin is TComboBox then
      if (aWin as TComboBox).Tag = itemNumber then
        if (aWin as TComboBox).Hint = variableCommand then Begin
          if (aWin as TComboBox).Hint = 'animation' then Begin
            if ses.ropenBorSystemSelected.htyp = 9 then
              s := '"'+'ANI_' + (aWin as TComboBox).Text+'"'
            else
              s := (aWin as TComboBox).Text;
          end else
            if ses.ropenBorSystemSelected.htyp = 9 then
              s := '"'+ (aWin as TComboBox).Text+'"'
            else
              s := (aWin as TComboBox).Text;
        end;
    inc(i);
  end;
  result := s;
end;

procedure TfsystemEditor.btnVariableHelpClick(Sender: TObject);
begin
  showBubble('Variable Commands',
             'entity	   = Lists all available entities in a ComboBox.' + #13
             + 'animation  = Lists all available anim Types that the Entity has in a ComboBox.' +#13
             + 'frame      = Lists amount of frames there are available and will insert the command into in a ComboBox.' +#13
             + 'key        = Displays joystick. #' +#13
             + 'int        = Displays a SpinEdit Box.' +#13
             + 'float      = Displays a SpinEdit Box with float support.' +#13
             + 'bool       = Displays a Check Box and returns a Integer.' +#13
             + 'bi         = Displays a Check Box and returns a Integer.' +#13
             + 'null       = Displays a edit box.' +#13
             , 10000);
end;

procedure TfsystemEditor.formCreate;
begin
 { if aSyn = nil then
    aSyn := TSynUniSyn.Create(reScriptCode);
  loadHighlighter('C++ Source');}
end;

procedure TfsystemEditor.loadHighlighter(aFilename: String;
  ExcludeHgl: Boolean);
Var
  s : String;
begin
  Try
  s := ExtractFilePath(Application.ExeName)+'Highlighters\'+aFilename+'.hgl';
  If FileExists(s) then Begin
    if ExcludeHgl = false then
      aSyn.LoadHglFromFile(s);
    reScriptCode.Highlighter := aSyn;
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

end.
