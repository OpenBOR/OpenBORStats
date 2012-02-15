void norun()
{// Turns off running status
    void self = getlocalvar("self");
    changeentityproperty(self, "aiflag", "running", 0);
}