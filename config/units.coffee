require '../src/util/Resources'
require '../src/util/Duration'
container = require '../src/container'

module.exports = container.publish 'config.units', [
	'util.Resources', 'util.Duration'
], (Resources, Duration) ->





	return {

		spearFighter:
			title:				'spear fighter'
			abbreviation:		'spr'
			offense:			10
			defenseGeneral:		15
			defenseCavalry:		45
			defenseArchers:		20
			speed:				new Duration '18m'
			haul: 				25
			costs:
				resources:		new Resources wood: 50, clay: 30, iron: 10
				time:			new Duration '17m'
				workers:		1
			research:
				requirements:	barracks: 1
				researched:		true



		swordsman:
			title:				'swordsman'
			abbreviation:		'swd'
			offense:			25
			defenseGeneral:		50
			defenseCavalry:		15
			defenseArchers:		40
			speed:				new Duration '22m'
			haul: 				15
			costs:
				resources:		new Resources wood: 30, clay: 30, iron: 70
				time:			new Duration '25m'
				workers:		1
			research:
				requirements:	smithy: 1
				researched:		true



		axeman:
			title:				'axeman'
			abbreviation:		'axe'
			offense:			40
			defenseGeneral:		10
			defenseCavalry:		5
			defenseArchers:		10
			speed:				new Duration '18m'
			haul: 				10
			costs:
				resources:		new Resources wood: 60, clay: 30, iron: 40
				time:			new Duration '22m'
				workers:		1
			research:
				requirements:	smithy: 2
				researched:		false
				resources:		new Resources wood: 700, clay: 840, iron: 820
				time:			new Duration '1h55m30s'



		archer:
			title:				'archer'
			abbreviation:		'ach'
			offense:			15
			defenseGeneral:		50
			defenseCavalry:		40
			defenseArchers:		5
			speed:				new Duration '18m'
			haul: 				10
			costs:
				resources:		new Resources wood: 100, clay: 30, iron: 60
				time:			new Duration '30m'
				workers:		1
			research:
				requirements:	barracks: 5, smithy: 5
				resources:		new Resources wood: 640, clay: 560, iron: 740
				time:			new Duration '2h12m30s'



		scout:
			title:				'scout'
			abbreviation:		'sct'
			offense:			0
			offenseScouts:		2
			defenseGeneral:		2
			defenseCavalry:		1
			defenseArchers:		2
			speed:				new Duration '9m'
			haul:				0
			costs:
				resources:		new Resources wood: 50, clay: 50, iron: 20
				time:			new Duration '15m'
				workers:		2
			research:
				requirements:	stable: 1
				researched:		false
				resources:		new Resources wood: 560, clay: 480, iron: 480
				time:			new Duration '1h6m'



		lightCavalry:
			title:				'light calvary'
			abbreviation:		'lcv'
			offense:			130
			defenseGeneral:		30
			defenseCavalry:		40
			defenseArchers:		30
			speed:				new Duration '10m'
			haul: 				80
			costs:
				resources:		new Resources wood: 125, clay: 100, iron: 250
				time:			new Duration '30m'
				workers:		4
			research:
				requirements:	stable: 3
				researched:		false
				resources:		new Resources wood: 2200, clay: 2400, iron: 2000
				time:			new Duration '2h28m30s'



		mountedArcher:
			title:				'mounted archer'
			abbreviation:		'mach'
			offense:			120
			defenseGeneral:		40
			defenseCavalry:		30
			defenseArchers:		50
			speed:				new Duration '10m'
			haul: 				50
			costs:
				resources:		new Resources wood: 2250, clay: 100, iron: 150
				time:			new Duration '45m'
				workers:		5
			research:
				requirements:	stable: 5
				researched:		false
				resources:		new Resources wood: 3000, clay: 2400, iron: 2000
				time:			new Duration '2h45m'



		heavyCavalry:
			title:				'heavy calvary'
			abbreviation:		'hcv'
			offense:			150
			defenseGeneral:		200
			defenseCavalry:		80
			defenseArchers:		180
			speed:				new Duration '11m'
			haul: 				50
			costs:
				resources:		new Resources wood: 200, clay: 150, iron: 600
				time:			new Duration '1h'
				workers:		6
			research:
				requirements:	stable: 10, smithy: 15
				researched:		false
				resources:		new Resources wood: 3000, clay: 2400, iron: 2000
				time:			new Duration '2h45m'



		ram:
			title:				'ram'
			abbreviation:		'ram'
			offense:			2
			defenseGeneral:		20
			defenseCavalry:		50
			defenseArchers:		20
			speed:				new Duration '30m'
			haul:				0
			costs:
				resources:		new Resources wood: 300, clay: 200, iron: 200
				time:			new Duration '1h20m'
				workers:		5
			research:
				requirements:	workshop: 1
				researched:		false
				resources:		new Resources wood: 1200, clay: 1600, iron: 800
				time:			new Duration '2h11m50s'



		catapult:
			title:				'catapult'
			abbreviation:		'cat'
			offense:			100
			defenseGeneral:		100
			defenseCavalry:		50
			defenseArchers:		100
			speed:				new Duration '30m'
			haul:				0
			costs:
				resources:		new Resources wood: 320, clay: 400, iron: 100
				time:			new Duration '2h'
				workers:		8
			research:
				requirements:	workshop: 2, smithy: 12
				researched:		false
				resources:		new Resources wood: 1600, clay: 2000, iron: 1200
				time:			new Duration '2h45m'



		paladin:
			title:				'paladin'
			abbreviation:		'pld'
			offense:			150
			defenseGeneral:		250
			defenseCavalry:		400
			defenseArchers:		150
			speed:				new Duration '10m'
			haul: 				100
			costs:
				resources:		new Resources wood: 20, clay: 20, iron: 40
				time:			new Duration '6h'
				workers:		100
			research:
				requirements:	statue: 1
				researched:		true



		nobleman:
			title:				'nobleman'
			abbreviation:		'nbm'
			offense:			30
			defenseGeneral:		100
			defenseCavalry:		50
			defenseArchers:		100
			speed:				new Duration '35m'
			haul:				0
			costs:
				resources:		new Resources wood: 40000, clay: 50000, iron: 50000
				time:			new Duration '5d' # todo: correct?
				workers:		100
				coins:			(lvl) -> lvl * (lvl + 1) / 2
			research:
				requirements:	academy: 1
				researched:		true

	}
