function ChoGGi.MsgPopup(Msg,Title,Icon)
  pcall(function()
    Msg = Msg or "Empty"
    --returns translated text corresponding to number if we don't do this
    if type(Msg) == "number" then
      Msg = tostring(Msg)
    end
    Title = Title or "Placeholder"
    Icon = Icon or "UI/Icons/Notifications/placeholder.tga"
    if type(AddCustomOnScreenNotification) == "function" then --incase we called it where there ain't no UI
      CreateRealTimeThread(AddCustomOnScreenNotification(
        AsyncRand(),Title,Msg,Icon,nil,{expiration=5000}
      ))
    end
  end)
end

function ChoGGi.QuestionBox(Msg,Function,Title,Ok,Cancel)
  pcall(function()
    Msg = Msg or "Empty"
    Ok = Ok or "Ok"
    Cancel = Cancel or "Cancel"
    Title = Title or "Placeholder"
    Icon = Icon or "UI/Icons/Notifications/placeholder.tga"
    CreateRealTimeThread(function()
      if "ok" == WaitQuestion(nil,
        Title,
        Msg,
        Ok,
        Cancel)
      then
        Function()
      end
    end)
  end)
end

function ChoGGi.AddAction(Menu,Action,Key,Des,Icon,Toolbar,Mode,xInput,ToolbarDefault)
  if Menu then
    Menu = "/" .. tostring(Menu)
  end

--[[
--TEST menu items
  if Menu then
    print(Menu)
  end
  if Action then
    print(Action)
  end
  if Key then
    print(Key)
  end
  if Des then
    print(Des)
  end
  if Icon then
    print(Icon)
  end
print("\n")
--]]

  --_InternalTranslate(T({Number from Game.csv}))
  --UserActions.AddActions({
  --UserActions.RejectedActions()
  ChoGGi.UserAddActions({
    ["ChoGGi_" .. AsyncRand()] = {
      menu = Menu,
      action = Action,
      key = Key,
      description = Des or "",
      icon = Icon,
      toolbar = Toolbar,
      mode = Mode,
      xinput = xInput,
      toolbar_default = ToolbarDefault
    }
  })
end

--update storage depot space
function ChoGGi.UpdateResourceAmount(building,new_size)
  local storable_resources = building.storable_resources
  local resource_count = #storable_resources
  local orig_amount
  for i = 1, resource_count do
    local resource_name = storable_resources[i]
    if building.supply[resource_name] then
      orig_amount = building.supply[resource_name]:GetActualAmount()
      building.supply[resource_name]:SetAmount(orig_amount)
      building.demand[resource_name]:SetAmount(new_size)
      building.stockpiled_amount[resource_name] = orig_amount
      building:SetCount(orig_amount, resource_name)
    end
  end
end

--used to add or remove traits from schools/sanitariums
function ChoGGi.BuildingsSetAll_Traits(Building,Traits,Bool)
  local Buildings = UICity.labels.BuildingNoDomes
  for i = 1, #(Buildings or "") do
    local Obj = Buildings[i]
    if IsKindOf(Obj,Building) then
      for j = 1, #Traits do
        if Bool then
          Obj:SetTrait(j,nil)
        else
          Obj:SetTrait(j,Traits[j])
        end
      end
    end
  end
end

-- positive or 1 return TrueVar || negative or 0 return FalseVar
---Consts.XXX = ChoGGi.NumRetBool(Consts.XXX,0,ChoGGi.Consts.XXX)
function ChoGGi.NumRetBool(Num,TrueVar,FalseVar)
  local Bool = true
  if Num < 1 then
    Bool = nil
  end
  return Bool and TrueVar or FalseVar
end

--return as num
function ChoGGi.BoolRetNum(Bool)
  if Bool then
    return 1
  end
  return 0
end

--toggle 0/1
function ChoGGi.ToggleBoolNum(Num)
  if Num == 0 then
    return 1
  end
  return 0
end


--ChoGGi.ReturnTechAmount("HullPolarization","BuildingMaintenancePointsModifier")
--ChoGGi.ReturnTechAmount("TransportOptimization","max_shared_storage")
--ReturnTechAmount().a amount and .p percent
function ChoGGi.ReturnTechAmount(Tech,Prop)
  for i,_ in ipairs(TechTree) do
    for j,_ in ipairs(TechTree[i]) do
      if TechTree[i][j].id == Tech then
        for k,_ in ipairs(TechTree[i][j]) do
          if TechTree[i][j][k].Prop == Prop then
            local Tech = TechTree[i][j][k]
            local RetObj = {}
            if Tech.Percent then
              RetObj.p = Tech.Percent * -1 + 0.0 / 100 -- -5 > 5 > 5.0 > 0.05
            end
            if Tech.Amount then
              if Tech.Amount <= 0 then
                RetObj.a = Tech.Amount * -1
              else
                RetObj.a = Tech.Amount
              end
            end
            return RetObj
          end
        end
      end
    end
  end
end

--check if tech is researched before we set these consts (activated from menuitems)
function ChoGGi.BuildingMaintenancePointsModifier()
  if UICity and UICity:IsTechDiscovered("HullPolarization") then
    local p = ChoGGi.ReturnTechAmount("HullPolarization","BuildingMaintenancePointsModifier").p
    return ChoGGi.Consts.BuildingMaintenancePointsModifier * p
  end
  return ChoGGi.Consts.BuildingMaintenancePointsModifier
end
--
function ChoGGi.CargoCapacity()
  if UICity and UICity:IsTechDiscovered("FuelCompression") then
    local a = ChoGGi.ReturnTechAmount("FuelCompression","CargoCapacity").a
    return ChoGGi.Consts.CargoCapacity + a
  end
  return ChoGGi.Consts.CargoCapacity
end
--
function ChoGGi.CommandCenterMaxDrones()
  if UICity and UICity:IsTechDiscovered("DroneSwarm") then
    local a = ChoGGi.ReturnTechAmount("DroneSwarm","CommandCenterMaxDrones").a
    return ChoGGi.Consts.CommandCenterMaxDrones + a
  end
  return ChoGGi.Consts.CommandCenterMaxDrones
end
--
function ChoGGi.DroneResourceCarryAmount()
  if UICity and UICity:IsTechDiscovered("ArtificialMuscles") then
    local a = ChoGGi.ReturnTechAmount("ArtificialMuscles","DroneResourceCarryAmount").a
    return ChoGGi.Consts.DroneResourceCarryAmount + a
  end
  return ChoGGi.Consts.DroneResourceCarryAmount
end
--
function ChoGGi.LowSanityNegativeTraitChance()
  if UICity and UICity:IsTechDiscovered("SupportiveCommunity") then
    local p = ChoGGi.ReturnTechAmount("SupportiveCommunity","LowSanityNegativeTraitChance").p
    --[[
    LowSanityNegativeTraitChance = 30%
    SupportiveCommunity = -70%
    --]]
    local LowSan = ChoGGi.Consts.LowSanityNegativeTraitChance + 0.0 --SM has no math.funcs so + 0.0
    return p*LowSan/100*100
  end
  return ChoGGi.Consts.LowSanityNegativeTraitChance
end
--
function ChoGGi.MaxColonistsPerRocket()
  local PerRocket = ChoGGi.Consts.MaxColonistsPerRocket
  local a
  if UICity and UICity:IsTechDiscovered("CompactPassengerModule") then
    a = ChoGGi.ReturnTechAmount("CompactPassengerModule","MaxColonistsPerRocket").a
    PerRocket = PerRocket + a
  end
  if UICity and UICity:IsTechDiscovered("CryoSleep") then
    a = ChoGGi.ReturnTechAmount("CryoSleep","MaxColonistsPerRocket")
    PerRocket = PerRocket + a
  end
  return PerRocket
end
--
function ChoGGi.NonSpecialistPerformancePenalty()
  if UICity and UICity:IsTechDiscovered("GeneralTraining") then
    local a = ChoGGi.ReturnTechAmount("GeneralTraining","NonSpecialistPerformancePenalty").a
    return ChoGGi.Consts.NonSpecialistPerformancePenalty - a
  end
  return ChoGGi.Consts.NonSpecialistPerformancePenalty
end
--
function ChoGGi.RCRoverMaxDrones()
  if UICity and UICity:IsTechDiscovered("RoverCommandAI") then
    local a = ChoGGi.ReturnTechAmount("RoverCommandAI","RCRoverMaxDrones").a
    return ChoGGi.Consts.RCRoverMaxDrones + a
  end
  return ChoGGi.Consts.RCRoverMaxDrones
end
--
function ChoGGi.RCTransportGatherResourceWorkTime()
  if UICity and UICity:IsTechDiscovered("TransportOptimization") then
    local p = ChoGGi.ReturnTechAmount("TransportOptimization","RCTransportGatherResourceWorkTime").p
    return ChoGGi.Consts.RCTransportGatherResourceWorkTime * p
  end
  return ChoGGi.Consts.RCTransportGatherResourceWorkTime
end
--
function ChoGGi.RCTransportResourceCapacity()
  if UICity and UICity:IsTechDiscovered("TransportOptimization") then
    local a = ChoGGi.ReturnTechAmount("TransportOptimization","max_shared_storage").a
    return ChoGGi.Consts.RCTransportResourceCapacity + a
  end
  return ChoGGi.Consts.RCTransportResourceCapacity
end
--
function ChoGGi.TravelTimeEarthMars()
  if UICity and UICity:IsTechDiscovered("PlasmaRocket") then
    local p = ChoGGi.ReturnTechAmount("PlasmaRocket","TravelTimeEarthMars").p
    return ChoGGi.Consts.TravelTimeEarthMars * p
  end
  return ChoGGi.Consts.TravelTimeEarthMars
end
--
function ChoGGi.TravelTimeMarsEarth()
  if UICity and UICity:IsTechDiscovered("PlasmaRocket") then
    local p = ChoGGi.ReturnTechAmount("PlasmaRocket","TravelTimeMarsEarth").p
    return ChoGGi.Consts.TravelTimeMarsEarth * p
  end
  return ChoGGi.Consts.TravelTimeMarsEarth
end

function ChoGGi.SetCameraSettings()
  if ChoGGi.CheatMenuSettings.BorderScrollingToggle then
    --disable border scrolling
    cameraRTS.SetProperties(1,{ScrollBorder = 0})
  else
    --reduce ScrollBorder to the smallest we can (1 = can't scroll down)
    cameraRTS.SetProperties(1,{ScrollBorder = 2})
  end

  --zoom
  if ChoGGi.CheatMenuSettings.CameraZoomToggle then
    cameraRTS.SetZoomLimits(0,24000)
  end

  cameraRTS.SetProperties(1,{HeightInertia = 0})
end

--[[
DataInstances.BuildingTemplate[""]
SelectedObj:__toluacode()

    ChoGGi.ConstructionModeNameClean(SelectedObj:__toluacode())

SelectedObj:__toluacode()
--]]

--fixup names we get from SelectedObj:__toluacode()
function ChoGGi.ConstructionModeNameClean(itemname)
  --we want template_name or we have to guess from the placeobj name
  local tempname = itemname:match("^.+template_name%A+([A-Za-z_%s]+).+$")
  --local tempname = itemname:match("^.+template_name%A+(%a+).+$")
  if not tempname then
    tempname = itemname:match("^PlaceObj%('(%a+).+$")
  end
  --print(tempname)
  ChoGGi.ConstructionModeSet(tempname)
end
--place item under the mouse for construction
function ChoGGi.ConstructionModeSet(itemname)
  --make sure it's closed so we don't mess up selection
  pcall(function()
    CloseXBuildMenu()
  end)
  --fix up some names
  itemname = pcall(ChoGGi.ConstructionNamesListFix[itemname]) or itemname
  --n all the rest
  local igi = GetInGameInterface()
  if not igi or not igi:GetVisible() then
    return
  end
  local bld_template = DataInstances.BuildingTemplate[itemname]
  local show, prefabs, can_build, action = UIGetBuildingPrerequisites(bld_template.build_category, bld_template, true)
  local dlg = GetXDialog("XBuildMenu")
  if show then
    if action then
      action(dlg, {
        enabled = can_build,
        name = bld_template.name,
        construction_mode = bld_template.construction_mode
      })
    else
      igi:SetMode("construction", {
        template = bld_template.name,
        selected_dome = dlg and dlg.context.selected_dome
      })
    end
    CloseXBuildMenu()
  end
end

function ChoGGi.RemoveOldFiles()
--[[
local file_error, code = AsyncFileToString(ChoGGi.ModPath .. "Script.lua")
if not file_error then
  ChoGGi.RemoveOldFiles()
end
--]]
  local Table = {
    "CheatMenuSettings",
    "ConsoleExec",
    "FuncsCheats",
    "FuncsDebug",
    "FuncsGameplayBuildings",
    "FuncsGameplayColonists",
    "FuncsGameplayDronesAndRC",
    "FuncsGameplayMisc",
    "FuncsResources",
    "FuncsToggles",
    "Functions",
    "MenuGameplayBuildings",
    "MenuGameplayColonists",
    "MenuGameplayDronesAndRC",
    "MenuGameplayMisc",
    "MenuToggles",
    "MenuTogglesFunc",
    "Script",
    --second files change :)
    "Keys",
    "MenuBuildings",
    "MenuBuildingsFunc",
    "MenuCheats",
    "MenuCheatsFunc",
    "MenuColonists",
    "MenuColonistsFunc",
    "MenuDebug",
    "MenuDebugFunc",
    "MenuDronesAndRC",
    "MenuDronesAndRCFunc",
    "MenuHelp",
    "MenuMisc",
    "MenuMiscFunc",
    "MenuResources",
    "MenuResourcesFunc",
    "OnMsgs",
    "libs/ReplacedFunctions",
    "libs/ExamineDialog",
  }
  for _,Value in ipairs(Table) do
    AsyncFileDelete(ChoGGi.ModPath .. Value .. ".lua")
    --os.remove(ChoGGi.ModPath .. Value .. ".lua")
  end
  --lfs.rmdir(ChoGGi.HomeModPath .. "libs")
  AsyncFileDelete(ChoGGi.ModPath .. "libs")
end

function ChoGGi.SetGravity(Bool,Who)
  local NewGravity
  if Who == 1 then --drones
    for _,object in ipairs(UICity.labels.Drone or empty_table) do
      if Bool then
        NewGravity = object:GetGravity() + 1000
        object:SetGravity(NewGravity)
        ChoGGi.CheatMenuSettings.GravityDrone = NewGravity
      else
        object:SetGravity(0)
      end
    end
    if not Bool then
      ChoGGi.CheatMenuSettings.GravityDrone = false
    end

  elseif Who == 2 then --rc
    for _,object in ipairs(UICity.labels.Rover or empty_table) do
      if Bool then
        NewGravity = object:GetGravity() + 5000
        object:SetGravity(NewGravity)
        ChoGGi.CheatMenuSettings.GravityRC = NewGravity
      else
        object:SetGravity(0)
      end
    end
    if not Bool then
      ChoGGi.CheatMenuSettings.GravityRC = false
    end

  elseif Who == 3 then --colonists
    for _,object in ipairs(UICity.labels.Colonist or empty_table) do
      if Bool then
        NewGravity = object:GetGravity() + 250
        object:SetGravity(NewGravity)
        ChoGGi.CheatMenuSettings.GravityColonist = NewGravity
      else
        object:SetGravity(0)
      end
    end
    if not Bool then
      ChoGGi.CheatMenuSettings.GravityColonist = false
    end

  end
  ChoGGi.WriteSettings()

  ChoGGi.MsgPopup(SelectedObj.encyclopedia_id .. ": Gravity is increased " .. Bool or "default",
   "Drones","UI/Icons/IPButtons/drone.tga"
  )
end

if ChoGGi.Testing then
  table.insert(ChoGGi.FilesCount,"FuncGame")
end
