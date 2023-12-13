if radiant_miniboss == nil then
	radiant_miniboss = class({})
end

function radiant_miniboss:Init()
    if IsInToolsMode() then --debug
        GameRules:GetGameModeEntity():SetThink("SpawnRadiantMiniboss", self, 1)
    else
        GameRules:GetGameModeEntity():SetThink("SpawnRadiantMiniboss", self, 300)
    end

    ListenToGameEvent('entity_killed', OnMinibossDied, nil)
end

function radiant_miniboss:SpawnRadiantMiniboss()
    local positionToSpawn = Vector(-3822.00, -4939.00, 384)
    if self ~= nil then
        CreateUnitByName("radiant_miniboss", thisEntity:GetAbsOrigin(), true, thisEntity ,thisEntity:GetOwner(), nil) --TODO: FIX THIS 
    end    
    --SPAWN AT LOCATION
    --SPAWN WITH LIFETIME?
    return 30
end

function radiant_miniboss:OnMinibossDied(keys)
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
    if killedUnit:IsCreature() then
        RollDrops(killedUnit)
    end
end

function radiant_miniboss:RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for item_name,chance in pairs(DropInfo) do
            if RollPercentage(chance) then
                -- Create the item
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync( pos, item )
                local pos_launch = pos+RandomVector(RandomFloat(150,200))
                item:LaunchLoot(false, 200, 0.75, pos_launch)
            end
        end
    end
end