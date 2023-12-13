if custom_tower_behaviour == nil then
	custom_tower_behaviour = class({})
end

function custom_tower_behaviour:init()

    print('custom_tower_behaviour:init')
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
                    -- if hAbility:GetAutoCastState() then
                    -- 	hAbility:ToggleAutoCast()
                    -- end
                    if hAbility:GetToggleState() ~= true then
                    hAbility:ToggleAbility()						
                    end	
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
                    -- if hAbility:GetAutoCastState() then
                    -- 	hAbility:ToggleAutoCast()
                    -- end
                    if hAbility:GetToggleState() ~= true then
                    hAbility:ToggleAbility()						
                    end	
                end
            end           
        
        end

        --BOT GOOD GUYS
        radiantBotTowers = Entities:FindAllByName("npc_dota_custom_tower_bot_goodguys")
        for i = 1, #radiantBotTowers do
            for j = 0, 3 do
                local hAbility = radiantBotTowers[i]:GetAbilityByIndex(j)
                if hAbility ~= nil then
                                        
                    Say(nil, tostring(hAbility), false) 						
                    hAbility:SetLevel(0)
                    if hAbility:GetToggleState() ~= true then
                    hAbility:ToggleAbility()						
                    end	
                end
            end           
        
        end
end

-- 3 is for radiant? 2 for dire?
function TowerFollen (eventInfo)
    print(eventInfo.teamnumber)
    local heal = 2000
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
                local targetTower = radiantTopTowers[i]

                local value = math.min(heal, targetTower:GetHealthDeficit())
                targetTower:Heal(value, self); 
                targetTower:EmitSound("Hero_Omniknight.Purification")
                print(targetTower:GetBaseHealthRegen())
                targetTower:SetBaseHealthRegen(targetTower:GetBaseHealthRegen() * 2)
                print(targetTower:GetBaseDamageMax())
                targetTower:SetBaseDamageMax(targetTower:GetBaseDamageMax() * 2)
                print(targetTower:GetBaseDamageMin())
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



                
                for j = 0, 3 do
                    local hAbility = targetTower:GetAbilityByIndex(j)
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
                for j = 0, 3 do
                     local hAbility = radiantMidTowers[i]:GetAbilityByIndex(j)
                    if hAbility ~= nil then
                                             
                        Say(nil, tostring(hAbility), false)
                        local value = math.min(heal, radiantMidTowers[i]:GetHealthDeficit())
                        radiantMidTowers[i]:Heal(value, self);  
                        radiantMidTowers[i]:EmitSound("Hero_Omniknight.Purification")
                        
                        -- Particle 
                        local particle = ParticleManager:CreateParticle("particles/generic_hero_status/hero_levelup.vpcf", PATTACH_ABSORIGIN_FOLLOW, radiantMidTowers[i])
                        ParticleManager:ReleaseParticleIndex( particle )

                        ParticleManager:SetParticleControl(particle, 0, radiantMidTowers[i]:GetAbsOrigin())
                        ParticleManager:SetParticleControl(particle, 1, Vector(200,0,0))

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
         radiantBotTowers = Entities:FindAllByName("npc_dota_custom_tower_bot_goodguys")
        if radiantBotTowers ~= nil then
            for i = 1, #radiantBotTowers do
                for j = 0, 3 do
                    local hAbility = radiantBotTowers[i]:GetAbilityByIndex(j)
                    if hAbility ~= nil then
                                             
                        Say(nil, tostring(hAbility), false) 
                        local value = math.min(heal, radiantBotTowers[i]:GetHealthDeficit())
                        radiantBotTowers[i]:Heal(value, self);
                        radiantBotTowers[i]:EmitSound("Hero_Omniknight.Purification")
                        
                        -- Particle 
                        local particle = ParticleManager:CreateParticle("particles/generic_hero_status/hero_levelup.vpcf", PATTACH_ABSORIGIN_FOLLOW, radiantBotTowers[i])
                        ParticleManager:ReleaseParticleIndex( particle )

                        ParticleManager:SetParticleControl(particle, 0, radiantBotTowers[i]:GetAbsOrigin())
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




