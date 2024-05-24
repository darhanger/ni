local tables = {
	blacklistedaoeunits = {},
	blacklisteddispels = {
	2819, 2824, 11355, 11356, 16427, 20184, 20185, 20186, 25351, 26967, 27186, GetSpellInfo(30129), 31803, 32859, 34616, 34856, 36814, 37132, 37930, 38136, 38141, 38142, 38143, 39042, 41486, GetSpellInfo(47843), GetSpellInfo(48160), 53742, 55360, GetSpellInfo(57970), 57973, 57972, 60667, 60814, 61429, 61840, 68055, 68786, 69674, 70337, 70405, 70867, 70964, 71224, 71889, 72908, 74562, 74567, 74792, 74795
	},
	bosses = {
		-- Ragefire Chasm
		[11517] = true, -- Oggleflint
		[11520] = true, -- Taragaman the Hungerer
		[11518] = true, -- Jergosh the Invoker
		[11519] = true, -- Bazzalan
		[17830] = true, -- Zelemar the Wrathful
		-- The Deadmines
		[644] = true, -- Rhahk'Zor
		[3586] = true, -- Miner Johnson
		[643] = true, -- Sneed
		[642] = true, -- Sneed's Shredder
		[1763] = true, -- Gilnid
		[646] = true, -- Mr. Smite
		[645] = true, -- Cookie
		[647] = true, -- Captain Greenskin
		[639] = true, -- Edwin VanCleef
		[596] = true, -- Brainwashed Noble, outside
		[626] = true, -- Foreman Thistlenettle, outside
		[599] = true, -- Marisa du'Paige, outside
		-- Wailing Caverns
		[5775] = true, -- Verdan the Everliving
		[3670] = true, -- Lord Pythas
		[3673] = true, -- Lord Serpentis
		[3669] = true, -- Lord Cobrahn
		[3654] = true, -- Mutanus the Devourer
		[3674] = true, -- Skum
		[3653] = true, -- Kresh
		[3671] = true, -- Lady Anacondra
		[5912] = true, -- Deviate Faerie Dragon
		[3672] = true, -- Boahn, outside
		[3655] = true, -- Mad Magglish, outside
		[3652] = true, -- Trigore the Lasher, outside
		-- Shadowfang Keep
		[3914] = true, -- Rethilgore
		[3886] = true, -- Razorclaw the Butcher
		[4279] = true, -- Odo the Blindwatcher
		[3887] = true, -- Baron Silverlaine
		[4278] = true, -- Commander Springvale
		[4274] = true, -- Fenrus the Devourer
		[3927] = true, -- Wolf Master Nandos
		[14682] = true, -- Sever (Scourge invasion only)
		[4275] = true, -- Archmage Arugal
		[3872] = true, -- Deathsworn Captain
		-- Blackfathom Deeps
		[4887] = true, -- Ghamoo-ra
		[4831] = true, -- Lady Sarevess
		[12902] = true, -- Lorgus Jett
		[6243] = true, -- Gelihast
		[12876] = true, -- Baron Aquanis
		[4830] = true, -- Old Serra'kis
		[4832] = true, -- Twilight Lord Kelris
		[4829] = true, -- Aku'mai
		-- Stormwind Stockade
		[1716] = true, -- Bazil Thredd
		[1663] = true, -- Dextren Ward
		[1717] = true, -- Hamhock
		[1666] = true, -- Kam Deepfury
		[1696] = true, -- Targorr the Dread
		[1720] = true, -- Bruegal Ironknuckle
		-- Razorfen Kraul
		[4421] = true, -- Charlga Razorflank
		[4420] = true, -- Overlord Ramtusk
		[4422] = true, -- Agathelos the Raging
		[4428] = true, -- Death Speaker Jargba
		[4424] = true, -- Aggem Thorncurse
		[6168] = true, -- Roogug
		[4425] = true, -- Blind Hunter
		[4842] = true, -- Earthcaller Halmgar
		-- Gnomeregan
		[7800] = true, -- Mekgineer Thermaplugg
		[7079] = true, -- Viscous Fallout
		[7361] = true, -- Grubbis
		[6235] = true, -- Electrocutioner 6000
		[6229] = true, -- Crowd Pummeler 9-60
		[6228] = true, -- Dark Iron Ambassador
		[6231] = true, -- Techbot, outside
		-- Scarlet Monastery: The Graveyard
		[3983] = true, -- Interrogator Vishas
		[6488] = true, -- Fallen Champion
		[6490] = true, -- Azshir the Sleepless
		[6489] = true, -- Ironspine
		[14693] = true, -- Scorn (Scourge invasion only)
		[4543] = true, -- Bloodmage Thalnos
		[23682] = true, -- Headless Horseman
		[23800] = true, -- Headless Horseman
		-- Scarley Monastery: Library
		[3974] = true, -- Houndmaster Loksey
		[6487] = true, -- Arcanist Doan
		-- Scarley Monastery: Armory
		[3975] = true, -- Herod
		-- Scarley Monastery: Cathedral
		[4542] = true, -- High Inquisitor Fairbanks
		[3976] = true, -- Scarlet Commander Mograine
		[3977] = true, -- High Inquisitor Whitemane
		-- Razorfen Downs
		[7355] = true, -- Tuten'kash
		[14686] = true, -- Lady Falther'ess (Scourge invasion only)
		[7356] = true, -- Plaguemaw the Rotting
		[7357] = true, -- Mordresh Fire Eye
		[8567] = true, -- Glutton
		[7354] = true, -- Ragglesnout
		[7358] = true, -- Amnennar the Coldbringer
		-- Uldaman
		[7057] = true, -- Digmaster Shovelphlange
		-- [2932]  = true, -- Magregan Deepshadow (Outside the instance, not elite)
		[6910] = true, -- Revelosh
		[7228] = true, -- Ironaya
		[7023] = true, -- Obsidian Sentinel
		[7206] = true, -- Ancient Stone Keeper
		[7291] = true, -- Galgann Firehammer
		[4854] = true, -- Grimlok
		[2748] = true, -- Archaedas
		[6906] = true, -- Baelog
		-- Zul'Farrak
		[10082] = true, -- Zerillis
		[10080] = true, -- Sandarr Dunereaver
		[7272] = true, -- Theka the Martyr
		[8127] = true, -- Antu'sul
		[7271] = true, -- Witch Doctor Zum'rah
		[7274] = true, -- Sandfury Executioner
		[7275] = true, -- Shadowpriest Sezz'ziz
		[7796] = true, -- Nekrum Gutchewer
		[7797] = true, -- Ruuzlu
		[7267] = true, -- Chief Ukorz Sandscalp
		[10081] = true, -- Dustwraith
		[7795] = true, -- Hydromancer Velratha
		[7273] = true, -- Gahz'rilla
		[7608] = true, -- Murta Grimgut
		[7606] = true, -- Oro Eyegouge
		[7604] = true, -- Sergeant Bly
		-- Maraudon
		-- [13718] = true, -- The Nameless Prophet (Pre-instance)
		[13742] = true, -- Kolk <The First Khan>
		[13741] = true, -- Gelk <The Second Khan>
		[13740] = true, -- Magra <The Third Khan>
		[13739] = true, -- Maraudos <The Fourth Khan>
		[12236] = true, -- Lord Vyletongue
		[13738] = true, -- Veng <The Fifth Khan>
		[13282] = true, -- Noxxion
		[12258] = true, -- Razorlash
		[12237] = true, -- Meshlok the Harvester
		[12225] = true, -- Celebras the Cursed
		[12203] = true, -- Landslide
		[13601] = true, -- Tinkerer Gizlock
		[13596] = true, -- Rotgrip
		[12201] = true, -- Princess Theradras
		-- Temple of Atal'Hakkar
		[1063] = true, -- Jade
		[5400] = true, -- Zekkis
		[5713] = true, -- Gasher
		[5715] = true, -- Hukku
		[5714] = true, -- Loro
		[5717] = true, -- Mijan
		[5712] = true, -- Zolo
		[5716] = true, -- Zul'Lor
		[5399] = true, -- Veyzhak the Cannibal
		[5401] = true, -- Kazkaz the Unholy
		[8580] = true, -- Atal'alarion
		[8443] = true, -- Avatar of Hakkar
		[5711] = true, -- Ogom the Wretched
		[5710] = true, -- Jammal'an the Prophet
		[5721] = true, -- Dreamscythe
		[5720] = true, -- Weaver
		[5719] = true, -- Morphaz
		[5722] = true, -- Hazzas
		[5709] = true, -- Shade of Eranikus
		-- The Blackrock Depths: Detention Block
		[9018] = true, -- High Interrogator Gerstahn
		-- The Blackrock Depths: Halls of the Law
		[9025] = true, -- Lord Roccor
		[9319] = true, -- Houndmaster Grebmar
		-- The Blackrock Depths: Ring of Law (Arena)
		[9031] = true, -- Anub'shiah
		[9029] = true, -- Eviscerator
		[9027] = true, -- Gorosh the Dervish
		[9028] = true, -- Grizzle
		[9032] = true, -- Hedrum the Creeper
		[9030] = true, -- Ok'thor the Breaker
		[16059] = true, -- Theldren
		-- The Blackrock Depths: Outer Blackrock Depths
		[9024] = true, -- Pyromancer Loregrain
		[9041] = true, -- Warder Stilgiss
		[9042] = true, -- Verek
		[9476] = true, -- Watchman Doomgrip
		-- Dark Keepers, 6 of em: http://www.wowwiki.com/Dark_Keeper
		[9056] = true, -- Fineous Darkvire
		[9017] = true, -- Lord Incendius
		[9016] = true, -- Bael'Gar
		[9033] = true, -- General Angerforge
		[8983] = true, -- Golem Lord Argelmach
		-- The Blackrock Depths: Grim Guzzler
		[9543] = true, -- Ribbly Screwspigot
		[9537] = true, -- Hurley Blackbreath
		[9502] = true, -- Phalanx
		[9499] = true, -- Plugger Spazzring
		[23872] = true, -- Coren Direbrew
		-- The Blackrock Depths: Inner Blackrock Depths
		[9156] = true, -- Ambassador Flamelash
		[8923] = true, -- Panzor the Invincible
		[17808] = true, -- Anger'rel
		[9039] = true, -- Doom'rel
		[9040] = true, -- Dope'rel
		[9037] = true, -- Gloom'rel
		[9034] = true, -- Hate'rel
		[9038] = true, -- Seeth'rel
		[9036] = true, -- Vile'rel
		[9938] = true, -- Magmus
		[10076] = true, -- High Priestess of Thaurissan
		[8929] = true, -- Princess Moira Bronzebeard
		[9019] = true, -- Emperor Dagran Thaurissan
		-- Dire Maul: Arena
		[11447] = true, -- Mushgog
		[11498] = true, -- Skarr the Unbreakable
		[11497] = true, -- The Razza
		-- Dire Maul: East
		[14354] = true, -- Pusillin
		[14327] = true, -- Lethtendris
		[14349] = true, -- Pimgib
		[13280] = true, -- Hydrospawn
		[11490] = true, -- Zevrim Thornhoof
		[11492] = true, -- Alzzin the Wildshaper
		[16097] = true, -- Isalien
		-- Dire Maul: North
		[14326] = true, -- Guard Mol'dar
		[14322] = true, -- Stomper Kreeg
		[14321] = true, -- Guard Fengus
		[14323] = true, -- Guard Slip'kik
		[14325] = true, -- Captain Kromcrush
		[14324] = true, -- Cho'Rush the Observer
		[11501] = true, -- King Gordok
		-- Dire Maul: West
		[11489] = true, -- Tendris Warpwood
		[11487] = true, -- Magister Kalendris
		[11467] = true, -- Tsu'zee
		[11488] = true, -- Illyanna Ravenoak
		[14690] = true, -- Revanchion (Scourge Invasion)
		[11496] = true, -- Immol'thar
		[14506] = true, -- Lord Hel'nurath
		[11486] = true, -- Prince Tortheldrin
		-- Lower Blackrock Spire
		[10263] = true, -- Burning Felguard
		[9218] = true, -- Spirestone Battle Lord
		[9219] = true, -- Spirestone Butcher
		[9217] = true, -- Spirestone Lord Magus
		[9196] = true, -- Highlord Omokk
		[9236] = true, -- Shadow Hunter Vosh'gajin
		[9237] = true, -- War Master Voone
		[16080] = true, -- Mor Grayhoof
		[9596] = true, -- Bannok Grimaxe
		[10596] = true, -- Mother Smolderweb
		[10376] = true, -- Crystal Fang
		[10584] = true, -- Urok Doomhowl
		[9736] = true, -- Quartermaster Zigris
		[10220] = true, -- Halycon
		[10268] = true, -- Gizrul the Slavener
		[9718] = true, -- Ghok Bashguud
		[9568] = true, -- Overlord Wyrmthalak
		-- Stratholme: Scarlet Stratholme
		[10393] = true, -- Skul
		[14684] = true, -- Balzaphon (Scourge Invasion)
		-- [11082] = true, -- Stratholme Courier
		[11058] = true, -- Fras Siabi
		[10558] = true, -- Hearthsinger Forresten
		[10516] = true, -- The Unforgiven
		[16387] = true, -- Atiesh
		[11143] = true, -- Postmaster Malown
		[10808] = true, -- Timmy the Cruel
		[11032] = true, -- Malor the Zealous
		[11120] = true, -- Crimson Hammersmith
		[10997] = true, -- Cannon Master Willey
		[10811] = true, -- Archivist Galford
		[10813] = true, -- Balnazzar
		[16101] = true, -- Jarien
		[16102] = true, -- Sothos
		-- Stratholme: Undead Stratholme
		[10809] = true, -- Stonespine
		[10437] = true, -- Nerub'enkan
		[10436] = true, -- Baroness Anastari
		[11121] = true, -- Black Guard Swordsmith
		[10438] = true, -- Maleki the Pallid
		[10435] = true, -- Magistrate Barthilas
		[10439] = true, -- Ramstein the Gorger
		[10440] = true, -- Baron Rivendare (Stratholme)
		-- Stratholme: Defenders of the Chapel
		[17913] = true, -- Aelmar the Vanquisher
		[17911] = true, -- Cathela the Seeker
		[17910] = true, -- Gregor the Justiciar
		[17914] = true, -- Vicar Hieronymus
		[17912] = true, -- Nemas the Arbiter
		-- Scholomance
		[14861] = true, -- Blood Steward of Kirtonos
		[10506] = true, -- Kirtonos the Herald
		[14695] = true, -- Lord Blackwood (Scourge Invasion)
		[10503] = true, -- Jandice Barov
		[11622] = true, -- Rattlegore
		[14516] = true, -- Death Knight Darkreaver
		[10433] = true, -- Marduk Blackpool
		[10432] = true, -- Vectus
		[16118] = true, -- Kormok
		[10508] = true, -- Ras Frostwhisper
		[10505] = true, -- Instructor Malicia
		[11261] = true, -- Doctor Theolen Krastinov
		[10901] = true, -- Lorekeeper Polkelt
		[10507] = true, -- The Ravenian
		[10504] = true, -- Lord Alexei Barov
		[10502] = true, -- Lady Illucia Barov
		[1853] = true, -- Darkmaster Gandling
		-- Upper Blackrock Spire
		[9816] = true, -- Pyroguard Emberseer
		[10264] = true, -- Solakar Flamewreath
		[10509] = true, -- Jed Runewatcher
		[10899] = true, -- Goraluk Anvilcrack
		[10339] = true, -- Gyth
		[10429] = true, -- Warchief Rend Blackhand
		[10430] = true, -- The Beast
		[16042] = true, -- Lord Valthalak
		[10363] = true, -- General Drakkisath
		-- Zul'Gurub
		[14517] = true, -- High Priestess Jeklik
		[14507] = true, -- High Priest Venoxis
		[14510] = true, -- High Priestess Mar'li
		[11382] = true, -- Bloodlord Mandokir
		[15114] = true, -- Gahz'ranka
		[14509] = true, -- High Priest Thekal
		[14515] = true, -- High Priestess Arlokk
		[11380] = true, -- Jin'do the Hexxer
		[14834] = true, -- Hakkar
		[15082] = true, -- Gri'lek
		[15083] = true, -- Hazza'rah
		[15084] = true, -- Renataki
		[15085] = true, -- Wushoolay
		-- Onyxia's Lair
		[10184] = true, -- Onyxia
		-- Molten Core
		[12118] = true, -- Lucifron
		[11982] = true, -- Magmadar
		[12259] = true, -- Gehennas
		[12057] = true, -- Garr
		[12056] = true, -- Baron Geddon
		[12264] = true, -- Shazzrah
		[12098] = true, -- Sulfuron Harbinger
		[11988] = true, -- Golemagg the Incinerator
		[12018] = true, -- Majordomo Executus
		[11502] = true, -- Ragnaros
		-- Blackwing Lair
		[12435] = true, -- Razorgore the Untamed
		[13020] = true, -- Vaelastrasz the Corrupt
		[12017] = true, -- Broodlord Lashlayer
		[11983] = true, -- Firemaw
		[14601] = true, -- Ebonroc
		[11981] = true, -- Flamegor
		[14020] = true, -- Chromaggus
		[11583] = true, -- Nefarian
		[12557] = true, -- Grethok the Controller
		[10162] = true, -- Lord Victor Nefarius <Lord of Blackrock> (Also found in Blackrock Spire)
		-- Ruins of Ahn'Qiraj
		[15348] = true, -- Kurinnaxx
		[15341] = true, -- General Rajaxx
		[15340] = true, -- Moam
		[15370] = true, -- Buru the Gorger
		[15369] = true, -- Ayamiss the Hunter
		[15339] = true, -- Ossirian the Unscarred
		-- Temple of Ahn'Qiraj
		[15263] = true, -- The Prophet Skeram
		[15511] = true, -- Lord Kri
		[15543] = true, -- Princess Yauj
		[15544] = true, -- Vem
		[15516] = true, -- Battleguard Sartura
		[15510] = true, -- Fankriss the Unyielding
		[15299] = true, -- Viscidus
		[15509] = true, -- Princess Huhuran
		[15276] = true, -- Emperor Vek'lor
		[15275] = true, -- Emperor Vek'nilash
		[15517] = true, -- Ouro
		[15727] = true, -- C'Thun
		[15589] = true, -- Eye of C'Thun
		-- Naxxramas
		[30549] = true, -- Baron Rivendare (Naxxramas)
		[16803] = true, -- Death Knight Understudy
		[15930] = true, -- Feugen
		[15929] = true, -- Stalagg
		-- Naxxramas: Spider Wing
		[15956] = true, -- Anub'Rekhan
		[15953] = true, -- Grand Widow Faerlina
		[15952] = true, -- Maexxna
		-- Naxxramas: Abomination Wing
		[16028] = true, -- Patchwerk
		[15931] = true, -- Grobbulus
		[15932] = true, -- Gluth
		[15928] = true, -- Thaddius
		-- Naxxramas: Plague Wing
		[15954] = true, -- Noth the Plaguebringer
		[15936] = true, -- Heigan the Unclean
		[16011] = true, -- Loatheb
		-- Naxxramas: Deathknight Wing
		[16061] = true, -- Instructor Razuvious
		[16060] = true, -- Gothik the Harvester
		-- Naxxramas: The Four Horsemen
		[16065] = true, -- Lady Blaumeux
		[16064] = true, -- Thane Korth'azz
		[16062] = true, -- Highlord Mograine
		[16063] = true, -- Sir Zeliek
		-- Naxxramas: Frostwyrm Lair
		[15989] = true, -- Sapphiron
		[15990] = true, -- Kel'Thuzad
		[25465] = true, -- Kel'Thuzad
		-- Hellfire Citadel: Hellfire Ramparts
		[17306] = true, -- Watchkeeper Gargolmar
		[17308] = true, -- Omor the Unscarred
		[17537] = true, -- Vazruden
		[17307] = true, -- Vazruden the Herald
		[17536] = true, -- Nazan
		-- Hellfire Citadel: The Blood Furnace
		[17381] = true, -- The Maker
		[17380] = true, -- Broggok
		[17377] = true, -- Keli'dan the Breaker
		-- Coilfang Reservoir: Slave Pens
		[25740] = true, -- Ahune
		[17941] = true, -- Mennu the Betrayer
		[17991] = true, -- Rokmar the Crackler
		[17942] = true, -- Quagmirran
		-- Coilfang Reservoir: The Underbog
		[17770] = true, -- Hungarfen
		[18105] = true, -- Ghaz'an
		[17826] = true, -- Swamplord Musel'ek
		[17827] = true, -- Claw <Swamplord Musel'ek's Pet>
		[17882] = true, -- The Black Stalker
		-- Auchindoun: Mana-Tombs
		[18341] = true, -- Pandemonius
		[18343] = true, -- Tavarok
		[22930] = true, -- Yor (Heroic)
		[18344] = true, -- Nexus-Prince Shaffar
		-- Auchindoun: Auchenai Crypts
		[18371] = true, -- Shirrak the Dead Watcher
		[18373] = true, -- Exarch Maladaar
		-- Caverns of Time: Escape from Durnholde Keep
		[17848] = true, -- Lieutenant Drake
		[17862] = true, -- Captain Skarloc
		[18096] = true, -- Epoch Hunter
		[28132] = true, -- Don Carlos
		-- Auchindoun: Sethekk Halls
		[18472] = true, -- Darkweaver Syth
		[23035] = true, -- Anzu (Heroic)
		[18473] = true, -- Talon King Ikiss
		-- Coilfang Reservoir: The Steamvault
		[17797] = true, -- Hydromancer Thespia
		[17796] = true, -- Mekgineer Steamrigger
		[17798] = true, -- Warlord Kalithresh
		-- Auchindoun: Shadow Labyrinth
		[18731] = true, -- Ambassador Hellmaw
		[18667] = true, -- Blackheart the Inciter
		[18732] = true, -- Grandmaster Vorpil
		[18708] = true, -- Murmur
		-- Hellfire Citadel: Shattered Halls
		[16807] = true, -- Grand Warlock Nethekurse
		[20923] = true, -- Blood Guard Porung (Heroic)
		[16809] = true, -- Warbringer O'mrogg
		[16808] = true, -- Warchief Kargath Bladefist
		-- Caverns of Time: Opening the Dark Portal
		[17879] = true, -- Chrono Lord Deja
		[17880] = true, -- Temporus
		[17881] = true, -- Aeonus
		-- Tempest Keep: The Mechanar
		[19218] = true, -- Gatewatcher Gyro-Kill
		[19710] = true, -- Gatewatcher Iron-Hand
		[19219] = true, -- Mechano-Lord Capacitus
		[19221] = true, -- Nethermancer Sepethrea
		[19220] = true, -- Pathaleon the Calculator
		-- Tempest Keep: The Botanica
		[17976] = true, -- Commander Sarannis
		[17975] = true, -- High Botanist Freywinn
		[17978] = true, -- Thorngrin the Tender
		[17980] = true, -- Laj
		[17977] = true, -- Warp Splinter
		-- Tempest Keep: The Arcatraz
		[20870] = true, -- Zereketh the Unbound
		[20886] = true, -- Wrath-Scryer Soccothrates
		[20885] = true, -- Dalliah the Doomsayer
		[20912] = true, -- Harbinger Skyriss
		[20904] = true, -- Warden Mellichar
		-- Magisters' Terrace
		[24723] = true, -- Selin Fireheart
		[24744] = true, -- Vexallus
		[24560] = true, -- Priestess Delrissa
		[24664] = true, -- Kael'thas Sunstrider
		-- Karazhan
		[15550] = true, -- Attumen the Huntsman
		[16151] = true, -- Midnight
		[28194] = true, -- Tenris Mirkblood (Scourge invasion)
		[15687] = true, -- Moroes
		[16457] = true, -- Maiden of Virtue
		[15691] = true, -- The Curator
		[15688] = true, -- Terestian Illhoof
		[16524] = true, -- Shade of Aran
		[15689] = true, -- Netherspite
		[15690] = true, -- Prince Malchezaar
		[17225] = true, -- Nightbane
		[17229] = true, -- Kil'rek
		-- Chess event

		-- Karazhan: Servants' Quarters Beasts
		[16179] = true, -- Hyakiss the Lurker
		[16181] = true, -- Rokad the Ravager
		[16180] = true, -- Shadikith the Glider
		-- Karazhan: Opera Event
		[17535] = true, -- Dorothee
		[17546] = true, -- Roar
		[17543] = true, -- Strawman
		[17547] = true, -- Tinhead
		[17548] = true, -- Tito
		[18168] = true, -- The Crone
		[17521] = true, -- The Big Bad Wolf
		[17533] = true, -- Romulo
		[17534] = true, -- Julianne
		-- Gruul's Lair
		[18831] = true, -- High King Maulgar
		[19044] = true, -- Gruul the Dragonkiller
		-- Gruul's Lair: Maulgar's Ogre Council
		[18835] = true, -- Kiggler the Crazed
		[18836] = true, -- Blindeye the Seer
		[18834] = true, -- Olm the Summoner
		[18832] = true, -- Krosh Firehand
		-- Hellfire Citadel: Magtheridon's Lair
		[17257] = true, -- Magtheridon
		-- Zul'Aman: Animal Bosses
		[29024] = true, -- Nalorakk
		[28514] = true, -- Nalorakk
		[23576] = true, -- Nalorakk
		[23574] = true, -- Akil'zon
		[23578] = true, -- Jan'alai
		[28515] = true, -- Jan'alai
		[29023] = true, -- Jan'alai
		[23577] = true, -- Halazzi
		[28517] = true, -- Halazzi
		[29022] = true, -- Halazzi
		[24239] = true, -- Malacrass
		-- Zul'Aman: Final Bosses
		[24239] = true, -- Hex Lord Malacrass
		[23863] = true, -- Zul'jin
		-- Coilfang Reservoir: Serpentshrine Cavern
		[21216] = true, -- Hydross the Unstable
		[21217] = true, -- The Lurker Below
		[21215] = true, -- Leotheras the Blind
		[21214] = true, -- Fathom-Lord Karathress
		[21213] = true, -- Morogrim Tidewalker
		[21212] = true, -- Lady Vashj
		[21875] = true, -- Shadow of Leotheras
		-- Tempest Keep: The Eye
		[19514] = true, -- Al'ar
		[19516] = true, -- Void Reaver
		[18805] = true, -- High Astromancer Solarian
		[19622] = true, -- Kael'thas Sunstrider
		[20064] = true, -- Thaladred the Darkener
		[20060] = true, -- Lord Sanguinar
		[20062] = true, -- Grand Astromancer Capernian
		[20063] = true, -- Master Engineer Telonicus
		[21270] = true, -- Cosmic Infuser
		[21269] = true, -- Devastation
		[21271] = true, -- Infinity Blades
		[21268] = true, -- Netherstrand Longbow
		[21273] = true, -- Phaseshift Bulwark
		[21274] = true, -- Staff of Disintegration
		[21272] = true, -- Warp Slicer
		-- Caverns of Time: Battle for Mount Hyjal
		[17767] = true, -- Rage Winterchill
		[17808] = true, -- Anetheron
		[17888] = true, -- Kaz'rogal
		[17842] = true, -- Azgalor
		[17968] = true, -- Archimonde
		-- Black Temple
		[22887] = true, -- High Warlord Naj'entus
		[22898] = true, -- Supremus
		[22841] = true, -- Shade of Akama
		[22871] = true, -- Teron Gorefiend
		[22948] = true, -- Gurtogg Bloodboil
		[23420] = true, -- Essence of Anger
		[23419] = true, -- Essence of Desire
		[23418] = true, -- Essence of Suffering
		[22947] = true, -- Mother Shahraz
		[23426] = true, -- Illidari Council
		[22917] = true, -- Illidan Stormrage -- Not adding solo quest IDs for now
		[22949] = true, -- Gathios the Shatterer
		[22950] = true, -- High Nethermancer Zerevor
		[22951] = true, -- Lady Malande
		[22952] = true, -- Veras Darkshadow
		-- Sunwell Plateau
		[24891] = true, -- Kalecgos
		[25319] = true, -- Kalecgos
		[24850] = true, -- Kalecgos
		[24882] = true, -- Brutallus
		[25038] = true, -- Felmyst
		[25165] = true, -- Lady Sacrolash
		[25166] = true, -- Grand Warlock Alythess
		[25741] = true, -- M'uru
		[25315] = true, -- Kil'jaeden
		[25840] = true, -- Entropius
		[24892] = true, -- Sathrovarr the Corruptor
		-- Utgarde Keep: Main Bosses
		[23953] = true, -- Prince Keleseth (Utgarde Keep)
		[27390] = true, -- Skarvald the Constructor
		[24200] = true, -- Skarvald the Constructor
		[23954] = true, -- Ingvar the Plunderer
		[23980] = true, -- Ingvar the Plunderer
		-- Utgarde Keep: Secondary Bosses
		[27389] = true, -- Dalronn the Controller
		[24201] = true, -- Dalronn the Controller
		-- The Nexus
		[26798] = true, -- Commander Kolurg (Heroic)
		[26796] = true, -- Commander Stoutbeard (Heroic)
		[26731] = true, -- Grand Magus Telestra
		[26832] = true, -- Grand Magus Telestra
		[26928] = true, -- Grand Magus Telestra
		[26929] = true, -- Grand Magus Telestra
		[26930] = true, -- Grand Magus Telestra
		[26763] = true, -- Anomalus
		[26794] = true, -- Ormorok the Tree-Shaper
		[26723] = true, -- Keristrasza
		-- Azjol-Nerub
		[28684] = true, -- Krik'thir the Gatewatcher
		[28921] = true, -- Hadronox
		[29120] = true, -- Anub'arak
		-- Ahn'kahet: The Old Kingdom
		[29309] = true, -- Elder Nadox
		[29308] = true, -- Prince Taldaram (Ahn'kahet: The Old Kingdom)
		[29310] = true, -- Jedoga Shadowseeker
		[29311] = true, -- Herald Volazj
		[30258] = true, -- Amanitar (Heroic)
		-- Drak'Tharon Keep
		[26630] = true, -- Trollgore
		[26631] = true, -- Novos the Summoner
		[27483] = true, -- King Dred
		[26632] = true, -- The Prophet Tharon'ja
		[27696] = true, -- The Prophet Tharon'ja
		-- The Violet Hold
		[29315] = true, -- Erekem
		[29313] = true, -- Ichoron
		[29312] = true, -- Lavanthor
		[29316] = true, -- Moragg
		[29266] = true, -- Xevozz
		[29314] = true, -- Zuramat the Obliterator
		[31134] = true, -- Cyanigosa
		-- Gundrak
		[29304] = true, -- Slad'ran
		[29305] = true, -- Moorabi
		[29307] = true, -- Drakkari Colossus
		[29306] = true, -- Gal'darah
		[29932] = true, -- Eck the Ferocious (Heroic)
		-- Halls of Stone
		[27977] = true, -- Krystallus
		[27975] = true, -- Maiden of Grief
		[28234] = true, -- The Tribunal of Ages
		[27978] = true, -- Sjonnir The Ironshaper
		-- Halls of Lightning
		[28586] = true, -- General Bjarngrim
		[28587] = true, -- Volkhan
		[28546] = true, -- Ionar
		[28923] = true, -- Loken
		-- The Oculus
		[27654] = true, -- Drakos the Interrogator
		[27447] = true, -- Varos Cloudstrider
		[27655] = true, -- Mage-Lord Urom
		[27656] = true, -- Ley-Guardian Eregos
		-- Caverns of Time: Culling of Stratholme
		[26529] = true, -- Meathook
		[26530] = true, -- Salramm the Fleshcrafter
		[26532] = true, -- Chrono-Lord Epoch
		[32273] = true, -- Infinite Corruptor
		[26533] = true, -- Mal'Ganis
		[29620] = true, -- Mal'Ganis
		-- Utgarde Pinnacle
		[26668] = true, -- Svala Sorrowgrave
		[26687] = true, -- Gortok Palehoof
		[26693] = true, -- Skadi the Ruthless
		[26861] = true, -- King Ymiron
		-- Trial of the Champion: Alliance
		[35617] = true, -- Deathstalker Visceri <Grand Champion of Undercity>
		[35569] = true, -- Eressea Dawnsinger <Grand Champion of Silvermoon>
		[35572] = true, -- Mokra the Skullcrusher <Grand Champion of Orgrimmar>
		[35571] = true, -- Runok Wildmane <Grand Champion of the Thunder Bluff>
		[35570] = true, -- Zul'tore <Grand Champion of Sen'jin>
		-- Trial of the Champion: Horde
		[34702] = true, -- Ambrose Boltspark <Grand Champion of Gnomeregan>
		[34701] = true, -- Colosos <Grand Champion of the Exodar>
		[34705] = true, -- Marshal Jacob Alerius <Grand Champion of Stormwind>
		[34657] = true, -- Jaelyne Evensong <Grand Champion of Darnassus>
		[34703] = true, -- Lana Stouthammer <Grand Champion of Ironforge>
		-- Trial of the Champion: Neutral
		[34928] = true, -- Argent Confessor Paletress
		[35119] = true, -- Eadric the Pure
		[35451] = true, -- The Black Knight
		-- Forge of Souls
		[36497] = true, -- Bronjahm
		[36502] = true, -- Devourer of Souls
		-- Pit of Saron
		[36494] = true, -- Forgemaster Garfrost
		[36477] = true, -- Krick
		[36476] = true, -- Ick <Krick's Minion>
		[36658] = true, -- Scourgelord Tyrannus
		-- Halls of Reflection
		[38112] = true, -- Falric
		[38113] = true, -- Marwyn
		[37226] = true, -- The Lich King
		[38113] = true, -- Marvyn
		-- Obsidian Sanctum
		[30451] = true, -- Shadron
		[30452] = true, -- Tenebron
		[30449] = true, -- Vesperon
		[28860] = true, -- Sartharion
		-- Vault of Archavon
		[31125] = true, -- Archavon the Stone Watcher
		[33993] = true, -- Emalon the Storm Watcher
		[35013] = true, -- Koralon the Flamewatcher
		[38433] = true, --Toravon the Ice Watcher
		-- The Eye of Eternity
		[28859] = true, -- Malygos
		-- Ulduar: The Siege of Ulduar
		[33113] = true, -- Flame Leviathan
		[33118] = true, -- Ignis the Furnace Master
		[33186] = true, -- Razorscale
		[33293] = true, -- XT-002 Deconstructor
		[33670] = true, -- Aerial Command Unit
		[33329] = true, -- Heart of the Deconstructor
		[33651] = true, -- VX-001
		-- Ulduar: The Antechamber of Ulduar
		[32867] = true, -- Steelbreaker
		[32927] = true, -- Runemaster Molgeim
		[32857] = true, -- Stormcaller Brundir
		[32930] = true, -- Kologarn
		[33515] = true, -- Auriaya
		[34035] = true, -- Feral Defender
		[32933] = true, -- Left Arm
		[32934] = true, -- Right Arm
		[33524] = true, -- Saronite Animus
		-- Ulduar: The Keepers of Ulduar
		[33350] = true, -- Mimiron
		[32906] = true, -- Freya
		[32865] = true, -- Thorim
		[32845] = true, -- Hodir
		-- Ulduar: The Descent into Madness
		[33271] = true, -- General Vezax
		[33890] = true, -- Brain of Yogg-Saron
		[33136] = true, -- Guardian of Yogg-Saron
		[33288] = true, -- Yogg-Saron
		[32915] = true, -- Elder Brightleaf
		[32913] = true, -- Elder Ironbranch
		[32914] = true, -- Elder Stonebark
		[32882] = true, -- Jormungar Behemoth
		[33432] = true, -- Leviathan Mk II
		[34014] = true, -- Sanctum Sentry
		-- Ulduar: The Celestial Planetarium
		[32871] = true, -- Algalon the Observer
		-- Trial of the Crusader
		[34796] = true, -- Gormok
		[35144] = true, -- Acidmaw
		[34799] = true, -- Dreadscale
		[34797] = true, -- Icehowl
		[34780] = true, -- Jaraxxus
		[34461] = true, -- Tyrius Duskblade <Death Knight>
		[34460] = true, -- Kavina Grovesong <Druid>
		[34469] = true, -- Melador Valestrider <Druid>
		[34467] = true, -- Alyssia Moonstalker <Hunter>
		[34468] = true, -- Noozle Whizzlestick <Mage>
		[34465] = true, -- Velanaa <Paladin>
		[34471] = true, -- Baelnor Lightbearer <Paladin>
		[34466] = true, -- Anthar Forgemender <Priest>
		[34473] = true, -- Brienna Nightfell <Priest>
		[34472] = true, -- Irieth Shadowstep <Rogue>
		[34470] = true, -- Saamul <Shaman>
		[34463] = true, -- Shaabad <Shaman>
		[34474] = true, -- Serissa Grimdabbler <Warlock>
		[34475] = true, -- Shocuul <Warrior>
		[34458] = true, -- Gorgrim Shadowcleave <Death Knight>
		[34451] = true, -- Birana Stormhoof <Druid>
		[34459] = true, -- Erin Misthoof <Druid>
		[34448] = true, -- Ruj'kah <Hunter>
		[34449] = true, -- Ginselle Blightslinger <Mage>
		[34445] = true, -- Liandra Suncaller <Paladin>
		[34456] = true, -- Malithas Brightblade <Paladin>
		[34447] = true, -- Caiphus the Stern <Priest>
		[34441] = true, -- Vivienne Blackwhisper <Priest>
		[34454] = true, -- Maz'dinah <Rogue>
		[34444] = true, -- Thrakgar	<Shaman>
		[34455] = true, -- Broln Stouthorn <Shaman>
		[34450] = true, -- Harkzog <Warlock>
		[34453] = true, -- Narrhok Steelbreaker <Warrior>
		[35610] = true, -- Cat <Ruj'kah's Pet / Alyssia Moonstalker's Pet>
		[35465] = true, -- Zhaagrym <Harkzog's Minion / Serissa Grimdabbler's Minion>
		[34497] = true, -- Fjola Lightbane
		[34496] = true, -- Eydis Darkbane
		[34564] = true, -- Anub'arak (Trial of the Crusader)
		-- Icecrown Citadel
		[36612] = true, -- Lord Marrowgar
		[36855] = true, -- Lady Deathwhisper
		-- Gunship Battle
		[37813] = true, -- Deathbringer Saurfang
		[36626] = true, -- Festergut
		[36627] = true, -- Rotface
		[36678] = true, -- Professor Putricide
		[37972] = true, -- Prince Keleseth (Icecrown Citadel)
		[37970] = true, -- Prince Valanar
		[37973] = true, -- Prince Taldaram (Icecrown Citadel)
		[37955] = true, -- Queen Lana'thel
		[36789] = true, -- Valithria Dreamwalker
		[37950] = true, -- Valithria Dreamwalker (Phased)
		-- [37868] = true, -- Risen Archmage, Valitrhia Add
		-- [36791] = true, -- Blazing Skeleton, Valithria Add
		-- [37934] = true, -- Blistering Zombie, Valithria Add
		-- [37886] = true, -- Gluttonous Abomination, Valithria Add
		-- [37985] = true, -- Dream Cloud , Valithria "Add"
		[36853] = true, -- Sindragosa
		[36597] = true, -- The Lich King (Icecrown Citadel)
		-- [37217] = true, -- Precious
		-- [37025] = true, -- Stinki
		[36661] = true, -- Rimefang <Drake of Tyrannus>
		--Ruby Sanctum (PTR 3.3.5)
		[39746] = true, --Zarithrian
		[39747] = true, --Saviana
		[39751] = true, --Baltharus
		[39863] = true, -- Halion
		[39899] = true, -- Baltharus (Copy has an own id apparently)
		[40142] = true, -- Halion (twilight realm)
		-- World Dragons
		[14889] = true, -- Emeriss
		[14888] = true, -- Lethon
		[14890] = true, -- Taerar
		[14887] = true, -- Ysondre
		-- Azshara
		[14464] = true, -- Avalanchion
		[6109] = true, -- Azuregos
		-- Un'Goro Crater
		[14461] = true, -- Baron Charr
		-- Silithus
		[15205] = true, -- Baron Kazum <Abyssal High Council>
		[15204] = true, -- High Marshal Whirlaxis <Abyssal High Council>
		[15305] = true, -- Lord Skwol <Abyssal High Council>
		[15203] = true, -- Prince Skaldrenox <Abyssal High Council>
		[14454] = true, -- The Windreaver
		-- Searing Gorge
		[9026] = true, -- Overmaster Pyron
		-- Winterspring
		[14457] = true, -- Princess Tempestria
		-- Hellfire Peninsula
		[18728] = true, -- Doom Lord Kazzak
		[12397] = true, -- Lord Kazzak
		-- Shadowmoon Valley
		[17711] = true, -- Doomwalker
		-- Nagrand
		[18398] = true, -- Brokentoe
		[18069] = true, -- Mogor <Hero of the Warmaul>, friendly
		[18399] = true, -- Murkblood Twin
		[18400] = true, -- Rokdar the Sundered Lord
		[18401] = true, -- Skra'gath
		[18402] = true, -- Warmaul Champion
		-- Cataclysm Dungeons --
		-- Abyssal Maw: Throne of the Tides
		[40586] = true, -- Lady Naz'jar
		[40765] = true, -- Commander Ulthok
		[40825] = true, -- Erunak Stonespeaker
		[40788] = true, -- Mindbender Ghur'sha
		[42172] = true, -- Ozumat
		-- Blackrock Caverns
		[39665] = true, -- Rom'ogg Bonecrusher
		[39679] = true, -- Corla, Herald of Twilight
		[39698] = true, -- Karsh Steelbender
		[39700] = true, -- Beauty
		[39705] = true, -- Ascendant Lord Obsidius
		-- The Stonecore
		[43438] = true, -- Corborus
		[43214] = true, -- Slabhide
		[42188] = true, -- Ozruk
		[42333] = true, -- High Priestess Azil
		-- The Vortex Pinnacle
		[43878] = true, -- Grand Vizier Ertan
		[43873] = true, -- Altairus
		[43875] = true, -- Asaad
		-- Grim Batol
		[39625] = true, -- General Umbriss
		[40177] = true, -- Forgemaster Throngus
		[40319] = true, -- Drahga Shadowburner
		[40484] = true, -- Erudax
		-- Halls of Origination
		[39425] = true, -- Temple Guardian Anhuur
		[39428] = true, -- Earthrager Ptah
		[39788] = true, -- Anraphet
		[39587] = true, -- Isiset
		[39731] = true, -- Ammunae
		[39732] = true, -- Setesh
		[39378] = true, -- Rajh
		-- Lost City of the Tol'vir
		[44577] = true, -- General Husam
		[43612] = true, -- High Prophet Barim
		[43614] = true, -- Lockmaw
		[49045] = true, -- Augh
		[44819] = true, -- Siamat
		-- Zul'Aman
		[23574] = true, -- Akil'zon
		[23576] = true, -- Nalorakk
		[23578] = true, -- Jan'alai
		[23577] = true, -- Halazzi
		[24239] = true, -- Hex Lord Malacrass
		[23863] = true, -- Daakara
		-- Zul'Gurub
		[52155] = true, -- High Priest Venoxis
		[52151] = true, -- Bloodlord Mandokir
		[52271] = true, -- Edge of Madness
		[52059] = true, -- High Priestess Kilnara
		[52053] = true, -- Zanzil
		[52148] = true, -- Jin'do the Godbreaker
		-- End Time
		[54431] = true, -- Echo of Baine
		[54445] = true, -- Echo of Jaina
		[54123] = true, -- Echo of Sylvanas
		[54544] = true, -- Echo of Tyrande
		[54432] = true, -- Murozond
		-- Hour of Twilight
		[54590] = true, -- Arcurion
		[54968] = true, -- Asira Dawnslayer
		[54938] = true, -- Archbishop Benedictus
		-- Well of Eternity
		[55085] = true, -- Peroth'arn
		[54853] = true, -- Queen Azshara
		[54969] = true, -- Mannoroth
		[55419] = true, -- Captain Varo'then
		-- Mists of Pandaria Dungeons --
		-- Scarlet Halls
		[59303] = true, -- Houndmaster Braun
		[58632] = true, -- Armsmaster Harlan
		[59150] = true, -- Flameweaver Koegler
		-- Scarlet Monastery
		[59789] = true, -- Thalnos the Soulrender
		[59223] = true, -- Brother Korloff
		[3977] = true, -- High Inquisitor Whitemane
		[60040] = true, -- Commander Durand
		-- Scholomance
		[58633] = true, -- Instructor Chillheart
		[59184] = true, -- Jandice Barov
		[59153] = true, -- Rattlegore
		[58722] = true, -- Lilian Voss
		[58791] = true, -- Lilian's Soul
		[59080] = true, -- Darkmaster Gandling
		-- Stormstout Brewery
		[56637] = true, -- Ook-Ook
		[56717] = true, -- Hoptallus
		[59479] = true, -- Yan-Zhu the Uncasked
		-- Tempe of the Jade Serpent
		[56448] = true, -- Wise Mari
		[56843] = true, -- Lorewalker Stonestep
		[59051] = true, -- Strife
		[59726] = true, -- Peril
		[58826] = true, -- Zao Sunseeker
		[56732] = true, -- Liu Flameheart
		[56762] = true, -- Yu'lon
		[56439] = true, -- Sha of Doubt
		-- Mogu'shan Palace
		[61444] = true, -- Ming the Cunning
		[61442] = true, -- Kuai the Brute
		[61445] = true, -- Haiyan the Unstoppable
		[61243] = true, -- Gekkan
		[61398] = true, -- Xin the Weaponmaster
		-- Shado-Pan Monastery
		[56747] = true, -- Gu Cloudstrike
		[56541] = true, -- Master Snowdrift
		[56719] = true, -- Sha of Violence
		[56884] = true, -- Taran Zhu
		-- Gate of the Setting Sun
		[56906] = true, -- Saboteur Kip'tilak
		[56589] = true, -- Striker Ga'dok
		[56636] = true, -- Commander Ri'mok
		[56877] = true, -- Raigonn
		-- Siege of Niuzao Temple
		[61567] = true, -- Vizier Jin'bak
		[61634] = true, -- Commander Vo'jak
		[61485] = true, -- General Pa'valak
		[62205] = true, -- Wing Leader Ner'onok
		-- Pandaria Raid Adds --
		[63346] = true, -- Tsulong: The Dark of Night
		[62969] = true, -- Tsulong: Embodied Terror
		[62977] = true, -- Tsulong: Frightspawn
		[62919] = true, -- Tsulong: Unstable Sha
		[61034] = true, -- Sha of Fear: Terror Spawn
		[61003] = true -- Sha of Fear: Dread Spawn
	},
	cantheal = {
		[30843] = "Enfeeble",
		[41292] = "Aura of Suffering",
		[45996] = "Darkness",
		[55593] = "Necrotic Aura"
	},
	notneedheal = {
		[8326] = "Ghost",
		[27827] = "Spirit of Redemption"
	},
	classes = {
		deathknight = {},
		druid = {
			dispel = {"Curse", "Poison"}
		},
		hunter = {},
		mage = {
			dispel = {"Curse"}
		},
		monk = {
			dispel = {"Magic", "Poison", "Disease"}
		},
		paladin = {
			dispel = {"Poison", "Disease", "Magic"}
		},
		priest = {
			dispel = {"Magic", "Disease"}
		},
		rogue = {},
		shaman = {
			dispel = {"Disease", "Poison", "Curse"}
		},
		warlock = {
			dispel = {"Magic"}
		},		
		warrior = {}
	},
	dr = {
		types = {
			["Banish"] = "Banish",
			["Charge"] = "Charge",
			["Cheap Shot"] = "Cheap Shot",
			["Controlled stuns"] = "Controlled stuns",
			["Cyclone"] = "Cyclone",
			["Disarms"] = "Disarms",
			["Disorients"] = "Disorients",
			["Entrapment"] = "Entrapment",
			["Fears"] = "Fears",
			["Horrors"] = "Horrors",
			["Mind Control"] = "Mind Control",
			["Random roots"] = "Random roots",
			["Random stuns"] = "Random stuns",
			["Controlled roots"] = "Controlled roots",
			["Scatter Shot"] = "Scatter Shot",
			["Silences"] = "Silences",
			["Hibernate"] = "Hibernate",
			["Taunts"] = "Taunts"
		},
		refs = {
			["banish"] = "Banish",
			["charge"] = "Charge",
			["cheapshot"] = "Cheap Shot",
			["ctrlstun"] = "Controlled stuns",
			["cyclone"] = "Cyclone",
			["disarm"] = "Disarms",
			["disorient"] = "Disorients",
			["entrapment"] = "Entrapment",
			["fear"] = "Fears",
			["horror"] = "Horrors",
			["mc"] = "Mind Control",
			["rndroot"] = "Random roots",
			["rndstun"] = "Random stuns",
			["ctrlroot"] = "Controlled roots",
			["scatters"] = "Scatter Shot",
			["silence"] = "Silences",
			["sleep"] = "Hibernate",
			["taunt"] = "Taunts"
		},
		pve = {
			["ctrlstun"] = true,
			["rndstun"] = true,
			["taunt"] = true,
			["cyclone"] = true
		},
		spells = {
			--[[ TAUNT ]] --
			-- Taunt (Warrior)
			[355] = "taunt",
			-- Taunt (Pet)
			[53477] = "taunt",
			-- Mocking Blow
			[694] = "taunt",
			-- Growl (Druid)
			[6795] = "taunt",
			-- Dark Command
			[56222] = "taunt",
			-- Hand of Reckoning
			[62124] = "taunt",
			-- Righteous Defense
			[31790] = "taunt",
			-- Distracting Shot
			[20736] = "taunt",
			-- Challenging Shout
			[1161] = "taunt",
			-- Challenging Roar
			[5209] = "taunt",
			-- Death Grip
			[49560] = "taunt",
			-- Challenging Howl
			[59671] = "taunt",
			-- Angered Earth
			[36213] = "taunt", -- Dragon's Breath
			--
			--[[ DISORIENTS ]] [31661] = "disorient",
			[33041] = "disorient",
			[33042] = "disorient",
			[33043] = "disorient",
			[42949] = "disorient",
			[42950] = "disorient",
			-- Hungering Cold
			[49203] = "disorient",
			-- Sap
			[6770] = "disorient",
			[2070] = "disorient",
			[11297] = "disorient",
			[51724] = "disorient",
			-- Gouge
			[1776] = "disorient",
			-- Hex (Guessing)
			[51514] = "disorient",
			-- Shackle
			[9484] = "disorient",
			[9485] = "disorient",
			[10955] = "disorient",
			[76780] = "disorient",
			-- Polymorph
			[118] = "disorient",
			[12824] = "disorient",
			[12825] = "disorient",
			[28272] = "disorient",
			[28271] = "disorient",
			[12826] = "disorient",
			[61305] = "disorient",
			[61025] = "disorient",
			[61721] = "disorient",
			[61780] = "disorient",
			-- Freezing Trap
			[3355] = "disorient",
			[14308] = "disorient",
			[14309] = "disorient",
			-- Freezing Arrow
			[60210] = "disorient",
			-- Wyvern Sting
			[19386] = "disorient",
			[24132] = "disorient",
			[24133] = "disorient",
			[27068] = "disorient",
			[49011] = "disorient",
			[49012] = "disorient",
			-- Repentance
			[20066] = "disorient", -- Nether Shock
			--
			--[[ SILENCES ]] [53588] = "silence",
			[53589] = "silence",
			-- Garrote
			[1330] = "silence",
			-- Arcane Torrent (Energy version)
			[25046] = "silence",
			-- Arcane Torrent (Mana version)
			[28730] = "silence",
			-- Arcane Torrent (Runic power version)
			[50613] = "silence",
			-- Silence
			[15487] = "silence",
			-- Silencing Shot
			[34490] = "silence",
			-- Improved Kick
			[18425] = "silence",
			-- Improved Counterspell
			[18469] = "silence",
			-- Spell Lock
			[19244] = "silence",
			[19647] = "silence",
			-- Shield of the Templar
			[63529] = "silence",
			-- Strangulate
			[47476] = "silence",
			[49913] = "silence",
			[49914] = "silence",
			[49915] = "silence",
			[49916] = "silence",
			-- Gag Order (Warrior talent)
			[18498] = "silence", -- Snatch
			--
			--[[ DISARMS ]] [53542] = "disarm",
			[53543] = "disarm",
			-- Dismantle
			[51722] = "disarm",
			-- Disarm
			[676] = "disarm",
			-- Chimera Shot - Scorpid
			[53359] = "disarm",
			-- Psychic Horror (Disarm effect)
			[64058] = "disarm", -- Blind
			--
			--[[ FEARS ]] [2094] = "fear",
			-- Fear (Warlock)
			[5782] = "fear",
			[6213] = "fear",
			[6215] = "fear",
			-- Seduction (Pet)
			[6358] = "fear",
			-- Howl of Terror
			[5484] = "fear",
			[17928] = "fear",
			-- Psychic scream
			[8122] = "fear",
			[8124] = "fear",
			[10888] = "fear",
			[10890] = "fear",
			-- Scare Beast
			[1513] = "fear",
			[14326] = "fear",
			[14327] = "fear",
			-- Turn Evil
			[10326] = "fear",
			-- Intimidating Shout
			[5246] = "fear", -- Intercept (Felguard)
			--
			--[[ CONTROL STUNS ]] [30153] = "ctrlstun",
			[30195] = "ctrlstun",
			[30197] = "ctrlstun",
			[47995] = "ctrlstun",
			-- Ravage
			[50518] = "ctrlstun",
			[53558] = "ctrlstun",
			[53559] = "ctrlstun",
			[53560] = "ctrlstun",
			[53561] = "ctrlstun",
			[53562] = "ctrlstun",
			-- Sonic Blast
			[50519] = "ctrlstun",
			[53564] = "ctrlstun",
			[53565] = "ctrlstun",
			[53566] = "ctrlstun",
			[53567] = "ctrlstun",
			[53568] = "ctrlstun",
			-- Concussion Blow
			[12809] = "ctrlstun",
			-- Shockwave
			[46968] = "ctrlstun",
			-- Hammer of Justice
			[853] = "ctrlstun",
			[5588] = "ctrlstun",
			[5589] = "ctrlstun",
			[10308] = "ctrlstun",
			-- Bash
			[5211] = "ctrlstun",
			[6798] = "ctrlstun",
			[8983] = "ctrlstun",
			-- Intimidation
			[19577] = "ctrlstun",
			-- Maim
			[22570] = "ctrlstun",
			[49802] = "ctrlstun",
			-- Kidney Shot
			[408] = "ctrlstun",
			[8643] = "ctrlstun",
			-- War Stomp
			[20549] = "ctrlstun",
			-- Intercept
			[20252] = "ctrlstun",
			-- Deep Freeze
			[44572] = "ctrlstun",
			-- Shadowfury
			[30283] = "ctrlstun",
			[30413] = "ctrlstun",
			[30414] = "ctrlstun",
			-- Holy Wrath
			[2812] = "ctrlstun",
			-- Inferno Effect
			[22703] = "ctrlstun",
			-- Demon Charge
			[60995] = "ctrlstun",
			-- Gnaw (Ghoul)
			[47481] = "ctrlstun", -- Impact
			--
			--[[ RANDOM STUNS ]] [12355] = "rndstun",
			-- Stoneclaw Stun
			[39796] = "rndstun",
			-- Seal of Justice
			[20170] = "rndstun",
			-- Revenge Stun
			[12798] = "rndstun", -- Cyclone
			--
			--[[ CYCLONE ]] [33786] = "cyclone", -- Freeze (Water Elemental)
			--
			--[[ ROOTS ]] [33395] = "ctrlroot",
			-- Pin (Crab)
			[50245] = "ctrlroot",
			[53544] = "ctrlroot",
			[53545] = "ctrlroot",
			[53546] = "ctrlroot",
			[53547] = "ctrlroot",
			[53548] = "ctrlroot",
			-- Frost Nova
			[122] = "ctrlroot",
			[865] = "ctrlroot",
			[6131] = "ctrlroot",
			[10230] = "ctrlroot",
			[27088] = "ctrlroot",
			[42917] = "ctrlroot",
			-- Entangling Roots
			[339] = "ctrlroot",
			[1062] = "ctrlroot",
			[5195] = "ctrlroot",
			[5196] = "ctrlroot",
			[9852] = "ctrlroot",
			[9853] = "ctrlroot",
			[26989] = "ctrlroot",
			[53308] = "ctrlroot",
			-- Nature's Grasp (Uses different spellIDs than Entangling Roots for the same spell)
			[19970] = "ctrlroot",
			[19971] = "ctrlroot",
			[19972] = "ctrlroot",
			[19973] = "ctrlroot",
			[19974] = "ctrlroot",
			[19975] = "ctrlroot",
			[27010] = "ctrlroot",
			[53313] = "ctrlroot",
			-- Earthgrab (Storm, Earth and Fire talent)
			[8377] = "ctrlroot",
			[31983] = "ctrlroot",
			-- Web (Spider)
			[4167] = "ctrlroot",
			-- Venom Web Spray (Silithid)
			[54706] = "ctrlroot",
			[55505] = "ctrlroot",
			[55506] = "ctrlroot",
			[55507] = "ctrlroot",
			[55508] = "ctrlroot",
			[55509] = "ctrlroot", -- Improved Hamstring
			--
			--[[ RANDOM ROOTS ]] [23694] = "rndroot",
			-- Frostbite
			[12494] = "rndroot",
			-- Shattered Barrier
			[55080] = "rndroot", -- Hibernate
			--
			--[[ SLEEPS ]] [2637] = "sleep",
			[18657] = "sleep",
			[18658] = "sleep", -- Death Coil
			--
			--[[ HORROR ]] [6789] = "horror",
			[17925] = "horror",
			[17926] = "horror",
			[27223] = "horror",
			[47859] = "horror",
			[47860] = "horror",
			-- Psychic Horror
			[64044] = "horror", -- Scatter Shot
			--
			--[[ MISC ]] [19503] = "scatters",
			-- Cheap Shot
			[1833] = "cheapshot",
			-- Pounce
			[9005] = "cheapshot",
			[9823] = "cheapshot",
			[9827] = "cheapshot",
			[27006] = "cheapshot",
			[49803] = "cheapshot",
			-- Charge
			[7922] = "charge",
			-- Mind Control
			[605] = "mc",
			-- Banish
			[710] = "banish",
			[18647] = "banish",
			-- Entrapment
			[64804] = "entrapment",
			[64804] = "entrapment",
			[19185] = "entrapment"
		}
	},
	dummies = {
		[30527] = "Training Dummy",
		[32541] = "Initiate's Training Dummy",
		[32545] = "Initiate's Training Dummy",
		[31146] = "Raider's Training Dummy",
		[17578] = "Hellfire Training Dummy",
		[32542] = "Disciple's Training Dummy",
		[32543] = "Veteran's Training Dummy",
		[32546] = "Ebon Knight's Training Dummy",
		[31144] = "Grandmaster's Training Dummy",
		[32667] = "Master's Training Dummy",
		[32666] = "Experts's Training Dummy",
		[31146] = "Heroic Training Dummy",
		[31143] = "Reinforced Training Dummy",
		[24792] = "Advanced Training Dummy",
		[67127] = "Training Dummy",
		[46647] = "Training Dummy",
		[47105] = "Training Dummy",
	},
	mismarkedbosses = {
		-- Magtheridon's Lair
		[17256] = true, -- Hellfire Channeler 
		[18829] = true, -- Hellfire Warder
		-- ICC
		[36948] = true,
		[36939] = true
	},
	stopcasting = {
		stop = {
			[62680] = "Flame Jets",
			[63472] = "Flame Jets",
			[175576] = "Flame Jets",
			[62932] = "Ground Tremor",
			[62859] = "Ground Tremor",
			[62437] = "Ground Tremor",
			[62325] = "Ground Tremor",
			[64228] = "Ground Tremor",
			["Ground Tremor"] = "Ground Tremor",
			["Flame Jets"] = "Flame Jets",
			[42708] = "Staggering Roar",
			["Staggering Roar"] = "Staggering Roar",
			["Dreadful Roar"] = "Dreadful Roar",
			[71022] = "Disrupting Shout",
			["Disrupting Shout"] = "Disrupting Shout"
		},
		continue = {
			[31821] = "Aura Mastery"
		}
	},
	whitelistedlosunits = {
		[36897] = "Little Ooze",
		[38138] = "Little Ooze",
		[34797] = "Icehowl",
		[35447] = "Icehowl",
		[35448] = "Icehowl",
		[35449] = "Icehowl",
		[34799] = "Dreadscale",
		[35514] = "Dreadscale",
		[35515] = "Dreadscale",
		[35516] = "Dreadscale",
		[35144] = "Acidmaw",
		[35511] = "Acidmaw",
		[35512] = "Acidmaw",
		[35513] = "Acidmaw",
		[32934] = "Right Arm",
		[32933] = "Left Arm",
		[33329] = "Heart of the Deconstructor",
		[30245] = "Nexus Lord",
		[30249] = "Scion of Eternity",
		[33651] = "VX-001",
		[33432] = "Leviathan Mk II",
		[33670] = "Aerial Command Unit",
		[32955] = "Collapsing Star",
		[33142] = "Leviathan Defense Turret",
		[56754] = "Azure Serpent",
		[71407] = "Amber",
		[36980] = "Ice Tomb"
	},
	blacklisttauntunits = {
	
	},	
}
return tables;