
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 1

			SetPedHelmet(ped,false)
			DisableControlAction(0,345,true)

			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped then
				local speed = GetEntitySpeed(veh) * 3.6
				if speed ~= oldSpeed then
					if (oldSpeed - speed) >= 60 then
						TriggerServerEvent("upgradeStress",10)

						if GetVehicleClass(veh) ~= 8 and GetEntityModel(veh) ~= 1755270897 then
							SetVehicleEngineOn(veh,false,true,true)
							vehicleTyreBurst(veh)
						end
					end

					oldSpeed = speed
				end
			end
		else
			if oldSpeed ~= 0 then
				oldSpeed = 0
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(vehicle)
	local tyre = math.random(4)
	if tyre == 1 then
		if not IsVehicleTyreBurst(vehicle,0,false) then
			SetVehicleTyreBurst(vehicle,0,true,1000.0)
		end
	elseif tyre == 2 then
		if not IsVehicleTyreBurst(vehicle,1,false) then
			SetVehicleTyreBurst(vehicle,1,true,1000.0)
		end
	elseif tyre == 3 then
		if not IsVehicleTyreBurst(vehicle,4,false) then
			SetVehicleTyreBurst(vehicle,4,true,1000.0)
		end
	elseif tyre == 4 then
		if not IsVehicleTyreBurst(vehicle,5,false) then
			SetVehicleTyreBurst(vehicle,5,true,1000.0)
		end
	end

	if math.random(100) < 30 then
		Citizen.Wait(500)
		vehicleTyreBurst(vehicle)
	end
end