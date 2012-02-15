#include	"data/scripts/vars/constants.h"	//Constants list.
#include	"data/scripts/com/ani0009.h"	//Animation switch wrapper.

void ani0012()
{
	/*
	ani0012
	Damon Vaughn Caskey, based on Utunnel's in model script.
	2008_xx_xx
	~2011_03_28

	Switch to Grabattack2 when attacking Bad Brother.
	*/

	void vSelf		= getlocalvar("self");					//Caller.
	void vTarget	= getentityproperty(vSelf, "opponent");	//Caller's Target.
	char cTName;											//Target base name.

	if(!vTarget)											//No target?
	{
		vTarget = getentityproperty(vSelf, "grabbing");		//Use grapple defender.
	}

	if(vTarget)												//Target found?
	{
		cTName = getentityproperty(vTarget, "defaultname");	//Get target base name.
		
		if(cTName == "Bad_Brother")							//Bad brother?
		{			
			ani0009(vSelf, A_GRABATK2, -1);					//Perform grabattack2.
		}
	}
}