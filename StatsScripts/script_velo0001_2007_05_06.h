void velo0001(float fX, float fZ, float fY){
     
    /*
    velo0001
	Damon Vaughn Caskey		
    2007_05_06

	Replicates movement effect on caller.
	
	fX: X axis speed.
	fZ: Z axis speed.
	fY: Y axis speed.
	*/
	
	void vSelf = getlocalvar("self");						//Calling entity.
	
	if (!getentityproperty(vSelf, "direction"))				//Facing right?
	{                   
        fX = -fX;											//Reverse X direction to match facing.
    }         
	
	changeentityproperty(vSelf, "velocity", fX, fZ, fY);	//Apply movement.

}