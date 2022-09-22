-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:runInspect")
AddEventHandler("police:runInspect",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasPermission(user_id,"Police") then
			TriggerClientEvent("player:Commands",entity[1],true)
			TriggerClientEvent("inventory:Close",entity[1])
			openPlayer[user_id] = vRP.getUserId(entity[1])
			vCLIENT.toggleCarry(entity[1],source)
			openSource[user_id] = entity[1]
			vCLIENT.openInspect(source)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.resetInspect()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if openSource[user_id] then
			if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
				TriggerClientEvent("player:Commands",openSource[user_id],false)
				vCLIENT.toggleCarry(openSource[user_id],source)
			end
		end

		if openSource[user_id] then
			openSource[user_id] = nil
		end

		if openPlayer[user_id] then
			openPlayer[user_id] = nil
		end
	end
end