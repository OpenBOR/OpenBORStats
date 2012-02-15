int jump0003(int iAni, int iAtk, void vEnt)
{
	/*
	jump0003
	Damon Vaughn caskey
	2010_03_17
	Change current animation to a real "jump"; also changes to another animation if needed.

	iAni:	Animation change?
	iAtk:	Attacking?
	vEnt:	Target.	
	*/	
	
	if (!vEnt){ vEnt = getlocalvar("self"); }

	if (iAni && getentityproperty(vEnt, "animvalid", iAni))
	{
		changeentityproperty(vEnt, "animation", iAni);		
	}

	changeentityproperty(vEnt, "aiflag", "jumping", 1);
	changeentityproperty(vEnt, "aiflag", "idling", 0);
	changeentityproperty(vEnt, "takeaction", "common_jump");	
}