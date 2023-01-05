if shared.CharacterSignal then
    shared.CharacterSignal:Disconnect();
end

local Dump = loadstring(game:HttpGet('https://raw.githubusercontent.com/strawbberrys/LuaScripts/main/TableDumper.lua'))()

local Players = game:GetService("Players");

local LocalPlayer = Players.LocalPlayer;
local Backpack = LocalPlayer.Backpack;

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();

shared.CharacterSignal = LocalPlayer.CharacterAdded:Connect(function(NewCharacter) 
    Character = NewCharacter;
end) 

local function GetTool()
    return Character:FindFirstChildOfClass("Tool") or Backpack:FindFirstChildOfClass("Tool");
end

local Tool = GetTool();

local Script = Tool:FindFirstChild("GunScript");

print(Dump(getsenv(Script)))

local PossibleGunData = {}

for Index, Value in ipairs(getgc(true)) do
    if type(Value) == "table" and rawget(Value, "drag") then
        table.insert(PossibleGunData, Value);
    end
end

local function GetTickColor()
    return Color3.fromHSV(tick() % 10 / 10, 1, 1)
end

for Index, Value in ipairs(PossibleGunData) do
    print(Dump(Value))
    
    local Value = setmetatable(Value, {
        __index = function(self, Index)
            if Index == "tracerColor" then
                return GetTickColor()
            end
            
            return rawget(self, Index)
        end
    })
    
    rawset(Value, "drag", 0)
    rawset(Value, "bulletCount", 99)
    rawset(Value, "segmentedReload", 0)
    rawset(Value, "spacing", 0)
    rawset(Value, "mAmmo", 100)
    rawset(Value, "cooloff", 0);
    rawset(Value, "spread", 0);
    rawset(Value, "reloadTime", 0)
    rawset(Value, "gravityMultiplier", 0);
    rawset(Value, "maxTDist", 99999999);
    rawset(Value, "forceMultiplier", 999999)
end

