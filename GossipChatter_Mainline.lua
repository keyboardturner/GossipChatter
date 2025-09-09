local defaultsTable = {
	SplitParagraphs = true,
	Indent = false,
	TTSButton = {locked = true, show = true, scale = 1, x = -35, y = 0, point = "CENTER", relativePoint = "RIGHT",},
	AutoTTS = false,
	Interrupt = true,
	Format = true,
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

GossipTracker.button = CreateFrame("Button", nil, QuestFrame.TitleContainer)
GossipTracker.button:SetPoint("CENTER", QuestFrame.TitleContainer, "RIGHT", -35, 0)
GossipTracker.button:SetWidth(24)
GossipTracker.button:SetHeight(24)
GossipTracker.button.tex = GossipTracker.button:CreateTexture(nil, "ARTWORK", nil, 1)
GossipTracker.button.tex:SetAllPoints(GossipTracker.button)
GossipTracker.button.tex:SetAtlas("chatframe-button-icon-TTS")
GossipTracker.button.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
GossipTracker.button:SetNormalAtlas("chatframe-button-up")
GossipTracker.button:SetPushedAtlas("chatframe-button-down")
GossipTracker.button:SetHighlightAtlas("chatframe-button-highlight")


GossipTracker.button:SetScript("OnMouseDown", function()
	GossipTracker.button.tex:SetTexCoord(-.08, 1.16, -.16, 1.08)
end)
GossipTracker.button:SetScript("OnMouseUp", function()
	GossipTracker:Speak(bodyTTS, false)
	GossipTracker.buttonPress = true
	GossipTracker.button.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
end)

------------------------------------------------------------------------------------------------------------------

GossipTracker.button2 = CreateFrame("Button", nil, GossipFrame.TitleContainer)
GossipTracker.button2:SetPoint("CENTER", GossipFrame.TitleContainer, "RIGHT", -35, 0)
GossipTracker.button2:SetWidth(24)
GossipTracker.button2:SetHeight(24)
GossipTracker.button2.tex = GossipTracker.button2:CreateTexture(nil, "ARTWORK", nil, 1)
GossipTracker.button2.tex:SetAllPoints(GossipTracker.button2)
GossipTracker.button2.tex:SetAtlas("chatframe-button-icon-TTS")
GossipTracker.button2.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
GossipTracker.button2:SetNormalAtlas("chatframe-button-up")
GossipTracker.button2:SetPushedAtlas("chatframe-button-down")
GossipTracker.button2:SetHighlightAtlas("chatframe-button-highlight")


GossipTracker.button2:SetScript("OnMouseDown", function()
	GossipTracker.button2.tex:SetTexCoord(-.08, 1.16, -.16, 1.08)
end)
GossipTracker.button2:SetScript("OnMouseUp", function()
	GossipTracker:Speak(bodyTTS, false)
	GossipTracker.buttonPress = true
	GossipTracker.button2.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
end)

GossipTracker.button3 = CreateFrame("Button", nil, ItemTextFrame.TitleContainer)
GossipTracker.button3:SetPoint("CENTER", ItemTextFrame.TitleContainer, "RIGHT", -35, 0)
GossipTracker.button3:SetWidth(24)
GossipTracker.button3:SetHeight(24)
GossipTracker.button3.tex = GossipTracker.button3:CreateTexture(nil, "ARTWORK", nil, 1)
GossipTracker.button3.tex:SetAllPoints(GossipTracker.button3)
GossipTracker.button3.tex:SetAtlas("chatframe-button-icon-TTS")
GossipTracker.button3.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
GossipTracker.button3:SetNormalAtlas("chatframe-button-up")
GossipTracker.button3:SetPushedAtlas("chatframe-button-down")
GossipTracker.button3:SetHighlightAtlas("chatframe-button-highlight")

GossipTracker.button3:SetScript("OnMouseDown", function()
	GossipTracker.button3.tex:SetTexCoord(-.08, 1.16, -.16, 1.08)
end)
GossipTracker.button3:SetScript("OnMouseUp", function()
	GossipTracker:Speak(bodyTTS, true)
	GossipTracker.buttonPress = true
	GossipTracker.button3.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
end)


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

	-- === General ===
	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("General"))

	do
		local setting = RegisterSetting("AutoTTS", GossipChatter_DB.TTSButton.auto or false, "Auto-play Text To Speech")
		CreateCheckbox(category, setting, "Automatically play NPC text with Text to Speech.")
	end
	do
		local setting = RegisterSetting("ShowButton", GossipChatter_DB.TTSButton.show or true, "Show Button on Frame")
		CreateCheckbox(category, setting, "Show the TTS button on Gossip/Quest/Item frames.")
	end
	do
		local setting = RegisterSetting("Interrupt", GossipChatter_DB.Interrupt or false, "Interrupt Text To Speech")
		CreateCheckbox(category, setting, "Interrupt Text To Speech if you close a gossip or quest frame.")
	end
	do
		local setting = RegisterSetting("Format", GossipChatter_DB.Format or true, "Format NPC Name")
		CreateCheckbox(category, setting, "Prefix Text To Speech chat messages with the NPC’s name.")
	end
	do
		local setting = RegisterSetting("SplitParagraphs", GossipChatter_DB.SplitParagraphs or false, "Split paragraphs into separate messages")
		CreateCheckbox(category, setting, "Print each paragraph as its own chat message instead of a single block.")
	end

	-- === Voices ===
	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Voice Settings"))

	local function AddVoiceControls(voiceKey, displayName)
		-- rate slider
		do
			local variable = voiceKey
			local subKey = "rate"
			local default = 0
			local setting = RegisterSetting(variable, default, displayName .. " Rate", subKey)
			local opts = Settings.CreateSliderOptions(-10, 10, 1)
			opts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
			Settings.CreateSlider(category, setting, opts, "Adjust speech rate for " .. displayName)
		end

		-- volume slider
		do
			local variable = voiceKey
			local subKey = "volume"
			local default = 100
			local setting = RegisterSetting(variable, default, displayName .. " Volume", subKey)
			local opts = Settings.CreateSliderOptions(0, 100, 1)
			opts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
			Settings.CreateSlider(category, setting, opts, "Adjust volume for " .. displayName)
		end

		-- voice dropdown
		do
			local variable = voiceKey
			local subKey = "voiceID"
			local default = 1
			local setting = RegisterSetting(variable, default, displayName .. " Voice", subKey)
			local function GetOptions()
				local container = Settings.CreateControlTextContainer()
				for _, v in ipairs(C_VoiceChat.GetTtsVoices()) do
					container:Add(v.voiceID, v.name)
				end
				return container:GetData()
			end
			CreateDropdown(category, setting, GetOptions, "Choose the TTS voice for " .. displayName)
		end

		-- test button
		do
			local function OnButtonClick()
				local voiceID = GossipChatter_DB[voiceKey].voiceID or 1
				local rate    = GossipChatter_DB[voiceKey].rate or 0
				local volume  = GossipChatter_DB[voiceKey].volume or 100
				C_VoiceChat.SpeakText(voiceID, TEXT_TO_SPEECH_SAMPLE_TEXT, 1, rate, volume)
			end
			local initializer = CreateSettingsButtonInitializer("Play Sample: " .. displayName, TEXT_TO_SPEECH_PLAY_SAMPLE, OnButtonClick, "Hear an example of this voice with current settings.", true)
			layout:AddInitializer(initializer)
		end
	end

	AddVoiceControls("VoiceThey", "They/Them")
	AddVoiceControls("VoiceHe",   "He/Him")
	AddVoiceControls("VoiceShe",  "She/Her")
	AddVoiceControls("VoiceUnk",  "Item/Unknown")

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

	-- deduplication - skip if body was printed recently
	if IsDuplicateDialog(body) then return end
	AddRecentDialog(body)

	if autoTTS then
		GossipTracker:Speak(text or bodyTTS, useUnk)
	end

	local info = ChatTypeInfo[useUnk and "MONSTER_EMOTE" or "MONSTER_SAY"]
	local ts = date(C_CVar.GetCVar("showTimestamps"))
	if ts == "none" or ts == nil then ts = "" end

	local indent = ""
	if GossipChatter_DB.IndentParagraphs then
		indent = "  "
	end

	if GossipChatter_DB.SplitParagraphs then
		local first = true
		for line in body:gmatch("[^\n]+") do
			if first then
				DEFAULT_CHAT_FRAME:AddMessage(ts .. line, info.r, info.g, info.b, info.id)
				first = false
			else
				DEFAULT_CHAT_FRAME:AddMessage(indent..line, info.r, info.g, info.b, info.id)
			end
		end
	else
		-- original single-message print
		DEFAULT_CHAT_FRAME:AddMessage(ts .. body, info.r, info.g, info.b, info.id)
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