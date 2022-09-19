-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"Admin") and args[1] and args[2] then
		    local work = false
		    if args[3] then
		        work = true
		    end
			local nidentity = vRP.getUserIdentity(args[1])
			vRP.execute("vehicles/addVehicles",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlate(), work = tostring(work) })
			TriggerClientEvent("Notify",args[1],"amarelo","Recebido o veículo <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"amarelo","Adicionado o veiculo <b>"..args[2].."</b> na garagem de ID <b>"..args[1].."</b>.",10000)
			vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[ADICIONOU]: "..args[2].."\n[PARA]:"..parseInt(args[1]).." "..nidentity.name.." "..nidentity.name2.." "..os.date("\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S").." \r```", "addcar_remcar")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTEMPCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addtempcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"Owner") and args[1] and args[2] and args[3] then
			local nidentity = vRP.getUserIdentity(args[1])
			vRP.execute("vehicles/rentalVehicles",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlate(), work = tostring(false), rental = parseInt(os.time()), rendays = args[3] })
            TriggerClientEvent("Notify",args[1],"amarelo","Recebido o veículo <b>"..args[2].."</b> por <b>"..args[3].." dias</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"amarelo","Adicionado o veiculo <b>"..args[2].."</b> por <b>"..args[3].." dias</b> na garagem de ID <b>"..args[1].."</b>.",10000)
			vRP.Log("```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2.." \n[ADICIONOU TEMPORARIO]: "..args[2].."\n[PARA]:"..parseInt(args[1]).." "..nidentity.name.." "..nidentity.name2.."\n[DIAS]:"..parseInt(args[3]).." "..os.date("\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S").." \r```", "addcar_remcar")
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Suporte") then
			TriggerClientEvent("admin:vehicleTuning",source)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Moderador") then
			local vehicle,vehNet,vehPlate = vRPC.vehList(source,10)
			if vehicle then
				TriggerClientEvent("inventory:repairAdmin",-1,vehNet,vehPlate)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local vehicle = vRPC.vehicleHash(source)
			if vehicle then
				print(vehicle)
			end
		end
	end
end)
