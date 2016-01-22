container = require '../../src/container'

module.exports = container.publish 'config.buildings.headquarter', ->





	return {

		title: 'headqarter'
		abbreviation: 'hq'
		initialLevel: 1
		minimalLevel: 1
		maximalLevel: 30
		points: (lvl) -> if lvl < 1 then 0 else Math.round 10 * 1.1999971560929 ^ (lvl - 1)
		workers: (lvl) -> if lvl < 1 then 0 else Math.round 5 * 1.17 ^ (lvl - 1)
		costs:
			wood: (lvl) -> Math.round 90 * 1.26 ^ (lvl - 1)
			clay: (lvl) -> Math.round 80 * 1.275 ^ (lvl - 1)
			iron: (lvl) -> Math.round 70 * 1.26 ^ (lvl - 1)
			time: (lvl) -> Math.round 900 * 1.2 ^ (lvl - 1)
		requirements: {}
		timeFactor: (lvl) -> .952381 ^ lvl

	}
