#ifndef DEFINED
#define DEFINED			1										

/******Adjustments And Settings******/
#define DRAWMOD			1										//Draw scaling modes: 0 = SNK Style, 1 = Capcom style
#define TRAILMAX		20										//Global shadow trail limit.
#define TRAILCNT		5										//Character shadow trail limit.
#define TRAILDLY		5										//Delay (to spawn next trailer, so trailer lasts for TRAILCNT*TRAILDLY)

/******Animations (custom)******/
#define BLOCKNOR		openborconstant("ANI_BLOCKPAIN")		//Default guard.
#define BLOCKMID		openborconstant("ANI_BLOCKPAIN2")		//Middle guard.
#define BLOCKLOW		openborconstant("ANI_BLOCKPAIN3")		//Low guard.
#define BLOCKHIGH		openborconstant("ANI_BLOCKPAIN4")		//High guard.
#define COLLAPSE		openborconstant("ANI_FALL4")			//Collapse
#define SWEPT			openborconstant("ANI_FALL3")			//Foot sweep.
#define TOSS			openborconstant("ANI_FALL5")			//Thrown.
#define SPLAT			openborconstant("ANI_FALL8")			//Thrown hard onto head.
#define EIMPS			openborconstant("ANI_FOLLOW1")			//Impact effect: Small.
#define EIMPM			openborconstant("ANI_FOLLOW2")			//Impact effect: Medium.
#define EIMPL			openborconstant("ANI_FOLLOW3")			//Impact effect: Large.
#define ESPLA			openborconstant("ANI_FOLLOW4")			//Impact effect: Splash.
//50 to 70: Calamity poses.
#define DIZZY			openborconstant("ANI_FOLLOW50")			//Dizzy.
#define DEFPOSE			openborconstant("ANI_FOLLOW51")			//Defensive grapple.
#define FFORE			openborconstant("ANI_FOLLOW52")			//Fatality: Fly into foreground.
#define FWATER			openborconstant("ANI_FOLLOW53")			//Fatality: Fall into background water.
//70 to 80: Taunt/victory poses.
#define AIRBLOCK		openborconstant("ANI_FOLLOW80")			//Air block.
#define AIRBACK			openborconstant("ANI_FOLLOW81")			//Air back attack.
#define ATKDOWN			openborconstant("ANI_FOLLOW82")			//Down attack.
#define DODATK			openborconstant("ANI_FOLLOW83")			//Dodge attack.     
#define DODATKU			openborconstant("ANI_FOLLOW84")			//Dodge up attack. 
#define DODATKD			openborconstant("ANI_FOLLOW85")			//Dodge down attack.
#define DODATKSD		openborconstant("ANI_FOLLOW86")			//Dodge attack step down.
#define DODATKSU		openborconstant("ANI_FOLLOW87")			//Dodge attack step down.
#define TEAM1			openborconstant("ANI_FOLLOW88")			//Team call pose.
#define AIRJ2AL			openborconstant("ANI_FOLLOW89")			//Alternate Jumpattack2 (when not moving).
#define AIRJ3AL			openborconstant("ANI_FOLLOW90")			//Alternate Jumpattack3 (when not moving). 
#define PARRY			openborconstant("ANI_FOLLOW91")			//Parry/Just defense animation.
#define APARRY			openborconstant("ANI_FOLLOW92")			//Air Parry/Just defense animation.
#define BREAK			20										//Guard or attack broken.
#define POWUP			openborconstant("ANI_FOLLOW94")			//Power up animation.

/******Animations (system default)******/
#define A_ATKDOWN		openborconstant("ANI_ATTACKDOWN")
#define A_ATKUP			openborconstant("ANI_ATTACKUP")
#define A_BURN			openborconstant("ANI_BURN")
#define A_BURNDIE		openborconstant("ANI_BURNDIE")
#define A_SHOCKDIE		openborconstant("ANI_SHOCKDIE")
#define A_DOWN			openborconstant("ANI_DOWN")
#define A_FALL			openborconstant("ANI_FALL")
#define A_FSPECIAL      openborconstant("ANI_FREESPECIAL")
#define A_FSPECIAL2     openborconstant("ANI_FREESPECIAL2")
#define A_FSPECIAL3     openborconstant("ANI_FREESPECIAL3")
#define A_FSPECIAL4     openborconstant("ANI_FREESPECIAL4")
#define A_FSPECIAL5     openborconstant("ANI_FREESPECIAL5")
#define A_FSPECIAL6     openborconstant("ANI_FREESPECIAL6")
#define A_FSPECIAL7     openborconstant("ANI_FREESPECIAL7")
#define A_FSPECIAL8     openborconstant("ANI_FREESPECIAL8")
#define A_FSPECIAL9     openborconstant("ANI_FREESPECIAL9")
#define A_FSPECIAL10    openborconstant("ANI_FREESPECIAL10")
#define A_GRABATK2		openborconstant("ANI_GRABATTACK2")
#define A_IDLE			openborconstant("ANI_IDLE")
#define A_JUMP			openborconstant("ANI_JUMP")
#define A_JUMPATK       openborconstant("ANI_JUMPATTACK")
#define A_RESPAWN       openborconstant("ANI_RESPAWN")
#define A_RISE          openborconstant("ANI_RISE")
#define A_RISEATK		openborconstant("ANI_RISEATTACK")
#define A_RUN			openborconstant("ANI_RUN")
#define A_RUNJUMPATK    openborconstant("ANI_RUNJUMPATTACK")
#define A_SLEEP         openborconstant("ANI_SLEEP")
#define A_UP			openborconstant("ANI_UP")
#define A_WALK			openborconstant("ANI_WALK")

/******Animation Frames******/
#define HELD			0										//Grabbed.
#define HELDP			1										//Grabbed pain.
#define HORUP			2										//Horizontal up.
#define HORDN			3										//Horizontal down.
#define VERUP			4										//Vertical up.
#define VERDN			5										//Vertical Down.
#define TLTUP			6										//Tilt up.
#define TLTDN			7										//Tilt down.
#define VERDNP			8										//Vertical down pain.
#define DWNUP			9										//Laying down face up.
#define DWNUPP			10										//Laying down face up in pain.
#define FALUP			11										//Falling face up.
#define FALUPT			12										//Falling face up tilted.
#define HORUPP			13										//Horiztonal face up pain.
#define HELDMP			14										//Held middle pain.

/******Attack types******/
#define ATK_2			openborconstant("ATK_NORMAL2")
#define ATK_BURN		openborconstant("ATK_BURN")
#define ATK_SHOCK		openborconstant("ATK_SHOCK")

/*****Color Maps*****/
#define MAPKO			1										//KO.
#define MAPBURN			2										//Burn.
#define MAPSHOCK		3										//Shock.
#define MAPFREEZ		4										//Freeze.
#define MAPPOIS			5										//Poison.

/******Entity types******/
#define T_ENEMY         openborconstant("TYPE_ENEMY")
#define T_NPC           openborconstant("TYPE_NPC")
#define T_OBSTACLE      openborconstant("TYPE_OBSTACLE")
#define T_PLAYER        openborconstant("TYPE_PLAYER")

/******Indexedvar ID (Entity)******/
#define ENTID			0										//ID number given during spawn script.
#define VITNAME			1										//Full Name.
#define VITRACE			2										//Race (Human, Elf, Dwarf, etc.).
#define VITGEND			3										//Gender (0 Male, 1 female)
#define VITHEIG			4										//Height (cm).
#define VITWEIG			5										//Weight (kg).
#define VITDOB			6										//Date of birth.
#define VITAGE			7										//Age.
#define VITPOB			8										//Place of birth.
#define VITALIG			9										//Alignment.
#define VITSTR			10										//Strength.
#define VITDEX			11										//Dexterity.
#define VITCON			12										//Constitution.
#define VITINT			13										//Intellegence.
#define VITWIS			14										//Wisdom.
#define VITCHR			15										//Charisma.
#define VITCLAS			16										//Class (Barbarian, Cleric, Fighter, etc.).
#define VITEXP			17										//Experience total.
#define STUNV			18										//Stun value built up by incoming attacks.
#define STUNT			19										//Gametime threshold to reduce/remove stun value.
#define BIND			20										//Primary bind for grappling moves.
#define NEXTANI			21										//Animation to be activated in future by another event or script.
#define NEXTANI2		22										//Animation to be activated in future by another event or script.
#define NEXTANI3		23										//Animation to be activated in future by another event or script.
#define NEXTANI4		24										//Animation to be activated in future by another event or script.
#define NEXTANI5		25										//Animation to be activated in future by another event or script.
#define NEXTSPW			26										//Model to be spawned in future by another event or script.
#define NEXTSPA			27										//Alias of NEXTSPW.
#define NEXTSPM			28										//Map of NEXTSPW.
#define NEXTSPB			29										//Blend setting of NEXTSPW.
#define NEXTSPX			30										//X location (or adjustment) of NEXTSPW.
#define NEXTSPY			31										//Y location (or adjustment) of NEXTSPW.
#define NEXTSPZ			32										//Z location (or adjustment) of NEXTSPW.
#define NEXTSPD			33										//Direction setting of NEXTSPW.
#define NEXTSPF			34										//Animation flag for binding NEXTSPW.   
#define OGMAP			35										//Orginal map. This is the remap entity starts with so it may be restored later if needed.
#define SPAWN			36										//Entity var slot used to store new spawns.
#define ADSCALEX		37										//draw scale X adjustment.
#define ADSCALEY		38										//draw scale Y adjustment.
#define ADFLIPX			39										//draw flip X setting.
#define ADFLIPY			40										//draw flip Y setting.
#define ADSHIFTX		41										//draw shift X setting.
#define ADBLEND			42										//draw blend setting.
#define ADREMAP			43										//draw remap setting.
#define ADFILL			44										//draw fill setting.
#define ADROTATE		45										//draw static rotate setting.
#define ADAROTAT		46										//draw auto rotation setting.
#define ADSCALER		47										//draw, last scale ratio applied to sprite.
#define ADSKIP			48										//draw toggle flag.
#define SHFLAG			49										//Shadow toggle and mode flag.
#define SHMODEL			50										//Shadow trail model.
#define SHALIAS			51										//Shadow model alias.
#define SHDELAY			52										//Shadow, delay between individual shadow entity spawns.
#define SHETIME			53										//Shadow, elapsed game time next shadow trail entity will be spawned.
#define SHREMAP			54										//Shadow, remap applied to shadow trail.
#define SHBLEND			55										//Shadow, blend mode applied to shadow trail.
#define TOSSX			56										//X velocity for toss effect on attack.
#define TOSSY			57										//Y velocity for toss effect on attack.
#define TOSSZ			58										//Z velocity for toss effect on attack.
#define DTOSSX			59										//X velocity for toss effect.
#define DTOSSY			60										//Y velocity for toss effect.
#define DTOSSZ			61										//Z velocity for toss effect.
#define WARPX			62										//X location adjust for self to attacker when hit.
#define WARPY			63										//Y location adjust for self to attacker when hit.
#define WARPZ			64										//Z location adjust for self to attacker when hit.
#define WARPT			65										//Condition for location adjust self to attacker when hit (0/NULL Any hit, 1 Pain or fall, 2 Fall only).  
#define HITDMG			66										//Extra damage to apply to target during didhitscript.
#define HITFIN			67										//Extra damage lethal flag (1 damage cannot reduce HP to < 1).
#define HITTYP			68										//Extra damage attack type.
#define HITDRP			69										//Extra damage drop power.
#define HITNOR			70										//Extra damage no reset on hit flag.
#define HITWRX			71										//Extra damage X location force.
#define HITWRY			72										//Extra damage Y location force.
#define HITWRZ			73										//Extra damage Z location force.
#define HITWRT			74										//Extra damage location force condition (0 always, 1 pain/knockdown, 2 knockdown).
#define HITLVL			75										//Force hit level flag (0 Normal, 1 Middle, 2 Low, 3 High).
#define HITFLS			76										//Extra damage hitflash.
#define BINDHE			77										//Bound hit effect entity.
#define BINDE			78										//Bound special effect.
#define KEY1SP			79										//Last time special key was pressed.
#define KEY1AT			80										//Last time attack key was pressed.
#define STATUS			81										//Special states (power up, etc.).
#define BOUNDM			82										//Bind mode used on this entity.
#define BOUNDA			83										//Anchor entity this entity is bound to.
#define BOUNDI			84										//Index this entity is bound with.
#define BOUNDX			85										//X this entity is bound to.
#define BOUNDY			86										//Y this entity is bound to.
#define BOUNDZ			87										//Z this entity is bound to.
#define	BOUNDD			88										//Dir this entity is bound to.
#define	BOUNDF			89										//Frame entity is set to during grapple bind.
#define	MAXHP			90										//Maximum Health (to reset when damaged as workaround for weapon bug).
#define MAXMP			91										//Maximum MP (to reset when damaged as workaround for weapon bug).
#define AGGRO			92										//Aggression (to reset when damaged as workaround for weapon bug).

/******Indexedvar ID (Global)******/
#define ECOUNT			0										//Entity's spawned counter.
#define MINZADJ			1										//Minimum Z adjustment.
#define MAXZADJ			2										//Maximum Z adjustment.
#define MAXYADJ			3										//Maximum level height adjustment.
#define GPAUSE			4										//Global pause.
#define TNAMES			5										//Index for opening name text file.
#define INLVL			6										//In level?
#define ICOJAR			7										//Magic jar.
#define BLOCBLU			8										//Life block, blue.
#define BLOCYEL			9										//Life block, yellow.
#define BLOCORA			10										//Life block, orange.
#define BLOCRED			11										//Life block, red.
#define SNDLSTI			12										//Last sound played (by index).
#define SNDLSTT			13										//Time last sound was played.
#define SNDLSTE			14										//Entity last sound was played "on".
#define TMUSIC			15										//Index for opening music text file.
#define DEBUG			16										//Debug mode.
#define SCREEN			17										//Screen 1 handle.

/******Models******/
#define EFBURNF			"";										//Flash burn.
#define EFSHOCC			"";										//Consistent electric ("shocked").
#define EFSHOCF			"";										//Shock flash.
#define EFFATAL			"fata0001";								//Fatality.

/******Sounds******/
#define VOIATK			0										//Attack grunt, generic.
#define VOIBTL			1										//Battle cry (when knocking opponent down).
#define VOIDYN			2										//Low health.
#define VOIDIE			3										//KO.
#define VOIGO			4										//Attack command.
#define VOICNT			5										//Can't do that.
#define VOIHA			6										//Laugh.
#define VOIPN			7										//Getting hit, generic.
#define VOIAID			8										//Help call.
#define VOIBOR			9										//Bored.
#define VOICHN			10										//Spell chanting.
#define VOIHI			11										//Spawn greeting.
#define VOISPF			12										//Magic fail.
#define VOISPO			13										//Enemy spotted.
#define VOIBLO			14										//Incoming attack blocked.
#define VOIPIT			15										//Falling in pit.
#define VOIBRN			16										//Burned.
#define VOISHO			17										//Shocked.
#define VOIPOI			18										//Poison.
#define VOIFRE			19										//Freeze.
#define VOIBYE			20										//Bye.
#define VOIATF			21										//Attack fail.
#define VOITAU			22										//Taunt.
#define VOIYES			23										//Yes (good idea).
#define VOIVIC			24										//Victory.
#define VOIATKL			25										//Attack grunt, light.
#define VOIATKM			26										//Attack grunt, medium.
#define VOIATKH			27										//Attack grunt, heavy.
#define VOIATKS			28										//Attack grunt, max.
#define VOIPOWL			29										//Power up, light.
#define VOIPOWM			30										//Power up, meduium.
#define VOIPOWH			31										//Power up, heavy.
#define VOIPOWS			32										//Power up, max.
#define VOIS0			100										//Specific 0.
#define VOIS1			101										//Specific 1.
#define VOIS2			102										//Specific 2.
#define VOIS3			103										//Specific 3.
#define VOIS4			104										//Specific 4.
#define VOIS5			105										//Specific 5.
#define VOIS6			106										//Specific 6.
#define VOIS7			107										//Specific 7.
#define VOIS8			108										//Specific 8.
#define VOIS9			109										//Specific 9.
#define VOIS10			110										//Specific 10.
#define VOIS11			111										//Specific 11.
#define VOIS12			112										//Specific 12.
#define VOIS13			113										//Specific 13.
#define VOIS14			114										//Specific 14.
#define VOIS15			115										//Specific 15.
#define VOIS16			116										//Specific 16.
#define VOIS17			117										//Specific 17.
#define VOIS18			118										//Specific 18.
#define VOIS19			119										//Specific 19.
#define VOIS20			120										//Specific 20.
#define SNDWIFFL		200										//Whiff, Light.
#define SNDWIFFM		201										//Whiff, Medium.
#define SNDWIFFH		202										//Whiff, heavy.
#define SNDJUMPL		203										//Jump, light.
#define SNDJUMPM		204										//Jump, medium.
#define SNDJUMPH		205										//Jump, heavy.
#define SNDLANDL		206										//Land, light.
#define SNDLANDM		207										//Land, medium.
#define SNDLANDH		208										//Land, heavy.
#define SNDHITL			209										//Hit, light.
#define SNDHITM			210										//Hit, medium.
#define SNDHITH			211										//Hit, heavy.
#define SNDCUTL			212										//Hit w/edged weapon, light.
#define SNDCUTM			213										//Hit w/edged weapon, medium.
#define SNDCUTH			214										//Hit w/edged weapon, heavy.
#define SNDBLOIL		215										//Block Impact, light.
#define SNDBLOIM		216										//Block Impact, medium.
#define SNDBLOIH		217										//Block Impact, heavy.
#define SNDBLOCL		218										//Block cut, light.
#define SNDBLOCM		219										//Block cut, medium.
#define SNDBLOCH		220										//Block cut, heavy.
#define SNDIDIRL		221										//Indirect, light.
#define SNDIDIRM		222										//Indirect, medium.
#define SNDIDIRH		223										//Indirect, heavy.
#define SNDFALLL		224										//Fall land, light.
#define SNDFALLM		225										//Fall land, medium.
#define SNDFALLH		226										//Fall land, heavy.
#define SNDFALLML		227										//Fall land metalic, light.
#define SNDFALLMM		228										//Fall land metalic, medium.
#define SNDFALLMH		229										//Fall land metalic, heavy.
#define SNDIMPL			230										//Ground impact, light.
#define SNDIMPM			231										//Ground impact, medium.
#define SNDIMPH			232										//Ground impact, heavy.
#define SNDBITEL		233										//Bite, light.
#define SNDBITEM		234										//Bite, medium.
#define SNDBITEH		235										//Bite, heavy.
#define SNDHITBL		237										//Hit w/blunt weapon, light.
#define SNDHITBM		238										//Hit w/blunt weapon, medium.
#define SNDHITBH		239										//Hit w/blunt weapon, heavy.
#define SNDHITFIL		240										//Hit w/fire, light.
#define SNDHITFIM		241										//Hit w/fire, medium.
#define SNDHITFIH		242										//Hit w/fire, heavy.
#define SNDHITFRL		243										//Hit w/freeze, light.
#define SNDHITFRM		244										//Hit w/freeze, medium.
#define SNDHITFRH		245										//Hit w/freeze, heavy.
#define SNDHITACL		246										//Hit w/acid, light.
#define SNDHITACM		247										//Hit w/acid, medium.
#define SNDHITACH		248										//Hit w/acid, heavy.
#define SNDHITELL		249										//Hit w/elec, light.
#define SNDHITELM		250										//Hit w/elec, medium.
#define SNDHITELH		251										//Hit w/elec, heavy.
#define SNDHITBOL		252										//Hit w/bone break light.
#define SNDHITBOM		253										//Hit w/bone break medium.
#define SNDHITBOH		254										//Hit w/bone break heavy.
#define SNDHITWAL		255										//Hit/Fall w/water light.
#define SNDHITWAM		256										//Hit/Fall w/water medium.
#define SNDHITWAH		257										//Hit/Fall w/water heavy.
#define SNDPULLL		258										//Pull or stangle, light.
#define SNDPULLM		259										//Pull or stangle, medium.
#define SNDPULLH		260										//Pull or stangle, heavy.
#define SNDSCORL		261										//Score, small.
#define SNDSCORM		262										//Score, medium.
#define SNDSCORH		263										//Score, big.
#define SNDSLAML		264										//Body slam, light.
#define SNDSLAMM		265										//Body slam, medium.
#define SNDSLAMH		266										//Body slam, heavy.
#define SNDSLAMS		267										//Body slam, massive.
#define SNDSLAPL		268										//Bitch slap, light.
#define SNDSLAPM		269										//Bitch slap, medium.
#define SNDSLAPH		270										//Bitch slap, heavy.
#define SNDEFF0			1000									//GA red dragon, fireball.
#define SNDEFF1			1001									//GA red dragon, fireball hit.
#define SNDEFF2			1002									//GA blue dragon, fire breath.
#define SNDEFF3			1003									//GA blue dragon, fire stream.
#define SNDEFF4			1004									//Neo Geo Super start up.
#define SNDEFF5			1005									//Orginal BOR punch whiff.
#define SNDEFF6			1006									//Mortal Kombat Raiden warp.
#define SNDEFF7			1007									//KOF 99-2002 Andy Bogard, Hishoken.
#define SNDEFF8			1008									//KOF 99-2002 Andy Bogard, Geki Hishoken.
#define SNDEFF9			1009									//KOF 99-2002 Andy Bogard, Ku Ha Dan.		
#define SNDEFF10		1010									//KOF 99-2002 Andy Bogard, Dark Rain Kick.
#define SNDEFF11		1011									//KOF 99-2002 Andy Bogard, Cho Reppa Dan startup.
#define SNDEFF12		1012									//KOF 99-2002 Andy Bogard, Cho Reppa Dan.
#define SNDEFF13		1013									//KOF 99-2002 Andy Bogard, ??.
#define SNDEFF14		1014									//KOF 99-2002 Andy Bogard, ??.
#define SNDEFF15		1015									//Unkown high pitched power burst used for Andy Bogard Bakushin.
#define SNDEFF16		1016									//Unkown massive impact used for Andy Bogard Bakushin finish.
#define SNDEFF17		1017									//KOF "clasp/grab" sound.
#define SNDEFF18		1018									//Beats of Rage "Bike" sound.
#define SNDEFF19		1019									//Streets of Rage "gulp" sound.
#define SNDEFF20		1020									//Horse galloping repeat a few times and fade.
#define SNDEFF21		1021									//NGBC cursor move beep.
#define SNDEFF22		1022									//NGBC menu selection confirmed.
#define SNDEFF23		1023									//Word Hereos Perfect Hanzou/Fuuma slide dash.
#define SNDEFF24		1024									//Revenge Of Shinobi box break.
#define SNDEFF25		1025									//Lightning strike I (unknown source).
#define SNDEFF26		1026									//Liquid spray (unknown source).
#define SNDEFF27		1027									//NGBC super startup.
#define SNDEFF28		1028									//NGBC Hanzou/Fumma Rekkozan star.
#define SNDEFF29		1029									//Lightning strike II (unknown source).
#define SNDEFF30		1030									//Electrocution (unknown source).
#define SNDEFF31		1031									//NGBC hard whoosh.
#define SNDEFF32		1032									//Muffled low whiff (unknown source).
#define SNDEFF33		1033									//KOF series Ryo Sakazaki Zanrestuken whiffs.
#define SNDEFF34		1034									//KOF 99-2002 super startup.
#define SNDEFF35		1035									//Streets Of Rage metal clang.
#define SNDEFF36		1036									//Quick machine whir, like a drill or winch (unknown source).

/******System Constants******/
#define S_FRONTZ		openborconstant("FRONTPANEL_Z")

#endif
