#include "data/scripts/vars/constants.h"	//http://www.caskeys.com/dc/?p=1314#constants
#include "data/scripts/com/soun0009.h"      //http://www.caskeys.com/dc/?p=1314#soun0009
#include "data/scripts/com/rnd0001.h"       //http://www.caskeys.com/dc/?p=1314#rnd0001
#include "data/scripts/com/path0001.h"      //http://www.caskeys.com/dc/?p=1314#path0001

int soun0005(void vEnt, int iGrp, int fSnd, float fProb, char cSFol, int iTime)
{
    /*
    soun0005, http://www.caskeys.com/dc/?p=1314#soun0005
	Damon Vaughn Caskey
    2010_07_10
	~04_03_2011

	Play specfic or random sound from group.
    
	vEnt:   Target entity. Used to get path, determine stereo location, and time delay.
    iGrp:   Sound group (Attack, battle cry, etc.)
    iSnd:   Sound within group. If 0, random sound is choosen.
    fProb:  Probability of sound playing (0-100%).
	cSFol:	Optional sub folder.
    iTime:  Forced time delay between sounds.        
	*/

	void	vEnt		= getlocalvar("self");								//Get caller.	
   	char	cSample, cPath;													//Sample path, entity path.    
	int		iTDam;															//Entity throwdamage setting.

	if (!vEnt)																//No entity given?
	{
		vEnt = getlocalvar("self");											//Default to self.
	}

	fProb = fProb * 100;													//Convert play probability to whole number.
	
	if(fProb >= rnd0001(0, 100, 0,0,0,0))									//Probability met?
	{
		cPath	= path0001(vEnt);											//Get entity path.
		
		if(fSnd==-1)														//Auto mode requested?
		{
			fSnd	= 0;													//Reset fSnd.
		
			if(cSFol)														//Sub group used?
			{
				cSample = cPath+"/sounds/"+cSFol+"/"+iGrp;					//Construct base sound path with subgroup.
			}
			else
			{
				cSample = cPath+"/sounds/"+iGrp;							//Construct base sound path.
			}

			while(loadsample(cSample+"_"+fSnd+".wav", 1) != -1)				//Loop until invalid sound path is found.                                                                        
			{		
				fSnd++;														//Increment count.												
			}
			
			if (!fSnd)														//No sounds in group? 
			{				
				iTDam	= getentityproperty(vEnt, "throwdamage");			//Throwdamage acts as head group (gender, species, etc.).				
				fSnd	= 0;												//Reset fSnd.

				if(cSFol)													//Sub folder?
				{
					cSample = "data/sounds/"+iTDam+"/"+cSFol+"/"+iGrp+"_";	//Construct base sound path with subgroup.
				}
				else
				{
					cSample = "data/sounds/"+iTDam+"/"+iGrp+"_";			//Construct base sound path.
				}
				
				while (loadsample(cSample+fSnd+".wav", 1) != -1)			//Loop until invalid sound path is found.                                                                                               
				{		
					fSnd++;													//Increment count.										
				}																				
				
				if(fSnd)													//Sound count is at least 1?
				{
					fSnd	= rnd0001(0, --fSnd, 0,0,0,0);					//Get random number from given range.
					cSample = cSample+fSnd+".wav";							//Construct full sound path.				
				}
				else                                                        //Count is still 0. Let's move up another branch.
				{
                    fSnd	= 0;											//Reset fSnd.

					if(cSFol)												//Sub folder?
					{
						cSample = "data/sounds/"+cSFol+"/"+iGrp+"_";		//Construct base sound path with subgroup.
					}
					else
					{
						cSample = "data/sounds/"+iGrp+"_";					//Construct base sound path.
					}

				    while (loadsample(cSample+fSnd+".wav", 1) != -1)		//Loop until invalid sound path is found.                                                                                               
				    {		
					    fSnd++;												//Increment count.										
				    }
                    
                    if(fSnd)                                                //Sound count is at least 1?
                    {
                        fSnd	= rnd0001(0, --fSnd, 0,0,0,0);				//Get random number from given range.
					    cSample = cSample+fSnd+".wav";						//Construct full sound path.
                    }                    
				}
			}
			else
			{
				fSnd	= rnd0001(0, --fSnd, 0,0,0,0);						//Get random number from given range.	
				cSample = cPath + "/sounds/"+iGrp+"_"+fSnd+".wav";			//Construct full sound path.
			}				
		}
		else																//Static sound call.
		{
			if(cSFol)														//Sub group used?
			{
				cSample = cPath+"/sounds/"+cSFol+"/"+iGrp;					//Construct base sound path with subgroup.
			}
			else
			{
				cSample = cPath+"/sounds/"+iGrp;							//Construct base sound path.
			}

			cSample +="_"+fSnd+".wav";
				
			if(loadsample(cSample, 1) == -1)								//Verify sample path.
			{
				iTDam	= getentityproperty(vEnt, "throwdamage");			//Throwdamage acts as head group (gender, species, etc.).				

				if(cSFol)													//Sub group used?
				{
					cSample = "data/sounds/"+iTDam+"/"+cSFol+"/"+iGrp;		//Construct base sound path with subgroup.
				}
				else
				{
					cSample = "data/sounds/"+iTDam+"/"+iGrp;				//Construct base sound path.
				}
				
				cSample +="_"+fSnd+".wav";

				if(loadsample(cSample, 1) == -1)							//Verify sample path.
				{
				
					if(cSFol)												//Sub group used?
					{
						cSample = "data/sounds/"+cSFol+"/"+iGrp;			//Construct base sound path with subgroup.
					}
					else
					{
						cSample = "data/sounds/"+iGrp;						//Construct base sound path.
					}

					cSample +="_"+fSnd+".wav";					
				}			
			}
		}

		if(loadsample(cSample, 1) != -1)									//Verify the final sample path.
		{
			return soun0009(vEnt, cSample, 0, 0, 0, 0, 0, iTime, 0, 0);     //Play sound.
		}
		
		return -1;															//Return invalid sound index.
    }
}
