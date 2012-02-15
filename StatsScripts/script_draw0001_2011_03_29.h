#include "data/scripts/vars/constants.h"	//http://www.caskeys.com/dc/?p=1314#constants
#include "data/scripts/com/draw0002.h"		//http://www.caskeys.com/dc/?p=1314#draw0002

void draw0001(void vEnt){
        
    /*
    draw0001
    Damon Vaughn Caskey
    2008_01_25
	~2011_03_29

    Applies requested draw effects and auto zoom to all valid entities. The overall effect is to cause an entity to shrink as it 
	moves "away" from the player's viewpoint and expand as it moves toward the player's vantage, similar to many Neo-Geo games.
    
    1. Zoom ratio is stored as entity variable for later use, and applied to ScaleX/ScaleY parameters of setdrawmthod for entity.
    2. This function will overidde other uses of drawmethod. Therfore values are taken and applied from entity variables stored 
    by other functions to control other setdrawmethod parameters. This includes manual adjustment of scale values if desired.
      
	
	DRAWMOD: Modes;
		0	= SNK Style:	Auto zoom applied based on Z location with manual adjustments.
		1	= Capcom style: Auto zoom is always at 100% with manual adjustments unless entity is out of the normal playfield.		
	*/
    
	float	fScaleX;														//X scale adjustment.                
    float	fScaleY;														//Y scale adjustment.
    int		iFlipX;															//Flip X.
    int		iFlipY;															//Flip Y.
    int		iShiftX;														//Shift X.
    int		iFill;															//Fill.
    int		iRotate;														//Rotate.
    int		iARotat;														//Auto Rotation.
    float	fMinZ, fMaxZ;													//Minimum/Maximum Z location.                                       
    float	fDeltaZ;														//Range betwen fMinZ and MaxZ                                            
    float	fFactor;														//Autozoom calculation placeholder.
	float	fZ;																//Current Z location.
	float	fSmax = 1;														//Maximum size ratio.
	float	fSmin = 0.8;													//Minimum size ratio.

	/*
	Failsafe in case function is called and entity does not exist (otherwise setdrawmethod() will cause shut down).
	*/
	if (!vEnt)
	{ 
		return; 
	}

	fScaleX		=	getentityvar(vEnt, ADSCALEX);							//X scale adjustment.                
    fScaleY		=	getentityvar(vEnt, ADSCALEY);							//Y scale adjustment.
    iFlipX		=	getentityvar(vEnt, ADFLIPX);							//Flip X.
    iFlipY		=	getentityvar(vEnt, ADFLIPY);							//Flip Y.
    iShiftX		=	getentityvar(vEnt, ADSHIFTX);							//Shift X.	
    iFill		=	getentityvar(vEnt, ADFILL);								//Fill.
    iRotate		=	getentityvar(vEnt, ADROTATE);							//Rotate.
    iARotat		=	getentityvar(vEnt, ADAROTAT);							//Auto Rotation.
    fMinZ		=	openborconstant("PLAYER_MIN_Z");						//Minimum Z location * Zoom factor.                                       
    fMaxZ		=	openborconstant("PLAYER_MAX_Z");						//Maximum Z location.
	fDeltaZ		=	fMaxZ - (fMinZ * 1.1);									//Range betwen fMinZ * Zoom factor and MaxZ                                            
    fZ			=	getentityproperty(vEnt, "z");							//Ent's current Z location.

	if(DRAWMOD && (fZ > fMinZ || fZ < fMaxZ))								//Autozoom disabled and entity in bounds?
	{
		fFactor		= 1;													//Factor = 1 (100% normal size).
	}
	else
	{		
		fFactor = ((fZ - fMinZ) * ((fSmax-fSmin)/(fMaxZ-fMinZ))) + fSmin;	//Calculate scale ratio.		
	}
	
	setentityvar(vEnt, ADSCALER, fFactor);									//Store scale ratio for use by sub entity (shooting, spawning, binding etc.) functions.
    fFactor *= 256;															//Calculate % of normal size (256) for setdrawmethod().
	
	/*
	Auto rotation.
	*/
    if (iARotat)
    {                
        iRotate = iRotate + iARotat;
        setentityvar(vEnt, ADROTATE, iRotate);
    }
    
    /*
	If ScaleX Adjustment provided, apply it with autozoom factor.
	*/
    if (fScaleX)
    {
        fScaleX = draw0002(fFactor, fScaleX); 
    }
    else
    {
        fScaleX = fFactor;
    }

    /*
	If ScaleY Adjustment provided, apply it with autozoom factor.
	*/
    if (fScaleY)
    {
        fScaleY = draw0002(fFactor, fScaleY);
    }
    else
    {
        fScaleY = fFactor; 
    }

	/*
	Reverse rotation if target facing opposite direction.
	*/
    if (iRotate)
    {
        if (!getentityproperty(vEnt, "direction"))
        {
            iRotate = -iRotate;
        }
    }
    
    /*
	If Values are not available, apply defaults.
	*/
    if (!iFlipX)  { iFlipX  = 0;    }   //FlipX.
    if (!iFlipY)  { iFlipY  = 0;    }   //FlipY.
    if (!iShiftX) { iShiftX = 0;    }   //ShiftX.
    if (!iFill)   { iFill   = 0;    }   //Fill.
    if (!iRotate) { iRotate = 0;    }   //Fill.

    setdrawmethod(vEnt, 1, fScaleX, fScaleY, iFlipX, iFlipY, iShiftX, -1, -1, iFill, iRotate);  //Set final values to drawmethod.    

}
