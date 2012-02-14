unit clsirfanView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, JvExComCtrls, JvToolBar, JvComCtrls, jvstrings,
  unCommon;

type
  TirfanViewOptions = class(Tobject)

  private
  public
    vFlip : bool;
    hFlip : bool;
    xtraParamaters : string;
    rotate :integer;
    //outputFormat : string;
    sourceFile : string;
    outputFile : string;
  end;

type
  TirfanView = class(TObject)

  private
    optionsz : TirfanViewOptions;
    irfanviewExe :string;
  public

    constructor create(options:TirfanViewOptions; irfanviewExeLocation :string);
end;

implementation

{ TirfanView }

constructor TirfanView.create(options: TirfanViewOptions; irfanviewExeLocation :string);
var
  paramaters : string;
begin
  irfanviewExe := irfanviewExeLocation;
  //paramaters := irfanviewExe + ' ' + options.sourceFile;
  paramaters := ' "'+options.sourceFile + '"' ;
  if options.vFlip = true then
    paramaters := paramaters + ' /vflip';
  if options.hFlip = true then
    paramaters := paramaters + ' /hflip';
  paramaters := paramaters + ' /advancedbatch';  
  //if options.rotate <> 0 then //(6,1,1,0,1,300,0,0)
   // paramaters := paramaters + ' /jpg_rotate=(6,1,1,0,1,' + IntToStr(options.rotate) + ',0,0)';
  paramaters := paramaters + ' /convert="' + options.outputFile+'"';
  paramaters := paramaters + ' ' + options.xtraParamaters;
  irfanviewExe := '"' + irfanviewExe + '"';
  exeAppBor(irfanviewExe,paramaters,true,false);
  //sleep(1000);
  optionsz := options;
end;

end.
