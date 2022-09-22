-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] and parseInt(args[2]) > 0 then
			if vRP.hasPermission(user_id,"service"..args[1]) then
				vRP.cleanPermission(args[2])

				if args[1] == "Police" or args[1] == "Paramedic" then
					vRP.setPermission(args[2],"wait"..args[1])
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseFormat(args[2]).."</b> adicionado.",5000)
				else
					vRP.setPermission(args[2],args[1])
					TriggerClientEvent("Notify",source,"verde","Passaporte <b>"..parseFormat(args[2]).."</b> adicionado.",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and args[1] and parseInt(args[2]) > 0 then
			if vRP.hasPermission(user_id,"service"..args[1]) then
				if args[1] == "Police" or args[1] == "Paramedic" then
					vRP.remPermission(args[2],args[1])
					vRP.remPermission(args[2],"wait"..args[1])
					TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..parseFormat(args[2]).."</b> removido.",5000)
				else
					vRP.remPermission(args[2],args[1])
					TriggerClientEvent("Notify",source,"amarelo","Passaporte <b>"..parseFormat(args[2]).."</b> removido.",5000)
				end
			end
		end
	end
end)