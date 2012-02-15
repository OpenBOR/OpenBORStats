How to compile

- install Delphi 7 (required, Delphi5 was not sufficient in my tests)
- open Delphi once (important!) (otherwise delphi will not write its paths into registry)
- install VirtualTreeview via the installer (get it from softgems website)
- install JVCL 3.45 complete from sourceforge jedi project. (note that 
  it has a bug, two files fail to compile because they have a UTF8 BOM 
  header, which is not recognized by delphi. you need to open them with 
  a hexeditor (i.e. HxD) and cut off the first 3 or so bytes until the 
  license header starts.
- Install each packages in this dir into your IDE
  this mostly means adding Components/CompoXXX/Source to your library path
  (tools/environment options/library path), and then open the CompoXXX_D7.dpk
  file from the Delphi dir.
  (if no .dpk file exists, it is sufficient to choose 
  "Components -> Install Components", then select tab "into new package"
  then add the .pas file and give the pkg an unique name. the name itself doesnt
  matter.)
  then click "compile" and "install" in the window delphi shows after the dpk file
  is loaded.

once everything is installed you can open "openBorStats.dpr" and are good to go.
  
