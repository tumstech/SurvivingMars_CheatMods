--ChoGGi.AddAction(Menu,Action,Key,Des,Icon)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gravity - 250",
  function()
    ChoGGi.SetGravity(true,3)
  end,
  nil,
  "Lowers the gravity of Colonists.",
  "groups.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gravity (Default)",
  function()
    ChoGGi.SetGravity(nil,3)
  end,
  nil,
  "Default gravity.",
  "groups.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Fire All Colonists!",
  ChoGGi.FireAllColonists,
  nil,
  "Fires everyone from every job.",
  "ReportBug.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Turn Off All Shifts",
  function()
    ChoGGi.AllShifts_Toggle(true,"off")
  end,
  nil,
  "Turns all work shifts off.",
  "ReportBug.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Turn On All Shifts",
  function()
    ChoGGi.AllShifts_Toggle(false,"on")
  end,
  nil,
  "Turns all work shifts on.",
  "ReportBug.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Baby Birth Toggle",
  ChoGGi.BirthThreshold_Toggle,
  nil,
  function()
    local des
    if Consts.BirthThreshold == 999999900 then
      des = "(Enabled)"
    else
      des = "(Disabled)"
    end
    return des .. " Maxed out BirthThreshold (no chance of birth)."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Min Comfort Birth Toggle",
  ChoGGi.MinComfortBirth_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.MinComfortBirth,"(Disabled)","(Enabled)")
    return des .. " Lower limit on birthing comfort."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Visit Fail Penalty Toggle",
  ChoGGi.VisitFailPenalty_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.VisitFailPenalty,"(Disabled)","(Enabled)")
    return des .. " Disable comfort penalty when failing to satisfy a need via a visit."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Renegade Creation Toggle",
  ChoGGi.RenegadeCreation_Toggle,
  nil,
  function()
    local des
    if Consts.RenegadeCreation == 9999900 then
      des = "(Enabled)"
    else
      des = "(Disabled)"
    end
    return des .. " Disable creation of renegades.\nWorks after daily update."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Morale Max Toggle",
  ChoGGi.ColonistsMoraleMax_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.HighStatLevel,"(Disabled)","(Enabled)")
    return des .. " Colonists always max morale (can effect birthing rates).\nOnly works on colonists that have yet to spawn (maybe)."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/See Dead Sanity Damage Toggle",
  ChoGGi.SeeDeadSanityDamage_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.SeeDeadSanity,"(Disabled)","(Enabled)")
    return des .. " Disable colonists taking sanity damage from seeing dead.\nWorks after in-game hour."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/No Home Comfort Damage Toggle",
  ChoGGi.NoHomeComfortDamage_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.NoHomeComfort,"(Disabled)","(Enabled)")
    return des .. " Disable colonists taking comfort damage from not having a home.\nWorks after in-game hour."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Chance Of Sanity Damage Toggle",
  ChoGGi.ChanceOfSanityDamage_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.DustStormSanityDamage,"(Disabled)","(Enabled)")
    return des .. " Disable colonists taking sanity damage from certain events.\nWorks after in-game hour."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Chance Of Negative Trait Toggle",
  ChoGGi.ChanceOfNegativeTrait_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.LowSanityNegativeTraitChance,"(Disabled)","(Enabled)")
    return des .. " Disable chance of getting a negative trait when Sanity reaches zero.\nWorks after colonist idle."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Chance Of Suicide Toggle",
  ChoGGi.ColonistsChanceOfSuicide_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.LowSanitySuicideChance,"(Disabled)","(Enabled)")
    return des .. " Disable chance of suicide when Sanity reaches zero.\nWorks after colonist idle."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Colonists Suffocate Toggle",
  ChoGGi.ColonistsSuffocate_Toggle,
  nil,
  function()
    local des
    if Consts.OxygenMaxOutsideTime == 99999900 then
      des = "(Enabled)"
    else
      des = "(Disabled)"
    end
    return des .. " Disable colonists suffocating with no oxygen.\nWorks after in-game hour."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Colonists Starve Toggle",
  ChoGGi.ColonistsStarve_Toggle,
  nil,
  function()
    local des
    if Consts.TimeBeforeStarving == 99999900 then
      des = "(Enabled)"
    else
      des = "(Disabled)"
    end
    return des .. " Disable colonists starving with no food.\nWorks after colonist idle."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Colonists Avoid Fired Workplace Toggle",
  ChoGGi.AvoidWorkplace_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.AvoidWorkplaceSols,"(Disabled)","(Enabled)")
    return des .. " After being fired, Colonists won't avoid that Workplace searching for a Workplace.\nWorks after colonist idle."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Positive Playground Toggle",
  ChoGGi.PositivePlayground_Toggle,
  nil,
  function()
    local des
    if Consts.positive_playground_chance == 101 then
      des = "(Enabled)"
    else
      des = "(Disabled)"
    end
    return des .. " 100% Chance to get a perk when grown if colonist has visited a playground as a child.\nOnly works on colonists that have yet to spawn (maybe)."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Project Morpheus Positive Trait Toggle",
  ChoGGi.ProjectMorpheusPositiveTrait_Toggle,
  nil,
  function()
    local des
    if Consts.ProjectMorphiousPositiveTraitChance == 100 then
      des = "(Enabled)"
    else
      des = "(Disabled)"
    end
    return des .. " 100% Chance to get positive trait when Resting and ProjectMorpheus is active."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Performance Penalty Non-Specialist Toggle",
  ChoGGi.PerformancePenaltyNonSpecialist_Toggle,
  nil,
  function()
    local des = ChoGGi.NumRetBool(Consts.NonSpecialistPerformancePenalty,"(Disabled)","(Enabled)")
    return des .. " Disable performance penalty for non-Specialists.\nActivated when colonist changes job."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Outside Workplace Radius + 16",
  function()
    ChoGGi.OutsideWorkplaceRadius(true)
  end,
  nil,
  function()
    return "Colonists search " .. Consts.DefaultOutsideWorkplacesRadius + ChoGGi.Consts.DefaultOutsideWorkplacesRadius .. " hexes outside their Dome when looking for a Workplace (default " .. ChoGGi.Consts.DefaultOutsideWorkplacesRadius .. ")."
  end,
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Outside Workplace Radius Toggle",
  ChoGGi.OutsideWorkplaceRadius,
  nil,
  "Colonists search 10 hexes outside their Dome when looking for a Workplace.",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: Children",
  function()
    ChoGGi.NewColonistAge("Child","When you're youngest at heart")
  end,
  nil,
  "Make all newly arrived and born colonists Children",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: Youth",
  function()
    ChoGGi.NewColonistAge("Youth","When you're young at heart")
  end,
  nil,
  "Make all newly arrived and born colonists Youths",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: Adult",
  function()
    ChoGGi.NewColonistAge("Adult","Time for the rat race")
  end,
  nil,
  "Make all newly arrived and born colonists Adults",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: Middle Aged",
  function()
    ChoGGi.NewColonistAge("Middle Aged","Still time for the rat race")
  end,
  nil,
  "Make all newly arrived and born colonists Middle Aged",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: Senior",
  function()
    ChoGGi.NewColonistAge("Senior","When you're (very much) young at heart")
  end,
  nil,
  "Make all newly arrived and born colonists Seniors",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: Retiree",
  function()
    ChoGGi.NewColonistAge("Retiree","Time for some long pig")
  end,
  nil,
  "Make all newly arrived and born colonists Retirees",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Age: (Default)",
  function()
    ChoGGi.NewColonistAge(false,"The miracle of childbirth")
  end,
  nil,
  "Back to random Age",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Gender: Other",
  function()
    ChoGGi.NewColonistSex("Other","Whole lotta nothing going on")
  end,
  nil,
  "Make all newly arrived and born colonists Other",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Gender: Android",
  function()
    ChoGGi.NewColonistSex("Android","Ever kissed a cyborg? No.\nYou will.")
  end,
  nil,
  "Make all newly arrived and born colonists Android",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Gender: Clone",
  function()
    ChoGGi.NewColonistSex("Clone","Nasty Star Wars funk in the pants.")
  end,
  nil,
  "Make all newly arrived and born colonists Clone",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Gender: Male",
  function()
    ChoGGi.NewColonistSex("Male","Sausage Fest")
  end,
  nil,
  "Make all newly arrived and born colonists Male",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Gender: Female",
  function()
    ChoGGi.NewColonistSex("Female","Fish Market")
  end,
  nil,
  "Make all newly arrived and born colonists Female",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/New/Gender: (Default)",
  function()
    ChoGGi.NewColonistSex(false,"The miracle of childbirth")
  end,
  nil,
  "Back to random Sex",
  "AlignSel.tga"
)

--modify colonists directly

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Morale 100",
  function()
    ChoGGi.SetColonistsMorale(100000,"Happy days are here again!")
  end,
  nil,
  "Set all Colonists Morale to 100",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Sanity Max",
  function()
    ChoGGi.SetColonistsSanity(9999900,"No need for shrinks")
  end,
  nil,
  "Set all Colonists Sanity to Max",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Sanity 100",
  function()
    ChoGGi.SetColonistsSanity(100000,"No need for shrinks")
  end,
  nil,
  "Set all Colonists Sanity to 100",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Comfort Max",
  function()
    ChoGGi.SetColonistsComfort(9999900,"Happy days are here again!")
  end,
  nil,
  "Set all Colonists Comfort to Max",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Comfort 100",
  function()
    ChoGGi.SetColonistsComfort(100000,"Happy days are here again!")
  end,
  nil,
  "Set all Colonists Comfort to 100",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Health Max",
  function()
    ChoGGi.SetColonistsHealth(9999900,"Healthy!")
  end,
  nil,
  "Set all Colonists Health to Max",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Stats/Set Health 100",
  function()
    ChoGGi.SetColonistsHealth(100000,"Healthy!")
  end,
  nil,
  "Set all Colonists Health to 100",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Age/[1]Make all Colonists Children",
  function()
    ChoGGi.SetColonistsAge("Child","When you're youngest at heart")
  end,
  nil,
  "Make all Colonists Child age",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Age/[2]Make all Colonists Youths",
  function()
    ChoGGi.SetColonistsAge("Youth","When you're young at heart")
  end,
  nil,
  "Make all Colonists Youth age",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Age/[3]Make all Colonists Adult",
  function()
    ChoGGi.SetColonistsAge("Adult","Time for the rat race")
  end,
  nil,
  "Make all Colonists Adult age",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Age/[3]Make all Colonists Middle Aged",
  function()
    ChoGGi.SetColonistsAge("Middle Aged","Still time for the rat race")
  end,
  nil,
  "Make all Colonists Middle Aged.",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Age/[4]Make all Colonists Senior",
  function()
    ChoGGi.SetColonistsAge("Senior","When you're (very much) young at heart")
  end,
  nil,
  "Make all Colonists Senior age",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Age/[5]Make all Colonists Retirees",
  function()
    ChoGGi.SetColonistsAge("Retiree","Time for some long pig")
  end,
  nil,
  "Make all Colonists Retiree age",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gender/Make all Colonists Others",
  function()
    ChoGGi.SetColonistsSex("Other","Whole lotta nothing going on")
  end,
  nil,
  "Make all Colonist's sex Other",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gender/Make all Colonists Androids",
  function()
    ChoGGi.SetColonistsSex("Android","Ever kissed a cyborg? No.\nYou will.")
  end,
  nil,
  "Make all Colonist's sex Android",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gender/Make all Colonists Clones",
  function()
    ChoGGi.SetColonistsSex("Clone","Nasty Star Wars funk in the pants.")
  end,
  nil,
  "Make all Colonist's sex Clone",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gender/Make all Colonists Male",
  function()
    ChoGGi.SetColonistsSex("Male","Sausage Fest")
  end,
  nil,
  "Make all Colonist's sex Male",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Gender/Make all Colonists Female",
  function()
    ChoGGi.SetColonistsSex("Female","Fish Market")
  end,
  nil,
  "Make all Colonist's sex Female",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Positive Traits Add All",
  function()
    ChoGGi.AllPositiveTraits_Toggle(true)
  end,
  nil,
  "Add all Positive traits to colonists",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Positive Traits Remove All",
  ChoGGi.AllPositiveTraits_Toggle,
  nil,
  "Remove all Positive traits from colonists",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Negative Traits Remove All",
  function()
    ChoGGi.AllNegativeTraits_Toggle(true)
  end,
  nil,
  "Remove all negative traits from colonists",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Traits/Negative Traits Add All",
  ChoGGi.AllNegativeTraits_Toggle,
  nil,
  "Add all negative traits to colonists",
  "AlignSel.tga"
)

ChoGGi.AddAction(
  "Gameplay/Colonists/Work/Add Specialization To All",
  ChoGGi.ColonistsAddSpecializationToAll,
  nil,
  "If Colonist has no Specialization then add a random one",
  "AlignSel.tga"
)

if ChoGGi.Testing then
  table.insert(ChoGGi.FilesCount,"ColonistsMenu")
end
