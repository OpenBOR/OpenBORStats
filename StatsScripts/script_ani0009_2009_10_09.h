int ani0009(void vEnt, int iAni, int iType)
{
	/*
	ani0009
	Damon Vaughn Caskey
	2009_10_09

	Animation switch wrapper. Verfies animation exists and sets using desired method.
	
	vEnt:	Target entity.
	iAni:	Animation.
	iType:	Method (0 = performattack, -1 = changeentityproperty).
	*/

	if (!vEnt)
	{
		vEnt = getlocalvar("self");
	}

    if (getentityproperty(vEnt, "animvalid", iAni))			//Animation valid?
    {
        if (iType == -1)									//Type -1?
        {
            changeentityproperty(vEnt, "animation", iAni);	//Set animation with entity property.
        }
        else
        {
            performattack(vEnt, iAni, iType);				//Set animation with perform attack command.
        }
        return 1;											//Return 1.        
    }
    return 0;
}

