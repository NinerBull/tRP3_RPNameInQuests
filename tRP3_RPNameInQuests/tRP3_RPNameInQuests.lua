--[[
================================================
Total RP 3: RP Name in Quest Text
https://github.com/NinerBull/tRP3_RPNameInQuests
================================================

------------------------------------------
Requires Total RP 3 
https://github.com/Total-RP/Total-RP-3
------------------------------------------
]]--

local _, L = ...;

TRP3RPNameInQuests = CreateFrame("Frame")
TRP3RPNameInQuests:RegisterEvent("ITEM_TEXT_READY");
TRP3RPNameInQuests:RegisterEvent("UNIT_NAME_UPDATE");
TRP3RPNameInQuests:RegisterEvent("ADDON_LOADED")
TRP3RPNameInQuests:RegisterEvent("PLAYER_ENTERING_WORLD")
TRP3RPNameInQuests:RegisterEvent("GOSSIP_SHOW")

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	TRP3RPNameInQuests:RegisterEvent("KNOWN_TITLES_UPDATE");
end


function TRP3RPNameInQuests:Init()

	--Create table to save user's variables	
	if (type(TRP3RPNameInQuests_CharVars) ~= "table") then		
		TRP3RPNameInQuests_CharVars = {}
		TRP3_API.utils.message.displayMessage(string.format(L.FIRST_TIME_INSTALL_GREET, TRP3_API.Colors.Cyan("RP Name in Quest Text"), TRP3_API.Colors.Cyan("/trp3 questtext")),1)
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

	
	-- Set Default Addon Variables
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
	
	
	-- Player's Class Colour
	TRP3RPNameInQuests.ClassColorString = CreateColor(GetClassColor(TRP3_API.globals.player_character.class)) or NORMAL_FONT_COLOR


	--TRP3 Variables
	TRP3RPNameInQuests.Config = {};

	TRP3RPNameInQuests.Config.WHICHRPNAME = "trp3_rpnameinquests_whichrpname";
	TRP3RPNameInQuests.Config.WHICHRPNAMETEXT = "trp3_rpnameinquests_whichrpnametext";

	TRP3RPNameInQuests.Config.CUSTOMCLASSNAME = "trp3_rpnameinquests_customclassname";
	TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT = "trp3_rpnameinquests_customclassnametext";

	TRP3RPNameInQuests.Config.CUSTOMRACENAME = "trp3_rpnameinquests_customracename";
	TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT = "trp3_rpnameinquests_customracenametext";

	TRP3RPNameInQuests.Config.TEXTMODQUESTDIALOG = "trp3_rpnameinquests_textmod_questdialog";
	TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH = "trp3_rpnameinquests_textmod_npcspeech";
	TRP3RPNameInQuests.Config.TEXTMODTEXTITEMS = "trp3_rpnameinquests_textmod_textitems";
	TRP3RPNameInQuests.Config.TEXTMODMAILBOX = "trp3_rpnameinquests_textmod_mailbox";
	TRP3RPNameInQuests.Config.RACECLASSPUNCTUATION = "trp3_rpnameinquests_textmod_raceclasspunctuation";

	TRP3RPNameInQuests.Config.UNITFRAMERPNAME = "trp3_rpnameinquests_unitframerpname";
	TRP3RPNameInQuests.Config.PAPERDOLLRPNAME = "trp3_rpnameinquests_paperdollrpname";
	TRP3RPNameInQuests.Config.PARTYFRAMERPNAME = "trp3_rpnameinquests_partyframerpname";
	TRP3RPNameInQuests.Config.PARTYFRAMERPCOLOR = "trp3_rpnameinquests_partyframerpcolor";
	TRP3RPNameInQuests.Config.ZONENAMERPNAME = "trp3_rpnameinquests_zonenamerpname";
	
	TRP3RPNameInQuests.Config.ALTRPNAMEREPLACEMENT = "trp3_rpnameinquests_altnamerpreplacement";
	TRP3RPNameInQuests.Config.NOTINENCOUNTER = "trp3_rpnameinquests_notinencounter";
	--TRP3RPNameInQuests.Config.USEFUNCHOOKS = "trp3_rpnameinquests_usefunchooks";
	TRP3RPNameInQuests.Config.QTMODMETHOD = "trp3_rpnameinquests_qtmodmethod";

	-- Register and set value for variables

	-- ==Character Specific==
	
	--WhichRPName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.WHICHRPNAME, TRP3RPNameInQuests_CharVars.WhichRPName);
	TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.WHICHRPNAME, TRP3RPNameInQuests_CharVars.WhichRPName);
	
	--WhichRPNameText
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.WHICHRPNAMETEXT, TRP3RPNameInQuests_CharVars.WhichRPNameText);
	TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.WHICHRPNAMETEXT, TRP3RPNameInQuests_CharVars.WhichRPNameText);

	--CustomClassName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME, TRP3RPNameInQuests_CharVars.CustomClassName);
	TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME, TRP3RPNameInQuests_CharVars.CustomClassName);

	--CustomClassNameText
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT, TRP3RPNameInQuests_CharVars.CustomClassNameText);
	TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT, TRP3RPNameInQuests_CharVars.CustomClassNameText);

	--CustomRaceName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.CUSTOMRACENAME, TRP3RPNameInQuests_CharVars.CustomRaceName);
	TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME, TRP3RPNameInQuests_CharVars.CustomRaceName);

	--CustomRaceNameText
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT, TRP3RPNameInQuests_CharVars.CustomRaceNameText);
	TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT, TRP3RPNameInQuests_CharVars.CustomRaceNameText);



	-- ==Account Wide==
	
	--QuestDialog
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.TEXTMODQUESTDIALOG, true);
	
	--NPCSpeech
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH, true);
	
	--TextItems
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.TEXTMODTEXTITEMS, true);

	--Mailbox
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.TEXTMODMAILBOX, true);
	
	--RaceClassPunctuationAdjacent
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.RACECLASSPUNCTUATION, true);

	--UnitFrameRPName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.UNITFRAMERPNAME, false);

	--PaperDollRPName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.PAPERDOLLRPNAME, false);
	
	--PartyFrameRPName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.PARTYFRAMERPNAME, false);
	
	--PartyFrameRPColor
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.PARTYFRAMERPCOLOR, false);
	
	--ZoneNameRPName
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.ZONENAMERPNAME, false);
	
	
	--Alternate RP Name Replacement
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.ALTRPNAMEREPLACEMENT, false);
	
	--Don't Modify in Encounter
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.NOTINENCOUNTER, false);
	
	--Use Function Hooks
	--TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.USEFUNCHOOKS, false);
	
	-- Quest Text Modification Method
	TRP3_API.configuration.registerConfigKey(TRP3RPNameInQuests.Config.QTMODMETHOD, 1);
	



	--Temp Values to check if /reload is needed
	TRP3RPNameInQuests.OldVar = {}
	TRP3RPNameInQuests.OldVar.QuestDialog = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODQUESTDIALOG)
	TRP3RPNameInQuests.OldVar.NPCSpeech = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH)
	TRP3RPNameInQuests.OldVar.TextItems = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODTEXTITEMS)
	TRP3RPNameInQuests.OldVar.Mailbox = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODMAILBOX)
	TRP3RPNameInQuests.OldVar.ZoneNameRPName = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.ZONENAMERPNAME)
	--TRP3RPNameInQuests.OldVar.UseFuncHooks = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.USEFUNCHOOKS)
	TRP3RPNameInQuests.OldVar.QTModMethod = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.QTMODMETHOD)
	
	
	-- Bypass Unit Frame options if totalRP3_UnitFrames is loaded.
	-- (Go get it btw it's awesome)
	-- https://github.com/keyboardturner/totalRP3_UnitFrames

	TRP3RPNameInQuests.IgnoreUnitFrameMods = C_AddOns.IsAddOnLoaded("totalRP3_UnitFrames") or false
	TRP3RPNameInQuests.NameToChange = TRP3_API.globals.player or UnitNameUnmodified("player")
	TRP3RPNameInQuests.RaceToChange = TRP3_API.globals.player_race_loc or UnitRace("player")
	TRP3RPNameInQuests.ClassToChange = TRP3_API.globals.player_class_loc or UnitClass("player")
	

	-- API Table
	TRP3RPNameInQuests.API = {}

	function TRP3RPNameInQuests.API:ShouldNotEditText(strict)
	
		local shouldPrevent = false
		
		if (TRP3_API.utils.IsInCombatInstance()) then
			shouldPrevent = true
		end
				
		--Should we not try to edit text right now?
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.NOTINENCOUNTER) == true and shouldPrevent == true) 
		or (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown()) then
			return true
		else
			return false
		end
		
	end
	
	
	
	
	function TRP3RPNameInQuests.API:IsEncounterInProgress()
	
		if IsEncounterInProgress then
			return IsEncounterInProgress()
		elseif C_InstanceEncounter and C_InstanceEncounter.IsEncounterInProgress then
			return C_InstanceEncounter.IsEncounterInProgress()
		else
			return false
		end
	
	end
	
	
	function TRP3RPNameInQuests.API:QuestTextAddonDetected()
		-- List addons here that use functions such as GetQuestText 
		return (C_AddOns.IsAddOnLoaded("Immersion") or C_AddOns.IsAddOnLoaded("Interaction") or C_AddOns.IsAddOnLoaded("Storyline"))
	
	end
	
	

	-- Full TRP3 Name (Including Title)
	function TRP3RPNameInQuests.API:GetFullRPName(getFullName)
	
		getFullName = getFullName or false
			
		local thisTRP3CharInfo = TRP3_API.profile.getData("player/characteristics")
		
		local thisTRP3CharNameFull = ""
		
		if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 2 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 3 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 4 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 5) or (getFullName == true)) then
			if (thisTRP3CharInfo.TI) then
				thisTRP3CharNameFull = thisTRP3CharNameFull .. thisTRP3CharInfo.TI	.. " "
			end
		end
		
		if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 3 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 5 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 6 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 8) or (getFullName == true)) then
			if (thisTRP3CharInfo.FN) then
				thisTRP3CharNameFull = thisTRP3CharNameFull .. thisTRP3CharInfo.FN
			end
		end
		
		if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 4 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 5 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 7 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 8) or (getFullName == true)) then
			if (thisTRP3CharInfo.LN) then
				thisTRP3CharNameFull = thisTRP3CharNameFull .. " " ..  thisTRP3CharInfo.LN
			end
		end
		
		
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.ALTRPNAMEREPLACEMENT) == true) then
			--Remove double of title, if it exists
			if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 2 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 3 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 4 or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 5) or (getFullName == true)) then
			
				if (thisTRP3CharInfo.TI) then
					if (string.find(thisTRP3CharNameFull, thisTRP3CharInfo.TI .. " " .. thisTRP3CharInfo.TI)) then
						thisTRP3CharNameFull = thisTRP3CharNameFull:gsub(thisTRP3CharInfo.TI .. " " .. thisTRP3CharInfo.TI, thisTRP3CharInfo.TI)
					end
				end
			
			end
		
		end
		
		
		-- If the player wants to use a custom name, grab that instead
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) == 99 and getFullName == false) then
			thisTRP3CharNameFull = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAMETEXT)
		end
		
		-- Trim extra space on the left and right of the string
		thisTRP3CharNameFull = thisTRP3CharNameFull:gsub("%s+", " ")
		thisTRP3CharNameFull = thisTRP3CharNameFull:gsub("^%s*(.-)%s*$", "%1")
		--string.join(" ", string1, string2);
		
		
		-- If for some reason the character name is empty, default back to the player's OOC name
		if (thisTRP3CharNameFull == "") then
			thisTRP3CharNameFull = TRP3_API.globals.player or UnitNameUnmodified("player")
		end
			
		
		return thisTRP3CharNameFull

	end
	
	

	-- Functions that do the actual renaming

	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		-- Some allied races use a different race name in quest text rather than their full race name
		local thisPlayerRaceName, thisPlayerRaceFile, thisPlayerRaceID = UnitRace("player")
		
		thisActualRaceInfo = {}
		
		if (thisPlayerRaceID == 28) then -- Highmountain Tauren
			thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(6)
		end
		
		if (thisPlayerRaceID == 30) then -- Lightforged Draenei
			 thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(11)
		end
		
		if (thisPlayerRaceID == 31) then -- Zandalari Troll
			thisActualRaceInfo.raceName = TRP3RPNameInQuests.RaceToChange:match("(%w+)(.*)")
		end
		
		if (thisPlayerRaceID == 34) then -- Dark Iron Dwarf
			thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(3)
		end
		
		if (thisPlayerRaceID == 36) then -- Mag'har Orc
			 thisActualRaceInfo = C_CreatureInfo.GetRaceInfo(2)
		end
		
		
		if (thisActualRaceInfo.raceName ~= nil) then
			TRP3RPNameInQuests.RaceToChange = thisActualRaceInfo.raceName
		end
		
		
	end
	
	
	
	
	
	--Rename Character
	function TRP3RPNameInQuests.API:RPNameRename(textToRename, renameFullName, doUpperCase)
	
		renameFullName = renameFullName or false
		doUpperCase = doUpperCase or false
			
		if (canaccessvalue and not canaccessvalue(textToRename)) then
			return textToRename
		end
		
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return textToRename
		end
	
		thisTextToReturn = textToRename
		
		--rename char
		thisTRP3CharName = TRP3RPNameInQuests.API:GetFullRPName(renameFullName)
				
		if (thisTRP3CharName == "") then
			--empty, do nothing
			thisTRP3CharName = TRP3RPNameInQuests.NameToChange
		else
		
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.ALTRPNAMEREPLACEMENT) == true) then
				if (textToRename) then
					if (doUpperCase == true) then
						textToRename = textToRename:gsub(string.upper(TRP3RPNameInQuests.NameToChange), string.upper(thisTRP3CharName))
					else
						textToRename = textToRename:gsub(TRP3RPNameInQuests.NameToChange, thisTRP3CharName)
					end
				end
			
			else
				
				if (doUpperCase == true) then
					if (textToRename and not(string.find(textToRename, string.upper(thisTRP3CharName)  .. "%A"))) then
						textToRename = textToRename:gsub(string.upper(TRP3RPNameInQuests.NameToChange), string.upper(thisTRP3CharName))
					end
				else
					if (textToRename and not(string.find(textToRename, thisTRP3CharName  .. "%A"))) then
						textToRename = textToRename:gsub(TRP3RPNameInQuests.NameToChange, thisTRP3CharName)
					end

				end
			
			end
			
		end
		thisTextToReturn =  textToRename

		return thisTextToReturn
		
	end

	
	
	-- Return RP Name
	function TRP3RPNameInQuests.API:ReturnRPName(renameFullName)
	
		renameFullName = renameFullName or false
	
		return TRP3RPNameInQuests.API:GetFullRPName(renameFullName)
		
	end
	
	
	-- Return RP Name Target
	function TRP3RPNameInQuests.API:ReturnRPNameTarget(thisTarget, withTitle)
	
		thisTarget = thisTarget or "player"
		withTitle = withTitle or false
		
		if (canaccessvalue and not canaccessvalue(thisTarget)) then
			return UnitName(thisTarget)
		end
		
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return UnitName(thisTarget)
		end
		
		local thisPlayer = AddOn_TotalRP3.Player.CreateFromUnit(tostring(thisTarget))
	
		local thisFullName = thisPlayer:GetFullName() or TRP3RPNameInQuests.NameToChange
		local thisFullTitle = thisPlayer:GetTitle()
		
		if (withTitle == true) then
			if (thisFullTitle ~= nil) then
				thisFullName = string.join(" ", thisFullTitle, thisFullName)
			end
		end
		
		thisFullName = thisFullName:gsub("%s+", " ")
		thisFullName = thisFullName:gsub("^%s*(.-)%s*$", "%1")
		
		return thisFullName
	
	end
	
	

	
	
	--Rename Race
	function TRP3RPNameInQuests.API:RPRaceRename(textToRename, doLowerCase, doUpperCase)
	
		doLowerCase = doLowerCase or false
		doUpperCase = doUpperCase or false
		
		if (canaccessvalue and not canaccessvalue(textToRename)) then
			return textToRename
		end
		
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return textToRename
		end
		
		thisTextToReturn = textToRename
		local thisTRP3CharInfoR = TRP3_API.profile.getData("player/characteristics")
		thisRaceName = TRP3RPNameInQuests.RaceToChange
		
		--If not OOC Race Name
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) ~= 1) then
			--TRP3 Race Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) == 2) then
				if (thisTRP3CharInfoR.RA ~= nil) then
					thisRaceName = thisTRP3CharInfoR.RA
				end
			end
			
			--Custom Race Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) == 99) then
				if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT) ~= "") then
					thisRaceName = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT)
				end
			end
			
			
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.RACECLASSPUNCTUATION) == true) then
			
			
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(", " .. TRP3RPNameInQuests.RaceToChange),string.lower(", " .. thisRaceName))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.RaceToChange .. ","),string.lower(thisRaceName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.RaceToChange .. "%."),string.lower(thisRaceName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.RaceToChange .. "%?"),string.lower(thisRaceName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.RaceToChange .. "!"),string.lower(thisRaceName .. "!"))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(", " .. TRP3RPNameInQuests.RaceToChange),string.upper(", " .. thisRaceName))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.RaceToChange .. ","),string.upper(thisRaceName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.RaceToChange .. "%."),string.upper(thisRaceName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.RaceToChange .. "%?"),string.upper(thisRaceName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.RaceToChange .. "!"),string.upper(thisRaceName .. "!"))
				else
					thisTextToReturn = thisTextToReturn:gsub(", " .. TRP3RPNameInQuests.RaceToChange,", " .. thisRaceName)
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.RaceToChange .. "," ,thisRaceName .. ",")
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.RaceToChange .. "%." ,thisRaceName .. ".")
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.RaceToChange .. "%?" ,thisRaceName .. "?")
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.RaceToChange .. "!" ,thisRaceName .. "!")
				end
			
			else
			
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.RaceToChange),string.lower(thisRaceName))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.RaceToChange),string.upper(thisRaceName))
				else
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.RaceToChange,thisRaceName)
				end
			
			end
			
			
	
		end
		
		return thisTextToReturn
		
	end
	
	
	
	 
	 --Return RP Race
	function TRP3RPNameInQuests.API:ReturnRPRace()
	
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return UnitRace("player")
		end
	
		local thisTRP3CharInfoR = TRP3_API.profile.getData("player/characteristics")
		thisRaceName = TRP3RPNameInQuests.RaceToChange
		
		--If not OOC Race Name
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) ~= 1) then
			--TRP3 Race Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) == 2) then
				if (thisTRP3CharInfoR.RA ~= nil) then
					thisRaceName = thisTRP3CharInfoR.RA
				end
			end
		
			--Custom Race Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) == 99) then
				if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT) ~= "") then
					thisRaceName = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT)
				end
			end
				
		end
		
		return thisRaceName
	
	 end
	 
	 


	 
	--Rename Class
	 function TRP3RPNameInQuests.API:RPClassRename(textToRename, doLowerCase, doUpperCase)
	 
		if (canaccessvalue and not canaccessvalue(textToRename)) then
			return textToRename
		end
	 
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return textToRename
		end
	
		doLowerCase = doLowerCase or false
		doUpperCase = doUpperCase or false
		thisTextToReturn = textToRename
		local thisTRP3CharInfoC = TRP3_API.profile.getData("player/characteristics")
		thisClassName = TRP3RPNameInQuests.ClassToChange
	
		--If not OOC Class Name
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) ~= 1) then
			--TRP3 Class Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) == 2) then
				if (thisTRP3CharInfoC.CL ~= nil) then
					thisClassName = thisTRP3CharInfoC.CL
				end
			end
			
			--Custom Class Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) == 99) then
				if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT) ~= "") then
					thisClassName = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT)
				end
			end
			
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.RACECLASSPUNCTUATION) == true) then
				--Replace text next to punctuation
				
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(", " .. TRP3RPNameInQuests.ClassToChange),string.lower(", " .. thisClassName))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.ClassToChange .. ","),string.lower(thisClassName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.ClassToChange .. "%."),string.lower(thisClassName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.ClassToChange .. "%?"),string.lower(thisClassName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.ClassToChange .. "!"),string.lower(thisClassName .. "!"))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(", " .. TRP3RPNameInQuests.ClassToChange),string.upper(", " .. thisClassName))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.ClassToChange .. ","),string.upper(thisClassName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.ClassToChange .. "%."),string.upper(thisClassName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.ClassToChange .. "%?"),string.upper(thisClassName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.ClassToChange .. "!"),string.upper(thisClassName .. "!"))
				else
					thisTextToReturn = thisTextToReturn:gsub(", " .. TRP3RPNameInQuests.ClassToChange,", " ..thisClassName)
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.ClassToChange .. ",",thisClassName .. ",")
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.ClassToChange .. "%.",thisClassName .. ".")
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.ClassToChange .. "%?",thisClassName .. "?")
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.ClassToChange .. "!",thisClassName .. "!")
				end

			else
			
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3RPNameInQuests.ClassToChange),string.lower(thisClassName))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3RPNameInQuests.ClassToChange),string.upper(thisClassName))
				else
					thisTextToReturn = thisTextToReturn:gsub(TRP3RPNameInQuests.ClassToChange,thisClassName)
					
				end
			
			end
			
			
	
		end
	
		return thisTextToReturn
	
	end
	
	
	
	
	--Return Class Name
	 function TRP3RPNameInQuests.API:ReturnRPClass()
	 
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return UnitClass("player")
		end
	
		local thisTRP3CharInfoC = TRP3_API.profile.getData("player/characteristics")
		thisClassName = TRP3RPNameInQuests.ClassToChange
	
		--If not OOC Class Name
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) ~= 1) then
			--TRP3 Class Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) == 2) then
				if (thisTRP3CharInfoC.CL ~= nil) then
					thisClassName = thisTRP3CharInfoC.CL
				end
			end
			
			--Custom Class Name
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) == 99) then
				if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT) ~= "") then
					thisClassName = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT)
				end
			end
	
		end
		
		return thisClassName

	end
	
	
	
	
	
	--Complete Rename Function
	function TRP3RPNameInQuests.API:CompleteRename(textToRename)
		
		if (canaccessvalue and not canaccessvalue(textToRename)) then
			return textToRename
		end
	
		if TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			return textToRename
		end

		thisRenamedText = textToRename or ""
		
		--CharacterName
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME) ~= 1) then
		
			-- Find out if TRP3 Name is a short version of OOC Name
			lengthOfOOCName = string.len(TRP3RPNameInQuests.NameToChange)
			lengthOfTRP3Name = string.len(TRP3RPNameInQuests.API:RPNameRename(TRP3RPNameInQuests.NameToChange, true))
			
		
			if (lengthOfTRP3Name >= lengthOfOOCName) then
				if (strmatch(thisRenamedText, TRP3RPNameInQuests.NameToChange) and (not (strmatch(thisRenamedText, TRP3RPNameInQuests.API:ReturnRPName(true))))) then
					thisRenamedText =  TRP3RPNameInQuests.API:RPNameRename(thisRenamedText)
				end
				
				if (strmatch(thisRenamedText, string.upper(TRP3RPNameInQuests.NameToChange)) and (not (strmatch(thisRenamedText, TRP3RPNameInQuests.API:ReturnRPName(true))))) then
					thisRenamedText =  TRP3RPNameInQuests.API:RPNameRename(thisRenamedText, false, true)
				end
				
			else
				if (strmatch(thisRenamedText, TRP3RPNameInQuests.NameToChange)) then
					thisRenamedText =  TRP3RPNameInQuests.API:RPNameRename(thisRenamedText)
				end
				if (strmatch(thisRenamedText, string.upper(TRP3RPNameInQuests.NameToChange))) then
					thisRenamedText =  TRP3RPNameInQuests.API:RPNameRename(thisRenamedText, false, true)
				end
			end
		end
		
		--ClassName
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME) ~= 1) then
			if (strmatch(thisRenamedText, TRP3RPNameInQuests.ClassToChange)) then
				thisRenamedText =  TRP3RPNameInQuests.API:RPClassRename(thisRenamedText)
			end
			if (strmatch(thisRenamedText, string.lower(TRP3RPNameInQuests.ClassToChange))) then
				thisRenamedText =  TRP3RPNameInQuests.API:RPClassRename(thisRenamedText, true)
			end
			if (strmatch(thisRenamedText, string.upper(TRP3RPNameInQuests.ClassToChange))) then
				thisRenamedText =  TRP3RPNameInQuests.API:RPClassRename(thisRenamedText, false, true)
			end
		end
		
		--RaceName
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME) ~= 1) then
			if (strmatch(thisRenamedText, TRP3RPNameInQuests.RaceToChange)) then
				thisRenamedText =  TRP3RPNameInQuests.API:RPRaceRename(thisRenamedText)
			end
			if (strmatch(thisRenamedText, string.lower(TRP3RPNameInQuests.RaceToChange))) then
				thisRenamedText =  TRP3RPNameInQuests.API:RPRaceRename(thisRenamedText, true)
			end
			if (strmatch(thisRenamedText, string.upper(TRP3RPNameInQuests.RaceToChange))) then
				thisRenamedText =  TRP3RPNameInQuests.API:RPRaceRename(thisRenamedText, false, true)
			end
		end

		
		return thisRenamedText
	
	
	
	end
	
	

	
	-- Unit Frame
	-- If "Show my character's TRP3 info in the Player Unit Frame" is enabled, these will add the full character name to it.
	hooksecurefunc("UnitFrame_Update", function(self, isParty)
		if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			pcall(function () 
				if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.UNITFRAMERPNAME) == true) and (TRP3RPNameInQuests.IgnoreUnitFrameMods == false)) then
					if self.name and self.unit then
						if (UnitPlayerControlled(tostring(self.unit))) then
							if (UnitName(tostring(self.unit)) ~= TRP3_API.register.getUnitRPName(tostring(self.unit))) then
								local thisRealmString = ""
								if (UnitRealmRelationship(tostring(self.unit)) == LE_REALM_RELATION_COALESCED) then
									thisRealmString = FOREIGN_SERVER_LABEL
								--elseif if (UnitRealmRelationship(tostring(self.thisUnit)) == LE_REALM_RELATION_VIRTUAL) then
									--thisRealmString = INTERACTIVE_SERVER_LABEL
								end
								self.name:SetText(TRP3RPNameInQuests.API:ReturnRPNameTarget(self.unit, true) .. thisRealmString)
							end
						end
					end
				end
			end)
		end
	end)

		
	
	-- Party/Raid Frames
	-- If "Show my character's TRP3 info in the Player Unit Frame" is enabled, these will add the full character name to the Raid Frames.
	hooksecurefunc("CompactUnitFrame_UpdateName", function(self)
		if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			pcall(function () 
				if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.PARTYFRAMERPNAME) == true) and (C_AddOns.IsAddOnLoaded("Blizzard_CUFProfiles"))) then
					if self.name and self.unit then
						if (UnitPlayerControlled(tostring(self.unit))) then
							if (UnitName(tostring(self.unit)) ~= TRP3_API.register.getUnitRPName(tostring(self.unit))) then
									local thisRealmString = ""
									if (UnitRealmRelationship(tostring(self.unit)) == LE_REALM_RELATION_VIRTUAL) then
										thisRealmString = FOREIGN_SERVER_LABEL
									end
									self.name:SetText(TRP3RPNameInQuests.API:ReturnRPNameTarget(self.unit) .. thisRealmString)
								
							end
						end
					end
				end
			end)
		end
	end)
	
	
	-- 
	-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_UnitFrame/Mainline/CompactUnitFrame.lua#L553
	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
		local inInstance, instanceType = IsInInstance()
		if (not TRP3RPNameInQuests.API:ShouldNotEditText(true) and instanceType ~= "raid") then
			if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.PARTYFRAMERPNAME) == true) and (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.PARTYFRAMERPCOLOR) == true) and (C_AddOns.IsAddOnLoaded("Blizzard_CUFProfiles")) and type(CompactUnitFrame_GetOptionUseClassColors) ~= "nil") then
				
				local unitIsConnected = UnitIsConnected(frame.unit);
				local unitIsDead = unitIsConnected and UnitIsDead(frame.unit);
				local unitIsPlayer = UnitIsPlayer(frame.unit) or UnitIsPlayer(frame.displayedUnit);
				local unitIsActivePlayer = UnitIsUnit(frame.unit, "player") or UnitIsUnit(frame.displayedUnit, "player");
				
				if ( not unitIsConnected or (unitIsDead and not unitIsPlayer) ) then
					
				elseif ( C_GameRules.IsGameRuleActive(Enum.GameRule.PlayerNameplateAlternateHealthColor) and unitIsPlayer and not unitIsActivePlayer and UnitCanAttack("player", frame.unit) ) then
					
				else
					if ( frame.optionTable.healthBarColorOverride ) then
						
					else
						
						local useClassColors = CompactUnitFrame_GetOptionUseClassColors(frame, frame.optionTable);
						
						if ( (frame.optionTable.allowClassColorsForNPCs or UnitIsPlayer(frame.unit) or UnitTreatAsPlayerForDisplay(frame.unit)) and classColor and useClassColors ) then
								
						elseif ( CompactUnitFrame_IsTapDenied(frame) ) then
					
						elseif ( frame.optionTable.colorHealthBySelection ) then
							
						elseif ( UnitIsFriend("player", frame.unit) ) then
						
							thisUnitFrameColorDisplay = AddOn_TotalRP3.Player.CreateFromUnit(frame.unit):GetCustomColorForDisplay() or nil

							if (UnitIsPlayer(frame.unit) and (thisUnitFrameColorDisplay)) then
								
								local thisCustomClassColor = thisUnitFrameColorDisplay:GetRGBTable() or nil
							
								if (thisCustomClassColor ~= nil) then
							
									frame.healthBar:SetStatusBarColor(thisCustomClassColor.r, thisCustomClassColor.g, thisCustomClassColor.b);
								
								end
							
							end
								
						else

						end
					end
				end
			end
		end
	end)
	--AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
	
	
	
	-- Update Unit Frames when profile changed
	if (not WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then -- BROKEN IN 12.0.0
		TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_PROFILES_LOADED", function()
			if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.UNITFRAMERPNAME) == true) and (TRP3RPNameInQuests.IgnoreUnitFrameMods == false)) then
				if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
					TRP3RPNameInQuests:UpdateUnitFrames()
				end
			end
		end);
		
		TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_DATA_UPDATED", function()
			if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.UNITFRAMERPNAME) == true) and (TRP3RPNameInQuests.IgnoreUnitFrameMods == false)) then
				if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
					TRP3RPNameInQuests:UpdateUnitFrames()
				end
			end
		end);
	end
	

	
	-- Character Sheet
	hooksecurefunc("ToggleCharacter", function()
		if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.PAPERDOLLRPNAME) == true) then
				if ( CharacterFrame:IsShown() ) then
					if (TRP3RPNameInQuests.API:ReturnRPNameTarget() ~= "") then
						if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
							-- Era Only
							CharacterNameText:SetText(TRP3RPNameInQuests.API:ReturnRPNameTarget());
						elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then 
							-- TBC
							CharacterNameText:SetText(TRP3RPNameInQuests.API:ReturnRPNameTarget());
						elseif (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC) then 
							-- MoP
							CharacterFrameTitleText:SetText(TRP3RPNameInQuests.API:ReturnRPNameTarget());
						else
							-- Retail
							CharacterFrame:SetTitle(TRP3RPNameInQuests.API:ReturnRPNameTarget());
						end
					end
				end
			end
		end
	end)


	-- Character Sheet Level/Race/Class
	hooksecurefunc("PaperDollFrame_SetLevel", function()
		if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.PAPERDOLLRPNAME) == true) then
			
				local thisTRP3CharInfo = TRP3_API.profile.getData("player/characteristics")
					
				local thisTRP3CharRace = thisTRP3CharInfo.RA or UnitRace("player")
				local thisTRP3CharClass = thisTRP3CharInfo.CL or UnitClass("player")
			
				local level = UnitLevel("player");

			
				if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
					-- Era Only
					CharacterLevelText:SetFormattedText(PLAYER_LEVEL, UnitLevel("player"), thisTRP3CharRace, thisTRP3CharClass);
				elseif (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC) then
					-- TBC
					CharacterLevelText:SetFormattedText(PLAYER_LEVEL, UnitLevel("player"), thisTRP3CharRace, thisTRP3CharClass);
				else
					-- Retail and MoP
					local thisTRP3CharColor = CreateColor(GetClassColor(TRP3_API.globals.player_character.class)) or NORMAL_FONT_COLOR
					
					if (thisTRP3CharInfo.CH ~= nil) then
						thisTRP3CharColor = CreateColorFromRGBHexString(thisTRP3CharInfo.CH) or NORMAL_FONT_COLOR			
					end
					
						if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
						
							local effectiveLevel = UnitEffectiveLevel("player");
							
							if ( effectiveLevel ~= level ) then
								level = EFFECTIVE_LEVEL_FORMAT:format(effectiveLevel, level);
							end
						
						end
					
					CharacterLevelText:SetFormattedText(PLAYER_LEVEL, level, thisTRP3CharColor:GenerateHexColor(), thisTRP3CharRace, thisTRP3CharClass);
					
				end
			end
		end
	end)
	


	-- Quests, Dialog, Gossip Etc.
	if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODQUESTDIALOG) == true) then
		
		-- Retail and MoP
		if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
		
			-- If Classic Quest Log is Installed
			if (C_AddOns.IsAddOnLoaded("Classic Quest Log") or C_AddOns.IsAddOnLoaded("Kerzo Classic Quest Log")) then
				GetQuestLogQuestTextRPNameQuestText = GetQuestLogQuestText
				GetQuestLogQuestText = function(...) 
					questDescription, questObjectives = GetQuestLogQuestTextRPNameQuestText(...)
					return TRP3RPNameInQuests.API:CompleteRename(questDescription), questObjectives
				end
			end
			
			-- Regular Quest Window
			hooksecurefunc("QuestInfo_Display", function()
				local thisQuestDescription = QuestInfoDescriptionText:GetText()
				if (thisQuestDescription ~= nil) then
					QuestInfoDescriptionText:SetText(TRP3RPNameInQuests.API:CompleteRename(thisQuestDescription))
				end
			end)
			
			
		
		else
			-- Classic
			hooksecurefunc("QuestLog_UpdateQuestDetails", function()
				local thisQuestDescription = QuestLogQuestDescription:GetText()
				if (thisQuestDescription ~= nil) then
					QuestLogQuestDescription:SetText(TRP3RPNameInQuests.API:CompleteRename(thisQuestDescription))
				end
			end)
		 end
		
		
		if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.QTMODMETHOD) == 1 and not TRP3RPNameInQuests.API:QuestTextAddonDetected()) or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.QTMODMETHOD) == 2) then
			-- Use Hooks
			
			--print("XHOOKS")
			
			hooksecurefunc(QuestInfoDescriptionText, "SetText", function()
				pcall(function()
					if (not InCombatLockdown()) then
						local questDescription;
						if ( QuestInfoFrame and QuestInfoFrame.questLog ) then
							questDescription = GetQuestLogQuestText();
						else
							questDescription = GetQuestText();
						end
						QuestInfoDescriptionText:SetText(TRP3RPNameInQuests.API:CompleteRename(questDescription))
					end
				end)
			end)
			
			
			hooksecurefunc(GreetingText, "SetText", function()
				pcall(function()
					if (not InCombatLockdown()) then
						GreetingText:SetText(TRP3RPNameInQuests.API:CompleteRename(GetGreetingText()));
					end
				end)
			end)
			
			hooksecurefunc(QuestProgressText, "SetText", function()
				pcall(function()
					if (not InCombatLockdown()) then
						QuestProgressText:SetText(TRP3RPNameInQuests.API:CompleteRename(GetProgressText()));
					end
				end)
			end)
			
			hooksecurefunc(QuestInfoRewardText, "SetText", function()
				pcall(function()
					if (not InCombatLockdown()) then
						QuestInfoRewardText:SetText(TRP3RPNameInQuests.API:CompleteRename(GetRewardText()));
					end
				end)
			end)
		
		else
		
			--print("XREPLACE")
			
			-- Get Gossip Text
			TRP3RPNameInQuests.C_GossipInfoGetTextHook = C_GossipInfo.GetText
			C_GossipInfo.GetText = function (...)
				local thisGossipText = TRP3RPNameInQuests:C_GossipInfoGetTextHook()
				return TRP3RPNameInQuests.API:CompleteRename(thisGossipText)
			end
			

			-- Get Greeting Text
			TRP3RPNameInQuests.GetGreetingTextHook = GetGreetingText
			GetGreetingText = function (...)
				local thisGreetingText = TRP3RPNameInQuests:GetGreetingTextHook()
				return TRP3RPNameInQuests.API:CompleteRename(thisGreetingText)
			end


			-- Get Quest Text
			TRP3RPNameInQuests.GetQuestTextHook = GetQuestText
			GetQuestText = function (...)
				local thisQuestText = TRP3RPNameInQuests:GetQuestTextHook()
				return TRP3RPNameInQuests.API:CompleteRename(thisQuestText)
			end


			-- Get Quest Progress Text
			TRP3RPNameInQuests.GetProgressTextHook = GetProgressText
			GetProgressText = function (...)
				local thisProgressText = TRP3RPNameInQuests:GetProgressTextHook()
				return TRP3RPNameInQuests.API:CompleteRename(thisProgressText)
			end



			-- Get Quest Reward Text
			TRP3RPNameInQuests.GetRewardTextHook = GetRewardText
			GetRewardText = function (...)
				local thisRewardText = TRP3RPNameInQuests:GetRewardTextHook()
				return TRP3RPNameInQuests.API:CompleteRename(thisRewardText)
			end


			-- Gossip Options
			TRP3RPNameInQuests.GetGossipOptions = C_GossipInfo.GetOptions
			C_GossipInfo.GetOptions = function (...)
				local thisGossipOptions = TRP3RPNameInQuests:GetGossipOptions()
				for key, value in pairs(thisGossipOptions) do		
					thisGossipOptions[key]["name"] =  TRP3RPNameInQuests.API:CompleteRename(thisGossipOptions[key]["name"])
				end
				return(thisGossipOptions)
			end
			
		end
		
	
		
	end --eo QuestDialog
	
	
	--Cinematic Subtitles
	hooksecurefunc(SubtitlesFrame, "AddSubtitle", function(...)
		if not TRP3RPNameInQuests.API:ShouldNotEditText() then
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH) == true) then
				SubtitlesFrame.Subtitle1:SetText(TRP3RPNameInQuests.API:CompleteRename(SubtitlesFrame.Subtitle1:GetText()))
			end
		end
	end)

	

	
	-- Mail Window
	-- /Interface/FrameXML/MailFrame.lua
	if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODMAILBOX) == true) then
		hooksecurefunc("OpenMail_Update", function()
			if not TRP3RPNameInQuests.API:ShouldNotEditText() then
				-- Retail
				if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
					if ( not OpenMailFrame_IsValidMailID()) then
						return;
					else
						local bodyText, stationeryID1, stationeryID2, isTakeable, isInvoice, isConsortium = GetInboxText(InboxFrame.openMailID);
						
						if(bodyText) then
							OpenMailBodyText:SetText(TRP3RPNameInQuests.API:CompleteRename(bodyText), true);
						end
					end
				else
					-- Classic
					if ( not InboxFrame.openMailID ) then
						return;
					else
						local bodyText, stationeryID1, stationeryID2, isTakeable, isInvoice = GetInboxText(InboxFrame.openMailID);
						
						if(bodyText) then
							OpenMailBodyText:SetText(TRP3RPNameInQuests.API:CompleteRename(bodyText), true);
						end
					end
				end
			end

		end)
	
	end
	
	TRP3RPNameInQuests:SetScript("OnEvent", function(self, event, arg1, arg2)
		
		if not TRP3RPNameInQuests.API:ShouldNotEditText() then
			
			-- Books, etc.
			-- /Interface/FrameXML/ItemTextFrame.lua
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODTEXTITEMS) == true) then
		
				if event == "ITEM_TEXT_READY" then
				
					local creator = ItemTextGetCreator();
					if ( creator ) then
						creator = "\n\n"..ITEM_TEXT_FROM.."\n"..creator.."\n";
						ItemTextPageText:SetText(TRP3RPNameInQuests.API:CompleteRename(ItemTextGetText())..creator);
					else
						ItemTextPageText:SetText(TRP3RPNameInQuests.API:CompleteRename(ItemTextGetText()));
					end
					
				end
				
			end
			
			
			--Update Nameplates if title/name changes
			if (not WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then -- BROKEN IN 12.0.0
				if ( event == "KNOWN_TITLES_UPDATE" or (event == "UNIT_NAME_UPDATE" and arg1 == "player")) then
				
					if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.UNITFRAMERPNAME) == true) and (TRP3RPNameInQuests.IgnoreUnitFrameMods == false)) then
						TRP3RPNameInQuests:UpdateUnitFrames()
					end
					
				end
			end
		
		end
		
		
		if ((TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.QTMODMETHOD) == 1 and not TRP3RPNameInQuests.API:QuestTextAddonDetected()) or TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.QTMODMETHOD) == 2) then
			
			if ( event == "GOSSIP_SHOW" ) then
				
				if (not InCombatLockdown()) then
				
					for _, thisChildFrame in GossipFrame.GreetingPanel.ScrollBox:EnumerateFrames() do
						local thisChildFrameData = thisChildFrame:GetElementData()
						local thisButtonX = thisChildFrameData.buttonType
						
						if (thisButtonX == GOSSIP_BUTTON_TYPE_TITLE) then
							thisChildFrame.GreetingText:SetText(TRP3RPNameInQuests.API:CompleteRename(thisChildFrame.GreetingText:GetText()))
						elseif (thisButtonX == GOSSIP_BUTTON_TYPE_OPTION) then
							thisChildFrame:SetText(TRP3RPNameInQuests.API:CompleteRename(thisChildFrame:GetText()))
							thisChildFrame:Resize();
						end
					
					end
				
				end
			
			end
		
		end
		
	
	end)



	
	-- Chat Filters
	local function ChatFilterFunc(self, thisEvent, thisMessage, thisNPC, ...)
	
		if (canaccessvalue and (not canaccessvalue(thisMessage) or not canaccessvalue(thisNPC))) then
			return --false, thisMessage, thisNPC, ...
		end

		if (C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown()) then
			return --false, thisMessage, thisNPC, ...
		end
	
		if (TRP3RPNameInQuests.API:ShouldNotEditText(true)) then
			return --false, thisMessage, thisNPC, ...
		end
		
		local thisNewMessage = TRP3RPNameInQuests.API:CompleteRename(thisMessage)
		local thisNewNPC = TRP3RPNameInQuests.API:RPNameRename(thisNPC)
		if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH) == true) then
			if (thisEvent == "CHAT_MSG_MONSTER_SAY" or thisEvent == "CHAT_MSG_MONSTER_YELL" or thisEvent ==  "CHAT_MSG_MONSTER_PARTY") then
				pcall(function () 
					TRP3RPNameInQuests:ModSpeechBubbles()
				end) 
				
			end
		end

		return false, thisNewMessage, thisNewNPC, ...
	
	end
	
	
	
	-- NPC Speech
	if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH) == true) then
		-- 12.0.0 Should be changed to ChatFrameUtil.AddMessageEventFilter
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", ChatFilterFunc) -- NPC /s Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_YELL", ChatFilterFunc) -- NPC /y Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_PARTY", ChatFilterFunc) -- NPC /p Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_WHISPER", ChatFilterFunc) -- NPC /w Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_EMOTE", ChatFilterFunc) -- NPC /e Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PING", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_HORDE", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_ALLIANCE", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_NEUTRAL", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SKILL", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OPENING", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_TRADESKILLS", ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_EMOTE", ChatFilterFunc) -- NPC Boss /e Chat
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_BOSS_WHISPER", ChatFilterFunc) -- NPC Boss /w Chat
		
		-- Raid Boss Emote
		--[[hooksecurefunc("RaidNotice_AddMessage", function(noticeFrame, ...)
			noticeFrame.slot1:SetText(TRP3RPNameInQuests.API:CompleteRename(noticeFrame.slot1:GetText()))
			noticeFrame.slot2:SetText(TRP3RPNameInQuests.API:CompleteRename(noticeFrame.slot2:GetText()))
		end)]]
	
	end
	



	
	if ((WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) and (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH) == true)) then
	
		--Talking Head
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function(self)
			if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
				C_Timer.After(0.3, function()
					--Talker Text
					self.TextFrame.Text:SetText(TRP3RPNameInQuests.API:CompleteRename(self.TextFrame.Text:GetText()))
				end);
			end
		end)
		
		-- Adventure Map
		C_AddOns.LoadAddOn("Blizzard_AdventureMap")
		hooksecurefunc(AdventureMapQuestChoiceDialog, "RefreshDetails", function(self)
			if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
				local _, descriptionText, _ = C_AdventureMap.GetQuestInfo(self.questID);
				if descriptionText then
					self.Details.Child.DescriptionText:SetText(TRP3RPNameInQuests.API:CompleteRename(descriptionText));
				end
			end
		end)
				
		
	end
	

	
	
	-- Speech Bubbles
	-- with Code Modified from https://www.wowinterface.com/forums/showpost.php?p=336696&postcount=2
	function TRP3RPNameInQuests:ModSpeechBubbles()
			--Slight timer so the bubble has chance to fade in
			C_Timer.After(.05, function()
				if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
					for _, bubble in pairs(C_ChatBubbles.GetAllChatBubbles()) do -- This -should- only affect NPC speech bubbles, player speech bubbles are protected
						for i = 1, bubble:GetNumChildren() do
							local child = select(i, select(i, bubble:GetChildren()))
							if(child) then
								if (child:GetObjectType() == "Frame") and (child.String) and (child.Center) then
									for i = 1, child:GetNumRegions() do
										local region = select(i, child:GetRegions())
										if (region:GetObjectType() == "FontString") then
										
											thisBubbleText = region:GetText()
											
											region:SetText(TRP3RPNameInQuests.API:CompleteRename(thisBubbleText))
											
											--Resize bubble to accomodate new text
											if (region:GetStringWidth() >= region:GetWrappedWidth()) then
												region:SetWidth(region:GetWrappedWidth())
											else
												--region:SetWidth(region:GetStringWidth())
												region:SetWidth(region:GetWrappedWidth())
											end
											
											
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
	if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.ZONENAMERPNAME) == true) then
	
		TRP3RPNameGetZoneText = GetZoneText
		function GetZoneText()
			return TRP3RPNameInQuests.API:RPNameRename(TRP3RPNameGetZoneText(), true)
		end
		
		TRP3RPNameGetSubZoneText = GetSubZoneText
		function GetSubZoneText()
			return TRP3RPNameInQuests.API:RPNameRename(TRP3RPNameGetSubZoneText(), true)
		end
	
	end

	--[[
	hooksecurefunc("Minimap_Update", function(...)
		if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
			if (TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.ZONENAMERPNAME) == true) then
				varCurrentMinimapZoneText = GetMinimapZoneText()
				
				MinimapZoneText:SetText(TRP3RPNameInQuests.API:RPNameRename(varCurrentMinimapZoneText, true))
			end
		end
	end)
	]]

	
	
	function TRP3RPNameInQuests:UpdateUnitFrames()
		if (not WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then -- BROKEN IN 12.0.0
			if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
				pcall(function () 
					UnitFrame_Update(PlayerFrame)
					UnitFrame_Update(TargetFrame)
				end)
			end
		end
	end
	

	-- TRP3 Options Page
	local TRPRPNAMEINQUESTS_DROPDOWNSTUFF = {
		{ L.DROPDOWNSTUFF_OPT1, 1 },
		{ L.DROPDOWNSTUFF_OPT2, 2 },
		{ L.DROPDOWNSTUFF_OPT3, 3 },
		{ L.DROPDOWNSTUFF_OPT4, 4 },
		{ L.DROPDOWNSTUFF_OPT5, 5 },
		{ L.DROPDOWNSTUFF_OPT6, 6 },
		{ L.DROPDOWNSTUFF_OPT7, 7 },
		{ L.DROPDOWNSTUFF_OPT8, 8 },
		{ L.DROPDOWNSTUFF_OPT9, 99 },		
	}

	local TRPRPNAMEINQUESTS_DROPDOWNCLASS = {
		{ L.DROPDOWNCLASS_OPT1, 1 },
		{ L.DROPDOWNCLASS_OPT2, 2 },
		{ L.DROPDOWNCLASS_OPT3, 99 },	
	}

	local TRPRPNAMEINQUESTS_DROPDOWNRACE = {
		{ L.DROPDOWNRACE_OPT1, 1 },
		{ L.DROPDOWNRACE_OPT2, 2 },
		{ L.DROPDOWNRACE_OPT3, 99 },	
	}
	
	local TRPRPNAMEINQUESTS_DROPDOWNQTMETHOD = {
		{ string.format(L.DROPDOWNQTMETHOD_OPT1, TRP3RPNameInQuests.API:QuestTextAddonDetected() and L.DROPDOWNQTMETHOD_OPT3 or L.DROPDOWNQTMETHOD_OPT2), 1 },
		{ L.DROPDOWNQTMETHOD_OPT2, 2 },
		{ L.DROPDOWNQTMETHOD_OPT3, 3 },	
		
	}
	
	local TextureDot = CreateSimpleTextureMarkup("interface/raidframe/ui-raidframe-threat", 10,10)


	TRP3RPNameInQuests.ConfigElements = {
		{
			inherit = "TRP3_ConfigH1",
			title =  string.format(L.CHARSETTINGS_MAINTITLE, TRP3RPNameInQuests.ClassColorString:WrapTextInColorCode(TRP3_API.globals.player)),
			
		},
		{
			inherit = "TRP3_ConfigParagraph",
			title = string.format(L.CHARSETTINGS_MAINTITLE_HELP, TRP3RPNameInQuests.ClassColorString:WrapTextInColorCode(TRP3_API.globals.player), TRP3RPNameInQuests.ClassColorString:WrapTextInColorCode(L.CHARSETTINGS_CHARSPECIFIC)),
		},
		{
			inherit = "TRP3_ConfigDropDown",
			widgetName = "trp3_rpnameinquests_whichrpnamewidget",
			title = string.format(L.CHARSETTINGS_NAMEFORMAT_TITLE, ORANGE_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_CHARACTER)),
			help = L.CHARSETTINGS_NAMEFORMAT_HELP,
			listContent = TRPRPNAMEINQUESTS_DROPDOWNSTUFF,
			configKey = TRP3RPNameInQuests.Config.WHICHRPNAME,
			listCallback = function(value)
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.WHICHRPNAME, value)
				TRP3RPNameInQuests_CharVars.WhichRPName = TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAME)
			end,

		},
		{
			inherit = "TRP3_ConfigDropDown",
			title = string.format(L.CHARSETTINGS_RACEFORMAT_TITLE, NORMAL_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_RACE)),
			help = L.CHARSETTINGS_RACEFORMAT_HELP,
			listContent = TRPRPNAMEINQUESTS_DROPDOWNRACE,
			configKey = TRP3RPNameInQuests.Config.CUSTOMRACENAME,
			listCallback = function(value)
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.CUSTOMRACENAME, value)
				TRP3RPNameInQuests_CharVars.CustomRaceName = value
				
				
			end,
		},
		{
			inherit = "TRP3_ConfigDropDown",
			title = string.format(L.CHARSETTINGS_CLASSFORMAT_TITLE, TRP3RPNameInQuests.ClassColorString:WrapTextInColorCode(L.CHARSETTINGS_CLASS)),
			help = L.CHARSETTINGS_CLASSFORMAT_HELP,
			listContent = TRPRPNAMEINQUESTS_DROPDOWNCLASS,
			configKey = TRP3RPNameInQuests.Config.CUSTOMCLASSNAME,
			listCallback = function(value)
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAME, value)
				TRP3RPNameInQuests_CharVars.CustomClassName = value
			end,
		},
		{
			inherit = "TRP3_ConfigNote",
			title = "- - -",
		},
		{
			inherit = "TRP3_ConfigEditBox",
			title = string.format(L.CHARSETTINGS_CUSTOMNAME_TITLE, ORANGE_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_CHARACTER), LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_ASTERISK)),
			help = L.CHARSETTINGS_CUSTOMNAME_HELP,
			configKey = TRP3RPNameInQuests.Config.WHICHRPNAMETEXT,
		},
		{
			inherit = "TRP3_ConfigEditBox",
			title = string.format(L.CHARSETTINGS_CUSTOMNAME_TITLE, NORMAL_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_RACE), LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_ASTERISK)),
			help = L.CHARSETTINGS_CUSTOMRACE_HELP,
			configKey = TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT,
		},
		{
			inherit = "TRP3_ConfigEditBox",
			title = string.format(L.CHARSETTINGS_CUSTOMCLASS_TITLE, TRP3RPNameInQuests.ClassColorString:WrapTextInColorCode(L.CHARSETTINGS_CLASS), LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_ASTERISK)),
			help = L.CHARSETTINGS_CUSTOMCLASS_HELP,
			configKey = TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT,
		},
		{
			inherit = "TRP3_ConfigNote",
			title = " ",
		},
		{
			inherit = "TRP3_ConfigH1",
			title = L.MODIFYSETTINGS_TITLE,
		},
		{
			inherit = "TRP3_ConfigParagraph",
			title = string.format(L.MODIFYSETTINGS_HELP, ORANGE_FONT_COLOR:WrapTextInColorCode(L.MODIFYSETTINGS_ACCOUNT_WIDE)),
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = L.MODIFYSETTINGS_QUESTTEXT_TITLE,
			help = L.MODIFYSETTINGS_QUESTTEXT_HELP,
			configKey = TRP3RPNameInQuests.Config.TEXTMODQUESTDIALOG,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;					
				
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.TEXTMODQUESTDIALOG, value)
				
				if (TRP3RPNameInQuests.OldVar.QuestDialog ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = string.format(L.MODIFYSETTINGS_NPCSPEECH_TITLE .. " ", LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.MODIFYSETTINGS_NPCSPEECH_TITLE2)),
			help = L.MODIFYSETTINGS_NPCSPEECH_HELP,
			configKey = TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.TEXTMODNPCSPEECH, value)
				
				if (TRP3RPNameInQuests.OldVar.NPCSpeech ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = string.format(L.MODIFYSETTINGS_TEXTITEMS_TITLE .. " ", LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.MODIFYSETTINGS_TEXTITEMS_TITLE2)),
			help = L.MODIFYSETTINGS_TEXTITEMS_HELP,
			configKey = TRP3RPNameInQuests.Config.TEXTMODTEXTITEMS,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;

				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.TEXTMODTEXTITEMS, value)

				if (TRP3RPNameInQuests.OldVar.TextItems ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = L.MODIFYSETTINGS_MAILBOX_TITLE,
			help = L.MODIFYSETTINGS_MAILBOX_HELP,
			configKey = TRP3RPNameInQuests.Config.TEXTMODMAILBOX,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;

				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.TEXTMODMAILBOX, value)
				
				if (TRP3RPNameInQuests.OldVar.Mailbox ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = L.MODIFYSETTINGS_RCPUNC_TITLE,
			help = string.format(L.MODIFYSETTINGS_RCPUNC_HELP, TRP3_API.globals.player_class_loc, TRP3_API.globals.player_class_loc),
			configKey = TRP3RPNameInQuests.Config.RACECLASSPUNCTUATION,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;

				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.RACECLASSPUNCTUATION, value)


				
			end,
		},
		{
			inherit = "TRP3_ConfigNote",
			title = " ",
		},
		{
			inherit = "TRP3_ConfigH1",
			title = L.EXTRAFUNC_TITLE
		},
		{
			inherit = "TRP3_ConfigParagraph",
			title = L.EXTRAFUNC_HELP1 .. "\n" .. NORMAL_FONT_COLOR:WrapTextInColorCode(L.EXTRAFUNC_HELP2) ..  "\n" .. string.format(L.EXTRAFUNC_HELP3, ORANGE_FONT_COLOR:WrapTextInColorCode(L.MODIFYSETTINGS_ACCOUNT_WIDE)),
		},
		{
			inherit = "TRP3_ConfigNote",
			title = LORE_TEXT_BODY_COLOR:WrapTextInColorCode(L.EXTRAFUNC_SHOWINFO_TITLE),
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = TextureDot .. " " .. L.EXTRAFUNC_SHOWINFO_UNITFRAME_TITLE,
			help = L.EXTRAFUNC_SHOWINFO_UNITFRAME_HELP,
			configKey = TRP3RPNameInQuests.Config.UNITFRAMERPNAME,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.UNITFRAMERPNAME, value)	
				
				--Update Unit Frames
				if not TRP3RPNameInQuests.API:ShouldNotEditText(true) then
					TRP3RPNameInQuests:UpdateUnitFrames()
				end
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = TextureDot .. " " ..  L.EXTRAFUNC_SHOWINFO_PAPERDOLL_TITLE,
			help = L.EXTRAFUNC_SHOWINFO_PAPERDOLL_HELP,
			configKey = TRP3RPNameInQuests.Config.PAPERDOLLRPNAME,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.PAPERDOLLRPNAME, value)
				
				--Save Variables we can't save otherwise
				TRP3RPNameInQuests_CharVars.WhichRPNameText = TRP3_API.utils.str.sanitize(TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.WHICHRPNAMETEXT))
				
				TRP3RPNameInQuests_CharVars.CustomClassNameText = TRP3_API.utils.str.sanitize(TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMCLASSNAMETEXT))
				
				TRP3RPNameInQuests_CharVars.CustomRaceNameText = TRP3_API.utils.str.sanitize(TRP3_API.configuration.getValue(TRP3RPNameInQuests.Config.CUSTOMRACENAMETEXT))
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = TextureDot .. " " ..  L.EXTRAFUNC_SHOWINFO_PARTYFRAME_TITLE,
			help = L.EXTRAFUNC_SHOWINFO_PARTYFRAME_HELP,
			configKey = TRP3RPNameInQuests.Config.PARTYFRAMERPNAME,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.PARTYFRAMERPNAME, value)	
				
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = TextureDot .. " " ..  L.EXTRAFUNC_SHOWINFO_CLASSCOLOR_TITLE,
			help = L.EXTRAFUNC_SHOWINFO_CLASSCOLOR_HELP,
			configKey = TRP3RPNameInQuests.Config.PARTYFRAMERPCOLOR,
			dependentOnOptions = { TRP3RPNameInQuests.Config.PARTYFRAMERPNAME },
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.PARTYFRAMERPCOLOR, value)	
				
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = TextureDot .. " " .. string.format(L.EXTRAFUNC_SHOWINFO_ZONENAME_TITLE, LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.EXTRAFUNC_SHOWINFO_ZONENAME_TITLE2)),
			help = L.EXTRAFUNC_SHOWINFO_ZONENAME_HELP,
			configKey = TRP3RPNameInQuests.Config.ZONENAMERPNAME,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.ZONENAMERPNAME, value)	
				
				if (TRP3RPNameInQuests.OldVar.ZoneNameRPName ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
				
			end,
		},
		{
			inherit = "TRP3_ConfigNote",
			title = " ",
		},
		{
			inherit = "TRP3_ConfigH1",
			title = L.TROUBLESHOOTING_TITLE,
		},
		{
			inherit = "TRP3_ConfigDropDown",
			widgetName = "trp3_rpnameinquests_qtmodmethod",
			title = L.TROUBLESHOOTING_QTMETHOD_TITLE,
			help = L.TROUBLESHOOTING_QTMETHOD_HELP,
			listContent = TRPRPNAMEINQUESTS_DROPDOWNQTMETHOD,
			configKey = TRP3RPNameInQuests.Config.QTMODMETHOD,
			listCallback = function(value)
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.QTMODMETHOD, value)
				
				if (TRP3RPNameInQuests.OldVar.QTModMethod ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
				
			end,

		},
		--[[{
			inherit = "TRP3_ConfigCheck",
			title = L.TROUBLESHOOTING_USEHOOKS_TITLE,
			help = L.TROUBLESHOOTING_USEHOOKS_HELP,
			configKey = TRP3RPNameInQuests.Config.USEFUNCHOOKS,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.USEFUNCHOOKS, value)
				
				if (TRP3RPNameInQuests.OldVar.UseFuncHooks ~= value) then
					TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
				end
				
				
			end,
		},]]
		{
			inherit = "TRP3_ConfigCheck",
			title = L.TROUBLESHOOTING_ALTMETHOD_TITLE,
			help = L.TROUBLESHOOTING_ALTMETHOD_HELP,
			configKey = TRP3RPNameInQuests.Config.ALTRPNAMEREPLACEMENT,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.ALTRPNAMEREPLACEMENT, value)	
				
				
			end,
		},
		{
			inherit = "TRP3_ConfigCheck",
			title = L.TROUBLESHOOTING_NOTINENCOUNTER_TITLE,
			help = L.TROUBLESHOOTING_NOTINENCOUNTER_HELP,
			configKey = TRP3RPNameInQuests.Config.NOTINENCOUNTER,
			OnHide = function(button)
				local value = button:GetChecked() and true or false;
				TRP3_API.configuration.setValue(TRP3RPNameInQuests.Config.NOTINENCOUNTER, value)	
				
				
			end,
		},
		
	}
	
	-- Remove Unit Frame Option if needed
	if (TRP3RPNameInQuests.IgnoreUnitFrameMods == true) then
		table.remove(TRP3RPNameInQuests.ConfigElements, 22)
	end
	

	--Create Config Page
	TRP3_API.configuration.registerConfigurationPage({
		id = "trp3_rpnameinquests_config",
		menuText = L.ADDON_NAME_SHORT,
		pageText = L.ADDON_NAME,
		elements = TRP3RPNameInQuests.ConfigElements
	});

end




TRP3_API.module.registerModule({
	name = L.ADDON_NAME,
	description = L.ADDON_DESC,
	version = C_AddOns.GetAddOnMetadata("tRP3_RPNameInQuests", "Version"):gsub("v", ""),
	id = "trp3_rpnameinquests",
	onStart = TRP3RPNameInQuests.Init,
	minVersion = 130,
});


-- Slash Command
function TRP3RPNameInQuests:OpenConfig()
	TRP3_API.navigation.openMainFrame();
	TRP3_API.navigation.page.setPage("trp3_rpnameinquests_config");
end

TRP3RPNameInQuests.OpenConfigCommand = {
	id = "questtext",
	helpLine = " " .. L.SLASHCMD_HELP,
	handler = function()
		TRP3RPNameInQuests:OpenConfig();
	end,
}

TRP3_API.slash.registerCommand(TRP3RPNameInQuests.OpenConfigCommand);





-- Addon Compartment
if (AddonCompartmentFrame) then

	AddonCompartmentFrame:RegisterAddon({
		text = L.ADDON_NAME,
		icon = C_AddOns.GetAddOnMetadata("tRP3_RPNameInQuests", "IconTexture"),
		notCheckable = true,
		
		func = function(button)
			TRP3RPNameInQuests:OpenConfig()
		end,
		
		funcOnEnter = function(button)
			if (not TRP3RPNameInQuests.Tooltip) then
					TRP3RPNameInQuests.Tooltip = CreateFrame("GameTooltip", "TRP3RPNameInQuests.Tooltip_Compartment", UIParent, "GameTooltipTemplate")
				end
				
				local ClassColorString = CreateColor(GetClassColor(TRP3_API.globals.player_character.class)) or NORMAL_FONT_COLOR
				
				TRP3RPNameInQuests.Tooltip:SetOwner(button, "ANCHOR_LEFT");
				TRP3RPNameInQuests.Tooltip:SetText(L.TRP3 .. ": " .. L.ADDON_NAME)
				
				TRP3RPNameInQuests.Tooltip:AddLine(" ")
				TRP3RPNameInQuests.Tooltip:AddLine(string.format(L.ADCOM_HOW, ClassColorString:WrapTextInColorCode(TRP3_API.globals.player)), WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				TRP3RPNameInQuests.Tooltip:AddLine(" ")
				
				TRP3RPNameInQuests.Tooltip:AddDoubleLine(L.ADCOM_NAME, TRP3RPNameInQuests.API:GetFullRPName(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				TRP3RPNameInQuests.Tooltip:AddDoubleLine(L.ADCOM_RACE, TRP3RPNameInQuests.API:ReturnRPRace(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				TRP3RPNameInQuests.Tooltip:AddDoubleLine(L.ADCOM_CLASS, TRP3RPNameInQuests.API:ReturnRPClass(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
				
				TRP3RPNameInQuests.Tooltip:AddLine(" ")
				TRP3RPNameInQuests.Tooltip:AddLine(L.ADCOM_CLICK_TO_CHANGE, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)

				TRP3RPNameInQuests.Tooltip:Show()
		end,
		
		funcOnLeave = function(button)
			TRP3RPNameInQuests.Tooltip:Hide()
		end,
	})

end


-- For DialogueUI
function TRP3_RPNameInQuests_CompleteRename(textToRename)
	return TRP3RPNameInQuests.API:CompleteRename(textToRename)
end
