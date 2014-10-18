Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'workshop'
	abbreviation: 'wsh'
	initialLevel: 0
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 300
				clay: 240
				iron: 260
			workers: 8
			points: 24
			duration: new Duration '1s' #todo
			timeFactor: 0.63
		}

		# level 2
		{
			resources: new Resources
				wood: 378
				clay: 307
				iron: 328
			workers: 1
			points: 5
			duration: new Duration '1s' #todo
			timeFactor: 0.59
		}

		# level 3
		{
			resources: new Resources
				wood: 476
				clay: 393
				iron: 413
			workers: 2
			points: 6
			duration: new Duration '1s' #todo
			timeFactor: 0.65
		}

		# level 4
		{
			resources: new Resources
				wood: 600
				clay: 503
				iron: 520
			workers: 2
			points: 6
			duration: new Duration '1s' #todo
			timeFactor: 0.53
		}

		# level 5
		{
			resources: new Resources
				wood: 756
				clay: 644
				iron: 655
			workers: 2
			points: 9
			duration: new Duration '1s' #todo
			timeFactor: 0.50
		}

		# level 6
		{
			resources: new Resources
				wood: 953
				clay: 825
				iron: 826
			workers: 3
			points: 10
			duration: new Duration '1s' #todo
			timeFactor: 0.47
		}

		# level 7
		{
			resources: new Resources
				wood: 1200
				clay: 1056
				iron: 1040
			workers: 3
			points: 12
			duration: new Duration '1s' #todo
			timeFactor: 0.44
		}

		# level 8
		{
			resources: new Resources
				wood: 1513
				clay: 1351
				iron: 1311
			workers: 3
			points: 14
			duration: new Duration '1s' #todo
			timeFactor: 0.42
		}

		# level 9
		{
			resources: new Resources
				wood: 1906
				clay: 1729
				iron: 1652
			workers: 4
			points: 17
			duration: new Duration '1s' #todo
			timeFactor: 0.39
		}

		# level 10
		{
			resources: new Resources
				wood: 2401
				clay: 2214
				iron: 2081
			workers: 5
			points: 21
			duration: new Duration '1s' #todo
			timeFactor: 0.37
		}

		# level 11
		{
			resources: new Resources
				wood: 3026
				clay: 2833
				iron: 2622
			workers: 5
			points: 25
			duration: new Duration '1s' #todo
			timeFactor: 0.35
		}

		# level 12
		{
			resources: new Resources
				wood: 3812
				clay: 3627
				iron: 3304
			workers: 7
			points: 29
			duration: new Duration '1s' #todo
			timeFactor: 0.33
		}

		# level 13
		{
			resources: new Resources
				wood: 4804
				clay: 4642
				iron: 4163
			workers: 8
			points: 36
			duration: new Duration '1s' #todo
			timeFactor: 0.31
		}

		# level 14
		{
			resources: new Resources
				wood: 6053
				clay: 5942
				iron: 5246
			workers: 9
			points: 43
			duration: new Duration '1s' #todo
			timeFactor: 0.29
		}

		# level 15
		{
			resources: new Resources
				wood: 7626
				clay: 7606
				iron: 6609
			workers: 10
			points: 51
			duration: new Duration '1s' #todo
			timeFactor: 0.28
		}

	]
