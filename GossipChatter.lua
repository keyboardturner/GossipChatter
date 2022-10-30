local defaultsTable = {
	VoiceThey = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceHe = {show = true, voiceID = 2, rate = 0, volume = 100,},
	VoiceShe = {show = true, voiceID = 1, rate = 0, volume = 100,},
	VoiceUnk = {show = true, voiceID = 2, rate = 0, volume = 100,},
	TTSButton = {auto = true, show = true, scale = 1, x = 0, y = 0, point = "BOTTOMRIGHT", relativePoint = "BOTTOMRIGHT",},
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

local sender = " "
local body = ""
GossipTracker.textPlaying = false

------------------------------------------------------------------------------------------------------------------

GossipTracker.button = CreateFrame("Button", nil, QuestFrame.TitleContainer)
GossipTracker.button:SetPoint("CENTER", QuestFrame.TitleContainer, "RIGHT", -35, 0)
GossipTracker.button:SetWidth(15)
GossipTracker.button:SetHeight(15)
GossipTracker.button.tex = GossipTracker.button:CreateTexture(nil, "ARTWORK", nil, 1)
GossipTracker.button.tex:SetAllPoints(GossipTracker.button)
GossipTracker.button.tex:SetAtlas("chatframe-button-icon-TTS")
GossipTracker.button.tex:SetTexCoord(.08, .92, .08, .92)
GossipTracker.button.tex2 = GossipTracker.button:CreateTexture(nil, "ARTWORK", nil, 0)
GossipTracker.button.tex2:SetAllPoints(GossipTracker.button)
GossipTracker.button.tex2:SetAtlas("chatframe-button-up")
GossipTracker.button.tex2:SetTexCoord(.08, .92, .08, .92)

function GossipTracker.TextToSpeech(body)
	if GossipTracker.textPlaying == true then
		C_VoiceChat.StopSpeakingText()
		return
	end
	C_VoiceChat.SpeakText(GossipChatter_DB.VoiceThey.voiceID, body, 1, GossipChatter_DB.VoiceThey.rate, GossipChatter_DB.VoiceThey.volume)
end

GossipTracker.button:SetScript("OnMouseDown", function()
	GossipTracker.button.tex:SetTexCoord(0, 1, 0, 1)
	GossipTracker.button.tex2:SetTexCoord(0, 1, 0, 1)
end)
GossipTracker.button:SetScript("OnMouseUp", function()
	GossipTracker.TextToSpeech(body)
	GossipTracker.button.tex:SetTexCoord(.08, .92, .08, .92)
	GossipTracker.button.tex2:SetTexCoord(.08, .92, .08, .92)
end)

------------------------------------------------------------------------------------------------------------------

GossipTracker.button2 = CreateFrame("Button", nil, GossipFrame.TitleContainer)
GossipTracker.button2:SetPoint("CENTER", GossipFrame.TitleContainer, "RIGHT", -35, -0)
GossipTracker.button2:SetWidth(15)
GossipTracker.button2:SetHeight(15)
GossipTracker.button2.tex = GossipTracker.button2:CreateTexture(nil, "ARTWORK", nil, 1)
GossipTracker.button2.tex:SetAllPoints(GossipTracker.button2)
GossipTracker.button2.tex:SetAtlas("chatframe-button-icon-TTS")
GossipTracker.button2.tex:SetTexCoord(.08, .92, .08, .92)
GossipTracker.button2.tex2 = GossipTracker.button2:CreateTexture(nil, "ARTWORK", nil, 0)
GossipTracker.button2.tex2:SetAllPoints(GossipTracker.button2)
GossipTracker.button2.tex2:SetAtlas("chatframe-button-up")
GossipTracker.button2.tex2:SetTexCoord(.08, .92, .08, .92)


GossipTracker.button2:SetScript("OnMouseDown", function()
	GossipTracker.button2.tex:SetTexCoord(0, 1, 0, 1)
	GossipTracker.button2.tex2:SetTexCoord(0, 1, 0, 1)
end)
GossipTracker.button2:SetScript("OnMouseUp", function()
	GossipTracker.TextToSpeech(body)
	GossipTracker.button2.tex:SetTexCoord(.08, .92, .08, .92)
	GossipTracker.button2.tex2:SetTexCoord(.08, .92, .08, .92)
end)

GossipTracker.button3 = CreateFrame("Button", nil, ItemTextFrame.TitleContainer)
GossipTracker.button3:SetPoint("CENTER", ItemTextFrame.TitleContainer, "RIGHT", -35, -0)
GossipTracker.button3:SetWidth(15)
GossipTracker.button3:SetHeight(15)
GossipTracker.button3.tex = GossipTracker.button3:CreateTexture(nil, "ARTWORK", nil, 1)
GossipTracker.button3.tex:SetAllPoints(GossipTracker.button3)
GossipTracker.button3.tex:SetAtlas("chatframe-button-icon-TTS")
GossipTracker.button3.tex:SetTexCoord(.08, .92, .08, .92)
GossipTracker.button3.tex2 = GossipTracker.button3:CreateTexture(nil, "ARTWORK", nil, 0)
GossipTracker.button3.tex2:SetAllPoints(GossipTracker.button3)
GossipTracker.button3.tex2:SetAtlas("chatframe-button-up")
GossipTracker.button3.tex2:SetTexCoord(.08, .92, .08, .92)

GossipTracker.button3:SetScript("OnMouseDown", function()
	GossipTracker.button3.tex:SetTexCoord(0, 1, 0, 1)
	GossipTracker.button3.tex2:SetTexCoord(0, 1, 0, 1)
end)
GossipTracker.button3:SetScript("OnMouseUp", function()
	GossipTracker.TextToSpeech(body)
	GossipTracker.button3.tex:SetTexCoord(.08, .92, .08, .92)
	GossipTracker.button3.tex2:SetTexCoord(.08, .92, .08, .92)
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

local speechRateTest = 0

--speech rate slider
GossipChatterPanel.SpeedSlider = CreateFrame("Slider", "GCSpeedPanelSlider", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.SpeedSlider:SetWidth(300);
GossipChatterPanel.SpeedSlider:SetHeight(15);
GossipChatterPanel.SpeedSlider:SetMinMaxValues(-10,10);
GossipChatterPanel.SpeedSlider:SetValueStep(1);
GossipChatterPanel.SpeedSlider:SetObeyStepOnDrag(true)
GossipChatterPanel.SpeedSlider:ClearAllPoints();
GossipChatterPanel.SpeedSlider:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53);
getglobal(GossipChatterPanel.SpeedSlider:GetName() .. 'Low'):SetText(SLOW);
getglobal(GossipChatterPanel.SpeedSlider:GetName() .. 'High'):SetText(FAST);
getglobal(GossipChatterPanel.SpeedSlider:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_RATE);
GossipChatterPanel.SpeedSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.SpeedSlider:GetName()):GetValue();
	speechRateTest = scaleValue
	--MoveMenusF_DB.MicromenuFrame.scale = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

local speechVolumeTest = 50

--volume slider
GossipChatterPanel.VolumeSliderThey = CreateFrame("Slider", "GCVolumePanelSliderThey", GossipChatterPanel, "OptionsSliderTemplate");
GossipChatterPanel.VolumeSliderThey:SetWidth(300);
GossipChatterPanel.VolumeSliderThey:SetHeight(15);
GossipChatterPanel.VolumeSliderThey:SetMinMaxValues(0,100);
GossipChatterPanel.VolumeSliderThey:SetValueStep(1);
GossipChatterPanel.VolumeSliderThey:SetObeyStepOnDrag(true)
GossipChatterPanel.VolumeSliderThey:ClearAllPoints();
GossipChatterPanel.VolumeSliderThey:SetPoint("TOPLEFT", GossipChatterPanel, "TOPLEFT",12,-53*2);
getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'Low'):SetText('');
getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'High'):SetText('PH');
getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'Text'):SetText(TEXT_TO_SPEECH_ADJUST_VOLUME);
GossipChatterPanel.VolumeSliderThey:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(GossipChatterPanel.VolumeSliderThey:GetName()):GetValue();
	getglobal(GossipChatterPanel.VolumeSliderThey:GetName() .. 'High'):SetText(string.format("%.0f %%", scaleValue));
	speechVolumeTest = scaleValue
	GossipChatter_DB.VoiceThey.volume = scaleValue;
end)


------------------------------------------------------------------------------------------------------------------

GossipChatterPanel.LockedCheckbox = CreateFrame("CheckButton", "GCP_LockedCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.LockedCheckbox:ClearAllPoints();
GossipChatterPanel.LockedCheckbox:SetPoint("TOPLEFT", 350, -53);
getglobal(GossipChatterPanel.LockedCheckbox:GetName().."Text"):SetText("Auto-play Text To Speech");

GossipChatterPanel.LockedCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.LockedCheckbox:GetChecked() then
		--MoveMenusF_DB.locked = true;
		print("clicked true")
	else
		--MoveMenusF_DB.locked = false;
		print("clicked false")
	end
end);

------------------------------------------------------------------------------------------------------------------

GossipChatterPanel.ShowCheckbox = CreateFrame("CheckButton", "GCP_ShowCheckbox", GossipChatterPanel, "UICheckButtonTemplate");
GossipChatterPanel.ShowCheckbox:ClearAllPoints();
GossipChatterPanel.ShowCheckbox:SetPoint("TOPLEFT", 350, -53*1.5);
getglobal(GossipChatterPanel.ShowCheckbox:GetName().."Text"):SetText("Show Button on Frame");

GossipChatterPanel.ShowCheckbox:SetScript("OnClick", function(self)
	if GossipChatterPanel.ShowCheckbox:GetChecked() then
		--MoveMenusF_DB.locked = true;
		print("clicked true")
	else
		--MoveMenusF_DB.locked = false;
		print("clicked false")
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
	print("You clicked me!")
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
	print("You clicked me!")
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
	print("You clicked me!")
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
	print("You clicked me!")
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
	end

	if event == "GOSSIP_SHOW"  then
		sender = GossipFrameTitleText:GetText() or UnitName("target")
		body = CHAT_SAY_GET:format(sender) .. C_GossipInfo.GetText()
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		if C_GossipInfo.GetText() == nil then
			return
		else
			DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
		end
	end
	if event == "QUEST_GREETING" then
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. GreetingText:GetText()
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_PROGRESS" then
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. QuestProgressText:GetText()
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_COMPLETE" then
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. QuestInfoRewardText:GetText()
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_DETAIL" then
		sender = QuestFrameTitleText:GetText()
		body = CHAT_SAY_GET:format(sender) .. QuestInfoDescriptionText:GetText()
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "ITEM_TEXT_READY" then	
		local info = ChatTypeInfo["MONSTER_EMOTE"]
		sender = ItemTextFrameTitleText:GetText()

		body = CHAT_EMOTE_GET:format(sender) .. pagenumber .. ItemTextGetText()
		body = string.gsub(body, "<", "|cffFF7F40<")
		body = string.gsub(body, ">", ">|r")
		if string.find(body, "<HTML>") then
			return
		end
		
		DEFAULT_CHAT_FRAME:AddMessage(timeStamps .. body, info.r, info.g, info.b, info.id)
	end
	if event == "ADDON_LOADED" and arg1 == "GossipChatter" then
		if not GossipChatter_DB then
			GossipChatter_DB = defaultsTable;
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

		UIDropDownMenu_SetText(GossipChatterPanel.dropDownThey, "Voice - They/Them: " .. GossipChatter_DB.VoiceThey.voiceID)
		UIDropDownMenu_SetText(GossipChatterPanel.dropDownHe, "Voice - He/Him: " .. GossipChatter_DB.VoiceHe.voiceID)
		UIDropDownMenu_SetText(GossipChatterPanel.dropDownShe, "Voice - She/Her: " .. GossipChatter_DB.VoiceShe.voiceID)
		UIDropDownMenu_SetText(GossipChatterPanel.dropDownUnk, "Voice - Item: " .. GossipChatter_DB.VoiceUnk.voiceID)
		--MenuFramePanel.MicroMenuSlider:SetValue(MoveMenusF_DB.MicromenuFrame.scale*100);
		--MenuFramePanel.BagButtonsSlider:SetValue(MoveMenusF_DB.BagbuttonsFrame.scale*100);
		--MenuFramePanel.XPBarSlider:SetValue(MoveMenusF_DB.XPBarFrame.scale*100);
		--MenuEventFrame.ReMoveStuff();
		--MenuEventFrame.Stuff(MicroButtonAndBagsBar);
		--MenuEventFrame.Stuff(MainMenuBarBackpackButton);
		--MenuEventFrame.Stuff(StatusTrackingBarManager);
	end

end
GossipTracker:SetScript("OnEvent",GossipTracker.OnEvent);