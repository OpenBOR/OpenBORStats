
{**********************************************************************************************************************}
{                                                                                                                      }
{                                                   XML Data Binding                                                   }
{                                                                                                                      }
{         Generated on: 2009-07-11 15:28:03                                                                            }
{       Generated from: C:\Program Files\Borland\Delphi7\Bin\Mario\Home\openBorStats\xml Schema\xmlopenBorSystem.xsd   }
{                                                                                                                      }
{**********************************************************************************************************************}

unit xmlopenBorSystem;

interface

uses variants, xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTopenBorSystemDefList = interface;
  IXMLTopenBorSystemDef = interface;

{ IXMLTopenBorSystemDefList }

  IXMLTopenBorSystemDefList = interface(IXMLNodeCollection)
    ['{E03F6B15-C0EA-4042-87E6-6BD6EDA7640B}']
    { Property Accessors }
    function Get_TopenBorSystem(Index: Integer): IXMLTopenBorSystemDef;
    { Methods & Properties }
    function Add: IXMLTopenBorSystemDef;
    function Insert(const Index: Integer): IXMLTopenBorSystemDef;
    property TopenBorSystem[Index: Integer]: IXMLTopenBorSystemDef read Get_TopenBorSystem; default;
  end;

{ IXMLTopenBorSystemDef }

  IXMLTopenBorSystemDef = interface(IXMLNode)
    ['{3649177D-E84F-40A9-B0D4-581D735D9C5C}']
    { Property Accessors }
    function Get_Id: Integer;
    function Get_Gd: WideString;
    function Get_Title: WideString;
    function Get_Dscrp: WideString;
    function Get_Htyp: Integer;
    function Get_Vald: WideString;
    function Get_Lgth: WideString;
    function Get_Usd: WideString;
    function Get_Avar: WideString;
    function Get_Mltp: Integer;
    function Get_Icmd: Integer;
    function Get_Grp: WideString;
    function Get_Rslt: WideString;
    function Get_Scnme: WideString;
    function Get_Sccod: WideString;
    function Get_Sctyp: Integer;
    procedure Set_Id(Value: Integer);
    procedure Set_Gd(Value: WideString);
    procedure Set_Title(Value: WideString);
    procedure Set_Dscrp(Value: WideString);
    procedure Set_Htyp(Value: Integer);
    procedure Set_Vald(Value: WideString);
    procedure Set_Lgth(Value: WideString);
    procedure Set_Usd(Value: WideString);
    procedure Set_Avar(Value: WideString);
    procedure Set_Mltp(Value: Integer);
    procedure Set_Icmd(Value: Integer);
    procedure Set_Grp(Value: WideString);
    procedure Set_Rslt(Value: WideString);
    procedure Set_Scnme(Value: WideString);
    procedure Set_Sccod(Value: WideString);
    procedure Set_Sctyp(Value: Integer);
    { Methods & Properties }
    property Id: Integer read Get_Id write Set_Id;
    property Gd: WideString read Get_Gd write Set_Gd;
    property Title: WideString read Get_Title write Set_Title;
    property Dscrp: WideString read Get_Dscrp write Set_Dscrp;
    property Htyp: Integer read Get_Htyp write Set_Htyp;
    property Vald: WideString read Get_Vald write Set_Vald;
    property Lgth: WideString read Get_Lgth write Set_Lgth;
    property Usd: WideString read Get_Usd write Set_Usd;
    property Avar: WideString read Get_Avar write Set_Avar;
    property Mltp: Integer read Get_Mltp write Set_Mltp;
    property Icmd: Integer read Get_Icmd write Set_Icmd;
    property Grp: WideString read Get_Grp write Set_Grp;
    property Rslt: WideString read Get_Rslt write Set_Rslt;
    property Scnme: WideString read Get_Scnme write Set_Scnme;
    property Sccod: WideString read Get_Sccod write Set_Sccod;
    property Sctyp: Integer read Get_Sctyp write Set_Sctyp;
  end;

{ Forward Decls }

  TXMLTopenBorSystemDefList = class;
  TXMLTopenBorSystemDef = class;

{ TXMLTopenBorSystemDefList }

  TXMLTopenBorSystemDefList = class(TXMLNodeCollection, IXMLTopenBorSystemDefList)
  protected
    { IXMLTopenBorSystemDefList }
    function Get_TopenBorSystem(Index: Integer): IXMLTopenBorSystemDef;
    function Add: IXMLTopenBorSystemDef;
    function Insert(const Index: Integer): IXMLTopenBorSystemDef;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTopenBorSystemDef }

  TXMLTopenBorSystemDef = class(TXMLNode, IXMLTopenBorSystemDef)
  protected
    { IXMLTopenBorSystemDef }
    function Get_Id: Integer;
    function Get_Gd: WideString;
    function Get_Title: WideString;
    function Get_Dscrp: WideString;
    function Get_Htyp: Integer;
    function Get_Vald: WideString;
    function Get_Lgth: WideString;
    function Get_Usd: WideString;
    function Get_Avar: WideString;
    function Get_Mltp: Integer;
    function Get_Icmd: Integer;
    function Get_Grp: WideString;
    function Get_Rslt: WideString;
    function Get_Scnme: WideString;
    function Get_Sccod: WideString;
    function Get_Sctyp: Integer;
    procedure Set_Id(Value: Integer);
    procedure Set_Gd(Value: WideString);
    procedure Set_Title(Value: WideString);
    procedure Set_Dscrp(Value: WideString);
    procedure Set_Htyp(Value: Integer);
    procedure Set_Vald(Value: WideString);
    procedure Set_Lgth(Value: WideString);
    procedure Set_Usd(Value: WideString);
    procedure Set_Avar(Value: WideString);
    procedure Set_Mltp(Value: Integer);
    procedure Set_Icmd(Value: Integer);
    procedure Set_Grp(Value: WideString);
    procedure Set_Rslt(Value: WideString);
    procedure Set_Scnme(Value: WideString);
    procedure Set_Sccod(Value: WideString);
    procedure Set_Sctyp(Value: Integer);
  end;

{ Global Functions }

function GetTopenBorSystemList(Doc: IXMLDocument): IXMLTopenBorSystemDefList;
function LoadTopenBorSystemList(const FileName: WideString): IXMLTopenBorSystemDefList;
function NewTopenBorSystemList: IXMLTopenBorSystemDefList;

const
  TargetNamespace = '';

implementation

{ Global Functions }

function GetTopenBorSystemList(Doc: IXMLDocument): IXMLTopenBorSystemDefList;
begin
  Result := Doc.GetDocBinding('TopenBorSystemList', TXMLTopenBorSystemDefList, TargetNamespace) as IXMLTopenBorSystemDefList;
end;

function LoadTopenBorSystemList(const FileName: WideString): IXMLTopenBorSystemDefList;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('TopenBorSystemList', TXMLTopenBorSystemDefList, TargetNamespace) as IXMLTopenBorSystemDefList;
end;

function NewTopenBorSystemList: IXMLTopenBorSystemDefList;
begin
  Result := NewXMLDocument.GetDocBinding('TopenBorSystemList', TXMLTopenBorSystemDefList, TargetNamespace) as IXMLTopenBorSystemDefList;
end;

{ TXMLTopenBorSystemDefList }

procedure TXMLTopenBorSystemDefList.AfterConstruction;
begin
  RegisterChildNode('TopenBorSystem', TXMLTopenBorSystemDef);
  ItemTag := 'TopenBorSystem';
  ItemInterface := IXMLTopenBorSystemDef;
  inherited;
end;

function TXMLTopenBorSystemDefList.Get_TopenBorSystem(Index: Integer): IXMLTopenBorSystemDef;
begin
  Result := List[Index] as IXMLTopenBorSystemDef;
end;

function TXMLTopenBorSystemDefList.Add: IXMLTopenBorSystemDef;
begin
  Result := AddItem(-1) as IXMLTopenBorSystemDef;
end;

function TXMLTopenBorSystemDefList.Insert(const Index: Integer): IXMLTopenBorSystemDef;
begin
  Result := AddItem(Index) as IXMLTopenBorSystemDef;
end;

{ TXMLTopenBorSystemDef }

function TXMLTopenBorSystemDef.Get_Id: Integer;
begin
  Result := ChildNodes['id'].NodeValue;
end;

procedure TXMLTopenBorSystemDef.Set_Id(Value: Integer);
begin
  ChildNodes['id'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Gd: WideString;
begin
  Result := ChildNodes['gd'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Gd(Value: WideString);
begin
  ChildNodes['gd'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Title: WideString;
begin
  Result := ChildNodes['title'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Title(Value: WideString);
begin
  ChildNodes['title'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Dscrp: WideString;
begin
  Result := ChildNodes['dscrp'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Dscrp(Value: WideString);
begin
  ChildNodes['dscrp'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Htyp: Integer;
begin
  Result := ChildNodes['htyp'].NodeValue;
end;

procedure TXMLTopenBorSystemDef.Set_Htyp(Value: Integer);
begin
  ChildNodes['htyp'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Vald: WideString;
begin
  Result := ChildNodes['vald'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Vald(Value: WideString);
begin
  ChildNodes['vald'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Lgth: WideString;
begin
  Result := ChildNodes['lgth'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Lgth(Value: WideString);
begin
  ChildNodes['lgth'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Usd: WideString;
begin
  Result := ChildNodes['usd'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Usd(Value: WideString);
begin
  ChildNodes['usd'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Avar: WideString;
begin
  Result := ChildNodes['avar'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Avar(Value: WideString);
begin
  ChildNodes['avar'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Mltp: Integer;
begin
  Result := ChildNodes['mltp'].NodeValue;
end;

procedure TXMLTopenBorSystemDef.Set_Mltp(Value: Integer);
begin
  ChildNodes['mltp'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Icmd: Integer;
begin
  Result := ChildNodes['icmd'].NodeValue;
end;

procedure TXMLTopenBorSystemDef.Set_Icmd(Value: Integer);
begin
  ChildNodes['icmd'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Grp: WideString;
begin
  Result := ChildNodes['grp'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Grp(Value: WideString);
begin
  ChildNodes['grp'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Rslt: WideString;
begin
  Result := ChildNodes['rslt'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Rslt(Value: WideString);
begin
  ChildNodes['rslt'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Scnme: WideString;
begin
  Result := ChildNodes['scnme'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Scnme(Value: WideString);
begin
  ChildNodes['scnme'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Sccod: WideString;
begin
  Result := ChildNodes['sccod'].Text;
end;

procedure TXMLTopenBorSystemDef.Set_Sccod(Value: WideString);
begin
  ChildNodes['sccod'].NodeValue := Value;
end;

function TXMLTopenBorSystemDef.Get_Sctyp: Integer;
begin
  try

  if(varIsNull(ChildNodes['sctyp'].NodeValue)) then
    Result := 0
  else
    Result := ChildNodes['sctyp'].NodeValue;

  except
  end
end;

procedure TXMLTopenBorSystemDef.Set_Sctyp(Value: Integer);
begin
  ChildNodes['sctyp'].NodeValue := Value;
end;

end. 