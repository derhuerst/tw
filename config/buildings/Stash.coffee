Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'stash'
	abbreviation: 'sta'
	initialLevel: 0
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 50
				clay: 60
				iron: 50
			workers: 2
			points: 5
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 150
				clay: 150
				iron: 150
		}

		# level 2
		{
			resources: new Resources
				wood: 63
				clay: 75
				iron: 63
			workers: 0
			points: 1
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 200
				clay: 200
				iron: 200
		}

		# level 3
		{
			resources: new Resources
				wood: 78
				clay: 94
				iron: 78
			workers: 1
			points: 1
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 267
				clay: 267
				iron: 267
		}

		# level 4
		{
			resources: new Resources
				wood: 98
				clay: 117
				iron: 98
			workers: 0
			points: 2
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 356
				clay: 356
				iron: 356
		}

		# level 5
		{
			resources: new Resources
				wood: 122
				clay: 146
				iron: 122
			workers: 1
			points: 1
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 474
				clay: 474
				iron: 474
		}

		# level 6
		{
			resources: new Resources
				wood: 153
				clay: 183
				iron: 153
			workers: 7
			points: 0
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 632
				clay: 632
				iron: 632
		}

		# level 7
		{
			resources: new Resources
				wood: 191
				clay: 229
				iron: 191
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 843
				clay: 843
				iron: 843
		}

		# level 8
		{
			resources: new Resources
				wood: 238
				clay: 286
				iron: 238
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 1125
				clay: 1125
				iron: 1125
		}

		# level 9
		{
			resources: new Resources
				wood: 298
				clay: 358
				iron: 298
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 1500
				clay: 1500
				iron: 1500
		}

		# level 10
		{
			resources: new Resources
				wood: 373
				clay: 447
				iron: 373
			workers: 1
			points: 5
			duration: new Duration '1s' #todo
			capacity: new Resources
				wood: 2000
				clay: 2000
				iron: 2000
		}

	]
