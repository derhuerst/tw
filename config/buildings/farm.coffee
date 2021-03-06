container = require '../../src/container'

module.exports = container.publish 'config.buildings.farm', ->





	return {

		title: 'farm'
		abbreviation: 'frm'
		initialLevel: 1
		minimalLevel: 1
		maximalLevel: 30
		points: (lvl) -> if lvl < 1 then 0 else Math.round 5 * 1.1999971560929 ^ (lvl - 1)
		workers: (lvl) -> if lvl < 1 then 0 else Math.round 240 * 1.1721022975335 ^ (lvl - 1)
		costs:
			wood: (lvl) -> Math.round 45 * 1.3 ^ (lvl - 1)
			clay: (lvl) -> Math.round 40 * 1.32 ^ (lvl - 1)
			iron: (lvl) -> Math.round 30 * 1.29 ^ (lvl - 1)
			time: (lvl) -> Math.round 1200 * 1.2 ^ (lvl - 1)
		requirements: {}

	}
