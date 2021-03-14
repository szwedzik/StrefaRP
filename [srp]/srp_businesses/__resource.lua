--[[
Name: srp_businesses
Author: Ezi - Ezi#0001
Version: v0.1.5
Date: 16/07/2019 - 22:45
]]--

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'locale.lua',
  'locales/pl.lua',
  'locales/en.lua',
  'config.lua'
}

client_scripts {
  'client/main.lua',
  'locale.lua',
  'locales/pl.lua',
  'locales/en.lua',
  'config.lua'
}

dependencies {
  'essentialmode',
  'srp_notify'
}