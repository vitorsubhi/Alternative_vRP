-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
vRPC = Tunnel.getInterface("vRP")

local version = module("version")
PerformHttpRequest("https://raw.githubusercontent.com/vitorsubhi/Alternative_vRP/master/resources/%5BEssentials%5D/vrp/version.lua",function(err,text,headers)
	if err == 200 then
		text = string.gsub(text,"return ","")
		local r_version = tonumber(text)
		if version ~= r_version then
			print("\n^5[Alternative]: ^1Uma atualização da Alternative vRP foi detectada em:\n^2https://github.com/vitorsubhi/Alternative_vRP")
			print("^4[Última versão]: ".. r_version)
			print("^3[Versão atual]: ".. version.."^7")
		else 
			print("^5[Alternative]: ^7Você está utilizando a versão mais recente da base Alternative.^7")
		end
	else
		print("^5[Alternative]: ^1Não foi possível verificar versão remota.^7")
	end
	end, "GET", "")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
vRP.userIds = {}
vRP.userInfos = {}
vRP.userTables = {}
vRP.userSources = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYSQL
-----------------------------------------------------------------------------------------------------------------------------------------
local mysqlDriver
local userSql = {}
local mysqlInit = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
local cacheQuery = {}
local cachePrepare = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETIDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getIdentities(source)
	local result = false

	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end

	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERDBDRIVER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.registerDBDriver(name,onInit,onPrepare,onQuery)
	if not userSql[name] then
		userSql[name] = { onInit,onPrepare,onQuery }
		mysqlDriver = userSql[name]
		mysqlInit = true

		for _,prepare in pairs(cachePrepare) do
			onPrepare(table.unpack(prepare,1,table.maxn(prepare)))
		end

		for _,query in pairs(cacheQuery) do
			query[2](onQuery(table.unpack(query[1],1,table.maxn(query[1]))))
		end

		cachePrepare = {}
		cacheQuery = {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETXT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateTxt(archive,text)
	archive = io.open("resources/logsystem/"..archive,"a")
	if archive then
		archive:write(text.."\n")
	end

	archive:close()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.prepare(name,query)
	if mysqlInit then
		mysqlDriver[2](name,query)
	else
		table.insert(cachePrepare,{ name,query })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.query(name,params,mode)
	if not mode then mode = "query" end

	if mysqlInit then
		return mysqlDriver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cacheQuery,{{ name,params or {},mode },r })
		return r:wait()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXECUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.execute(name,params)
	return vRP.query(name,params,"execute")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkBanned(steam)
	local consult = vRP.query("banneds/getBanned",{ steam = steam })
	if consult[1] then
		if consult[1]["time"] >= os.time() then
			vRP.execute("banneds/removeBanned",{ steam = steam })
			return false
		end

		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWHITELIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkWhitelist(steam)
	local infoAccount = vRP.infoAccount(steam)
	if infoAccount then
		return infoAccount["whitelist"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.infoAccount(steam)
	local infoAccount = vRP.query("accounts/getInfos",{ steam = steam })
	return infoAccount[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userData(user_id,key)
	local consult = vRP.query("playerdata/getUserdata",{ user_id = parseInt(user_id), key = key })
	if consult[1] then
		return json.decode(consult[1]["dvalue"])
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setUData(user_id,key,value)
	vRP.execute("playerdata/setUserdata",{ user_id = parseInt(user_id), key = key, value = value })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUData(user_id,key)
	local rows = vRP.query("playerdata/getUserdata",{ user_id = parseInt(user_id), key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setSData(key,value)
	vRP.execute("entitydata/setData",{ key = key, value = value })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getSData(key)
	local rows = vRP.query("entitydata/getData",{ key = key })
	if #rows > 0 then
		return rows[1].dvalue
	else
		return ""
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMEPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateHomePosition(user_id,x,y,z)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		dataTable["position"] = { x = mathLegth(x), y = mathLegth(y), z = mathLegth(z) }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userInventory(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end

		return dataTable["inventory"]
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESELECTSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateSelectSkin(user_id,hash)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		dataTable["skin"] = hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserId(source)
	return vRP.userIds[parseInt(source)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userList()
	return vRP.userSources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.userPlayers()
	return vRP.userIds
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userSource(user_id)
	return vRP.userSources[parseInt(user_id)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getDatatable(user_id)
	return vRP.userTables[parseInt(user_id)] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function(reason)
	playerDropped(source,reason)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.kick(user_id,reason)
	local userSource = vRP.userSource(user_id)
	if userSource then
		playerDropped(userSource,"Kick/Afk")
		DropPlayer(userSource,reason)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
function playerDropped(source,reason)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Disconnect","```prolog\n[ID]: "..parseFormat(user_id).."\n[IP]: "..GetPlayerEndpoint(source).."\n[SAIU DO SERVIDOR]: "..reason..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```",3092790)

		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			TriggerEvent("vRP:playerLeave",user_id,source)
			vRP.execute("playerdata/setUserdata",{ user_id = parseInt(user_id), key = "Datatable", value = json.encode(dataTable) })
			vRP.userSources[parseInt(user_id)] = nil
			vRP.userTables[parseInt(user_id)] = nil
			vRP.userIds[parseInt(source)] = nil
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEINFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.userUpdate(pArmour,pHealth,pCoords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			dataTable["armour"] = parseInt(pArmour)
			dataTable["health"] = parseInt(pHealth)
			dataTable["position"] = { x = mathLegth(pCoords["x"]), y = mathLegth(pCoords["y"]), z = mathLegth(pCoords["z"]) }
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:playerConnecting",function(source,identifiers,deferrals)
	local steam = vRP.getIdentities(source)
	if steam then
		if not vRP.checkBanned(steam) then
			if vRP.checkWhitelist(steam) then
				vRP.execute("accounts/dateLogin",{ steam = steam, login = os.date("%d/%m/%Y") })
				deferrals.done()
			else
				local infoAccount = vRP.infoAccount(steam)
				if not infoAccount then
					vRP.execute("accounts/newAccount",{ steam = steam, login = os.date("%d/%m/%Y") })
				end

				deferrals.done("Envie na sala liberação: "..steam)
				TriggerEvent("Queue:removeQueue",identifiers)
			end
		else
			deferrals.done("Banido.")
			TriggerEvent("Queue:removeQueue",identifiers)
		end
	else
		deferrals.done("Conexão perdida com a Steam.")
		TriggerEvent("Queue:removeQueue",identifiers)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.characterChosen(source,user_id,model)
	vRP.userIds[source] = user_id
	vRP.userSources[user_id] = source
	vRP.userTables[user_id] = vRP.userData(user_id,"Datatable")

	if model ~= nil then
		vRP.userTables[user_id]["backpack"] = 50
		vRP.userTables[user_id]["inventory"] = {}
		vRP.generateItem(user_id,"water",3,false)
		vRP.generateItem(user_id,"sandwich",3,false)
		vRP.generateItem(user_id,"cellphone",1,false)
		vRP.userTables[user_id]["skin"] = GetHashKey(model)
	end

	local identity = vRP.userIdentity(user_id)
	if identity["serial"] == nil then
		vRP.execute("characters/setSerial",{ user_id = user_id, serial = vRP.generateSerial() })
	end

	TriggerEvent("vRP:playerSpawn",user_id,source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetGameType("Bahamas")
	SetMapName("www.bahamascity.com.br")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:PRINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:Print")
AddEventHandler("vRP:Print",function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Hackers","Passaporte **"..user_id.."** "..message..".",3092790)
	end
end)

vRP.getUserSource = vRP.userSource