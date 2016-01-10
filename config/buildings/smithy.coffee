Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'smithy'
	abbreviation: 'smy'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 20
	points: (lvl) -> if lvl < 1 then 0 else Math.round 10 * 1.1999987515464 ^ (lvl - 1)
	workers: (lvl) -> if lvl < 1 then 0 else Math.round 20 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 220 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 180 * 1.275 ^ (lvl - 1)
		iron: (lvl) -> Math.round 240 * 1.26 ^ (lvl - 1)
		time: (lvl) -> Math.round 6000 * 1.2 ^ (lvl - 1)
	requirements:
		headquarter: 5
		barracks: 1
	timeFactor: (lvl) -> (90/99) ^ lvl
