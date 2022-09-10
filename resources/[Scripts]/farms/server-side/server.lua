local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("farms",func)

vTASKBAR = Tunnel.getInterface("taskbar")

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	
	--return true
	local taskResult = vTASKBAR.genericTask(source)
	if taskResult and vRP.hasPermission(user_id,perm) then
		return true
	else
		return false
	end
end

local src = {
	[1] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "weed", ['itemqtd'] = 1 },
	[2] = { ['re'] = "weed", ['reqtd'] = 10, ['item'] = "weed", ['itemqtd'] = 10 },
	[3] = { ['re'] = "fertilizante", ['reqtd'] = 10, ['item'] = "maconha", ['itemqtd'] = 20 },
}

function func.checkPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src[id].re ~= nil then
			if vRP.inventoryWeight(user_id)+itemWeight(src[id].item)*src[id].itemqtd <= vRP.getBackpack(user_id) then
				if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,true)
					return true
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)			
			end
		else
			if vRP.inventoryWeight(user_id)+itemWeight(src[id].item)*src[id].itemqtd <= vRP.getBackpack(user_id) then
				vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,true)
				return true
			else
				TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)			
			end
		end
	end
end

local amount = {}

func.checkPerm = function(perm)
    local user_id = vRP.getUserId(source)
    return vRP.hasPermission(user_id,perm)
end

func.awardEntrega = function(item)
    local user_id = vRP.getUserId(source)
    local livre = vRP.getBackpack(user_id) - vRP.computeInvWeight(user_id)
    local pesoItem = 0
    for k,v in pairs(config.blipItem[item]) do
        if #v == 2 then
            amount[k] = math.random(v[1],v[2])
            local peso = vRP.itemWeightList(k)*amount[k]
            pesoItem = pesoItem + peso
        elseif #v == 1 then
            amount[k] = v[1]
            local peso = vRP.itemWeightList(k)*amount[k]
            pesoItem = pesoItem + peso
        else
            print('ERRO: VOCÊ COLOCOU A QUANTIDADE DO ITEM: ['..k..'] DE FORMA ERRADA, COLOQUE 2 NÚMEROS PARA SER UM VALOR RANDOM ENTRE ELES, OU UM NÚMERO PARA SER UM VALOR FIXO')
        end
    end
    if livre - pesoItem < 0 then
        TriggerClientEvent("Notify",source,"vermelho","Espaço insuficiente.",5000)
        return false
    else
        SetTimeout(config.segundos*1000, function()
            for k,v in pairs(config.blipItem[item]) do
                vRP.giveInventoryItem(user_id,k,amount[k])
                amount[k] = nil
            end
        end)
        return true
    end
end
