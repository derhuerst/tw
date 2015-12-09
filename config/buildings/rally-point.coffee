Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'rally point'
	abbreviation: 'rlp'
	initialLevel: 1
	minimalLevel: 0
	maximalLevel: 1
	points: (lvl) -> 0
	workers: (lvl) -> 0
	costs:
		wood: (lvl) -> Math.round 10 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 40 * 1.275 ^ (lvl - 1)
		iron: (lvl) -> Math.round 30 * 1.26 ^ (lvl - 1)
		time: (lvl) -> Math.round 10860 * 1.2 ^ (lvl - 1)
	requirements: {}
