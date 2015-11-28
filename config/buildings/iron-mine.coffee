Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'





module.exports =



	title: 'iron mine'
	abbreviation: 'irm'
	initialLevel: 1
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 75
				clay: 65
				iron: 70
			workers: 10
			points: 6
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 30
		}

		# level 2
		{
			resources: new Resources
				wood: 94
				clay: 83
				iron: 87
			workers: 2
			points: 1
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 35
		}

		# level 3
		{
			resources: new Resources
				wood: 118
				clay: 106
				iron: 108
			workers: 2
			points: 2
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 41
		}

		# level 4
		{
			resources: new Resources
				wood: 147
				clay: 135
				iron: 133
			workers: 2
			points: 1
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 47
		}

		# level 5
		{
			resources: new Resources
				wood: 184
				clay: 172
				iron: 165
			workers: 3
			points: 2
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 55
		}

		# level 6
		{
			resources: new Resources
				wood: 231
				clay: 219
				iron: 205
			workers: 3
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 64
		}

		# level 7
		{
			resources: new Resources
				wood: 289
				clay: 279
				iron: 254
			workers: 4
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 74
		}

		# level 8
		{
			resources: new Resources
				wood: 362
				clay: 356
				iron: 316
			workers: 4
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 86
		}

		# level 9
		{
			resources: new Resources
				wood: 453
				clay: 454
				iron: 391
			workers: 5
			points: 5
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 100
		}

		# level 10
		{
			resources: new Resources
				wood: 567
				clay: 579
				iron: 485
			workers: 6
			points: 5
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 117
		}

		# level 11
		{
			resources: new Resources
				wood: 710
				clay: 738
				iron: 602
			workers: 7
			points: 6
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 136
		}

		# level 12
		{
			resources: new Resources
				wood: 889
				clay: 941
				iron: 756
			workers: 8
			points: 8
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 158
		}

		# level 13
		{
			resources: new Resources
				wood: 1113
				clay: 1200
				iron: 925
			workers: 10
			points: 8
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 184
		}

		# level 14
		{
			resources: new Resources
				wood: 1393
				clay: 1529
				iron: 1147
			workers: 11
			points: 11
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 214
		}

		# level 15
		{
			resources: new Resources
				wood: 1744
				clay: 1950
				iron: 1422
			workers: 13
			points: 13
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 249
		}

		# level 16
		{
			resources: new Resources
				wood: 2183
				clay: 2486
				iron: 1764
			workers: 15
			points: 15
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 289
		}

		# level 17
		{
			resources: new Resources
				wood: 2734
				clay: 3170
				iron: 2187
			workers: 18
			points: 19
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 337
		}

		# level 18
		{
			resources: new Resources
				wood: 3422
				clay: 4042
				iron: 2712
			workers: 21
			points: 22
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 391
		}

		# level 19
		{
			resources: new Resources
				wood: 4285
				clay: 5153
				iron: 3363
			workers: 25
			points: 27
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 455
		}

		# level 20
		{
			resources: new Resources
				wood: 5365
				clay: 6571
				iron: 4170
			workers: 28
			points: 32
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 530
		}

		# level 21
		{
			resources: new Resources
				wood: 6717
				clay: 8378
				iron: 5170
			workers: 34
			points: 38
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 616
		}

		# level 22
		{
			resources: new Resources
				wood: 8409
				clay: 69610681
				iron: 6411
			workers: 39
			points: 46
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 717
		}

		# level 23
		{
			resources: new Resources
				wood: 10528
				clay: 12619
				iron: 7950
			workers: 46
			points: 55
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 833
		}

		# level 24
		{
			resources: new Resources
				wood: 13181
				clay: 17364
				iron: 9858
			workers: 54
			points: 66
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 969
		}

		# level 25
		{
			resources: new Resources
				wood: 16503
				clay: 22139
				iron: 12224
			workers: 63
			points: 80
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 1127
		}

		# level 26
		{
			resources: new Resources
				wood: 20662
				clay: 28227
				iron: 12158
			workers: 74
			points: 95
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 1311
		}

		# level 27
		{
			resources: new Resources
				wood: 25869
				clay: 35990
				iron: 18796
			workers: 86
			points: 115
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 1525
		}

		# level 28
		{
			resources: new Resources
				wood: 32388
				clay: 45887
				iron: 23307
			workers: 100
			points: 137
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 1774
		}

		# level 29
		{
			resources: new Resources
				wood: 40549
				clay: 58506
				iron: 28900
			workers: 118
			points: 165
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 2063
		}

		# level 30
		{
			resources: new Resources
				wood: 50768
				clay: 74595
				iron: 35837
			workers: 138
			points: 198
			duration: new Duration '1s' #todo
			production: new Production new Resources
				iron: 2400
		}
	]
