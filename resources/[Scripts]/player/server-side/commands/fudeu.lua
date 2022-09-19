-----------------------------------------------------------------------------------------------------------------------------------------
-- FUDEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fudeu",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			TriggerClientEvent("player:blockCommands",source,false)
			TriggerClientEvent("inventory:blockButtons",source,false)
		end
	end
end)
