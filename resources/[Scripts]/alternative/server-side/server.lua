local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")

cRP = {}
Tunnel.bindInterface("alternative", cRP)
vCLIENT = Tunnel.getInterface("alternative")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DevTools
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local webhook = "https://discord.com/api/webhooks/948073375459315753/YP64BfhFUhbR4FEoSiOgHHqIji32e5zSx2ezlNgkS0z0johAd-CX5ODwpG_zP9fKRV2E"
function cRP.Punicao()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        --vRP.kick(source,'Você foi expulso por estar utilizando o Dev Tools, não abra isso!')
        SendWebhookMessage(webhook,"```ini\n[ID]: "..user_id.." \n[MOTIVO: ACESSANDO O DEVTOOLS] \n"..os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S  \r```"))
    end
end

local webhookexit = "https://discord.com/api/webhooks/957145263447879710/_fJkL2tt2bbe4E5QhxUMs-vauPtVCCD_rxgC7EptdW10UikowVgkT97B-9rlfccKG8Xa"


-----------------------------------------------------------------------------------------------------------------------------------------
-- COMBAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("combat", function(source, args, rawcmd)
    TriggerClientEvent("pixel_antiCL:show", source)
end)

RegisterCommand ("carregar", function (source)
	local otherPlayer = vRPC.nearestPlayer(source,2)
	if otherPlayer then
		TriggerClientEvent("player:toggleCarregar",source,otherPlayer)
	end
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerClientEvent("pixel_anticl", -1, id, crds, user_id, reason)
        SendWebhookMessage(webhookexit,"```[ID]: "..user_id.." \n[IP]: "..GetPlayerEndpoint(source).." \n[=========SAIU DO SERVIDOR=========]\nREASON: "..reason.."\n"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startCarry(target,animationLib,animationLib2,animation,animation2,distans,distans2,height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	local source = source
	vCLIENT.syncTarget(targetSrc,source,animationLib2,animation2,distans,distans2,height,length,spin,controlFlagTarget,animFlagTarget)
	vCLIENT.syncSource(source,animationLib,animation,length,controlFlagSrc,animFlagTarget)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stopCarry(targetSrc)
	vCLIENT.stopCarry(targetSrc)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookids = "https://discord.com/api/webhooks/957145930266730507/H4VbHC3oPHXO-HsAFnn5IYdlmj1NsMZvPk8Z4G8NIZUA9Vp6v6S0Su6DMVO4I0aMn6FE"
-----------------------------------------------------------------------------------------------------------------------------------------
-- USER ADMIN PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------	
function cRP.isAdmin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,"Moderator") or vRP.hasPermission(user_id,"Admin")
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET USER ID AND STEAMHEX
-----------------------------------------------------------------------------------------------------------------------------------------	
function cRP.getId(sourceplayer)
	if sourceplayer ~= nil and sourceplayer ~= 0 then
		local user_id = vRP.getUserId(sourceplayer)
		if user_id then
			local userIdentity = vRP.getUserIdentity(user_id)
			return user_id, userIdentity
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORT LOG WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.reportLog(toggle)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.createWeebHook(webhookids,"```prolog\n[ID]: "..user_id.." \n[STATUS]: ".. toggle ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end