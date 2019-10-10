/*------------------------------------------------------------------------------
Logs:
	Version 1.0:
	    new langguage
	    new pawn code
	Version 1.5:
	    coming soon...
	Version 2.0:
		coming soon...
------------------------------------------------------------------------------*/
#include <a_samp>
#include <YSI\y_hooks>
//==============================================================================
#define _MALAYSIA_LANG 1
#define _ENGLISH_LANG 2

#define MAX_STRINGS 250

forward OnIncludeInit();
//==============================================================================
new
	mLang[MAX_PLAYERS char],
	_Used_Malay_Lang[MAX_PLAYERS];
new 
	Menu:_main;
//==============================================================================
public OnIncludeInit()
{
	new 
		head[MAX_STRINGS];
	_main = CreateMenu(head, 1, 30.0, 200.0, 150.0, 0.0);

	SetMenuColumnHeader(_main, 0, "Malay Lang");
	SetMenuColumnHeader(_main, 0, "English Lang");

	CallLocalFunction("_OnPlayerConnect", "");
	return 1;
}
//==============================================================================
public Hook:_OnPlayerConnect(playerid)
{
	ShowMenuForPlayer(_main, playerid);
	return 1;
}
//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row)
{
	new
		Menu:current = GetPlayerMenu(playerid);
	if(current == _main)
	{
		switch(row)
		{
			case 0: { ShowMenuForPlayer(_main, playerid); }
		}
	}
	new
		Menu:current2 = GetPlayerMenu(playerid);
	if(current2 == _main)
	{
		switch(row)
		{
			case 0: { _Used_Malay_Lang[playerid] = 1; }
			case 1: { _Used_Malay_Lang[playerid] = 0; }
		}
	}
}
//==============================================================================
stock SendLangMessage(playerid, color, const MalayMSG[], const EnglishMSG[])
{
	if(mLang[playerid] == _MALAYSIA_LANG)
	{
		if(_Used_Malay_Lang[playerid] >= 1)
		{
	    		SendClientMessage(playerid, color, MalayMSG);
		}
	}
	else
	{
	    	SendClientMessage(playerid, color, EnglishMSG);	
	}
	return 1;
}
//==============================================================================
