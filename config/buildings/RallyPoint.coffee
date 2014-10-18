Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'rally point'
	abbreviation: 'rlp'
	initialLevel: 1
	minimalLevel: 1
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 10
				clay: 40
				iron: 30
			workers: 0
			points: 24
			duration: new Duration '1s' #todo
		}
	]
