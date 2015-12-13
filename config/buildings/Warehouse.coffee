Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'warehouse'
	abbreviation: 'wrh'
	initialLevel: 1
	minimalLevel: 0
	maximalLevel: 30
	points: (lvl) -> Math.round 6 * 1.2000041287667 ^ (lvl - 1)
	# todo: costs
	requirements: {}
	# todo: capacity
