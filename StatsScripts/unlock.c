void main () {
int     i       = openborvariant("models_cached");    
        int     iSel;
        char    cName;

        log("\n Cached: " + i);
        log("\n Loaded: " + openborvariant("models_loaded"));        

        for(i=0;i<openborvariant("models_cached");i++)      //Loop model collection.  
        {
            cName   = getmodelproperty(i, 1);               //Get name.
            iSel    = getmodelproperty(i, 4);               //Get selectable flag..    

            if (cName == "Metal_Sonic_MK1")                            //Is this Alex?
            {
                if(iSel)                                    //Selectable?                         
                {
                    iSel = 0;                               //Toggle Select flag off.   
                }
                else                                        //Not selectable?
                {
                    iSel = 1;                               //Toggle select flag on.
                }
                
                changemodelproperty(i, 4, iSel);            //Apply select flag.
            }

            log("\n Index: "    + i);
            log("\n Load: "     + getmodelproperty(i, 0));
            log("\n Model: "    + cName);
            log("\n Name: "     + getmodelproperty(i, 2));
            log("\n Path: "     + getmodelproperty(i, 3));
            log("\n Select: "   + iSel + "\n");
        }
}