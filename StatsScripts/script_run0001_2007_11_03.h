void run0001()
{
    /*
    run0001
    Damon Vaughn Caskey
    2007_11_03   
	
	Stop running. Used to create dash step from running animation.
    */

    void vSelf = getlocalvar("self");

    changeentityproperty(vSelf, "aiflag", "running", 0);					//Turn off run flag.
    changeentityproperty(vSelf, "velocity", 0, 0, 0);						//Stop movement.
    changeentityproperty(vSelf, "animation", openborconstant("ANI_IDLE"));	//Set idle animation.
}