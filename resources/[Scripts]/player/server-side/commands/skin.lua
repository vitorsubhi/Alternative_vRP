-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			TriggerClientEvent("skinmenu",nplayer,args[2])
			TriggerClientEvent("Notify",source,"amarelo","Setada a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
		end
    end
end)
