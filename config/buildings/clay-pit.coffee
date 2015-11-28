Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'





module.exports =



	title: 'clay pit'
	abbreviation: 'clp'
	initialLevel: 1
	minimalLevel: 0
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 65
				clay: 50
				iron: 40
			workers: 10
			points: 6
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 30
		}

		# level 2
		{
			resources: new Resources
				wood: 83
				clay: 63
				iron: 50
			workers: 1
			points: 1
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 35
		}

		# level 3
		{
			resources: new Resources
				wood: 105
				clay: 80
				iron: 62
			workers: 2
			points: 2
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 41
		}

		# level 4
		{
			resources: new Resources
				wood: 133
				clay: 101
				iron: 76
			workers: 2
			points: 1
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 47
		}

		# level 5
		{
			resources: new Resources
				wood: 169
				clay: 128
				iron: 95
			workers: 2
			points: 2
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 55
		}

		# level 6
		{
			resources: new Resources
				wood: 215
				clay: 162
				iron: 117
			workers: 2
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 64
		}

		# level 7
		{
			resources: new Resources
				wood: 273
				clay: 205
				iron: 145
			workers: 3
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 74
		}

		# level 8
		{
			resources: new Resources
				wood: 346
				clay: 259
				iron: 180
			workers: 3
			points: 3
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 86
		}

		# level 9
		{
			resources: new Resources
				wood: 440
				clay: 328
				iron: 224
			workers: 4
			points: 5
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 100
		}

		# level 10
		{
			resources: new Resources
				wood: 559
				clay: 415
				iron: 277
			workers: 4
			points: 5
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 117
		}

		# level 11
		{
			resources: new Resources
				wood: 709
				clay: 525
				iron: 344
			workers: 4
			points: 6
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 136
		}

		# level 12
		{
			resources: new Resources
				wood: 901
				clay: 664
				iron: 426
			workers: 5
			points: 8
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 158
		}

		# level 13
		{
			resources: new Resources
				wood: 1144
				clay: 840
				iron: 529
			workers: 6
			points: 8
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 184
		}

		# level 14
		{
			resources: new Resources
				wood: 1453
				clay: 1062
				iron: 655
			workers: 7
			points: 11
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 214
		}

		# level 15
		{
			resources: new Resources
				wood: 1846
				clay: 1343
				iron: 813
			workers: 8
			points: 13
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 249
		}

		# level 16
		{
			resources: new Resources
				wood: 2344
				clay: 1700
				iron: 1008
			workers: 8
			points: 15
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 289
		}

		# level 17
		{
			resources: new Resources
				wood: 2977
				clay: 2150
				iron: 1250
			workers: 10
			points: 19
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 337
		}

		# level 18
		{
			resources: new Resources
				wood: 3781
				clay: 2750
				iron: 1550
			workers: 12
			points: 22
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 391
		}

		# level 19
		{
			resources: new Resources
				wood: 4802
				clay: 3440
				iron: 1922
			workers: 13
			points: 27
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 455
		}

		# level 20
		{
			resources: new Resources
				wood: 6098
				clay: 4352
				iron: 2383
			workers: 15
			points: 32
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 530
		}

		# level 21
		{
			resources: new Resources
				wood: 7744
				clay: 5505
				iron: 2955
			workers: 16
			points: 38
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 616
		}

		# level 22
		{
			resources: new Resources
				wood: 9835
				clay: 6964
				iron: 3664
			workers: 20
			points: 46
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 717
		}

		# level 23
		{
			resources: new Resources
				wood: 12491
				clay: 8810
				iron: 4543
			workers: 22
			points: 55
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 822
		}

		# level 24
		{
			resources: new Resources
				wood: 15863
				clay: 11144
				iron: 5633
			workers: 25
			points: 66
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 969
		}

		# level 25
		{
			resources: new Resources
				wood: 20147
				clay: 14098
				iron: 6985
			workers: 28
			points: 80
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 1127
		}

		# level 26
		{
			resources: new Resources
				wood: 25586
				clay: 17833
				iron: 8662
			workers: 33
			points: 95
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 1311
		}

		# level 27
		{
			resources: new Resources
				wood: 32495
				clay: 22559
				iron: 10740
			workers: 37
			points: 115
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 1525
		}

		# level 28
		{
			resources: new Resources
				wood: 41268
				clay: 28537
				iron: 13318
			workers: 41
			points: 137
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 1774
		}

		# level 29
		{
			resources: new Resources
				wood: 52410
				clay: 36100
				iron: 16515
			workers: 48
			points: 165
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 2063
		}

		# level 30
		{
			resources: new Resources
				wood: 66561
				clay: 45666
				iron: 20478
			workers: 55
			points: 198
			duration: new Duration '1s' #todo
			production: new Production new Resources
				clay: 2400
		}
	]
