//To be used with Entity header "didblockscript"

//Actual code to push
void knockback(void other, float spd)
{
  if(getentityproperty(other, "direction")==1)
    {spd = -spd;}
  changeentityproperty(other, "velocity", spd, 0, 0);
}

//Character that blocked will push the attacker back
void main()
{
  if(getlocalvar("self"))
  { knockback(getlocalvar("attacker"), 1); }
}