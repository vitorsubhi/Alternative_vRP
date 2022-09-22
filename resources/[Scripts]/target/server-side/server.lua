-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
aRP = {}
Tunnel.bindInterface("target",aRP)
vCLIENT = Tunnel.getInterface("target")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp:playerActive",source,user_id)
	TriggerClientEvent("vrp:targetActive",-1)
end)

RegisterCommand("pars",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("paramedic:updateService",source, args[1])
		end
	end
end)

RegisterCommand("pols",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("police:updateService",source, args[1])
		end
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == "target" then
		Wait(3000)

	    TriggerClientEvent("vrp:playerActive",-1)
	    TriggerClientEvent("vrp:targetActive",-1)
    end
end)