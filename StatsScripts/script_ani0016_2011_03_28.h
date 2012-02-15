#include	"data/scripts/vars/constants.h"	//COnstants list.
#include	"data/scripts/com/ani0009.h"	//Animation switch wrapper.

int ani0016(int iAni, int iAI, int A, int B, int C){
    
	/*
	ani0015
	Damon Vaughn Caskey
	2008_xx_xx
	~2001_03_28

	Perform alternate animation if target is rising or performing a riseattack.
	Put this together quick by checking animation ID. There might be an AI flag for rising.

	iAni:	Alternate animation.
	iAI:	Only if under AI control.
	A-C:	Expansion.
	*/

    void	vSelf	= getlocalvar("self");				//Caller.                                                         
    int		iType	= getentityproperty(vSelf, "type");	//Caller Type.
	void	vOpp;										//Nearest target in range of alternate attack.
	int		iAni;										//Target's animation.

	if (iAI && iType == T_PLAYER)						//AI required and caller is Player type?
	{
		return 0;										//Exit and return 0.
	}

	vOpp = findtarget(vSelf, iAni);						//Find target.

	if (vOpp)											//Found a target?
	{
		iAni = getentityproperty(vOpp, "animationid");	//Get animation.

		if (iAni == A_RISE								//Rise?
			|| iAni == A_RISEATK)						//Riseattack?
		{
			ani0009(vSelf, iAni, 0);					//Perform animation.
			return 1;									//Return 1.
		}
	}

	return 0;											//Return 0.
}
