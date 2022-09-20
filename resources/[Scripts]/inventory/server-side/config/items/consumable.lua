local consumable = {
    ["absolut"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0},
        ["downgradeStress"] = 10,
        ["upgradeThirst"] = 20,
        ["alcohol"] = {
            ["alcoholTimer"] = 1,
            ["drunkTime"] = 90
        }
    },
    ["bandage"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_clipboard@male@idle_a","idle_c","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0},
        ["upgradeStress"] = 2,
        ["updateHealth"] = 15
    },
    ["medkit"] = {
        ["ProgressTimer"] = 20,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_clipboard@male@idle_a","idle_c","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0},
        ["resetBleeding"] = true,
        ["updateHealth"] = 40,
        ["cooldown"] = {
            ["type"] = "health",
            ["delay"] = 60
        }
    },
    ["chandon"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0},
        ["downgradeStress"] = 10,
        ["upgradeThirst"] = 20,
        ["alcohol"] = {
            ["alcoholTimer"] = 1,
            ["drunkTime"] = 300
        }
    },
    ["chocolate"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_inteat@burger","mp_player_int_eat_burger","prop_choc_ego",49,60309},
        ["downgradeStress"] = 10,
        ["upgradeHunger"] = 15,
        ["upgradeThirst"] = 0
    },
    ["coffee"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_aa_coffee@idle_a", "idle_a","p_amb_coffeecup_01",49,28422},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 0,
        ["upgradeThirst"] = 15,
        ["upgradeSpeed"] = {
            ["time"] = 15,
            ["factor"] = 1.15
        }
    },
    ["cola"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_intdrink","loop_bottle","prop_ecola_can",49,60309,0.01,0.01,0.05,0.0,0.0,90.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 0,
        ["upgradeThirst"] = 15
    },
    ["cookie"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,60309},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 35,
        ["upgradeThirst"] = 0
    },
    ["dewars"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_blr",49,28422,0.0,0.0,-0.10,0.0,0.0,0.0},
        ["downgradeStress"] = 10,
        ["upgradeThirst"] = 20,
        ["alcohol"] = {
            ["alcoholTimer"] = 1,
            ["drunkTime"] = 300
        }
    },
    ["donuts"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_amb_donut",49,28422},
        ["downgradeStress"] = 10,
        ["upgradeHunger"] = 10,
        ["upgradeThirst"] = 0
    },
    ["hennessy"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422,0.0,0.0,0.05,0.0,0.0,0.0},
        ["downgradeStress"] = 10,
        ["upgradeThirst"] = 20,
        ["alcohol"] = {
            ["alcoholTimer"] = 1,
            ["drunkTime"] = 300
        }
    },
    ["energetic"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_intdrink","loop_bottle","prop_energy_drink",49,60309,0.0,0.0,0.0,0.0,0.0,130.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 0,
        ["upgradeThirst"] = 0,
        ["upgradeStress"] = 5,
        ["upgradeSpeed"] = {
            ["time"] = 25,
            ["factor"] = 1.15
        }
    },
    ["fries"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_inteat@burger","mp_player_int_eat_burger","prop_food_chips",49,18905,0.10,0.0,0.08,150.0,320.0,160.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 10,
        ["upgradeThirst"] = 0
    },
    ["hamburger"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_inteat@burger","mp_player_int_eat_burger","prop_cs_burger_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 15,
        ["upgradeThirst"] = 0
    },
    ["hotdog"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_hotdog_01",49,28422},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 15,
        ["upgradeThirst"] = 0
    },
    ["ritmoneury"] = {
        ["ProgressTimer"] = 1,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0},
        ["downgradeStress"] = 40,
        ["upgradeHunger"] = 0,
        ["upgradeThirst"] = 5,
        ["chemicalTimer"] = 3
    },
    ["sandwich"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_inteat@burger","mp_player_int_eat_burger","prop_sandwich_01",49,18905,0.13,0.05,0.02,-50.0,16.0,60.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 15,
        ["upgradeThirst"] = 0
    },
    ["sinkalmy"] = {
        ["ProgressTimer"] = 1,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0},
        ["downgradeStress"] = 25,
        ["upgradeHunger"] = 0,
        ["upgradeThirst"] = 5,
        ["chemicalTimer"] = 3
    },
    ["soda"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_intdrink","loop_bottle","ng_proc_sodacan_01b",49,60309,0.0,0.0,-0.04,0.0,0.0,130.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 0,
        ["upgradeThirst"] = 15
    },
    ["tacos"] = {
        ["ProgressTimer"] = 15,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_inteat@burger","mp_player_int_eat_burger","prop_taco_01",49,18905,0.16,0.06,0.02,-50.0,220.0,60.0},
        ["downgradeStress"] = 0,
        ["upgradeHunger"] = 20,
        ["upgradeThirst"] = 0
    },
    ["water"] = {
        ["ProgressTimer"] = 10,
        ["blockButtons"] = true,
        ["animation"] = {"mp_player_intdrink","loop_bottle","vw_prop_casino_water_bottle_01a",49,60309,0.0,0.0,-0.06,0.0,0.0,130.0},
        ["downgradeStress"] = 0,
        ["upgradeThirst"] = 20,
        ["generateItem"] = {
            ["item"] = "emptybottle",
            ["amount"] = 1
        }
    }
}

function useConsumable (source, itemName, slot)
	local user_id = vRP.getUserId(source)
    if (consumable[itemName]) then
        local isCooldown = false
        if consumable[itemName]["cooldown"] then
            local cooldownType = consumable[itemName]["cooldown"]["type"]
            if not (cooldown[cooldownType][user_id] == nil or GetGameTimer() > cooldown[cooldownType][user_id]) then
                isCooldown = true
            end
        end
        if not isCooldown then
            activeItens[user_id] = consumable[itemName]["ProgressTimer"]
            vRPC.stopActived(source)
            TriggerClientEvent("Progress",source,consumable[itemName]["ProgressTimer"]*1000)
            TriggerClientEvent("inventory:Close",source)
            TriggerClientEvent("inventory:blockButtons",source,consumable[itemName]["blockButtons"])
            
            vRPC.createObjects(source, consumable[itemName]["animation"][1], consumable[itemName]["animation"][2],
            consumable[itemName]["animation"][3], consumable[itemName]["animation"][4], consumable[itemName]["animation"][5],
            consumable[itemName]["animation"][6], consumable[itemName]["animation"][7], consumable[itemName]["animation"][8],
            consumable[itemName]["animation"][9], consumable[itemName]["animation"][10], consumable[itemName]["animation"][11])

            repeat
                if activeItens[user_id] == 0 then
                    activeItens[user_id] = nil
                    vRPC.removeObjects(source,"one")
                    TriggerClientEvent("inventory:blockButtons",source,false)

                    if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
                        vRP.upgradeHunger(user_id,consumable[itemName]["upgradeHunger"] or 0)
                        vRP.upgradeThirst(user_id,consumable[itemName]["upgradeThirst"] or 0)
                        vRP.upgradeStress(user_id,consumable[itemName]["upgradeStress"] or 0)
                        vRP.downgradeStress(user_id,consumable[itemName]["downgradeStress"] or 0)
                        vRPC.updateHealth(source, consumable[itemName]["updateHealth"] or 0)
                        vRP.chemicalTimer(user_id,consumable[itemName]["chemicalTimer"] or 0)

                        if consumable[itemName]["cooldown"] then
                            local cooldownType = consumable[itemName]["cooldown"]["type"]
                            cooldown[cooldownType][user_id] = GetGameTimer() + consumable[itemName]["cooldown"]["delay"]*1000
                        end
                        if(consumable[itemName]["alcohol"]) then
                            vRP.alcoholTimer(user_id,consumable[itemName]["alcohol"]["alcoholTimer"])
                            TriggerClientEvent("setDrunkTime",source,consumable[itemName]["alcohol"]["drunkTime"])
                        end
                        if(consumable[itemName]["resetBleeding"]) then
                            TriggerClientEvent("resetBleeding",source)
                        end		
                        if(consumable[itemName]["upgradeSpeed"]) then
                            TriggerClientEvent("setEnergetic",source,consumable[itemName]["upgradeSpeed"]["time"],consumable[itemName]["upgradeSpeed"]["factor"])
                        end
                        if(consumable[itemName]["generateItem"]) then
                            vRP.generateItem(user_id,consumable[itemName]["generateItem"]["item"],consumable[itemName]["generateItem"]["amount"])
                        end
                    end
                end

                Citizen.Wait(500 + consumable[itemName]["ProgressTimer"]*1000)
            until activeItens[user_id] == nil
        else
            local cooldownType = consumable[itemName]["cooldown"]["type"]
            local waitTime = parseInt((cooldown[cooldownType][user_id] - GetGameTimer()) / 1000)
            TriggerClientEvent("Notify",source,"azul","Aguarde <b>"..waitTime.." segundos</b>.",5000)
        end
    end
    return
end