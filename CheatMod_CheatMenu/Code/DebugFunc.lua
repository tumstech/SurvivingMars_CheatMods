function ChoGGi.HigherShadowDist_Toggle()
  ChoGGi.CheatMenuSettings.HigherShadowDist = not ChoGGi.CheatMenuSettings.HigherShadowDist
  if ChoGGi.CheatMenuSettings.HigherShadowDist then
    hr.ShadowRangeOverride = 1000000
    hr.ShadowFadeOutRangePercent = 0
  else
    hr.ShadowRangeOverride = 0
    hr.ShadowFadeOutRangePercent = 30
  end

  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup("Higher Shadow Render Dist: " .. tostring(ChoGGi.CheatMenuSettings.HigherShadowDist),
   "Video","UI/Icons/Anomaly_Event.tga"
  )
end

function ChoGGi.HigherRenderDist_Toggle()
  ChoGGi.CheatMenuSettings.HigherRenderDist = not ChoGGi.CheatMenuSettings.HigherRenderDist
  if ChoGGi.CheatMenuSettings.HigherRenderDist then
    hr.LODDistanceModifier = 600
  else
    hr.LODDistanceModifier = 120
  end

  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup("Higher Render Dist: " .. tostring(ChoGGi.CheatMenuSettings.HigherRenderDist),
   "Video","UI/Icons/Anomaly_Event.tga"
  )
end

function ChoGGi.WriteLogs_Toggle()
  ChoGGi.CheatMenuSettings.WriteLogs = not ChoGGi.CheatMenuSettings.WriteLogs
  if ChoGGi.CheatMenuSettings.WriteLogs then
    ChoGGi.WriteLogsEnable()
  end
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup("Write Debug/Console Logs: " .. tostring(ChoGGi.CheatMenuSettings.WriteLogs),
   "Logging","UI/Icons/Anomaly_Breakthrough.tga"
  )
end

function ChoGGi.ObjExaminer()
  local obj = SelectedObj or SelectionMouseObj()
  --OpenExamine(SelectedObj)
  if obj == nil then
    return ClearShowMe()
  end
  local ex = Examine:new()
  ex:SetPos(terminal.GetMousePos())
  ex:SetObj(obj)
end

function ChoGGi.DumpCurrentObj()
  pcall(function()
    local obj = SelectedObj or SelectionMouseObj()
    Examine.onclick_handles = {}
    Examine.obj = obj
    local tempTable = Examine:totextex(obj)
    tempTable = tempTable:gsub("<[/%s%a%d]*>","")
    ChoGGi.Dump(tempTable .. "\n\n","a","DumpedExamine","lua")
  end)
end

function ChoGGi.Editor_Toggle()
  --keep menu opened if visible
  local showmenu
  if dlgUAMenu then
    showmenu = true
  end

  if IsEditorActive() then
    EditorState(0)
    table.restore(hr, "Editor")
    editor.SavedDynRes = false
    XShortcutsSetMode("Game")
  else
    table.change(hr, "Editor", {
      ResolutionPercent = 100,
      SceneWidth = 0,
      SceneHeight = 0,
      DynResTargetFps = 0
    })
    XShortcutsSetMode("Editor", function()
      EditorDeactivate()
    end)
    EditorState(1,1)
    GetEditorInterface():Show(true)

    --GetToolbar():SetVisible(true)
    editor.OldCameraType = {
      GetCamera()
    }
    editor.CameraWasLocked = camera.IsLocked(1)
    camera.Unlock(1)

    GetEditorInterface():SetVisible(true)
    GetEditorInterface():ShowSidebar(true)
    GetEditorInterface().dlgEditorStatusbar:SetVisible(true)
    --GetEditorInterface():SetMinimapVisible(true)
    --CreateEditorPlaceObjectsDlg()
    if showmenu then
      UAMenu.ToggleOpen()
    end
  end
end

function ChoGGi.MeteorBombardment(Bool)
  --function WaitBombard(obj, radius, count, delay_min, delay_max)
  if Bool then
    StartBombard(GetTerrainCursor(),0,50,0,0)
  else
    StartBombard(GetTerrainCursor(),0,50,0,0)
  end
end

function ChoGGi.AsteroidBombardment(Num)
  --function WaitBombard(obj, radius, count, delay_min, delay_max)
  if Num == 1 then
    CreateGameTimeThread(function()
      local def = MapSettings_Meteor:new({storm_radius = 0})
      MeteorsDisaster(def, "single", IsValid(SelectedObj) and SelectedObj:GetVisualPos() or GetTerrainCursor())
    end)
  elseif Num == 2 then
    CreateGameTimeThread(function()
      local def = MapSettings_Meteor:new({storm_radius = 5000})
      MeteorsDisaster(def, "multispawn", IsValid(SelectedObj) and SelectedObj:GetVisualPos() or GetTerrainCursor())
    end)
  elseif Num == 3 then
    --pound it
    CreateGameTimeThread(function()
      local def = MapSettings_Meteor:new({storm_radius = 50000})
      MeteorsDisaster(def, "storm", IsValid(SelectedObj) and SelectedObj:GetVisualPos() or GetTerrainCursor())
    end)
  end
end

function ChoGGi.DeleteSelectedObject()
  pcall(function()
    SelectedObj.can_demolish = true
    SelectedObj.indestructible = false
    DestroyBuildingImmediate(SelectedObj)
    SelectedObj:Destroy()
    SelectedObj:delete()
  end)
end

function ChoGGi.ConsoleHistory_Toggle()
  ChoGGi.CheatMenuSettings.ConsoleToggleHistory = not ChoGGi.CheatMenuSettings.ConsoleToggleHistory
  ShowConsoleLog(ChoGGi.CheatMenuSettings.ConsoleToggleHistory)
  ChoGGi.WriteSettings()
  ChoGGi.MsgPopup(tostring(ChoGGi.CheatMenuSettings.ConsoleToggleHistory) .. ": Those who cannot remember the past are condemned to repeat it.",
   "Console","UI/Icons/Sections/workshifts.tga"
  )
end

function ChoGGi.ChangeMap()
  local ineditor = Platform.editor and IsEditorActive()
  if ineditor then
    s_OldChangeMapAction()
  else
    CreateRealTimeThread(function()
      local caption = Untranslated("Choose map with settings presets:")
      local maps = ListMaps()
      local items = {}
      for i = 1, #maps do
        if not string.find(string.lower(maps[i]), "^prefab") and not string.find(maps[i], "^__") then
          table.insert(items, {
            text = Untranslated(maps[i]),
            map = maps[i]
          })
        end
      end
      local default_selection = table.find(maps, GetMapName())
      local map_settings = {}
      local class_names = ClassDescendantsList("MapSettings")
      for i = 1, #class_names do
        local class = class_names[i]
        map_settings[class] = mapdata[class]
      end
      local sel_idx, map_settings = WaitMapSettingsDialog(items, caption, nil, default_selection, map_settings)
      if sel_idx ~= "idCancel" then
        local map = sel_idx and items[sel_idx].map
        if not map or map == "" then
          return
        end
        CloseMenuWizards()
        StartGame(map, map_settings)
        LocalStorage.last_map = map
        SaveLocalStorage()
      end
    end)
  end
end

if ChoGGi.Testing then
  table.insert(ChoGGi.FilesCount,"DebugFunc")
end
