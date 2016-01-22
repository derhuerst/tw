container = require '../../src/container'

module.exports = container.publish 'config.buildings.stash', ->





	return {

		title: 'stash'
		abbreviation: 'sta'
		initialLevel: 1
		minimalLevel: 0
		maximalLevel: 10
		points: (lvl) -> if lvl < 1 then 0 else Math.round 5 * 1.201035728641 ^ (lvl - 1)
		workers: (lvl) -> if lvl < 1 then 0 else Math.round 2 * 1.17 ^ (lvl - 1)
		costs:
			wood: (lvl) -> Math.round 50 * 1.25 ^ (lvl - 1)
			clay: (lvl) -> Math.round 60 * 1.25 ^ (lvl - 1)
			iron: (lvl) -> Math.round 50 * 1.25 ^ (lvl - 1)
			time: (lvl) -> Math.round 1800 * 1.2 ^ (lvl - 1)
		requirements: {}
		capacity: (lvl) -> Math.round 112,4 * 0,2879 ^ lvl
		# todo? "hide" with Math.round 150 * 1.333500530983 ^ (lvl - 1); what is this?

	}
