-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
chestCoords = {
	{ "Police",362.68,-1599.2,25.44,68.04 }, -- POLICIA SUL
	{ "Police",-443.12,6017.03,36.99,221.11 }, -- POLICIA NORTE
	{ "Police",118.36,-729.07,242.15,70.87 }, -- FBI
	{ "Vermelhos",-818.25,-717.82,23.78,107.72}, -- Vermelhos
	{ "Dk",-363.81,-2646.76,12.2,45.36}, --- Dk
	{ "MechanicS",822.23,-928.73,32.39,357.17}, -- Laranjas
	{ "Brancos",810.88,-764.4,31.26,269.3}, -- Brancos
	{ "Marinhos", 1108.61,250.08,-45.85,357.17}, -- Marinhos
	{ "Rosas",-597.08,-1049.4,22.34,2.84}, -- Rosas
	{ "RosasFrutas",-588.51,-1066.21,22.34,269.3}, -- Rosas
	{ "Linos", -1259.11,-283.95,37.39,252.29},-- Linos
	{ "LinosFood", -1262.43,-288.35,37.37,14.18},
	{ "Hospital", -1257.16,317.36,65.5,150.24}, -- Hp
	{ "Bullguer",-571.97,-892.54,25.7,87.88 }
}
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	for k,v in pairs(chestCoords) do
		if v[6] then
			exports["target"]:AddCircleZone("chest:"..k,vector3(v[2],v[3],v[4]),1.0,{
				name = "chest:"..k,
				heading = v[5]
			},{
				shop = {type = "chest", id = k},
				distance = 1.0,
				options = {
					{
						event = "inventory:open",
						label = "Abrir",
						tunnel = "shop"
					}
				}
			})
		else
			exports["target"]:AddCircleZone("chest:"..k,vector3(v[2],v[3],v[4]),1.0,{
				name = "chest:"..k,
				heading = v[5]
			},{
				shop = {type = "chest", id = k},
				distance = 1.0,
				options = {
					{
						event = "inventory:open",
						label = "Abrir",
						tunnel = "shop"
					},{
						event = "chest:upgradeSystem",
						label = "Aumentar",
						tunnel = "shop"
					}
				}
			})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("chest:upgradeSystem",function(inventoryData)
	local chestId = inventoryData["id"]
	vSERVER.upgradeSystem(chestCoords[chestId][1])
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:UpdateWeight")
AddEventHandler("chest:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ action = "updateWeight", type = "chest", invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
