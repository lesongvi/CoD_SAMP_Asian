//=========================Add House============================================
CreateHouse(houseid, Float:iconX, Float:iconY, Float:iconZ, Float:interiorX, Float:interiorY, Float:interiorZ, Costa, Sella, Interiora, virtualworld)
{
	new house[256], string[152];
	format(string, sizeof(string),"Cost: %d", Costa);
	Create3DTextLabel(string, 0xFF0000FF, iconX, iconY, iconZ, 50.0, -1, 1);
	format(house, sizeof(house), "Houses/houseid%d.txt",houseid);
	if(!dini_Exists(house))
	{
		dini_Create(house);
		format(hInfo[houseid][Name], 24, "ForSale");
		dini_Set(house, "Name", "ForSale");
		format(hInfo[houseid][Renter], 24, "ForRent");
		dini_Set(house, "Renter", "ForRent");
		hInfo[houseid][Rentable] = 0;
		dini_IntSet(house, "Rentable", 0);
		hInfo[houseid][Rentcost] = 0;
		dini_IntSet(house, "Rentcost", 0);
		hInfo[houseid][Cost] = Costa;
		dini_IntSet(house, "Cost", Costa);
		hInfo[houseid][Sell] = Sella;
		dini_IntSet(house, "Sell", Sella);
		hInfo[houseid][Interior] = Interiora;
		dini_IntSet(house, "Interior", Interiora);
		dini_IntSet(house, "Virtualworld", virtualworld);
		hInfo[houseid][Virtualworld] = virtualworld;
		hInfo[houseid][Locked] = 1;
		dini_IntSet(house, "Locked", 1);
		hInfo[houseid][InteriorX] = interiorX;
		hInfo[houseid][InteriorY] = interiorY;
		hInfo[houseid][InteriorZ] = interiorZ;
		dini_FloatSet(house, "X", interiorX);
		dini_FloatSet(house, "Y", interiorY);
		dini_FloatSet(house, "Z", interiorZ);
		dini_IntSet(house, "RentPay", 0);
		dini_IntSet(house, "RentGet", 0);
		HouseCarInfo[houseid][HouseCar] = 429;
		dini_IntSet(house, "HouseCar", 0);
		HouseCarInfo[houseid][CarModel] = 429;
		dini_IntSet(house, "CarModel", 0);
		HouseCarInfo[houseid][CarX] = 0;
		HouseCarInfo[houseid][CarY] = 0;
		HouseCarInfo[houseid][CarZ] = 0;
		dini_FloatSet(house, "CarX", 0);
		dini_FloatSet(house, "CarY", 0);
		dini_FloatSet(house, "CarZ", 0);
		HouseCarInfo[houseid][CarColor1] = 0;
		HouseCarInfo[houseid][CarColor2] = 0;
		dini_IntSet(house, "CarColor1", 0);
		dini_IntSet(house, "CarColor2", 0);
		HouseCarInfo[houseid][GotCar] = 0;
		print("-");
		print("--------------House Created--------------");
		printf("- Houseid: %d", houseid);
		printf("- Buy Cost: %d", Costa);
		printf("- Sell Cost: %d", Sella);
		printf("- Interior: %d", Interiora);
		printf("- VirtualWorld: %d", virtualworld);
		print("-----------------------------------------");
		print("-");
	}
	else
	{
	    format(hInfo[houseid][Name], 24, dini_Get(house, "Name"));
	    format(hInfo[houseid][Renter], 24, dini_Get(house, "Renter"));
		hInfo[houseid][Rentable] = dini_Int(house, "Rentable");
		hInfo[houseid][Rentcost] = dini_Int(house, "Rentcost");
	    hInfo[houseid][Cost] = dini_Int(house, "Cost");
	    hInfo[houseid][Sell] = dini_Int(house, "Sell");
	    hInfo[houseid][Interior] = dini_Int(house, "Interior");
	    hInfo[houseid][Locked] = dini_Int(house, "Locked");
	    hInfo[houseid][InteriorX] = dini_Float(house, "X");
	    hInfo[houseid][InteriorY] = dini_Float(house, "Y");
		hInfo[houseid][InteriorZ] = dini_Float(house, "Z");
		hInfo[houseid][Virtualworld] = dini_Int(house, "Virtualworld");
	}
    hInfo[houseid][iconx]=iconX;
	hInfo[houseid][icony]=iconY;
	hInfo[houseid][iconz]=iconZ;
	format(house, sizeof(house), "Houses/houseid%d.txt",houseid);
	if(strcmp(hInfo[houseid][Name],"ForSale",true)==0)
	{
		hpick[houseid] = CreatePickup(1273, 23, iconX, iconY, iconZ);//Setting the ICON as it is NOT BOUGHT
	}
	else
	{
		hpick[houseid] = CreatePickup(1272,23, iconX, iconY, iconZ);//Setting the ICON as it is bought
	}
}
CreateHouseCar(houseid, modelid, Float:Carx, Float:Cary, Float:Carz, color1, color2, respawn_delay)
{
	new house[256];
	format(house, sizeof(house), "Houses/houseid%d.txt",houseid);
	if(dini_Exists(house)) //If the file exists
	{
	    HouseCarInfo[houseid][GotCar] = 1; //Set GOT Car to '1'
		if(dini_Int(house, "CarModel")==0)
		{
		    dini_IntSet(house, "CarModel", modelid); //-------------------------//
		    HouseCarInfo[houseid][CarModel] = modelid;
		    HouseCarInfo[houseid][CarX] = Carx;
			HouseCarInfo[houseid][CarY] = Cary;
			HouseCarInfo[houseid][CarZ] = Carz;
			dini_FloatSet(house, "CarX", Carx);
			dini_FloatSet(house, "CarY", Cary);
			dini_FloatSet(house, "CarZ", Carz);
			HouseCarInfo[houseid][CarColor1] = color1;
			HouseCarInfo[houseid][CarColor2] = color2;
			dini_IntSet(house, "CarColor1", color1);
			dini_IntSet(house, "CarColor2", color2);
			dini_IntSet(house, "Respawn_Delay", respawn_delay);
			HouseCarInfo[houseid][Respawn_Delay] = respawn_delay;
 			HouseCarInfo[houseid][HouseCar] = CreateVehicle(HouseCarInfo[houseid][CarModel], Carx, Cary, Carz, 0.0, color1, color2, respawn_delay);
 			//-------------DEBUG---------------------//
		    print("-");
			print("--------------House Car Has been Created--------------");
			printf("- Car Houseid: %d", houseid);
			printf("- Modelid: %d", modelid);
			printf("- Color 1: %d", color1);
			printf("- Color 2: %d", color2);
			printf("- Respawn Delay: %d", respawn_delay);
			print("---------------------------------------");
			print("-");
			//-----------DEBUG----------------------//
		}
		else
		{
		    HouseCarInfo[houseid][CarModel] = dini_Int(house, "CarModel");
		}
		HouseCarInfo[houseid][CarX] = dini_Int(house, "CarX");
		HouseCarInfo[houseid][CarY] = dini_Int(house, "CarY");
		HouseCarInfo[houseid][CarZ] = dini_Int(house, "CarZ");
		HouseCarInfo[houseid][CarColor1] = dini_Int(house, "CarColor1");
		HouseCarInfo[houseid][CarColor2] = dini_Int(house, "CarColor2");
		HouseCarInfo[houseid][Respawn_Delay] = dini_Int(house, "Respawn_Delay");
 		HouseCarInfo[houseid][HouseCar] = CreateVehicle(HouseCarInfo[houseid][CarModel], Carx, Cary, Carz, 0.0, color1, color2, respawn_delay);
	}
}
stock SpawnAtHouse(playerid)
{
	new str1[256],pname[24],str[256];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if (dini_Exists(str1))
	{
		if(dini_Int(str1,"Houseid")!=-255)
		{
			new Float:x,Float:y,Float:z;
			str = dini_Get(str1,"SpawnInt");
			SetPlayerInterior(playerid, strval(str));
			playerint[playerid] = strval(str);
    		x = dini_Float(str1,"SpawnX");
	  		y = dini_Float(str1,"SpawnY");
	  		z = dini_Float(str1,"SpawnZ");
			SetPlayerPos(playerid, x, y, z);
		}
	}
	return 1;
}
stock GetHouseStats(playerid, houseid)
{
	new str2[256];
	format(str2, sizeof(str2), "Owned by: %s", hInfo[hid][Name]);
	SendClientMessage(playerid, yellow, str2);
	if(strcmp(hInfo[hid][Renter],"ForRent",true))
	{
		format(str2, sizeof(str2), "Rented by: %s", hInfo[hid][Renter]);
		SendClientMessage(playerid, blue, str2);
	}
	format(str2,sizeof(str2),"Cost: $%i",hInfo[hid][Cost]);
	SendClientMessage(playerid, green, str2);
}