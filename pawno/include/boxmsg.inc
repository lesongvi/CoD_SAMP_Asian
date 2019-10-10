// SendBoxMessage by Arakuta.
// Postado no fórum samp no dia 12/04/13;

#include <a_samp>

new Text:asdfaa[11];
new osahfnmcb[11][128];

stock LoadBox(Float:add)
{
	asdfaa[0] = TextDrawCreate(439.000000 + add, 341.000000, ">");
	TextDrawBackgroundColor(asdfaa[0], 255);
	TextDrawFont(asdfaa[0], 1);
	TextDrawLetterSize(asdfaa[0], 0.140000, 10.300000);
	TextDrawColor(asdfaa[0], -1);
	TextDrawSetOutline(asdfaa[0], 0);
	TextDrawSetProportional(asdfaa[0], 1);
	TextDrawSetShadow(asdfaa[0], 1);
	TextDrawUseBox(asdfaa[0], 1);
	TextDrawBoxColor(asdfaa[0], 85);
	TextDrawTextSize(asdfaa[0], 641.000000, 341.000000);

	asdfaa[10] = TextDrawCreate(446.000000 + add, 342.000000, " ");
	TextDrawBackgroundColor(asdfaa[10], 255);
	TextDrawFont(asdfaa[10], 1);
	TextDrawLetterSize(asdfaa[10], 0.189999, 1.000000);
	TextDrawColor(asdfaa[10], -1);
	TextDrawSetOutline(asdfaa[10], 0);
	TextDrawSetProportional(asdfaa[10], 1);
	TextDrawSetShadow(asdfaa[10], 1);

	asdfaa[8] = TextDrawCreate(446.000000 + add, 360.000000, " ");
	TextDrawBackgroundColor(asdfaa[8], 255);
	TextDrawFont(asdfaa[8], 1);
	TextDrawLetterSize(asdfaa[8], 0.189999, 1.000000);
	TextDrawColor(asdfaa[8], -1);
	TextDrawSetOutline(asdfaa[8], 0);
	TextDrawSetProportional(asdfaa[8], 1);
	TextDrawSetShadow(asdfaa[8], 1);

	asdfaa[9] = TextDrawCreate(446.000000 + add, 351.000000, " ");
	TextDrawBackgroundColor(asdfaa[9], 255);
	TextDrawFont(asdfaa[9], 1);
	TextDrawLetterSize(asdfaa[9], 0.189999, 1.000000);
	TextDrawColor(asdfaa[9], -1);
	TextDrawSetOutline(asdfaa[9], 0);
	TextDrawSetProportional(asdfaa[9], 1);
	TextDrawSetShadow(asdfaa[9], 1);

	asdfaa[7] = TextDrawCreate(446.000000 + add, 369.000000, " ");
	TextDrawBackgroundColor(asdfaa[7], 255);
	TextDrawFont(asdfaa[7], 1);
	TextDrawLetterSize(asdfaa[7], 0.189999, 1.000000);
	TextDrawColor(asdfaa[7], -1);
	TextDrawSetOutline(asdfaa[7], 0);
	TextDrawSetProportional(asdfaa[7], 1);
	TextDrawSetShadow(asdfaa[7], 1);

	asdfaa[6] = TextDrawCreate(446.000000 + add, 378.000000, " ");
	TextDrawBackgroundColor(asdfaa[6], 255);
	TextDrawFont(asdfaa[6], 1);
	TextDrawLetterSize(asdfaa[6], 0.189999, 1.000000);
	TextDrawColor(asdfaa[6], -1);
	TextDrawSetOutline(asdfaa[6], 0);
	TextDrawSetProportional(asdfaa[6], 1);
	TextDrawSetShadow(asdfaa[6], 1);

	asdfaa[5] = TextDrawCreate(446.000000 + add, 386.000000, " ");
	TextDrawBackgroundColor(asdfaa[5], 255);
	TextDrawFont(asdfaa[5], 1);
	TextDrawLetterSize(asdfaa[5], 0.189999, 1.000000);
	TextDrawColor(asdfaa[5], -1);
	TextDrawSetOutline(asdfaa[5], 0);
	TextDrawSetProportional(asdfaa[5], 1);
	TextDrawSetShadow(asdfaa[5], 1);

	asdfaa[4] = TextDrawCreate(446.000000 + add, 395.000000, " ");
	TextDrawBackgroundColor(asdfaa[4], 255);
	TextDrawFont(asdfaa[4], 1);
	TextDrawLetterSize(asdfaa[4], 0.189999, 1.000000);
	TextDrawColor(asdfaa[4], -1);
	TextDrawSetOutline(asdfaa[4], 0);
	TextDrawSetProportional(asdfaa[4], 1);
	TextDrawSetShadow(asdfaa[4], 1);

	asdfaa[3] = TextDrawCreate(446.000000 + add, 404.000000, " ");
	TextDrawBackgroundColor(asdfaa[3], 255);
	TextDrawFont(asdfaa[3], 1);
	TextDrawLetterSize(asdfaa[3], 0.189999, 1.000000);
	TextDrawColor(asdfaa[3], -1);
	TextDrawSetOutline(asdfaa[3], 0);
	TextDrawSetProportional(asdfaa[3], 1);
	TextDrawSetShadow(asdfaa[3], 1);

	asdfaa[2] = TextDrawCreate(446.000000 + add, 413.000000, " ");
	TextDrawBackgroundColor(asdfaa[2], 255);
	TextDrawFont(asdfaa[2], 1);
	TextDrawLetterSize(asdfaa[2], 0.189999, 1.000000);
	TextDrawColor(asdfaa[2], -1);
	TextDrawSetOutline(asdfaa[2], 0);
	TextDrawSetProportional(asdfaa[2], 1);
	TextDrawSetShadow(asdfaa[2], 1);
	
	asdfaa[1] = TextDrawCreate(446.000000 + add, 422.000000, " ");
	TextDrawBackgroundColor(asdfaa[1], 255);
	TextDrawFont(asdfaa[1], 1);
	TextDrawLetterSize(asdfaa[1], 0.189999, 1.000000);
	TextDrawColor(asdfaa[1], -1);
	TextDrawSetOutline(asdfaa[1], 0);
	TextDrawSetProportional(asdfaa[1], 1);
	TextDrawSetShadow(asdfaa[1], 1);
	
	print("SendBoxMessage - By Arakuta");
	return 1;
}

stock SendBoxMessage(msg[])
{
	format(osahfnmcb[10],128,osahfnmcb[9]);
	format(osahfnmcb[9],128,osahfnmcb[8]);
	format(osahfnmcb[8],128,osahfnmcb[7]);
	format(osahfnmcb[7],128,osahfnmcb[6]);
	format(osahfnmcb[6],128,osahfnmcb[5]);
	format(osahfnmcb[5],128,osahfnmcb[4]);
	format(osahfnmcb[4],128,osahfnmcb[3]);
	format(osahfnmcb[3],128,osahfnmcb[2]);
	format(osahfnmcb[2],128,osahfnmcb[1]);
	format(osahfnmcb[1],128,msg);
	TextDrawSetString(asdfaa[1],osahfnmcb[1]);
	TextDrawSetString(asdfaa[2],osahfnmcb[2]);
	TextDrawSetString(asdfaa[3],osahfnmcb[3]);
	TextDrawSetString(asdfaa[4],osahfnmcb[4]);
	TextDrawSetString(asdfaa[5],osahfnmcb[5]);
	TextDrawSetString(asdfaa[6],osahfnmcb[6]);
	TextDrawSetString(asdfaa[7],osahfnmcb[7]);
	TextDrawSetString(asdfaa[8],osahfnmcb[8]);
	TextDrawSetString(asdfaa[9],osahfnmcb[9]);
	TextDrawSetString(asdfaa[10],osahfnmcb[10]);
}

// native SendBoxMessage(const msg[])

stock ShowPlayerBox(playerid)
{
	TextDrawShowForPlayer(playerid,asdfaa[0]);
	TextDrawShowForPlayer(playerid,asdfaa[1]);
	TextDrawShowForPlayer(playerid,asdfaa[2]);
	TextDrawShowForPlayer(playerid,asdfaa[3]);
	TextDrawShowForPlayer(playerid,asdfaa[4]);
	TextDrawShowForPlayer(playerid,asdfaa[5]);
	TextDrawShowForPlayer(playerid,asdfaa[6]);
	TextDrawShowForPlayer(playerid,asdfaa[7]);
	TextDrawShowForPlayer(playerid,asdfaa[8]);
	TextDrawShowForPlayer(playerid,asdfaa[9]);
	TextDrawShowForPlayer(playerid,asdfaa[10]);
}

// native ShowPlayerBox(playerid)

stock HidePlayerBox(playerid)
{
	TextDrawHideForPlayer(playerid,asdfaa[0]);
	TextDrawHideForPlayer(playerid,asdfaa[1]);
	TextDrawHideForPlayer(playerid,asdfaa[2]);
	TextDrawHideForPlayer(playerid,asdfaa[3]);
	TextDrawHideForPlayer(playerid,asdfaa[4]);
	TextDrawHideForPlayer(playerid,asdfaa[5]);
	TextDrawHideForPlayer(playerid,asdfaa[6]);
	TextDrawHideForPlayer(playerid,asdfaa[7]);
	TextDrawHideForPlayer(playerid,asdfaa[8]);
	TextDrawHideForPlayer(playerid,asdfaa[9]);
	TextDrawHideForPlayer(playerid,asdfaa[10]);
}

// native HidePlayerBox(playerid)

stock EditBoxMessage(asdfaaid,msg[])
{
	format(osahfnmcb[asdfaaid],sizeof osahfnmcb,msg);
	TextDrawSetString(asdfaa[asdfaaid],osahfnmcb[asdfaaid]);
}

// native EditBoxMessage(lineid,const msg[])
	