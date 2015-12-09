Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'





module.exports =



	title: 'clay pit'
	abbreviation: 'clp'
	initialLevel: 1
	minimalLevel: 0
	maximalLevel: 30
	points: (lvl) -> Math.round 6 * 1.2000041287667 ^ (lvl - 1)
	workers: (lvl) -> Math.round 10 * 1.14 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 65 * 1.27 ^ (lvl - 1)
		clay: (lvl) -> Math.round 50 * 1.265 ^ (lvl - 1)
		iron: (lvl) -> Math.round 40 * 1.24 ^ (lvl - 1)
		time: (lvl) -> # todo
	requirements: {}
	production: (lvl) ->
		return 5 unless lvl > 0
		return Math.round 30 * 1.1631180425543 ^ (lvl - 1)
