Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'academy'
	abbreviation: 'acd'
	initialLevel: 0
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 15000
				clay: 25000
				iron: 10000
			workers: 80
			points: 512
			duration: new Duration '1s' #todo
		}
	]
