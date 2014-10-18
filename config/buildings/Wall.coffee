Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'





module.exports =



	title: 'wall'
	abbreviation: 'wll'
	initialLevel: 0
	minimalLevel: 0
	basicDefenseGain: 50
	levels: [

		# level 1
		{
			resources: new Resources
				wood: 50
				clay: 100
				iron: 20
			workers: 5
			points: 8
			duration: new Duration '1s' #todo
			basicDefense: 70
			defenseFactor: 1.04
		}

		# level 2
		{
			resources: new Resources
				wood: 63
				clay: 128
				iron: 25
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			basicDefense: 120
			defenseFactor: 1.08
		}

		# level 3
		{
			resources: new Resources
				wood: 79
				clay: 163
				iron: 32
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.12
		}

		# level 4
		{
			resources: new Resources
				wood: 100
				clay: 207
				iron: 40
			workers: 1
			points: 2
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.16
		}

		# level 5
		{
			resources: new Resources
				wood: 126
				clay: 264
				iron: 50
			workers: 1
			points: 3
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.20
		}

		# level 6
		{
			resources: new Resources
				wood: 159
				clay: 337
				iron: 64
			workers: 2
			points: 3
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.24
		}

		# level 7
		{
			resources: new Resources
				wood: 200
				clay: 430
				iron: 80
			workers: 2
			points: 4
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.29
		}

		# level 8
		{
			resources: new Resources
				wood: 252
				clay: 548
				iron: 101
			workers: 2
			points: 5
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.34
		}

		# level 9
		{
			resources: new Resources
				wood: 318
				clay: 698
				iron: 127
			workers: 3
			points: 5
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.39
		}

		# level 10
		{
			resources: new Resources
				wood: 400
				clay: 890
				iron: 160
			workers: 3
			points: 7
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.44
		}

		# level 11
		{
			resources: new Resources
				wood: 504
				clay: 1135
				iron: 202
			workers: 3
			points: 9
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.49
		}

		# level 12
		{
			resources: new Resources
				wood: 635
				clay: 1447
				iron: 254
			workers: 4
			points: 9
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.55
		}

		# level 13
		{
			resources: new Resources
				wood: 801
				clay: 1846
				iron: 320
			workers: 5
			points: 12
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.60
		}

		# level 14
		{
			resources: new Resources
				wood: 1009
				clay: 2353
				iron: 404
			workers: 5
			points: 15
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.66
		}

		# level 15
		{
			resources: new Resources
				wood: 1271
				clay: 3000
				iron: 508
			workers: 7
			points: 17
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.72
		}

		# level 16
		{
			resources: new Resources
				wood: 1602
				clay: 3825
				iron: 641
			workers: 8
			points: 20
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.79
		}

		# level 17
		{
			resources: new Resources
				wood: 2018
				clay: 4877
				iron: 807
			workers: 9
			points: 25
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.85
		}

		# level 18
		{
			resources: new Resources
				wood: 2543
				clay: 6218
				iron: 1017
			workers: 10
			points: 29
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.92
		}

		# level 19
		{
			resources: new Resources
				wood: 3204
				clay: 7928
				iron: 1281
			workers: 12
			points: 36
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 1.99
		}

		# level 20
		{
			resources: new Resources
				wood: 4037
				clay: 10109
				iron: 1615
			workers: 15
			points: 43
			duration: new Duration '1s' #todo
			basicDefense: 70 #todo
			defenseFactor: 2.07
		}

	]
