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
Tunnel.bindInterface("player",cRP)
vSERVER = Tunnel.getInterface("player")

-----------------------------------------
local inCarry = false
local inCarryAnim = ""
local inCarryDict = ""
local inCarryControl = 0
local inCarryBlock = false

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
		Citizen.Wait(1)
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
	TriggerEvent("cancelando",true)
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
		Citizen.Wait(1)
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
	TriggerEvent("cancelando",false)
	DetachEntity(PlayerPedId(),false,false)
	TriggerEvent("player:applyRope",false)
	vRP.removeObjects()
end