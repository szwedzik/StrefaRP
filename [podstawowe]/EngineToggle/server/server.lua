ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if not UseKey then
	RegisterCommand("engine", function(Source, Arguments, RawCommand)
		if #Arguments == 0 then
			TriggerClientEvent('EngineToggle:Engine', Source)
		end
	end, false)
end

RegisterServerEvent('EngineToggle:FixEngines')
AddEventHandler('EngineToggle:FixEngines', function(vehid)
	TriggerClientEvent("EngineToggle:FixEngine", -1, vehid)
end)

local CurrentVersion = '2.3.0'
local GithubResourceName = 'EngineToggle'

PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)
	end)
end)