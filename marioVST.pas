unit marioVST;//V0.02

interface

uses
  Windows, SysUtils, Classes, ZipMstr, Forms, VirtualTrees, Graphics,
  MarioSec, mario;

  procedure vstSetTreeSettings(vTree:TVirtualStringTree);
  procedure vstSetParentVisible(vTree:TVirtualStringTree;aNode:PVirtualNode);
  procedure vstSetParentExpand(vTree:TVirtualStringTree;aNode:PVirtualNode);
  Function vstColumnWidthsGet(vTree:TVirtualStringTree):String;
  Procedure vstColumnWidthsSet(vTree:TVirtualStringTree;encodedString:String);


var
  zzBusy : Boolean =false;

implementation

Uses
  vtMethods, TTMain ;

procedure vstSetTreeSettings(vTree: TVirtualStringTree);
begin
  vTree.Colors.FocusedSelectionColor := aConfig.selColor;
  vTree.Colors.FocusedSelectionBorderColor := aConfig.selBordrColor;
  vTree.Header.Style := hsXPStyle;
  vTree.CheckImageKind := ckXP;
  vTree.Font := Form1.FontBlack;

  vTree.Header.Background := clMoneyGreen;
  vTree.TreeOptions.SelectionOptions := vTree.TreeOptions.SelectionOptions + [toFullRowSelect];
  vTree.TreeOptions.SelectionOptions := vTree.TreeOptions.SelectionOptions + [toRightClickSelect];

  vTree.OnMeasureItem := Form1.VstNMeasureItem;
  If aConfig.ShowBackGround = true then Begin
    Randomize;
    Form1.VstN.TreeOptions.PaintOptions := Form1.VstN.TreeOptions.PaintOptions + [toShowBackground];
    vTree.Background := Form1.VstN.Background;
    vTree.TreeOptions.PaintOptions := vTree.TreeOptions.PaintOptions + [toShowBackground];
    vTree.BackgroundOffsetX := random(300);
    vTree.BackgroundOffsety := random(300);
  End else
    vTree.TreeOptions.PaintOptions := vTree.TreeOptions.PaintOptions - [toShowBackground];
  {If aConfig.AnimateTree = true then Begin
    VstN.TreeOptions.AnimationOptions := VstN.TreeOptions.AnimationOptions + [toAnimatedToggle];
    VSTCurrent.TreeOptions.AnimationOptions := VSTCurrent.TreeOptions.AnimationOptions + [toAnimatedToggle];
    vTree.TreeOptions.AnimationOptions := vTree.TreeOptions.AnimationOptions + [toAnimatedToggle];
  End
  Else Begin
    vTree.TreeOptions.AnimationOptions := vTree.TreeOptions.AnimationOptions - [toAnimatedToggle];
  End;}
  //vTree.ScrollBarOptions.ScrollBarStyle := sbm3D;
end;

procedure vstSetParentVisible(vTree:TVirtualStringTree;aNode:PVirtualNode);
Var
  aParent : PVirtualNode;
begin
  Try
    if Form1.canProceed then Begin
      if aNode <> nil then
        aParent := vTree.NodeParent[aNode];// aNode.Parent;
      While aParent <> nil do Begin
        Try
          If vTree.IsVisible[aParent] = false then
            vTree.IsVisible[aParent] := True;
        Except
        End;
        //aParent.States := aParent.States + [vsVisible];
        aParent := vTree.NodeParent[aParent];// aParent.Parent;
      End;
    End;
  Except
  end;
End;

procedure vstSetParentExpand(vTree:TVirtualStringTree;aNode:PVirtualNode);
Var
  aParent : PVirtualNode;
  i : Integer;
begin
  if Form1.canProceed then Begin
    If Assigned(aNode) then
      If Assigned(aNode.Parent) then Begin
        aParent := vTree.NodeParent[aNode]; //;aNode.Parent;
        While Assigned(aParent) do Begin //<> nil do Begin
          Try
            i := vTree.GetNodeLevel(aParent);
            vTree.Expanded[aParent] := True;
            If i = 0 then
              aParent := nil;
          Except
          End;
          If Assigned(aParent) then
            If Assigned(aParent.Parent) then
              aParent := vTree.NodeParent[aParent]// aParent.Parent
          Else
            aParent := nil;
        End;
    End;
  End;
End;

Function vstColumnWidthsGet(vTree:TVirtualStringTree):String;
Var
  Lst : TStringList;
  s : String;
  i : Integer;
  Stream : TMemoryStream;
begin
  Try
    Lst := TStringList.Create;
    Stream := TMemoryStream.Create;
    For i := 0 to vTree.Header.Columns.Count -1 do Begin
      Lst.Add(IntToStr(vTree.Header.Columns[i].Width));
    end;
    Lst.SaveToStream(Stream);
    s := EncodeStream(Stream);
  Finally
    Lst.Free;
    Result := s;
    Stream.Free;
  end;
End;

Procedure vstColumnWidthsSet(vTree:TVirtualStringTree;encodedString:String);
Var
  Lst : TStringList;
  i, Value : Integer;
begin
  Try
    If encodedString = '' then
       encodedString := 'MTU4DQo3NQ0KMjMwDQoxNTANCjUwDQo=';
    If encodedString <> '' then Begin
      Lst := TStringList.Create;
      Lst.Text := DecodeStringStr(encodedString);
      i := 0;
      While i < Lst.Count do Begin
        Try
          Value := StrToInt(Lst.Strings[i]);
          if Value < 8 then
            Value := 8;
        Except
          Value := 20;
        End;
        If Value > 15 then
          if i < vTree.Header.Columns.Count + 1 then
            vTree.Header.Columns[i].Width := Value
          Else
            i := Lst.Count;
        inc(i);
      End;
    End;
  Finally
    if Lst <> nil then
      Lst.Free;
  end;
End;

End.
