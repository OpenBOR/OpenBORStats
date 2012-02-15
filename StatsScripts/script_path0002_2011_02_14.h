#include "data/scripts/com/path0001.h"

char path0002(void vEnt)
{

	/*
    path0002
    06182010
    Damon V. Caskey

    Return home folder.
    */

    char    cPath   = path0001(vEnt);			//Sample string.
	char    cStr;
    int     i       = strlength(cPath);

    do                                                                                                  
    {           
        cStr = strright(cPath, i--);               
    }
    while (strinfirst(cStr, "/") == -1);

	i = strlength(strleft(cPath, i+2));

	return strright(cPath, i);

}