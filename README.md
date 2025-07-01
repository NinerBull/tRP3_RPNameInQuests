# Total RP 3: RP Name in Quest Text
An addon for World of Warcraft - The War Within, Cataclysm Classic and Classic Era!

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
* **The War Within** - 11.1.7
* **MoP Classic** - 5.5.0
* **Classic Era** - 1.15.7

This addon **requires** [Total RP 3](https://github.com/Total-RP/Total-RP-3) as it makes use of the RP Character Profile.

I have tested this addon successfully with the following:
* [Classic Quest Log](https://www.curseforge.com/wow/addons/classic-quest-log)
* [Immersion](https://github.com/seblindfors/Immersion)
* [Storyline](https://github.com/Total-RP/Storyline)
* [GossipChatter](https://github.com/keyboardturner/GossipChatter)
* [DialogueUI](https://github.com/Peterodox/YUI-Dialogue)
* [Interaction](https://github.com/Adaptvx/Interaction)

This addon should hopefully be compatible with other addons that modify quest windows, chat windows, etc.

## :warning: Caveats
WoW's API only seems to give quest text/dialogue that already has your character's OOC Name/Class/Race in it. It does not have placeholders such as `<name>` or `<race>`.
Due to this, the addon works by doing a find/replace for your OOC Info, and replaces it with your IC info, when enabled.

**Unfortunately this has the side effect that ANY text whether intended for your character or not can be replaced,** which will be much more apparent with Custom Class/Race enabled. _This is reduced by ticking the "Only modify Race/Class adjacent to punctuation" option, which is enabled by default._

For example, let's say you are an **Orc OOC**, but have your IC Race set as **Ogre**, and you have the **Use Custom Class option Enabled**.

Right-clicking on Overlord Najoi in Orgrimmar, he will normally say "We be horde, all of us. Tauren, **orc**, troll, an' all da rest. Never forget dat we in dis together."

But if you have Custom Race enabled in this addon, he'll say "We be horde, all of us. Tauren, **Ogre**, troll, an' all da rest. Never forget dat we in dis together.", which is unintended.
