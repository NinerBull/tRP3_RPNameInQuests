# Total RP 3: RP Name in Quest Text
An addon for World of Warcraft!

## About
This _unofficial_ module for [Total RP 3](https://github.com/Total-RP/Total-RP-3) attempts to replace any mentions of your OOC Character name by NPCs in Quest Dialogues and Text Chat, with your Roleplay Character Name.

E.g. If your character's name is `Xxlegölåsxx` but your TRP3 Roleplay Name is `Sir Legolas the Nevermissing`, then Quest Dialogues should refer to you with your TRP3 Roleplay Name instead.

You can choose how your character should be addressed on a per-character basis. Type `/trp3 questtext` to begin.

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


## Installation
Download the latest version below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.

* [CurseForge](https://www.curseforge.com/wow/addons/trp3-rpnameinquests)
* [WoWInterface](https://www.wowinterface.com/downloads/fileinfo.php?id=26545)
* [GitHub](https://github.com/NinerBull/tRP3_RPNameInQuests/releases/latest)
* Or put `https://github.com/NinerBull/tRP3_RPNameInQuests` into your favourite Addon Manager


## Configuration
A new area will be added into Total RP 3's Config Window, under 'Settings' > 'Quest Text'.

You can also access the config by typing `/trp3 questtext`. 

There is a dropdown here so you can choose how your character should be addressed by NPCs. You can also choose to enable a function that renames the Character Window with your TRP3 Roleplay Name.

Note that this is on a per-character basis, not per-TRP3 Profile basis. So even if you use the same TRP3 profile across 2 or more characters, you'll need to adjust this dropdown individually for each one.

## :warning: Caveats
While datamined text may show things such as `<name>` in them [as for example, this weekly quest](https://www.wowhead.com/quest=72068), unfortunately, any quest text I can get via the API doesn't include placeholder tags for character name, etc. It already contains your OOC Character name. This addon basically does a find/replace for your OOC Char name with your IC Name.

So if your character's OOC name is a common word, for example, `Warrior` or `Shaman`, then **wierd things are going to happen to quest text with this addon enabled**.

This addon may not be compatible with other addons that modify quest windows, chat windows, etc.
