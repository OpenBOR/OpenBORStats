unit formEditor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvRichEdit, ToolWin, ComCtrls,
  JvExComCtrls, JvToolBar;

type
  TfrmEditor = class(TForm)
    JvToolBar1: TJvToolBar;
    JvRichEdit1: TJvRichEdit;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    edtFileName: TEdit;
    tbSave: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    procedure ToolButton1Click(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure updateVisuals;
  public
    { Public declarations }
    mode : Integer;
    
    procedure populateEditor(filename:String;gotoLine:integer=0;forceFormat:Boolean=false); Overload;
    procedure populateEditor(listData:TStringList); Overload;
  end;

var
  frmEditor: TfrmEditor;

implementation
Uses
  unMain, formFormat;

{$R *.dfm}

{ TfrmEditor }

procedure TfrmEditor.populateEditor(filename: String; gotoLine: integer;forceFormat:Boolean);
Var
  aCur : TPoint;
begin
  if FileExists(filename) then Begin
    Form1.JvOpenDialog1.InitialDir := ExtractFilePath(filename);
    Form1.JvSaveDialog1.InitialDir := ExtractFilePath(filename);
    edtFileName.Text := filename;
    aCur.x := 0;
    aCur.Y := gotoLine;
    JvRichEdit1.Lines.LoadFromFile(filename);
    if forceFormat = true then
      JvRichEdit1.Lines :=  frmFormat.format(JvRichEdit1.Lines);
    updateVisuals;
    try
      Application.ProcessMessages;
      JvRichEdit1.CaretPos := aCur;
      JvRichEdit1.ScreenToClient(aCur);
    except
    end;
  end;
end;

procedure TfrmEditor.ToolButton1Click(Sender: TObject);
begin
  if Form1.JvOpenDialog1.Execute then Begin
    populateEditor(Form1.JvOpenDialog1.FileName);
  end;
end;

procedure TfrmEditor.tbSaveClick(Sender: TObject);
begin
  JvRichEdit1.Lines.SaveToFile(edtFileName.Text);
  ShowMessage('Succesfully saved: '+edtFileName.Text);
end;

procedure TfrmEditor.ToolButton5Click(Sender: TObject);
begin
  if Form1.JvSaveDialog1.Execute then Begin
    JvRichEdit1.Lines.SaveToFile(Form1.JvSaveDialog1.FileName);
    ShowMessage('Succesfully saved: ' + Form1.JvSaveDialog1.FileName);
  end;
end;

procedure TfrmEditor.ToolButton6Click(Sender: TObject);
begin
  JvRichEdit1.Lines :=  frmFormat.format(JvRichEdit1.Lines);
end;

procedure TfrmEditor.ToolButton8Click(Sender: TObject);
begin
  JvRichEdit1.Undo;
end;

procedure TfrmEditor.ToolButton9Click(Sender: TObject);
begin
  JvRichEdit1.Redo;
end;

procedure TfrmEditor.FormShow(Sender: TObject);
begin
  JvRichEdit1.SetFocus;
end;

procedure TfrmEditor.updateVisuals;
begin
  case mode of
    1: Begin
      tbSave.Visible := false;

    end
    else Begin
      tbSave.Visible := True;
    end;
  end;
end;

procedure TfrmEditor.populateEditor(listData: TStringList);
begin
  mode := 1;
  JvRichEdit1.Lines := listData;
  updateVisuals;
end;

end.
