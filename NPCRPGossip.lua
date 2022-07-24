local npcrpframe = CreateFrame("Frame")
npcrpframe:RegisterEvent("ADDON_LOADED")
npcrpframe:RegisterEvent("PLAYER_LOGOUT")
npcrpframe:RegisterEvent("MODIFIER_STATE_CHANGED")



local waitTable = {};
local waitFrame = nil;


C_GossipInfo.ForceGossip = function()
	return ForceGossipShiftX
end



--Stolen from http://wowwiki.wikia.com/wiki/Wait
--Using this so the notifications appear visible.
function NPCRPGOSSIP__wait(delay, func, ...)
  if(type(delay)~="number" or type(func)~="function") then
    return false;
  end
  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
    waitFrame:SetScript("onUpdate",function (self,elapse)
      local count = #waitTable;
      local i = 1;
      while(i<=count) do
        local waitRecord = tremove(waitTable,i);
        local d = tremove(waitRecord,1);
        local f = tremove(waitRecord,1);
        local p = tremove(waitRecord,1);
        if(d>elapse) then
          tinsert(waitTable,i,{d-elapse,f,p});
          i = i + 1;
        else
          count = count - 1;
          f(unpack(p));
        end
      end
    end);
  end
  tinsert(waitTable,{delay,func,{...}});
  return true;
end

npcrpframe:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "ADDON_LOADED" and arg1 == "NPCRPGossip" then
	
        
        if NPCRPGossipEnable == nil then
            -- No value, enable it
            NPCRPGossipEnable = true
		
        end
		
		if NPCRPGossipStoryline == nil then
			NPCRPGossipStoryline = true
		end
		
		
		-- Let the user know if it's enabled or not
		
		if NPCRPGossipEnable == true then
			NPCRPGOSSIP__wait(5, print, "|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cff00ff00ENABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
			NPCRPGOSSIP__wait(5, print, "|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily disable.")
		else
			NPCRPGOSSIP__wait(5, print, "|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cffff0000DISABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
			NPCRPGOSSIP__wait(5, print, "|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily enable.")
		end
		
		ForceGossipShiftX =  NPCRPGossipEnable
		
		    
    end
	
	if event == "MODIFIER_STATE_CHANGED" then
	
		if (arg1 == "LSHIFT") or (arg1 == "RSHIFT") then
			
			if arg2 == 1 then
				-- SHIFT is pressed
					
				if NPCRPGossipEnable == true then
					ForceGossipShiftX = false
				else
					ForceGossipShiftX = true
				end
					
			else
				-- SHIFT was let go 
				ForceGossipShiftX =  NPCRPGossipEnable
			end
					
		
		end 
	
	end 
	
end)

-- Slash toggle to disable/enable RP Gossip
SLASH_RPGOSSIPTOGGLE1 = "/npcrpgossip"
function SlashCmdList.RPGOSSIPTOGGLE(msg)
    if NPCRPGossipEnable == true then
		NPCRPGossipEnable = false
		print("|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cffff0000DISABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
			print("|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily enable.")
	else
		NPCRPGossipEnable = true
		print("|cffF58CBA<NPC RP Gossip>:|r Gossip Text is |cff00ff00ENABLED!|r Type |cffF58CBA/npcrpgossip|r to toggle.")
			print("|cffF58CBA<NPC RP Gossip>:|r Hold down the |cffF58CBASHIFT|r key when interacting with an NPC to temporarily disable.")
	end
	
	ForceGossipShiftX =  NPCRPGossipEnable
end
