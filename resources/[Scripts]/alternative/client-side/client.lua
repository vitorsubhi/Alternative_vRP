local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")

cRP = {}
Tunnel.bindInterface("alternative",cRP)
vSERVER = Tunnel.getInterface("alternative")

RegisterNUICallback('dev_tools',function()
	vSERVER.Punicao()
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inCarry = false
local inCarryAnim = ""
local inCarryDict = ""
local inCarryControl = 0
local inCarryBlock = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEROPE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("rope:toggleRope")
AddEventHandler("rope:toggleRope",function(pedTarget)
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		if not inCarryBlock then
			if not inCarry then
				vSERVER.startCarry(pedTarget,"missfinale_c2mcs_1","nm","fin_c2_mcs_1_camman","firemans_carry",0.15,0.27,0.63,pedTarget,100000,0.0,49,33,1)
			else
				inCarry = false
				vRP.removeObjects()
				DetachEntity(ped,false,false)
				vSERVER.stopCarry(pedTarget)
			end
		end
	end
end)

RegisterNetEvent("player:toggleCarregar")
AddEventHandler("player:toggleCarregar",function(pedTarget)
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		if not inCarryBlock then
			if not inCarry then
				vSERVER.startCarry(pedTarget,"anim@heists@box_carry@","anim@amb@business@bgen@bgen_no_work@","idle","sit_phone_phoneputdown_idle_nowork",0.25,0.1,1.03,pedTarget,100000,90.0,49,33,1)
			else
				inCarry = false
				vRP.removeObjects()
				DetachEntity(ped,false,false)
				vSERVER.stopCarry(pedTarget)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.syncTarget(target,animationLib,animation2,distans,distans2,height,length,spin,controlFlag)
	vRP.removeObjects()
	local ped = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		RequestAnimDict(animationLib)
		Citizen.Wait(10)
	end

	if spin == nil then
		spin = 180.0
	end

	AttachEntityToEntity(ped,targetPed,0,distans2,distans,height,0.5,0.5,spin,false,false,false,false,2,false)

	if controlFlag == nil then
		controlFlag = 0
	end

	TaskPlayAnim(ped,animationLib,animation2,8.0,-8.0,length,controlFlag,0,false,false,false)

	inCarryAnim = animation2
	inCarryDict = animationLib
	inCarryControl = controlFlag

	TriggerEvent("player:applyRope",true)
	LocalPlayer["state"]["Cancel"] = true
	inCarryBlock = true
	inCarry = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.syncSource(animationLib,animation,length,controlFlag,animFlag)
	local ped = PlayerPedId()

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		RequestAnimDict(animationLib)
		Citizen.Wait(10)
	end

	if controlFlag == nil then
		controlFlag = 0
	end

	TaskPlayAnim(ped,animationLib,animation,8.0,-8.0,length,controlFlag,0,false,false,false)

	inCarryAnim = animation
	inCarryDict = animationLib
	inCarryControl = controlFlag
	inCarry = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopCarry()
	inCarry = false
	inCarryBlock = false
	LocalPlayer["state"]["Cancel"] = false
	DetachEntity(PlayerPedId(),false,false)
	TriggerEvent("player:applyRope",false)
	vRP.removeObjects()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADANIM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if inCarry then
			timeDistance = 4
			local ped = PlayerPedId()
			if not IsEntityPlayingAnim(ped,inCarryDict,inCarryAnim,3) then
				TaskPlayAnim(ped,inCarryDict,inCarryAnim,8.0,-8.0,100000,inCarryControl,0,false,false,false)
			end

			DisableControlAction(1,23,true)
		end
		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------------------------------------------------------------------
local cDistance = 15000
local showIds = false
local players = {}
local admin = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CORE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
	    for _, id in ipairs(GetActivePlayers()) do
	    	if id == -1 or id == nil then return end
			local pid, userIdentity = vSERVER.getId(GetPlayerServerId(id))
			if pid == -1 then
				return
			end
			if players[id] ~= pid or not players[id] then
				players[id] = pid
			end
		end
		Citizen.Wait(1500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wall",function()
	admin = vSERVER.isAdmin()
	if not admin then
		return
	end

	if admin then
		showIds = not showIds
	end

	if showIds then
		vSERVER.reportLog("ON")
		TriggerEvent("Notify","amarelo","Wall ligado.",3000)
	else
		vSERVER.reportLog("OFF")
		TriggerEvent("Notify","amarelo","Wall desligado.",3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
    	local kswait = 15000
		  if showIds then
			pedAdm = PlayerPedId()
			kswait = 7

	        	for k,id in ipairs(GetActivePlayers()) do
	        		if ((NetworkIsPlayerActive(id)) and GetPlayerPed(id) ~= PlayerPedId()) then
						local p1 = GetEntityCoords(PlayerPedId())
						local p2 = GetEntityCoords(GetPlayerPed(id))
						local distance = math.floor(#(p2-p1))
						if admin then
					    	if ((distance < cDistance)) then
					    		if GetPlayerPed(id) ~= -1 and players[id] ~= nil then
									local playerName = GetPlayerName(id)
									if playerName == nil or playerName == "" or playerName == -1 then
										playerName = "Sem Steam"
									end
									
					    			local playerHealth = GetEntityHealth(GetPlayerPed(id))
									if playerHealth == 1 then
										playerHealth = 0
									end

									local playerArmour = GetPedArmour(GetPlayerPed(id))
									if playerArmour == 1 then
										playerArmour = 0
									end

					    			local playerHealthPercent = playerHealth / 2
					    			local playerArmourPercent = playerArmour
					    			playerHealthPercent = math.floor(playerHealthPercent)
					    			playerArmourPercent = math.floor(playerArmourPercent)
									DrawLine(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, 129, 61, 138, 255)
					    			DrawText3D(p2.x, p2.y, p2.z+1, "~p~ID: ~w~" .. players[id] .. "\n~g~VIDA:~w~ "..playerHealth.. " (" .. playerHealthPercent .. "%)\n~r~COLETE:~w~ "..playerArmour.. " (" .. playerArmourPercent .. "%)\n~b~STEAM:~w~ " .. playerName, 255, 255, 255)
					    		end
					    	end
					    end
					end
				end

		end
		Citizen.Wait(kswait)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- 3D TEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.25)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end