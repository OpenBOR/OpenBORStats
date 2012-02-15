#include "data/scripts/com/bind0010.h"  //Grapple bind.
#include "data/scripts/com/bind0014.h"  //Grapple bind.
#include "data/scripts/com/key0006.h"   //Selection increment.

void debu0001(void vEnt, int iKUp, int iKDn, int iKLt, int iKRt, int iKAtk, int iKAtk2, int iKAtk3, int iKAtk4, int iKSt, int iKSs, int iKEsc, int iKAtkH, int iKAtk2H, int iKAtk3H, int iKAtk4H, int iKSp, int iJmpH, int iKEscH){

	void	vTarget;																										//Target entity.
	void	vOpp;																											//Current opponent.
	int     i;                                                                                                              //Counter.
	int		iDebug;																											//Debug mode.
	int		iDB1, iDB2, iDB3, iDB4, iDB5, iDB6, iDB7, iDB8, iDB9, iDB10;													//Debug subsettings.
	int		iECnt;																											//Number of entities in play.
	int		iD;																												//Direction.
	float	fB, fX, fY, fZ;																									//Base, X, Y, and Z locations.
	char	cON			= "NA";                                                                                             //Opponent's default name.
	char	cOA			= "NA";                                                                                             //Opponent's alias.
	char	cName		= "NA";                                                                                             //Default name.
    char	cAlias		= "NA";                                                                                             //Default alias.
   	char    cFrame      = "NA";                                                                                             //Frame.
    char    cMHP        = "NA";                                                                                             //Max health.
    char    cHP         = "NA";                                                                                             //Health.


	if (openborvariant("in_selectscreen")){ return; }

	//Clear out debug globals.
	if(iKEsc)
	{
		for(i=0;i<11;i++)
		{
			setglobalvar("dubug_iDB"+i, NULL());
		}
	}

    iDebug = key0006(vEnt, "debug_set", iDebug, 0, NULL(), 10, NULL(), iKEscH, iKUp, iKDn, 1);								//Set debug mode.

    //Clear out text objects.
    for(i=0;i<7;i++)
    {
        cleartextobj(i);
    }

	if(iDebug != NULL())
	{
        settextobj(0, 10, 30, 1, -1, "Debug: " + iDebug);
    }

	if(iDebug == 1)		//General info.
	{

		iDB1	= key0006(vEnt, "debug_iDB1",	iDB1, 0,	NULL(),	iECnt,	NULL(), iKAtkH,	iKRt, iKLt, 1);					//Entity index.

		if (!iDB1){	iDB1 = 0;	}																							//Null to 0.

		vTarget = getentity(iDB1);																							//Get entity handle.
        iECnt	= openborvariant("ent_max");																				//Get count of entites.

		settextobj(0, 10, 30, 1, -1, "Debug: " + iDebug + ", General Info");
		settextobj(1, 10, 40, 2, -1, "SP: Index: ("+iDB1+"/"+iECnt+")");

        if(vTarget																											//Valid handle?
			&& getentityproperty(vTarget, "exists"))																		//Valid entity?
		{

			cName	= getentityproperty(vTarget, "defaultname");
			cAlias	= getentityproperty(vTarget, "name");
			iD		= getentityproperty(vTarget, "direction");
			fB		= getentityproperty(vTarget, "base");
			fX		= getentityproperty(vTarget, "x");
			fY		= getentityproperty(vTarget, "a");
			fZ		= getentityproperty(vTarget, "z");
			vOpp	= getentityproperty(vTarget, "opponent");
			cMHP    = getentityproperty(vTarget, "maxhealth");
			cHP     = getentityproperty(vTarget, "health");

			if(vOpp)
			{
				cON		= getentityproperty(vOpp, "defaultname");
				cOA		= getentityproperty(vOpp, "name");
			}
			else
			{
				vOpp	= "NA";
				cON		= "NA";
				cOA		= "NA";
			}

			settextobj(3, 10, 50, 2, -1, "Handle: "		+	vTarget	+	", Name: "	+	cName	+	", Alias: "	+	cAlias);
			settextobj(4, 10, 60, 2, -1, "D: "			+	iD		+	", B: "		+	fB		+	", X: "		+	fX	+	", Y: "	+	fY	+	", Z: "	+	fZ);
			settextobj(5, 10, 70, 2, -1, "Opponent: "	+	vOpp	+	", "		+	cON		+	", "		+	cOA);
			settextobj(6, 10, 80, 2, -1, "Health: "	    +	cHP	    +	" of "		+	cMHP);

		}
	}
	else if(iDebug == 2)	//Weapons.
	{
		iDB1	= key0006(vEnt, "debug_bind0010_i1",	iDB1, 0,	NULL(), iECnt,	NULL(), iKAtkH,		iKRt, iKLt, 1);		//Entity index.

		if (!iDB1){	iDB1 = 0;	}																							//Null to 0.

		vTarget = getentity(iDB1);																							//Get entity handle.
        iECnt	= openborvariant("ent_max");																				//Get count of entites.

		settextobj(0, 10, 30, 1, -1, "Debug: " + iDebug + ", General Info");
		settextobj(1, 10, 40, 2, -1, "SP: Index: ("+iDB1+"/"+iECnt+")");

        if(vTarget																											//Valid handle?
			&& getentityproperty(vTarget, "exists"))																		//Valid entity?
		{
			iDB1 = key0006(vEnt, "debug_bind0010_i2",	iDB1, 0,		NULL(), 20,		NULL(), iKAtkH,		iKUp, iKDn, 1);	//Weapon select.

			cName	= getentityproperty(vTarget, "defaultname");
			cAlias	= getentityproperty(vTarget, "name");

			settextobj(3, 10, 50, 2, -1, "Handle: "		+	vTarget	+	", Name: "	+	cName	+	", Alias: "	+	cAlias);
			settextobj(4, 10, 60, 2, -1, "Weapon: "		+	iDB1);

			if(iDB1 == 2)
			{
				changeentityproperty(vTarget, "model", "ax_rdrag", 1);
			}
			else
			{
				changeentityproperty(vTarget, "weapon", iDB1);
			}
		}
	}
	else if(iDebug == 3)	//Graphics.
	{
		iDB1 = getindexedvar(DRAWMOD);																					//Get current draw setting.																				
		iDB2 = openborvariant("gfx_x_offset");																			//Get GFX X offset.
		iDB3 = openborvariant("gfx_y_offset_adj");																		//Get GFX Y offset adjust.

		iDB1 = key0006(vEnt, 0,				iDB1,	0,		NULL(),	1,		NULL(), iJmpH,		iKRt,	iKLt,	1);		//Drawing mode.
		iDB2 = key0006(vEnt, 0,				iDB2,	NULL(),	NULL(),	NULL(),	NULL(), iKAtkH,		iKRt,	iKLt,	1);		//Graphics offset X.
		iDB3 = key0006(vEnt, 0,				iDB3,	NULL(),	NULL(), NULL(),	NULL(), iKAtkH,		iKUp,	iKDn,	1);		//Graphics offset Y.

		setindexedvar(DRAWMOD, iDB1);																					//Apply draw setting.
		changeopenborvariant("gfx_x_offset", iDB2);																		//Apply gfx offset X.
		changeopenborvariant("gfx_y_offset_adj", iDB3);																	//Apply gfx offset Y.		

		if (!iDB1){ iDB1 = 0; }
        if (!iDB2){ iDB2 = 0; }
        if (!iDB3){ iDB3 = 0; }

		settextobj(0, 10, 30, 1, -1, "Debug: "			+	iDebug	+	", Draw");										//Show Debug mode.
		settextobj(1, 10, 40, 2, -1, "JP: Draw Mode("	+	iDB1		+	")");										//Show draw mode.
        settextobj(2, 10, 50, 2, -1, "A1: Offset X("	+	iDB2		+	"), Y("			+	iDB3		+	")");	//Show graphics offsets.
	}
	else if(iDebug == 4)	//Grappling.
	{
		iDB1 = key0006(vEnt, "debug_iDB1",	iDB1,	0,		NULL(),	7,		NULL(),	iJmpH,		iKRt,	iKLt,	1);	//Bind Mode (see bind0010).
		iDB2 = key0006(vEnt, "debug_iDB2",	iDB2,	0,		NULL(), NULL(),	NULL(), iKAtkH,		iKRt,	iKLt,	1);	//Bind index (targeted entity).
	    iDB3 = key0006(vEnt, "debug_iDB3",	iDB3,	0,		NULL(), 14,		NULL(), iKAtkH,		iKUp,	iKDn,	1);	//Bind pose.
		iDB4 = key0006(vEnt, "debug_iDB4",	iDB4,	NULL(),	NULL(), NULL(), NULL(), iKAtk2H,	iKRt,	iKLt,	1);	//Bind X offset.
		iDB5 = key0006(vEnt, "debug_iDB5",	iDB5,	NULL(),	NULL(), NULL(), NULL(), iKAtk2H,	iKUp,	iKDn,	1);	//Bind Y offset.
		iDB6 = key0006(vEnt, "debug_iDB6",	iDB6,	NULL(),	NULL(), NULL(), NULL(), iKAtk3H,	iKUp,	iKDn,	1);	//Bind Z offset.
		iDB7 = key0006(vEnt, "debug_iDB7",	iDB7,	-2,		NULL(), 2,		NULL(), iKAtk3H,	iKRt,	iKLt,	1);	//Bind direction set.
		iDB8 = key0006(vEnt, "debug_iDB8",	iDB8,	0,		NULL(), NULL(), NULL(), iKAtk4H,	iKRt,	iKLt,	1);	//Current frame.
		iDB9 = key0006(vEnt, "debug_iDB9",	iDB9,	0,		NULL(), 1,		NULL(), iKAtk4H,	iKUp,	iKDn,	1);	//Rebind on each frame change toggle.

		vTarget = getglobalvar(vEnt + ".bind." + iDB2);

        if(vTarget)
		{
			cName = getentityproperty(vTarget, "defaultname");
		}
		else
		{
            cName = "None";
        }
		
		if (!iDB1){ iDB1 = 0; }
        if (!iDB2){ iDB2 = 0; }
        if (!iDB3){ iDB3 = 0; }
        if (!iDB4){ iDB4 = 0; }
        if (!iDB5){ iDB5 = 0; }
        if (!iDB6){ iDB6 = 0; }
        if (!iDB7){ iDB7 = 0; }
        if (!iDB8){ iDB8 = 0; }
        if (!iDB9){ iDB9 = 0; }

        if(iDB3 == 0){       cFrame = "HELD";   }
        else if(iDB3 == 1){  cFrame = "HELDP";  }
        else if(iDB3 == 2){  cFrame = "HORUP";  }
        else if(iDB3 == 3){  cFrame = "HORDN";  }
        else if(iDB3 == 4){  cFrame = "VERUP";  }
        else if(iDB3 == 5){  cFrame = "VERDN";  }
        else if(iDB3 == 6){  cFrame = "TLTUP";  }
        else if(iDB3 == 7){  cFrame = "TLTDN";  }
        else if(iDB3 == 8){  cFrame = "VERDNP"; }
        else if(iDB3 == 9){  cFrame = "DWNUP";  }
        else if(iDB3 == 10){ cFrame = "DWNUPP"; }
        else if(iDB3 == 11){ cFrame = "FALUP";  }
        else if(iDB3 == 12){ cFrame = "FALUPT"; }
        else if(iDB3 == 13){ cFrame = "HORUPP"; }
        else if(iDB3 == 14){ cFrame = "HELDMP"; }

        settextobj(0, 10, 30, 1, -1, "Debug: "			+	iDebug	+	", Grappling");
		settextobj(1, 10, 40, 2, -1, "JP: Bind Mode("	+	iDB1		+	")");
        settextobj(2, 10, 50, 2, -1, "A1: Index("		+	iDB2		+	"; "			+	cName	+	"), Pose("	+	iDB3	+"; " + cFrame + ")");
        settextobj(3, 10, 60, 2, -1, "A2: X("			+	iDB4		+	"), Y("			+	iDB5		+	")");
        settextobj(4, 10, 70, 2, -1, "A3: Dir("			+	iDB7		+	"), Z("			+	iDB6		+	")");
        settextobj(5, 10, 80, 2, -1, "A4: Frame("		+	iDB8		+	"), Rebind("	+	iDB9		+	")");
		settextobj(6, 10, 90, 2, -1, "SP: Log binding command.");

        if(vEnt && (iKAtk4H && (iKRt || iKLt)))
        {
            updateframe(vEnt, iDB8);
        }

        if(iDB9)
		{
            bind0010(iDB1, vEnt, iDB2, iDB4, iDB5, iDB6, iDB7, iDB3, 0);
        }

		changeentityproperty(vEnt, "tosstime", openborvariant("elapsed_time") + 10000000000);
		changeentityproperty(vEnt, "velocity", 0, 0, 0);

        if(iKSp)
        {
            log("\n Bind Cmd (frame " + iDB8 + "): @cmd bind0010 " + iDB1 + " 0 " + iDB2 + " " + iDB4 + " " + iDB5 + " " + iDB6 + " " + iDB7 + " " + cFrame + " 0");
        }
	}
}
