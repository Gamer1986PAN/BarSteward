local BS = _G.BarSteward
local completed = {
    [_G.TIMED_ACTIVITY_TYPE_DAILY] = false,
    [_G.TIMED_ACTIVITY_TYPE_WEEKLY] = false
}

local function configureWidget(widget, complete, maxComplete, activityType, tasks, hideLimit, defaultTooltip)
    local widgetIndex = activityType == _G.TIMED_ACTIVITY_TYPE_DAILY and BS.W_DAILY_ENDEAVOURS or BS.W_WEEKLY_ENDEAVOURS

    widget:SetValue(complete .. (hideLimit and "" or ("/" .. maxComplete)))
    widget:SetColour(unpack(BS.Vars.Controls[widgetIndex].Colour or BS.Vars.DefaultColour))

    if (#tasks > 0) then
        local tooltipText = defaultTooltip or ""

        for _, t in ipairs(tasks) do
            tooltipText = tooltipText .. BS.LF .. t
        end

        widget.tooltip = tooltipText
    end
end

local function getTimedActivityProgress(activityType, widget, hideLimit, defaultTooltip)
    local complete = 0
    local maxComplete = GetTimedActivityTypeLimit(activityType)
    local tasks = {}
    local maxPcProgress = -1
    local maxTask = {}

    for idx = 1, 30 do
        local name = GetTimedActivityName(idx)

        if (name == "") then
            break
        end

        if (GetTimedActivityType(idx) == activityType) then
            local max = GetTimedActivityMaxProgress(idx)
            local progress = GetTimedActivityProgress(idx)
            local pcProgress = progress / max
            local ttext = name .. "  (" .. progress .. "/" .. max .. ")"
            local colour = "|cb4b4b4"

            completed[activityType] = false

            if (progress > 0 and progress < max and complete ~= maxComplete) then
                colour = "|cffff00"
            elseif (complete == maxComplete and max ~= progress) then
                colour = "|cb4b4b4"
            elseif (max == progress) then
                complete = complete + 1
                colour = "|c00ff00"
            end

            -- get reward info
            local numRewards = GetNumTimedActivityRewards(idx)
            local reward = ""

            for rewardIndex = 1, numRewards do
                local rewardId, quantity = GetTimedActivityRewardInfo(idx, rewardIndex)
                local rewardData = REWARDS_MANAGER:GetInfoForReward(rewardId, quantity)

                if (reward ~= "") then
                    reward = reward .. ", "
                end

                reward = reward .. zo_iconFormat(rewardData.lootIcon or rewardData.icon, 16, 16) .. quantity
            end

            ttext = colour .. ttext .. "|r" .. " " .. reward

            table.insert(tasks, ttext)

            if (pcProgress > maxPcProgress) then
                maxTask = {
                    name = name,
                    description = GetTimedActivityDescription(idx),
                    progress = progress,
                    maxProgress = max
                }

                maxPcProgress = pcProgress
            end
        end
    end

    if (complete == maxComplete) then
        completed[activityType] = true
    end

    if (widget ~= nil) then
        configureWidget(widget, complete, maxComplete, activityType, tasks, hideLimit, defaultTooltip)
    end

    return complete, maxTask
end

BS.widgets[BS.W_DAILY_ENDEAVOURS] = {
    -- v1.0.1
    name = "dailyEndeavourProgress",
    update = function(widget)
        return getTimedActivityProgress(
            _G.TIMED_ACTIVITY_TYPE_DAILY,
            widget,
            BS.Vars.Controls[BS.W_DAILY_ENDEAVOURS].HideLimit,
            GetString(_G.BARSTEWARD_DAILY_ENDEAVOUR_PROGRESS)
        )
    end,
    event = {_G.EVENT_PLAYER_ACTIVATED, _G.EVENT_TIMED_ACTIVITY_PROGRESS_UPDATED},
    icon = "/esoui/art/journal/u26_progress_digsite_checked_incomplete.dds",
    tooltip = GetString(_G.BARSTEWARD_DAILY_ENDEAVOUR_PROGRESS),
    onClick = function()
        if (not IsInGamepadPreferredMode()) then
            GROUP_MENU_KEYBOARD:ShowCategory(_G.TIMED_ACTIVITIES_FRAGMENT)
            TIMED_ACTIVITIES_KEYBOARD:SetCurrentActivityType(_G.TIMED_ACTIVITY_TYPE_DAILY)
        else
            ZO_ACTIVITY_FINDER_ROOT_GAMEPAD:ShowCategory(TIMED_ACTIVITIES_GAMEPAD:GetCategoryData())
        end
    end,
    complete = function()
        return completed[_G.TIMED_ACTIVITY_TYPE_DAILY]
    end
}

BS.widgets[BS.W_WEEKLY_ENDEAVOURS] = {
    -- v1.0.1
    name = "weeklyEndeavourProgress",
    update = function(widget)
        return getTimedActivityProgress(
            _G.TIMED_ACTIVITY_TYPE_WEEKLY,
            widget,
            BS.Vars.Controls[BS.W_WEEKLY_ENDEAVOURS].HideLimit,
            GetString(_G.BARSTEWARD_WEEKLY_ENDEAVOUR_PROGRESS)
        )
    end,
    event = {_G.EVENT_PLAYER_ACTIVATED, _G.EVENT_TIMED_ACTIVITY_PROGRESS_UPDATED},
    icon = "/esoui/art/journal/u26_progress_digsite_checked_complete.dds",
    tooltip = GetString(_G.BARSTEWARD_WEEKLY_ENDEAVOUR_PROGRESS),
    onClick = function()
        if (not IsInGamepadPreferredMode()) then
            GROUP_MENU_KEYBOARD:ShowCategory(_G.TIMED_ACTIVITIES_FRAGMENT)
            TIMED_ACTIVITIES_KEYBOARD:SetCurrentActivityType(_G.TIMED_ACTIVITY_TYPE_WEEKLY)
        else
            ZO_ACTIVITY_FINDER_ROOT_GAMEPAD:ShowCategory(TIMED_ACTIVITIES_GAMEPAD:GetCategoryData())
        end
    end,
    complete = function()
        return completed[_G.TIMED_ACTIVITY_TYPE_WEEKLY]
    end
}

BS.widgets[BS.W_ENDEAVOUR_PROGRESS] = {
    -- v1.2.14
    name = "weeklyEndeavourBar",
    update = function(widget)
        local _, maxTask = getTimedActivityProgress(_G.TIMED_ACTIVITY_TYPE_WEEKLY, nil)

        if (maxTask.name and maxTask.maxProgress) then
            widget:SetProgress(maxTask.progress, 0, maxTask.maxProgress)

            local ttt = GetString(_G.BARSTEWARD_WEEKLY_ENDEAVOUR_PROGRESS_BEST) .. BS.LF
            ttt = ttt .. "|cf6f6f6"
            ttt = ttt .. maxTask.name .. BS.LF .. BS.LF
            ttt = ttt .. maxTask.description

            widget.tooltip = ttt

            return maxTask.progress == maxTask.maxProgress
        else
            return 0
        end
    end,
    gradient = function()
        local startg = {GetInterfaceColor(_G.INTERFACE_COLOR_TYPE_GENERAL, _G.INTERFACE_GENERAL_COLOR_STATUS_BAR_START)}
        local endg = {GetInterfaceColor(_G.INTERFACE_COLOR_TYPE_GENERAL, _G.INTERFACE_GENERAL_COLOR_STATUS_BAR_END)}
        local s = BS.Vars.Controls[BS.W_ENDEAVOUR_PROGRESS].GradientStart or startg
        local e = BS.Vars.Controls[BS.W_ENDEAVOUR_PROGRESS].GradientEnd or endg

        return s, e
    end,
    event = {_G.EVENT_PLAYER_ACTIVATED, _G.EVENT_TIMED_ACTIVITY_PROGRESS_UPDATED},
    icon = "/esoui/art/journal/u26_progress_digsite_marked_complete.dds",
    tooltip = GetString(_G.BARSTEWARD_WEEKLY_ENDEAVOUR_PROGRESS_BEST),
    onClick = function()
        if (not IsInGamepadPreferredMode()) then
            GROUP_MENU_KEYBOARD:ShowCategory(_G.TIMED_ACTIVITIES_FRAGMENT)
        else
            ZO_ACTIVITY_FINDER_ROOT_GAMEPAD:ShowCategory(TIMED_ACTIVITIES_GAMEPAD:GetCategoryData())
        end
    end,
    complete = function()
        return completed[_G.TIMED_ACTIVITY_TYPE_WEEKLY]
    end
}

local difficultyColours = {
    [_G.ANTIQUITY_DIFFICULTY_TRIVIAL] = "e6e6e6",
    [_G.ANTIQUITY_DIFFICULTY_SIMPLE] = "2dc50e",
    [_G.ANTIQUITY_DIFFICULTY_INTERMEDIATE] = "3a92ff",
    [_G.ANTIQUITY_DIFFICULTY_ADVANCED] = "a02ef7",
    [_G.ANTIQUITY_DIFFICULTY_MASTER] = "ccaa1a",
    [_G.ANTIQUITY_DIFFICULTY_ULTIMATE] = "e58b27"
}

local function getLeadColour(lead)
    if ((lead.quality or 0) == 0) then
        return BS.ARGBConvert(BS.Vars.Controls[BS.W_LEADS].Colour or BS.Vars.DefaultColour)
    end

    return "|c" .. difficultyColours[lead.quality]
end

BS.isScryingUnlocked = false

BS.RegisterForEvent(
    _G.EVENT_PLAYER_ACTIVATED,
    function()
        BS.isScryingUnlocked = ZO_IsScryingUnlocked()
    end
)

BS.RegisterForEvent(
    _G.EVENT_SKILL_LINE_ADDED,
    function()
        BS.isScryingUnlocked = ZO_IsScryingUnlocked()
    end
)

BS.widgets[BS.W_LEADS] = {
    -- v1.1.0
    name = "leads",
    update = function(widget)
        local minTime = 99999999
        local leads = {}
        local antiquityId = GetNextAntiquityId()
        local vars = BS.Vars.Controls[BS.W_LEADS]

        while antiquityId do
            if (DoesAntiquityHaveLead(antiquityId)) then
                local lead = {
                    name = BS.Format(GetAntiquityName(antiquityId)),
                    remaining = GetAntiquityLeadTimeRemainingSeconds(antiquityId),
                    quality = GetAntiquityQuality(antiquityId),
                    zone = BS.Format(GetZoneNameById(GetAntiquityZoneId(antiquityId))),
                    id = antiquityId,
                    inProgress = GetNumAntiquityDigSites(antiquityId) > 0
                }

                table.insert(leads, lead)

                if (not lead.inProgress) then
                    if (lead.remaining < minTime) then
                        minTime = lead.remaining
                    end
                end
            end

            antiquityId = GetNextAntiquityId(antiquityId)
        end

        if (#leads > 0) then
            local timeColour = BS.Vars.DefaultOkColour

            if (minTime <= (vars.DangerValue) * 3600) then
                timeColour = vars.DangerColour or BS.Vars.DefaultDangerColour
            elseif (minTime <= (vars.WarningValue * 3600)) then
                timeColour = vars.WarningColour or BS.Vars.DefaultWarningColour
            end

            local value

            if (#leads == 1 and leads[1].inProgress) then
                value = GetString(_G.BARSTEWARD_IN_PROGRESS)
                timeColour = {1, 0.5, 0, 1}
                minTime = 0
            else
                value = BS.SecondsToTime(minTime, false, false, true, vars.Format, vars.HideDaysWhenZero)
            end

            if (vars.ShowCount) then
                value = "(" .. #leads .. ")  " .. value
            end

            widget:SetColour(unpack(timeColour))
            widget:SetValue(value)

            local ttt = BS.Format(_G.SI_ANTIQUITY_SUBHEADING_ACTIVE_LEADS)

            -- sort by time remaining
            table.sort(
                leads,
                function(a, b)
                    return a.remaining < b.remaining
                end
            )

            for _, lead in ipairs(leads) do
                local nameAndZone = lead.name .. " - " .. lead.zone
                local time = BS.SecondsToTime(lead.remaining, false, false, true, vars.Format, vars.HideDaysWhenZero)
                local ttlColour = getLeadColour(lead)

                timeColour = BS.Vars.DefaultOkColour

                if (lead.inProgress) then
                    time = GetString(_G.BARSTEWARD_IN_PROGRESS)
                    timeColour = {1, 0.5, 0, 1}
                else
                    if (lead.remaining <= (vars.DangerValue * 3600)) then
                        timeColour = vars.DangerColour or BS.Vars.DefaultDangerColour
                    elseif (lead.remaining <= (vars.WarningValue * 3600)) then
                        timeColour = vars.WarningColour or BS.Vars.DefaultWarningColour
                    end
                end

                ttt = ttt .. BS.LF .. " " .. ttlColour
                ttt = ttt .. nameAndZone .. " - |r" .. BS.ARGBConvert(timeColour) .. time .. "|r"
            end

            widget.tooltip = ttt
        end

        return minTime
    end,
    timer = 1000,
    icon = GetAntiquityLeadIcon(),
    tooltip = BS.Format(_G.SI_ANTIQUITY_SUBHEADING_ACTIVE_LEADS),
    hideWhenEqual = 99999999,
    hideWhenTrue = function()
        return not BS.isScryingUnlocked
    end,
    customSettings = {
        [1] = {
            type = "checkbox",
            name = GetString(_G.BARSTEWARD_SHOW_LEAD_COUNT),
            getFunc = function()
                return BS.Vars.Controls[BS.W_LEADS].ShowCount or false
            end,
            setFunc = function(value)
                BS.Vars.Controls[BS.W_LEADS].ShowCount = value
                BS.RefreshWidget(BS.W_LEADS)
            end,
            default = false
        }
    }
}

local function getDisplay(timeRemaining, widgetIndex)
    local display
    local hours = timeRemaining / 60 / 60
    local days = math.floor((hours / 24) + 0.5)

    if (BS.Vars.Controls[widgetIndex].ShowDays and days >= 1 and hours > 24) then
        display = zo_strformat(GetString(_G.BARSTEWARD_DAYS), days)
    else
        display =
            BS.SecondsToTime(
            timeRemaining,
            false,
            false,
            BS.Vars.Controls[widgetIndex].HideSeconds,
            BS.Vars.Controls[widgetIndex].Format,
            BS.Vars.Controls[widgetIndex].HideDaysWhenZero
        )
    end

    return display
end

local function getTimedActivityTimeRemaining(activityType, widgetIndex, widget)
    local secondsRemaining = TIMED_ACTIVITIES_MANAGER:GetTimedActivityTypeTimeRemainingSeconds(activityType)
    local vars = BS.Vars.Controls[widgetIndex]
    local colour = vars.OkColour or BS.Vars.DefaultOkColour

    if (secondsRemaining < (vars.DangerValue * 3600)) then
        colour = vars.DangerColour or BS.Vars.DefaultDangerColour
    elseif (secondsRemaining < (vars.WarningValue * 3600)) then
        colour = vars.WarningColour or BS.Vars.DefaultWarningColour
    end

    local display = getDisplay(secondsRemaining, widgetIndex)

    widget:SetColour(unpack(colour))
    widget:SetValue(display)

    return secondsRemaining
end

function BS.GetTimedActivityTimeRemaining(...)
    return getTimedActivityTimeRemaining(...)
end

BS.widgets[BS.W_DAILY_ENDEAVOUR_TIME] = {
    -- v1.2.18
    name = "dailyEndeavourTime",
    update = function(widget)
        return getTimedActivityTimeRemaining(_G.TIMED_ACTIVITY_TYPE_DAILY, BS.W_DAILY_ENDEAVOUR_TIME, widget)
    end,
    timer = 1000,
    icon = "/esoui/art/journal/u26_progress_digsite_unknown_incomplete.dds",
    tooltip = GetString(_G.BARSTEWARD_DAILY_ENDEAVOUR_TIME),
    onClick = function()
        if (not IsInGamepadPreferredMode()) then
            GROUP_MENU_KEYBOARD:ShowCategory(_G.TIMED_ACTIVITIES_FRAGMENT)
        else
            ZO_ACTIVITY_FINDER_ROOT_GAMEPAD:ShowCategory(TIMED_ACTIVITIES_GAMEPAD:GetCategoryData())
        end
    end
}

BS.widgets[BS.W_WEEKLY_ENDEAVOUR_TIME] = {
    -- v1.2.18
    name = "weeklyEndeavourTime",
    update = function(widget)
        return getTimedActivityTimeRemaining(_G.TIMED_ACTIVITY_TYPE_WEEKLY, BS.W_WEEKLY_ENDEAVOUR_TIME, widget)
    end,
    timer = 1000,
    icon = "/esoui/art/journal/u26_progress_digsite_unknown_complete.dds",
    tooltip = GetString(_G.BARSTEWARD_WEEKLY_ENDEAVOUR_TIME),
    onClick = function()
        if (not IsInGamepadPreferredMode()) then
            GROUP_MENU_KEYBOARD:ShowCategory(_G.TIMED_ACTIVITIES_FRAGMENT)
        else
            ZO_ACTIVITY_FINDER_ROOT_GAMEPAD:ShowCategory(TIMED_ACTIVITIES_GAMEPAD:GetCategoryData())
        end
    end,
    complete = function()
        return completed[_G.TIMED_ACTIVITY_TYPE_WEEKLY]
    end
}

BS.widgets[BS.W_TRIBUTE_CLUB_RANK] = {
    name = "tributeRank",
    update = function(widget, updateType)
        if (updateType == "initial") then
            zo_callLater(
                function()
                    RequestTributeClubData()
                end,
                1000
            )
        else
            local rank = GetTributePlayerClubRank()
            local xp, totalxp = GetTributePlayerExperienceInCurrentClubRank()
            local percent = zo_floor(xp / totalxp * 100)
            local icon = string.format("EsoUI/Art/Tribute/tributeClubRank_%d.dds", rank)
            local rankName = zo_strformat(GetString("SI_TRIBUTECLUBRANK", rank))
            local displayRank = rank + 1

            widget:SetIcon(icon)

            if (rank == 7) then
                widget:SetValue(displayRank)
            else
                widget:SetValue(displayRank .. " (" .. percent .. "%)")
            end

            local ttt = GetString(_G.BARSTEWARD_TRIBUTE_RANK) .. BS.LF

            ttt = ttt .. "|cf9f9f9" .. displayRank .. " - " .. rankName .. BS.LF .. BS.LF
            ttt = ttt .. xp .. " / " .. totalxp .. ((rank == 7) and "" or " (" .. percent .. "%)|r")

            widget.tooltip = ttt
        end
    end,
    event = {
        _G.EVENT_PLAYER_ACTIVATED,
        _G.EVENT_TRIBUTE_CLUB_RANK_CHANGED,
        _G.EVENT_TRIBUTE_CLUB_EXPERIENCE_GAINED,
        _G.EVENT_TRIBUTE_CLUB_INIT
    },
    icon = "/esoui/art/tribute/tributeclubrank_7.dds",
    tooltip = GetString(_G.BARSTEWARD_TRIBUTE_RANK)
}

BS.widgets[BS.W_ACHIEVEMENT_POINTS] = {
    -- v1.3.3
    name = "achievementPoints",
    update = function(widget)
        local totalPoints = GetTotalAchievementPoints()
        local earnedPoints = GetEarnedAchievementPoints()
        local colour = BS.Vars.Controls[BS.W_ACHIEVEMENT_POINTS].Colour or BS.Vars.DefaultColour
        local value = earnedPoints

        if (BS.Vars.Controls[BS.W_ACHIEVEMENT_POINTS].ShowPercent) then
            value = math.floor((earnedPoints / totalPoints) * 100) .. "%"
        end

        widget:SetValue(value)
        widget:SetColour(unpack(colour))

        local ttt = BS.Format(_G.SI_ACHIEVEMENTS_OVERALL) .. BS.LF

        ttt = ttt .. "|cf9f9f9" .. earnedPoints .. "/" .. totalPoints .. "|r"

        widget.tooltip = ttt
        return widget:GetValue()
    end,
    event = {
        _G.EVENT_PLAYER_ACTIVATED,
        _G.EVENT_ACHIEVEMENT_UPDATED,
        _G.EVENT_ACHIEVEMENT_AWARDED,
        _G.EVENT_ACHIEVEMENTS_UPDATED
    },
    icon = "/esoui/art/journal/journal_tabicon_achievements_up.dds",
    tooltip = BS.Format(_G.SI_ACHIEVEMENTS_OVERALL),
    onClick = function()
        if (not IsInGamepadPreferredMode()) then
            SCENE_MANAGER:Show("achievements")
        else
            SCENE_MANAGER:Show("achievementsGamepad")
        end
    end
}

BS.widgets[BS.W_PLEDGES_TIME] = {
    -- v1.3.11
    -- same time as any other daily activity
    name = "dailyPledgesTime",
    update = function(widget)
        return getTimedActivityTimeRemaining(_G.TIMED_ACTIVITY_TYPE_DAILY, BS.W_PLEDGES_TIME, widget)
    end,
    timer = 1000,
    icon = "/esoui/art/icons/undaunted_bigcoffer.dds",
    tooltip = GetString(_G.BARSTEWARD_DAILY_PLEDGES_TIME)
}

local function setTracker(widgetIndex, resetSeconds, tooltip)
    if (not BS.Vars.Trackers[widgetIndex]) then
        BS.Vars.Trackers[widgetIndex] = {}
    end

    local thisCharacter = GetUnitName("player")

    if (not BS.Vars.Trackers[widgetIndex][thisCharacter]) then
        BS.Vars.Trackers[widgetIndex][thisCharacter] = {}
    end

    local resetTime = resetSeconds + os.time()
    BS.Vars.Trackers[widgetIndex][thisCharacter].resetTime = resetTime

    local resets = BS.Vars.Trackers[widgetIndex]

    for character, time in pairs(resets) do
        if (character ~= thisCharacter) then
            local timeRemaining = 0

            if (time.resetTime > os.time()) then
                timeRemaining = time.resetTime - os.time()
            end

            local formattedTime =
                BS.SecondsToTime(timeRemaining, true, false, BS.Vars.Controls[BS.W_SHADOWY_VENDOR_TIME].HideSeconds)

            tooltip = tooltip .. BS.LF .. "|cffd700"
            tooltip = tooltip .. formattedTime .. "|r " .. ZO_FormatUserFacingDisplayName(character)
        end
    end

    return tooltip
end

BS.isShadowyVendorUnlocked = false

function BS.IsShadowyVendorUnlocked()
    local DarkBrotherhoodSkillLineId = 118
    local skilltype, skilllineid = GetSkillLineIndicesFromSkillLineId(DarkBrotherhoodSkillLineId)
    local _, rank, _, _, _, _, active = GetSkillLineInfo(skilltype, skilllineid)

    return (rank > 3) and active
end

BS.RegisterForEvent(
    _G.EVENT_PLAYER_ACTIVATED,
    function()
        BS.isShadowyVendorUnlocked = BS.IsShadowyVendorUnlocked()
    end
)

BS.RegisterForEvent(
    _G.EVENT_SKILL_LINE_ADDED,
    function()
        BS.isShadowyVendorUnlocked = BS.IsShadowyVendorUnlocked()
    end
)

BS.widgets[BS.W_SHADOWY_VENDOR_TIME] = {
    -- v1.3.11
    name = "remainsSilentReset",
    update = function(widget)
        local timeToReset = GetTimeToShadowyConnectionsResetInSeconds()
        local colour = BS.Vars.DefaultColour
        local remaining =
            BS.SecondsToTime(timeToReset, true, false, BS.Vars.Controls[BS.W_SHADOWY_VENDOR_TIME].HideSeconds)

        widget:SetColour(unpack(colour))
        widget:SetValue(remaining)

        widget.tooltip =
            setTracker(BS.W_SHADOWY_VENDOR_TIME, timeToReset, GetString(_G.BARSTEWARD_SHADOWY_VENDOR_RESET))
        return timeToReset
    end,
    timer = 1000,
    icon = "/esoui/art/icons/rep_darkbrotherhood_64.dds",
    tooltip = GetString(_G.BARSTEWARD_SHADOWY_VENDOR_RESET),
    hideWhenTrue = function()
        return not BS.isShadowyVendorUnlocked
    end
}

BS.widgets[BS.W_LFG_TIME] = {
    -- v1.3.11
    name = "lfgTime",
    update = function(widget)
        local timeToReset = GetLFGCooldownTimeRemainingSeconds(_G.LFG_COOLDOWN_DUNGEON_REWARD_GRANTED)
        local colour = BS.Vars.DefaultColour
        local remaining = BS.SecondsToTime(timeToReset, true, false, BS.Vars.Controls[BS.W_LFG_TIME].HideSeconds)

        widget:SetColour(unpack(colour))
        widget:SetValue(remaining)

        widget.tooltip = setTracker(BS.W_LFG_TIME, timeToReset, GetString(_G.BARSTEWARD_DUNGEON_REWARD_RESET))

        return timeToReset
    end,
    timer = 1000,
    icon = "/esoui/art/lfg/lfg_indexicon_dungeon_up.dds",
    tooltip = GetString(_G.BARSTEWARD_DUNGEON_REWARD_RESET),
    onClick = function()
        if (IsInGamepadPreferredMode()) then
            SCENE_MANAGER:Show("gamepad_groupList")
        else
            SCENE_MANAGER:Show("groupMenuKeyboard")
        end
    end
}

BS.widgets[BS.W_LOREBOOKS] = {
    -- v1.4.5
    name = "lorebooks",
    update = function(widget)
        local colour = BS.Vars.Controls[BS.W_LOREBOOKS].Colour or BS.Vars.DefaultColour
        local categories = {}

        for categoryIndex = 1, GetNumLoreCategories() do
            local categoryName, numCollections = GetLoreCategoryInfo(categoryIndex)
            local category = {
                name = categoryName,
                numCollections = numCollections,
                numKnownBooks = 0,
                totalBooks = 0
            }

            for collectionIndex = 1, numCollections do
                local _, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
                if not hidden then
                    category.numKnownBooks = category.numKnownBooks + numKnownBooks
                    category.totalBooks = category.totalBooks + totalBooks
                end
            end

            categories[categoryIndex] = category
        end

        local value = ""

        local tt = GetString(_G.BARSTEWARD_LOREBOOKS)

        for _, category in pairs(categories) do
            local metrics = category.numKnownBooks .. "/" .. category.totalBooks

            tt = tt .. BS.LF .. "|cf9f9f9"
            tt = tt .. category.name .. " " .. metrics .. "|r"

            if (BS.Vars.Controls[BS.W_LOREBOOKS].ShowCategory == category.name) then
                value = metrics
            end
        end

        widget:SetValue(value)
        widget:SetColour(unpack(colour))

        widget.tooltip = tt

        return #categories
    end,
    event = {_G.EVENT_PLAYER_ACTIVATED, _G.EVENT_LORE_BOOK_LEARNED, _G.EVENT_STYLE_LEARNED, _G.EVENT_TRAIT_LEARNED},
    icon = "/esoui/art/icons/quest_book_001.dds",
    tooltip = GetString(_G.BARSTEWARD_LOREBOOKS),
    onClick = function()
        if (IsInGamepadPreferredMode()) then
            SCENE_MANAGER:Show("loreLibraryGamepad")
        else
            SCENE_MANAGER:Show("loreLibrary")
        end
    end,
    customSettings = function()
        local options = {}

        for categoryIndex = 1, GetNumLoreCategories() do
            local categoryName = GetLoreCategoryInfo(categoryIndex)

            table.insert(options, categoryName)
        end

        return {
            [1] = {
                type = "dropdown",
                name = GetString(_G.BARSTEWARD_LOREBOOKS_CATEGORY),
                choices = options,
                getFunc = function()
                    return BS.Vars.Controls[BS.W_LOREBOOKS].ShowCategory
                end,
                setFunc = function(value)
                    BS.Vars.Controls[BS.W_LOREBOOKS].ShowCategory = value
                    BS.RefreshWidget(BS.W_LOREBOOKS)
                end,
                default = false
            }
        }
    end
}

local function getActivityRewardInfo(activityTypes)
    local result = {}
    for _, activityType in ipairs(activityTypes) do
        local locationsData = ZO_ACTIVITY_FINDER_ROOT_MANAGER:GetLocationsData(activityType)

        if (locationsData) then
            for _, location in ipairs(locationsData) do
                if (location:ShouldForceFullPanelKeyboard()) then
                    if (location:HasRewardData()) then
                        local rewardUIDataId, xpReward = location:GetRewardData()
                        local numShownItemRewardNodes = GetNumLFGActivityRewardUINodes(rewardUIDataId)

                        for nodeIndex = 1, numShownItemRewardNodes do
                            local displayName, icon, red, green, blue =
                                GetLFGActivityRewardUINodeInfo(rewardUIDataId, nodeIndex)

                            if (icon) then
                                --d(location:GetSetTypesListText())
                                result[activityType] = {
                                    typeName = location:GetNameKeyboard(),
                                    xpReward = xpReward,
                                    displayName = zo_strformat(_G.SI_ACTIVITY_FINDER_REWARD_NAME_FORMAT, displayName),
                                    icon = icon,
                                    colour = {r = red, g = green, b = blue},
                                    active = location:IsActive() or false,
                                    meetsRequirements = location:DoesPlayerMeetLevelRequirements()
                                }
                                break
                            end
                        end
                    end
                end
            end
        end
    end

    return result
end

local function getActvityOutput(data)
    if (data.output ~= "") then
        data.output = data.output .. " "
        data.normalisedOutput = data.normalisedOutput .. " "
    end

    data.output = data.output .. zo_iconFormat(data.icon, 32, 32)

    if (data.activityData.meetsRequirements) then
        local icon = BS.ColourToIcon(data.activityData.colour.r, data.activityData.colour.g, data.activityData.colour.b)
        data.output = data.output .. " " .. zo_iconFormat(icon, 32, 32)
        data.eligibleCount = data.eligibleCount + 1
    else
        data.output = data.output .. " " .. zo_iconFormat(BS.INELIGIBLE_ICON, 16, 16)
    end

    data.normalisedOutput = data.normalisedOutput .. "XXXXXXX"

    data.tt = data.tt .. BS.LF .. "|cf9f9f9"
    data.tt = data.tt .. BS.Format(data.label) .. " |r"

    if (data.activityData.meetsRequirements) then
        local cdt = ZO_CommaDelimitNumber(data.activityData.xpReward)
        data.tt = data.tt .. BS.ARGBConvert2(data.activityData.colour) .. data.activityData.displayName .. " |r"
        data.tt = data.tt .. zo_strformat(_G.SI_ACTIVITY_FINDER_REWARD_XP_FORMAT, cdt)
    else
        data.tt = data.tt .. "|cf90000"
        data.tt = data.tt .. BS.Format(_G.SI_HOUSE_TEMPLATE_UNMET_REQUIREMENTS_TEXT)
        data.tt = data.tt .. "|r"
    end

    return data
end

BS.widgets[BS.W_RANDOM_DUNGEON] = {
    -- v1.4.22
    name = "randomDungeon",
    update = function(widget)
        local activities = {_G.LFG_ACTIVITY_DUNGEON, _G.LFG_ACTIVITY_MASTER_DUNGEON}
        local dungeonInfo = getActivityRewardInfo(activities)
        local data = {
            output = "",
            normalisedOutput = "",
            eligibleCount = 0,
            tt = GetString(_G.BARSTEWARD_RANDOM_DUNGEON)
        }
        local nd = dungeonInfo[_G.LFG_ACTIVITY_DUNGEON]
        local vd = dungeonInfo[_G.LFG_ACTIVITY_MASTER_DUNGEON]

        if (nd) then
            data.activityData = nd
            data.label = _G.SI_DUNGEONDIFFICULTY1
            data.icon = BS.DUNGEON[_G.LFG_ACTIVITY_DUNGEON]
            data = getActvityOutput(data)
        end

        if (vd) then
            data.activityData = vd
            data.label = _G.SI_DUNGEONDIFFICULTY2
            data.icon = BS.DUNGEON[_G.LFG_ACTIVITY_MASTER_DUNGEON]
            data = getActvityOutput(data)
        end

        widget:SetValue(data.output, data.normalisedOutput)
        widget.tooltip = data.tt

        return data.eligibleCount
    end,
    event = _G.EVENT_PLAYER_ACTIVATED,
    icon = "/esoui/art/icons/achievement_update11_dungeons_019.dds",
    hideWhenEqual = 0,
    tooltip = GetString(_G.BARSTEWARD_RANDOM_DUNGEON),
    onClick = function()
        if (IsInGamepadPreferredMode()) then
            SCENE_MANAGER:Show("gamepadDungeonFinder")
        else
            SCENE_MANAGER:Show("groupMenuKeyboard")
        end
    end
}

BS.widgets[BS.W_RANDOM_BATTLEGROUND] = {
    -- v1.4.23
    name = "randomBattleground",
    update = function(widget)
        local activities = {_G.LFG_ACTIVITY_BATTLE_GROUND_LOW_LEVEL, _G.LFG_ACTIVITY_BATTLE_GROUND_NON_CHAMPION}
        local bgInfo = getActivityRewardInfo(activities)
        local data = {
            output = "",
            normalisedOutput = "",
            eligibleCount = 0,
            tt = BS.Format(_G.SI_BATTLEGROUND_FINDER_RANDOM_FILTER_TEXT)
        }
        local ll = bgInfo[_G.LFG_ACTIVITY_BATTLE_GROUND_LOW_LEVEL] -- Random Battleground
        --local cp = bgInfo[_G.LFG_ACTIVITY_BATTLE_GROUND_CHAMPION]
        local np = bgInfo[_G.LFG_ACTIVITY_BATTLE_GROUND_NON_CHAMPION] -- Group Battleground
        local battleground = ll
        local icon = BS.BATTLEGROUND_ICON[_G.LFG_ACTIVITY_BATTLE_GROUND_LOW_LEVEL]

        if (np) then
            if (np.meetsRequirements) then
                battleground = np
                icon = BS.BATTLEGROUND_ICON[_G.LFG_ACTIVITY_BATTLE_GROUND_NON_CHAMPION]
            end
        end

        data.activityData = battleground
        data.label = ""
        data.icon = icon

        if (battleground) then
            data = getActvityOutput(data)
        end

        widget:SetValue(data.output, data.normalisedOutput)
        widget.tooltip = data.tt

        return data.eligibleCount
    end,
    event = _G.EVENT_PLAYER_ACTIVATED,
    icon = "/esoui/art/icons/store_battleground.dds",
    hideWhenEqual = 0,
    tooltip = BS.Format(_G.SI_BATTLEGROUND_FINDER_RANDOM_FILTER_TEXT),
    onClick = function()
        if (IsInGamepadPreferredMode()) then
            SCENE_MANAGER:Show("gamepadDungeonFinder")
        else
            SCENE_MANAGER:Show("groupMenuKeyboard")
        end
    end
}

BS.widgets[BS.W_RANDOM_TRIBUTE] = {
    -- v1.4.23
    name = "randomTribute",
    update = function(widget)
        local activities = {_G.LFG_ACTIVITY_TRIBUTE_COMPETITIVE, _G.LFG_ACTIVITY_TRIBUTE_CASUAL}
        local bgInfo = getActivityRewardInfo(activities)
        local data = {
            output = "",
            normalisedOutput = "",
            eligibleCount = 0,
            tt = GetString(_G.BARSTEWARD_RANDOM_TRIBUTE)
        }
        local ct = bgInfo[_G.LFG_ACTIVITY_TRIBUTE_COMPETITIVE]
        local nt = bgInfo[_G.LFG_ACTIVITY_TRIBUTE_CASUAL]

        if (nt) then
            data.activityData = nt
            data.label = _G.SI_LFGACTIVITY10
            data.icon = BS.TRIBUTE_ICON[_G.LFG_ACTIVITY_TRIBUTE_CASUAL]
            data = getActvityOutput(data)
        end

        if (ct) then
            data.activityData = ct
            data.label = _G.SI_LFGACTIVITY9
            data.icon = BS.TRIBUTE_ICON[_G.LFG_ACTIVITY_TRIBUTE_COMPETITIVE]
            data = getActvityOutput(data)
        end

        widget:SetValue(data.output, data.normalisedOutput)
        widget.tooltip = data.tt

        return data.eligibleCount
    end,
    event = _G.EVENT_PLAYER_ACTIVATED,
    icon = "/esoui/art/icons/u34_tribute_tutorial.dds",
    hideWhenEqual = 0,
    tooltip = GetString(_G.BARSTEWARD_RANDOM_TRIBUTE),
    onClick = function()
        if (IsInGamepadPreferredMode()) then
            SCENE_MANAGER:Show("gamepadDungeonFinder")
        else
            SCENE_MANAGER:Show("groupMenuKeyboard")
        end
    end
}
