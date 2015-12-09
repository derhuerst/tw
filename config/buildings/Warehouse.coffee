Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'warehouse'
	abbreviation: 'wrh'
	initialLevel: 1
	minimalLevel: 0
	maximalLevel: 30
	points: (lvl) -> Math.round 6 * 1.2000041287667 ^ (lvl - 1)
	workers: (lvl) -> 0
	costs:
		wood: (lvl) -> Math.round 60 * 1.265 ^ (lvl - 1)
		clay: (lvl) -> Math.round 50 * 1.27 ^ (lvl - 1)
		iron: (lvl) -> Math.round 40 * 1.245 ^ (lvl - 1)
		time: (lvl) -> # todo
	requirements: {}
	workers: (lvl) -> Math.round 1000 * 1.2294934136946 ^ (lvl - 1)
