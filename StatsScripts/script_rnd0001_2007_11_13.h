int rnd0001(int iABind, int iBBind, int A, int B, int C, int D){

    /*
    rnd0001
    Damon Vaughn Caskey
    11/13/2007
    Random numeric wrapper.

    iABind: Normally lower boundry.
    iBBind: Normally upper boundry.
    A-D:    Reserved.
    */    

    void vSelf  = getlocalvar("self");      //Calling entity.
    int  iRand;                             //Random numeric placeholder.

    iBBind = (iBBind - iABind) + 1;         //Find difference between desired min and max, then add 1 to create random seed.
    int iRand  = rand()%iBBind;             //Generate random number.

    if (iRand < 0){ iRand = iRand * -1; }   //If resulting random number is negative, convert to positive.
    return iRand + iABind;                  //Add minimum for final result and return.   

}
