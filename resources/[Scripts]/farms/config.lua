local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]----------------------------------------------------------------------------------------------------------------------------

config = {}
Proxy.addInterface("config:farms",config)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ PERSONALIZAÇÃO DAS ROTAS ]
-----------------------------------------------------------------------------------------------------------------------------------------

config.segundos = 5

config.blipCoords = {
    ['Yakuza'] = { ['perm'] = "Yakuza", ['coords'] = vector3(912.02,-3189.17,-17.3) },
	['Cmvermelho'] = { ['perm'] = "Cmvermelho", ['coords'] = vector3(1297.89,-2532.13,46.02) },
	['Elcapone'] = { ['perm'] = "Elcapone", ['coords'] = vector3(1548.81,3795.6,30.47) },
	['Playboy'] = { ['perm'] = "Playboy", ['coords'] = vector3(-1548.57,79.56,53.88) },
	['heroina'] = { ['perm'] = "Heroina", ['coords'] = vector3(3069.98,2961.76,92.6) },
	['lanca'] = { ['perm'] = "Lanca", ['coords'] = vector3(1271.13,-1750.77,45.6) },
	['Anonymous'] = { ['perm'] = "Anonymous", ['coords'] = vector3(3001.02,2683.5,75.49) },
	['lossantos'] = { ['perm'] = "LosSantos", ['coords'] = vector3(-602.03,-922.61,23.89) },
	['lsd'] = { ['perm'] = "Lsd", ['coords'] = vector3(1274.31,-196.88,102.17) },
	['Bratva'] = { ['perm'] = "Bratva", ['coords'] = vector3(1406.16,1107.56,114.83) },
	['IHp'] = { ['perm'] = "Owner", ['coords'] = vector3(2434.31,4964.06,42.35) }
}

config.blipItem = {
	['Yakuza'] = {
		['placametal'] = {4,8},
		['pecadearma'] = {5,9},
		['molas'] = {7,9}
	},
	['Cmvermelho'] = { 
		['capsula'] = {6,9},
		['polvora'] = {6,8}
	},
	['Elcapone'] = { 
		['capsula'] = {6,9},
		['polvora'] = {6,8}
	},
	['Playboy'] = { 
		['copper'] = {6,9},
		['glass'] = {8,9},
		['plastic'] = {6,9},
		['rubber'] = {5,10},
		['aluminum'] = {8,12}
	},
	['Heroina'] = { 
		['papoulas'] = {1,3},
		['opio'] = {1,3}
	},
	['Bratva'] = {
		['placametal'] = {4,8},
		['pecadearma'] = {5,9},
		['molas'] = {7,9}
	},
	['Anonymous'] = { 
		['plastic'] = {3,6},
		['copper'] = {3,6}
	},
	['lossantos'] = { 
		['plastic'] = {3,4},
		['copper'] = {3,4},
		['paper'] = {3,4},
		['rubber'] = {3,4},
		['aluminum'] = {3,4}
	},
	['lsd'] = {
		['acidolisergico'] = {6,8},
		['clavicepspurpurea'] = {6,7},
	},
	['lanca'] = {
		['cloretodeetila'] = {6,8},
		['eter'] = {6,7},
	},
	['IHp'] = {
		['seringa'] = {1,2},
		['etanol'] = {2,4},
		['epinefrina'] = {2,4},
	}
}

config.entregaCoords = {
	vector3(22.22,-1103.51,38.16),
	vector3(809.31,-2222.57,29.65), 
	vector3(857.46,-1038.54,33.14), 
	vector3(-216.53,-1674.28,34.47), 
	vector3(-1314.93,-406.88,36.43), 
	vector3(245.8,-16.81,73.78), 
	vector3(-679.97,-924.24,23.08), 
	vector3(-3179.21,1093.41,20.85), 
	vector3(-342.36,6097.81,31.32),
	vector3(1687.68,3755.8,34.58),
	vector3(2591.68,4669.26,34.08),
	vector3(2531.08,4114.24,38.75),
	vector3(1194.26,2721.53,38.82),
	vector3(569.18,2796.6,42.02),
	vector3(201.57,2462.43,55.9),
	vector3(1243.17,1869.42,78.97),
	vector3(252.41,374.66,105.62),
	vector3(-613.11,323.8,82.27), 
	vector3(-1585.1,-838.48,9.96), 
	vector3(313.41,-174.47,58.12),
	vector3(-13.56,-83.86,56.9),
	vector3(-348.88,-47.22,54.43),
	vector3(-591.43,342.84,85.45),
	vector3(-622.6,304.43,82.25),
	vector3(-809.56,355.49,88.34),
	vector3(-1344.83,-211.84,43.69),
	vector3(-1245.12,-680.52,26.0),
	vector3(-1115.26,-967.16,2.16),
	vector3(-1178.32,-1403.16,4.65),
	vector3(-635.03,-1226.39,11.98),
	vector3(-332.98,98.8,71.22), 
	vector3(-705.81,-1036.31,16.41), 
	vector3(-601.91,-1030.65,22.55), 
	vector3(-1218.87,-1051.64,8.42), 
	vector3(-850.71,-252.02,39.66), 
	vector3(-1613.12,-1028.17,13.16),
	vector3(-1327.1,-189.47,47.89), 
	vector3(-1816.63,-1193.6,14.31), 
	vector3(442.56,-1969.44,24.41), 
	vector3(-1565.66,-231.46,49.47), 
	vector3(-1472.95,-193.1,48.85), 
	vector3(-1546.9,-561.12,33.73), 
	vector3(-1142.79,-1993.39,13.17)
}