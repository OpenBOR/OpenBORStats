
void mode0001(void vEnt, int iWep, int iWepF, char cModel, int iModelF)
{

    /*
    mode0001
    Damon Vaughn Caskey
    02142011
    
    Weapon switch
    */

	if (!vEnt){	vEnt = getlocalvar("self");	}
	
	changeentityproperty(vEnt, "weapon", iWep, iWepF);
	changeentityproperty(vEnt, "model", cModel, iModelF);	
	       
}
