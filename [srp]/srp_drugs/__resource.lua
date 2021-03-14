--[[
Name: srp_drugs
Edit: Ciemina#0001 & DaMcHm#9706
Base Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 01/07/2019 - 20:31
]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'server/client.lua'
}

client_scripts {
  'client/main.lua',
  'config.lua'
}