--[[
Name: srp_whitelist
Author: Ezi - Ezi#0001
Version: v0.01.3612
Date: 21/06/2019 - 12:16
]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'config.lua'
}

client_scripts {
  'client/main.lua',
  'config.lua'
}