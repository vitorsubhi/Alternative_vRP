-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("notify",cRP)
vSERVER = Tunnel.getInterface("notify")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showBlips = {}
local timeBlips = {}
local numberBlips = 0
local hoverCoords = {}
local hoverNumbers = 0
local hoverLocates = {}
local hoverInsert = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,timer)
	SendNUIMessage({ type = 'notify', css = css, mensagem = mensagem, timer = timer })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(status)
	SendNUIMessage({ type = 'notifyItem', mode = status[1], item = status[2], amount = status[3], name = status[4] })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY CALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("notify",function(source,args,rawCommand)
	if not exports["player"]:blockCommands() and not exports["player"]:handCuff() then
		SendNUIMessage({ type = 'notifyCall', action = "showAll" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("notify","Abrir as notificações","keyboard","f2")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data)
	data["street"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["x"],data["y"],data["z"]))

	SendNUIMessage({ type = 'notifyCall', action = "notify", data = data })

	numberBlips = numberBlips + 1

	timeBlips[numberBlips] = 60
	showBlips[numberBlips] = AddBlipForRadius(data["x"],data["y"],data["z"],150.0)
	SetBlipColour(showBlips[numberBlips],data["blipColor"])
	SetBlipAlpha(showBlips[numberBlips],150)

	if data["code"] == "QRT" then
		TriggerEvent("sounds:source","deathcop",0.7)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(timeBlips) do
			if timeBlips[k] > 0 then
				timeBlips[k] = timeBlips[k] - 1

				if timeBlips[k] <= 0 then
					RemoveBlip(showBlips[k])
					showBlips[k] = nil
					timeBlips[k] = nil
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function()
	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("setWay",function(data)
	SetNewWaypoint(data["x"] + 0.0001,data["y"] + 0.0001)
	SendNUIMessage({ type = 'notifyCall', action = "hideAll" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("phoneCall",function(data)
	exports["smartphone"]:callPlayer(data["phone"])
	SendNUIMessage({ type = 'notifyCall', action = "hideAll" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if not hoverInsert then
				local coords = GetEntityCoords(ped)
				local gridZone = getGridzone(coords["x"],coords["y"])

				if hoverLocates[gridZone] then
					for k,v in pairs(hoverLocates[gridZone]) do
						local distance = #(coords - vector3(v["x"],v["y"],v["z"]))
						if distance < v["distance"] then
							SendNUIMessage({ type = 'hoverfy', show = true, key = v["key"], title = v["title"], legend = v["legend"] })
							hoverCoords = { v["x"],v["y"],v["z"],v["distance"] }
							hoverInsert = true
						end
					end
				end
			end
		end

		if hoverInsert then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(hoverCoords[1],hoverCoords[2],hoverCoords[3]))
			if distance > hoverCoords[4] then
				SendNUIMessage({ type = 'hoverfy', show = false })
				hoverInsert = false
				timeDistance = 100
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY:INSERTTABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hoverfy:insertTable")
AddEventHandler("hoverfy:insertTable",function(innerTable)
	for k,v in pairs(innerTable) do
		local gridZone = getGridzone(v[1],v[2])

		if hoverLocates[gridZone] == nil then
			hoverLocates[gridZone] = {}
		end

		hoverNumbers = hoverNumbers + 1
		hoverLocates[gridZone][hoverNumbers] = { x = v[1], y = v[2], z = v[3], distance = v[4], key = v[5], title = v[6], legend = v[7] }
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
local policeRadar = false
local policeFreeze = false
local policeService = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFYPUSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("notifyShooting")
AddEventHandler("notifyShooting",function(coords)
	if policeService then
		TriggerEvent("NotifyPush",{ code = "QRU", title = "Confronto em andamento", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Disparos de arma de fogo", blipColor = 6 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ tencode = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendCode",function(data)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	vSERVER.sendCode(data["code"])
	SendNUIMessage({ tencode = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:UPDATESERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("police:updateService")
AddEventHandler("police:updateService",function(status)
	policeService = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADRADAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyPoliceVehicle(ped) and policeService then
			if policeRadar then
				if not policeFreeze then
					timeDistance = 100

					local vehicle = GetVehiclePedIsUsing(ped)
					local vehicleDimension = GetOffsetFromEntityInWorldCoords(vehicle,0.0,1.0,1.0)

					local vehicleFront = GetOffsetFromEntityInWorldCoords(vehicle,0.0,105.0,0.0)
					local vehicleFrontShape = StartShapeTestCapsule(vehicleDimension,vehicleFront,3.0,10,vehicle,7)
					local _,_,_,_,vehFront = GetShapeTestResult(vehicleFrontShape)

					if IsEntityAVehicle(vehFront) then
						local vehModel = GetEntityModel(vehFront)
						local vehPlate = GetVehicleNumberPlateText(vehFront)
						local vehSpeed = GetEntitySpeed(vehFront) * 3.6
						local vehName = GetDisplayNameFromVehicleModel(vehModel)

						SendNUIMessage({ radar = "top", plate = vehPlate, model = vehName, speed = vehSpeed })
					end

					local vehicleBack = GetOffsetFromEntityInWorldCoords(vehicle,0.0,-105.0,0.0)
					local vehicleBackShape = StartShapeTestCapsule(vehicleDimension,vehicleBack,3.0,10,vehicle,7)
					local _,_,_,_,vehBack = GetShapeTestResult(vehicleBackShape)

					if IsEntityAVehicle(vehBack) then
						local vehModel = GetEntityModel(vehBack)
						local vehPlate = GetVehicleNumberPlateText(vehBack)
						local vehSpeed = GetEntitySpeed(vehBack) * 3.6
						local vehName = GetDisplayNameFromVehicleModel(vehModel)

						SendNUIMessage({ radar = "bot", plate = vehPlate, model = vehName, speed = vehSpeed })
					end
				end
			end
		end

		if not IsPedInAnyVehicle(ped) and policeRadar then
			policeRadar = false
			SendNUIMessage({ radar = false })
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLERADAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleRadar",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(ped) and policeService then
		if policeRadar then
			policeRadar = false
			SendNUIMessage({ radar = false })
		else
			policeRadar = true
			SendNUIMessage({ radar = true })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEFREEZE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("toggleFreeze",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyPoliceVehicle(ped) and policeService then
		policeFreeze = not policeFreeze
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tencode",function(source,args,rawCommand)
	--if policeService then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.9)
		SendNUIMessage({ tencode = true })
	--end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOUND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("sounds:source")
AddEventHandler("sounds:source",function(sound,volume)
	SendNUIMessage({ type = "sound", transactionFile = sound, transactionVolume = volume })
end)

RegisterNetEvent("sounds:distance")
AddEventHandler("sounds:distance",function(sCoords,maxDistance,sound,volume)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - sCoords)

	if distance <= maxDistance then
		SendNUIMessage({ type = "sound", transactionFile = sound, transactionVolume = volume })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("tencode","Abrir o código dez","keyboard","f3")
RegisterKeyMapping("toggleRadar","Ativar/Desativar radar das viaturas.","keyboard","N")
RegisterKeyMapping("toggleFreeze","Travar/Destravar radar das viaturas.","keyboard","M")