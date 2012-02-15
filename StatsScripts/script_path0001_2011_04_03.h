char path0001(void vEnt)
{

    /*
    path0001, http://www.caskeys.com/dc/?p=1314#path0001
	Damon Vaughn Caskey
	2011_06_18
	~2011_04_03    

    Return entity path (withotu filename). Pretty suboptimal with a while
    loop, but does the job given OpenBOR's limited string manipulation.
    */

    char    cPath;								//Get full path.
	char    cStr;								//String work placeholder.
    int     i;									//String length and counter.

	//Default vEnt to self.
	if(!vEnt)
	{
		vEnt = getlocalvar("self");
	}

	cPath	= getentityproperty(vEnt, "path");	//Get caller's full path.
	i		= strlength(cPath);					//Get length of path.

	
	//Start at right side of path and move left, decrementing i with each character. Continue until "/" is found.
    do                                                                                                  
    {           
        cStr = strright(cPath, i--);               
    }
    while (strinfirst(cStr, "/") == -1);

    return strleft(cPath, i+1);					//Return i+1 count of characters from left side of string.

}