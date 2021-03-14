resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX tattoo shop'

version '1.4.1'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/TattoosList/list.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	'skinchanger',
	'esx_skin'
}
