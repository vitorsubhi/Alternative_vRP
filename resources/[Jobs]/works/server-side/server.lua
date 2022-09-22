
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEWORKS
-----------------------------------------------------------------------------------------------------------------------------------------
local activeWorks = {
	["Ballas"] = {},
	["Vagos"] = {},
	["DaNang"] = {},
	["Families"] = {},
	["Aztecas"] = {}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collectAmount = {}
local paymentAmount = {}
local deliveryAmount = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.collectConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["collectRandom"] then
			local amountItem = 0
			local selectItem = ""

			if serviceName == "Minerador" then
				local randomItem = math.random(100)

				if randomItem <= 1 then
					amountItem = 1
					selectItem = "emerald"
				elseif randomItem >= 2 and randomItem <= 3 then
					selectItem = "diamond"
					amountItem = math.random(2)
				elseif randomItem >= 4 and randomItem <= 8 then
					selectItem = "ruby"
					amountItem = math.random(2)
				elseif randomItem >= 9 and randomItem <= 16 then
					selectItem = "sapphire"
					amountItem = math.random(3)
				elseif randomItem >= 17 and randomItem <= 27 then
					selectItem = "amethyst"
					amountItem = math.random(3)
				elseif randomItem >= 28 and randomItem <= 44 then
					selectItem = "amber"
					amountItem = math.random(3)
				elseif randomItem >= 45 and randomItem <= 60 then
					selectItem = "turquoise"
					amountItem = math.random(3)
				elseif randomItem >= 61 and randomItem <= 79 then
					selectItem = "aluminum"
					amountItem = math.random(2)
				elseif randomItem >= 80 then
					selectItem = "copper"
					amountItem = math.random(2)
				end
			else
				local randomItem = math.random(#works[serviceName]["deliveryItem"])
				selectItem = works[serviceName]["deliveryItem"][randomItem]
				amountItem = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(selectItem) * parseInt(amountItem))) <= vRP.getBackpack(user_id) then
				vRP.generateItem(user_id,selectItem,amountItem,true)

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		else
			if collectAmount[user_id] == nil then
				collectAmount[user_id] = math.random(works[serviceName]["collectConsume"]["min"],works[serviceName]["collectConsume"]["max"])
			end

			local deliveryItem = works[serviceName]["deliveryItem"]
			if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(collectAmount[user_id]))) <= vRP.getBackpack(user_id) then
				vRP.generateItem(user_id,deliveryItem,collectAmount[user_id],true)
				collectAmount[user_id] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERYCONSUME
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.deliveryConsume(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if deliveryAmount[user_id] == nil then
			deliveryAmount[user_id] = math.random(works[serviceName]["deliveryConsume"]["min"],works[serviceName]["deliveryConsume"]["max"])
		end

		if paymentAmount[user_id] == nil then
			paymentAmount[user_id] = math.random(works[serviceName]["deliveryPayment"]["min"],works[serviceName]["deliveryPayment"]["max"])
		end

		local deliveryItem = works[serviceName]["deliveryPayment"]["item"]
		if (vRP.inventoryWeight(user_id) + (itemWeight(deliveryItem) * parseInt(paymentAmount[user_id]))) <= vRP.getBackpack(user_id) then
			if vRP.tryGetInventoryItem(user_id,works[serviceName]["deliveryItem"],deliveryAmount[user_id]) then
				local paymentPrice = parseInt(paymentAmount[user_id] * deliveryAmount[user_id])

				vRP.generateItem(user_id,deliveryItem,paymentPrice,true)

				if deliveryItem == "dollars" or deliveryItem == "dollarsz" then
					if vRP.userPremium(user_id) then
						vRP.generateItem(user_id,deliveryItem,paymentPrice * 0.1,true)
					end
				end

				deliveryAmount[user_id] = nil
				paymentAmount[user_id] = nil

				if works[serviceName]["upgradeStress"] > 0 then
					vRP.upgradeStress(user_id,works[serviceName]["upgradeStress"])
				end

				if serviceName == "Contrabandista" then
					TriggerClientEvent("player:applyGsr",source)

					if math.random(1000) >= 500 then
						local ped = GetPlayerPed(source)
						local coords = GetEntityCoords(ped)

						local policeResult = vRP.numPermission("Police")
						for k,v in pairs(policeResult) do
							async(function()
								TriggerClientEvent("NotifyPush",v,{ code = "QRU", title = "Contrabando de Munições", x = coords["x"], y = coords["y"], z = coords["z"], time = "Recebido às "..os.date("%H:%M"), blipColor = 5 })
							end)
						end
					end
				end

				return true
			else
				TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>"..parseFormat(deliveryAmount[user_id]).."x "..itemName(works[serviceName]["deliveryItem"]).."</b> para entregar.",5000)
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.checkPermission(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if works[serviceName]["perm"] == nil then
			return true
		end

		if vRP.hasGroup(user_id,works[serviceName]["perm"]) then
			if activeWorks[serviceName] then
				if parseInt(#activeWorks[serviceName]) < 5 then
					activeWorks[serviceName][user_id] = true
					return true
				else
					TriggerClientEvent("Notify",source,"amarelo","Limite de trabalhadores atingido.",3000)
				end
			else
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.finishService(serviceName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and activeWorks[serviceName] then
		if activeWorks[serviceName][user_id] then
			activeWorks[serviceName][user_id] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS:BULLGUERJUICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("works:bullguerJuice")
AddEventHandler("works:bullguerJuice",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.checkMaxItens(user_id,"bullguerjuice",1) then
			TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			return
		end

		vRP.generateItem(user_id,"bullguerjuice",1,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS:BULLGUERFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("works:bullguerFood")
AddEventHandler("works:bullguerFood",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.checkMaxItens(user_id,"bullguerfood",1) then
			TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			return
		end

		vRP.generateItem(user_id,"bullguerfood",1,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS:BULLGUERBOX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("works:bullguerBox")
AddEventHandler("works:bullguerBox",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.checkMaxItens(user_id,"bullguerbox",1) then
			TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			return
		end

		local consultFood = vRP.getInventoryItemAmount(user_id,"bullguerfood")
		if consultFood[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("bullguerfood").."</b>.",5000)
			return
		end

		local consultJuice = vRP.getInventoryItemAmount(user_id,"bullguerjuice")
		if consultJuice[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName("bullguerjuice").."</b>.",5000)
			return
		end

		vRP.removeInventoryItem(user_id,"bullguerjuice",1,false)
		vRP.removeInventoryItem(user_id,"bullguerfood",1,false)
		vRP.generateItem(user_id,"bullguerbox",1,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.paymentService()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = math.random(225,300)
		vRP.generateItem(user_id,"dollars",value,true)

		if vRP.userPremium(user_id) then
			vRP.generateItem(user_id,"dollars",value * 0.1,true)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.initService(status)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if status then
			vRP.insertPermission(source,"Taxi")
		else
			vRP.removePermission(source,"Taxi")
		end
	end

	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSWITCHBLADE
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.checkSwitchblade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.inventoryWeight(user_id) + (itemWeight("meatA") * 3)) > vRP.getBackpack(user_id) then
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
			return false
		end

		local consultItem = vRP.getInventoryItemAmount(user_id,"switchblade")
		if consultItem[1] >= 1 then
			if vRP.checkBroken(consultItem[2]) then
				TriggerClientEvent("Notify",source,"vermelho","Item quebrado.",5000)
				return false
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMALPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.animalPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local reputationValue = vRP.checkReputation(user_id,"hunting")
		if reputationValue <= 500 then
			local randomItens = math.random(100)

			if randomItens <= 70 then
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatA",math.random(3),true)
				else
					vRP.generateItem(user_id,"meatA",math.random(2),true)
					vRP.generateItem(user_id,"meatB",1,true)
				end
			elseif randomItens >= 71 and randomItens <= 90 then
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatA",math.random(2),true)
					vRP.generateItem(user_id,"meatB",1,true)
				else
					vRP.generateItem(user_id,"meatA",1,true)
					vRP.generateItem(user_id,"meatB",math.random(2),true)
				end
			else
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatB",math.random(2),true)
					vRP.generateItem(user_id,"meatC",1,true)
				else
					vRP.generateItem(user_id,"meatB",1,true)
					vRP.generateItem(user_id,"meatC",math.random(2),true)
				end
			end
		elseif reputationValue >= 501 and reputationValue <= 1000 then
			local randomItens = math.random(100)

			if randomItens <= 70 then
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatA",math.random(3),true)

					if math.random(100) <= 50 then
						vRP.generateItem(user_id,"meatB",1,true)
					end
				else
					vRP.generateItem(user_id,"meatA",math.random(2),true)
					vRP.generateItem(user_id,"meatB",1,true)

					if math.random(100) <= 50 then
						vRP.generateItem(user_id,"meatC",1,true)
					end
				end
			elseif randomItens >= 71 and randomItens <= 90 then
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatA",math.random(2),true)
					vRP.generateItem(user_id,"meatB",1,true)

					if math.random(100) <= 50 then
						vRP.generateItem(user_id,"meatC",1,true)
					end
				else
					vRP.generateItem(user_id,"meatA",1,true)
					vRP.generateItem(user_id,"meatB",math.random(2),true)

					if math.random(100) <= 50 then
						vRP.generateItem(user_id,"meatS",1,true)
					end
				end
			else
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatB",math.random(2),true)
					vRP.generateItem(user_id,"meatC",1,true)
				else
					vRP.generateItem(user_id,"meatB",1,true)
					vRP.generateItem(user_id,"meatC",math.random(2),true)
				end

				if math.random(100) <= 50 then
					vRP.generateItem(user_id,"meatS",1,true)
				end
			end
		else
			local randomItens = math.random(100)

			if randomItens <= 70 then
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatB",math.random(3),true)

					if math.random(100) <= 50 then
						vRP.generateItem(user_id,"meatC",1,true)
					end
				else
					vRP.generateItem(user_id,"meatB",math.random(2),true)
					vRP.generateItem(user_id,"meatC",1,true)

					if math.random(100) <= 50 then
						vRP.generateItem(user_id,"meatS",1,true)
					end
				end
			elseif randomItens >= 71 and randomItens <= 90 then
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatB",math.random(2),true)
					vRP.generateItem(user_id,"meatC",1,true)
				else
					vRP.generateItem(user_id,"meatB",1,true)
					vRP.generateItem(user_id,"meatC",math.random(2),true)
				end

				if math.random(100) <= 50 then
					vRP.generateItem(user_id,"meatS",1,true)
				end
			else
				if math.random(100) <= 75 then
					vRP.generateItem(user_id,"meatC",math.random(2),true)
					vRP.generateItem(user_id,"meatS",1,true)
				else
					vRP.generateItem(user_id,"meatC",1,true)
					vRP.generateItem(user_id,"meatS",math.random(2),true)
				end
			end
		end

		if math.random(1000) <= 10 then
			if (vRP.inventoryWeight(user_id) + itemWeight("horndeer")) <= vRP.getBackpack(user_id) then
				vRP.generateItem(user_id,"horndeer",1,true)
			end
		end

		if (vRP.inventoryWeight(user_id) + itemWeight("animalpelt")) <= vRP.getBackpack(user_id) then
			vRP.generateItem(user_id,"animalpelt",1,true)
		end

		vRP.insertReputation(user_id,"hunting",1)
		vRP.upgradeStress(user_id,4)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local stockadeNet = 0
local stockadeTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.checkStockade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if parseInt(#policeResult) <= 0 or GetGameTimer() < stockadeTimer then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			return false
		end

		local consultItem = vRP.getInventoryItemAmount(user_id,"card05")
		if consultItem[1] <= 0 then
			return false
		end

		if vRP.checkBroken(consultItem[2]) then
			TriggerClientEvent("Notify",source,"vermelho","Item quebrado.",5000)
			return false
		end

		if vRP.tryGetInventoryItem(user_id,consultItem[2],1,true,false) then
			stockadeTimer = GetGameTimer() + (120 * 60000)
			TriggerClientEvent("player:applyGsr",source)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADEINSERT
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.stockadeInsert(vehNet)
	stockadeNet = parseInt(vehNet)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("stockade:explodeVehicle")
AddEventHandler("stockade:explodeVehicle",function()
	stockadeNet = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOCKADENET
-----------------------------------------------------------------------------------------------------------------------------------------
function stockadeNet()
	return stockadeNet
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("stockadeNet",stockadeNet)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local boxTimers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.applyTimers(boxId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if boxTimers[boxId] then
			if GetGameTimer() < boxTimers[boxId] then
				TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
				return false
			else
				local consultItem = vRP.getInventoryItemAmount(user_id,"pliers")
				if consultItem[1] <= 0 then
					TriggerClientEvent("Notify",source,"amarelo","Necessário possuir um <b>Alicate</b>.",5000)
					return false
				end

				startBox(boxId,source)
				return true
			end
		else
			startBox(boxId,source)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTBOX
-----------------------------------------------------------------------------------------------------------------------------------------
function startBox(boxId,source)
	boxTimers[boxId] = GetGameTimer() + (20 * 60000)

	if math.random(100) >= 75 then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		TriggerClientEvent("player:applyGsr",source)

		local policeResult = vRP.numPermission("Police")
		for k,v in pairs(policeResult) do
			async(function()
				vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
				TriggerClientEvent("NotifyPush",v,{ code = "QRU", title = "Caixa Registradora", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.paymentMethod()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.wantedTimer(user_id,60)
		vRP.generateItem(user_id,"dollarsz",math.random(120,150),true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local atmTimers = 0-- GetGameTimer() + (math.random(20,30) * 60000)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSYSTEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.checkSystems()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if --[[parseInt(#policeResult) <= 2 or]] GetGameTimer() < atmTimers then
			TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			return false
		else
			local consultItem = vRP.getInventoryItemAmount(user_id,"floppy")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify",source,"amarelo","Necessário possuir um <b>Disquete</b>.",5000)
				return false
			end

			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			atmTimers = GetGameTimer() + (math.random(20,30) * 60000)
			TriggerClientEvent("player:applyGsr",source)

			for k,v in pairs(policeResult) do
				async(function()
					vRPC.playSound(v,"ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET")
					TriggerClientEvent("NotifyPush",v,{ code = "QRU", title = "Caixa Eletrônico", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
				end)
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTSYSTEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.paymentSystems()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if GetGameTimer() < atmTimers then
			vRP.wantedTimer(user_id,20)
			vRP.generateItem(user_id,"dollarsz",math.random(100,150))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.checkRobbery(robberyId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robberys[robberyId] then
			local prev = robberys[robberyId]

			if GetGameTimer() >= robberyAvailable[prev["type"]] then
				local policeResult = vRP.numPermission("Police")
				if parseInt(#policeResult) > parseInt(prev["cops"]) then
					local consultItem = vRP.getInventoryItemAmount(user_id,prev["item"])
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify",source,"amarelo","Precisa de <b>1x "..itemName(prev["item"]).."</b> para roubar.",5000)
						return false
					end

					if vRP.checkBroken(consultItem[2]) then
						return false
					end

					if vRP.tryGetInventoryItem(user_id,consultItem[2],1) then
						TriggerClientEvent("player:applyGsr",source)
						robberyAvailable[prev["type"]] = GetGameTimer() + (prev["cooldown"] * 60000)

						for k,v in pairs(policeResult) do
							async(function()
								TriggerClientEvent("NotifyPush",v,{ code = "QRU", title = prev["name"], x = prev["coords"][1], y = prev["coords"][2], z = prev["coords"][3], time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
								vRPC.playSound(v,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
							end)
						end

						return true
					end
				end
			else
				TriggerClientEvent("Notify",source,"amarelo","Sistema indisponível no momento.",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.paymentRobbery(robberyId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.wantedTimer(user_id,900)

		for k,v in pairs(robberys[robberyId]["payment"]) do
			local value = math.random(v[2],v[3])
			vRP.generateItem(user_id,v[1],parseInt(value),true)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	vCLIENT.updateWorks(source,works)
	vCLIENT.inputRobberys(source,robberys)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == "works" then
		Wait(10000)
		vCLIENT.updateWorks(-1,works)
	    vCLIENT.inputRobberys(-1,robberys)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if activeWorks["Ballas"][user_id] then
		activeWorks["Ballas"][user_id] = nil
	end

	if activeWorks["Vagos"][user_id] then
		activeWorks["Vagos"][user_id] = nil
	end

	if activeWorks["DaNang"][user_id] then
		activeWorks["DaNang"][user_id] = nil
	end

	if activeWorks["Families"][user_id] then
		activeWorks["Families"][user_id] = nil
	end

	if activeWorks["Aztecas"][user_id] then
		activeWorks["Aztecas"][user_id] = nil
	end
end)