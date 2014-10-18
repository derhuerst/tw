Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'barracks'
	abbreviation: 'brs'
	initialLevel: 0
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 200
				clay: 150
				iron: 90
			workers: 7
			points: 16
			duration: new Duration '1s' #todo
			timeFactor: 0.63
		}

		# level 2
		{
			resources: new Resources
				wood: 252
				clay: 218
				iron: 113
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			timeFactor: 0.59
		}

		# level 3
		{
			resources: new Resources
				wood: 318
				clay: 279
				iron: 143
			workers: 2
			points: 4
			duration: new Duration '1s' #todo
			timeFactor: 0.56
		}

		# level 4
		{
			resources: new Resources
				wood: 400
				clay: 357
				iron: 180
			workers: 1
			points: 5
			duration: new Duration '1s' #todo
			timeFactor: 0.53
		}

		# level 5
		{
			resources: new Resources
				wood: 504
				clay: 456
				iron: 227
			workers: 2
			points: 5
			duration: new Duration '1s' #todo
			timeFactor: 0.50
		}

		# level 6
		{
			resources: new Resources
				wood: 635
				clay: 584
				iron: 286
			workers: 2
			points: 7
			duration: new Duration '1s' #todo
			timeFactor: 0.47
		}

		# level 7
		{
			resources: new Resources
				wood: 800
				clay: 748
				iron: 360
			workers: 3
			points: 8
			duration: new Duration '1s' #todo
			timeFactor: 0.44
		}

		# level 8
		{
			resources: new Resources
				wood: 1008
				clay: 957
				iron: 454
			workers: 3
			points: 9
			duration: new Duration '1s' #todo
			timeFactor: 0.42
		}

		# level 9
		{
			resources: new Resources
				wood: 1271
				clay: 1225
				iron: 572
			workers: 4
			points: 12
			duration: new Duration '1s' #todo
			timeFactor: 0.39
		}

		# level 10
		{
			resources: new Resources
				wood: 1601
				clay: 1568
				iron: 720
			workers: 4
			points: 14
			duration: new Duration '1s' #todo
			timeFactor: 0.37
		}

		# level 11
		{
			resources: new Resources
				wood: 2017
				clay: 2007
				iron: 908
			workers: 5
			points: 16
			duration: new Duration '1s' #todo
			timeFactor: 0.35
		}

		# level 12
		{
			resources: new Resources
				wood: 2542
				clay: 2569
				iron: 1144
			workers: 5
			points: 20
			duration: new Duration '1s' #todo
			timeFactor: 0.33
		}

		# level 13
		{
			resources: new Resources
				wood: 3202
				clay: 3288
				iron: 1441
			workers: 7
			points: 24
			duration: new Duration '1s' #todo
			timeFactor: 0.31
		}

		# level 14
		{
			resources: new Resources
				wood: 4035
				clay: 4209
				iron: 1816
			workers: 8
			points: 28
			duration: new Duration '1s' #todo
			timeFactor: 0.29
		}

		# level 15
		{
			resources: new Resources
				wood: 5084
				clay: 5388
				iron: 2288
			workers: 9
			points: 34
			duration: new Duration '1s' #todo
			timeFactor: 0.28
		}

		# level 16
		{
			resources: new Resources
				wood: 6406
				clay: 6896
				iron: 2883
			workers: 11
			points: 42
			duration: new Duration '1s' #todo
			timeFactor: 0.26
		}

		# level 17
		{
			resources: new Resources
				wood: 8072
				clay: 8827
				iron: 3632
			workers: 12
			points: 49
			duration: new Duration '1s' #todo
			timeFactor: 0.25
		}

		# level 18
		{
			resources: new Resources
				wood: 10170
				clay: 11298
				iron: 4577
			workers: 15
			points: 59
			duration: new Duration '1s' #todo
			timeFactor: 0.23
		}

		# level 19
		{
			resources: new Resources
				wood: 12814
				clay: 14462
				iron: 5767
			workers: 17
			points: 71
			duration: new Duration '1s' #todo
			timeFactor: 0.22
		}

		# level 20
		{
			resources: new Resources
				wood: 16164
				clay: 18511
				iron: 7266
			workers: 20
			points: 85
			duration: new Duration '1s' #todo
			timeFactor: 0.21
		}

		# level 21
		{
			resources: new Resources
				wood: 20344
				clay: 23695
				iron: 9155
			workers: 24
			points: 102
			duration: new Duration '1s' #todo
			timeFactor: 0.20
		}

		# level 22
		{
			resources: new Resources
				wood: 25634
				clay: 30329
				iron: 11535
			workers: 27
			points: 123
			duration: new Duration '1s' #todo
			timeFactor: 0.19
		}

		# level 23
		{
			resources: new Resources
				wood: 32298
				clay: 38821
				iron: 14534
			workers: 32
			points: 147
			duration: new Duration '1s' #todo
			timeFactor: 0.17
		}

		# level 24
		{
			resources: new Resources
				wood: 40696
				clay: 49691
				iron: 18313
			workers: 38
			points: 177
			duration: new Duration '1s' #todo
			timeFactor: 0.16
		}

		# level 25
		{
			resources: new Resources
				wood: 51277
				clay: 63605
				iron: 23075
			workers: 44
			points: 212
			duration: new Duration '1s' #todo
			timeFactor: 0.16
		}
	]
