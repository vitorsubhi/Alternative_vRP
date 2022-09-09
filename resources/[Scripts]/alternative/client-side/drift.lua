-----------------------------------------------------------------------------------------------------------------------------------------
-- DRIFT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 3000
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*2.236936
			if speed <= 100.0 then
				sleep = 4
				if IsControlPressed(1,21) then
					SetVehicleReduceGrip(vehicle,true)
				else
					SetVehicleReduceGrip(vehicle,false)
				end
			end    
		end
		Citizen.Wait(sleep)
	end
end)