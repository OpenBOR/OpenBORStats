#include "data/scripts/vars/anims.h"
#include "data/scripts/vars/entity.h"
#include "data/scripts/com/ani0009.h"
#include "data/scripts/com/summ0001.h"

int parr0001(void vEnt, void vOpp){

    /*
    parr0001
    Damon Vaughn Caskey
    2011_01_01
	
	Check for Key timing and parry accordingly.    

	vEnt:	Defendeing entity.
    vOpp:	Attacking entity.
    */
           
    int		iHX, iHY, iHZ;																		//Last hit Location.    
    int		iMP;																				//Current MP.
	float	fMMP = 0.0;																			//maximum MP.
	int		iAni;																				//Animation.
    int		fOX, fOY;																			//Attacker Y location.
    int		iOB;																				//Attacker base Y.
    int		iTime;																				//Elapsed game time.
    int		iKeyLst;																			//Key press time.
    int		iNAni;
	int		iONAni;
	int		iPause;
	float	fX, fY;
	int		iB;
	int		iParry;																				//parry activated?
	int		iDir;																				//Direction.
	
	if(!vEnt){	vEnt = getlocalvar("self");	}
	
	iKeyLst	= getentityvar(vEnt, KEY1SP);														//Get time of last special press.	
	iTime	= openborvariant("elapsed_time");													//Get elapsed time.
	iAni	= getentityproperty(vEnt, "animationid");											//Get current animation.

	/*
	Player must press Special 0.25 seconds before attack hits, and can't be attacking, in pain, or block stun.
	*/
    if ((iTime-iKeyLst) <= 25 																	//Last special press within limit?
		&& (iAni == openborconstant("ANI_BLOCK")												//In Block or any Parry animation?
		||	iAni == AIRBLOCK
		||	iAni == PARRY
		||	iAni == APARRY))
    {
		setentityvar(vEnt, KEY1SP, 0);															//Reset last Special press time.        

		iB	=	getentityproperty(vEnt, "base");
		fY	=	getentityproperty(vEnt, "a");

		if(fY == iB)
		{
			iParry = ani0009(vEnt, PARRY, 0);													//Set ground parry animation.
		}
		else
		{
			iParry = ani0009(vEnt, APARRY, 0);													//Set air parry animation.
		}

		if(iParry)																				//Parry animation set?
		{   
			iHX		=	openborvariant("lasthitx") - openborvariant("xpos");
			iHY		=	openborvariant("lasthita");
			iHZ		=	openborvariant("lasthitz");
			fX		=	getentityproperty(vEnt, "x");
			fOX		=	getentityproperty(vOpp, "x");
			iMP		=	getentityproperty(vEnt, "mp");
			fMMP	+=	getentityproperty(vEnt, "maxmp");
			iDir	=	getentityproperty(vEnt, "direction");
			
			/*
			Face toward attack.
			*/
			if(fX > fOX)
			{
				iDir = 0;
			}
			else if(fX < fOX)
			{				
				iDir = 1;
			}
			
			changeentityproperty(vEnt, "mp", iMP + (fMMP * 0.3));								//Recover 30% of maximum MP.
			changeentityproperty(vEnt, "direction", iDir);										//Apply facing.
			summ0001("pflash", "pflash", 0, 1, iHX, iHY, iHZ, iDir, 0, 0, 1);					//Spawn parry flash.
				
			iNAni	= getentityproperty(vEnt, "nextanim") + 30;            	                
	        iONAni	= getentityproperty(vOpp, "nextanim") + 75;
	        iPause  = getlocalvar("pauseadd") + iONAni;
			
	        changeentityproperty(vOpp, "nextanim", iPause);
	        changeentityproperty(vOpp, "nextthink", iPause); 
			changeentityproperty(vOpp, "tosstime", iPause); 

			changeentityproperty(vEnt, "nextanim", iNAni);
	        changeentityproperty(vEnt, "nextthink", iNAni);
			changeentityproperty(vEnt, "tosstime", iNAni);
                            
            return 1;
        }        
    }

    return 0;
}
