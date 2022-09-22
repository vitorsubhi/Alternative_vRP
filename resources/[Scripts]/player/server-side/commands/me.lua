-----------------------------------------------------------------------------------------------------------------------------------------
-- ME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("me",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] then
			local identity = vRP.userIdentity(user_id)
			if identity then
				TriggerClientEvent("chatME",source,"^1* "..identity["name"].." ... "..rawCommand:sub(3))

				local players = vRPC.nearestPlayers(source,5)
				for _,v in pairs(players) do
					TriggerClientEvent("chatME",v[2],"^1* "..identity["name"].." ... "..rawCommand:sub(3))
				end
			end
		end
	end
end)