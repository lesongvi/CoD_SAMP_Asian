#include <a_samp>

new CallSpawn;
new Float:Random[][] = {
 {x, y , z},
 {x, y, z},
 {x, y, z}
};
public OnPlayerSpawn(playerid)
{
if(CallSpawn = 1)
{
new rand = random(sizeof(Random));
SetPlayerPos(playerid, Random[rand][0], Random[rand][1], Random[rand][2]);

stock SetPlayerSpawnEx(playerid, Float:x,Float:y,Float:z, repeat)
{
if(repeat == true)
{
CallSpawn = 1;
}
else
{
CallSpawn = 0;
}
return 1;
}