Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'barracks'
	abbreviation: 'brs'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 25
	points: (lvl) -> if lvl < 1 then 0 else Math.round 16 * 1.2000019829319 ^ (lvl - 1)
	workers: (lvl) -> if lvl < 1 then 0 else Math.round 7 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 200 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 170 * 1.28 ^ (lvl - 1)
		iron: (lvl) -> Math.round 90 * 1.26 ^ (lvl - 1)
		time: (lvl) -> Math.round 1800 * 1.2 ^ (lvl - 1)
	requirements:
		headquarter: 3
	timeFactor: (lvl) -> (2/3) * .9433 ^ lvl
