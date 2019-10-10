/*
This include is made by =>Sandra<=.
Do not take credits of what is not yours!
Enjoy!
*/

#include <a_samp>
/*
native PlayerNameIs(playerid, const name[]);
native PlayerNameContains(playerid, const name[]);
native PlayerNameStartsWith(playerid, const name[]);
native PlayerNameEndsWith(playerid, const name[]);
native ReversePlayerName(playerid);
*/
stock PlayerNameIs(playerid, const name[])
{
	if(IsPlayerConnected(playerid))
	{
		new PName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PName, sizeof(PName));
		if(strcmp(PName, name, true)==0)
		{
		    return 1;
		}
		else
		{
			return 0;
		}
	}
	else
	{
	    return 0;
	}
}


stock PlayerNameContains(playerid, const name[])
{
	if(IsPlayerConnected(playerid))
	{
		new PName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PName, sizeof(PName));
		for(new i=0; i<sizeof(PName); i++)
		{
			if(strfind(PName[i], name, true) != -1)
			{
		    	return 1;
			}
		}
	}
	else
	{
	    return 0;
	}
	return 0;
}

stock PlayerNameStartsWith(playerid, const name[])
{
	if(IsPlayerConnected(playerid))
	{
		new PName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PName, sizeof(PName));
		if(strfind(PName, name, true)==0)
		{
	    	return 1;
		}
	}
	else
	{
	    return 0;
	}
	return 0;
}

stock PlayerNameEndsWith(playerid, const name[])
{
	if(IsPlayerConnected(playerid))
	{
		new PName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PName, sizeof(PName));
		new startofend = strlen(PName)-strlen(name);
		if(strcmp(PName[startofend], name, true)==0)
		{
	    	return 1;
		}
	}
	else
	{
	    return 0;
	}
	return 0;
}

stock ReversePlayerName(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new PName[MAX_PLAYER_NAME], NewName[MAX_PLAYER_NAME], idx;
		GetPlayerName(playerid, PName, sizeof(PName));
		idx = strlen(PName);
		for(new i; i<strlen(PName); i++)
		{
			NewName[i] = PName[idx-1];
			idx--;
		}
		SetPlayerName(playerid, NewName);
		return 1;
	}
	else
	{
	    return 0;
	}
}
	
			
		