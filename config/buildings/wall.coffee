container = require '../../src/container'

module.exports = container.publish 'config.buildings.wall', ->





	return {

		title: 'wall'
		abbreviation: 'wll'
		initialLevel: 0
		minimalLevel: 0
		maximalLevel: 20
		points: (lvl) -> if lvl < 1 then 0 else Math.round 8 * 1.2001027195781 ^ (lvl - 1)
		workers: (lvl) -> if lvl < 1 then 0 else Math.round 5 * 1.17 ^ (lvl - 1)
		costs:
			wood: (lvl) -> Math.round 50 * 1.26 ^ (lvl - 1)
			clay: (lvl) -> Math.round 100 * 1.275 ^ (lvl - 1)
			iron: (lvl) -> Math.round 20 * 1.26 ^ (lvl - 1)
			time: (lvl) -> Math.round 3600 * 1.2 ^ (lvl - 1)
		requirements:
			barracks: 1
		defenseFactor: (lvl) -> 1.03704 ^ lvl
		basicDefense: (lvl) -> 20 + 50 * lvl

	}
