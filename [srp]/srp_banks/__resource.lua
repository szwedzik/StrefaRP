--[[
Name: srp_banks
Author: Ezi - Ezi#0001 & Smerfik - Smerfik#0069
Version: v0.01.3612
Date: 22/06/2019 - 13:32
]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}

client_scripts {
  'client/main.lua',
  'client/doors.lua'
}