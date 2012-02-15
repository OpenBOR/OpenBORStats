void teledodgez( float dx, float dy, float dz )
{// Dodge by teleporting up or down depending on z location
    void self = getlocalvar("self");
    int x = getentityproperty(self,"x"); //Get character's x coordinate
    int z = getentityproperty(self,"z"); //Get character's z coordinate
    int a = getentityproperty(self,"a"); //Get character's a coordinate
    int dir = getentityproperty(self,"direction"); //Get character's facing direction
    float H;

    if(dir==0){ // Facing left?
      dx = -dx ;
    }

    if(z > (openborconstant("PLAYER_MIN_Z") + openborconstant("PLAYER_MAX_Z")) / 2 ) {
      dz = -dz ;
    }

    H = checkwall(x+dx,z+dz);

    if(H > 0){ // Is there a wall on teleport destination?
      dx = -dx ;
    }

    changeentityproperty(self, "position", x+dx, z+dz, a+dy); //Teleport away!
}