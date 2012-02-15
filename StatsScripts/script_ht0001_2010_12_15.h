#include	"data/scripts/vars/entity.h"
#include	"data/scripts/com/draw0002.h"

void ht0001(void vEnt){

	/*
	ht0001
	Damon Vaughn Caskey
	2010_12_15

	Returns entity's current height, including current draw adjustment.

	vEnt:	Target entity.
	*/

	int		iH;														//Height placeholder.
	float	fRatio  = getentityvar(vEnt, ADSCALER);					//Get ent's current scale ratio. 

	if(!vEnt)														//No target ent passed?
	{
		vEnt = getlocalvar("self");									//Use caller.
	}

	iH = getentityproperty(vEnt, "animheight");						//Get anim hiehgt.
	if(!iH){	iH = getentityproperty(vEnt, "height");			}	//If no animheight, use model height.
	if(iH){		iH = draw0002(fRatio, iH);						}	//Apply fRatio to height.

	return iH;														//Return final value.	

}