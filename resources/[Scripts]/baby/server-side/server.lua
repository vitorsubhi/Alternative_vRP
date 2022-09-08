-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

RegisterCommand ("carregar", function (source)
	local otherPlayer = vRPC.nearestPlayer(source,2)
	if otherPlayer then
		TriggerClientEvent("player:toggleCarregar",source,otherPlayer)
	end
end)