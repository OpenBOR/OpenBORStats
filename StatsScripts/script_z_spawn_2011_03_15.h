#include "data/scripts/vars/constants.h"    //openborconstants.

#include "data/scripts/com/bind0017.h"      //Find entity with same name and move to it.
#include "data/scripts/com/draw0001.h"      //Drawing functions.
#include "data/scripts/com/name0001.h"      //Random name.
#include "data/scripts/com/rema0002.h"      //Random remap.
#include "data/scripts/com/wake0001.h"      //"Wake" function for Golden Axe.
#include "data/scripts/com/soun0005.h"	    //Random capable stereo sound player.
#include "data/scripts/com/path0002.h"	    //Folder.

void z_spawn(void vEnt)
{
    /*
	Damon V. Caskey
	z_spawn
	2011_03_14 (moved from z_spawn.c main)
	~2011_03_15

	Generic spawn functions for most level spawns.
	*/

	int     iMap;											//Caller's starting map.
    int     iKOMap;											//Caller's KO map.
    int     iAni;                                           //Animation ID.
	char	cDModel;										//Default model
	char	cModel;											//Current model.
	int		iSpr;
	void	vPEnt;
	int		iIndex;

	if (!vEnt){	vEnt = getlocalvar("self");	}				//Self default.

	iMap	=	getentityproperty(vEnt, "map");				//Caller's starting map.
	iKOMap	=	getentityproperty(vEnt, "komap", 0);		//Caller's KO map.

	/*
	cDModel	=	getentityproperty(vEnt, "defaultmodel");	//Get default model.
	cModel	=	getentityproperty(vEnt, "model");			//Current model.
	iSpr    =   getentityproperty(vEnt, "icon", 0);         //Main icon.

	log("\n z_spawn, cDModel:" + cDModel);
	log("\n z_spawn, cModel:" + cModel);
	log("\n z_spawn, icon:" + iSpr);
	log("\n z_spawn, playerindex:" + iIndex);
	log("\n z_spawn, icon:" + getentityproperty(vEnt, "icon", 0));
	log("\n --------------------------------------------------------- \n");
	*/

    //Golden Axe--------------------------------------------------------------------------------------------------------
    if(getentityproperty(vEnt, "type") == T_PLAYER)                             //Player?
	{
	    bind0017(vEnt, A_RISE, -1, 1, 0,0,0,0,0,0);                             //Find old corpse and spawn there.
	}
	else
	{
		if(getentityproperty(vEnt, "animvalid", A_FSPECIAL10))
		{
			changeentityproperty(vEnt, "energycost", A_FSPECIAL10, 0,0,-2);
		}

		if(iKOMap && iMap == iKOMap-1)                                          //"Dark" map?
		{
			changeentityproperty(vEnt, "animation", A_RESPAWN);                 //Play respawn animation.

			if(getentityproperty(vEnt, "animvalid", A_FSPECIAL10))              //Has teleport move?
			{
				changeentityproperty(vEnt, "energycost", A_FSPECIAL10, 0,0,0);  //Enable teleport.
			}
		}
		else if(getglobalvar("sleep")==1)                                       //Global sleep var on?
		{
			changeentityproperty(vEnt, "stealth", 1);                           //Become invisible to AI.
			changeentityproperty(vEnt, "animation", A_SLEEP);                   //Go into sleep animation.
		}
		else if(getglobalvar("inscreen")==1)                                    //Global inscreen variable on?
		{
			wake0001();                                                         //Run "wake" function.
		}
	}
    //------------------------------------------------------------------------------------------------------------------

    if (iKOMap && iMap == iKOMap)                                               //KO map?
    {
        rema0002(vEnt,0,0,0,0,0);                                               //Apply random remap.
    }

	//soun0008(vEnt, 0,0,0,0,0,0);                                              //Set up sound counts.
    name0001(vEnt,0,0,0);                                                       //Assign random alias (if starting alias = "Random").
    draw0001(vEnt);                                                             //Apply draw settings.

}



