/*
											gStreamer public beta
					I released this version just to test for bugs, and to see if it can
					hold a large ammount of objects in a bigger server. You can test/use
					it for free as long you dont sell, remove these credits, or clame it
					as your own.                                        	©Game931215
*/
//========================================================================================================
#include <a_samp>
#if !defined STREAMER_OBJECT_LIMIT
	#define STREAMER_OBJECT_LIMIT				2000
#endif
#if !defined STREAMER_DISTANCE
	#define STREAMER_DISTANCE					400
#endif
#if !defined STREAMER_TICKRATE
	#define STREAMER_TICKRATE					500
#endif
#if !defined AUTO_ADJUST_STREAM_DISTANCE
	#define AUTO_ADJUST_STREAM_DISTANCE			true
#endif
//========================================================================================================
enum objectinfo
{
	_id,
	_model,
	Float:_x,
	Float:_y,
	Float:_z,
	Float:_rx,
	Float:_ry,
	Float:_rz,
	bool:_streamed,
	bool:_active
};
new Objects[STREAMER_OBJECT_LIMIT][objectinfo];
new currentid = -1;
new streamed_objects = 0;
#if AUTO_ADJUST_STREAM_DISTANCE == true
	new real_stream_distance = STREAMER_DISTANCE;
#endif
//========================================================================================================
/*
		native CreateDynamicObject(modelid,Float:x,Float:y,Float:z,Float:rx,Float:ry,Float:rz)
		native MoveDynamicObject(objectid,Float:X,Float:Y,Float:Z,Float:speed)
		native DestroyDynamicObject(objectid)
		native GetDynamicObjectID(objectid)
		native IsDynamicObjectActive(objectid)
																										*/
//========================================================================================================
#if defined FILTERSCRIPT
	public OnFilterScriptInit()
	{
        SetTimer("streamer",STREAMER_TICKRATE,true);
		//auto lower-stream distance when there are much objects loaded
		#if AUTO_ADJUST_STREAM_DISTANCE == true
		    SetTimer("adjust_distance",5000,true);
		#endif
		return CallLocalFunction("gStreamer_OnFilterScriptInit","");
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit gStreamer_OnFilterScriptInit
	forward gStreamer_OnFilterScriptInit();
#else
	public OnGameModeInit()
	{
        SetTimer("streamer",STREAMER_TICKRATE,true);
		//auto lower-stream distance when there are much objects loaded
		#if AUTO_ADJUST_STREAM_DISTANCE == true
		    SetTimer("adjust_distance",5000,true);
		#endif
		return CallLocalFunction("gStreamer_OnGameModeInit","");
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit gStreamer_OnGameModeInit
	forward gStreamer_OnGameModeInit();
#endif
//========================================================================================================
stock CreateDynamicObject(modelid,Float:X,Float:Y,Float:Z,Float:RX,Float:RY,Float:RZ)
{
	if(currentid +1 > STREAMER_OBJECT_LIMIT) return 1;
	currentid++;
	Objects[currentid][_model] = modelid;
	Objects[currentid][_x] = X;
	Objects[currentid][_y] = Y;
	Objects[currentid][_z] = Z;
	Objects[currentid][_rx] = RX;
	Objects[currentid][_ry] = RY;
	Objects[currentid][_rz] = RZ;
	Objects[currentid][_active] = true;
	Objects[currentid][_streamed] = false;
	return currentid;
}
stock MoveDynamicObject(objectid,Float:X,Float:Y,Float:Z,Float:speed)
{
	if(Objects[objectid][_streamed] == true) MoveObject(Objects[objectid][_id],X,Y,Z,speed);Objects[currentid][_x] = X;Objects[currentid][_y] = Y;Objects[currentid][_z] = Z;
	return 1;
}
stock DestroyDynamicObject(objectid)
{
    Objects[objectid][_active] = false;
    if(Objects[objectid][_streamed] == true)
    {
        Objects[objectid][_streamed] = false;
        DestroyObject(Objects[objectid][_id]);
    }
	return 1;
}
stock GetDynamicObjectID(objectid)
{
    if(Objects[objectid][_streamed] == false) return -1;
	return Objects[objectid][_id];
}

stock IsDynamicObjectActive(objectid)
{
	if(Objects[objectid][_streamed] == true)
	{
	    return 1;
	}
	return 0;
}
//========================================================================================================
forward streamer();
public streamer()
{
	//the actual streaming part
	for(new i = 0;i<currentid +1;i++)
	{
	    if(Objects[i][_active] == true)
	    {
	        if(Objects[i][_streamed] == true)
	        {
	            if(!IsPlayerNearbyObject(i))
	            {
	                streamed_objects--;
	                DestroyObject(Objects[i][_id]);
	                Objects[i][_streamed] = false;
	            }
	        } else {
	            if(IsPlayerNearbyObject(i) && streamed_objects < 399)
	            {
					streamed_objects++;
					Objects[i][_id] = CreateObject(Objects[i][_model],Objects[i][_x],Objects[i][_y],Objects[i][_z],Objects[i][_rx],Objects[i][_ry],Objects[i][_rz]);
                    Objects[i][_streamed] = true;
	            }
	        }
	    }
	}
}
#if AUTO_ADJUST_STREAM_DISTANCE == true
forward adjust_distance();
public adjust_distance()
{
	    if(streamed_objects > 100)
	    {
	        real_stream_distance = STREAMER_DISTANCE / 2;
	    } else if(streamed_objects > 250)
	    {
	        real_stream_distance = STREAMER_DISTANCE / 3;
	    } else if(streamed_objects > 350)
	    {
	        real_stream_distance = STREAMER_DISTANCE / 4;
	    } else if(streamed_objects > 480)
	    {
	        real_stream_distance = STREAMER_DISTANCE / 8;
		} else if (streamed_objects > 490)
		{
		    real_stream_distance = STREAMER_DISTANCE /8;
	    } else {real_stream_distance = STREAMER_DISTANCE;}
}
#endif

stock IsPlayerNearbyObject(objectid)
{
	for(new i = 0;i<MAX_PLAYERS;i++)
	{
	    if(!IsPlayerConnected(i)) continue;
	    #if AUTO_ADJUST_STREAM_DISTANCE == true
	    	if(IsPlayerInRangeOfPoint(i,real_stream_distance,Objects[objectid][_x],Objects[objectid][_y],Objects[objectid][_z])) return 1;
		#else
		    if(IsPlayerInRangeOfPoint(i,STREAMER_DISTANCE,Objects[objectid][_x],Objects[objectid][_y],Objects[objectid][_z])) return 1;
		#endif
	}
	return 0;
}