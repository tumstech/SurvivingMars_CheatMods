function ChoGGi.ShuttleCapacitySet(Bool)
  for _,object in ipairs(UICity.labels.CargoShuttle or empty_table) do
    if Bool then
      object.max_shared_storage = object.max_shared_storage  + (256 * ChoGGi.Consts.ResourceScale)
      ChoGGi.CheatMenuSettings.ShuttleStorage = object.max_shared_storage
    else
      object.max_speed = object.base_max_shared_storage
    end
  end

  if not Bool then
    ChoGGi.CheatMenuSettings.ShuttleStorage = false
  end
  ChoGGi.WriteSettings()

  ChoGGi.MsgPopup(SelectedObj.encyclopedia_id .. ": Storage is now " .. ChoGGi.CheatMenuSettings.ShuttleStorage or "default",
    "Drones","UI/Icons/IPButtons/drone.tga"
  )

end

function ChoGGi.ShuttleSpeedSet(Bool)
--base_max_speed
  for _,object in ipairs(UICity.labels.CargoShuttle or empty_table) do
    if Bool then
      object.max_speed = object.max_speed + 5000
      ChoGGi.CheatMenuSettings.ShuttleSpeed = object.max_shared_storage
    else
      object.max_speed = object.base_max_speed
    end
  end
  if not Bool then
    ChoGGi.CheatMenuSettings.ShuttleSpeed = false
  end
  ChoGGi.WriteSettings()

  ChoGGi.MsgPopup(SelectedObj.encyclopedia_id .. ": Speed is now " .. ChoGGi.CheatMenuSettings.ShuttleSpeed or "default",
    "Drones","UI/Icons/IPButtons/drone.tga"
  )
end

function ChoGGi.ShuttleHubCapacitySet(Bool)
  if not SelectedObj and not SelectedObj.base_max_shuttles or not UICity.labels.BuildingNoDomes then
    ChoGGi.MsgPopup("You need to select something that has shuttles.",
      "Drones","UI/Icons/IPButtons/drone.tga"
    )
    return
  end
  for _,building in ipairs(UICity.labels.BuildingNoDomes or empty_table) do
    --if IsKindOf(building,SelectedObj.encyclopedia_id) then
    if building.encyclopedia_id == SelectedObj.encyclopedia_id then
      if Bool == true then
        building.max_shuttles = building.max_shuttles + ChoGGi.Consts.ShuttleAddAmount
      else
        building.max_shuttles = nil
      end
      if building.max_shuttles ~= building.base_max_shuttles then
        ChoGGi.CheatMenuSettings.BuildingsCapacity[SelectedObj.encyclopedia_id] = building.max_shuttles
      elseif building.max_shuttles == building.base_max_shuttles then
        ChoGGi.CheatMenuSettings.BuildingsCapacity[SelectedObj.encyclopedia_id] = nil
      end
    end
  end
  ChoGGi.WriteSettings()

  ChoGGi.MsgPopup(SelectedObj.encyclopedia_id .. ": Capacity is now " .. ChoGGi.CheatMenuSettings.BuildingsCapacity[SelectedObj.encyclopedia_id] or "default",
    "Drones","UI/Icons/IPButtons/drone.tga"
  )
end

function ChoGGi.CameraFree_Toggle()
  if not mapdata.GameLogic then
    return
  end
  if cameraFly.IsActive() then
    SetMouseDeltaMode(false)
    ShowMouseCursor("InGameCursor")
    cameraRTS.Activate(1)
    print("Camera RTS")
  else
    cameraFly.Activate(1)
    HideMouseCursor("InGameCursor")
    SetMouseDeltaMode(true)
    print("Camera Fly")
  end
  --resets zoom so...
  ChoGGi.SetCameraSettings()
end

function ChoGGi.CameraFollow_Toggle()
  --it was on the free camera so
  if not mapdata.GameLogic then
    return
  end
  --turn it off
  if camera3p.IsActive() then
    engineShowMouseCursor()
    SetMouseDeltaMode(false)
    ShowMouseCursor("InGameCursor")
    cameraRTS.Activate(1)
    return
  --crashes if we attach to false
  elseif not SelectedObj then
    return
  end
  --we only want to follow one object
  if ChoGGi.LastFollowedObject then
    camera3p.DetachObject(ChoGGi.LastFollowedObject)
  end
  --save for DetachObject
  ChoGGi.LastFollowedObject = SelectedObj

  camera3p.Activate(1)
  camera3p.AttachObject(SelectedObj)
  --camera3p.SetZoom(10) --default 100
  --if SelectedObj:GetSpecialization() --human
  camera3p.SetLookAtOffset(point(0,0,-1500))
  camera3p.SetEyeOffset(point(0,0,-1000))
  camera3p.EnableMouseControl(true)
  camera3p.EnableMouseControl(true)
  print("Camera Follow")
end

function ChoGGi.CameraCursor_Toggle()
  if IsMouseCursorHidden() then
    engineShowMouseCursor()
    SetMouseDeltaMode(false)
    ShowMouseCursor("InGameCursor")
  else
    engineHideMouseCursor()
    HideMouseCursor("InGameCursor")
    SetMouseDeltaMode(true)
  end
end

function ChoGGi.InfopanelCheats_Toggle()
  config.BuildingInfopanelCheats = not config.BuildingInfopanelCheats
  ReopenSelectionXInfopanel()
  ChoGGi.CheatMenuSettings.ToggleInfopanelCheats = config.BuildingInfopanelCheats
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(tostring(ChoGGi.CheatMenuSettings.ToggleInfopanelCheats) .. ": HAXOR",
   "Cheats","UI/Icons/Anomaly_Tech.tga"
  )
end

function ChoGGi.BorderScrolling_Toggle()
  ChoGGi.CheatMenuSettings.BorderScrollingToggle = not ChoGGi.CheatMenuSettings.BorderScrollingToggle
  if ChoGGi.CheatMenuSettings.BorderScrollingToggle then
    cameraRTS.SetProperties(1,{ScrollBorder = 0})
  else
    cameraRTS.SetProperties(1,{ScrollBorder = 2})
  end
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(tostring(ChoGGi.CheatMenuSettings.BorderScrollingToggle) .. ": Mouse Border Scrolling",
   "BorderScrolling","UI/Icons/IPButtons/status_effects.tga"
  )
end

function ChoGGi.CameraZoom_Toggle()
  ChoGGi.CheatMenuSettings.CameraZoomToggle = not ChoGGi.CheatMenuSettings.CameraZoomToggle
  if ChoGGi.CheatMenuSettings.CameraZoomToggle then
    cameraRTS.SetZoomLimits(0,24000)
  else
    cameraRTS.SetZoomLimits(400,8000)
  end
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(tostring(ChoGGi.CheatMenuSettings.CameraZoomToggle) .. ": Camera Zoom",
   "Camera","UI/Icons/IPButtons/status_effects.tga"
  )
end

function ChoGGi.PipesPillarsSpacing_Toggle()
  if Consts.PipesPillarSpacing == 1000 then
    Consts.PipesPillarSpacing = ChoGGi.Consts.PipesPillarSpacing
  else
    Consts.PipesPillarSpacing = 1000
  end
  ChoGGi.CheatMenuSettings.PipesPillarSpacing = Consts.PipesPillarSpacing
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(tostring(ChoGGi.CheatMenuSettings.PipesPillarSpacing) .. ": Is that a rocket in your pocket?",
   "Buildings","UI/Icons/Sections/spaceship.tga"
  )
end

function ChoGGi.ShowAllTraits_Toggle()
  ChoGGi.CheatMenuSettings.ShowAllTraits = not ChoGGi.CheatMenuSettings.ShowAllTraits
  if ChoGGi.CheatMenuSettings.ShowAllTraits then
    g_SchoolTraits = ChoGGi.PositiveTraits
    g_SanatoriumTraits = ChoGGi.NegativeTraits
  else
    g_SchoolTraits = {"Nerd","Composed","Enthusiast","Religious","Survivor"}
    g_SanatoriumTraits = {"Alcoholic","Gambler","Glutton","Lazy","ChronicCondition","Melancholic","Coward"}
  end
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(tostring(ChoGGi.CheatMenuSettings.ShowAllTraits) .. ": Good for what ails you",
   "Traits","UI/Icons/Upgrades/factory_ai_04.tga"
  )
end

function ChoGGi.ResearchQueueLarger_Toggle()
  if const.ResearchQueueSize == 25 then
    const.ResearchQueueSize = ChoGGi.Consts.ResearchQueueSize
  else
    const.ResearchQueueSize = 25
  end
  ChoGGi.CheatMenuSettings.ResearchQueueSize = const.ResearchQueueSize
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.ResearchQueueSize .. ": Nerdgasm",
   "Research","UI/Icons/Notifications/research.tga"
  )
end

function ChoGGi.ScannerQueueLarger_Toggle()
  if const.ExplorationQueueMaxSize == 100 then
    const.ExplorationQueueMaxSize = ChoGGi.Consts.ExplorationQueueMaxSize
  else
    const.ExplorationQueueMaxSize = 100
  end
  ChoGGi.CheatMenuSettings.ExplorationQueueMaxSize = const.ExplorationQueueMaxSize
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.ExplorationQueueMaxSize .. ": scans at a time.",
   "Scanner","UI/Icons/Notifications/scan.tga"
  )
end

function ChoGGi.MeteorHealthDamage_Toggle()
  Consts.MeteorHealthDamage = ChoGGi.NumRetBool(Consts.MeteorHealthDamage,0,ChoGGi.Consts.MeteorHealthDamage)
  ChoGGi.CheatMenuSettings.MeteorHealthDamage = Consts.MeteorHealthDamage
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.MeteorHealthDamage .. ": Damage? Total, sir. It's what we call a global killer. The end of mankind. Doesn't matter where it hits. Nothing would survive, not even bacteria.",
   "Colonists","UI/Icons/Notifications/meteor_storm.tga"
  )
end

function ChoGGi.RocketCargoCapacity_Toggle()
  if Consts.CargoCapacity == 1000000000 then
    Consts.CargoCapacity = ChoGGi.CargoCapacity()
  else
    Consts.CargoCapacity = 1000000000
  end
  ChoGGi.CheatMenuSettings.CargoCapacity = Consts.CargoCapacity
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.CargoCapacity .. ": I can still see some space",
   "Rocket","UI/Icons/Sections/spaceship.tga"
  )
end

function ChoGGi.RocketTravelInstant_Toggle()
  Consts.TravelTimeEarthMars = ChoGGi.NumRetBool(Consts.TravelTimeEarthMars,0,ChoGGi.Consts.TravelTimeEarthMars)
  Consts.TravelTimeMarsEarth = ChoGGi.NumRetBool(Consts.TravelTimeMarsEarth,0,ChoGGi.Consts.TravelTimeMarsEarth)
  ChoGGi.CheatMenuSettings.TravelTimeEarthMars = Consts.TravelTimeEarthMars
  ChoGGi.CheatMenuSettings.TravelTimeMarsEarth = Consts.TravelTimeMarsEarth
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.TravelTimeEarthMars / ChoGGi.Consts.ResourceScale .. "or 88 MPH",
   "Rocket","UI/Upgrades/autoregulator_04/timer.tga"
  )
end

--SetTimeFactor(1000) = normal speed
function ChoGGi.SetGameSpeed(Speed)
  if Speed == 1 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed
  elseif Speed == 2 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 2
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 2
  elseif Speed == 3 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 3
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 3
  elseif Speed == 4 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 4
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 4
  elseif Speed == 5 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 8
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 8
  elseif Speed == 6 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 16
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 16
  elseif Speed == 7 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 32
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 32
  elseif Speed == 8 then
    const.mediumGameSpeed = ChoGGi.Consts.mediumGameSpeed * 64
    const.fastGameSpeed = ChoGGi.Consts.fastGameSpeed * 64
  end
  --so it changes the speed
  ChangeGameSpeedState(-1)
  ChangeGameSpeedState(1)
  ChoGGi.CheatMenuSettings.mediumGameSpeed = const.mediumGameSpeed
  ChoGGi.CheatMenuSettings.fastGameSpeed = const.fastGameSpeed
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.mediumGameSpeed .. ": I think I can",
   "Speed","UI/Icons/Notifications/timer.tga"
  )
end

function ChoGGi.ColonistsPerRocket(Bool)
  if Bool == true then
    Consts.MaxColonistsPerRocket = Consts.MaxColonistsPerRocket + 25
  else
    Consts.MaxColonistsPerRocket = ChoGGi.MaxColonistsPerRocket()
  end
  ChoGGi.CheatMenuSettings.MaxColonistsPerRocket = Consts.MaxColonistsPerRocket
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.MaxColonistsPerRocket .. ": Long pig sardines",
   "Rocket","UI/Icons/Notifications/colonist.tga"
  )
end

--TESTING
--TESTING
--TESTING
--TESTING
--TESTING
function ChoGGi.RCRoverRadius(Bool)
  for _,rcvehicle in ipairs(UICity.labels.RCRover or empty_table) do
    local prop_meta = rcvehicle:GetPropertyMetadata("UIWorkRadius")
    if prop_meta then
      if Bool == true then
        local radius = rcvehicle:GetProperty(prop_meta.id)
        rcvehicle:SetProperty(prop_meta.id, Max(prop_meta.max, radius + 25))
      else
        rcvehicle:SetProperty(prop_meta.id, Max(prop_meta.max,ChoGGi.Consts.RCRoverMaxRadius))
      end
    end
  end
  ChoGGi.MsgPopup("+25 I can see for miles and miles",
   "RC","UI/Icons/Upgrades/service_bots_04.tga"
  )
end

function ChoGGi.CommandCenterRadius(Bool)
  local buildings = UICity.labels.BuildingNoDomes
  for _,building in ipairs(buildings) do
    if IsKindOf(building,"DroneHub") then
      local prop_meta = building:GetPropertyMetadata("UIWorkRadius")
      if prop_meta then
        if Bool == true then
          const.CommandCenterDefaultRadius = const.CommandCenterDefaultRadius + 25
          const.CommandCenterMaxRadius = const.CommandCenterMaxRadius + 25
          const.CommandCenterMinRadius = const.CommandCenterMinRadius + 25
          local radius = building:GetProperty(prop_meta.id)
          building:SetProperty(prop_meta.id, Max(prop_meta.max, radius + 25))
          building:SetProperty(prop_meta.id, Default(prop_meta.default, radius + 25))
          building:SetProperty(prop_meta.id, Min(prop_meta.min, radius + 25))
        else
          const.CommandCenterDefaultRadius = ChoGGi.Consts.CommandCenterDefaultRadius
          const.CommandCenterMaxRadius = ChoGGi.Consts.CommandCenterMaxRadius
          const.CommandCenterMinRadius = ChoGGi.Consts.CommandCenterMinRadius
          building:SetProperty(prop_meta.id, Default(prop_meta.default, const.CommandCenterDefaultRadius))
          building:SetProperty(prop_meta.id, Max(prop_meta.max, const.CommandCenterMaxRadius))
          building:SetProperty(prop_meta.id, Min(prop_meta.min, const.CommandCenterMinRadius))
        end
      end
    end
  end
  ChoGGi.MsgPopup("I see you there",
   "Buildings","UI/Icons/Upgrades/polymer_blades_04.tga"
  )
end

function ChoGGi.TriboelectricScrubberRadius(Bool)
  local buildings = UICity.labels.BuildingNoDomes
  for _,building in ipairs(buildings) do
    if IsKindOf(building,"TriboelectricScrubber") then
      local prop_meta = building:GetPropertyMetadata("UIRange")
      if prop_meta then
        if Bool == true then
          local radius = building:GetProperty(prop_meta.id)
          building:SetProperty(prop_meta.id, Max(prop_meta.max, radius + 25))
        else
          building:SetProperty(prop_meta.id, Max(prop_meta.max,5)) --figure out default const to put here
        end
      end
    end
  end
  ChoGGi.MsgPopup("I see you there",
   "Buildings","UI/Icons/Upgrades/polymer_blades_04.tga"
  )
end

if ChoGGi.Testing then
  table.insert(ChoGGi.FilesCount,"MiscFunc")
end
