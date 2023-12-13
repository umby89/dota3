if custom_tower_behaviour == nil then
	custom_tower_behaviour = class({})
end

function custom_tower_behaviour:Init()

    print('custom_tower_behaviour:Init')
    SetAllTowerAbilityInactive()

    if ontowerkill_event == nil then 
        ontowerkill_event = ListenToGameEvent("dota_tower_kill", TowerFollen, nil)  
    end
end


function SetAllTowerAbilityInactive()
    print('SetAllTowerAbilityInactive')
    Say(nil, "SET ABILITY TO DEACTIVE", false)
    -- TOP GOOD GUYS
    radiantTopTowers = Entities:FindAllByName("npc_dota_custom_tower_top_goodguys")
    for i = 1, #radiantTopTowers do      
        for j = 0, 3 do
            local hAbility = radiantTopTowers[i]:GetAbilityByIndex(j)
            if hAbility ~= nil then
                                    
                Say(nil, tostring(hAbility), false) 						
                hAbility:SetLevel(0)						
            end	
        end
    end           
    
    -- MID GOOD GUYS
    radiantMidTowers = Entities:FindAllByName("npc_dota_custom_tower_mid_goodguys")
    for i = 1, #radiantMidTowers do
        for j = 0, 3 do
            local hAbility = radiantMidTowers[i]:GetAbilityByIndex(j)
            if hAbility ~= nil then
                                    
                Say(nil, tostring(hAbility), false) 						
                hAbility:SetLevel(0)						
            end	
        end                     
    
    end

    --BOT GOOD GUYS
    radiantBotTowers = Entities:FindAllByName("npc_dota_custom_tower_bottom_goodguys")
    for i = 1, #radiantBotTowers do
        for j = 0, 3 do
            local hAbility = radiantBotTowers[i]:GetAbilityByIndex(j)
            if hAbility ~= nil then
                                    
                Say(nil, tostring(hAbility), false) 						
                hAbility:SetLevel(0)						
            end	
        end
    end               
end

-- 3 is for radiant? 2 for dire?
function TowerFollen (eventInfo)
    print(eventInfo.teamnumber)    
    if eventInfo.teamnumber == 2 then
        Say(nil, "A TAWERKA IS DOWN", false)

        -- GetBaseHealthRegen
        -- SetBaseHealthRegen
        -- GetBaseDamageMax
        -- SetBaseDamageMax
        -- GetBaseDamageMin
        -- SetBaseDamageMin
        -- GetHealthRegen       
        -- GetDeathXP
        -- SetDeathXP
        -- GetMaximumGoldBounty
        -- SetMaximumGoldBounty
        -- GetMinimumGoldBounty
        -- SetMinimumGoldBounty

         -- TOP GOOD GUYS
        radiantTopTowers = Entities:FindAllByName("npc_dota_custom_tower_top_goodguys")
        if radiantTopTowers ~= nil then
            for i = 1, #radiantTopTowers do      
                local targetTowerTop = radiantTopTowers[i]

                TowerUpgrade(targetTowerTop)
                
                for j = 0, 3 do
                    local hAbility = targetTowerTop:GetAbilityByIndex(j)
                    if hAbility ~= nil then                                             
                        Say(nil, tostring(hAbility), false)
                        
                            hAbility:SetLevel(hAbility:GetLevel()+2)
                            -- if hAbility:GetAutoCastState() then
                            -- 	hAbility:ToggleAutoCast()
                            -- end
                        if hAbility:GetToggleState() ~= true then
                            hAbility:ToggleAbility()						
                        end	         
                       
                    end
                end       
            end
        end        
 
         -- MID GOOD GUYS
        radiantMidTowers = Entities:FindAllByName("npc_dota_custom_tower_mid_goodguys")
        if radiantMidTowers ~= nil then
            for i = 1, #radiantMidTowers do

                local targetTowermid = radiantMidTowers[i]

                TowerUpgrade(targetTowermid)

                for j = 0, 3 do
                     local hAbility = radiantMidTowers[i]:GetAbilityByIndex(j)
                    if hAbility ~= nil then
                                             
                        Say(nil, tostring(hAbility), false)

                        hAbility:SetLevel(hAbility:GetLevel()+2)
                        -- if hAbility:GetAutoCastState() then
                        -- 	hAbility:ToggleAutoCast()
                        -- end
                            if hAbility:GetToggleState() ~= true then
                                hAbility:ToggleAbility()						
                            end	
                    end
                end                  
            end   
        end
 
         --BOT GOOD GUYS
        radiantBotTowers = Entities:FindAllByName("npc_dota_custom_tower_bottom_goodguys")
        if radiantBotTowers ~= nil then
            for i = 1, #radiantBotTowers do

                local targetTowerbot = radiantBotTowers[i]

                TowerUpgrade(targetTowerbot)                

                for j = 0, 3 do
                    local hAbility = targetTowerbot:GetAbilityByIndex(j)
                    if hAbility ~= nil then
                                             
                        Say(nil, tostring(hAbility), false) 
                        local value = math.min(heal, radiantBotTowers[i]:GetHealthDeficit())
                        targetTowerbot:Heal(value, self);
                        targetTowerbot:EmitSound("Hero_Omniknight.Purification")
                        
                        -- Particle 
                        local particle = ParticleManager:CreateParticle("particles/generic_hero_status/hero_levelup.vpcf", PATTACH_ABSORIGIN_FOLLOW,targetTowerbot)
                        ParticleManager:ReleaseParticleIndex( particle )

                        ParticleManager:SetParticleControl(particle, 0, targetTowerbot:GetAbsOrigin())
                        ParticleManager:SetParticleControl(particle, 1, Vector(200,0,0))


                        hAbility:SetLevel(hAbility:GetLevel()+2)
                            if hAbility:GetToggleState() ~= true then
                                hAbility:ToggleAbility()						
                            end	
                    end
                end           
             
            end   
        end       
    end
end

function TowerUpgrade(targetTower)

    local heal = 2000
    local value = math.min(heal, targetTower:GetHealthDeficit())
    targetTower:Heal(value, self); 
    targetTower:EmitSound("Hero_Omniknight.Purification")
    print(targetTower:GetBaseHealthRegen())
    targetTower:SetBaseHealthRegen(targetTower:GetBaseHealthRegen() * 2)
    print(targetTower:GetBaseDamageMax())
    targetTower:SetBaseDamageMax(targetTower:GetBaseDamageMax() * 2)
    targetTower:SetBaseDamageMin(targetTower:GetBaseDamageMin() * 2)
    print(targetTower:GetDeathXP())
    targetTower:SetDeathXP(targetTower:GetDeathXP() * 2)
    targetTower:SetMaximumGoldBounty(targetTower:GetMaximumGoldBounty() * 2)
    targetTower:SetMinimumGoldBounty(targetTower:GetMinimumGoldBounty() * 2)
                 
     -- Particle 
    local particle = ParticleManager:CreateParticle("particles/generic_hero_status/hero_levelup.vpcf", PATTACH_ABSORIGIN_FOLLOW, targetTower)
    ParticleManager:ReleaseParticleIndex( particle )


    ParticleManager:SetParticleControl(particle, 0, targetTower:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, Vector(200,0,0))
end




