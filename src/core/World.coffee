{EventEmitter} =	require 'events'
shortid =			require 'shortid'
random =			require 'lodash/number/random'

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
		@map = ((null for [0 ... mapSize]) for [0 ... mapSize])

		@players = []
		@villages = []
		for player in options.players or []
			@add player



	village: (x, y) ->
		return @map[x][y] if y?
		return @map[x.x][x.y] if x.isVector
		return @villages[x]    # id



	add: (player) ->
		return unless player

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
		return unless player

		player = if player.isPlayer then player else @players[player.id]
		unless player
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
		return unless @village village.id

		@villages.remove village
		@villages[village.id] = null
		@map[village.x][village.y] = null

		@emit 'villages.remove', village



	# todo: this system sucks: it might happen that when a village already received an id but isn't yet added to @villages, we give another village that same id. then, upon adding the two villages, one of them doesn't get added. The same goes for playerId.
	villageId: () ->
		id = shortid.generate()
		while !!@villages[id]
			id = shortid.generate()
		return id

	# todo: see todo for @villageId
	playerId: () ->
		id = shortid.generate()
		while !!@players[id]
			id = shortid.generate()
		return id


	villagePosition: () ->
		xMax = @map.length - 1
		yMax = @map[0].length - 1
		[x, y] = [ random(0, xMax), random 0, yMax ]
		while @village result
			[x, y] = [ random(0, xMax), random 0, yMax ]
		return new Vector x, y





module.exports = World
