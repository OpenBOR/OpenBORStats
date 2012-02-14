unit frmSynSearch;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TTextSearchDialog1 = class(TForm)
    Label1: TLabel;
    cbSearchText: TComboBox;
    rgSearchDirection: TRadioGroup;
    gbSearchOptions: TGroupBox;
    cbSearchCaseSensitive: TCheckBox;
    cbSearchWholeWords: TCheckBox;
    cbSearchFromCursor: TCheckBox;
    cbSearchSelectedOnly: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    cbRegularExpression: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetSearchBackwards: boolean;
    function GetSearchCaseSensitive: boolean;
    function GetSearchFromCursor: boolean;
    function GetSearchInSelection: boolean;
    function GetSearchText: string;
    function GetSearchTextHistory: string;
    function GetSearchWholeWords: boolean;
    procedure SetSearchBackwards(Value: boolean);
    procedure SetSearchCaseSensitive(Value: boolean);
    procedure SetSearchFromCursor(Value: boolean);
    procedure SetSearchInSelection(Value: boolean);
    procedure SetSearchText(Value: string);
    procedure SetSearchTextHistory(Value: string);
    procedure SetSearchWholeWords(Value: boolean);
    procedure SetSearchRegularExpression(const Value: boolean);
    function GetSearchRegularExpression: boolean;
  public
    property SearchBackwards: boolean read GetSearchBackwards
      write SetSearchBackwards;
    property SearchCaseSensitive: boolean read GetSearchCaseSensitive
      write SetSearchCaseSensitive;
    property SearchFromCursor: boolean read GetSearchFromCursor
      write SetSearchFromCursor;
    property SearchInSelectionOnly: boolean read GetSearchInSelection
      write SetSearchInSelection;
    property SearchText: string read GetSearchText write SetSearchText;
    property SearchTextHistory: string read GetSearchTextHistory
      write SetSearchTextHistory;
    property SearchWholeWords: boolean read GetSearchWholeWords
      write SetSearchWholeWords;
    property SearchRegularExpression: boolean read GetSearchRegularExpression
      write SetSearchRegularExpression;
  end;

implementation

{$R *.DFM}

{ TTextSearchDialog }

function TTextSearchDialog1.GetSearchBackwards: boolean;
begin
  Result := rgSearchDirection.ItemIndex = 1;
end;

function TTextSearchDialog1.GetSearchCaseSensitive: boolean;
begin
  Result := cbSearchCaseSensitive.Checked;
end;

function TTextSearchDialog1.GetSearchFromCursor: boolean;
begin
  Result := cbSearchFromCursor.Checked;
end;

function TTextSearchDialog1.GetSearchInSelection: boolean;
begin
  Result := cbSearchSelectedOnly.Checked;
end;

function TTextSearchDialog1.GetSearchRegularExpression: boolean;
begin
  Result := cbRegularExpression.Checked;
end;

function TTextSearchDialog1.GetSearchText: string;
begin
  Result := cbSearchText.Text;
end;

function TTextSearchDialog1.GetSearchTextHistory: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to cbSearchText.Items.Count - 1 do begin
    if i >= 10 then
      break;
    if i > 0 then
      Result := Result + #13#10;
    Result := Result + cbSearchText.Items[i];
  end;
end;

function TTextSearchDialog1.GetSearchWholeWords: boolean;
begin
  Result := cbSearchWholeWords.Checked;
end;

procedure TTextSearchDialog1.SetSearchBackwards(Value: boolean);
begin
  rgSearchDirection.ItemIndex := Ord(Value);
end;

procedure TTextSearchDialog1.SetSearchCaseSensitive(Value: boolean);
begin
  cbSearchCaseSensitive.Checked := Value;
end;

procedure TTextSearchDialog1.SetSearchFromCursor(Value: boolean);
begin
  cbSearchFromCursor.Checked := Value;
end;

procedure TTextSearchDialog1.SetSearchInSelection(Value: boolean);
begin
  cbSearchSelectedOnly.Checked := Value;
end;

procedure TTextSearchDialog1.SetSearchText(Value: string);
begin
  cbSearchText.Text := Value;
end;

procedure TTextSearchDialog1.SetSearchTextHistory(Value: string);
begin
  cbSearchText.Items.Text := Value;
end;

procedure TTextSearchDialog1.SetSearchWholeWords(Value: boolean);
begin
  cbSearchWholeWords.Checked := Value;
end;

procedure TTextSearchDialog1.SetSearchRegularExpression(
  const Value: boolean);
begin
  cbRegularExpression.Checked := Value;
end;

{ event handlers }

procedure TTextSearchDialog1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  s: string;
  i: integer;
begin
  if ModalResult = mrOK then begin
    s := cbSearchText.Text;
    if s <> '' then begin
      i := cbSearchText.Items.IndexOf(s);
      if i > -1 then begin
        cbSearchText.Items.Delete(i);
        cbSearchText.Items.Insert(0, s);
        cbSearchText.Text := s;
      end else
        cbSearchText.Items.Insert(0, s);
    end;
  end;
end;

end.

