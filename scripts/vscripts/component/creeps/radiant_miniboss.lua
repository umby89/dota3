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
    if self ~= nil then
        local radiantMiniboss = Entities:FindAllByName("radiant_miniboss") --TODO NOT WORKING
        if #radiantMiniboss <= 0  then
            print("SpawnRadiantMiniboss number"..#radiantMiniboss)
            CreateUnitByName("radiant_miniboss", positionToSpawn, true, nil, nil, 4) 
        end
    end    
    --SPAWN AT LOCATION
    --SPAWN WITH LIFETIME?
    return 30
end

function OnMinibossDied(keys)
    print("OnMinibossDied keys:")
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
   
	local hero = EntIndexToHScript( keys.entindex_attacker )
    local killerTeam = hero:GetTeam()
    if hero:IsRealHero() then
        local memberID = hero:GetPlayerID()
        local name = hero:GetClassname()
        
        print("OnMinibossDied killedUnit:"..killedUnit:GetUnitName())
        print("OnMinibossDied killerTeam:"..killerTeam)
        print("OnMinibossDied hero:"..hero:GetName())
        print("OnMinibossDied memberID:"..memberID)
        print("OnMinibossDied name:"..name)
        
        --player:AddNewModifier(nil, nil, 'modifier_satyr_hellcaller_unholy_aura', nil)
        --hero:AddNewModifier(nil, nil, 'modifier_satyr_hellcaller_unholy_aura_bonus', nil)
   
        if killedUnit:IsCreature() then
            RollDrops(killedUnit)
        end
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