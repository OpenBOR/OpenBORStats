//To be used with Entity header "didblockscript"

//Actual code to push back the entity
void succesfulldefense(void other, float spd)
{
  int xPos = getentityproperty(other, "x");
  int aPos = getentityproperty(other, "a");
  int zPos = getentityproperty(other, "z");
  int direction = getentityproperty(other, "direction");
  //make sure it pushes the entity back
  if (direction == 1) { spd = xPos - spd; } else
  if (direction == 0) { spd = xPos + spd; }
  //Velocity does not work on a AI characters
  changeentityproperty(other, "position", spd, zPos, aPos);
}

//Character that blocked will be pushed back
void main()
{
 if(getlocalvar("self"))
   { succesfulldefense(getlocalvar("self"), 10); }

}