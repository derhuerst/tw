require '../../src/util/Duration'
container = require '../../src/container'

module.exports = container.publish 'config.buildings.market', [
	'util.Duration'
], (Duration) ->





	return {

		title: 'market'
		abbreviation: 'mkt'
		initialLevel: 0
		minimalLevel: 0
		maximalLevel: 25
		points: (lvl) -> if lvl < 1 then 0 else Math.round 10 * 1.1999971560929 ^ (lvl - 1)
		workers: (lvl) -> if lvl < 1 then 0 else Math.round 20 * 1.17 ^ (lvl - 1)
		costs:
			wood: (lvl) -> Math.round 100 * 1.26 ^ (lvl - 1)
			clay: (lvl) -> Math.round 100 * 1.275 ^ (lvl - 1)
			iron: (lvl) -> Math.round 100 * 1.26 ^ (lvl - 1)
			time: (lvl) -> Math.round 2700 * 1.2 ^ (lvl - 1)
		requirements:
			main: 3
			warehouse: 2
		tradesTimeToRevoke: new Duration '5m'
		merchants: (lvl) -> if lvl > 10 then 10 + Math.pow (lvl - 10), 2 else 10

	}
