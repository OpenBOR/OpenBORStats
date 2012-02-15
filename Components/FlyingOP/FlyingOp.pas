unit FlyingOp;

{-----------------------------------------------------------------------------}
{ TFlyingOp v 1.01                                                            }
{-----------------------------------------------------------------------------}
{ A component to encapsulate the Win95 ShFileOperation                        }
{ Copyright 1998, Eric Pedrazzi.  All Rights Reserved.                        }
{ This component can be freely used and distributed in commercial and private }
{ environments, provied this notice is not modified in any way and there is   }
{ no charge for it other than nomial handling fees.  Contact me directly for  }
{ modifications to this agreement.                                            }
{-----------------------------------------------------------------------------}
{ Feel free to contact me if you have any questions, comments or suggestions  }
{ at epedrazzi@chez.com                                                       }
{ The lateset version will always be available on the web at:                 }
{   http://www.chez.com/epedrazzi/epdelphuk or                                }
{   http://www.chez.com/epedrazzi/epdelphfr                                   }
{ See FlyingOp.txt for notes, known issues, and revision history.             }
{-----------------------------------------------------------------------------}
{ Date last modified:  October 13, 1998                                       }
{-----------------------------------------------------------------------------}
{ v1.0 : Initial release                                                      }
{ v1.01 : Added CreateDirectory property                                      }
{-----------------------------------------------------------------------------}

{ This unit provides a component to perform file oprations using the ShFileOperation
  windows API, showing the standard "flying files" dialog box.

  Properties
  ----------
**CreateDirectory      : true to create directory without confirmation dialog
  SourceDirectory      : self explanatory
  DestinationDirectory : self explanatory
  FileMask             : self explanatory (*.db, *.*, ....)
  RecurseDirectory     : true to recurse directory when calling SearchForFiles methods
  FileList             : TStringList containing the files to process

  Methods
  -------
  SearchForFiles : Recursive procedure to search files according to the properties,
                   storing result in the FileList property
  ExecCopy       : procedure, no parameter, self explanatory
  ExecDelete     : procedure, no parameter, self explanatory
  ExecMove       : procedure, no parameter, self explanatory

}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, ShlObj, ShellApi;

type
  TFlyingOp = class(TComponent)
  private
    { Dclarations prives }
    FStringList : TStringList;
    FSourceDirectory : AnsiString;
    FDestinationDirectory : AnsiString;
    FFileMask : AnsiString;
    FRecurseDirectory : Boolean;
    FFileList : TStringList;
    FCreateDirectory : Boolean;
    FOverrideFile: boolean;
    procedure FSearchForFiles(path, mask : AnsiString; var Value : TStringList; brec : Boolean);
    function FExecuteOp(idOp : UINT): boolean;
    procedure SetOverrideFile(const Value: boolean);
  protected
    { Dclarations protges }
    procedure SetFileList (Value : TStringList);
  public
    { Dclarations publiques }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SearchForFiles;
    function ExecCopy: boolean;
    procedure ExecDelete;
    procedure ExecMove;
  published
    { Dclarations publies }
    property SourceDirectory : AnsiString read FSourceDirectory write FSourceDirectory;
    property DestinationDirectory : AnsiString read FDestinationDirectory write FDestinationDirectory;
    property FileMask : AnsiString read FFileMask write FFileMask;
    property RecurseDirectory : Boolean read FRecurseDirectory write FRecurseDirectory;
    property FileList : TStringList read FFileList write SetFileList;
    property CreateDirectory : Boolean read FCreateDirectory write FCreateDirectory;
    property OverrideFile: boolean read FOverrideFile write SetOverrideFile;
  end;

procedure Register;

implementation

procedure TFlyingOp.FSearchForFiles(path, mask : AnsiString; var Value : TStringList; brec : Boolean);
var
  srRes : TSearchRec;
  iFound : Integer;
begin
  if ( brec ) then
    begin
    // Fr : On doit d'abord chercher les rpertoires
    // Eng: First, we must search the directories
    if path[Length(path)] <> '\' then path := path +'\';
    iFound := FindFirst( path + '*.*', faAnyfile, srRes );
    while iFound = 0 do
      begin
      if ( srRes.Name <> '.' ) and ( srRes.Name <> '..' ) then
        if srRes.Attr and faDirectory > 0 then
          FSearchForFiles( path + srRes.Name, mask, Value, brec );
      iFound := FindNext(srRes);
      end;
    FindClose(srRes);
    end;

  // Fr  : Arriv ici, on ne doit plus traiter les rpertoires
  // Eng : Now, we don't treat the directories anymore

  if path[Length(path)] <> '\' then path := path +'\';

  iFound := FindFirst(path+mask, faAnyFile-faDirectory, srRes);
  while iFound = 0 do
    begin
    if ( srRes.Name <> '.' ) and ( srRes.Name <> '..' ) and ( srRes.Name <> '' ) then
      Value.Add(path+srRes.Name);
    iFound := FindNext(srRes);
    end;
  FindClose( srRes );
end;

constructor TFlyingOp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFileList := TStringList.Create;
end;

destructor TFlyingOp.Destroy;
begin
  FFileList.Free;
  inherited Destroy;
end;

procedure TFlyingOp.SetFileList(Value: TStringList);
begin
  FFileList.Assign(Value);
end;

procedure TFlyingOp.SearchForFiles;
begin
  FStringList := TStringList.Create;
  try
    FSearchForFiles(FSourceDirectory, FFileMask, FStringList, FRecurseDirectory);
    SetFileList(FStringList);
  finally
    FStringList.Free;
  end;
end;

function TFlyingOp.ExecCopy: boolean;
begin
  result:= FExecuteOp(FO_COPY);
end;


procedure TFlyingOp.ExecDelete;
begin
  FExecuteOp(FO_DELETE);
end;

procedure TFlyingOp.ExecMove;
begin
  FExecuteOp(FO_MOVE);
end;

function TFlyingOp.FExecuteOp(idOp : UINT): boolean;
var
  i : Integer;
  F : TShFileOpStruct;
  sFic, sFrom, sTo : AnsiString;
begin
  if FFileList.Count = 0 then Exit;

  for i:=0 to FFileList.Count-1 do
  begin
    sFic  := Copy(FFileList[i], Length(FSourceDirectory)+1, Length(FFileList[i]));
    sFrom := sFrom + FSourceDirectory + sFic + #0;
    if idOp <> FO_DELETE then sTo := sTo + FDestinationDirectory + sFic + #0;
  end;

  F.Wnd    := GetActiveWindow; // return active window Hwnd
  F.wFunc  := idOp;            // FO_COPY, FO_MOVE, FO_DELETE
  F.pFrom  := PChar(sFrom);

  if idOp <> FO_DELETE then begin
    F.pTo    := PChar(sTo);
    F.fFlags := FOF_ALLOWUNDO or FOF_MULTIDESTFILES;
    if FCreateDirectory then
      F.fFlags := F.fFlags or FOF_NOCONFIRMMKDIR;
    if FOverrideFile then
      F.fFlags := F.fFlags or FOF_NOCONFIRMATION;
  end
  else
    F.fFlags := FOF_ALLOWUNDO;
  result := ShFileOperation(F) = 0;
  if not result then
    if F.fAnyOperationsAborted then
      MessageBox(F.Wnd,Pchar('Operation aborted'),nil,ID_OK)
    else
      MessageBox(F.Wnd,Pchar('Error!'),nil,ID_OK);

  sFrom := ''; sTo := '';
end;


procedure Register;
begin
  RegisterComponents('VCL', [TFlyingOp]);
end;

procedure TFlyingOp.SetOverrideFile(const Value: boolean);
begin
  FOverrideFile := Value;
end;

end.
