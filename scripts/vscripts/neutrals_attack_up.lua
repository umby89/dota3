neutral_attack_up = class({})
LinkLuaModifier("neutrals_attack_up", "/modifiers/neutrals_attack_up.lua",LUA_MODIFIER_MOTION_NONE)

function GetAttackNeutralKills(playerId: PlayerID)
    if PlayerResource:IsValidPlayerID(playerId) then
        local teamKiller = GetTeam(playerID)
        teamKiller:AddNewModifier(self:GetCaster(), self, "neutrals_attack_up", {duration = 120.0})
end