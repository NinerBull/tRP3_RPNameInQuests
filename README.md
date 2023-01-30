# TRP3: RP Name in Quest Text
An :warning: **EXPERIMENTAL** :warning: addon for World of Warcraft Dragonflight!

## About
This addon attempts to replace any mentions of your OOC Character name by NPCs in Quest Dialogues and text chat, with your Roleplay Character Name that you have created using [Total RP 3](https://github.com/Total-RP/Total-RP-3).

E.g. If your character's name is `Xxlegölåsxx` but your TRP3 Roleplay Name is `Sir Legolas the Nevermissing`, then Quest Dialogues should refer to you with your Roleplay name instead.

You can choose how your character should be addressed on a per-character basis.

## :warning: Caveats
While datamined text may show things such as `<name>` in them [As for example, this weekly quest](https://www.wowhead.com/quest=72068), unfortunately, any quest text I can get via the API doesn't include placeholder tags for character name, etc. It already contains your OOC Character name. This addon basically does a find/replace for your OOC Char name with your IC Name.

So if your character's OOC name is a common word, for example, `The` or `Shaman`, then **wierd things are going to happen to quest text with this addon enabled**.

## Compatibility
* **Dragonflight** - 10.0.5
* **WotLK Classic** - 3.4.1 :warning: UNTESTED :warning:
* **Classic Era** - 1.14.3 :warning: UNTESTED :warning:

Tested and appears to work with:
* Stock UI Quest Frames
* [Classic Quest Log](https://www.curseforge.com/wow/addons/classic-quest-log)
* Stock UI Chat Window
* [Immersion](https://www.curseforge.com/wow/addons/immersion)
* [Storyline](https://github.com/Total-RP/Storyline)


## Installation
Download the latest version below, and unzip it in your `<warcraft>\<_version_>\Interface\Addons` folder if installing manually.

* [GitHub](https://github.com/NinerBull/tRP3_RPNameInQuests/releases/latest)
* Or put `https://github.com/NinerBull/tRP3_RPNameInQuests` into your favourite Addon Manager


## Configuration
A new area will be added into Total RP 3's Config Window, under 'Settings' > 'Quest Text'.

There is a dropdown here so you can choose how your character should be addressed by NPCs. Note that this is on a per-character basis, not per-TRP3 Profile basis. So even if you use the same TRP3 profile across 2 or more characters, you'll need to adjust this dropdown individually for each one.


## To Do ?
- [X] Add Support for Dialogue Options
- [ ] Add Support for Speech Bubbles
- [X] See if any other quest addons work with this - [Storyline](https://github.com/Total-RP/Storyline) seems to, at least.