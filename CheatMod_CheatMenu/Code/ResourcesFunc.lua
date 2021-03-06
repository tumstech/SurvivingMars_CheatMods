function ChoGGi.DeepScanToggle()
  Consts.DeepScanAvailable = ChoGGi.ToggleBoolNum(Consts.DeepScanAvailable)
  Consts.IsDeepWaterExploitable = ChoGGi.ToggleBoolNum(Consts.IsDeepWaterExploitable)
  Consts.IsDeepMetalsExploitable = ChoGGi.ToggleBoolNum(Consts.IsDeepMetalsExploitable)
  Consts.IsDeepPreciousMetalsExploitable = ChoGGi.ToggleBoolNum(Consts.IsDeepPreciousMetalsExploitable)
  --GrantTech("AdaptedProbes")
  --GrantTech("DeepScanning")
  --GrantTech("DeepWaterExtraction")
  --GrantTech("DeepMetalExtraction")
  ChoGGi.CheatMenuSettings.DeepScanAvailable = Consts.DeepScanAvailable
  ChoGGi.CheatMenuSettings.IsDeepWaterExploitable = Consts.IsDeepWaterExploitable
  ChoGGi.CheatMenuSettings.IsDeepMetalsExploitable = Consts.IsDeepMetalsExploitable
  ChoGGi.CheatMenuSettings.IsDeepPreciousMetalsExploitable = Consts.IsDeepPreciousMetalsExploitable
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.DeepScanAvailable .. ": Alice thought to herself 'Now you will see a film... made for children... perhaps... ' But, I nearly forgot... you must... close your eyes... otherwise... you won't see anything.",
   "Scanner","UI/Icons/Notifications/scan.tga"
  )
end

function ChoGGi.DeeperScanEnable()
  GrantTech("CoreMetals")
  GrantTech("CoreWater")
  GrantTech("CoreRareMetals")
  ChoGGi.MsgPopup("Further down the rabbit hole",
   "Scanner","UI/Icons/Notifications/scan.tga"
  )
end

function ChoGGi.FoodPerRocketPassenger(Amount)
  if Amount == 1 then
    Consts.FoodPerRocketPassenger = ChoGGi.Consts.FoodPerRocketPassenger * ChoGGi.Consts.ResourceScale
  elseif Amount == 2 then
    Consts.FoodPerRocketPassenger = Consts.FoodPerRocketPassenger + (25 * ChoGGi.Consts.ResourceScale)
  elseif Amount == 3 then
    Consts.FoodPerRocketPassenger = Consts.FoodPerRocketPassenger + (1000 * ChoGGi.Consts.ResourceScale)
  end
  ChoGGi.CheatMenuSettings.FoodPerRocketPassenger = Consts.FoodPerRocketPassenger
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(ChoGGi.CheatMenuSettings.FoodPerRocketPassenger / ChoGGi.Consts.ResourceScale .. ": om nom nom nom nom",
   "Passengers","UI/Icons/Sections/Food_4.tga"
  )
end

function ChoGGi.Add100PrefabsDrone()
  UICity.drone_prefabs = UICity.drone_prefabs + 100
  ChoGGi.MsgPopup("100 Drone Prefabs Added",
    "Prefabs","UI/Icons/Sections/storage.tga"
  )
end

function ChoGGi.AddPrefabs(Type,Amount,Msg)
  UICity:AddPrefabs(Type,Amount)
  ChoGGi.MsgPopup(Msg,
    "Prefabs","UI/Icons/Sections/storage.tga"
  )
end

function ChoGGi.SetFunds(Amount,Msg)
  ChangeFunding(Amount)
  ChoGGi.MsgPopup(Msg,
  "Funding","UI/Icons/IPButtons/rare_metals.tga"
  )
end

function ChoGGi.FillResource(self)
  if not SelectedObj then
    return
  end
  ChoGGi.MsgPopup("Resouce Filled",
  "Resource","UI/Icons/IPButtons/rare_metals.tga"
  )
  if pcall(function()
    ResourceProducer.CheatFill(self)
  end) then return --needed to put something for then
  elseif pcall(function()
    ResourceProducer.CheatFill(self)
    self.amount_stored = self.producers[1].max_storage
  end) then return
  elseif pcall(function()
    local group = self.group
    for i = 1, #group do
      group[i].transport_request:AddAmount(10000)
    end
    self:UpdateUI()
  end) then return
  elseif pcall(function()
    self.electricity:SetStoredAmount(self.capacity, "electricity")
  end) then return
  elseif pcall(function()
    self.air:SetStoredAmount(self.air_capacity, "air")
  end) then return
  elseif pcall(function()
    self.water:SetStoredAmount(self.water_capacity, "water")
  end) then return
  elseif pcall(function()
    self.transport_request:AddAmount(10000)
    self:UpdateUI()
  end) then return
  elseif pcall(function()
    self.demand.WasteRock:SetAmount(0)
    if self.supply.Concrete then
      self.supply.Concrete:SetAmount(self.max_amount_WasteRock / Max(1, g_Consts.WasteRockToConcreteRatio))
    end
    self:SetCount(self.max_amount_WasteRock)
  end) then return
  elseif pcall(function()
    self.amount = self.max_amount
    self:NotifyNearbyExploiters()
  end) then return
  elseif pcall(function()
    local resource = self.resource
    if self.supply[resource] then
      local max_name = "max_amount_" .. resource
      self.supply[resource]:SetAmount(self[max_name])
      self.demand[resource]:SetAmount(0)
    end
    self:SetCount(self.supply[resource]:GetActualAmount())
  end) then return
  elseif pcall(function()
    local amount_to_fill = self.max_storage - self:GetAmountStored()
    self.today_production = self.today_production + amount_to_fill
    self.lifetime_production = self.lifetime_production + amount_to_fill
    self:UpdateStockpileAmounts(self.max_storage)
  end) then return
  elseif pcall(function()
    local storable_resources = self.storable_resources
    local resource_count = #storable_resources
    self:InterruptDrones(nil, function(drone)
      local r = drone.d_request
      if r and self.demand[r:GetResource()] == r then
        return drone
      end
    end)
    for i = 1, resource_count do
      local resource_name = storable_resources[i]
      if self.supply[resource_name] then
        local a = self.demand[resource_name]:GetActualAmount()
        self:AddResource(a, resource_name)
      end
    end
  end) then return
  end
end

if ChoGGi.Testing then
  table.insert(ChoGGi.FilesCount,"ResourcesFunc")
end
