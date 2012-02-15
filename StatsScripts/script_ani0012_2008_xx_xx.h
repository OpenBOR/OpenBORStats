void ani0012()
{
	/*
	ani0012
	Copied from Utunnel's in model script.
	2008_xx_xx

	Switch to Grabattack2 when attacking Bad Brother.
	*/

	void self = getlocalvar("self");
	void target = getentityproperty(self, "opponent");
	
	if(target==NULL())
	{
		target = getentityproperty(self, "grabbing");
	}

	if(target!=NULL())
	{
		char tname = getentityproperty(target, "defaultname");
		if(tname == "Bad_Brother")
		{			
			changeentityproperty(self, "animation", openborconstant("ANI_GRABATTACK2"));
		}
	}
}