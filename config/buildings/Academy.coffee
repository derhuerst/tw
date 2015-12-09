Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'academy'
	abbreviation: 'acd'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 1
	points: (lvl) -> Math.round 512 * 1.1997721137783 ^ (lvl - 1)
	workers: (lvl) -> Math.round 80 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 15000 * 2 ^ (lvl - 1)
		clay: (lvl) -> Math.round 25000 * 2 ^ (lvl - 1)
		iron: (lvl) -> Math.round 10000 * 2 ^ (lvl - 1)
		time: (lvl) -> Math.round 586800 * 1.2 ^ (lvl - 1)
	requirements:
		headquarter: 20
		smithy: 20
		market: 10
