#include <a_samp>
#include <foreach>

new Text:ueberschrift[MAX_PLAYERS];
new Text:insidetext[MAX_PLAYERS];

static bool:fnc[1] = false;

public OnGameModeInit()
{
    fnc[0] = (funcidx("CB_OnPlayerConnect") != -1);
    CallLocalFunction("CB_OnGameModeInit", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CB_OnGameModeInit
forward CB_OnGameModeInit();

public OnPlayerConnect(playerid)
{
    if(fnc[0]) CallLocalFunction("CB_OnPlayerConnect", "i", playerid);
    ueberschrift[playerid] = TextDrawCreate(501.000000, 222.000000, "info");
    TextDrawBackgroundColor(ueberschrift[playerid], 50);
    TextDrawFont(ueberschrift[playerid], 2);
    TextDrawLetterSize(ueberschrift[playerid], 0.320000, 1.299999);
    TextDrawColor(ueberschrift[playerid], -1);
    TextDrawSetOutline(ueberschrift[playerid], 1);
    TextDrawSetProportional(ueberschrift[playerid], 1);
    TextDrawUseBox(ueberschrift[playerid], 1);
    TextDrawBoxColor(ueberschrift[playerid], 6062591);
    TextDrawTextSize(ueberschrift[playerid], 586.000000, 0.000000);
    insidetext[playerid] = TextDrawCreate(501.000000, 237.000000, "text");
    TextDrawBackgroundColor(insidetext[playerid], 50);
    TextDrawFont(insidetext[playerid], 0);
    TextDrawLetterSize(insidetext[playerid], 0.270000, 1.000000);
    TextDrawColor(insidetext[playerid], -1);
    TextDrawSetOutline(insidetext[playerid], 1);
    TextDrawSetProportional(insidetext[playerid], 1);
    TextDrawUseBox(insidetext[playerid], 1);
    TextDrawBoxColor(insidetext[playerid], 150);
    TextDrawTextSize(insidetext[playerid], 586.000000, 0.000000);
    return 1;
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect CB_OnPlayerConnect
forward CB_OnPlayerConnect(playerid);

stock CreateBox(playerid,header[],text[])
{
    new string[128];

    format(string, sizeof string,"%s",header);
    TextDrawSetString(Text:ueberschrift[playerid],string);
    TextDrawShowForPlayer(playerid,Text:ueberschrift[playerid]);

    format(string, sizeof string,"%s",text);
    TextDrawSetString(Text:insidetext[playerid],string);
    TextDrawShowForPlayer(playerid,Text:insidetext[playerid]);

    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);

    SetPVarInt(playerid,"CreateBoxEx",1);
    SetTimerEx("CloseBox", 5000, 0, "i", playerid);
    return 1;
}

forward CloseBox(playerid);
public CloseBox(playerid)
{
    TextDrawHideForPlayer(playerid,Text:ueberschrift[playerid]);
    TextDrawHideForPlayer(playerid,Text:insidetext[playerid]);
    return 1;
}