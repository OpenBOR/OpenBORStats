// To Use
//@cmd    anichange "ANI_FOLLOW3"
//calls the "anim Follow3" of the Entity


void anichange(void Ani)
{ // Animation changer
    void self = getlocalvar("self");

    changeentityproperty(self, "animation", openborconstant(Ani)); //Change the animation
}