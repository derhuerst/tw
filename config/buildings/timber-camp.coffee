Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'





module.exports =



	title: 'timber camp'
	abbreviation: 'tbc'
	initialLevel: 0
	minimalLevel: 0
	maximalLevel: 30
	points: (lvl) -> Math.round 6 * 1.2000041287667 ^ (lvl - 1)
	workers: (lvl) -> Math.round 5 * 1.155 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 50 * 1.25 ^ (lvl - 1)
		clay: (lvl) -> Math.round 60 * 1.275 ^ (lvl - 1)
		iron: (lvl) -> Math.round 40 * 1.245 ^ (lvl - 1)
		time: (lvl) -> Math.round 900 * 1.2 ^ (lvl - 1)
	requirements: {}
	production: (lvl) ->
		return 5 unless lvl > 0
		return Math.round 30 * 1.1631180425543 ^ (lvl - 1)
