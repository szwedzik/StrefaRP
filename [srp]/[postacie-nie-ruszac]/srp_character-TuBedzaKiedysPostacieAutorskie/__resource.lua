--[[
Name: srp_characters
Author: Ezi - Ezi#0001 & DaMcHm - DaMcHm#9706
Version: v0.01.0001
Date: 16/07/2019 - 20:23
]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}

client_scripts {
  'client/main.lua',
  'config/config.lua'
}