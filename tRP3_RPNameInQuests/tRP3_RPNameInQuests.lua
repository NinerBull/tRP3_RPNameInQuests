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


local TRP3RPNameInQuests_Frame = CreateFrame("Frame")
TRP3RPNameInQuests_Frame:RegisterEvent("ITEM_TEXT_READY");
TRP3RPNameInQuests_Frame:RegisterEvent("UNIT_NAME_UPDATE");
TRP3RPNameInQuests_Frame:RegisterEvent("ADDON_LOADED")

if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
	TRP3RPNameInQuests_Frame:RegisterEvent("KNOWN_TITLES_UPDATE");
end

TRPRPNAMEINQUESTS = select(2, ...);


local function TRP3RPNameInQuests_Init()

		
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
	TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION = "trp3_rpnameinquests_textmod_raceclasspunctuation";

	TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME = "trp3_rpnameinquests_unitframerpname";
	TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME = "trp3_rpnameinquests_paperdollrpname";
	TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME = "trp3_rpnameinquests_partyframerpname";
	TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPCOLOR = "trp3_rpnameinquests_partyframerpcolor";
	TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME = "trp3_rpnameinquests_zonenamerpname";
	
	TRPRPNAMEINQUESTS.CONFIG.ALTRPNAMEREPLACEMENT = "trp3_rpnameinquests_altnamerpreplacement";

	-- Register and set value for variables

	-- ==Character Specific==
	
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



	-- ==Account Wide==
	
	--QuestDialog
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, true);
	
	--NPCSpeech
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, true);
	
	--TextItems
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS, true);

	--Mailbox
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, true);
	
	--RaceClassPunctuationAdjacent
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.RACECLASSPUNCTUATION, true);
	
	
	

	--UnitFrameRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME, false);

	--PaperDollRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME, false);
	
	--PartyFrameRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME, false);
	
	--PartyFrameRPColor
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPCOLOR, false);
	
	--ZoneNameRPName
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME, false);
	
	
	--Alternate RP Name Replacement
	TRP3_API.configuration.registerConfigKey(TRPRPNAMEINQUESTS.CONFIG.ALTRPNAMEREPLACEMENT, false);



	--Temp Values to check if /reload is needed
	local TRP3_RPNameInQuests_OldVar_QuestDialog = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG)
	local TRP3_RPNameInQuests_OldVar_NPCSpeech = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH)
	local TRP3_RPNameInQuests_OldVar_TextItems = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS)
	local TRP3_RPNameInQuests_OldVar_Mailbox = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX)
	local TRP3_RPNameInQuests_OldVar_ZoneNameRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME)
	
	

	
	-- Bypass Unit Frame options if totalRP3_UnitFrames is loaded.
	-- (Go get it btw it's awesome)
	-- https://github.com/keyboardturner/totalRP3_UnitFrames

	local TRP3_RPNameInQuests_IgnoreUnitFrameMods = C_AddOns.IsAddOnLoaded("totalRP3_UnitFrames") or false
	local TRP3_RPNameInQuests_NameToChange = TRP3_API.globals.player or UnitNameUnmodified("player")
	local TRP3_RPNameInQuests_RaceToChange = TRP3_API.globals.player_race_loc or UnitRace("player")
	local TRP3_RPNameInQuests_ClassToChange = TRP3_API.globals.player_class_loc or UnitClass("player")
	


	-- Full TRP3 Name (Including Title)
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
		
		
		
		
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ALTRPNAMEREPLACEMENT) == true) then
			--Remove double of title, if it exists
			if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 2 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 3 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 4 or TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 5) or (getFullName == true)) then
			
				if (thisTRP3CharInfo.TI) then
					if (string.find(thisTRP3CharNameFull, thisTRP3CharInfo.TI .. " " .. thisTRP3CharInfo.TI)) then
						thisTRP3CharNameFull = thisTRP3CharNameFull:gsub(thisTRP3CharInfo.TI .. " " .. thisTRP3CharInfo.TI, thisTRP3CharInfo.TI)
					end
				end
			
			end
		
		end
		
		
		
		
		-- If the player wants to use a custom name, grab that instead
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) == 99 and getFullName == false) then
			thisTRP3CharNameFull = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT)
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
	function TRP3_RPNameInQuests_RPNameRename(textToRename, renameFullName, doUpperCase)
	
		renameFullName = renameFullName or false
		doUpperCase = doUpperCase or false
	
		if (doUpperCase == true) then
			--textToRename = string.upper(textToRename)
		end
	
		thisTextToReturn = textToRename
		
		--rename char
		thisTRP3CharName = TRP3_RPNameInQuests_GetFullRPName(renameFullName)
				
		if (thisTRP3CharName == "") then
			--empty, do nothing
			thisTRP3CharName = TRP3_RPNameInQuests_NameToChange
		else
		
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ALTRPNAMEREPLACEMENT) == true) then
				if (textToRename) then
					if (doUpperCase == true) then
						textToRename = textToRename:gsub(string.upper(TRP3_RPNameInQuests_NameToChange), string.upper(thisTRP3CharName))
					else
						textToRename = textToRename:gsub(TRP3_RPNameInQuests_NameToChange, thisTRP3CharName)
					end
				end
			
			else
				
				if (doUpperCase == true) then
					if (textToRename and not(string.find(textToRename, string.upper(thisTRP3CharName)  .. "%A"))) then
						textToRename = textToRename:gsub(string.upper(TRP3_RPNameInQuests_NameToChange), string.upper(thisTRP3CharName))
					end
				else
					if (textToRename and not(string.find(textToRename, thisTRP3CharName  .. "%A"))) then
						textToRename = textToRename:gsub(TRP3_RPNameInQuests_NameToChange, thisTRP3CharName)
					end

				end
			
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
	
	-- Return RP Name Target
	function TRP3_RPNameInQuests_ReturnRPNameTarget(thisTarget, withTitle)
	
		thisTarget = thisTarget or "player"
		withTitle = withTitle or false
		
		local thisPlayer = AddOn_TotalRP3.Player.CreateFromUnit(tostring(thisTarget))
	
		local thisFullName = thisPlayer:GetFullName() or TRP3_RPNameInQuests_NameToChange
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
	function TRP3_RPNameInQuests_RPRaceRename(textToRename, doLowerCase, doUpperCase)
	
		doLowerCase = doLowerCase or false
		doUpperCase = doUpperCase or false
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
			
			
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(", " .. TRP3_RPNameInQuests_RaceToChange),string.lower(", " .. thisRaceName))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. ","),string.lower(thisRaceName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. "%."),string.lower(thisRaceName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. "%?"),string.lower(thisRaceName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange .. "!"),string.lower(thisRaceName .. "!"))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(", " .. TRP3_RPNameInQuests_RaceToChange),string.upper(", " .. thisRaceName))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_RaceToChange .. ","),string.upper(thisRaceName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_RaceToChange .. "%."),string.upper(thisRaceName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_RaceToChange .. "%?"),string.upper(thisRaceName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_RaceToChange .. "!"),string.upper(thisRaceName .. "!"))
				else
					thisTextToReturn = thisTextToReturn:gsub(", " .. TRP3_RPNameInQuests_RaceToChange,", " .. thisRaceName)
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "," ,thisRaceName .. ",")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "%." ,thisRaceName .. ".")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "%?" ,thisRaceName .. "?")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange .. "!" ,thisRaceName .. "!")
				end
			
			else
			
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_RaceToChange),string.lower(thisRaceName))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_RaceToChange),string.upper(thisRaceName))
				else
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_RaceToChange,thisRaceName)
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
	 function TRP3_RPNameInQuests_RPClassRename(textToRename, doLowerCase, doUpperCase)
	
		doLowerCase = doLowerCase or false
		doUpperCase = doUpperCase or false
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
				
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(", " .. TRP3_RPNameInQuests_ClassToChange),string.lower(", " .. thisClassName))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. ","),string.lower(thisClassName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. "%."),string.lower(thisClassName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. "%?"),string.lower(thisClassName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange .. "!"),string.lower(thisClassName .. "!"))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(", " .. TRP3_RPNameInQuests_ClassToChange),string.upper(", " .. thisClassName))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_ClassToChange .. ","),string.upper(thisClassName .. ","))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_ClassToChange .. "%."),string.upper(thisClassName .. "."))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_ClassToChange .. "%?"),string.upper(thisClassName .. "?"))
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_ClassToChange .. "!"),string.upper(thisClassName .. "!"))
				else
					thisTextToReturn = thisTextToReturn:gsub(", " .. TRP3_RPNameInQuests_ClassToChange,", " ..thisClassName)
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. ",",thisClassName .. ",")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. "%.",thisClassName .. ".")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. "%?",thisClassName .. "?")
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange .. "!",thisClassName .. "!")
				end

			else
			
				if (doLowerCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.lower(TRP3_RPNameInQuests_ClassToChange),string.lower(thisClassName))
				elseif (doUpperCase == true) then
					thisTextToReturn = thisTextToReturn:gsub(string.upper(TRP3_RPNameInQuests_ClassToChange),string.upper(thisClassName))
				else
					thisTextToReturn = thisTextToReturn:gsub(TRP3_RPNameInQuests_ClassToChange,thisClassName)
					
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
	-- Do not rename this, DialogueUI looks for and uses this function
	function TRP3_RPNameInQuests_CompleteRename(textToRename)

		thisRenamedText = textToRename or ""
		
		--CharacterName
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME) ~= 1) then
		
			-- Find out if TRP3 Name is a short version of OOC Name
			lengthOfOOCName = string.len(TRP3_RPNameInQuests_NameToChange)
			lengthOfTRP3Name = string.len(TRP3_RPNameInQuests_RPNameRename(TRP3_RPNameInQuests_NameToChange, true))
			
		
			if (lengthOfTRP3Name >= lengthOfOOCName) then
				if (strmatch(thisRenamedText, TRP3_RPNameInQuests_NameToChange) and (not (strmatch(thisRenamedText, TRP3_RPNameInQuests_ReturnRPName(true))))) then
					thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText)
				end
				
				if (strmatch(thisRenamedText, string.upper(TRP3_RPNameInQuests_NameToChange)) and (not (strmatch(thisRenamedText, TRP3_RPNameInQuests_ReturnRPName(true))))) then
					thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText, false, true)
				end
				
			else
				if (strmatch(thisRenamedText, TRP3_RPNameInQuests_NameToChange)) then
					thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText)
				end
				if (strmatch(thisRenamedText, string.upper(TRP3_RPNameInQuests_NameToChange))) then
					thisRenamedText =  TRP3_RPNameInQuests_RPNameRename(thisRenamedText, false, true)
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
			if (strmatch(thisRenamedText, string.upper(TRP3_RPNameInQuests_ClassToChange))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPClassRename(thisRenamedText, false, true)
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
			if (strmatch(thisRenamedText, string.upper(TRP3_RPNameInQuests_RaceToChange))) then
				thisRenamedText =  TRP3_RPNameInQuests_RPRaceRename(thisRenamedText, false, true)
			end
		end

		
		return thisRenamedText
	
	
	
	end
	
	
	
	
	-- Unit Frame
	-- If "Show my character's TRP3 info in the Player Unit Frame" is enabled, these will add the full character name to it.
	hooksecurefunc("UnitFrame_Update", function(self, isParty)
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
			if self.name and self.unit then
				if (UnitPlayerControlled(tostring(self.unit))) then
					if (UnitName(tostring(self.unit)) ~= TRP3_API.register.getUnitRPName(tostring(self.unit))) then
						pcall(function () 
							local thisRealmString = ""
							if (UnitRealmRelationship(tostring(self.unit)) == LE_REALM_RELATION_COALESCED) then
								thisRealmString = FOREIGN_SERVER_LABEL
							--elseif if (UnitRealmRelationship(tostring(self.thisUnit)) == LE_REALM_RELATION_VIRTUAL) then
								--thisRealmString = INTERACTIVE_SERVER_LABEL
							end
							self.name:SetText(TRP3_RPNameInQuests_ReturnRPNameTarget(self.unit, true) .. thisRealmString)
						end)
					end
				end
			end
		end
	end)
	
	-- Also Unit Frame
	--[[hooksecurefunc("UnitFrame_OnEvent", function(self, thisEvent, thisUnit)
		if self.name and thisEvent == "UNIT_NAME_UPDATE" and thisUnit == self.thisUnit then
			if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
				if self.name and self.thisUnit then
					if (UnitIsPlayer(tostring(self.thisUnit))) then
						if ((tostring(self.thisUnit) == "player" or tostring(self.thisUnit) == "target" or tostring(self.thisUnit) == "targettarget") and (self.name:GetText() == TRP3_RPNameInQuests_NameToChange))  then
							pcall(function () 
								self.name:SetText(TRP3_RPNameInQuests_GetFullRPName(true));
							end)
						else
							--if (UnitRealmRelationship(tostring(self.thisUnit)) == 1) then
							if (UnitName(self.thisUnit) ~= TRP3_API.register.getUnitRPName(tostring(self.thisUnit))) then
								pcall(function () 
									local thisRealmString = ""
									if (UnitRealmRelationship(tostring(self.thisUnit)) == LE_REALM_RELATION_COALESCED) then
										thisRealmString = FOREIGN_SERVER_LABEL
									--elseif if (UnitRealmRelationship(tostring(self.thisUnit)) == LE_REALM_RELATION_VIRTUAL) then
										--thisRealmString = INTERACTIVE_SERVER_LABEL
									end
									self.name:SetText(TRP3_API.register.getUnitRPName(tostring(self.thisUnit)) .. thisRealmString)
								end)
							end
						end
					end
				end
			end
		end
	end)]]
	


		
	
	-- Party/Raid Frames
	-- If "Show my character's TRP3 info in the Player Unit Frame" is enabled, these will add the full character name to the Raid Frames.
	hooksecurefunc("CompactUnitFrame_UpdateName", function(self)
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME) == true) and (C_AddOns.IsAddOnLoaded("Blizzard_CUFProfiles"))) then
			if self.name and self.unit then
				if (UnitPlayerControlled(tostring(self.unit))) then
					--[[if ((tostring(self.unit) == "player") and (self.name:GetText() == TRP3_RPNameInQuests_NameToChange))  then
						pcall(function () 
							self.name:SetText(TRP3_RPNameInQuests_GetFullRPName(true));
						end)
					else]]
						if (UnitName(tostring(self.unit)) ~= TRP3_API.register.getUnitRPName(tostring(self.unit))) then
							pcall(function () 
								local thisRealmString = ""
								if (UnitRealmRelationship(tostring(self.unit)) == LE_REALM_RELATION_VIRTUAL) then
									thisRealmString = FOREIGN_SERVER_LABEL
								--[[elseif if (UnitRealmRelationship(tostring(self.unit)) == LE_REALM_RELATION_VIRTUAL) then
									thisRealmString = INTERACTIVE_SERVER_LABEL]]--
								end
								self.name:SetText(TRP3_RPNameInQuests_ReturnRPNameTarget(self.unit) .. thisRealmString)
							end)
						end
					--[[end]]
				end
			end
		end
	end)
	
	
	-- 
	-- https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_UnitFrame/Mainline/CompactUnitFrame.lua#L553
	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
	
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME) == true) and (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPCOLOR) == true) and (C_AddOns.IsAddOnLoaded("Blizzard_CUFProfiles"))) then
			
			local unitIsConnected = UnitIsConnected(frame.unit);
			local unitIsDead = unitIsConnected and UnitIsDead(frame.unit);
			local unitIsPlayer = UnitIsPlayer(frame.unit) or UnitIsPlayer(frame.displayedUnit);
			local unitIsActivePlayer = UnitIsUnit(frame.unit, "player") or UnitIsUnit(frame.displayedUnit, "player");
			
			
			
			if ( not unitIsConnected or (unitIsDead and not unitIsPlayer) ) then
				
			elseif ( C_GameRules.IsGameRuleActive(Enum.GameRule.PlayerNameplateAlternateHealthColor) and unitIsPlayer and not unitIsActivePlayer and UnitCanAttack("player", frame.unit) ) then
				
			else
				if ( frame.optionTable.healthBarColorOverride ) then
					
					
				else
				
					if (CompactUnitFrame_GetOptionUseClassColors) then 
					
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
	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_PROFILES_LOADED", function()
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
			if (InCombatLockdown() == false) then
				TRP3_RPNameInQuests_UpdateUnitFrames()
			end
		end
	end);
	
	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_DATA_UPDATED", function()
		if ((TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.UNITFRAMERPNAME) == true) and (TRP3_RPNameInQuests_IgnoreUnitFrameMods == false)) then
			if (InCombatLockdown() == false) then
				TRP3_RPNameInQuests_UpdateUnitFrames()
			end
		end
	end);
	

	
	-- Character Sheet
	hooksecurefunc("ToggleCharacter", function()
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.PAPERDOLLRPNAME) == true) then
			if ( CharacterFrame:IsShown() ) then
				if (TRP3_RPNameInQuests_ReturnRPNameTarget() ~= "") then
					if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
						-- Era Only
						CharacterNameText:SetText(TRP3_RPNameInQuests_ReturnRPNameTarget());
					else
						-- Retail and Cata
						CharacterFrame:SetTitle(TRP3_RPNameInQuests_ReturnRPNameTarget());
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

		
			if (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC) then
				-- Era Only
				CharacterLevelText:SetFormattedText(PLAYER_LEVEL, UnitLevel("player"), thisTRP3CharRace, thisTRP3CharClass);
			else
				-- Retail and Cata
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
	end)
	




	-- Quests, Dialog, Gossip Etc.
	if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG) == true) then
	
		
		
		-- Retail and Cata
		if (WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC) then
		
			-- If Classic Quest Log is Installed
			if (C_AddOns.IsAddOnLoaded("Classic Quest Log")) then
				GetQuestLogQuestTextRPNameQuestText = GetQuestLogQuestText
				GetQuestLogQuestText = function(...) 
					questDescription, questObjectives = GetQuestLogQuestTextRPNameQuestText(...)
					return TRP3_RPNameInQuests_CompleteRename(questDescription), questObjectives
				end
			else 
				-- Regular Quest Window
				hooksecurefunc("QuestInfo_Display", function()
					local thisQuestDescription = QuestInfoDescriptionText:GetText()
					if (thisQuestDescription ~= nil) then
						QuestInfoDescriptionText:SetText(TRP3_RPNameInQuests_CompleteRename(thisQuestDescription))
					end
				end)
			end
		

		else
			-- Classic Era
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
	
	
	--Cinematic Subtitles
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		hooksecurefunc(SubtitlesFrame, "AddSubtitle", function(...)
			if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH) == true) then
				SubtitlesFrame.Subtitle1:SetText(TRP3_RPNameInQuests_CompleteRename(SubtitlesFrame.Subtitle1:GetText()))
			end
		end)
	end

	
	
	
	
	
	
	
	-- Mail Window
	-- /Interface/FrameXML/MailFrame.lua
	if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX) == true) then
		hooksecurefunc("OpenMail_Update", function()

				-- Retail
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
					-- Classic
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
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PING", TRP3_RPNameInQuests_ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_HORDE", TRP3_RPNameInQuests_ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_ALLIANCE", TRP3_RPNameInQuests_ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BG_SYSTEM_NEUTRAL", TRP3_RPNameInQuests_ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SKILL", TRP3_RPNameInQuests_ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OPENING", TRP3_RPNameInQuests_ChatFilterFunc)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_TRADESKILLS", TRP3_RPNameInQuests_ChatFilterFunc)
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
											--region:SetWidth(region:GetStringWidth())
											region:SetWidth(region:GetWrappedWidth())
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

	
	hooksecurefunc("Minimap_Update", function(...)
		if (TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME) == true) then
			varCurrentMinimapZoneText = GetMinimapZoneText()
			
			MinimapZoneText:SetText(TRP3_RPNameInQuests_RPNameRename(varCurrentMinimapZoneText, true))
		end
	end)

	
	
	
	
	
	function TRP3_RPNameInQuests_UpdateUnitFrames()
			UnitFrame_Update(PlayerFrame)
			UnitFrame_Update(TargetFrame)
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
	
	local TRP3RPNameInQuests_TextureDot = CreateSimpleTextureMarkup("interface/raidframe/ui-raidframe-threat", 10,10)


	TRP3RPNameInQuests_ConfigElements = {
			{
				inherit = "TRP3_ConfigH1",
				title =  string.format(L.CHARSETTINGS_MAINTITLE, TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(TRP3_API.globals.player)),
				
			},
			{
				inherit = "TRP3_ConfigParagraph",
				title = string.format(L.CHARSETTINGS_MAINTITLE_HELP, TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(TRP3_API.globals.player), TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(L.CHARSETTINGS_CHARSPECIFIC)),
			},
			{
				inherit = "TRP3_ConfigDropDown",
				widgetName = "trp3_rpnameinquests_whichrpnamewidget",
				title = string.format(L.CHARSETTINGS_NAMEFORMAT_TITLE, ORANGE_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_CHARACTER)),
				help = L.CHARSETTINGS_NAMEFORMAT_HELP,
				listContent = TRPRPNAMEINQUESTS_DROPDOWNSTUFF,
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME, value)
					TRP3RPNameInQuests_CharVars.WhichRPName = TRP3_API.configuration.getValue(TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAME)
				end,

			},
			{
				inherit = "TRP3_ConfigDropDown",
				title = string.format(L.CHARSETTINGS_RACEFORMAT_TITLE, NORMAL_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_RACE)),
				help = L.CHARSETTINGS_RACEFORMAT_HELP,
				listContent = TRPRPNAMEINQUESTS_DROPDOWNRACE,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME,
				listCallback = function(value)
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAME, value)
					TRP3RPNameInQuests_CharVars.CustomRaceName = value
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigDropDown",
				title = string.format(L.CHARSETTINGS_CLASSFORMAT_TITLE, TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(L.CHARSETTINGS_CLASS)),
				help = L.CHARSETTINGS_CLASSFORMAT_HELP,
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
				title = string.format(L.CHARSETTINGS_CUSTOMNAME_TITLE, ORANGE_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_CHARACTER), LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_ASTERISK)),
				help = L.CHARSETTINGS_CUSTOMNAME_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.WHICHRPNAMETEXT,
			},
			{
				inherit = "TRP3_ConfigEditBox",
				title = string.format(L.CHARSETTINGS_CUSTOMNAME_TITLE, NORMAL_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_RACE), LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_ASTERISK)),
				help = L.CHARSETTINGS_CUSTOMRACE_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMRACENAMETEXT,
			},
			{
				inherit = "TRP3_ConfigEditBox",
				title = string.format(L.CHARSETTINGS_CUSTOMCLASS_TITLE, TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(L.CHARSETTINGS_CLASS), LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.CHARSETTINGS_ASTERISK)),
				help = L.CHARSETTINGS_CUSTOMCLASS_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.CUSTOMCLASSNAMETEXT,
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
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;					
					
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODQUESTDIALOG, value)
					
					if (TRP3_RPNameInQuests_OldVar_QuestDialog ~= value) then
						TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
					end
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = string.format(L.MODIFYSETTINGS_NPCSPEECH_TITLE .. " ", LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.MODIFYSETTINGS_NPCSPEECH_TITLE2)),
				help = L.MODIFYSETTINGS_NPCSPEECH_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODNPCSPEECH, value)
					
					if (TRP3_RPNameInQuests_OldVar_NPCSpeech ~= value) then
						TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
					end
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = string.format(L.MODIFYSETTINGS_TEXTITEMS_TITLE .. " ", LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.MODIFYSETTINGS_TEXTITEMS_TITLE2)),
				help = L.MODIFYSETTINGS_TEXTITEMS_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;

					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODTEXTITEMS, value)

					if (TRP3_RPNameInQuests_OldVar_TextItems ~= value) then
						TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
					end
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = L.MODIFYSETTINGS_MAILBOX_TITLE,
				help = L.MODIFYSETTINGS_MAILBOX_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;

					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.TEXTMODMAILBOX, value)
					
					if (TRP3_RPNameInQuests_OldVar_Mailbox ~= value) then
						TRP3_API.popup.showConfirmPopup(L.MODIFYSETTINGS_RELOADUI, ReloadUI);
					end
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = L.MODIFYSETTINGS_RCPUNC_TITLE,
				help = string.format(L.MODIFYSETTINGS_RCPUNC_HELP, TRP3_API.globals.player_class_loc, TRP3_API.globals.player_class_loc),
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
				title = TRP3RPNameInQuests_TextureDot .. " " .. L.EXTRAFUNC_SHOWINFO_UNITFRAME_TITLE,
				help = L.EXTRAFUNC_SHOWINFO_UNITFRAME_HELP,
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
				title = TRP3RPNameInQuests_TextureDot .. " " ..  L.EXTRAFUNC_SHOWINFO_PAPERDOLL_TITLE,
				help = L.EXTRAFUNC_SHOWINFO_PAPERDOLL_HELP,
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
				title = TRP3RPNameInQuests_TextureDot .. " " ..  L.EXTRAFUNC_SHOWINFO_PARTYFRAME_TITLE,
				help = L.EXTRAFUNC_SHOWINFO_PARTYFRAME_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME, value)	
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = TRP3RPNameInQuests_TextureDot .. " " ..  L.EXTRAFUNC_SHOWINFO_CLASSCOLOR_TITLE,
				help = L.EXTRAFUNC_SHOWINFO_CLASSCOLOR_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPCOLOR,
				dependentOnOptions = { TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPNAME },
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.PARTYFRAMERPCOLOR, value)	
					
					
				end,
			},
			{
				inherit = "TRP3_ConfigCheck",
				title = TRP3RPNameInQuests_TextureDot .. " " .. string.format(L.EXTRAFUNC_SHOWINFO_ZONENAME_TITLE, LIGHTGRAY_FONT_COLOR:WrapTextInColorCode(L.EXTRAFUNC_SHOWINFO_ZONENAME_TITLE2)),
				help = L.EXTRAFUNC_SHOWINFO_ZONENAME_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.ZONENAMERPNAME, value)	
					
					if (TRP3_RPNameInQuests_OldVar_ZoneNameRPName ~= value) then
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
				inherit = "TRP3_ConfigCheck",
				title = L.TROUBLESHOOTING_ALTMETHOD_TITLE,
				help = L.TROUBLESHOOTING_ALTMETHOD_HELP,
				configKey = TRPRPNAMEINQUESTS.CONFIG.ALTRPNAMEREPLACEMENT,
				OnHide = function(button)
					local value = button:GetChecked() and true or false;
					TRP3_API.configuration.setValue(TRPRPNAMEINQUESTS.CONFIG.ALTRPNAMEREPLACEMENT, value)	
					
					
				end,
			},
			
		}
	
	-- Remove Unit Frame Option if needed
	if (TRP3_RPNameInQuests_IgnoreUnitFrameMods == true) then
		table.remove(TRP3RPNameInQuests_ConfigElements, 22)
	end
	

	--Create Config Page
	TRP3_API.configuration.registerConfigurationPage({
			id = "trp3_rpnameinquests_config",
			menuText = L.ADDON_NAME_SHORT,
			pageText = L.ADDON_NAME,
			elements = TRP3RPNameInQuests_ConfigElements
		});

end




TRP3_API.module.registerModule({
	name = L.ADDON_NAME,
	description = L.ADDON_DESC,
	version = "1.2.21",
	id = "trp3_rpnameinquests",
	onStart = TRP3RPNameInQuests_Init,
	minVersion = 130,
});


-- Slash Command
function TRP3RPNameInQuests_OpenConfig()
	TRP3_API.navigation.openMainFrame();
	TRP3_API.navigation.page.setPage("trp3_rpnameinquests_config");
end

local TRP3RPNameInQuests_OpenConfigCommand = {
	id = "questtext",
	helpLine = " " .. L.SLASHCMD_HELP,
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
		TRP3RPNameInQuests_Tooltip:SetText(L.TRP3 .. ": " .. L.ADDON_NAME)
		
		TRP3RPNameInQuests_Tooltip:AddLine(" ")
		TRP3RPNameInQuests_Tooltip:AddLine(string.format(L.ADCOM_HOW, TRP3RPNameInQuests_ClassColorString:WrapTextInColorCode(TRP3_API.globals.player)), WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		TRP3RPNameInQuests_Tooltip:AddLine(" ")
		
		TRP3RPNameInQuests_Tooltip:AddDoubleLine(L.ADCOM_NAME, TRP3_RPNameInQuests_GetFullRPName(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		TRP3RPNameInQuests_Tooltip:AddDoubleLine(L.ADCOM_RACE, TRP3_RPNameInQuests_ReturnRPRace(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		TRP3RPNameInQuests_Tooltip:AddDoubleLine(L.ADCOM_CLASS, TRP3_RPNameInQuests_ReturnRPClass(), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, WHITE_FONT_COLOR.r, WHITE_FONT_COLOR.g, WHITE_FONT_COLOR.b)
		
		TRP3RPNameInQuests_Tooltip:AddLine(" ")
		TRP3RPNameInQuests_Tooltip:AddLine(L.ADCOM_CLICK_TO_CHANGE, GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)

		TRP3RPNameInQuests_Tooltip:Show()
	end
end

function TRP3RPNameInQuests_CompartmentLeave(buttonName)
	if (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) then
		TRP3RPNameInQuests_Tooltip:Hide()
	end
end
