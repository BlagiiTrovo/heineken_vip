-- BALKAN HEINEKEN 
--https://trovo.live/Blagii

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'VIP Status - Balkan Heineken'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

dependencies {
	'es_extended'
}