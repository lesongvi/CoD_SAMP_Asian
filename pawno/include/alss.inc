/*
    /////////////////////////////////////////////////////////////////
    //=============================================================//
    //== Anti Lag Shot Sync Remote include made by BigETI © 2012 ==//
    //=============================================================//
    //== You are not allowed to edit this include =================//
    //== and/or release it without my permissions! ================//
    //=============================================================//
    //== File name: alss_remote2.inc ==============================//
    //== Author: Ethem Kurt © =====================================//
    //== Release Date: 19.03.2012 =================================//
    //== Version: V1.0.1 ==========================================//
    //== Lines: 76 ================================================//
    //== File size: 3.35 KB =======================================//
    //=============================================================//
    /////////////////////////////////////////////////////////////////
     
    ||===========================================================================================||
    ||      IMPORTANT: This is just a remote include. You need a main script with alls.inc included! ||
    ||  This is a PVar version include!                                                          ||
    ||===========================================================================================||
    */
     
    //Do not edit those things below!
    #if defined ALSS_REMOTE_INCLUDED_
            #endinput
    #endif
    #define ALSS_REMOTE_INCLUDED_
    #if defined ALSS_INCLUDED_
            #error Do not include alss.inc and alss_remote.inc in one script.
    #endif
    #include <a_samp>
    stock ALSS_SetPlayerHealth(playerid, Float:health)
    {
            SetPVarFloat(playerid, "ALSS_Health", health);
            return SetPlayerHealth(playerid, health);
    }
    #if defined _ALS_SetPlayerHealth
            #undef SetPlayerHealth
    #else
            #define _ALS_SetPlayerHealth
    #endif
    #define SetPlayerHealth ALSS_SetPlayerHealth
    stock ALSS_SetPlayerArmour(playerid, Float:armour)
    {
            SetPVarFloat(playerid, "ALSS_Armour", armour);
            return SetPlayerArmour(playerid, armour);
    }
    #if defined _ALS_SetPlayerArmour
            #undef SetPlayerArmour
    #else
            #define _ALS_SetPlayerArmour
    #endif
    #define TEAM_GERMANY 0
    #define TEAM_IRAQ 1
    #define TEAM_RUSSIA 2
    #define TEAM_USA 3
    #define TEAM_BANGLADESH 4
    #define SetPlayerArmour ALSS_SetPlayerArmour
    stock ALSS_SetPlayerTeam(playerid, teamid) return SetPVarInt(playerid, "ALSS_Team", teamid);
    #if defined _ALS_SetPlayerTeam
            #undef SetPlayerTeam
    #else
            #define _ALS_SetPlayerTeam
    #endif
    #define SetPlayerTeam ALSS_SetPlayerTeam
    #define DisablePlayerTakeDamage(%0) SetPVarInt(%0, "ALSS_NoTakeDamage", 1)
    #define EnablePlayerTakeDamage(%0) DeletePVar(%0, "ALSS_NoTakeDamage")
    #define DisablePlayerGiveDamage(%0) SetPVarInt(%0, "ALSS_NoGiveDamage", 1)
    #define EnablePlayerGiveDamage(%0) DeletePVar(%0, "ALSS_NoGiveDamage")
    /*
    ETIETIETIETI    ETI                 ETIETIETIETI        BigBigBigBig    BigBigBigBigBig         Big
    ETI       ETI   ETI               ETI                   Big                   Big               Big
    ETI        ETI  ETI              ETI                    Big                   Big               Big
    ETI       ETI   ETI             ETI                     Big                   Big               Big
    ETIETIETIETI    ETI             ETI    ETIETIETI        BigBigBig             Big               Big
    ETI       ETI   ETI             ETI          ETI        Big                   Big               Big
    ETI        ETI  ETI              ETI         ETI        Big                   Big               Big
    ETI       ETI   ETI               ETI        ETI        Big                   Big               Big
    ETIETIETIETI    ETI                 ETIETIETIETI        BigBigBigBig          Big               Big
    */
