-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) > 101 then
			if args[2] == "friend" then
				local otherPlayer = vRPC.nearestPlayer(source,3)
				if otherPlayer then
					if vRP.getHealth(otherPlayer) > 101 and not vCLIENT.getHandcuff(otherPlayer) then
						local identity = vRP.userIdentity(user_id)
						local request = vRP.request(otherPlayer,"Aceitar o pedido de <b>"..identity["name"].." "..identity["name2"].."</b> da animação <b>"..args[1].."</b>?",30)
						if request then
							TriggerClientEvent("emotes",otherPlayer,args[1])
							TriggerClientEvent("emotes",source,args[1])
						end
					end
				end
			else
				TriggerClientEvent("emotes",source,args[1])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMOTES2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("e2",function(source,args,rawCommand)
	if exports["chat"]:statusChat(source) then
		local user_id = vRP.getUserId(source)
		if user_id and vRP.getHealth(source) > 101 then
			local otherPlayer = vRPC.nearestPlayer(source,3)
			if otherPlayer then
				if vRP.hasPermission(user_id,"Paramedic") then
					TriggerClientEvent("emotes",otherPlayer,args[1])
				end
			end
		end
	end
end)