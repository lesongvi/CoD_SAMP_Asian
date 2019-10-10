// Filterscript by (Rog)
#define FILTERSCRIPT

#include <a_samp>

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Headshot System");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}


public OnPlayerConnect(playerid)
{
	return 1;
}

stock GivePlayerScore(playerid, score)
{
  SetPlayerScore(playerid, GetPlayerScore(playerid)+score);
  return 1;
}
stock PlayerName1(playerid)
{
new Name[MAX_PLAYER_NAME];
GetPlayerName(playerid, Name, MAX_PLAYER_NAME);
return Name;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
 if(GetPlayerTeam(issuerid) != GetPlayerTeam(playerid))
 {
     if(weaponid == 34 && bodypart == 9)
     {
     SetPlayerHealth(playerid, 0.0);
     GameTextForPlayer(playerid, "~n~~n~~r~HEADSHOT", 5000, 3);
     GameTextForPlayer(issuerid, "~n~~n~~g~HEADSHOT", 5000, 3);
     GivePlayerScore(issuerid, 2);
     new str[1500];
     format(str,sizeof(str),"Good Job!You Killed %s and got 2+ score for {FF0000}HEADSHOT!", PlayerName1(playerid));
     SendClientMessage(issuerid, 0x00FF00FF, str);
     }
 }
return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

