if GameSetup == nil then
    GameSetup = class({})
end


function GameSetup:init()
    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetGoldPerTick(1.5)
    GameRules:SetPreGameTime(3.0)
    GameRules:SetSameHeroSelectionEnabled(true)
    GameRules:SetStartingGold(99900)
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 3 )
    GameRules:GetGameModeEntity():SetTowerBackdoorProtectionEnabled( true )
    GameRules:SetGoldTickTime(2.0)
    GameRules:SetUseBaseGoldBountyOnHeroes(true)
    GameRules:SetRuneSpawnTime(30.0)
    GameRules:SetUseUniversalShopMode(true)
    --GameRules:SetRespawnTimeScale(0.5)
    GameRules:GetGameModeEntity():SetFreeCourierModeEnabled( true )
    GameRules:SetPostGameLayout( DOTA_POST_GAME_LAYOUT_DOUBLE_COLUMN )
	GameRules:SetPostGameColumns( {
		DOTA_POST_GAME_COLUMN_LEVEL,
		DOTA_POST_GAME_COLUMN_ITEMS,
		DOTA_POST_GAME_COLUMN_KILLS,
		DOTA_POST_GAME_COLUMN_DEATHS,
		DOTA_POST_GAME_COLUMN_ASSISTS,
        DOTA_POST_GAME_COLUMN_DAMAGE,
        DOTA_POST_GAME_COLUMN_NET_WORTH
	} )
          


end




