local GossipTracker = CreateFrame("Frame");
GossipTracker:RegisterEvent("GOSSIP_SHOW");
GossipTracker:RegisterEvent("TRAINER_SHOW");
GossipTracker:RegisterEvent("GOSSIP_CLOSED");
GossipTracker:RegisterEvent("QUEST_PROGRESS");
GossipTracker:RegisterEvent("QUEST_COMPLETE");
GossipTracker:RegisterEvent("QUEST_DETAIL");
GossipTracker:RegisterEvent("ITEM_TEXT_READY");

C_GossipInfo.ForceGossip = function()
	return ForceGossipTemp
end

if C_GossipInfo.ForceGossip() == nil then
	ForceGossipTemp = false
end

function GossipTracker:OnEvent(event,arg1)
	local info = ChatTypeInfo["MONSTER_SAY"]
	if event == "GOSSIP_SHOW" and C_GossipInfo.ForceGossip() == true then
		local sender = GossipFrameNpcNameText:GetText()
		local body = CHAT_SAY_GET:format(sender) .. C_GossipInfo.GetText()
		
		DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)
	end
	if event == "GOSSIP_SHOW" and C_GossipInfo.ForceGossip() == false then
		ForceGossipTemp = true
		local sender = UnitName("target")
		local body = CHAT_SAY_GET:format(sender) .. C_GossipInfo.GetText()
		
		DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)


		ForceGossipTemp = false 
	end
	if event == "QUEST_PROGRESS" then
		local sender = QuestFrameNpcNameText:GetText()
		local body = CHAT_SAY_GET:format(sender) .. QuestProgressText:GetText()
		
		DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_COMPLETE" then
		local sender = QuestFrameNpcNameText:GetText()
		local body = CHAT_SAY_GET:format(sender) .. QuestInfoRewardText:GetText()
		
		DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)
	end
	if event == "QUEST_DETAIL" then
		local sender = QuestFrameNpcNameText:GetText()
		local body = CHAT_SAY_GET:format(sender) .. QuestInfoDescriptionText:GetText()
		
		DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)
	end
	if event == "ITEM_TEXT_READY" then	
		local info = ChatTypeInfo["MONSTER_EMOTE"]
		local sender = ItemTextFrameTitleText:GetText()
		local body = CHAT_EMOTE_GET:format(sender) .. "Page " .. ItemTextCurrentPage:GetText() .. ": " .. ItemTextGetText()
		
		DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)
	end
end
GossipTracker:SetScript("OnEvent",GossipTracker.OnEvent);
--[[
	local info = ChatTypeInfo["MONSTER_SAY"]
	local body = CHAT_SAY_GET:format(sender) .. msg
	DEFAULT_CHAT_FRAME:AddMessage(body, info.r, info.g, info.b, info.id)

	GossipFrameNpcNameText
	GossipGreetingText

	QuestFrameNpcNameText
	QuestInfoDescriptionText
	QuestProgressText
	QuestInfoRewardText

	ItemTextFrameTitleText

]]