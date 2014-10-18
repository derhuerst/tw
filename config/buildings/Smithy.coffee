Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'smithy'
	abbreviation: 'smy'
	initialLevel: 0
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 220
				clay: 180
				iron: 240
			workers: 20
			points: 19
			duration: new Duration '1s' #todo
			timeFactor: 0.91
		}

		# level 2
		{
			resources: new Resources
				wood: 277
				clay: 230
				iron: 302
			workers: 3
			points: 4
			duration: new Duration '1s' #todo
			timeFactor: 0.83
		}

		# level 3
		{
			resources: new Resources
				wood: 349
				clay: 293
				iron: 351
			workers: 4
			points: 4
			duration: new Duration '1s' #todo
			timeFactor: 0.75
		}

		# level 4
		{
			resources: new Resources
				wood: 440
				clay: 373
				iron: 480
			workers: 5
			points: 6
			duration: new Duration '1s' #todo
			timeFactor: 0.68
		}

		# level 5
		{
			resources: new Resources
				wood: 555
				clay: 476
				iron: 605
			workers: 5
			points: 6
			duration: new Duration '1s' #todo
			timeFactor: 0.62
		}

		# level 6
		{
			resources: new Resources
				wood: 699
				clay: 606
				iron: 762
			workers: 7
			points: 8
			duration: new Duration '1s' #todo
			timeFactor: 0.56
		}

		# level 7
		{
			resources: new Resources
				wood: 880
				clay: 773
				iron: 960
			workers: 7
			points: 10
			duration: new Duration '1s' #todo
			timeFactor: 0.51
		}

		# level 8
		{
			resources: new Resources
				wood: 1109
				clay: 689
				iron: 1210
			workers: 9
			points: 11
			duration: new Duration '1s' #todo
			timeFactor: 0.47
		}

		# level 9
		{
			resources: new Resources
				wood: 1398
				clay: 1257
				iron: 1525
			workers: 10
			points: 14
			duration: new Duration '1s' #todo
			timeFactor: 0.42
		}

		# level 10
		{
			resources: new Resources
				wood: 1761
				clay: 1603
				iron: 1921
			workers: 12
			points: 16
			duration: new Duration '1s' #todo
			timeFactor: 0.39
		}

		# level 11
		{
			resources: new Resources
				wood: 2219
				clay: 2043
				iron: 2421
			workers: 14
			points: 20
			duration: new Duration '1s' #todo
			timeFactor: 0.35
		}

		# level 12
		{
			resources: new Resources
				wood: 2796
				clay: 2605
				iron: 3050
			workers: 16
			points: 23
			duration: new Duration '1s' #todo
			timeFactor: 0.32
		}

		# level 13
		{
			resources: new Resources
				wood: 3523
				clay: 3322
				iron: 3843
			workers: 20
			points: 28
			duration: new Duration '1s' #todo
			timeFactor: 0.29
		}

		# level 14
		{
			resources: new Resources
				wood: 4439
				clay: 4236
				iron: 4842
			workers: 22
			points: 34
			duration: new Duration '1s' #todo
			timeFactor: 0.26
		}

		# level 15
		{
			resources: new Resources
				wood: 5593
				clay: 5400
				iron: 6101
			workers: 26
			points: 41
			duration: new Duration '1s' #todo
			timeFactor: 0.24
		}

		# level 16
		{
			resources: new Resources
				wood: 7047
				clay: 6885
				iron: 7687
			workers: 31
			points: 49
			duration: new Duration '1s' #todo
			timeFactor: 0.22
		}

		# level 17
		{
			resources: new Resources
				wood: 8879
				clay: 8779
				iron: 9686
			workers: 36
			points: 58
			duration: new Duration '1s' #todo
			timeFactor: 0.20
		}

		# level 18
		{
			resources: new Resources
				wood: 11187
				clay: 11193
				iron: 12204
			workers: 42
			points: 71
			duration: new Duration '1s' #todo
			timeFactor: 0.18
		}

		# level 19
		{
			resources: new Resources
				wood: 14096
				clay: 14271
				iron: 15377
			workers: 49
			points: 84
			duration: new Duration '1s' #todo
			timeFactor: 0.16
		}

		# level 20
		{
			resources: new Resources
				wood: 17761
				clay: 18196
				iron: 19375
			workers: 57
			points: 101
			duration: new Duration '1s' #todo
			timeFactor: 0.15
		}

	]
