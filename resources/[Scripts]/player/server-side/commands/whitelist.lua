-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Whitelist") then
            vRP.execute("accounts/infosWhitelist",{ steam = tostring(args[1]), whitelist = 1 })
			TriggerClientEvent("Notify",source,"amarelo","Você liberou a whitelist de: <b>"..args[1].."</b>",10000)
            vRP.Log("```prolog\n[ID]: "..user_id.."\n[LIBEROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "whitelist")
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"Whitelist") then
			vRP.kick(args[1],"Você perdeu a sua Whitelist na Cidade.")
            vRP.execute("accounts/infosWhitelist",{ steam = tostring(args[1]), whitelist = 0 })
			TriggerClientEvent("Notify",source,"amarelo","Você retirou a whitelist de: <b>"..args[1].."</b>",10000)
            vRP.Log("```prolog\n[ID]: "..user_id.."\n[BLOQUEOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```", "whitelist")
        end
    end
end)
