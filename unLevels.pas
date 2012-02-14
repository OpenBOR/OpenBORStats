unit unLevels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  clsLevels;

  procedure retrieveLevelData(filename:string);

  var
    aLevel : TLevelsData;

implementation
uses
  unMain, formStats;

procedure retrieveLevelData(filename:string);
Var
  aList, DataList : TStringList;
  i, iSpawnLineNumber : integer;
  StartSpawn : boolean;
  s : string;

  aLevelData : TLevelData;
Begin
  frmStats.GridLevels.RowCount := 2;
  frmStats.GridLevels.ColCount := 2;
  aList := TStringList.Create;
  DataList := TStringList.Create;
  if aLevel = nil then
    aLevel := TLevelsData.create
  else
    aLevel.list.clear;
  aList.LoadFromFile(filename);
  if FileExists(filename) then Begin
    i := 0;
    while i < aList.Count do Begin
      s := LowerCase(aList.Strings[i]);
      Form1.StringDelete2End(s,'#');
      if (s = ' ') or
         (s = '  ') or
         (s = '   ') then
        s := '';

      Begin
        //Search for a Entity creation position
        if PosStr('spawn',s) > 0 then Begin
          StartSpawn := True;
          iSpawnLineNumber := i;
        end;
        //Add entity data into datalist
        if StartSpawn = true then Begin
          DataList.Add(s);
        end;
        //Check for end of Entity state
        if (StartSpawn = true) and
           (s = '') then Begin
          StartSpawn := false;
          aLevel.addData(DataList,iSpawnLineNumber);
          iSpawnLineNumber := 0;
          DataList.Clear;
        end;
      end;
      inc(i);
    end;

    frmStats.GridLevels.ColCount := 7;
    frmStats.GridLevels.Cells[1,0] := 'Name';
    frmStats.GridLevels.Cells[2,0] := 'Min Health';
    frmStats.GridLevels.Cells[3,0] := 'Max Health';
    frmStats.GridLevels.Cells[4,0] := 'Apearance';
    frmStats.GridLevels.Cells[5,0] := 'Items';
    frmStats.GridLevels.Cells[6,0] := 'Boss';
    for i := 0 to aLevel.list.Count -1 do Begin
      aLevelData := (aLevel.list.Objects[i] as TLevelData);
      frmStats.GridLevels.Cells[1,frmStats.GridLevels.RowCount] := aLevelData.SpawnName;
      frmStats.GridLevels.Cells[2,frmStats.GridLevels.RowCount] := IntToStr(aLevelData.SpawnMinHealth);
      frmStats.GridLevels.Cells[3,frmStats.GridLevels.RowCount] := IntToStr(aLevelData.SpawnMaxHealth);
      frmStats.GridLevels.Cells[4,frmStats.GridLevels.RowCount] := IntToStr(aLevelData.SpawnCount);
      frmStats.GridLevels.Cells[5,frmStats.GridLevels.RowCount] := IntToStr(aLevelData.SpawnItem);
      frmStats.GridLevels.Cells[6,frmStats.GridLevels.RowCount] := IntToStr(aLevelData.SpawnBoss);
      frmStats.GridLevels.RowCount := frmStats.GridLevels.RowCount +1;
    end;
  end;
  aList.Free;
  DataList.Free;

end;

end.
