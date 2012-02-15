#include "data/scripts/com/ani0009.h"	//http://www.caskeys.com/dc/?p=1314#ani0009

int jump0003(int iAni, int iAtk, void vEnt)
{
	/*
	jump0003 - http://www.caskeys.com/dc/?p=1314#jump0003
	Damon Vaughn caskey
	2010_03_17
	~2011_04_10
	
	Change current animation to a real "jump"; also changes to another animation if needed.

	iAni:	Animation change?
	iAtk:	Attacking?
	vEnt:	Target.	
	*/	
	
	if (!vEnt)													//No ent passed?
	{ 
		vEnt = getlocalvar("self");								//Use self.
	}

	if (iAni)													//Animation passed?
	{
		ani0009(vEnt, iAni, -1);								//Switch animation.
	}

	changeentityproperty(vEnt, "aiflag", "jumping", 1);			//Set jumping flasg.
	changeentityproperty(vEnt, "aiflag", "idling", 0);			//Set idle flag.
	changeentityproperty(vEnt, "takeaction", "common_jump");	//Set jump action.
}
