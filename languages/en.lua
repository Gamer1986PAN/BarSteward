-- English localisation
-- luacheck: push ignore 631
local L = function(t, v)
    ZO_CreateStringId("BARSTEWARD_" .. t, v)
end

L("12", "12 Hour")
L("24", "24 Hour")
L("ACTIVE_BAR", "Active Bar")
L("ADD_SEPARATORS", "Add number separators")
L("ADD_WIDGET", "Add Widget")
L("ALIGN", "Centre Align")
L("ALIGN_BAR", "Align Bar")
L("ALIGN_BAR_ANCHOR", "Anchor")
L("ALIGN_BARS", "Align Bars")
L("ALIGN_RELATIVE", "Relative to")
L("ALREADY_COLLECTED", "Already Collected")
L("AMBER", "Amber")
L("ANNOUNCEMENT", "Show Warning Announcement")
L("ANNOUNCEMENT_FRIEND", "Show Friend Online Announcement")
L("ANNOUNCEMENT_FRIEND_GUILD", "Show Guild Friend Online Announcement")
L("ANNOUNCEMENTS", "Announcements")
L("AP_BUFF", "Alliance Point Buff")
L("ASSISTANT_WIDGET", "Assistant - <<1>>")
L("ASSISTANTS", "Assistants")
L("AUTOHIDE", "Autohide")
L("AUTOHIDE_TOOLTIP", "Hide this widget when the value reaches zero (or the max value for Rapport) or is blank")
L("BACK_BAR", "Back bar")
L("BACK_BAR_ICON", "Back Bar Icon")
L("BACK_BAR_TEXT", "Back Bar Text")
L("BACKDROP_COLOUR", "Background Colour")
L("BACKGROUND_STYLE", "Background Style")
L("BACKGROUND_STYLE_1", "Quickslot")
L("BACKGROUND_STYLE_2", "Black Fade")
L("BACKGROUND_STYLE_3", "Codex")
L("BACKGROUND_STYLE_4", "Icon")
L("BACKGROUND_STYLE_5", "Conversation")
L("BACKGROUND_STYLE_6", "Overlay")
L("BACKGROUND_STYLE_7", "Scroll")
L("BACKGROUND_STYLE_8", "Achievements")
L("BACKGROUND_STYLE_9", "Cooldown")
L("BACKGROUND_STYLE_10", "Ava")
L("BACKGROUND_STYLE_11", "Aldmeri")
L("BACKGROUND_STYLE_12", "Daggerfall")
L("BACKGROUND_STYLE_13", "Ebonheart")
L("BACKGROUND_STYLE_14", "Cloudy")
L("BAG_FREE", "Show free space")
L("BAG_FREE_TOOLTIP", "Show free space instead of used space")
L("BANK", "Bank Space")
L("BAR", "Bar")
L("BARS", "Bars")
L("BAR_ALIGN", "Bar Steward Alignment")
L("BAR_ANCHOR", "Bar Anchor")
L("BAR_NAME", "Bar Name (hit Enter when done)")
L("BORDER_STYLE", "Border")
L("BORDER_STYLE_1", "World Map")
L("BORDER_STYLE_2", "Blue")
L("BORDER_STYLE_3", "Gold")
L("BORDER_STYLE_4", "Red")
L("BORDER_STYLE_5", "Chat Window")
L("BORDER_STYLE_6", "Conversation")
L("BORDER_STYLE_7", "Highlight")
L("BOTH", "Both")
L("BOTTOM", "Bottom")
L("BOUNTY_AMOUNT", "Bounty Amount")
L("BUILD_INFO", "Build information will update when you equip or save a build")
L("BUTTON_ALIGN", "Align")
L("CATEGORY_ABILITIES", "Abilities")
L("CATEGORY_ACTIVITIES", "Activities")
L("CATEGORY_CHARACTER", "Character")
L("CATEGORY_CLIENT", "Client")
L("CATEGORY_COMPANIONS", "Companions")
L("CATEGORY_CRAFTING", "Crafting")
L("CATEGORY_CURRENCY", "Currency")
L("CATEGORY_INCLUDE", "Show category count")
L("CATEGORY_INVENTORY", "Inventory")
L("CATEGORY_RIDING", "Riding")
L("CATEGORY_SOCIAL", "Social")
L("CATEGORY_THIEVERY", "Thievery")
L("CATEGORY_USE", "Use widget categories")
L("CHANGE", "Change name (hit Enter when done)")
L("CHANGE_DEFAULT", "Change Default Colour")
L("CHANGE_DEFAULTOK", "Change Default OK Colour")
L("CHANGE_DEFAULTWARNING", "Change Default Warning Colour")
L("CHANGE_DEFAULTDANGER", "Change Default Danger Colour")
L("COLLECTIBLE_FRAGMENTS", "Collectible Fragments")
L("COMBAT_COLOUR", "Change Colour During Combat")
L("COMBAT_COLOUR_BACKDROP", "Combat Backdrop Colour")
L("COMPLETED", "Completed")
L("COMPANION_LEVEL", "Active Companion Level")
L("COMPANION_WIDGET", "Companion - <<1>>")
L("CONDITION", "Condition")
L("CONFIGURE", "Configure")
L(
    "COPY",
    "Select the text below, then use ctrl-c to copy it. The text can then be pasted into Bar Steward's 'Import Bar' box for another user."
)
L("COPY_SETTINGS", "Copy Settings")
L("CRAFTING_MOTIFS", "Crafting Motifs")
L("DAILY_CRAFTING", "Daily Crafting Writs")
L("DAILY_ENDEAVOUR_PROGRESS_BEST", "Daily Endeavour Best Progress")
L("DAILY_ENDEAVOUR_PROGRESS", "Daily Endeavour Progress")
L("DAILY_ENDEAVOUR_TIME", "Daily Endeavour Time Remaining")
L("DAILY_PLEDGES", "Daily Undaunted Pledges")
L("DAILY_PLEDGES_TIME", "Daily Undaunted Pledges Time Remaining")
L("DAILY_QUEST_COUNT", "Daily Quest Count")
L("DAILY_WRITS_TIME", "Daily Crafting Writs Time Remaining")
L("DANGER_COLOUR", "Danger")
L("DANGER_VALUE", "Danger value")
L("DAYS", "<<1[days/1 day/$d days]>>")
L("DAYS_ONLY", "Days only")
L("DAYS_ONLY_TOOLTIP", "Show the remaining time in days only until less than one day remains.")
L("DEBOUNCE", "Debounce time (minutes)")
L("DEBOUNCE_DESC", "Period of time to wait between consecutive announcements")
L("DECIMAL_PLACES", "Decimal places")
L("DEFAULT_COLOUR", "Default")
L("DELETE", "Permanently delete tracked character data")
L("DELETE_FOR", "Permanently delete tracked character data for <<1>>?")
L("DELIVER", "deliver")
L("DISABLE", "Disable")
L("DISPLAY", "Display")
L("DPS", "DPS")
L("DUNGEON_REWARD_RESET", "Time to dungeon reward reset")
L("DURABILITY", "Lowest Item Durability")
L("EDGE_DEFAULT", "Default")
L("EDGE_GAMEPAD", "Gamepad")
L("EDGE_MAP", "World Map")
L("EMPTY", "Empty")
L("ENABLE_CONDITIONAL", "Enable Conditional Bar Hiding")
L("ENLIGHTENED", "Enlightened Amount")
L("EQUIPPED_POISON", "Equipped Poison")
L("EXPAND", "Expand bar to full screen width")
L("EXPAND_TOOLTIP", "Only works with horizontal bars and does not affect widget spacing")
L("EXPERIMENTAL", "Experimental")
L("EXPERIMENTAL_DESC", "This widget is under development, please feel free to submit feedback.")
L("EXPORT", "Export")
L("EXPORT_BAR", "Export Bar")
L("FENCE", "Fence Transactions")
L("FENCE_RESET", "Fence Reset Timer")
L("FILLED", "Filled")
L("FIXED_WIDTH", "Fixed Width")
L("FONT", "Font")
L("FONT_SIZE", "Font Size")
L("FONT_STYLE", "Font Style")
L("FOOD_BUFF", "Food/Drink Buff")
L("FOUND_CHESTS", "Chests found in the current dungeon")
L("FPS", "FPS")
L("FRIEND_ONLINE", "Friend Online")
L("FRIEND_ONLINE_MESSAGE", "<<1>> (<<2>>) has come online")
L("GENERIC_EXISTS", "This selection has already been used. Please select another one.")
L("GENERIC_INVALID", "Invalid Selection")
L("GENERIC_BLANK", "The selection cannot be blank.")
L("GENERIC_INVALID", "Invalid Selection")
L("GENERIC_REMOVE", "Remove")
L("GENERIC_REMOVE_WARNING", "The selection will be permanently deleted!")
L("GOLD_BAG", "In your bags")
L("GOLD_BANK", "In your bank")
L("GOLD_COMBINED", "Bank and bags")
L("GOLD_DISPLAY", "Display")
L("GOLD_EVERYWHERE", "Everywhere")
L("GOLD_SEPARATED", "Bank/bags")
L("GREEN", "Green")
L("GRID_SIZE", "Snap to grid Size")
L("GRID_SIZE_VISIBLE", "Visible grid Size")
L("GUILD_FRIEND_ONLINE", "Guild Friend Online")
L("GUILD_FRIENDS", "Guild Friends")
L("GUILD_FRIENDS_MONITORING", "Guild Friends Monitoring")
L("GUILD_FRIENDS_ONLINE", "Guild Friends Online")
L("HIDE_DURING_COMBAT", "Hide during combat")
L("HIDE_LIMIT", "Hide limit")
L("HIDE_LIMIT_TOOLTIP", "Don't show the maximum amount applicable to this widget")
L("HIDE_MAX", "Hide when maximum level")
L("HIDE_MOUSE", "Hide mouse icon in tooltips")
L("HIDE_SECONDS", "Hide seconds")
L("HIDE_TEXT", "Hide text")
L("HIDE_TIMER", "Hide timer")
L("HIDE_WHEN_COMPLETE", "Hide when complete")
L(
    "HIDE_WHEN_COMPLETE_TOOLTIP",
    "Hide when no more traits can be researched for this crafting type. This settings will override any Autohide setting."
)
L("HIDE_WHEN_DEAD", "Hide when dead")
L("HIDE_WHEN_FULLY_USED", "Hide when fully in use")
L("HIDE_WHEN_FULLY_USED_TOOLTIP", "Hide when all availble slots/options are being used")
L("HIDE_WIDGET_ICON", "Hide widget icon")
L("HIDE_ZERO_DAYS", "Hide days when zero")
L("HIGHEST", "Highest score")
L("HORIZONTAL", "Horizontal")
L("HOURS", "Hours")
L("ICONGAP", "Gap between the icon and the text")
L("IMPORT", "Import")
L("IMPORT_BAR", "Import Bar")
L("IMPORT_ERROR_BAR", "Missing bar information")
L("IMPORT_ERROR_DATA", "Invalid data format")
L("IMPORT_ERROR_WIDGET", "Missing widget information")
L("IMPORT_ERROR_WIDGET_OR_BAR", "Missing bar or widget information")
L("IN_PROGRESS", "In progress")
L("INFINITE_ARCHIVE_PORT", "Travel to the Infinite Archive")
L("INFINITE_ARCHIVE_PROGRESS", "Infinite Archive Progress")
L("INFINITE_ARCHIVE_SCORE", "Infinite Archive Score")
L("INFINITE_ARCHIVE_SHOW", "Only show in Infinite Archive")
L("INVERT", "Invert Warning/Danger logic")
L(
    "INVERT_TOOLTIP",
    "Change the logic so values higher than those entered trigger the colour change. Default behaviour triggers on lower values."
)
L("ITEM_EXISTS", "This item has already been added to the watchlist.")
L("ITEM_ID", "Item id")
L("ITEM_INVALID", "Invalid Item Id")
L("KPH", "kph")
L("LATENCY", "Latency")
L("LAUNDER", "Launder Transactions")
L("LEFT", "Left")
L("LOCK_FRAMES", "Lock Bars")
L("LOREBOOKS", "Lorebooks")
L("LOREBOOKS_CATEGORY", "Display totals for category")
L("MAIN_BAR", "Main Bar")
L("MAIN_BAR_REPLACE", "Replace Main Bar")
L("MAIN_BAR_REPLACE_CONFIRM", "Are you sure you want to replace your Main Bar?")
L("MAIN_BAR_ICON", "Main Bar Icon")
L("MAINTENANCE", "Maintenance")
L("MAX_MESSAGE", "Maximum length reached")
L("MAX_COLOUR", "Maximum")
L("MAX_VALUE", "Check maximum value")
L("MAIN_BAR_TEXT", "Main Bar Text")
L("MEMORY", "Memory Usage")
L("MIDDLE", "Middle")
L("MINUTES", "Minutes")
L("MOUNT_TRAINING", "Time until next mount training")
L(
    "MOVE_WIDGETS",
    "This bar contains <<1[no widgets/1 widget/$d widgets]>> that will be moved to the new bar from their current bar. Do you want to proceed?"
)
L("MOVEFRAME", "Movable Bars")
L("MPH", "mph")
L("NEW_BAR", "Create New Bar")
L("NEW_BAR_DEFAULT_NAME", "New Bar <<1>>")
L("NEWBAR_ADD", "Add New Bar")
L("NEWBAR_BLANK", "The bar name cannot be blank.")
L("NEWBAR_EXISTS", "This bar name has already been used. Please use a new one.")
L("NEWBAR_INVALID", "Invalid Bar Name")
L("NEWBAR_NAME", "New Bar Name (hit Enter when done)")
L("NEWBAR_WARNING", "Adding a new bar will force a UI reload")
L("NO_LIMIT_COLOUR", "No limit colour")
L("NO_LIMIT_COLOUR_TOOLTIP", "Don't add a colour to the maximum value")
L("NONE", "Nothing to train")
L("NONE_BAR", "None")
L("NOT_APPLICABLE", "N/A")
L("NOT_COLLECTED", "Not Collected")
L("NOT_PICKED_UP", "Not picked up")
L("NOT_VAMPIRE", "Not a vampire")
L("NUDGE", "Nudge the compass down")
L("NUDGE_WARNING", "If you have moved the compass with another addon, this setting could have strange results")
L("NUMBER_GROUPING", "3")
L("NUMBER_SEPARATOR", ",")
L("NUMBER_SEPARATORS", "Number separators")
L("OK_COLOUR", "OK")
L("OK_VALUE", "OK value")
L("ONLINE_ONLY", "Online only")
L("ONLINE_ONLY_TOOLTIP", "Online show online friends in the tooltip.")
L("ORIENTATION", "Orientation")
L("OVERRIDE", "Override settings for this bar")
L("PADDING_HORIZONTAL", "Horizontal padding")
L("PADDING_VERTICAL", "Vertical padding")
L("PASTE", "Paste the code for the new bar below, then click the 'Import' button")
L("PERCENTAGE", "Show as percentage")
L("PERFORMANCE", "Performance")
L("PERFORMANCE_TIMERS", "Disable timers during combat")
L(
    "PERFORMANCE_TIMERS_TOOLTIP",
    "Disable timer based widgets (except the time), during combat. This will reduce the number of potentially performance impacting updates."
)
L("PLAYER_EXPERIENCE", "Player Experience")
L("PLAYER_LOCATION", "Player Location")
L("PORT_TO_HOUSE", "Port to House")
L("PORT_TO_HOUSE_DESCRIPTION", "Create a new widget to port to one of your houses")
L("PORT_TO_HOUSE_LOCATION_ONLY", "Show Location Only")
L("PORT_TO_HOUSE_LOCATION_TOO", "Show Location Too")
L("PORT_TO_HOUSE_PTF", "Port To Friend's House locations will  have <<1>> appended to their widget.")
L("PORT_TO_HOUSE_PTF_INFO", "Newly added/removed houses will require a UI reload.")
L("PORT_TO_HOUSE_PREVIEW", "Preview")
L("PORT_TO_HOUSE_SELECT", "Select House")
L("PREVIOUS_ENCOUNTER", "Previous Encounter")
L("PREVIOUS_ENCOUNTER_AVERAGE", "Average DPS")
L("PREVIOUS_ENCOUNTER_DURATION", "Duration")
L("PREVIOUS_ENCOUNTER_MAXIMUM", "Maximum DPS")
L("PICKED_UP", "Picked up")
L("PROGRESS_GRADIENT_END", "Gradient end")
L("PROGRESS_GRADIENT_START", "Gradient start")
L("PROGRESS_VALUE", "Progress value")
L("PVP_NEVER", "Don't show in PvP")
L("PVP_ONLY", "Only show in PvP")
L("RANDOM_BATTLEGROUND", "Random Battleground")
L("RANDOM_DUNGEON", "Random Dungeon")
L("RANDOM_EMOTE", "Use Random Emote")
L("RANDOM_MEMENTO", "Use Random Memento")
L("RANDOM_MOUNT", "Select Random Mount")
L("RANDOM_PET", "Summon Random Pet")
L("RANDOM_PRINT", "Print selection in chat window")
L("RANDOM_RECENT", "Most recently used")
L("RANDOM_TRIBUTE", "Random Tales of Tribute")
L("RAPPORT", "Active Companion Rapport")
L("READY", "Ready for hand in")
L("RECALL", "Recall Cooldown")
L("RECIPES", "Recipes Found")
L("RECIPES_DISPLAY", "Display")
L("RED", "Red")
L("RELOAD", "UI reload required")
L("RELOAD_MSG", "The UI will now reload.")
L("REMOVE_BAR", "Remove Bar")
L("REMOVE_WARNING", "This will permanently delete the selected bar!")
L("REORDER", "Reorder")
L("REORDER_WIDGETS", "Reorder Widgets")
L("REPAIR_COST", "Item Repair Cost")
L("REQUIRES", "Requires <<1>>")
L("RIGHT", "Right")
L("RUNEBOX_FRAGMENTS", "Runebox Fragments")
L("SAMPLE", " *** Sample text in the selected font ***")
L("SCALE", "Scale")
L("SCREEN", "Screen")
L("SECONDS", "Seconds")
L("SELECT_ALL", "Select All")
L("SELECT_NONE", "Select None")
L("SERVER", "Server")
L("SETTINGS", "Settings may not appear correctly until a UI reload.")
L("SHADOWY_VENDOR_RESET", "Time to Shadowy Supplier reset")
L("SHORTEN", "Shorten Name (remove Boon:)")
L("SHOW_BACKDROP", "Show Background")
L("SHOW_CLASS_ICON", "Show Class Icon")
L("SHOW_EVERYWHERE", "Show Everywhere")
L("SHOW_FOUND", "Show Found")
L("SHOW_GRID", "Show Grid")
L("SHOW_LEAD_COUNT", "Show lead count")
L("SHOW_SLOTS", "Show crafting slots")
L("SHOW_STOLEN_SLOTS", "Show slot count")
L("SHOW_TEXT", "Show text")
L("SHOW_TEXT_TOOLTIP", "Show text instead of icon")
L("SHOW_UNSPENT", "Show unspent points")
L("SHOW_WHILST_BANKING", "Show Whilst Banking")
L("SHOW_WHILST_CRAFTING", "Show Whilst Crafting")
L("SHOW_WHILST_GUILDSTORE", "Show Whilst in Guild Store")
L("SHOW_WHILST_INTERACTING", "Show Whilst Interacting")
L("SHOW_WHILST_INVENTORY", "Show Whilst in Inventory")
L("SHOW_WHILST_MAIL", "Show Whilst in Mail")
L("SHOW_WHILST_MENU", "Show Whilst in Game Menu")
L("SHOW_WHILST_SIEGE", "Show Whilst in Siege")
L("SHOW_XP_PC", "Show experience percent")
L("SKILL_POINTS", "Available Skill Points")
L("SKYSHARDS_SKILL_POINTS", "<<1>>/3 skyshards for next skill point")
L("SNAP", "Snap To Grid When Moving Bars")
L("SOUL_GEMS_TYPE", "Soul Gem type")
L("SOUL_GEMS", "Soul Gems")
L("SOUND", "Sound")
L("SOUND_VALUE_BELOW", "Play sound when value below")
L("SOUND_VALUE_EQUALS", "Play sound when value matches")
L("SOUND_VALUE_EXCEEDS", "Play sound when value exceeds")
L("SORT", "Sort widgets by most recently added first")
L("SORT_USED", "Sort widgets by used/unused")
L("SPEED", "Movement Speed")
L("SPEED_UNITS", "Speed Units")
L("STOLEN", "Stolen Items in Inventory")
L("TAMRIEL_TIME", "Tamriel Time")
L("THIS_ACCOUNT", "This Account")
L("THIS_CHARACTER", "This Character")
L("TIER_POINTS", "Tier <<1>>, Points <<2>>")
L("TIME_FORMAT_12", "12hr Time Format")
L("TIME_FORMAT_24", "24hr Time Format")
L("TIMER", "Timer <<1>>")
L("TIMER_NONE", "No timers enabled")
L("TIMER_NOTE", "Important, use the format mins:secs, e.g. 4:50")
L("TIMER_TIP", "Right-click for timers")
L("TIMER_WARNING", "Timers will not persist beyond logout or UI reload.")
L("TIMERS", "Countdown Timers")
L("TIMER_FORMAT", "Timer Format")
L("TIMER_FORMAT_TEXT", "<<1>>d <<2>>h <<3>>m")
L("TIMER_FORMAT_TEXT_NO_DAYS", "<<1>>h <<2>>m")
L("TIMER_FORMAT_TEXT_WITH_SECONDS", "<<1>>d <<2>>h <<3>>m <<4>>s")
L("TIMER_FORMAT_TEXT_WITH_SECONDS_NO_DAYS", "<<1>>h <<2>>m <<3>>s")
L("TOGGLE", "Toggle <<1>>")
L("TOTAL_VALUE", "Total value: <<1>>")
L("TOOLTIP_ANCHOR", "Tooltip Anchor")
L("TOP", "Top")
L("TRAINING_PROGRESS", "Mount Training Progress")
L("TRANSMUTE_CRYSTALS", "Transmute Crystals")
L("TRIBUTE_RANK", "Tales of Tribute Club Rank")
L("TROPHY_VAULT_KEYS", "Trophy Vault Keys")
L("TWELVE_TWENTY_FOUR", "12/24 Hour")
L("UNDAUNTED_KEYS", "Undaunted Keys")
L("UNKNOWN_WRIT_MOTIFS", "Missing Writ Motifs")
L("UNSLOTTED", "Unslotted")
L("UNSLOTTED_OPTION", "Show Unslotted Count")
L("UNSLOTTED_TOOLTIP", "Show the number of empty champion point slots")
L("UNSPENT", "Unspent")
L("USE_ALTERNATE", "Use alternate icon")
L("USE_FONT_CORRECTION", "Use font size correction (experimental)")
L(
    "USE_FONT_CORRECTION_TOOLTIP",
    "When the font size is set to less than the default, some widgets may have their values truncated. This setting attempts to compensate for that."
)
L("USE_ICONS", "Use Icons")
L("USE_PROGRESS", "Use progress bar")
L("USE_RAG", "Use red/amber/green progress colours")
L("USE_WRITWORTHY", "Use WritWorthy for writ summaries")
L(
    "USE_WRITWORTHY_TOOLTIP",
    "Use WritWorthy for writ summaries if installed. Note, if you have a lot of writs this could cause a slight stutter each time your bag slots update."
)
L("VALUE", "Value")
L("VALUE_SIDE", "Value Side")
L("VAMPIRE_FEED_TIMER", "Vampire feed timer")
L("VAMPIRE_SHOW_STAGE", "Show stage")
L("VAMPIRE_STAGE", "<<1>> <<2>>(Stage <<3>>)<<4>>")
L("VAMPIRE_STAGE_TIMER", "Vampirism stage timer")
L("VERTICAL", "Vertical")
L("WARN_INSTANCE", "Warn when entering an instance")
L("WARN_INSTANCE_BACK_BAR", "Only warn when back bar is active")
L("WARN_INSTANCE_MESSAGE", "<<1>> is active")
L("WARNING", "Warning!")
L("WARNING_BAGS", "Your bags are almost full!")
L("WARNING_COLOUR", "Warning")
L("WARNING_EVENT_TICKETS", "Spend your event tickets!")
L("WARNING_EXPIRING", "<<1>> expiring soon!")
L("WARNING_VALUE", "Warning value")
L("WATCHED_ITEM_ALERT", "Watched Item Alert!")
L("WATCHED_ITEM_MESSAGE", "<<1>> found")
L("WATCHED_ITEMS", "Item Watcher")
L("WEAPON_CHARGE", "Weapon Charge")
L("WEEKLY_ENDEAVOUR_PROGRESS", "Weekly Endeavour Progress")
L("WEEKLY_ENDEAVOUR_PROGRESS_BEST", "Weekly Endeavour Best Progress")
L("WEEKLY_ENDEAVOUR_TIME", "Weekly Endeavour Time Remaining")
L("WIDGET", "Widget")
L("WIDGET_ICON_SIZE", "Widget icon size")
L("WIDGETS", "Widgets")
L("WIDGET_ORDERING", "Bar Steward Widget Ordering")
L("WRIT_ALCHEMY", "Alchemist Writ")
L("WRIT_BLACKSMITHING", "Blacksmith Writ")
L("WRIT_CLOTHIER", "Clothier Writ")
L("WRIT_ENCHANTING", "Enchanter Writ")
L("WRIT_JEWELLERY", "Jewelry Crafting Writ")
L("WRIT_PROVISIONING", "Provisioner Writ")
L("WRIT_WOODWORKING", "Woodworker Writ")
L("WRITS", "Master Writs/Surveys/Treasure Maps")
L("WRITS_WRITS", "<<1[No Master Writs/1 Master Writ/$d Master Writs]>>")
L("WRITS_SURVEYS", "<<1[No Surveys/1 Survey/$d Surveys]>>")
L("WRITS_MAPS", "<<1[No Treasure Maps/1 Treasure Map/$s Treasure Maps]>>")
L("XP_BUFF", "Experience Point Buff")

-- Saved Vars
L("ACCOUNT_WIDE", "Account-wide Settings")
L("ACCOUNT_WIDE_TOOLTIP", "All the settings below will be the same for each of your characters.")

-- Slash commands
L("SLASH_ENABLE", "enable")
L("SLASH_HIDE", "hide")
L("SLASH_SHOW", "show")
--luacheck: pop
