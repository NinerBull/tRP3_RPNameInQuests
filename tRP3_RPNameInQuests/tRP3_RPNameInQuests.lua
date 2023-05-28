local trp3rpnamequestsframe = CreateFrame("Frame")
trp3rpnamequestsframe:RegisterEvent("ITEM_TEXT_READY");


local TRPRPNAMEINQUESTS = select(2, ...);


local function trp3RPNameInQuestsInit()

	
	--Init
	if tRP3RPNameInQuests == nil then		
		tRP3RPNameInQuests = {}
		print("|cffFF7C0A<TRP3: RP Name in Quest Text>:|r Type |cffFF7C0A/trp3 questtext|r to select how this character is addressed by NPCs.")
	end

	
	
	
	
	--Upgrades from older version
	if (type(tRP3RPNameInQuests) == "number") then
		tRP3RPNameInQuests = {}
	end
	
	if (tRP3RPNameInQuests.CustomClassName == true) then
		tRP3RPNameInQuests.CustomClassName = 2
	end
	
	if (tRP3RPNameInQuests.CustomRaceName == true) then
		tRP3RPNameInQuests.CustomRaceName = 2
	end
	
	
	
	
	
	
	
	
	--Init Enabled Mods Table
	if (tRP3RPNameInQuests.EnabledTextMods == nil) then
		tRP3RPNameInQuests.EnabledTextMods = {}
	end
	
	
	
	
	-- Set Addon Variables
	if (tRP3RPNameInQuests.WhichRPName == nil) then
		tRP3RPNameInQuests.WhichRPName = 5
	end
	
	if (tRP3RPNameInQuests.WhichRPNameText == nil) then
		tRP3RPNameInQuests.WhichRPNameText = ""
	end
	
	
	
	
	if (tRP3RPNameInQuests.CustomClassName == nil) then
		tRP3RPNameInQuests.CustomClassName = 1
	end
	
	if (tRP3RPNameInQuests.CustomClassNameText == nil) then
		tRP3RPNameInQuests.CustomClassNameText = ""
	end
	
	
	
	
	if (tRP3RPNameInQuests.CustomRaceName == nil) then
		tRP3RPNameInQuests.CustomRaceName = 1
	end
	
	if (tRP3RPNameInQuests.CustomRaceNameText == nil) then
		tRP3RPNameInQuests.CustomRaceNameText = ""
	end
	
	
	
	
	if (tRP3RPNameInQuests.EnabledTextMods.NPCSpeech == nil) then
		tRP3RPNameInQuests.EnabledTextMods.NPCSpeech = true
	end
	
	if (tRP3RPNameInQuests.EnabledTextMods.QuestDialog == nil) then
		tRP3RPNameInQuests.EnabledTextMods.QuestDialog = true
	end
	
	if (tRP3RPNameInQuests.EnabledTextMods.Mailbox == nil) then
		tRP3RPNameInQuests.EnabledTextMods.Mailbox = true
	end
	
	if (tRP3RPNameInQuests.EnabledTextMods.TextItems == nil) then
		tRP3RPNameInQuests.EnabledTextMods.TextItems = true
	end
	
	if (tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote == nil) then
		tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote = false
	end
	
	
	
	
	if (tRP3RPNameInQuests.PaperDollRPName == nil) then
		tRP3RPNameInQuests.PaperDollRPName = false
	end
	
	
	
	
	

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
	
	






	-- Functions that do the actual renaming
	local TRP3_RPNameInQuests_NameToChange = UnitName("player")
	local TRP3_RPNameInQuests_RaceToChange = UnitRace("player")
	local TRP3_RPNameInQuests_ClassToChange = UnitClass("player")
	
	
	
	
	--Rename Character
	local function TRP3_RPNameInQuests_RPNameRename(textToRename, returnRPName)
	
		returnRPName = returnRPName or false
	
		thisTextToReturn = textToRename
		--Get TRP 3 Name
		
		
		if (tRP3RPNameInQuests.WhichRPName == 1) then
			-- ooc name, so do nothing
			
		else
			--rename char
			thisTRP3CharName = TRP3_RPNameInQuests_GetFullRPName(false)
			
			if (thisTRP3CharName == "") then
				--empty, do nothing
				thisTRP3CharName = TRP3_RPNameInQuests_NameToChange
				
			else
			
				if (textToRename) then
					textToRename = textToRename:gsub(TRP3_RPNameInQuests_NameToChange, thisTRP3CharName)
				end
			end
			
			
			if (returnRPName == true) then
				thisTextToReturn =  thisTRP3CharName
			else
				thisTextToReturn =  textToRename
			end
			
			
			
		end
	
		return thisTextToReturn
		
		
		
	end
	
	
	
	
	
	--Rename Race
	local function TRP3_RPNameInQuests_RPRaceRename(textToRename, returnRPRace, doLowerCase)
	
		returnRPRace = returnRPRace or false
		
		doLowerCase = doLowerCase or false
		
		thisTextToReturn = textToRename
	
		local thisTRP3CharInfoR = TRP3_API.profile.getData("player/characteristics")
		
		thisRaceName = TRP3_RPNameInQuests_RaceToChange
		
		--If not OOC Race Name
		if (tRP3RPNameInQuests.CustomRaceName ~= 1) then
		
			--TRP3 Race Name
			if (tRP3RPNameInQuests.CustomRaceName == 2) then
			
				if (thisTRP3CharInfoR.RA ~= nil) then
				
					thisRaceName = thisTRP3CharInfoR.RA
			
				end
				
			end
			
			
			--Custom Race Name
			if (tRP3RPNameInQuests.CustomRaceName == 3) then
			
				if (tRP3RPNameInQuests.CustomRaceNameText ~= "") then
				
					thisRaceName = tRP3RPNameInQuests.CustomRaceNameText
					
				end
				
			end
			
			
			if (doLowerCase == false) then
				thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange,thisRaceName)
			else
				thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange),thisRaceName)
			end
	
		end

		
		
		if (returnRPRace == true) then
			return thisRaceName
		else
			return thisTextToReturn
		end
		
		
	 end
	 
	 
	 
	 
	 
	--Rename Class
	local function TRP3_RPNameInQuests_RPClassRename(textToRename, returnRPClass, doLowerCase)
	
		returnRPClass = returnRPClass or false
		
		doLowerCase = doLowerCase or false
		
		thisTextToReturn = textToRename
	
		local thisTRP3CharInfoC = TRP3_API.profile.getData("player/characteristics")
		
		thisClassName = TRP3_RPNameInQuests_ClassToChange
		
		
		
		--If not OOC Class Name
		if (tRP3RPNameInQuests.CustomClassName ~= 1) then
		
			--TRP3 Class Name
			if (tRP3RPNameInQuests.CustomClassName == 2) then
			
				if (thisTRP3CharInfoR.CL ~= nil) then
				
					thisClassName = thisTRP3CharInfoR.CL
			
				end
				
			end
			
			
			--Custom Class Name
			if (tRP3RPNameInQuests.CustomClassName == 3) then
			
				if (tRP3RPNameInQuests.CustomClassNameText ~= "") then
				
					thisClassName = tRP3RPNameInQuests.CustomClassNameText
					
				end
				
			end
			
			
			if (doLowerCase == false) then
				thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange,thisClassName)
			else
				thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange),thisClassName)
			end
	
		end


		if (returnRPClass == true) then
			return thisClassName
		else
			return thisTextToReturn
		end

	end
	
	
	
	--TheBigRename
	
	local function tRP3RPNameTheBigRename(textToRename)
	
		thisRenamedText = textToRename or ""
	
		if (tRP3RPNameInQuests.WhichRPName ~= 1) then
			if (strmatch(thisRenamedText, TRP3_RPNameInQuests_NameToChange) and (not (strmatch(thisRenamedText, TRP3_RPNameInQuests_RPNameRename("placeholder", true))))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText)
			end
		end
		
		--ClassName
		if (tRP3RPNameInQuests.CustomClassName ~= 1) then
			if (strmatch(thisRenamedText, TRP3_RPNameInQuests_ClassToChange)) then
				thisRenamedText =  TRP3_RPNameInQuests_RPClassRename(thisRenamedText)
			end
			if (strmatch(thisRenamedText, string.lower(TRP3_RPNameInQuests_ClassToChange))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPClassRename(thisRenamedText, false, true)
			end
		end
		
		--RaceName
		if (tRP3RPNameInQuests.CustomRaceName ~= 1) then
			if (strmatch(thisRenamedText, TRP3_RPNameInQuests_RaceToChange)) then
				thisRenamedText =  TRP3_RPNameInQuests_RPRaceRename(thisRenamedText)
			end
			if (strmatch(thisRenamedText, string.lower(TRP3_RPNameInQuests_RaceToChange))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPRaceRename(thisRenamedText, false, true)
			end
		end

		
		return thisRenamedText
	
	
	
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









	--Quests, Dialog, Gossip Etc.
	if (tRP3RPNameInQuests.EnabledTextMods.QuestDialog == true) then

		-- Quest Window
		hooksecurefunc("QuestInfo_Display", function()
				
			local thisQuestDescription = QuestInfoDescriptionText:GetText()
			
			if (thisQuestDescription ~= nil) then
			
				QuestInfoDescriptionText:SetText(tRP3RPNameTheBigRename(thisQuestDescription))
				
			end

		end)
		



		
		if (useNewAPI == true) then
		
			-- Get Gossip Text
			local TRP3_RPNameInQuests_C_GossipInfoGetTextHook = C_GossipInfo.GetText
			C_GossipInfo.GetText = function (...)
				
				local thisGossipText = TRP3_RPNameInQuests_C_GossipInfoGetTextHook()
				
				return tRP3RPNameTheBigRename(thisGossipText)
				
				
			end
		
		else
		
			-- Get Gossip Text
			local TRP3_RPNameInQuests_GetGossipTextHook = GetGossipText
			GetGossipText = function (...)
			
				local thisGossipText = TRP3_RPNameInQuests_GetGossipTextHook()
				
				return tRP3RPNameTheBigRename(thisGossipText)
				
			end

		end
		
		

		
		-- Get Greeting Text
		local TRP3_RPNameInQuests_GetGreetingTextHook = GetGreetingText
		GetGreetingText = function (...)
		
			local thisGreetingText = TRP3_RPNameInQuests_GetGreetingTextHook()
			
			return tRP3RPNameTheBigRename(thisGreetingText)
			
		end



		-- Get Quest Text
		local TRP3_RPNameInQuests_GetQuestTextHook = GetQuestText
		GetQuestText = function (...)
			local thisQuestText = TRP3_RPNameInQuests_GetQuestTextHook()
			
			return tRP3RPNameTheBigRename(thisQuestText)
			
		end



		-- Get Quest Progress Text
		local TRP3_RPNameInQuests_GetProgressTextHook = GetProgressText
		GetProgressText = function (...)
		
			local thisProgressText = TRP3_RPNameInQuests_GetProgressTextHook()
			
			return tRP3RPNameTheBigRename(thisProgressText)
			
		end



		-- Get Quest Reward Text
		local TRP3_RPNameInQuests_GetRewardTextHook = GetRewardText
		GetRewardText = function (...)
		
			local thisRewardText = TRP3_RPNameInQuests_GetRewardTextHook()
			
			return tRP3RPNameTheBigRename(thisRewardText)
			
		end


	







		if (useNewAPI == true) then

			-- Gossip Options
			local TRP3_RPNameInQuests_GetGossipOptions = C_GossipInfo.GetOptions
			C_GossipInfo.GetOptions = function (...)
			
				local thisGossipOptions = TRP3_RPNameInQuests_GetGossipOptions()
				
				for key, value in pairs(thisGossipOptions) do
								
					thisGossipOptions[key]["name"] =  tRP3RPNameTheBigRename(thisGossipOptions[key]["name"])
					
				end

				return(thisGossipOptions)
			
			end
		
		else
		
		
			--TO DO - Classic version maybe? Any point though? Perhaps Classic Era will be upgraded to DF's API.

		end
	
	
	
	
	
	
	end --eo QuestDialog
	
	
	
	
	
	
	
	
	
	
	
	-- Mail Window
	-- /Interface/FrameXML/MailFrame.lua
	if (tRP3RPNameInQuests.EnabledTextMods.Mailbox == true) then
		hooksecurefunc("OpenMail_Update", function()

				if ( not OpenMailFrame_IsValidMailID()) then
					return;
				end
				
				local bodyText, stationeryID1, stationeryID2, isTakeable, isInvoice, isConsortium = GetInboxText(InboxFrame.openMailID);
				
				OpenMailBodyText:SetText(tRP3RPNameTheBigRename(bodyText), true);

		end)
	
	end
	
	
	
	
	
	
	
	-- Books, etc.
	-- /Interface/FrameXML/ItemTextFrame.lua
	if (tRP3RPNameInQuests.EnabledTextMods.TextItems == true) then
		trp3rpnamequestsframe:SetScript("OnEvent", function(self, event, arg1, arg2)
	
			if event == "ITEM_TEXT_READY" then
			
				local creator = ItemTextGetCreator();
				if ( creator ) then
					creator = "\n\n"..ITEM_TEXT_FROM.."\n"..creator.."\n";
					ItemTextPageText:SetText(tRP3RPNameTheBigRename(ItemTextGetText())..creator);
				else
					ItemTextPageText:SetText(tRP3RPNameTheBigRename(ItemTextGetText()));
				end
				
			end
		
		
		end)
	end
	
	
	


	
	-- Chat Filters
	local function TRP3_RPNameInQuests_ChatFilterFunc(self, thisEvent, thisMessage, thisNPC, ...) 
	
		local thisNewMessage = tRP3RPNameTheBigRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_RPNameRename(thisNPC)
			if (tRP3RPNameInQuests.EnabledTextMods.NPCSpeech == true) then
				if (thisEvent == "CHAT_MSG_MONSTER_SAY" or thisEvent == "CHAT_MSG_MONSTER_YELL" or thisEvent ==  "CHAT_MSG_MONSTER_PARTY") then
					TRP3_RPNameInQuests_ModSpeechBubbles()
				end
			end
			
			
			return false, thisNewMessage, thisNewNPC, ...
	
	end
	
	
	-- NPC Speech
	if (tRP3RPNameInQuests.EnabledTextMods.NPCSpeech == true) then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /s Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /y Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /p Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /w Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /e Chat
	end
	
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		if (tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote == true) then
			-- Raid Boss Emote Frame
			ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_EMOTE", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC Boss /e Chat
			ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_WHISPER", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC Boss /w Chat
		end
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

										region:SetText(tRP3RPNameTheBigRename(thisBubbleText))
										
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

local TRPRPNAMEINQUESTS_DROPDOWNCLASS = {
	{ "OOC Class Name", 1 },
	{ "TRP3 Class Name", 2 },
	{ "Custom Class Name (Set Below)", 3 },	
}

local TRPRPNAMEINQUESTS_DROPDOWNRACE = {
	{ "OOC Race Name", 1 },
	{ "TRP3 Race Name", 2 },
	{ "Custom Race Name (Set Below)", 3 },	
}




local classDisplayName, class = UnitClass("player");
local classColorString = RAID_CLASS_COLORS[class].colorStr;
	

--TRP3 Variables
TRPRPNAMEINQUESTS.CONFIG = {};

TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME = "trp3_rpnameinquests_whichrpname";

TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME = "trp3_rpnameinquests_customclassname";
TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT = "trp3_rpnameinquests_customclassnametext";

TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME = "trp3_rpnameinquests_customracename";
TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT = "trp3_rpnameinquests_customracenametext";

TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH = "trp3_rpnameinquests_textmod_npcspeech";
TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG = "trp3_rpnameinquests_textmod_questdialog";
TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX = "trp3_rpnameinquests_textmod_mailbox";
TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS = "trp3_rpnameinquests_textmod_textitems";
TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS = "trp3_rpnameinquests_textmod_raidboss";

TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME = "trp3_rpnameinquests_paperdollrpname";


--Register and set value for variables

--WhichRPName
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, tRP3RPNameInQuests.WhichRPName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, tRP3RPNameInQuests.WhichRPName);

--CustomClassName
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, tRP3RPNameInQuests.CustomClassName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, tRP3RPNameInQuests.CustomClassName);

--CustomClassNameText
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT, tRP3RPNameInQuests.CustomClassNameText);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT, tRP3RPNameInQuests.CustomClassNameText);

--CustomRaceName
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, tRP3RPNameInQuests.CustomRaceName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, tRP3RPNameInQuests.CustomRaceName);

--CustomRaceNameText
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT, tRP3RPNameInQuests.CustomRaceNameText);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT, tRP3RPNameInQuests.CustomRaceNameText);

--NPCSpeech
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, tRP3RPNameInQuests.EnabledTextMods.NPCSpeech);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, tRP3RPNameInQuests.EnabledTextMods.NPCSpeech);

--QuestDialog
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, tRP3RPNameInQuests.EnabledTextMods.QuestDialog);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, tRP3RPNameInQuests.EnabledTextMods.QuestDialog);

--Mailbox
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, tRP3RPNameInQuests.EnabledTextMods.Mailbox);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, tRP3RPNameInQuests.EnabledTextMods.Mailbox);

--TextItems
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS, tRP3RPNameInQuests.EnabledTextMods.TextItems);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS, tRP3RPNameInQuests.EnabledTextMods.TextItems);

--RaidBossEmote
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS, tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS, tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote);

--PaperDollRPName
TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, tRP3RPNameInQuests.PaperDollRPName);
TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, tRP3RPNameInQuests.PaperDollRPName);






--Create Config Page
TRP3_API.configuration.registerConfigurationPage({
		id = "trp3_rpnameinquests_config",
		menuText = "Quest Text",
		pageText = "RP Name in Quest Text",
		elements = {
			{
				inherit = "TRP3_ConfigParagraph",
				title = "Note that all options here are OOC Character Specific.",
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Main Options for |c" .. classColorString .. UnitName("player") .. "|r",
			},
			{
				inherit = "TRP3_ConfigParagraph",
				title = "How should NPCs refer to your character?",
			},
			{
				inherit = "TRP3_ConfigDropDown",
				widgetName = "trp3_rpnameinquests_whichrpnamewidget",
				title = "TRP3 Character Name Format",
				help = "Select what Character Name NPCs should refer you to as, in the chosen format. This uses the Character Name from your currently selected TRP3 Profile.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNSTUFF,
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, value)
					tRP3RPNameInQuests.WhichRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME)
				end,

			},
			{
				inherit = "TRP3_ConfigDropDown",
				title = "|c" .. classColorString .. "Class" .. "|r"  .. " Name Format",
				help = "Select what class NPCs should refer to you as. \n\nNote: Will also affect any regular quest text mentioning your OOC Class Name.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNCLASS,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, value)
					tRP3RPNameInQuests.CustomClassName = value
					
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigDropDown",
				title = "|cffE3963ERace|r Name Format",
				help = "Select what race NPCs should refer to you as. \n\nNote: Will also affect any regular quest text mentioning your OOC Class Name.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNRACE,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, value)
					tRP3RPNameInQuests.CustomRaceName = value
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigNote",
				title = " ",
			},
			{
				inherit = "TRP3_ConfigEditBox",
				title = "Custom |c" .. classColorString .. "Class" .. "|r" .." Name (*)",
				help = "Only used if 'Class Name Format' is set as 'Custom Class Name'.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT,
				--dependentOnOptions = { false }
			},
			
			{
				inherit = "TRP3_ConfigEditBox",
				title = "Custom |cffE3963ERace|r Name (*)",
				help = "Only used if 'Race Name Format' is set as 'Custom Race Name'.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT,
				--dependentOnOptions = { false }
			},
			{
				inherit = "TRP3_ConfigNote",
				title = " ",
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Which Text to Modify for |c" .. classColorString .. UnitName("player") .. "|r",
			},
			{
				inherit = "TRP3_ConfigParagraph",
				title = "Select which text this addon should modify to include your RP Name/Class/Race.",
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "NPC Speech (/say, /yell, /emote etc)",
				help = "If checked, this addon will modify all text and speech bubbles for NPCs.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, value)
					
					local oldVar = tRP3RPNameInQuests.EnabledTextMods.NPCSpeech
					
					tRP3RPNameInQuests.EnabledTextMods.NPCSpeech = value
					
					if (oldVar ~= tRP3RPNameInQuests.EnabledTextMods.NPCSpeech) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Quest Dialog / Gossip",
				help = "If checked, this addon will modify all quest text and dialog boxes.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, value)
					
					local oldVar = tRP3RPNameInQuests.EnabledTextMods.QuestDialog
					
					tRP3RPNameInQuests.EnabledTextMods.QuestDialog = value
					
					if (oldVar ~= tRP3RPNameInQuests.EnabledTextMods.QuestDialog) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Mailbox",
				help = "If checked, this addon will modify all Non-AH Mail in your Mailbox.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, value)
					
					local oldVar = tRP3RPNameInQuests.EnabledTextMods.Mailbox
					
					tRP3RPNameInQuests.EnabledTextMods.Mailbox = value
					
					if (oldVar ~= tRP3RPNameInQuests.EnabledTextMods.Mailbox) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Text Items (Books, Letters, Plaques etc)",
				help = "If checked, this addon will modify text items such as books.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, value)
					
					local oldVar = tRP3RPNameInQuests.EnabledTextMods.TextItems
					
					tRP3RPNameInQuests.EnabledTextMods.TextItems = value
					
					if (oldVar ~= tRP3RPNameInQuests.EnabledTextMods.TextItems) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Raid Boss Warnings",
				help = "If checked, this addon will modify Raid Boss Warnings/Emotes.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS, value)
					
					local oldVar = tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote
					
					
					tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote = value
					
					if (oldVar ~= tRP3RPNameInQuests.EnabledTextMods.RaidBossEmote) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
					
				end,
			},
			{
				inherit = "TRP3_ConfigNote",
				title = " ",
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Extra Functions for |c" .. classColorString .. UnitName("player") .. "|r",
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Use TRP3 Name in Character Window",
				help = "If checked, your current TRP3 Character Name will be shown in the title bar of the Character Window (aka Paper Doll).",
				configKey = TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, value)
					tRP3RPNameInQuests.PaperDollRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME)
					
					tRP3RPNameInQuests.CustomClassNameText = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT)
					
					tRP3RPNameInQuests.CustomRaceNameText = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT)
					
				end,
			},
			
		}
	
	});

end


TRP3_API.module.registerModule({
	name = "RP Name in Quest Text",
	description = "This module enhances questing immersion by putting your TRP3 IC Name into Quest Text!",
	version = "1.1.0",
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
    helpLine = " Open the 'RP Name in Quest Text' Config.",
    handler = function()
        trp3RPNameInQuestsOpenConfig();
    end,
}

TRP3_API.slash.registerCommand(trp3RPNameInQuestsOpenConfigCommand);