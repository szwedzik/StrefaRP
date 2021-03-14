--[[
 ___________________________________________________________________________________
|																					|
|							Code Edited by: Johnny2525								|
|						Mail: johnny2525.contact@gmail.com							|
|		Linked-In: https://www.linkedin.com/in/jakub-barwi%C5%84ski-09617b164/		|
|___________________________________________________________________________________|

--]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('actionmenu:checkPhone')
AddEventHandler('actionmenu:checkPhone', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local phone = xPlayer.getInventoryItem("blackberry")
	
	if(phone.count <= 0) then
		TriggerClientEvent("esx:showNotification", _source, "~r~Nie posiadasz telefonu!")
	else
		TriggerClientEvent("gcPhone:closeopenPhone", _source)
		--print("trigger telefonu na:" _source)
	end

end)
