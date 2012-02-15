//Use in anim block
//                "ANI_animName"
// @cmd    keyint "ANI_FOLLOW4" 0 "A" 0 0
// "jump" "attack" "special" "esc" "start" "moveleft" "moveright" "moveup" "movedown" "screenshot" "anybutton"


void keyint(void Ani, int Frame, void Key, int Hflag, int Limit)
{// Change current animation if proper key is pressed or released provided HP is more than limit
    void self = getlocalvar("self");
    void Health = getentityproperty(self,"health");    
    int iPIndex = getentityproperty(self,"playerindex"); //Get player index
    void iRKey;
      //Direction
      if (Key=="U"){ //Up Required?
       iRKey = playerkeys(iPIndex, 0, "moveup"); // "Up"
	}
      if (Key=="D"){ //Down Required?
        iRKey = playerkeys(iPIndex, 0, "movedown"); // "Down"
	}
      if (Key=="B"){ //Backwards Required?
        iRKey = playerkeys(iPIndex, 0, "moveleft"); // "Backwards"
	}
      if (Key=="F"){ //Down Required?
        iRKey = playerkeys(iPIndex, 0, "moveright"); // "Forward"
	}
      //Keys
      if (Key=="J"){ //Jump Required?
        iRKey = playerkeys(iPIndex, 0, "jump"); // "Jump"
	}
      if (Key=="A"){ //Attack Required?
        iRKey = playerkeys(iPIndex, 0, "attack"); // "Attack"
	}
      if (Key=="S"){ //Special Required?
        iRKey = playerkeys(iPIndex, 0, "special"); // "Special"
	}
      //Direction Plus Attack
      if (Key=="UA"){ //Up Attack Required?
        iRKey = playerkeys(iPIndex, 0, "moveup", "attack"); // "Up Attack"
	}
      if (Key=="DA"){
        iRKey = playerkeys(iPIndex, 0, "movedown", "attack"); // "Down Attack"
	}
      if (Key=="BA"){
        iRKey = playerkeys(iPIndex, 0, "moveleft", "attack"); // "Backwards"
	}
      if (Key=="FA"){
        iRKey = playerkeys(iPIndex, 0, "moveright", "attack"); // "Forward"
	}
      //Direction Plus Jump
      if (Key=="UJ"){
        iRKey = playerkeys(iPIndex, 0, "moveup", "jump"); // "Up" + "Jump"
	}
      if (Key=="DJ"){
        iRKey = playerkeys(iPIndex, 0, "movedown", "jump"); // "Down" + "Jump"
	}
      if (Key=="BJ"){
        iRKey = playerkeys(iPIndex, 0, "moveleft", "jump"); // "Back" + "Jump"
	}
      if (Key=="FJ"){
        iRKey = playerkeys(iPIndex, 0, "moveright", "jump"); // "Forwad" + "Jump"
	}

      if (Hflag==1){ //Not holding the button case?
        iRKey = !iRKey; //Take the opposite condition
	}

      if ((Health > Limit)&&iRKey){
        changeentityproperty(self, "animation", openborconstant(Ani)); //Change the animation
        changeentityproperty(self, "animpos", Frame);

        if (Key=="UJ"){ 
          // This is copy of dethrown
          changeentityproperty(self, "attacking", 0);
          changeentityproperty(self, "damage_on_landing", 0);
          changeentityproperty(self, "projectile", 0);
        }
      }
}