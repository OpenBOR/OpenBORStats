void thrown()
{// Sets thrown status
    void self = getlocalvar("self");

    changeentityproperty(self, "attacking", 1);
    changeentityproperty(self, "projectile", 1);
}

void dethrown()
{// Disables thrown status
    void self = getlocalvar("self");

    changeentityproperty(self, "attacking", 0);
    changeentityproperty(self, "damage_on_landing", 0);
    changeentityproperty(self, "projectile", 0);
}