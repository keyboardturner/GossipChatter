local defaultsTable = {
	VoiceThey = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceHe = {show = true, voiceID = 2, rate = 0, volume = 100,},
	VoiceShe = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceUnk = {show = true, voiceID = 2, rate = 0, volume = 100,},
	Interrupt = false,
	TTSButton = {auto = false, locked = true, show = true, scale = 1, x = -35, y = 0, point = "CENTER", relativePoint = "RIGHT",},
	Format = true,
};

--GossipChatter_DB

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


------------------------------------------------------------------------------------------------------------------

function GossipTracker.TextToSpeech(body)
	if GossipTracker.textPlaying == true and GossipTracker.buttonPress == true then
		C_VoiceChat.StopSpeakingText()
		GossipTracker.buttonPress = false
		return
	end
	if GossipTracker.textPlaying == true and GossipChatter_DB.Interrupt == true then
		C_VoiceChat.StopSpeakingText()
		return
	end

	if GossipChatter_DB.Format == true then
		if UnitSex("target") == 1 then
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceThey.voiceID, body, 1, GossipChatter_DB.VoiceThey.rate, GossipChatter_DB.VoiceThey.volume)
		elseif UnitSex("target") == 2 then
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceHe.voiceID, body, 1, GossipChatter_DB.VoiceHe.rate, GossipChatter_DB.VoiceHe.volume)
		elseif UnitSex("target") == 3 then
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceShe.voiceID, body, 1, GossipChatter_DB.VoiceShe.rate, GossipChatter_DB.VoiceShe.volume)
		else
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceUnk.voiceID, body, 1, GossipChatter_DB.VoiceUnk.rate, GossipChatter_DB.VoiceUnk.volume)
		end
	else
		if UnitSex("target") == 1 then
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceThey.voiceID, grabText, 1, GossipChatter_DB.VoiceThey.rate, GossipChatter_DB.VoiceThey.volume)
		elseif UnitSex("target") == 2 then
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceHe.voiceID, grabText, 1, GossipChatter_DB.VoiceHe.rate, GossipChatter_DB.VoiceHe.volume)
		elseif UnitSex("target") == 3 then
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceShe.voiceID, grabText, 1, GossipChatter_DB.VoiceShe.rate, GossipChatter_DB.VoiceShe.volume)
		else
			C_VoiceChat.SpeakText(GossipChatter_DB.VoiceUnk.voiceID, grabText, 1, GossipChatter_DB.VoiceUnk.rate, GossipChatter_DB.VoiceUnk.volume)
		end
	end
end

function GossipTracker.TextToSpeechUnk(body)
	if GossipTracker.textPlaying == true and GossipTracker.buttonPress == true  then
		C_VoiceChat.StopSpeakingText()
		return
	end
	if GossipTracker.textPlaying == true and GossipChatter_DB.Interrupt == true  then
		C_VoiceChat.StopSpeakingText()
		return
	end
	if GossipChatter_DB.Format == true then
		C_VoiceChat.SpeakText(GossipChatter_DB.VoiceUnk.voiceID, body, 1, GossipChatter_DB.VoiceUnk.rate, GossipChatter_DB.VoiceUnk.volume)
	else
		C_VoiceChat.SpeakText(GossipChatter_DB.VoiceUnk.voiceID, grabText, 1, GossipChatter_DB.VoiceUnk.rate, GossipChatter_DB.VoiceUnk.volume)
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
	GossipTracker.TextToSpeech(body)
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
	GossipTracker.TextToSpeech(body)
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
	--if GossipChatter_DB.TTSButton.locked == true  then
		GossipTracker.button3.tex:SetTexCoord(-.08, 1.16, -.16, 1.08)
	--end
end)
GossipTracker.button3:SetScript("OnMouseUp", function()
	--if GossipChatter_DB.TTSButton.locked == true then
		GossipTracker.TextToSpeechUnk(body)
	GossipTracker.buttonPress = true
		GossipTracker.button3.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
	--end
end)


------------------------------------------------------------------------------------------------------------------
--[[

function GossipTracker.Stuff(frame,button)
	print("bingus")
		frame:SetMovable(true);
		frame:SetUserPlaced(true);
		frame:EnableMouse(true)
		frame:RegisterForDrag("RightButton");
		frame:SetClampedToScreen(true)

		frame:SetScript("OnDragStart", function(self, button)
			if button == "RightButton" then
				if GossipChatter_DB.TTSButton.locked == false then
						Mixin(self, BackdropTemplateMixin);
						frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = -1, right = -1, top = -1, bottom = -1 }});
						frame:SetBackdropColor(1,.71,.75,.5);
						self:StartMoving();
						print("OnDragStart", button)
						self.isMoving = true;
				end
			end
		end);
		frame:SetScript("OnDragStop", function(self, button)
			Mixin(self, BackdropTemplateMixin);
			frame:SetBackdropColor(0,0,0,0);
			self:StopMovingOrSizing();
			print("OnDragStop")
			self.isMoving = false;
			local point, relativeTo, relativePoint, xOfs, yOfs = frame:GetPoint();

			GossipChatter_DB.TTSButton.point = point
			GossipChatter_DB.TTSButton.relativePoint = relativePoint
			GossipChatter_DB.TTSButton.x = xOfs
			GossipChatter_DB.TTSButton.y = yOfs

			print(GossipTracker.button3:GetBottom())
		end);
end

function GossipTracker.ReStuff()
	GossipTracker.button:ClearAllPoints()
	GossipTracker.button:SetPoint(GossipChatter_DB.TTSButton.point, QuestFrame.TitleContainer, GossipChatter_DB.TTSButton.relativePoint, GossipChatter_DB.TTSButton.x, GossipChatter_DB.TTSButton.y);
	GossipTracker.button:SetScale(GossipChatter_DB.TTSButton.scale);
	GossipTracker.button2:SetPoint(GossipChatter_DB.TTSButton.point, GossipFrame.TitleContainer, GossipChatter_DB.TTSButton.relativePoint, GossipChatter_DB.TTSButton.x, GossipChatter_DB.TTSButton.y);
	GossipTracker.button2:SetScale(GossipChatter_DB.TTSButton.scale);
	GossipTracker.button3:SetPoint(GossipChatter_DB.TTSButton.point, ItemTextFrame.TitleContainer, GossipChatter_DB.TTSButton.relativePoint, GossipChatter_DB.TTSButton.x, GossipChatter_DB.TTSButton.y);
	GossipTracker.button3:SetScale(GossipChatter_DB.TTSButton.scale);
end

function GossipTrackerResetStuff()
	GossipTracker.button:ClearAllPoints()
	GossipTracker.button2:ClearAllPoints()
	GossipTracker.button3:ClearAllPoints()


	GossipChatter_DB.TTSButton.x = defaultsTable.TTSButton.x
	GossipChatter_DB.TTSButton.y = defaultsTable.TTSButton.y
	GossipChatter_DB.TTSButton.scale = defaultsTable.TTSButton.scale

	GossipTracker.button:SetPoint("CENTER", QuestFrame.TitleContainer, "RIGHT", defaultsTable.TTSButton.x, defaultsTable.TTSButton.y);
	GossipTracker.button:SetScale(defaultsTable.TTSButton.scale);
	GossipTracker.button2:SetPoint("CENTER", GossipFrame.TitleContainer, "RIGHT", defaultsTable.TTSButton.x, defaultsTable.TTSButton.y);
	GossipTracker.button2:SetScale(defaultsTable.TTSButton.scale);
	GossipTracker.button3:SetPoint("CENTER", ItemTextFrame.TitleContainer, "RIGHT", defaultsTable.TTSButton.x, defaultsTable.TTSButton.y);
	GossipTracker.button3:SetScale(defaultsTable.TTSButton.scale);
end
]]

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
GossipChatterPanel.Version:SetText("Version: " .. GetAddOnMetadata("GossipChatter", "Version"));

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

--voice types
--1. neutrum
--2. male
--3. female
--4. unknown

------------------------------------------------------------------------------------------------------------------

--final
InterfaceOptions_AddCategory(GossipChatterPanel);


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------


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
		GossipTracker.textPlaying = true
	end

	if event == "VOICE_CHAT_TTS_PLAYBACK_FINISHED" then
		GossipTracker.textPlaying = false
		GossipTracker.buttonPress = false
	end

	if event == "GOSSIP_SHOW"  then
		if C_GossipInfo.GetText() == nil then
			return
		end
		if C_GossipInfo.GetText() then
			grabText = C_GossipInfo.GetText()
		else
			grabText = ""
		end
		sender = GossipFrameTitleText:GetText() or UnitName("target")
		if CHAT_SAY_GET:format(sender) then
			body = CHAT_SAY_GET:format(sender) .. grabText
		else
			body = "" .. grabText
		end
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		if C_GossipInfo.GetText() == nil then
			return
		else
			if GossipChatter_DB.TTSButton.auto == true then
				if GossipChatter_DB.Format == true then
					GossipTracker.TextToSpeech(body)
				else
					GossipTracker.TextToSpeech(grabText)
				end
			end
			DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
		end

	end
	if event == "QUEST_GREETING" then
		if GreetingText:GetText() == nil then
			return
		end
		grabText = GreetingText:GetText()
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. grabText
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")

		if GossipChatter_DB.TTSButton.auto == true then
			if GossipChatter_DB.Format == true then
				GossipTracker.TextToSpeech(body)
			else
				GossipTracker.TextToSpeech(grabText)
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_PROGRESS" then
		if QuestProgressText:GetText() == nil then
			return
		end
		grabText = QuestProgressText:GetText()
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. grabText
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")

		if GossipChatter_DB.TTSButton.auto == true then
			if GossipChatter_DB.Format == true then
				GossipTracker.TextToSpeech(body)
			else
				GossipTracker.TextToSpeech(grabText)
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_COMPLETE" then
		if QuestInfoRewardText:GetText() == nil then
			return
		end
		grabText = QuestInfoRewardText:GetText()
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. grabText
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")

		if GossipChatter_DB.TTSButton.auto == true then
			if GossipChatter_DB.Format == true then
				GossipTracker.TextToSpeech(body)
			else
				GossipTracker.TextToSpeech(grabText)
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_DETAIL" then
		if QuestInfoDescriptionText:GetText() == nil then
			return
		end
		grabText = QuestInfoDescriptionText:GetText()
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. grabText
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")

		if GossipChatter_DB.TTSButton.auto == true then
			if GossipChatter_DB.Format == true then
				GossipTracker.TextToSpeech(body)
			else
				GossipTracker.TextToSpeech(grabText)
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "ITEM_TEXT_READY" then	
		if ItemTextGetText() == nil then
			return
		end
		local info = ChatTypeInfo["MONSTER_EMOTE"]
		grabText = ItemTextGetText()
		sender = ItemTextFrameTitleText:GetText()

		body = CHAT_EMOTE_GET:format(sender) .. pagenumber .. grabText
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		if string.find(body, "<HTML>") then
			return
		end
		
		if GossipChatter_DB.TTSButton.auto == true then
			if GossipChatter_DB.Format == true then
				GossipTracker.TextToSpeechUnk(body)
			else
				GossipTracker.TextToSpeechUnk(grabText)
			end
		end
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "ADDON_LOADED" and arg1 == "GossipChatter" then
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

end
GossipTracker:SetScript("OnEvent",GossipTracker.OnEvent);