local BS = _G.BarSteward

-- based on code from AI Research Timer
local function getResearchTimer(craftType)
    local maxTimer = 2000000
    local maxResearch = GetMaxSimultaneousSmithingResearch(craftType)
    local maxLines = GetNumSmithingResearchLines(craftType)
    local maxR = maxResearch
    local inuse = 0

    for i = 1, maxLines do
        local _, _, numTraits = GetSmithingResearchLineInfo(craftType, i)

        for j = 1, numTraits do
            local duration, timeRemaining = GetSmithingResearchLineTraitTimes(craftType, i, j)

            if (duration ~= nil and timeRemaining ~= nil) then
                maxResearch = maxResearch - 1
                inuse = inuse + 1
                maxTimer = math.min(maxTimer, timeRemaining)
            end
        end
    end

    if (maxResearch > 0) then
        maxTimer = 0
    end

    return maxTimer, maxR, inuse
end

BS.widgets[BS.W_BLACKSMITHING] = {
    name = "blacksmithing",
    update = function(widget)
        local timeRemaining, maxResearch, inUse = getResearchTimer(_G.CRAFTING_TYPE_BLACKSMITHING)
        local colour = BS.Vars.Controls[BS.W_BLACKSMITHING].OkColour or BS.Vars.DefaultOkColour

        if (timeRemaining < (BS.Vars.Controls[BS.W_BLACKSMITHING].DangerValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_BLACKSMITHING].DangerColour or BS.Vars.DefaultDangerColour
        elseif (timeRemaining < (BS.Vars.Controls[BS.W_BLACKSMITHING].WarningValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_BLACKSMITHING].WarningColour or BS.Vars.DefaultWarningColour
        end

        widget:SetColour(unpack(colour))
        widget:SetValue(
            BS.SecondsToTime(
                timeRemaining,
                false,
                false,
                BS.Vars.Controls[BS.W_BLACKSMITHING].HideSeconds,
                BS.Vars.Controls[BS.W_BLACKSMITHING].Format
            ) .. (BS.Vars.Controls[BS.W_BLACKSMITHING].ShowSlots and " (" .. inUse .. "/" .. maxResearch .. ")" or "")
        )
        return timeRemaining
    end,
    timer = 1000,
    icon = "/esoui/art/icons/servicemappins/servicepin_smithy.dds",
    tooltip = ZO_CachedStrFormat("<<C:1>>", GetString(_G.SI_TRADESKILLTYPE1)),
    hideWhenEqual = 0,
    complete = function()
        return BS.IsTraitResearchComplete(_G.CRAFTING_TYPE_BLACKSMITHING)
    end,
    customSettings = {
        [1] = {
            type = "checkbox",
            name = GetString(_G.BARSTEWARD_SHOW_SLOTS),
            getFunc = function()
                return BS.Vars.Controls[BS.W_BLACKSMITHING].ShowSlots
            end,
            setFunc = function(value)
                BS.Vars.Controls[BS.W_BLACKSMITHING].ShowSlots = value
                BS.widgets[BS.W_BLACKSMITHING].update(
                    _G[BS.Name .. "_Widget_" .. BS.widgets[BS.W_BLACKSMITHING].name].ref
                )
            end,
            width = "full"
        }
    }
}

BS.widgets[BS.W_WOODWORKING] = {
    name = "woodworking",
    update = function(widget)
        local timeRemaining, maxResearch, inUse = getResearchTimer(_G.CRAFTING_TYPE_WOODWORKING)
        local colour = BS.Vars.Controls[BS.W_WOODWORKING].OkColour or BS.Vars.DefaultOkColour

        if (timeRemaining < (BS.Vars.Controls[BS.W_WOODWORKING].DangerValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_WOODWORKING].DangerColour or BS.Vars.DefaultDangerColour
        elseif (timeRemaining < (BS.Vars.Controls[BS.W_WOODWORKING].WarningValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_WOODWORKING].WarningColour or BS.Vars.DefaultWarningColour
        end

        widget:SetColour(unpack(colour))
        widget:SetValue(
            BS.SecondsToTime(
                timeRemaining,
                false,
                false,
                BS.Vars.Controls[BS.W_WOODWORKING].HideSeconds,
                BS.Vars.Controls[BS.W_WOODWORKING].Format
            ) .. (BS.Vars.Controls[BS.W_WOODWORKING].ShowSlots and " (" .. inUse .. "/" .. maxResearch .. ")" or "")
        )
        return timeRemaining
    end,
    timer = 1000,
    icon = "/esoui/art/icons/servicemappins/servicepin_woodworking.dds",
    tooltip = ZO_CachedStrFormat("<<C:1>>", GetString(_G.SI_TRADESKILLTYPE6)),
    hideWhenEqual = 0,
    complete = function()
        return BS.IsTraitResearchComplete(_G.CRAFTING_TYPE_WOODWORKING)
    end,
    customSettings = {
        [1] = {
            type = "checkbox",
            name = GetString(_G.BARSTEWARD_SHOW_SLOTS),
            getFunc = function()
                return BS.Vars.Controls[BS.W_WOODWORKING].ShowSlots
            end,
            setFunc = function(value)
                BS.Vars.Controls[BS.W_WOODWORKING].ShowSlots = value
                BS.widgets[BS.W_WOODWORKING].update(_G[BS.Name .. "_Widget_" .. BS.widgets[BS.W_WOODWORKING].name].ref)
            end,
            width = "full"
        }
    }
}

BS.widgets[BS.W_CLOTHING] = {
    name = "clothing",
    update = function(widget)
        local timeRemaining, maxResearch, inUse = getResearchTimer(_G.CRAFTING_TYPE_CLOTHIER)
        local colour = BS.Vars.Controls[BS.W_CLOTHING].OkColour or BS.Vars.DefaultOkColour

        if (timeRemaining < (BS.Vars.Controls[BS.W_CLOTHING].DangerValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_CLOTHING].DangerColour or BS.Vars.DefaultDangerColour
        elseif (timeRemaining < (BS.Vars.Controls[BS.W_CLOTHING].WarningValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_CLOTHING].WarningColour or BS.Vars.DefaultWarningColour
        end

        widget:SetColour(unpack(colour))
        widget:SetValue(
            BS.SecondsToTime(
                timeRemaining,
                false,
                false,
                BS.Vars.Controls[BS.W_CLOTHING].HideSeconds,
                BS.Vars.Controls[BS.W_CLOTHING].Format
            ) .. (BS.Vars.Controls[BS.W_CLOTHING].ShowSlots and " (" .. inUse .. "/" .. maxResearch .. ")" or "")
        )
        return timeRemaining
    end,
    timer = 1000,
    icon = "/esoui/art/icons/servicemappins/servicepin_outfitter.dds",
    tooltip = ZO_CachedStrFormat("<<C:1>>", GetString(_G.SI_TRADESKILLTYPE2)),
    hideWhenEqual = 0,
    complete = function()
        return BS.IsTraitResearchComplete(_G.CRAFTING_TYPE_CLOTHIER)
    end,
    customSettings = {
        [1] = {
            type = "checkbox",
            name = GetString(_G.BARSTEWARD_SHOW_SLOTS),
            getFunc = function()
                return BS.Vars.Controls[BS.W_CLOTHING].ShowSlots
            end,
            setFunc = function(value)
                BS.Vars.Controls[BS.W_CLOTHING].ShowSlots = value
                BS.widgets[BS.W_CLOTHING].update(_G[BS.Name .. "_Widget_" .. BS.widgets[BS.W_CLOTHING].name].ref)
            end,
            width = "full"
        }
    }
}

BS.widgets[BS.W_JEWELCRAFTING] = {
    name = "jewelcrafting",
    update = function(widget)
        local timeRemaining, maxResearch, inUse = getResearchTimer(_G.CRAFTING_TYPE_JEWELRYCRAFTING)
        local colour = BS.Vars.Controls[BS.W_JEWELCRAFTING].OkColour or BS.Vars.DefaultOkColour

        if (timeRemaining < (BS.Vars.Controls[BS.W_JEWELCRAFTING].DangerValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_JEWELCRAFTING].DangerColour or BS.Vars.DefaultDangerColour
        elseif (timeRemaining < (BS.Vars.Controls[BS.W_JEWELCRAFTING].WarningValue * 3600)) then
            colour = BS.Vars.Controls[BS.W_JEWELCRAFTING].WarningColour or BS.Vars.DefaultWarningColour
        end

        widget:SetColour(unpack(colour))
        widget:SetValue(
            BS.SecondsToTime(
                timeRemaining,
                false,
                false,
                BS.Vars.Controls[BS.W_JEWELCRAFTING].HideSeconds,
                BS.Vars.Controls[BS.W_JEWELCRAFTING].Format
            ) .. (BS.Vars.Controls[BS.W_JEWELCRAFTING].ShowSlots and " (" .. inUse .. "/" .. maxResearch .. ")" or "")
        )
        return timeRemaining
    end,
    timer = 1000,
    icon = "/esoui/art/icons/icon_jewelrycrafting_symbol.dds",
    tooltip = ZO_CachedStrFormat("<<C:1>>", GetString(_G.SI_TRADESKILLTYPE7)),
    hideWhenEqual = 0,
    complete = function()
        return BS.IsTraitResearchComplete(_G.CRAFTING_TYPE_JEWELRYCRAFTING)
    end,
    customSettings = {
        [1] = {
            type = "checkbox",
            name = GetString(_G.BARSTEWARD_SHOW_SLOTS),
            getFunc = function()
                return BS.Vars.Controls[BS.W_JEWELCRAFTING].ShowSlots
            end,
            setFunc = function(value)
                BS.Vars.Controls[BS.W_JEWELCRAFTING].ShowSlots = value
                BS.widgets[BS.W_JEWELCRAFTING].update(
                    _G[BS.Name .. "_Widget_" .. BS.widgets[BS.W_JEWELCRAFTING].name].ref
                )
            end,
            width = "full"
        }
    }
}
