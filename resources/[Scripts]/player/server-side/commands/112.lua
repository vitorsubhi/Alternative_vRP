-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("112",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] and vRP.getHealth(source) > 101 then
			if vRP.hasPermission(user_id,"Paramedic") then
				local identity = vRP.userIdentity(user_id)

				local paramedicResult = vRP.numPermission("Paramedic")
				for k,v in pairs(paramedicResult) do
					async(function()
						TriggerClientEvent("chatME",v,"^5"..identity["name"].." "..identity["name2"]..": ^4"..rawCommand:sub(4))
					end)
				end
			end
		end
	end
end)