local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("farms")
vRP = Proxy.getInterface("vRP")


--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

farms = Tunnel.getInterface("farms",farms)
----------------------------------------------------------------------------------------------------------------------------------------- 
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

local perm = {}
local processo = false
local item = nil
local selecionado = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{
		['id'] = 1,
		['coords'] = { 2216.63, 5576.16, 53.7, 22.48 },
		["customAnim"] = false,
		["processDuration"] = 9000,
		["processAnim"] = {false,"amb@world_human_gardener_plant@female@base","base_female",false },
		['text'] = "colher a sativa",
		['perm'] = "Maconha"
	},
	{ 
		['id'] = 2,
		['coords'] = { 2200.38, 5612.38, 53.53, 22.48},
		["customAnim"] = false,
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "colher a índica",
		['perm'] = "Maconha"
	}, 
	{ 
		['id'] = 3,
		['coords'] = { 2268.18,5136.55,53.77, 22.48 },
		["customAnim"] = true,
		["functionAnim"] = "separando()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "separar bucha",
		['perm'] = "Maconha"
	},
	{ 
		['id'] = 4,
		['coords'] = { 1493.17,6390.24,21.26,161.58 },
		["customAnim"] = true,
		["functionAnim"] = "liquidos()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "colocar os ingredientes",
		['perm'] = "Metanfetamina"
	},
	{ 
		['id'] = 5,
		['coords'] = { 1504.89,6393.25,20.79,22.48 },
		["customAnim"] = true,
		["functionAnim"] = "quebrando()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "quebrar metanfetamina",
		['perm'] = "Metanfetamina"
	},
	{ 
		['id'] = 6,
		['coords'] = { 1500.67,6394.03,20.79,22.48 },
		["customAnim"] = true,
		["functionAnim"] = "embalando()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "embalar metanfetamina",
		['perm'] = "Metanfetamina"
	},
	{ 
		['id'] = 7,
		['coords'] = { 1978.45,-2607.79,3.56,323.15 },
		["customAnim"] = true,
		["functionAnim"] = "despejando()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "despejar cocaína",
		['perm'] = "Cocaina"
	},
	{ 
		['id'] = 8,
		['coords'] = { 1979.98,-2612.82,3.56,133.23 },
		["customAnim"] = true,
		["functionAnim"] = "espalhando()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "espalhar cocaína",
		['perm'] = "Cocaina"
	},
	{ 
		['id'] = 9,
		['coords'] = { 1983.14,-2611.64,3.56,323.15 },
		["customAnim"] = true,
		["functionAnim"] = "embalando_brinquedo()",
		["processDuration"] = 21000,
		["processAnim"] = {false,"anim@amb@business@weed@weed_inspecting_lo_med_hi@","weed_crouch_checkingleaves_idle_01_inspector",false },
		['text'] = "embalar cocaína",
		['perm'] = "Cocaina"
	}
}  

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local myCoords = GetEntityCoords(ped)
			local distance = #(myCoords - vector3(v["coords"][1],v["coords"][2],v["coords"][3]))
			if distance <= 2 and not processo then
				drawTxt("Pressione  ~r~E~w~  para "..v.text..".",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm)then
					ClearPedTasks(ped)
					if not v["customAnim"] then
						processo = true
						LocalPlayer["state"]["Cancel"] = true
						LocalPlayer["state"]["Commands"] = true
						TriggerEvent("Progress",v['processDuration'] + 500)
						SetEntityHeading(ped, v['coords'][4])
						vRP.playAnim(v["processAnim"][1], {v["processAnim"][2],v["processAnim"][3]}, v["processAnim"][4])
						Citizen.Wait(v['processDuration'])
						func.checkPayment(v['id'])
						LocalPlayer["state"]["Commands"] = false
						LocalPlayer["state"]["Cancel"] = false
						processo = false
					else
						LocalPlayer["state"]["Cancel"] = true
						LocalPlayer["state"]["Commands"] = true
						processo = true
						load(v["functionAnim"])()
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function separando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId() 
			local  targetRotation = vec3(180.0, 180.0, 300.0)
			local x,y,z = table.unpack(vec3(111.74, 6359.91, 32.32)) 

			local animDict = "anim@amb@business@weed@weed_sorting_seated@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_weed_bag_01a")
			RequestModel("bkr_prop_weed_bag_pile_01a")
			RequestModel("bkr_prop_weed_bud_02b")
			RequestModel("bkr_prop_weed_leaf_01a")
			RequestModel("bkr_prop_weed_dry_01a")
			RequestModel("bkr_prop_weed_bucket_open_01a")

			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_weed_bag_01a") and 
				not HasModelLoaded("bkr_prop_weed_bag_pile_01a") and 
				not HasModelLoaded("bkr_prop_weed_bud_02b") and 
				not HasModelLoaded("bkr_prop_weed_leaf_01a") and
				not HasModelLoaded("bkr_prop_weed_dry_01a") and 
				not HasModeLoaded("bkr_prop_weed_bucket_open_01a") do 
				Citizen.Wait(100)
			end

			plastico_vazio = CreateObject(GetHashKey('bkr_prop_weed_bag_01a'), x, y, z, 1, 0, 1)
			pilha_plasticos = CreateObject(GetHashKey('bkr_prop_weed_bag_pile_01a'), x, y, z, 1, 0, 1)
			bud = CreateObject(GetHashKey('bkr_prop_weed_bud_02b'), x, y, z, 1, 0, 1)
			folha = CreateObject(GetHashKey('bkr_prop_weed_leaf_01a'), x, y, z, 1, 0, 1)
			maconha_seca = CreateObject(GetHashKey('bkr_prop_weed_dry_01a'), x, y, z, 1, 0, 1)
			balde = CreateObject(GetHashKey('bkr_prop_weed_bucket_open_01a'), x, y, z, 1, 0, 1)


			local netScene = NetworkCreateSynchronisedScene(x + 5.5,y + 3.1, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene2 = NetworkCreateSynchronisedScene(x + 5.5 ,y + 3.1, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "sorter_left_sort_v1_sorter01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(plastico_vazio, netScene, animDict, "sorter_left_sort_v1_weedbag01a", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(pilha_plasticos, netScene, animDict, "sorter_left_sort_v1_weedbagpile01a", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bud, netScene, animDict, "sorter_left_sort_v1_weedbud02b^3", 4.0, -8.0, 1)


			NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "sorter_left_sort_v1_sorter01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(maconha_seca, netScene2, animDict, "sorter_left_sort_v1_weeddry01a", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(folha, netScene2, animDict, "sorter_left_sort_v1_weedleaf01a^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(balde, netScene2, animDict, "sorter_left_sort_v1_bucket01a", 4.0, -8.0, 1)

			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene2)


			
			Citizen.Wait(GetAnimDuration(animDict, "sorter_left_sort_v1_sorter01") * 770)
			TriggerEvent('Notify', 'verde', 'Você separou a bucha.', 5000)
			DeleteObject(plastico_vazio)
			DeleteObject(pilha_plasticos)
			DeleteObject(bud)
			DeleteObject(folha)
			DeleteObject(maconha_seca)
			DeleteObject(balde)

			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break
		end
	end)
end

function liquidos()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId() 
            local  targetRotation = vec3(180.0, 180.0, 180.0)
            local x,y,z = table.unpack(vec3(1493.17,6390.24,21.26))

			local animDict = "anim@amb@business@meth@meth_monitoring_cooking@cooking@"
    
            RequestAnimDict(animDict)
            RequestModel("bkr_prop_meth_ammonia")
            RequestModel("bkr_prop_meth_sacid")
            RequestModel("bkr_prop_fakeid_clipboard_01a")
            RequestModel("bkr_prop_fakeid_penclipboard")
    
            while not HasAnimDictLoaded(animDict) and
                not HasModelLoaded("bkr_prop_meth_ammonia") and 
                not HasModelLoaded("bkr_prop_meth_sacid") and 
                not HasModelLoaded("bkr_prop_fakeid_clipboard_01a") and
                not HasModelLoaded("bkr_prop_fakeid_penclipboard") do 
                Citizen.Wait(100)
            end

            ammonia = CreateObject(GetHashKey('bkr_prop_meth_ammonia'), x, y, z, 1, 0, 1)
            acido = CreateObject(GetHashKey('bkr_prop_meth_sacid'), x, y, z, 1, 0, 1)
            caderneta = CreateObject(GetHashKey('bkr_prop_fakeid_clipboard_01a'), x, y, z, 1, 0, 1)
            caneta = CreateObject(GetHashKey('bkr_prop_fakeid_penclipboard'), x, y, z, 1, 0, 1)   


            local netScene = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            local netScene2 = NetworkCreateSynchronisedScene(x + 5.0 ,y + 2.0, z - 0.4, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(ammonia, netScene, animDict, "chemical_pour_long_ammonia", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(acido, netScene, animDict, "chemical_pour_long_sacid", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(caderneta, netScene, animDict, "chemical_pour_long_clipboard", 4.0, -8.0, 1)
            NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "chemical_pour_long_cooker", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(caneta, netScene2, animDict, "chemical_pour_long_pencil", 4.0, -8.0, 1)
			
			Citizen.Wait(150)
            NetworkStartSynchronisedScene(netScene)
            NetworkStartSynchronisedScene(netScene2)

			Citizen.Wait(GetAnimDuration(animDict, "chemical_pour_long_cooker") * 770)
			TriggerEvent('Notify', 'verde', 'Você misturou os ingredientes.', 5000)
            DeleteObject(ammonia)
            DeleteObject(acido)
            DeleteObject(caderneta)
			DeleteObject(caneta)
			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break    
		end
	end)
end


function embalando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local ped = PlayerPedId() 
			local  targetRotation = vec3(180.0, 180.0, 168.0)
			local x,y,z = table.unpack(vec3(1500.67, 6394.03, 20.79))    

			local animDict = "anim@amb@business@meth@meth_smash_weight_check@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_meth_scoop_01a")
			RequestModel("bkr_prop_meth_bigbag_03a")
			RequestModel("bkr_prop_meth_bigbag_04a")
			RequestModel("bkr_prop_fakeid_penclipboard")
			RequestModel("bkr_prop_fakeid_clipboard_01a")
			RequestModel("bkr_prop_meth_openbag_02")
			RequestModel("bkr_prop_coke_scale_01")
			RequestModel("bkr_prop_meth_smallbag_01a")
			RequestModel("bkr_prop_meth_openbag_01a")
			RequestModel("bkr_prop_fakeid_penclipboard")

			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_meth_scoop_01a") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_03a") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_04a") and
				not HasModelLoaded("bkr_prop_meth_openbag_02") and 
				not HasModelLoaded("bkr_prop_coke_scale_01") and 
				not HasModelLoaded("bkr_prop_meth_smallbag_01a") and 
				not HasModelLoaded("bkr_prop_meth_openbag_01a") and 
				not HasModelLoaded("bkr_prop_fakeid_clipboard_01a") and
				not HasModelLoaded("bkr_prop_fakeid_penclipboard") do 
				Citizen.Wait(100)
			end

			pazinha = CreateObject(GetHashKey('bkr_prop_meth_scoop_01a'), x, y, z, 1, 0, 1)
			caixa_grande = CreateObject(GetHashKey('bkr_prop_meth_bigbag_03a'), x, y, z, 1, 0, 1)
			caixa_grande_2 = CreateObject(GetHashKey('bkr_prop_meth_bigbag_04a'), x, y, z, 1, 0, 1)
			bolsa = CreateObject(GetHashKey('bkr_prop_meth_openbag_02'), x, y, z, 1, 0, 1)
			bolsa_fechada = CreateObject(GetHashKey('bkr_prop_meth_smallbag_01a'), x, y, z, 1, 0, 1)
			bolsa_aberta = CreateObject(GetHashKey('bkr_prop_meth_openbag_01a'), x, y, z, 1, 0, 1)
			balanca = CreateObject(GetHashKey('bkr_prop_coke_scale_01'), x, y, z, 1, 0, 1)
			caderneta = CreateObject(GetHashKey('bkr_prop_fakeid_clipboard_01a'), x, y, z, 1, 0, 1)
			caneta = CreateObject(GetHashKey('bkr_prop_fakeid_penclipboard'), x, y, z, 1, 0, 1)


			local netScene = NetworkCreateSynchronisedScene(x - 5.3,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene2 = NetworkCreateSynchronisedScene(x - 5.3 ,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene3 = NetworkCreateSynchronisedScene(x - 5.3 ,y - 0.4, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, "break_weigh_scoop", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_grande_2, netScene, animDict, "break_weigh_box01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bolsa, netScene, animDict, "break_weigh_methbag01^3", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(balanca, netScene2, animDict, "break_weigh_scale", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_grande, netScene2, animDict, "break_weigh_box01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(bolsa_fechada, netScene2, animDict, "break_weigh_methbag01^2", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "break_weigh_char01", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(bolsa_aberta, netScene3, animDict, "break_weigh_methbag01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caderneta, netScene3, animDict, "break_weigh_clipboard", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caneta, netScene3, animDict, "break_weigh_pen", 4.0, -8.0, 1)
			
			NetworkStartSynchronisedScene(netScene)
			NetworkStartSynchronisedScene(netScene2)
			NetworkStartSynchronisedScene(netScene3)


			
			Citizen.Wait(GetAnimDuration(animDict, "break_weigh_char01") * 770)

			TriggerEvent('Notify', 'verde', 'Você embalou a metanfetamina.', 5000)

			DeleteObject(pazinha)
			DeleteObject(caixa_grande)
			DeleteObject(caixa_grande_2)
			DeleteObject(bolsa)
			DeleteObject(bolsa_fechada)
			DeleteObject(bolsa_aberta)
			DeleteObject(balanca)
			DeleteObject(caderneta)
			DeleteObject(caneta)
			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break
		end
	end)
end

function quebrando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local ped = PlayerPedId() 
			local  targetRotation = vec3(180.0, 180.0, 168.0)
			local x,y,z = table.unpack(vec3(1504.89, 6393.25, 20.79))

			local animDict = "anim@amb@business@meth@meth_smash_weight_check@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_meth_tray_02a")
			RequestModel("w_me_hammer")
			RequestModel("bkr_prop_meth_tray_01a")
			RequestModel("bkr_prop_meth_smashedtray_01")
			RequestModel("bkr_prop_meth_smashedtray_01_frag_")
			RequestModel("bkr_prop_meth_bigbag_02a")

			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_meth_tray_02a") and 
				not HasModelLoaded("bkr_prop_fakeid_penclipboard") and 
				not HasModelLoaded("w_me_hammer") and 
				not HasModelLoaded("bkr_prop_meth_tray_01a") and 
				not HasModelLoaded("bkr_prop_meth_smashedtray_01") and 
				not HasModelLoaded("bkr_prop_meth_smashedtray_01_frag_") and 
				not HasModelLoaded("bkr_prop_meth_bigbag_02a") do 
				Citizen.Wait(100)
			end

			forma = CreateObject(GetHashKey('bkr_prop_meth_tray_02a'), x, y, z, 1, 0, 1)
			forma_2 = CreateObject(GetHashKey('bkr_prop_meth_tray_01a'), x, y, z, 1, 0, 1)
			--forma_quebrada = CreateObject(GetHashKey('bkr_prop_meth_smashedtray_01'), x, y, z, 1, 0, 1)
			forma_quebrada_2 = CreateObject(GetHashKey('bkr_prop_meth_smashedtray_01_frag_'), x, y, z, 1, 0, 1)
			martelo = CreateObject(GetHashKey('w_me_hammer'), x, y, z, 1, 0, 1)
			caixa = CreateObject(GetHashKey('bkr_prop_meth_bigbag_02a'), x, y, z, 1, 0, 1)




			local netScene = NetworkCreateSynchronisedScene(x - 3.6,y - 1.0, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			local netScene2 = NetworkCreateSynchronisedScene(x - 3.6,y - 1.0, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "break_weigh_char02", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(forma_quebrada, netScene, animDict, "break_weigh_tray01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(forma_2, netScene, animDict, "break_weigh_tray01^1", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(martelo, netScene, animDict, "break_weigh_hammer", 4.0, -8.0, 1)

			NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "break_weigh_char02", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(forma, netScene2, animDict, "break_weigh_tray01^2", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(forma_quebrada_2, netScene2, animDict, "break_weigh_tray01", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa, netScene2, animDict, "break_weigh_box01^1", 4.0, -8.0, 1)
			
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)
			NetworkStartSynchronisedScene(netScene2)


			
			Citizen.Wait(GetAnimDuration(animDict, "break_weigh_char02") * 770)
			TriggerEvent('Notify', 'verde', 'Você quebrou a mentafetamina.', 5000)
			DeleteObject(forma)
			DeleteObject(forma_2)
			DeleteObject(forma_quebrada)
			DeleteObject(forma_quebrada_2)
			DeleteObject(martelo)
			DeleteObject(caixa)
			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break
		end
	end)
end


function embalando_brinquedo()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local animDict = "anim@amb@business@coc@coc_packing_hi@"
            RequestAnimDict(animDict)
            RequestModel("bkr_prop_coke_fullscoop_01a")
            RequestModel("bkr_prop_coke_fullmetalbowl_02")
            RequestModel("bkr_prop_coke_dollboxfolded")
            RequestModel("bkr_prop_coke_dollmould")
            RequestModel("bkr_prop_coke_press_01b")
            RequestModel("bkr_prop_coke_dollcast")
            RequestModel("bkr_prop_coke_doll")
            RequestModel("bkr_prop_coke_dollbox")
            RequestModel("bkr_prop_coke_doll_bigbox")
    
            while not HasAnimDictLoaded(animDict) and
                not HasModelLoaded("bkr_prop_coke_fullscoop_01a") and 
                not HasModelLoaded("bkr_prop_coke_fullmetalbowl_02") and 
                not HasModelLoaded("bkr_prop_coke_dollboxfolded") and 
                not HasModelLoaded("bkr_prop_coke_dollmould") and 
                not HasModelLoaded("bkr_prop_coke_press_01b") and 
                not HasModelLoaded("bkr_prop_coke_dollcast") and 
                not HasModelLoaded("bkr_prop_coke_doll") and 
                not HasModelLoaded("bkr_prop_coke_dollbox") and
                not HasModelLoaded("bkr_prop_coke_doll_bigbox") do
                Citizen.Wait(100)
            end

            pazinha = CreateObject(GetHashKey('bkr_prop_coke_fullscoop_01a'), x, y, z, 1, 0, 1)
            vasilha = CreateObject(GetHashKey('bkr_prop_coke_fullmetalbowl_02'), x, y, z, 1, 0, 1)
            caixa_aberta = CreateObject(GetHashKey('bkr_prop_coke_dollboxfolded'), x, y, z, 1, 0, 1)
            boneco_molde = CreateObject(GetHashKey('bkr_prop_coke_dollmould'), x, y, z, 1, 0, 1)
            prensa = CreateObject(GetHashKey('bkr_prop_coke_press_01b'), x, y, z, 1, 0, 1)
            boneco_vazio = CreateObject(GetHashKey('bkr_prop_coke_dollcast'), x, y, z, 1, 0, 1)
            boneco_pronto = CreateObject(GetHashKey('bkr_prop_coke_doll'), x, y, z, 1, 0, 1)
            caixa_fechada = CreateObject(GetHashKey('bkr_prop_coke_dollbox'), x, y, z, 1, 0, 1)

            local  targetRotation = vec3(180.0, 180.0, 330.0)
            local x,y,z = table.unpack(vec3(1985.24,-2616.34,3.58))

            local animPos = GetAnimInitialOffsetPosition(animDict, "full_cycle_v1_pressoperator",x ,y ,z ,targetRotation, 0, 2) 
			local netScene = NetworkCreateSynchronisedScene(x + 3.0, y - 0.8, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)

            NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "full_cycle_v1_pressoperator", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, "full_cycle_v1_scoop", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(vasilha, netScene, animDict, "full_cycle_v1_cocbowl", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_aberta, netScene, animDict, "full_cycle_v1_foldedbox", 4.0, -8.0, 1)

            local netScene2 = NetworkCreateSynchronisedScene(x + 3.0 ,y - 0.8, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            NetworkAddEntityToSynchronisedScene(boneco_molde, netScene2, animDict, "full_cycle_v1_dollmould", 4.0, -8.0, 1) --
            NetworkAddEntityToSynchronisedScene(prensa, netScene2, animDict, "full_cycle_v1_cokepress", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(boneco_vazio, netScene2, animDict, "full_cycle_v1_dollcast^3", 4.0, -8.0, 1)
			local netScene3 = NetworkCreateSynchronisedScene(x + 3.0 ,y - 0.8, z - 1.0, targetRotation, 2, false, false, 1148846080, 0, 1.3)

            NetworkAddEntityToSynchronisedScene(boneco_pronto, netScene3, animDict, "full_cycle_v1_cocdoll", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa_fechada, netScene3, animDict, "full_cycle_v1_boxeddoll", 4.0, -8.0, 1)
			
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)
			Citizen.Wait(100)
			NetworkStartSynchronisedScene(netScene2)
			Citizen.Wait(100)
            NetworkStartSynchronisedScene(netScene3)

			Citizen.Wait(GetAnimDuration(animDict, "full_cycle_v1_pressoperator") * 780) 

			NetworkStopSynchronisedScene(netScene)
			NetworkStopSynchronisedScene(netScene2)
			NetworkStopSynchronisedScene(netScene3)

			TriggerEvent('Notify', 'verde', 'Você embalou a cocaína.', 5000)

			DeleteObject(prensa)
            DeleteObject(caixa_aberta)
            DeleteObject(boneco_molde)
            DeleteObject(boneco_vazio)
            DeleteObject(boneco_pronto)
			DeleteObject(caixa_fechada)
			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break
		end
	end)
end

function despejando()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local animDict = "anim@amb@business@coc@coc_unpack_cut@"
    
			RequestAnimDict(animDict)
			RequestModel("bkr_prop_coke_box_01a")
			RequestModel("bkr_prop_coke_fullmetalbowl_02")
			RequestModel("bkr_prop_coke_fullscoop_01a")


			while not HasAnimDictLoaded(animDict) and
				not HasModelLoaded("bkr_prop_coke_box_01a") and 
				not HasModelLoaded("bkr_prop_coke_fullmetalbowl_02") and 
				not HasModelLoaded("bkr_prop_coke_fullscoop_01a") do
				Citizen.Wait(100)
			end

			vasilha = CreateObject(GetHashKey('bkr_prop_coke_fullmetalbowl_02'), x, y, z, 1, 0, 1)
			pazinha = CreateObject(GetHashKey('bkr_prop_coke_fullscoop_01a'), x, y, z, 1, 0, 1) 
			caixa = CreateObject(GetHashKey('bkr_prop_coke_box_01a'), x, y, z, 1, 0, 1)

			local  targetRotation = vec3(180.0, 180.0, 240.5)
			local x,y,z = table.unpack(vec3(1977.71,-2607.23,3.56)) 


			local netScene = NetworkCreateSynchronisedScene(x + 0.5 ,y - 0.2, z - 0.60, targetRotation, 2, false, false, 1148846080, 0, 1.3)
			NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "fullcut_cycle_v1_cokepacker", 1.5, -4.0, 1, 16, 1148846080, 0)
			NetworkAddEntityToSynchronisedScene(vasilha, netScene, animDict, "fullcut_cycle_v1_cokebowl", 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(caixa, netScene, animDict, 'fullcut_cycle_v1_cokebox', 4.0, -8.0, 1)
			NetworkAddEntityToSynchronisedScene(pazinha, netScene, animDict, 'fullcut_cycle_v1_cokescoop', 4.0, -8.0, 1)
			
			Citizen.Wait(150)
			NetworkStartSynchronisedScene(netScene)

			SetEntityVisible(pazinha, false, 0)
			Citizen.Wait(GetAnimDuration(animDict, "fullcut_cycle_v1_cokepacker") * 450)
			SetEntityVisible(pazinha, true, 0)

			Citizen.Wait(GetAnimDuration(animDict, "fullcut_cycle_v1_cokepacker") * 65)
			SetEntityVisible(caixa, false, 0)
			
			Citizen.Wait(GetAnimDuration(animDict, "fullcut_cycle_v1_cokepacker") * 245)

			TriggerEvent('Notify', 'verde', 'Você colocou a cocaína na vasilha.', 5000)

			DeleteObject(caixa)
			DeleteObject(pazinha)
			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break
		end
		return true
	end)
end

function espalhando()
	Citizen.CreateThread(function() 
		while true do
			Citizen.Wait(10) 
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local animDict = "anim@amb@business@coc@coc_unpack_cut_left@"
    
            RequestAnimDict(animDict)
            RequestModel("bkr_prop_coke_box_01a")
            RequestModel("prop_cs_credit_card")
            RequestModel("bkr_prop_coke_bakingsoda_o")
    
            while not HasAnimDictLoaded(animDict) and
                not HasModelLoaded("bkr_prop_coke_bakingsoda_o") and 
                not HasModelLoaded("prop_cs_credit_card") do 
                Citizen.Wait(100)
            end

            cartao = CreateObject(GetHashKey('prop_cs_credit_card'), x, y, z, 1, 0, 1)
            cartao_2 = CreateObject(GetHashKey('prop_cs_credit_card'), x, y, z, 1, 0, 1)
            soda = CreateObject(GetHashKey('bkr_prop_coke_bakingsoda_o'), x, y, z, 1, 0, 1)

            local  targetRotation = vec3(180.0, 180.0, 135.5)
            local x,y,z = table.unpack(vec3(1979.11,-2609.97,3.56))  


            local netScene = NetworkCreateSynchronisedScene(x - 0.7 ,y - 1.8, z - 0.65, targetRotation, 2, false, false, 1148846080, 0, 1.3)
            NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "coke_cut_coccutter", 1.5, -4.0, 1, 16, 1148846080, 0)
            NetworkAddEntityToSynchronisedScene(cartao, netScene, animDict, "coke_cut_creditcard", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(cartao_2, netScene, animDict, "coke_cut_creditcard^1", 4.0, -8.0, 1)
            NetworkAddEntityToSynchronisedScene(soda, netScene, animDict, "cut_cough_v1_bakingsoda", 4.0, -8.0, 1) 

            NetworkStartSynchronisedScene(netScene)


			Citizen.Wait(GetAnimDuration(animDict, "coke_cut_coccutter") * 770)
			
			TriggerEvent('Notify', 'verde', 'Você espalhou a cocaína na mesa.', 5000)

            DeleteObject(cartao)
            DeleteObject(cartao2)
			DeleteObject(soda)
			processo = false
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Cancel"] = false
			break
		end
		return true
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
--[ THREADS ]
-----------------------------------------------------------------------------------------------------------------------------------------

local perm = {}
local servico = false
local item = nil
local selecionado = 0

-- [ MARKERS ] --
CreateThread(function()
	repeat
		local idle = 2000
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for k,v in pairs(config.blipCoords) do
			if perm[k] then
				if not IsPedInAnyVehicle(ped, true) then
					if not servico then
						local distance = #(pedCoords - v['coords'])
						if distance <= 50 then
							idle = 1000
							if distance <= 30 then
								idle = 500
								if distance <= 7 then
									idle = 1
									DrawMarker(20, v['coords'].x, v['coords'].y, v['coords'].z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, true, 2, false)
									DrawMarker(27, v['coords'].x, v['coords'].y, v['coords'].z-1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 255, 0, 0, 255, false, false, 2, true)
									if distance < 1.2 then
										DrawText3D(v['coords'].x,v['coords'].y,v['coords'].z-0.25, "[~r~E~w~] PARA ~r~INICIAR~w~ A ROTA")
										if IsControlJustPressed(0,38) then
											servico = true
											item = k
											PrimeiraRota()
											TriggerEvent("Notify",source,"verde","Você iniciou a rota.",5000)
										end
									end
								end
							end
						end
					end
				end
			end
		end

	Wait(idle)
	until false
end)

-- [ MARKERS SERVICO ] --
CreateThread(function()
	repeat
		local timer = 2000
		if servico then
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			local blipCoords = config.entregaCoords[selecionado]
			local distance = #(pedCoords - blipCoords)

			if distance <= 30 then
				timer = 1000
			end
			if distance < 7 then
				timer = 1
				DrawMarker(21, blipCoords.x, blipCoords.y, blipCoords.z-0.65, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 0, 0, 255, false, true, 2, false)
				if distance < 1.2 then
					DrawText3D(blipCoords.x, blipCoords.y, blipCoords.z-0.25, "[~r~E~w~] PARA ~r~COLETAR~w~ AS PEÇAS")
					if IsControlJustPressed(0,38) then
						RemoveBlip(blips)
						local bool = farms.awardEntrega(item)
						if bool then
							vRP._playAnim(false,{"anim@heists@ornate_bank@grab_cash_heels","grab"},true)
							ProximaRota()
							SetTimeout(config.segundos*1000, function()
								vRP._stopAnim()
							end)
						end
					end
				end
			end
		end
	Wait(timer)
	until false
end)

-- [ PERM CHECK ] --
CreateThread(function()
	repeat
		local sleep = 5000
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for k,v in pairs(config.blipCoords) do
			local distance = #(pedCoords - v['coords'])
			if distance <= 50 and distance > 14 then
				perm[k] = false
				sleep = 1000
			end
			if distance <= 14 then
				if farms.checkPerm(v['perm']) then
					perm[k] = true
				else
					perm[k] = false
				end
			end
		end
	Wait(sleep)
	until false
end)

-- [ SAIR SERVIÇO ] --
CreateThread(function()
	repeat
		local idle = 300
		if servico then
			idle = 1
			if IsControlJustPressed(0,168) then
				servico = false
				item = nil
				selecionado = 0
				RemoveBlip(blips)
				TriggerEvent("Notify",source,"vermelho","Você finalizou a rota.",5000)
			end
		end
	Wait(idle)
	until false
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNCTIONS ]
-----------------------------------------------------------------------------------------------------------------------------------------

PrimeiraRota = function()
	if servico then
		selecionado = selecionado + 1
		if (config.entregaCoords[selecionado]) then
			CriandoBlip(config.entregaCoords,selecionado)
		else
			CriandoBlip(config.entregaCoords,1)
		end
	end
end

ProximaRota = function()
	if servico then
		if selecionado < #config.entregaCoords then
			selecionado = selecionado + 1
			if (config.entregaCoords[selecionado]) then
				CriandoBlip(config.entregaCoords,selecionado)
			else
				CriandoBlip(config.entregaCoords,1)
			end
		else
			PrimeiraRota()
		end
	end
end

DrawText3D = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
	local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 50)
end

CriandoBlip = function(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar PEÇAS DE FABRICAÇÃO")
	EndTextCommandSetBlipName(blips)
end
