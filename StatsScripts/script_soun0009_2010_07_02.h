//playsample(id, 0, 120, 120, 100, 0);

#include "data/scripts/vars/constants.h"	//http://www.caskeys.com/dc/?p=1314#constants

int soun0009(void vEnt, char cSam, int iPri, int iLVol, int iRVol, int iSpeed, int iLoop, int iTime, int B, int C)
{
    /*
    soun0009
    07022010
    Damon Vaughn Caskey
    Sound effect wrapper. Verify sample and last play time, then 
    play sample with location based stereo effect. 
    */
    
    int   iSnd  = loadsample(cSam, 1);                                                                              //Load sample.           
    int   iETime;
    int   iSTime;
    int   iTest;
    float fX;                                                                                                       //X location.
   
    if(!vEnt    ){  vEnt    = getlocalvar("self");  }
        
    if (iSnd != -1 && vEnt)											                                                //Sample and entity valid?
	{
        iETime = openborvariant("elapsed_time");
        iSTime = getindexedvar(SNDLSTT);
        iTest  = iETime - iSTime;
                     
        if (vEnt == getindexedvar(SNDLSTE)  && (iTest < iTime))
        {                
            return -2;
        }

        //Assign defaults.    
        if(!iLVol   ){  iLVol   = 200;                  }
        if(!iRVol   ){  iRVol   = 200;                  }
        if(!iSpeed  ){  iSpeed  = 100;                  }
                   
        fX      =   getentityproperty(vEnt, "x") - openborvariant("xpos");
        fX      /=  (openborvariant("hResolution") * 0.5);                                                          //Get screen center.    
        iLVol   -=  (iLVol / 2) * fX;                                                                               //Decrease Left volume as entity moves to right.
        iRVol   =   (iRVol / 2) * fX;                                                                               //Decrease Right volume as entity moves to left.

        setindexedvar(SNDLSTI, iSnd);                                                                               //Store sample.
        setindexedvar(SNDLSTT, openborvariant("elapsed_time"));                                                     //Store current time.
        setindexedvar(SNDLSTE, vEnt);                                                                               //Store caller.
		
        playsample(iSnd, iPri, iLVol, iRVol, iSpeed, iLoop);                                                        //Play the sample.
	}
	else                                                                                                            //Sample invalid.
	{
        log("\n Error, soun0009; Sample: - " + cSam);
		log(", Model: " + getentityproperty(vEnt, "model") + "\n");	    //Output eror to log.
	}

    return iSnd;                                                                                                    //Return sample index.
}