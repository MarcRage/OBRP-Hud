local QBCore = exports['qb-core']:GetCoreObject()

local seatbeltOn = false
local cruiseOn = false
local inVehicle = false

------------------------------------------------------------
-- FORCE HUD TO SHOW ON LOAD
------------------------------------------------------------
CreateThread(function()
    Wait(1500)
    SendNUIMessage({
        action = "toggleHud",
        show = true
    })
end)

------------------------------------------------------------
-- PLAYER HUD LOOP
------------------------------------------------------------
CreateThread(function()
    while true do
        local ped = PlayerPedId()

        local health = GetEntityHealth(ped) - 100
        local armor = GetPedArmour(ped)
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())

        local hunger = LocalPlayer.state.hunger or 100
        local thirst = LocalPlayer.state.thirst or 100
        local stress = LocalPlayer.state.stress or 0

        SendNUIMessage({
            action = "updatePlayerHud",
            health = health,
            armor = armor,
            hunger = hunger,
            thirst = thirst,
            stress = stress,
            stamina = stamina
        })

        Wait(300)
    end
end)

------------------------------------------------------------
-- VEHICLE HUD LOOP
------------------------------------------------------------
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)

        if veh ~= 0 and GetPedInVehicleSeat(veh, -1) == ped then

            if not inVehicle then
                inVehicle = true
            end

            local speed = GetEntitySpeed(veh) * 3.6
            local fuel = Entity(veh).state.fuel or GetVehicleFuelLevel(veh) or 0
            local engine = GetVehicleEngineHealth(veh)
            local rpm = GetVehicleCurrentRpm(veh)
            local gear = GetVehicleCurrentGear(veh)
            local lightsOn, highbeamsOn = GetVehicleLightsState(veh)

            SendNUIMessage({
                action = "updateVehicleHud",
                show = true,
                speed = math.floor(speed),
                fuel = math.floor(fuel),
                engine = math.floor(engine / 10),
                rpm = math.floor(rpm * 100),
                gear = gear > 0 and gear or "N",
                seatbelt = seatbeltOn,
                cruise = cruiseOn,
                lights = lightsOn == 1,
                highbeams = highbeamsOn == 1
            })

            Wait(100)

        else
            if inVehicle then
                inVehicle = false
                SendNUIMessage({
                    action = "updateVehicleHud",
                    show = false
                })
            end

            Wait(500)
        end
    end
end)

------------------------------------------------------------
-- SEATBELT (B KEY)
------------------------------------------------------------
CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(0, 29) then -- B
            seatbeltOn = not seatbeltOn

            if seatbeltOn then
                DisableControlAction(0, 75, true)
            else
                DisableControlAction(0, 75, false)
            end
        end
    end
end)