local defaultsTable = {
	VoiceThey = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceHe = {show = true, voiceID = 2, rate = 0, volume = 100,},
	VoiceShe = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceUnk = {show = true, voiceID = 2, rate = 0, volume = 100,},
	Interrupt = false,
	TTSButton = {auto = false, locked = true, show = true, scale = 1, x = -35, y = 0, point = "CENTER", relativePoint = "RIGHT",},
	Format = true,
};

local GossipTracker = CreateFrame("Frame");
GossipTracker:RegisterEvent("GOSSIP_SHOW");
GossipTracker:RegisterEvent("TRAINER_SHOW");
GossipTracker:RegisterEvent("GOSSIP_CLOSED");
GossipTracker:RegisterEvent("QUEST_PROGRESS");
GossipTracker:RegisterEvent("QUEST_COMPLETE");
GossipTracker:RegisterEvent("QUEST_DETAIL");
GossipTracker:RegisterEvent("ITEM_TEXT_READY");
GossipTracker:RegisterEvent("QUEST_GREETING");
GossipTracker:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_STARTED");
GossipTracker:RegisterEvent("VOICE_CHAT_TTS_PLAYBACK_FINISHED");
GossipTracker:RegisterEvent("ADDON_LOADED");
GossipTracker.buttonPress = false

local sender = " "
local body = ""
local grabText = ""
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

	-- pick text body or grabText depending on format
	local msg = GossipChatter_DB.Format and text or grabText
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
	GossipTracker:Speak(body, false)
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
	GossipTracker:Speak(body, false)
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
	GossipTracker:Speak(body, true)
	GossipTracker.buttonPress = true
	GossipTracker.button3.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
end)


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------


local GossipChatterPanel = CreateFrame("FRAME");
GossipChatterPanel.name = "Gossip Chatter";

GossipChatterPanel.Headline = GossipChatterPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GossipChatterPanel.Headline:SetFont(GossipChatterPanel.Headline:GetFont(), 23);
GossipChatterPanel.Headline:SetTextColor(1,.73,0,1);
GossipChatterPanel.Headline:ClearAllPoints();
GossipChatterPanel.Headline:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-12);
GossipChatterPanel.Headline:SetText("Gossip Chatter");

GossipChatterPanel.Version = GossipChatterPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GossipChatterPanel.Version:SetFont(GossipChatterPanel.Version:GetFont(), 12);
GossipChatterPanel.Version:SetTextColor(1,1,1,1);
GossipChatterPanel.Version:ClearAllPoints();
GossipChatterPanel.Version:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",400,-21);
GossipChatterPanel.Version:SetText("Version: " .. C_AddOns.GetAddOnMetadata("GossipChatter", "Version"));

GossipChatterPanel.Hyperlink = GossipChatterPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
GossipChatterPanel.Hyperlink:SetFont(GossipChatterPanel.Hyperlink:GetFont(), 12);
GossipChatterPanel.Hyperlink:SetTextColor(1,1,1,1);
GossipChatterPanel.Hyperlink:ClearAllPoints();
GossipChatterPanel.Hyperlink:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",350,-21*2);
GossipChatterPanel.Hyperlink:SetText("|Tinterface\\chatframe\\ui-chaticon-blizz:12:20|t" .. TEXT_TO_SPEECH_MORE_VOICES);

GossipChatterPanel:SetHyperlinksEnabled(true)
GossipChatterPanel:SetScript("OnHyperlinkClick", function(self, link, text, button)
	SetItemRef(link, text, button, self)
end)

------------------------------------------------------------------------------------------------------------------
--[[
--button scale slider
GossipChatterPanel.ButtonScale = CreateFrame("Slider", "GCButtonPanelSliderScale", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.ButtonScale:SetWidth(150);
GossipChatterPanel.ButtonScale:SetHeight(15);
GossipChatterPanel.ButtonScale:SetMinMaxValues(50,150);
GossipChatterPanel.ButtonScale:SetValueStep(1);
--GossipChatterPanel.ButtonScale:SetObeyStepOnDrag(true)
GossipChatterPanel.ButtonScale:ClearAllPoints();
GossipChatterPanel.ButtonScale:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53*7);
getglobal(GossipChatterPanel.ButtonScale:GetName() .. 'Low'):SetText(SMALL);
getglobal(GossipChatterPanel.ButtonScale:GetName() .. 'High'):SetText(LARGE);
getglobal(GossipChatterPanel.ButtonScale:GetName() .. 'Text'):SetText(HUD_EDIT_MODE_SETTING_UNIT_FRAME_FRAME_SIZE);
GossipChatterPanel.ButtonScale:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.ButtonScale:GetName()):GetValue() / 100;
	GossipChatter_DB.TTSButton.scale = scaleValue;
	GossipTracker.button:SetScale(defaultsTable.TTSButton.scale);
	GossipTracker.button2:SetScale(defaultsTable.TTSButton.scale);
	GossipTracker.button3:SetScale(defaultsTable.TTSButton.scale);
	GossipTracker.ReStuff()
end)
]]
------------------------------------------------------------------------------------------------------------------

--speech rate slider
GossipChatterPanel.SpeedSliderThey = CreateFrame("Slider", "GCSpeedPanelSliderThey", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.SpeedSliderThey:SetWidth(150);
GossipChatterPanel.SpeedSliderThey:SetHeight(15);
GossipChatterPanel.SpeedSliderThey:SetMinMaxValues(-10,10);
GossipChatterPanel.SpeedSliderThey:SetValueStep(1);
GossipChatterPanel.SpeedSliderThey:SetObeyStepOnDrag(true)
GossipChatterPanel.SpeedSliderThey:ClearAllPoints();
GossipChatterPanel.SpeedSliderThey:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53*2);
getglobal(GossipChatterPanel.SpeedSliderThey:GetName() .. 'Low'):SetText(SLOW);
getglobal(GossipChatterPanel.SpeedSliderThey:GetName() .. 'High'):SetText(FAST);
getglobal(GossipChatterPanel.SpeedSliderThey:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_RATE);
GossipChatterPanel.SpeedSliderThey:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.SpeedSliderThey:GetName()):GetValue();
	GossipChatter_DB.VoiceThey.rate = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

--volume slider
GossipChatterPanel.VolumeSliderThey = CreateFrame("Slider", "GCVolumePanelSliderThey", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.VolumeSliderThey:SetWidth(150);
GossipChatterPanel.VolumeSliderThey:SetHeight(15);
GossipChatterPanel.VolumeSliderThey:SetMinMaxValues(0,100);
GossipChatterPanel.VolumeSliderThey:SetValueStep(1);
GossipChatterPanel.VolumeSliderThey:SetObeyStepOnDrag(true)
GossipChatterPanel.VolumeSliderThey:ClearAllPoints();
GossipChatterPanel.VolumeSliderThey:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",170,-53*2);
getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'Low'):SetText('');
getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'High'):SetText('PH');
getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_VOLUME);
GossipChatterPanel.VolumeSliderThey:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.VolumeSliderThey:GetName()):GetValue();
	getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'High'):SetText(string.format("%.0f %%", scaleValue));
	GossipChatter_DB.VoiceThey.volume = scaleValue;
end)

------------------------------------------------------------------------------------------------------------------

--speech rate slider
GossipChatterPanel.SpeedSliderHe = CreateFrame("Slider", "GCSpeedPanelSliderHe", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.SpeedSliderHe:SetWidth(150);
GossipChatterPanel.SpeedSliderHe:SetHeight(15);
GossipChatterPanel.SpeedSliderHe:SetMinMaxValues(-10,10);
GossipChatterPanel.SpeedSliderHe:SetValueStep(1);
GossipChatterPanel.SpeedSliderHe:SetObeyStepOnDrag(true)
GossipChatterPanel.SpeedSliderHe:ClearAllPoints();
GossipChatterPanel.SpeedSliderHe:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53*3);
getglobal(GossipChatterPanel.SpeedSliderHe:GetName() .. 'Low'):SetText(SLOW);
getglobal(GossipChatterPanel.SpeedSliderHe:GetName() .. 'High'):SetText(FAST);
getglobal(GossipChatterPanel.SpeedSliderHe:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_RATE);
GossipChatterPanel.SpeedSliderHe:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.SpeedSliderHe:GetName()):GetValue();
	GossipChatter_DB.VoiceHe.rate = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

--volume slider
GossipChatterPanel.VolumeSliderHe = CreateFrame("Slider", "GCVolumePanelSliderHe", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.VolumeSliderHe:SetWidth(150);
GossipChatterPanel.VolumeSliderHe:SetHeight(15);
GossipChatterPanel.VolumeSliderHe:SetMinMaxValues(0,100);
GossipChatterPanel.VolumeSliderHe:SetValueStep(1);
GossipChatterPanel.VolumeSliderHe:SetObeyStepOnDrag(true)
GossipChatterPanel.VolumeSliderHe:ClearAllPoints();
GossipChatterPanel.VolumeSliderHe:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",170,-53*3);
getglobal(GossipChatterPanel.VolumeSliderHe:GetName() .. 'Low'):SetText('');
getglobal(GossipChatterPanel.VolumeSliderHe:GetName() .. 'High'):SetText('PH');
getglobal(GossipChatterPanel.VolumeSliderHe:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_VOLUME);
GossipChatterPanel.VolumeSliderHe:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.VolumeSliderHe:GetName()):GetValue();
	getglobal(GossipChatterPanel.VolumeSliderHe:GetName() .. 'High'):SetText(string.format("%.0f %%", scaleValue));
	GossipChatter_DB.VoiceHe.volume = scaleValue;
end)

------------------------------------------------------------------------------------------------------------------

--speech rate slider
GossipChatterPanel.SpeedSliderShe = CreateFrame("Slider", "GCSpeedPanelSliderShe", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.SpeedSliderShe:SetWidth(150);
GossipChatterPanel.SpeedSliderShe:SetHeight(15);
GossipChatterPanel.SpeedSliderShe:SetMinMaxValues(-10,10);
GossipChatterPanel.SpeedSliderShe:SetValueStep(1);
GossipChatterPanel.SpeedSliderShe:SetObeyStepOnDrag(true)
GossipChatterPanel.SpeedSliderShe:ClearAllPoints();
GossipChatterPanel.SpeedSliderShe:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53*4);
getglobal(GossipChatterPanel.SpeedSliderShe:GetName() .. 'Low'):SetText(SLOW);
getglobal(GossipChatterPanel.SpeedSliderShe:GetName() .. 'High'):SetText(FAST);
getglobal(GossipChatterPanel.SpeedSliderShe:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_RATE);
GossipChatterPanel.SpeedSliderShe:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.SpeedSliderShe:GetName()):GetValue();
	GossipChatter_DB.VoiceShe.rate = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

--volume slider
GossipChatterPanel.VolumeSliderShe = CreateFrame("Slider", "GCVolumePanelSliderShe", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.VolumeSliderShe:SetWidth(150);
GossipChatterPanel.VolumeSliderShe:SetHeight(15);
GossipChatterPanel.VolumeSliderShe:SetMinMaxValues(0,100);
GossipChatterPanel.VolumeSliderShe:SetValueStep(1);
GossipChatterPanel.VolumeSliderShe:SetObeyStepOnDrag(true)
GossipChatterPanel.VolumeSliderShe:ClearAllPoints();
GossipChatterPanel.VolumeSliderShe:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",170,-53*4);
getglobal(GossipChatterPanel.VolumeSliderShe:GetName() .. 'Low'):SetText('');
getglobal(GossipChatterPanel.VolumeSliderShe:GetName() .. 'High'):SetText('PH');
getglobal(GossipChatterPanel.VolumeSliderShe:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_VOLUME);
GossipChatterPanel.VolumeSliderShe:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.VolumeSliderShe:GetName()):GetValue();
	getglobal(GossipChatterPanel.VolumeSliderShe:GetName() .. 'High'):SetText(string.format("%.0f %%", scaleValue));
	GossipChatter_DB.VoiceShe.volume = scaleValue;
end)

------------------------------------------------------------------------------------------------------------------

--speech rate slider
GossipChatterPanel.SpeedSliderUnk = CreateFrame("Slider", "GCSpeedPanelSliderUnk", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.SpeedSliderUnk:SetWidth(150);
GossipChatterPanel.SpeedSliderUnk:SetHeight(15);
GossipChatterPanel.SpeedSliderUnk:SetMinMaxValues(-10,10);
GossipChatterPanel.SpeedSliderUnk:SetValueStep(1);
GossipChatterPanel.SpeedSliderUnk:SetObeyStepOnDrag(true)
GossipChatterPanel.SpeedSliderUnk:ClearAllPoints();
GossipChatterPanel.SpeedSliderUnk:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53*5);
getglobal(GossipChatterPanel.SpeedSliderUnk:GetName() .. 'Low'):SetText(SLOW);
getglobal(GossipChatterPanel.SpeedSliderUnk:GetName() .. 'High'):SetText(FAST);
getglobal(GossipChatterPanel.SpeedSliderUnk:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_RATE);
GossipChatterPanel.SpeedSliderUnk:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.SpeedSliderUnk:GetName()):GetValue();
	GossipChatter_DB.VoiceUnk.rate = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

--volume slider
GossipChatterPanel.VolumeSliderUnk = CreateFrame("Slider", "GCVolumePanelSliderUnk", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.VolumeSliderUnk:SetWidth(150);
GossipChatterPanel.VolumeSliderUnk:SetHeight(15);
GossipChatterPanel.VolumeSliderUnk:SetMinMaxValues(0,100);
GossipChatterPanel.VolumeSliderUnk:SetValueStep(1);
GossipChatterPanel.VolumeSliderUnk:SetObeyStepOnDrag(true)
GossipChatterPanel.VolumeSliderUnk:ClearAllPoints();
GossipChatterPanel.VolumeSliderUnk:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",170,-53*5);
getglobal(GossipChatterPanel.VolumeSliderUnk:GetName() .. 'Low'):SetText('');
getglobal(GossipChatterPanel.VolumeSliderUnk:GetName() .. 'High'):SetText('PH');
getglobal(GossipChatterPanel.VolumeSliderUnk:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_VOLUME);
GossipChatterPanel.VolumeSliderUnk:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.VolumeSliderUnk:GetName()):GetValue();
	getglobal(GossipChatterPanel.VolumeSliderUnk:GetName() .. 'High'):SetText(string.format("%.0f %%", scaleValue));
	GossipChatter_DB.VoiceUnk.volume = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

GossipChatterPanel.AutoCheckbox = CreateFrame("CheckButton", "GCP_AutoCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.AutoCheckbox:ClearAllPoints();
GossipChatterPanel.AutoCheckbox:SetPoint("TOPLEFT", 350, -53);
getglobal(GossipChatterPanel.AutoCheckbox:GetName().."Text"):SetText("Auto-play Text To Speech");

GossipChatterPanel.AutoCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.AutoCheckbox:GetChecked() then
		GossipChatter_DB.TTSButton.auto = true;
	else
		GossipChatter_DB.TTSButton.auto = false;
	end
end);

------------------------------------------------------------------------------------------------------------------

GossipChatterPanel.ShowCheckbox = CreateFrame("CheckButton", "GCP_ShowCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.ShowCheckbox:ClearAllPoints();
GossipChatterPanel.ShowCheckbox:SetPoint("TOPLEFT", 350, -53*1.5);
getglobal(GossipChatterPanel.ShowCheckbox:GetName().."Text"):SetText("Show Button on Frame");

GossipChatterPanel.ShowCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.ShowCheckbox:GetChecked() then
		GossipChatter_DB.TTSButton.show = true;
		GossipTracker.button:Show()
		GossipTracker.button2:Show()
		GossipTracker.button3:Show()
	else
		GossipChatter_DB.TTSButton.show = false;
		GossipTracker.button:Hide()
		GossipTracker.button2:Hide()
		GossipTracker.button3:Hide()
	end
end);

------------------------------------------------------------------------------------------------------------------
--[[
GossipChatterPanel.LockCheckbox = CreateFrame("CheckButton", "GCP_LockCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.LockCheckbox:ClearAllPoints();
GossipChatterPanel.LockCheckbox:SetPoint("TOPLEFT", 350, -53*7);
getglobal(GossipChatterPanel.LockCheckbox:GetName().."Text"):SetText("Lock Button Position");

GossipChatterPanel.LockCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.LockCheckbox:GetChecked() then
		GossipChatter_DB.TTSButton.locked = true;
	else
		GossipChatter_DB.TTSButton.locked = false;
	end
end);
]]

------------------------------------------------------------------------------------------------------------------

GossipChatterPanel.InterruptCheckbox = CreateFrame("CheckButton", "GCP_InterruptCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.InterruptCheckbox:ClearAllPoints();
GossipChatterPanel.InterruptCheckbox:SetPoint("TOPLEFT", 520, -53);
getglobal(GossipChatterPanel.InterruptCheckbox:GetName().."Text"):SetText("Interrupt Auto-TTS");

GossipChatterPanel.InterruptCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.InterruptCheckbox:GetChecked() then
		GossipChatter_DB.Interrupt = true;
	else
		GossipChatter_DB.Interrupt = false;
	end
end);


------------------------------------------------------------------------------------------------------------------

GossipChatterPanel.FormatCheckbox = CreateFrame("CheckButton", "GCP_FormatCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.FormatCheckbox:ClearAllPoints();
GossipChatterPanel.FormatCheckbox:SetPoint("TOPLEFT", 520, -53*1.5);
getglobal(GossipChatterPanel.FormatCheckbox:GetName().."Text"):SetText("Format NPC Name");

GossipChatterPanel.FormatCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.FormatCheckbox:GetChecked() then
		GossipChatter_DB.Format = true;
	else
		GossipChatter_DB.Format = false;
	end
end);

------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------

local TextExample = TEXT_TO_SPEECH_SAMPLE_TEXT
local favoriteNumberThey = 1 -- A user-configurable setting


GossipChatterPanel.dropDownThey = CreateFrame("FRAME", "WPDemodropDownThey", GossipChatterPanel, "UIDropDownMenuTemplate")
GossipChatterPanel.dropDownThey:SetPoint("TOPLEFT", 315, -53*2)
UIDropDownMenu_SetWidth(GossipChatterPanel.dropDownThey, 200)
UIDropDownMenu_SetText(GossipChatterPanel.dropDownThey, "Voice - They/Them: " .. favoriteNumberThey)




GossipChatterPanel.TestPlaybackThey = CreateFrame("Button", nil, GossipChatterPanel, "UIPanelButtonTemplate")
GossipChatterPanel.TestPlaybackThey:SetPoint("TOPLEFT", 550, -53*2)
GossipChatterPanel.TestPlaybackThey:SetText(TEXT_TO_SPEECH_PLAY_SAMPLE)
GossipChatterPanel.TestPlaybackThey:SetWidth(100)
GossipChatterPanel.TestPlaybackThey:SetScript("OnClick", function()
	C_VoiceChat.SpeakText(GossipChatter_DB.VoiceThey.voiceID, TextExample, 1, GossipChatter_DB.VoiceThey.rate, GossipChatter_DB.VoiceThey.volume)
end)

------------------------------------------------------------------------------------------------------------------

local favoriteNumberHe = 1 -- A user-configurable setting


GossipChatterPanel.dropDownHe = CreateFrame("FRAME", "WPDemodropDownHe", GossipChatterPanel, "UIDropDownMenuTemplate")
GossipChatterPanel.dropDownHe:SetPoint("TOPLEFT", 315, -53*3)
UIDropDownMenu_SetWidth(GossipChatterPanel.dropDownHe, 200)
UIDropDownMenu_SetText(GossipChatterPanel.dropDownHe, "Voice - He/Him: " .. favoriteNumberHe)




GossipChatterPanel.TestPlaybackHe = CreateFrame("Button", nil, GossipChatterPanel, "UIPanelButtonTemplate")
GossipChatterPanel.TestPlaybackHe:SetPoint("TOPLEFT", 550, -53*3)
GossipChatterPanel.TestPlaybackHe:SetText(TEXT_TO_SPEECH_PLAY_SAMPLE)
GossipChatterPanel.TestPlaybackHe:SetWidth(100)
GossipChatterPanel.TestPlaybackHe:SetScript("OnClick", function()
	C_VoiceChat.SpeakText(GossipChatter_DB.VoiceHe.voiceID, TextExample, 1, GossipChatter_DB.VoiceHe.rate, GossipChatter_DB.VoiceHe.volume)
end)

------------------------------------------------------------------------------------------------------------------

local favoriteNumberShe = 1 -- A user-configurable setting


GossipChatterPanel.dropDownShe = CreateFrame("FRAME", "WPDemodropDownShe", GossipChatterPanel, "UIDropDownMenuTemplate")
GossipChatterPanel.dropDownShe:SetPoint("TOPLEFT", 315, -53*4)
UIDropDownMenu_SetWidth(GossipChatterPanel.dropDownShe, 200)
UIDropDownMenu_SetText(GossipChatterPanel.dropDownShe, "Voice - She/Her: " .. favoriteNumberShe)




GossipChatterPanel.TestPlaybackShe = CreateFrame("Button", nil, GossipChatterPanel, "UIPanelButtonTemplate")
GossipChatterPanel.TestPlaybackShe:SetPoint("TOPLEFT", 550, -53*4)
GossipChatterPanel.TestPlaybackShe:SetText(TEXT_TO_SPEECH_PLAY_SAMPLE)
GossipChatterPanel.TestPlaybackShe:SetWidth(100)
GossipChatterPanel.TestPlaybackShe:SetScript("OnClick", function()
	C_VoiceChat.SpeakText(GossipChatter_DB.VoiceShe.voiceID, TextExample, 1, GossipChatter_DB.VoiceShe.rate, GossipChatter_DB.VoiceShe.volume)
end)

------------------------------------------------------------------------------------------------------------------

local favoriteNumberUnk = 1 -- A user-configurable setting


GossipChatterPanel.dropDownUnk = CreateFrame("FRAME", "WPDemodropDownUnk", GossipChatterPanel, "UIDropDownMenuTemplate")
GossipChatterPanel.dropDownUnk:SetPoint("TOPLEFT", 315, -53*5)
UIDropDownMenu_SetWidth(GossipChatterPanel.dropDownUnk, 200)
UIDropDownMenu_SetText(GossipChatterPanel.dropDownUnk, "Voice - Item: " .. favoriteNumberUnk)




GossipChatterPanel.TestPlaybackUnk = CreateFrame("Button", nil, GossipChatterPanel, "UIPanelButtonTemplate")
GossipChatterPanel.TestPlaybackUnk:SetPoint("TOPLEFT", 550, -53*5)
GossipChatterPanel.TestPlaybackUnk:SetText(TEXT_TO_SPEECH_PLAY_SAMPLE)
GossipChatterPanel.TestPlaybackUnk:SetWidth(100)
GossipChatterPanel.TestPlaybackUnk:SetScript("OnClick", function()
	C_VoiceChat.SpeakText(GossipChatter_DB.VoiceUnk.voiceID, TextExample, 1, GossipChatter_DB.VoiceUnk.rate, GossipChatter_DB.VoiceUnk.volume)
end)

------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------

--final
local category, layout = Settings.RegisterCanvasLayoutCategory(GossipChatterPanel, GossipChatterPanel.name, GossipChatterPanel.name);
category.ID = GossipChatterPanel.name;
Settings.RegisterAddOnCategory(category)

--InterfaceOptions_AddCategory(GossipChatterPanel);


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

local function BuildBody(sender, text, chatFormat)
	if not text or text == "" then return nil end

	local body = (chatFormat and chatFormat:format(sender or "")) .. (text or "")

	-- deduplicate newlines
	body = body:gsub("\n+", "\n")
	body = body:gsub("|n+", "\n")

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
		GossipTracker:Speak(GossipChatter_DB.Format and body or text, useUnk)
	end

	local info = ChatTypeInfo[useUnk and "MONSTER_EMOTE" or "MONSTER_SAY"]
	local ts = date(C_CVar.GetCVar("showTimestamps"))
	if ts == "none" or ts == nil then ts = "" end

	local indent = ""
	if GossipChatter_DB then -- change to GossipChatter_DB.IndentParagraphs
		indent = "  "
	end

	if GossipChatter_DB then -- change to GossipChatter_DB.SplitParagraphs
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
		timeStamps = ""
	end
	local info = ChatTypeInfo["MONSTER_SAY"]
	local pagenumber = ": "
	if ItemTextCurrentPage == true then
		pagenumber = (ItemTextCurrentPage:GetText() .. ": ")
	else
		pagenumber = ": "
	end
	if event == "VOICE_CHAT_TTS_PLAYBACK_STARTED" then
		self.textPlaying = true
		return
	elseif event == "VOICE_CHAT_TTS_PLAYBACK_FINISHED" then
		self.textPlaying, self.buttonPress = false, false
		return
	elseif event == "ADDON_LOADED" and arg1 == "GossipChatter" then
		if not GossipChatter_DB then
			GossipChatter_DB = defaultsTable;
		end
		if GossipChatter_DB.Format == nil then
			GossipChatter_DB.Format = true;
		end

		UIDropDownMenu_Initialize(GossipChatterPanel.dropDownThey, function(self, level, menuList)
		local infoThey = UIDropDownMenu_CreateInfo()
			if (level or 1) == 1 then
			infoThey.func = self.SetValue
				for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
					infoThey.text, infoThey.arg1, infoThey.checked = i, i, i == GossipChatter_DB.VoiceThey.voiceID
					UIDropDownMenu_AddButton(infoThey, level)
				end
			end
		end)


		function GossipChatterPanel.dropDownThey:SetValue(newValue)
			favoriteNumberThey = newValue
			GossipChatter_DB.VoiceThey.voiceID = favoriteNumberThey
			UIDropDownMenu_SetText(GossipChatterPanel.dropDownThey, "Voice - They/Them: " .. GossipChatter_DB.VoiceThey.voiceID)
			CloseDropDownMenus()
		end

		UIDropDownMenu_Initialize(GossipChatterPanel.dropDownHe, function(self, level, menuList)
		local infoHe = UIDropDownMenu_CreateInfo()
			if (level or 1) == 1 then
			infoHe.func = self.SetValue
				for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
					infoHe.text, infoHe.arg1, infoHe.checked = i, i, i == GossipChatter_DB.VoiceHe.voiceID
					UIDropDownMenu_AddButton(infoHe, level)
				end
			end
		end)


		function GossipChatterPanel.dropDownHe:SetValue(newValue)
			favoriteNumberHe = newValue
			GossipChatter_DB.VoiceHe.voiceID = favoriteNumberHe
			UIDropDownMenu_SetText(GossipChatterPanel.dropDownHe, "Voice - He/Him: " .. GossipChatter_DB.VoiceHe.voiceID)
			CloseDropDownMenus()
		end

		UIDropDownMenu_Initialize(GossipChatterPanel.dropDownShe, function(self, level, menuList)
		local infoShe = UIDropDownMenu_CreateInfo()
			if (level or 1) == 1 then
			infoShe.func = self.SetValue
				for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
					infoShe.text, infoShe.arg1, infoShe.checked = i, i, i == GossipChatter_DB.VoiceShe.voiceID
					UIDropDownMenu_AddButton(infoShe, level)
				end
			end
		end)


		function GossipChatterPanel.dropDownShe:SetValue(newValue)
			favoriteNumberShe = newValue
			GossipChatter_DB.VoiceShe.voiceID = favoriteNumberShe
			UIDropDownMenu_SetText(GossipChatterPanel.dropDownShe, "Voice - She/Her: " .. GossipChatter_DB.VoiceShe.voiceID)
			CloseDropDownMenus()
		end

		UIDropDownMenu_Initialize(GossipChatterPanel.dropDownUnk, function(self, level, menuList)
		local infoUnk = UIDropDownMenu_CreateInfo()
			if (level or 1) == 1 then
			infoUnk.func = self.SetValue
				for i, v in pairs(C_VoiceChat.GetTtsVoices()) do
					infoUnk.text, infoUnk.arg1, infoUnk.checked = i, i, i == GossipChatter_DB.VoiceUnk.voiceID
					UIDropDownMenu_AddButton(infoUnk, level)
				end
			end
		end)


		function GossipChatterPanel.dropDownUnk:SetValue(newValue)
			favoriteNumberUnk = newValue
			GossipChatter_DB.VoiceUnk.voiceID = favoriteNumberUnk
			UIDropDownMenu_SetText(GossipChatterPanel.dropDownUnk, "Voice - Item: " .. GossipChatter_DB.VoiceUnk.voiceID)
			CloseDropDownMenus()
		end

		GossipChatterPanel.AutoCheckbox:SetChecked(GossipChatter_DB.TTSButton.auto)
		GossipChatterPanel.ShowCheckbox:SetChecked(GossipChatter_DB.TTSButton.show)
		GossipChatterPanel.InterruptCheckbox:SetChecked(GossipChatter_DB.Interrupt)
		GossipChatterPanel.FormatCheckbox:SetChecked(GossipChatter_DB.Format)

		--GossipChatterPanel.ShowCheckbox:SetChecked(GossipChatter_DB.TTSButton.locked)

		--GossipChatterPanel.ButtonScale:SetValue(GossipChatter_DB.TTSButton.scale*100);

		GossipChatterPanel.SpeedSliderThey:SetValue(GossipChatter_DB.VoiceThey.rate);
		GossipChatterPanel.VolumeSliderThey:SetValue(GossipChatter_DB.VoiceThey.volume);
		GossipChatterPanel.SpeedSliderHe:SetValue(GossipChatter_DB.VoiceHe.rate);
		GossipChatterPanel.VolumeSliderHe:SetValue(GossipChatter_DB.VoiceHe.volume);
		GossipChatterPanel.SpeedSliderShe:SetValue(GossipChatter_DB.VoiceShe.rate);
		GossipChatterPanel.VolumeSliderShe:SetValue(GossipChatter_DB.VoiceShe.volume);
		GossipChatterPanel.SpeedSliderUnk:SetValue(GossipChatter_DB.VoiceUnk.rate);
		GossipChatterPanel.VolumeSliderUnk:SetValue(GossipChatter_DB.VoiceUnk.volume);

		--GossipTracker.Stuff(GossipTracker.button);
		--GossipTracker.Stuff(GossipTracker.button2);
		--GossipTracker.Stuff(GossipTracker.button3);



		--GossipTracker.ReStuff()


		UIDropDownMenu_SetText(GossipChatterPanel.dropDownThey, "Voice - They/Them: " .. GossipChatter_DB.VoiceThey.voiceID)
		UIDropDownMenu_SetText(GossipChatterPanel.dropDownHe, "Voice - He/Him: " .. GossipChatter_DB.VoiceHe.voiceID)
		UIDropDownMenu_SetText(GossipChatterPanel.dropDownShe, "Voice - She/Her: " .. GossipChatter_DB.VoiceShe.voiceID)
		UIDropDownMenu_SetText(GossipChatterPanel.dropDownUnk, "Voice - Item: " .. GossipChatter_DB.VoiceUnk.voiceID)
	end

	local handler = eventHandlers[event]
	if handler then
		local text, sender, chatFmt, useUnk = handler()
		if not text then return end
		grabText, body = text, text
		HandleOutput(sender, text, chatFmt, GossipChatter_DB.TTSButton.auto, useUnk)
	end

end
GossipTracker:SetScript("OnEvent",GossipTracker.OnEvent);