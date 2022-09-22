-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("911",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] and vRP.getHealth(source) > 101 then
			if vRP.hasPermission(user_id,"Police") then
				local identity = vRP.userIdentity(user_id)

				local policeResult = vRP.numPermission("Police")
				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("chatME",v,"^7"..identity["name"].." "..identity["name2"]..": ^4"..rawCommand:sub(4))
					end)
				end
			end
		end
	end
end)