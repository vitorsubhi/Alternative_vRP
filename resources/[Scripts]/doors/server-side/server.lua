-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("doors",cRP)
vTASKBAR = Tunnel.getInterface("taskbar")

-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[doorNumber]["lock"] = doorStatus

	if doors[doorNumber]["other"] ~= nil then
		local doorSecond = doors[doorNumber]["other"]
		doors[doorSecond]["lock"] = doorStatus
		TriggerClientEvent("doors:Update",-1,doorSecond,doorStatus)
	end

	TriggerClientEvent("doors:Update",-1,doorNumber,doorStatus)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[doorNumber]["perm"] ~= nil then
			if vRP.hasPermission(user_id,doors[doorNumber]["perm"]) then
				return true
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick")
				if consultItem[1] >= 1 then
					if math.random(100) >= 50 then
						vRP.removeInventoryItem(user_id,consultItem[2],1,true)
						vRP.generateItem(user_id,"lockpick2",1,false)
					end

					local taskResult = vTASKBAR.taskDoors(source)
					if taskResult then
						return true
					end
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("doors:doorsUpdate",source,doors)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == "doors" then
		Wait(10000)
		TriggerClientEvent("doors:doorsUpdate",-1,doors)
    end
end)