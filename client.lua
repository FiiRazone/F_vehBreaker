-- Initializing ESX and PlayerData

ESX = nil
playerData = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	playerData = ESX.GetPlayerData()
end)

-- Notif

local function sendNotif(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    SetNotificationBackgroundColor(63)
    DrawNotification(true, false)
end

-- SCRIPT

Citizen.CreateThread(function()
    local player = PlayerPedId()
    while true do
        if IsPedInAnyVehicle(player, false) then
            local pedVeh = GetVehiclePedIsIn(player, false)
            local healVeh = GetVehicleBodyHealth(pedVeh)
            if healVeh < 750 then
            SetVehicleEngineHealth(pedVeh, -4000)
            SetVehicleEngineOn(pedVeh, false, true, true)
            sendNotif("~r~Véhicule détruit")
            end
        end
        Citizen.Wait(1000)
    end
end)