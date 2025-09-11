local _, gc = ...
local L = gc.L

local defaultsTable = {
	SplitParagraphs = true,
	Indent = false,
	TTSButton = {locked = true, show = true, scale = 1, x = -35, y = 0, point = "CENTER", relativePoint = "RIGHT",},
	AutoTTS = false,
	Interrupt = true,
	Format = false,
    ChatFrame = 1,
	VoiceThey = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceHe = {show = true, voiceID = 2, rate = 0, volume = 100,},
	VoiceShe = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceUnk = {show = true, voiceID = 2, rate = 0, volume = 100,},
};

local function InitDefaults(tbl, defs)
	for k, v in pairs(defs) do
		if type(v) == "table" then
			if type(tbl[k]) ~= "table" then tbl[k] = {} end
			InitDefaults(tbl[k], v);
		else
			if tbl[k] == nil then
				tbl[k] = v;
			end
		end
	end
end

local GossipTracker = CreateFrame("Frame");
GossipTracker:RegisterEvent("GOSSIP_SHOW");
GossipTracker:RegisterEvent("TRAINER_SHOW");
GossipTracker:RegisterEvent("QUEST_PROGRESS");
GossipTracker:RegisterEvent("QUEST_COMPLETE");
GossipTracker:RegisterEvent("QUEST_DETAIL");
GossipTracker:RegisterEvent("ITEM_TEXT_READY");
GossipTracker:RegisterEvent("QUEST_GREETING");
GossipTracker:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_STARTED");
GossipTracker:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_FINISHED");
GossipTracker:RegisterEvent("ADDON_LOADED");
GossipTracker:RegisterEvent("GOSSIP_CLOSED");
GossipTracker:RegisterEvent("QUEST_FINISHED");
GossipTracker:RegisterEvent("QUEST_TURNED_IN");

GossipTracker.buttonPress = false

local senderTTS = " "
local bodyTTS = ""
GossipTracker.textPlaying = false
local recentDialogs = {}
local maxDialogs = 15


------------------------------------------------------------------------------------------------------------------

local function GetVoiceSettings(useUnk)
	if useUnk then
		return GossipChatter_DB.VoiceUnk
	end

	local sex = UnitSex("target")
	if sex == 1 then
		return GossipChatter_DB.VoiceThey
	elseif sex == 2 then
		return GossipChatter_DB.VoiceHe
	elseif sex == 3 then
		return GossipChatter_DB.VoiceShe
	else
		return GossipChatter_DB.VoiceUnk
	end
end

function GossipTracker:Speak(text, useUnk)
	-- handle interruptions
	if self.textPlaying then
		if self.buttonPress or GossipChatter_DB.Interrupt then
			C_VoiceChat.StopSpeakingText()
			self.buttonPress = false
			return
		end
	end

	-- pick text body depending on format
	local msg = text
	if GossipChatter_DB.Format then
		local bingus = string.format(CHAT_SAY_GET, senderTTS)
		msg = bingus .. msg
	end
	local settings = GetVoiceSettings(useUnk)

	C_VoiceChat.SpeakText(settings.voiceID, msg, 1, settings.rate, settings.volume)
end

local function IsDuplicateDialog(text)
	for _, v in ipairs(recentDialogs) do
		if v == text then
			return true
		end
	end
	return false
end

local function AddRecentDialog(text)
	table.insert(recentDialogs, text)
	if #recentDialogs > maxDialogs then
		table.remove(recentDialogs, 1) -- remove oldest
	end
end

------------------------------------------------------------------------------------------------------------------

local BUTTON_SIZE = 24
local OFFSET_X, OFFSET_Y = -15, 0

GossipTracker.ttsButtonLocked = true
GossipTracker.ttsButtonParentFrames = { QuestFrame.TitleContainer or QuestNpcNameFrame, GossipFrame.TitleContainer, ItemTextFrame.TitleContainer or ItemTextFrame }

--local function LockUnlockMenuGenerator(owner, rootDescription)
--	local label = GossipTracker.ttsButtonLocked and "Unlock TTS Button" or "Lock TTS Button"
--	rootDescription:CreateButton(label, function()
--		GossipTracker.ttsButtonLocked = not GossipTracker.ttsButtonLocked
--		--print("TTS Button " .. (GossipTracker.ttsButtonLocked and "locked" or "unlocked"))
--	end)
--end

local function CreateTTSButton(parentFrame, isItemText)
	if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then -- classic era
		if parentFrame == GossipFrame.TitleContainer then
			parentFrame = GossipFrame
		end
	end
	local button = CreateFrame("Button", nil, parentFrame)
	button:SetSize(BUTTON_SIZE, BUTTON_SIZE)
	if parentFrame == QuestNpcNameFrame then -- classic era
		OFFSET_X = -25
	end
	if parentFrame == ItemTextFrame then -- classic era
		OFFSET_X = -15*4.5
		OFFSET_Y = -25
		button:SetPoint("CENTER", parentFrame, "TOPRIGHT", OFFSET_X, OFFSET_Y)
	elseif parentFrame == GossipFrame then -- classic era
		OFFSET_X = -15*4.5
		OFFSET_Y = -30
		button:SetPoint("CENTER", parentFrame, "TOPRIGHT", OFFSET_X, OFFSET_Y)
	else
		button:SetPoint("CENTER", parentFrame, "RIGHT", OFFSET_X, OFFSET_Y)
	end
	--button:SetClampedToScreen(true)

	button.tex = button:CreateTexture(nil, "ARTWORK", nil, 1)
	button.tex:SetAllPoints(button)
	button.tex:SetAtlas("chatframe-button-icon-TTS")
	button.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)

	button:SetNormalAtlas("chatframe-button-up")
	button:SetPushedAtlas("chatframe-button-down")
	button:SetHighlightAtlas("chatframe-button-highlight")

	button:SetScript("OnMouseDown", function(self)
		self.tex:SetTexCoord(-.08, 1.16, -.16, 1.08)
	end)

	button:SetScript("OnMouseUp", function(self, buttonClicked)
		self.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)

		--if buttonClicked == "RightButton" then
		--	-- show lock/unlock menu
		--	MenuUtil.CreateContextMenu(self, LockUnlockMenuGenerator)
		--	return
		--end

		-- only speak if locked
		--if GossipTracker.ttsButtonLocked then
			GossipTracker:Speak(bodyTTS, isItemText)
			GossipTracker.buttonPress = true
		--end
	end)

	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:AddLine(L["ButtonSpeechTT"])
		GameTooltip:Show()
	end)

	button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)

	return button
end

-- create buttons for all frames
GossipTracker.ttsButtons = {}
for _, frame in ipairs(GossipTracker.ttsButtonParentFrames) do
	local isItemText = (frame == ItemTextFrame.TitleContainer or frame == ItemTextFrame)
	table.insert(GossipTracker.ttsButtons, CreateTTSButton(frame, isItemText))
end




------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------


local function RegisterGossipChatterSettings()
	local category, layout = Settings.RegisterVerticalLayoutCategory("Gossip Chatter")

	local CreateDropdown = Settings.CreateDropdown or Settings.CreateDropDown
	local CreateCheckbox = Settings.CreateCheckbox or Settings.CreateCheckBox

	local function RegisterSetting(key, defaultValue, name, subKey)
		local unique
		local setting
		if subKey then
			unique = "GC_" .. key .. "_" .. subKey
			setting = Settings.RegisterAddOnSetting(category, unique, subKey, GossipChatter_DB[key], type(defaultValue), name, defaultValue)
			setting:SetValue(GossipChatter_DB[key][subKey]) -- nested
		else
			unique = "GC_" .. key
			setting = Settings.RegisterAddOnSetting(category, unique, key, GossipChatter_DB, type(defaultValue), name, defaultValue)
			setting:SetValue(GossipChatter_DB[key]) -- flat
		end
		return setting
	end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["Setting_General"]))

	do
		local setting = RegisterSetting("SplitParagraphs", GossipChatter_DB.SplitParagraphs or false, L["Setting_SplitParagraphs"])
		CreateCheckbox(category, setting, L["Setting_SplitParagraphsTT"])
	end
	do
		local setting = RegisterSetting("Indent", GossipChatter_DB.Indent or false, L["Setting_IndentParagraphs"])
		CreateCheckbox(category, setting, L["Setting_IndentParagraphsTT"])
	end

	do
	    local setting = Settings.RegisterAddOnSetting(category, "GC_ChatFrame", "ChatFrame", GossipChatter_DB, "number", L["Setting_OutputChatFrame"], 1)
	    setting:SetValue(GossipChatter_DB.ChatFrame or 1)

	    local function GetOptions()
	        local container = Settings.CreateControlTextContainer()
	        for i = 1, NUM_CHAT_WINDOWS do
	            local name = GetChatWindowInfo(i)
	            if name and name ~= "" then
	                container:Add(i, name)
	            else
	                container:Add(i, "ChatFrame " .. i)
	            end
	        end
	        return container:GetData()
	    end
	    CreateDropdown(category, setting, GetOptions, L["Setting_OutputChatFrameTT"])
	end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["Setting_TextToSpeech"]))
	do
		local setting = RegisterSetting("ShowButton", GossipChatter_DB.TTSButton.show or true, L["Setting_ShowButton"])
		CreateCheckbox(category, setting, L["Setting_ShowButtonTT"])
	end
	do
		local setting = RegisterSetting("AutoTTS", GossipChatter_DB.TTSButton.auto or false, L["Setting_AutoplayTTS"])
		CreateCheckbox(category, setting, L["Setting_AutoplayTTSTT"])
	end
	do
		local setting = RegisterSetting("Interrupt", GossipChatter_DB.Interrupt or false, L["Setting_InterruptTTS"])
		CreateCheckbox(category, setting, L["Setting_InterruptTTSTT"])
	end
	do
		local setting = RegisterSetting("Format", GossipChatter_DB.Format or false, L["Setting_FormatName"])
		CreateCheckbox(category, setting, L["Setting_FormatNameTT"])
	end


	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["Setting_VoiceOptions"]))

	local function AddVoiceControls(voiceKey, displayName)
		-- rate slider
		do
			local variable = voiceKey
			local subKey = "rate"
			local default = 0
			local setting = RegisterSetting(variable, default, displayName .. " "..L["Setting_Voice_Rate"], subKey)
			local opts = Settings.CreateSliderOptions(-10, 10, 1)
			opts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
			Settings.CreateSlider(category, setting, opts, "Adjust speech rate for " .. displayName)
		end

		-- volume slider
		do
			local variable = voiceKey
			local subKey = "volume"
			local default = 100
			local setting = RegisterSetting(variable, default, displayName .. " "..L["Setting_Voice_Volume"], subKey)
			local opts = Settings.CreateSliderOptions(0, 100, 1)
			opts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
			Settings.CreateSlider(category, setting, opts, "Adjust volume for " .. displayName)
		end

		-- voice dropdown
		do
			local variable = voiceKey
			local subKey = "voiceID"
			local default = 1
			local setting = RegisterSetting(variable, default, displayName .. " "..L["Setting_Voice_VoiceID"], subKey)
			local function GetOptions()
				local container = Settings.CreateControlTextContainer()
				for _, v in ipairs(C_VoiceChat.GetTtsVoices()) do
					container:Add(v.voiceID, v.name)
				end
				return container:GetData()
			end
			CreateDropdown(category, setting, GetOptions, string.format(L["Setting_Voice_DropdownTT"], displayName))
		end

		-- test button
		do
			local function OnButtonClick()
				local voiceID = GossipChatter_DB[voiceKey].voiceID or 1
				local rate    = GossipChatter_DB[voiceKey].rate or 0
				local volume  = GossipChatter_DB[voiceKey].volume or 100
				C_VoiceChat.SpeakText(voiceID, TEXT_TO_SPEECH_SAMPLE_TEXT, 1, rate, volume)
			end
			local initializer = CreateSettingsButtonInitializer(string.format(L["Setting_Voice_PlaySample"], displayName), TEXT_TO_SPEECH_PLAY_SAMPLE, OnButtonClick, L["Setting_Voice_PlaySampleTT"], true)
			layout:AddInitializer(initializer)
		end
	end

	AddVoiceControls("VoiceThey", "They/Them")
	AddVoiceControls("VoiceHe",   "He/Him")
	AddVoiceControls("VoiceShe",  "She/Her")
	AddVoiceControls("VoiceUnk",  "Item/Unknown")


	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("|Tinterface\\chatframe\\ui-chaticon-blizz:12:20|t" .. TEXT_TO_SPEECH_MORE_VOICES))

	Settings.RegisterAddOnCategory(category)
end


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

local function BuildBody(sender, text, chatFormat)
	if not text or text == "" then return nil end

	local body = (chatFormat and chatFormat:format(sender or "")) .. (text or "")

	-- deduplicate newlines
	body = body:gsub("\r\n", "\n"):gsub("\r", "\n"):gsub("|n", "\n"):gsub("\\n", "\n")
	body = body:gsub("\n+", "\n") -- collapse multiple newlines

	-- get emote color
	local emoteInfo = ChatTypeInfo["MONSTER_EMOTE"]
	local emoteColor = CreateColor(emoteInfo.r, emoteInfo.g, emoteInfo.b)

	-- <text in angle brackets> turn into emote-colored text
	body = body:gsub("<(.-)>", function(inner)
		return emoteColor:WrapTextInColorCode("<" .. inner .. ">")
	end)

	-- *text in asterisks* turn into emote-colored text (non-greedy to avoid over-matching)
	body = body:gsub("%*(.-)%*", function(inner)
		return emoteColor:WrapTextInColorCode("*" .. inner .. "*")
	end)

	return body
end

local function HandleOutput(sender, text, chatFormat, autoTTS, useUnk)
    local body = BuildBody(sender, text, chatFormat)
    if not body then return end

    if IsDuplicateDialog(body) then return end
    AddRecentDialog(body)

    if autoTTS then
        GossipTracker:Speak(text or bodyTTS, useUnk)
    end

    local info = ChatTypeInfo[useUnk and "MONSTER_EMOTE" or "MONSTER_SAY"]
    local ts = date(C_CVar.GetCVar("showTimestamps"))
    if ts == "none" or ts == nil then ts = "" end

    local indent = GossipChatter_DB.Indent and "  " or ""

    -- pick selected chat frame
    local frame = _G["ChatFrame"..(GossipChatter_DB.ChatFrame or 1)] or DEFAULT_CHAT_FRAME

    if GossipChatter_DB.SplitParagraphs then
        local first = true
        for line in body:gmatch("[^\n]+") do
            if first then
                frame:AddMessage(ts .. line, info.r, info.g, info.b, info.id)
                first = false
            else
                frame:AddMessage(indent..line, info.r, info.g, info.b, info.id)
            end
        end
    else
        frame:AddMessage(ts .. body, info.r, info.g, info.b, info.id)
    end
end


local eventHandlers = {
	GOSSIP_SHOW = function()
		return C_GossipInfo.GetText(), UnitName("npc") or GossipFrameTitleText:GetText() or UnitName("questnpc") or UnitName("target"), CHAT_SAY_GET
	end,
	QUEST_GREETING = function()
		return GetGreetingText(), UnitName("npc") or UnitName("questnpc"), CHAT_SAY_GET
	end,
	QUEST_PROGRESS = function()
		return GetProgressText(), UnitName("npc") or UnitName("questnpc"), CHAT_SAY_GET
	end,
	QUEST_COMPLETE = function()
		return GetRewardText(), UnitName("npc") or UnitName("questnpc"), CHAT_SAY_GET
	end,
	QUEST_DETAIL = function()
		return GetQuestText(), UnitName("npc") or UnitName("questnpc"), CHAT_SAY_GET
	end,
	ITEM_TEXT_READY = function()
		local text = ItemTextGetText()
		local sender = UnitName("npc") or ItemTextFrameTitleText:GetText() or UnitName("questnpc")
		local page = ItemTextCurrentPage and ItemTextCurrentPage:GetText() or ""
		return text and (page .. ": " .. text) or nil, sender, CHAT_EMOTE_GET, true
	end,
}


function GossipTracker:OnEvent(event,arg1)
	local timeStamps = date(C_CVar.GetCVar("showTimestamps"))
	if timeStamps == "none" or nil then
		timeStamps = "";
	end
	local info = ChatTypeInfo["MONSTER_SAY"]
	local pagenumber = ": ";
	if ItemTextCurrentPage == true then
		pagenumber = (ItemTextCurrentPage:GetText() .. ": ");
	else
		pagenumber = ": ";
	end
	if event == "VOICE_CHAT_TTS_PLAYBACK_STARTED" then
		self.textPlaying = true;
		return
	elseif event == "VOICE_CHAT_TTS_PLAYBACK_FINISHED" then
		self.textPlaying, self.buttonPress = false, false;
		return
	elseif event == "GOSSIP_CLOSED" or event == "QUEST_FINISHED" or event == "QUEST_TURNED_IN" then
		if self.textPlaying and GossipChatter_DB.Interrupt then
			C_VoiceChat.StopSpeakingText();
			self.textPlaying, self.buttonPress = false, false;
		end
		return
	elseif event == "ADDON_LOADED" and arg1 == "GossipChatter" then
		if not GossipChatter_DB then GossipChatter_DB = {} end
		InitDefaults(GossipChatter_DB, defaultsTable);
		RegisterGossipChatterSettings();
	end

	local handler = eventHandlers[event]
	if handler then
		local text, sender, chatFmt, useUnk = handler()
		if not text then return end
		bodyTTS = text
		senderTTS = sender
		HandleOutput(sender, text, chatFmt, GossipChatter_DB.AutoTTS, useUnk)
	end

end
GossipTracker:SetScript("OnEvent",GossipTracker.OnEvent);