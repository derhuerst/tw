Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =

	title: 'headqarter'
	abbreviation: 'hq'
	initialLevel: 1
	minimalLevel: 1
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 90
				clay: 80
				iron: 70
			workers: 5
			points: 10
			duration: new Duration '1s' #todo
			timeFactor: 0.95
		}

		# level 2
		{
			resources: new Resources
				wood: 113
				clay: 102
				iron: 88
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			timeFactor: 0.91
		}

		# level 3
		{
			resources: new Resources
				wood: 143
				clay: 130
				iron: 111
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			timeFactor: 0.86
		}

		# level 4
		{
			resources: new Resources
				wood: 180
				clay: 166
				iron: 140
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			timeFactor: 0.82
		}

		# level 5
		{
			resources: new Resources
				wood: 227
				clay: 211
				iron: 176
			workers: 1
			points: 4
			duration: new Duration '1s' #todo
			timeFactor: 0.78
		}

		# level 6
		{
			resources: new Resources
				wood: 286
				clay: 270
				iron: 222
			workers: 2
			points: 4
			duration: new Duration '1s' #todo
			timeFactor: 0.75
		}

		# level 7
		{
			resources: new Resources
				wood: 360
				clay: 344
				iron: 280
			workers: 2
			points: 5
			duration: new Duration '1s' #todo
			timeFactor: 0.71
		}

		# level 8
		{
			resources: new Resources
				wood: 454
				clay: 438
				iron: 353
			workers: 2
			points: 6
			duration: new Duration '1s' #todo
			timeFactor: 0.68
		}

		# level 9
		{
			resources: new Resources
				wood: 572
				clay: 559
				iron: 445
			workers: 3
			points: 7
			duration: new Duration '1s' #todo
			timeFactor: 0.64
		}

		# level 10
		{
			resources: new Resources
				wood: 720
				clay: 712
				iron: 560
			workers: 3
			points: 9
			duration: new Duration '1s' #todo
			timeFactor: 0.61
		}

		# level 11
		{
			resources: new Resources
				wood: 908
				clay: 908
				iron: 706
			workers: 3
			points: 10
			duration: new Duration '1s' #todo
			timeFactor: 0.58
		}

		# level 12
		{
			resources: new Resources
				wood: 1144
				clay: 1158
				iron: 890
			workers: 4
			points: 12
			duration: new Duration '1s' #todo
			timeFactor: 0.56
		}

		# level 13
		{
			resources: new Resources
				wood: 1441
				clay: 1476
				iron: 1121
			workers: 5
			points: 15
			duration: new Duration '1s' #todo
			timeFactor: 0.53
		}

		# level 14
		{
			resources: new Resources
				wood: 1816
				clay: 1882
				iron: 1412
			workers: 5
			points: 18
			duration: new Duration '1s' #todo
			timeFactor: 0.51
		}

		# level 15
		{
			resources: new Resources
				wood: 2288
				clay: 2400
				iron: 1779
			workers: 7
			points: 21
			duration: new Duration '1s' #todo
			timeFactor: 0.48
		}

		# level 16
		{
			resources: new Resources
				wood: 2883
				clay: 3060
				iron: 2242
			workers: 8
			points: 26
			duration: new Duration '1s' #todo
			timeFactor: 0.46
		}

		# level 17
		{
			resources: new Resources
				wood: 3632
				clay: 3902
				iron: 2825
			workers: 9
			points: 31
			duration: new Duration '1s' #todo
			timeFactor: 0.44
		}

		# level 18
		{
			resources: new Resources
				wood: 4577
				clay: 4975
				iron: 3560
			workers: 10
			points: 37
			duration: new Duration '1s' #todo
			timeFactor: 0.42
		}

		# level 19
		{
			resources: new Resources
				wood: 5767
				clay: 6343
				iron: 4485
			workers: 12
			points: 44
			duration: new Duration '1s' #todo
			timeFactor: 0.40
		}

		# level 20
		{
			resources: new Resources
				wood: 7266
				clay: 8087
				iron: 5651
			workers: 15
			points: 53
			duration: new Duration '1s' #todo
			timeFactor: 0.38
		}

		# level 21
		{
			resources: new Resources
				wood: 9155
				clay: 10311
				iron: 7120
			workers: 17
			points: 64
			duration: new Duration '1s' #todo
			timeFactor: 0.36
		}

		# level 22
		{
			resources: new Resources
				wood: 11535
				clay: 13146
				iron: 8972
			workers: 19
			points: 77
			duration: new Duration '1s' #todo
			timeFactor: 0.34
		}

		# level 23
		{
			resources: new Resources
				wood: 14534
				clay: 16762
				iron: 11304
			workers: 23
			points: 92
			duration: new Duration '1s' #todo
			timeFactor: 0.33
		}

		# level 24
		{
			resources: new Resources
				wood: 18313
				clay: 21371
				iron: 14244
			workers: 27
			points: 110
			duration: new Duration '1s' #todo
			timeFactor: 0.31
		}

		# level 25
		{
			resources: new Resources
				wood: 23075
				clay: 27248
				iron: 17947
			workers: 31
			points: 133
			duration: new Duration '1s' #todo
			timeFactor: 0.30
		}

		# level 26
		{
			resources: new Resources
				wood: 29074
				clay: 34741
				iron: 22613
			workers: 37
			points: 159
			duration: new Duration '1s' #todo
			timeFactor: 0.28
		}

		# level 27
		{
			resources: new Resources
				wood: 36633
				clay: 44295
				iron: 28493
			workers: 43
			points: 191
			duration: new Duration '1s' #todo
			timeFactor: 0.27
		}

		# level 28
		{
			resources: new Resources
				wood: 46158
				clay: 56476
				iron: 35901
			workers: 51
			points: 229
			duration: new Duration '1s' #todo
			timeFactor: 0.26
		}

		# level 29
		{
			resources: new Resources
				wood: 58159
				clay: 72007
				iron: 45235
			workers: 59
			points: 274
			duration: new Duration '1s' #todo
			timeFactor: 0.24
		}

		# level 30
		{
			resources: new Resources
				wood: 73280
				clay: 91809
				iron: 56996
			workers: 69
			points: 330
			duration: new Duration '1s' #todo
			timeFactor: 0.23
		}
	]
