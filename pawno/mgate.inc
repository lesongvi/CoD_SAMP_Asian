new object;
//-----------------------------------
native AddMovingGate(gateid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);

//-----------------------------------
stock AddMovingGate(gateid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
object = CreateObject(971, x,y,z,rx,ry,rz, 250.0);
SetTimer("MoveGate", 10000, true);
}
//------------------------------------
forward MoveGate();
public MoveGate() {
MoveObject(object, x, y+10, z, 20.0, rx, ry, rz);
SetTimer("MoveGate", 10000, true);
return 1;
}