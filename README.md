# Total RP 3: RP Name in Quest Text
An addon for World of Warcraft!

![Info Img](https://cdn-wow.mmoui.com/preview/pvw75727.jpg)

## About
This is an _unofficial_ module for [Total RP 3](https://github.com/Total-RP/Total-RP-3) that enhances questing immersion by putting your TRP3 Character Name (and optionally Race and Class) into Quest Text!


## Features
With this addon, it accesses info from your currently selected Total RP 3 Character Profile, and with it:

* Replaces your Character's OOC name (e.g. `Bestwarreu`) with your TRP3 IC name (e.g. `Sir Obvious Testman`) in Quests, Gossip Text, and Says/Yells/Emotes from NPCs! Alternatively, enter a Custom Name that NPCs will refer to you as.
* Optionally, replace your OOC Race and Class Name (e.g. `Orc / Warrior`) with your TRP3 IC Race and Class (e.g. `Ogre / Brawler`) in the same text, or with your own Custom Race/Class too!

## Installation
Download the latest version below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.

* [CurseForge](https://www.curseforge.com/wow/addons/trp3-rpnameinquests)
* [WoWInterface](https://www.wowinterface.com/downloads/fileinfo.php?id=26545)
* [Wago](https://addons.wago.io/addons/trp3-rpnameinquests)
* [GitHub](https://github.com/NinerBull/tRP3_RPNameInQuests/releases/latest)
* Or put `https://github.com/NinerBull/tRP3_RPNameInQuests` into your favourite Addon Manager


## Configuration
Once installed, a new section will be added into Total RP 3's Config Window.
You can access it via one of the following:

* From TRP3's config window, under 'Settings' > 'Quest Text'.
* Typing `/trp3 questtext` in chat.
* Clicking the "RP Name in Quest Text" option from the Addon Compartment (Retail Only)

From here, you'll have multiple options to select from. Note that these options are OOC Character Specific, and are not tied to your TRP3 Character Profile.

* Select how NPCs should address you when they say your Name. (This is "Title + First Name + Last Name" by default.)
* Select what Race NPCs call you. (This is "OOC Race Name" by default.)
* Select what Class NPCs call you. (This is "OOC Class Name" by default.)

If set as "Custom Name/Race/Class", fill in the text boxes underneath to use a Name/Race/Class which is seperate from your TRP3 Profile!

You can also select which text this addon modifies. Turn on/off as desired.

You can also add your TRP3 Roleplay Name/Race/Class to various UI components, such as Unit Frames and the Character Window. _Note that this may not function with other 3rd party UI addons._


## Compatibility
* **Midnight** - 12.1.0
* **MoP Classic** - 5.5.4
* **TBC Classic** - 2.5.6
* **Classic Era** - 1.15.9

This addon **requires** [Total RP 3](https://github.com/Total-RP/Total-RP-3) as it makes use of the RP Character Profile.

I have tested this addon successfully with the following:
* [Kerzo Classic Quest Log](https://www.curseforge.com/wow/addons/kerzo-classic-quest-log)
* [Immersion](https://github.com/seblindfors/Immersion)
* [Storyline](https://github.com/Total-RP/Storyline)
* [GossipChatter](https://github.com/keyboardturner/GossipChatter)
* [DialogueUI](https://github.com/Peterodox/YUI-Dialogue)
* [Interaction](https://github.com/Adaptvx/Interaction)

This addon should hopefully be compatible with other addons that modify quest windows, chat windows, etc.

## API
You can use the following functions in your own addons to make use of this addon's data.

### Return Functions
* `TRP3RPNameInQuests.API:ReturnRPName(renameFullName)` - Returns the character's currently chosen Quest Text RP Name. If `renameFullName` is `true`, it will give the full RP Name (Title + First Name + Last Name)
* `TRP3RPNameInQuests.API:ReturnRPRace()` - Returns the character's currently chosen Quest Text RP Race. 
* `TRP3RPNameInQuests.API:ReturnRPClass()` - Returns the character's currently chosen Quest Text RP Class. 
* `TRP3RPNameInQuests.API:ReturnRPNameUnit(unit, withTitle)` - Returns a string with the unit's RP Name, or their regular name if they do not have a TRP3 profile. `unit` should be a valid unit stringID, e.g. `"player"` or `"target"`. If `withTitle` is `true`, it will also provide the target's RP Title.

### Rename Functions
* `TRP3RPNameInQuests.API:RPNameRename(textToRename, renameFullName)` - Returns a string, replacing the character's OOC Name with their chosen Quest Text Character Name. If `renameFullName` is `true`, it will search for the full RP Name (Title + First Name + Last Name).
* `TRP3RPNameInQuests.API:RPClassRename(textToRename)` - Returns a string, replacing the character's OOC Class with their chosen Quest Text Class Name.
* `TRP3RPNameInQuests.API:RPRaceRename(textToRename)` - Returns a string, replacing the character's OOC Race with their chosen Quest Text Class Name.
* `TRP3RPNameInQuests.API:CompleteRename(textToRename)` - Returns a string, replacing the character's OOC Name, Class and Race with their chosen Quest Text formatting settings.

### Modifier Settings Functions
* `TRP3RPNameInQuests.API:IsTextModifierEnabled(thisTextModifier)` - Returns a boolean to determine if the addon is currently modifying a certain type of text content. `thisTextModifier` can be a string containing one of the following:
	* `questdialog` - Quest Text / Gossip Text / Quest Log
	* `npcspeech` - NPC Speech, such as /say and /yell
	* `textitems` - Text Items, such as books and plaques
	* `mailbox` - Mailbox items such as letters
* `TRP3RPNameInQuests.API:IsUsingModifiedTextForType(thisTextType)` - Returns a boolean to determine if the addon is modifying the player's Name, Class or Race. `thisTextType` can be a string containing one of the following:
	* `name` - If the character's Name is being modified from their OOC name to their TRP3 name (or a custom name)
	* `class` - If the character's Class is being modified from their OOC class to their TRP3 class (or a custom class)
	* `race` - If the character's Race is being modified from their OOC race to their TRP3 class (or a custom race)

### API Examples
You can check to see if the module is loaded before attempting to use any of these APIs with the following example:
```lua
if (TRP3_API and TRP3_API.module.isModuleLoaded("trp3_rpnameinquests")) then
	
	-- # Obtaining Strings
	local thisRPName = TRP3RPNameInQuests.API:ReturnRPName()
	local thisRPRace = TRP3RPNameInQuests.API:ReturnRPRace()
	local thisRPClass = TRP3RPNameInQuests.API:ReturnRPClass()

	-- # Modifying Strings
	-- With an OOC Name of 'Sirtestman' and RP Name of 'Sir Obvious Testman'
	local thisText1 = TRP3RPNameInQuests.API:CompleteRename("My Name is Sirtestman. A pleasure to meet you.")
	-- thisText1 will become "My Name is Sir Obvious Testman. A pleasure to meet you."
	
	-- String variables also work.
	local thisTextString = "My Name is Sirtestman. A pleasure to meet you."
	local thisText2 = TRP3RPNameInQuests.API:CompleteRename(thisTextString)
	
	-- And also functions that return strings
	local thisText3 = TRP3RPNameInQuests.API:CompleteRename(UnitName("player"))
	
	-- Get the Target's RP Name
	local thisTextTarget = TRP3RPNameInQuests.API:ReturnRPNameUnit("target")
	local thisTextTargetTitle = TRP3RPNameInQuests.API:ReturnRPNameUnit("target", true) -- With Title
	
end
```


## :warning: Caveats
WoW's API only seems to give quest text/dialogue that already has your character's OOC Name/Class/Race in it. It does not have placeholders such as `<name>` or `<race>`.
Due to this, the addon works by doing a find/replace for your OOC Info, and replaces it with your IC info, when enabled.

**Unfortunately this has the side effect that ANY text whether intended for your character or not can be replaced,** which will be much more apparent with Custom Class/Race enabled. _This is reduced by ticking the "Only modify Race/Class adjacent to punctuation" option, which is enabled by default._

For example, let's say you are an **Orc OOC**, but have your IC Race set as **Ogre**, and you have the **Use Custom Class option Enabled**.

Right-clicking on Overlord Najoi in Orgrimmar, he will normally say "We be horde, all of us. Tauren, **orc**, troll, an' all da rest. Never forget dat we in dis together."

But if you have Custom Race enabled in this addon, he'll say "We be horde, all of us. Tauren, **Ogre**, troll, an' all da rest. Never forget dat we in dis together.", which is unintended.
