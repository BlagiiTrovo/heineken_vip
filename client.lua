-- BALKAN HEINEKEN 
--https://trovo.live/Blagii

ESX = nil
local PlayerLoaded = false
vip = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

AddEventHandler('esx:onPlayerSpawn', function()
	vip = false
	ESX.TriggerServerCallback('heineken_vip:getVIPStatus', function(vip)
		if vip then
			while not PlayerLoaded do
				ESX.ShowNotification("VAS VIP STATUS SE UCITAVA...")
				Citizen.Wait(1000)
			end

		ESX.ShowNotification("VIP status: AKTIVAN")
		else
		ESX.ShowNotification("Kao VIP igrač imate više mogućnosti. Posetite naš Discord server za više informacija.")
		end
	end)
end)

function addVIPStatus()
	TriggerServerEvent('heineken_vip:setVIPStatus', true)
	vip = true
end

function removeVIPStatus()
	TriggerServerEvent('heineken_vip:setVIPStatus', false)
	vip = false
end

RegisterNetEvent('heineken_vip:addVIPStatus')
AddEventHandler('heineken_vip:addVIPStatus', function()
	addVIPStatus()
end)

RegisterNetEvent('heineken_vip:removeVIPStatus')
AddEventHandler('heineken_vip:removeVIPStatus', function()
	removeVIPStatus()
end)

-- BALKAN HEINEKEN 
--https://trovo.live/Blagii