local keywords = {}

buffCollection = {
    heal = {
        name = "Heal",
        type = "buff",
        heal = true,
        shield = false,
        armor = false,
        manashield = false,
        ward = false,
        overtime = false
    },
    regen = {
        name = "Regen",
        type = "buff",
        heal = true,
        shield = false,
        armor = false,
        manashield = false,
        ward = false,
        overtime = true
    },
    shield = {
        name = "Shield",
        type = "buff",
        heal = false,
        shield = true,
        armor = false,
        manashield = false,
        ward = false,
        overtime = false
    },
    cover = {
        name = "Cover",
        type = "buff",
        heal = false,
        shield = false,
        armor = true,
        manashield = false,
        ward = false,
        overtime = false
    },
    manashield = {
        name = "Manashield",
        type = "buff",
        heal = false,
        shield = false,
        armor = false,
        manashield = true,
        ward = false,
        overtime = false
    },
    ward = {
        name = "Ward",
        type = "buff",
        heal = false,
        shield = false,
        armor = false,
        manashield = false,
        ward = true,
        overtime = false
    },


}

damageCollection = {
    pierce = {
        name = "Pierce",
        shieldPierce = true,
        armorPierce = false,
        manashieldPierce = true,
        wardPierce = false
    },
    breakthrough = {
        name = "Breakthrough",
        shieldPierce = true,
        armorPierce = true,
        manashieldPierce = false,
        wardPierce = false
    },
    burn = {
        name = "Burn",
        shieldPierce = true,
        armorPierce = false,
        manashieldPierce = false,
        wardPierce = false
    },
    melt = {
        name = "Melt",
        shieldPierce = true,
        armorPierce = true,
        manashieldPierce = false,
        wardPierce = false
    },
    truedmg = {
        name = "True Damage",
        shieldPierce = true,
        armorPierce = true,
        manashieldPierce = true,
        wardPierce = true
    }
}


return keywords