#include "data/scripts/com/path0002.h"

void mode0001(void vEnt, int iWep, int iWepF, char cModel, int iModelF)
{

    /*
    mode0001
    Damon Vaughn Caskey
    2011_02_14
	-2011_02_17
    
    Weapon and model switch.

	vEnt:		Target entity.
	iWep:		Weapon number to use.
	iWepF:		Weapon switch animation flag.
	cModel:		Model to use.
	iModelF:	Model switch animation flag.
    */

	if (!vEnt){	vEnt = getlocalvar("self");	}					//Use self if vEnt not passed.
	
	if(iWep != -1)												//Weapon number not -1?
	{
		changeentityproperty(vEnt, "weapon", iWep, iWepF);		//Switch weapon.
	}

	if(cModel)													//Model provided?
	{
		if(cModel == "main"){ cModel == path0002(vEnt);	}		//If passed model == "main", use entity's folder name.
		
		changeentityproperty(vEnt, "model", cModel, iModelF);	//Switch model.
	}	       
}
