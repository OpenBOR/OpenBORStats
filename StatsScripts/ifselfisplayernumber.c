void vSelf      = getlocalvar("self");                          //Calling entity
int  iPIndex    = getentityproperty(vSelf, "playerindex");      //Caller's player index.

if (iPlndex == 0)                                               //Player 1?
{
    updateframe(vSelf, {your frame number for player 1 here});  //Set player 1's frame.
}
else if (iPlndex == 1)                                          //Player 2?
{
    updateframe(vSelf, {your frame number for player 2 here});  //Set player 2's frame.
}
else if (iPlndex == 2)                                          //Player 3?.
{
    updateframe(vSelf, {your frame number for player 3 here});  //Set player 3's frame.
}
else if (iPlndex == 3)                                          //Player 4?
{
    updateframe(vSelf, {your frame number for player 4 here});  //Set player 4's frame.
    
    
    
    
    
    
    
    
Doing that would probably break too much backward compatibility with scripted mods that already evaluate entities.

The good news is you can evaluate it as is:

Code:

vEnt = getplayerproperty(0, "entity");

if(vEnt) //==False of entity not found.
{
}


This works too:

Code:

vEnt = getplayerproperty(0, "entity");

if(vEnt==NULL()) //==True if entity found.
{
}