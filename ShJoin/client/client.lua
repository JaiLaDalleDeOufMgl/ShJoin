ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local Spawn = true
local PlayerLoaded = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
    Citizen.CreateThread(function()
        while not PlayerLoaded do
            Citizen.Wait(10)
        end
        if Spawn then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if skin == nil then
                else
                    TriggerEvent('skinchanger:loadSkin', skin)
                    Validation()
                end
            end)
            Spawn = false
        end
    end)
end)

RegisterNetEvent('Shaz:GetEntityPosition')
AddEventHandler('Shaz:GetEntityPosition', function(position)
    if position then
        pos = position
    end
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, true)
    Wait(500)
    DisplayRadar(true)
    SetEntityHealth(GetPlayerPed(-1), tonumber(100))
end)

function startAnim(lib, anim)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 10.0, true, false, false)
    end)
end

local Chargement = nil
local Percentage = 0.0

function Validation()
    TriggerServerEvent("Shaz:ApercuLoad")
    FreezeEntityPosition(PlayerPedId(), true)
    SetPlayerInvincible(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), -798.60, 338.74145507812, 157.61976623535, 0.0, 0.0, 0.0, true)
    SetEntityHeading(PlayerPedId(), 89.10)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, -801.42828369141, 338.99714477539, 158.42978149414)
    SetCamRot(cam, 5.0, 0.0, 265.160)
    SetCamFov(cam, 20.0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    DisplayRadar(false)
    startAnim('timetable@ron@ig_3_couch', 'base')
    local CoMenu = RageUI.CreateMenu(" ", "Connexion")
    CoMenu.Closable = false
    ESX.TriggerServerCallback("Shaz:GetInfos", function(Infos)
        Transaction = Infos
    end)
    RageUI.Visible(CoMenu, not RageUI.Visible(CoMenu))
    while CoMenu do
        Wait(0)
        RageUI.IsVisible(CoMenu, function()
            if Transaction then
                for k, v in pairs(Transaction) do
                    RageUI.Separator('~g~Shazuub~b~Land')
                    RageUI.Separator('→→ ~o~Mon Personnage~s~ ←←')
                    RageUI.Separator("Noms et Prénoms : ~y~" .. v.firstname .. ' - ' .. v.lastname)
                    RageUI.Separator("Métier : ~y~" .. ESX.PlayerData.job.label .. " - " .. ESX.PlayerData.job.grade_label)
                end
            end
            RageUI.CenterButton('~r~Se Réveiller', nil, {}, true, {
                onSelected = function()
                    Chargement = true
                end
            })
            if Chargement == true then
                RageUI.PercentagePanel(Percentage or 0.0, "Réveil en cours ... (" .. math.floor(Percentage * 100) .. "%)", "", "", function(Hovered, Active, Percent)
                    if Percentage < 1.0 then
                        Percentage = Percentage + 0.004
                    else
                        DoScreenFadeOut(1000)
                        FreezeEntityPosition(PlayerPedId(), false)
                        SetPlayerInvincible(PlayerPedId(), false)
                        Citizen.Wait(1000)
                        DestroyCam(Camera)
                        ClearFocus()
                        ClearPedTasks(PlayerPedId())
                        Wait(10000)
                        ESX.TriggerServerCallback('Shaz:GetEntityPosition', function()
                        end)
                        RenderScriptCams(0, 0, 3000, 1, 1, 0)
                        Wait(2000)
                        DoScreenFadeIn(2000)
                        Wait(1000)
                        RageUI.CloseAll()
                    end
                end)

            end
        end)
        if not RageUI.Visible(CoMenu) then
            CoMenu = RMenu:DeleteType('CoMenu', true)
        end
    end
end