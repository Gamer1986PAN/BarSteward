local BS = _G.BarSteward

local function Initialise()
    -- dialogs
    local buttons = {
        {
            text = GetString(_G.SI_OK),
            callback = function()
            end
        }
    }

    local notempty = {
        title = {text = GetString(_G.BARSTEWARD_NEWBAR_INVALID)},
        mainText = {text = GetString(_G.BARSTEWARD_NEWBAR_BLANK)},
        buttons = buttons
    }

    local exists = {
        title = {text = GetString(_G.BARSTEWARD_NEWBAR_INVALID)},
        mainText = {text = GetString(_G.BARSTEWARD_NEWBAR_EXISTS)},
        buttons = buttons
    }

    local reload = {
        title = {text = "Bar Steward"},
        mainText = {text = GetString(_G.BARSTEWARD_RELOAD_MSG)},
        buttons = {
            {
                text = GetString(_G.SI_OK),
                callback = function()
                    zo_callLater(
                        function()
                            ReloadUI()
                        end,
                        200
                    )
                end
            }
        }
    }

    local remove = {
        title = {text = GetString(_G.BARSTEWARD_REMOVE_BAR)},
        mainText = {text = GetString(_G.BARSTEWARD_REMOVE_WARNING)},
        buttons = {
            {
                text = GetString(_G.SI_CANCEL),
                callback = function()
                    BS.BarIndex = nil
                end
            }
        }
    }

    ZO_Dialogs_RegisterCustomDialog(BS.Name .. "NotEmpty", notempty)
    ZO_Dialogs_RegisterCustomDialog(BS.Name .. "Exists", exists)
    ZO_Dialogs_RegisterCustomDialog(BS.Name .. "Reload", reload)
    ZO_Dialogs_RegisterCustomDialog(BS.Name .. "Remove", remove)

    -- saved variables
    BS.Vars =
        _G.LibSavedVars:NewAccountWide("BarStewardSavedVars", "Account", BS.Defaults):AddCharacterSettingsToggle(
        "BarStewardSavedVars",
        "Characters"
    )

    BS.VersionCheck()
    BS.RegisterSettings()

    -- create bars
    local bars = BS.Vars.Bars
    local alignBars = {}

    for idx, barData in pairs(bars) do
        local widgets = {}
        local orderedWidgets = {}

        table.insert(alignBars, barData.Name)

        -- get the widgets for this bar
        for id, info in ipairs(BS.Vars.Controls) do
            if (info.Bar == idx) then
                local widget = BS.widgets[id]
                widget.id = id
                table.insert(widgets, {info.Order, widget})
            end
        end

        -- ensure the widgets are in the order we want them drawn
        table.sort(
            widgets,
            function(a, b)
                return a[1] < b[1]
            end
        )

        if (#widgets > 0) then
            -- ensure there are no gaps in the array sequence
            local widgetIndex = 1
            for _, v in ipairs(widgets) do
                orderedWidgets[widgetIndex] = v[2]
                widgetIndex = widgetIndex + 1
            end

            local bar =
                BS.CreateBar(
                {
                    index = idx,
                    position = barData.Orientation == GetString(_G.BARSTEWARD_HORIZONTAL) and TOP or LEFT,
                    scale = barData.Scale or GuiRoot:GetScale(),
                    settings = BS.Vars.Bars[idx]
                }
            )

            bar:AddWidgets(orderedWidgets)
        end

        if (BS.Vars.Bars[idx].NudgeCompass) then
            BS.NudgeCompass()
            -- from Bandits UI
            -- stop the game move the compass back to its original position
            local block = {ZO_CompassFrame_Keyboard_Template = true, ZO_CompassFrame_Gamepad_Template = true}
            local ZO_ApplyTemplateToControl = _G.ApplyTemplateToControl
            _G.ApplyTemplateToControl = function(control, templateName)
                if block[templateName] then
                    return
                else
                    ZO_ApplyTemplateToControl(control, templateName)
                end
            end
        end
    end

    BS.CreateAlignmentFrame(alignBars)
    BS.CreateLockButton()
    BS.CreateWidgetOrderTool(alignBars)

    -- add / remove ignore friends
    _G.SLASH_COMMANDS["/bsexclude"] = function(value)
        if ((value or "") == "") then
            return
        end

        local exclude = BS.Vars.Controls[BS.W_FRIENDS].Exclude or {}

        if (not zo_strfind(value, "@", 1, 2)) then
            value = "@" .. value
        end

        if (not exclude[value]) then
            exclude[value] = true
            BS.Vars.Controls[BS.W_FRIENDS].Exclude = exclude

            if (BS.Chat) then
                BS.Chat:SetTagColor("dc143c"):Print(zo_strformat(GetString(_G.BARSTEWARD_EXCLUDE), value))
            end
        else
            if (BS.Chat) then
                BS.Chat:SetTagColor("dc143c"):Print(zo_strformat(GetString(_G.BARSTEWARD_EXCLUDED), value))
            end
        end
    end

    _G.SLASH_COMMANDS["/bsinclude"] = function(value)
        if ((value or "") == "") then
            return
        end

        local exclude = BS.Vars.Controls[BS.W_FRIENDS].Exclude or {}

        if (not zo_strfind(value, "@", 1, 2)) then
            value = "@" .. value
        end

        if (exclude[value]) then
            exclude[value] = nil
            BS.Vars.Controls[BS.W_FRIENDS].Exclude = exclude

            if (BS.Chat) then
                BS.Chat:SetTagColor("dc143c"):Print(zo_strformat(GetString(_G.BARSTEWARD_INCLUDE), value))
            end
        else
            if (BS.Chat) then
                BS.Chat:SetTagColor("dc143c"):Print(zo_strformat(GetString(_G.BARSTEWARD_INCLUDE_NOT_THERE), value))
            end
        end
    end

    -- utiltity
    if (_G.SLASH_COMMANDS["/rl"] == nil) then
        _G.SLASH_COMMANDS["/rl"] = function()
            ReloadUI()
        end
    end
end

function BS.OnAddonLoaded(_, addonName)
    if (_G.LibChatMessage ~= nil) then
        BS.Chat = _G.LibChatMessage(BS.Name, "Bar Steward")
    end

    if (addonName ~= BS.Name) then
        return
    end

    EVENT_MANAGER:UnregisterForEvent(BS.Name, _G.EVENT_ADD_ON_LOADED)

    Initialise()
end

EVENT_MANAGER:RegisterForEvent(BS.Name, _G.EVENT_ADD_ON_LOADED, BS.OnAddonLoaded)
