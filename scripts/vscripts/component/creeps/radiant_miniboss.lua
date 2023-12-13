if radiant_miniboss == nil then
	radiant_miniboss = class({})
end

function radiant_miniboss:Init()
    GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")

    if IsInToolsMode() then --debug
        GameRules:GetGameModeEntity():SetThink("SpawnRadiantMiniboss", self, 1)
    else
        GameRules:GetGameModeEntity():SetThink("SpawnRadiantMiniboss", self, 300)
    end


    if onminibosskill_event == nil then 
        onminibosskill_event = ListenToGameEvent("entity_killed", OnMinibossDied, nil)  
    end
end

function radiant_miniboss:SpawnRadiantMiniboss()  -- TODO DYNAMIC RETRIVE OF POSITION + NOT SPAWN IF ALREADY EXIST
    local positionToSpawn = Vector(-3822.00, -4939.00, 384)
    print('SpawnRadiantMiniboss')
    print(self)
    if self ~= nil then
        radiantMiniboss = Entities:FindAllByName("radiant_miniboss") --TODO NOT WORKING
        if #radiantMiniboss <= 0  then
            print(radiantMiniboss)
            print(#radiantMiniboss)
            CreateUnitByName("radiant_miniboss", positionToSpawn, true, nil, nil, 4) 
        end
    end    
    --SPAWN AT LOCATION
    --SPAWN WITH LIFETIME?
    return 30
end

function OnMinibossDied(keys)
    print(keys)
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    print(killedUnit)
    if killedUnit:IsCreature() then
        RollDrops(killedUnit)
    end
end

function RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for item_name,chance in pairs(DropInfo) do
            if RollPercentage(chance) then
                -- Create the item
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync( pos, item )
                local pos_launch = pos+RandomVector(RandomFloat(150,200))
                item:LaunchLoot(false, 200, 0.75, pos_launch, nil)
            end
        end
    end
end