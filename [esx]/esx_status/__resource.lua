--[[
 ___________________________________________________________________________________
|																					|
|							Code Edited by: Johnny2525								|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Status'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/classes/status.lua',
	'client/main.lua'
}

-- ui_page 'html/ui.html'

-- files {
-- 	'html/ui.html',
-- 	'html/css/app.css',
-- 	'html/scripts/app.js'
-- }