
void increasehealthforentity(void aentity,int amount)
{// increase current health amount. Not max health.
// V0.01
    //void self = getlocalvar("self");
    void cmp = getentityproperty(aentity,"health");
    cmp = cmp + amount;
    changeentityproperty(aentity, "health", cmp);
    return aentity;
}



//
void main()
{
  void aenemy = getlocalvar("self");
  void aplayer = getlocalvar("attacker");
  void aplayerrushcnt = 0;
  if(aenemy)
   {
     aplayerrushcnt = getentityproperty(aplayer, "rush_count");
     //Give damage bonus for rush count and subtract health from the enemy
     if (aplayerrushcnt > 3)
     {
       aenemy = increasehealthforentity(aenemy,(-aplayerrushcnt - 3));
     }
     //temp
     if (aplayerrushcnt > 10)
     {
       increasehealthforentity(aplayer,1);
     }

   }

}