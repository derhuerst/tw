Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'stash'
	abbreviation: 'sta'
	initialLevel: 1
	minimalLevel: 0
	maximalLevel: 10
	points: (lvl) -> Math.round 5 * 1.201035728641 ^ (lvl - 1)
	workers: (lvl) -> Math.round 2 * 1.17 ^ (lvl - 1)
	costs:
		wood: (lvl) -> Math.round 50 * 1.25 ^ (lvl - 1)
		clay: (lvl) -> Math.round 60 * 1.25 ^ (lvl - 1)
		iron: (lvl) -> Math.round 50 * 1.25 ^ (lvl - 1)
		time: (lvl) -> Math.round 1800 * 1.2 ^ (lvl - 1)
	requirements: {}
	capacity:
		wood: (lvl) -> Math.round 50 * 1.2501754918161 ^ (lvl - 1)
		clay: (lvl) -> Math.round 60 * 1.249989176514 ^ (lvl - 1)
		iron: (lvl) -> Math.round 50 * 1.2501754918161 ^ (lvl - 1)
	# todo? "hide" with Math.round 150 * 1.333500530983 ^ (lvl - 1); what is this?
