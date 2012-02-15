#include "data/scripts/com/ani0009.h"

int ani0016(int iAni, int iAI, int A, int B, int C){
    
	/*
	ani0015
	Damon Vaughn Caskey
	
	Perform alternate animation if target is rising or performing a riseattack.
	Put this together quick by checking animation ID. There might be an AI flag for rising.

	iAni:	Alternate animation.
	iAI:	Only if under AI control.
	A-C:	Expansion.
	*/

    void vSelf      = getlocalvar("self");					//Caller.                                                         
    void vOpp       = findtarget(vSelf, iAni);				//Nearest target in range of alternate attack.
	int	 iAni;												//Target's animation.

	if (iAI && getentityproperty(vSelf, "type") == openborconstant("TYPE_PLAYER"))
	{
		return 0;
	}

	if (vOpp)												//Found a target?
	{
		iAni = getentityproperty(vOpp, "animationid");		//Get animation.

		if (iAni == openborconstant("ANI_RISE")
			|| iAni == openborconstant("ANI_RISEATTACK"))	//Rise or riseattack?
		{
			ani0009(vSelf, iAni, 0);						//Perform animation.
			return 1;										//Return 1.
		}
	}

	return 0;												//Return 0.
}
