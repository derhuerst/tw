Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'stable'
	abbreviation: 'stb'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 20
	points: (lvl) -> if lvl < 1 then 0 else Math.round 20 * 1.2000039538005 ^ (lvl - 1)
	workers: (lvl) -> if lvl < 1 then 0 else Math.round 8 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 270 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 240 * 1.28 ^ (lvl - 1)
		iron: (lvl) -> Math.round 260 * 1.26 ^ (lvl - 1)
		time: (lvl) -> Math.round 6000 * 1.2 ^ (lvl - 1)
	requirements:
		headquarter: 10
		barracks: 5
		smithy: 5
	timeFactor: -> 1 # todo: see below
	levels: [
		# level 1
			timeFactor: 0.63
		, # level 2
			timeFactor: 0.59
		, # level 3
			timeFactor: 0.56
		, # level 4
			timeFactor: 0.53
		, # level 5
			timeFactor: 0.50
		, # level 6
			timeFactor: 0.47
		, # level 7
			timeFactor: 0.44
		, # level 8
			timeFactor: 0.42
		, # level 9
			timeFactor: 0.39
		, # level 10
			timeFactor: 0.37
		, # level 11
			timeFactor: 0.35
		, # level 12
			timeFactor: 0.33
		, # level 13
			timeFactor: 0.31
		, # level 14
			timeFactor: 0.29
		, # level 15
			timeFactor: 0.28
		, # level 16
			timeFactor: 0.26
		, # level 17
			timeFactor: 0.25
		, # level 18
			timeFactor: 0.23
		, # level 19
			timeFactor: 0.22
		, # level 20
			timeFactor: 0.21
	]
