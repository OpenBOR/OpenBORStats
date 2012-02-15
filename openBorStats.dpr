program openBorStats;

uses
  FastMM4,
  Forms,
  unMain in 'unMain.pas' {Form1},
  unLevels in 'unLevels.pas',
  clsLevels in 'clsLevels.pas',
  unDetails in 'unDetails.pas' {frmLevelSub},
  unEntityDetails in 'unEntityDetails.pas' {frmEntityDetails},
  clsEntityDetails in 'clsEntityDetails.pas',
  unCommon in 'unCommon.pas',
  formFormat in 'formFormat.pas' {frmFormat},
  formEditor in 'formEditor.pas' {frmEditor},
  clsmugenAir in 'clsmugenAir.pas',
  formImport in 'formImport.pas' {frmImport},
  clsimportTreeVst in 'clsimportTreeVst.pas',
  formCharacterEditor in 'formCharacterEditor.pas' {frmCharacterEditor},
  clsanimeEntityListVst in 'clsanimeEntityListVst.pas',
  frameGifList in 'frameGifList.pas' {frmGifList: TFrame},
  xmlopenBorSystem in 'xmlopenBorSystem.pas',
  xmlopenBorSystemClass in 'xmlopenBorSystemClass.pas',
  clsopenBorSystemVst in 'clsopenBorSystemVst.pas',
  formSystemEditor in 'formSystemEditor.pas' {frmSystemEditor},
  frameSystemEditor in 'frameSystemEditor.pas' {fsystemEditor: TFrame},
  formStats in 'formStats.pas' {frmStats},
  clsModels in 'clsModels.pas',
  clstreeProjectVst in 'clstreeProjectVst.pas',
  frameEditor in 'frameEditor.pas' {frmEditorSyn: TFrame},
  clsLevelsHeader in 'clsLevelsHeader.pas',
  formTestFactory in 'formTestFactory.pas' {frmTestFactory},
  clsVideo in 'clsVideo.pas',
  clsLevelDesign in 'clsLevelDesign.pas',
  formLevelDesign in 'formLevelDesign.pas' {frmLevelDesign},
  formStairs in 'formStairs.pas' {frmStairs},
  untFndFileVst in 'untFndFileVst.pas' {frmFndFileVst},
  clsirfanView in 'clsirfanView.pas',
  unHudDesign in 'unHudDesign.pas' {frmHudDesign};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmLevelSub, frmLevelSub);
  Application.CreateForm(TfrmEntityDetails, frmEntityDetails);
  Application.CreateForm(TfrmFormat, frmFormat);
  Application.CreateForm(TfrmEditor, frmEditor);
  Application.CreateForm(TfrmImport, frmImport);
  Application.CreateForm(TfrmCharacterEditor, frmCharacterEditor);
  Application.CreateForm(TfrmSystemEditor, frmSystemEditor);
  Application.CreateForm(TfrmStats, frmStats);
  Application.CreateForm(TfrmTestFactory, frmTestFactory);
  Application.CreateForm(TfrmLevelDesign, frmLevelDesign);
  Application.CreateForm(TfrmStairs, frmStairs);
  Application.CreateForm(TfrmFndFileVst, frmFndFileVst);
  Application.CreateForm(TfrmHudDesign, frmHudDesign);
  Application.Run;
end.
