{EventEmitter} =	require 'events'

helpers =			require '../util/helpers'
GameError =			require '../util/GameError'
Vector =			require '../util/Vector'





class World extends EventEmitter



	# players
	# villages

	# map

	isGame: true



	constructor: (options) ->
		options = options or {}

		mapSize = options.mapSize or config.mapSize or 100
		@map = []
		for x in [0 ... mapSize]
			@map[x] = []
			for y in [0 ... mapSize]
				@map[x][y] = null

		@players = []
		@villages = []
		for player in options.players or []
			@add player



	village: (x, y) ->
		return @map[x][y] if y?
		return @map[x.x][x.y] if x.isVector
		return @villages[x]    # id



	add: (player) ->
		return if not player

		if @players[player.id]
			throw new GameError "#{player} does already take part in this game."

		@players.add player
		@players[player.id] = player

		for village in player.villages
			@addVillage village
		_this = this
		player.on 'add', (village) ->
			_this.addVillage village
		# todo: List class; use List.watch

		@emit 'players.add', player


	remove: (player) ->
		return if not player

		player = if player.isPlayer then player else @players[player.id]
		if not player
			throw new GameError "#{player} doesn't take part in this game."

		@players.remove player
		@players[player.id] = null

		for village in player.villages
			@removeVillage village
		_this
		@player.on 'remove', (village) ->
			_this.removeVillage village
		# todo: List class; use List.watch

		@emit 'players.remove', player



	addVillage: (village) ->
		return if @village village.id

		existing = @village village.position
		if existing and existing isnt village
			throw new GameError "Location for #{village} is already occupied by #{existing}."

		@villages.add village
		@villages[village.id] = village
		@map[village.position.x][village.position.y] = village

		@emit 'villages.add', village


	removeVillage: (village) ->
		return if not @village village.id

		@villages.remove village
		@villages[village.id] = null
		@map[village.x][village.y] = null

		@emit 'villages.remove', village



	# todo: this system sucks: it might happen that when a village already received an id but isn't yet added to @villages, we give another village that same id. then, upon adding the two villages, one of them doesn't get added. The same goes for playerId.
	villageId: () ->
		id = helpers.uid 9
		while !!@villages[id]
			id = helpers.uid 9
		return id

	# todo: see todo for @villageId
	playerId: () ->
		id = helpers.uid 6
		while !!@players[id]
			id = helpers.uid 6
		return id


	villagePosition: () ->
		x = helpers.random 0, @map.length - 1, true
		y = helpers.random 0, @map[x].length - 1, true
		while @village x, y
			x = helpers.random 0, @map.length - 1, true
			y = helpers.random 0, @map[x].length - 1, true
		return new Vector x, y





module.exports = World
