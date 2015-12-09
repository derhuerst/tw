Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'wall'
	abbreviation: 'wll'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 20
	points: (lvl) -> Math.round 8 * 1.2001027195781 ^ (lvl - 1)
	workers: (lvl) -> Math.round 5 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 50 * 1.26 ^ (lvl - 1)
		clay: (lvl) -> Math.round 100 * 1.275 ^ (lvl - 1)
		iron: (lvl) -> Math.round 20 * 1.26 ^ (lvl - 1)
		time: (lvl) -> # todo
	requirements:
		barracks: 1
	levels: [ # todo
		# level 1
			basicDefense: 70
			defenseFactor: 1.04
		, # level 2
			basicDefense: 120
			defenseFactor: 1.08
		, # level 3
			basicDefense: 70 #todo
			defenseFactor: 1.12
		, # level 4
			basicDefense: 70 #todo
			defenseFactor: 1.16
		, # level 5
			basicDefense: 70 #todo
			defenseFactor: 1.20
		, # level 6
			basicDefense: 70 #todo
			defenseFactor: 1.24
		, # level 7
			basicDefense: 70 #todo
			defenseFactor: 1.29
		, # level 8
			basicDefense: 70 #todo
			defenseFactor: 1.34
		, # level 9
			basicDefense: 70 #todo
			defenseFactor: 1.39
		, # level 10
			basicDefense: 70 #todo
			defenseFactor: 1.44
		, # level 11
			basicDefense: 70 #todo
			defenseFactor: 1.49
		, # level 12
			basicDefense: 70 #todo
			defenseFactor: 1.55
		, # level 13
			basicDefense: 70 #todo
			defenseFactor: 1.60
		, # level 14
			basicDefense: 70 #todo
			defenseFactor: 1.66
		, # level 15
			basicDefense: 70 #todo
			defenseFactor: 1.72
		, # level 16
			basicDefense: 70 #todo
			defenseFactor: 1.79
		, # level 17
			basicDefense: 70 #todo
			defenseFactor: 1.85
		, # level 18
			basicDefense: 70 #todo
			defenseFactor: 1.92
		, # level 19
			basicDefense: 70 #todo
			defenseFactor: 1.99
		, # level 20
			basicDefense: 70 #todo
			defenseFactor: 2.07
	]
