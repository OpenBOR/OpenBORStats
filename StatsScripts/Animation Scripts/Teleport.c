void teletarget(int dx, int dy, int dz)
{// Targetting opponent then teleport to target
    void self = getlocalvar("self");
    int dir = getentityproperty(self, "direction");

    if(dir==0){ // Facing left?
      dx = -dx ;
    }

    setlocalvar("T"+self, findtarget(self)); //Get nearest player

    if( getlocalvar("T"+self) != NULL()){
      void target = getlocalvar("T"+self);
      int Tx = getentityproperty(target, "x");
      int Tz = getentityproperty(target, "z");

      changeentityproperty(self, "position", Tx+dx, Tz+dz, dy); //Teleport to target!
    }
}


void deviate(int r, int r2)
{ // Deviates position randomly
// Used together with 'teletarget'
    void self = getlocalvar("self");
    int x = getentityproperty(self,"x"); //Get character's x coordinate
    int z = getentityproperty(self,"z"); //Get character's z coordinate
    int dir = getentityproperty(self,"direction"); //Get character's facing direction
    int dx = rand()%r; // Get random x deviation
    int dz = rand()%r2; // Get random z deviation

    if( (z+dz) < openborconstant("PLAYER_MIN_Z") ) {
      dz = 0;
    } else if( (z+dz) > openborconstant("PLAYER_MAX_Z") ) {
      dz = 0;
    }

    if(dir==0){ // Facing left?
      changeentityproperty(self, "position", x-dx, z+dz); //Deviate!
    }
    else if(dir==1){ // Facing right?
      changeentityproperty(self, "position", x+dx, z+dz); //Deviate!
    }
}