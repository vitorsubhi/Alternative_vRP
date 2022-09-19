-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderador") then
			local message = vRP.prompt(source,"Mensagem:","")
			if message == "" then
				return
			end

			TriggerClientEvent("smartphone:createSMS",-1,"Governador",message)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSOLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("console",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("smartphone:createSMS",-1,"Governador",rawCommand:sub(9))
	end
end)
