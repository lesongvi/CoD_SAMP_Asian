/*
Author: LuisGraph.
Date: 23/03/2012
Contact: Twitter: @luis29ish
*/

/**************************NATIVES***************************/
/*
native SetPlayerProgressBar(playerid, Float:X, Float:Y, interval, name[]);
native DestroyBarToPlayer(playerid);
native IsPlayerBarCharged(playerid);
*/


#if defined _L_Bar
#endinput
#endif
#define _L_Bar_included
#pragma library L_Bar

/***********************************************************/
//////////////////////////50%
/**********************************************************/

#include <a_samp>

new Text:L_Bars[MAX_PLAYERS][5];
new L_BarsTimers[MAX_PLAYERS][2];
new Count[MAX_PLAYERS];

forward Actualizar(playerid, Float:X);
forward DestroyBarToPlayer(playerid);
forward IsPlayerBarCharged(playerid);


stock SetPlayerProgressBar(playerid, Float:X, Float:Y, interval, name[])
{
	Count[playerid] = 0;
	L_Bars[playerid][0] = TextDrawCreate(X, Y,"_");
	/********************************************************/
	
	TextDrawUseBox(L_Bars[playerid][0],1);
	TextDrawBoxColor(L_Bars[playerid][0],0x00000099);
	TextDrawTextSize(L_Bars[playerid][0],400.000000,1.060000);
	TextDrawAlignment(L_Bars[playerid][0],0);
	TextDrawBackgroundColor(L_Bars[playerid][0],0x000000ff);
	TextDrawFont(L_Bars[playerid][0],3);
	TextDrawLetterSize(L_Bars[playerid][0],1.000000,3.0);
	TextDrawColor(L_Bars[playerid][0],0xffffffff);
	TextDrawSetOutline(L_Bars[playerid][0],1);
	TextDrawSetProportional(L_Bars[playerid][0],1);
	TextDrawSetShadow(L_Bars[playerid][0],1);
	TextDrawShowForPlayer(playerid, L_Bars[playerid][0]);
	
	/********************************************************/
	L_Bars[playerid][1] = TextDrawCreate(X+4, Y+1,"_");
	/********************************************************/
	
	TextDrawUseBox(L_Bars[playerid][1],1);
	TextDrawBoxColor(L_Bars[playerid][1],0xADB5C6FF);
	TextDrawTextSize(L_Bars[playerid][1],395.000000,1.060000);
	TextDrawAlignment(L_Bars[playerid][1],0);
	TextDrawBackgroundColor(L_Bars[playerid][1],0x000000ff);
	TextDrawFont(L_Bars[playerid][1],3);
	TextDrawLetterSize(L_Bars[playerid][1],0.700000,2.6);
	TextDrawColor(L_Bars[playerid][1],0xffffffff);
	TextDrawSetOutline(L_Bars[playerid][1],1);
	TextDrawSetProportional(L_Bars[playerid][1],1);
	TextDrawSetShadow(L_Bars[playerid][1],1);
	TextDrawShowForPlayer(playerid, L_Bars[playerid][1]);
	
	/********************************************************/
	L_Bars[playerid][2] = TextDrawCreate(X+4, Y+1,"_");
	/********************************************************/
	
	TextDrawUseBox(L_Bars[playerid][2],1);
	TextDrawBoxColor(L_Bars[playerid][2],0x0000D6FF);
	TextDrawAlignment(L_Bars[playerid][2],0);
	TextDrawBackgroundColor(L_Bars[playerid][2],0x000000ff);
	TextDrawFont(L_Bars[playerid][1],3);
	TextDrawLetterSize(L_Bars[playerid][2],0,2.6);
	TextDrawColor(L_Bars[playerid][1],0xffffffff);
	TextDrawSetOutline(L_Bars[playerid][2],1);
	TextDrawSetProportional(L_Bars[playerid][2],1);
	TextDrawSetShadow(L_Bars[playerid][2],1);
 	
 	/********************************************************/
 	L_Bars[playerid][3] = TextDrawCreate(X+70, Y+5,"0");
 	/********************************************************/
 	
 	TextDrawColor(L_Bars[playerid][3], 0xFFFFFFFF);
 	
 	/********************************************************/
 	L_Bars[playerid][4] = TextDrawCreate(X+70, Y-16, name);
 	/********************************************************/

	TextDrawShowForPlayer(playerid, L_Bars[playerid][4]);
	TextDrawFont(L_Bars[playerid][4], 2);
    TextDrawSetShadow(L_Bars[playerid][4],0);
 	
 	/********************************************************/
 	
	L_BarsTimers[playerid][0] = SetTimerEx("Actualizar", interval, true, "if", playerid, X);
 	
}
public IsPlayerBarCharged(playerid)
{
	if(Count[playerid] == 100)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
public Actualizar(playerid, Float:X)
{
	if(Count[playerid] == 101)
	{
	    for(new i; i < 5; i++)
	    {
	    	KillTimer(L_BarsTimers[playerid][0]);
	    	L_BarsTimers[playerid][1] = SetTimerEx("DestroyBarToPlayer", 2000, false, "i", playerid);
		}
		return Count[playerid] = 100;
	}
    new str[5];
 	format(str, 5, "%i%", Count[playerid]);
 	TextDrawSetString(L_Bars[playerid][3], str);
 	TextDrawShowForPlayer(playerid, L_Bars[playerid][3]);

    TextDrawTextSize(L_Bars[playerid][2], floatadd(X, floatmul(Count[playerid], 1.7+0.06)),0.000000);
    TextDrawShowForPlayer(playerid, L_Bars[playerid][2]);
    Count[playerid]++;
    return 1;
    
}
public DestroyBarToPlayer(playerid)
{
 	for(new T; T < 5; T++)
 	{
		TextDrawDestroy(L_Bars[playerid][T]);
 	}
 	KillTimer(L_BarsTimers[playerid][1]);
 	KillTimer(L_BarsTimers[playerid][0]);
}
