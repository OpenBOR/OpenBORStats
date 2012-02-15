char path0001(void vEnt)
{

    /*
    path0001
    06182010
    Damon V. Caskey

    Return entity path (withotu filename). Pretty suboptimal with a while
    loop, but does the job given OpenBOR's limited string manipulation.
    */

    char    cPath   = getentityproperty(vEnt, "path");			//Sample string.
	char    cStr;
    int     i       = strlength(cPath);

    do                                                                                                  
    {           
        cStr = strright(cPath, i--);               
    }
    while (strinfirst(cStr, "/") == -1);

    return strleft(cPath, i+1);

}