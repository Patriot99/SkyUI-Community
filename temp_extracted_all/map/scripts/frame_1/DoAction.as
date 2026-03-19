function InitExtensions()
{
   WorldMap.InitExtensions();
}
function SetPlatform(aPlatformNum, abPS3Switch)
{
   WorldMap.SetPlatform(aPlatformNum,abPS3Switch);
}
function handleInput(details, pathToFocus)
{
   return WorldMap.handleInput(details,pathToFocus);
}
_global.gfxExtensions = true;
Shared.GlobalFunc.MaintainTextFormat();
Shared.GlobalFunc.SetLockFunction();
var WorldMap = new Map.MapMenu();
SetPlatform(0);
