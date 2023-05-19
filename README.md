# Total RP 3: RP Name in Quest Text
An addon for World of Warcraft!


## About
This is an _unofficial_ module for [Total RP 3](https://github.com/Total-RP/Total-RP-3) that enhances questing immersion by putting your TRP3 IC Name into Quest Text!


## Features
With this addon, it accesses info from your currently selected Total RP 3 Character Profile, and with it:

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

This addon should be compatible with other addons that modify quest windows, chat windows, etc.

## :warning: Caveats
WoW's API only seems to give quest text/dialogue that already has your character's OOC Name/Class/Race in it. It does not have placeholders such as `<name>` or `<race>`.
Due to this, the addon works by doing a find/replace for your OOC Info, and replaces it with your IC info, when enabled.

**Unfortunately this has the side effect that ANY text whether intended for your character or not can be replaced,** which will be much more apparent with Custom Class/Race enabled.

For example, let's say you are an **Orc OOC**, but have your IC Race set as **Ogre**, and you have the **Use Custom Class option Enabled**.

Right-clicking on Overlord Najoi in Orgrimmar, he will normally say "We be horde, all of us. Tauren, **orc**, troll, an' all da rest. Never forget dat we in dis together."

But if you have Custom Race enabled in this addon, he'll say "We be horde, all of us. Tauren, **Ogre**, troll, an' all da rest. Never forget dat we in dis together.", which is unintended.



