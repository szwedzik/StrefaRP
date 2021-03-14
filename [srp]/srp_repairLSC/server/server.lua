ESX = nil
enableprice = true
local price = 500
local qprice = 2500

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- Park Mirror
RegisterServerEvent('srp_repairLSC:checkmoney')
AddEventHandler('srp_repairLSC:checkmoney', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= price) then
				xPlayer.removeBank(price)
				TriggerClientEvent('srp_repairLSC:success', mysource, price)
				
			else
				moneyleft = price - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoney', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:free', mysource)
		end
end)

RegisterServerEvent('srp_repairLSC:checkmoneypremium')
AddEventHandler('srp_repairLSC:checkmoneypremium', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= qprice) then
				xPlayer.removeBank(qprice)
				TriggerClientEvent('srp_repairLSC:successpremium', mysource, qprice)
				societyAccount.addMoney(qprice)
				
			else
				moneyleft = qprice - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneypremium', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:free', mysource)
		end
end)
--Sandy Shores
RegisterServerEvent('srp_repairLSC:checkmoneySS')
AddEventHandler('srp_repairLSC:checkmoneySS', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= price) then
				xPlayer.removeBank(price)
				TriggerClientEvent('srp_repairLSC:successSS', mysource, price)
				
			else
				moneyleft = price - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneySS', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:freeSS', mysource)
		end
end)

RegisterServerEvent('srp_repairLSC:checkmoneypremiumSS')
AddEventHandler('srp_repairLSC:checkmoneypremiumSS', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= qprice) then
				xPlayer.removeBank(qprice)
				TriggerClientEvent('srp_repairLSC:successpremiumSS', mysource, qprice)
				societyAccount.addMoney(qprice)
				
			else
				moneyleft = qprice - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneypremiumSS', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:freeSS', mysource)
		end
end)
-- Paleto Bay
RegisterServerEvent('srp_repairLSC:checkmoneyPB')
AddEventHandler('srp_repairLSC:checkmoneyPB', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= price) then
				xPlayer.removeBank(price)
				TriggerClientEvent('srp_repairLSC:successPB', mysource, price)
				
			else
				moneyleft = price - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneyPB', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:freePB', mysource)
		end
end)

RegisterServerEvent('srp_repairLSC:checkmoneypremiumPB')
AddEventHandler('srp_repairLSC:checkmoneypremiumPB', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= qprice) then
				xPlayer.removeBank(qprice)
				TriggerClientEvent('srp_repairLSC:successpremiumPB', mysource, qprice)
				societyAccount.addMoney(qprice)
				
			else
				moneyleft = qprice - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneypremiumPB', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:freePB', mysource)
		end
end)
-- AirPort
RegisterServerEvent('srp_repairLSC:checkmoneyAirPort')
AddEventHandler('srp_repairLSC:checkmoneyAirPort', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= price) then
				xPlayer.removeBank(price)
				TriggerClientEvent('srp_repairLSC:successAirPort', mysource, price)
				
			else
				moneyleft = price - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneyAirPort', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:freeAirPort', mysource)
		end
end)

RegisterServerEvent('srp_repairLSC:checkmoneypremiumAirPort')
AddEventHandler('srp_repairLSC:checkmoneypremiumAirPort', function()
	local mysource = source
	local xPlayer = ESX.GetPlayerFromId(source)		
		if(enableprice == true) then
			if(xPlayer.getBank() >= qprice) then
				xPlayer.removeBank(qprice)
				TriggerClientEvent('srp_repairLSC:successpremiumAirPort', mysource, qprice)
				societyAccount.addMoney(qprice)
				
			else
				moneyleft = qprice - xPlayer.getBank()
				TriggerClientEvent('srp_repairLSC:notenoughmoneypremiumAirPort', mysource, moneyleft)
			end
		else
			TriggerClientEvent('srp_repairLSC:freeAirPort', mysource)
		end
end)