
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
local ipList = {
	{
		props = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = { -1150.7,-1520.7,10.6 }
	},{
		props = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = { -47.1,-1115.3,26.5 }
	},{
		props = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = { -802.3,175.0,72.8 }
	},{
		props = {
			"v_gabz_mrpd_rm1",
			"v_gabz_mrpd_rm2",
			"v_gabz_mrpd_rm3",
			"v_gabz_mrpd_rm4",
			"v_gabz_mrpd_rm5",
			"v_gabz_mrpd_rm6",
			"v_gabz_mrpd_rm7",
			"v_gabz_mrpd_rm8",
			"v_gabz_mrpd_rm9",
			"v_gabz_mrpd_rm10",
			"v_gabz_mrpd_rm11",
			"v_gabz_mrpd_rm12",
			"v_gabz_mrpd_rm13",
			"v_gabz_mrpd_rm14",
			"v_gabz_mrpd_rm15",
			"v_gabz_mrpd_rm16",
			"v_gabz_mrpd_rm17",
			"v_gabz_mrpd_rm18",
			"v_gabz_mrpd_rm19",
			"v_gabz_mrpd_rm20",
			"v_gabz_mrpd_rm21",
			"v_gabz_mrpd_rm22",
			"v_gabz_mrpd_rm23",
			"v_gabz_mrpd_rm24",
			"v_gabz_mrpd_rm25",
			"v_gabz_mrpd_rm26",
			"v_gabz_mrpd_rm27",
			"v_gabz_mrpd_rm28",
			"v_gabz_mrpd_rm29",
			"v_gabz_mrpd_rm30",
			"v_gabz_mrpd_rm31"
		},
		coords = { 451.0129,-993.3741,29.1718 }
	},{
		coords = { -69.18748,72.87926,77.17023 } -- Benefactor
	},{
		coords = { -1685.06,-277.2893,60.31789 } -- Church
	},{
		coords = { 1129.451,-782.8797,59.21406 } -- Rockets
	},{
		coords = { 1152.216,-786.5847,59.33324 } -- Rockets
	},{
		coords = { 322.113,-1075.958,28.3984 } -- Pharmacy Santos
	},{
		coords = { 1174.968,2641.397,36.75007 } -- Harmony
	},{
		coords = { -1419.976,-447.8622,36.62567 } -- Hayes
	},{
		coords = { 338.8661,-582.8466,29.63187 } -- Pillbox
	},{
		coords = { 311.2546,-592.4204,42.32737 } -- Pillbox
	},{
		coords = { -189.059,-1164.32,24.1877 } -- Impound
	},{
		coords = { -37.1869,-1050.44,27.58956 } -- Bennys
	},{
		coords = { -675.3189,5836.144,17.70478 } -- Hunting
	},{
		coords = { -175.6765,6385.318,30.5772 } -- Pharmacy Paleto
	},{
		coords = { -255.972,6321.406,33.116 } -- Paleto Hospital
	},{
		coords = { 562.8,2745.72,41.87698 } -- Petshop
	},{
		coords = { 1783.901,2555.33,46.70935 } -- Prison
	},{
		coords = { 1597.629,2553.452,45.81208 } -- Prison
	},{
		coords = { 1758.084,2486.698,48.78679 } -- Prison
	},{
		coords = { 1767.281,2583.534,46.59865 } -- Prison
	},{
		coords = { 1832.21,2582.68,47.0143 } -- Prison
	},{
		coords = { 1959.688,3844.558,34.54492 } -- Sandy Bar
	},{
		coords = { 1959.688,3844.558,34.54492 } -- Sandy Bar
	},{
		coords = { 1830.509,3679.626,33.2749 } -- Sandypital
	},{
		coords = { -551.0138,-193.8526,45.22602 } -- Towhall
	},{
		coords = { -585.7,-884.74,26.0,172.92 } -- Bullguer
	},{
		coords = { -582.9611,-922.9904,21.54857 } -- Benefactor
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADIPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for _k,_v in pairs(ipList) do
		local interiorCoords = GetInteriorAtCoords(_v["coords"][1],_v["coords"][2],_v["coords"][3])
		LoadInterior(interiorCoords)

		if _v["props"] ~= nil then
			for k,v in pairs(_v["props"]) do
				EnableInteriorProp(interiorCoords,v)
				Citizen.Wait(1)
			end
		end

		RefreshInterior(interiorCoords)
	end
end)