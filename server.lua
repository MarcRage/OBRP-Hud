local QBCore = exports['qb-core']:GetCoreObject()

------------------------------------------------------------
-- INITIALIZE PLAYER HUD STATES ON LOAD
------------------------------------------------------------
AddEventHandler('QBCore:Server:PlayerLoaded', function(playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if not Player then return end

    -- Ensure statebags exist
    Player.Functions.SetMetaData('hunger', Player.PlayerData.metadata['hunger'] or 100)
    Player.Functions.SetMetaData('thirst', Player.PlayerData.metadata['thirst'] or 100)
    Player.Functions.SetMetaData('stress', Player.PlayerData.metadata['stress'] or 0)

    -- Push to statebags for client HUD
    local ped = GetPlayerPed(playerId)
    local ent = Entity(ped).state

    ent.hunger = Player.PlayerData.metadata['hunger']
    ent.thirst = Player.PlayerData.metadata['thirst']
    ent.stress = Player.PlayerData.metadata['stress']
end)

------------------------------------------------------------
-- UPDATE STATEBAGS WHEN METADATA CHANGES
------------------------------------------------------------
RegisterNetEvent('QBCore:Server:OnMetaDataUpdate', function(playerId, metaKey, metaValue)
    local ped = GetPlayerPed(playerId)
    local ent = Entity(ped).state

    if metaKey == 'hunger' then
        ent.hunger = metaValue
    elseif metaKey == 'thirst' then
        ent.thirst = metaValue
    elseif metaKey == 'stress' then
        ent.stress = metaValue
    end
end)

------------------------------------------------------------
-- EXPORTS FOR OTHER RESOURCES TO UPDATE HUD VALUES
------------------------------------------------------------
exports('SetHunger', function(playerId, value)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.SetMetaData('hunger', value)
    end
end)

exports('SetThirst', function(playerId, value)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.SetMetaData('thirst', value)
    end
end)

exports('SetStress', function(playerId, value)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if Player then
        Player.Functions.SetMetaData('stress', value)
    end
end)

------------------------------------------------------------
-- OPTIONAL: COMMANDS FOR TESTING HUD VALUES
------------------------------------------------------------
QBCore.Commands.Add('sethunger', 'Set hunger level', {{name='value', help='0-100'}}, false, function(source, args)
    local value = tonumber(args[1]) or 100
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        Player.Functions.SetMetaData('hunger', value)
    end
end)

QBCore.Commands.Add('setthirst', 'Set thirst level', {{name='value', help='0-100'}}, false, function(source, args)
    local value = tonumber(args[1]) or 100
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        Player.Functions.SetMetaData('thirst', value)
    end
end)

QBCore.Commands.Add('setstress', 'Set stress level', {{name='value', help='0-100'}}, false, function(source, args)
    local value = tonumber(args[1]) or 0
    local Player = QBCore.Functions.GetPlayer(source)
    if Player then
        Player.Functions.SetMetaData('stress', value)
    end
end)