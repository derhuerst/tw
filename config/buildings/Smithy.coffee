Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'smithy'
	abbreviation: 'smy'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 20
	points: (lvl) -> Math.round 10 * 1.1999987515464 ^ (lvl - 1)
	workers: (lvl) -> Math.round 20 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 220 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 180 * 1.275 ^ (lvl - 1)
		iron: (lvl) -> Math.round 240 * 1.26 ^ (lvl - 1)
		time: (lvl) -> # todo
	requirements:
		headquarter: 5
		barracks: 1
	levels: [ # todo
			timeFactor: 0.91
		, # level 2
			timeFactor: 0.83
		, # level 3
			timeFactor: 0.75
		, # level 4
			timeFactor: 0.68
		, # level 5
			timeFactor: 0.62
		, # level 6
			timeFactor: 0.56
		, # level 7
			timeFactor: 0.51
		, # level 8
			timeFactor: 0.47
		, # level 9
			timeFactor: 0.42
		, # level 10
			timeFactor: 0.39
		, # level 11
			timeFactor: 0.35
		, # level 12
			timeFactor: 0.32
		, # level 13
			timeFactor: 0.29
		, # level 14
			timeFactor: 0.26
		, # level 15
			timeFactor: 0.24
		, # level 16
			timeFactor: 0.22
		, # level 17
			timeFactor: 0.20
		, # level 18
			timeFactor: 0.18
		, # level 19
			timeFactor: 0.16
		, # level 20
			timeFactor: 0.15
	]
