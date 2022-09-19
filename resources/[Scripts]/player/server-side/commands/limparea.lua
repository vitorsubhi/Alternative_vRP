-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Suporte") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			TriggerClientEvent("syncarea",-1,coords["x"],coords["y"],coords["z"],100)
		end
	end
end)