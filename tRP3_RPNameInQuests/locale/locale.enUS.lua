local _, L = ...;
--if (TRP3_API.utils.GetPreferredLocale() == "enUS") then
	L.TRP3 = "TRP3"
	L.ADDON_NAME = "RP Name in Quest Text"
	L.ADDON_NAME_SHORT = "Quest Text"
	L.ADDON_DESC = "Enhances questing immersion by putting your TRP3 Character Name (and optionally Race and Class) into Quest Text!"
	L.FIRST_TIME_INSTALL_GREET = "%s installed! Type %s to select how this character is addressed by NPCs."
	
	L.DROPDOWNSTUFF_OPT1 = "OOC Character Name"
	L.DROPDOWNSTUFF_OPT2 = "Title"
	L.DROPDOWNSTUFF_OPT3 = "Title + First Name"
	L.DROPDOWNSTUFF_OPT4 = "Title + Last Name"
	L.DROPDOWNSTUFF_OPT5 = "Title + First Name + Last Name"
	L.DROPDOWNSTUFF_OPT6 = "First Name"
	L.DROPDOWNSTUFF_OPT7 = "Last Name"
	L.DROPDOWNSTUFF_OPT8 = "First Name + Last Name"
	L.DROPDOWNSTUFF_OPT9 = "Custom* (Set Below)"
	
	L.DROPDOWNCLASS_OPT1 = "OOC Class Name"
	L.DROPDOWNCLASS_OPT2 = "TRP3 Class Name"
	L.DROPDOWNCLASS_OPT3 = "Custom* (Set Below)"
	
	L.DROPDOWNRACE_OPT1 = "OOC Race Name"
	L.DROPDOWNRACE_OPT2 = "TRP3 Race Name"
	L.DROPDOWNRACE_OPT3 = "Custom* (Set Below)"
	
	L.CHARSETTINGS_MAINTITLE = "%s's Quest Text Settings"
	
	L.CHARSETTINGS_CHARACTER = CHARACTER
	L.CHARSETTINGS_RACE = RACE
	L.CHARSETTINGS_CLASS = CLASS
	L.CHARSETTINGS_ASTERISK = FOREIGN_SERVER_LABEL
	L.CHARSETTINGS_CHARSPECIFIC = "Character Specific"
	
	L.CHARSETTINGS_MAINTITLE_HELP = "What Name, Race and Class should NPCs refer to %s as?\nThese options are %s."
	
	L.CHARSETTINGS_NAMEFORMAT_TITLE = "%s Name Format"
	L.CHARSETTINGS_NAMEFORMAT_HELP = "Select what Name Format NPCs should refer you to as.\n\nSelecting anything other than 'OOC Character Name' or 'Custom' will use information from your currently selected TRP3 Character Profile."
	
	L.CHARSETTINGS_RACEFORMAT_TITLE = "%s Name Format"
	L.CHARSETTINGS_RACEFORMAT_HELP = "Select what Race NPCs should refer to you as."
	
	L.CHARSETTINGS_CLASSFORMAT_TITLE = "%s Name Format"
	L.CHARSETTINGS_CLASSFORMAT_HELP = "Select what Class NPCs should refer to you as."
	
	L.CHARSETTINGS_CUSTOMNAME_TITLE = "Custom %s Name"
	L.CHARSETTINGS_CUSTOMNAME_HELP = "The value entered here will only be used if 'Character Name Format' is set as 'Custom'."
	
	L.CHARSETTINGS_CUSTOMRACE_TITLE = "Custom %s Name"
	L.CHARSETTINGS_CUSTOMRACE_HELP = "The value entered here will only be used if 'Race Name Format' is set as 'Custom'."
	
	L.CHARSETTINGS_CUSTOMCLASS_TITLE = "Custom %s Name"
	L.CHARSETTINGS_CUSTOMCLASS_HELP = "The value entered here will only be used if 'Class Name Format' is set as 'Custom'."
	
	L.MODIFYSETTINGS_TITLE = "Text to Modify"
	L.MODIFYSETTINGS_HELP = "Select which text this addon should modify to include your RP Name/Race/Class.\nThese options are %s."
	L.MODIFYSETTINGS_ACCOUNT_WIDE = "Account Wide"
	L.MODIFYSETTINGS_RELOADUI = "This change requires you to /reload the UI."
	
	L.MODIFYSETTINGS_QUESTTEXT_TITLE = "Quest Text / Gossip"
	L.MODIFYSETTINGS_QUESTTEXT_HELP = "If checked, this addon will modify all text that appears in quest dialogues, including Quest Text, Gossip Text and Gossip Options."
	
	L.MODIFYSETTINGS_NPCSPEECH_TITLE = "NPC Speech"
	L.MODIFYSETTINGS_NPCSPEECH_TITLE2 = "(/say, /yell, /emote etc)"
	L.MODIFYSETTINGS_NPCSPEECH_HELP = "If checked, this addon will modify speech from NPCs including Says, Yells, Emotes, Talking Heads, and Cinematic/Cutscene Subtitles.\n\nDoes not affect speech from other players."
	
	L.MODIFYSETTINGS_TEXTITEMS_TITLE = "Text Items"
	L.MODIFYSETTINGS_TEXTITEMS_TITLE2 = "(Books, Letters, Plaques etc)"
	L.MODIFYSETTINGS_TEXTITEMS_HELP = "If checked, this addon will modify text items such as Books, Letters and other text items you can find in the world or use from your bags."
	
	L.MODIFYSETTINGS_MAILBOX_TITLE = "Mailbox"
	L.MODIFYSETTINGS_MAILBOX_HELP = "If checked, this addon will modify most mail in your Mailbox.\n\nDoes not affect mails that use a template, for example, Auction House invoices."
	
	L.MODIFYSETTINGS_RCPUNC_TITLE = "Only modify Race/Class adjacent to punctuation"
	L.MODIFYSETTINGS_RCPUNC_HELP = "If checked, your RP Race or Class will only be modified in quest text if it is next to a full stop, comma, question mark, or exclamation mark.\n\nFor example, 'How are you, %s?' would be replaced, as the question mark is next to your class name, but 'How could a %s defeat me?' would not."
	
	
	L.EXTRAFUNC_TITLE = "Extra Functions"
	L.EXTRAFUNC_HELP1 = "Add TRP3 Character Information to other UI elements."
	L.EXTRAFUNC_HELP2 = "These functions may not be compatible with custom UI addons or frameworks."
	L.EXTRAFUNC_HELP3 = "These options are %s."
	
	L.EXTRAFUNC_SHOWINFO_TITLE = "Show Character TRP3 Info:"
	
	L.EXTRAFUNC_SHOWINFO_UNITFRAME_TITLE = "In the Unit Frame"
	L.EXTRAFUNC_SHOWINFO_UNITFRAME_HELP = "If checked, TRP3 Character Names will be shown in the Unit Frame."
	
	L.EXTRAFUNC_SHOWINFO_PAPERDOLL_TITLE = "In the Character Window"
	L.EXTRAFUNC_SHOWINFO_PAPERDOLL_HELP = "If checked, TRP3 Character Name, Race and Class will be shown in the Character Window (aka Paper Doll)."
	
	L.EXTRAFUNC_SHOWINFO_PARTYFRAME_TITLE = "In the Party/Raid Frame"
	L.EXTRAFUNC_SHOWINFO_PARTYFRAME_HELP = "If checked, TRP3 Character Names will be shown in the Party/Raid Frame."
	
	L.EXTRAFUNC_SHOWINFO_CLASSCOLOR_TITLE = "Also Use Custom Class Color in Raid Frames"
	L.EXTRAFUNC_SHOWINFO_CLASSCOLOR_HELP = "If checked, Raid Frames will use the Character's TRP3 Class Color for their background, if available."
	
	L.EXTRAFUNC_SHOWINFO_ZONENAME_TITLE = "In Zone Names %s"
	L.EXTRAFUNC_SHOWINFO_ZONENAME_TITLE2 = "(e.g. Garrison)"
	L.EXTRAFUNC_SHOWINFO_ZONENAME_HELP = "If checked, TRP3 Character Names will be shown in Zone Names where appropriate.\nFor example, your Draenor Garrison."
	
	L.TROUBLESHOOTING_TITLE = "Troubleshooting"
	
	L.TROUBLESHOOTING_ALTMETHOD_TITLE = "Use alternate method to insert RP Name into Quest Text"
	L.TROUBLESHOOTING_ALTMETHOD_HELP = "If your TRP3 Character Name does not appear in quest text as expected, try enabling this option.\nThis will use a slightly different method to add/replace your Character's Name in text which may fix the issue."
	
	L.TROUBLESHOOTING_NOTINENCOUNTER_TITLE = "Don't modify text during a Dungeon/Raid/PVP Instance"
	L.TROUBLESHOOTING_NOTINENCOUNTER_HELP = "If checked, this addon won't attempt to modify any text when in a Dungeon, Raid, Scenario or PVP Instance.\nThis may help prevent LUA errors while in one of these."
	
	L.SLASHCMD_HELP = "Open the 'RP Name in Quest Text' Config."
	
	L.ADCOM_HOW = "How NPCs will address %s:"
	L.ADCOM_NAME = "Name:"
	L.ADCOM_RACE = RACE .. ":"
	L.ADCOM_CLASS = CLASS .. ":"
	L.ADCOM_CLICK_TO_CHANGE = "Click to change settings."
	
--end