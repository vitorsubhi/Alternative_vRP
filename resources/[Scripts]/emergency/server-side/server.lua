-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("emergency",cRP)
vCLIENT = Tunnel.getInterface("emergency")
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["mp_m_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 133, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 15, texture = 0 },
		["torso"] = { item = 362, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 83, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	},
	["mp_f_freemode_01"] = {
		["hat"] = { item = -1, texture = 0 },
		["pants"] = { item = 140, texture = 0 },
		["vest"] = { item = 0, texture = 0 },
		["bracelet"] = { item = -1, texture = 0 },
		["decals"] = { item = 0, texture = 0 },
		["mask"] = { item = 0, texture = 0 },
		["shoes"] = { item = 25, texture = 0 },
		["tshirt"] = { item = 14, texture = 0 },
		["torso"] = { item = 381, texture = 0 },
		["accessory"] = { item = 0, texture = 0 },
		["watch"] = { item = -1, texture = 0 },
		["arms"] = { item = 86, texture = 0 },
		["glass"] = { item = 0, texture = 0 },
		["ear"] = { item = -1, texture = 0 }
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:PRISONCLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:prisonClothes")
AddEventHandler("police:prisonClothes",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasPermission(user_id,"Police") then
			local mHash = vRP.modelPlayer(entity[1])
			if mHash == "mp_m_freemode_01" or mHash == "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity[1],preset[mHash])
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initPrison(nuser_id,services,fines,text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true

			local identity = vRP.userIdentity(user_id)
			local otherPlayer = vRP.userSource(nuser_id)
			if otherPlayer then
				vCLIENT.syncPrison(otherPlayer,true,false)
				TriggerClientEvent("radio:outServers",otherPlayer)
			end

			vRP.execute("prison/insertPrison",{ police = identity["name"].." "..identity["name2"], nuser_id = parseInt(nuser_id), services = services, fines = fines, text = text, date = os.date("%d/%m/%Y").." ás "..os.date("%H:%M") })
			vRP.execute("characters/setPrison",{ user_id = parseInt(nuser_id), prison = parseInt(services) })
			vRPC.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
			
            TriggerClientEvent("xst:cutscene", otherPlayer)
			TriggerClientEvent("Notify",source,"verde","Prisão efetuada.",5000)
			TriggerClientEvent("police:Update",source,"reloadPrison")

			if fines > 0 then
				vRP.addFines(nuser_id,fines)
			end

			TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Serviços:** "..parseFormat(services).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,13541152)

			actived[user_id] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCHUSER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.searchUser(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.userIdentity(nuser_id)
		if identity then
			local fines = vRP.getFines(nuser_id)
			local records = vRP.query("prison/getRecords",{ nuser_id = parseInt(nuser_id) })

			return { true,identity["name"].." "..identity["name2"],identity["phone"],fines,records,identity["port"],identity["serial"],identity["penal"] }
		end
	end

	return { false }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INITFINE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.initFine(nuser_id,fines,text)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and fines > 0 then
		if actived[user_id] == nil then
			actived[user_id] = true

			TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Multa:** $"..parseFormat(fines).."\n**Horário:** "..os.date("%H:%M:%S").."\n**Motivo:** "..text,2316674)
			TriggerClientEvent("Notify",source,"verde","Multa aplicada.",5000)
			TriggerClientEvent("police:Update",source,"reloadFine")
			vRP.addFines(nuser_id,fines)

			actived[user_id] = nil
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePort(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local portStatus = ""
		local identity = vRP.userIdentity(user_id)
		local nidentity = vRP.userIdentity(nuser_id)

		if nidentity["port"] == 0 then
			portStatus = "Ativado"
			vRP.execute("characters/updatePort",{ port = 1, id = parseInt(nuser_id) })
		else
			portStatus = "Desativado"
			vRP.execute("characters/updatePort",{ port = 0, id = parseInt(nuser_id) })
		end

		TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(nuser_id))
		TriggerEvent("discordLogs","Police","**Por:** "..parseFormat(user_id).."\n**Passaporte:** "..parseFormat(nuser_id).."\n**Porte:** "..portStatus.."\n**Horário:** "..os.date("%H:%M:%S"),6303352)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPENAL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updatePenal(nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"servicePolice") then
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				if identity["penal"] == 0 then
					vRP.execute("characters/updatePenal",{ penal = 1, id = parseInt(nuser_id) })
				else
					vRP.execute("characters/updatePenal",{ penal = 0, id = parseInt(nuser_id) })
				end

				TriggerClientEvent("police:Update",source,"reloadSearch",parseInt(nuser_id))
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISONSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(prisonMarkers) do
			if prisonMarkers[k][1] > 0 then
				prisonMarkers[k][1] = prisonMarkers[k][1] - 1

				if prisonMarkers[k][1] <= 0 then
					if vRP.userSource(prisonMarkers[k][2]) then
						TriggerEvent("blipsystem:serviceExit",k)
					end

					prisonMarkers[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.resetPrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vCLIENT.syncPrison(source,false,true)
		prisonMarkers[source] = { 600,parseInt(user_id) }
		vRP.execute("characters/fixPrison",{ user_id = parseInt(user_id) })

		local policeResult = vRP.numPermission("Police")
		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("Notify",v,"amarelo","Recebemos a informação de um fugitivo da penitenciária.",5000)
			end)
		end

		TriggerEvent("blipsystem:serviceEnter",source,"Prisioneiro",48)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reducePrison()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.execute("characters/removePrison",{ user_id = parseInt(user_id), prison = 5 })

		local consult = vRP.getInformation(user_id)
		if parseInt(consult[1]["prison"]) <= 0 then
			vCLIENT.syncPrison(source,false,true)
			vRP.execute("characters/fixPrison",{ user_id = parseInt(user_id) })
			TriggerClientEvent("Notify",source,"verde","Serviço acabou, esperamos não vê-lo novamente.",5000)
		else
			vCLIENT.asyncServices(source)
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(consult[1]["prison"]).." serviços</b>.",5000)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKKEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkKey()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if parseInt(#policeResult) <= 5 then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			return false
		end

		local consultItem = vRP.getInventoryItemAmount(user_id,"key")
		if consultItem[1] > 0 then
			if not vRP.checkBroken(consultItem[2]) then
				if vRP.tryGetInventoryItem(user_id,consultItem[2],1,true) then
					local taskResult = vTASKBAR.taskDoors(source)
					if taskResult then
						return true
					end
				end
			end
		end

		return false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEKEY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.giveKey()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.generateItem(user_id,"key",1,true)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:STARTTREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:tratamento")
AddEventHandler("paramedic:tratamento",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 and vRP.getHealth(entity) > 101 then
		if vRP.hasPermission(user_id,"Paramedic") then
			vRPC.startTreatment(entity)
			TriggerClientEvent("Notify",source,"amarelo","Tratamento começou.",5000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:maca")
AddEventHandler("paramedic:maca",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasPermission(user_id,"Paramedic") then
			TriggerClientEvent("target:pacienteDeitar",entity)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:REANIMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:reanimar")
AddEventHandler("paramedic:reanimar",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 and vRP.getHealth(entity) <= 101 then
		if vRP.hasPermission(user_id,"Paramedic") then
			local nuser_id = vRP.getUserId(entity)

			TriggerClientEvent("Progress",source,10000)
			TriggerClientEvent("vrp:Cancel",source,true)
			vRPC.playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)

			SetTimeout(10000,function()
				vRPC.removeObjects(source)
				vRP.upgradeThirst(nuser_id,10)
				vRP.upgradeHunger(nuser_id,10)
				vRPC.revivePlayer(entity,110)
				TriggerClientEvent("resetBleeding",entity)
				TriggerClientEvent("vrp:Cancel",source,false)
			end)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:SANGRAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:sangramento")
AddEventHandler("paramedic:sangramento",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 and vRP.getHealth(entity) > 101 then
		if vRP.hasPermission(user_id,"Paramedic") then
			TriggerClientEvent("resetBleeding",entity)
			TriggerClientEvent("Notify",source,"blood","Sangramento parou.",5000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:DIAGNOSTICO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:diagnostico")
AddEventHandler("paramedic:diagnostico",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasPermission(user_id,"Paramedic") then
			local hurt = false
			local diagnostic,bleeding = vCLIENT.getDiagnostic(entity)
			if diagnostic then
				if next(diagnostic) then
					hurt = true
					TriggerClientEvent("drawInjuries",source,entity,diagnostic)
				end
			end

			local text = ""
			if bleeding == 3 then
				text = "- <b>Sangramento Baixo</b><br>"
			elseif bleeding == 4 then
				text = "- <b>Sangramento Médio</b><br>"
			elseif bleeding >= 5 then
				text = "- <b>Sangramento Alto</b><br>"
			end

			if diagnostic["taser"] then
				text = text .. "- <b>Eletrocutado</b><br>"
			end

			if diagnostic["vehicle"] then
				text = text .. "- <b>Acidente com veículo</b><br>"
			end

			if text ~= "" then
				TriggerClientEvent("Notify",source,"amarelo","Status do paciente:<br>" .. text,5000)
			elseif not hurt then
				TriggerClientEvent("Notify",source,"verde","Status do paciente:<br>- <b>Nada encontrado</b>",5000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 56, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 16, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 15, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 15, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 57, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 16, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 15, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 15, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 84, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 122, texture = 0 },
			["shoes"] = { item = 47, texture = 3 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 186, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 110, texture = 3 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 86, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["decals"] = { item = 90, texture = 0 },
			["mask"] = { item = 122, texture = 0 },
			["shoes"] = { item = 48, texture = 3 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 188, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 127, texture = 3 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	}
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETBURN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:presetBurn")
AddEventHandler("paramedic:presetBurn",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Emergency") then
			local model = vRP.modelPlayer(entity)

			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity,preset["1"][model])
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETPLASTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:presetPlaster")
AddEventHandler("paramedic:presetPlaster",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Emergency") then
			local model = vRP.modelPlayer(entity)

			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerClientEvent("updateRoupas",entity,preset["2"][model])
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			vRP.upgradeHunger(user_id,20)
			vRP.upgradeThirst(user_id,20)
			vRP.reposeTimer(user_id,1)
			return true
		end

		local amountValue = 500
		local amountPerms = vRP.numPermission("Paramedic")

		if vRP.getHealth(source) <= 101 then
			amountValue = amountValue + 500
		end

		if parseInt(#amountPerms) >= 1 then
			amountValue = amountValue + 500

			if vRP.request(source,"Paramédicos em serviço, prosseguir o tratamento por <b>$"..parseFormat(amountValue).."</b> dólares?",30) then
				if vRP.paymentFull(user_id,amountValue) then
					vRP.upgradeHunger(user_id,20)
					vRP.upgradeThirst(user_id,20)
					vRP.reposeTimer(user_id,15)
					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
				end
			end
		else
			if vRP.request(source,"Prosseguir o tratamento por <b>$"..parseFormat(amountValue).."</b> dólares?",30) then
				if vRP.paymentFull(user_id,amountValue) then
					vRP.upgradeHunger(user_id,20)
					vRP.upgradeThirst(user_id,20)
					vRP.reposeTimer(user_id,3)
					return true
				else
					TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
				end
			end
		end
	end

	return false
end

--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local consult = vRP.getInformation(user_id)
	if consult[1] then
		if parseInt(consult[1]["prison"]) <= 0 then
			return
		else
			TriggerClientEvent("Notify",source,"azul","Restam <b>"..parseInt(consult[1]["prison"]).." serviços</b>.",5000)
			vCLIENT.syncPrison(source,true,true)
		end
	end
end)