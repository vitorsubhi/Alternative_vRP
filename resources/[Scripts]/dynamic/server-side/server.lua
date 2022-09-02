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
Tunnel.bindInterface("dynamic",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local animal = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalRegister(netId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		animal[user_id] = netId
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMACLEANER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.animalCleaner()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("player:deleteObject",-1,animal[user_id])
		animal[user_id] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if animal[user_id] then
		TriggerClientEvent("player:deleteObject",-1,animal[user_id])
		animal[user_id] = nil
	end
end)