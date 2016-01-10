Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'workshop'
	abbreviation: 'wsh'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 15
	points: (lvl) -> if lvl < 1 then 0 else Math.round 24 * 1.1999609284227 ^ (lvl - 1)
	workers: (lvl) -> if lvl < 1 then 0 else Math.round 8 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 300 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 240 * 1.28 ^ (lvl - 1)
		iron: (lvl) -> Math.round 260 * 1.26 ^ (lvl - 1)
		time: (lvl) -> Math.round 6000 * 1.2 ^ (lvl - 1)
	requirements:
		headquarter: 10
		smithy: 10
	timeFactor: (lvl) -> (2/3) * .9433 ^ lvl
