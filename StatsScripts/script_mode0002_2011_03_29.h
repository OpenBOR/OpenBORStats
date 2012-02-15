void mode0002()
{
	/*
	mode0002
	Utunnels (renamed from saveanimal)
	Unknown date
	~2011_03_29
	
	Find out what weapon models (if any) players have and store them for placement into next level. This
	enables the "animal sleeping in campsite" during bonus stages for Golden Axe.
	*/

	int i;
	void p;
	char a;

	for(i =0; i<3; i++)
	{
		p = getplayerproperty(i, "ent");
		if(p!=NULL())
		{
			a = getentityproperty(p, "model");
			if(a=="a_chick" || a=="al_chick" || a=="g_chick" || a=="j_chick" || a=="t_chick")
			{
				setglobalvar("runanimal", "Chickenlegs");
				break;
			}
			else if(a=="a_rdrag" || a=="al_rdrag" || a=="g_rdrag" || a=="j_rdrag" || a=="t_rdrag")
			{
				setglobalvar("runanimal", "Red_Dragon");
				break;
			}
			else if(a=="a_bdrag" || a=="al_bdrag" || a=="g_bdrag" || a=="j_bdrag" || a=="t_bdrag")
			{
				setglobalvar("runanimal", "Blue_Dragon");
				break;
			}
		}
	}
}
