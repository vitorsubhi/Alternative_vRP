-----------------------------------------------------------------------------------------------------------------------------------------
-- REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("repose",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local timer = parseInt(args[2])
			local nuser_id = parseInt(args[1])
			local uSource = vRP.userSource(nuser_id)
			if uSource then
				local identity = vRP.userIdentity(nuser_id)
				if vRP.request(source,"Deseja aplicar <b>"..timer.." minutos</b> de repouso no(a) <b>"..identity["name"].." "..identity["name2"].."</b>?.",30) then
					TriggerClientEvent("Notify",source,"azul","Aplicou <b>"..timer.." minutos</b> de repouso.",10000)
					vRP.reposeTimer(nuser_id,timer)
				end
			end
		end
	end
end)