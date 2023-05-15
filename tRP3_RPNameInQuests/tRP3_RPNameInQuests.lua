local trp3rpnamequestsframe = CreateFrame("Frame")


local TRPRPNAMEINQUESTS = select(2, ...);


local function trp3RPNameInQuestsInit()


	if tRP3RPNameInQuests == nil then		
		
		tRP3RPNameInQuests = {}
	
		print("|cffFF7C0A<TRP3: RP Name in Quest Text>:|r Type |cffFF7C0A/trp3 questtext|r to select how this character is addressed by NPCs.")
	end
	
	-- Set Addon Variables
	tRP3RPNameInQuests.WhichRPName = tRP3RPNameInQuests.WhichRPName or 5
	tRP3RPNameInQuests.CustomClassName = tRP3RPNameInQuests.CustomClassName or false
	tRP3RPNameInQuests.CustomRaceName = tRP3RPNameInQuests.CustomRaceName or false
	tRP3RPNameInQuests.PaperDollRPName = tRP3RPNameInQuests.PaperDollRPName or false





	local useNewAPI = true

	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) or (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC) then
		useNewAPI = true
	end

	if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) or (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)    then
		useNewAPI = false
	end









	-- Full TRP3 Name
	
	local function TRP3_RPNameInQuests_GetFullRPName(getFullName)
	
	
		getFullName = getFullName or false
			
		local thisTRP3CharInfo = TRP3_API.profile.getData("player/characteristics")
		
			local thisTRP3CharNameFull = ""
			
			if ((tRP3RPNameInQuests.WhichRPName == 2 or tRP3RPNameInQuests.WhichRPName == 3 or tRP3RPNameInQuests.WhichRPName == 4 or tRP3RPNameInQuests.WhichRPName == 5) or (getFullName == true)) then
				if (thisTRP3CharInfo.TI) then
					thisTRP3CharNameFull = thisTRP3CharNameFull .. thisTRP3CharInfo.TI	.. " "
				end
			end
			
			if ((tRP3RPNameInQuests.WhichRPName == 3 or tRP3RPNameInQuests.WhichRPName == 5 or tRP3RPNameInQuests.WhichRPName == 6 or tRP3RPNameInQuests.WhichRPName == 8) or (getFullName == true)) then
				if (thisTRP3CharInfo.FN) then
					thisTRP3CharNameFull = thisTRP3CharNameFull .. thisTRP3CharInfo.FN
				end
			end
			
			if ((tRP3RPNameInQuests.WhichRPName == 4 or tRP3RPNameInQuests.WhichRPName == 5 or tRP3RPNameInQuests.WhichRPName == 7 or tRP3RPNameInQuests.WhichRPName == 8) or (getFullName == true)) then
				if (thisTRP3CharInfo.LN) then
					thisTRP3CharNameFull = thisTRP3CharNameFull .. " " ..  thisTRP3CharInfo.LN
				end
			end
			
			--trim space
			thisTRP3CharNameFull = thisTRP3CharNameFull:gsub("^%s*(.-)%s*$", "%1")
			
			
			return thisTRP3CharNameFull
	
	end
	
	






	-- Function that does the actual renaming
	local TRP3_RPNameInQuests_VarToChange = UnitName("player")
	local TRP3_RPNameInQuests_RaceToChange = UnitRace("player")
	local TRP3_RPNameInQuests_ClassToChange = UnitClass("player")
	

	local function TRP3_RPNameInQuests_TextRename(textToRename, returnRPName)
	
		returnRPName = returnRPName or false
	
		thisTextToReturn = textToRename
		--Get TRP 3 Name
		
		--print("TextRename")
		
		
		if (tRP3RPNameInQuests.WhichRPName == 1) then
			-- ooc name, so do nothing
			
		else
			--rename char
			thisTRP3CharName = TRP3_RPNameInQuests_GetFullRPName(false)
			
			if (thisTRP3CharName == "") then
				--empty, do nothing
				thisTRP3CharName = TRP3_RPNameInQuests_VarToChange
				
			else
			
				if (textToRename) then
					textToRename = textToRename:gsub(TRP3_RPNameInQuests_VarToChange, thisTRP3CharName)
				end
			end
			
			
			if (returnRPName == true) then
				thisTextToReturn =  thisTRP3CharName
			else
				thisTextToReturn =  textToRename
			end
			
			
			
		end
		
		local thisTRP3CharInfoF = TRP3_API.profile.getData("player/characteristics")
		
		
		-- Race Name Text Here
		if (tRP3RPNameInQuests.CustomRaceName == true) then
		
			if (thisTRP3CharInfoF.RA ~= nil) then
			
				thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange,thisTRP3CharInfoF.RA)
				thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange),thisTRP3CharInfoF.RA)
			
			end
		
		end
		
		
		-- Class Name Text Here
		if (tRP3RPNameInQuests.CustomClassName == true) then
		
			if (thisTRP3CharInfoF.CL ~= nil) then
			
				thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange,thisTRP3CharInfoF.CL)
				thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange),thisTRP3CharInfoF.CL)
			
			end
		
		end
		
		
		return thisTextToReturn
		
		
		
	end


	-- Character Sheet
	hooksecurefunc("ToggleCharacter", function()
		if (tRP3RPNameInQuests.PaperDollRPName == true) then
			if ( CharacterFrame:IsShown() ) then
				if (TRP3_RPNameInQuests_GetFullRPName(true) ~= "") then
						if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
							CharacterFrame:SetTitle(TRP3_RPNameInQuests_GetFullRPName(true));
						else
							CharacterNameText:SetText(TRP3_RPNameInQuests_GetFullRPName(true));
						end
				end
			end
		end
	end)




	-- Quest Window
	hooksecurefunc("QuestInfo_Display", function()

		local thisQuestDescription = QuestInfoDescriptionText:GetText()
		
		if (thisQuestDescription ~= nil) then
				QuestInfoDescriptionText:SetText(TRP3_RPNameInQuests_TextRename(thisQuestDescription))
		end

	end)
	



	
	if (useNewAPI == true) then
	
	
		-- Get Gossip Text
		local TRP3_RPNameInQuests_C_GossipInfoGetTextHook = C_GossipInfo.GetText
		C_GossipInfo.GetText = function (...)
			
			local thisGossipText = TRP3_RPNameInQuests_C_GossipInfoGetTextHook()
			return TRP3_RPNameInQuests_TextRename(thisGossipText)
			
		end

	
	
	else 
	
		-- Get Gossip Text
		local TRP3_RPNameInQuests_GetGossipTextHook = GetGossipText
		GetGossipText = function (...)
		
			local thisGossipText = TRP3_RPNameInQuests_GetGossipTextHook()
			
			return TRP3_RPNameInQuests_TextRename(thisGossipText)
			
		end

	
	end
	
	

	
	-- Get Greeting Text
	local TRP3_RPNameInQuests_GetGreetingTextHook = GetGreetingText
	GetGreetingText = function (...)
	
		local thisGreetingText = TRP3_RPNameInQuests_GetGreetingTextHook()
		
		return TRP3_RPNameInQuests_TextRename(thisGreetingText)
		
	end



	-- Get Quest Text
	local TRP3_RPNameInQuests_GetQuestTextHook = GetQuestText
	GetQuestText = function (...)
	
		local thisQuestText = TRP3_RPNameInQuests_GetQuestTextHook()
		
		return TRP3_RPNameInQuests_TextRename(thisQuestText)
		
	end



	-- Get Quest Progress Text
	local TRP3_RPNameInQuests_GetProgressTextHook = GetProgressText
	GetProgressText = function (...)
	
		local thisProgressText = TRP3_RPNameInQuests_GetProgressTextHook()
		
		return TRP3_RPNameInQuests_TextRename(thisProgressText)
		
	end



	-- Get Quest Reward Text
	local TRP3_RPNameInQuests_GetRewardTextHook = GetRewardText
	GetRewardText = function (...)
	
		local thisRewardText = TRP3_RPNameInQuests_GetRewardTextHook()
		
		return TRP3_RPNameInQuests_TextRename(thisRewardText)
		
	end










	if (useNewAPI == true) then


		-- Gossip Options
		local TRP3_RPNameInQuests_GetGossipOptions = C_GossipInfo.GetOptions
		C_GossipInfo.GetOptions = function (...)
		
			local thisGossipOptions = TRP3_RPNameInQuests_GetGossipOptions()
			
			for key, value in pairs(thisGossipOptions) do
							
				if (strmatch(thisGossipOptions[key]["name"], TRP3_RPNameInQuests_VarToChange)) then
					thisGossipOptions[key]["name"] =  TRP3_RPNameInQuests_TextRename(thisGossipOptions[key]["name"])
				end
				
			end

			return(thisGossipOptions)
		
		end
	
	
	else
		--TO DO - Classic version maybe?
	

	end
	
	
	
	
	
	
	
	-- Chat Filters
	local function TRP3_RPNameInQuests_ChatFilterFunc(self, thisEvent, thisMessage, thisNPC, ...) 
	
		local thisNewMessage = TRP3_RPNameInQuests_TextRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_TextRename(thisNPC)
			
			if (thisEvent == "CHAT_MSG_MONSTER_SAY" or thisEvent == "CHAT_MSG_MONSTER_YELL" or thisEvent ==  "CHAT_MSG_MONSTER_PARTY") then
				TRP3_RPNameInQuests_ModSpeechBubbles()
			end
			
			
			return false, thisNewMessage, thisNewNPC, ...
	
	end
	
	
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /s Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /y Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /p Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /w Chat
	ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /e Chat
	
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_EMOTE", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC Boss /e Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_WHISPER", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC Boss /w Chat
	end
	
	
	
	
	
	
	
	--Speech Bubbles
	--with Code Modified from https://www.wowinterface.com/forums/showpost.php?p=336696&postcount=2
	function TRP3_RPNameInQuests_ModSpeechBubbles()
			
		--Slight timer so the bubble has chance to fade in
		C_Timer.After(.05, function()
			for _, bubble in pairs(C_ChatBubbles.GetAllChatBubbles()) do -- This -should- only affect NPC speech bubbles, player speech bubbles are protected
				for i = 1, bubble:GetNumChildren() do
					local child = select(i, select(i, bubble:GetChildren()))
					if(child) then
						if (child:GetObjectType() == "Frame") and (child.String) and (child.Center) then
							for i = 1, child:GetNumRegions() do
								local region = select(i, child:GetRegions())
								if (region:GetObjectType() == "FontString") then
								
									thisBubbleText = region:GetText()
									
									region:SetText(TRP3_RPNameInQuests_TextRename(thisBubbleText))
									
								end
							end
						end
					end
				end
			
			end
		
		end)
		
	end
	
	
	
	

-- TRP3 Options Page
local TRPRPNAMEINQUESTS_DROPDOWNSTUFF = {
	{ "OOC Character Name", 1 },
	{ "Title", 2 },
	{ "Title + First Name", 3 },
	{ "Title + Last Name", 4 },
	{ "Title + First Name + Last Name", 5 },
	{ "First Name", 6 },
	{ "Last Name", 7 },
	{ "First Name + Last Name", 8 },	
}




local classDisplayName, class = UnitClass("player");
local classColorString = RAID_CLASS_COLORS[class].colorStr;
	
	
TRPRPNAMEINQUESTS.CONFIG = {};

TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME = "trp3_rpnameinquests_whichrpname";
TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME = "trp3_rpnameinquests_customclassname";
TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME = "trp3_rpnameinquests_customracename";
TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME = "trp3_rpnameinquests_paperdollrpname";


TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, tRP3RPNameInQuests.WhichRPName);
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, tRP3RPNameInQuests.CustomClassName);
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, tRP3RPNameInQuests.CustomRaceName);
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, tRP3RPNameInQuests.PaperDollRPName);

TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, tRP3RPNameInQuests.WhichRPName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, tRP3RPNameInQuests.CustomClassName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, tRP3RPNameInQuests.CustomRaceName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, tRP3RPNameInQuests.PaperDollRPName);



TRP3_API.configuration.registerConfigurationPage({
		id = "trp3_rpnameinquests_config",
		menuText = "Quest Text",
		pageText = "RP Name in Quest Text",
		elements = {
			{
				inherit = "TRP3_ConfigParagraph",
				title = "This AddOn attempts to put your Total RP 3 Character Name into quest text and dialogue.",
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Main Options",
			},
			{
				inherit = "TRP3_ConfigDropDown",
				widgetName = "trp3_rpnameinquests_whichrpnamewidget",
				title = "How should NPCs address |c" .. classColorString .. UnitName("player") .. "|r?",
				help = "This will replace your OOC Name in Quests, NPC Speech, and Speech Bubbles, with your chosen name format. \n\nNote: Will cause wierd stuff to happen if your OOC name is a common word.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNSTUFF,
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, value)
					tRP3RPNameInQuests.WhichRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME)
				end,

			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "[!] Use Custom Class Name for |c" .. classColorString .. UnitName("player") .. "|r",
				help = "If checked, this will replace your OOC Class Name in Quests (e.g. Warrior) with your Custom Class name (e.g. Knight). \n\nNote: Will very likely cause regular quest text mentioning your OOC Class Name to look wierd.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, value)
					tRP3RPNameInQuests.CustomClassName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME)
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "[!] Use Custom Race Name for |c" .. classColorString .. UnitName("player") .. "|r",
				help = "If checked, this will replace your OOC Race Name in Quests (e.g. Orc) with your Custom Race name (e.g. Ogre).\n\nNote: Will very likely cause regular quest text mentioning your OOC Race Name to look wierd.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, value)
					tRP3RPNameInQuests.CustomRaceName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME)
				end,
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Extra Functions",
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Use TRP3 Name in Character Window for |c" .. classColorString .. UnitName("player") .. "|r",
				help = "If checked, your current TRP3 Character Name will be shown in the Character Window (aka Paper Doll).",
				configKey = TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, value)
					tRP3RPNameInQuests.PaperDollRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME)
				end,
			},
			
		}
	
	});

end


TRP3_API.module.registerModule({
	name = "RP Name in Quest Text",
	description = "This module attempts to put your Total RP 3 Character Name into quest text and dialogue.",
	version = "1.0.8",
	id = "trp3_rpnameinquests",
	onStart = trp3RPNameInQuestsInit,
	minVersion = 60,
});


-- Slash Command
function trp3RPNameInQuestsOpenConfig()
	TRP3_API.navigation.openMainFrame();
	TRP3_API.navigation.page.setPage("trp3_rpnameinquests_config");
end

local trp3RPNameInQuestsOpenConfigCommand = {
    id = "questtext",
    helpLine = " Open the RP Name in Quest Text Config.",
    handler = function()
        trp3RPNameInQuestsOpenConfig();
    end,
}

TRP3_API.slash.registerCommand(trp3RPNameInQuestsOpenConfigCommand);