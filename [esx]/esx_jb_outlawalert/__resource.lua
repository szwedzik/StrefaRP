--[[
 ___________________________________________________________________________________
|																					|
|							Code Edited by: Johnny2525								|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	"config.lua",
	"client/weaponsUtil.lua",
	"client/npcnotify.lua",
	"client.lua"
}