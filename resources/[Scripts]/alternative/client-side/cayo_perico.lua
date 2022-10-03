-----------------------------------------------------------------------------------------------------------------------------------------
-- CAYO PERICO - MINIMAP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetRadarAsExteriorThisFrame()
		SetRadarAsInteriorThisFrame("h4_fake_islandx",vec(4700.0,-5145.0),0,0)
	end
end)