-- BALKAN HEINEKEN 
--https://trovo.live/Blagii

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetIdentifierWithoutLicense(Identifier)
    return string.gsub(Identifier, "license:", "")
end


ESX.RegisterServerCallback('heineken_vip:getVIPStatus', function(source, cb)
	local license = GetPlayerIdentifiers(source)[2]
	local identifier = string.gsub(license, "license:", "")

	MySQL.Async.fetchScalar('SELECT vip FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(vip)
		if vip then
			print(('heineken_vip: %s VIP status je resetovan za igraca!'):format(identifier))
		end

		cb(vip)
	end)
end)

RegisterServerEvent('heineken_vip:setVIPStatus')
AddEventHandler('heineken_vip:setVIPStatus', function(vip)
	local license = GetPlayerIdentifiers(source)[2]
	local identifier = string.gsub(license, "license:", "")

	if type(vip) ~= 'boolean' then
		print(('heineken_vip: %s attempted to parse something else than a boolean to setVIPStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET vip = @vip WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@vip'] = vip
	})
end)


ESX.RegisterCommand('addvip', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('heineken_vip:addVIPStatus')
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(158, 35, 35, 0.4); border-radius: 3px;"><i class="fas fa-globe"></i> <b>[Igrac je dodan kao VIP]</b></i></div>'
		})	
end, true, {help = 'dodajte vip igracu', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterCommand('delvip', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('heineken_vip:removeVIPStatus')
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(158, 35, 35, 0.4); border-radius: 3px;"><i class="fas fa-globe"></i> <b>[Igracu je uklonjen VIP]</b></i></div>'
		})	
end, true, {help = 'uklonite vip igracu', validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

-- BALKAN HEINEKEN 
--https://trovo.live/Blagii