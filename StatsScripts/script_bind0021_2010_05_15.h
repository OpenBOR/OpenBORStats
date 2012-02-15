void bind0021(void vEnt, void vBound){
	
	/*
	bind0021
	Damon Vaughn Caskey
	2010_05_15

	Shunt self away from wall if bound entity is inside of it (wall). Prevents getting 
	a bound entity stuck within areas meant to be inaccessible or bounced to infinity
	by wall functions.

    vEnt:	Anchor entity.
	vBound:	Bound entity.
	iX/Y/Z:	Anchor location
	*/

    int	iOX, iOZ, iOB;														//Bound offset and Base.
	int	iX = getentityproperty(vEnt, "x");									//Get self X location.
    int iY = getentityproperty(vEnt, "a");									//Get self Y location.
    int iZ = getentityproperty(vEnt, "z");									//Get self Z location.

	if (vBound)                                                             //Anything there?
    {            
        iOX = getentityproperty(vBound, "x");								//Get X bind offset.
        iOZ = getentityproperty(vBound, "z");								//Get Z bind offset.
		iOB = getentityproperty(vBound, "base");							//Get bound base.

		if (iOX > iX)														//Bound to right of anchor?
		{
			do																//Start loop.
			{					
				iX--;														//Decrement anchor location.
				iOX--;														//Decrement bound location.
			}
			while(checkwall(iOX+15, iOZ)>iOB);								//Continue until outside of wall.
		}
		else																//Bound left of anchor.
		{
			do																//Start loop.
			{					
				iX++;														//Increment anchor location.
				iOX++;														//Increment bound location.
			}
			while(checkwall(iOX-15, iOZ)>iOB);								//Continue until outside of wall.
		}
			
		changeentityproperty(vEnt, "position", iX, iZ, iY);					//Apply location to anchor.
	}
}