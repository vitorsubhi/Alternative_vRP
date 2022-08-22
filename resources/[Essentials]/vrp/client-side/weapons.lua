local weapon_list = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_types = {
	"WEAPON_KNIFE",
	"WEAPON_HATCHET",
	"WEAPON_BAT",
	"WEAPON_BATTLEAXE",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_DAGGER",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_MACHETE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_SWITCHBLADE",
	"WEAPON_WRENCH",
	"WEAPON_KNUCKLE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_RAYPISTOL",
	"WEAPON_FLAREGUN",
	"WEAPON_COMBATPISTOL",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_RAYCARBINE",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_MILITARYRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_SNOWBALL",
	"WEAPON_PIPEBOMB",
	"WEAPON_BALL",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_FLARE",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG",
	"WEAPON_PETROLCAN",
	"GADGET_PARACHUTE",
	"WEAPON_STUNGUN",
	"WEAPON_FIREEXTINGUISHER"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getWeapons()
	local ped = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped,hash) then
			local weapon = {}
			weapons[v] = weapon
			local atype = GetPedAmmoTypeFromWeapon(ped,hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(ped,hash)
			else
				weapon.ammo = 0
			end
		end
	end
	weapons = tvRP.legalWeaponsChecker(weapons)
	return weapons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPLACEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.replaceWeapons()
	local old_weapons = tvRP.getWeapons()
	RemoveAllPedWeapons(PlayerPedId(),true)
	weapon_list = {}
	return old_weapons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.clearWeapons()
	RemoveAllPedWeapons(PlayerPedId(),true)
	weapon_list = {}
end

function tvRP.legalWeaponsChecker(weapon)
	local weapon = weapon
	local weapons_legal = tvRP.getWeaponsLegal()
	local ilegal = false
	for v, b in pairs(weapon) do
		if not weapon_list[v] then
			ilegal = true
		end
	end
	if ilegal then
	  	tvRP.giveWeapons(weapons_legal, true)
		weapon = weapons_legal
	end
	return weapon
end

function tvRP.getWeaponsLegal()
	return weapon_list
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.giveWeapons(weapons,clear_before)
	local ped = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(ped,true)
		weapon_list = {}
	end

	for k,v in pairs(weapons) do
		GiveWeaponToPed(ped,GetHashKey(k),v.ammo or 0,false)
		weapon_list[string.upper(k)] = {ammo = v.ammo}
	end
end

function tvRP.giveWeapons2(clear_before, weapon, ammo)
    local ped = PlayerPedId()

	if clear_before then
		RemoveAllPedWeapons(ped,true)
		weapon_list = {}
	end

	if weapon then
		GiveWeaponToPed(ped,GetHashKey(weapon),ammo or 0,false)
		weapon_list[string.upper(weapon)] = {ammo = ammo}
	end
end

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if IsPlayerPlaying(PlayerId()) then
			tvRP.getWeapons()
		end
	end
end)]]