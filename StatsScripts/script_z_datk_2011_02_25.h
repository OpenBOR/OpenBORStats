#include	"data/scripts/com/parr0001.h"

void z_datk(void vEnt)
{
	/*
	z_datk
	Damon Vaughn Caskey
	2011_02_25

	Universal doattack event function.

	vEnt:	Caller entity.
	*/
		
    int		iAtkID		= getlocalvar("attackid");
	void	vOther		= getlocalvar("other");

	if(!vEnt){	vEnt = getlocalvar("self");	}

	/*
	log("\n z_datk ~ Cuurent ID: " + iAtkID);
	log("\n z_datk ~ Attack ID: " + getentityproperty(vEnt, "attackid"));
	log("\n z_datk ~ Hit By ID: " + getentityproperty(vEnt, "hitbyid"));
	*/

	if(!getlocalvar("which") && (getentityproperty(vEnt, "hitbyid") != iAtkID))
	{
		if (parr0001(vEnt, vOther))
		{		
			changeopenborvariant("lasthitc", 0);
		}		
	}
		
	changeentityproperty(vEnt, "hitbyid", iAtkID);

	//log("\n z_datk ~ Hit By ID (after): " + getentityproperty(vEnt, "hitbyid"));
}
