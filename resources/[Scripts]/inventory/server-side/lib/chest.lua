-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestName == "Bullguer" then
			return true
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if (vRP.hasPermission(user_id,consultChest[1]["perm"]) and not vRP.wantedReturn(user_id)) or vRP.hasPermission(user_id,"Police") then
				return true
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.takeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if vRP.tryChest(user_id,"stackChest:"..chestName,amount,slot,target) then
				TriggerClientEvent("inventory:update",source,"updateMochila")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getBackpack(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if parseInt(consultChest[1]["logs"]) >= 1 then
					TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Retirou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),9317187)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
					v["serial"] = splitName[3]
				elseif splitName[1] == "vehkey" then
					v["serial"] = splitName[2]
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myInventory[k] = v
		end

		local myChest = {}
		local result = vRP.getSrvdata("stackChest:"..chestName)
		for k,v in pairs(result) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["max"] = itemMaxAmount(v["item"])
			v["type"] = itemType(v["item"])
			v["desc"] = itemDescription(v["item"])
			v["economy"] = itemEconomy(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				v["durability"] = parseInt(os.time() - splitName[2])
				v["days"] = itemDurability(v["item"])
				v["serial"] = splitName[3]
			else
				v["durability"] = 0
				v["days"] = 1
			end

			myChest[k] = v
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			return myInventory,myChest,vRP.inventoryWeight(user_id),vRP.getBackpack(user_id),vRP.chestWeight(result),consultChest[1]["weight"]
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.storeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			if vRP.storeChest(user_id,"stackChest:"..chestName,amount,consultChest[1]["weight"],slot,target) then
				TriggerClientEvent("inventory:update",source,"updateMochila")
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				TriggerClientEvent("chest:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getBackpack(user_id),vRP.chestWeight(result),consultChest[1]["weight"])

				if parseInt(consultChest[1]["logs"]) >= 1 then
					TriggerEvent("discordLogs",chestName,"**Passaporte:** "..parseFormat(user_id).."\n**Guardou:** "..parseFormat(amount).."x "..itemName(nameItem).."\n**Horário:** "..os.date("%H:%M:%S"),3042892)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.upgradeSystem(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			local upgradePrice = 30000 

			if vRP.hasPermission(user_id,consultChest[1]["perm"]) then
				if vRP.request(source,"Comprar <b>25Kg</b> pagando <b>$"..parseFormat(upgradePrice).."</b>?",30) then
					if vRP.paymentFull(user_id,upgradePrice) then
						vRP.execute("chests/upgradeChests",{ name = chestName })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					else
						TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente.",5000)
					end
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function aRP.updateChest(slot,target,amount,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.updateChest(user_id,"stackChest:"..chestName,slot,target,amount) then
			TriggerClientEvent("inventory:update",source,"updateMochila")
		end
	end
end

AddEventHandler('onResourceStart', function(resource)
	if resource == "inventory" then
		Wait(10000)
			TriggerClientEvent("inventory:update",-1,"updateMochila")
    end
end)