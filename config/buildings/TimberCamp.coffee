Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'





module.exports =



	title: 'timber camp'
	abbreviation: 'tbc'
	initialLevel: 1
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 50
				clay: 60
				iron: 40
			workers: 5
			points: 6
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 30
		}

		# level 2
		{
			resources: new Resources
				wood: 63
				clay: 77
				iron: 50
			workers: 1
			points: 1
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 35
		}

		# level 3
		{
			resources: new Resources
				wood: 78
				clay: 98
				iron: 62
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 41
		}

		# level 4
		{
			resources: new Resources
				wood: 98
				clay: 124
				iron: 77
			workers: 1
			points: 1
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 47
		}

		# level 5
		{
			resources: new Resources
				wood: 122
				clay: 159
				iron: 96
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 55
		}

		# level 6
		{
			resources: new Resources
				wood: 153
				clay: 202
				iron: 120
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 64
		}

		# level 7
		{
			resources: new Resources
				wood: 191
				clay: 158
				iron: 149
			workers: 2
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 74
		}

		# level 8
		{
			resources: new Resources
				wood: 238
				clay: 329
				iron: 185
			workers: 2
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 86
		}

		# level 9
		{
			resources: new Resources
				wood: 298
				clay: 419
				iron: 231
			workers: 2
			points: 5
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 100
		}

		# level 10
		{
			resources: new Resources
				wood: 373
				clay: 534
				iron: 27287
			workers: 2
			points: 5
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 117
		}

		# level 11
		{
			resources: new Resources
				wood: 466
				clay: 681
				iron: 358
			workers: 3
			points: 6
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 136
		}

		# level 12
		{
			resources: new Resources
				wood: 582
				clay: 868
				iron: 446
			workers: 3
			points: 8
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 158
		}

		# level 13
		{
			resources: new Resources
				wood: 728
				clay: 1107
				iron: 555
			workers: 4
			points: 8
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 184
		}

		# level 14
		{
			resources: new Resources
				wood: 909
				clay: 1412
				iron: 691
			workers: 5
			points: 11
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 214
		}

		# level 15
		{
			resources: new Resources
				wood: 1137
				clay: 1800
				iron: 860
			workers: 5
			points: 13
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 249
		}

		# level 16
		{
			resources: new Resources
				wood: 1421
				clay: 2295
				iron: 1071
			workers: 5
			points: 15
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 289
		}

		# level 17
		{
			resources: new Resources
				wood: 1776
				clay: 2926
				iron: 1333
			workers: 7
			points: 19
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 337
		}

		# level 18
		{
			resources: new Resources
				wood: 2220
				clay: 3731
				iron: 1659
			workers: 8
			points: 22
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 391
		}

		# level 19
		{
			resources: new Resources
				wood: 2776
				clay: 4757
				iron: 2066
			workers: 9
			points: 27
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 455
		}

		# level 20
		{
			resources: new Resources
				wood: 3469
				clay: 6065
				iron: 2572
			workers: 15
			points: 32
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 530
		}

		# level 21
		{
			resources: new Resources
				wood: 4337
				clay: 7733
				iron: 3202
			workers: 12
			points: 38
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 616
		}

		# level 22
		{
			resources: new Resources
				wood: 5421
				clay: 9860
				iron: 3987
			workers: 14
			points: 46
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 717
		}

		# level 23
		{
			resources: new Resources
				wood: 6776
				clay: 12571
				iron: 4963
			workers: 16
			points: 55
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 833
		}

		# level 24
		{
			resources: new Resources
				wood: 8470
				clay: 16028
				iron: 6180
			workers: 19
			points: 66
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 969
		}

		# level 25
		{
			resources: new Resources
				wood: 10588
				clay: 20436
				iron: 7694
			workers: 21
			points: 80
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 1127
		}

		# level 26
		{
			resources: new Resources
				wood: 13235
				clay: 26056
				iron: 9578
			workers: 24
			points: 95
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 1311
		}

		# level 27
		{
			resources: new Resources
				wood: 16544
				clay: 33221
				iron: 11925
			workers: 29
			points: 115
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 1525
		}

		# level 28
		{
			resources: new Resources
				wood: 20680
				clay: 42357
				iron: 14847
			workers: 33
			points: 137
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 1774
		}

		# level 29
		{
			resources: new Resources
				wood: 25849
				clay: 54005
				iron: 18484
			workers: 38
			points: 165
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 2063
		}

		# level 30
		{
			resources: new Resources
				wood: 32312
				clay: 68857
				iron: 23013
			workers: 43
			points: 198
			duration: new Duration '1s' #todo
			production: new Production new Resources
				wood: 2400
		}
	]
