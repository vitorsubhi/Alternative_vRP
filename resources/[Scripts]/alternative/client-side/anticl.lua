local show3DText = false
Config = {}

Config.DrawingTime = 60*1000 --1 MINUT
Config.TextColor = {r=255, g=255,b=255} -- WHITE (Player Data)
Config.AlertTextColor = {r=255, g=0, b=0} -- RED (Player Left Game)

RegisterNetEvent("pixel_antiCL:show")
AddEventHandler("pixel_antiCL:show", function()
    if show3DText then
        show3DText = false
		TriggerEvent("Notify","vermelho","Você desativou o sistema Anti - CL",5000)
    else
        show3DText = true
		TriggerEvent("Notify","verde","Você ativou o sistema Anti - CL",5000)
    end
end)

RegisterNetEvent("pixel_anticl")
AddEventHandler("pixel_anticl", function(id, crds, user_id, reason)
    Display(id, crds, user_id, reason)
end)

function Display(id, crds, user_id, reason)
    local displaying = true

    Citizen.CreateThread(function()
        Wait(Config.DrawingTime)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        while displaying do
            Wait(5)
            local pcoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(crds.x, crds.y, crds.z, pcoords.x, pcoords.y, pcoords.z, true) < 15.0 and show3DText then
                DrawText3D(crds.x, crds.y, crds.z+0.15, "Player saiu do jogo")
                DrawText3D(crds.x, crds.y, crds.z, "ID: "..user_id.." \nMotivo: "..reason)
            else
                Citizen.Wait(2000)
            end
        end
    end)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(Config.TextColor.r, Config.TextColor.g, Config.TextColor.b, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end