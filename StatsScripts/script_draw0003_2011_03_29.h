#include "data/scripts/vars/constants.h"	//http://www.caskeys.com/dc/?p=1314#constants

void draw0003(float iScaleX, float iScaleY, int iFlipX, int iFlipY, int iShiftX, int iBlend, int iRemap, int iFill, int iRotate){

     /*
     draw0003
     Damon Vaughn Caskey
     2008_01_25
	 ~2011_03_29

     Sets passed drawmethod parameters on caller to be applied by draw0001 (http://www.caskeys.com/dc/?p=1314#draw0001).
     */
     
     void vSelf = getlocalvar("self");				//Caller.     
            
     changeentityproperty(vSelf, "alpha", iBlend);	//Set transparency.

	 setentityvar(vSelf, ADSCALEX,    iScaleX);		//iScaleX adjustment.
     setentityvar(vSelf, ADSCALEY,    iScaleY);		//iScaleY adjustment.
     setentityvar(vSelf, ADFLIPX,     iFlipX);		//Flip X.
     setentityvar(vSelf, ADFLIPY,     iFlipY);		//Flip Y.
     setentityvar(vSelf, ADSHIFTX,    iShiftX);		//Shift X.     
	 setentityvar(vSelf, ADREMAP,     iRemap);		//Remap.
     setentityvar(vSelf, ADFILL,      iFill);		//Fill color.
     setentityvar(vSelf, ADROTATE,    iRotate);		//Rotate.
        
}
