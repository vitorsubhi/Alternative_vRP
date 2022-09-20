
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName,vehLock,vehBlock,vehHealth = vRPC.vehList(source,3)
		if vehicle then
			if not vehLock and not vehBlock and parseInt(vehHealth) > 0 then
				if vRP.userPlate(vehPlate) then
					if not vRPC.inVehicle(source) then
						TriggerClientEvent("player:syncDoorsOptions",-1,vehNet,"open")
					end

					vCLIENT.trunkOpen(source)
				end
			end
		end
	end
end)