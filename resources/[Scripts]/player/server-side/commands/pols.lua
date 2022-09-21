-----------------------------------------------------------------------------------------------------------------------------------------
-- POLS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("pols",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("police:updateService",source, args[1])
		end
	end
end)