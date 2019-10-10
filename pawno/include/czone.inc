/* 

J_Capture zone creator. Create simple capture using one line! ;D
Credits:
-Icoginto - Streamer plugin and streamer include

*/
#include <streamer> //Credtis to Icoginto
#include <a_samp> //Credits to sa-mp team
//--------Variables----------------------------
new tCP[30];
new iCP[MAX_PLAYERS];
new UnderAttack[30];
new Captured[30];
new CP[30];
new Zone[30];
new timer[MAX_PLAYERS][30];
new CountVar[MAX_PLAYERS] = 25;
new InCP[MAX_PLAYERS][30];
new CountTime[MAX_PLAYERS];
//---------------------------------------------
#define default_color 0xFFFFFFFF
#define captured_color 0x15FF00AA
//---------------------------------------------
forward AddCaptureZone(zoneid, teamid, Float:x, Float:y, Float:z, Float:minX, Float:minY, Float:maxX, Float:maxY);
forward CountDown(playerid);
forward SetCaptureZone(playerid, zoneid);
//---------------------------------------------
public AddCaptureZone(zoneid, teamid, Float:x, Float:y, Float:z, Float:minX, Float:minY, Float:maxX, Float:maxY)
{
    CP[zoneid] = GangZoneCreate(minX, minY, maxX, maxY);
	Zone[zoneid] = CreateDynamicCP(x, y, z ,3, -1,-1,-1,100.0);
	return 1;
}
//---------------------------------------------
/* 
    Correct usage:
	                  Put the following under OnGameModeInit or OnFilterScriptInit (depends on what you use).

					  it must be like : OnInit(zoneid, teamid);

					  WARNING: zoneid and teamid will be the one you will use in AddCaptureZone
*/

stock OnInit(zoneid, teamid)
{
   UnderAttack[zoneid] = -1;
   Captured[zoneid] = -1;
   tCP[zoneid] = teamid;
   return 1;
}

stock  OnConnect(playerid, zoneid)
{
    iCP[playerid] = -1;
    InCP[playerid][zoneid] = 0;
	GangZoneShowForPlayer(playerid, Zone[zoneid], default_color);
	return 1;
}
stock OnDisconnect(playerid, zoneid)
{
   if(InCP[playerid][zoneid] == 1)
   {
	  UnderAttack[zoneid] = 0;
   }
   return 1;
}
public CountDown(playerid)
{
  CountVar[playerid]--;
  if(CountVar[playerid] == 0)
  {
	 CountVar[playerid] = 25;
	 KillTimer(CountTime[playerid]);
  }
  else
  {
     new str[124];
  	 format(str, sizeof(str),"~n~~n~~n~~n~~n~~n~~r~%d/~y~25 ~w~Seconds left~n~~g~to capture", CountVar[playerid]);
	 GameTextForPlayer(playerid, str, 1000, 3);
  }
  CountTime[playerid] = SetTimerEx("CountDown", 1000, false,"i", playerid);
  return 1;
}
stock OnEnterCaptureZone(playerid, checkpointid,  zoneid)
{
   if(checkpointid == CP[zoneid])
   {
	 if(UnderAttack[zoneid] == 1)
	 {
	   SendClientMessage(playerid, 0xFF0000FF,"[ERROR]: This flag is already being taken over kill the player to capture it");
	 }
	 else if(GetPlayerTeam(playerid) == tCP[zoneid])
	 {
        SendClientMessage(playerid, 0xFF0000FF,"[ERROR]: This flag is already controlled by your team");
     }
     else
     {
	      UnderAttack[zoneid] = 1;
		  timer[playerid][zoneid] = SetTimerEx("SetCaptureZone", 25000, false,"id",playerid, zoneid);
		  CountTime[zoneid] = SetTimerEx("CountDown", 1, false,"i", playerid);
		  iCP[playerid] = zoneid;
		  InCP[playerid][zoneid] = 1;
		  Captured[zoneid] = 0;
		  GangZoneFlashForAll(Zone[zoneid], 0xFF0000FF);
	 }
   }
   return 1;
}
stock OnLeaveCaptureZone(playerid, checkpointid, zoneid)
{
  if(checkpointid == CP[zoneid])
  {
	if(Captured[zoneid] == 1)
	{
	   GangZoneStopFlashForAll(Zone[zoneid]);
	   UnderAttack[zoneid] = 0;
	   InCP[playerid][zoneid] = 0;
	   tCP[zoneid] = GetPlayerTeam(playerid);
	   GangZoneShowForAll(Zone[zoneid], captured_color);
	   KillTimer(timer[playerid][zoneid]);
	   KillTimer(CountTime[playerid]);
	}
    else if(Captured[zoneid] == 0)
    {
      SendClientMessage(playerid, 0xFF0000FF,"You have left the flag you have failed to capture the zone!");
      UnderAttack[zoneid] = 0;
      InCP[playerid][zoneid] = 0;
      GangZoneStopFlashForAll(Zone[zoneid]);
      KillTimer(timer[playerid][zoneid]);
      KillTimer(CountTime[playerid]);
    }
  }
  return 1;
}
public SetCaptureZone(playerid, zoneid)
{
  if(iCP[playerid] == zoneid)
  {
	 SetPlayerScore(playerid, GetPlayerScore(playerid)+5);
	 GivePlayerMoney(playerid, 5000);
	 SendClientMessage(playerid, 0xFFFFFFFF,"Congratulations! You have successfully captured a zone! You earned +5 scores and +$5000!");
	 new stringA[64], pName[MAX_PLAYER_NAME];
	 GetPlayerName(playerid, pName, sizeof(pName));
	 format(stringA, sizeof(stringA),"%s has captured %s for his team!",pName, ZoneName(zoneid));
	 SendClientMessageToAll(0xFFFFFFFF, stringA);
	 tCP[zoneid] = GetPlayerTeam(playerid);
	 GangZoneShowForAll(Zone[zoneid], captured_color);
	 GangZoneStopFlashForAll(Zone[zoneid]);
	 Captured[zoneid] = 1;
	 KillTimer(CountTime[playerid]);
	 KillTimer(timer[playerid][zoneid]);
  }
  return 1;
}
stock ZoneName(zoneid)
{
    new str[65];
	switch(zoneid)
	{
     case 0: str = ("Gas Station");
	 case 1: str = ("Your zone name");
	 case 2: str = ("Your zone name");
	 case 3: str = ("Your zone name");
	 case 4: str = ("Your zone name");
	 case 5: str = ("Your zone name");
	 case 6: str = ("Your zone name");
	 case 7: str = ("Your zone name");
	 case 8: str = ("Your zone name");
     case 9: str = ("Your zone name");
 	 case 10: str = ("Your zone name");
	 case 11: str = ("Your zone name");
	 case 12: str = ("Your zone name");
	 case 13: str = ("Your zone name");
	 case 14: str = ("Your zone name");
	}
	return str;
}