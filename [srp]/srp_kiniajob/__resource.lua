resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'StrefaRP(SRP) Zwierzako Job'

version '2.1.5'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}
