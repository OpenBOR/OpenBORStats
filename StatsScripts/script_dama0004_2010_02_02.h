#include "data/scripts/vars/entity.h"
#include "data/scripts/com/targ0001.h"

void dama0004(void iIndex, int iBind, float fHP, int iDrop, int iType, int iDir, float fY, float fX, float fZ, int iDOL, int iAttacking, int iProj, int fMode){
			
	/*
    dama0004
    Damon Vaughn Caskey
    2010_02_02

	Damage caller's bound entity by index. Differs from dama0001 in that a mode is provided to allow
    non-lethal damage, and attack types are passed as integers rather than a string.

    iIndex:        Target entity by index. 
	iBind:		   -2: Remove bind record from self and target.
    fHP:           Amount of damage to apply.
    iDrop:         Knockdown.
    iType:         Attack type.
    iDir:          Force direction.
    fX/fY/fZ:      Toss entity parameters.
    iDOL:          Damage on landing.
    iAttacking:    Attacking flag.
    iProj:         Projectile flag. 
    fMode:         0: Normal damage, -1: Normal damage to 1hp, 0+: same as 0, but also add fMode % of target's HP to total damage.
    */

    void    vSelf   = getlocalvar("self");                                          //Calling entity.
    void    vTarget = getglobalvar(vSelf + ".bind." + iIndex);                      //Target entity.
    int     iSDir   = getentityproperty(vSelf, "direction");                        //Calling entity facing.
    int     iTDir   = getentityproperty(vTarget, "direction");                      //Target entity facing.
    float   fOff    = 0.0;                                                          //Offense.
    float   fDef    = 0.0;                                                          //Defense.
    int     iDam;                                                                   //Potential damage placeholder.
    int     iHealth;                                                                //Target health.
       
    if (iBind = -2)																	//Erase bind records?
    {
        setglobalvar(vSelf + ".bind." + iIndex, NULL());                            //Remove record of binding.

		setentityvar(vTarget, BOUNDA, NULL());										//Remove record bound to self anchor from target.
		setentityvar(vTarget, BOUNDI, NULL());										//Remove record bound to self Index from target.
		setentityvar(vTarget, BOUNDX, NULL());										//Remove record bound to self X from target.
		setentityvar(vTarget, BOUNDY, NULL());										//Remove record bound to self Y from target.
		setentityvar(vTarget, BOUNDZ, NULL());										//Remove record bound to self Z from target.
		setentityvar(vTarget, BOUNDD, NULL());										//Remove record bound to self direction from target.
		setentityvar(vTarget, BOUNDF, NULL());										//Remove record bound to self frame from target.
    }

	if(fMode == -1)                                                                  //Mode -1. Only damage to 1 health. 
    {
        /*
        Let's find out if the requested damage will kill target. We'll need to factor in
        the attacker's offense and target's defense ratings.
        */

        iHealth = getentityproperty(vTarget, "health");                             //Get target health
        fOff    = getentityproperty(vSelf, "offense", iType);                       //Get self offense.
        fDef    = getentityproperty(vTarget, "defense", iType, "factor");           //Get self defense.
        
        if(fOff){ iDam = fHP * fOff;    }                                           //Apply self offense.
        if(fDef){ iDam *= fDef;         }                                           //Apply target defense.
            
        if (iDam >= iHealth)                                                        //Will damage kill defender?
        {
            iDam    = -1;
            fHP     = 0;                                                            //Set damage to 0. We're still going to "damage" the entity so engine knows damage took place and takes appropriate measures.
        }        
    }
    else if(fMode>0)																//Mode 0+. "Mike Hagger" style damage based on % of target's health.
    {
        iHealth     = getentityproperty(vTarget, "health");                         //Get target's health.
        fHP         += (iHealth * fMode);											//Add fMode % of target's health to total damage.	        
    }

    changeentityproperty(vTarget, "dead", 0);                                       //Unset target's death status so it can receive damage effect even if already killed.
    damageentity(vTarget, vSelf, fHP, iDrop, iType);                                //Apply attack/damage.     
    changeentityproperty(vTarget, "damage_on_landing", iDOL);                       //Set damage on landing flag.
    //changeentityproperty(vTarget, "attacking",         iAttacking);                 //Set attacking flag (05162010: I found this wasn't needed for thrown entities to hit allies, and caused them to hit opponents as well. Removed until I can retool script calls on the models).
    changeentityproperty(vTarget, "projectile",        iProj);                      //Set "hit others" flag.     

    if(iDam == -1)																	//Damage would have been lethal?
    {
        changeentityproperty(vTarget, "health", 0);                                 //Set health to 0. Next time entity is damaged, even for 0HP, the engine will consider it killed.
    }    

    if (iDir == 1)
    { 
		iTDir = iSDir;                                                              //Same as self.         
    }
    else if (iDir == 2)												                //Right.
    {
		iTDir = 1;                                                         
    }
    else if (iDir == -1)												            //Opposite of self.
    {
		if (iSDir)
		{
			iTDir = 0;             
		}
		else
		{
			iTDir = 1;
		}         
    }
    else if (iDir == -2)												            //Left.
    {
		iTDir = 0;                                                         
    }     

    if (!iSDir){ fX = -fX; }          

    if (fY || fX || fZ) { tossentity(vTarget, fY, fX, fZ); }                        //If velocity provided, toss em'.
    changeentityproperty(vTarget,"direction", iTDir);                               //Change direction.

}
