local Core = exports[Config.core]:GetCoreObject()


RegisterNetEvent('qb-skydiving:client')
AddEventHandler('qb-skydiving:client', function()
PlayCutscene('hang_int_plane')
Citizen.Wait(3000)
Core.Functions.Progressbar("preparing_parachute", "Preparing The Parachute", 5000, false, true, {
disableMovement = false,
disableCarMovement = false,
disableMouse = false,
disableCombat = true,
}, {}, {}, {}, function() -- Done 
print ("naor best dev")
Core.Functions.Notify(Config.notify, 'success')
TriggerEvent('qb-skydiving:client:UseParachute')
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetEntityCoords(PlayerPedId(), -59.65032, -808.4782, 626.4953, false, false, false, true) 
    SetEntityHeading(PlayerPedId(), 322.00183)

    Citizen.Wait(500)

    DoScreenFadeIn(1000) 
end)
end)

RegisterNetEvent('qb-skydiving:client2')
AddEventHandler('qb-skydiving:client2', function()
PlayCutscene('hang_int_plane')
Citizen.Wait(3000)
Core.Functions.Progressbar("preparing_parachute", "Preparing The Parachute", 5000, false, true, {
disableMovement = false,
disableCarMovement = false,
disableMouse = false,
disableCombat = true,
}, {}, {}, {}, function() -- Done 
Core.Functions.Notify(Config.notify, 'success')
TriggerEvent('qb-skydiving:client:UseParachute')
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetEntityCoords(PlayerPedId(), 454.10586, 5590.7226, 2178.8776, false, false, false, true) 
    SetEntityHeading(PlayerPedId(), 118.58907)

    Citizen.Wait(500)

    DoScreenFadeIn(1000)
end) 
end)

RegisterNetEvent('qb-skydiving:client3')
AddEventHandler('qb-skydiving:client3', function()
PlayCutscene('hang_int_plane')
Citizen.Wait(3000)
Core.Functions.Progressbar("preparing_parachute", "Preparing The Parachute", 5000, false, true, {
disableMovement = false,
disableCarMovement = false,
disableMouse = false,
disableCombat = true,
}, {}, {}, {}, function() -- Done 
print ("naor best dev")
Core.Functions.Notify(Config.notify, 'success')
TriggerEvent('qb-skydiving:client:UseParachute')
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetEntityCoords(PlayerPedId(), 1238.9235, 3084.8178, 1079.3007, false, false, false, true)  
    SetEntityHeading(PlayerPedId(), 91.20951)

    Citizen.Wait(500)

    DoScreenFadeIn(1000)
end) 
end)

CreateThread(function()
	while true do
		Wait(1000)
		for k, v in pairs{{coords = vector4(-703.9741, -1398.096, 5.4952855, 138.78056)}} do
			local pos = GetEntityCoords(PlayerPedId())	
			local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
			
			if dist < 40 and not pedspawned then
				TriggerEvent('qb-skydiving:spawn:ped', v.coords)
				pedspawned = true
                Freeze = true
			end
			if dist >= 35 then
				pedspawned = false
				DeletePed(SkyPed)
			end
		end
	end
end)

RegisterNetEvent('qb-skydiving:spawn:ped')
AddEventHandler('qb-skydiving:spawn:ped',function(coords)
	local hash = `s_m_m_pilot_01`

	RequestModel(hash)
	while not HasModelLoaded(hash) do 
		Wait(10)
	end

        pedspawned = true
        freeze = true
        invincible = true
        blockevents = true
        SkyPed = CreatePed(5, hash, coords.x, coords.y, coords.z - 1.0, coords.w, false, false)
        FreezeEntityPosition(SkyPed, true)
        SetBlockingOfNonTemporaryEvents(SkyPed, true)
        TaskStartScenarioInPlace(SkyPed, "WORLD_HUMAN_STAND_MOBILE_UPRIGHT", 0, true) 
end)

exports[Config.target]:AddTargetModel(`s_m_m_pilot_01`, {
    options = {
        {
            type = "client",
            coords = vector4(-703.9741, -1398.096, 4.4952855, 138.78056),
            event = "qb-menu:client:qb-skydiving",
			icon = Config.icon,
			label = Config.label
        },
    },
    distance = 2.5
})

RegisterNetEvent('qb-skydiving:client:UseParachute', function()
    EquipParachuteAnim()
        local ped = PlayerPedId()
        TriggerEvent("inventory:client:ItemBox", Core.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, `GADGET_PARACHUTE`, 1, false)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 7, texture = 0},  -- Adding Parachute Clothing
            }
        }
        TriggerEvent('raid_clothes:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function GearAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end


Citizen.CreateThread(function()

    for _, info in pairs(Config.BlipLocation) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

RegisterNetEvent("qb-menu:client:qb-skydiving", function()
	exports[Config.menu]:openMenu({
        {
            header = "🪂 Sky Diving 🪂",
			txt = "",
            isMenuHeader = true, 
        },
        {
            header = Config.header,
            txt = "Sky Diving On DownTown",
            params = {
                event = "qb-skydiving:cash2",
            }
        },
        {
            header = Config.header,
            txt = "Sky Diving On Chiliad Mountain",
            params = {
                event = "qb-skydiving:cash3",
            }
        },
        {
            header = Config.header,
            txt = "Sky Diving On Sandy Shores",
            params = {
                event = "qb-skydiving:cash4",
            }
        },
		{
			header = "⬅ Close",
			params = {
				event = "qb-menu:client:closemenu",
			}
		},
    })
end)


RegisterNetEvent("qb-skydiving:cash2", function()
    TriggerServerEvent("qb-skydiving:cash")
end)

RegisterNetEvent("qb-skydiving:cash3", function()
    TriggerServerEvent("qb-skydiving:server:cash2")
end)

RegisterNetEvent("qb-skydiving:cash4", function()
    TriggerServerEvent("qb-skydiving:server:cash3")
end)

function PlayCutscene(cut)
    while not HasThisCutsceneLoaded(cut) do 
        RequestCutscene(cut, 8)
        Wait(0) 
    end
    CreateCutscene()
    RemoveCutscene()
    DoScreenFadeIn(500)
end

function CreateCutscene()
    local ped = PlayerPedId()
    local clone = ClonePedEx(ped, 0.0, false, true, 1)
    local clone2 = ClonePedEx(ped, 0.0, false, true, 1)
    local clone3 = ClonePedEx(ped, 0.0, false, true, 1)
    local clone4 = ClonePedEx(ped, 0.0, false, true, 1)
    local clone5 = ClonePedEx(ped, 0.0, false, true, 1)
    SetBlockingOfNonTemporaryEvents(clone, true)
    SetEntityVisible(clone, false, false)
    SetEntityInvincible(clone, true)
    SetEntityCollision(clone, false, false)
    FreezeEntityPosition(clone, true)
    SetPedHelmet(clone, false)
    RemovePedHelmet(clone, true) 
    SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
    RegisterEntityForCutscene(ped, 'MP_1', 0, GetEntityModel(ped), 64)
    SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
    RegisterEntityForCutscene(clone2, 'MP_2', 0, GetEntityModel(clone2), 64)
    SetCutsceneEntityStreamingFlags('MP_3', 0, 1)
    RegisterEntityForCutscene(clone3, 'MP_3', 0, GetEntityModel(clone3), 64)
    SetCutsceneEntityStreamingFlags('MP_4', 0, 1)
    RegisterEntityForCutscene(clone4, 'MP_4', 0, GetEntityModel(clone4), 64)
    SetCutsceneEntityStreamingFlags('MP_5', 0, 1)
    RegisterEntityForCutscene(clone5, 'MP_5', 0, GetEntityModel(clone5), 64)
    Wait(10)
    StartCutscene(0)
    Wait(10)
    ClonePedToTarget(clone, ped)
    Wait(10)
    DeleteEntity(clone)
    DeleteEntity(clone2)
    DeleteEntity(clone3)
    DeleteEntity(clone4)
    DeleteEntity(clone5)
    Wait(50)
    DoScreenFadeIn(250)
end
