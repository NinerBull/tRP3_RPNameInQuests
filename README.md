# Total RP 3: RP Name in Quest Text
An addon for World of Warcraft!


## About
This is an _unofficial_ module for [Total RP 3](https://github.com/Total-RP/Total-RP-3) that enhances questing immersion by putting your TRP3 IC name into Quest Text!


## Features
With this addon, it accesses info from your currently selected Total RP 3 Character Profile, and with it :
* It can replace your character's OOC name (e.g. `Bestwarreu`) with your TRP3 IC name (e.g. `Sir Obvious Testman`) in Quests, Gossip Text, and Says/Yells/Emotes from NPCS!
* You can select how NPCs address you - Title, First Name and/or Last Name, or a combination!
* You can also choose to swap your OOC Race and Class Name (e.g. `Orc / Warrior`) with your TRP3 IC Race and Class (e.g. `Ogre / Brawler`) in the same text!

## Installation
Download the latest version below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.

* [CurseForge](https://www.curseforge.com/wow/addons/trp3-rpnameinquests)
* [WoWInterface](https://www.wowinterface.com/downloads/fileinfo.php?id=26545)
* [GitHub](https://github.com/NinerBull/tRP3_RPNameInQuests/releases/latest)
* Or put `https://github.com/NinerBull/tRP3_RPNameInQuests` into your favourite Addon Manager


## Configuration
Once installed, a new tab will be added into Total RP 3's Config Window.
You can access it via one of the following:

* From TRP3's config window, under 'Settings' > 'Quest Text'.
* Typing `/trp3 questtext` in chat.
* Clicking the "RP Name in Quest Text" option from the Addon Compartment (Retail Only)

From here, you'll have multiple options to select from. Note that these options are OOC Character Specific.

* Choose from the dropdown how NPCs should address you when they say your name. This is "Title + First Name + Last Name" by default.
* Select if NPCs should address your character by your TRP3 Race Name. This is disabled by default.
* Select if NPCs should address your character by your TRP3 Class Name. This is disabled by default.


## Compatibility
* **Dragonflight** - 10.1.0
* **WotLK Classic** - 3.4.1
* **Classic Era** - 1.14.3

**REQUIRES** [Total RP 3](https://github.com/Total-RP/Total-RP-3)

Tested and appears to work with:
* Stock UI Quest Frames
* [Classic Quest Log](https://www.curseforge.com/wow/addons/classic-quest-log)
* Stock UI Chat Window
* [Immersion](https://www.curseforge.com/wow/addons/immersion)
* [Storyline](https://github.com/Total-RP/Storyline)


## :warning: Caveats
While datamined text may show things such as `<name>` in them [as for example, this weekly quest](https://www.wowhead.com/quest=72068), unfortunately, any quest text I can get via the API doesn't include placeholder tags for character name, etc. It already contains your OOC Character name. This addon basically does a find/replace for your OOC Char name with your IC Name.

So if your character's OOC name is a common word, for example, `Warrior` or `Shaman`, then **wierd things are going to happen to quest text with this addon enabled**.

Wierd things are also very likely to happen if you enable custom Race/Class names.

This addon should be compatible with other addons that modify quest windows, chat windows, etc.
