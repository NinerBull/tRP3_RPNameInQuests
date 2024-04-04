local TRP3RPNameInQuests_Frame = CreateFrame("Frame")
TRP3RPNameInQuests_Frame:RegisterEvent("ITEM_TEXT_READY");
TRP3RPNameInQuests_Frame:RegisterEvent("UNIT_NAME_UPDATE");

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	TRP3RPNameInQuests_Frame:RegisterEvent("KNOWN_TITLES_UPDATE");
end

TRPRPNAMEINQUESTS = select(2, ...);



local function TRP3RPNameInQuests_Init()

		
	--Init	
	if (type(TRP3RPNameInQuests_CharVars) ~= "table") then		
		TRP3RPNameInQuests_CharVars = {}
		TRP3_API.utils.message.displayMessage(TRP3_API.Colors.Cyan("RP Name in Quest Text") .. " installed! Type " .. TRP3_API.Colors.Cyan("/trp3 questtext") .. " to select how this character is addressed by NPCs.",1)
	end

	
	
	--Upgrades from older versions
	if (TRP3RPNameInQuests_CharVars.CustomClassName == true) then
		TRP3RPNameInQuests_CharVars.CustomClassName = 2
	end
	
	if (TRP3RPNameInQuests_CharVars.CustomRaceName == true) then
		TRP3RPNameInQuests_CharVars.CustomRaceName = 2
	end
	
	if (TRP3RPNameInQuests_CharVars.CustomClassName == 3) then
		TRP3RPNameInQuests_CharVars.CustomClassName = 99
	end
	
	if (TRP3RPNameInQuests_CharVars.CustomRaceName == 3) then
		TRP3RPNameInQuests_CharVars.CustomRaceName = 99
	end
	
	if (TRP3RPNameInQuests_CharVars.WhichRPName == 9) then
		TRP3RPNameInQuests_CharVars.WhichRPName = 99
	end


	
	

	
	
	
	-- Set Addon Variables
	if (type(TRP3RPNameInQuests_CharVars.WhichRPName) ~= "number") then
		TRP3RPNameInQuests_CharVars.WhichRPName = 5
	end
	
	if (type(TRP3RPNameInQuests_CharVars.WhichRPNameText) ~= "string") then
		TRP3RPNameInQuests_CharVars.WhichRPNameText = ""
	end
	
	if (type(TRP3RPNameInQuests_CharVars.CustomClassName) ~= "number") then
		TRP3RPNameInQuests_CharVars.CustomClassName = 1
	end
	
	if (type(TRP3RPNameInQuests_CharVars.CustomClassNameText) ~= "string") then
		TRP3RPNameInQuests_CharVars.CustomClassNameText = ""
	end
	
	if (type(TRP3RPNameInQuests_CharVars.CustomRaceName) ~= "number") then
		TRP3RPNameInQuests_CharVars.CustomRaceName = 1
	end
	
	if (type(TRP3RPNameInQuests_CharVars.CustomRaceNameText) ~= "string") then
		TRP3RPNameInQuests_CharVars.CustomRaceNameText = ""
	end
	
	
	
	local TRP3RPNameInQuests_ClassColorString = CreateColor(GetClassColor(TRP3_API.globals.player_character.class)) or NORMAL_FONT_COLOR

		

	--TRP3 Variables
	TRPRPNAMEINQUESTS.CONFIG = {};

	TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME = "trp3_rpnameinquests_whichrpname";
	TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT = "trp3_rpnameinquests_whichrpnametext";

	TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME = "trp3_rpnameinquests_customclassname";
	TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT = "trp3_rpnameinquests_customclassnametext";

	TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME = "trp3_rpnameinquests_customracename";
	TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT = "trp3_rpnameinquests_customracenametext";

	TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG = "trp3_rpnameinquests_textmod_questdialog";
	TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH = "trp3_rpnameinquests_textmod_npcspeech";
	TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS = "trp3_rpnameinquests_textmod_textitems";
	TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX = "trp3_rpnameinquests_textmod_mailbox";
	TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS = "trp3_rpnameinquests_textmod_raidboss";
	TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION = "trp3_rpnameinquests_textmod_raceclasspunctuation";

	TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME = "trp3_rpnameinquests_unitframerpname";
	TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME = "trp3_rpnameinquests_paperdollrpname";
	TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME = "trp3_rpnameinquests_partyframerpname";
	TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME = "trp3_rpnameinquests_zonenamerpname";

	--Register and set value for variables

	-- Character Specific
	
	--WhichRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, TRP3RPNameInQuests_CharVars.WhichRPName);
	TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, TRP3RPNameInQuests_CharVars.WhichRPName);
	
	--WhichRPNameText
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT, TRP3RPNameInQuests_CharVars.WhichRPNameText);
	TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT, TRP3RPNameInQuests_CharVars.WhichRPNameText);

	--CustomClassName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, TRP3RPNameInQuests_CharVars.CustomClassName);
	TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, TRP3RPNameInQuests_CharVars.CustomClassName);

	--CustomClassNameText
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT, TRP3RPNameInQuests_CharVars.CustomClassNameText);
	TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT, TRP3RPNameInQuests_CharVars.CustomClassNameText);

	--CustomRaceName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, TRP3RPNameInQuests_CharVars.CustomRaceName);
	TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, TRP3RPNameInQuests_CharVars.CustomRaceName);

	--CustomRaceNameText
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT, TRP3RPNameInQuests_CharVars.CustomRaceNameText);
	TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT, TRP3RPNameInQuests_CharVars.CustomRaceNameText);



	-- Account Wide
	
	--QuestDialog
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, true);
	
	--NPCSpeech
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, true);
	
	--TextItems
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS, true);

	--Mailbox
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, true);

	--RaidBossEmote
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS, false);
	
	--RaceClassPunctuationAdjacent
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION, true);
	
	
	

	--UnitFrameRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME, false);

	--PaperDollRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, false);
	
	--PartyFrameRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME, false);
	
	--ZoneNameRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME, false);
	
	




	--Temp Values to check if /reload is needed
	local TRP3_RPNameInQuests_OldVar_QuestDialog = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG)
	local TRP3_RPNameInQuests_OldVar_NPCSpeech = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH)
	local TRP3_RPNameInQuests_OldVar_TextItems = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS)
	local TRP3_RPNameInQuests_OldVar_Mailbox = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX)
	local TRP3_RPNameInQuests_OldVar_RaidBossEmote = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS)
	local TRP3_RPNameInQuests_OldVar_ZoneNameRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME)
	
	

	
	-- Bypass Unit Frame options if totalRP3_UnitFrames is loaded.
	-- (Go get it btw it's awesome)
	-- https://github.com/keyboardturner/totalRP3_UnitFrames
	
	-- TODO: Will need to change to C_AddOns.IsAddOnLoaded in future when Cata prepatch drops.
	local TRP3_RPNameInQuests_IgnoreUnitFrameMods = IsAddOnLoaded("totalRP3_UnitFrames") or false
	local TRP3_RPNameInQuests_NameToChange = TRP3_API.globals.player or UnitName("player")
	local TRP3_RPNameInQuests_RaceToChange = TRP3_API.globals.player_race_loc or UnitRace("player")
	local TRP3_RPNameInQuests_ClassToChange = TRP3_API.globals.player_class_loc or UnitClass("player")
	


	-- Full TRP3 Name
	-- Do not rename this, DialogueUI looks for and uses this function
	function TRP3_RPNameInQuests_GetFullRPName(getFullName)
	
	
		getFullName = getFullName or false
			
		local thisTRP3CharInfo = TRP3_API.profile.getData("player/characteristics")
		
		local thisTRP3CharNameFull = ""
		
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 2 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 3 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 4 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 5) or (getFullName == true)) then
			if (thisTRP3CharInfo.TI) then
				thisTRP3CharNameFull = thisTRP3CharNameFull .. thisTRP3CharInfo.TI	.. " "
			end
		end
		
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 3 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 5 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 6 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 8) or (getFullName == true)) then
			if (thisTRP3CharInfo.FN) then
				thisTRP3CharNameFull = thisTRP3CharNameFull .. thisTRP3CharInfo.FN
			end
		end
		
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 4 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 5 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 7 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 8) or (getFullName == true)) then
			if (thisTRP3CharInfo.LN) then
				thisTRP3CharNameFull = thisTRP3CharNameFull .. " " ..  thisTRP3CharInfo.LN
			end
		end
		
		
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 99 and getFullName == false) then
			thisTRP3CharNameFull = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT)
		end
		
		--trim space
		thisTRP3CharNameFull = thisTRP3CharNameFull:gsub("%s+", " ")
		thisTRP3CharNameFull = thisTRP3CharNameFull:gsub("^%s*(.-)%s*$", "%1")
		
		if (thisTRP3CharNameFull == "") then
			thisTRP3CharNameFull = TRP3_API.globals.player or UnitName("player")
		end
			
		
		return thisTRP3CharNameFull

	end
	
	






	-- Functions that do the actual renaming
	
	
	
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		-- Some allied races use a different race name in quest text rather than their full race name
		local thisPlayerRaceName, thisPlayerRaceFile, thisPlayerRaceID = UnitRace("player")
		
		thisActualRaceInfo = {}
		
		--print(thisPlayerRaceID)
		
		if (thisPlayerRaceID == 28) then -- Highmountain Tauren
			thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(6)
		end
		
		if (thisPlayerRaceID == 30) then -- Lightforged Draenei
			 thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(11)
		end
		
		if (thisPlayerRaceID == 31) then -- Zandalari Troll
			thisActualRaceInfo.raceName = TRP3_RPNameInQuests_RaceToChange:match("(%w+)(.*)")
		end
		
		if (thisPlayerRaceID == 34) then -- Dark Iron Dwarf
			thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(3)
		end
		
		if (thisPlayerRaceID == 36) then -- Mag'har Orc
			 thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(2)
		end
		
		
		if (thisActualRaceInfo.raceName ~= nil) then
			TRP3_RPNameInQuests_RaceToChange = thisActualRaceInfo.raceName
		end
		
		
	end
	
	
	
	
	
	--Rename Character
	function TRP3_RPNameInQuests_RPNameRename(textToRename, renameFullName)
	
		renameFullName = renameFullName or false
	
		thisTextToReturn = textToRename
		
		--rename char
		thisTRP3CharName = TRP3_RPNameInQuests_GetFullRPName(renameFullName)
				
		if (thisTRP3CharName == "") then
			--empty, do nothing
			thisTRP3CharName = TRP3_RPNameInQuests_NameToChange
		else
			if (textToRename) then
				textToRename = textToRename:gsub(TRP3_RPNameInQuests_NameToChange, thisTRP3CharName)
			end
		end
		thisTextToReturn =  textToRename
		
		return thisTextToReturn
		
	end

	
	
	-- Return RP Name
	function TRP3_RPNameInQuests_ReturnRPName(renameFullName)
	
		renameFullName = renameFullName or false
	
		return TRP3_RPNameInQuests_GetFullRPName(renameFullName)
		
	end
	
	
	
	
	
	
	
	--Rename Race
	function TRP3_RPNameInQuests_RPRaceRename(textToRename, doLowerCase)
	
		doLowerCase = doLowerCase or false
		thisTextToReturn = textToRename
		local thisTRP3CharInfoR = TRP3_API.profile.getData("player/characteristics")
		thisRaceName = TRP3_RPNameInQuests_RaceToChange
		
		--If not OOC Race Name
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) ~= 1) then
			--TRP3 Race Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) == 2) then
				if (thisTRP3CharInfoR.RA ~= nil) then
					thisRaceName = thisTRP3CharInfoR.RA
				end
			end
			
			--Custom Race Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) == 99) then
				if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT) ~= "") then
					thisRaceName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT)
				end
			end
			
			
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION) == true) then
			
			
				if (doLowerCase == false) then
					thisTextToReturn = thisTextToReturn:gsub(", " .. TRP3_RPNameInQuests_RaceToChange,", " .. thisRaceName)
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "," ,thisRaceName .. ",")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "%." ,thisRaceName .. ".")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "%?" ,thisRaceName .. "?")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "!" ,thisRaceName .. "!")
				else
					thisTextToReturn = thisTextToReturn:gsub(string.lower(", " .. TRP3_RPNameInQuests_RaceToChange),string.lower(", " .. thisRaceName))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. ","),string.lower(thisRaceName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. "%."),string.lower(thisRaceName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. "%?"),string.lower(thisRaceName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. "!"),string.lower(thisRaceName .. "!"))
				end
			
			else
			
				if (doLowerCase == false) then
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange,thisRaceName)
				else
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange),string.lower(thisRaceName))
				end
			
			end
			
			
	
		end
		
		return thisTextToReturn
		
	end
	
	
	
	 
	 --Return RP Race
	function TRP3_RPNameInQuests_ReturnRPRace()
	
		local thisTRP3CharInfoR = TRP3_API.profile.getData("player/characteristics")
		thisRaceName = TRP3_RPNameInQuests_RaceToChange
		
		--If not OOC Race Name
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) ~= 1) then
			--TRP3 Race Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) == 2) then
				if (thisTRP3CharInfoR.RA ~= nil) then
					thisRaceName = thisTRP3CharInfoR.RA
				end
			end
		
			--Custom Race Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) == 99) then
				if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT) ~= "") then
					thisRaceName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT)
				end
			end
				
		end
		
		return thisRaceName
	
	 end
	 
	 


	 
	--Rename Class
	 function TRP3_RPNameInQuests_RPClassRename(textToRename, doLowerCase)
	
		doLowerCase = doLowerCase or false
		thisTextToReturn = textToRename
		local thisTRP3CharInfoC = TRP3_API.profile.getData("player/characteristics")
		thisClassName = TRP3_RPNameInQuests_ClassToChange
	
		--If not OOC Class Name
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) ~= 1) then
			--TRP3 Class Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) == 2) then
				if (thisTRP3CharInfoC.CL ~= nil) then
					thisClassName = thisTRP3CharInfoC.CL
				end
			end
			
			--Custom Class Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) == 99) then
				if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT) ~= "") then
					thisClassName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT)
				end
			end
			
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION) == true) then
				--Replace text next to punctuation
				
				if (doLowerCase == false) then
					thisTextToReturn = thisTextToReturn:gsub(", " .. TRP3_RPNameInQuests_ClassToChange,", " ..thisClassName)
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. ",",thisClassName .. ",")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. "%.",thisClassName .. ".")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. "%?",thisClassName .. "?")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. "!",thisClassName .. "!")
				else
					thisTextToReturn = thisTextToReturn:gsub(string.lower(", " .. TRP3_RPNameInQuests_ClassToChange),string.lower(", " .. thisClassName))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. ","),string.lower(thisClassName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. "%."),string.lower(thisClassName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. "%?"),string.lower(thisClassName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. "!"),string.lower(thisClassName .. "!"))
				end

			else
			
				if (doLowerCase == false) then
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange,thisClassName)
				else
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange),string.lower(thisClassName))
				end
			
			end
			
			
	
		end
	
		return thisTextToReturn
	
	end
	
	
	--Return Class Name
	 function TRP3_RPNameInQuests_ReturnRPClass()
	
		local thisTRP3CharInfoC = TRP3_API.profile.getData("player/characteristics")
		thisClassName = TRP3_RPNameInQuests_ClassToChange
	
		--If not OOC Class Name
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) ~= 1) then
			--TRP3 Class Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) == 2) then
				if (thisTRP3CharInfoC.CL ~= nil) then
					thisClassName = thisTRP3CharInfoC.CL
				end
			end
			
			--Custom Class Name
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) == 99) then
				if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT) ~= "") then
					thisClassName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT)
				end
			end
	
		end
		
		return thisClassName

	end
	
	
	
	
	
	--Complete Rename Function
	function TRP3_RPNameInQuests_CompleteRename(textToRename)

	
		thisRenamedText = textToRename or ""
		
	
		
		--CharacterName
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) ~= 1) then
		
			-- Find out if TRP Name is a short version of OOC Name
			lengthOfOOCName = string.len(TRP3_RPNameInQuests_NameToChange)
			lengthOfTRP3Name = string.len(TRP3_RPNameInQuests_RPNameRename(TRP3_RPNameInQuests_NameToChange, true))
			
		
			if (lengthOfTRP3Name >= lengthOfOOCName) then
				if (strmatch(thisRenamedText, TRP3_RPNameInQuests_NameToChange) and (not (strmatch(thisRenamedText, TRP3_RPNameInQuests_ReturnRPName(true))))) then
					thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText)
				end
			else
				if (strmatch(thisRenamedText, TRP3_RPNameInQuests_NameToChange)) then
					thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText)
				end
			end
		end
		
		--ClassName
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME) ~= 1) then
			if (strmatch(thisRenamedText, TRP3_RPNameInQuests_ClassToChange)) then
				thisRenamedText =  TRP3_RPNameInQuests_RPClassRename(thisRenamedText)
			end
			if (strmatch(thisRenamedText, string.lower(TRP3_RPNameInQuests_ClassToChange))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPClassRename(thisRenamedText, true)
			end
		end
		
		--RaceName
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME) ~= 1) then
			if (strmatch(thisRenamedText, TRP3_RPNameInQuests_RaceToChange)) then
				thisRenamedText =  TRP3_RPNameInQuests_RPRaceRename(thisRenamedText)
			end
			if (strmatch(thisRenamedText, string.lower(TRP3_RPNameInQuests_RaceToChange))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPRaceRename(thisRenamedText, true)
			end
		end

		
		return thisRenamedText
	
	
	
	end
	
	
	
	
	-- Unit Frame
	hooksecurefunc("UnitFrame_Update", function(self)
		--if (InCombatLockdown() == false) then
			if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
				if (self.name) then
					local thisName = nil
					pcall(function () 
						thisName = self.name:GetText()
					end) 
					if (thisName ~= nil) then			
						if (TRP3_RPNameInQuests_NameToChange == thisName) then
							if (TRP3_RPNameInQuests_GetFullRPName(true) ~= "") then
								pcall(function () 
									self.name:SetText(TRP3_RPNameInQuests_GetFullRPName(true));
								end) 
							end
						end
					end

				end
			end
		--end
	end)
		
	
	-- Party/Raid Frames
	hooksecurefunc("CompactUnitFrame_UpdateName", function(self)
		--if (InCombatLockdown() == false) then
			-- TODO: Will need to change to C_AddOns.IsAddOnLoaded in future.
			if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME) == true) and (IsAddOnLoaded("Blizzard_CUFProfiles"))) then
				if (self.name) then
					local thisName = nil
					pcall(function () 
						thisName = self.name:GetText()
					end) 
					if (thisName ~= nil) then			
						if (TRP3_RPNameInQuests_NameToChange == thisName) then
							if (TRP3_RPNameInQuests_GetFullRPName(true) ~= "") then
								pcall(function () 
									self.name:SetText(TRP3_RPNameInQuests_GetFullRPName(true));
								end) 
							end
						end
					end
				end
			end
		--end
	end)
	
	
	-- Update Unit Frames when profile changed
	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_PROFILES_LOADED", function()
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
			TRP3_RPNameInQuests_UpdateUnitFrames()
		end
	end);
	
	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_DATA_UPDATED", function()
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
			TRP3_RPNameInQuests_UpdateUnitFrames()
		end
	end);
	

	
	-- Character Sheet
	hooksecurefunc("ToggleCharacter", function()
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME) == true) then
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


	-- Character Sheet Level/Race/Class
	hooksecurefunc("PaperDollFrame_SetLevel", function()
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME) == true) then
		
			local thisTRP3CharInfo = TRP3_API.profile.getData("player/characteristics")
				
			local thisTRP3CharRace = thisTRP3CharInfo.RA or UnitRace("player")
			local thisTRP3CharClass = thisTRP3CharInfo.CL or UnitClass("player")
		
			local level = UnitLevel("player");

		
			if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
			
				local thisTRP3CharColor = CreateColor(GetClassColor(TRP3_API.globals.player_character.class)) or NORMAL_FONT_COLOR
				
				if (thisTRP3CharInfo.CH ~= nil) then
					thisTRP3CharColor = CreateColorFromRGBHexString(thisTRP3CharInfo.CH) or NORMAL_FONT_COLOR			
				end
				
				local effectiveLevel = UnitEffectiveLevel("player");
				
				if ( effectiveLevel ~= level ) then
					level = EFFECTIVE_LEVEL_FORMAT:format(effectiveLevel, level);
				end
				
				CharacterLevelText:SetFormattedText(PLAYER_LEVEL, level, thisTRP3CharColor:GenerateHexColor(), thisTRP3CharRace, thisTRP3CharClass);
			else
				CharacterLevelText:SetFormattedText(PLAYER_LEVEL, UnitLevel("player"), thisTRP3CharRace, thisTRP3CharClass);
			end
		end
	end)
	


	-- Quests, Dialog, Gossip Etc.
	if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG) == true) then
	
		
		
		
		if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then

			-- Quest Window in Retail and Wrath
			hooksecurefunc("QuestInfo_Display", function()

				local thisQuestDescription = QuestInfoDescriptionText:GetText()
				
				if (thisQuestDescription ~= nil) then
				
					QuestInfoDescriptionText:SetText(TRP3_RPNameInQuests_CompleteRename(thisQuestDescription))
					
				end

			end)
			
			
		else
			
			-- Quest Window in Classic
			hooksecurefunc("QuestLog_UpdateQuestDetails", function()

				local thisQuestDescription = QuestLogQuestDescription:GetText()
				
				if (thisQuestDescription ~= nil) then
				
					QuestLogQuestDescription:SetText(TRP3_RPNameInQuests_CompleteRename(thisQuestDescription))
					
				end

			end)
		 
		 
		 end
			
			


			-- Get Gossip Text
			local TRP3_RPNameInQuests_C_GossipInfoGetTextHook = C_GossipInfo.GetText
			C_GossipInfo.GetText = function (...)
				
				local thisGossipText = TRP3_RPNameInQuests_C_GossipInfoGetTextHook()
				
				return TRP3_RPNameInQuests_CompleteRename(thisGossipText)
				
				
			end
			

			
			-- Get Greeting Text
			TRP3_RPNameInQuests_GetGreetingTextHook = GetGreetingText
			GetGreetingText = function (...)
			
				local thisGreetingText = TRP3_RPNameInQuests_GetGreetingTextHook()
				
				return TRP3_RPNameInQuests_CompleteRename(thisGreetingText)
				
			end



			-- Get Quest Text
			TRP3_RPNameInQuests_GetQuestTextHook = GetQuestText
			GetQuestText = function (...)
				local thisQuestText = TRP3_RPNameInQuests_GetQuestTextHook()
				
				return TRP3_RPNameInQuests_CompleteRename(thisQuestText)
				
			end



			-- Get Quest Progress Text
			TRP3_RPNameInQuests_GetProgressTextHook = GetProgressText
			GetProgressText = function (...)
			
				local thisProgressText = TRP3_RPNameInQuests_GetProgressTextHook()
				
				return TRP3_RPNameInQuests_CompleteRename(thisProgressText)
				
			end



			-- Get Quest Reward Text
			TRP3_RPNameInQuests_GetRewardTextHook = GetRewardText
			GetRewardText = function (...)
			
				local thisRewardText = TRP3_RPNameInQuests_GetRewardTextHook()
				
				return TRP3_RPNameInQuests_CompleteRename(thisRewardText)
				
			end


			-- Gossip Options
			TRP3_RPNameInQuests_GetGossipOptions = C_GossipInfo.GetOptions
			C_GossipInfo.GetOptions = function (...)
			
				local thisGossipOptions = TRP3_RPNameInQuests_GetGossipOptions()
				
				for key, value in pairs(thisGossipOptions) do
								
					thisGossipOptions[key]["name"] =  TRP3_RPNameInQuests_CompleteRename(thisGossipOptions[key]["name"])
					
				end

				return(thisGossipOptions)
			
			end
			

	
	
	
	
	end --eo QuestDialog
	
	
	
	
	
	
	
	
	
	
	
	-- Mail Window
	-- /Interface/FrameXML/MailFrame.lua
	if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX) == true) then
		hooksecurefunc("OpenMail_Update", function()

				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					if ( not OpenMailFrame_IsValidMailID()) then
						return;
					else
						local bodyText, stationeryID1, stationeryID2, isTakeable, isInvoice, isConsortium = GetInboxText(InboxFrame.openMailID);
						
						if(bodyText) then
							OpenMailBodyText:SetText(TRP3_RPNameInQuests_CompleteRename(bodyText), true);
						end
					end
				else
					if ( not InboxFrame.openMailID ) then
						return;
					else
						local bodyText, stationeryID1, stationeryID2, isTakeable, isInvoice = GetInboxText(InboxFrame.openMailID);
						
						if(bodyText) then
							OpenMailBodyText:SetText(TRP3_RPNameInQuests_CompleteRename(bodyText), true);
						end
					end
				end
				

		end)
	
	end
	
	
	
	
	
	
	
	
	
	TRP3RPNameInQuests_Frame:SetScript("OnEvent", function(self, event, arg1, arg2)
		
		-- Books, etc.
		-- /Interface/FrameXML/ItemTextFrame.lua
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS) == true) then
	
			if event == "ITEM_TEXT_READY" then
			
				local creator = ItemTextGetCreator();
				if ( creator ) then
					creator = "\n\n"..ITEM_TEXT_FROM.."\n"..creator.."\n";
					ItemTextPageText:SetText(TRP3_RPNameInQuests_CompleteRename(ItemTextGetText())..creator);
				else
					ItemTextPageText:SetText(TRP3_RPNameInQuests_CompleteRename(ItemTextGetText()));
				end
				
			end
			
		end
		
		
		--Update Nameplates if title/name changes
		if ( event == "KNOWN_TITLES_UPDATE" or (event == "UNIT_NAME_UPDATE" and arg1 == "player")) then
		
			if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
				TRP3_RPNameInQuests_UpdateUnitFrames()
			end
			
		end
		
		
		
	
	end)

	
	
	


	
	-- Chat Filters
	local function TRP3_RPNameInQuests_ChatFilterFunc(self, thisEvent, thisMessage, thisNPC, ...) 
	
		local thisNewMessage = TRP3_RPNameInQuests_CompleteRename(thisMessage)
			local thisNewNPC = TRP3_RPNameInQuests_RPNameRename(thisNPC)
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH) == true) then
				if (thisEvent == "CHAT_MSG_MONSTER_SAY" or thisEvent == "CHAT_MSG_MONSTER_YELL" or thisEvent ==  "CHAT_MSG_MONSTER_PARTY") then
					pcall(function () 
						TRP3_RPNameInQuests_ModSpeechBubbles()
					end) 
					
				end
			end
			
			
			return false, thisNewMessage, thisNewNPC, ...
	
	end
	
	
	
	-- NPC Speech
	if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH) == true) then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /s Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /y Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /p Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /w Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC /e Chat
	end
	
	
	-- Raid Boss Emote Frame
	if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODRAIDBOSS) == true) then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_EMOTE", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC Boss /e Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_WHISPER", TRP3_RPNameInQuests_ChatFilterFunc) -- NPC Boss /w Chat
	end
	

	--Talking Head
	if ((WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) and (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH) == true)) then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			C_Timer.After(0.3, function()
				--Talker Text
				self.TextFrame.Text:SetText(TRP3_RPNameInQuests_CompleteRename(self.TextFrame.Text:GetText()))
			end);
		end)
	end
	
	
	
	-- Speech Bubbles
	-- with Code Modified from https://www.wowinterface.com/forums/showpost.php?p=336696&postcount=2
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
										
										region:SetText(TRP3_RPNameInQuests_CompleteRename(thisBubbleText))
										
										--Resize bubble to accomodate new text
										if (region:GetStringWidth() >= region:GetWrappedWidth()) then
											region:SetWidth(region:GetWrappedWidth())
										else
											region:SetWidth(region:GetStringWidth())
										end
										
										
									end
								end
							end
						end
					end
				end
			end)
	end
	
	
	
	
	
	--Zone Texts
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	
	
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME) == true) then
		
			TRP3RPNameGetZoneText = GetZoneText
			function GetZoneText()
				return TRP3_RPNameInQuests_RPNameRename(TRP3RPNameGetZoneText(), true)
			end
			
			
			TRP3RPNameGetSubZoneText = GetSubZoneText
			function GetSubZoneText()
				return TRP3_RPNameInQuests_RPNameRename(TRP3RPNameGetSubZoneText(), true)
			end
		
		
		end
	
		--[[
		hooksecurefunc("SetZoneText", function(...)
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME) == true) then
				varCurrentZoneTextString = ZoneTextString:GetText() or ""
				varCurrentSubZoneTextString = SubZoneTextString:GetText() or ""
				
				ZoneTextString:SetText(TRP3_RPNameInQuests_RPNameRename(varCurrentZoneTextString, true))
				SubZoneTextString:SetText(TRP3_RPNameInQuests_RPNameRename(varCurrentSubZoneTextString, true))
			end

		end)
		]]--
		
		hooksecurefunc("Minimap_Update", function(...)
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME) == true) then
				varCurrentMinimapZoneText = GetMinimapZoneText()
				
				MinimapZoneText:SetText(TRP3_RPNameInQuests_RPNameRename(varCurrentMinimapZoneText, true))
			end
		end)
	end
	
	
	
	
	function TRP3_RPNameInQuests_UpdateUnitFrames()
			UnitFrame_Update(PlayerFrame)
			UnitFrame_Update(TargetFrame)
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
		{ "Custom* (Set Below)", 99 },		
	}

	local TRPRPNAMEINQUESTS_DROPDOWNCLASS = {
		{ "OOC Class Name", 1 },
		{ "TRP3 Class Name", 2 },
		{ "Custom* (Set Below)", 99 },	
	}

	local TRPRPNAMEINQUESTS_DROPDOWNRACE = {
		{ "OOC Race Name", 1 },
		{ "TRP3 Race Name", 2 },
		{ "Custom* (Set Below)", 99 },	
	}
	
	local TRP3RPNameInQuests_TextureDot = CreateSimpleTextureMarkup("interface/raidframe/ui-raidframe-threat", 10,10)


	TRP3RPNameInQuests_ConfigElements = {
			{
				inherit = "TRP3_ConfigH1",
				title = TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(TRP3_API.globals.player) .. "'s Quest Text Settings",
			},
			{
				inherit = "TRP3_ConfigParagraph",
				title = "What Name, Race and Class should NPCs refer to " .. TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(TRP3_API.globals.player) .. " as?" .."\n" .. "These options are " .. TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode("Character Specific") .. ".",
			},
			{
				inherit = "TRP3_ConfigDropDown",
				widgetName = "trp3_rpnameinquests_whichrpnamewidget",
				title = ORANGE_FONT_COLOR:WrapTextInColorCode("Character") .. " Name Format",
				help = "Select what Name Format NPCs should refer you to as." .. "\n\n" .. "This uses the Character Name from your currently selected TRP3 Profile.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNSTUFF,
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, value)
					TRP3RPNameInQuests_CharVars.WhichRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME)
				end,

			},
			{
				inherit = "TRP3_ConfigDropDown",
				title = NORMAL_FONT_COLOR:WrapTextInColorCode("Race") .. " Name Format",
				help = "Select what race NPCs should refer to you as." .. "\n\n" .. "Note: Will also affect any regular quest text mentioning your OOC Class Name.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNRACE,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, value)
					TRP3RPNameInQuests_CharVars.CustomRaceName = value
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigDropDown",
				title = TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode("Class")  .. " Name Format",
				help = "Select what class NPCs should refer to you as. " .. "\n\n" .. "Note: Will also affect any regular quest text mentioning your OOC Class Name.",
				listContent = TRPRPNAMEINQUESTS_DROPDOWNCLASS,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAME, value)
					TRP3RPNameInQuests_CharVars.CustomClassName = value
					
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigNote",
				title = "- - -",
			},
			{
				inherit = "TRP3_ConfigEditBox",
				title = "Custom " .. ORANGE_FONT_COLOR:WrapTextInColorCode("Character") .. " Name " .. LIGHTGRAY_FONT_COLOR:WrapTextInColorCode("(*)"),
				help = "Only used if 'Character Name Format' is set as 'Custom'.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT,
			},
			{
				inherit = "TRP3_ConfigEditBox",
				title = "Custom " .. NORMAL_FONT_COLOR:WrapTextInColorCode("Race") .. " Name " .. LIGHTGRAY_FONT_COLOR:WrapTextInColorCode("(*)"),
				help = "Only used if 'Race Name Format' is set as 'Custom'.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT,
			},
			{
				inherit = "TRP3_ConfigEditBox",
				title = "Custom " .. TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode("Class")  .." Name " .. LIGHTGRAY_FONT_COLOR:WrapTextInColorCode("(*)"),
				help = "Only used if 'Class Name Format' is set as 'Custom'.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT,
			},
			{
				inherit = "TRP3_ConfigNote",
				title = " ",
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Text to Modify",
			},
			{
				inherit = "TRP3_ConfigParagraph",
				title = "Select which text this addon should modify to include your RP Name/Race/Class." .. "\n" .. "These options are " .. ORANGE_FONT_COLOR:WrapTextInColorCode("Account Wide") .. ".",
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Quest Text / Gossip",
				help = "If checked, this addon will modify all Quest Text, Gossip Chat and Gossip Options.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;					
					
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, value)
					
					if (TRP3_RPNameInQuests_OldVar_QuestDialog ~= value) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "NPC Speech " .. LIGHTGRAY_FONT_COLOR:WrapTextInColorCode("(/say, /yell, /emote etc)"),
				help = "If checked, this addon will modify all text and speech bubbles for NPCs." .. "\n\n" .. "Does not affect speech from other players.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, value)
					
					if (TRP3_RPNameInQuests_OldVar_NPCSpeech ~= value) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Text Items " .. LIGHTGRAY_FONT_COLOR:WrapTextInColorCode("(Books, Letters, Plaques etc)"),
				help = "If checked, this addon will modify text items such as Books, Letters and other text items you can find in the world.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;

					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS, value)

					if (TRP3_RPNameInQuests_OldVar_TextItems ~= value) then
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
					
					if (TRP3_RPNameInQuests_OldVar_Mailbox ~= value) then
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

					if (TRP3_RPNameInQuests_OldVar_RaidBossEmote ~= value) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = "Only modify Race/Class adjacent to punctuation",
				help = "If checked, your RP Race or Class will only be modified in quest text if it is next to a full stop, comma, question mark, or exclamation mark.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;

					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION, value)


					
				end,
			},
			{
				inherit = "TRP3_ConfigNote",
				title = " ",
			},
			{
				inherit = "TRP3_ConfigH1",
				title = "Extra Functions",
			},
			{
				inherit = "TRP3_ConfigParagraph",
				title = "Add your TRP3 Character Information to other UI elements." .. "\n" .. NORMAL_FONT_COLOR:WrapTextInColorCode("These functions may not be compatible with custom UI addons or frameworks.") ..  "\n" .. "These options are " .. ORANGE_FONT_COLOR:WrapTextInColorCode("Account Wide") .. ".",
			},
			{
				inherit = "TRP3_ConfigNote",
				title = LORE_TEXT_BODY_COLOR:WrapTextInColorCode("Show my Character's TRP3 Info:"),
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = TRP3RPNameInQuests_TextureDot .. " " .. "In the Player Unit Frame",
				help = "If checked, your TRP3 Character Name will be shown in your Unit Frame.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME, value)	
					
					--Update Unit Frames
					TRP3_RPNameInQuests_UpdateUnitFrames()
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = TRP3RPNameInQuests_TextureDot .. " " ..  "In the Character Window",
				help = "If checked, your TRP3 Character Name, Race and Class will be shown in the Character Window (aka Paper Doll).",
				configKey = TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, value)
					
					--Save Variables we can't save otherwise
					TRP3RPNameInQuests_CharVars.WhichRPNameText = TRP3_API.utils.str.sanitize(TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT))
					
					TRP3RPNameInQuests_CharVars.CustomClassNameText = TRP3_API.utils.str.sanitize(TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT))
					
					TRP3RPNameInQuests_CharVars.CustomRaceNameText = TRP3_API.utils.str.sanitize(TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT))
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = TRP3RPNameInQuests_TextureDot .. " " ..  "In the Party/Raid Frame",
				help = "If checked, your TRP3 Character Name will be shown in your Party/Raid Frame.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME, value)	
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = TRP3RPNameInQuests_TextureDot .. " " .. "In Zone Names" .. " " .. LIGHTGRAY_FONT_COLOR:WrapTextInColorCode("(e.g. Garrison)"),
				help = "If checked, your TRP3 Character Name will be shown in Zone Names where appropriate." .. "\n" .. "For example, your Draenor Garrison.",
				configKey = TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME, value)	
					
					if (TRP3_RPNameInQuests_OldVar_ZoneNameRPName ~= value) then
						TRP3_API.popup.showConfirmPopup("This change requires you to /reload the UI.", ReloadUI);
					end
					
				end,
			},
			
		}
		
		
	-- Remove Zone Names from non-retail
	if (WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE) then
		table.remove(TRP3RPNameInQuests_ConfigElements, 26)
	end
	
	-- Remove Unit Frame Option if needed
	if (TRP3_RPNameInQuests_IgnoreUnitFrameMods == true) then
		table.remove(TRP3RPNameInQuests_ConfigElements, 23)
	end
	

	--Create Config Page
	TRP3_API.configuration.registerConfigurationPage({
			id = "trp3_rpnameinquests_config",
			menuText = "Quest Text",
			pageText = "RP Name in Quest Text",
			elements = TRP3RPNameInQuests_ConfigElements
		});

end




TRP3_API.module.registerModule({
	name = "RP Name in Quest Text",
	description = "Enhances questing immersion by putting your TRP3 Character Name (and optionally Race and Class) into Quest Text!",
	version = "1.2.12",
	id = "trp3_rpnameinquests",
	onStart = TRP3RPNameInQuests_Init,
	minVersion = 110,
});


-- Slash Command
function TRP3RPNameInQuests_OpenConfig()
	TRP3_API.navigation.openMainFrame();
	TRP3_API.navigation.page.setPage("trp3_rpnameinquests_config");
end

local TRP3RPNameInQuests_OpenConfigCommand = {
	id = "questtext",
	helpLine = " Open the 'RP Name in Quest Text' Config.",
	handler = function()
		TRP3RPNameInQuests_OpenConfig();
	end,
}

TRP3_API.slash.registerCommand(TRP3RPNameInQuests_OpenConfigCommand);






--Addon Compartment
local TRP3RPNameInQuests_Tooltip

function TRP3RPNameInQuests_CompartmentClick(addonName, buttonName)
	TRP3RPNameInQuests_OpenConfig()
end

function TRP3RPNameInQuests_CompartmentHover(addonName, buttonName)
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		if (not TRP3RPNameInQuests_Tooltip) then
			TRP3RPNameInQuests_Tooltip = CreateFrame("GameTooltip", "TRP3RPNameInQuests_Tooltip_Compartment", UIParent, "GameTooltipTemplate")
		end
		
		local TRP3RPNameInQuests_ClassColorString = CreateColor(GetClassColor(TRP3_API.globals.player_character.class)) or NORMAL_FONT_COLOR
		
		TRP3RPNameInQuests_Tooltip:SetOwner(buttonName, "ANCHOR_LEFT");
		TRP3RPNameInQuests_Tooltip:SetText("TRP3: RP Name in Quest Text")
		
		TRP3RPNameInQuests_Tooltip:AddLine(" ")
		TRP3RPNameInQuests_Tooltip:AddLine("How NPCs will address " .. TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(TRP3_API.globals.player) .. ":", WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		TRP3RPNameInQuests_Tooltip:AddLine(" ")
		
		TRP3RPNameInQuests_Tooltip:AddDoubleLine("Name:", TRP3_RPNameInQuests_GetFullRPName(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		TRP3RPNameInQuests_Tooltip:AddDoubleLine("Race:", TRP3_RPNameInQuests_ReturnRPRace(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		TRP3RPNameInQuests_Tooltip:AddDoubleLine("Class:", TRP3_RPNameInQuests_ReturnRPClass(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		
		TRP3RPNameInQuests_Tooltip:AddLine(" ")
		TRP3RPNameInQuests_Tooltip:AddLine("Click to change settings.", GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)

		TRP3RPNameInQuests_Tooltip:Show()
	end
end

function TRP3RPNameInQuests_CompartmentLeave(buttonName)
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		TRP3RPNameInQuests_Tooltip:Hide()
	end
end
