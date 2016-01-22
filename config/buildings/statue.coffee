container = require '../../src/container'

module.exports = container.publish 'config.buildings.statue', ->





	return {

		title: 'statue'
		abbreviation: 'stt'
		initialLevel: 0
		minimalLevel: 0
		maximalLevel: 1
		points: (lvl) -> if lvl < 1 then 0 else Math.round 24 * 1.25 ^ (lvl - 1)
		workers: (lvl) -> if lvl < 1 then 0 else Math.round 10 * 1.17 ^ (lvl - 1)
		costs:
			wood: (lvl) -> Math.round 220 * 1.26 ^ (lvl - 1)
			clay: (lvl) -> Math.round 220 * 1.275 ^ (lvl - 1)
			iron: (lvl) -> Math.round 220 * 1.26 ^ (lvl - 1)
			time: (lvl) -> Math.round 24 * 1.25 ^ (lvl - 1)
		requirements: {}

	}
