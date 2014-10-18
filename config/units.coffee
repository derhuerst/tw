Resources =			require '../src/util/Resources'
Duration =			require '../src/util/Duration'
Speed =				require '../src/util/Speed'





module.exports =



	spearFighter:
		title:				'spear fighter'
		abbreviation:		'spr'
		offense:			10
		defenseGeneral:		15
		defenseCavalry:		45
		defenseArchers:		20
		speed:				new Speed new Duration '18m'
		haul: 				5
		resources:			new Resources
								wood: 50
								clay: 30
								iron: 10
		workers:			1
		duration:			new Duration '1s'
		researched:			true



	swordsman:
		title:				'swordsman'
		abbreviation:		'swd'
		offense:			25
		defenseGeneral:		50
		defenseCavalry:		15
		defenseArchers:		40
		speed:				new Speed new Duration '22m'
		haul: 				5
		resources:			new Resources
								wood: 30
								clay: 30
								iron: 70
		workers:			1
		duration:			new Duration '1s'
		researched:			true



	axeman:
		title:				'axeman'
		abbreviation:		'axe'
		offense:			40
		defenseGeneral:		10
		defenseCavalry:		5
		defenseArchers:		10
		speed:				new Speed new Duration '18m'
		haul: 				0
		resources:			new Resources
								wood: 60
								clay: 30
								iron: 40
		workers:			1
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 700
								clay: 840
								iron: 820
			duration:		new Duration '1s'
		researched:			false



	archer:
		title:				'archer'
		abbreviation:		'ach'
		offense:			15
		defenseGeneral:		50
		defenseCavalry:		40
		defenseArchers:		5
		speed:				new Speed new Duration '18m'
		haul: 				0
		resources:			new Resources
								wood: 100
								clay: 30
								iron: 60
		workers:			1
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 640
								clay: 560
								iron: 740
			duration:		new Duration '1s'
		researched:			false



	scout:
		title:				'scout'
		abbreviation:		'sct'
		offense:			0
		offenseScouts:		2
		defenseGeneral:		2
		defenseCavalry:		1
		defenseArchers:		2
		speed:				new Speed new Duration '9m'
		haul:				0
		resources:			new Resources
								wood: 50
								clay: 50
								iron: 20
		workers:			2
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 560
								clay: 480
								iron: 480
			duration:		new Duration '1s'
		researched:			false



	lightCavalry:
		title:				'light calvary'
		abbreviation:		'lcv'
		offense:			130
		defenseGeneral:		30
		defenseCavalry:		40
		defenseArchers:		30
		speed:				new Speed new Duration '10m'
		haul: 				0
		resources:			new Resources
								wood: 125
								clay: 100
								iron: 250
		workers:			4
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 2200
								clay: 2400
								iron: 2000
			duration:		new Duration '1s'
		researched:			false



	mountedArcher:
		title:				'mounted archer'
		abbreviation:		'mach'
		offense:			120
		defenseGeneral:		40
		defenseCavalry:		30
		defenseArchers:		50
		speed:				new Speed new Duration '10m'
		haul: 				0
		resources:			new Resources
								wood: 2250
								clay: 100
								iron: 150
		workers:			5
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 3000
								clay: 2400
								iron: 2000
			duration:		new Duration '1s'
		researched:			false



	heavyCavalry:
		title:				'heavy calvary'
		abbreviation:		'hcv'
		offense:			150
		defenseGeneral:		200
		defenseCavalry:		80
		defenseArchers:		180
		speed:				new Speed new Duration '11m'
		haul: 				0
		resources:			new Resources
								wood: 200
								clay: 150
								iron: 600
		workers:			6
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 3000
								clay: 2400
								iron: 2000
			duration:		new Duration '1s'
		researched:			false



	ram:
		title:				'ram'
		abbreviation:		'ram'
		offense:			2
		defenseGeneral:		20
		defenseCavalry:		50
		defenseArchers:		20
		speed:				new Speed new Duration '30m'
		haul:				0
		resources:			new Resources
								wood: 300
								clay: 200
								iron: 200
		workers:			5
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 1200
								clay: 1600
								iron: 800
			duration:		new Duration '1s'
		researched:			false
		speed: new Speed new Duration '1s'



	catapult:
		title:				'catapult'
		abbreviation:		'cat'
		offense:			100
		defenseGeneral:		100
		defenseCavalry:		50
		defenseArchers:		100
		speed:				new Speed new Duration '30m'
		haul:				0
		resources:			new Resources
								wood: 320
								clay: 400
								iron: 100
		workers:			8
		duration:			new Duration '1s'
		research:
			resources:		new Resources
								wood: 1600
								clay: 2000
								iron: 1200
			duration:		new Duration '1s'
		researched:			false



	paladin:
		title:				'paladin'
		abbreviation:		'pld'
		offense:			150
		defenseGeneral:		250
		defenseCavalry:		400
		defenseArchers:		150
		speed:				new Speed new Duration '10m'
		haul: 				100
		resources:			new Resources
								wood: 20
								clay: 20
								iron: 40
		workers:			10
		duration:			new Duration '1s'
		researched:			true



	nobleman:
		title:				'nobleman'
		abbreviation:		'nbm'
		offense:			30
		defenseGeneral:		100
		defenseCavalry:		50
		defenseArchers:		100
		speed:				new Speed new Duration '35m'
		haul:				0
		resources:			new Resources
								wood: 40000
								clay: 50000
								iron: 50000
		workers:			100
		duration:			new Duration '1s'
		researched:			true
