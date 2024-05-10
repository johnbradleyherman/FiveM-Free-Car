ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('free_car', function() 
    lib.registerContext({
      id = 'free_car',
      title = 'Free Car',
      options = {
          {
            title = 'Claim your free car',
            description = 'Welcome to our server!',
            icon = 'car',
            event = "claimVehicle"
          }
      },
  })
    lib.showContext('free_car') 
end)

-- Event handler for spawning the claimed vehicle
RegisterNetEvent("aintjb_freecar:client:spawnClaimedVehicle")
AddEventHandler("aintjb_freecar:client:spawnClaimedVehicle", function()
    local plyPed = GetPlayerPed(-1)

    -- Check if the spawn point is clear before spawning the vehicle
    if not ESX.Game.IsSpawnPointClear(Config.Locations["SpawnCoords"], 5) then 
        ESX.ShowNotification("Spawn point is not clear!")
        return
    end

    -- Load the vehicle model and spawn the vehicle
    LoadVehicleModel(Config.Vehicle["model"])

     ESX.Game.SpawnVehicle(Config.Vehicle["model"], Config.Locations["SpawnCoords"], Config.Locations["SpawnCoords"].w, function(spawnedVehicle) 
            if DoesEntityExist(spawnedVehicle) then
            local plate = exports['esx_vehicleshop']:GeneratePlate()

            SetVehicleNumberPlateText(spawnedVehicle, plate)
            TaskWarpPedIntoVehicle(PlayerPedId(), spawnedVehicle, -1)

            local vehicleProps = ESX.Game.GetVehicleProperties(spawnedVehicle)
            TriggerServerEvent("aintjb_freecar:server:SetOwnedVehicle", plate, vehicleProps)
        end
    end)
end)

-- Function to load the vehicle model
function LoadVehicleModel(vehicleModel)
    vehicleModel = GetHashKey(vehicleModel)

    if not HasModelLoaded(vehicleModel) then
        RequestModel(vehicleModel)

        BeginTextCommandBusyspinnerOn('STRING')
        AddTextComponentSubstringPlayerName('Vehicle model is loading')
        EndTextCommandBusyspinnerOn(4)

        while not HasModelLoaded(vehicleModel) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end

        BusyspinnerOff()
    end
end

RegisterNetEvent('claimVehicle', function() 
    TriggerServerEvent("aintjb_freecar:server:claimVehicle")
end)

exports.ox_target:addBoxZone({
    coords = vec3(-38.571, -1116.474, 26.432),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = false, 
    options = {
        {   
            name = "FreeCar",
            event = "free_car",
            icon = "fa-solid fa-car",
            label = "Claim your Free Car",
            distance = 2
        }
    }
})
